Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbTHTWh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbTHTWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:37:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:30381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262287AbTHTWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:37:11 -0400
Date: Wed, 20 Aug 2003 15:37:13 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix bug 923 for sis900 driver
Message-ID: <20030820223713.GB5138@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I realized that I've had this patch in my tree for a while, and forgot
to send it to you and lkml.  The patch below fixes bug number 923:
	http://bugme.osdl.org/show_bug.cgi?id=923
(basically keeps us from calling pci_find_device from interrupt
context.)

It's been tested by a few people with this device, and they say it works
just fine for them.  Please forward it on up the food chain.

thanks,

greg k-h


diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Wed Aug 20 15:29:35 2003
+++ b/drivers/net/sis900.c	Wed Aug 20 15:29:35 2003
@@ -169,6 +169,7 @@
 	dma_addr_t rx_ring_dma;
 
 	unsigned int tx_full;			/* The Tx queue is full.    */
+	u8 host_bridge_rev;
 };
 
 MODULE_AUTHOR("Jim Huang <cmhuang@sis.com.tw>, Ollie Lho <ollie@sis.com.tw>");
@@ -367,6 +368,7 @@
 {
 	struct sis900_private *sis_priv;
 	struct net_device *net_dev;
+	struct pci_dev *dev;
 	dma_addr_t ring_dma;
 	void *ring_space;
 	long ioaddr;
@@ -473,6 +475,11 @@
 		goto err_out_unregister;
 	}
 
+	/* save our host bridge revision */
+	dev = pci_find_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_630, NULL);
+	if (dev)
+		pci_read_config_byte(dev, PCI_CLASS_REVISION, &sis_priv->host_bridge_rev);
+
 	/* print some information about our NIC */
 	printk(KERN_INFO "%s: %s at %#lx, IRQ %d, ", net_dev->name,
 	       card_name, ioaddr, net_dev->irq);
@@ -1108,18 +1115,12 @@
 {
 	struct sis900_private *sis_priv = net_dev->priv;
 	u16 reg14h, eq_value=0, max_value=0, min_value=0;
-	u8 host_bridge_rev;
 	int i, maxcount=10;
-	struct pci_dev *dev=NULL;
 
 	if ( !(revision == SIS630E_900_REV || revision == SIS630EA1_900_REV ||
 	       revision == SIS630A_900_REV || revision ==  SIS630ET_900_REV) )
 		return;
 
-	dev = pci_find_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_630, dev);
-	if (dev)
-		pci_read_config_byte(dev, PCI_CLASS_REVISION, &host_bridge_rev);
-
 	if (netif_carrier_ok(net_dev)) {
 		reg14h=mdio_read(net_dev, sis_priv->cur_phy, MII_RESV);
 		mdio_write(net_dev, sis_priv->cur_phy, MII_RESV, (0x2200 | reg14h) & 0xBFFF);
@@ -1142,7 +1143,8 @@
 		}
 		/* 630B0&B1 rule to determine the equalizer value */
 		if (revision == SIS630A_900_REV && 
-		    (host_bridge_rev == SIS630B0 || host_bridge_rev == SIS630B1)) {
+		    (sis_priv->host_bridge_rev == SIS630B0 || 
+		     sis_priv->host_bridge_rev == SIS630B1)) {
 			if (max_value == 0)
 				eq_value=3;
 			else
@@ -1157,7 +1159,8 @@
 	else {
 		reg14h=mdio_read(net_dev, sis_priv->cur_phy, MII_RESV);
 		if (revision == SIS630A_900_REV && 
-		    (host_bridge_rev == SIS630B0 || host_bridge_rev == SIS630B1)) 
+		    (sis_priv->host_bridge_rev == SIS630B0 || 
+		     sis_priv->host_bridge_rev == SIS630B1)) 
 			mdio_write(net_dev, sis_priv->cur_phy, MII_RESV, (reg14h | 0x2200) & 0xBFFF);
 		else
 			mdio_write(net_dev, sis_priv->cur_phy, MII_RESV, (reg14h | 0x2000) & 0xBFFF);
