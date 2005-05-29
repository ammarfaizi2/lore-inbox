Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVE3OqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVE3OqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVE3OoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:44:18 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43531 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261621AbVE3On0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:43:26 -0400
Subject: [patch 1/1] kconfig: trivial cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, zippel@linux-m68k.org,
       kbuild-devel@lists.sourceforge.net
From: blaisorblade@yahoo.it
Date: Sun, 29 May 2005 19:45:24 +0200
Message-Id: <20050529174525.A36D7A2FA3@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Roman Zippel <zippel@linux-m68k.org>, <kbuild-devel@lists.sourceforge.net>

Replace all menu_add_prop mimicking menu_add_prompt with the latter func. I've
had to add a return value to menu_add_prompt for one usage.

Remains to rebuild scripts/kconfig/zconf.tab.c_shipped, which I didn't in this
patch because I've a different version of Bison (2.0 one) and so the patch I
get would be bigly cluttered.

If you want, I'll do one patch update the included version to 2.0 Bison (which
uses an updated skeleton) and then, separately, a patch updating
zconf.tab.c_shipped to reflect the updated zconf.y.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/./scripts/kconfig/menu.c |    4 ++--
 linux-2.6.git-paolo/scripts/kconfig/lkc.h    |    2 +-
 linux-2.6.git-paolo/scripts/kconfig/zconf.y  |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff -puN scripts/kconfig/lkc.h~kbuild-trivial-cleanup scripts/kconfig/lkc.h
--- linux-2.6.git/scripts/kconfig/lkc.h~kbuild-trivial-cleanup	2005-05-29 19:34:19.000000000 +0200
+++ linux-2.6.git-paolo/scripts/kconfig/lkc.h	2005-05-29 19:34:19.000000000 +0200
@@ -59,7 +59,7 @@ void menu_add_entry(struct symbol *sym);
 void menu_end_entry(void);
 void menu_add_dep(struct expr *dep);
 struct property *menu_add_prop(enum prop_type type, char *prompt, struct expr *expr, struct expr *dep);
-void menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
+struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
 void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
 void menu_finalize(struct menu *parent);
diff -puN ./scripts/kconfig/menu.c~kbuild-trivial-cleanup ./scripts/kconfig/menu.c
--- linux-2.6.git/./scripts/kconfig/menu.c~kbuild-trivial-cleanup	2005-05-29 19:34:19.000000000 +0200
+++ linux-2.6.git-paolo/./scripts/kconfig/menu.c	2005-05-29 19:34:19.000000000 +0200
@@ -136,9 +136,9 @@ struct property *menu_add_prop(enum prop
 	return prop;
 }
 
-void menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep)
+struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep)
 {
-	menu_add_prop(type, prompt, NULL, dep);
+	return menu_add_prop(type, prompt, NULL, dep);
 }
 
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep)
diff -puN scripts/kconfig/zconf.y~kbuild-trivial-cleanup scripts/kconfig/zconf.y
--- linux-2.6.git/scripts/kconfig/zconf.y~kbuild-trivial-cleanup	2005-05-29 19:34:19.000000000 +0200
+++ linux-2.6.git-paolo/scripts/kconfig/zconf.y	2005-05-29 19:34:19.000000000 +0200
@@ -342,7 +342,7 @@ if_block:
 menu: T_MENU prompt T_EOL
 {
 	menu_add_entry(NULL);
-	menu_add_prop(P_MENU, $2, NULL, NULL);
+	menu_add_prompt(P_MENU, $2, NULL);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 };
 
@@ -392,7 +392,7 @@ source_stmt: source
 comment: T_COMMENT prompt T_EOL
 {
 	menu_add_entry(NULL);
-	menu_add_prop(P_COMMENT, $2, NULL, NULL);
+	menu_add_prompt(P_COMMENT, $2, NULL);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 };
 
@@ -443,7 +443,7 @@ prompt_stmt_opt:
 	  /* empty */
 	| prompt if_expr
 {
-	menu_add_prop(P_PROMPT, $1, NULL, $2);
+	menu_add_prompt(P_PROMPT, $1, $2);
 };
 
 prompt:	  T_WORD
@@ -487,7 +487,7 @@ void conf_parse(const char *name)
 	sym_init();
 	menu_init();
 	modules_sym = sym_lookup("MODULES", 0);
-	rootmenu.prompt = menu_add_prop(P_MENU, "Linux Kernel Configuration", NULL, NULL);
+	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 	//zconfdebug = 1;
 	zconfparse();
_
