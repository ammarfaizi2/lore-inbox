Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUI2M4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUI2M4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUI2Myc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:54:32 -0400
Received: from mail.renesas.com ([202.234.163.13]:12966 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268360AbUI2MxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:53:09 -0400
Date: Wed, 29 Sep 2004 21:52:55 +0900 (JST)
Message-Id: <20040929.215255.276753506.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc2-mm4] [m32r] Architecture upgrade on 20040928
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miscellaneous upgrade for recent m32r kernel changes.
Please apply.

Thank you.

	* arch/m32r/kernel/entry.S:
	Add system calls; taken from asm-i386/unistd.h.
	- [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386  (05/31/2004)
	- [PATCH] Make key management use syscalls not prctls (09/06/2004)

	* arch/m32r/kernel/io_m32102.c: Remove.
	This file is no longer used. Please remove this file.
	
	* arch/m32r/kernel/irq.c: 
	- Fix the unnecessary entropy call in the irq handler.

	* arch/m32r/kernel/signal.c:
	- Merge common signal handling fault handling in generic code;
	  use force_sigsegv() instead of force_sig().

	* arch/m32r/kernel/smp.c:
	- Just add brackets.

	* include/asm-m32r/hardirq.h:
	- factor out common <asm/hardirq.h> code

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S     |   10 +
 arch/m32r/kernel/io_m32102.c |  277 -------------------------------------------
 arch/m32r/kernel/irq.c       |    8 -
 arch/m32r/kernel/signal.c    |   11 -
 arch/m32r/kernel/smp.c       |    3 
 include/asm-m32r/hardirq.h   |   30 ----
 6 files changed, 24 insertions(+), 315 deletions(-)


diff -ruNp a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
--- a/arch/m32r/kernel/entry.S	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/entry.S	2004-09-28 12:38:11.000000000 +0900
@@ -992,6 +992,16 @@ ENTRY(sys_call_table)
         .long sys_mq_notify
         .long sys_mq_getsetattr
         .long sys_ni_syscall            /* reserved for kexec */
+	.long sys_waitid
+	.long sys_perfctr_info
+	.long sys_vperfctr_open
+	.long sys_vperfctr_control
+	.long sys_vperfctr_unlink
+	.long sys_vperfctr_iresume
+	.long sys_vperfctr_read		/* 290 */
+	.long sys_add_key
+	.long sys_request_key
+	.long sys_keyctl
 
 syscall_table_size=(.-sys_call_table)
 
diff -ruNp a/arch/m32r/kernel/irq.c b/arch/m32r/kernel/irq.c
--- a/arch/m32r/kernel/irq.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/irq.c	2004-09-28 12:38:11.000000000 +0900
@@ -187,15 +187,17 @@ int handle_IRQ_event(unsigned int irq,
 		struct pt_regs *regs, struct irqaction *action)
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
-	int retval = 0;
+	int ret, retval = 0;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
 	do {
-		status |= action->flags;
-		retval |= action->handler(irq, action->dev_id, regs);
+		ret = action->handler(irq, action->dev_id, regs);
+		if (ret == IRQ_HANDLED)
+			status |= action->flags;
 		action = action->next;
+		retval |= ret;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
diff -ruNp a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
--- a/arch/m32r/kernel/signal.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/signal.c	2004-09-28 12:38:23.000000000 +0900
@@ -404,9 +404,7 @@ static void setup_frame(int sig, struct 
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -482,9 +480,7 @@ static void setup_rt_frame(int sig, stru
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
@@ -528,9 +524,6 @@ handle_signal(unsigned long sig, struct 
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
diff -ruNp a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
--- a/arch/m32r/kernel/smp.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/smp.c	2004-09-28 12:38:23.000000000 +0900
@@ -441,9 +441,10 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_IPI, 0);
 
-	while (!cpus_empty(flush_cpumask))
+	while (!cpus_empty(flush_cpumask)) {
 		/* nothing. lockup detection does not belong here */
 		mb();
+	}
 
 	flush_mm = NULL;
 	flush_vma = NULL;
diff -ruNp a/include/asm-m32r/hardirq.h b/include/asm-m32r/hardirq.h
--- a/include/asm-m32r/hardirq.h	2004-09-28 10:19:53.000000000 +0900
+++ b/include/asm-m32r/hardirq.h	2004-09-28 12:38:24.000000000 +0900
@@ -30,7 +30,12 @@ typedef struct {
 
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
+
+#if NR_IRQS > 256
+#define HARDIRQ_BITS	9
+#else
 #define HARDIRQ_BITS	8
+#endif
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
@@ -45,29 +50,10 @@ typedef struct {
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -76,10 +62,4 @@ do {									\
 		preempt_enable_no_resched();				\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
-
 #endif /* __ASM_HARDIRQ_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

