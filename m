Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUCYAV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCYADX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:23 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:38301 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262854AbUCYAAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:00:50 -0500
Subject: [patch 17/22] __early_param for SH
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000048.RGGE4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:00:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/sh/kernel/setup.c       |    6 +-----
 linux-2.6-early_setup-trini/arch/sh/kernel/vmlinux.lds.S |    3 +++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/sh/kernel/setup.c~sh arch/sh/kernel/setup.c
--- linux-2.6-early_setup/arch/sh/kernel/setup.c~sh	2004-03-24 16:15:09.280097962 -0700
+++ linux-2.6-early_setup-trini/arch/sh/kernel/setup.c	2004-03-24 16:15:09.285096836 -0700
@@ -92,7 +92,6 @@ static struct sh_machine_vector* __init 
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f },
@@ -252,10 +251,6 @@ static inline void parse_cmdline (char *
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
 	memory_start = (unsigned long)PAGE_OFFSET+__MEMORY_START;
 	memory_end = memory_start + __MEMORY_SIZE;
 
@@ -411,6 +406,7 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.end = virt_to_bus(_edata)-1;
 
 	sh_mv_setup(cmdline_p);
+	parse_early_options(cmdline_p);
 
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
diff -puN arch/sh/kernel/vmlinux.lds.S~sh arch/sh/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/sh/kernel/vmlinux.lds.S~sh	2004-03-24 16:15:09.282097512 -0700
+++ linux-2.6-early_setup-trini/arch/sh/kernel/vmlinux.lds.S	2004-03-24 16:15:09.285096836 -0700
@@ -66,6 +66,9 @@ SECTIONS
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
