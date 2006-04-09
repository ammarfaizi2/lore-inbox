Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDIP3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDIP3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWDIP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:28:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31914 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750776AbWDIP23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:28:29 -0400
Date: Sun, 9 Apr 2006 17:28:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/19] kconfig: allow multiple default values per symbol
Message-ID: <Pine.LNX.4.64.0604091728190.23136@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extend struct symbol to allow storing multiple default values, which can
be used to hold multiple configurations.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/confdata.c |   34 +++++++++++++++++-----------------
 scripts/kconfig/expr.h     |    7 ++++++-
 scripts/kconfig/symbol.c   |   16 ++++++++--------
 3 files changed, 31 insertions(+), 26 deletions(-)

Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -133,11 +133,11 @@ load:
 		case S_INT:
 		case S_HEX:
 		case S_STRING:
-			if (sym->user.val)
-				free(sym->user.val);
+			if (sym->def[S_DEF_USER].val)
+				free(sym->def[S_DEF_USER].val);
 		default:
-			sym->user.val = NULL;
-			sym->user.tri = no;
+			sym->def[S_DEF_USER].val = NULL;
+			sym->def[S_DEF_USER].tri = no;
 		}
 	}
 
@@ -165,7 +165,7 @@ load:
 			switch (sym->type) {
 			case S_BOOLEAN:
 			case S_TRISTATE:
-				sym->user.tri = no;
+				sym->def[S_DEF_USER].tri = no;
 				sym->flags &= ~SYMBOL_NEW;
 				break;
 			default:
@@ -195,18 +195,18 @@ load:
 			switch (sym->type) {
 			case S_TRISTATE:
 				if (p[0] == 'm') {
-					sym->user.tri = mod;
+					sym->def[S_DEF_USER].tri = mod;
 					sym->flags &= ~SYMBOL_NEW;
 					break;
 				}
 			case S_BOOLEAN:
 				if (p[0] == 'y') {
-					sym->user.tri = yes;
+					sym->def[S_DEF_USER].tri = yes;
 					sym->flags &= ~SYMBOL_NEW;
 					break;
 				}
 				if (p[0] == 'n') {
-					sym->user.tri = no;
+					sym->def[S_DEF_USER].tri = no;
 					sym->flags &= ~SYMBOL_NEW;
 					break;
 				}
@@ -229,7 +229,7 @@ load:
 			case S_INT:
 			case S_HEX:
 				if (sym_string_valid(sym, p)) {
-					sym->user.val = strdup(p);
+					sym->def[S_DEF_USER].val = strdup(p);
 					sym->flags &= ~SYMBOL_NEW;
 				} else {
 					conf_warning("symbol value '%s' invalid for %s", p, sym->name);
@@ -248,24 +248,24 @@ load:
 		}
 		if (sym && sym_is_choice_value(sym)) {
 			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
-			switch (sym->user.tri) {
+			switch (sym->def[S_DEF_USER].tri) {
 			case no:
 				break;
 			case mod:
-				if (cs->user.tri == yes) {
+				if (cs->def[S_DEF_USER].tri == yes) {
 					conf_warning("%s creates inconsistent choice state", sym->name);
 					cs->flags |= SYMBOL_NEW;
 				}
 				break;
 			case yes:
-				if (cs->user.tri != no) {
+				if (cs->def[S_DEF_USER].tri != no) {
 					conf_warning("%s creates inconsistent choice state", sym->name);
 					cs->flags |= SYMBOL_NEW;
 				} else
-					cs->user.val = sym;
+					cs->def[S_DEF_USER].val = sym;
 				break;
 			}
-			cs->user.tri = E_OR(cs->user.tri, sym->user.tri);
+			cs->def[S_DEF_USER].tri = E_OR(cs->def[S_DEF_USER].tri, sym->def[S_DEF_USER].tri);
 		}
 	}
 	fclose(in);
@@ -294,12 +294,12 @@ int conf_read(const char *name)
 			switch (sym->type) {
 			case S_BOOLEAN:
 			case S_TRISTATE:
-				if (sym->user.tri != sym_get_tristate_value(sym))
+				if (sym->def[S_DEF_USER].tri != sym_get_tristate_value(sym))
 					break;
 				if (!sym_is_choice(sym))
 					goto sym_ok;
 			default:
-				if (!strcmp(sym->curr.val, sym->user.val))
+				if (!strcmp(sym->curr.val, sym->def[S_DEF_USER].val))
 					goto sym_ok;
 				break;
 			}
@@ -316,7 +316,7 @@ int conf_read(const char *name)
 			case S_STRING:
 			case S_INT:
 			case S_HEX:
-				if (!sym_string_within_range(sym, sym->user.val)) {
+				if (!sym_string_within_range(sym, sym->def[S_DEF_USER].val)) {
 					sym->flags |= SYMBOL_NEW;
 					sym->flags &= ~SYMBOL_VALID;
 				}
Index: linux-2.6-git/scripts/kconfig/expr.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.h
+++ linux-2.6-git/scripts/kconfig/expr.h
@@ -63,12 +63,17 @@ enum symbol_type {
 	S_UNKNOWN, S_BOOLEAN, S_TRISTATE, S_INT, S_HEX, S_STRING, S_OTHER
 };
 
+enum {
+	S_DEF_USER,		/* main user value */
+};
+
 struct symbol {
 	struct symbol *next;
 	char *name;
 	char *help;
 	enum symbol_type type;
-	struct symbol_value curr, user;
+	struct symbol_value curr;
+	struct symbol_value def[4];
 	tristate visible;
 	int flags;
 	struct property *prop;
Index: linux-2.6-git/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/symbol.c
+++ linux-2.6-git/scripts/kconfig/symbol.c
@@ -227,7 +227,7 @@ static struct symbol *sym_calc_choice(st
 	struct expr *e;
 
 	/* is the user choice visible? */
-	def_sym = sym->user.val;
+	def_sym = sym->def[S_DEF_USER].val;
 	if (def_sym) {
 		sym_calc_visibility(def_sym);
 		if (def_sym->visible != no)
@@ -306,7 +306,7 @@ void sym_calc_value(struct symbol *sym)
 		} else if (E_OR(sym->visible, sym->rev_dep.tri) != no) {
 			sym->flags |= SYMBOL_WRITE;
 			if (sym_has_value(sym))
-				newval.tri = sym->user.tri;
+				newval.tri = sym->def[S_DEF_USER].tri;
 			else if (!sym_is_choice(sym)) {
 				prop = sym_get_default_prop(sym);
 				if (prop)
@@ -329,7 +329,7 @@ void sym_calc_value(struct symbol *sym)
 		if (sym->visible != no) {
 			sym->flags |= SYMBOL_WRITE;
 			if (sym_has_value(sym)) {
-				newval.val = sym->user.val;
+				newval.val = sym->def[S_DEF_USER].val;
 				break;
 			}
 		}
@@ -439,7 +439,7 @@ bool sym_set_tristate_value(struct symbo
 		struct property *prop;
 		struct expr *e;
 
-		cs->user.val = sym;
+		cs->def[S_DEF_USER].val = sym;
 		cs->flags &= ~SYMBOL_NEW;
 		prop = sym_get_choice_prop(cs);
 		for (e = prop->expr; e; e = e->left.expr) {
@@ -448,7 +448,7 @@ bool sym_set_tristate_value(struct symbo
 		}
 	}
 
-	sym->user.tri = val;
+	sym->def[S_DEF_USER].tri = val;
 	if (oldval != val) {
 		sym_clear_all_valid();
 		if (sym == modules_sym)
@@ -596,15 +596,15 @@ bool sym_set_string_value(struct symbol 
 		sym_set_changed(sym);
 	}
 
-	oldval = sym->user.val;
+	oldval = sym->def[S_DEF_USER].val;
 	size = strlen(newval) + 1;
 	if (sym->type == S_HEX && (newval[0] != '0' || (newval[1] != 'x' && newval[1] != 'X'))) {
 		size += 2;
-		sym->user.val = val = malloc(size);
+		sym->def[S_DEF_USER].val = val = malloc(size);
 		*val++ = '0';
 		*val++ = 'x';
 	} else if (!oldval || strcmp(oldval, newval))
-		sym->user.val = val = malloc(size);
+		sym->def[S_DEF_USER].val = val = malloc(size);
 	else
 		return true;
 
