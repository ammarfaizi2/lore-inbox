Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUIBJsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUIBJsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUIBJsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:48:42 -0400
Received: from [212.29.248.50] ([212.29.248.50]:44727 "EHLO il.aduva.com")
	by vger.kernel.org with ESMTP id S268102AbUIBJri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:47:38 -0400
Message-ID: <4136EB54.6060705@il.aduva.com>
Date: Thu, 02 Sep 2004 12:43:48 +0300
From: Yuval Turgeman <yuval@il.aduva.com>
Reply-To: yuvalt@gmail.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: sam@ravnborg.org, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Menuconfig search changes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the search to go over the properties attached to a symbol (like 
Roman suggessted).
Added regex support to help narrow down the searches.
Displaying the parameter's dependencies (nothing fency - simply using 
expr_fprint).
Added a 'show_file' helper function.
(This patch should be applied after applying Andrew's modifications)
Thanks.

Signed-off-by: Yuval Turgeman <yuvalt@gmail.com>

diff -uprN linux-2.6.8.1/scripts/kconfig/mconf.c 
linux/scripts/kconfig/mconf.c
--- linux-2.6.8.1/scripts/kconfig/mconf.c       2004-09-02 
12:23:30.000000000 +0300
+++ linux/scripts/kconfig/mconf.c       2004-09-02 12:12:47.000000000 +0300
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
+#include <regex.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"
@@ -102,7 +103,9 @@ static void show_textbox(const char *tit
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
 static void show_readme(void);
+static void show_file(const char *filename, const char *title, int r, 
int c);
 static void search_conf(char *);
+static int regex_match(const char *, char *);
 
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -275,33 +278,28 @@ static int exec_conf(void)
        return WEXITSTATUS(stat);
 }
 
-static struct menu *do_search(struct menu *menu, struct symbol *sym)
+static int regex_match(const char *string, char *pattern)
 {
-       struct menu *child, *ret;
-       /* Ignore invisible menus ?
-       if (!menu_is_visible(menu))
-               return NULL;
-       */
+       regex_t re;
+       int rc;
 
-       if (menu->sym) {
-               if (menu->sym->name && !strcmp(menu->sym->name, sym->name))
-                       return menu;
-       }
-       for (child = menu->list; child; child = child->next) {
-               ret = do_search(child, sym);
-               if (ret)
-                       return ret;
-       }
-       return NULL;
+       if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
+               return 0;
+       rc = regexec(&re, string, (size_t) 0, NULL, 0);
+       regfree(&re);
+       if (rc)
+               return 0;
+       return 1;
 }
 
 static void search_conf(char *search_str)
 {
-       struct symbol *sym;
+       struct symbol *sym = NULL;
        struct menu *menu[32] = { 0 };
-       int i, j, k;
-       FILE *fp;
+       struct property *prop = NULL;
+       FILE *fp = NULL;
        bool hit = false;
+       int i, j, k;
 
        fp = fopen(".search.tmp", "w");
        if (fp == NULL) {
@@ -309,49 +307,51 @@ static void search_conf(char *search_str
                return;
        }
        for_all_symbols(i, sym) {
-               if (sym->name && strstr(sym->name, search_str)) {
-                       struct menu *submenu = do_search(&rootmenu, sym);
-
+               if (!sym->name)
+                       continue;
+               if (!regex_match(sym->name, search_str))
+                       continue;
+               for_all_prompts(sym, prop) {
+                       struct menu *submenu = prop->menu;
+                       if (!submenu)
+                               continue;
                        j = 0;
+                       hit = false;
                        while (submenu) {
                                menu[j++] = submenu;
                                submenu = submenu->parent;
                        }
                        if (j > 0) {
-                               if (sym->prop && sym->prop->text)
-                                       fprintf(fp, "%s (%s)\n",
-                                               sym->prop->text, sym->name);
+                               if (!hit)
+                                       hit = true;
+                               if (prop->text)
+                                       fprintf(fp, "%s (%s)\n", 
prop->text, sym->name);
                                else
                                        fprintf(fp, "%s\n", sym->name);
+                               fprintf(fp, "Location:\n");
                        }
                        for (k = j-2; k > 0; k--) {
-                               if (!hit)
-                                       hit = true;
-                               submenu = menu[k];
-                               const char *prompt = 
menu_get_prompt(submenu);
-                               if (submenu->sym)
-                                       fprintf(fp, " -> %s (%s)\n",
-                                               prompt, submenu->sym->name);
+                               const char *prompt = (char 
*)menu_get_prompt(menu[k]);
+                               if (menu[k]->sym)
+                                       fprintf(fp, " -> %s (%s)\n", 
prompt, menu[k]->sym->name);
                                else
                                        fprintf(fp, " -> %s\n", prompt);
                        }
-                       if (hit)
-                               fprintf(fp, "\n");
+                       if (hit) {
+                               if (menu[0]->dep || (menu[0]->sym && 
menu[0]->sym->dep))
+                                       fprintf(fp, "Depends:\n ");
+                               if (menu[0]->dep)
+                                       expr_fprint(menu[0]->dep, fp);
+                               if (menu[0]->sym && menu[0]->sym->dep)
+                                       expr_fprint(menu[0]->sym->dep, fp);
+                               fprintf(fp, "\n\n\n");
+                       }
                }
        }
        if (!hit)
                fprintf(fp, "No matches found.");
        fclose(fp);
-
-       do {
-               cprint_init();
-               cprint("--title");
-               cprint("Search Results");
-               cprint("--textbox");
-               cprint(".search.tmp");
-               cprint("%d", rows);
-               cprint("%d", cols);
-       } while (exec_conf() < 0);
+       show_file(".search.tmp", "Search Results", rows, cols);
        unlink(".search.tmp");
 }
 
@@ -554,11 +554,9 @@ static void conf(struct menu *menu)
                                perror("malloc");
                                continue;
                        }
-                       /* Capitalizing the string */
                        for (i = 0; input_buf[i]; i++)
                                search_str[i] = toupper(input_buf[i]);
                        search_str[i] = '\0';
-                       /* Searching and displaying all matches */
                        search_conf(search_str);
                        free(search_str);
                        continue;
@@ -650,17 +648,7 @@ static void show_textbox(const char *tit
        fd = creat(".help.tmp", 0777);
        write(fd, text, strlen(text));
        close(fd);
-       do {
-               cprint_init();
-               if (title) {
-                       cprint("--title");
-                       cprint("%s", title);
-               }
-               cprint("--textbox");
-               cprint(".help.tmp");
-               cprint("%d", r);
-               cprint("%d", c);
-       } while (exec_conf() < 0);
+       show_file(".help.tmp", title, r, c);
        unlink(".help.tmp");
 }
 
@@ -689,13 +677,22 @@ static void show_help(struct menu *menu)
 
 static void show_readme(void)
 {
+       show_file("scripts/README.Menuconfig", NULL, rows, cols);
+}
+
+static void show_file(const char *filename, const char *title, int r, 
int c)
+{
        do {
                cprint_init();
+               if (title) {
+                       cprint("--title");
+                       cprint("%s", title);
+               }
                cprint("--textbox");
-               cprint("scripts/README.Menuconfig");
-               cprint("%d", rows);
-               cprint("%d", cols);
-       } while (exec_conf() == -1);
+               cprint("%s", filename);
+               cprint("%d", r);
+               cprint("%d", c);
+       } while (exec_conf() < 0);
 }
 
 static void conf_choice(struct menu *menu)

