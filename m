Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIUIY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIUIY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIUIY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:24:57 -0400
Received: from zero.aec.at ([193.170.194.10]:63750 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267517AbUIUIYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:24:45 -0400
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add tainted bit for machine checks
From: Andi Kleen <ak@muc.de>
Date: Tue, 21 Sep 2004 10:24:41 +0200
Message-ID: <m3isa8av1y.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a new "M" tainted bit in oopses for machine checks.

This shows in a oops when the machine had already a machine check.
That information may be useful to see if the machine has hardware
trouble and if it's really worth to invest much time into a
mysterious oops.

Support for i386 and x86-64 so far.

Index: linux/arch/x86_64/kernel/mce.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mce.c	2004-09-13 22:19:22.%N +0200
+++ linux/arch/x86_64/kernel/mce.c	2004-09-21 10:15:55.%N +0200
@@ -227,6 +227,7 @@
 	}
 
  out:
+	tainted |= TAINT_MACHINE_CHECK;
 	/* Last thing done in the machine check exception to clear state. */
 	wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
Index: linux/kernel/panic.c
===================================================================
--- linux.orig/kernel/panic.c	2004-09-13 22:18:13.%N +0200
+++ linux/kernel/panic.c	2004-09-21 10:16:24.%N +0200
@@ -111,6 +111,7 @@
  *  'P' - Proprietary module has been loaded.
  *  'F' - Module has been forcibly loaded.
  *  'S' - SMP with CPUs not designed for SMP.
+ *  'M' - Machine had a machine check experience.
  *
  *	The string is overwritten by the next call to print_taint().
  */
@@ -119,7 +120,8 @@
 {
 	static char buf[20];
 	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c",
+ 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
 			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
 			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
 			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h	2004-09-13 22:18:13.%N +0200
+++ linux/include/linux/kernel.h	2004-09-21 10:15:55.%N +0200
@@ -141,6 +141,7 @@
 	SYSTEM_RESTART,
 } system_state;
 
+#define TAINT_MACHINE_CHECK		(1<<10)
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
Index: linux/arch/i386/kernel/cpu/mcheck/k7.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/k7.c	2004-03-21 21:12:03.%N +0100
+++ linux/arch/i386/kernel/cpu/mcheck/k7.c	2004-09-21 10:15:55.%N +0200
@@ -64,6 +64,8 @@
 	printk (KERN_EMERG "Attempting to continue.\n");
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+
+	tainted |= TAINT_MACHINE_CHECK;
 }
 
 
Index: linux/arch/i386/kernel/cpu/mcheck/p6.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/p6.c	2004-03-21 21:12:03.%N +0100
+++ linux/arch/i386/kernel/cpu/mcheck/p6.c	2004-09-21 10:15:55.%N +0200
@@ -76,6 +76,8 @@
 	}
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+
+	tainted |= TAINT_MACHINE_CHECK;
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
Index: linux/arch/i386/kernel/cpu/mcheck/p4.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/p4.c	2004-06-16 12:22:43.%N +0200
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2004-09-21 10:15:55.%N +0200
@@ -226,6 +226,8 @@
 	}
 	mcgstl &= ~(1<<2);
 	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+
+	tainted |= TAINT_MACHINE_CHECK;
 }
 
 
Index: linux/arch/i386/kernel/cpu/mcheck/p5.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/p5.c	2004-03-21 21:12:03.%N +0100
+++ linux/arch/i386/kernel/cpu/mcheck/p5.c	2004-09-21 10:15:55.%N +0200
@@ -25,6 +25,8 @@
 	printk(KERN_EMERG "CPU#%d: Machine Check Exception:  0x%8X (type 0x%8X).\n", smp_processor_id(), loaddr, lotype);
 	if(lotype&(1<<5))
 		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU on fire ?).\n", smp_processor_id());
+
+	tainted |= TAINT_MACHINE_CHECK;
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
Index: linux/arch/i386/kernel/cpu/mcheck/winchip.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/winchip.c	2004-03-21 21:12:03.%N +0100
+++ linux/arch/i386/kernel/cpu/mcheck/winchip.c	2004-09-21 10:15:55.%N +0200
@@ -19,6 +19,7 @@
 static asmlinkage void winchip_machine_check(struct pt_regs * regs, long error_code)
 {
 	printk(KERN_EMERG "CPU0: Machine Check Exception.\n");
+	tainted |= TAINT_MACHINE_CHECK;
 }
 
 /* Set up machine check reporting on the Winchip C6 series */

