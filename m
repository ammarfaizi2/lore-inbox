Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJMXcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJMXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:32:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:63374 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbTJMXcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:32:18 -0400
Date: Mon, 13 Oct 2003 16:32:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NULL pointer dereference in sysfs_hash_and_remove()
Message-Id: <20031013163200.43e5d1bf.shemminger@osdl.org>
In-Reply-To: <1065220892.31749.39.camel@tux.rsn.bth.se>
References: <1065220892.31749.39.camel@tux.rsn.bth.se>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Oct 2003 00:41:32 +0200
Martin Josefsson <gandalf@wlug.westbo.se> wrote:

> Hi
> 
> I compiled 2.6.0-test6 and ran it on a laptop with cardbus.
> I have an Xircom NIC and if I remove it during operation I get the bug
> below.
> 
> I have yenta_socket and xircom_cb loaded as modules.


The driver was setting the statistics pointer after registration had occurred,
so on unregister the network code was removing a non-existent sysfs directory.

Try this please.

diff -Nru a/drivers/net/tulip/xircom_cb.c b/drivers/net/tulip/xircom_cb.c
--- a/drivers/net/tulip/xircom_cb.c	Mon Oct 13 16:29:05 2003
+++ b/drivers/net/tulip/xircom_cb.c	Mon Oct 13 16:29:05 2003
@@ -230,7 +230,8 @@
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	if ((dev = init_etherdev(NULL, sizeof(struct xircom_private))) == NULL) {
+	dev = alloc_etherdev(sizeof(struct xircom_private));
+	if (!dev) {
 		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
 		goto device_fail;
 	}
@@ -250,7 +251,7 @@
 
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
+
 
 	private->dev = dev;
 	private->pdev = pdev;
@@ -259,7 +260,6 @@
 	dev->irq = pdev->irq;
 	dev->base_addr = private->io_port;
 	
-	
 	initialize_card(private);
 	read_mac_address(private);
 	setup_descriptors(private);
@@ -272,7 +272,12 @@
 	SET_ETHTOOL_OPS(dev, &netdev_ethtool_ops);
 	pci_set_drvdata(pdev, dev);
 
-	
+	if (register_netdev(dev)) {
+		printk(KERN_ERR "xircom_probe: netdevice registration failed.\n");
+		goto reg_fail;
+	}
+		
+	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 	/* start the transmitter to get a heartbeat */
 	/* TODO: send 2 dummy packets here */
 	transceiver_voodoo(private);
@@ -287,10 +292,12 @@
 	leave("xircom_probe");
 	return 0;
 
+reg_fail:
+	kfree(private->tx_buffer);
 tx_buf_fail:
 	kfree(private->rx_buffer);
 rx_buf_fail:
-	kfree(dev);
+	free_netdev(dev);
 device_fail:
 	return -ENODEV;
 }
@@ -305,22 +312,16 @@
 static void __devexit xircom_remove(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct xircom_private *card;
+	struct xircom_private *card = dev->priv;
+
 	enter("xircom_remove");
-	if (dev!=NULL) {
-		card=dev->priv;
-		if (card!=NULL) {	
-			if (card->rx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
-			card->rx_buffer = NULL;
-			if (card->tx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
-			card->tx_buffer = NULL;			
-		}
-	}
+	pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
+	pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
+
 	release_region(dev->base_addr, 128);
 	unregister_netdev(dev);
 	free_netdev(dev);
+	pci_set_drvdata(pdev, NULL);
 	leave("xircom_remove");
 } 
 
