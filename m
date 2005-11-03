Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVKCPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVKCPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVKCPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:11:58 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31177 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030266AbVKCPLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:11:53 -0500
Date: Thu, 3 Nov 2005 16:11:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] kconfig: stricter error checking for .config
Message-ID: <Pine.LNX.4.61.0511031611380.2544@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some more checks during the parsing of .config, so that after parsing 
sym_change_count reflects the correct state whether the .config is correct 
and in sync with the Kconfig or if it needs saving.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/confdata.c |   95 ++++++++++++++++++++++++++++++++++++---------
 scripts/kconfig/lkc.h      |    1 
 2 files changed, 77 insertions(+), 19 deletions(-)

Index: linux-2.6/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/confdata.c	2005-11-03 13:23:06.000000000 +0100
+++ linux-2.6/scripts/kconfig/confdata.c	2005-11-03 13:23:16.000000000 +0100
@@ -14,6 +14,12 @@
 #define LKC_DIRECT_LINK
 #include "lkc.h"
 
+static void conf_warning(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+static const char *conf_filename;
+static int conf_lineno, conf_warnings, conf_unsaved;
+
 const char conf_def_filename[] = ".config";
 
 const char conf_defname[] = "arch/$ARCH/defconfig";
@@ -27,6 +33,17 @@ const char *conf_confnames[] = {
 	NULL,
 };
 
+static void conf_warning(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d:warning: ", conf_filename, conf_lineno);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+	conf_warnings++;
+}
+
 static char *conf_expand_value(const char *in)
 {
 	struct symbol *sym;
@@ -74,7 +91,6 @@ int conf_read_simple(const char *name)
 	FILE *in = NULL;
 	char line[1024];
 	char *p, *p2;
-	int lineno = 0;
 	struct symbol *sym;
 	int i;
 
@@ -93,12 +109,18 @@ int conf_read_simple(const char *name)
 			}
 		}
 	}
-
 	if (!in)
 		return 1;
 
+	conf_filename = name;
+	conf_lineno = 0;
+	conf_warnings = 0;
+	conf_unsaved = 0;
+
 	for_all_symbols(i, sym) {
 		sym->flags |= SYMBOL_NEW | SYMBOL_CHANGED;
+		if (sym_is_choice(sym))
+			sym->flags &= ~SYMBOL_NEW;
 		sym->flags &= ~SYMBOL_VALID;
 		switch (sym->type) {
 		case S_INT:
@@ -113,7 +135,7 @@ int conf_read_simple(const char *name)
 	}
 
 	while (fgets(line, sizeof(line), in)) {
-		lineno++;
+		conf_lineno++;
 		sym = NULL;
 		switch (line[0]) {
 		case '#':
@@ -127,7 +149,10 @@ int conf_read_simple(const char *name)
 				continue;
 			sym = sym_find(line + 9);
 			if (!sym) {
-				fprintf(stderr, "%s:%d: trying to assign nonexistent symbol %s\n", name, lineno, line + 9);
+				conf_warning("trying to assign nonexistent symbol %s", line + 9);
+				break;
+			} else if (!(sym->flags & SYMBOL_NEW)) {
+				conf_warning("trying to reassign symbol %s", sym->name);
 				break;
 			}
 			switch (sym->type) {
@@ -141,8 +166,10 @@ int conf_read_simple(const char *name)
 			}
 			break;
 		case 'C':
-			if (memcmp(line, "CONFIG_", 7))
+			if (memcmp(line, "CONFIG_", 7)) {
+				conf_warning("unexpected data");
 				continue;
+			}
 			p = strchr(line + 7, '=');
 			if (!p)
 				continue;
@@ -152,7 +179,10 @@ int conf_read_simple(const char *name)
 				*p2 = 0;
 			sym = sym_find(line + 7);
 			if (!sym) {
-				fprintf(stderr, "%s:%d: trying to assign nonexistent symbol %s\n", name, lineno, line + 7);
+				conf_warning("trying to assign nonexistent symbol %s", line + 7);
+				break;
+			} else if (!(sym->flags & SYMBOL_NEW)) {
+				conf_warning("trying to reassign symbol %s", sym->name);
 				break;
 			}
 			switch (sym->type) {
@@ -173,6 +203,7 @@ int conf_read_simple(const char *name)
 					sym->flags &= ~SYMBOL_NEW;
 					break;
 				}
+				conf_warning("symbol value '%s' invalid for %s", p, sym->name);
 				break;
 			case S_STRING:
 				if (*p++ != '"')
@@ -185,8 +216,8 @@ int conf_read_simple(const char *name)
 					memmove(p2, p2 + 1, strlen(p2));
 				}
 				if (!p2) {
-					fprintf(stderr, "%s:%d: invalid string found\n", name, lineno);
-					exit(1);
+					conf_warning("invalid string found");
+					continue;
 				}
 			case S_INT:
 			case S_HEX:
@@ -194,8 +225,8 @@ int conf_read_simple(const char *name)
 					sym->user.val = strdup(p);
 					sym->flags &= ~SYMBOL_NEW;
 				} else {
-					fprintf(stderr, "%s:%d: symbol value '%s' invalid for %s\n", name, lineno, p, sym->name);
-					exit(1);
+					conf_warning("symbol value '%s' invalid for %s", p, sym->name);
+					continue;
 				}
 				break;
 			default:
@@ -205,6 +236,7 @@ int conf_read_simple(const char *name)
 		case '\n':
 			break;
 		default:
+			conf_warning("unexpected data");
 			continue;
 		}
 		if (sym && sym_is_choice_value(sym)) {
@@ -213,17 +245,20 @@ int conf_read_simple(const char *name)
 			case no:
 				break;
 			case mod:
-				if (cs->user.tri == yes)
-					/* warn? */;
+				if (cs->user.tri == yes) {
+					conf_warning("%s creates inconsistent choice state", sym->name);
+					cs->flags |= SYMBOL_NEW;
+				}
 				break;
 			case yes:
-				if (cs->user.tri != no)
-					/* warn? */;
-				cs->user.val = sym;
+				if (cs->user.tri != no) {
+					conf_warning("%s creates inconsistent choice state", sym->name);
+					cs->flags |= SYMBOL_NEW;
+				} else
+					cs->user.val = sym;
 				break;
 			}
 			cs->user.tri = E_OR(cs->user.tri, sym->user.tri);
-			cs->flags &= ~SYMBOL_NEW;
 		}
 	}
 	fclose(in);
@@ -245,6 +280,28 @@ int conf_read(const char *name)
 
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
+		if (sym_is_choice(sym) || (sym->flags & SYMBOL_AUTO))
+			goto sym_ok;
+		if (sym_has_value(sym) && (sym->flags & SYMBOL_WRITE)) {
+			/* check that calculated value agrees with saved value */
+			switch (sym->type) {
+			case S_BOOLEAN:
+			case S_TRISTATE:
+				if (sym->user.tri != sym_get_tristate_value(sym))
+					break;
+				if (!sym_is_choice(sym))
+					goto sym_ok;
+			default:
+				if (!strcmp(sym->curr.val, sym->user.val))
+					goto sym_ok;
+				break;
+			}
+		} else if (!sym_has_value(sym) && !(sym->flags & SYMBOL_WRITE))
+			/* no previous value and not saved */
+			goto sym_ok;
+		conf_unsaved++;
+		/* maybe print value in verbose mode... */
+	sym_ok:
 		if (sym_has_value(sym) && !sym_is_choice_value(sym)) {
 			if (sym->visible == no)
 				sym->flags |= SYMBOL_NEW;
@@ -252,8 +309,10 @@ int conf_read(const char *name)
 			case S_STRING:
 			case S_INT:
 			case S_HEX:
-				if (!sym_string_within_range(sym, sym->user.val))
+				if (!sym_string_within_range(sym, sym->user.val)) {
 					sym->flags |= SYMBOL_NEW;
+					sym->flags &= ~SYMBOL_VALID;
+				}
 			default:
 				break;
 			}
@@ -266,7 +325,7 @@ int conf_read(const char *name)
 				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
 	}
 
-	sym_change_count = 1;
+	sym_change_count = conf_warnings && conf_unsaved;
 
 	return 0;
 }
Index: linux-2.6/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6.orig/scripts/kconfig/lkc.h	2005-11-03 13:23:15.000000000 +0100
+++ linux-2.6/scripts/kconfig/lkc.h	2005-11-03 13:23:16.000000000 +0100
@@ -55,7 +55,6 @@ char *zconf_curname(void);
 
 /* confdata.c */
 extern const char conf_def_filename[];
-extern char conf_filename[];
 
 char *conf_get_default_confname(void);
 
