Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVACBGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVACBGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVACBGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:06:45 -0500
Received: from dialin-145-254-060-068.arcor-ip.net ([145.254.60.68]:11274 "EHLO
	spit.home") by vger.kernel.org with ESMTP id S261305AbVACBFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:05:34 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kconfig:
Date: Mon, 3 Jan 2005 01:34:36 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org>
In-Reply-To: <20041230235146.GA9450@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dMJ2BrGhbFz89/G"
Message-Id: <200501030134.37810.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dMJ2BrGhbFz89/G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday 31 December 2004 00:51, Sam Ravnborg wrote:

> Here follows a few kconfig patches.
> Main purpose is to improve readability of the output when doing  search
> and to inculde dependency information in the help text.

I completely missed that the search patch was already merged... :-(
It wasn't ready yet, it was still a quick hack. I attached a patch which does 
the basic cleanup, so that it not only works for the trivial cases.

bye, Roman

--Boundary-00=_dMJ2BrGhbFz89/G
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="search_cleanup"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="search_cleanup"

 kconfig/lkc_proto.h |    1 
 kconfig/mconf.c     |  202 +++++++++++++++++++++-------------------------------
 kconfig/symbol.c    |   35 +++++++++
 lxdialog/menubox.c  |   11 --
 4 files changed, 123 insertions(+), 126 deletions(-)

Index: linux-2.6.10/scripts/lxdialog/menubox.c
===================================================================
--- linux-2.6.10.orig/scripts/lxdialog/menubox.c	2005-01-02 23:24:41.000000000 +0100
+++ linux-2.6.10/scripts/lxdialog/menubox.c	2005-01-03 00:26:53.000000000 +0100
@@ -276,15 +276,6 @@ dialog_menu (const char *title, const ch
 
     while (key != ESC) {
 	key = wgetch(menu);
-	if ( key == '/' ) {
-		int ret = dialog_inputbox("Search Configuration Parameter",
-					"Enter Keyword", height, width,
-					(char *) NULL);
-		if (ret == 0) {
-			fprintf(stderr, "%s", dialog_input_result);
-			return 26;
-		}
-	}
 
 	if (key < 256 && isalpha(key)) key = tolower(key);
 
@@ -408,6 +399,7 @@ dialog_menu (const char *title, const ch
 	case 'y':
 	case 'n':
 	case 'm':
+	case '/':
 	    /* save scroll info */
 	    if ( (f=fopen("lxdialog.scrltmp","w")) != NULL ) {
 		fprintf(f,"%d\n",scroll);
@@ -421,6 +413,7 @@ dialog_menu (const char *title, const ch
             case 'n': return 4;
             case 'm': return 5;
             case ' ': return 6;
+            case '/': return 7;
             }
 	    return 0;
 	case 'h':
Index: linux-2.6.10/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6.10.orig/scripts/kconfig/symbol.c	2005-01-02 23:24:41.000000000 +0100
+++ linux-2.6.10/scripts/kconfig/symbol.c	2005-01-03 00:26:53.000000000 +0100
@@ -6,6 +6,7 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
+#include <regex.h>
 #include <sys/utsname.h>
 
 #define LKC_DIRECT_LINK
@@ -656,6 +657,40 @@ struct symbol *sym_find(const char *name
 	return symbol;
 }
 
+struct symbol **sym_re_search(const char *pattern, int flags)
+{
+	struct symbol *sym, **sym_arr = NULL;
+	int i, cnt, size;
+	regex_t re;
+
+	cnt = size = 0;
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB|REG_ICASE))
+		return NULL;
+
+	for_all_symbols(i, sym) {       
+		if (sym->flags & SYMBOL_CONST || !sym->name) 
+			continue;
+		if (regexec(&re, sym->name, 0, NULL, 0))
+			continue;
+		if (cnt + 1 >= size) {
+			void *tmp = sym_arr;
+			size += 16;
+			sym_arr = realloc(sym_arr, size * sizeof(struct symbol *));
+			if (!sym_arr) {
+				free(tmp);
+				return NULL;
+			}
+		}
+		sym_arr[cnt++] = sym;
+	}
+	if (sym_arr)
+		sym_arr[cnt] = NULL;
+	regfree(&re);
+
+	return sym_arr;
+}
+
+
 struct symbol *sym_check_deps(struct symbol *sym);
 
 static struct symbol *sym_check_expr_deps(struct expr *e)
Index: linux-2.6.10/scripts/kconfig/mconf.c
===================================================================
--- linux-2.6.10.orig/scripts/kconfig/mconf.c	2005-01-02 23:24:41.000000000 +0100
+++ linux-2.6.10/scripts/kconfig/mconf.c	2005-01-03 00:27:03.000000000 +0100
@@ -18,7 +18,6 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
-#include <regex.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"
@@ -104,9 +103,7 @@ static void show_helptext(const char *ti
 static void show_help(struct menu *menu);
 static void show_readme(void);
 static void show_file(const char *filename, const char *title, int r, int c);
-static void show_expr(struct menu *menu, FILE *fp);
-static void search_conf(char *pattern);
-static int regex_match(const char *string, regex_t *re);
+static void search_conf(void);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -279,111 +276,96 @@ static int exec_conf(void)
 	return WEXITSTATUS(stat);
 }
 
-static int regex_match(const char *string, regex_t *re)
+static void search_conf(void)
 {
-	int rc;
-
-	rc = regexec(re, string, (size_t) 0, NULL, 0);
-	if (rc)
-		return 0;
-	return 1;
-}
-
-static void show_expr(struct menu *menu, FILE *fp)
-{
-	bool hit = false;
-	fprintf(fp, "Depends:\n ");
-	if (menu->prompt->visible.expr) {
-		if (!hit)
-			hit = true;
-		expr_fprint(menu->prompt->visible.expr, fp);
-	}
-	if (!hit)
-		fprintf(fp, "None");
-	if (menu->sym) {
-		struct property *prop;
-		hit = false;
-		fprintf(fp, "\nSelects:\n ");
-		for_all_properties(menu->sym, prop, P_SELECT) {
-			if (!hit)
-				hit = true;
-			expr_fprint(prop->expr, fp);
-		}
-		if (!hit)
-			fprintf(fp, "None");
-		hit = false;
-		fprintf(fp, "\nSelected by:\n ");
-		if (menu->sym->rev_dep.expr) {
-			hit = true;
-			expr_fprint(menu->sym->rev_dep.expr, fp);
-		}
-		if (!hit)
-			fprintf(fp, "None");
-	}
-}
-
-static void search_conf(char *pattern)
-{
-	struct symbol *sym = NULL;
-	struct menu *menu[32] = { 0 };
-	struct property *prop = NULL;
-	FILE *fp = NULL;
-	bool hit = false;
-	int i, j, k, l;
-	regex_t re;
-
-	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
+	struct symbol *sym, **sym_arr;
+	struct menu *submenu[8], *menu;
+	struct property *prop;
+	FILE *fp;
+	bool hit;
+	int i, j, k, stat;
+
+again:
+	cprint_init();
+	cprint("--title");
+	cprint("Search Configuration Parameter");
+	cprint("--inputbox");
+	cprint("Enter Keyword");
+	cprint("10");
+	cprint("75");
+	cprint("");
+	stat = exec_conf();
+	if (stat < 0)
+		goto again;
+	switch (stat) {
+	case 0:
+		break;
+	case 1:
+		show_helptext("Search Configuration", "to be filled in...");
+		goto again;
+	default:
 		return;
-
+	}
 	fp = fopen(".search.tmp", "w");
 	if (fp == NULL) {
 		perror("fopen");
 		return;
 	}
-	for_all_symbols(i, sym) {
-		if (!sym->name)
-			continue;
-		if (!regex_match(sym->name, &re))
-			continue;
+
+	sym_arr = sym_re_search(input_buf, 0);
+	for (i = 0; sym_arr && (sym = sym_arr[i]); i++) {
+		fprintf(fp, "Symbol: %s\n", sym->name);
 		for_all_prompts(sym, prop) {
-			struct menu *submenu = prop->menu;
-			if (!submenu)
-				continue;
-			j = 0;
-			hit = false;
-			while (submenu) {
-				menu[j++] = submenu;
-				submenu = submenu->parent;
-			}
+			fprintf(fp, "Prompt: %s\n", prop->text);
+			fprintf(fp, "  Defined at %s:%d\n", prop->menu->file->name,
+				prop->menu->lineno);
+			if (!expr_is_yes(prop->visible.expr)) {
+				fprintf(fp, "  Depends on: ");
+				expr_fprint(prop->visible.expr, fp);
+				fprintf(fp, "\n");
+			}
+			menu = prop->menu->parent;
+			for (j = 0; menu != &rootmenu && j < 8; menu = menu->parent)
+				submenu[j++] = menu;
 			if (j > 0) {
-				if (!hit)
-					hit = true;
-				fprintf(fp, "%s (%s)\n", prop->text, sym->name);
-				fprintf(fp, "Location:\n");
-			}
-			for (k = j-2, l=1; k > 0; k--, l++) {
-				const char *prompt = menu_get_prompt(menu[k]);
-				if (menu[k]->sym)
-					fprintf(fp, "%*c-> %s (%s)\n",
-								l, ' ',
-								prompt,
-								menu[k]->sym->name);
-				else
-					fprintf(fp, "%*c-> %s\n",
-								l, ' ',
-								prompt);
-			}
-			if (hit) {
-				show_expr(menu[0], fp);
-				fprintf(fp, "\n\n\n");
+				fprintf(fp, "  Location:\n");
+				for (k = 4; --j >= 0; k += 2) {
+					menu = submenu[j];
+					fprintf(fp, "%*c-> %s", k, ' ', menu_get_prompt(menu));
+					if (menu->sym) {
+						fprintf(fp, " (%s:[%s])", menu->sym->name ?
+							menu->sym->name : "<choice>",
+							sym_get_string_value(menu->sym));
+						
+					}
+					fprintf(fp, "\n");
+				}
 			}
 		}
+		hit = false;
+		for_all_properties(sym, prop, P_SELECT) {
+			if (!hit) {
+				fprintf(fp, "  Selects: ");
+				hit = true;
+			} else
+				fprintf(fp, " && ");
+			expr_fprint(prop->expr, fp);
+		}
+		if (hit)
+			fprintf(fp, "\n");
+		if (sym->rev_dep.expr) {
+			fprintf(fp, "  Selected by: ");
+			expr_fprint(sym->rev_dep.expr, fp);
+			fprintf(fp, "\n");
+		}
+		fprintf(fp, "\n\n");
 	}
-	if (!hit)
-		fprintf(fp, "No matches found.");
-	regfree(&re);
+	if (!i)
+		fprintf(fp, "No matches found.\n");
+
+	free(sym_arr);
 	fclose(fp);
-	show_file(".search.tmp", "Search Results", rows, cols);
+	show_file(".search.tmp", "Search Results", 0, 0);
 	unlink(".search.tmp");
 }
 
@@ -576,23 +558,6 @@ static void conf(struct menu *menu)
 			cprint("    Save Configuration to an Alternate File");
 		}
 		stat = exec_conf();
-		if (stat == 26) {
-			char *pattern;
-
-			if (!strlen(input_buf))
-				continue;
-			pattern = malloc(sizeof(char)*sizeof(input_buf));
-			if (pattern == NULL) {
-				perror("malloc");
-				continue;
-			}
-			for (i = 0; input_buf[i]; i++)
-				pattern[i] = toupper(input_buf[i]);
-			pattern[i] = '\0';
-			search_conf(pattern);
-			free(pattern);
-			continue;
-		}
 		if (stat < 0)
 			continue;
 
@@ -669,6 +634,9 @@ static void conf(struct menu *menu)
 			else if (type == 'm')
 				conf(submenu);
 			break;
+		case 7:
+			search_conf();
+			break;
 		}
 	}
 }
@@ -686,7 +654,7 @@ static void show_textbox(const char *tit
 
 static void show_helptext(const char *title, const char *text)
 {
-	show_textbox(title, text, rows, cols);
+	show_textbox(title, text, 0, 0);
 }
 
 static void show_help(struct menu *menu)
@@ -709,7 +677,7 @@ static void show_help(struct menu *menu)
 
 static void show_readme(void)
 {
-	show_file("scripts/README.Menuconfig", NULL, rows, cols);
+	show_file("scripts/README.Menuconfig", NULL, 0, 0);
 }
 
 static void show_file(const char *filename, const char *title, int r, int c)
@@ -722,8 +690,8 @@ static void show_file(const char *filena
 		}
 		cprint("--textbox");
 		cprint("%s", filename);
-		cprint("%d", r);
-		cprint("%d", c);
+		cprint("%d", r ? r : rows);
+		cprint("%d", c ? c : cols);
 	} while (exec_conf() < 0);
 }
 
Index: linux-2.6.10/scripts/kconfig/lkc_proto.h
===================================================================
--- linux-2.6.10.orig/scripts/kconfig/lkc_proto.h	2005-01-02 23:24:41.000000000 +0100
+++ linux-2.6.10/scripts/kconfig/lkc_proto.h	2005-01-03 00:26:53.000000000 +0100
@@ -18,6 +18,7 @@ P(sym_change_count,int,);
 
 P(sym_lookup,struct symbol *,(const char *name, int isconst));
 P(sym_find,struct symbol *,(const char *name));
+P(sym_re_search,struct symbol **,(const char *pattern, int flags));
 P(sym_type_name,const char *,(enum symbol_type type));
 P(sym_calc_value,void,(struct symbol *sym));
 P(sym_get_type,enum symbol_type,(struct symbol *sym));

--Boundary-00=_dMJ2BrGhbFz89/G--
