Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319529AbSIGWHR>; Sat, 7 Sep 2002 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319531AbSIGWHR>; Sat, 7 Sep 2002 18:07:17 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:17372 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319529AbSIGWHP>; Sat, 7 Sep 2002 18:07:15 -0400
Date: Sun, 8 Sep 2002 00:34:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] per isr in_progress markers
Message-ID: <Pine.LNX.4.44.0209072342450.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Robert,
	What do you make of the following patch. It is supposed to ease 
irq sharing by allowing multiple isrs to be executed, but still not 
allowing a specific isr to be run asynchronously. I haven't been able to 
test it on SMP proper, only SMP kernel on UP machine and using a shared 
network card and sound card concurrently with an interrupt load of 
~3000irqs/s

Few questions;
1) Should we set IRQ_PENDING on the way out again if it is found to be 
ISR_INPROGRESS?

2) Is the spin_unlock(desc->lock).. handle_IRQ_event() ... 
spin_lock(desc->lock) window large enough to allow another cpu in there 
to handle another interrupt on that descriptor?

Thanks,
	Zwane

Index: linux-2.5.33/include/linux/interrupt.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/include/linux/interrupt.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 interrupt.h
--- linux-2.5.33/include/linux/interrupt.h	31 Aug 2002 22:30:51 -0000	1.1.1.1
+++ linux-2.5.33/include/linux/interrupt.h	7 Sep 2002 17:21:40 -0000
@@ -13,6 +13,8 @@
 #include <asm/system.h>
 #include <asm/ptrace.h>
 
+#define ISR_INPROGRESS	1	/* ISR currently being executed */
+
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
@@ -20,6 +22,7 @@
 	const char *name;
 	void *dev_id;
 	struct irqaction *next;
+	unsigned long status;
 };
 
 
Index: linux-2.5.33/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.33/arch/i386/kernel/irq.c	31 Aug 2002 22:31:11 -0000	1.1.1.1
+++ linux-2.5.33/arch/i386/kernel/irq.c	7 Sep 2002 17:22:26 -0000
@@ -200,21 +200,27 @@
  */
 int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct irqaction * action)
 {
-	int status = 1;	/* Force the "do bottom halves" bit */
+	int ret = 1;	/* Force the "do bottom halves" bit */
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
+	/* Ease irq sharing by allowing other handlers to be run instead
+	 * of blocking all with IRQ_INPROGRESS */
+
 	do {
-		status |= action->flags;
-		action->handler(irq, action->dev_id, regs);
+		if (test_and_set_bit(ISR_INPROGRESS, &action->status) == 0) {
+			action->handler(irq, action->dev_id, regs);
+			clear_bit(ISR_INPROGRESS, &action->status);
+		}
+		ret |= action->flags;
 		action = action->next;
 	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
+	if (ret & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
-	return status;
+	return ret;
 }
 
 /*
@@ -342,10 +348,13 @@
 
 	/*
 	 * If the IRQ is disabled for whatever reason, we cannot
-	 * use the action we have.
+	 * use the action we have. Note that we don't check for
+	 * IRQ_INPROGRESS, we allow multiple ISRs from a shared
+	 * interrupt to be run concurrently, but still not allowing
+	 * the same handler to be run asynchronously.
 	 */
 	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+	if (likely(!(status & IRQ_DISABLED))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -463,6 +472,7 @@
 	action->mask = 0;
 	action->name = devname;
 	action->next = NULL;
+	action->status = 0;
 	action->dev_id = dev_id;
 
 	retval = setup_irq(irq, action);
-- 
function.linuxpower.ca


