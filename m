Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWDIPa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDIPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDIPaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:30:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36522 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750789AbWDIPaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:30:01 -0400
Date: Sun, 9 Apr 2006 17:29:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 16/19] kconfig: create links in info window
Message-ID: <Pine.LNX.4.64.0604091729540.23167@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extend the expression print helper function to allow customization of
the symbol output and use it to add links to the info window.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/expr.c      |   50 +++++++++++++++++++-------------------
 scripts/kconfig/lkc_proto.h |    2 -
 scripts/kconfig/qconf.cc    |   57 ++++++++++++++++++++++++++++++++++++++++----
 scripts/kconfig/qconf.h     |    4 ++-
 4 files changed, 81 insertions(+), 32 deletions(-)

Index: linux-2.6-git/scripts/kconfig/expr.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.c
+++ linux-2.6-git/scripts/kconfig/expr.c
@@ -1013,73 +1013,73 @@ int expr_compare_type(enum expr_type t1,
 #endif
 }
 
-void expr_print(struct expr *e, void (*fn)(void *, const char *), void *data, int prevtoken)
+void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken)
 {
 	if (!e) {
-		fn(data, "y");
+		fn(data, NULL, "y");
 		return;
 	}
 
 	if (expr_compare_type(prevtoken, e->type) > 0)
-		fn(data, "(");
+		fn(data, NULL, "(");
 	switch (e->type) {
 	case E_SYMBOL:
 		if (e->left.sym->name)
-			fn(data, e->left.sym->name);
+			fn(data, e->left.sym, e->left.sym->name);
 		else
-			fn(data, "<choice>");
+			fn(data, NULL, "<choice>");
 		break;
 	case E_NOT:
-		fn(data, "!");
+		fn(data, NULL, "!");
 		expr_print(e->left.expr, fn, data, E_NOT);
 		break;
 	case E_EQUAL:
-		fn(data, e->left.sym->name);
-		fn(data, "=");
-		fn(data, e->right.sym->name);
+		fn(data, e->left.sym, e->left.sym->name);
+		fn(data, NULL, "=");
+		fn(data, e->right.sym, e->right.sym->name);
 		break;
 	case E_UNEQUAL:
-		fn(data, e->left.sym->name);
-		fn(data, "!=");
-		fn(data, e->right.sym->name);
+		fn(data, e->left.sym, e->left.sym->name);
+		fn(data, NULL, "!=");
+		fn(data, e->right.sym, e->right.sym->name);
 		break;
 	case E_OR:
 		expr_print(e->left.expr, fn, data, E_OR);
-		fn(data, " || ");
+		fn(data, NULL, " || ");
 		expr_print(e->right.expr, fn, data, E_OR);
 		break;
 	case E_AND:
 		expr_print(e->left.expr, fn, data, E_AND);
-		fn(data, " && ");
+		fn(data, NULL, " && ");
 		expr_print(e->right.expr, fn, data, E_AND);
 		break;
 	case E_CHOICE:
-		fn(data, e->right.sym->name);
+		fn(data, e->right.sym, e->right.sym->name);
 		if (e->left.expr) {
-			fn(data, " ^ ");
+			fn(data, NULL, " ^ ");
 			expr_print(e->left.expr, fn, data, E_CHOICE);
 		}
 		break;
 	case E_RANGE:
-		fn(data, "[");
-		fn(data, e->left.sym->name);
-		fn(data, " ");
-		fn(data, e->right.sym->name);
-		fn(data, "]");
+		fn(data, NULL, "[");
+		fn(data, e->left.sym, e->left.sym->name);
+		fn(data, NULL, " ");
+		fn(data, e->right.sym, e->right.sym->name);
+		fn(data, NULL, "]");
 		break;
 	default:
 	  {
 		char buf[32];
 		sprintf(buf, "<unknown type %d>", e->type);
-		fn(data, buf);
+		fn(data, NULL, buf);
 		break;
 	  }
 	}
 	if (expr_compare_type(prevtoken, e->type) > 0)
-		fn(data, ")");
+		fn(data, NULL, ")");
 }
 
-static void expr_print_file_helper(void *data, const char *str)
+static void expr_print_file_helper(void *data, struct symbol *sym, const char *str)
 {
 	fwrite(str, strlen(str), 1, data);
 }
@@ -1089,7 +1089,7 @@ void expr_fprint(struct expr *e, FILE *o
 	expr_print(e, expr_print_file_helper, out, E_NONE);
 }
 
-static void expr_print_gstr_helper(void *data, const char *str)
+static void expr_print_gstr_helper(void *data, struct symbol *sym, const char *str)
 {
 	str_append((struct gstr*)data, str);
 }
Index: linux-2.6-git/scripts/kconfig/lkc_proto.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc_proto.h
+++ linux-2.6-git/scripts/kconfig/lkc_proto.h
@@ -39,4 +39,4 @@ P(prop_get_type_name,const char *,(enum 
 
 /* expr.c */
 P(expr_compare_type,int,(enum expr_type t1, enum expr_type t2));
-P(expr_print,void,(struct expr *e, void (*fn)(void *, const char *), void *data, int prevtoken));
+P(expr_print,void,(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken));
Index: linux-2.6-git/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.cc
+++ linux-2.6-git/scripts/kconfig/qconf.cc
@@ -925,6 +925,8 @@ void ConfigInfoView::setShowDebug(bool b
 		_showDebug = b;
 		if (menu)
 			menuInfo();
+		else if (sym)
+			symbolInfo();
 		emit showDebugChanged(b);
 	}
 }
@@ -943,15 +945,44 @@ void ConfigInfoView::setSource(const QSt
 	const char *p = name.latin1();
 
 	menu = NULL;
+	sym = NULL;
 
 	switch (p[0]) {
 	case 'm':
-		if (sscanf(p, "m%p", &menu) == 1)
+		struct menu *m;
+
+		if (sscanf(p, "m%p", &m) == 1 && menu != m) {
+			menu = m;
 			menuInfo();
+		}
+		break;
+	case 's':
+		struct symbol *s;
+
+		if (sscanf(p, "s%p", &s) == 1 && sym != s) {
+			sym = s;
+			symbolInfo();
+		}
 		break;
 	}
 }
 
+void ConfigInfoView::symbolInfo(void)
+{
+	QString str;
+
+	str += "<big>Symbol: <b>";
+	str += print_filter(sym->name);
+	str += "</b></big><br><br>value: ";
+	str += print_filter(sym_get_string_value(sym));
+	str += "<br>visibility: ";
+	str += sym->visible == yes ? "y" : sym->visible == mod ? "m" : "n";
+	str += "<br>";
+	str += debug_info(sym);
+
+	setText(str);
+}
+
 void ConfigInfoView::menuInfo(void)
 {
 	struct symbol* sym;
@@ -965,12 +996,20 @@ void ConfigInfoView::menuInfo(void)
 			head += "</b></big>";
 			if (sym->name) {
 				head += " (";
+				if (showDebug())
+					head += QString().sprintf("<a href=\"s%p\">", sym);
 				head += print_filter(sym->name);
+				if (showDebug())
+					head += "</a>";
 				head += ")";
 			}
 		} else if (sym->name) {
 			head += "<big><b>";
+			if (showDebug())
+				head += QString().sprintf("<a href=\"s%p\">", sym);
 			head += print_filter(sym->name);
+			if (showDebug())
+				head += "</a>";
 			head += "</b></big>";
 		}
 		head += "<br><br>";
@@ -1015,9 +1054,9 @@ QString ConfigInfoView::debug_info(struc
 		switch (prop->type) {
 		case P_PROMPT:
 		case P_MENU:
-			debug += "prompt: ";
+			debug += QString().sprintf("prompt: <a href=\"m%p\">", prop->menu);
 			debug += print_filter(_(prop->text));
-			debug += "<br>";
+			debug += "</a><br>";
 			break;
 		case P_DEFAULT:
 			debug += "default: ";
@@ -1088,9 +1127,17 @@ QString ConfigInfoView::print_filter(con
 	return res;
 }
 
-void ConfigInfoView::expr_print_help(void *data, const char *str)
+void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char *str)
 {
-	reinterpret_cast<QString*>(data)->append(print_filter(str));
+	QString* text = reinterpret_cast<QString*>(data);
+	QString str2 = print_filter(str);
+
+	if (sym && sym->name && !(sym->flags & SYMBOL_CONST)) {
+		*text += QString().sprintf("<a href=\"s%p\">", sym);
+		*text += str2;
+		*text += "</a>";
+	} else
+		*text += str2;
 }
 
 QPopupMenu* ConfigInfoView::createPopupMenu(const QPoint& pos)
Index: linux-2.6-git/scripts/kconfig/qconf.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/qconf.h
+++ linux-2.6-git/scripts/kconfig/qconf.h
@@ -260,13 +260,15 @@ signals:
 	void showDebugChanged(bool);
 
 protected:
+	void symbolInfo(void);
 	void menuInfo(void);
 	QString debug_info(struct symbol *sym);
 	static QString print_filter(const QString &str);
-	static void expr_print_help(void *data, const char *str);
+	static void expr_print_help(void *data, struct symbol *sym, const char *str);
 	QPopupMenu* createPopupMenu(const QPoint& pos);
 	void contentsContextMenuEvent(QContextMenuEvent *e);
 
+	struct symbol *sym;
 	struct menu *menu;
 	bool _showDebug;
 };
