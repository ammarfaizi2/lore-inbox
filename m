Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDIPct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDIPct (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDIPcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:32:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34986 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750780AbWDIP3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:29:37 -0400
Date: Sun, 9 Apr 2006 17:29:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 13/19] kconfig: add defconfig_list/module option
Message-ID: <Pine.LNX.4.64.0604091729270.23155@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This makes it possible to change two options which were hardcoded sofar.
1. Any symbol can now take the role of CONFIG_MODULES
2. The more useful option is to change the list of default file names,
   which kconfig uses to load the base configuration if .config isn't
   available.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 init/Kconfig                        |    8 ++++++++
 scripts/kconfig/confdata.c          |   26 +++++++++++---------------
 scripts/kconfig/expr.h              |    1 +
 scripts/kconfig/lkc.h               |    1 +
 scripts/kconfig/menu.c              |   14 ++++++++++++++
 scripts/kconfig/symbol.c            |   15 ++++++++-------
 scripts/kconfig/zconf.tab.c_shipped |   10 +++++++++-
 scripts/kconfig/zconf.y             |   10 +++++++++-
 8 files changed, 61 insertions(+), 24 deletions(-)

Index: linux-2.6-git/init/Kconfig
===================================================================
--- linux-2.6-git.orig/init/Kconfig
+++ linux-2.6-git/init/Kconfig
@@ -1,3 +1,11 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "/lib/modules/$UNAME_RELEASE/.config"
+	default "/etc/kernel-config"
+	default "/boot/config-$UNAME_RELEASE"
+	default "arch/$ARCH/defconfig"
+
 menu "Code maturity level options"
 
 config EXPERIMENTAL
Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -25,15 +25,6 @@ const char conf_def_filename[] = ".confi
 
 const char conf_defname[] = "arch/$ARCH/defconfig";
 
-const char *conf_confnames[] = {
-	".config",
-	"/lib/modules/$UNAME_RELEASE/.config",
-	"/etc/kernel-config",
-	"/boot/config-$UNAME_RELEASE",
-	conf_defname,
-	NULL,
-};
-
 static void conf_warning(const char *fmt, ...)
 {
 	va_list ap;
@@ -98,16 +89,21 @@ int conf_read_simple(const char *name, i
 	if (name) {
 		in = zconf_fopen(name);
 	} else {
-		const char **names = conf_confnames;
-		name = *names++;
-		if (!name)
-			return 1;
+		struct property *prop;
+
+		name = conf_def_filename;
 		in = zconf_fopen(name);
 		if (in)
 			goto load;
 		sym_change_count++;
-		while ((name = *names++)) {
-			name = conf_expand_value(name);
+		if (!sym_defconfig_list)
+			return 1;
+
+		for_all_defaults(sym_defconfig_list, prop) {
+			if (expr_calc_value(prop->visible.expr) == no ||
+			    prop->expr->type != E_SYMBOL)
+				continue;
+			name = conf_expand_value(prop->expr->left.sym->name);
 			in = zconf_fopen(name);
 			if (in) {
 				printf(_("#\n"
Index: linux-2.6-git/scripts/kconfig/expr.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.h
+++ linux-2.6-git/scripts/kconfig/expr.h
@@ -156,6 +156,7 @@ struct file *lookup_file(const char *nam
 
 extern struct symbol symbol_yes, symbol_no, symbol_mod;
 extern struct symbol *modules_sym;
+extern struct symbol *sym_defconfig_list;
 extern int cdebug;
 struct expr *expr_alloc_symbol(struct symbol *sym);
 struct expr *expr_alloc_one(enum expr_type type, struct expr *ce);
Index: linux-2.6-git/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc.h
+++ linux-2.6-git/scripts/kconfig/lkc.h
@@ -104,6 +104,7 @@ const char *str_get(struct gstr *gs);
 /* symbol.c */
 void sym_init(void);
 void sym_clear_all_valid(void);
+void sym_set_all_changed(void);
 void sym_set_changed(struct symbol *sym);
 struct symbol *sym_check_deps(struct symbol *sym);
 struct property *prop_alloc(enum prop_type type, struct symbol *sym);
Index: linux-2.6-git/scripts/kconfig/menu.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/menu.c
+++ linux-2.6-git/scripts/kconfig/menu.c
@@ -154,6 +154,20 @@ void menu_add_symbol(enum prop_type type
 
 void menu_add_option(int token, char *arg)
 {
+	struct property *prop;
+
+	switch (token) {
+	case T_OPT_MODULES:
+		prop = prop_alloc(P_DEFAULT, modules_sym);
+		prop->expr = expr_alloc_symbol(current_entry->sym);
+		break;
+	case T_OPT_DEFCONFIG_LIST:
+		if (!sym_defconfig_list)
+			sym_defconfig_list = current_entry->sym;
+		else if (sym_defconfig_list != current_entry->sym)
+			zconf_error("trying to redefine defconfig symbol");
+		break;
+	}
 }
 
 static int menu_range_valid_sym(struct symbol *sym, struct symbol *sym2)
Index: linux-2.6-git/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/symbol.c
+++ linux-2.6-git/scripts/kconfig/symbol.c
@@ -31,6 +31,7 @@ struct symbol symbol_yes = {
 };
 
 int sym_change_count;
+struct symbol *sym_defconfig_list;
 struct symbol *modules_sym;
 tristate modules_val;
 
@@ -352,10 +353,13 @@ void sym_calc_value(struct symbol *sym)
 		sym->curr.val = sym_calc_choice(sym);
 	sym_validate_range(sym);
 
-	if (memcmp(&oldval, &sym->curr, sizeof(oldval)))
+	if (memcmp(&oldval, &sym->curr, sizeof(oldval))) {
 		sym_set_changed(sym);
-	if (modules_sym == sym)
-		modules_val = modules_sym->curr.tri;
+		if (modules_sym == sym) {
+			sym_set_all_changed();
+			modules_val = modules_sym->curr.tri;
+		}
+	}
 
 	if (sym_is_choice(sym)) {
 		int flags = sym->flags & (SYMBOL_CHANGED | SYMBOL_WRITE);
@@ -449,11 +453,8 @@ bool sym_set_tristate_value(struct symbo
 	}
 
 	sym->def[S_DEF_USER].tri = val;
-	if (oldval != val) {
+	if (oldval != val)
 		sym_clear_all_valid();
-		if (sym == modules_sym)
-			sym_set_all_changed();
-	}
 
 	return true;
 }
Index: linux-2.6-git/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.tab.c_shipped
+++ linux-2.6-git/scripts/kconfig/zconf.tab.c_shipped
@@ -2112,7 +2112,9 @@ void conf_parse(const char *name)
 
 	sym_init();
 	menu_init();
-	modules_sym = sym_lookup("MODULES", 0);
+	modules_sym = sym_lookup(NULL, 0);
+	modules_sym->type = S_BOOLEAN;
+	modules_sym->flags |= SYMBOL_AUTO;
 	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 #if YYDEBUG
@@ -2122,6 +2124,12 @@ void conf_parse(const char *name)
 	zconfparse();
 	if (zconfnerrs)
 		exit(1);
+	if (!modules_sym->prop) {
+		struct property *prop;
+
+		prop = prop_alloc(P_DEFAULT, modules_sym);
+		prop->expr = expr_alloc_symbol(sym_lookup("MODULES", 0));
+	}
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
 		sym_check_deps(sym);
Index: linux-2.6-git/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.y
+++ linux-2.6-git/scripts/kconfig/zconf.y
@@ -481,7 +481,9 @@ void conf_parse(const char *name)
 
 	sym_init();
 	menu_init();
-	modules_sym = sym_lookup("MODULES", 0);
+	modules_sym = sym_lookup(NULL, 0);
+	modules_sym->type = S_BOOLEAN;
+	modules_sym->flags |= SYMBOL_AUTO;
 	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 #if YYDEBUG
@@ -491,6 +493,12 @@ void conf_parse(const char *name)
 	zconfparse();
 	if (zconfnerrs)
 		exit(1);
+	if (!modules_sym->prop) {
+		struct property *prop;
+
+		prop = prop_alloc(P_DEFAULT, modules_sym);
+		prop->expr = expr_alloc_symbol(sym_lookup("MODULES", 0));
+	}
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
 		sym_check_deps(sym);
