Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWEQASM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWEQASM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEQASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:18:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6865 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932359AbWEQASE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:04 -0400
Date: Wed, 17 May 2006 02:17:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 35/50] genirq: ARM: Convert ixp2000 to generic irq handling
Message-ID: <20060517001755.GJ12877@elte.hu>
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
 arch/arm/mach-ixp2000/core.c     |    3 ++-
 arch/arm/mach-ixp2000/ixdp2x00.c |    6 +++---
 arch/arm/mach-ixp2000/ixdp2x01.c |    6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-genirq.q/arch/arm/mach-ixp2000/core.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp2000/core.c
+++ linux-genirq.q/arch/arm/mach-ixp2000/core.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/bitops.h>
@@ -407,7 +408,7 @@ static void ixp2000_err_irq_handler(unsi
 	for(i = 31; i >= 0; i--) {
 		if(status & (1 << i)) {
 			desc = irq_desc + IRQ_IXP2000_DRAM0_MIN_ERR + i;
-			desc->handle(IRQ_IXP2000_DRAM0_MIN_ERR + i, desc, regs);
+			desc_handle_irq(IRQ_IXP2000_DRAM0_MIN_ERR + i, desc, regs);
 		}
 	}
 }
Index: linux-genirq.q/arch/arm/mach-ixp2000/ixdp2x00.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp2000/ixdp2x00.c
+++ linux-genirq.q/arch/arm/mach-ixp2000/ixdp2x00.c
@@ -113,7 +113,7 @@ static void ixdp2x00_irq_handler(unsigne
 	static struct slowport_cfg old_cfg;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->handler->mask(irq);
 
 #ifdef CONFIG_ARCH_IXDP2400
 	if (machine_is_ixdp2400())
@@ -137,7 +137,7 @@ static void ixdp2x00_irq_handler(unsigne
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 static struct irqchip ixdp2x00_cpld_irq_chip = {
@@ -168,7 +168,7 @@ void ixdp2x00_init_irq(volatile unsigned
 	}
 
 	/* Hook into PCI interrupt */
-	set_irq_chained_handler(IRQ_IXP2000_PCIB, &ixdp2x00_irq_handler);
+	set_irq_chained_handler(IRQ_IXP2000_PCIB, ixdp2x00_irq_handler);
 }
 
 /*************************************************************************
Index: linux-genirq.q/arch/arm/mach-ixp2000/ixdp2x01.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-ixp2000/ixdp2x01.c
+++ linux-genirq.q/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -69,7 +69,7 @@ static void ixdp2x01_irq_handler(unsigne
 	u32 ex_interrupt;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->handler->mask(irq);
 
 	ex_interrupt = *IXDP2X01_INT_STAT_REG & valid_irq_mask;
 
@@ -87,7 +87,7 @@ static void ixdp2x01_irq_handler(unsigne
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 static struct irqchip ixdp2x01_irq_chip = {
@@ -128,7 +128,7 @@ void __init ixdp2x01_init_irq(void)
 	}
 
 	/* Hook into PCI interrupts */
-	set_irq_chained_handler(IRQ_IXP2000_PCIB, &ixdp2x01_irq_handler);
+	set_irq_chained_handler(IRQ_IXP2000_PCIB, ixdp2x01_irq_handler);
 }
 
 
