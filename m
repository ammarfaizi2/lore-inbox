Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266641AbRGTG5p>; Fri, 20 Jul 2001 02:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbRGTG5g>; Fri, 20 Jul 2001 02:57:36 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:45317 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S266641AbRGTG5Y>; Fri, 20 Jul 2001 02:57:24 -0400
Date: Fri, 20 Jul 2001 02:57:22 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH re-sent] one more starfire net driver fix for 2.4.7pre6+
Message-ID: <Pine.LNX.4.33.0107200256020.8516-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

This patch reverses the MII hunk from the previous patch (included in
2.4.7-pre6), which was apparently breaking some cards. It also fixes an
incorrect comment.

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
 
 


