Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSG0Sk5>; Sat, 27 Jul 2002 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318803AbSG0Sk5>; Sat, 27 Jul 2002 14:40:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24714 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318802AbSG0Sk4>;
	Sat, 27 Jul 2002 14:40:56 -0400
Date: Sat, 27 Jul 2002 20:43:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] Re: Serial Oopsen caused by global IRQ chanes
In-Reply-To: <20020727191119.C32766@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207272034210.19384-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes a synchronize_irq() bug: if the interrupt is 
freed while an IRQ handler is running (irq state is IRQ_INPROGRESS) then 
synchronize_irq() will return early, which is incorrect.

there was another do_IRQ() bug that in fact necessiated the bad code that
caused the synchronize_irq() bug - we kept the IRQ_INPROGRESS bit set for
not active interrupt sources - after they happen for the first time. Now
the only effect this has is on i8259A irq handling - we used to keep these
irqs disabled after the first 'spurious' interrupt happened.  Now what the
i8259A code really wants to do IMO is to keep the interrupt disabled if
there is no handler defined for that interrupt source. The patch adds
exactly this. I dont remember why this was needed in the first place (irq
probing? avoidance of interrupt storms?), but with the patch the behavior
should be equivalent.

	Ingo

--- linux/arch/i386/kernel/irq.c.orig2	Sat Jul 27 20:28:05 2002
+++ linux/arch/i386/kernel/irq.c	Sat Jul 27 20:31:58 2002
@@ -187,10 +187,6 @@
 #if CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
-	/* is there anything to synchronize with? */
-	if (!irq_desc[irq].action)
-		return;
-
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
 		cpu_relax();
 }
@@ -350,7 +346,7 @@
 	 * use the action we have.
 	 */
 	action = NULL;
-	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -363,7 +359,7 @@
 	   a different instance of this same irq, the other processor
 	   will take care of it.
 	 */
-	if (!action)
+	if (unlikely(!action))
 		goto out;
 
 	/*
@@ -381,12 +377,12 @@
 		handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
 		
-		if (!(desc->status & IRQ_PENDING))
+		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
 	}
-	desc->status &= ~IRQ_INPROGRESS;
 out:
+	desc->status &= ~IRQ_INPROGRESS;
 	/*
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
--- linux/arch/i386/kernel/i8259.c.orig2	Sat Jul 27 20:40:11 2002
+++ linux/arch/i386/kernel/i8259.c	Sat Jul 27 20:42:44 2002
@@ -38,7 +38,8 @@
 
 static void end_8259A_irq (unsigned int irq)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
+							irq_desc[irq].action)
 		enable_8259A_irq(irq);
 }
 

