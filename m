Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264304AbTCXQxZ>; Mon, 24 Mar 2003 11:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264337AbTCXQu2>; Mon, 24 Mar 2003 11:50:28 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:41194 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264277AbTCXQax>; Mon, 24 Mar 2003 11:30:53 -0500
Message-Id: <200303241642.h2OGg335008252@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:51 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: xircom init_etherdev conversion.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Also cleans up some exit paths.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tulip/xircom_cb.c linux-2.5/drivers/net/tulip/xircom_cb.c
--- bk-linus/drivers/net/tulip/xircom_cb.c	2003-03-08 09:57:19.000000000 +0000
+++ linux-2.5/drivers/net/tulip/xircom_cb.c	2003-02-25 14:07:53.000000000 +0000
@@ -249,32 +249,24 @@ static int __devinit xircom_probe(struct
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	if ((dev = init_etherdev(dev, sizeof(struct xircom_private))) == NULL) {
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
 
@@ -304,14 +296,21 @@ static int __devinit xircom_probe(struct
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
 
 
