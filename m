Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUIMNDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUIMNDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIMNDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:03:44 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2017 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266657AbUIMNC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:02:59 -0400
Date: Mon, 13 Sep 2004 15:02:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: hch@lst.df
Cc: akpm@osdl.org, spyro@f2s.com, rmk@arm.linux.org.uk, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_enter/irq_exit consolidation
Message-ID: <20040913130239.GA3086@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> s390 has an assembly wrapper around do_softirq.
> 
> I've extended the invoke_softirq mechanism used by s390 (also called
> by ksoftirqd) to the two arm variants, but the right thing to do is
> probably to use the normal do_softirq call in arm and set
> __ARCH_HAS_DO_SOFTIRQ + providing a per-arch do_softirq for all callers
> for s390 and maybe arm26.

do_call_softirq switches to the asynchronous interrupt stack,
just what i386 does now as well. Trouble is that on s390 it is
non-trivial to do the switch in C with inline assembly. We need
a bit of assembly. But we could get rid of invoke_softirq, define
__ARCH_HAS_DO_SOFTIRQ and use do_softirq to call the assembly
wrapper.

blue skies,
  Martin.

---

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Replace invoke_softirq mechanism by __ARCH_HAS_DO_SOFTIRQ
mechanism for s390.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S      |    4 +---
 arch/s390/kernel/entry64.S    |    4 +---
 arch/s390/kernel/s390_ext.c   |    1 +
 arch/s390/kernel/s390_ksyms.c |    1 -
 arch/s390/kernel/setup.c      |   20 ++++++++++++++++++++
 include/asm-s390/hardirq.h    |    3 +--
 6 files changed, 24 insertions(+), 9 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2004-09-13 14:30:42.000000000 +0200
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	2004-09-13 14:21:29.000000000 +0200
@@ -153,7 +153,6 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stnsm	__SF_EMPTY(%r15),0xfc
 	stmg	%r12,%r15,__SF_GPRS(%r15)
 	lgr	%r12,%r15
 	lg	%r0,__LC_ASYNC_STACK
@@ -163,9 +162,8 @@
 	lg	%r15,__LC_ASYNC_STACK
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	stg	%r12,__SF_BACKCHAIN(%r15)	# store back chain
-	brasl	%r14,do_softirq
+	brasl	%r14,__do_softirq
 	lmg	%r12,%r15,__SF_GPRS(%r12)
-	ssm	__SF_EMPTY(%r15)
 	br	%r14
 
 __critical_start:
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2004-09-13 14:30:42.000000000 +0200
+++ linux-2.6-s390/arch/s390/kernel/entry.S	2004-09-13 14:21:29.000000000 +0200
@@ -156,7 +156,6 @@
  */
 	.global do_call_softirq
 do_call_softirq:
-	stnsm	__SF_EMPTY(%r15),0xfc
 	stm	%r12,%r15,__SF_GPRS(%r15)
 	lr	%r12,%r15
         basr    %r13,0
@@ -171,7 +170,6 @@
 	l	%r1,.Ldo_softirq-do_call_base(%r13)
 	basr	%r14,%r1
 	lm	%r12,%r15,__SF_GPRS(%r12)
-	ssm	__SF_EMPTY(%r15)
 	br	%r14
 
 __critical_start:
@@ -733,7 +731,7 @@
 .Ldo_IRQ:      .long  do_IRQ
 .Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
-.Ldo_softirq:  .long  do_softirq
+.Ldo_softirq:  .long  __do_softirq
 .Lhandle_per:  .long  do_single_step
 .Ljump_table:  .long  pgm_check_table
 .Lschedule:    .long  schedule
diff -urN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-s390/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-s390/arch/s390/kernel/s390_ext.c	2004-09-13 14:34:14.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
 
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
diff -urN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	2004-09-13 14:03:55.000000000 +0200
+++ linux-2.6-s390/arch/s390/kernel/s390_ksyms.c	2004-09-13 14:33:34.000000000 +0200
@@ -61,6 +61,5 @@
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_devno);
 EXPORT_SYMBOL(console_irq);
-EXPORT_SYMBOL(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
 EXPORT_SYMBOL(cpcmd);
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2004-09-13 14:30:42.000000000 +0200
+++ linux-2.6-s390/arch/s390/kernel/setup.c	2004-09-13 14:31:53.000000000 +0200
@@ -654,3 +654,23 @@
 {
 	/* nothing... */
 }
+
+extern void do_call_softirq(void);
+
+asmlinkage void do_softirq(void)
+{
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	if (local_softirq_pending())
+		/* Call __do_softirq on asynchromous interrupt stack. */
+		do_call_softirq();
+
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(do_softirq);
diff -urN linux-2.6/include/asm-s390/hardirq.h linux-2.6-s390/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	2004-09-13 14:30:42.000000000 +0200
+++ linux-2.6-s390/include/asm-s390/hardirq.h	2004-09-13 14:31:42.000000000 +0200
@@ -61,9 +61,8 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-extern void do_call_softirq(void);
 extern void account_ticks(struct pt_regs *);
 
-#define invoke_softirq() do_call_softirq()
+#define __ARCH_HAS_DO_SOFTIRQ
 
 #endif /* __ASM_HARDIRQ_H */
