Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTEODYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTEODXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:23:16 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:18412 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263800AbTEODSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:23 -0400
Date: Thu, 15 May 2003 04:31:10 +0100
Message-Id: <200305150331.h4F3VAH6000662@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: xircom init cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tulip/xircom_cb.c linux-2.5/drivers/net/tulip/xircom_cb.c
--- bk-linus/drivers/net/tulip/xircom_cb.c	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/drivers/net/tulip/xircom_cb.c	2003-04-22 01:23:14.000000000 +0100
@@ -243,38 +243,29 @@ static int __devinit xircom_probe(struct
 		return -ENODEV;
 	}
 
-	
 	/* 
 	   Before changing the hardware, allocate the memory.
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	if ((dev = init_etherdev(NULL, sizeof(struct xircom_private))) == NULL) {
+		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
+		goto device_fail;
+	}
+	private = dev->priv;
 	
 	/* Allocate the send/receive buffers */
 	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
-	
 	if (private->rx_buffer == NULL) {
  		printk(KERN_ERR "xircom_probe: no memory for rx buffer \n");
- 		kfree(private);
-		return -ENODEV;
+		goto rx_buf_fail;
 	}	
 	private->tx_buffer = pci_alloc_consistent(pdev,8192,&private->tx_dma_handle);
 	if (private->tx_buffer == NULL) {
 		printk(KERN_ERR "xircom_probe: no memory for tx buffer \n");
-		kfree(private->rx_buffer);
-		kfree(private);
-		return -ENODEV;
-	}
-	dev = init_etherdev(dev, 0);
-	if (dev == NULL) {
-		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
-		kfree(private->rx_buffer);
-		kfree(private->tx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto tx_buf_fail;
 	}
+
 	SET_MODULE_OWNER(dev);
 	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 
@@ -304,14 +295,21 @@ static int __devinit xircom_probe(struct
 	transceiver_voodoo(private);
 	
 	spin_lock_irqsave(&private->lock,flags);
-	  activate_transmitter(private);
-	  activate_receiver(private);
+	activate_transmitter(private);
+	activate_receiver(private);
 	spin_unlock_irqrestore(&private->lock,flags);
 	
 	trigger_receive(private);
 	
 	leave("xircom_probe");
 	return 0;
+
+tx_buf_fail:
+	kfree(private->rx_buffer);
+rx_buf_fail:
+	kfree(dev);
+device_fail:
+	return -ENODEV;
 }
 
 
@@ -336,7 +334,6 @@ static void __devexit xircom_remove(stru
 				pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
 			card->tx_buffer = NULL;			
 		}
-		kfree(card);
 	}
 	release_region(dev->base_addr, 128);
 	unregister_netdev(dev);
