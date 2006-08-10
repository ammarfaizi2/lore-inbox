Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWHJUEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWHJUEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWHJUDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:03:55 -0400
Received: from ns.suse.de ([195.135.220.2]:63120 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932641AbWHJTgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:46 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [88/145] x86_64: Use early CPU identify before early command line parsing
Message-Id: <20060810193645.646AF13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:45 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This makes it possible to modify CPU flags in command line 
options without hacks. 

And remove another copy in head64.c

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/head64.c |   19 -------------------
 arch/x86_64/kernel/setup.c  |    4 ++--
 2 files changed, 2 insertions(+), 21 deletions(-)

Index: linux/arch/x86_64/kernel/head64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/head64.c
+++ linux/arch/x86_64/kernel/head64.c
@@ -56,24 +56,6 @@ static void __init copy_bootdata(char *r
 	printk("Bootdata ok (command line is %s)\n", saved_command_line);	
 }
 
-static void __init setup_boot_cpu_data(void)
-{
-	unsigned int dummy, eax;
-
-	/* get vendor info */
-	cpuid(0, (unsigned int *)&boot_cpu_data.cpuid_level,
-	      (unsigned int *)&boot_cpu_data.x86_vendor_id[0],
-	      (unsigned int *)&boot_cpu_data.x86_vendor_id[8],
-	      (unsigned int *)&boot_cpu_data.x86_vendor_id[4]);
-
-	/* get cpu type */
-	cpuid(1, &eax, &dummy, &dummy,
-		(unsigned int *) &boot_cpu_data.x86_capability);
-	boot_cpu_data.x86 = (eax >> 8) & 0xf;
-	boot_cpu_data.x86_model = (eax >> 4) & 0xf;
-	boot_cpu_data.x86_mask = eax & 0xf;
-}
-
 void __init x86_64_start_kernel(char * real_mode_data)
 {
 	char *s;
@@ -117,6 +99,5 @@ void __init x86_64_start_kernel(char * r
 	if (__pa_symbol(&_end) >= KERNEL_TEXT_SIZE)
 		panic("Kernel too big for kernel mapping\n");
 
-	setup_boot_cpu_data();
 	start_kernel();
 }
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -547,10 +547,10 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = virt_to_phys(&_etext);
 	data_resource.end = virt_to_phys(&_edata)-1;
 
-	parse_cmdline_early(cmdline_p);
-
 	early_identify_cpu(&boot_cpu_data);
 
+	parse_cmdline_early(cmdline_p);
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
