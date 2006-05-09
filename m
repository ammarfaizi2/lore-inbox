Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWEIItw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWEIItw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWEIItb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:31 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46723 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751547AbWEIItD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:03 -0400
Message-Id: <20060509085157.070289000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:23 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 23/35] Increase x86 interrupt vector range
Content-Disposition: inline; filename=x86-increase-interrupt-vector-range
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the limit of 256 interrupt vectors by changing the value
stored in orig_{e,r}ax to be the negated interrupt vector.
The orig_{e,r}ax needs to be < 0 to allow the signal code to
distinguish between return from interrupt and return from syscall.
With this change applied, NR_IRQS can be > 256.

Xen extends the IRQ numbering space to include room for dynamically
allocated virtual interrupts (in the range 256-511), which requires a
more permissive interface to do_IRQ.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/entry.S    |    4 ++--
 arch/i386/kernel/irq.c      |    4 ++--
 arch/x86_64/kernel/entry.S  |    2 +-
 arch/x86_64/kernel/irq.c    |    4 ++--
 arch/x86_64/kernel/smp.c    |    4 ++--
 include/asm-x86_64/hw_irq.h |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

--- linus-2.6.orig/arch/i386/kernel/entry.S
+++ linus-2.6/arch/i386/kernel/entry.S
@@ -464,7 +464,7 @@ vector=0
 ENTRY(irq_entries_start)
 .rept NR_IRQS
 	ALIGN
-1:	pushl $vector-256
+1:	pushl $~(vector)
 	jmp common_interrupt
 .data
 	.long 1b
@@ -481,7 +481,7 @@ common_interrupt:
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
-	pushl $nr-256;			\
+	pushl $~(nr);			\
 	SAVE_ALL			\
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
--- linus-2.6.orig/arch/i386/kernel/irq.c
+++ linus-2.6/arch/i386/kernel/irq.c
@@ -53,8 +53,8 @@ static union irq_ctx *softirq_ctx[NR_CPU
  */
 fastcall unsigned int do_IRQ(struct pt_regs *regs)
 {	
-	/* high bits used in ret_from_ code */
-	int irq = regs->orig_eax & 0xff;
+	/* high bit used in ret_from_ code */
+	int irq = ~regs->orig_eax;
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
--- linus-2.6.orig/arch/x86_64/kernel/entry.S
+++ linus-2.6/arch/x86_64/kernel/entry.S
@@ -601,7 +601,7 @@ retint_kernel:	
  */		
 	.macro apicinterrupt num,func
 	INTR_FRAME
-	pushq $\num-256
+	pushq $~(\num)
 	CFI_ADJUST_CFA_OFFSET 8
 	interrupt \func
 	jmp ret_from_intr
--- linus-2.6.orig/arch/x86_64/kernel/irq.c
+++ linus-2.6/arch/x86_64/kernel/irq.c
@@ -91,8 +91,8 @@ skip:
  */
 asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
 {	
-	/* high bits used in ret_from_ code  */
-	unsigned irq = regs->orig_rax & 0xff;
+	/* high bit used in ret_from_ code  */
+	unsigned irq = ~regs->orig_rax;
 
 	exit_idle();
 	irq_enter();
--- linus-2.6.orig/arch/x86_64/kernel/smp.c
+++ linus-2.6/arch/x86_64/kernel/smp.c
@@ -135,10 +135,10 @@ asmlinkage void smp_invalidate_interrupt
 
 	cpu = smp_processor_id();
 	/*
-	 * orig_rax contains the interrupt vector - 256.
+	 * orig_rax contains the negated interrupt vector.
 	 * Use that to determine where the sender put the data.
 	 */
-	sender = regs->orig_rax + 256 - INVALIDATE_TLB_VECTOR_START;
+	sender = ~regs->orig_rax - INVALIDATE_TLB_VECTOR_START;
 	f = &per_cpu(flush_state, sender);
 
 	if (!cpu_isset(cpu, f->flush_cpumask))
--- linus-2.6.orig/include/asm-x86_64/hw_irq.h
+++ linus-2.6/include/asm-x86_64/hw_irq.h
@@ -127,7 +127,7 @@ asmlinkage void IRQ_NAME(nr); \
 __asm__( \
 "\n.p2align\n" \
 "IRQ" #nr "_interrupt:\n\t" \
-	"push $" #nr "-256 ; " \
+	"push $~(" #nr ") ; " \
 	"jmp common_interrupt");
 
 #if defined(CONFIG_X86_IO_APIC)

--
