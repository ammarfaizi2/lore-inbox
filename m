Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUCYAVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUCYACe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:02:34 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:52410 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262784AbUCYAAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:00:00 -0500
Subject: [patch 13/22] __early_param for parisc
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthew@wil.cx
From: trini@kernel.crashing.org
Message-Id: <20040324235957.YFVR19401.fed1mtao06.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:59:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: matthew@wil.cx, grundler@parisc-linux.org
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert mem= to __early_param


---

 linux-2.6-early_setup-trini/arch/parisc/kernel/setup.c       |   10 +---
 linux-2.6-early_setup-trini/arch/parisc/kernel/vmlinux.lds.S |    3 +
 linux-2.6-early_setup-trini/arch/parisc/mm/init.c            |   27 ++---------
 3 files changed, 11 insertions(+), 29 deletions(-)

diff -puN arch/parisc/kernel/setup.c~parisc arch/parisc/kernel/setup.c
--- linux-2.6-early_setup/arch/parisc/kernel/setup.c~parisc	2004-03-24 16:15:08.363304438 -0700
+++ linux-2.6-early_setup-trini/arch/parisc/kernel/setup.c	2004-03-24 16:15:08.370302862 -0700
@@ -46,7 +46,6 @@
 #include <asm/io.h>
 
 #define COMMAND_LINE_SIZE 1024
-char	saved_command_line[COMMAND_LINE_SIZE];
 char	command_line[COMMAND_LINE_SIZE];
 
 /* Intended for ccio/sba/cpu statistics under /proc/bus/{runway|gsc} */
@@ -60,11 +59,8 @@ void __init setup_cmdline(char **cmdline
 	/* Collect stuff passed in from the boot loader */
 
 	/* boot_args[0] is free-mem start, boot_args[1] is ptr to command line */
-	if (boot_args[0] < 64) {
-		/* called from hpux boot loader */
-		saved_command_line[0] = '\0';
-	} else {
-		strcpy(saved_command_line, (char *)__va(boot_args[1]));
+	if (boot_args[0] > 64) {
+		strcpy(command_line, (char *)__va(boot_args[1]));
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
@@ -75,8 +71,8 @@ void __init setup_cmdline(char **cmdline
 #endif
 	}
 
-	strcpy(command_line, saved_command_line);
 	*cmdline_p = command_line;
+	parse_early_options(cmdline_p);
 }
 
 #ifdef CONFIG_PA11
diff -puN arch/parisc/kernel/vmlinux.lds.S~parisc arch/parisc/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/parisc/kernel/vmlinux.lds.S~parisc	2004-03-24 16:15:08.365303988 -0700
+++ linux-2.6-early_setup-trini/arch/parisc/kernel/vmlinux.lds.S	2004-03-24 16:15:08.370302862 -0700
@@ -116,6 +116,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
diff -puN arch/parisc/mm/init.c~parisc arch/parisc/mm/init.c
--- linux-2.6-early_setup/arch/parisc/mm/init.c~parisc	2004-03-24 16:15:08.367303537 -0700
+++ linux-2.6-early_setup-trini/arch/parisc/mm/init.c	2004-03-24 16:15:08.371302637 -0700
@@ -74,33 +74,18 @@ int npmem_ranges;
 
 static unsigned long mem_limit = MAX_MEM;
 
-static void __init mem_limit_func(void)
+static int __init mem_limit_func(char *cp)
 {
-	char *cp, *end;
 	unsigned long limit;
-	extern char saved_command_line[];
 
-	/* We need this before __setup() functions are called */
-
-	limit = MAX_MEM;
-	for (cp = saved_command_line; *cp; ) {
-		if (memcmp(cp, "mem=", 4) == 0) {
-			cp += 4;
-			limit = memparse(cp, &end);
-			if (end != cp)
-				break;
-			cp = end;
-		} else {
-			while (*cp != ' ' && *cp)
-				++cp;
-			while (*cp == ' ')
-				++cp;
-		}
-	}
+	limit = memparse(cp, &cp);
 
 	if (limit < mem_limit)
 		mem_limit = limit;
+
+	return 0;
 }
+__early_param("mem=", mem_limit_func);
 
 #define MAX_GAP (0x40000000UL >> PAGE_SHIFT)
 
@@ -215,8 +200,6 @@ static void __init setup_bootmem(void)
 	 * to work with multiple memory ranges).
 	 */
 
-	mem_limit_func();       /* check for "mem=" argument */
-
 	mem_max = 0;
 	for (i = 0; i < npmem_ranges; i++) {
 		unsigned long rsize;

_
