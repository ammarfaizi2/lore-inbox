Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUINMVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUINMVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269337AbUINMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:20:29 -0400
Received: from [212.29.248.34] ([212.29.248.34]:19533 "EHLO localhost")
	by vger.kernel.org with ESMTP id S269365AbUINMRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:17:13 -0400
Date: Tue, 14 Sep 2004 15:14:01 +0300
To: zippel@linux-m68k.org, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
Message-ID: <20040914121401.GA13531@aduva.com>
Reply-To: yuvalt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Yuval Turgeman <yuval@aduva.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 13:45:27 +0200 (CEST), Roman Zippel <zippel@linux-m68k.org> wrote:

> Yes, thanks.

Ok then,
Here's a complete patch of the changes against 2.6.8.1.

diff -uprN linux-2.6.8.1/scripts/kconfig/mconf.c linux-2.6.9-rc1-mm5/scripts/kconfig/mconf.c
--- linux-2.6.8.1/scripts/kconfig/mconf.c	2004-08-14 13:54:51.000000000 +0300
+++ linux-2.6.9-rc1-mm5/scripts/kconfig/mconf.c	2004-09-14 15:00:21.000000000 +0300
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
+#include <regex.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"
@@ -28,7 +29,7 @@ static const char menu_instructions[] =
 	"<Enter> selects submenus --->.  "
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
-	"Press <Esc><Esc> to exit, <?> for Help.  "
+	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
 	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
 radiolist_instructions[] =
 	"Use the arrow keys to navigate this window or "
@@ -88,7 +89,7 @@ static char *args[1024], **argptr = args
 static int indent;
 static struct termios ios_org;
 static int rows = 0, cols = 0;
-static struct menu *current_menu;
+struct menu *current_menu;
 static int child_count;
 static int do_resize;
 static int single_menu_mode;
@@ -102,6 +103,10 @@ static void show_textbox(const char *tit
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
 static void show_readme(void);
+static void show_file(const char *filename, const char *title, int r, int c);
+static void show_expr(struct menu *menu, FILE *fp);
+static void search_conf(char *pattern);
+static int regex_match(const char *string, regex_t *re);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -274,6 +279,114 @@ static int exec_conf(void)
 	return WEXITSTATUS(stat);
 }
 
+static int regex_match(const char *string, regex_t *re)
+{
+	int rc;
+
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
+	}
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
+	}
+}
+
+static void search_conf(char *pattern)
+{
+	struct symbol *sym = NULL;
+	struct menu *menu[32] = { 0 };
+	struct property *prop = NULL;
+	FILE *fp = NULL;
+	bool hit = false;
+	int i, j, k, l;
+	regex_t re;
+
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
+		return;
+
+	fp = fopen(".search.tmp", "w");
+	if (fp == NULL) {
+		perror("fopen");
+		return;
+	}
+	for_all_symbols(i, sym) {
+		if (!sym->name)
+			continue;
+		if (!regex_match(sym->name, &re))
+			continue;
+		for_all_prompts(sym, prop) {
+			struct menu *submenu = prop->menu;
+			if (!submenu)
+				continue;
+			j = 0;
+			hit = false;
+			while (submenu) {
+				menu[j++] = submenu;
+				submenu = submenu->parent;
+			}
+			if (j > 0) {
+				if (!hit)
+					hit = true;
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
+				else
+					fprintf(fp, "%*c-> %s\n",
+								l, ' ',
+								prompt);
+			}
+			if (hit) {
+				show_expr(menu[0], fp);
+				fprintf(fp, "\n\n\n");
+			}
+		}
+	}
+	if (!hit)
+		fprintf(fp, "No matches found.");
+	regfree(&re);
+	fclose(fp);
+	show_file(".search.tmp", "Search Results", rows, cols);
+	unlink(".search.tmp");
+}
+
 static void build_conf(struct menu *menu)
 {
 	struct symbol *sym;
@@ -463,6 +576,23 @@ static void conf(struct menu *menu)
 			cprint("    Save Configuration to an Alternate File");
 		}
 		stat = exec_conf();
+		if (stat == 26) {
+			char *pattern;
+
+			if (!strlen(input_buf))
+				continue;
+			pattern = malloc(sizeof(char)*sizeof(input_buf));
+			if (pattern == NULL) {
+				perror("malloc");
+				continue;
+			}
+			for (i = 0; input_buf[i]; i++)
+				pattern[i] = toupper(input_buf[i]);
+			pattern[i] = '\0';
+			search_conf(pattern);
+			free(pattern);
+			continue;
+		}
 		if (stat < 0)
 			continue;
 
@@ -550,17 +680,7 @@ static void show_textbox(const char *tit
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
 
@@ -589,13 +709,22 @@ static void show_help(struct menu *menu)
 
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
diff -uprN linux-2.6.8.1/scripts/lxdialog/menubox.c linux-2.6.9-rc1-mm5/scripts/lxdialog/menubox.c
--- linux-2.6.8.1/scripts/lxdialog/menubox.c	2004-08-14 13:56:22.000000000 +0300
+++ linux-2.6.9-rc1-mm5/scripts/lxdialog/menubox.c	2004-09-14 15:00:21.000000000 +0300
@@ -276,6 +276,15 @@ dialog_menu (const char *title, const ch
 
     while (key != ESC) {
 	key = wgetch(menu);
+	if ( key == '/' ) {
+		int ret = dialog_inputbox("Search Configuration Parameter",
+					"Enter Keyword", height, width,
+					(char *) NULL);
+		if (ret == 0) {
+			fprintf(stderr, "%s", dialog_input_result);
+			return 26;
+		}
+	}
 
 	if (key < 256 && isalpha(key)) key = tolower(key);
