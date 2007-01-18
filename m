Return-Path: <linux-kernel-owner+w=401wt.eu-S932374AbXARNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXARNFa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbXARNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:05:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:54881 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932405AbXARNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:20 -0500
Message-Id: <20070118130031.351874000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:14 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 25/26] Dynamic kernel command-line - x86_64
Content-Disposition: inline; filename=dynamic-kernel-command-line-x86_64.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

---
 arch/x86_64/kernel/head64.c    |    4 ++--
 arch/x86_64/kernel/setup.c     |    6 +++---
 include/asm-x86_64/bootsetup.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.20-rc4-mm1/include/asm-x86_64/bootsetup.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/asm-x86_64/bootsetup.h
+++ linux-2.6.20-rc4-mm1/include/asm-x86_64/bootsetup.h
@@ -31,7 +31,7 @@ extern char x86_boot_params[BOOT_PARAM_S
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
-#define COMMAND_LINE saved_command_line
+#define COMMAND_LINE boot_command_line
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
Index: linux-2.6.20-rc4-mm1/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/x86_64/kernel/head64.c
+++ linux-2.6.20-rc4-mm1/arch/x86_64/kernel/head64.c
@@ -34,7 +34,7 @@ static void __init clear_bss(void)
 #define OLD_CL_BASE_ADDR        0x90000
 #define OLD_CL_OFFSET           0x90022
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 static void __init copy_bootdata(char *real_mode_data)
 {
@@ -50,7 +50,7 @@ static void __init copy_bootdata(char *r
 		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
 	}
 	command_line = (char *) ((u64)(new_data));
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 }
 
 void __init x86_64_start_kernel(char * real_mode_data)
Index: linux-2.6.20-rc4-mm1/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/x86_64/kernel/setup.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(edid_info);
 
 extern int root_mountflags;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
@@ -343,7 +343,7 @@ static void discover_ebda(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	printk(KERN_INFO "Command line: %s\n", saved_command_line);
+	printk(KERN_INFO "Command line: %s\n", boot_command_line);
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
@@ -373,7 +373,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	parse_early_param();

-- 
