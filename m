Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWEKF1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWEKF1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 01:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWEKF1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 01:27:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:29163 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751460AbWEKF1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 01:27:17 -0400
Subject: [RFC][PATCH] Cascaded interrupts: a simple solution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Thu, 11 May 2006 15:26:55 +1000
Message-Id: <1147325215.30380.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While working on some major cleanup of the powerpc architecture
interrupt handling, I found out that I could easily solve one of our
problems with a small addition to the interrupt core. This will probably
be useful to other architectures as well.

It's quite common in ppc-land to have cascaded interrupt controllers.
That is, a given interrupt is actually the output of another interrupt
controller (a demultiplexer if you prefer). Currently, the typical
setups are a master OpenPIC/MPIC with a cascaded i8259, or on PowerMacs,
a MPICs and a slave MPIC. However, Cell is also bringing similar
cascades into the picture (one iic per thread and cascaded south bridge
interrupts, from the spider chip for now and others in the future) and
it's also a common setup on embedded.

At the moment, we handled that in a fairly dirty way. That is, the
interrupt controller "driver" would have a magic "hook" for setting up a
cascade callback on one of its interrupt sources. In some cases (like
Cell), it's even hard coded (one interrupt controller driver calls
directly into another one whem the interrupt is the cascade).

I figured out that it would be very simple to make that much cleaner and
generic by simply defining a new interrupt flag SA_CASCADEIRQ to attach
to the cascade irq, and have the handler fetch the interrupts from the
slave controller and return them to the core.

This patch is an implementation that was quickly tested on G5 (a second
patch to use that for the G5 follows) and seems to work fine. I changed
irqreturn_t to be an unsigned int to better match the type of "irq" in
most cases. It also relies on the fact that irq 0 (which matches the
constant IRQ_NONE) is invalid (at least is never a valid cascaded
interrupt) which matches a decision made by Linus a while ago when
talking about introducing a generic NO_IRQ.

The reason I made it recursive is that I found any other implementation
attempts I did too ugly for words, it's much more cleaner that way, and
it only recurses as much as there are levels of IRQ cascaded controllers
which I don't expect to ever be more than 2 or 3. Since the involved
functions have very little locals allocated, I decided it was good
enough that way.

Note the fact that it's looping on the handler until IRQ_NONE is
returned, since a cascaded controller might issue only one irq upstream
for any combination of downstream interrupts, it must be "polled" until
it has no more interrupt to return.

If you are happy with this patch, please consider for 2.6.18 and I'll
convert the rest of the powerpc architecture to use this mecanism as
part of my cleanup.

Cheers,
Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/interrupt.h
===================================================================
--- linux-work.orig/include/linux/interrupt.h	2006-01-14 14:43:35.000000000 +1100
+++ linux-work/include/linux/interrupt.h	2006-05-11 12:01:32.000000000 +1000
@@ -27,8 +27,13 @@
  * IRQ_NONE means we didn't handle it.
  * IRQ_HANDLED means that we did have a valid interrupt and handled it.
  * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
+ *
+ * A cascade interrupt (using SA_CASCADE) returns IRQ_NONE or a valid interrupt
+ * number. It's assumed that 0 is not a valid cascaded interrupt number. As
+ * per prior discussion with Linus, all archs should migrate to have 0 not be
+ * a valid interrupt number at all anyway.
  */
-typedef int irqreturn_t;
+typedef unsigned int irqreturn_t;
 
 #define IRQ_NONE	(0)
 #define IRQ_HANDLED	(1)
Index: linux-work/include/linux/signal.h
===================================================================
--- linux-work.orig/include/linux/signal.h	2006-05-11 11:45:09.000000000 +1000
+++ linux-work/include/linux/signal.h	2006-05-11 11:49:38.000000000 +1000
@@ -15,8 +15,10 @@
  * SA_INTERRUPT is also used by the irq handling routines.
  * SA_SHIRQ is for shared interrupt support on PCI and EISA.
  * SA_PROBEIRQ is set by callers when they expect sharing mismatches to occur
+ * SA_CASCADE is set for a cascade (demultiplexer) interrupt handler
  */
 #define SA_SAMPLE_RANDOM	SA_RESTART
+#define SA_CASCADEIRQ		0x02000000
 #define SA_SHIRQ		0x04000000
 #define SA_PROBEIRQ		0x08000000
 
Index: linux-work/kernel/irq/handle.c
===================================================================
--- linux-work.orig/kernel/irq/handle.c	2006-01-14 14:43:37.000000000 +1100
+++ linux-work/kernel/irq/handle.c	2006-05-11 12:03:41.000000000 +1000
@@ -79,13 +79,19 @@ irqreturn_t no_action(int cpl, void *dev
 fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 				struct irqaction *action)
 {
-	int ret, retval = 0, status = 0;
+	unsigned int ret;
+	int retval = 0, status = 0;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
 	do {
 		ret = action->handler(irq, action->dev_id, regs);
+		if ((action->flags & SA_CASCADEIRQ) && (ret != IRQ_NONE)) {
+			retval |= IRQ_HANDLED;
+			__do_IRQ(ret, regs);
+			continue;
+		}
 		if (ret == IRQ_HANDLED)
 			status |= action->flags;
 		retval |= ret;
Index: linux-work/kernel/irq/manage.c
===================================================================
--- linux-work.orig/kernel/irq/manage.c	2006-05-11 11:45:09.000000000 +1000
+++ linux-work/kernel/irq/manage.c	2006-05-11 12:00:52.000000000 +1000
@@ -371,6 +371,13 @@ int request_irq(unsigned int irq,
 	if (!handler)
 		return -EINVAL;
 
+	/*
+	 * SA_CASCADE implies SA_INTERRUPT (that is, the demux itself happens
+	 * with interrupts disabled, the final handler is still called with
+	 */
+	if (irqflags & SA_CASCADEIRQ)
+		irqflags |= SA_INTERRUPT;
+
 	action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
 	if (!action)
 		return -ENOMEM;
Index: linux-work/include/linux/irq.h
===================================================================
--- linux-work.orig/include/linux/irq.h	2006-03-31 12:13:05.000000000 +1100
+++ linux-work/include/linux/irq.h	2006-05-11 14:34:58.000000000 +1000
@@ -172,7 +172,8 @@ extern fastcall int handle_IRQ_event(uns
 					struct irqaction *action);
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
-					int action_ret, struct pt_regs *regs);
+					unsigned int  action_ret,
+			   		struct pt_regs *regs);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 extern void init_irq_proc(void);
Index: linux-work/kernel/irq/spurious.c
===================================================================
--- linux-work.orig/kernel/irq/spurious.c	2006-01-14 14:43:37.000000000 +1100
+++ linux-work/kernel/irq/spurious.c	2006-05-11 14:35:21.000000000 +1000
@@ -133,7 +133,7 @@ static void report_bad_irq(unsigned int 
 	}
 }
 
-void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret,
+void note_interrupt(unsigned int irq, irq_desc_t *desc, unsigned int action_ret,
 			struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {


