// Importar o MaterialApp e outros widgets que podem ser utilizados 
import 'package:flutter/material.dart';

// Necessidade da classe principal para executar o programa
void main() => runApp(new TodoApp());

// Classe App
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList ()
    );
  }
}

// Classe para listar os itens
class TodoList extends StatefulWidget {
  @override
  createState() => TodoListAttTela();
}

// Classe para atualizar lista de itens
class TodoListAttTela extends State<TodoList> {
  List<String> _listaItens = [];

  // Essa função vai ser chamada quando apertar o botão de +
  void _addItem(String tarefa) {
      if (tarefa.length > 0){
        setState(() => _listaItens.add(tarefa));
      }
    }

  // Essa função funciona como a de cima, porém para remover a tarefa
  void _removerItem(int item) {
    setState(() => _listaItens.removeAt(item));
  }

  // Exibir caixa de alerta para o usuario confirmar a exclusão do item
  void _alertaRemoverItem(int item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Deseja marcar "${_listaItens[item]}" como concluido?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('Concluido!'),
              onPressed: () {
                _removerItem(item);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }


  Widget _criarListaItens() {
    return new ListView.builder(
      itemBuilder: (context, item) {
        if(item < _listaItens.length) {
          return _criarListaItem(_listaItens[item], item);
        }
      },
    );
  }
  
  Widget _criarListaItem(String todoText, int item) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _alertaRemoverItem(item)
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ESIG ToDo List'),
      ),
      body: _criarListaItens(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushScreen,
        tooltip: 'Adicionar tarefa',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Adicionar nova tarefa'),
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'Insira o que pretende fazer: ',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
          );
        }
      )
    );
  }
}