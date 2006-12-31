Return-Path: <linux-kernel-owner+w=401wt.eu-S933096AbWLaI31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbWLaI31 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 03:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbWLaI31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 03:29:27 -0500
Received: from sa2.bezeqint.net ([192.115.104.16]:45310 "EHLO sa2.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933096AbWLaI3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 03:29:25 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc2] "make xconfig" Search Dialog
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Date: Sun, 31 Dec 2006 10:25:26 +0200
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2P3lF7LSLxfCYV1"
Message-Id: <200612311025.26053.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2P3lF7LSLxfCYV1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

[ I'm not subscribed to this list so please CC me on your replies. ]

This patch is a reworked version of:

http://www.ussg.iu.edu/hypermail/linux/kernel/0603.3/0990.html

It adds a search dialog to the kernel's "make xconfig" configuration applet.

Changes in this release include:

1. Fixed formatting.

2. The items are now displayed in a tree instead of in a flat list. (With all 
the necessary changes).

3. Updated to apply against the recent kernel version.

--------

The To do is:

1. Implemented more sophisticated querying.

2. Fix the fact that the top categories in the QListView do not have a visible 
[+] sign next to them to expand them. (Albeit they are expanded upon a double 
click).

3. Make sure double clicking an end-item opens and highlights it in the main 
application.

--------

The patch was tested against kernel 2.6.20-rc2.

Enjoy and Happy New Year!

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

Chuck Norris wrote a complete Perl 6 implementation in a day but then
destroyed all evidence with his bare hands, so no one will know his secrets.

--Boundary-00=_2P3lF7LSLxfCYV1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xconfig-search-patch-5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xconfig-search-patch-5.diff"

--- linux-2.6.20-rc2/scripts/kconfig/qconf.cc.orig	2006-12-28 01:12:27.384938513 +0200
+++ linux-2.6.20-rc2/scripts/kconfig/qconf.cc	2006-12-30 23:05:15.409325133 +0200
@@ -21,6 +21,10 @@
 #include <qfiledialog.h>
 #include <qdragobject.h>
 #include <qregexp.h>
+#include <qdialog.h>
+#include <qlayout.h>
+#include <qlabel.h>
+#include <qpushbutton.h>
 
 #include <stdlib.h>
 
@@ -1323,6 +1327,8 @@
 	  connect(splitViewAction, SIGNAL(activated()), SLOT(showSplitView()));
 	QAction *fullViewAction = new QAction("Full View", QPixmap(xpm_tree_view), "Full View", 0, this);
 	  connect(fullViewAction, SIGNAL(activated()), SLOT(showFullView()));
+	QAction *findAction = new QAction("Find", QPixmap(xpm_save), "&Find", CTRL+Key_F, this);
+	  connect(findAction, SIGNAL(activated()), SLOT(findEntries()));
 
 	QAction *showNameAction = new QAction(NULL, "Show Name", 0, this);
 	  showNameAction->setToggleAction(TRUE);
@@ -1376,6 +1382,11 @@
 	config->insertSeparator();
 	quitAction->addTo(config);
 
+	// create file menu
+	QPopupMenu* editMenu = new QPopupMenu(this);
+	menu->insertItem("&Edit", editMenu);
+	findAction->addTo(editMenu);
+
 	// create options menu
 	QPopupMenu* optionMenu = new QPopupMenu(this);
 	menu->insertItem("&Option", optionMenu);
@@ -1447,6 +1458,233 @@
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 }
 
+
+FindDialog::FindDialog( QWidget* parent, const char* name, bool modal, WFlags fl )
+	: QDialog( parent, name, modal, fl )
+{
+	main_layout = new QVBoxLayout(this, 11, 6, "main_layout");
+	main_layout->addWidget(new QLabel("Query:", this, "label1"));
+	queryLineEdit = new QLineEdit(this, "queryLineEdit");
+	main_layout->addWidget(queryLineEdit);
+	findButton = new QPushButton("Find", this, "findButton");
+	main_layout->addWidget(findButton);
+	connect( findButton, SIGNAL( clicked() ), this, SLOT( performQuery() ) );
+	results = new QListView(this, "results");
+	results->addColumn("Item");
+	main_layout->addWidget(results);
+}
+
+FindDialog::~FindDialog()
+{
+}
+
+static QString * get_parent_disp(struct menu * menu)
+{
+	QString s;
+	if (menu->sym)
+	{
+		if (menu->prompt)
+		{
+			s += menu->prompt->text;
+			if (menu->sym->name)
+			{
+				s += " (";
+				s += menu->sym->name;
+				s += ")";
+			}
+		}
+		else if (menu->sym->name)
+		{
+			s += menu->sym->name;
+		}
+	}
+	else if (menu->prompt)
+	{
+		s += menu->prompt->text;
+	}
+	return new QString(s);
+}
+
+QString * get_parent_string(struct menu * menu, int depth)
+{
+	QString * parent_disp = get_parent_disp(menu);
+	QString s;
+
+	/*
+	 * Append 'depth' tabs.
+	 * */
+	for(int i=0;i<depth;i++)
+	{
+		s += "\t";
+	}
+	s += *parent_disp;
+	s += "\n";
+
+	delete parent_disp;
+
+	return new QString(s);
+}
+
+static QString * get_item_display(MenuList * parents, struct menu * mymenu)
+{
+	MenuList::iterator it;
+	QString * item;
+#if 0
+	int depth;
+#else
+	int depth=0;
+#endif
+
+	item = new QString();
+
+#if 0
+	for (depth=0, it = parents->begin(); it != parents->end() ; ++it, ++depth)
+	{
+		QString * parent_string = get_parent_string(*it, depth);
+		*item += *parent_string;
+		delete parent_string;
+	}
+#endif
+
+	QString * string = get_parent_string(mymenu, depth);
+	*item += *string;
+	delete string;
+
+	return item;
+}
+
+QListViewItem * ListViewBranch::newItem(QString & s)
+{
+	if (which == ISNULL)
+	{
+		// Shouldn't happen.
+		throw "Hello";
+	}
+	else if (which == ITEM)
+	{
+		return new QListViewItem(item, s);
+	}
+	else
+	{
+		return new QListViewItem(view, s);
+	}
+
+}
+
+ListViewBranch ListViewBranch::insertItem(QString & s)
+{
+	return ListViewBranch(newItem(s));
+}
+
+bool FindDialog::matches(struct menu * mymenu, QString & query)
+{
+	struct symbol * sym = mymenu->sym;
+
+	if (!sym)
+	{
+		return false;
+	}
+
+	QString help(sym->help);
+	QString name(sym->name);
+
+	return (help.contains(query, FALSE) || name.contains(query, FALSE));
+}
+
+void FindDialog::handle_match(MenuList * parents, ListViewMenuList * * last_branch)
+{
+	// TODO : Name to something more meaningful than
+	// it2
+	MenuList::iterator it;
+	ListViewMenuList::iterator it2;
+
+	// Find the last branch that was allocated
+	it = parents->begin();
+	it2 = (*last_branch)->begin();
+
+	for (;(*it2).menu == *it ; ++it, ++it2)
+	{
+	}
+
+	ListViewMenuList * new_branch = new ListViewMenuList;
+	MenuList new_menu;
+
+	ListViewMenuList::iterator copy_branches;
+	MenuList::iterator copy_menu;
+	for (copy_branches = (*last_branch)->begin(),copy_menu = parents->begin();
+		copy_branches != it2;
+		++copy_branches, ++copy_menu)
+	{
+		new_branch->append(*copy_branches);
+		new_menu.append(*copy_menu);
+	}
+
+	for (; it != parents->end(); ++it)
+	{
+		ListViewMenuItem new_item;
+		new_item.menu = *it;
+
+		QString * str = get_item_display(&new_menu, *it);
+		new_item.branch = new_branch->back().branch.insertItem(*str);
+
+		new_branch->append(new_item);
+		new_menu.append(*it);
+		delete str;
+	}
+
+	// Update to the the new branch
+	delete *last_branch;
+	*last_branch = new_branch;
+}
+
+void FindDialog::search(QString & query, MenuList * parents, ListViewMenuList * * last_branch)
+{
+	struct menu * child;
+
+	struct menu * mymenu = parents->back();
+
+	if (matches(mymenu, query))
+	{
+		handle_match(parents, last_branch);
+	}
+
+	for (child = mymenu->list; child ; child = child->next)
+	{
+		MenuList new_parents(*parents);
+		new_parents.append(child);
+		search(query, &new_parents, last_branch);
+	}
+}
+
+void FindDialog::performQuery(void)
+{
+	QString query = queryLineEdit->text();
+	results->clear();
+
+	MenuList parents;
+	ListViewMenuList * mybranch = new ListViewMenuList;
+
+	{
+		ListViewMenuItem i;
+		i.branch = ListViewBranch(results);
+		i.menu = &rootmenu;
+		mybranch->append(i);
+	}
+
+	parents.append(&rootmenu);
+
+	search(query, &parents, &mybranch);
+
+	delete mybranch;
+	// printf("Query for \"%s\"\n", (const char *)queryLineEdit->text());
+}
+
+void ConfigMainWindow::findEntries(void)
+{
+	FindDialog * dlg = new FindDialog(this, "dialog", TRUE);
+	dlg->exec();
+}
+
 void ConfigMainWindow::saveConfigAs(void)
 {
 	QString s = QFileDialog::getSaveFileName(".config", NULL, this);
--- linux-2.6.20-rc2/scripts/kconfig/qconf.h.orig	2006-12-28 01:12:27.384938513 +0200
+++ linux-2.6.20-rc2/scripts/kconfig/qconf.h	2006-12-30 23:05:54.335543414 +0200
@@ -4,6 +4,7 @@
  */
 
 #include <qlistview.h>
+#include <qlistbox.h>
 #if QT_VERSION >= 300
 #include <qsettings.h>
 #else
@@ -304,6 +305,7 @@
 	ConfigMainWindow(void);
 public slots:
 	void changeMenu(struct menu *);
+	void findEntries(void);
 	void setMenuLink(struct menu *);
 	void listFocusChanged(void);
 	void goBack(void);
@@ -332,3 +334,49 @@
 	QSplitter* split1;
 	QSplitter* split2;
 };
+
+typedef QValueList<struct menu *> MenuList;
+
+struct ListViewBranch
+{
+	enum { ISNULL, ITEM, VIEW } which;
+	union
+	{
+		QListViewItem * item;
+		QListView * view;
+	};
+	ListViewBranch() { which = ISNULL; item = NULL; }
+	ListViewBranch(QListView * v) { view = v; which = VIEW; }
+	ListViewBranch(QListViewItem * i) { item = i; which = ITEM; }
+	QListViewItem * newItem(QString & s);
+	ListViewBranch insertItem(QString & s);
+};
+
+struct ListViewMenuItem
+{
+	ListViewBranch branch;
+	struct menu * menu;
+};
+
+typedef QValueList<struct ListViewMenuItem> ListViewMenuList;
+
+class FindDialog : public QDialog
+{
+	Q_OBJECT
+	public:
+	FindDialog( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
+	~FindDialog();
+	QVBoxLayout * main_layout;
+	QLineEdit * queryLineEdit;
+	QPushButton * findButton;
+	QListView * results;
+public slots:
+	void performQuery();
+public:
+	bool matches(struct menu * mymenu, QString & query);
+	void search(QString & query, MenuList * parents,
+			ListViewMenuList * * last_branch);
+	void handle_match(MenuList * parents,
+			ListViewMenuList * * last_branch);
+};
+

--Boundary-00=_2P3lF7LSLxfCYV1--
