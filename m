Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWEQA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWEQA2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEQA13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:27:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12701 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932338AbWEQARl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:41 -0400
Date: Wed, 17 May 2006 02:17:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 29/50] genirq: ARM: Convert ecard driver to generic irq handling
Message-ID: <20060517001730.GD12877@elte.hu>
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

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/kernel/ecard.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-genirq.q/arch/arm/kernel/ecard.c
===================================================================
--- linux-genirq.q.orig/arch/arm/kernel/ecard.c
+++ linux-genirq.q/arch/arm/kernel/ecard.c
@@ -549,7 +549,7 @@ static void ecard_check_lockup(struct ir
 			printk(KERN_ERR "\nInterrupt lockup detected - "
 			       "disabling all expansion card interrupts\n");
 
-			desc->chip->mask(IRQ_EXPANSIONCARD);
+			desc->handler->mask(IRQ_EXPANSIONCARD);
 			ecard_dump_irq_state();
 		}
 	} else
@@ -572,7 +572,7 @@ ecard_irq_handler(unsigned int irq, stru
 	ecard_t *ec;
 	int called = 0;
 
-	desc->chip->mask(irq);
+	desc->handler->mask(irq);
 	for (ec = cards; ec; ec = ec->next) {
 		int pending;
 
@@ -590,7 +590,7 @@ ecard_irq_handler(unsigned int irq, stru
 			called ++;
 		}
 	}
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 
 	if (called == 0)
 		ecard_check_lockup(desc);
@@ -620,7 +620,7 @@ ecard_irqexp_handler(unsigned int irq, s
 		ecard_t *ec = slot_to_ecard(slot);
 
 		if (ec->claimed) {
-			struct irqdesc *d = irqdesc + ec->irq;
+			struct irq_desc *d = irq_desc + ec->irq;
 			/*
 			 * this ugly code is so that we can operate a
 			 * prioritorising system:
