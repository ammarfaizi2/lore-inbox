Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTI1Som (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTI1Som
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:44:42 -0400
Received: from front3.chartermi.net ([24.213.60.109]:6537 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S262672AbTI1Sod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:44:33 -0400
Message-ID: <3F772C0F.10504@quark.didntduck.org>
Date: Sun, 28 Sep 2003 14:44:31 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
References: <Pine.LNX.4.44.0309281133120.15408-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309281133120.15408-100000@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040508060907000405090009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508060907000405090009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Brian Gerst wrote:
> 
>>Good point.  Wouldn't it just be better to change the few handlers to 
>>asmlinkage instead?  Having that stub function there is pointless.
> 
> 
> That would work, yes. One problem is that gcc doesn't do proper 
> type-checking on it, so it's open to problems. But I'd accept the patch.
> 
> 		Linus
> 

Updated patch.

--
				Brian Gerst

--------------040508060907000405090009
Content-Type: text/plain;
 name="mce-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mce-2"

diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/k7.c linux/arch/i386/kernel/cpu/mcheck/k7.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/k7.c	2003-09-28 10:20:05.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/k7.c	2003-09-28 14:37:06.308207128 -0400
@@ -17,7 +17,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For AMD Athlon/Duron */
-static void k7_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void k7_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.c linux/arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.c	2003-07-27 13:06:29.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/mce.c	2003-09-28 14:33:11.331928952 -0400
@@ -18,18 +18,13 @@
 int nr_mce_banks;
 
 /* Handle unconfigured int18 (should never happen) */
-static void unexpected_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void unexpected_machine_check(struct pt_regs * regs, long error_code)
 {	
 	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
 }
 
 /* Call the installed machine check handler for this CPU setup. */
-void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
-
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
-{
-	machine_check_vector(regs, error_code);
-}
+void asmlinkage (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
 void __init mcheck_init(struct cpuinfo_x86 *c)
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.h linux/arch/i386/kernel/cpu/mcheck/mce.h
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/mce.h	2003-07-27 12:57:41.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/mce.h	2003-09-28 14:33:17.421003272 -0400
@@ -7,7 +7,7 @@
 void winchip_mcheck_init(struct cpuinfo_x86 *c);
 
 /* Call the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *, long error_code);
+extern asmlinkage void (*machine_check_vector)(struct pt_regs *, long error_code);
 
 extern int mce_disabled __initdata;
 extern int nr_mce_banks;
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p4.c linux/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p4.c	2003-07-27 13:04:07.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2003-09-28 14:32:26.717711344 -0400
@@ -148,7 +148,7 @@
 	return mce_num_extended_msrs;
 }
 
-static void intel_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p5.c linux/arch/i386/kernel/cpu/mcheck/p5.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p5.c	2003-07-27 13:03:24.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p5.c	2003-09-28 14:32:33.271714984 -0400
@@ -16,7 +16,7 @@
 #include "mce.h"
 
 /* Machine check handler for Pentium class Intel */
-static void pentium_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void pentium_machine_check(struct pt_regs * regs, long error_code)
 {
 	u32 loaddr, hi, lotype;
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p6.c linux/arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/p6.c	2003-07-27 13:04:11.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p6.c	2003-09-28 14:32:39.256805112 -0400
@@ -16,7 +16,7 @@
 #include "mce.h"
 
 /* Machine Check Handler For PII/PIII */
-static void intel_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
diff -urN linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/winchip.c linux/arch/i386/kernel/cpu/mcheck/winchip.c
--- linux-2.6.0-test6/arch/i386/kernel/cpu/mcheck/winchip.c	2003-07-27 13:02:34.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/winchip.c	2003-09-28 14:32:45.437865448 -0400
@@ -15,7 +15,7 @@
 #include "mce.h"
 
 /* Machine check handler for WinChip C6 */
-static void winchip_machine_check(struct pt_regs * regs, long error_code)
+static asmlinkage void winchip_machine_check(struct pt_regs * regs, long error_code)
 {
 	printk(KERN_EMERG "CPU0: Machine Check Exception.\n");
 }
diff -urN linux-2.6.0-test6/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.6.0-test6/arch/i386/kernel/entry.S	2003-09-28 10:20:13.000000000 -0400
+++ linux/arch/i386/kernel/entry.S	2003-09-28 14:30:55.516576024 -0400
@@ -595,7 +595,7 @@
 #ifdef CONFIG_X86_MCE
 ENTRY(machine_check)
 	pushl $0
-	pushl $do_machine_check
+	pushl machine_check_vector
 	jmp error_code
 #endif
 

--------------040508060907000405090009--

