Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUCYASN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUCYADb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:31 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:46586 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262846AbUCYAAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:00:38 -0500
Subject: [patch 16/22] __early_param for s390
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000037.FKGI2430.fed1mtao02.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:00:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/s390/kernel/setup.c       |    6 +-----
 linux-2.6-early_setup-trini/arch/s390/kernel/vmlinux.lds.S |    3 +++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/s390/kernel/setup.c~s390 arch/s390/kernel/setup.c
--- linux-2.6-early_setup/arch/s390/kernel/setup.c~s390	2004-03-24 16:15:08.992162809 -0700
+++ linux-2.6-early_setup-trini/arch/s390/kernel/setup.c	2004-03-24 16:15:08.997161684 -0700
@@ -74,7 +74,6 @@ extern int _text,_etext, _edata, _end;
 #include <asm/setup.h>
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
@@ -373,10 +372,6 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = (unsigned long) &_etext;
 	data_resource.end = (unsigned long) &_edata - 1;
 
-        /* Save unparsed command line copy for /proc/cmdline */
-        memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-        saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
         for (;;) {
                 /*
                  * "mem=XXX[kKmM]" sets memsize 
@@ -423,6 +418,7 @@ void __init setup_arch(char **cmdline_p)
         if (c == ' ' && to > command_line) to--;
         *to = '\0';
         *cmdline_p = command_line;
+	parse_early_options(cmdline_p);
 
 	/*
 	 * partially used pages are not usable - thus
diff -puN arch/s390/kernel/vmlinux.lds.S~s390 arch/s390/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/s390/kernel/vmlinux.lds.S~s390	2004-03-24 16:15:08.994162359 -0700
+++ linux-2.6-early_setup-trini/arch/s390/kernel/vmlinux.lds.S	2004-03-24 16:15:08.997161684 -0700
@@ -77,6 +77,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;

_
