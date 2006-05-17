Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWEQATq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWEQATq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWEQATS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17617 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932340AbWEQAS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:28 -0400
Date: Wed, 17 May 2006 02:18:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 41/50] genirq: ARM: Convert s3c2410 to generic irq handling
Message-ID: <20060517001823.GP12877@elte.hu>
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
 arch/arm/mach-s3c2410/bast-irq.c |   10 +++++-----
 arch/arm/mach-s3c2410/time.c     |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: linux-genirq.q/arch/arm/mach-s3c2410/bast-irq.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-s3c2410/bast-irq.c
+++ linux-genirq.q/arch/arm/mach-s3c2410/bast-irq.c
@@ -95,7 +95,7 @@ bast_pc104_maskack(unsigned int irqno)
 	struct irqdesc *desc = irq_desc + IRQ_ISA;
 
 	bast_pc104_mask(irqno);
-	desc->chip->ack(IRQ_ISA);
+	desc->handler->ack(IRQ_ISA);
 }
 
 static void
@@ -129,15 +129,15 @@ bast_irq_pc104_demux(unsigned int irq,
 		/* ack if we get an irq with nothing (ie, startup) */
 
 		desc = irq_desc + IRQ_ISA;
-		desc->chip->ack(IRQ_ISA);
+		desc->handler->ack(IRQ_ISA);
 	} else {
 		/* handle the IRQ */
 
 		for (i = 0; stat != 0; i++, stat >>= 1) {
 			if (stat & 1) {
 				irqno = bast_pc104_irqs[i];
-
-				desc_handle_irq(irqno, irq_desc + irqno, regs);
+				desc = irq_desc + irqno;
+				desc_handle_irq(irqno, desc, regs);
 			}
 		}
 	}
@@ -156,7 +156,7 @@ static __init int bast_irq_init(void)
 
 		set_irq_chained_handler(IRQ_ISA, bast_irq_pc104_demux);
 
-		/* reigster our IRQs */
+		/* register our IRQs */
 
 		for (i = 0; i < 4; i++) {
 			unsigned int irqno = bast_pc104_irqs[i];
Index: linux-genirq.q/arch/arm/mach-s3c2410/time.c
===================================================================
--- linux-genirq.q.orig/arch/arm/mach-s3c2410/time.c
+++ linux-genirq.q/arch/arm/mach-s3c2410/time.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
