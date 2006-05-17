Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWEQATI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWEQATI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEQATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20433 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932376AbWEQASt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:49 -0400
Date: Wed, 17 May 2006 02:18:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 45/50] genirq: ARM: Convert plat-omap to generic irq handling
Message-ID: <20060517001842.GT12877@elte.hu>
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

Fixup the conversion to generic irq subsystem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/plat-omap/dma.c  |    2 +-
 arch/arm/plat-omap/gpio.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-genirq.q/arch/arm/plat-omap/dma.c
===================================================================
--- linux-genirq.q.orig/arch/arm/plat-omap/dma.c
+++ linux-genirq.q/arch/arm/plat-omap/dma.c
@@ -24,9 +24,9 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/system.h>
-#include <asm/irq.h>
 #include <asm/hardware.h>
 #include <asm/dma.h>
 #include <asm/io.h>
Index: linux-genirq.q/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-genirq.q.orig/arch/arm/plat-omap/gpio.c
+++ linux-genirq.q/arch/arm/plat-omap/gpio.c
@@ -737,9 +737,9 @@ static void gpio_irq_handler(unsigned in
 	unsigned int gpio_irq;
 	struct gpio_bank *bank;
 
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 
-	bank = (struct gpio_bank *) desc->data;
+	bank = get_irq_data(irq);
 	if (bank->method == METHOD_MPUIO)
 		isr_reg = bank->base + OMAP_MPUIO_GPIO_INT;
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -783,7 +783,7 @@ static void gpio_irq_handler(unsigned in
 		/* if there is only edge sensitive GPIO pin interrupts
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask)
-			desc->chip->unmask(irq);
+			desc->handler->unmask(irq);
 
 		if (!isr)
 			break;
@@ -809,7 +809,7 @@ static void gpio_irq_handler(unsigned in
 		handler(s) are executed in order to avoid spurious bank
 		interrupt */
 		if (level_mask)
-			desc->chip->unmask(irq);
+			desc->handler->unmask(irq);
 	}
 }
 
