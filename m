Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWEQAQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWEQAQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEQAQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61596 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932303AbWEQAQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:42 -0400
Date: Wed, 17 May 2006 02:16:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 17/50] genirq: add IRQ_NOPROBE support
Message-ID: <20060517001633.GR12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

introduce IRQ_NOPROBE: enables platforms to control chip-probing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h    |    1 +
 kernel/irq/autoprobe.c |    4 ++--
 kernel/irq/manage.c    |    4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -40,6 +40,7 @@
 # define CHECK_IRQ_PER_CPU(var) 0
 #endif
 
+#define IRQ_NOPROBE	512	/* IRQ is not valid for probing */
 /**
  * struct hw_interrupt_type - hardware interrupt type descriptor
  *
Index: linux-genirq.q/kernel/irq/autoprobe.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/autoprobe.c
+++ linux-genirq.q/kernel/irq/autoprobe.c
@@ -40,7 +40,7 @@ unsigned long probe_irq_on(void)
 		desc = irq_desc + i;
 
 		spin_lock_irq(&desc->lock);
-		if (!desc->action)
+		if (!desc->action && !(desc->status & IRQ_NOPROBE))
 			desc->handler->startup(i);
 		spin_unlock_irq(&desc->lock);
 	}
@@ -57,7 +57,7 @@ unsigned long probe_irq_on(void)
 		desc = irq_desc + i;
 
 		spin_lock_irq(&desc->lock);
-		if (!desc->action) {
+		if (!desc->action && !(desc->status & IRQ_NOPROBE)) {
 			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
 			if (desc->handler->startup(i))
 				desc->status |= IRQ_PENDING;
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -118,6 +118,10 @@ void enable_irq(unsigned int irq)
 		WARN_ON(1);
 		break;
 	case 1: {
+		unsigned int status = desc->status & ~IRQ_DISABLED;
+
+		/* Prevent probing on this irq: */
+		desc->status = status | IRQ_NOPROBE;
 		check_irq_resend(desc, irq);
 		/* fall-through */
 	}
