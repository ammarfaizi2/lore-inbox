Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbVKHGpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbVKHGpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVKHGpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:45:50 -0500
Received: from [85.8.13.51] ([85.8.13.51]:7064 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965286AbVKHGpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:45:49 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] Register interrupt handler when net device is registered. Avoids missing
Date: Tue, 08 Nov 2005 07:45:48 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051108064547.18106.53763.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

interrupts if the interrupt mask gets out of sync.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

---

The reason this patch is needed for me is that the resume function is
broken. It enables interrupts unconditionally, but the interrupt handler
is only registered when the device is up.

I don't have enough knowledge about the driver to fix the resume
function so this patch will instead make sure that the interrupt handler
is registered at all times (which can be a nice safeguard even when the
resume function gets fixed).
---

 drivers/net/8139cp.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1196,20 +1196,11 @@ static int cp_open (struct net_device *d
 
 	cp_init_hw(cp);
 
-	rc = request_irq(dev->irq, cp_interrupt, SA_SHIRQ, dev->name, dev);
-	if (rc)
-		goto err_out_hw;
-
 	netif_carrier_off(dev);
 	mii_check_media(&cp->mii_if, netif_msg_link(cp), TRUE);
 	netif_start_queue(dev);
 
 	return 0;
-
-err_out_hw:
-	cp_stop_hw(cp);
-	cp_free_rings(cp);
-	return rc;
 }
 
 static int cp_close (struct net_device *dev)
@@ -1230,7 +1221,6 @@ static int cp_close (struct net_device *
 	spin_unlock_irqrestore(&cp->lock, flags);
 
 	synchronize_irq(dev->irq);
-	free_irq(dev->irq, dev);
 
 	cp_free_rings(cp);
 	return 0;
@@ -1814,6 +1804,10 @@ static int cp_init_one (struct pci_dev *
 	if (rc)
 		goto err_out_iomap;
 
+	rc = request_irq(dev->irq, cp_interrupt, SA_SHIRQ, dev->name, dev);
+	if (rc)
+		goto err_out_unreg;
+
 	printk (KERN_INFO "%s: RTL-8139C+ at 0x%lx, "
 		"%02x:%02x:%02x:%02x:%02x:%02x, "
 		"IRQ %d\n",
@@ -1833,6 +1827,8 @@ static int cp_init_one (struct pci_dev *
 
 	return 0;
 
+err_out_unreg:
+	unregister_netdev(dev);
 err_out_iomap:
 	iounmap(regs);
 err_out_res:
@@ -1853,6 +1849,7 @@ static void cp_remove_one (struct pci_de
 
 	if (!dev)
 		BUG();
+	free_irq(dev->irq, dev);
 	unregister_netdev(dev);
 	iounmap(cp->regs);
 	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);

