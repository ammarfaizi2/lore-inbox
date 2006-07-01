Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWGAO6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWGAO6A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWGAO56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:58 -0400
Received: from www.osadl.org ([213.239.205.134]:21156 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751355AbWGAO4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:53 -0400
Message-Id: <20060701145223.552113000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:22 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, spyro@f2s.com
Subject: [RFC][patch 03/44] ARM26: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-arm26.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/arm26/kernel/irq.c    |   16 ++++++++--------
 arch/arm26/kernel/time.c   |    2 +-
 include/asm-arm26/floppy.h |    2 +-
 include/asm-arm26/signal.h |    2 --
 4 files changed, 10 insertions(+), 12 deletions(-)

Index: linux-2.6.git/include/asm-arm26/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm26/floppy.h	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/include/asm-arm26/floppy.h	2006-07-01 16:51:30.000000000 +0200
@@ -22,7 +22,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					SA_INTERRUPT,"floppy",NULL)
+					IRQF_DISABLED,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
Index: linux-2.6.git/include/asm-arm26/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm26/signal.h	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/include/asm-arm26/signal.h	2006-07-01 16:51:30.000000000 +0200
@@ -82,7 +82,6 @@ typedef unsigned long sigset_t;
  *			is running in 26-bit.
  * SA_ONSTACK		allows alternate signal stacks (see sigaltstack(2)).
  * SA_RESTART		flag to get restarting signals (which were the default long ago)
- * SA_INTERRUPT		is a no-op, but left due to historical reasons. Use the
  * SA_NODEFER		prevents the current signal from being masked in the handler.
  * SA_RESETHAND		clears the handler when the signal is delivered.
  *
@@ -101,7 +100,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 
 /* 
Index: linux-2.6.git/arch/arm26/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/arm26/kernel/irq.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/arm26/kernel/irq.c	2006-07-01 16:51:30.000000000 +0200
@@ -190,7 +190,7 @@ __do_irq(unsigned int irq, struct irqact
 	int ret;
 
 	spin_unlock(&irq_controller_lock);
-	if (!(action->flags & SA_INTERRUPT))
+	if (!(action->flags & IRQF_DISABLED))
 		local_irq_enable();
 
 	status = 0;
@@ -201,7 +201,7 @@ __do_irq(unsigned int irq, struct irqact
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
+	if (status & IRQF_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 
 	spin_lock_irq(&irq_controller_lock);
@@ -451,7 +451,7 @@ int setup_irq(unsigned int irq, struct i
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
+	if (new->flags & IRQF_SAMPLE_RANDOM) {
 		/*
 		 * This function might sleep, we want to call it first,
 		 * outside of the atomic block.
@@ -471,7 +471,7 @@ int setup_irq(unsigned int irq, struct i
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
+		if (!(old->flags & new->flags & IRQF_SHARED)) {
 			spin_unlock_irqrestore(&irq_controller_lock, flags);
 			return -EBUSY;
 		}
@@ -526,11 +526,11 @@ int setup_irq(unsigned int irq, struct i
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
 
@@ -542,7 +542,7 @@ int request_irq(unsigned int irq, irqret
 	struct irqaction *action;
 
 	if (irq >= NR_IRQS || !irq_desc[irq].valid || !handler ||
-	    (irq_flags & SA_SHIRQ && !dev_id))
+	    (irq_flags & IRQF_SHARED && !dev_id))
 		return -EINVAL;
 
 	action = (struct irqaction *)kmalloc(sizeof(struct irqaction), GFP_KERNEL);
Index: linux-2.6.git/arch/arm26/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/arm26/kernel/time.c	2006-07-01 16:51:29.000000000 +0200
+++ linux-2.6.git/arch/arm26/kernel/time.c	2006-07-01 16:51:30.000000000 +0200
@@ -205,7 +205,7 @@ static irqreturn_t timer_interrupt(int i
 
 static struct irqaction timer_irq = {
 	.name	= "timer",
-	.flags	= SA_INTERRUPT,
+	.flags	= IRQF_DISABLED,
 	.handler = timer_interrupt,
 };
 

--

