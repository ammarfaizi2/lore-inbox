Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWFZQVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFZQVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWFZQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:21:42 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:38281 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750754AbWFZQVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:21:41 -0400
Date: Mon, 26 Jun 2006 09:21:30 -0700
From: Daniel Walker <dwalker@dwalker1.mvista.com>
Message-Id: <200606261621.k5QGLUM4016700@dwalker1.mvista.com>
To: mingo@elte.hu
Cc: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] fix preempt hardirqs on OMAP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix hardirq threading when the chained handler
disables an interrupt when setting IRQ_PENDING. Which happens
on OMAP, but I'm not sure how many other ARM boards do this.
It also has the effect of re-running the interrupt on 
IRQ_PENDING, which would normally be handled inside the chained
handler. Since this happens inside a thread the chained handler
will just wake up the thread multiple times, leaving the thread
to actually rerun the interrupt .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/irq/manage.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

Index: linux-2.6.16/kernel/irq/manage.c
===================================================================
--- linux-2.6.16.orig/kernel/irq/manage.c
+++ linux-2.6.16/kernel/irq/manage.c
@@ -511,6 +511,7 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;
 
+restart:
 	if (action && !desc->depth) {
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, NULL, action);
@@ -520,6 +521,18 @@ static void thread_simple_irq(irq_desc_t
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret, NULL);
 	}
+
+	/*
+	 * Some boards will disable an interrupt when it
+	 * sets IRQ_PENDING . So we have to remove the flag
+	 * and re-enable to handle it.
+	 */
+	if (desc->status & IRQ_PENDING) {
+		desc->status &= ~IRQ_PENDING;
+		if (desc->chip)
+			desc->chip->enable(irq);
+		goto restart;
+	}
 	desc->status &= ~IRQ_INPROGRESS;
 }
 
