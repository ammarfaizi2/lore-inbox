Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264278AbTCXQz7>; Mon, 24 Mar 2003 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264336AbTCXQuM>; Mon, 24 Mar 2003 11:50:12 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:41706 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264278AbTCXQax>; Mon, 24 Mar 2003 11:30:53 -0500
Message-Id: <200303241642.h2OGg235008237@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:49 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: init_etherdev conversion for sb1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also plugs leak by kfree'ing dev_sb1000 on exit.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/sb1000.c linux-2.5/drivers/net/sb1000.c
--- bk-linus/drivers/net/sb1000.c	2003-03-08 09:57:16.000000000 +0000
+++ linux-2.5/drivers/net/sb1000.c	2003-03-17 23:42:27.000000000 +0000
@@ -218,7 +218,7 @@ sb1000_probe(struct net_device *dev)
 				"S/N %#8.8x, IRQ %d.\n", dev->name, dev->base_addr,
 				dev->mem_start, serial_number, dev->irq);
 
-		dev = init_etherdev(dev, 0);
+		dev = init_etherdev(dev, sizeof(struct sb1000_private));
 		if (!dev) {
 			pnp_device_detach(idev);
 			release_region(ioaddr[1], 16);
@@ -227,12 +227,6 @@ sb1000_probe(struct net_device *dev)
 		}
 		SET_MODULE_OWNER(dev);
 
-		/* Make up a SB1000-specific-data structure. */
-		dev->priv = kmalloc(sizeof(struct sb1000_private), GFP_KERNEL);
-		if (dev->priv == NULL)
-			return -ENOMEM;
-		memset(dev->priv, 0, sizeof(struct sb1000_private));
-
 		if (sb1000_debug > 0)
 			printk(KERN_NOTICE "%s", version);
 
@@ -1251,8 +1245,7 @@ void cleanup_module(void)
 	unregister_netdev(&dev_sb1000);
 	release_region(dev_sb1000.base_addr, 16);
 	release_region(dev_sb1000.mem_start, 16);
-	kfree(dev_sb1000.priv);
-	dev_sb1000.priv = NULL;
+	kfree(dev_sb1000);
 }
 #endif /* MODULE */
 
