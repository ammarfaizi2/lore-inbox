Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUCYAYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUCYAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:22:12 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:36029 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262903AbUCYABt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:01:49 -0500
Subject: [patch 22/22] __early_param for x86_64
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
From: trini@kernel.crashing.org
Message-Id: <20040325000145.YGSE19401.fed1mtao06.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:01:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert earlyprintk=


---

 linux-2.6-early_setup-trini/arch/x86_64/kernel/early_printk.c |    2 -
 linux-2.6-early_setup-trini/arch/x86_64/kernel/head64.c       |   16 +++-------
 linux-2.6-early_setup-trini/arch/x86_64/kernel/setup.c        |    6 ---
 linux-2.6-early_setup-trini/arch/x86_64/kernel/vmlinux.lds.S  |    3 +
 4 files changed, 10 insertions(+), 17 deletions(-)

diff -puN arch/x86_64/kernel/early_printk.c~x86_64 arch/x86_64/kernel/early_printk.c
--- linux-2.6-early_setup/arch/x86_64/kernel/early_printk.c~x86_64	2004-03-24 16:15:10.757765168 -0700
+++ linux-2.6-early_setup-trini/arch/x86_64/kernel/early_printk.c	2004-03-24 16:15:10.765763367 -0700
@@ -219,4 +219,4 @@ void __init disable_early_printk(void)
 	}
 } 
 
-__setup("earlyprintk=", setup_early_printk);
+__early_param("earlyprintk=", setup_early_printk);
diff -puN arch/x86_64/kernel/head64.c~x86_64 arch/x86_64/kernel/head64.c
--- linux-2.6-early_setup/arch/x86_64/kernel/head64.c~x86_64	2004-03-24 16:15:10.758764943 -0700
+++ linux-2.6-early_setup-trini/arch/x86_64/kernel/head64.c	2004-03-24 16:15:10.765763367 -0700
@@ -34,8 +34,6 @@ extern char x86_boot_params[2048];
 #define OLD_CL_BASE_ADDR        0x90000
 #define OLD_CL_OFFSET           0x90022
 
-extern char saved_command_line[];
-
 static void __init copy_bootdata(char *real_mode_data)
 {
 	int new_data;
@@ -52,8 +50,7 @@ static void __init copy_bootdata(char *r
 		printk("old bootloader convention, maybe loadlin?\n");
 	}
 	command_line = (char *) ((u64)(new_data));
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	printk("Bootdata ok (command line is %s)\n", saved_command_line);	
+	printk("Bootdata ok (command line is %s)\n", command_line);
 }
 
 static void __init setup_boot_cpu_data(void)
@@ -81,18 +78,15 @@ void __init x86_64_start_kernel(char * r
 	pda_init(0);
 	copy_bootdata(real_mode_data);
 	/* default console: */
-	if (!strstr(saved_command_line, "console="))
-		strcat(saved_command_line, " console=tty0"); 
-	s = strstr(saved_command_line, "earlyprintk=");
-	if (s != NULL)
-		setup_early_printk(s);
+	if (!strstr(command_line, "console="))
+		strcat(command_line, " console=tty0");
 #ifdef CONFIG_DISCONTIGMEM
-	s = strstr(saved_command_line, "numa=");
+	s = strstr(command_line, "numa=");
 	if (s != NULL)
 		numa_setup(s+5);
 #endif
 #ifdef CONFIG_X86_IO_APIC
-	if (strstr(saved_command_line, "disableapic"))
+	if (strstr(command_line, "disableapic"))
 		disable_apic = 1;
 #endif
 	setup_boot_cpu_data();
diff -puN arch/x86_64/kernel/setup.c~x86_64 arch/x86_64/kernel/setup.c
--- linux-2.6-early_setup/arch/x86_64/kernel/setup.c~x86_64	2004-03-24 16:15:10.761764268 -0700
+++ linux-2.6-early_setup-trini/arch/x86_64/kernel/setup.c	2004-03-24 16:15:10.766763142 -0700
@@ -98,7 +98,6 @@ extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 
 char command_line[COMMAND_LINE_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
@@ -194,10 +193,6 @@ static __init void parse_cmdline_early (
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
 	for (;;) {
 		if (c != ' ') 
 			goto next_char; 
@@ -378,6 +373,7 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.end = virt_to_phys(&_edata)-1;
 
 	parse_cmdline_early(cmdline_p);
+	parse_early_options(cmdline_p);
 
 	/*
 	 * partially used pages are not usable - thus
diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64 arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/x86_64/kernel/vmlinux.lds.S~x86_64	2004-03-24 16:15:10.762764043 -0700
+++ linux-2.6-early_setup-trini/arch/x86_64/kernel/vmlinux.lds.S	2004-03-24 16:15:10.766763142 -0700
@@ -89,6 +89,9 @@ SECTIONS
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
