Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDIPa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDIPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDIPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:30:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36010 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750778AbWDIP3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:29:53 -0400
Date: Sun, 9 Apr 2006 17:29:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 15/19] kconfig: finer customization via popup menus
Message-ID: <Pine.LNX.4.64.0604091729470.23164@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows to configure every symbol list and info window separately
via a popup menu, these settings are also separately saved and restored.
Cleanup the ConfigSettings class a bit to reduce the number of #ifdef.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/qconf.cc |  486 +++++++++++++++++++++++++++--------------------
 scripts/kconfig/qconf.h  |   95 +++++----
 2 files changed, 343 insertions(+), 238 deletions(-)

Index: linux-2.6-git/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.cc
+++ linux-2.6-git/scripts/kconfig/qconf.cc
@@ -36,6 +36,7 @@
 #endif
 
 static QApplication *configApp;
+static ConfigSettings *configSettings;
 
 static inline QString qgettext(const char* str)
 {
@@ -47,23 +48,6 @@ static inline QString qgettext(const QSt
 	return QString::fromLocal8Bit(gettext(str.latin1()));
 }
 
-ConfigSettings::ConfigSettings()
-	: showAll(false), showName(false), showRange(false), showData(false)
-{
-}
-
-#if QT_VERSION >= 300
-/**
- * Reads the list column settings from the application settings.
- */
-void ConfigSettings::readListSettings()
-{
-	showAll = readBoolEntry("/kconfig/qconf/showAll", false);
-	showName = readBoolEntry("/kconfig/qconf/showName", false);
-	showRange = readBoolEntry("/kconfig/qconf/showRange", false);
-	showData = readBoolEntry("/kconfig/qconf/showData", false);
-}
-
 /**
  * Reads a list of integer values from the application settings.
  */
@@ -92,76 +76,7 @@ bool ConfigSettings::writeSizes(const QS
 		stringList.push_back(QString::number(*it));
 	return writeEntry(key, stringList);
 }
-#endif
-
-
-/*
- * update all the children of a menu entry
- *   removes/adds the entries from the parent widget as necessary
- *
- * parent: either the menu list widget or a menu entry widget
- * menu: entry to be updated
- */
-template <class P>
-void ConfigList::updateMenuList(P* parent, struct menu* menu)
-{
-	struct menu* child;
-	ConfigItem* item;
-	ConfigItem* last;
-	bool visible;
-	enum prop_type type;
-
-	if (!menu) {
-		while ((item = parent->firstChild()))
-			delete item;
-		return;
-	}
-
-	last = parent->firstChild();
-	if (last && !last->goParent)
-		last = 0;
-	for (child = menu->list; child; child = child->next) {
-		item = last ? last->nextSibling() : parent->firstChild();
-		type = child->prompt ? child->prompt->type : P_UNKNOWN;
-
-		switch (mode) {
-		case menuMode:
-			if (!(child->flags & MENU_ROOT))
-				goto hide;
-			break;
-		case symbolMode:
-			if (child->flags & MENU_ROOT)
-				goto hide;
-			break;
-		default:
-			break;
-		}
-
-		visible = menu_is_visible(child);
-		if (showAll || visible) {
-			if (!item || item->menu != child)
-				item = new ConfigItem(parent, last, child, visible);
-			else
-				item->testUpdateMenu(visible);
 
-			if (mode == fullMode || mode == menuMode || type != P_MENU)
-				updateMenuList(item, child);
-			else
-				updateMenuList(item, 0);
-			last = item;
-			continue;
-		}
-	hide:
-		if (item && item->menu == child) {
-			last = parent->firstChild();
-			if (last == item)
-				last = 0;
-			else while (last->nextSibling() != item)
-				last = last->nextSibling();
-			delete item;
-		}
-	}
-}
 
 #if QT_VERSION >= 300
 /*
@@ -395,14 +310,14 @@ void ConfigLineEdit::keyPressEvent(QKeyE
 	hide();
 }
 
-ConfigList::ConfigList(ConfigView* p, ConfigSettings* configSettings)
-	: Parent(p),
+ConfigList::ConfigList(ConfigView* p, const char *name)
+	: Parent(p, name),
 	  updateAll(false),
 	  symbolYesPix(xpm_symbol_yes), symbolModPix(xpm_symbol_mod), symbolNoPix(xpm_symbol_no),
 	  choiceYesPix(xpm_choice_yes), choiceNoPix(xpm_choice_no),
 	  menuPix(xpm_menu), menuInvPix(xpm_menu_inv), menuBackPix(xpm_menuback), voidPix(xpm_void),
 	  showAll(false), showName(false), showRange(false), showData(false),
-	  rootEntry(0)
+	  rootEntry(0), headerPopup(0)
 {
 	int i;
 
@@ -416,11 +331,14 @@ ConfigList::ConfigList(ConfigView* p, Co
 	connect(this, SIGNAL(selectionChanged(void)),
 		SLOT(updateSelection(void)));
 
-	if (configSettings) {
-		showAll = configSettings->showAll;
-		showName = configSettings->showName;
-		showRange = configSettings->showRange;
-		showData = configSettings->showData;
+	if (name) {
+		configSettings->beginGroup(name);
+		showAll = configSettings->readBoolEntry("/showAll", false);
+		showName = configSettings->readBoolEntry("/showName", false);
+		showRange = configSettings->readBoolEntry("/showRange", false);
+		showData = configSettings->readBoolEntry("/showData", false);
+		configSettings->endGroup();
+		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
 	}
 
 	for (i = 0; i < colNr; i++)
@@ -451,6 +369,18 @@ void ConfigList::reinit(void)
 	updateListAll();
 }
 
+void ConfigList::saveSettings(void)
+{
+	if (name()) {
+		configSettings->beginGroup(name());
+		configSettings->writeEntry("/showName", showName);
+		configSettings->writeEntry("/showRange", showRange);
+		configSettings->writeEntry("/showData", showData);
+		configSettings->writeEntry("/showAll", showAll);
+		configSettings->endGroup();
+	}
+}
+
 void ConfigList::updateSelection(void)
 {
 	struct menu *menu;
@@ -512,14 +442,6 @@ update:
 	triggerUpdate();
 }
 
-void ConfigList::setAllOpen(bool open)
-{
-	QListViewItemIterator it(this);
-
-	for (; it.current(); it++)
-		it.current()->setOpen(open);
-}
-
 void ConfigList::setValue(ConfigItem* item, tristate val)
 {
 	struct symbol* sym;
@@ -624,6 +546,74 @@ void ConfigList::setParentMenu(void)
 	}
 }
 
+/*
+ * update all the children of a menu entry
+ *   removes/adds the entries from the parent widget as necessary
+ *
+ * parent: either the menu list widget or a menu entry widget
+ * menu: entry to be updated
+ */
+template <class P>
+void ConfigList::updateMenuList(P* parent, struct menu* menu)
+{
+	struct menu* child;
+	ConfigItem* item;
+	ConfigItem* last;
+	bool visible;
+	enum prop_type type;
+
+	if (!menu) {
+		while ((item = parent->firstChild()))
+			delete item;
+		return;
+	}
+
+	last = parent->firstChild();
+	if (last && !last->goParent)
+		last = 0;
+	for (child = menu->list; child; child = child->next) {
+		item = last ? last->nextSibling() : parent->firstChild();
+		type = child->prompt ? child->prompt->type : P_UNKNOWN;
+
+		switch (mode) {
+		case menuMode:
+			if (!(child->flags & MENU_ROOT))
+				goto hide;
+			break;
+		case symbolMode:
+			if (child->flags & MENU_ROOT)
+				goto hide;
+			break;
+		default:
+			break;
+		}
+
+		visible = menu_is_visible(child);
+		if (showAll || visible) {
+			if (!item || item->menu != child)
+				item = new ConfigItem(parent, last, child, visible);
+			else
+				item->testUpdateMenu(visible);
+
+			if (mode == fullMode || mode == menuMode || type != P_MENU)
+				updateMenuList(item, child);
+			else
+				updateMenuList(item, 0);
+			last = item;
+			continue;
+		}
+	hide:
+		if (item && item->menu == child) {
+			last = parent->firstChild();
+			if (last == item)
+				last = 0;
+			else while (last->nextSibling() != item)
+				last = last->nextSibling();
+			delete item;
+		}
+	}
+}
+
 void ConfigList::keyPressEvent(QKeyEvent* ev)
 {
 	QListViewItem* i = currentItem();
@@ -786,12 +776,50 @@ void ConfigList::focusInEvent(QFocusEven
 	emit gotFocus();
 }
 
+void ConfigList::contextMenuEvent(QContextMenuEvent *e)
+{
+	if (e->y() <= header()->geometry().bottom()) {
+		if (!headerPopup) {
+			QAction *action;
+
+			headerPopup = new QPopupMenu(this);
+			action = new QAction("Show Name", 0, this);
+			  action->setToggleAction(TRUE);
+			  connect(action, SIGNAL(toggled(bool)),
+				  parent(), SLOT(setShowName(bool)));
+			  connect(parent(), SIGNAL(showNameChanged(bool)),
+				  action, SLOT(setOn(bool)));
+			  action->setOn(showName);
+			  action->addTo(headerPopup);
+			action = new QAction("Show Range", 0, this);
+			  action->setToggleAction(TRUE);
+			  connect(action, SIGNAL(toggled(bool)),
+				  parent(), SLOT(setShowRange(bool)));
+			  connect(parent(), SIGNAL(showRangeChanged(bool)),
+				  action, SLOT(setOn(bool)));
+			  action->setOn(showRange);
+			  action->addTo(headerPopup);
+			action = new QAction("Show Data", 0, this);
+			  action->setToggleAction(TRUE);
+			  connect(action, SIGNAL(toggled(bool)),
+				  parent(), SLOT(setShowData(bool)));
+			  connect(parent(), SIGNAL(showDataChanged(bool)),
+				  action, SLOT(setOn(bool)));
+			  action->setOn(showData);
+			  action->addTo(headerPopup);
+		}
+		headerPopup->exec(e->globalPos());
+		e->accept();
+	} else
+		e->ignore();
+}
+
 ConfigView* ConfigView::viewList;
 
-ConfigView::ConfigView(QWidget* parent, ConfigSettings *configSettings)
-	: Parent(parent)
+ConfigView::ConfigView(QWidget* parent, const char *name)
+	: Parent(parent, name)
 {
-	list = new ConfigList(this, configSettings);
+	list = new ConfigList(this, name);
 	lineEdit = new ConfigLineEdit(this);
 	lineEdit->hide();
 
@@ -811,6 +839,50 @@ ConfigView::~ConfigView(void)
 	}
 }
 
+void ConfigView::setShowAll(bool b)
+{
+	if (list->showAll != b) {
+		list->showAll = b;
+		list->updateListAll();
+		emit showAllChanged(b);
+	}
+}
+
+void ConfigView::setShowName(bool b)
+{
+	if (list->showName != b) {
+		list->showName = b;
+		list->reinit();
+		emit showNameChanged(b);
+	}
+}
+
+void ConfigView::setShowRange(bool b)
+{
+	if (list->showRange != b) {
+		list->showRange = b;
+		list->reinit();
+		emit showRangeChanged(b);
+	}
+}
+
+void ConfigView::setShowData(bool b)
+{
+	if (list->showData != b) {
+		list->showData = b;
+		list->reinit();
+		emit showDataChanged(b);
+	}
+}
+
+void ConfigList::setAllOpen(bool open)
+{
+	QListViewItemIterator it(this);
+
+	for (; it.current(); it++)
+		it.current()->setOpen(open);
+}
+
 void ConfigView::updateList(ConfigItem* item)
 {
 	ConfigView* v;
@@ -830,6 +902,21 @@ void ConfigView::updateListAll(void)
 ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 	: Parent(parent, name), menu(0)
 {
+	if (name) {
+		configSettings->beginGroup(name);
+		_showDebug = configSettings->readBoolEntry("/showDebug", false);
+		configSettings->endGroup();
+		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
+	}
+}
+
+void ConfigInfoView::saveSettings(void)
+{
+	if (name()) {
+		configSettings->beginGroup(name());
+		configSettings->writeEntry("/showDebug", showDebug());
+		configSettings->endGroup();
+	}
 }
 
 void ConfigInfoView::setShowDebug(bool b)
@@ -1006,8 +1093,26 @@ void ConfigInfoView::expr_print_help(voi
 	reinterpret_cast<QString*>(data)->append(print_filter(str));
 }
 
-ConfigSearchWindow::ConfigSearchWindow(QWidget* parent)
-	: Parent(parent), result(NULL)
+QPopupMenu* ConfigInfoView::createPopupMenu(const QPoint& pos)
+{
+	QPopupMenu* popup = Parent::createPopupMenu(pos);
+	QAction* action = new QAction("Show Debug Info", 0, popup);
+	  action->setToggleAction(TRUE);
+	  connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
+	  connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
+	  action->setOn(showDebug());
+	popup->insertSeparator();
+	action->addTo(popup);
+	return popup;
+}
+
+void ConfigInfoView::contentsContextMenuEvent(QContextMenuEvent *e)
+{
+	Parent::contentsContextMenuEvent(e);
+}
+
+ConfigSearchWindow::ConfigSearchWindow(QWidget* parent, const char *name)
+	: Parent(parent, name), result(NULL)
 {
 	setCaption("Search Config");
 
@@ -1023,14 +1128,47 @@ ConfigSearchWindow::ConfigSearchWindow(Q
 	layout2->addWidget(searchButton);
 	layout1->addLayout(layout2);
 
-	QSplitter* split = new QSplitter(this);
+	split = new QSplitter(this);
 	split->setOrientation(QSplitter::Vertical);
-	list = new ConfigView(split, NULL);
+	list = new ConfigView(split, name);
 	list->list->mode = listMode;
-	info = new ConfigInfoView(split);
+	info = new ConfigInfoView(split, name);
 	connect(list->list, SIGNAL(menuChanged(struct menu *)),
 		info, SLOT(setInfo(struct menu *)));
 	layout1->addWidget(split);
+
+	if (name) {
+		int x, y, width, height;
+		bool ok;
+
+		configSettings->beginGroup(name);
+		width = configSettings->readNumEntry("/window width", parent->width() / 2);
+		height = configSettings->readNumEntry("/window height", parent->height() / 2);
+		resize(width, height);
+		x = configSettings->readNumEntry("/window x", 0, &ok);
+		if (ok)
+			y = configSettings->readNumEntry("/window y", 0, &ok);
+		if (ok)
+			move(x, y);
+		QValueList<int> sizes = configSettings->readSizes("/split", &ok);
+		if (ok)
+			split->setSizes(sizes);
+		configSettings->endGroup();
+		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
+	}
+}
+
+void ConfigSearchWindow::saveSettings(void)
+{
+	if (name()) {
+		configSettings->beginGroup(name());
+		configSettings->writeEntry("/window x", pos().x());
+		configSettings->writeEntry("/window y", pos().y());
+		configSettings->writeEntry("/window width", size().width());
+		configSettings->writeEntry("/window height", size().height());
+		configSettings->writeSizes("/split", split->sizes());
+		configSettings->endGroup();
+	}
 }
 
 void ConfigSearchWindow::search(void)
@@ -1058,49 +1196,36 @@ void ConfigSearchWindow::search(void)
 ConfigMainWindow::ConfigMainWindow(void)
 {
 	QMenuBar* menu;
-	bool ok, showDebug;
+	bool ok;
 	int x, y, width, height;
 
 	QWidget *d = configApp->desktop();
 
-	ConfigSettings* configSettings = new ConfigSettings();
-#if QT_VERSION >= 300
-	width = configSettings->readNumEntry("/kconfig/qconf/window width", d->width() - 64);
-	height = configSettings->readNumEntry("/kconfig/qconf/window height", d->height() - 64);
+	width = configSettings->readNumEntry("/window width", d->width() - 64);
+	height = configSettings->readNumEntry("/window height", d->height() - 64);
 	resize(width, height);
-	x = configSettings->readNumEntry("/kconfig/qconf/window x", 0, &ok);
+	x = configSettings->readNumEntry("/window x", 0, &ok);
 	if (ok)
-		y = configSettings->readNumEntry("/kconfig/qconf/window y", 0, &ok);
+		y = configSettings->readNumEntry("/window y", 0, &ok);
 	if (ok)
 		move(x, y);
-	showDebug = configSettings->readBoolEntry("/kconfig/qconf/showDebug", false);
-
-	// read list settings into configSettings, will be used later for ConfigList setup
-	configSettings->readListSettings();
-#else
-	width = d->width() - 64;
-	height = d->height() - 64;
-	resize(width, height);
-	showDebug = false;
-#endif
 
 	split1 = new QSplitter(this);
 	split1->setOrientation(QSplitter::Horizontal);
 	setCentralWidget(split1);
 
-	menuView = new ConfigView(split1, configSettings);
+	menuView = new ConfigView(split1, "menu");
 	menuList = menuView->list;
 
 	split2 = new QSplitter(split1);
 	split2->setOrientation(QSplitter::Vertical);
 
 	// create config tree
-	configView = new ConfigView(split2, configSettings);
+	configView = new ConfigView(split2, "config");
 	configList = configView->list;
 
-	helpText = new ConfigInfoView(split2);
+	helpText = new ConfigInfoView(split2, "help");
 	helpText->setTextFormat(Qt::RichText);
-	helpText->setShowDebug(showDebug);
 
 	setTabOrder(configList, helpText);
 	configList->setFocus();
@@ -1130,25 +1255,29 @@ ConfigMainWindow::ConfigMainWindow(void)
 
 	QAction *showNameAction = new QAction(NULL, "Show Name", 0, this);
 	  showNameAction->setToggleAction(TRUE);
-	  showNameAction->setOn(configList->showName);
-	  connect(showNameAction, SIGNAL(toggled(bool)), SLOT(setShowName(bool)));
+	  connect(showNameAction, SIGNAL(toggled(bool)), configView, SLOT(setShowName(bool)));
+	  connect(configView, SIGNAL(showNameChanged(bool)), showNameAction, SLOT(setOn(bool)));
+	  showNameAction->setOn(configView->showName());
 	QAction *showRangeAction = new QAction(NULL, "Show Range", 0, this);
 	  showRangeAction->setToggleAction(TRUE);
+	  connect(showRangeAction, SIGNAL(toggled(bool)), configView, SLOT(setShowRange(bool)));
+	  connect(configView, SIGNAL(showRangeChanged(bool)), showRangeAction, SLOT(setOn(bool)));
 	  showRangeAction->setOn(configList->showRange);
-	  connect(showRangeAction, SIGNAL(toggled(bool)), SLOT(setShowRange(bool)));
 	QAction *showDataAction = new QAction(NULL, "Show Data", 0, this);
 	  showDataAction->setToggleAction(TRUE);
+	  connect(showDataAction, SIGNAL(toggled(bool)), configView, SLOT(setShowData(bool)));
+	  connect(configView, SIGNAL(showDataChanged(bool)), showDataAction, SLOT(setOn(bool)));
 	  showDataAction->setOn(configList->showData);
-	  connect(showDataAction, SIGNAL(toggled(bool)), SLOT(setShowData(bool)));
 	QAction *showAllAction = new QAction(NULL, "Show All Options", 0, this);
 	  showAllAction->setToggleAction(TRUE);
+	  connect(showAllAction, SIGNAL(toggled(bool)), configView, SLOT(setShowAll(bool)));
+	  connect(showAllAction, SIGNAL(toggled(bool)), menuView, SLOT(setShowAll(bool)));
 	  showAllAction->setOn(configList->showAll);
-	  connect(showAllAction, SIGNAL(toggled(bool)), SLOT(setShowAll(bool)));
 	QAction *showDebugAction = new QAction(NULL, "Show Debug Info", 0, this);
 	  showDebugAction->setToggleAction(TRUE);
-	  showDebugAction->setOn(showDebug);
 	  connect(showDebugAction, SIGNAL(toggled(bool)), helpText, SLOT(setShowDebug(bool)));
 	  connect(helpText, SIGNAL(showDebugChanged(bool)), showDebugAction, SLOT(setOn(bool)));
+	  showDebugAction->setOn(helpText->showDebug());
 
 	QAction *showIntroAction = new QAction(NULL, "Introduction", 0, this);
 	  connect(showIntroAction, SIGNAL(activated()), SLOT(showIntro()));
@@ -1209,8 +1338,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(menuList, SIGNAL(gotFocus(void)),
 		SLOT(listFocusChanged(void)));
 
-#if QT_VERSION >= 300
-	QString listMode = configSettings->readEntry("/kconfig/qconf/listMode", "symbol");
+	QString listMode = configSettings->readEntry("/listMode", "symbol");
 	if (listMode == "single")
 		showSingleView();
 	else if (listMode == "full")
@@ -1219,17 +1347,13 @@ ConfigMainWindow::ConfigMainWindow(void)
 		showSplitView();
 
 	// UI setup done, restore splitter positions
-	QValueList<int> sizes = configSettings->readSizes("/kconfig/qconf/split1", &ok);
+	QValueList<int> sizes = configSettings->readSizes("/split1", &ok);
 	if (ok)
 		split1->setSizes(sizes);
 
-	sizes = configSettings->readSizes("/kconfig/qconf/split2", &ok);
+	sizes = configSettings->readSizes("/split2", &ok);
 	if (ok)
 		split2->setSizes(sizes);
-#else
-	showSplitView();
-#endif
-	delete configSettings;
 }
 
 /*
@@ -1237,7 +1361,6 @@ ConfigMainWindow::ConfigMainWindow(void)
  */
 void ConfigMainWindow::setHelp(QListViewItem* item)
 {
-	struct symbol* sym;
 	struct menu* menu = 0;
 
 	if (item)
@@ -1273,7 +1396,7 @@ void ConfigMainWindow::saveConfigAs(void
 void ConfigMainWindow::searchConfig(void)
 {
 	if (!searchWindow)
-		searchWindow = new ConfigSearchWindow(this);
+		searchWindow = new ConfigSearchWindow(this, "search");
 	searchWindow->show();
 }
 
@@ -1353,46 +1476,6 @@ void ConfigMainWindow::showFullView(void
 	configList->setFocus();
 }
 
-void ConfigMainWindow::setShowAll(bool b)
-{
-	if (configList->showAll == b)
-		return;
-	configList->showAll = b;
-	configList->updateListAll();
-	menuList->showAll = b;
-	menuList->updateListAll();
-}
-
-void ConfigMainWindow::setShowName(bool b)
-{
-	if (configList->showName == b)
-		return;
-	configList->showName = b;
-	configList->reinit();
-	menuList->showName = b;
-	menuList->reinit();
-}
-
-void ConfigMainWindow::setShowRange(bool b)
-{
-	if (configList->showRange == b)
-		return;
-	configList->showRange = b;
-	configList->reinit();
-	menuList->showRange = b;
-	menuList->reinit();
-}
-
-void ConfigMainWindow::setShowData(bool b)
-{
-	if (configList->showData == b)
-		return;
-	configList->showData = b;
-	configList->reinit();
-	menuList->showData = b;
-	menuList->reinit();
-}
-
 /*
  * ask for saving configuration before quitting
  * TODO ask only when something changed
@@ -1447,17 +1530,10 @@ void ConfigMainWindow::showAbout(void)
 
 void ConfigMainWindow::saveSettings(void)
 {
-#if QT_VERSION >= 300
-	ConfigSettings *configSettings = new ConfigSettings;
-	configSettings->writeEntry("/kconfig/qconf/window x", pos().x());
-	configSettings->writeEntry("/kconfig/qconf/window y", pos().y());
-	configSettings->writeEntry("/kconfig/qconf/window width", size().width());
-	configSettings->writeEntry("/kconfig/qconf/window height", size().height());
-	configSettings->writeEntry("/kconfig/qconf/showName", configList->showName);
-	configSettings->writeEntry("/kconfig/qconf/showRange", configList->showRange);
-	configSettings->writeEntry("/kconfig/qconf/showData", configList->showData);
-	configSettings->writeEntry("/kconfig/qconf/showAll", configList->showAll);
-	configSettings->writeEntry("/kconfig/qconf/showDebug", helpText->showDebug());
+	configSettings->writeEntry("/window x", pos().x());
+	configSettings->writeEntry("/window y", pos().y());
+	configSettings->writeEntry("/window width", size().width());
+	configSettings->writeEntry("/window height", size().height());
 
 	QString entry;
 	switch(configList->mode) {
@@ -1473,13 +1549,10 @@ void ConfigMainWindow::saveSettings(void
 		entry = "full";
 		break;
 	}
-	configSettings->writeEntry("/kconfig/qconf/listMode", entry);
+	configSettings->writeEntry("/listMode", entry);
 
-	configSettings->writeSizes("/kconfig/qconf/split1", split1->sizes());
-	configSettings->writeSizes("/kconfig/qconf/split2", split2->sizes());
-
-	delete configSettings;
-#endif
+	configSettings->writeSizes("/split1", split1->sizes());
+	configSettings->writeSizes("/split2", split2->sizes());
 }
 
 void fixup_rootmenu(struct menu *menu)
@@ -1537,6 +1610,8 @@ int main(int ac, char** av)
 	conf_read(NULL);
 	//zconfdump(stdout);
 
+	configSettings = new ConfigSettings();
+	configSettings->beginGroup("/kconfig/qconf");
 	v = new ConfigMainWindow();
 
 	//zconfdump(stdout);
@@ -1546,5 +1621,8 @@ int main(int ac, char** av)
 	v->show();
 	configApp->exec();
 
+	configSettings->endGroup();
+	delete configSettings;
+
 	return 0;
 }
Index: linux-2.6-git/scripts/kconfig/qconf.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.h
+++ linux-2.6-git/scripts/kconfig/qconf.h
@@ -7,9 +7,25 @@
 #if QT_VERSION >= 300
 #include <qsettings.h>
 #else
-class QSettings { };
+class QSettings {
+public:
+	void beginGroup(const QString& group) { }
+	void endGroup(void) { }
+	bool readBoolEntry(const QString& key, bool def = FALSE, bool* ok = 0) const
+	{ if (ok) *ok = FALSE; return def; }
+	int readNumEntry(const QString& key, int def = 0, bool* ok = 0) const
+	{ if (ok) *ok = FALSE; return def; }
+	QString readEntry(const QString& key, const QString& def = QString::null, bool* ok = 0) const
+	{ if (ok) *ok = FALSE; return def; }
+	QStringList readListEntry(const QString& key, bool* ok = 0) const
+	{ if (ok) *ok = FALSE; return QStringList(); }
+	template <class t>
+	bool writeEntry(const QString& key, t value)
+	{ return TRUE; }
+};
 #endif
 
+class ConfigView;
 class ConfigList;
 class ConfigItem;
 class ConfigLineEdit;
@@ -18,35 +34,8 @@ class ConfigMainWindow;
 
 class ConfigSettings : public QSettings {
 public:
-	ConfigSettings();
-
-#if QT_VERSION >= 300
-	void readListSettings();
 	QValueList<int> readSizes(const QString& key, bool *ok);
 	bool writeSizes(const QString& key, const QValueList<int>& value);
-#endif
-
-	bool showAll;
-	bool showName;
-	bool showRange;
-	bool showData;
-};
-
-class ConfigView : public QVBox {
-	Q_OBJECT
-	typedef class QVBox Parent;
-public:
-	ConfigView(QWidget* parent, ConfigSettings* configSettings);
-	~ConfigView(void);
-	static void updateList(ConfigItem* item);
-	static void updateListAll(void);
-
-public:
-	ConfigList* list;
-	ConfigLineEdit* lineEdit;
-
-	static ConfigView* viewList;
-	ConfigView* nextView;
 };
 
 enum colIdx {
@@ -60,7 +49,7 @@ class ConfigList : public QListView {
 	Q_OBJECT
 	typedef class QListView Parent;
 public:
-	ConfigList(ConfigView* p, ConfigSettings *configSettings);
+	ConfigList(ConfigView* p, const char *name = 0);
 	void reinit(void);
 	ConfigView* parent(void) const
 	{
@@ -74,6 +63,8 @@ protected:
 	void contentsMouseMoveEvent(QMouseEvent *e);
 	void contentsMouseDoubleClickEvent(QMouseEvent *e);
 	void focusInEvent(QFocusEvent *e);
+	void contextMenuEvent(QContextMenuEvent *e);
+
 public slots:
 	void setRootMenu(struct menu *menu);
 
@@ -81,6 +72,7 @@ public slots:
 	void setValue(ConfigItem* item, tristate val);
 	void changeValue(ConfigItem* item);
 	void updateSelection(void);
+	void saveSettings(void);
 signals:
 	void menuChanged(struct menu *menu);
 	void menuSelected(struct menu *menu);
@@ -136,6 +128,7 @@ public:
 	struct menu *rootEntry;
 	QColorGroup disabledColorGroup;
 	QColorGroup inactivedColorGroup;
+	QPopupMenu* headerPopup;
 
 private:
 	int colMap[colNr];
@@ -219,6 +212,37 @@ public:
 	ConfigItem *item;
 };
 
+class ConfigView : public QVBox {
+	Q_OBJECT
+	typedef class QVBox Parent;
+public:
+	ConfigView(QWidget* parent, const char *name = 0);
+	~ConfigView(void);
+	static void updateList(ConfigItem* item);
+	static void updateListAll(void);
+
+	bool showAll(void) const { return list->showAll; }
+	bool showName(void) const { return list->showName; }
+	bool showRange(void) const { return list->showRange; }
+	bool showData(void) const { return list->showData; }
+public slots:
+	void setShowAll(bool);
+	void setShowName(bool);
+	void setShowRange(bool);
+	void setShowData(bool);
+signals:
+	void showAllChanged(bool);
+	void showNameChanged(bool);
+	void showRangeChanged(bool);
+	void showDataChanged(bool);
+public:
+	ConfigList* list;
+	ConfigLineEdit* lineEdit;
+
+	static ConfigView* viewList;
+	ConfigView* nextView;
+};
+
 class ConfigInfoView : public QTextBrowser {
 	Q_OBJECT
 	typedef class QTextBrowser Parent;
@@ -228,6 +252,7 @@ public:
 
 public slots:
 	void setInfo(struct menu *menu);
+	void saveSettings(void);
 	void setSource(const QString& name);
 	void setShowDebug(bool);
 
@@ -239,6 +264,8 @@ protected:
 	QString debug_info(struct symbol *sym);
 	static QString print_filter(const QString &str);
 	static void expr_print_help(void *data, const char *str);
+	QPopupMenu* createPopupMenu(const QPoint& pos);
+	void contentsContextMenuEvent(QContextMenuEvent *e);
 
 	struct menu *menu;
 	bool _showDebug;
@@ -248,12 +275,16 @@ class ConfigSearchWindow : public QDialo
 	Q_OBJECT
 	typedef class QDialog Parent;
 public:
-	ConfigSearchWindow(QWidget* parent);
+	ConfigSearchWindow(QWidget* parent, const char *name = 0);
+
 public slots:
+	void saveSettings(void);
 	void search(void);
+
 protected:
 	QLineEdit* editField;
 	QPushButton* searchButton;
+	QSplitter* split;
 	ConfigView* list;
 	ConfigInfoView* info;
 
@@ -276,10 +307,6 @@ public slots:
 	void showSingleView(void);
 	void showSplitView(void);
 	void showFullView(void);
-	void setShowAll(bool);
-	void setShowRange(bool);
-	void setShowName(bool);
-	void setShowData(bool);
 	void showIntro(void);
 	void showAbout(void);
 	void saveSettings(void);
