Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDIP2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDIP2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDIP2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:28:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32426 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750780AbWDIP2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:28:40 -0400
Date: Sun, 9 Apr 2006 17:28:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/19] kconfig: allow loading multiple configurations
Message-ID: <Pine.LNX.4.64.0604091728310.23140@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extend conf_read_simple() so it can load multiple configurations.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/conf.c      |    6 +-
 scripts/kconfig/confdata.c  |  111 ++++++++++++++++++++++++++------------------
 scripts/kconfig/expr.h      |    6 +-
 scripts/kconfig/gconf.c     |    6 --
 scripts/kconfig/lkc.h       |    2 
 scripts/kconfig/lkc_proto.h |    2 
 scripts/kconfig/symbol.c    |   13 ++---
 7 files changed, 84 insertions(+), 62 deletions(-)

Index: linux-2.6-git/scripts/kconfig/conf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/conf.c
+++ linux-2.6-git/scripts/kconfig/conf.c
@@ -572,7 +572,7 @@ int main(int ac, char **av)
 	case set_random:
 		name = getenv("KCONFIG_ALLCONFIG");
 		if (name && !stat(name, &tmpstat)) {
-			conf_read_simple(name);
+			conf_read_simple(name, S_DEF_USER);
 			break;
 		}
 		switch (input_mode) {
@@ -583,9 +583,9 @@ int main(int ac, char **av)
 		default: break;
 		}
 		if (!stat(name, &tmpstat))
-			conf_read_simple(name);
+			conf_read_simple(name, S_DEF_USER);
 		else if (!stat("all.config", &tmpstat))
-			conf_read_simple("all.config");
+			conf_read_simple("all.config", S_DEF_USER);
 		break;
 	default:
 		break;
Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -86,13 +86,13 @@ char *conf_get_default_confname(void)
 	return name;
 }
 
-int conf_read_simple(const char *name)
+int conf_read_simple(const char *name, int def)
 {
 	FILE *in = NULL;
 	char line[1024];
 	char *p, *p2;
 	struct symbol *sym;
-	int i;
+	int i, def_flags;
 
 	if (name) {
 		in = zconf_fopen(name);
@@ -125,20 +125,21 @@ load:
 	conf_warnings = 0;
 	conf_unsaved = 0;
 
+	def_flags = SYMBOL_DEF << def;
 	for_all_symbols(i, sym) {
-		sym->flags |= SYMBOL_NEW | SYMBOL_CHANGED;
+		sym->flags |= SYMBOL_CHANGED;
+		sym->flags &= ~(def_flags|SYMBOL_VALID);
 		if (sym_is_choice(sym))
-			sym->flags &= ~SYMBOL_NEW;
-		sym->flags &= ~SYMBOL_VALID;
+			sym->flags |= def_flags;
 		switch (sym->type) {
 		case S_INT:
 		case S_HEX:
 		case S_STRING:
-			if (sym->def[S_DEF_USER].val)
-				free(sym->def[S_DEF_USER].val);
+			if (sym->def[def].val)
+				free(sym->def[def].val);
 		default:
-			sym->def[S_DEF_USER].val = NULL;
-			sym->def[S_DEF_USER].tri = no;
+			sym->def[def].val = NULL;
+			sym->def[def].tri = no;
 		}
 	}
 
@@ -155,19 +156,26 @@ load:
 			*p++ = 0;
 			if (strncmp(p, "is not set", 10))
 				continue;
-			sym = sym_find(line + 9);
-			if (!sym) {
-				conf_warning("trying to assign nonexistent symbol %s", line + 9);
-				break;
-			} else if (!(sym->flags & SYMBOL_NEW)) {
+			if (def == S_DEF_USER) {
+				sym = sym_find(line + 9);
+				if (!sym) {
+					conf_warning("trying to assign nonexistent symbol %s", line + 9);
+					break;
+				}
+			} else {
+				sym = sym_lookup(line + 9, 0);
+				if (sym->type == S_UNKNOWN)
+					sym->type = S_BOOLEAN;
+			}
+			if (sym->flags & def_flags) {
 				conf_warning("trying to reassign symbol %s", sym->name);
 				break;
 			}
 			switch (sym->type) {
 			case S_BOOLEAN:
 			case S_TRISTATE:
-				sym->def[S_DEF_USER].tri = no;
-				sym->flags &= ~SYMBOL_NEW;
+				sym->def[def].tri = no;
+				sym->flags |= def_flags;
 				break;
 			default:
 				;
@@ -185,34 +193,48 @@ load:
 			p2 = strchr(p, '\n');
 			if (p2)
 				*p2 = 0;
-			sym = sym_find(line + 7);
-			if (!sym) {
-				conf_warning("trying to assign nonexistent symbol %s", line + 7);
-				break;
-			} else if (!(sym->flags & SYMBOL_NEW)) {
+			if (def == S_DEF_USER) {
+				sym = sym_find(line + 7);
+				if (!sym) {
+					conf_warning("trying to assign nonexistent symbol %s", line + 7);
+					break;
+				}
+			} else {
+				sym = sym_lookup(line + 7, 0);
+				if (sym->type == S_UNKNOWN)
+					sym->type = S_OTHER;
+			}
+			if (sym->flags & def_flags) {
 				conf_warning("trying to reassign symbol %s", sym->name);
 				break;
 			}
 			switch (sym->type) {
 			case S_TRISTATE:
 				if (p[0] == 'm') {
-					sym->def[S_DEF_USER].tri = mod;
-					sym->flags &= ~SYMBOL_NEW;
+					sym->def[def].tri = mod;
+					sym->flags |= def_flags;
 					break;
 				}
 			case S_BOOLEAN:
 				if (p[0] == 'y') {
-					sym->def[S_DEF_USER].tri = yes;
-					sym->flags &= ~SYMBOL_NEW;
+					sym->def[def].tri = yes;
+					sym->flags |= def_flags;
 					break;
 				}
 				if (p[0] == 'n') {
-					sym->def[S_DEF_USER].tri = no;
-					sym->flags &= ~SYMBOL_NEW;
+					sym->def[def].tri = no;
+					sym->flags |= def_flags;
 					break;
 				}
 				conf_warning("symbol value '%s' invalid for %s", p, sym->name);
 				break;
+			case S_OTHER:
+				if (*p != '"') {
+					for (p2 = p; *p2 && !isspace(*p2); p2++)
+						;
+					sym->type = S_STRING;
+					goto done;
+				}
 			case S_STRING:
 				if (*p++ != '"')
 					break;
@@ -229,9 +251,10 @@ load:
 				}
 			case S_INT:
 			case S_HEX:
+			done:
 				if (sym_string_valid(sym, p)) {
-					sym->def[S_DEF_USER].val = strdup(p);
-					sym->flags &= ~SYMBOL_NEW;
+					sym->def[def].val = strdup(p);
+					sym->flags |= def_flags;
 				} else {
 					conf_warning("symbol value '%s' invalid for %s", p, sym->name);
 					continue;
@@ -249,24 +272,24 @@ load:
 		}
 		if (sym && sym_is_choice_value(sym)) {
 			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
-			switch (sym->def[S_DEF_USER].tri) {
+			switch (sym->def[def].tri) {
 			case no:
 				break;
 			case mod:
-				if (cs->def[S_DEF_USER].tri == yes) {
+				if (cs->def[def].tri == yes) {
 					conf_warning("%s creates inconsistent choice state", sym->name);
-					cs->flags |= SYMBOL_NEW;
+					cs->flags &= ~def_flags;
 				}
 				break;
 			case yes:
-				if (cs->def[S_DEF_USER].tri != no) {
+				if (cs->def[def].tri != no) {
 					conf_warning("%s creates inconsistent choice state", sym->name);
-					cs->flags |= SYMBOL_NEW;
+					cs->flags &= ~def_flags;
 				} else
-					cs->def[S_DEF_USER].val = sym;
+					cs->def[def].val = sym;
 				break;
 			}
-			cs->def[S_DEF_USER].tri = E_OR(cs->def[S_DEF_USER].tri, sym->def[S_DEF_USER].tri);
+			cs->def[def].tri = E_OR(cs->def[def].tri, sym->def[def].tri);
 		}
 	}
 	fclose(in);
@@ -281,11 +304,11 @@ int conf_read(const char *name)
 	struct symbol *sym;
 	struct property *prop;
 	struct expr *e;
-	int i;
+	int i, flags;
 
 	sym_change_count = 0;
 
-	if (conf_read_simple(name))
+	if (conf_read_simple(name, S_DEF_USER))
 		return 1;
 
 	for_all_symbols(i, sym) {
@@ -314,15 +337,13 @@ int conf_read(const char *name)
 	sym_ok:
 		if (sym_has_value(sym) && !sym_is_choice_value(sym)) {
 			if (sym->visible == no)
-				sym->flags |= SYMBOL_NEW;
+				sym->flags &= ~SYMBOL_DEF_USER;
 			switch (sym->type) {
 			case S_STRING:
 			case S_INT:
 			case S_HEX:
-				if (!sym_string_within_range(sym, sym->def[S_DEF_USER].val)) {
-					sym->flags |= SYMBOL_NEW;
-					sym->flags &= ~SYMBOL_VALID;
-				}
+				if (!sym_string_within_range(sym, sym->def[S_DEF_USER].val))
+					sym->flags &= ~(SYMBOL_VALID|SYMBOL_DEF_USER);
 			default:
 				break;
 			}
@@ -330,9 +351,11 @@ int conf_read(const char *name)
 		if (!sym_is_choice(sym))
 			continue;
 		prop = sym_get_choice_prop(sym);
+		flags = sym->flags;
 		for (e = prop->expr; e; e = e->left.expr)
 			if (e->right.sym->visible != no)
-				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
+				flags &= e->right.sym->flags;
+		sym->flags |= flags & SYMBOL_DEF_USER;
 	}
 
 	sym_change_count += conf_warnings || conf_unsaved;
Index: linux-2.6-git/scripts/kconfig/expr.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.h
+++ linux-2.6-git/scripts/kconfig/expr.h
@@ -92,10 +92,14 @@ struct symbol {
 #define SYMBOL_OPTIONAL		0x0100
 #define SYMBOL_WRITE		0x0200
 #define SYMBOL_CHANGED		0x0400
-#define SYMBOL_NEW		0x0800
 #define SYMBOL_AUTO		0x1000
 #define SYMBOL_CHECKED		0x2000
 #define SYMBOL_WARNED		0x8000
+#define SYMBOL_DEF		0x10000
+#define SYMBOL_DEF_USER		0x10000
+#define SYMBOL_DEF2		0x20000
+#define SYMBOL_DEF3		0x40000
+#define SYMBOL_DEF4		0x80000
 
 #define SYMBOL_MAXLENGTH	256
 #define SYMBOL_HASHSIZE		257
Index: linux-2.6-git/scripts/kconfig/gconf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/gconf.c
+++ linux-2.6-git/scripts/kconfig/gconf.c
@@ -132,8 +132,6 @@ const char *dbg_print_flags(int val)
 		strcat(buf, "write/");
 	if (val & SYMBOL_CHANGED)
 		strcat(buf, "changed/");
-	if (val & SYMBOL_NEW)
-		strcat(buf, "new/");
 	if (val & SYMBOL_AUTO)
 		strcat(buf, "auto/");
 
@@ -1186,9 +1184,7 @@ static gchar **fill_row(struct menu *men
 
 	row[COL_OPTION] =
 	    g_strdup_printf("%s %s", menu_get_prompt(menu),
-			    sym ? (sym->
-				   flags & SYMBOL_NEW ? "(NEW)" : "") :
-			    "");
+			    sym && sym_has_value(sym) ? "(NEW)" : "");
 
 	if (show_all && !menu_is_visible(menu))
 		row[COL_COLOR] = g_strdup("DarkGray");
Index: linux-2.6-git/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc.h
+++ linux-2.6-git/scripts/kconfig/lkc.h
@@ -137,7 +137,7 @@ static inline bool sym_is_optional(struc
 
 static inline bool sym_has_value(struct symbol *sym)
 {
-	return sym->flags & SYMBOL_NEW ? false : true;
+	return sym->flags & SYMBOL_DEF_USER ? true : false;
 }
 
 #ifdef __cplusplus
Index: linux-2.6-git/scripts/kconfig/lkc_proto.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc_proto.h
+++ linux-2.6-git/scripts/kconfig/lkc_proto.h
@@ -2,7 +2,7 @@
 /* confdata.c */
 P(conf_parse,void,(const char *name));
 P(conf_read,int,(const char *name));
-P(conf_read_simple,int,(const char *name));
+P(conf_read_simple,int,(const char *name, int));
 P(conf_write,int,(const char *name));
 P(conf_write_autoconf,int,(void));
 
Index: linux-2.6-git/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/symbol.c
+++ linux-2.6-git/scripts/kconfig/symbol.c
@@ -426,8 +426,8 @@ bool sym_set_tristate_value(struct symbo
 	if (oldval != val && !sym_tristate_within_range(sym, val))
 		return false;
 
-	if (sym->flags & SYMBOL_NEW) {
-		sym->flags &= ~SYMBOL_NEW;
+	if (!(sym->flags & SYMBOL_DEF_USER)) {
+		sym->flags |= SYMBOL_DEF_USER;
 		sym_set_changed(sym);
 	}
 	/*
@@ -440,11 +440,11 @@ bool sym_set_tristate_value(struct symbo
 		struct expr *e;
 
 		cs->def[S_DEF_USER].val = sym;
-		cs->flags &= ~SYMBOL_NEW;
+		cs->flags |= SYMBOL_DEF_USER;
 		prop = sym_get_choice_prop(cs);
 		for (e = prop->expr; e; e = e->left.expr) {
 			if (e->right.sym->visible != no)
-				e->right.sym->flags &= ~SYMBOL_NEW;
+				e->right.sym->flags |= SYMBOL_DEF_USER;
 		}
 	}
 
@@ -591,8 +591,8 @@ bool sym_set_string_value(struct symbol 
 	if (!sym_string_within_range(sym, newval))
 		return false;
 
-	if (sym->flags & SYMBOL_NEW) {
-		sym->flags &= ~SYMBOL_NEW;
+	if (!(sym->flags & SYMBOL_DEF_USER)) {
+		sym->flags |= SYMBOL_DEF_USER;
 		sym_set_changed(sym);
 	}
 
@@ -679,7 +679,6 @@ struct symbol *sym_lookup(const char *na
 	memset(symbol, 0, sizeof(*symbol));
 	symbol->name = new_name;
 	symbol->type = S_UNKNOWN;
-	symbol->flags = SYMBOL_NEW;
 	if (isconst)
 		symbol->flags |= SYMBOL_CONST;
 
