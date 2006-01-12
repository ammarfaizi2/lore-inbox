Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWALOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWALOld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWALOld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:41:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030423AbWALOlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:41:32 -0500
Message-ID: <43C66A95.4080505@redhat.com>
Date: Thu, 12 Jan 2006 09:41:25 -0500
From: Christopher Lalancette <clalance@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH: ethtool support for forcedeth for 2.4.33-pre1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
      The patch below adds improved ethtool support for forcedeth for 
2.4.33-pre1.  The patch was originally written against 2.4.21, but 
applies to 2.4.33-pre1 as well.  This patch adds support for get/set 
settings, get regs, and nway rst.

Chris Lalancette


--- linux-2.4.21/drivers/net/forcedeth.c.v0.30    2006-01-11 
16:28:20.557859000 -0500
+++ linux-2.4.21/drivers/net/forcedeth.c    2006-01-11 
16:32:32.750417000 -0500
@@ -212,6 +212,7 @@
  #define NVREG_LINKSPEED_10    1000
  #define NVREG_LINKSPEED_100    100
  #define NVREG_LINKSPEED_1000    50
+#define NVREG_LINKSPEED_MASK    (0xFFF)
      NvRegUnknownSetupReg5 = 0x130,
  #define NVREG_UNKSETUP5_BIT31    (1<<31)
      NvRegUnknownSetupReg3 = 0x13c,
@@ -443,6 +444,8 @@
      int in_shutdown;
      u32 linkspeed;
      int duplex;
+    int autoneg;
+    int fixed_mode;
      int phyaddr;
      int wolenabled;
      unsigned int phy_oui;
@@ -802,11 +805,238 @@
      return 0;
  }

+static int nv_update_linkspeed(struct net_device *dev);
+static int nv_get_settings(struct net_device *dev, struct ethtool_cmd 
*ecmd)
+{
+    struct fe_priv *np = get_nvpriv(dev);
+    int adv;
+
+    spin_lock_irq(&np->lock);
+    ecmd->port = PORT_MII;
+    if (!netif_running(dev)) {
+        /* We do not track link speed / duplex setting if the
+         * interface is disabled. Force a link check */
+        nv_update_linkspeed(dev);
+    }
+    switch(np->linkspeed & (NVREG_LINKSPEED_MASK)) {
+        case NVREG_LINKSPEED_10:
+            ecmd->speed = SPEED_10;
+            break;
+        case NVREG_LINKSPEED_100:
+            ecmd->speed = SPEED_100;
+            break;
+        case NVREG_LINKSPEED_1000:
+            ecmd->speed = SPEED_1000;
+            break;
+    }
+    ecmd->duplex = DUPLEX_HALF;
+    if (np->duplex)
+        ecmd->duplex = DUPLEX_FULL;
+
+    ecmd->autoneg = np->autoneg;
+
+    ecmd->advertising = ADVERTISED_MII;
+    if (np->autoneg) {
+        ecmd->advertising |= ADVERTISED_Autoneg;
+        adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+    } else {
+        adv = np->fixed_mode;
+    }
+
+    if (adv & ADVERTISE_10HALF)
+        ecmd->advertising |= ADVERTISED_10baseT_Half;
+    if (adv & ADVERTISE_10FULL)
+        ecmd->advertising |= ADVERTISED_10baseT_Full;
+    if (adv & ADVERTISE_100HALF)
+        ecmd->advertising |= ADVERTISED_100baseT_Half;
+    if (adv & ADVERTISE_100FULL)
+        ecmd->advertising |= ADVERTISED_100baseT_Full;
+    if (np->autoneg && np->gigabit == PHY_GIGABIT) {
+        adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+        if (adv & ADVERTISE_1000FULL)
+            ecmd->advertising |= ADVERTISED_1000baseT_Full;
+    }
+
+    ecmd->supported = (SUPPORTED_Autoneg |
+        SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+        SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+        SUPPORTED_MII);
+    if (np->gigabit == PHY_GIGABIT)
+        ecmd->supported |= SUPPORTED_1000baseT_Full;
+
+    ecmd->phy_address = np->phyaddr;
+    ecmd->transceiver = XCVR_EXTERNAL;
+
+    /* ignore maxtxpkt, maxrxpkt for now */
+    spin_unlock_irq(&np->lock);
+    return 0;
+}
+
+static void nv_linkchange(struct net_device *dev);
+static int nv_set_settings(struct net_device *dev, struct ethtool_cmd 
*ecmd)
+{
+    struct fe_priv *np = get_nvpriv(dev);
+
+    if (ecmd->port != PORT_MII)
+        return -EINVAL;
+    if (ecmd->transceiver != XCVR_EXTERNAL)
+        return -EINVAL;
+    if (ecmd->phy_address != np->phyaddr) {
+        /* TODO: support switching between multiple phys. Should be
+         * trivial, but not enabled due to lack of test hardware. */
+        return -EINVAL;
+    }
+    if (ecmd->autoneg == AUTONEG_ENABLE) {
+        u32 mask;
+
+        mask = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
+              ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
+        if (np->gigabit == PHY_GIGABIT)
+            mask |= ADVERTISED_1000baseT_Full;
+
+        if ((ecmd->advertising & mask) == 0)
+            return -EINVAL;
+
+    } else if (ecmd->autoneg == AUTONEG_DISABLE) {
+        /* Note: autonegotiation disable, speed 1000 intentionally
+         * forbidden - noone should need that. */
+
+        if (ecmd->speed != SPEED_10 && ecmd->speed != SPEED_100)
+            return -EINVAL;
+        if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
+            return -EINVAL;
+    } else {
+        return -EINVAL;
+    }
+
+    spin_lock_irq(&np->lock);
+    if (ecmd->autoneg == AUTONEG_ENABLE) {
+        int adv, bmcr;
+
+        np->autoneg = 1;
+
+        /* advertise only what has been requested */
+        adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+        adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+        if (ecmd->advertising & ADVERTISED_10baseT_Half)
+            adv |= ADVERTISE_10HALF;
+        if (ecmd->advertising & ADVERTISED_10baseT_Full)
+            adv |= ADVERTISE_10FULL;
+        if (ecmd->advertising & ADVERTISED_100baseT_Half)
+            adv |= ADVERTISE_100HALF;
+        if (ecmd->advertising & ADVERTISED_100baseT_Full)
+            adv |= ADVERTISE_100FULL;
+        mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+
+        if (np->gigabit == PHY_GIGABIT) {
+            adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+            adv &= ~ADVERTISE_1000FULL;
+            if (ecmd->advertising & ADVERTISED_1000baseT_Full)
+                adv |= ADVERTISE_1000FULL;
+            mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+        }
+
+        bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+        bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+        mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+    } else {
+        int adv, bmcr;
+
+        np->autoneg = 0;
+
+        adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+        adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+        if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_HALF)
+            adv |= ADVERTISE_10HALF;
+        if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_FULL)
+            adv |= ADVERTISE_10FULL;
+        if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_HALF)
+            adv |= ADVERTISE_100HALF;
+        if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_FULL)
+            adv |= ADVERTISE_100FULL;
+        mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+        np->fixed_mode = adv;
+
+        if (np->gigabit == PHY_GIGABIT) {
+            adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+            adv &= ~ADVERTISE_1000FULL;
+            mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+        }
+
+        bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+        bmcr |= ~(BMCR_ANENABLE|BMCR_SPEED100|BMCR_FULLDPLX);
+        if (adv & (ADVERTISE_10FULL|ADVERTISE_100FULL))
+            bmcr |= BMCR_FULLDPLX;
+        if (adv & (ADVERTISE_100HALF|ADVERTISE_100FULL))
+            bmcr |= BMCR_SPEED100;
+        mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+        if (netif_running(dev)) {
+            /* Wait a bit and then reconfigure the nic. */
+            udelay(10);
+            nv_linkchange(dev);
+        }
+    }
+    spin_unlock_irq(&np->lock);
+
+    return 0;
+}
+
+#define FORCEDETH_REGS_VER    1
+#define FORCEDETH_REGS_SIZE    0x400 /* 256 32-bit registers */
+
+static int nv_get_regs_len(struct net_device *dev)
+{
+    return FORCEDETH_REGS_SIZE;
+}
+
+static void nv_get_regs(struct net_device *dev, struct ethtool_regs 
*regs, void *buf)
+{
+    struct fe_priv *np = get_nvpriv(dev);
+    u8  *base = get_hwbase(dev);
+    u32 *rbuf = buf;
+    int i;
+
+    regs->version = FORCEDETH_REGS_VER;
+    spin_lock_irq(&np->lock);
+    for (i=0;i<FORCEDETH_REGS_SIZE/sizeof(u32);i++)
+        rbuf[i] = readl(base + i*sizeof(u32));
+    spin_unlock_irq(&np->lock);
+}
+
+static int nv_nway_reset(struct net_device *dev)
+{
+    struct fe_priv *np = get_nvpriv(dev);
+    int ret;
+
+    spin_lock_irq(&np->lock);
+    if (np->autoneg) {
+        int bmcr;
+
+        bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+        bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+        mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+        ret = 0;
+    } else {
+        ret = -EINVAL;
+    }
+    spin_unlock_irq(&np->lock);
+
+    return ret;
+}
+
  static struct ethtool_ops ops = {
      .get_drvinfo = nv_get_drvinfo,
      .get_link = ethtool_op_get_link,
      .get_wol = nv_get_wol,
      .set_wol = nv_set_wol,
+    .get_settings = nv_get_settings,
+    .set_settings = nv_set_settings,
+    .get_regs_len = nv_get_regs_len,
+    .get_regs = nv_get_regs,
+    .nway_reset = nv_nway_reset,
  };

  /*
@@ -1286,6 +1516,25 @@
          goto set_speed;
      }

+    if (np->autoneg == 0) {
+        dprintk(KERN_DEBUG "%s: nv_update_linkspeed: autoneg off, PHY 
set to 0x%04x.\n",
+                dev->name, np->fixed_mode);
+        if (np->fixed_mode & LPA_100FULL) {
+            newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+            newdup = 1;
+        } else if (np->fixed_mode & LPA_100HALF) {
+            newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+            newdup = 0;
+        } else if (np->fixed_mode & LPA_10FULL) {
+            newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+            newdup = 1;
+        } else {
+            newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+            newdup = 0;
+        }
+        retval = 1;
+        goto set_speed;
+    }
      /* check auto negotiation is complete */
      if (!(mii_status & BMSR_ANEGCOMPLETE)) {
          /* still in autonegotiation - configure nic for 10 MBit HD and 
wait. */
@@ -1362,9 +1611,9 @@
      phyreg &= ~(PHY_HALF|PHY_100|PHY_1000);
      if (np->duplex == 0)
          phyreg |= PHY_HALF;
-    if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_100)
+    if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_100)
          phyreg |= PHY_100;
-    else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+    else if ((np->linkspeed & NVREG_LINKSPEED_MASK) == 
NVREG_LINKSPEED_1000)
          phyreg |= PHY_1000;
      writel(phyreg, base + NvRegPhyInterface);

@@ -1865,6 +2114,10 @@
          phy_init(dev);
      }

+    np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+    np->duplex = 0;
+    np->autoneg = 1;
+
      err = register_netdev(dev);
      if (err) {
          printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", 
err);
