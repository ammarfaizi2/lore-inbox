Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUKORn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUKORn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKORn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:43:59 -0500
Received: from quark.didntduck.org ([69.55.226.66]:24537 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261544AbUKORmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:42:14 -0500
Message-ID: <4198EA70.202@quark.didntduck.org>
Date: Mon, 15 Nov 2004 12:42:08 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Regparm for x86 machine check handlers
Content-Type: multipart/mixed;
 boundary="------------090809080704040309040601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090809080704040309040601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The patch to change traps and interrupts to the fastcall convention 
missed the machine check handlers.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------090809080704040309040601
Content-Type: text/plain;
 name="mcheck-fastcall"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcheck-fastcall"

diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/k7.c linux/arch/i386/kernel/cpu/mcheck/k7.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/k7.c	2004-10-22 22:59:22.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/k7.c	2004-11-06 19:14:22.000000000 -0500
@@ -18,7 +18,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For AMD Athlon/Duron */
-static asmlinkage void k7_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void k7_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/mce.c linux/arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/mce.c	2004-06-23 18:05:51.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/mce.c	2004-11-06 19:14:38.000000000 -0500
@@ -22,13 +22,13 @@
 EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
 
 /* Handle unconfigured int18 (should never happen) */
-static asmlinkage void unexpected_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void unexpected_machine_check(struct pt_regs * regs, long error_code)
 {	
 	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
 }
 
 /* Call the installed machine check handler for this CPU setup. */
-void asmlinkage (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
+void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
 void __init mcheck_init(struct cpuinfo_x86 *c)
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/mce.h linux/arch/i386/kernel/cpu/mcheck/mce.h
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/mce.h	2003-12-17 21:58:15.000000000 -0500
+++ linux/arch/i386/kernel/cpu/mcheck/mce.h	2004-11-06 19:15:18.000000000 -0500
@@ -7,7 +7,7 @@
 void winchip_mcheck_init(struct cpuinfo_x86 *c);
 
 /* Call the installed machine check handler for this CPU setup. */
-extern asmlinkage void (*machine_check_vector)(struct pt_regs *, long error_code);
+extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
 
 extern int mce_disabled __initdata;
 extern int nr_mce_banks;
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p4.c linux/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p4.c	2004-11-06 20:02:10.000000000 -0500
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2004-11-06 19:14:46.000000000 -0500
@@ -159,7 +159,7 @@
 	return mce_num_extended_msrs;
 }
 
-static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void intel_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p5.c linux/arch/i386/kernel/cpu/mcheck/p5.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p5.c	2004-10-22 22:59:22.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p5.c	2004-11-06 19:14:52.000000000 -0500
@@ -17,7 +17,7 @@
 #include "mce.h"
 
 /* Machine check handler for Pentium class Intel */
-static asmlinkage void pentium_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void pentium_machine_check(struct pt_regs * regs, long error_code)
 {
 	u32 loaddr, hi, lotype;
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p6.c linux/arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/p6.c	2004-10-22 22:59:22.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p6.c	2004-11-06 19:14:57.000000000 -0500
@@ -17,7 +17,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For PII/PIII */
-static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void intel_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/winchip.c linux/arch/i386/kernel/cpu/mcheck/winchip.c
--- linux-2.6.10-rc1-bk/arch/i386/kernel/cpu/mcheck/winchip.c	2004-10-22 22:59:22.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/winchip.c	2004-11-06 19:15:01.000000000 -0500
@@ -16,7 +16,7 @@
 #include "mce.h"
 
 /* Machine check handler for WinChip C6 */
-static asmlinkage void winchip_machine_check(struct pt_regs * regs, long error_code)
+static fastcall void winchip_machine_check(struct pt_regs * regs, long error_code)
 {
 	printk(KERN_EMERG "CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK);

--------------090809080704040309040601--
