Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWGAO70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWGAO70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWGAO6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:58:00 -0400
Received: from www.osadl.org ([213.239.205.134]:19876 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751367AbWGAO4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:52 -0400
Message-Id: <20060701145223.436970000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, rth@twiddle.net
Subject: [RFC][patch 02/44] ALPHA: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-alpha.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/alpha/kernel/irq.c        |    4 ++--
 arch/alpha/kernel/irq_alpha.c  |    2 +-
 arch/alpha/kernel/sys_jensen.c |    2 +-
 arch/alpha/kernel/sys_titan.c  |   14 +++++++-------
 include/asm-alpha/floppy.h     |    2 +-
 include/asm-alpha/signal.h     |    2 --
 6 files changed, 12 insertions(+), 14 deletions(-)

Index: linux-2.6.git/include/asm-alpha/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-alpha/floppy.h	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/include/asm-alpha/floppy.h	2006-07-01 16:51:30.000000000 +0200
@@ -26,7 +26,7 @@
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_cacheflush(addr,size) /* nothing */
 #define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt,\
-					    SA_INTERRUPT, "floppy", NULL)
+					    IRQF_DISABLED, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #ifdef CONFIG_PCI
Index: linux-2.6.git/include/asm-alpha/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-alpha/signal.h	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/include/asm-alpha/signal.h	2006-07-01 16:51:30.000000000 +0200
@@ -77,7 +77,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -98,7 +97,6 @@ typedef unsigned long sigset_t;
 
 #define SA_ONESHOT	SA_RESETHAND
 #define SA_NOMASK	SA_NODEFER
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 /* 
  * sigaltstack controls
Index: linux-2.6.git/arch/alpha/kernel/irq_alpha.c
===================================================================
--- linux-2.6.git.orig/arch/alpha/kernel/irq_alpha.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/alpha/kernel/irq_alpha.c	2006-07-01 16:51:30.000000000 +0200
@@ -214,7 +214,7 @@ static unsigned int rtc_startup(unsigned
 
 struct irqaction timer_irqaction = {
 	.handler	= timer_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "timer",
 };
 
Index: linux-2.6.git/arch/alpha/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/alpha/kernel/irq.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/alpha/kernel/irq.c	2006-07-01 16:51:30.000000000 +0200
@@ -94,12 +94,12 @@ show_interrupts(struct seq_file *p, void
 #endif
 		seq_printf(p, " %14s", irq_desc[irq].chip->typename);
 		seq_printf(p, "  %c%s",
-			(action->flags & SA_INTERRUPT)?'+':' ',
+			(action->flags & IRQF_DISABLED)?'+':' ',
 			action->name);
 
 		for (action=action->next; action; action = action->next) {
 			seq_printf(p, ", %c%s",
-				  (action->flags & SA_INTERRUPT)?'+':' ',
+				  (action->flags & IRQF_DISABLED)?'+':' ',
 				   action->name);
 		}
 
Index: linux-2.6.git/arch/alpha/kernel/sys_jensen.c
===================================================================
--- linux-2.6.git.orig/arch/alpha/kernel/sys_jensen.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/alpha/kernel/sys_jensen.c	2006-07-01 16:51:30.000000000 +0200
@@ -74,7 +74,7 @@ jensen_local_startup(unsigned int irq)
 		 * the IPL from being dropped during handler processing.
 		 */
 		if (irq_desc[irq].action)
-			irq_desc[irq].action->flags |= SA_INTERRUPT;
+			irq_desc[irq].action->flags |= IRQF_DISABLED;
 	return 0;
 }
 
Index: linux-2.6.git/arch/alpha/kernel/sys_titan.c
===================================================================
--- linux-2.6.git.orig/arch/alpha/kernel/sys_titan.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/alpha/kernel/sys_titan.c	2006-07-01 16:51:30.000000000 +0200
@@ -279,15 +279,15 @@ titan_late_init(void)
 	 * all reported to the kernel as machine checks, so the handler
 	 * is a nop so it can be called to count the individual events.
 	 */
-	request_irq(63+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(63+16, titan_intr_nop, IRQF_DISABLED, 
 		    "CChip Error", NULL);
-	request_irq(62+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(62+16, titan_intr_nop, IRQF_DISABLED, 
 		    "PChip 0 H_Error", NULL);
-	request_irq(61+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(61+16, titan_intr_nop, IRQF_DISABLED, 
 		    "PChip 1 H_Error", NULL);
-	request_irq(60+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(60+16, titan_intr_nop, IRQF_DISABLED, 
 		    "PChip 0 C_Error", NULL);
-	request_irq(59+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(59+16, titan_intr_nop, IRQF_DISABLED, 
 		    "PChip 1 C_Error", NULL);
 
 	/* 
@@ -348,9 +348,9 @@ privateer_init_pci(void)
 	 * Hook a couple of extra err interrupts that the
 	 * common titan code won't.
 	 */
-	request_irq(53+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(53+16, titan_intr_nop, IRQF_DISABLED, 
 		    "NMI", NULL);
-	request_irq(50+16, titan_intr_nop, SA_INTERRUPT, 
+	request_irq(50+16, titan_intr_nop, IRQF_DISABLED, 
 		    "Temperature Warning", NULL);
 
 	/*

--

