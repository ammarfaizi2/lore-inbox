Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264316AbTCXQz7>; Mon, 24 Mar 2003 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264278AbTCXQuV>; Mon, 24 Mar 2003 11:50:21 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:40426 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264276AbTCXQax>; Mon, 24 Mar 2003 11:30:53 -0500
Message-Id: <200303241642.h2OGg035008226@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:48 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: misc au1000 cleanups.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Missing release region
- Unneeded initialisation of private struct
  (already done in init_etherdev)
- Remove unneeded freeing of dev->priv
  (auto-free'd by kfree(dev)
- actually kfree (dev), plugging leak.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/au1000_eth.c linux-2.5/drivers/net/au1000_eth.c
--- bk-linus/drivers/net/au1000_eth.c	2003-03-08 09:57:14.000000000 +0000
+++ linux-2.5/drivers/net/au1000_eth.c	2003-02-20 12:16:32.000000000 +0000
@@ -675,37 +675,24 @@ au1000_probe1(struct net_device *dev, lo
 	char *pmac, *argptr;
 	char ethaddr[6];
 
-	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET")) {
+	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET"))
 		 return -ENODEV;
-	}
 
 	if (version_printed++ == 0) printk(version);
 
-	if (!dev) {
+	if (!dev)
 		dev = init_etherdev(0, sizeof(struct au1000_private));
-	}
+
 	if (!dev) {
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
