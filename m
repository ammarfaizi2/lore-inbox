Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUE3Kxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUE3Kxb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUE3Kxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:53:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262114AbUE3KxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:53:19 -0400
Date: Sun, 30 May 2004 06:53:05 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: PATCH: First cut at fixing the 3c59x power mismanagment
Message-ID: <20040530105305.GA5312@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Fedora 2 there have been lots of problem reports with 3c59x mostly 
apparently linked to power handling errors. In particular tools query the
MII state of down interfaces.

The changes here

-	Power the chip up when doing MII, much as e100 does
-	Fix a case where the error handling issued commands to the chip
	while it was in D3 state
-	Fixed a case where shutdown handling issued commands to the chip
	while it was in D3 state

I don't have enough suitable hardware to do good coverage testing on these
changes so test reports would be appreciated.

Alan


--- ../linux.vanilla-2.6.6/drivers/net/3c59x.c	2004-05-10 03:31:55.000000000 +0100
+++ drivers/net/3c59x.c	2004-05-29 23:25:37.300505816 +0100
@@ -884,7 +884,7 @@
 static int vortex_probe1(struct device *gendev, long ioaddr, int irq,
 				   int chip_idx, int card_idx);
 static void vortex_up(struct net_device *dev);
-static void vortex_down(struct net_device *dev);
+static void vortex_down(struct net_device *dev, int final);
 static int vortex_open(struct net_device *dev);
 static void mdio_sync(long ioaddr, int bits);
 static int mdio_read(struct net_device *dev, int phy_id, int location);
@@ -948,7 +948,7 @@
 	if (dev && dev->priv) {
 		if (netif_running(dev)) {
 			netif_device_detach(dev);
-			vortex_down(dev);
+			vortex_down(dev, 1);
 		}
 	}
 	return 0;
@@ -2059,7 +2059,8 @@
 				printk(KERN_ERR "%s: PCI bus error, bus status %8.8x\n", dev->name, bus_status);
 
 			/* In this case, blow the card away */
-			vortex_down(dev);
+			/* Must not enter D3 or we can't legally issue the reset! */
+			vortex_down(dev, 0);
 			issue_and_wait(dev, TotalReset | 0xff);
 			vortex_up(dev);		/* AKPM: bug.  vortex_up() assumes that the rx ring is full. It may not be. */
 		} else if (fifo_diag & 0x0400)
@@ -2656,7 +2657,7 @@
 }
 
 static void
-vortex_down(struct net_device *dev)
+vortex_down(struct net_device *dev, int final_down)
 {
 	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
@@ -2685,7 +2686,7 @@
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (VORTEX_PCI(vp) && vp->enable_wol) {
+	if (final_down && VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_save_state(VORTEX_PCI(vp), vp->power_state);
 		acpi_set_WOL(dev);
 	}
@@ -2699,7 +2700,7 @@
 	int i;
 
 	if (netif_device_present(dev))
-		vortex_down(dev);
+		vortex_down(dev, 1);
 
 	if (vortex_debug > 1) {
 		printk(KERN_DEBUG"%s: vortex_close() status %4.4x, Tx status %2.2x.\n",
@@ -2869,7 +2870,7 @@
 	.get_drvinfo =		vortex_get_drvinfo,
 };
 
-static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int vortex_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
@@ -2904,6 +2905,30 @@
 	return retval;
 }
 
+/*
+ *	Must power the device up to do MDIO operations
+ */
+static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	int err;
+	struct vortex_private *vp = netdev_priv(dev);
+	int state = 0;
+	
+	if(VORTEX_PCI(vp))
+		state = VORTEX_PCI(vp)->current_state;
+
+	/* The kernel core really should have pci_get_power_state() */
+
+	if(state != 0)
+		pci_set_power_state(VORTEX_PCI(vp), 0);	
+	err = vortex_do_ioctl(dev, rq, cmd);
+	if(state != 0)
+		pci_set_power_state(VORTEX_PCI(vp), state);	
+	
+	return err;
+}
+
+
 /* Pre-Cyclone chips have no documented multicast filter, so the only
    multicast setting is to receive all multicast frames.  At least
    the chip has a very clean way to set the mode, unlike many others. */
@@ -3059,14 +3084,14 @@
 	 * here
 	 */
 	unregister_netdev(dev);
-	/* Should really use issue_and_wait() here */
-	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
+	/* Should really use issue_and_wait() here */
+	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
