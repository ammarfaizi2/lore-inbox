Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265364AbRGLOUu>; Thu, 12 Jul 2001 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGLOUk>; Thu, 12 Jul 2001 10:20:40 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:64008 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S265166AbRGLOU2>; Thu, 12 Jul 2001 10:20:28 -0400
Date: Thu, 12 Jul 2001 07:20:27 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] one more starfire net driver fix for 2.4.7pre6
Message-ID: <Pine.LNX.4.33.0107120718160.18452-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch reverses the MII hunk from the previous patch, which was 
apparently breaking some cards. It also fixes an incorrect comment.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
---------------------------------
--- linux-2.4/drivers/net/starfire.c.orig	Thu Jul 12 10:15:18 2001
+++ linux-2.4/drivers/net/starfire.c	Thu Jul 12 10:17:30 2001
@@ -87,8 +87,7 @@
 
 	LK1.3.3 (Ion Badulescu)
 	- Initialize the TxMode register properly
-	- Set the MII registers _after_ resetting it
-	- Don't dereference dev->priv after unregister_netdev() has freed it
+	- Don't dereference dev->priv after freeing it
 
 TODO:
 	- implement tx_timeout() properly
@@ -987,12 +986,12 @@
 	struct netdev_private *np = dev->priv;
 	u16 reg0;
 
+	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 	mdio_write(dev, np->phys[0], MII_BMCR, BMCR_RESET);
 	udelay(500);
 	while (mdio_read(dev, np->phys[0], MII_BMCR) & BMCR_RESET);
 
 	reg0 = mdio_read(dev, np->phys[0], MII_BMCR);
-	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 
 	if (np->autoneg) {
 		reg0 |= BMCR_ANENABLE | BMCR_ANRESTART;
@@ -1939,12 +1938,12 @@
 		pci_free_consistent(pdev, PAGE_SIZE,
 				    np->rx_ring, np->rx_ring_dma);
 
-	unregister_netdev(dev);			/* Will also free np!! */
+	unregister_netdev(dev);
 	iounmap((char *)dev->base_addr);
 	pci_release_regions(pdev);
 
 	pci_set_drvdata(pdev, NULL);
-	kfree(dev);
+	kfree(dev);			/* Will also free np!! */
 }
 
 

