Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269727AbUICTIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269727AbUICTIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUICTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:08:37 -0400
Received: from [212.29.248.34] ([212.29.248.34]:58802 "EHLO localhost")
	by vger.kernel.org with ESMTP id S269727AbUICTED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:04:03 -0400
Date: Fri, 3 Sep 2004 22:00:23 +0300
To: sam@ravnborg.org, zippel@linux-m68k.org, rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Menuconfig search changes - pt. 3
Message-ID: <20040903190023.GA8898@aduva.com>
Reply-To: yuvalt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Yuval Turgeman <yuval@aduva.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes -
The search results are indented.
Added "Selects" to the search results.
The patch is finally attached as inline text... :-)
(Once again, this patch should be applied after Andrew's changes)

Signed-off-by: Yuval Turgeman <yuvalt@gmail.com>

diff -uprN linux-2.6.8.1/scripts/kconfig/mconf.c linux/scripts/kconfig/mconf.c
--- linux-2.6.8.1/scripts/kconfig/mconf.c	2004-09-02 23:36:30.000000000 +0300
+++ linux/scripts/kconfig/mconf.c	2004-09-02 23:30:58.000000000 +0300
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
+static void show_file(const char *filename, const char *title, int r, int c);
+static void show_expr(struct menu *menu, FILE *fp);
 static void search_conf(char *);
+static int regex_match(const char *, char *);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -275,33 +279,59 @@ static int exec_conf(void)
 	return WEXITSTATUS(stat);
 }
 
-static struct menu *do_search(struct menu *menu, struct symbol *sym)
+static int regex_match(const char *string, char *pattern)
 {
-	struct menu *child, *ret;
-	/* Ignore invisible menus ?
-	if (!menu_is_visible(menu))
-		return NULL;
-	*/
+	regex_t re;
+	int rc;
 
-	if (menu->sym) {
-		if (menu->sym->name && !strcmp(menu->sym->name, sym->name))
-			return menu;
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
+		return 0;
+	rc = regexec(&re, string, (size_t) 0, NULL, 0);
+	regfree(&re);
+	if (rc)
+		return 0;
+	return 1;
+}
+
+static void show_expr(struct menu *menu, FILE *fp)
+{
+	bool hit = false;
+	fprintf(fp, "Depends:\n ");
+	if (menu->dep) {
+		if (!hit)
+			hit = true;
+		expr_fprint(menu->dep, fp);
+	}
+	if (menu->sym && menu->sym->dep) {
+		if (!hit)
+			hit = true;
+		expr_fprint(menu->sym->dep, fp);
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
 	}
-	return NULL;
 }
 
 static void search_conf(char *search_str)
 {
-	struct symbol *sym;
+	struct symbol *sym = NULL;
 	struct menu *menu[32] = { 0 };
-	int i, j, k;
-	FILE *fp;
+	struct property *prop = NULL;
+	char *space = NULL;
+	FILE *fp = NULL;
 	bool hit = false;
+	int i, j, k, l;
 
 	fp = fopen(".search.tmp", "w");
 	if (fp == NULL) {
@@ -309,49 +339,59 @@ static void search_conf(char *search_str
 		return;
 	}
 	for_all_symbols(i, sym) {
-		if (sym->name && strstr(sym->name, search_str)) {
-			struct menu *submenu = do_search(&rootmenu, sym);
-
+		if (!sym->name)
+			continue;
+		if (!regex_match(sym->name, search_str))
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
+				if (!hit)
+					hit = true;
+				if (prop->text)
+					fprintf(fp, "%s (%s)\n", prop->text, 
+								sym->name);
 				else
 					fprintf(fp, "%s\n", sym->name);
+				fprintf(fp, "Location:\n");
 			}
-			for (k = j-2; k > 0; k--) {
-				if (!hit)
-					hit = true;
-				submenu = menu[k];
-				const char *prompt = menu_get_prompt(submenu);
-				if (submenu->sym)
-					fprintf(fp, " -> %s (%s)\n",
-						prompt, submenu->sym->name);
+			space = (char*)malloc(sizeof(char)*j);
+			if (space == NULL) {
+				perror("malloc");
+				continue;
+			}
+			memset(space, ' ', j);
+			for (k = j-2, l=1; k > 0; k--, l++) {
+				const char *prompt = menu_get_prompt(menu[k]);
+				space[l-1] = ' ';
+				space[l] = '\0';
+				if (menu[k]->sym)
+					fprintf(fp, "%s-> %s (%s)\n", 
+								space, prompt,
+								menu[k]->sym->name);
 				else
-					fprintf(fp, " -> %s\n", prompt);
+					fprintf(fp, "%s-> %s\n", space, 
+								prompt);
+			}
+			free(space);
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
 
@@ -554,11 +594,9 @@ static void conf(struct menu *menu)
 				perror("malloc");
 				continue;
 			}
-			/* Capitalizing the string */
 			for (i = 0; input_buf[i]; i++)
 				search_str[i] = toupper(input_buf[i]);
 			search_str[i] = '\0';
-			/* Searching and displaying all matches */
 			search_conf(search_str);
 			free(search_str);
 			continue;
@@ -650,17 +688,7 @@ static void show_textbox(const char *tit
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
 
@@ -689,13 +717,22 @@ static void show_help(struct menu *menu)
 
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
