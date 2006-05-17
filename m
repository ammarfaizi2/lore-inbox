Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWEQAVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWEQAVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEQATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32925 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932365AbWEQASi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:38 -0400
Date: Wed, 17 May 2006 02:18:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 42/50] genirq: ARM: Convert sa1100 to generic irq handling
Message-ID: <20060517001827.GQ12877@elte.hu>
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
 arch/arm/mach-sa1100/cerf.c     |    1 +
 arch/arm/mach-sa1100/h3600.c    |    2 +-
 arch/arm/mach-sa1100/irq.c      |    3 ++-
 arch/arm/mach-sa1100/neponset.c |    6 +++---
 arch/arm/mach-sa1100/pleb.c     |    1 +
 arch/arm/mach-sa1100/time.c     |    1 +
 6 files changed, 9 insertions(+), 5 deletions(-)

Index: linux-genirq.q/arch/arm/mach-sa1100/cerf.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/cerf.c
+++ linux-genirq.q/arch/arm/mach-sa1100/cerf.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
Index: linux-genirq.q/arch/arm/mach-sa1100/h3600.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/h3600.c
+++ linux-genirq.q/arch/arm/mach-sa1100/h3600.c
@@ -836,7 +836,7 @@ static void __init h3800_init_irq(void)
 	}
 #endif
 	set_irq_type(IRQ_GPIO_H3800_ASIC, IRQT_RISING);
-	set_irq_chained_handler(IRQ_GPIO_H3800_ASIC, &h3800_IRQ_demux);
+	set_irq_chained_handler(IRQ_GPIO_H3800_ASIC, h3800_IRQ_demux);
 }
 
 
Index: linux-genirq.q/arch/arm/mach-sa1100/irq.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/irq.c
+++ linux-genirq.q/arch/arm/mach-sa1100/irq.c
@@ -11,12 +11,13 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/ioport.h>
 #include <linux/ptrace.h>
 #include <linux/sysdev.h>
 
 #include <asm/hardware.h>
-#include <asm/irq.h>
 #include <asm/mach/irq.h>
 
 #include "generic.h"
Index: linux-genirq.q/arch/arm/mach-sa1100/neponset.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/neponset.c
+++ linux-genirq.q/arch/arm/mach-sa1100/neponset.c
@@ -39,7 +39,7 @@ neponset_irq_handler(unsigned int irq, s
 		/*
 		 * Acknowledge the parent IRQ.
 		 */
-		desc->chip->ack(irq);
+		desc->handler->ack(irq);
 
 		/*
 		 * Read the interrupt reason register.  Let's have all
@@ -57,7 +57,7 @@ neponset_irq_handler(unsigned int irq, s
 		 * recheck the register for any pending IRQs.
 		 */
 		if (irr & (IRR_ETHERNET | IRR_USAR)) {
-			desc->chip->mask(irq);
+			desc->handler->mask(irq);
 
 			if (irr & IRR_ETHERNET) {
 				d = irq_desc + IRQ_NEPONSET_SMC9196;
@@ -69,7 +69,7 @@ neponset_irq_handler(unsigned int irq, s
 				desc_handle_irq(IRQ_NEPONSET_USAR, d, regs);
 			}
 
-			desc->chip->unmask(irq);
+			desc->handler->unmask(irq);
 		}
 
 		if (irr & IRR_SA1111) {
Index: linux-genirq.q/arch/arm/mach-sa1100/pleb.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/pleb.c
+++ linux-genirq.q/arch/arm/mach-sa1100/pleb.c
@@ -7,6 +7,7 @@
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
 
 #include <linux/mtd/partitions.h>
 
Index: linux-genirq.q/arch/arm/mach-sa1100/time.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-sa1100/time.c
+++ linux-genirq.q/arch/arm/mach-sa1100/time.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/timex.h>
 #include <linux/signal.h>
 
