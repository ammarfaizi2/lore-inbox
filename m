Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWEQAVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWEQAVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEQATQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40093 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932381AbWEQAS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:57 -0400
Date: Wed, 17 May 2006 02:18:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 47/50] genirq: ARM: Convert ixp23xx to generic irq handling
Message-ID: <20060517001851.GV12877@elte.hu>
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
 arch/arm/mach-ixp23xx/core.c     |    6 +++---
 arch/arm/mach-ixp23xx/ixdp2351.c |   18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-genirq.q/arch/arm/mach-ixp23xx/core.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp23xx/core.c
+++ linux-genirq.q/arch/arm/mach-ixp23xx/core.c
@@ -248,7 +248,7 @@ static void pci_handler(unsigned int irq
 
 	pci_interrupt = *IXP23XX_PCI_XSCALE_INT_STATUS;
 
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 
 	/* See which PCI_INTA, or PCI_INTB interrupted */
 	if (pci_interrupt & (1 << 26)) {
@@ -260,9 +260,9 @@ static void pci_handler(unsigned int irq
 	}
 
 	int_desc = irq_desc + irqno;
-	int_desc->handle(irqno, int_desc, regs);
+	desc_handle_irq(irqno, int_desc, regs);
 
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 static struct irqchip ixp23xx_pci_irq_chip = {
Index: linux-genirq.q/arch/arm/mach-ixp23xx/ixdp2351.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp23xx/ixdp2351.c
+++ linux-genirq.q/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/bitops.h>
@@ -37,7 +38,6 @@
 #include <asm/memory.h>
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
@@ -67,7 +67,7 @@ static void ixdp2351_inta_handler(unsign
 		*IXDP2351_CPLD_INTA_STAT_REG & IXDP2351_INTA_IRQ_VALID;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->handler->mask(irq);
 
 	for (i = 0; i < IXDP2351_INTA_IRQ_NUM; i++) {
 		if (ex_interrupt & (1 << i)) {
@@ -75,11 +75,11 @@ static void ixdp2351_inta_handler(unsign
 			int cpld_irq =
 				IXP23XX_MACH_IRQ(IXDP2351_INTA_IRQ_BASE + i);
 			cpld_desc = irq_desc + cpld_irq;
-			cpld_desc->handle(cpld_irq, cpld_desc, regs);
+			desc_handle_irq(cpld_irq, cpld_desc, regs);
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 static struct irqchip ixdp2351_inta_chip = {
@@ -104,7 +104,7 @@ static void ixdp2351_intb_handler(unsign
 		*IXDP2351_CPLD_INTB_STAT_REG & IXDP2351_INTB_IRQ_VALID;
 	int i;
 
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 
 	for (i = 0; i < IXDP2351_INTB_IRQ_NUM; i++) {
 		if (ex_interrupt & (1 << i)) {
@@ -112,11 +112,11 @@ static void ixdp2351_intb_handler(unsign
 			int cpld_irq =
 				IXP23XX_MACH_IRQ(IXDP2351_INTB_IRQ_BASE + i);
 			cpld_desc = irq_desc + cpld_irq;
-			cpld_desc->handle(cpld_irq, cpld_desc, regs);
+			desc_handle_irq(cpld_irq, cpld_desc, regs);
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 static struct irqchip ixdp2351_intb_chip = {
@@ -159,8 +159,8 @@ void ixdp2351_init_irq(void)
 		}
 	}
 
-	set_irq_chained_handler(IRQ_IXP23XX_INTA, &ixdp2351_inta_handler);
-	set_irq_chained_handler(IRQ_IXP23XX_INTB, &ixdp2351_intb_handler);
+	set_irq_chained_handler(IRQ_IXP23XX_INTA, ixdp2351_inta_handler);
+	set_irq_chained_handler(IRQ_IXP23XX_INTB, ixdp2351_intb_handler);
 }
 
 /*
