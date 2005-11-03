Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVKCPGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVKCPGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVKCPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:06:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:26825 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030248AbVKCPGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:06:21 -0500
Date: Thu, 3 Nov 2005 16:06:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] kconfig: Fix Kconfig performance bug
Message-ID: <Pine.LNX.4.61.0511031605170.2493@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gibson <david@gibson.dropbear.id.au>

When doing its recursive dependency check, scripts/kconfig/conf uses
the flag SYMBOL_CHECK_DONE to avoid rechecking a symbol it has already
checked.  However, that flag is only set at the top level, so if a
symbol is first encountered as a dependency of another symbol it will
be rechecked every time it is encountered until it's encountered at
the top level.

This patch adjusts the flag setting so that each symbol will only be
checked once, regardless of whether it is first encountered at the top
level, or while recursing down from another symbol.  On complex
configurations, this vastly speeds up scripts/kconfig/conf.  The
config in the powerpc merge tree is particularly bad: this patch
reduces the time for 'scripts/kconfig/conf -o arch/powerpc/Kconfig' by
a factor of 40 on a G5.  That's even including the time to print the
config, so the speedup in the actual checking is more likely 2 or 3
orders of magnitude.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/expr.h              |    1 -
 scripts/kconfig/symbol.c            |   11 ++++++++---
 scripts/kconfig/zconf.tab.c_shipped |    5 +----
 scripts/kconfig/zconf.y             |    5 +----
 4 files changed, 10 insertions(+), 12 deletions(-)

Index: linux-2.6/scripts/kconfig/expr.h
===================================================================
--- linux-2.6.orig/scripts/kconfig/expr.h	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/expr.h	2005-11-03 13:10:24.000000000 +0100
@@ -93,7 +93,6 @@ struct symbol {
 #define SYMBOL_NEW		0x0800
 #define SYMBOL_AUTO		0x1000
 #define SYMBOL_CHECKED		0x2000
-#define SYMBOL_CHECK_DONE	0x4000
 #define SYMBOL_WARNED		0x8000
 
 #define SYMBOL_MAXLENGTH	256
Index: linux-2.6/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/symbol.c	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/symbol.c	2005-11-03 13:10:24.000000000 +0100
@@ -731,12 +731,12 @@ struct symbol *sym_check_deps(struct sym
 	struct symbol *sym2;
 	struct property *prop;
 
-	if (sym->flags & SYMBOL_CHECK_DONE)
-		return NULL;
 	if (sym->flags & SYMBOL_CHECK) {
 		printf("Warning! Found recursive dependency: %s", sym->name);
 		return sym;
 	}
+	if (sym->flags & SYMBOL_CHECKED)
+		return NULL;
 
 	sym->flags |= (SYMBOL_CHECK | SYMBOL_CHECKED);
 	sym2 = sym_check_expr_deps(sym->rev_dep.expr);
@@ -756,8 +756,13 @@ struct symbol *sym_check_deps(struct sym
 			goto out;
 	}
 out:
-	if (sym2)
+	if (sym2) {
 		printf(" %s", sym->name);
+		if (sym2 == sym) {
+			printf("\n");
+			sym2 = NULL;
+		}
+	}
 	sym->flags &= ~SYMBOL_CHECK;
 	return sym2;
 }
Index: linux-2.6/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:10:24.000000000 +0100
@@ -1933,10 +1933,7 @@ void conf_parse(const char *name)
 		exit(1);
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
-                if (!(sym->flags & SYMBOL_CHECKED) && sym_check_deps(sym))
-                        printf("\n");
-		else
-			sym->flags |= SYMBOL_CHECK_DONE;
+		sym_check_deps(sym);
         }
 
 	sym_change_count = 1;
Index: linux-2.6/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.y	2005-11-03 13:10:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.y	2005-11-03 13:10:24.000000000 +0100
@@ -495,10 +495,7 @@ void conf_parse(const char *name)
 		exit(1);
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
-                if (!(sym->flags & SYMBOL_CHECKED) && sym_check_deps(sym))
-                        printf("\n");
-		else
-			sym->flags |= SYMBOL_CHECK_DONE;
+		sym_check_deps(sym);
         }
 
 	sym_change_count = 1;
