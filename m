Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUHaJMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUHaJMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHaJMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:12:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:3726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267566AbUHaJKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:10:07 -0400
Date: Tue, 31 Aug 2004 02:08:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yuval Turgeman <yuvalt@gmail.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Searching parameters in menuconfig
Message-Id: <20040831020811.0c866219.akpm@osdl.org>
In-Reply-To: <9ae345c0040831005257c245da@mail.gmail.com>
References: <9ae345c0040831005257c245da@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuval Turgeman <yuvalt@gmail.com> wrote:
>
> Added support for searching parameters in make menuconfig.
>  Can be compiled with gcc-2.95 now...
>  ( If I didn't mention this before, pressing '/' invokes the search window )

Your mailer wordwrapped the patch.

I already fixed the gcc-2.95 thing.

Please make any changes relative to the below:


--- 25/scripts/kconfig/mconf.c~searching-for-parameters-in-make-menuconfig	2004-08-31 01:55:58.000000000 -0700
+++ 25-akpm/scripts/kconfig/mconf.c	2004-08-31 02:00:54.300526448 -0700
@@ -28,7 +28,7 @@ static const char menu_instructions[] =
 	"<Enter> selects submenus --->.  "
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
-	"Press <Esc><Esc> to exit, <?> for Help.  "
+	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
 	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
 radiolist_instructions[] =
 	"Use the arrow keys to navigate this window or "
@@ -102,6 +102,7 @@ static void show_textbox(const char *tit
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
 static void show_readme(void);
+static void search_conf(char *);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -274,6 +275,86 @@ static int exec_conf(void)
 	return WEXITSTATUS(stat);
 }
 
+static struct menu *do_search(struct menu *menu, struct symbol *sym)
+{
+	struct menu *child, *ret;
+	/* Ignore invisible menus ?
+	if (!menu_is_visible(menu))
+		return NULL;
+	*/
+
+	if (menu->sym) {
+		if (menu->sym->name && !strcmp(menu->sym->name, sym->name))
+			return menu;
+	}
+	for (child = menu->list; child; child = child->next) {
+		ret = do_search(child, sym);
+		if (ret)
+			return ret;
+	}
+	return NULL;
+}
+
+static void search_conf(char *search_str)
+{
+	struct symbol *sym;
+	struct menu *menu[32] = { 0 };
+	int i, j, k;
+	FILE *fp;
+	bool hit = false;
+
+	fp = fopen(".search.tmp", "w");
+	if (fp == NULL) {
+		perror("fopen");
+		return;
+	}
+	for_all_symbols(i, sym) {
+		if (sym->name && strstr(sym->name, search_str)) {
+			struct menu *submenu = do_search(&rootmenu, sym);
+
+			j = 0;
+			while (submenu) {
+				menu[j++] = submenu;
+				submenu = submenu->parent;
+			}
+			if (j > 0) {
+				if (sym->prop && sym->prop->text)
+					fprintf(fp, "%s (%s)\n",
+						sym->prop->text, sym->name);
+				else
+					fprintf(fp, "%s\n", sym->name);
+			}
+			for (k = j-2; k > 0; k--) {
+				if (!hit)
+					hit = true;
+				submenu = menu[k];
+				const char *prompt = menu_get_prompt(submenu);
+				if (submenu->sym)
+					fprintf(fp, " -> %s (%s)\n",
+						prompt, submenu->sym->name);
+				else
+					fprintf(fp, " -> %s\n", prompt);
+			}
+			if (hit)
+				fprintf(fp, "\n");
+		}
+	}
+	if (!hit)
+		fprintf(fp, "No matches found.");
+	fclose(fp);
+
+	do {
+		cprint_init();
+		cprint("--title");
+		cprint("Search Results");
+		cprint("--textbox");
+		cprint(".search.tmp");
+		cprint("%d", rows);
+		cprint("%d", cols);
+	} while (exec_conf() < 0);
+	unlink(".search.tmp");
+}
+
 static void build_conf(struct menu *menu)
 {
 	struct symbol *sym;
@@ -463,6 +544,25 @@ static void conf(struct menu *menu)
 			cprint("    Save Configuration to an Alternate File");
 		}
 		stat = exec_conf();
+		if (stat == 26) {
+			char *search_str;
+
+			if (!strlen(input_buf))
+				continue;
+			search_str = malloc(sizeof(char)*sizeof(input_buf));
+			if (search_str == NULL) {
+				perror("malloc");
+				continue;
+			}
+			/* Capitalizing the string */
+			for (i = 0; input_buf[i]; i++)
+				search_str[i] = toupper(input_buf[i]);
+			search_str[i] = '\0';
+			/* Searching and displaying all matches */
+			search_conf(search_str);
+			free(search_str);
+			continue;
+		}
 		if (stat < 0)
 			continue;
 
diff -puN scripts/lxdialog/menubox.c~searching-for-parameters-in-make-menuconfig scripts/lxdialog/menubox.c
--- 25/scripts/lxdialog/menubox.c~searching-for-parameters-in-make-menuconfig	2004-08-31 01:55:58.000000000 -0700
+++ 25-akpm/scripts/lxdialog/menubox.c	2004-08-31 01:57:40.000000000 -0700
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
 
_

