Return-Path: <linux-kernel-owner+w=401wt.eu-S1751002AbXACR7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXACR7N (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbXACR7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:59:12 -0500
Received: from sa7.bezeqint.net ([192.115.104.21]:35533 "EHLO sa7.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbXACR7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:59:11 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] qconf Search Dialog
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Date: Wed, 3 Jan 2007 19:54:36 +0200
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c3+mF0l5u+3VF8N"
Message-Id: <200701031954.36440.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_c3+mF0l5u+3VF8N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

[ I'm not subscribed to this list so please CC me on your replies. ]

This is a new version of the patch that adds a search dialog to the 
kernel's "make xconfig" configuration applet.

Changes in this release include:

1. Implemented regular expression querying. The GUI includes an option for a 
keywords based query, which is not supported yet.

2. Fixed the fact that the top categories in the QListView do not have a 
visible 
[+] sign next to them to expand them. (Albeit they are expanded upon a double 
click).

3. Now resizing the dialog to a larger default size.

To do is:

1. Make sure double clicking an end-item opens and highlights it in the main 
application.

2. Eliminate the weird black-outlined rectangle that appears in the top-left 
corner of the dialog.

--------

The patch was tested against kernel 2.6.20-rc3.

Enjoy!

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

Chuck Norris wrote a complete Perl 6 implementation in a day but then
destroyed all evidence with his bare hands, so no one will know his secrets.

--Boundary-00=_c3+mF0l5u+3VF8N
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xconfig-search-patch-10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xconfig-search-patch-10.diff"

--- linux-2.6.20-rc3/scripts/kconfig/qconf.cc.orig	2007-01-01 22:06:27.995620083 +0200
+++ linux-2.6.20-rc3/scripts/kconfig/qconf.cc	2007-01-03 19:50:56.569683217 +0200
@@ -21,8 +21,13 @@
 #include <qfiledialog.h>
 #include <qdragobject.h>
 #include <qregexp.h>
+#include <qdialog.h>
+#include <qlayout.h>
+#include <qlabel.h>
+#include <qpushbutton.h>
 
 #include <stdlib.h>
+#include <stdio.h>
 
 #include "lkc.h"
 #include "qconf.h"
@@ -1323,6 +1328,8 @@
 	  connect(splitViewAction, SIGNAL(activated()), SLOT(showSplitView()));
 	QAction *fullViewAction = new QAction("Full View", QPixmap(xpm_tree_view), "Full View", 0, this);
 	  connect(fullViewAction, SIGNAL(activated()), SLOT(showFullView()));
+	QAction *findAction = new QAction("Find", QPixmap(xpm_save), "&Find", CTRL+Key_F, this);
+	  connect(findAction, SIGNAL(activated()), SLOT(findEntries()));
 
 	QAction *showNameAction = new QAction(NULL, "Show Name", 0, this);
 	  showNameAction->setToggleAction(TRUE);
@@ -1376,6 +1383,11 @@
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
@@ -1447,6 +1459,300 @@
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
+	search_type = new QButtonGroup(this, "search_type");
+
+	substring = new QRadioButton("Substring Match", this, "Substring Match");
+	search_type->insert(substring);
+	main_layout->addWidget(substring);
+
+	keywords = new QRadioButton("Keywords", this, "Keywords");
+	search_type->insert(keywords);
+	main_layout->addWidget(keywords);
+
+	regex = new QRadioButton("Regular Expression", this, "Regular Expression");
+	search_type->insert(regex);
+	main_layout->addWidget(regex);
+
+	substring->setChecked(TRUE);
+
+	results = new QListView(this, "results");
+	results->setRootIsDecorated(TRUE);
+	results->addColumn("Item");
+	main_layout->addWidget(results);
+
+	resize(QSize(500,400));
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
+FindQuery::FindQuery(QString q, SEARCH_TYPE t, bool a_case) :
+	query(q), search_type(t), case_sensitive(a_case)
+{
+	compiled_regex = NULL;
+	if (search_type == REGEX)
+	{
+		compiled_regex = new QRegExp(query, case_sensitive);
+	}
+}
+
+FindQuery::~FindQuery()
+{
+	if (compiled_regex)
+	{
+		delete compiled_regex;
+		compiled_regex = NULL;
+	}
+}
+
+bool FindQuery::string_matches(const char * string)
+{
+	QString qs(string);
+
+	if (search_type == SUBSTRING)
+	{
+		return qs.contains(query, case_sensitive);
+	}
+	else if (search_type == REGEX)
+	{
+		return (compiled_regex->search(qs) >= 0);
+	}
+	else
+	{
+		return false;
+	}
+}
+
+bool FindDialog::matches(struct menu * mymenu, FindQuery & query)
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
+	return (query.string_matches(sym->help) ||
+		query.string_matches(sym->name)
+		);
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
+void FindDialog::search(FindQuery & query, MenuList * parents, ListViewMenuList * * last_branch)
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
+SEARCH_TYPE FindDialog::getSearchType()
+{
+	return	substring->isChecked() ? SUBSTRING :
+		regex->isChecked() ? REGEX :
+		KEYWORDS;
+}
+
+void FindDialog::performQuery(void)
+{
+	QString query_string = queryLineEdit->text();
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
+	FindQuery query(query_string, getSearchType());
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
--- linux-2.6.20-rc3/scripts/kconfig/qconf.h.orig	2007-01-01 22:06:27.995620083 +0200
+++ linux-2.6.20-rc3/scripts/kconfig/qconf.h	2007-01-02 20:58:25.676773277 +0200
@@ -4,6 +4,10 @@
  */
 
 #include <qlistview.h>
+#include <qlistbox.h>
+#include <qradiobutton.h>
+#include <qbuttongroup.h>
+#include <qregexp.h>
 #if QT_VERSION >= 300
 #include <qsettings.h>
 #else
@@ -304,6 +308,7 @@
 	ConfigMainWindow(void);
 public slots:
 	void changeMenu(struct menu *);
+	void findEntries(void);
 	void setMenuLink(struct menu *);
 	void listFocusChanged(void);
 	void goBack(void);
@@ -332,3 +337,68 @@
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
+enum SEARCH_TYPE { SUBSTRING, KEYWORDS, REGEX };
+class FindQuery
+{
+	public:
+	bool case_sensitive;
+	SEARCH_TYPE search_type;
+	QString query;
+	QRegExp * compiled_regex;
+
+	public:
+	FindQuery() : query("") { case_sensitive = false; search_type = SUBSTRING; }
+	FindQuery(QString q, SEARCH_TYPE t, bool a_case = false);
+	~FindQuery();
+	bool string_matches(const char *);
+};
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
+	QButtonGroup * search_type;
+	QRadioButton * substring, * keywords, * regex;
+public slots:
+	void performQuery();
+public:
+	bool matches(struct menu * mymenu, FindQuery & query);
+	void search(FindQuery & query, MenuList * parents,
+			ListViewMenuList * * last_branch);
+	void handle_match(MenuList * parents,
+			ListViewMenuList * * last_branch);
+	SEARCH_TYPE getSearchType();
+};
+

--Boundary-00=_c3+mF0l5u+3VF8N--
