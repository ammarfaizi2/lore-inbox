Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbTGPLOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTGPLOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:14:49 -0400
Received: from kotol.kotelna.sk ([212.89.232.170]:23300 "EHLO kotol.kotelna.sk")
	by vger.kernel.org with ESMTP id S271030AbTGPLOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:14:47 -0400
Date: Wed, 16 Jul 2003 13:29:38 +0200
From: Martin Lucina <mato@kotelna.sk>
To: linux-kernel@vger.kernel.org
Subject: (Fwd) [PATCH] 3c59x suspend/resume
Message-ID: <20030716112938.GH12852@kotelna.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/me is living under a rock ...

----- Forwarded message from Martin Lucina <mato@kotelna.sk> -----

Date: Wed, 16 Jul 2003 13:26:36 +0200
From: Martin Lucina <mato@kotelna.sk>
Subject: [PATCH] 3c59x suspend/resume
To: akpm@zip.com.au
Cc: linux-kernel@vger.rutgers.edu

Hi,

having gotten tired of ejecting and reinserting my 3CCFE575CT Cardbus
card each time I do a suspend/resume, I've come up with the following
trivial patch to make it work for all cards in a system by default,
independently of the setting of enable_wol.

It's possible that this might not be the safest way to do it (maybe some
PCI cards don't like having their power state changed, should we check
some capabilities here?) but for me it makes a difference between "card
no work after suspend" and "card work most of the time[1] after
suspend".

Comments?

-mato

[1] Sometimes the card appears to get confused and refuse to transmit
for a while, which results in a transmit timeout from the NETDEV
WATCHDOG. All appears to be fine after the driver resets the TX ring
pointer though. Plus, it's still better than resuming without this
patch, which results in the driver occasionally hanging the whole
machine for random amounts of time.

PS. The documentation in networking/vortex.txt talks about
global_enable_wol, which doesn't seem to exist in the driver in 2.4.21.
Maybe this should be updated to match the driver? (I presume it is a
result of an earlier discussion about this that I saw on LKML)

--- drivers/net/3c59x.c.orig	Wed Jul 16 12:37:48 2003
+++ drivers/net/3c59x.c	Wed Jul 16 12:43:07 2003
@@ -1311,7 +1311,7 @@
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
-	if (pdev && vp->enable_wol) {
+	if (pdev) {
 		vp->pm_state_valid = 1;
  		pci_save_state(vp->pdev, vp->power_state);
  		acpi_set_WOL(dev);
@@ -1368,7 +1368,7 @@
 	unsigned int config;
 	int i;
 
-	if (vp->pdev && vp->enable_wol) {
+	if (vp->pdev) {
 		pci_set_power_state(vp->pdev, 0);	/* Go active */
 		pci_restore_state(vp->pdev, vp->power_state);
 	}
@@ -2506,7 +2506,7 @@
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (vp->pdev && vp->enable_wol) {
+	if (vp->pdev) {
 		pci_save_state(vp->pdev, vp->power_state);
 		acpi_set_WOL(dev);
 	}
@@ -2863,12 +2863,14 @@
 	struct vortex_private *vp = (struct vortex_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 
-	/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
-	EL3WINDOW(7);
-	outw(2, ioaddr + 0x0c);
-	/* The RxFilter must accept the WOL frames. */
-	outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
-	outw(RxEnable, ioaddr + EL3_CMD);
+        if (vp->enable_wol) {
+            /* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
+            EL3WINDOW(7);
+            outw(2, ioaddr + 0x0c);
+            /* The RxFilter must accept the WOL frames. */
+            outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
+            outw(RxEnable, ioaddr + EL3_CMD);
+        }
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
 	pci_enable_wake(vp->pdev, 0, 1);
@@ -2896,7 +2898,7 @@
 	/* Should really use issue_and_wait() here */
 	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
-	if (vp->pdev && vp->enable_wol) {
+	if (vp->pdev) {
 		pci_set_power_state(vp->pdev, 0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(vp->pdev, vp->power_state);


----- End forwarded message -----
