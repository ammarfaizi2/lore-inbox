Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDIPbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDIPbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDIPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:31:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37034 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750792AbWDIPal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:30:41 -0400
Date: Sun, 9 Apr 2006 17:30:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 17/19] kconfig: jump to linked menu prompt
Message-ID: <Pine.LNX.4.64.0604091730020.23183@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If clicking on of the links, which leads to a visible prompt, jump to it
in the symbol list.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/qconf.cc |  109 +++++++++++++++++++++++++++++++++++------------
 scripts/kconfig/qconf.h  |    6 +-
 2 files changed, 86 insertions(+), 29 deletions(-)

Index: linux-2.6-git/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.cc
+++ linux-2.6-git/scripts/kconfig/qconf.cc
@@ -381,6 +381,18 @@ void ConfigList::saveSettings(void)
 	}
 }
 
+ConfigItem* ConfigList::findConfigItem(struct menu *menu)
+{
+	ConfigItem* item = (ConfigItem*)menu->data;
+
+	for (; item; item = item->nextItem) {
+		if (this == item->listView())
+			break;
+	}
+
+	return item;
+}
+
 void ConfigList::updateSelection(void)
 {
 	struct menu *menu;
@@ -524,6 +536,7 @@ void ConfigList::setRootMenu(struct menu
 	rootEntry = menu;
 	updateListAll();
 	setSelected(currentItem(), hasFocus());
+	ensureItemVisible(currentItem());
 }
 
 void ConfigList::setParentMenu(void)
@@ -766,14 +779,16 @@ skip:
 
 void ConfigList::focusInEvent(QFocusEvent *e)
 {
-	Parent::focusInEvent(e);
+	struct menu *menu = NULL;
 
-	QListViewItem* item = currentItem();
-	if (!item)
-		return;
+	Parent::focusInEvent(e);
 
-	setSelected(item, TRUE);
-	emit gotFocus();
+	ConfigItem* item = (ConfigItem *)currentItem();
+	if (item) {
+		setSelected(item, TRUE);
+		menu = item->menu;
+	}
+	emit gotFocus(menu);
 }
 
 void ConfigList::contextMenuEvent(QContextMenuEvent *e)
@@ -933,6 +948,8 @@ void ConfigInfoView::setShowDebug(bool b
 
 void ConfigInfoView::setInfo(struct menu *m)
 {
+	if (menu == m)
+		return;
 	menu = m;
 	if (!menu)
 		clear();
@@ -954,6 +971,7 @@ void ConfigInfoView::setSource(const QSt
 		if (sscanf(p, "m%p", &m) == 1 && menu != m) {
 			menu = m;
 			menuInfo();
+			emit menuSelected(menu);
 		}
 		break;
 	case 's':
@@ -1380,10 +1398,14 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(menuList, SIGNAL(menuSelected(struct menu *)),
 		SLOT(changeMenu(struct menu *)));
 
-	connect(configList, SIGNAL(gotFocus(void)),
-		SLOT(listFocusChanged(void)));
-	connect(menuList, SIGNAL(gotFocus(void)),
+	connect(configList, SIGNAL(gotFocus(struct menu *)),
+		helpText, SLOT(setInfo(struct menu *)));
+	connect(menuList, SIGNAL(gotFocus(struct menu *)),
+		helpText, SLOT(setInfo(struct menu *)));
+	connect(menuList, SIGNAL(gotFocus(struct menu *)),
 		SLOT(listFocusChanged(void)));
+	connect(helpText, SIGNAL(menuSelected(struct menu *)),
+		SLOT(setMenuLink(struct menu *)));
 
 	QString listMode = configSettings->readEntry("/listMode", "symbol");
 	if (listMode == "single")
@@ -1403,18 +1425,6 @@ ConfigMainWindow::ConfigMainWindow(void)
 		split2->setSizes(sizes);
 }
 
-/*
- * display a new help entry as soon as a new menu entry is selected
- */
-void ConfigMainWindow::setHelp(QListViewItem* item)
-{
-	struct menu* menu = 0;
-
-	if (item)
-		menu = ((ConfigItem*)item)->menu;
-	helpText->setInfo(menu);
-}
-
 void ConfigMainWindow::loadConfig(void)
 {
 	QString s = QFileDialog::getOpenFileName(".config", NULL, this);
@@ -1453,17 +1463,62 @@ void ConfigMainWindow::changeMenu(struct
 	backAction->setEnabled(TRUE);
 }
 
-void ConfigMainWindow::listFocusChanged(void)
+void ConfigMainWindow::setMenuLink(struct menu *menu)
 {
-	if (menuList->hasFocus()) {
-		if (menuList->mode == menuMode)
+	struct menu *parent;
+	ConfigList* list = NULL;
+	ConfigItem* item;
+
+	if (!menu_is_visible(menu) && !configView->showAll())
+		return;
+
+	switch (configList->mode) {
+	case singleMode:
+		list = configList;
+		parent = menu_get_parent_menu(menu);
+		if (!parent)
+			return;
+		list->setRootMenu(parent);
+		break;
+	case symbolMode:
+		if (menu->flags & MENU_ROOT) {
+			configList->setRootMenu(menu);
 			configList->clearSelection();
-		setHelp(menuList->selectedItem());
-	} else if (configList->hasFocus()) {
-		setHelp(configList->selectedItem());
+			list = menuList;
+		} else {
+			list = configList;
+			parent = menu_get_parent_menu(menu->parent);
+			if (!parent)
+				return;
+			item = menuList->findConfigItem(parent);
+			if (item) {
+				menuList->setSelected(item, TRUE);
+				menuList->ensureItemVisible(item);
+			}
+			list->setRootMenu(parent);
+		}
+		break;
+	case fullMode:
+		list = configList;
+		break;
+	}
+
+	if (list) {
+		item = list->findConfigItem(menu);
+		if (item) {
+			list->setSelected(item, TRUE);
+			list->ensureItemVisible(item);
+			list->setFocus();
+		}
 	}
 }
 
+void ConfigMainWindow::listFocusChanged(void)
+{
+	if (menuList->mode == menuMode)
+		configList->clearSelection();
+}
+
 void ConfigMainWindow::goBack(void)
 {
 	ConfigItem* item;
Index: linux-2.6-git/scripts/kconfig/qconf.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.h
+++ linux-2.6-git/scripts/kconfig/qconf.h
@@ -55,6 +55,7 @@ public:
 	{
 		return (ConfigView*)Parent::parent();
 	}
+	ConfigItem* findConfigItem(struct menu *);
 
 protected:
 	void keyPressEvent(QKeyEvent *e);
@@ -77,7 +78,7 @@ signals:
 	void menuChanged(struct menu *menu);
 	void menuSelected(struct menu *menu);
 	void parentSelected(void);
-	void gotFocus(void);
+	void gotFocus(struct menu *);
 
 public:
 	void updateListAll(void)
@@ -258,6 +259,7 @@ public slots:
 
 signals:
 	void showDebugChanged(bool);
+	void menuSelected(struct menu *);
 
 protected:
 	void symbolInfo(void);
@@ -298,8 +300,8 @@ class ConfigMainWindow : public QMainWin
 public:
 	ConfigMainWindow(void);
 public slots:
-	void setHelp(QListViewItem* item);
 	void changeMenu(struct menu *);
+	void setMenuLink(struct menu *);
 	void listFocusChanged(void);
 	void goBack(void);
 	void loadConfig(void);
