Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUEaJUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUEaJUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEaJUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:20:52 -0400
Received: from verein.lst.de ([212.34.189.10]:1450 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264398AbUEaJUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:20:47 -0400
Date: Mon, 31 May 2004 11:20:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: RH's noninteractive config patch
Message-ID: <20040531092044.GA14091@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, zippel@linux-m68k.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Arjan said you some objections against RH's current noninteractive
config patch?  I'd really love to see something like it included
because it greatly helps packagaing the kernel.  Patch from their
current RPM is below:


diff -urNp linux-1/scripts/kconfig/conf.c linux-500/scripts/kconfig/conf.c
--- linux-1/scripts/kconfig/conf.c
+++ linux-500/scripts/kconfig/conf.c
@@ -20,6 +20,7 @@ enum {
 	ask_all,
 	ask_new,
 	ask_silent,
+	dont_ask,
 	set_default,
 	set_yes,
 	set_mod,
@@ -36,6 +37,8 @@ static struct menu *rootEntry;
 
 static char nohelp_text[] = "Sorry, no help available for this option yet.\n";
 
+static int return_value = 0;
+
 static void strip(char *str)
 {
 	char *p = str;
@@ -93,6 +96,12 @@ static void conf_askvalue(struct symbol 
 		fflush(stdout);
 		fgets(line, 128, stdin);
 		return;
+	case dont_ask:
+		if (!sym_has_value(sym)) {
+			fprintf(stderr,"CONFIG_%s\n",sym->name);
+			return_value++;
+		}
+		return;
 	case set_default:
 		printf("%s\n", def);
 		return;
@@ -339,6 +348,7 @@ static int conf_choice(struct menu *menu
 		switch (input_mode) {
 		case ask_new:
 		case ask_silent:
+		case dont_ask:
 			if (!is_new) {
 				cnt = def;
 				printf("%d\n", cnt);
@@ -472,7 +482,10 @@ static void check_conf(struct menu *menu
 			if (!conf_cnt++)
 				printf("*\n* Restart config...\n*\n");
 			rootEntry = menu_get_parent_menu(menu);
-			conf(rootEntry);
+			if (input_mode == dont_ask)
+				fprintf(stderr,"CONFIG_%s\n",sym->name);
+			else
+				conf(rootEntry);
 		}
 		if (sym_is_choice(sym) && sym_get_tristate_value(sym) != mod)
 			return;
@@ -493,6 +506,9 @@ int main(int ac, char **av)
 		case 'o':
 			input_mode = ask_new;
 			break;
+		case 'b':
+			input_mode = dont_ask;
+			break;
 		case 's':
 			input_mode = ask_silent;
 			valid_stdin = isatty(0) && isatty(1) && isatty(2);
@@ -557,6 +573,7 @@ int main(int ac, char **av)
 		}
 	case ask_all:
 	case ask_new:
+	case dont_ask:
 		conf_read(NULL);
 		break;
 	default:
@@ -574,10 +591,10 @@ int main(int ac, char **av)
 	do {
 		conf_cnt = 0;
 		check_conf(&rootmenu);
-	} while (conf_cnt);
+	} while ((conf_cnt) && (input_mode != dont_ask));
 	if (conf_write(NULL)) {
 		fprintf(stderr, "\n*** Error during writing of the kernel configuration.\n\n");
 		return 1;
 	}
-	return 0;
+	return return_value;
 }
--- linux-2.6.3/scripts/kconfig/Makefile.orig	2004-02-25 16:59:55.934625904 +0100
+++ linux-2.6.3/scripts/kconfig/Makefile	2004-02-25 17:02:37.076128672 +0100
@@ -23,6 +23,10 @@
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+nonint_oldconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -b arch/$(ARCH)/Kconfig
+
+
 .PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
 
 randconfig: $(obj)/conf
@@ -68,7 +72,7 @@
 libkconfig-objs := zconf.tab.o
 
 host-progs	:= conf mconf qconf gconf
-conf-objs	:= conf.o  libkconfig.so
+conf-objs	:= conf.o
 mconf-objs	:= mconf.o libkconfig.so
 
 ifeq ($(MAKECMDGOALS),xconfig)
@@ -95,13 +99,15 @@
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
+HOSTLOADLIBES_conf     = -Wl,-rpath,\$$ORIGIN -Lscripts/kconfig -lkconfig
+
 HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
 HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
 
-$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
+$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h $(obj)/libkconfig.so
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
