Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWEQAXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWEQAXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEQAW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:22:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41373 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932380AbWEQAS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:59 -0400
Date: Wed, 17 May 2006 02:18:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 46/50] genirq: ARM: Convert at91rm9200 to generic irq handling
Message-ID: <20060517001847.GU12877@elte.hu>
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
 arch/arm/mach-at91rm9200/gpio.c |   12 ++++++------
 arch/arm/mach-at91rm9200/time.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-genirq.q/arch/arm/mach-at91rm9200/gpio.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-at91rm9200/gpio.c
+++ linux-genirq.q/arch/arm/mach-at91rm9200/gpio.c
@@ -261,21 +261,21 @@ static void gpio_irq_handler(unsigned ir
 	void __iomem	*pio;
 	u32		isr;
 
-	pio = desc->base;
+	pio = get_irq_chip_data(irq);
 
 	/* temporarily mask (level sensitive) parent IRQ */
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 	for (;;) {
 		isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
 		if (!isr)
 			break;
 
-		pin = (unsigned) desc->data;
+		pin = (unsigned) get_irq_data(irq);
 		gpio = &irq_desc[pin];
 
 		while (isr) {
 			if (isr & 1) {
-				if (unlikely(gpio->disable_depth)) {
+				if (unlikely(gpio->depth)) {
 					/*
 					 * The core ARM interrupt handler lazily disables IRQs so
 					 * another IRQ must be generated before it actually gets
@@ -284,14 +284,14 @@ static void gpio_irq_handler(unsigned ir
 					gpio_irq_mask(pin);
 				}
 				else
-					gpio->handle(pin, gpio, regs);
+					desc_handle_irq(pin, gpio, regs);
 			}
 			pin++;
 			gpio++;
 			isr >>= 1;
 		}
 	}
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 	/* now it may re-trigger */
 }
 
Index: linux-genirq.q/arch/arm/mach-at91rm9200/time.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-at91rm9200/time.c
+++ linux-genirq.q/arch/arm/mach-at91rm9200/time.c
@@ -22,13 +22,13 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/mach/time.h>
 
 /*
