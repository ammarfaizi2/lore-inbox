Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUHCHck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUHCHck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUHCHck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:32:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:16796 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265255AbUHCHcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:32:35 -0400
Subject: [PATCH] ppc32: Fix problem with spurrious edge interrupts on old
	powermacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Message-Id: <1091518119.7396.122.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 17:28:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On old powermacs, it's possible that we get a stale edge interrupt
when doing request_irq(), that typically happens with the DBDMA
controller interrupts when the device was used by the firmware for
booting.

I just tracked down a nasty memory corruption problem where that was
causing the bmac driver to try to process packets before the driver
internal data structures were properly initialized.

While I agree that the driver should (and will) be made more robust
to such things, Paulus and I decided that it makes little sense to keep
track of an "old" edge interrupt that happens before a driver does 
request_irq. (On those powermacs, those are only the DBDMA interrupts
anyway, and none of the DBDMA users will care).

This patch implements a "startup" handler for the old Apple PIC that
will "ack" pending edge interrupts before unmasking, thus preventing
those stale interrupts to be delivered.

It also "fixes" the ppc32 irq core to call the startup() callback when
available instead of just calling enable().

Please apply,
Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/arch/ppc/kernel/irq.c linux-swsusp/arch/ppc/kernel/irq.c
--- linux-2.5/arch/ppc/kernel/irq.c	2004-07-29 08:46:54.000000000 +1000
+++ linux-swsusp/arch/ppc/kernel/irq.c	2004-08-03 17:19:01.000000000 +1000
@@ -171,7 +171,12 @@
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
-		unmask_irq(irq);
+		if (desc->handler) {
+			if (desc->handler->startup)
+				desc->handler->startup(irq);
+			else if (desc->handler->enable)
+				desc->handler->enable(irq);
+		}
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
 
diff -urN linux-2.5/arch/ppc/platforms/pmac_pic.c linux-swsusp/arch/ppc/platforms/pmac_pic.c
--- linux-2.5/arch/ppc/platforms/pmac_pic.c	2004-07-29 08:46:54.000000000 +1000
+++ linux-swsusp/arch/ppc/platforms/pmac_pic.c	2004-08-03 17:22:57.000000000 +1000
@@ -144,6 +144,22 @@
 	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
+/* When an irq gets requested for the first client, if it's an
+ * edge interrupt, we clear any previous one on the controller
+ */
+static unsigned int __pmac pmac_startup_irq(unsigned int irq_nr)
+{
+        unsigned long bit = 1UL << (irq_nr & 0x1f);
+        int i = irq_nr >> 5;
+
+	if ((irq_desc[irq_nr].status & IRQ_LEVEL) == 0)
+		out_le32(&pmac_irq_hw[i]->ack, bit);
+        set_bit(irq_nr, ppc_cached_irq_mask);
+        pmac_set_irq_mask(irq_nr, 0);
+
+	return 0;
+}
+
 static void __pmac pmac_mask_irq(unsigned int irq_nr)
 {
         clear_bit(irq_nr, ppc_cached_irq_mask);
@@ -168,25 +184,21 @@
 
 
 struct hw_interrupt_type pmac_pic = {
-        " PMAC-PIC ",
-        NULL,
-        NULL,
-        pmac_unmask_irq,
-        pmac_mask_irq,
-        pmac_mask_and_ack_irq,
-        pmac_end_irq,
-        NULL
+	.typename	= " PMAC-PIC ",
+	.startup	= pmac_startup_irq,
+	.enable		= pmac_unmask_irq,
+	.disable	= pmac_mask_irq,
+	.ack		= pmac_mask_and_ack_irq,
+	.end		= pmac_end_irq,
 };
 
 struct hw_interrupt_type gatwick_pic = {
-	" GATWICK  ",
-	NULL,
-	NULL,
-	pmac_unmask_irq,
-	pmac_mask_irq,
-	pmac_mask_and_ack_irq,
-	pmac_end_irq,
-	NULL
+	.typename	= " GATWICK  ",
+	.startup	= pmac_startup_irq,
+	.enable		= pmac_unmask_irq,
+	.disable	= pmac_mask_irq,
+	.ack		= pmac_mask_and_ack_irq,
+	.end		= pmac_end_irq,
 };
 
 static irqreturn_t gatwick_action(int cpl, void *dev_id, struct pt_regs *regs)


