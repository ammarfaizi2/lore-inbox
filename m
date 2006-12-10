Return-Path: <linux-kernel-owner+w=401wt.eu-S1762254AbWLJQgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762254AbWLJQgq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762255AbWLJQgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:36:46 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:8208 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762254AbWLJQgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:36:45 -0500
Message-Id: <20061210163545.488430000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 08:35:45 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix hardirq threading when the chained handler disables an interrupt 
while setting IRQ_PENDING. Which happens on ARM OMAP. It also has the effect of 
re-running the interrupt on IRQ_PENDING, which would normally be handled inside
the chained handler. Since this happens inside a thread the chained handler will
just wake up the thread multiple times, leaving the thread to actually rerun the
interrupt.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/irq/manage.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.19/kernel/irq/manage.c
===================================================================
--- linux-2.6.19.orig/kernel/irq/manage.c
+++ linux-2.6.19/kernel/irq/manage.c
@@ -546,6 +546,7 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;
 
+restart:
 	if (action && !desc->depth) {
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, action);
@@ -555,6 +556,19 @@ static void thread_simple_irq(irq_desc_t
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
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
+
 	desc->status &= ~IRQ_INPROGRESS;
 }
 
--
