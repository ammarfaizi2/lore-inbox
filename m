Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUHaHwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUHaHwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUHaHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 03:52:49 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:48753 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267180AbUHaHwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 03:52:41 -0400
Message-ID: <9ae345c0040831005257c245da@mail.gmail.com>
Date: Tue, 31 Aug 2004 10:52:40 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: sam@ravnborg.org
Subject: [PATCH] Searching parameters in menuconfig
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for searching parameters in make menuconfig.
Can be compiled with gcc-2.95 now...
( If I didn't mention this before, pressing '/' invokes the search window )

Signed-off-by: Yuval Turgeman <yuvalt@gmail.com>

scripts/kconfig/mconf.c    |  101 ++++++++++++++++++++++++++++++++++++++++++++-
scripts/lxdialog/menubox.c |   10 ++++
2 files changed, 110 insertions(+), 1 deletion(-)

diff -uprN linux-vanilla/scripts/kconfig/mconf.c linux/scripts/kconfig/mconf.c
--- linux-vanilla/scripts/kconfig/mconf.c       2004-08-14
13:54:51.000000000 +0300
+++ linux/scripts/kconfig/mconf.c       2004-08-31 10:15:56.000000000 +0300
@@ -28,7 +28,7 @@ static const char menu_instructions[] =
        "<Enter> selects submenus --->.  "
        "Highlighted letters are hotkeys.  "
        "Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
-       "Press <Esc><Esc> to exit, <?> for Help.  "
+       "Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
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
+       struct menu *child, *ret;
+       /* Ignore invisible menus ?
+       if (!menu_is_visible(menu))
+               return NULL;
+       */
+
+       if ( menu->sym ) {
+               if ( menu->sym->name && !strcmp(menu->sym->name, sym->name )) {
+                       return menu;
+               }
+       }
+       for (child = menu->list; child; child = child->next) {
+               ret = do_search(child, sym);
+               if ( ret ) return ret;
+       }
+       return NULL;
+}
+
+static void search_conf(char *search_str)
+{
+    struct symbol *sym = NULL;
+       struct menu *menu[32] = { 0 };
+       struct menu *submenu = NULL;
+       FILE *fp = NULL;
+       char *prompt = NULL;
+       int i, j, k;
+       bool hit = false;
+
+       fp = fopen(".search.tmp", "w");
+       if ( fp == NULL ) {
+               perror("fopen");
+               return;
+       }
+       for_all_symbols(i, sym) {
+               if ( sym->name && strstr(sym->name, search_str) ) {
+                       submenu = do_search(&rootmenu, sym);
+                       j = 0;
+                       while ( submenu ) {
+                               menu[j++] = submenu;
+                               submenu = submenu->parent;
+                       }
+                       if ( j > 0 ) {
+                               if ( sym->prop && sym->prop->text ) {
+                                       fprintf(fp, "%s (%s)\n",
sym->prop->text, sym->name);
+                               } else {
+                                       fprintf(fp, "%s\n", sym->name);
+                               }
+                       }
+                       for (k = j-2; k > 0; k-- ) {
+                               if ( ! hit ) hit = true;
+                               submenu = menu[k];
+                               prompt = (char*)menu_get_prompt(submenu);
+                               if ( submenu->sym ) {
+                                       fprintf(fp, " -> %s (%s)\n",
prompt, submenu->sym->name);
+                               } else {
+                                       fprintf(fp, " -> %s\n", prompt);
+                               }
+                       }
+                       if ( hit )
+                               fprintf(fp, "\n");
+               }
+    }
+       if ( ! hit ) {
+               fprintf(fp, "No matches found.");
+       }
+       fclose(fp);
+    do {
+        cprint_init();
+        cprint("--title");
+        cprint("Search Results");
+        cprint("--textbox");
+        cprint(".search.tmp");
+        cprint("%d", rows);
+        cprint("%d", cols);
+    } while (exec_conf() < 0);
+       unlink(".search.tmp");
+}
+
 static void build_conf(struct menu *menu)
 {
        struct symbol *sym;
@@ -436,6 +517,7 @@ static void conf(struct menu *menu)
        const char *prompt = menu_get_prompt(menu);
        struct symbol *sym;
        char active_entry[40];
+       char *search_str = NULL;
        int stat, type, i;
 
        unlink("lxdialog.scrltmp");
@@ -463,6 +545,23 @@ static void conf(struct menu *menu)
                        cprint("    Save Configuration to an Alternate File");
                }
                stat = exec_conf();
+               if ( stat == 26 ) {
+                       if ( ! strlen(input_buf) ) continue;
+                       search_str =
(char*)malloc(sizeof(char)*sizeof(input_buf));
+                       if ( search_str == NULL ) {
+                               perror("malloc");
+                               continue;
+                       }
+                       /* Capitalizing the string */
+                       for ( i = 0; input_buf[i]; i++ ) {
+                               search_str[i] = toupper(input_buf[i]);
+                       }
+                       search_str[i] = '\0';
+                       /* Searching and displaying all matches */
+                       search_conf( search_str );
+                       free(search_str);
+                       continue;
+               }
                if (stat < 0)
                        continue;
 
diff -uprN linux-vanilla/scripts/lxdialog/menubox.c
linux/scripts/lxdialog/menubox.c
--- linux-vanilla/scripts/lxdialog/menubox.c    2004-08-14
13:56:22.000000000 +0300
+++ linux/scripts/lxdialog/menubox.c    2004-08-31 10:15:56.000000000 +0300
@@ -276,6 +276,16 @@ dialog_menu (const char *title, const ch
 
     while (key != ESC) {
        key = wgetch(menu);
+       if ( key == '/' ) {
+               int ret = dialog_inputbox("Search Configuration Parameter", 
+                                                                
"Enter Keyword", height, width,
+                                                                
(char *) NULL);
+               if ( ret == 0 )
+               {
+                       fprintf(stderr, "%s", dialog_input_result);
+                       return 26;
+               }
+       }
 
        if (key < 256 && isalpha(key)) key = tolower(key);
