Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWEQAbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWEQAbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWEQAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:31:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:925 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932321AbWEQAQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:55 -0400
Date: Wed, 17 May 2006 02:16:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 19/50] genirq: add IRQ_NOAUTOEN support
Message-ID: <20060517001642.GT12877@elte.hu>
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

enable platforms to disable the automatic enabling of freshly set up irqs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |    1 +
 kernel/irq/manage.c |   18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -42,6 +42,7 @@
 
 #define IRQ_NOPROBE	512	/* IRQ is not valid for probing */
 #define IRQ_NOREQUEST	1024	/* IRQ cannot be requested */
+#define IRQ_NOAUTOEN	2048	/* IRQ will not be enabled on request irq */
 /**
  * struct hw_interrupt_type - hardware interrupt type descriptor
  *
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -216,13 +216,17 @@ int setup_irq(unsigned int irq, struct i
 		desc->status |= IRQ_PER_CPU;
 #endif
 	if (!shared) {
-		desc->depth = 0;
-		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT |
-				  IRQ_WAITING | IRQ_INPROGRESS);
-		if (desc->handler->startup)
-			desc->handler->startup(irq);
-		else
-			desc->handler->enable(irq);
+		desc->status &= ~(IRQ_AUTODETECT | IRQ_WAITING |
+				  IRQ_INPROGRESS);
+
+		if (!(desc->status & IRQ_NOAUTOEN)) {
+			desc->depth = 0;
+			desc->status &= ~IRQ_DISABLED;
+			if (desc->handler->startup)
+				desc->handler->startup(irq);
+			else
+				desc->handler->enable(irq);
+		}
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 
