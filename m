Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWJQW2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWJQW2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWJQW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:28:04 -0400
Received: from mout2.freenet.de ([194.97.50.155]:28814 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750830AbWJQW2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:28:01 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Add "void conf_set_changed_callback(void (*fn)(void))", use it in qconf.cc
Date: Wed, 18 Oct 2006 00:30:07 +0200
User-Agent: KMail/1.9.4
References: <200610180023.04978.annabellesgarden@yahoo.de> <200610180027.16967.annabellesgarden@yahoo.de> <200610180028.45011.annabellesgarden@yahoo.de>
In-Reply-To: <200610180028.45011.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610180030.07972.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added function sets "void (*conf_changed_callback)(void)".
Call it, if .config's changed state changes.
Use above in qconf.cc to set gui's save-widget's sensitvity.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 scripts/kconfig/confdata.c  |   12 +++++++++++-
 scripts/kconfig/lkc_proto.h |    1 +
 scripts/kconfig/qconf.cc    |   13 ++++++++++++-
 scripts/kconfig/qconf.h     |    3 +++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4bbbb5b..664fe29 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -767,18 +767,28 @@ int conf_write_autoconf(void)
 }
 
 static int sym_change_count;
+static void (*conf_changed_callback)(void);
 
 void sym_set_change_count(int count)
 {
+	int _sym_change_count = sym_change_count;
 	sym_change_count = count;
+	if (conf_changed_callback &&
+	    (bool)_sym_change_count != (bool)count)
+		conf_changed_callback();
 }
 
 void sym_add_change_count(int count)
 {
-	sym_change_count += count;
+	sym_set_change_count(count + sym_change_count);
 }
 
 bool conf_get_changed(void)
 {
 	return sym_change_count;
 }
+
+void conf_set_changed_callback(void (*fn)(void))
+{
+	conf_changed_callback = fn;
+}
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 84bb139..1503077 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -6,6 +6,7 @@ P(conf_read_simple,int,(const char *name
 P(conf_write,int,(const char *name));
 P(conf_write_autoconf,int,(void));
 P(conf_get_changed,bool,(void));
+P(conf_set_changed_callback, void,(void (*fn)(void)));
 
 /* menu.c */
 P(rootmenu,struct menu,);
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 64d1060..c00c6e4 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -38,6 +38,8 @@ #endif
 static QApplication *configApp;
 static ConfigSettings *configSettings;
 
+QAction *ConfigMainWindow::saveAction;
+
 static inline QString qgettext(const char* str)
 {
 	return QString::fromLocal8Bit(gettext(str));
@@ -1305,8 +1307,11 @@ ConfigMainWindow::ConfigMainWindow(void)
 	  connect(quitAction, SIGNAL(activated()), SLOT(close()));
 	QAction *loadAction = new QAction("Load", QPixmap(xpm_load), "&Load", CTRL+Key_L, this);
 	  connect(loadAction, SIGNAL(activated()), SLOT(loadConfig()));
-	QAction *saveAction = new QAction("Save", QPixmap(xpm_save), "&Save", CTRL+Key_S, this);
+	saveAction = new QAction("Save", QPixmap(xpm_save), "&Save", CTRL+Key_S, this);
 	  connect(saveAction, SIGNAL(activated()), SLOT(saveConfig()));
+	conf_set_changed_callback(conf_changed);
+	// Set saveAction's initial state
+	conf_changed();
 	QAction *saveAsAction = new QAction("Save As...", "Save &As...", 0, this);
 	  connect(saveAsAction, SIGNAL(activated()), SLOT(saveConfigAs()));
 	QAction *searchAction = new QAction("Search", "&Search", CTRL+Key_F, this);
@@ -1657,6 +1662,12 @@ void ConfigMainWindow::saveSettings(void
 	configSettings->writeSizes("/split2", split2->sizes());
 }
 
+void ConfigMainWindow::conf_changed(void)
+{
+	if (saveAction)
+		saveAction->setEnabled(conf_get_changed());
+}
+
 void fixup_rootmenu(struct menu *menu)
 {
 	struct menu *child;
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6a9e3b1..6fc1c5f 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -297,6 +297,9 @@ protected:
 
 class ConfigMainWindow : public QMainWindow {
 	Q_OBJECT
+
+	static QAction *saveAction;
+	static void conf_changed(void);
 public:
 	ConfigMainWindow(void);
 public slots:
-- 
1.4.2.3

