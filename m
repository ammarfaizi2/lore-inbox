Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264518AbUEJF3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbUEJF3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUEJF3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:29:48 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:41384 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264518AbUEJF3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:29:43 -0400
Subject: [PATCH] All Symbols in /proc/kallsyms
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain
Message-Id: <1084166916.8127.46.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 15:28:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debuggers (ie. xmon) can use kallsyms, but they want all symbols, not
just functions.  Fair enough.

Name: Debugging Option to Put text symbols in kallsyms
Status: Tested on 2.6.6-rc3-bk11

kallsyms contains only function names, but some debuggers (eg. xmon on
PPC/PPC64) use it to lookup symbols: it'd be much nicer if it included
data symbols too.


diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5274-linux-2.6.6-rc2-bk4/Makefile .5274-linux-2.6.6-rc2-bk4.updated/Makefile
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21129-linux-2.6.6-rc2-bk4/Makefile .21129-linux-2.6.6-rc2-bk4.updated/Makefile
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21201-linux-2.6.6-rc3-bk11/Makefile .21201-linux-2.6.6-rc3-bk11.updated/Makefile
--- .21201-linux-2.6.6-rc3-bk11/Makefile	2004-05-10 09:01:11.000000000 +1000
+++ .21201-linux-2.6.6-rc3-bk11.updated/Makefile	2004-05-10 15:09:44.000000000 +1000
@@ -567,7 +567,7 @@ ifdef CONFIG_KALLSYMS
 kallsyms.o := .tmp_kallsyms2.o
 
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) > $@
+cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) $(foreach x,$(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
 .tmp_kallsyms1.o .tmp_kallsyms2.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21201-linux-2.6.6-rc3-bk11/init/Kconfig .21201-linux-2.6.6-rc3-bk11.updated/init/Kconfig
--- .21201-linux-2.6.6-rc3-bk11/init/Kconfig	2004-04-29 17:30:12.000000000 +1000
+++ .21201-linux-2.6.6-rc3-bk11.updated/init/Kconfig	2004-05-10 15:09:44.000000000 +1000
@@ -235,6 +235,17 @@ config KALLSYMS
 	   symbolic stack backtraces. This increases the size of the kernel
 	   somewhat, as all symbols have to be loaded into the kernel image.
 
+config KALLSYMS_ALL
+	bool "Include all symbols in kallsyms"
+	depends on DEBUG_KERNEL && KALLSYMS
+	help
+	   Normally kallsyms only contains the symbols of functions, for nicer
+	   OOPS messages.  Some debuggers can use kallsyms for other
+	   symbols too: say Y here to include all symbols, and you
+	   don't care about adding 300k to the size of your kernel.
+
+	   Say N.
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21201-linux-2.6.6-rc3-bk11/kernel/kallsyms.c .21201-linux-2.6.6-rc3-bk11.updated/kernel/kallsyms.c
--- .21201-linux-2.6.6-rc3-bk11/kernel/kallsyms.c	2004-03-12 07:57:28.000000000 +1100
+++ .21201-linux-2.6.6-rc3-bk11.updated/kernel/kallsyms.c	2004-05-10 15:10:59.000000000 +1000
@@ -183,7 +183,10 @@ static void get_ksymbol_core(struct kall
 	iter->nameoff += strlen(kallsyms_names + iter->nameoff) + 1;
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
-	iter->type = 't';
+	if (is_kernel_text(iter->value) || is_kernel_inittext(iter->value))
+		iter->type = 't';
+	else
+		iter->type = 'd';
 
 	upcase_if_global(iter);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21201-linux-2.6.6-rc3-bk11/scripts/kallsyms.c .21201-linux-2.6.6-rc3-bk11.updated/scripts/kallsyms.c
--- .21201-linux-2.6.6-rc3-bk11/scripts/kallsyms.c	2003-09-22 10:07:21.000000000 +1000
+++ .21201-linux-2.6.6-rc3-bk11.updated/scripts/kallsyms.c	2004-05-10 15:09:44.000000000 +1000
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms > symbols.S
+ * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
  */
 
 #include <stdio.h>
@@ -22,11 +22,12 @@ struct sym_entry {
 static struct sym_entry *table;
 static int size, cnt;
 static unsigned long long _stext, _etext, _sinittext, _einittext;
+static int all_symbols = 0;
 
 static void
 usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] < in.map > out.S\n");
 	exit(1);
 }
 
@@ -51,9 +52,11 @@ read_symbol(FILE *in, struct sym_entry *
 static int
 symbol_valid(struct sym_entry *s)
 {
-	if ((s->addr < _stext || s->addr > _etext)
-	    && (s->addr < _sinittext || s->addr > _einittext))
-		return 0;
+	if (!all_symbols) {
+		if ((s->addr < _stext || s->addr > _etext)
+		    && (s->addr < _sinittext || s->addr > _einittext))
+			return 0;
+	}
 
 	if (strstr(s->sym, "_compiled."))
 		return 0;
@@ -156,7 +159,9 @@ write_src(void)
 int
 main(int argc, char **argv)
 {
-	if (argc != 1)
+	if (argc == 2 && strcmp(argv[1], "--all-symbols") == 0)
+		all_symbols = 1;
+	else if (argc != 1)
 		usage();
 
 	read_map(stdin);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

