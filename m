Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKIT5z>; Sat, 9 Nov 2002 14:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKIT5z>; Sat, 9 Nov 2002 14:57:55 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:4883 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262620AbSKIT5x>; Sat, 9 Nov 2002 14:57:53 -0500
Date: Sat, 9 Nov 2002 21:04:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Romain Lievin <rlievin@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (qconf): bug ?
In-Reply-To: <20021109134444.GB9480@free.fr>
Message-ID: <Pine.LNX.4.44.0211092054360.2113-100000@serv>
References: <20021109134444.GB9480@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 9 Nov 2002, Romain Lievin wrote:

> BTW, I noticed something weird with Qconf. I don't know whether it's a
> bug or a mis-behaviour...
> 
> Once you have a .config file in /usr/src/linux and if you attempt to load
> another config file, Qconf will not load my settings.
> If you does not have the .config file yet (freshen install) and I attempt to
> load my config file,  Qconf will load it fine...

The file was loaded, but the values were not immediately visible. The 
symbol value is only calculated on demand and the flag wasn't cleared 
(you had to change one value to see the update). The patch below fixes and 
also forces a redisplay in qconf.
The patch also moves conf_filename to it's only user (mconf).

bye, Roman

diff -ur linux-2.5/scripts/kconfig/confdata.c linux-lkc/scripts/kconfig/confdata.c
--- linux-2.5/scripts/kconfig/confdata.c	2002-11-09 20:43:01.000000000 +0100
+++ linux-lkc/scripts/kconfig/confdata.c	2002-11-09 20:44:52.000000000 +0100
@@ -4,7 +4,6 @@
  */
 
 #include <ctype.h>
-#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -14,7 +13,6 @@
 #include "lkc.h"
 
 const char conf_def_filename[] = ".config";
-char conf_filename[PATH_MAX+1];
 
 const char conf_defname[] = "arch/$ARCH/defconfig";
 
@@ -71,8 +69,6 @@
 
 	if (name) {
 		in = fopen(name, "r");
-		if (in)
-			strcpy(conf_filename, name);
 	} else {
 		const char **names = conf_confnames;
 		while ((name = *names++)) {
@@ -91,21 +87,21 @@
 		return 1;
 
 	for_all_symbols(i, sym) {
-		sym->flags |= SYMBOL_NEW;
+		sym->flags |= SYMBOL_NEW | SYMBOL_CHANGED;
+		sym->flags &= ~SYMBOL_VALID;
 		switch (sym->type) {
 		case S_INT:
 		case S_HEX:
 		case S_STRING:
-			if (S_VAL(sym->def)) {
+			if (S_VAL(sym->def))
 				free(S_VAL(sym->def));
-				S_VAL(sym->def) = NULL;
-			}
 		default:
-			;
+			S_VAL(sym->def) = NULL;
+			S_TRI(sym->def) = no;
 		}
 	}
 
-	while (fgets(line, 128, in)) {
+	while (fgets(line, sizeof(line), in)) {
 		lineno++;
 		switch (line[0]) {
 		case '#':
@@ -357,7 +359,6 @@
 	rename(name, oldname);
 	if (rename(".tmpconfig", name))
 		return 1;
-	strcpy(conf_filename, name);
 
 	sym_change_count = 0;
 
diff -ur linux-2.5/scripts/kconfig/mconf.c linux-lkc/scripts/kconfig/mconf.c
--- linux-2.5/scripts/kconfig/mconf.c	2002-11-09 20:43:01.000000000 +0100
+++ linux-lkc/scripts/kconfig/mconf.c	2002-11-09 20:44:53.000000000 +0100
@@ -11,6 +11,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <signal.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -82,6 +83,7 @@
 
 static char buf[4096], *bufptr = buf;
 static char input_buf[4096];
+static char filename[PATH_MAX+1] = ".config";
 static char *args[1024], **argptr = args;
 static int indent = 0;
 static struct termios ios_org;
@@ -661,7 +663,7 @@
 		cprint(load_config_text);
 		cprint("11");
 		cprint("55");
-		cprint("%s", conf_filename);
+		cprint("%s", filename);
 		stat = exec_conf();
 		switch(stat) {
 		case 0:
@@ -690,7 +692,7 @@
 		cprint(save_config_text);
 		cprint("11");
 		cprint("55");
-		cprint("%s", conf_filename);
+		cprint("%s", filename);
 		stat = exec_conf();
 		switch(stat) {
 		case 0:
diff -ur linux-2.5/scripts/kconfig/qconf.cc linux-lkc/scripts/kconfig/qconf.cc
--- linux-2.5/scripts/kconfig/qconf.cc	2002-11-09 20:43:01.000000000 +0100
+++ linux-lkc/scripts/kconfig/qconf.cc	2002-11-09 20:44:53.000000000 +0100
@@ -890,6 +890,8 @@
 		return;
 	if (conf_read(s.latin1()))
 		QMessageBox::information(this, "qconf", "Unable to load configuration!");
+	configList->updateListAll();
+	menuList->updateListAll();
 }
 
 void ConfigView::saveConfig(void)

