Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTEODWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEODWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:01 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:27884 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263815AbTEODS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:28 -0400
Date: Thu, 15 May 2003 04:31:06 +0100
Message-Id: <200305150331.h4F3V6ti000610@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: au1000 init cleanups.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if I incorporated all your feedback on this one last time.
Bug me if not...

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/au1000_eth.c linux-2.5/drivers/net/au1000_eth.c
--- bk-linus/drivers/net/au1000_eth.c	2003-04-30 16:02:26.000000000 +0100
+++ linux-2.5/drivers/net/au1000_eth.c	2003-04-30 16:18:41.000000000 +0100
@@ -675,37 +675,24 @@ au1000_probe1(struct net_device *dev, lo
 	char *pmac, *argptr;
 	char ethaddr[6];
 
-	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET")) {
+	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET"))
 		 return -ENODEV;
-	}
 
 	if (version_printed++ == 0) printk(version);
 
+	if (!dev)
+		dev = init_etherdev(NULL, sizeof(struct au1000_private));
+
 	if (!dev) {
-		dev = init_etherdev(0, sizeof(struct au1000_private));
-	}
-	if (!dev) {
-		 printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
-		 return -ENODEV;
+		printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
+		release_region(ioaddr, MAC_IOSIZE);
+		return -ENODEV;
 	}
 
 	printk("%s: Au1xxx ethernet found at 0x%lx, irq %d\n", 
 			dev->name, ioaddr, irq);
 
-	/* Initialize our private structure */
-	if (dev->priv == NULL) {
-		aup = (struct au1000_private *) 
-			kmalloc(sizeof(*aup), GFP_KERNEL);
-		if (aup == NULL) {
-			retval = -ENOMEM;
-			goto free_region;
-		}
-		dev->priv = aup;
-	}
-
 	aup = dev->priv;
-	memset(aup, 0, sizeof(*aup));
-
 
 	/* Allocate the data buffers */
 	aup->vaddr = (u32)dma_alloc(MAX_BUF_SIZE * 
@@ -834,8 +821,6 @@ free_region:
 	if (aup->vaddr) 
 		dma_free((void *)aup->vaddr, 
 				MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS));
-	if (dev->priv != NULL)
-		kfree(dev->priv);
 	printk(KERN_ERR "%s: au1000_probe1 failed.  Returns %d\n",
 	       dev->name, retval);
 	kfree(dev);
@@ -1003,15 +988,15 @@ static int au1000_close(struct net_devic
 	spin_lock_irqsave(&aup->lock, flags);
 	
 	/* stop the device */
-	if (netif_device_present(dev)) {
+	if (netif_device_present(dev))
 		netif_stop_queue(dev);
-	}
 
 	/* disable the interrupt */
 	free_irq(dev->irq, dev);
 	spin_unlock_irqrestore(&aup->lock, flags);
 
 	reset_mac(dev);
+	kfree(dev);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
