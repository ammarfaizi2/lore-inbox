Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVG1Psy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVG1Psy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVG1PqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:46:12 -0400
Received: from [151.97.230.9] ([151.97.230.9]:41124 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261485AbVG1Po3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:44:29 -0400
Subject: [patch 2/2] kconfig: trivial cleanup
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 17:56:25 +0200
Message-Id: <20050728155627.14CD51ADBD@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Roman Zippel <zippel@linux-m68k.org>, <kbuild-devel@lists.sourceforge.net>

Replace all menu_add_prop mimicking menu_add_prompt with the latter func. I've
had to add a return value to menu_add_prompt for one usage.

I've rebuilt scripts/kconfig/zconf.tab.c_shipped by hand to reflect changes
in the source (I've not the same Bison version so regenerating it wouldn't
have been not a good idea), and compared it with what Roman itself did some
time ago, and it's the same.

So I guess this can be finally merged.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/./scripts/kconfig/menu.c            |    4 ++--
 linux-2.6.git-paolo/scripts/kconfig/lkc.h               |    2 +-
 linux-2.6.git-paolo/scripts/kconfig/zconf.tab.c_shipped |    8 ++++----
 linux-2.6.git-paolo/scripts/kconfig/zconf.y             |    8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff -puN scripts/kconfig/lkc.h~kbuild-trivial-cleanup scripts/kconfig/lkc.h
--- linux-2.6.git/scripts/kconfig/lkc.h~kbuild-trivial-cleanup	2005-07-28 17:56:01.000000000 +0200
+++ linux-2.6.git-paolo/scripts/kconfig/lkc.h	2005-07-28 17:56:01.000000000 +0200
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
--- linux-2.6.git/./scripts/kconfig/menu.c~kbuild-trivial-cleanup	2005-07-28 17:56:01.000000000 +0200
+++ linux-2.6.git-paolo/./scripts/kconfig/menu.c	2005-07-28 17:56:01.000000000 +0200
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
--- linux-2.6.git/scripts/kconfig/zconf.y~kbuild-trivial-cleanup	2005-07-28 17:56:01.000000000 +0200
+++ linux-2.6.git-paolo/scripts/kconfig/zconf.y	2005-07-28 17:56:01.000000000 +0200
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
diff -puN scripts/kconfig/zconf.tab.c_shipped~kbuild-trivial-cleanup scripts/kconfig/zconf.tab.c_shipped
--- linux-2.6.git/scripts/kconfig/zconf.tab.c_shipped~kbuild-trivial-cleanup	2005-07-28 17:56:01.000000000 +0200
+++ linux-2.6.git-paolo/scripts/kconfig/zconf.tab.c_shipped	2005-07-28 17:56:01.000000000 +0200
@@ -1531,7 +1531,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prop(P_MENU, yyvsp[-1].string, NULL, NULL);
+	menu_add_prompt(P_MENU, yyvsp[-1].string, NULL);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1586,7 +1586,7 @@ yyreduce:
 
     {
 	menu_add_entry(NULL);
-	menu_add_prop(P_COMMENT, yyvsp[-1].string, NULL, NULL);
+	menu_add_prompt(P_COMMENT, yyvsp[-1].string, NULL);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 ;}
     break;
@@ -1640,7 +1640,7 @@ yyreduce:
   case 86:
 
     {
-	menu_add_prop(P_PROMPT, yyvsp[-1].string, NULL, yyvsp[0].expr);
+	menu_add_prompt(P_PROMPT, yyvsp[-1].string, yyvsp[0].expr);
 ;}
     break;
 
@@ -1925,7 +1925,7 @@ void conf_parse(const char *name)
 	sym_init();
 	menu_init();
 	modules_sym = sym_lookup("MODULES", 0);
-	rootmenu.prompt = menu_add_prop(P_MENU, "Linux Kernel Configuration", NULL, NULL);
+	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 	//zconfdebug = 1;
 	zconfparse();
_
