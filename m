Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbUKQFg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUKQFg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 00:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUKQFg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 00:36:59 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:7651 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262174AbUKQFg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 00:36:28 -0500
Date: Wed, 17 Nov 2004 06:36:17 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
cc: blazara@nvidia.com
Subject: [PATCH] forcedeth: add ethtool link speed support
Message-ID: <Pine.LNX.4.44.0411170630050.11679-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the attached patch adds ethtool get_ and set_settings support to the
forcedeth nic driver. This allows to force a certain link speed with
ethtool -s.

Changelog:
- Code reorganization: move ethtool functions further down in forcedeth.c
  (no code changes within the existing ethtool functions)
- add support media detection without autodetection.
- implement get_settings and set_settings ethtool functions.

Please test it. It works with my 250-Gb board.

--
	Manfred
// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 10
//  EXTRAVERSION =-rc1
--- 2.6/drivers/net/forcedeth.c	2004-11-14 14:50:21.000000000 +0100
+++ build-2.6/drivers/net/forcedeth.c	2004-11-17 05:55:13.440930446 +0100
@@ -79,6 +79,8 @@
  *	0.30: 25 Sep 2004: rx checksum support for nf 250 Gb. Add rx reset
  *			   into nv_close, otherwise reenabling for wol can
  *			   cause DMA to kfree'd memory.
+ *	0.31: 14 Nov 2004: ethtool support for getting/setting link
+ *	                   capabilities.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -90,7 +92,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.30"
+#define FORCEDETH_VERSION		"0.31"
 #define DRV_NAME			"forcedeth"

 #include <linux/module.h>
@@ -210,6 +212,7 @@ enum {
 #define NVREG_LINKSPEED_10	1000
 #define NVREG_LINKSPEED_100	100
 #define NVREG_LINKSPEED_1000	50
+#define NVREG_LINKSPEED_MASK	(0xFFF)
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
 	NvRegUnknownSetupReg3 = 0x13c,
@@ -441,6 +444,8 @@ struct fe_priv {
 	int in_shutdown;
 	u32 linkspeed;
 	int duplex;
+	int autoneg;
+	int fixed_mode;
 	int phyaddr;
 	int wolenabled;
 	unsigned int phy_oui;
@@ -765,50 +770,6 @@ static struct net_device_stats *nv_get_s
 	return &np->stats;
 }

-static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	strcpy(info->driver, "forcedeth");
-	strcpy(info->version, FORCEDETH_VERSION);
-	strcpy(info->bus_info, pci_name(np->pci_dev));
-}
-
-static void nv_get_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	wolinfo->supported = WAKE_MAGIC;
-
-	spin_lock_irq(&np->lock);
-	if (np->wolenabled)
-		wolinfo->wolopts = WAKE_MAGIC;
-	spin_unlock_irq(&np->lock);
-}
-
-static int nv_set_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 __iomem *base = get_hwbase(dev);
-
-	spin_lock_irq(&np->lock);
-	if (wolinfo->wolopts == 0) {
-		writel(0, base + NvRegWakeUpFlags);
-		np->wolenabled = 0;
-	}
-	if (wolinfo->wolopts & WAKE_MAGIC) {
-		writel(NVREG_WAKEUPFLAGS_ENABLE, base + NvRegWakeUpFlags);
-		np->wolenabled = 1;
-	}
-	spin_unlock_irq(&np->lock);
-	return 0;
-}
-
-static struct ethtool_ops ops = {
-	.get_drvinfo = nv_get_drvinfo,
-	.get_link = ethtool_op_get_link,
-	.get_wol = nv_get_wol,
-	.set_wol = nv_set_wol,
-};
-
 /*
  * nv_alloc_rx: fill rx ring entries.
  * Return 1 if the allocations for the skbs failed and the
@@ -1286,6 +1247,25 @@ static int nv_update_linkspeed(struct ne
 		goto set_speed;
 	}

+	if (np->autoneg == 0) {
+		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: autoneg off, PHY set to 0x%04x.\n",
+				dev->name, np->fixed_mode);
+		if (np->fixed_mode & LPA_100FULL) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+			newdup = 1;
+		} else if (np->fixed_mode & LPA_100HALF) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+			newdup = 0;
+		} else if (np->fixed_mode & LPA_10FULL) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+			newdup = 1;
+		} else {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+			newdup = 0;
+		}
+		retval = 1;
+		goto set_speed;
+	}
 	/* check auto negotiation is complete */
 	if (!(mii_status & BMSR_ANEGCOMPLETE)) {
 		/* still in autonegotiation - configure nic for 10 MBit HD and wait. */
@@ -1303,7 +1283,7 @@ static int nv_update_linkspeed(struct ne

 		if ((control_1000 & ADVERTISE_1000FULL) &&
 			(status_1000 & LPA_1000FULL)) {
-		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
+			dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
 				dev->name);
 			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
 			newdup = 1;
@@ -1362,9 +1342,9 @@ set_speed:
 	phyreg &= ~(PHY_HALF|PHY_100|PHY_1000);
 	if (np->duplex == 0)
 		phyreg |= PHY_HALF;
-	if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_100)
+	if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_100)
 		phyreg |= PHY_100;
-	else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+	else if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_1000)
 		phyreg |= PHY_1000;
 	writel(phyreg, base + NvRegPhyInterface);

@@ -1500,6 +1480,227 @@ static void nv_do_nic_poll(unsigned long
 	enable_irq(dev->irq);
 }

+static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	strcpy(info->driver, "forcedeth");
+	strcpy(info->version, FORCEDETH_VERSION);
+	strcpy(info->bus_info, pci_name(np->pci_dev));
+}
+
+static void nv_get_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	wolinfo->supported = WAKE_MAGIC;
+
+	spin_lock_irq(&np->lock);
+	if (np->wolenabled)
+		wolinfo->wolopts = WAKE_MAGIC;
+	spin_unlock_irq(&np->lock);
+}
+
+static int nv_set_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+
+	spin_lock_irq(&np->lock);
+	if (wolinfo->wolopts == 0) {
+		writel(0, base + NvRegWakeUpFlags);
+		np->wolenabled = 0;
+	}
+	if (wolinfo->wolopts & WAKE_MAGIC) {
+		writel(NVREG_WAKEUPFLAGS_ENABLE, base + NvRegWakeUpFlags);
+		np->wolenabled = 1;
+	}
+	spin_unlock_irq(&np->lock);
+	return 0;
+}
+
+static int nv_get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	int adv;
+
+	spin_lock_irq(&np->lock);
+	ecmd->port = PORT_MII;
+	if (!netif_running(dev)) {
+		/* We do not track link speed / duplex setting if the
+		 * interface is disabled. Force a link check */
+		nv_update_linkspeed(dev);
+	}
+	switch(np->linkspeed & (NVREG_LINKSPEED_MASK)) {
+		case NVREG_LINKSPEED_10:
+			ecmd->speed = SPEED_10;
+			break;
+		case NVREG_LINKSPEED_100:
+			ecmd->speed = SPEED_100;
+			break;
+		case NVREG_LINKSPEED_1000:
+			ecmd->speed = SPEED_1000;
+			break;
+	}
+	ecmd->duplex = DUPLEX_HALF;
+	if (np->duplex)
+		ecmd->duplex = DUPLEX_FULL;
+
+	ecmd->autoneg = np->autoneg;
+
+	ecmd->advertising = ADVERTISED_MII;
+	if (np->autoneg) {
+		ecmd->advertising |= ADVERTISED_Autoneg;
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+	} else {
+		adv = np->fixed_mode;
+	}
+	if (adv & ADVERTISE_10HALF)
+		ecmd->advertising |= ADVERTISED_10baseT_Half;
+	if (adv & ADVERTISE_10FULL)
+		ecmd->advertising |= ADVERTISED_10baseT_Full;
+	if (adv & ADVERTISE_100HALF)
+		ecmd->advertising |= ADVERTISED_100baseT_Half;
+	if (adv & ADVERTISE_100FULL)
+		ecmd->advertising |= ADVERTISED_100baseT_Full;
+	if (np->autoneg && np->gigabit == PHY_GIGABIT) {
+		adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		if (adv & ADVERTISE_1000FULL)
+			ecmd->advertising |= ADVERTISED_1000baseT_Full;
+	}
+
+	ecmd->supported = (SUPPORTED_Autoneg |
+		SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+		SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+		SUPPORTED_MII);
+	if (np->gigabit == PHY_GIGABIT)
+		ecmd->supported |= SUPPORTED_1000baseT_Full;
+
+	ecmd->phy_address = np->phyaddr;
+	ecmd->transceiver = XCVR_EXTERNAL;
+
+	/* ignore maxtxpkt, maxrxpkt for now */
+	spin_unlock_irq(&np->lock);
+	return 0;
+}
+
+static int nv_set_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	struct fe_priv *np = netdev_priv(dev);
+
+	if (ecmd->port != PORT_MII)
+		return -EINVAL;
+	if (ecmd->transceiver != XCVR_EXTERNAL)
+		return -EINVAL;
+	if (ecmd->phy_address != np->phyaddr) {
+		/* TODO: support switching between multiple phys. Should be
+		 * trivial, but not enabled due to lack of test hardware. */
+		return -EINVAL;
+	}
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		u32 mask;
+
+		mask = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
+			  ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
+		if (np->gigabit == PHY_GIGABIT)
+			mask |= ADVERTISED_1000baseT_Full;
+
+		if ((ecmd->advertising & mask) == 0)
+			return -EINVAL;
+
+	} else if (ecmd->autoneg == AUTONEG_DISABLE) {
+		/* Note: autonegotiation disable, speed 1000 intentionally
+		 * forbidden - noone should need that. */
+
+		if (ecmd->speed != SPEED_10 && ecmd->speed != SPEED_100)
+			return -EINVAL;
+		if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&np->lock);
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		int adv, bmcr;
+
+		np->autoneg = 1;
+
+		/* advertise only what has been requested */
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+		adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+		if (ecmd->advertising & ADVERTISED_10baseT_Half)
+			adv |= ADVERTISE_10HALF;
+		if (ecmd->advertising & ADVERTISED_10baseT_Full)
+			adv |= ADVERTISE_10FULL;
+		if (ecmd->advertising & ADVERTISED_100baseT_Half)
+			adv |= ADVERTISE_100HALF;
+		if (ecmd->advertising & ADVERTISED_100baseT_Full)
+			adv |= ADVERTISE_100FULL;
+		mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+
+		if (np->gigabit == PHY_GIGABIT) {
+			adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+			adv &= ~ADVERTISE_1000FULL;
+			if (ecmd->advertising & ADVERTISED_1000baseT_Full)
+				adv |= ADVERTISE_1000FULL;
+			mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+		}
+
+		bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+	} else {
+		int adv, bmcr;
+
+		np->autoneg = 0;
+
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+		adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+		if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_HALF)
+			adv |= ADVERTISE_10HALF;
+		if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_FULL)
+			adv |= ADVERTISE_10FULL;
+		if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_HALF)
+			adv |= ADVERTISE_100HALF;
+		if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_FULL)
+			adv |= ADVERTISE_100FULL;
+		mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+		np->fixed_mode = adv;
+
+		if (np->gigabit == PHY_GIGABIT) {
+			adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+			adv &= ~ADVERTISE_1000FULL;
+			mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+		}
+
+		bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		bmcr |= ~(BMCR_ANENABLE|BMCR_SPEED100|BMCR_FULLDPLX);
+		if (adv & (ADVERTISE_10FULL|ADVERTISE_100FULL))
+			bmcr |= BMCR_FULLDPLX;
+		if (adv & (ADVERTISE_100HALF|ADVERTISE_100FULL))
+			bmcr |= BMCR_SPEED100;
+		mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+		if (netif_running(dev)) {
+			/* Wait a bit and then reconfigure the nic. */
+			udelay(10);
+			nv_linkchange(dev);
+		}
+	}
+	spin_unlock_irq(&np->lock);
+
+	return 0;
+}
+
+static struct ethtool_ops ops = {
+	.get_drvinfo = nv_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_wol = nv_get_wol,
+	.set_wol = nv_set_wol,
+	.get_settings = nv_get_settings,
+	.set_settings = nv_set_settings,
+};
+
 static int nv_open(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
@@ -1550,9 +1751,6 @@ static int nv_open(struct net_device *de
 		base + NvRegRingSizes);

 	/* 5) continue setup */
-	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
-	np->duplex = 0;
-
 	writel(np->linkspeed, base + NvRegLinkSpeed);
 	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
 	writel(np->desc_ver, base + NvRegTxRxControl);
@@ -1866,6 +2064,11 @@ static int __devinit nv_probe(struct pci
 		phy_init(dev);
 	}

+	/* set default link speed settings */
+	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+	np->duplex = 0;
+	np->autoneg = 1;
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);

