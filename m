Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265699AbSKATny>; Fri, 1 Nov 2002 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265367AbSKATny>; Fri, 1 Nov 2002 14:43:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65428 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265699AbSKATnp>;
	Fri, 1 Nov 2002 14:43:45 -0500
Subject: [PATCH] linux-2.5.45_notsc-warning_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Nov 2002 11:49:01 -0800
Message-Id: <1036180141.12714.141.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, all,
	This patch is a minor cleanup that removes two instances of
CONFIG_X86_TSC (lets the compiler optimize it out), and adds a warning
message should anyone pass "notsc" to a kernel compiled w/
CONFIG_X86_TSC (which ignores it). 

This is basically a forward port of a patch I got into 2.4 a while back.
Please apply.

thanks
-john


diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Fri Nov  1 11:43:09 2002
+++ b/arch/i386/kernel/cpu/common.c	Fri Nov  1 11:43:09 2002
@@ -51,9 +51,16 @@
 	tsc_disable = 1;
 	return 1;
 }
+#else
+#define tsc_disable 0
 
-__setup("notsc", tsc_setup);
+static int __init tsc_setup(char *str)
+{
+	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
+	return 1;
+}
 #endif
+__setup("notsc", tsc_setup);
 
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
@@ -304,10 +311,8 @@
 	 */
 
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, c->x86_capability);
-#endif
 
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
@@ -443,14 +448,12 @@
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
 	if (tsc_disable && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
-#endif
 
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,

