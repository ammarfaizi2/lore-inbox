Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUBIWRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUBIWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:17:48 -0500
Received: from imap.gmx.net ([213.165.64.20]:7881 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265203AbUBIWRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:17:34 -0500
X-Authenticated: #125400
Message-ID: <4028075E.1070809@gmx.de>
Date: Mon, 09 Feb 2004 23:19:10 +0100
From: Andreas Fester <Andreas.Fester@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zippel@linux-m68k.org, Linus Torvalds <torvalds@osdl.org>
Subject: [2.6 PATCH] persist qconf options
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

enclosed is a patch to persist the selected options
from the "Options" menu of qconf.
Please apply, since it really improves the usage of the
qconf tool ;-) or otherwise comment ...

Thanks :-)

	Andreas

diff -ur linux-2.6.2/scripts/kconfig/qconf.cc linux-2.6.2-af2/scripts/kconfig/qconf.cc
--- linux-2.6.2/scripts/kconfig/qconf.cc	2004-02-07 23:04:24.000000000 +0100
+++ linux-2.6.2-af2/scripts/kconfig/qconf.cc	2004-02-09 22:31:16.000000000 +0100
@@ -327,13 +327,14 @@
  	hide();
  }

-ConfigList::ConfigList(ConfigView* p, ConfigMainWindow* cv)
+ConfigList::ConfigList(ConfigView* p, ConfigMainWindow* cv,
+			bool isShowAll, bool isShowName, bool isShowRange, bool isShowData)
  	: Parent(p), cview(cv),
  	  updateAll(false),
  	  symbolYesPix(xpm_symbol_yes), symbolModPix(xpm_symbol_mod), symbolNoPix(xpm_symbol_no),
  	  choiceYesPix(xpm_choice_yes), choiceNoPix(xpm_choice_no),
  	  menuPix(xpm_menu), menuInvPix(xpm_menu_inv), menuBackPix(xpm_menuback), voidPix(xpm_void),
-	  showAll(false), showName(false), showRange(false), showData(false),
+	  showAll(isShowAll), showName(isShowName), showRange(isShowRange), showData(isShowData),
  	  rootEntry(0)
  {
  	int i;
@@ -702,10 +703,13 @@

  ConfigView* ConfigView::viewList;

-ConfigView::ConfigView(QWidget* parent, ConfigMainWindow* cview)
+ConfigView::ConfigView(QWidget* parent, ConfigMainWindow* cview,
+			bool isShowAll, bool isShowName,
+			bool isShowRange, bool isShowData)
  	: Parent(parent)
  {
-	list = new ConfigList(this, cview);
+	list = new ConfigList(this, cview, isShowAll, isShowName,
+			isShowRange, isShowData);
  	lineEdit = new ConfigLineEdit(this);
  	lineEdit->hide();

@@ -754,6 +758,11 @@

  	QWidget *d = configApp->desktop();

+	bool isShowAll = false;
+	bool isShowName = false;
+	bool isShowRange = false;
+	bool isShowData = false;
+
  #if QT_VERSION >= 300
  	width = configSettings->readNumEntry("/kconfig/qconf/window width", d->width() - 64);
  	height = configSettings->readNumEntry("/kconfig/qconf/window height", d->height() - 64);
@@ -763,26 +772,34 @@
  		y = configSettings->readNumEntry("/kconfig/qconf/window y", 0, &ok);
  	if (ok)
  		move(x, y);
+	showDebug = configSettings->readBoolEntry("/kconfig/qconf/showDebug", false);
+	isShowAll = configSettings->readBoolEntry("/kconfig/qconf/showAll", false);
+	isShowName = configSettings->readBoolEntry("/kconfig/qconf/showName", false);
+	isShowRange = configSettings->readBoolEntry("/kconfig/qconf/showRange", false);
+	isShowData = configSettings->readBoolEntry("/kconfig/qconf/showData", false);
  #else
  	width = d->width() - 64;
  	height = d->height() - 64;
  	resize(width, height);
-#endif
-
  	showDebug = false;
+#endif

  	split1 = new QSplitter(this);
  	split1->setOrientation(QSplitter::Horizontal);
  	setCentralWidget(split1);

-	menuView = new ConfigView(split1, this);
+	menuView = new ConfigView(split1, this,
+				 isShowAll, isShowName,
+				 isShowRange, isShowData);
  	menuList = menuView->list;

  	split2 = new QSplitter(split1);
  	split2->setOrientation(QSplitter::Vertical);

  	// create config tree
-	configView = new ConfigView(split2, this);
+	configView = new ConfigView(split2, this,
+				    isShowAll, isShowName,
+				    isShowRange, isShowData);
  	configList = configView->list;

  	helpText = new QTextView(split2);
@@ -1145,6 +1162,10 @@
  	menuList->updateListAll();
  }

+bool ConfigMainWindow::getShowAll() {
+	return configList->showAll;
+}
+
  void ConfigMainWindow::setShowDebug(bool b)
  {
  	if (showDebug == b)
@@ -1152,6 +1173,10 @@
  	showDebug = b;
  }

+bool ConfigMainWindow::getShowDebug() {
+	return showDebug;
+}
+
  void ConfigMainWindow::setShowName(bool b)
  {
  	if (configList->showName == b)
@@ -1162,6 +1187,10 @@
  	menuList->reinit();
  }

+bool ConfigMainWindow::getShowName() {
+	return configList->showName;
+}
+
  void ConfigMainWindow::setShowRange(bool b)
  {
  	if (configList->showRange == b)
@@ -1172,6 +1201,10 @@
  	menuList->reinit();
  }

+bool ConfigMainWindow::getShowRange() {
+	return configList->showRange;
+}
+
  void ConfigMainWindow::setShowData(bool b)
  {
  	if (configList->showData == b)
@@ -1182,6 +1215,11 @@
  	menuList->reinit();
  }

+bool ConfigMainWindow::getShowData() {
+	return configList->showData;
+}
+
+
  /*
   * ask for saving configuration before quitting
   * TODO ask only when something changed
@@ -1260,6 +1298,7 @@

  int main(int ac, char** av)
  {
+
  	ConfigMainWindow* v;
  	const char *name;

@@ -1301,6 +1340,12 @@
  	configSettings->writeEntry("/kconfig/qconf/window y", v->pos().y());
  	configSettings->writeEntry("/kconfig/qconf/window width", v->size().width());
  	configSettings->writeEntry("/kconfig/qconf/window height", v->size().height());
+	configSettings->writeEntry("/kconfig/qconf/showName", v->getShowName());
+	configSettings->writeEntry("/kconfig/qconf/showRange", v->getShowRange());
+	configSettings->writeEntry("/kconfig/qconf/showData", v->getShowData());
+	configSettings->writeEntry("/kconfig/qconf/showAll", v->getShowAll());
+	configSettings->writeEntry("/kconfig/qconf/showDebug", v->getShowDebug());
+
  	delete configSettings;
  #endif
  	return 0;
diff -ur linux-2.6.2/scripts/kconfig/qconf.h linux-2.6.2-af2/scripts/kconfig/qconf.h
--- linux-2.6.2/scripts/kconfig/qconf.h	2004-02-09 21:56:32.000000000 +0100
+++ linux-2.6.2-af2/scripts/kconfig/qconf.h	2004-02-09 22:22:13.000000000 +0100
@@ -14,7 +14,9 @@
  	Q_OBJECT
  	typedef class QVBox Parent;
  public:
-	ConfigView(QWidget* parent, ConfigMainWindow* cview);
+	ConfigView(QWidget* parent, ConfigMainWindow* cview,
+		   bool isShowAll = false, bool isShowName = false,
+		   bool isShowRange = false, bool isShowData = false);
  	~ConfigView(void);
  	static void updateList(ConfigItem* item);
  	static void updateListAll(void);
@@ -38,7 +40,9 @@
  	Q_OBJECT
  	typedef class QListView Parent;
  public:
-	ConfigList(ConfigView* p, ConfigMainWindow* cview);
+	ConfigList(ConfigView* p, ConfigMainWindow* cview,
+		   bool isShowAll = false, bool isShowName = false,
+		   bool isShowRange = false, bool isShowData = false);
  	void reinit(void);
  	ConfigView* parent(void) const
  	{
@@ -216,10 +220,15 @@
  	void showSplitView(void);
  	void showFullView(void);
  	void setShowAll(bool);
+	bool getShowAll();
  	void setShowDebug(bool);
+	bool getShowDebug();
  	void setShowRange(bool);
+	bool getShowRange();
  	void setShowName(bool);
+	bool getShowName();
  	void setShowData(bool);
+	bool getShowData();
  	void showIntro(void);
  	void showAbout(void);
