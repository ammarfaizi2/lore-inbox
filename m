Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753513AbWK1VYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbWK1VYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbWK1VYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:24:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:12162 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1753513AbWK1VYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:24:42 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 28 Nov 2006 22:24:11 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [rfc PATCH] ieee1394: ohci1394: delete bogus spinlock, flush MMIO
 writes
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.9660c0c3e547e1fd@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a per-host spinlock which was only taken by the IRQ handler,
i.e. where no concurrency was involved.

All MMIO writes which were surrounded by the spinlock as well as the
very last MMIO write of the IRQ handler are now explicitly flushed by
MMIO reads of the respective register.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Some of the flushes may be unnecessary. Comments?


 drivers/ieee1394/ohci1394.c |   24 ++++++++++--------------
 drivers/ieee1394/ohci1394.h |    1 -
 2 files changed, 10 insertions(+), 15 deletions(-)

Index: linux-2.6.19-rc6/drivers/ieee1394/ohci1394.h
===================================================================
--- linux-2.6.19-rc6.orig/drivers/ieee1394/ohci1394.h
+++ linux-2.6.19-rc6/drivers/ieee1394/ohci1394.h
@@ -215,7 +215,6 @@ struct ti_ohci {
         int phyid, isroot;
 
         spinlock_t phy_reg_lock;
-	spinlock_t event_lock;
 
 	int self_id_errors;
 
Index: linux-2.6.19-rc6/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/ieee1394/ohci1394.c
+++ linux-2.6.19-rc6/drivers/ieee1394/ohci1394.c
@@ -2307,17 +2307,15 @@ static irqreturn_t ohci_irq_handler(int 
 	int phyid = -1, isroot = 0;
 	unsigned long flags;
 
-	/* Read and clear the interrupt event register.  Don't clear
-	 * the busReset event, though. This is done when we get the
-	 * selfIDComplete interrupt. */
-	spin_lock_irqsave(&ohci->event_lock, flags);
 	event = reg_read(ohci, OHCI1394_IntEventClear);
-	reg_write(ohci, OHCI1394_IntEventClear, event & ~OHCI1394_busReset);
-	spin_unlock_irqrestore(&ohci->event_lock, flags);
-
 	if (!event)
 		return IRQ_NONE;
 
+	/* Clear the interrupt event register except for the busReset event.
+	 * This is done when we handle the selfIDComplete event. */
+	reg_write(ohci, OHCI1394_IntEventClear, event & ~OHCI1394_busReset);
+	reg_read(ohci, OHCI1394_IntEventClear); /* flush */
+
 	/* If event is ~(u32)0 cardbus card was ejected.  In this case
 	 * we just return, and clean up in the ohci1394_pci_remove
 	 * function. */
@@ -2399,8 +2397,8 @@ static irqreturn_t ohci_irq_handler(int 
 		/* The busReset event bit can't be cleared during the
 		 * selfID phase, so we disable busReset interrupts, to
 		 * avoid burying the cpu in interrupt requests. */
-		spin_lock_irqsave(&ohci->event_lock, flags);
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
+		reg_read(ohci, OHCI1394_IntMaskClear); /* flush */
 
 		if (ohci->check_busreset) {
 			int loop_count = 0;
@@ -2409,10 +2407,9 @@ static irqreturn_t ohci_irq_handler(int 
 
 			while (reg_read(ohci, OHCI1394_IntEventSet) & OHCI1394_busReset) {
 				reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+				reg_read(ohci, OHCI1394_IntEventClear); /* flush */
 
-				spin_unlock_irqrestore(&ohci->event_lock, flags);
 				udelay(10);
-				spin_lock_irqsave(&ohci->event_lock, flags);
 
 				/* The loop counter check is to prevent the driver
 				 * from remaining in this state forever. For the
@@ -2429,7 +2426,7 @@ static irqreturn_t ohci_irq_handler(int 
 				loop_count++;
 			}
 		}
-		spin_unlock_irqrestore(&ohci->event_lock, flags);
+
 		if (!host->in_bus_reset) {
 			DBGMSG("irq_handler: Bus reset requested");
 
@@ -2520,10 +2517,10 @@ static irqreturn_t ohci_irq_handler(int 
 
 			/* Clear the bus reset event and re-enable the
 			 * busReset interrupt.  */
-			spin_lock_irqsave(&ohci->event_lock, flags);
 			reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+			reg_read(ohci, OHCI1394_IntEventClear); /* flush */
 			reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
-			spin_unlock_irqrestore(&ohci->event_lock, flags);
+			reg_read(ohci, OHCI1394_IntMaskSet); /* flush */
 
 			/* Turn on phys dma reception.
 			 *
@@ -3398,7 +3395,6 @@ static int __devinit ohci1394_pci_probe(
 	/* We hopefully don't have to pre-allocate IT DMA like we did
 	 * for IR DMA above. Allocate it on-demand and mark inactive. */
 	ohci->it_legacy_context.ohci = NULL;
-	spin_lock_init(&ohci->event_lock);
 
 	/*
 	 * interrupts are disabled, all right, but... due to IRQF_SHARED we


-- 
Stefan Richter
-=====-=-==- =-== ===--
http://arcgraph.de/sr/

