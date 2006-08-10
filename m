Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWHJUBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWHJUBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWHJT7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:1681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932646AbWHJTgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:50 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [92/145] x86_64: Remove need for early lockdep init
Message-Id: <20060810193649.9BE9C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:49 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

I think it was only needed for the printks and we can do them later.

I put in a single early_printk so that we know the kernel is alive
(early_printk doesn't need any locks)

This makes some things easier for initialization of unwind for
lockdep, which is needed by later patches.

Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/head64.c |    8 +-------
 arch/x86_64/kernel/setup.c  |    2 ++
 2 files changed, 3 insertions(+), 7 deletions(-)

Index: linux/arch/x86_64/kernel/head64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/head64.c
+++ linux/arch/x86_64/kernel/head64.c
@@ -45,15 +45,12 @@ static void __init copy_bootdata(char *r
 	new_data = *(int *) (x86_boot_params + NEW_CL_POINTER);
 	if (!new_data) {
 		if (OLD_CL_MAGIC != * (u16 *) OLD_CL_MAGIC_ADDR) {
-			printk("so old bootloader that it does not support commandline?!\n");
 			return;
 		}
 		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
-		printk("old bootloader convention, maybe loadlin?\n");
 	}
 	command_line = (char *) ((u64)(new_data));
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	printk("Bootdata ok (command line is %s)\n", saved_command_line);	
 }
 
 void __init x86_64_start_kernel(char * real_mode_data)
@@ -65,10 +62,7 @@ void __init x86_64_start_kernel(char * r
 	asm volatile("lidt %0" :: "m" (idt_descr));
 	clear_bss();
 
-	/*
-	 * This must be called really, really early:
-	 */
-	lockdep_init();
+	early_printk("Kernel alive\n");
 
 	/*
 	 * switch to init_level4_pgt from boot_level4_pgt
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -355,6 +355,8 @@ void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
 
+	printk(KERN_INFO "Command line: %s\n", saved_command_line);
+
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
