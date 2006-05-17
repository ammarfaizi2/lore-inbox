Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWEQA0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWEQA0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWEQARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52432 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932303AbWEQARO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:14 -0400
Date: Wed, 17 May 2006 02:17:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 23/50] genirq: add irq-wake (power-management) support
Message-ID: <20060517001701.GX12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

enable platforms to set the irq-wake (power-management) properties
of an IRQ.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/interrupt.h |   14 ++++++++++++++
 kernel/irq/manage.c       |   21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

Index: linux-genirq.q/include/linux/interrupt.h
===================================================================
--- linux-genirq.q.orig/include/linux/interrupt.h
+++ linux-genirq.q/include/linux/interrupt.h
@@ -56,6 +56,20 @@ extern void free_irq(unsigned int, void 
 extern void disable_irq_nosync(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
+
+/* IRQ wakeup (PM) control: */
+extern int set_irq_wake(unsigned int irq, unsigned int on);
+
+static inline int enable_irq_wake(unsigned int irq)
+{
+	return set_irq_wake(irq, 1);
+}
+
+static inline int disable_irq_wake(unsigned int irq)
+{
+	return set_irq_wake(irq, 0);
+}
+
 #endif
 
 #ifndef __ARCH_SET_SOFTIRQ_PENDING
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -133,6 +133,27 @@ void enable_irq(unsigned int irq)
 }
 EXPORT_SYMBOL(enable_irq);
 
+/**
+ *	set_irq_wake - control irq power management wakeup
+ *	@irq:	interrupt to control
+ *	@on:	enable/disable power management wakeup
+ *
+ *	Enable/disable power management wakeup mode
+ */
+int set_irq_wake(unsigned int irq, unsigned int on)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	unsigned long flags;
+	int ret = -ENXIO;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (desc->handler->set_wake)
+		ret = desc->handler->set_wake(irq, on);
+	spin_unlock_irqrestore(&desc->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(set_irq_wake);
+
 /*
  * Internal function that tells the architecture code whether a
  * particular irq has been exclusively allocated or is available
