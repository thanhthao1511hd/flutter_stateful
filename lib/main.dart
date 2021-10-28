import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // trạng thái k thay đổi trong vòng đời của Widge
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final List<WordPair> _word = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _words = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLACKPINK in your aera"),
        actions: <Widget>[
          new IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            // nếu index là số lẻ
            return Divider();
          }
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index]);
        }),
      ),
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget>  divides=ListTile.divideTiles(tiles: tiles).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: const Text("Saved list"),
        ),
        body: new ListView(
          children:divides,
        ),
      );
    }));
    
  }
}
