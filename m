Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWC0TxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWC0TxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWC0TxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:53:15 -0500
Received: from sa4.bezeqint.net ([192.115.104.18]:59598 "EHLO sa4.bezeqint.net")
	by vger.kernel.org with ESMTP id S1750995AbWC0TxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:53:14 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PoC "make xconfig" Search Facility
Date: Mon, 27 Mar 2006 21:50:41 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SIEKE9wlshziQLd"
Message-Id: <200603272150.42305.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_SIEKE9wlshziQLd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

[ I'm not subscribed to this list so please CC me on your replies. ]

This patch adds a proof-of-concept search facility to "make xconfig". Current 
problems and limitations:

1. Only case-insensitive single-substring search is supported.

2. The style is completely wrong, as I could not find a suitable vim 
configuration for editing Linux kernel source (and Google was not help). If 
anyone can refer me to one, I'll be grateful.

3. At the moment the results are displayed in a listbox as text. One cannot go 
from the result node to the place to toggle it in the configuration. (much 
less from one of it ancessorts)

But it works!

The patch is against kernel 2.6.16-git13.

Comments, suggestions, corrections, and flames are welcome.

Regards,

	Shlomi Fish 

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.

--Boundary-00=_SIEKE9wlshziQLd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xconfig-search-2.6.16-git13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xconfig-search-2.6.16-git13.patch"

--- scripts/kconfig/qconf.cc.orig	2006-03-20 07:53:29.000000000 +0200
+++ scripts/kconfig/qconf.cc	2006-03-27 21:26:38.644408250 +0200
@@ -17,6 +17,10 @@
 #include <qheader.h>
 #include <qfiledialog.h>
 #include <qregexp.h>
+#include <qdialog.h>
+#include <qlayout.h>
+#include <qlabel.h>
+#include <qpushbutton.h>
 
 #include <stdlib.h>
 
@@ -879,6 +883,8 @@
 	  connect(splitViewAction, SIGNAL(activated()), SLOT(showSplitView()));
 	QAction *fullViewAction = new QAction("Full View", QPixmap(xpm_tree_view), "Full View", 0, this);
 	  connect(fullViewAction, SIGNAL(activated()), SLOT(showFullView()));
+	QAction *findAction = new QAction("Find", QPixmap(xpm_save), "&Find", CTRL+Key_F, this);
+	  connect(findAction, SIGNAL(activated()), SLOT(findEntries()));
 
 	QAction *showNameAction = new QAction(NULL, "Show Name", 0, this);
 	  showNameAction->setToggleAction(TRUE);
@@ -925,6 +931,11 @@
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
@@ -1138,6 +1149,106 @@
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 }
 
+
+FindDialog::FindDialog( QWidget* parent, const char* name, bool modal, WFlags fl )
+    : QDialog( parent, name, modal, fl )
+{
+    main_layout = new QVBoxLayout(this, 11, 6, "main_layout");
+    main_layout->addWidget(new QLabel("Query:", this, "label1"));
+    queryLineEdit = new QLineEdit(this, "queryLineEdit");
+    main_layout->addWidget(queryLineEdit);
+    findButton = new QPushButton("Find", this, "findButton");
+    main_layout->addWidget(findButton);
+    connect( findButton, SIGNAL( clicked() ), this, SLOT( performQuery() ) );
+    results = new QListBox(this, "results");
+    main_layout->addWidget(results);
+}
+
+FindDialog::~FindDialog()
+{
+}
+
+static QString * get_parent_disp(struct menu * menu)
+{
+    QString s;
+    if (menu->sym)
+    {
+        if (menu->prompt)
+        {
+            s += menu->prompt->text;
+            if (menu->sym->name)
+            {
+                s += " (";
+                s += menu->sym->name;
+                s += ")";
+            }
+        }
+        else if (menu->sym->name)
+        {
+            s += menu->sym->name;
+        }
+    }
+    else if (menu->prompt)
+    {
+        s += menu->prompt->text;
+    }
+    return new QString(s);
+}
+
+void FindDialog::search(QString & query, struct menu * mymenu, MenuList * parents)
+{
+    struct symbol * sym;
+    struct menu * child;
+    
+    MenuList new_parents(*parents);
+    new_parents.append(mymenu);
+
+    sym = mymenu->sym;
+
+    if (sym)
+    {
+        QString help(sym->help);
+        QString name(sym->name);
+        
+        if (help.contains(query, FALSE) || name.contains(query, FALSE))
+        {
+            MenuList::iterator it;
+            QString item;
+            for (it = parents->begin(); it != parents->end() ; ++it)
+            {
+                QString * parent_disp = get_parent_disp(*it);
+                item += *parent_disp;
+                item += " -> ";
+                delete parent_disp;
+            }
+            QString * disp = get_parent_disp(mymenu);
+            item += *disp;
+            delete disp;
+            results->insertItem(item);
+        }
+    }
+    for (child = mymenu->list; child ; child = child->next)
+    {
+        search(query, child, &new_parents);
+    }
+}
+
+void FindDialog::performQuery(void)
+{
+    QString query = queryLineEdit->text();
+    results->clear();
+    
+    MenuList parents;
+    search(query, &rootmenu, &parents);
+    // printf("Query for \"%s\"\n", (const char *)queryLineEdit->text());
+}
+
+void ConfigMainWindow::findEntries(void)
+{
+    FindDialog * dlg = new FindDialog(this, "dialog", TRUE);
+    dlg->exec();
+}
+
 void ConfigMainWindow::saveConfigAs(void)
 {
 	QString s = QFileDialog::getSaveFileName(".config", NULL, this);
--- scripts/kconfig/qconf.h.orig	2006-03-20 07:53:29.000000000 +0200
+++ scripts/kconfig/qconf.h	2006-03-27 21:26:38.648408500 +0200
@@ -4,6 +4,7 @@
  */
 
 #include <qlistview.h>
+#include <qlistbox.h>
 #if QT_VERSION >= 300
 #include <qsettings.h>
 #else
@@ -229,6 +230,7 @@
 public slots:
 	void setHelp(QListViewItem* item);
 	void changeMenu(struct menu *);
+	void findEntries(void);
 	void listFocusChanged(void);
 	void goBack(void);
 	void loadConfig(void);
@@ -261,3 +263,22 @@
 
 	bool showDebug;
 };
+
+typedef QValueList<struct menu *> MenuList;
+
+class FindDialog : public QDialog
+{
+    Q_OBJECT
+public:
+    FindDialog( QWidget* parent = 0, const char* name = 0, bool modal = FALSE, WFlags fl = 0 );
+    ~FindDialog();
+    QVBoxLayout * main_layout;
+    QLineEdit * queryLineEdit;
+    QPushButton * findButton;
+    QListBox * results;
+public slots:
+    void performQuery();
+public:
+    void search(QString & query, struct menu * mymenu, MenuList * parents);
+};
+

--Boundary-00=_SIEKE9wlshziQLd--
