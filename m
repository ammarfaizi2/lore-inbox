Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUHHQRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUHHQRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUHHQRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:17:41 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:12515 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265773AbUHHQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:17:27 -0400
Date: Sun, 8 Aug 2004 16:03:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [3/3] via-rhine: small fixes
Message-ID: <20040808140312.GA8608@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808140216.GA8181@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove Rhine model names (per Jeff's request)
- remove redundant calls to clear MII cmd
- fill some rhine_private fields earlier

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.8-rc3-mm1/drivers/net/via-rhine.c.02	2004-08-08 13:16:11.009654178 +0200
+++ linux-2.6.8-rc3-mm1/drivers/net/via-rhine.c	2004-08-08 13:19:59.350890566 +0200
@@ -346,7 +346,7 @@ enum rhine_revs {
 	VT6105L		= 0x8A,
 	VT6107		= 0x8C,
 	VTunknown2	= 0x8E,
-	VT6105M		= 0x90,
+	VT6105M		= 0x90,	/* Management adapter */
 };
 
 enum rhine_quirks {
@@ -485,9 +485,7 @@ struct rhine_private {
 	dma_addr_t tx_bufs_dma;
 
 	struct pci_dev *pdev;
-#ifdef CONFIG_PM
 	long pioaddr;
-#endif
 	struct net_device_stats stats;
 	spinlock_t lock;
 
@@ -596,7 +594,7 @@ static void rhine_power_init(struct net_
 			default:
 				reason = "Unknown";
 			}
-			printk("%s: Woke system up. Reason: %s.\n",
+			printk(KERN_INFO "%s: Woke system up. Reason: %s.\n",
 			       DRV_NAME, reason);
 		}
 	}
@@ -706,7 +704,7 @@ static int __devinit rhine_init_one(stru
 	long memaddr;
 	long ioaddr;
 	int io_size, phy_id;
-	const char *name, *mname;
+	const char *name;
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -721,41 +719,24 @@ static int __devinit rhine_init_one(stru
 	phy_id = 0;
 	quirks = 0;
 	name = "Rhine";
-	mname = "unknown";
 	if (pci_rev < VTunknown0) {
 		quirks = rqRhineI;
 		io_size = 128;
-		mname = "VT86C100A";
 	}
 	else if (pci_rev >= VT6102) {
 		quirks = rqWOL | rqForceReset;
 		if (pci_rev < VT6105) {
 			name = "Rhine II";
 			quirks |= rqStatusWBRace;	/* Rhine-II exclusive */
-			if (pci_rev < VT8231)
-				mname = "VT6102";
-			else if (pci_rev < VT8233)
-				mname = "VT8231";
-			else if (pci_rev < VT8235)
-				mname = "VT8233";
-			else if (pci_rev < VT8237)
-				mname = "VT8235";
-			else if (pci_rev < VTunknown1)
-				mname = "VT8237";
 		}
 		else {
-			name = "Rhine III";
 			phy_id = 1;	/* Integrated PHY, phy_id fixed to 1 */
 			if (pci_rev >= VT6105_B0)
 				quirks |= rq6patterns;
-			if (pci_rev < VT6105L)
-				mname = "VT6105";
-			else if (pci_rev < VT6107)
-				mname = "VT6105L";
-			else if (pci_rev < VT6105M)
-				mname = "VT6107";
-			else if (pci_rev >= VT6105M)
-				mname = "Management Adapter VT6105M";
+			if (pci_rev < VT6105M)
+				name = "Rhine III";
+			else
+				name = "Rhine III (Management Adapter)";
 		}
 	}
 
@@ -793,6 +774,11 @@ static int __devinit rhine_init_one(stru
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
+	rp = netdev_priv(dev);
+	rp->quirks = quirks;
+	rp->pioaddr = pioaddr;
+	rp->pdev = pdev;
+
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
 		goto err_out_free_netdev;
@@ -826,11 +812,6 @@ static int __devinit rhine_init_one(stru
 #endif /* USE_MMIO */
 
 	dev->base_addr = ioaddr;
-	rp = netdev_priv(dev);
-	rp->quirks = quirks;
-#ifdef CONFIG_PM
-	rp->pioaddr = pioaddr;
-#endif
 
 	/* Get chip registers into a sane state */
 	rhine_power_init(dev);
@@ -852,7 +833,6 @@ static int __devinit rhine_init_one(stru
 	dev->irq = pdev->irq;
 
 	spin_lock_init(&rp->lock);
-	rp->pdev = pdev;
 	rp->mii_if.dev = dev;
 	rp->mii_if.mdio_read = mdio_read;
 	rp->mii_if.mdio_write = mdio_write;
@@ -880,8 +860,8 @@ static int __devinit rhine_init_one(stru
 	if (rc)
 		goto err_out_unmap;
 
-	printk(KERN_INFO "%s: VIA %s (%s) at 0x%lx, ",
-	       dev->name, name, mname,
+	printk(KERN_INFO "%s: VIA %s at 0x%lx, ",
+	       dev->name, name,
 #ifdef USE_MMIO
 		memaddr
 #else
@@ -1181,7 +1161,7 @@ static int mdio_read(struct net_device *
 
 	rhine_disable_linkmon(ioaddr, rp->quirks);
 
-	writeb(0, ioaddr + MIICmd);
+	/* rhine_disable_linkmon already cleared MIICmd */
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writeb(0x40, ioaddr + MIICmd);		/* Trigger read */
@@ -1199,7 +1179,7 @@ static void mdio_write(struct net_device
 
 	rhine_disable_linkmon(ioaddr, rp->quirks);
 
-	writeb(0, ioaddr + MIICmd);
+	/* rhine_disable_linkmon already cleared MIICmd */
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writew(value, ioaddr + MIIData);
