Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbUKTAxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUKTAxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKTAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:51:54 -0500
Received: from quark.didntduck.org ([69.55.226.66]:38366 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262818AbUKTAlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:41:22 -0500
Message-ID: <419E92A7.5010005@didntduck.org>
Date: Fri, 19 Nov 2004 19:41:11 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fastcall fixes for x86 smp interrupts
Content-Type: multipart/mixed;
 boundary="------------060704030804080202030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060704030804080202030506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I cross-checked the functions called by the BUILD_INTERRUPT macros and 
came up with this patch.  Even though some of these functions currently 
take no args I made them all consistent.  Some functions in the Voyager 
code that are not directly called from asm code become static.

Signed-off by: Brian Gerst <bgerst@didntduck.org>

--------------060704030804080202030506
Content-Type: text/plain;
 name="smp-fastcall"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-fastcall"

diff -urN linux-2.6.10-rc2-bk/arch/i386/kernel/apic.c linux/arch/i386/kernel/apic.c
--- linux-2.6.10-rc2-bk/arch/i386/kernel/apic.c	2004-11-19 01:55:46.000000000 -0500
+++ linux/arch/i386/kernel/apic.c	2004-11-19 14:33:13.954969299 -0500
@@ -1149,7 +1149,7 @@
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
 
-void smp_apic_timer_interrupt(struct pt_regs regs)
+fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
@@ -1169,14 +1169,14 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
 
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
  */
-asmlinkage void smp_spurious_interrupt(void)
+fastcall void smp_spurious_interrupt(struct pt_regs *regs)
 {
 	unsigned long v;
 
@@ -1200,7 +1200,7 @@
  * This interrupt should never happen with our APIC/SMP architecture
  */
 
-asmlinkage void smp_error_interrupt(void)
+fastcall void smp_error_interrupt(struct pt_regs *regs)
 {
 	unsigned long v, v1;
 
diff -urN linux-2.6.10-rc2-bk/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- linux-2.6.10-rc2-bk/arch/i386/kernel/smp.c	2004-11-19 01:55:46.000000000 -0500
+++ linux/arch/i386/kernel/smp.c	2004-11-19 14:33:13.954969299 -0500
@@ -308,7 +308,7 @@
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
 
-asmlinkage void smp_invalidate_interrupt (void)
+fastcall void smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
 
@@ -579,12 +579,12 @@
  * all the work is done automatically when
  * we return from the interrupt.
  */
-asmlinkage void smp_reschedule_interrupt(void)
+fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
 }
 
-asmlinkage void smp_call_function_interrupt(void)
+fastcall void smp_call_function_interrupt(struct pt_regs *regs)
 {
 	void (*func) (void *info) = call_data->func;
 	void *info = call_data->info;
diff -urN linux-2.6.10-rc2-bk/arch/i386/mach-voyager/voyager_smp.c linux/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.10-rc2-bk/arch/i386/mach-voyager/voyager_smp.c	2004-10-18 20:34:13.000000000 -0400
+++ linux/arch/i386/mach-voyager/voyager_smp.c	2004-11-19 14:33:13.956968863 -0500
@@ -785,8 +785,8 @@
  * System interrupts occur because some problem was detected on the
  * various busses.  To find out what you have to probe all the
  * hardware via the CAT bus.  FIXME: At the moment we do nothing. */
-asmlinkage void
-smp_vic_sys_interrupt(void)
+fastcall void
+smp_vic_sys_interrupt(struct pt_regs *regs)
 {
 	ack_CPI(VIC_SYS_INT);
 	printk("Voyager SYSTEM INTERRUPT\n");
@@ -795,8 +795,8 @@
 /* Handle a voyager CMN_INT; These interrupts occur either because of
  * a system status change or because a single bit memory error
  * occurred.  FIXME: At the moment, ignore all this. */
-asmlinkage void
-smp_vic_cmn_interrupt(void)
+fastcall void
+smp_vic_cmn_interrupt(struct pt_regs *regs)
 {
 	static __u8 in_cmn_int = 0;
 	static spinlock_t cmn_int_lock = SPIN_LOCK_UNLOCKED;
@@ -824,7 +824,7 @@
 /*
  * Reschedule call back. Nothing to do, all the work is done
  * automatically when we return from the interrupt.  */
-asmlinkage void
+static void
 smp_reschedule_interrupt(void)
 {
 	/* do nothing */
@@ -855,7 +855,7 @@
 /*
  * Invalidate call-back
  */
-asmlinkage void 
+static void 
 smp_invalidate_interrupt(void)
 {
 	__u8 cpu = smp_processor_id();
@@ -989,7 +989,7 @@
 }
 
 /* enable the requested IRQs */
-asmlinkage void
+static void
 smp_enable_irq_interrupt(void)
 {
 	__u8 irq;
@@ -1038,7 +1038,7 @@
  * previously set up.  This is used to schedule a function for
  * execution on all CPU's - set up the function then broadcast a
  * function_interrupt CPI to come here on each CPU */
-asmlinkage void
+static void
 smp_call_function_interrupt(void)
 {
 	void (*func) (void *info) = call_data->func;
@@ -1133,50 +1133,50 @@
  * no local APIC, so I can't do this
  *
  * This function is currently a placeholder and is unused in the code */
-asmlinkage void 
-smp_apic_timer_interrupt(struct pt_regs regs)
+fastcall void 
+smp_apic_timer_interrupt(struct pt_regs *regs)
 {
-	wrapper_smp_local_timer_interrupt(&regs);
+	wrapper_smp_local_timer_interrupt(regs);
 }
 
 /* All of the QUAD interrupt GATES */
-asmlinkage void
-smp_qic_timer_interrupt(struct pt_regs regs)
+fastcall void
+smp_qic_timer_interrupt(struct pt_regs *regs)
 {
 	ack_QIC_CPI(QIC_TIMER_CPI);
-	wrapper_smp_local_timer_interrupt(&regs);
+	wrapper_smp_local_timer_interrupt(regs);
 }
 
-asmlinkage void
-smp_qic_invalidate_interrupt(void)
+fastcall void
+smp_qic_invalidate_interrupt(struct pt_regs *regs)
 {
 	ack_QIC_CPI(QIC_INVALIDATE_CPI);
 	smp_invalidate_interrupt();
 }
 
-asmlinkage void
-smp_qic_reschedule_interrupt(void)
+fastcall void
+smp_qic_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_QIC_CPI(QIC_RESCHEDULE_CPI);
 	smp_reschedule_interrupt();
 }
 
-asmlinkage void
-smp_qic_enable_irq_interrupt(void)
+fastcall void
+smp_qic_enable_irq_interrupt(struct pt_regs *regs)
 {
 	ack_QIC_CPI(QIC_ENABLE_IRQ_CPI);
 	smp_enable_irq_interrupt();
 }
 
-asmlinkage void
-smp_qic_call_function_interrupt(void)
+fastcall void
+smp_qic_call_function_interrupt(struct pt_regs *regs)
 {
 	ack_QIC_CPI(QIC_CALL_FUNCTION_CPI);
 	smp_call_function_interrupt();
 }
 
-asmlinkage void
-smp_vic_cpi_interrupt(struct pt_regs regs)
+fastcall void
+smp_vic_cpi_interrupt(struct pt_regs *regs)
 {
 	__u8 cpu = smp_processor_id();
 
@@ -1186,7 +1186,7 @@
 		ack_VIC_CPI(VIC_CPI_LEVEL0);
 
 	if(test_and_clear_bit(VIC_TIMER_CPI, &vic_cpi_mailbox[cpu]))
-		wrapper_smp_local_timer_interrupt(&regs);
+		wrapper_smp_local_timer_interrupt(regs);
 	if(test_and_clear_bit(VIC_INVALIDATE_CPI, &vic_cpi_mailbox[cpu]))
 		smp_invalidate_interrupt();
 	if(test_and_clear_bit(VIC_RESCHEDULE_CPI, &vic_cpi_mailbox[cpu]))

--------------060704030804080202030506--
