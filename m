Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWDIPaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWDIPaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDIP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:29:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35498 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750778AbWDIP3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:29:46 -0400
Date: Sun, 9 Apr 2006 17:29:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 14/19] kconfig: Add search option for xconfig
Message-ID: <Pine.LNX.4.64.0604091729390.23160@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implement a simple search request for xconfig. Currently the
capabilities are rather simple (the same as menuconfig).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/qconf.cc |  444 ++++++++++++++++++++++++++++++-----------------
 scripts/kconfig/qconf.h  |   61 +++++-
 2 files changed, 333 insertions(+), 172 deletions(-)

Index: linux-2.6-git/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.cc
+++ linux-2.6-git/scripts/kconfig/qconf.cc
@@ -6,16 +6,20 @@
 #include <qapplication.h>
 #include <qmainwindow.h>
 #include <qtoolbar.h>
+#include <qlayout.h>
 #include <qvbox.h>
 #include <qsplitter.h>
 #include <qlistview.h>
-#include <qtextview.h>
+#include <qtextbrowser.h>
 #include <qlineedit.h>
+#include <qlabel.h>
+#include <qpushbutton.h>
 #include <qmenubar.h>
 #include <qmessagebox.h>
 #include <qaction.h>
 #include <qheader.h>
 #include <qfiledialog.h>
+#include <qdragobject.h>
 #include <qregexp.h>
 
 #include <stdlib.h>
@@ -35,12 +39,12 @@ static QApplication *configApp;
 
 static inline QString qgettext(const char* str)
 {
-  return QString::fromLocal8Bit(gettext(str));
+	return QString::fromLocal8Bit(gettext(str));
 }
 
 static inline QString qgettext(const QString& str)
 {
-  return QString::fromLocal8Bit(gettext(str.latin1()));
+	return QString::fromLocal8Bit(gettext(str.latin1()));
 }
 
 ConfigSettings::ConfigSettings()
@@ -355,6 +359,12 @@ ConfigItem::~ConfigItem(void)
 	}
 }
 
+ConfigLineEdit::ConfigLineEdit(ConfigView* parent)
+	: Parent(parent)
+{
+	connect(this, SIGNAL(lostFocus()), SLOT(hide()));
+}
+
 void ConfigLineEdit::show(ConfigItem* i)
 {
 	item = i;
@@ -385,8 +395,8 @@ void ConfigLineEdit::keyPressEvent(QKeyE
 	hide();
 }
 
-ConfigList::ConfigList(ConfigView* p, ConfigMainWindow* cv, ConfigSettings* configSettings)
-	: Parent(p), cview(cv),
+ConfigList::ConfigList(ConfigView* p, ConfigSettings* configSettings)
+	: Parent(p),
 	  updateAll(false),
 	  symbolYesPix(xpm_symbol_yes), symbolModPix(xpm_symbol_mod), symbolNoPix(xpm_symbol_no),
 	  choiceYesPix(xpm_choice_yes), choiceNoPix(xpm_choice_no),
@@ -450,9 +460,8 @@ void ConfigList::updateSelection(void)
 	if (!item)
 		return;
 
-	cview->setHelp(item);
-
 	menu = item->menu;
+	emit menuChanged(menu);
 	if (!menu)
 		return;
 	type = menu->prompt ? menu->prompt->type : P_UNKNOWN;
@@ -464,8 +473,20 @@ void ConfigList::updateList(ConfigItem* 
 {
 	ConfigItem* last = 0;
 
-	if (!rootEntry)
-		goto update;
+	if (!rootEntry) {
+		if (mode != listMode)
+			goto update;
+		QListViewItemIterator it(this);
+		ConfigItem* item;
+
+		for (; it.current(); ++it) {
+			item = (ConfigItem*)it.current();
+			if (!item->menu)
+				continue;
+			item->testUpdateMenu(menu_is_visible(item->menu));
+		}
+		return;
+	}
 
 	if (rootEntry != &rootmenu && (mode == singleMode ||
 	    (mode == symbolMode && rootEntry->parent != &rootmenu))) {
@@ -610,7 +631,7 @@ void ConfigList::keyPressEvent(QKeyEvent
 	struct menu *menu;
 	enum prop_type type;
 
-	if (ev->key() == Key_Escape && mode != fullMode) {
+	if (ev->key() == Key_Escape && mode != fullMode && mode != listMode) {
 		emit parentSelected();
 		ev->accept();
 		return;
@@ -767,11 +788,10 @@ void ConfigList::focusInEvent(QFocusEven
 
 ConfigView* ConfigView::viewList;
 
-ConfigView::ConfigView(QWidget* parent, ConfigMainWindow* cview,
-		       ConfigSettings *configSettings)
+ConfigView::ConfigView(QWidget* parent, ConfigSettings *configSettings)
 	: Parent(parent)
 {
-	list = new ConfigList(this, cview, configSettings);
+	list = new ConfigList(this, configSettings);
 	lineEdit = new ConfigLineEdit(this);
 	lineEdit->hide();
 
@@ -807,13 +827,238 @@ void ConfigView::updateListAll(void)
 		v->list->updateListAll();
 }
 
+ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
+	: Parent(parent, name), menu(0)
+{
+}
+
+void ConfigInfoView::setShowDebug(bool b)
+{
+	if (_showDebug != b) {
+		_showDebug = b;
+		if (menu)
+			menuInfo();
+		emit showDebugChanged(b);
+	}
+}
+
+void ConfigInfoView::setInfo(struct menu *m)
+{
+	menu = m;
+	if (!menu)
+		clear();
+	else
+		menuInfo();
+}
+
+void ConfigInfoView::setSource(const QString& name)
+{
+	const char *p = name.latin1();
+
+	menu = NULL;
+
+	switch (p[0]) {
+	case 'm':
+		if (sscanf(p, "m%p", &menu) == 1)
+			menuInfo();
+		break;
+	}
+}
+
+void ConfigInfoView::menuInfo(void)
+{
+	struct symbol* sym;
+	QString head, debug, help;
+
+	sym = menu->sym;
+	if (sym) {
+		if (menu->prompt) {
+			head += "<big><b>";
+			head += print_filter(_(menu->prompt->text));
+			head += "</b></big>";
+			if (sym->name) {
+				head += " (";
+				head += print_filter(sym->name);
+				head += ")";
+			}
+		} else if (sym->name) {
+			head += "<big><b>";
+			head += print_filter(sym->name);
+			head += "</b></big>";
+		}
+		head += "<br><br>";
+
+		if (showDebug())
+			debug = debug_info(sym);
+
+		help = print_filter(_(sym->help));
+	} else if (menu->prompt) {
+		head += "<big><b>";
+		head += print_filter(_(menu->prompt->text));
+		head += "</b></big><br><br>";
+		if (showDebug()) {
+			if (menu->prompt->visible.expr) {
+				debug += "&nbsp;&nbsp;dep: ";
+				expr_print(menu->prompt->visible.expr, expr_print_help, &debug, E_NONE);
+				debug += "<br><br>";
+			}
+		}
+	}
+	if (showDebug())
+		debug += QString().sprintf("defined at %s:%d<br><br>", menu->file->name, menu->lineno);
+
+	setText(head + debug + help);
+}
+
+QString ConfigInfoView::debug_info(struct symbol *sym)
+{
+	QString debug;
+
+	debug += "type: ";
+	debug += print_filter(sym_type_name(sym->type));
+	if (sym_is_choice(sym))
+		debug += " (choice)";
+	debug += "<br>";
+	if (sym->rev_dep.expr) {
+		debug += "reverse dep: ";
+		expr_print(sym->rev_dep.expr, expr_print_help, &debug, E_NONE);
+		debug += "<br>";
+	}
+	for (struct property *prop = sym->prop; prop; prop = prop->next) {
+		switch (prop->type) {
+		case P_PROMPT:
+		case P_MENU:
+			debug += "prompt: ";
+			debug += print_filter(_(prop->text));
+			debug += "<br>";
+			break;
+		case P_DEFAULT:
+			debug += "default: ";
+			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
+			debug += "<br>";
+			break;
+		case P_CHOICE:
+			if (sym_is_choice(sym)) {
+				debug += "choice: ";
+				expr_print(prop->expr, expr_print_help, &debug, E_NONE);
+				debug += "<br>";
+			}
+			break;
+		case P_SELECT:
+			debug += "select: ";
+			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
+			debug += "<br>";
+			break;
+		case P_RANGE:
+			debug += "range: ";
+			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
+			debug += "<br>";
+			break;
+		default:
+			debug += "unknown property: ";
+			debug += prop_get_type_name(prop->type);
+			debug += "<br>";
+		}
+		if (prop->visible.expr) {
+			debug += "&nbsp;&nbsp;&nbsp;&nbsp;dep: ";
+			expr_print(prop->visible.expr, expr_print_help, &debug, E_NONE);
+			debug += "<br>";
+		}
+	}
+	debug += "<br>";
+
+	return debug;
+}
+
+QString ConfigInfoView::print_filter(const QString &str)
+{
+	QRegExp re("[<>&\"\\n]");
+	QString res = str;
+	for (int i = 0; (i = res.find(re, i)) >= 0;) {
+		switch (res[i].latin1()) {
+		case '<':
+			res.replace(i, 1, "&lt;");
+			i += 4;
+			break;
+		case '>':
+			res.replace(i, 1, "&gt;");
+			i += 4;
+			break;
+		case '&':
+			res.replace(i, 1, "&amp;");
+			i += 5;
+			break;
+		case '"':
+			res.replace(i, 1, "&quot;");
+			i += 6;
+			break;
+		case '\n':
+			res.replace(i, 1, "<br>");
+			i += 4;
+			break;
+		}
+	}
+	return res;
+}
+
+void ConfigInfoView::expr_print_help(void *data, const char *str)
+{
+	reinterpret_cast<QString*>(data)->append(print_filter(str));
+}
+
+ConfigSearchWindow::ConfigSearchWindow(QWidget* parent)
+	: Parent(parent), result(NULL)
+{
+	setCaption("Search Config");
+
+	QVBoxLayout* layout1 = new QVBoxLayout(this, 11, 6);
+	QHBoxLayout* layout2 = new QHBoxLayout(0, 0, 6);
+	layout2->addWidget(new QLabel("Find:", this));
+	editField = new QLineEdit(this);
+	connect(editField, SIGNAL(returnPressed()), SLOT(search()));
+	layout2->addWidget(editField);
+	searchButton = new QPushButton("Search", this);
+	searchButton->setAutoDefault(FALSE);
+	connect(searchButton, SIGNAL(clicked()), SLOT(search()));
+	layout2->addWidget(searchButton);
+	layout1->addLayout(layout2);
+
+	QSplitter* split = new QSplitter(this);
+	split->setOrientation(QSplitter::Vertical);
+	list = new ConfigView(split, NULL);
+	list->list->mode = listMode;
+	info = new ConfigInfoView(split);
+	connect(list->list, SIGNAL(menuChanged(struct menu *)),
+		info, SLOT(setInfo(struct menu *)));
+	layout1->addWidget(split);
+}
+
+void ConfigSearchWindow::search(void)
+{
+	struct symbol **p;
+	struct property *prop;
+	ConfigItem *lastItem = NULL;
+
+	free(result);
+	list->list->clear();
+
+	result = sym_re_search(editField->text().latin1());
+	if (!result)
+		return;
+	for (p = result; *p; p++) {
+		for_all_prompts((*p), prop)
+			lastItem = new ConfigItem(list->list, lastItem, prop->menu,
+						  menu_is_visible(prop->menu));
+	}
+}
+
 /*
  * Construct the complete config widget
  */
 ConfigMainWindow::ConfigMainWindow(void)
 {
 	QMenuBar* menu;
-	bool ok;
+	bool ok, showDebug;
 	int x, y, width, height;
 
 	QWidget *d = configApp->desktop();
@@ -843,18 +1088,19 @@ ConfigMainWindow::ConfigMainWindow(void)
 	split1->setOrientation(QSplitter::Horizontal);
 	setCentralWidget(split1);
 
-	menuView = new ConfigView(split1, this, configSettings);
+	menuView = new ConfigView(split1, configSettings);
 	menuList = menuView->list;
 
 	split2 = new QSplitter(split1);
 	split2->setOrientation(QSplitter::Vertical);
 
 	// create config tree
-	configView = new ConfigView(split2, this, configSettings);
+	configView = new ConfigView(split2, configSettings);
 	configList = configView->list;
 
-	helpText = new QTextView(split2);
+	helpText = new ConfigInfoView(split2);
 	helpText->setTextFormat(Qt::RichText);
+	helpText->setShowDebug(showDebug);
 
 	setTabOrder(configList, helpText);
 	configList->setFocus();
@@ -873,6 +1119,8 @@ ConfigMainWindow::ConfigMainWindow(void)
 	  connect(saveAction, SIGNAL(activated()), SLOT(saveConfig()));
 	QAction *saveAsAction = new QAction("Save As...", "Save &As...", 0, this);
 	  connect(saveAsAction, SIGNAL(activated()), SLOT(saveConfigAs()));
+	QAction *searchAction = new QAction("Search", "&Search", CTRL+Key_F, this);
+	  connect(searchAction, SIGNAL(activated()), SLOT(searchConfig()));
 	QAction *singleViewAction = new QAction("Single View", QPixmap(xpm_single_view), "Split View", 0, this);
 	  connect(singleViewAction, SIGNAL(activated()), SLOT(showSingleView()));
 	QAction *splitViewAction = new QAction("Split View", QPixmap(xpm_split_view), "Split View", 0, this);
@@ -899,7 +1147,8 @@ ConfigMainWindow::ConfigMainWindow(void)
 	QAction *showDebugAction = new QAction(NULL, "Show Debug Info", 0, this);
 	  showDebugAction->setToggleAction(TRUE);
 	  showDebugAction->setOn(showDebug);
-	  connect(showDebugAction, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
+	  connect(showDebugAction, SIGNAL(toggled(bool)), helpText, SLOT(setShowDebug(bool)));
+	  connect(helpText, SIGNAL(showDebugChanged(bool)), showDebugAction, SLOT(setOn(bool)));
 
 	QAction *showIntroAction = new QAction(NULL, "Introduction", 0, this);
 	  connect(showIntroAction, SIGNAL(activated()), SLOT(showIntro()));
@@ -923,6 +1172,8 @@ ConfigMainWindow::ConfigMainWindow(void)
 	saveAction->addTo(config);
 	saveAsAction->addTo(config);
 	config->insertSeparator();
+	searchAction->addTo(config);
+	config->insertSeparator();
 	quitAction->addTo(config);
 
 	// create options menu
@@ -942,10 +1193,14 @@ ConfigMainWindow::ConfigMainWindow(void)
 	showIntroAction->addTo(helpMenu);
 	showAboutAction->addTo(helpMenu);
 
+	connect(configList, SIGNAL(menuChanged(struct menu *)),
+		helpText, SLOT(setInfo(struct menu *)));
 	connect(configList, SIGNAL(menuSelected(struct menu *)),
 		SLOT(changeMenu(struct menu *)));
 	connect(configList, SIGNAL(parentSelected()),
 		SLOT(goBack()));
+	connect(menuList, SIGNAL(menuChanged(struct menu *)),
+		helpText, SLOT(setInfo(struct menu *)));
 	connect(menuList, SIGNAL(menuSelected(struct menu *)),
 		SLOT(changeMenu(struct menu *)));
 
@@ -977,42 +1232,6 @@ ConfigMainWindow::ConfigMainWindow(void)
 	delete configSettings;
 }
 
-static QString print_filter(const QString &str)
-{
-	QRegExp re("[<>&\"\\n]");
-	QString res = str;
-	for (int i = 0; (i = res.find(re, i)) >= 0;) {
-		switch (res[i].latin1()) {
-		case '<':
-			res.replace(i, 1, "&lt;");
-			i += 4;
-			break;
-		case '>':
-			res.replace(i, 1, "&gt;");
-			i += 4;
-			break;
-		case '&':
-			res.replace(i, 1, "&amp;");
-			i += 5;
-			break;
-		case '"':
-			res.replace(i, 1, "&quot;");
-			i += 6;
-			break;
-		case '\n':
-			res.replace(i, 1, "<br>");
-			i += 4;
-			break;
-		}
-	}
-	return res;
-}
-
-static void expr_print_help(void *data, const char *str)
-{
-	reinterpret_cast<QString*>(data)->append(print_filter(str));
-}
-
 /*
  * display a new help entry as soon as a new menu entry is selected
  */
@@ -1021,105 +1240,9 @@ void ConfigMainWindow::setHelp(QListView
 	struct symbol* sym;
 	struct menu* menu = 0;
 
-	configList->parent()->lineEdit->hide();
 	if (item)
 		menu = ((ConfigItem*)item)->menu;
-	if (!menu) {
-		helpText->setText(QString::null);
-		return;
-	}
-
-	QString head, debug, help;
-	menu = ((ConfigItem*)item)->menu;
-	sym = menu->sym;
-	if (sym) {
-		if (menu->prompt) {
-			head += "<big><b>";
-			head += print_filter(_(menu->prompt->text));
-			head += "</b></big>";
-			if (sym->name) {
-				head += " (";
-				head += print_filter(_(sym->name));
-				head += ")";
-			}
-		} else if (sym->name) {
-			head += "<big><b>";
-			head += print_filter(_(sym->name));
-			head += "</b></big>";
-		}
-		head += "<br><br>";
-
-		if (showDebug) {
-			debug += "type: ";
-			debug += print_filter(sym_type_name(sym->type));
-			if (sym_is_choice(sym))
-				debug += " (choice)";
-			debug += "<br>";
-			if (sym->rev_dep.expr) {
-				debug += "reverse dep: ";
-				expr_print(sym->rev_dep.expr, expr_print_help, &debug, E_NONE);
-				debug += "<br>";
-			}
-			for (struct property *prop = sym->prop; prop; prop = prop->next) {
-				switch (prop->type) {
-				case P_PROMPT:
-				case P_MENU:
-					debug += "prompt: ";
-					debug += print_filter(_(prop->text));
-					debug += "<br>";
-					break;
-				case P_DEFAULT:
-					debug += "default: ";
-					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-					debug += "<br>";
-					break;
-				case P_CHOICE:
-					if (sym_is_choice(sym)) {
-						debug += "choice: ";
-						expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-						debug += "<br>";
-					}
-					break;
-				case P_SELECT:
-					debug += "select: ";
-					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-					debug += "<br>";
-					break;
-				case P_RANGE:
-					debug += "range: ";
-					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-					debug += "<br>";
-					break;
-				default:
-					debug += "unknown property: ";
-					debug += prop_get_type_name(prop->type);
-					debug += "<br>";
-				}
-				if (prop->visible.expr) {
-					debug += "&nbsp;&nbsp;&nbsp;&nbsp;dep: ";
-					expr_print(prop->visible.expr, expr_print_help, &debug, E_NONE);
-					debug += "<br>";
-				}
-			}
-			debug += "<br>";
-		}
-
-		help = print_filter(_(sym->help));
-	} else if (menu->prompt) {
-		head += "<big><b>";
-		head += print_filter(_(menu->prompt->text));
-		head += "</b></big><br><br>";
-		if (showDebug) {
-			if (menu->prompt->visible.expr) {
-				debug += "&nbsp;&nbsp;dep: ";
-				expr_print(menu->prompt->visible.expr, expr_print_help, &debug, E_NONE);
-				debug += "<br><br>";
-			}
-		}
-	}
-	if (showDebug)
-		debug += QString().sprintf("defined at %s:%d<br><br>", menu->file->name, menu->lineno);
-	helpText->setText(head + debug + help);
+	helpText->setInfo(menu);
 }
 
 void ConfigMainWindow::loadConfig(void)
@@ -1147,6 +1270,13 @@ void ConfigMainWindow::saveConfigAs(void
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 }
 
+void ConfigMainWindow::searchConfig(void)
+{
+	if (!searchWindow)
+		searchWindow = new ConfigSearchWindow(this);
+	searchWindow->show();
+}
+
 void ConfigMainWindow::changeMenu(struct menu *menu)
 {
 	configList->setRootMenu(menu);
@@ -1233,13 +1363,6 @@ void ConfigMainWindow::setShowAll(bool b
 	menuList->updateListAll();
 }
 
-void ConfigMainWindow::setShowDebug(bool b)
-{
-	if (showDebug == b)
-		return;
-	showDebug = b;
-}
-
 void ConfigMainWindow::setShowName(bool b)
 {
 	if (configList->showName == b)
@@ -1334,7 +1457,7 @@ void ConfigMainWindow::saveSettings(void
 	configSettings->writeEntry("/kconfig/qconf/showRange", configList->showRange);
 	configSettings->writeEntry("/kconfig/qconf/showData", configList->showData);
 	configSettings->writeEntry("/kconfig/qconf/showAll", configList->showAll);
-	configSettings->writeEntry("/kconfig/qconf/showDebug", showDebug);
+	configSettings->writeEntry("/kconfig/qconf/showDebug", helpText->showDebug());
 
 	QString entry;
 	switch(configList->mode) {
@@ -1417,9 +1540,10 @@ int main(int ac, char** av)
 	v = new ConfigMainWindow();
 
 	//zconfdump(stdout);
-	v->show();
+	configApp->setMainWidget(v);
 	configApp->connect(configApp, SIGNAL(lastWindowClosed()), SLOT(quit()));
 	configApp->connect(configApp, SIGNAL(aboutToQuit()), v, SLOT(saveSettings()));
+	v->show();
 	configApp->exec();
 
 	return 0;
Index: linux-2.6-git/scripts/kconfig/qconf.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.h
+++ linux-2.6-git/scripts/kconfig/qconf.h
@@ -36,7 +36,7 @@ class ConfigView : public QVBox {
 	Q_OBJECT
 	typedef class QVBox Parent;
 public:
-	ConfigView(QWidget* parent, ConfigMainWindow* cview, ConfigSettings* configSettings);
+	ConfigView(QWidget* parent, ConfigSettings* configSettings);
 	~ConfigView(void);
 	static void updateList(ConfigItem* item);
 	static void updateListAll(void);
@@ -53,14 +53,14 @@ enum colIdx {
 	promptColIdx, nameColIdx, noColIdx, modColIdx, yesColIdx, dataColIdx, colNr
 };
 enum listMode {
-	singleMode, menuMode, symbolMode, fullMode
+	singleMode, menuMode, symbolMode, fullMode, listMode
 };
 
 class ConfigList : public QListView {
 	Q_OBJECT
 	typedef class QListView Parent;
 public:
-	ConfigList(ConfigView* p, ConfigMainWindow* cview, ConfigSettings *configSettings);
+	ConfigList(ConfigView* p, ConfigSettings *configSettings);
 	void reinit(void);
 	ConfigView* parent(void) const
 	{
@@ -68,8 +68,6 @@ public:
 	}
 
 protected:
-	ConfigMainWindow* cview;
-
 	void keyPressEvent(QKeyEvent *e);
 	void contentsMousePressEvent(QMouseEvent *e);
 	void contentsMouseReleaseEvent(QMouseEvent *e);
@@ -84,6 +82,7 @@ public slots:
 	void changeValue(ConfigItem* item);
 	void updateSelection(void);
 signals:
+	void menuChanged(struct menu *menu);
 	void menuSelected(struct menu *menu);
 	void parentSelected(void);
 	void gotFocus(void);
@@ -208,9 +207,7 @@ class ConfigLineEdit : public QLineEdit 
 	Q_OBJECT
 	typedef class QLineEdit Parent;
 public:
-	ConfigLineEdit(ConfigView* parent)
-	: Parent(parent)
-	{ }
+	ConfigLineEdit(ConfigView* parent);
 	ConfigView* parent(void) const
 	{
 		return (ConfigView*)Parent::parent();
@@ -222,6 +219,47 @@ public:
 	ConfigItem *item;
 };
 
+class ConfigInfoView : public QTextBrowser {
+	Q_OBJECT
+	typedef class QTextBrowser Parent;
+public:
+	ConfigInfoView(QWidget* parent, const char *name = 0);
+	bool showDebug(void) const { return _showDebug; }
+
+public slots:
+	void setInfo(struct menu *menu);
+	void setSource(const QString& name);
+	void setShowDebug(bool);
+
+signals:
+	void showDebugChanged(bool);
+
+protected:
+	void menuInfo(void);
+	QString debug_info(struct symbol *sym);
+	static QString print_filter(const QString &str);
+	static void expr_print_help(void *data, const char *str);
+
+	struct menu *menu;
+	bool _showDebug;
+};
+
+class ConfigSearchWindow : public QDialog {
+	Q_OBJECT
+	typedef class QDialog Parent;
+public:
+	ConfigSearchWindow(QWidget* parent);
+public slots:
+	void search(void);
+protected:
+	QLineEdit* editField;
+	QPushButton* searchButton;
+	ConfigView* list;
+	ConfigInfoView* info;
+
+	struct symbol **result;
+};
+
 class ConfigMainWindow : public QMainWindow {
 	Q_OBJECT
 public:
@@ -234,11 +272,11 @@ public slots:
 	void loadConfig(void);
 	void saveConfig(void);
 	void saveConfigAs(void);
+	void searchConfig(void);
 	void showSingleView(void);
 	void showSplitView(void);
 	void showFullView(void);
 	void setShowAll(bool);
-	void setShowDebug(bool);
 	void setShowRange(bool);
 	void setShowName(bool);
 	void setShowData(bool);
@@ -249,15 +287,14 @@ public slots:
 protected:
 	void closeEvent(QCloseEvent *e);
 
+	ConfigSearchWindow *searchWindow;
 	ConfigView *menuView;
 	ConfigList *menuList;
 	ConfigView *configView;
 	ConfigList *configList;
-	QTextView *helpText;
+	ConfigInfoView *helpText;
 	QToolBar *toolBar;
 	QAction *backAction;
 	QSplitter* split1;
 	QSplitter* split2;
-
-	bool showDebug;
 };
