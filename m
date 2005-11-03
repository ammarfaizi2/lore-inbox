Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVKCPHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVKCPHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKCPHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:07:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28361 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030258AbVKCPHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:07:47 -0500
Date: Thu, 3 Nov 2005 16:07:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] kconfig: allow variable argumnts for range
Message-ID: <Pine.LNX.4.61.0511031607280.2505@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows variable arguments in the range option for int and hex config 
symbols.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/menu.c   |   10 ++++++--
 scripts/kconfig/symbol.c |   58 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

Index: linux-2.6/scripts/kconfig/menu.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/menu.c	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/menu.c	2005-11-03 13:10:29.000000000 +0100
@@ -151,6 +151,12 @@ void menu_add_symbol(enum prop_type type
 	menu_add_prop(type, NULL, expr_alloc_symbol(sym), dep);
 }
 
+static int menu_range_valid_sym(struct symbol *sym, struct symbol *sym2)
+{
+	return sym2->type == S_INT || sym2->type == S_HEX ||
+	       (sym2->type == S_UNKNOWN && sym_string_valid(sym, sym2->name));
+}
+
 void sym_check_prop(struct symbol *sym)
 {
 	struct property *prop;
@@ -185,8 +191,8 @@ void sym_check_prop(struct symbol *sym)
 			if (sym->type != S_INT && sym->type != S_HEX)
 				prop_warn(prop, "range is only allowed "
 				                "for int or hex symbols");
-			if (!sym_string_valid(sym, prop->expr->left.sym->name) ||
-			    !sym_string_valid(sym, prop->expr->right.sym->name))
+			if (!menu_range_valid_sym(sym, prop->expr->left.sym) ||
+			    !menu_range_valid_sym(sym, prop->expr->right.sym))
 				prop_warn(prop, "range is invalid");
 			break;
 		default:
Index: linux-2.6/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/symbol.c	2005-11-03 13:10:24.000000000 +0100
+++ linux-2.6/scripts/kconfig/symbol.c	2005-11-03 13:10:29.000000000 +0100
@@ -141,6 +141,55 @@ struct property *sym_get_range_prop(stru
 	return NULL;
 }
 
+static int sym_get_range_val(struct symbol *sym, int base)
+{
+	sym_calc_value(sym);
+	switch (sym->type) {
+	case S_INT:
+		base = 10;
+		break;
+	case S_HEX:
+		base = 16;
+		break;
+	default:
+		break;
+	}
+	return strtol(sym->curr.val, NULL, base);
+}
+
+static void sym_validate_range(struct symbol *sym)
+{
+	struct property *prop;
+	int base, val, val2;
+	char str[64];
+
+	switch (sym->type) {
+	case S_INT:
+		base = 10;
+		break;
+	case S_HEX:
+		base = 16;
+		break;
+	default:
+		return;
+	}
+	prop = sym_get_range_prop(sym);
+	if (!prop)
+		return;
+	val = strtol(sym->curr.val, NULL, base);
+	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	if (val >= val2) {
+		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		if (val <= val2)
+			return;
+	}
+	if (sym->type == S_INT)
+		sprintf(str, "%d", val2);
+	else
+		sprintf(str, "0x%x", val2);
+	sym->curr.val = strdup(str);
+}
+
 static void sym_calc_visibility(struct symbol *sym)
 {
 	struct property *prop;
@@ -301,6 +350,7 @@ void sym_calc_value(struct symbol *sym)
 	sym->curr = newval;
 	if (sym_is_choice(sym) && newval.tri == yes)
 		sym->curr.val = sym_calc_choice(sym);
+	sym_validate_range(sym);
 
 	if (memcmp(&oldval, &sym->curr, sizeof(oldval)))
 		sym_set_changed(sym);
@@ -478,8 +528,8 @@ bool sym_string_within_range(struct symb
 		if (!prop)
 			return true;
 		val = strtol(str, NULL, 10);
-		return val >= strtol(prop->expr->left.sym->name, NULL, 10) &&
-		       val <= strtol(prop->expr->right.sym->name, NULL, 10);
+		return val >= sym_get_range_val(prop->expr->left.sym, 10) &&
+		       val <= sym_get_range_val(prop->expr->right.sym, 10);
 	case S_HEX:
 		if (!sym_string_valid(sym, str))
 			return false;
@@ -487,8 +537,8 @@ bool sym_string_within_range(struct symb
 		if (!prop)
 			return true;
 		val = strtol(str, NULL, 16);
-		return val >= strtol(prop->expr->left.sym->name, NULL, 16) &&
-		       val <= strtol(prop->expr->right.sym->name, NULL, 16);
+		return val >= sym_get_range_val(prop->expr->left.sym, 16) &&
+		       val <= sym_get_range_val(prop->expr->right.sym, 16);
 	case S_BOOLEAN:
 	case S_TRISTATE:
 		switch (str[0]) {
