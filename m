Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUIDRx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUIDRx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIDRx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:53:29 -0400
Received: from [212.29.248.34] ([212.29.248.34]:44442 "EHLO localhost")
	by vger.kernel.org with ESMTP id S265053AbUIDRsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:48:53 -0400
Date: Sat, 4 Sep 2004 20:45:12 +0300
To: sam@ravnborg.org, zippel@linux-m68k.org, rddunlap@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] menuconfig: regex search + dependencies
Message-ID: <20040904174512.GA13990@aduva.com>
Reply-To: yuvalt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Yuval Turgeman <yuval@aduva.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the search to go over the properties attached to a symbol (like
Roman suggessted).
Added regex support to help narrow down the searches.
Displaying the parameter's dependencies (nothing fency - simply using
expr_fprint).
Added a 'show_file' helper function.

Signed-off-by: Yuval Turgeman <yuvalt@gmail.com>

diff -uprN linux-2.6.9-rc1-mm3/scripts/kconfig/mconf.c linux/scripts/kconfig/mconf.c
--- linux-2.6.9-rc1-mm3/scripts/kconfig/mconf.c	2004-09-04 20:34:57.000000000 +0300
+++ linux/scripts/kconfig/mconf.c	2004-09-04 20:35:11.000000000 +0300
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
+#include <regex.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"
@@ -102,7 +103,10 @@ static void show_textbox(const char *tit
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
 static void show_readme(void);
-static void search_conf(char *);
+static void show_file(const char *filename, const char *title, int r, int c);
+static void show_expr(struct menu *menu, FILE *fp);
+static void search_conf(char *pattern);
+static int regex_match(const char *string, regex_t *re);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -275,33 +279,61 @@ static int exec_conf(void)
 	return WEXITSTATUS(stat);
 }
 
-static struct menu *do_search(struct menu *menu, struct symbol *sym)
+static int regex_match(const char *string, regex_t *re)
 {
-	struct menu *child, *ret;
-	/* Ignore invisible menus ?
-	if (!menu_is_visible(menu))
-		return NULL;
-	*/
+	int rc;
 
-	if (menu->sym) {
-		if (menu->sym->name && !strcmp(menu->sym->name, sym->name))
-			return menu;
+	rc = regexec(re, string, (size_t) 0, NULL, 0);
+	if (rc)
+		return 0;
+	return 1;
+}
+
+static void show_expr(struct menu *menu, FILE *fp)
+{
+	bool hit = false;
+	fprintf(fp, "Depends:\n ");
+	if (menu->prompt->visible.expr) {
+		if (!hit)
+			hit = true;
+		expr_fprint(menu->prompt->visible.expr, fp);
 	}
-	for (child = menu->list; child; child = child->next) {
-		ret = do_search(child, sym);
-		if (ret)
-			return ret;
+	if (!hit)
+		fprintf(fp, "None");
+	if (menu->sym) {
+		struct property *prop;
+		hit = false;
+		fprintf(fp, "\nSelects:\n ");
+		for_all_properties(menu->sym, prop, P_SELECT) {
+			if (!hit)
+				hit = true;
+			expr_fprint(prop->expr, fp);
+		}
+		if (!hit)
+			fprintf(fp, "None");
+		hit = false;
+		fprintf(fp, "\nSelected by:\n ");
+		if (menu->sym->rev_dep.expr) {
+			hit = true;
+			expr_fprint(menu->sym->rev_dep.expr, fp);
+		}
+		if (!hit)
+			fprintf(fp, "None");
 	}
-	return NULL;
 }
 
-static void search_conf(char *search_str)
+static void search_conf(char *pattern)
 {
-	struct symbol *sym;
+	struct symbol *sym = NULL;
 	struct menu *menu[32] = { 0 };
-	int i, j, k;
-	FILE *fp;
+	struct property *prop = NULL;
+	FILE *fp = NULL;
 	bool hit = false;
+	int i, j, k, l;
+	regex_t re;
+
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
+		return;
 
 	fp = fopen(".search.tmp", "w");
 	if (fp == NULL) {
@@ -309,51 +341,49 @@ static void search_conf(char *search_str
 		return;
 	}
 	for_all_symbols(i, sym) {
-		if (sym->name && strstr(sym->name, search_str)) {
-			struct menu *submenu = do_search(&rootmenu, sym);
-
+		if (!sym->name)
+			continue;
+		if (!regex_match(sym->name, &re))
+			continue;
+		for_all_prompts(sym, prop) {
+			struct menu *submenu = prop->menu;
+			if (!submenu)
+				continue;
 			j = 0;
+			hit = false;
 			while (submenu) {
 				menu[j++] = submenu;
 				submenu = submenu->parent;
 			}
 			if (j > 0) {
-				if (sym->prop && sym->prop->text)
-					fprintf(fp, "%s (%s)\n",
-						sym->prop->text, sym->name);
-				else
-					fprintf(fp, "%s\n", sym->name);
-			}
-			for (k = j-2; k > 0; k--) {
-				const char *prompt;
-
 				if (!hit)
 					hit = true;
-				submenu = menu[k];
-				prompt = menu_get_prompt(submenu);
-				if (submenu->sym)
-					fprintf(fp, " -> %s (%s)\n",
-						prompt, submenu->sym->name);
+				fprintf(fp, "%s (%s)\n", prop->text, sym->name);
+				fprintf(fp, "Location:\n");
+			}
+			for (k = j-2, l=1; k > 0; k--, l++) {
+				const char *prompt = menu_get_prompt(menu[k]);
+				if (menu[k]->sym)
+					fprintf(fp, "%*c-> %s (%s)\n", 
+								l, ' ',
+								prompt,
+								menu[k]->sym->name);
 				else
-					fprintf(fp, " -> %s\n", prompt);
+					fprintf(fp, "%*c-> %s\n", 
+								l, ' ', 
+								prompt);
+			}
+			if (hit) {
+				show_expr(menu[0], fp);
+				fprintf(fp, "\n\n\n");
 			}
-			if (hit)
-				fprintf(fp, "\n");
 		}
 	}
 	if (!hit)
 		fprintf(fp, "No matches found.");
+	regfree(&re);
 	fclose(fp);
-
-	do {
-		cprint_init();
-		cprint("--title");
-		cprint("Search Results");
-		cprint("--textbox");
-		cprint(".search.tmp");
-		cprint("%d", rows);
-		cprint("%d", cols);
-	} while (exec_conf() < 0);
+	show_file(".search.tmp", "Search Results", rows, cols);
 	unlink(".search.tmp");
 }
 
@@ -547,22 +577,20 @@ static void conf(struct menu *menu)
 		}
 		stat = exec_conf();
 		if (stat == 26) {
-			char *search_str;
+			char *pattern;
 
 			if (!strlen(input_buf))
 				continue;
-			search_str = malloc(sizeof(char)*sizeof(input_buf));
-			if (search_str == NULL) {
+			pattern = malloc(sizeof(char)*sizeof(input_buf));
+			if (pattern == NULL) {
 				perror("malloc");
 				continue;
 			}
-			/* Capitalizing the string */
 			for (i = 0; input_buf[i]; i++)
-				search_str[i] = toupper(input_buf[i]);
-			search_str[i] = '\0';
-			/* Searching and displaying all matches */
-			search_conf(search_str);
-			free(search_str);
+				pattern[i] = toupper(input_buf[i]);
+			pattern[i] = '\0';
+			search_conf(pattern);
+			free(pattern);
 			continue;
 		}
 		if (stat < 0)
@@ -652,17 +680,7 @@ static void show_textbox(const char *tit
 	fd = creat(".help.tmp", 0777);
 	write(fd, text, strlen(text));
 	close(fd);
-	do {
-		cprint_init();
-		if (title) {
-			cprint("--title");
-			cprint("%s", title);
-		}
-		cprint("--textbox");
-		cprint(".help.tmp");
-		cprint("%d", r);
-		cprint("%d", c);
-	} while (exec_conf() < 0);
+	show_file(".help.tmp", title, r, c);
 	unlink(".help.tmp");
 }
 
@@ -691,13 +709,22 @@ static void show_help(struct menu *menu)
 
 static void show_readme(void)
 {
+	show_file("scripts/README.Menuconfig", NULL, rows, cols);
+}
+
+static void show_file(const char *filename, const char *title, int r, int c)
+{
 	do {
 		cprint_init();
+		if (title) {
+			cprint("--title");
+			cprint("%s", title);
+		}
 		cprint("--textbox");
-		cprint("scripts/README.Menuconfig");
-		cprint("%d", rows);
-		cprint("%d", cols);
-	} while (exec_conf() == -1);
+		cprint("%s", filename);
+		cprint("%d", r);
+		cprint("%d", c);
+	} while (exec_conf() < 0);
 }
 
 static void conf_choice(struct menu *menu)
