Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWEQARb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWEQARb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWEQAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44496 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932303AbWEQAQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:54 -0400
Date: Wed, 17 May 2006 02:16:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 18/50] genirq: add IRQ_NOREQUEST support
Message-ID: <20060517001638.GS12877@elte.hu>
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

enable platforms to disable request_irq() for certain interrupts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |    1 +
 kernel/irq/manage.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -41,6 +41,7 @@
 #endif
 
 #define IRQ_NOPROBE	512	/* IRQ is not valid for probing */
+#define IRQ_NOREQUEST	1024	/* IRQ cannot be requested */
 /**
  * struct hw_interrupt_type - hardware interrupt type descriptor
  *
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -141,7 +141,7 @@ int can_request_irq(unsigned int irq, un
 {
 	struct irqaction *action;
 
-	if (irq >= NR_IRQS)
+	if (irq >= NR_IRQS || irq_desc[irq].status & IRQ_NOREQUEST)
 		return 0;
 
 	action = irq_desc[irq].action;
@@ -356,6 +356,8 @@ int request_irq(unsigned int irq,
 		return -EINVAL;
 	if (irq >= NR_IRQS)
 		return -EINVAL;
+	if (irq_desc[irq].status & IRQ_NOREQUEST)
+		return -EINVAL;
 	if (!handler)
 		return -EINVAL;
 
