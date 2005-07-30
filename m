Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVG3V7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVG3V7H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVG3V7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:59:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:46099 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262886AbVG3V67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:58:59 -0400
Date: Sun, 31 Jul 2005 00:01:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [RFD] kconfig - introduce cond-source
Message-ID: <20050730220100.GA3240@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

In a couple of cases I have had the need to include a Kconfig file only
if present.
The current 'source' directive works as one would expect. It bails out
if the file is missing.

Examples where I have missed cond-source:
- klibc work
- external modules

	Sam

Patch below implement a cond-source.


diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -39,6 +39,7 @@ void zconf_starthelp(void);
 FILE *zconf_fopen(const char *name);
 void zconf_initscan(const char *name);
 void zconf_nextfile(const char *name);
+void zconf_try_nextfile(const char *name);
 int zconf_lineno(void);
 char *zconf_curname(void);
 
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -91,6 +91,7 @@ n	[A-Za-z0-9_]
 	"mainmenu"		BEGIN(PARAM); return T_MAINMENU;
 	"menu"			BEGIN(PARAM); return T_MENU;
 	"endmenu"		BEGIN(PARAM); return T_ENDMENU;
+	"cond-source"		BEGIN(PARAM); return T_CONDSOURCE;
 	"source"		BEGIN(PARAM); return T_SOURCE;
 	"choice"		BEGIN(PARAM); return T_CHOICE;
 	"endchoice"		BEGIN(PARAM); return T_ENDCHOICE;
@@ -299,18 +300,14 @@ void zconf_initscan(const char *name)
 	current_file->flags = FILE_BUSY;
 }
 
-void zconf_nextfile(const char *name)
+static void zconf_switch_buffer(const char *name, FILE *filp)
 {
 	struct file *file = file_lookup(name);
 	struct buffer *buf = malloc(sizeof(*buf));
 	memset(buf, 0, sizeof(*buf));
 
 	current_buf->state = YY_CURRENT_BUFFER;
-	yyin = zconf_fopen(name);
-	if (!yyin) {
-		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
-		exit(1);
-	}
+	yyin = filp;
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 	buf->parent = current_buf;
 	current_buf = buf;
@@ -329,6 +326,27 @@ void zconf_nextfile(const char *name)
 	current_file = file;
 }
 
+void zconf_nextfile(const char *name)
+{
+	FILE *filp;
+
+	filp = zconf_fopen(name);
+	if (!filp) {
+		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
+		exit(1);
+	}
+	zconf_switch_buffer(name, filp);
+}
+
+void zconf_try_nextfile(const char *name)
+{
+	FILE *filp;
+
+	filp = zconf_fopen(name);
+	if (filp)
+		zconf_switch_buffer(name, filp);
+}
+
 static struct buffer *zconf_endfile(void)
 {
 	struct buffer *parent;

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -44,6 +44,7 @@ static struct menu *current_menu, *curre
 %token T_MENU
 %token T_ENDMENU
 %token T_SOURCE
+%token T_CONDSOURCE
 %token T_CHOICE
 %token T_ENDCHOICE
 %token T_COMMENT
@@ -378,15 +379,22 @@ menu_block:
 
 source: T_SOURCE prompt T_EOL
 {
-	$$ = $2;
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
+	zconf_nextfile($2);
 };
 
-source_stmt: source
+condsource: T_CONDSOURCE prompt T_EOL
 {
-	zconf_nextfile($1);
+	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
+	zconf_try_nextfile($2);
 };
 
+source_stmt:
+	  source
+	| condsource
+	/* empty */
+;
+
 /* comment entry */
 
 comment: T_COMMENT prompt T_EOL
