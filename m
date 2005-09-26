Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVIZMJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVIZMJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIZMJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:09:13 -0400
Received: from web51011.mail.yahoo.com ([68.142.224.81]:51294 "HELO
	web51011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751425AbVIZMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:09:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sGAvAYM0xjnPLHjv1Nr46hYTnXi93ULKuf+s9KjcVhcmVks+ClgvmyBzzjHHK1+bAwzSzTn9iF5KqRzcPR7tI34uNc8I/DSnMIclEa4vL3Tlm27mQ1HFdi/3MTBvBqVeUN7IQfbTTGmzrpid6s1enwsxwBxmCNi+xe2AF2GUwqM=  ;
Message-ID: <20050926120910.8667.qmail@web51011.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:09:10 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [PATCH](conf.c & expr.h) Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux.org/scripts/kconfig/conf.c    2005-09-23
09:27:39.000000000 +0200
+++ linux-2.6.13.2/scripts/kconfig/conf.c      
2005-09-24 12:03:06.000000000 +0200
@@ -9,6 +9,7 @@
 #include <unistd.h>
 #include <time.h>
 #include <sys/stat.h>
+#include <sys/wait.h>

 #define LKC_DIRECT_LINK
 #include "lkc.h"
@@ -24,7 +25,9 @@
        set_yes,
        set_mod,
        set_no,
-       set_random
+       set_random,
+        set_auto,
+       set_autochoice
 } input_mode = ask_all;
 char *defconfig_file;

@@ -63,9 +66,51 @@
        }
 }

+static int auto_exec(const char* rule)
+{
+        int pd[2];
+        pid_t childpid;
+        char directory[128];
+
+        /*
+         * reading the dirctory where the rules are
+         */
+        strncpy(directory,"scripts/kconfig/rules/",
128);
+
+        strcat(directory, rule);
+
+        pipe(pd);
+
+        if (( childpid = fork() ) == 0) {
+                dup2(pd[1], STDOUT_FILENO);
+
+                close(pd[0]);
+                close(pd[1]);
+                 /*
+                  *  calling the rule
+                  */
+                system(directory);
+                exit(0);
+        }
+        close(pd[1]);
+        /*
+         *  waiting for the child process to complete
+         */
+         while ( wait ((int *) 0) != childpid)
+                         continue;
+        /*
+         * reading from the pipe, that is the answer
from the rule
+         */
+        read( pd[0], line, 128 );
+        close(pd[0]);
+        return 0;
+}
+
 static void conf_askvalue(struct symbol *sym, const
char *def)
 {
        enum symbol_type type = sym_get_type(sym);
+       char *autopara;
+       size_t buflng;
        tristate val;

        if (!sym_has_value(sym))
@@ -89,6 +134,63 @@
                        return;
                }
                check_stdin();
+       case set_auto:
+                fflush(stdout);
+                line[0] = '\n';
+                line[1] = 0;
+                if (sym->autorule) {
+                       if (sym->autopara) {
+                               buflng =
strlen(sym->autopara);
+                               autopara = (char*)
malloc (buflng+5);
+                               sprintf(autopara, "
\"%s\"", sym->autopara);
+                               strcat(sym->autorule,
autopara);
+                               free(autopara);
+                       }
+                        auto_exec(sym->autorule);
+               }
+                if (line[0] == 'y') {
+                       line[1] = '\n';
+                        line[2] = 0;
+                        if
(!(sym_tristate_within_range(sym, yes)))
+                                line[0] = 'm';
+                }
+               else if (line[0] == 'm') {
+                        line[1] = '\n';
+                        line[2] = 0;
+                        if
(!(sym_tristate_within_range(sym, mod)))
+                                line[0] = 'y';
+                }
+               else if (line[0] == 'n') {
+                       line[1] = '\n';
+                       line[2] = '0';
+               }
+               else printf("%c", line[0]);
+                return;
+        case set_autochoice:
+                fflush(stdout);
+                line[0] = '\n';
+                line[1] = 0;
+                if (sym->autorule) {
+                       if (sym->autopara) {
+                               buflng =
strlen(sym->autopara);
+                               autopara = (char*)
malloc (buflng+5);
+                               sprintf(autopara, "
\"%s\"", sym->autopara);
+                               strcat(sym->autorule,
autopara);
+                               free(autopara);
+                       }
+                        auto_exec(sym->autorule);
+                        if (line[0] == 'y') {
+                                fflush(stdout);
+                                fgets(line, 128,
stdin);
+                        }
+                        else {
+                                line[0] = 'n';
+                                line[1] = '\n';
+                                line[2] = 0;
+                        }
+               }
+               else printf("%c", line[0]);
+                return;
        case ask_all:
                fflush(stdout);
                fgets(line, 128, stdin);
@@ -272,7 +374,9 @@
        struct menu *child;
        int type;
        bool is_new;
-
+       char * autopara;
+       size_t buflng;
+
        sym = menu->sym;
        type = sym_get_type(sym);
        is_new = !sym_has_value(sym);
@@ -301,7 +405,6 @@

        while (1) {
                int cnt, def;
-
                printf("%*s%s\n", indent - 1, "",
menu_get_prompt(menu));
                def_sym = sym_get_choice_value(sym);
                cnt = def = 0;
@@ -326,6 +429,26 @@
                        if
(!sym_has_value(child->sym))
                                printf(" (NEW)");
                        printf("\n");
+                        if (child->sym->autorule) {
+                               if
(child->sym->autopara) {
+                                       buflng =
strlen(child->sym->autopara);
+                                       autopara =
(char*) malloc (buflng+4);
+                                      
sprintf(autopara, " \"%s\"",
+                                                     
 child->sym->autopara);
+                                      
strcat(child->sym->autorule, autopara);
+                                      
free(autopara);
+                               }
+                              
auto_exec(child->sym->autorule);
+                       }
+                       if(line[0]=='y') {
+                               sprintf(line, "%i",
cnt);
+                               break;
+                       } else {
+                               line[0] = '\n';
+                               line[1] = 0;
+                       }
+
+
                }
                printf("%*schoice", indent - 1, "");
                if (cnt == 1) {
@@ -348,6 +471,8 @@
                case ask_all:
                        fflush(stdout);
                        fgets(line, 128, stdin);
+                case set_auto:
+                case set_autochoice:
                        strip(line);
                        if (line[0] == '?') {
                                printf("\n%s\n",
menu->sym->help ?
@@ -493,6 +618,12 @@
                case 'o':
                        input_mode = ask_new;
                        break;
+                case 'a':
+                        input_mode = set_auto;
+                        break;
+                case 'c':
+                        input_mode = set_autochoice;
+                        break;
                case 's':
                        input_mode = ask_silent;
                        valid_stdin = isatty(0) &&
isatty(1) && isatty(2);
@@ -557,6 +688,8 @@
                }
        case ask_all:
        case ask_new:
+        case set_auto:
+        case set_autochoice:
                conf_read(NULL);
                break;
        default:
@@ -566,7 +699,7 @@
        if (input_mode != ask_silent) {
                rootEntry = &rootmenu;
                conf(&rootmenu);
-               if (input_mode == ask_all) {
+                if (input_mode == ask_all ||
input_mode == set_auto || input_mode ==
set_autochoice) {
                        input_mode = ask_silent;
                        valid_stdin = 1;
--- linux.org/scripts/kconfig/expr.h    2005-09-23
09:27:39.000000000 +0200
+++ linux-2.6.13.2/scripts/kconfig/expr.h      
2005-09-24 11:55:37.000000000 +0200
@@ -67,6 +67,8 @@
        struct symbol *next;
        char *name;
        char *help;
+       char *autorule;
+       char *autopara;
        enum symbol_type type;
        struct symbol_value curr, user;
        tristate visible;



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
