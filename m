Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWGAPA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWGAPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWGAO5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:49 -0400
Received: from www.osadl.org ([213.239.205.134]:25508 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751416AbWGAO44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:56 -0400
Message-Id: <20060701145223.906300000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:26 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, dhowells@redhat.com
Subject: [RFC][patch 06/44] FRV: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-frv.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/frv/kernel/irq-routing.c |    4 ++--
 arch/frv/kernel/irq.c         |   12 ++++++------
 arch/frv/kernel/time.c        |    2 +-
 include/asm-frv/irq-routing.h |    2 +-
 include/asm-frv/signal.h      |    2 --
 5 files changed, 10 insertions(+), 12 deletions(-)

Index: linux-2.6.git/include/asm-frv/irq-routing.h
===================================================================
--- linux-2.6.git.orig/include/asm-frv/irq-routing.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-frv/irq-routing.h	2006-07-01 16:51:32.000000000 +0200
@@ -51,7 +51,7 @@ struct irq_source {
 struct irq_level {
 	int			usage;
 	int			disable_count;
-	unsigned long		flags;		/* current SA_INTERRUPT and SA_SHIRQ settings */
+	unsigned long		flags;		/* current IRQF_DISABLED and IRQF_SHARED settings */
 	spinlock_t		lock;
 	struct irq_source	*sources;
 };
Index: linux-2.6.git/include/asm-frv/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-frv/signal.h	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/include/asm-frv/signal.h	2006-07-01 16:51:32.000000000 +0200
@@ -74,7 +74,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -94,7 +93,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/arch/frv/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/frv/kernel/irq.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/frv/kernel/irq.c	2006-07-01 16:51:32.000000000 +0200
@@ -341,11 +341,11 @@ asmlinkage void do_NMI(void)
  *
  *	Flags:
  *
- *	SA_SHIRQ		Interrupt is shared
+ *	IRQF_SHARED		Interrupt is shared
  *
- *	SA_INTERRUPT		Disable local interrupts while processing
+ *	IRQF_DISABLED	Disable local interrupts while processing
  *
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
+ *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
 
@@ -365,7 +365,7 @@ int request_irq(unsigned int irq,
 	 * to figure out which interrupt is which (messes up the
 	 * interrupt freeing logic etc).
 	 */
-	if (irqflags & SA_SHIRQ) {
+	if (irqflags & IRQF_SHARED) {
 		if (!dev_id)
 			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n",
 			       devname, (&irq)[-1]);
@@ -576,7 +576,7 @@ int setup_irq(unsigned int irq, struct i
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
+	if (new->flags & IRQF_SAMPLE_RANDOM) {
 		/*
 		 * This function might sleep, we want to call it first,
 		 * outside of the atomic block.
@@ -592,7 +592,7 @@ int setup_irq(unsigned int irq, struct i
 	spin_lock_irqsave(&level->lock, flags);
 
 	/* can't share interrupts unless all parties agree to */
-	if (level->usage != 0 && !(level->flags & new->flags & SA_SHIRQ)) {
+	if (level->usage != 0 && !(level->flags & new->flags & IRQF_SHARED)) {
 		spin_unlock_irqrestore(&level->lock,flags);
 		return -EBUSY;
 	}
Index: linux-2.6.git/arch/frv/kernel/irq-routing.c
===================================================================
--- linux-2.6.git.orig/arch/frv/kernel/irq-routing.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/frv/kernel/irq-routing.c	2006-07-01 16:51:32.000000000 +0200
@@ -81,7 +81,7 @@ void distribute_irqs(struct irq_group *g
 		if (action) {
 			int status = 0;
 
-//			if (!(action->flags & SA_INTERRUPT))
+//			if (!(action->flags & IRQF_DISABLED))
 //				local_irq_enable();
 
 			do {
@@ -90,7 +90,7 @@ void distribute_irqs(struct irq_group *g
 				action = action->next;
 			} while (action);
 
-			if (status & SA_SAMPLE_RANDOM)
+			if (status & IRQF_SAMPLE_RANDOM)
 				add_interrupt_randomness(irq);
 			local_irq_disable();
 		}
Index: linux-2.6.git/arch/frv/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/frv/kernel/time.c	2006-07-01 16:51:27.000000000 +0200
+++ linux-2.6.git/arch/frv/kernel/time.c	2006-07-01 16:51:32.000000000 +0200
@@ -47,7 +47,7 @@ unsigned long __delay_loops_MHz;
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs *regs);
 
 static struct irqaction timer_irq  = {
-	timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL
+	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
 static inline int set_rtc_mmss(unsigned long nowtime)

--

