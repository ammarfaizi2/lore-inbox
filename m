Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTKUHn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTKUHn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:43:28 -0500
Received: from [202.81.18.30] ([202.81.18.30]:21070 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264313AbTKUHmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:42:05 -0500
Subject: Re: sungem issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: "Badinter, George" <george.badinter@citigroup.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <D3365BA42AA4D611A5100008023D06D20556B563@exchny49.ny.ssmb.com>
References: <D3365BA42AA4D611A5100008023D06D20556B563@exchny49.ny.ssmb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1069400503.876.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 21 Nov 2003 18:41:44 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-21 at 10:59, Badinter, George wrote:
> I am running 2.4-22 on x86 with Sun GigE Card. The card seemed to
> recognized fined and I see it come up. However,
> it doesn't want to play nice with Cisco 3500XL switch. I have tried
> several port setting on the switch's port i.e.
> autoneg off/on duplex full/half and etc. I see link lights, ethtool says
> that the link is up, but there is no traffic coming through.
> This brings me to the interesting point, apparently sungem driver was
> fixed from 2.4-19 to 2.4-22, however ethtool still
> has no effect on it. No matter, how much I tried to play with it, it
> will not change any settings on sungem interface. It comes
> at 100 Full Duplex, autoneg on. 
> 
> Has anyone able to make this card work under 2.4-22??? Please help!!

Send me a dmesg output please.

Does this patch help ? It's a bit huge I know, it's +/- what I have
in the pmac tree for 2.4. I need to do a new backport from 2.6 and
submit that to DaveM & Marcelo for 2.4.24

diff -urN drivers/net/sungem.c ../linux-2.4.22-ben2/drivers/net/sungem.c
--- drivers/net/sungem.c	2003-08-25 21:44:42.000000000 +1000
+++ ../linux-2.4.22-ben2/drivers/net/sungem.c	2003-08-31 19:42:22.000000000 +1000
@@ -10,10 +10,6 @@
  *  - Get rid of all those nasty mdelay's and replace them
  * with schedule_timeout.
  *  - Implement WOL
- *  - Currently, forced Gb mode is only supported on bcm54xx
- *    PHY for which I use the SPD2 bit of the control register.
- *    On m1011 PHY, I can't force as I don't have the specs, but
- *    I can at least detect gigabit with autoneg.
  */
 
 #include <linux/config.h>
@@ -63,12 +59,20 @@
 #include <asm/pmac_feature.h>
 #endif
 
+#include "sungem_phy.h"
 #include "sungem.h"
 
+/* Stripping FCS is causing problems, disabled for now */
+#undef STRIP_FCS
+
 #define DEFAULT_MSG	(NETIF_MSG_DRV		| \
 			 NETIF_MSG_PROBE	| \
 			 NETIF_MSG_LINK)
 
+#define ADVERTISE_MASK	(SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full | \
+			 SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | \
+			 SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full)
+
 #define DRV_NAME	"sungem"
 #define DRV_VERSION	"0.97"
 #define DRV_RELDATE	"3/20/02"
@@ -81,24 +85,6 @@
 MODULE_DESCRIPTION("Sun GEM Gbit ethernet driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(gem_debug, "i");
-MODULE_PARM_DESC(gem_debug, "bitmapped message enable number");
-MODULE_PARM(link_mode, "i");
-MODULE_PARM_DESC(link_mode, "default link mode");
-
-int gem_debug = -1;
-static int link_mode;
-
-static u16 link_modes[] __devinitdata = {
-	BMCR_ANENABLE,			/* 0 : autoneg */
-	0,				/* 1 : 10bt half duplex */
-	BMCR_SPEED100,			/* 2 : 100bt half duplex */
-	BMCR_SPD2, /* bcm54xx only */   /* 3 : 1000bt half duplex */
-	BMCR_FULLDPLX,			/* 4 : 10bt full duplex */
-	BMCR_SPEED100|BMCR_FULLDPLX,	/* 5 : 100bt full duplex */
-	BMCR_SPD2|BMCR_FULLDPLX		/* 6 : 1000bt full duplex */
-};
-
 #define GEM_MODULE_NAME	"gem"
 #define PFX GEM_MODULE_NAME ": "
 
@@ -119,12 +105,14 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMACP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{0, }
 };
 
 MODULE_DEVICE_TABLE(pci, gem_pci_tbl);
 
-static u16 __phy_read(struct gem *gp, int reg, int phy_addr)
+static u16 __phy_read(struct gem *gp, int phy_addr, int reg)
 {
 	u32 cmd;
 	int limit = 10000;
@@ -150,12 +138,18 @@
 	return cmd & MIF_FRAME_DATA;
 }
 
+static inline int _phy_read(struct net_device *dev, int mii_id, int reg)
+{
+	struct gem *gp = dev->priv;
+	return __phy_read(gp, mii_id, reg);
+}
+
 static inline u16 phy_read(struct gem *gp, int reg)
 {
-	return __phy_read(gp, reg, gp->mii_phy_addr);
+	return __phy_read(gp, gp->mii_phy_addr, reg);
 }
 
-static void __phy_write(struct gem *gp, int reg, u16 val, int phy_addr)
+static void __phy_write(struct gem *gp, int phy_addr, int reg, u16 val)
 {
 	u32 cmd;
 	int limit = 10000;
@@ -177,9 +171,15 @@
 	}
 }
 
+static inline void _phy_write(struct net_device *dev, int mii_id, int reg, int val)
+{
+	struct gem *gp = dev->priv;
+	__phy_write(gp, mii_id, reg, val & 0xffff);
+}
+
 static inline void phy_write(struct gem *gp, int reg, u16 val)
 {
-	__phy_write(gp, reg, val, gp->mii_phy_addr);
+	__phy_write(gp, gp->mii_phy_addr, reg, val);
 }
 
 static void gem_handle_mif_event(struct gem *gp, u32 reg_val, u32 changed_bits)
@@ -228,10 +228,11 @@
 	if (pcs_miistat & PCS_MIISTAT_LS) {
 		printk(KERN_INFO "%s: PCS link is now up.\n",
 		       dev->name);
+		netif_carrier_on(gp->dev);
 	} else {
 		printk(KERN_INFO "%s: PCS link is now down.\n",
 		       dev->name);
-
+		netif_carrier_off(gp->dev);
 		/* If this happens and the link timer is not running,
 		 * reset so we re-negotiate.
 		 */
@@ -359,6 +360,7 @@
 
 		rxd->status_word = cpu_to_le64(RXDCTRL_FRESH(gp));
 	}
+	mb();
 	gp->rx_new = gp->rx_old = 0;
 
 	/* Now we must reprogram the rest of RX unit. */
@@ -400,6 +402,10 @@
 			gp->dev->name, rxmac_stat);
 
 	if (rxmac_stat & MAC_RXSTAT_OFLW) {
+		u32 smac = readl(gp->regs + MAC_SMACHINE);
+
+		printk(KERN_ERR "%s: RX MAC fifo overflow smac[%08x].\n",
+				dev->name, smac);
 		gp->net_stats.rx_over_errors++;
 		gp->net_stats.rx_fifo_errors++;
 
@@ -667,6 +673,7 @@
 			count = 0;
 		}
 	}
+	mb();
 	if (kick >= 0)
 		writel(kick, gp->regs + RXDMA_KICK);
 }
@@ -893,7 +900,7 @@
 		/* We must give this initial chunk to the device last.
 		 * Otherwise we could race with the device.
 		 */
-		first_len = skb->len - skb->data_len;
+		first_len = skb_headlen(skb);
 		first_mapping = pci_map_page(gp->pdev, virt_to_page(skb->data),
 					     ((unsigned long) skb->data & ~PAGE_MASK),
 					     first_len, PCI_DMA_TODEVICE);
@@ -936,6 +943,7 @@
 	if (netif_msg_tx_queued(gp))
 		printk(KERN_DEBUG "%s: tx queued, slot %d, skblen %d\n",
 		       dev->name, entry, skb->len);
+	mb();
 	writel(gp->tx_new, gp->regs + TXDMA_KICK);
 	spin_unlock_irq(&gp->lock);
 
@@ -1003,7 +1011,7 @@
 	} while (val & (GREG_SWRST_TXRST | GREG_SWRST_RXRST));
 
 	if (limit <= 0)
-		printk(KERN_ERR "gem: SW reset is ghetto.\n");
+		printk(KERN_ERR "%s: SW reset is ghetto.\n", gp->dev->name);
 }
 
 /* Must be invoked under gp->lock. */
@@ -1030,136 +1038,118 @@
 
 }
 
-/* Link modes of the BCM5400 PHY */
-static int phy_BCM5400_link_table[8][3] = {
-	{ 0, 0, 0 },	/* No link */
-	{ 0, 0, 0 },	/* 10BT Half Duplex */
-	{ 1, 0, 0 },	/* 10BT Full Duplex */
-	{ 0, 1, 0 },	/* 100BT Half Duplex */
-	{ 0, 1, 0 },	/* 100BT Half Duplex */
-	{ 1, 1, 0 },	/* 100BT Full Duplex*/
-	{ 1, 0, 1 },	/* 1000BT */
-	{ 1, 0, 1 },	/* 1000BT */
-};
 
 /* Must be invoked under gp->lock. */
+// XXX dbl check what that function should do when called on PCS PHY
 static void gem_begin_auto_negotiation(struct gem *gp, struct ethtool_cmd *ep)
 {
-	u16 ctl;
+	u32 advertise, features;
+	int autoneg;
+	int speed;
+	int duplex;
+
+	if (gp->phy_type != phy_mii_mdio0 &&
+     	    gp->phy_type != phy_mii_mdio1)
+     	    	goto non_mii;
+
+	/* Setup advertise */
+	if (found_mii_phy(gp))
+		features = gp->phy_mii.def->features;
+	else
+		features = 0;
+
+	advertise = features & ADVERTISE_MASK;
+	if (gp->phy_mii.advertising != 0)
+		advertise &= gp->phy_mii.advertising;
+
+	autoneg = gp->want_autoneg;
+	speed = gp->phy_mii.speed;
+	duplex = gp->phy_mii.duplex;
 	
 	/* Setup link parameters */
 	if (!ep)
 		goto start_aneg;
 	if (ep->autoneg == AUTONEG_ENABLE) {
-		/* TODO: parse ep->advertising */
-		gp->link_advertise |= (ADVERTISE_10HALF | ADVERTISE_10FULL);
-		gp->link_advertise |= (ADVERTISE_100HALF | ADVERTISE_100FULL);
-		/* Can I advertise gigabit here ? I'd need BCM PHY docs... */
-		gp->link_cntl = BMCR_ANENABLE;
+		advertise = ep->advertising;
+		autoneg = 1;
 	} else {
-		gp->link_cntl = 0;
-		if (ep->speed == SPEED_100)
-			gp->link_cntl |= BMCR_SPEED100;
-		else if (ep->speed == SPEED_1000 && gp->gigabit_capable)
-			/* Hrm... check if this is right... */
-			gp->link_cntl |= BMCR_SPD2;
-		if (ep->duplex == DUPLEX_FULL)
-			gp->link_cntl |= BMCR_FULLDPLX;
+		autoneg = 0;
+		speed = ep->speed;
+		duplex = ep->duplex;
 	}
 
 start_aneg:
-	if (!gp->hw_running)
+	/* Sanitize settings based on PHY capabilities */
+	if ((features & SUPPORTED_Autoneg) == 0)
+		autoneg = 0;
+	if (speed == SPEED_1000 &&
+	    !(features & (SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full)))
+		speed = SPEED_100;
+	if (speed == SPEED_100 &&
+	    !(features & (SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full)))
+		speed = SPEED_10;
+	if (duplex == DUPLEX_FULL &&
+	    !(features & (SUPPORTED_1000baseT_Full |
+	    		  SUPPORTED_100baseT_Full |
+	    		  SUPPORTED_10baseT_Full)))
+	    	duplex = DUPLEX_HALF;
+	if (speed == 0)
+		speed = SPEED_10;
+	
+	/* If HW is down, we don't try to actually setup the PHY, we
+	 * just store the settings
+	 */
+	if (!gp->hw_running) {
+		gp->phy_mii.autoneg = gp->want_autoneg = autoneg;
+		gp->phy_mii.speed = speed;
+		gp->phy_mii.duplex = duplex;
 		return;
+	}
 
 	/* Configure PHY & start aneg */
-	ctl = phy_read(gp, MII_BMCR);
-	ctl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_ANENABLE);
-	ctl |= gp->link_cntl;
-	if (ctl & BMCR_ANENABLE) {
-		ctl |= BMCR_ANRESTART;
+	gp->want_autoneg = autoneg;
+	if (autoneg) {
+		if (found_mii_phy(gp))
+			gp->phy_mii.def->ops->setup_aneg(&gp->phy_mii, advertise);
 		gp->lstate = link_aneg;
 	} else {
+		if (found_mii_phy(gp))
+			gp->phy_mii.def->ops->setup_forced(&gp->phy_mii, speed, duplex);
 		gp->lstate = link_force_ok;
 	}
-	phy_write(gp, MII_BMCR, ctl);
 
+non_mii:
 	gp->timer_ticks = 0;
 	mod_timer(&gp->link_timer, jiffies + ((12 * HZ) / 10));
 }
 
-/* Must be invoked under gp->lock. */
-static void gem_read_mii_link_mode(struct gem *gp, int *fd, int *spd, int *pause)
-{
-	u32 val;
-
-	*fd = 0;
-	*spd = 10;
-	*pause = 0;
-	
-	if (gp->phy_mod == phymod_bcm5400 ||
-	    gp->phy_mod == phymod_bcm5401 ||
-	    gp->phy_mod == phymod_bcm5411) {
-		int link_mode;	
-
-	    	val = phy_read(gp, MII_BCM5400_AUXSTATUS);
-		link_mode = ((val & MII_BCM5400_AUXSTATUS_LINKMODE_MASK) >>
-			     MII_BCM5400_AUXSTATUS_LINKMODE_SHIFT);
-		*fd = phy_BCM5400_link_table[link_mode][0];
-		*spd = phy_BCM5400_link_table[link_mode][2] ?
-			1000 :
-			(phy_BCM5400_link_table[link_mode][1] ? 100 : 10);
-		val = phy_read(gp, MII_LPA);
-		if (val & LPA_PAUSE)
-			*pause = 1;
-	} else {
-		val = phy_read(gp, MII_LPA);
-
-		if (val & (LPA_10FULL | LPA_100FULL))
-			*fd = 1;
-		if (val & (LPA_100FULL | LPA_100HALF))
-			*spd = 100;
-
-		if (gp->phy_mod == phymod_m1011) {
-			val = phy_read(gp, 0x0a);
-			if (val & 0xc00)
-				*spd = 1000;
-			if (val & 0x800)
-				*fd = 1;
-		}
-	}
-}
-
 /* A link-up condition has occurred, initialize and enable the
  * rest of the chip.
  *
  * Must be invoked under gp->lock.
  */
-static void gem_set_link_modes(struct gem *gp)
+static int gem_set_link_modes(struct gem *gp)
 {
 	u32 val;
 	int full_duplex, speed, pause;
 
 	full_duplex = 0;
-	speed = 10;
+	speed = SPEED_10;
 	pause = 0;
 
-	if (gp->phy_type == phy_mii_mdio0 ||
-	    gp->phy_type == phy_mii_mdio1) {
-		val = phy_read(gp, MII_BMCR);
-		if (val & BMCR_ANENABLE)
-			gem_read_mii_link_mode(gp, &full_duplex, &speed, &pause);
-		else {
-			if (val & BMCR_FULLDPLX)
-				full_duplex = 1;
-			if (val & BMCR_SPEED100)
-				speed = 100;
-		}
-	} else {
+	if (found_mii_phy(gp)) {
+	    	if (gp->phy_mii.def->ops->read_link(&gp->phy_mii))
+	    		return 1;
+		full_duplex = (gp->phy_mii.duplex == DUPLEX_FULL);
+		speed = gp->phy_mii.speed;
+		pause = gp->phy_mii.pause;
+	} else if (gp->phy_type == phy_serialink ||
+	    	   gp->phy_type == phy_serdes) {
 		u32 pcs_lpa = readl(gp->regs + PCS_MIILP);
 
 		if (pcs_lpa & PCS_MIIADV_FD)
 			full_duplex = 1;
-		speed = 1000;
+		speed = SPEED_1000;
 	}
 
 	if (netif_msg_link(gp))
@@ -1183,7 +1173,7 @@
 		val |= MAC_XIFCFG_FLED;
 	}
 
-	if (speed == 1000)
+	if (speed == SPEED_1000)
 		val |= (MAC_XIFCFG_GMII);
 
 	writel(val, gp->regs + MAC_XIFCFG);
@@ -1191,7 +1181,7 @@
 	/* If gigabit and half-duplex, enable carrier extension
 	 * mode.  Else, disable it.
 	 */
-	if (speed == 1000 && !full_duplex) {
+	if (speed == SPEED_1000 && !full_duplex) {
 		val = readl(gp->regs + MAC_TXCFG);
 		writel(val | MAC_TXCFG_TCE, gp->regs + MAC_TXCFG);
 
@@ -1239,50 +1229,51 @@
 	writel(val, gp->regs + MAC_MCCFG);
 
 	gem_start_dma(gp);
+
+	return 0;
 }
 
 /* Must be invoked under gp->lock. */
 static int gem_mdio_link_not_up(struct gem *gp)
 {
-	u16 val;
-	
-	if (gp->lstate == link_force_ret) {
+	switch (gp->lstate) {
+	case link_force_ret:
 		if (netif_msg_link(gp))
 			printk(KERN_INFO "%s: Autoneg failed again, keeping"
 				" forced mode\n", gp->dev->name);
-		phy_write(gp, MII_BMCR, gp->link_fcntl);
+		gp->phy_mii.def->ops->setup_forced(&gp->phy_mii,
+			gp->last_forced_speed, DUPLEX_HALF);
 		gp->timer_ticks = 5;
 		gp->lstate = link_force_ok;
-	} else if (gp->lstate == link_aneg) {
-		val = phy_read(gp, MII_BMCR);
-
+		return 0;
+	case link_aneg:
 		if (netif_msg_link(gp))
 			printk(KERN_INFO "%s: switching to forced 100bt\n",
 				gp->dev->name);
 		/* Try forced modes. */
-		val &= ~(BMCR_ANRESTART | BMCR_ANENABLE);
-		val &= ~(BMCR_FULLDPLX);
-		val |= BMCR_SPEED100;
-		phy_write(gp, MII_BMCR, val);
+		gp->phy_mii.def->ops->setup_forced(&gp->phy_mii, SPEED_100,
+			DUPLEX_HALF);
 		gp->timer_ticks = 5;
 		gp->lstate = link_force_try;
-	} else {
+		return 0;
+	case link_force_try:
 		/* Downgrade from 100 to 10 Mbps if necessary.
 		 * If already at 10Mbps, warn user about the
 		 * situation every 10 ticks.
 		 */
-		val = phy_read(gp, MII_BMCR);
-		if (val & BMCR_SPEED100) {
-			val &= ~BMCR_SPEED100;
-			phy_write(gp, MII_BMCR, val);
+		if (gp->phy_mii.speed == SPEED_100) {
+			gp->phy_mii.def->ops->setup_forced(&gp->phy_mii, SPEED_10,
+				DUPLEX_HALF);
 			gp->timer_ticks = 5;
 			if (netif_msg_link(gp))
 				printk(KERN_INFO "%s: switching to forced 10bt\n",
 					gp->dev->name);
+			return 0;
 		} else
 			return 1;
+	default:
+		return 0;
 	}
-	return 0;
 }
 
 static void gem_init_rings(struct gem *);
@@ -1322,7 +1313,8 @@
 static void gem_link_timer(unsigned long data)
 {
 	struct gem *gp = (struct gem *) data;
-
+	int restart_aneg = 0;
+		
 	if (!gp->hw_running)
 		return;
 
@@ -1334,62 +1326,8 @@
 	if (gp->reset_task_pending)
 		goto restart;
 	    	
-	if (gp->phy_type == phy_mii_mdio0 ||
-	    gp->phy_type == phy_mii_mdio1) {
-		u16 val = phy_read(gp, MII_BMSR);
-		u16 cntl = phy_read(gp, MII_BMCR);
-		int up;
-
-		/* When using autoneg, we really wait for ANEGCOMPLETE or we may
-		 * get a "transcient" incorrect link state
-		 */
-		if (cntl & BMCR_ANENABLE)
-			up = (val & (BMSR_ANEGCOMPLETE | BMSR_LSTATUS)) == (BMSR_ANEGCOMPLETE | BMSR_LSTATUS);
-		else
-			up = (val & BMSR_LSTATUS) != 0;
-		if (up) {
-			/* Ok, here we got a link. If we had it due to a forced
-			 * fallback, and we were configured for autoneg, we do
-			 * retry a short autoneg pass. If you know your hub is
-			 * broken, use ethtool ;)
-			 */
-			if (gp->lstate == link_force_try && (gp->link_cntl & BMCR_ANENABLE)) {
-				gp->lstate = link_force_ret;
-				gp->link_fcntl = phy_read(gp, MII_BMCR);
-				gp->timer_ticks = 5;
-				if (netif_msg_link(gp))
-					printk(KERN_INFO "%s: Got link after fallback, retrying"
-						" autoneg once...\n", gp->dev->name);
-				phy_write(gp, MII_BMCR,
-					  gp->link_fcntl | BMCR_ANENABLE | BMCR_ANRESTART);
-			} else if (gp->lstate != link_up) {
-				gp->lstate = link_up;
-				if (gp->opened)
-					gem_set_link_modes(gp);
-			}
-		} else {
-			int restart = 0;
-
-			/* If the link was previously up, we restart the
-			 * whole process
-			 */
-			if (gp->lstate == link_up) {
-				gp->lstate = link_down;
-				if (netif_msg_link(gp))
-					printk(KERN_INFO "%s: Link down\n",
-						gp->dev->name);
-				gp->reset_task_pending = 2;
-				schedule_task(&gp->reset_task);
-				restart = 1;
-			} else if (++gp->timer_ticks > 10)
-				restart = gem_mdio_link_not_up(gp);
-
-			if (restart) {
-				gem_begin_auto_negotiation(gp, NULL);
-				goto out_unlock;
-			}
-		}
-	} else {
+	if (gp->phy_type == phy_serialink ||
+	    gp->phy_type == phy_serdes) {
 		u32 val = readl(gp->regs + PCS_MIISTAT);
 
 		if (!(val & PCS_MIISTAT_LS))
@@ -1397,11 +1335,56 @@
 
 		if ((val & PCS_MIISTAT_LS) != 0) {
 			gp->lstate = link_up;
+			netif_carrier_on(gp->dev);
 			if (gp->opened)
-				gem_set_link_modes(gp);
+				(void)gem_set_link_modes(gp);
 		}
+		goto restart;
+	}
+	if (found_mii_phy(gp) && gp->phy_mii.def->ops->poll_link(&gp->phy_mii)) {
+		/* Ok, here we got a link. If we had it due to a forced
+		 * fallback, and we were configured for autoneg, we do
+		 * retry a short autoneg pass. If you know your hub is
+		 * broken, use ethtool ;)
+		 */
+		if (gp->lstate == link_force_try && gp->want_autoneg) {
+			gp->lstate = link_force_ret;
+			gp->last_forced_speed = gp->phy_mii.speed;
+			gp->timer_ticks = 5;
+			if (netif_msg_link(gp))
+				printk(KERN_INFO "%s: Got link after fallback, retrying"
+					" autoneg once...\n", gp->dev->name);
+			gp->phy_mii.def->ops->setup_aneg(&gp->phy_mii, gp->phy_mii.advertising);
+		} else if (gp->lstate != link_up) {
+			gp->lstate = link_up;
+			netif_carrier_on(gp->dev);
+			if (gp->opened && gem_set_link_modes(gp))
+				restart_aneg = 1;
+		}
+	} else {
+		/* If the link was previously up, we restart the
+		 * whole process
+		 */
+		if (gp->lstate == link_up) {
+			gp->lstate = link_down;
+			if (netif_msg_link(gp))
+				printk(KERN_INFO "%s: Link down\n",
+					gp->dev->name);
+			netif_carrier_off(gp->dev);
+			gp->reset_task_pending = 2;
+			schedule_task(&gp->reset_task);
+			restart_aneg = 1;
+		} else if (++gp->timer_ticks > 10) {
+			if (found_mii_phy(gp))
+				restart_aneg = gem_mdio_link_not_up(gp);
+			else
+				restart_aneg = 1;
+		}
+	}
+	if (restart_aneg) {
+		gem_begin_auto_negotiation(gp, NULL);
+		goto out_unlock;
 	}
-
 restart:
 	mod_timer(&gp->link_timer, jiffies + ((12 * HZ) / 10));
 out_unlock:
@@ -1501,153 +1484,14 @@
 		txd->control_word = 0;
 		txd->buffer = 0;
 	}
-}
-
-/* Must be invoked under gp->lock. */
-static int gem_reset_one_mii_phy(struct gem *gp, int phy_addr)
-{
-	u16 val;
-	int limit = 10000;
-	
-	val = __phy_read(gp, MII_BMCR, phy_addr);
-	val &= ~BMCR_ISOLATE;
-	val |= BMCR_RESET;
-	__phy_write(gp, MII_BMCR, val, phy_addr);
-
-	udelay(100);
-
-	while (limit--) {
-		val = __phy_read(gp, MII_BMCR, phy_addr);
-		if ((val & BMCR_RESET) == 0)
-			break;
-		udelay(10);
-	}
-	if ((val & BMCR_ISOLATE) && limit > 0)
-		__phy_write(gp, MII_BMCR, val & ~BMCR_ISOLATE, phy_addr);
-	
-	return (limit <= 0);
-}
-
-/* Must be invoked under gp->lock. */
-static void gem_init_bcm5201_phy(struct gem *gp)
-{
-	u16 data;
-
-	data = phy_read(gp, MII_BCM5201_MULTIPHY);
-	data &= ~MII_BCM5201_MULTIPHY_SUPERISOLATE;
-	phy_write(gp, MII_BCM5201_MULTIPHY, data);
-}
-
-/* Must be invoked under gp->lock. */
-static void gem_init_bcm5400_phy(struct gem *gp)
-{
-	u16 data;
-
-	/* Configure for gigabit full duplex */
-	data = phy_read(gp, MII_BCM5400_AUXCONTROL);
-	data |= MII_BCM5400_AUXCONTROL_PWR10BASET;
-	phy_write(gp, MII_BCM5400_AUXCONTROL, data);
-	
-	data = phy_read(gp, MII_BCM5400_GB_CONTROL);
-	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
-	phy_write(gp, MII_BCM5400_GB_CONTROL, data);
-	
-	mdelay(10);
-
-	/* Reset and configure cascaded 10/100 PHY */
-	gem_reset_one_mii_phy(gp, 0x1f);
-	
-	data = __phy_read(gp, MII_BCM5201_MULTIPHY, 0x1f);
-	data |= MII_BCM5201_MULTIPHY_SERIALMODE;
-	__phy_write(gp, MII_BCM5201_MULTIPHY, data, 0x1f);
-
-	data = phy_read(gp, MII_BCM5400_AUXCONTROL);
-	data &= ~MII_BCM5400_AUXCONTROL_PWR10BASET;
-	phy_write(gp, MII_BCM5400_AUXCONTROL, data);
-}
-
-/* Must be invoked under gp->lock. */
-static void gem_init_bcm5401_phy(struct gem *gp)
-{
-	u16 data;
-	int rev;
-
-	rev = phy_read(gp, MII_PHYSID2) & 0x000f;
-	if (rev == 0 || rev == 3) {
-		/* Some revisions of 5401 appear to need this
-		 * initialisation sequence to disable, according
-		 * to OF, "tap power management"
-		 * 
-		 * WARNING ! OF and Darwin don't agree on the
-		 * register addresses. OF seem to interpret the
-		 * register numbers below as decimal
-		 *
-		 * Note: This should (and does) match tg3_init_5401phy_dsp
-		 *       in the tg3.c driver. -DaveM
-		 */
-		phy_write(gp, 0x18, 0x0c20);
-		phy_write(gp, 0x17, 0x0012);
-		phy_write(gp, 0x15, 0x1804);
-		phy_write(gp, 0x17, 0x0013);
-		phy_write(gp, 0x15, 0x1204);
-		phy_write(gp, 0x17, 0x8006);
-		phy_write(gp, 0x15, 0x0132);
-		phy_write(gp, 0x17, 0x8006);
-		phy_write(gp, 0x15, 0x0232);
-		phy_write(gp, 0x17, 0x201f);
-		phy_write(gp, 0x15, 0x0a20);
-	}
-	
-	/* Configure for gigabit full duplex */
-	data = phy_read(gp, MII_BCM5400_GB_CONTROL);
-	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
-	phy_write(gp, MII_BCM5400_GB_CONTROL, data);
-
-	mdelay(1);
-
-	/* Reset and configure cascaded 10/100 PHY */
-	gem_reset_one_mii_phy(gp, 0x1f);
-	
-	data = __phy_read(gp, MII_BCM5201_MULTIPHY, 0x1f);
-	data |= MII_BCM5201_MULTIPHY_SERIALMODE;
-	__phy_write(gp, MII_BCM5201_MULTIPHY, data, 0x1f);
-}
-
-/* Must be invoked under gp->lock. */
-static void gem_init_bcm5411_phy(struct gem *gp)
-{
-	u16 data;
-
-	/* Here's some more Apple black magic to setup
-	 * some voltage stuffs.
-	 */
-	phy_write(gp, 0x1c, 0x8c23);
-	phy_write(gp, 0x1c, 0x8ca3);
-	phy_write(gp, 0x1c, 0x8c23);
-
-	/* Here, Apple seems to want to reset it, do
-	 * it as well
-	 */
-	phy_write(gp, MII_BMCR, BMCR_RESET);
-
-	/* Start autoneg */
-	phy_write(gp, MII_BMCR,
-		  (BMCR_ANENABLE | BMCR_FULLDPLX |
-		   BMCR_ANRESTART | BMCR_SPD2));
-
-	data = phy_read(gp, MII_BCM5400_GB_CONTROL);
-	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
-	phy_write(gp, MII_BCM5400_GB_CONTROL, data);
+	mb();
 }
 
 /* Must be invoked under gp->lock. */
 static void gem_init_phy(struct gem *gp)
 {
 	u32 mifcfg;
-
-	if (!gp->wake_on_lan && gp->phy_mod == phymod_bcm5201)
-		phy_write(gp, MII_BCM5201_INTERRUPT, 0);
-
+	
 	/* Revert MIF CFG setting done on stop_phy */
 	mifcfg = readl(gp->regs + MIF_CFG);
 	mifcfg &= ~MIF_CFG_BBMODE;
@@ -1655,19 +1499,37 @@
 	
 #ifdef CONFIG_ALL_PPC
 	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
-		int i;
+		int i, j;
 
+		/* Those delay sucks, the HW seem to love them though, I'll
+		 * serisouly consider breaking some locks here to be able
+		 * to schedule instead
+		 */
 		pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
-		for (i = 0; i < 32; i++) {
-			gp->mii_phy_addr = i;
-			if (phy_read(gp, MII_BMCR) != 0xffff)
+		mdelay(10);
+		for (j = 0; j < 3; j++) {
+			/* Some PHYs used by apple have problem getting back to us,
+			 * we _know_ it's actually at addr 0, that's a hack, but
+			 * it helps to do that reset now. I suspect some motherboards
+			 * don't wire the PHY reset line properly, thus the PHY doesn't
+			 * come back with the above pmac_call_feature.
+			 */
+			gp->mii_phy_addr = 0;
+			phy_write(gp, MII_BMCR, BMCR_RESET);
+			/* We should probably break some locks here and schedule... */
+			mdelay(10);
+			for (i = 0; i < 32; i++) {
+				gp->mii_phy_addr = i;
+				if (phy_read(gp, MII_BMCR) != 0xffff)
+					break;
+			}
+			if (i == 32) {
+				printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
+				       gp->dev->name);
+				gp->mii_phy_addr = 0;
+			} else
 				break;
 		}
-		if (i == 32) {
-			printk(KERN_WARNING "%s: GMAC PHY not responding !\n",
-			       gp->dev->name);
-			return;
-		}
 	}
 #endif /* CONFIG_ALL_PPC */
 
@@ -1690,79 +1552,12 @@
 
 	if (gp->phy_type == phy_mii_mdio0 ||
 	    gp->phy_type == phy_mii_mdio1) {
-		u32 phy_id;
-		u16 val;
-	
-		/* Take PHY out of isloate mode and reset it. */
-		gem_reset_one_mii_phy(gp, gp->mii_phy_addr);
-
-		phy_id = (phy_read(gp, MII_PHYSID1) << 16 | phy_read(gp, MII_PHYSID2))
-			 	& 0xfffffff0;
-		printk(KERN_INFO "%s: MII PHY ID: %x ", gp->dev->name, phy_id);
-		switch(phy_id) {
-		case 0x406210:
-			gp->phy_mod = phymod_bcm5201;
-			gem_init_bcm5201_phy(gp);
-			printk("BCM 5201\n");
-			break;
-
-		case 0x4061e0:
-			printk("BCM 5221\n");
-			gp->phy_mod = phymod_bcm5221;
-			break;
-
-		case 0x206040:
-			printk("BCM 5400\n");
-			gp->phy_mod = phymod_bcm5400;
-			gem_init_bcm5400_phy(gp);
-			gp->gigabit_capable = 1;
-			break;
-
-		case 0x206050:
-			printk("BCM 5401\n");
-			gp->phy_mod = phymod_bcm5401;
-			gem_init_bcm5401_phy(gp);
-			gp->gigabit_capable = 1;
-			break;
-
-		case 0x206070:
-			printk("BCM 5411\n");
-			gp->phy_mod = phymod_bcm5411;
-			gem_init_bcm5411_phy(gp);
-			gp->gigabit_capable = 1;
-			break;
-		case 0x1410c60:
-			printk("M1011 (Marvel ?)\n");
-			gp->phy_mod = phymod_m1011;
-			gp->gigabit_capable = 1;
-			break;
-
-		case 0x18074c0:
-			printk("Lucent\n");
-			gp->phy_mod = phymod_generic;
-			break;
-
-		case 0x437420:
-			printk("Enable Semiconductor\n");
-			gp->phy_mod = phymod_generic;
-			break;
-
-		default:
-			printk("Unknown (Using generic mode)\n");
-			gp->phy_mod = phymod_generic;
-			break;
-		};
+	    	// XXX check for errors
+		mii_phy_probe(&gp->phy_mii, gp->mii_phy_addr);
 
-		/* Init advertisement and enable autonegotiation. */
-		val = phy_read(gp, MII_BMCR);
-		val &= ~BMCR_ANENABLE;
-		phy_write(gp, MII_BMCR, val);
-		udelay(10);
-		
-		phy_write(gp, MII_ADVERTISE,
-			  phy_read(gp, MII_ADVERTISE) |
-			  (ADVERTISE_10HALF | ADVERTISE_10FULL |
-			   ADVERTISE_100HALF | ADVERTISE_100FULL));
+		/* Init PHY */
+		if (gp->phy_mii.def && gp->phy_mii.def->ops->init)
+			gp->phy_mii.def->ops->init(&gp->phy_mii);
 	} else {
 		u32 val;
 		int limit;
@@ -1819,13 +1614,7 @@
 		else
 			val |= PCS_SCTRL_LOOP;
 		writel(val, gp->regs + PCS_SCTRL);
-		gp->gigabit_capable = 1;
 	}
-
-	/* BMCR_SPD2 is a broadcom 54xx specific thing afaik */
-	if (gp->phy_mod != phymod_bcm5400 && gp->phy_mod != phymod_bcm5401 &&
-	    gp->phy_mod != phymod_bcm5411)
-	    	gp->link_cntl &= ~BMCR_SPD2;
 }
 
 /* Must be invoked under gp->lock. */
@@ -1914,9 +1703,7 @@
 {
 	unsigned char *e = &gp->dev->dev_addr[0];
 
-	if (gp->pdev->vendor == PCI_VENDOR_ID_SUN &&
-	    gp->pdev->device == PCI_DEVICE_ID_SUN_GEM)
-		writel(0x1bf0, gp->regs + MAC_SNDPAUSE);
+	writel(0x1bf0, gp->regs + MAC_SNDPAUSE);
 
 	writel(0x00, gp->regs + MAC_IPG0);
 	writel(0x08, gp->regs + MAC_IPG1);
@@ -1953,7 +1740,9 @@
 	writel(0, gp->regs + MAC_AF0MSK);
 
 	gp->mac_rx_cfg = gem_setup_multicast(gp);
-
+#ifdef STRIP_FCS
+	gp->mac_rx_cfg |= MAC_RXCFG_SFCS;
+#endif
 	writel(0, gp->regs + MAC_NCOLL);
 	writel(0, gp->regs + MAC_FASUCC);
 	writel(0, gp->regs + MAC_ECOLL);
@@ -2129,12 +1918,15 @@
 		/* Default aneg parameters */
 		gp->timer_ticks = 0;
 		gp->lstate = link_down;
+		netif_carrier_off(gp->dev);
 
 		/* Can I advertise gigabit here ? I'd need BCM PHY docs... */
 		gem_begin_auto_negotiation(gp, NULL);
 	} else {
-		if (gp->lstate == link_up)
+		if (gp->lstate == link_up) {
+			netif_carrier_on(gp->dev);
 			gem_set_link_modes(gp);
+		}
 	}
 }
 
@@ -2184,9 +1976,6 @@
 {
 	u32 mifcfg;
 
-	if (!gp->wake_on_lan && gp->phy_mod == phymod_bcm5201)
-		phy_write(gp, MII_BCM5201_INTERRUPT, 0);
-
 	/* Make sure we aren't polling PHY status change. We
 	 * don't currently use that feature though
 	 */
@@ -2194,9 +1983,6 @@
 	mifcfg &= ~MIF_CFG_POLL;
 	writel(mifcfg, gp->regs + MIF_CFG);
 
-	/* Here's a strange hack used by both MacOS 9 and X */
-	phy_write(gp, MII_LPA, phy_read(gp, MII_LPA));
-
 	if (gp->wake_on_lan) {
 		/* Setup wake-on-lan */
 	} else
@@ -2210,21 +1996,12 @@
 		gem_stop(gp);
 		writel(MAC_TXRST_CMD, gp->regs + MAC_TXRST);
 		writel(MAC_RXRST_CMD, gp->regs + MAC_RXRST);
-		if (gp->phy_mod == phymod_bcm5400 || gp->phy_mod == phymod_bcm5401 ||
-		    gp->phy_mod == phymod_bcm5411) {
-#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
-			phy_write(gp, MII_BMCR, BMCR_PDOWN);
-#endif
-		} else if (gp->phy_mod == phymod_bcm5201 || gp->phy_mod == phymod_bcm5221) {
-#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
-			u16 val = phy_read(gp, MII_BCM5201_AUXMODE2)
-			phy_write(gp, MII_BCM5201_AUXMODE2,
-				  val & ~MII_BCM5201_AUXMODE2_LOWPOWER);
-#endif				
-			phy_write(gp, MII_BCM5201_MULTIPHY, MII_BCM5201_MULTIPHY_SUPERISOLATE);
-		} else if (gp->phy_mod == phymod_m1011)
-			phy_write(gp, MII_BMCR, BMCR_PDOWN);
+	}
 
+	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
+		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
+
+	if (!gp->wake_on_lan) {
 		/* According to Apple, we must set the MDIO pins to this begnign
 		 * state or we may 1) eat more current, 2) damage some PHYs
 		 */
@@ -2330,15 +2107,11 @@
 		gp->hw_running = 1;
 	}
 
-	spin_lock_irq(&gp->lock);
-
 	/* We can now request the interrupt as we know it's masked
 	 * on the controller
 	 */
 	if (request_irq(gp->pdev->irq, gem_interrupt,
 			SA_SHIRQ, dev->name, (void *)dev)) {
-		spin_unlock_irq(&gp->lock);
-
 		printk(KERN_ERR "%s: failed to request irq !\n", gp->dev->name);
 
 #ifdef CONFIG_ALL_PPC
@@ -2349,10 +2122,13 @@
 		gp->pm_timer.expires = jiffies + 10*HZ;
 		add_timer(&gp->pm_timer);
 		up(&gp->pm_sem);
+		spin_unlock_irq(&gp->lock);
 
 		return -EAGAIN;
 	}
 
+       	spin_lock_irq(&gp->lock);
+
 	/* Allocate & setup ring buffers */
 	gem_init_rings(gp);
 
@@ -2526,7 +2302,11 @@
 	netif_stop_queue(dev);
 
 	rxcfg = readl(gp->regs + MAC_RXCFG);
-	gp->mac_rx_cfg = rxcfg_new = gem_setup_multicast(gp);
+	rxcfg_new = gem_setup_multicast(gp);
+#ifdef STRIP_FCS
+	rxcfg_new |= MAC_RXCFG_SFCS;
+#endif
+	gp->mac_rx_cfg = rxcfg_new;
 	
 	writel(rxcfg & ~MAC_RXCFG_ENAB, gp->regs + MAC_RXCFG);
 	while (readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB) {
@@ -2551,8 +2331,6 @@
 static int gem_ethtool_ioctl(struct net_device *dev, void *ep_user)
 {
 	struct gem *gp = dev->priv;
-	u16 bmcr;
-	int full_duplex, speed, pause;
 	struct ethtool_cmd ecmd;
 
 	if (copy_from_user(&ecmd, ep_user, sizeof(ecmd)))
@@ -2560,7 +2338,7 @@
 		
 	switch(ecmd.cmd) {
         case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = { cmd: ETHTOOL_GDRVINFO };
+		struct ethtool_drvinfo info = { .cmd = ETHTOOL_GDRVINFO };
 
 		strncpy(info.driver, DRV_NAME, ETHTOOL_BUSINFO_LEN);
 		strncpy(info.version, DRV_VERSION, ETHTOOL_BUSINFO_LEN);
@@ -2575,41 +2353,36 @@
 	}
 
 	case ETHTOOL_GSET:
-		ecmd.supported =
+		if (gp->phy_type == phy_mii_mdio0 ||
+	     	    gp->phy_type == phy_mii_mdio1) {
+	     	    	if (gp->phy_mii.def)
+	     	    		ecmd.supported = gp->phy_mii.def->features;
+	     	    	else
+	     	    		ecmd.supported = SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full;
+
+			/* XXX hardcoded stuff for now */
+			ecmd.port = PORT_MII;
+			ecmd.transceiver = XCVR_EXTERNAL;
+			ecmd.phy_address = 0; /* XXX fixed PHYAD */
+
+			/* Return current PHY settings */
+			spin_lock_irq(&gp->lock);
+			ecmd.autoneg = gp->want_autoneg;
+			ecmd.speed = gp->phy_mii.speed;
+			ecmd.duplex = gp->phy_mii.duplex;			
+			ecmd.advertising = gp->phy_mii.advertising;
+			/* If we started with a forced mode, we don't have a default
+			 * advertise set, we need to return something sensible so
+			 * userland can re-enable autoneg properly */
+			if (ecmd.advertising == 0)
+				ecmd.advertising = ecmd.supported;
+			spin_unlock_irq(&gp->lock);
+		} else { // XXX PCS ?
+	     	    ecmd.supported =
 			(SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
 			 SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
-			 SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII);
-
-		if (gp->gigabit_capable)
-			ecmd.supported |=
-				(SUPPORTED_1000baseT_Half |
-				 SUPPORTED_1000baseT_Full);
-
-		/* XXX hardcoded stuff for now */
-		ecmd.port = PORT_MII;
-		ecmd.transceiver = XCVR_EXTERNAL;
-		ecmd.phy_address = 0; /* XXX fixed PHYAD */
-
-		/* Record PHY settings if HW is on. */
-		spin_lock_irq(&gp->lock);
-		if (gp->hw_running) {
-			bmcr = phy_read(gp, MII_BMCR);
-			gem_read_mii_link_mode(gp, &full_duplex, &speed, &pause);
-		} else
-			bmcr = 0;
-		spin_unlock_irq(&gp->lock);
-		if (bmcr & BMCR_ANENABLE) {
-			ecmd.autoneg = AUTONEG_ENABLE;
-			ecmd.speed = speed == 10 ? SPEED_10 : (speed == 1000 ? SPEED_1000 : SPEED_100);
-			ecmd.duplex = full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
-		} else {
-			ecmd.autoneg = AUTONEG_DISABLE;
-			ecmd.speed =
-				(bmcr & BMCR_SPEED100) ?
-				SPEED_100 : SPEED_10;
-			ecmd.duplex =
-				(bmcr & BMCR_FULLDPLX) ?
-				DUPLEX_FULL : DUPLEX_HALF;
+			 SUPPORTED_Autoneg);
+		    ecmd.advertising = ecmd.supported;
 		}
 		if (copy_to_user(ep_user, &ecmd, sizeof(ecmd)))
 			return -EFAULT;
@@ -2621,13 +2394,18 @@
 		    ecmd.autoneg != AUTONEG_DISABLE)
 			return -EINVAL;
 
+		if (ecmd.autoneg == AUTONEG_ENABLE &&
+		    ecmd.advertising == 0)
+		    	return -EINVAL;
+
 		if (ecmd.autoneg == AUTONEG_DISABLE &&
-		    ((ecmd.speed != SPEED_100 &&
+		    ((ecmd.speed != SPEED_1000 &&
+		      ecmd.speed != SPEED_100 &&
 		      ecmd.speed != SPEED_10) ||
 		     (ecmd.duplex != DUPLEX_HALF &&
 		      ecmd.duplex != DUPLEX_FULL)))
 			return -EINVAL;
-
+	      
 		/* Apply settings and restart link process. */
 		spin_lock_irq(&gp->lock);
 		gem_begin_auto_negotiation(gp, &ecmd);
@@ -2636,7 +2414,7 @@
 		return 0;
 
 	case ETHTOOL_NWAY_RST:
-		if ((gp->link_cntl & BMCR_ANENABLE) == 0)
+		if (!gp->want_autoneg)
 			return -EINVAL;
 
 		/* Restart link process. */
@@ -2652,7 +2430,7 @@
 
 	/* get link status */
 	case ETHTOOL_GLINK: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GLINK };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
 
 		edata.data = (gp->lstate == link_up);
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
@@ -2662,7 +2440,7 @@
 
 	/* get message-level */
 	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GMSGLVL };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GMSGLVL };
 
 		edata.data = gp->msg_enable;
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
@@ -2740,15 +2518,21 @@
 		/* Fallthrough... */
 
 	case SIOCGMIIREG:		/* Read MII PHY register. */
-		data->val_out = __phy_read(gp, data->reg_num & 0x1f, data->phy_id & 0x1f);
-		rc = 0;
+		if (!gp->hw_running)
+			rc = -EIO;
+		else {
+			data->val_out = __phy_read(gp, data->phy_id & 0x1f, data->reg_num & 0x1f);
+			rc = 0;
+		}
 		break;
 
 	case SIOCSMIIREG:		/* Write MII PHY register. */
-		if (!capable(CAP_NET_ADMIN)) {
+		if (!capable(CAP_NET_ADMIN))
 			rc = -EPERM;
-		} else {
-			__phy_write(gp, data->reg_num & 0x1f, data->val_in, data->phy_id & 0x1f);
+		else if (!gp->hw_running)
+			rc = -EIO;
+		else {
+			__phy_write(gp, data->phy_id & 0x1f, data->reg_num & 0x1f, data->val_in);
 			rc = 0;
 		}
 		break;
@@ -2894,7 +2678,7 @@
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_SUN &&
 	    pdev->device == PCI_DEVICE_ID_SUN_GEM &&
-	    !pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff)) {
+	    !pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
 		pci_using_dac = 1;
 	} else {
 		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
@@ -2934,7 +2718,7 @@
 	dev->base_addr = (long) pdev;
 	gp->dev = dev;
 
-	gp->msg_enable = (gem_debug < 0 ? DEFAULT_MSG : gem_debug);
+	gp->msg_enable = DEFAULT_MSG;
 
 	spin_lock_init(&gp->lock);
 	init_MUTEX(&gp->pm_sem);
@@ -2950,13 +2734,9 @@
 	INIT_TQUEUE(&gp->pm_task, gem_pm_task, gp);
 	INIT_TQUEUE(&gp->reset_task, gem_reset_task, gp);
 	
-	/* Default link parameters */
-	if (link_mode >= 0 && link_mode <= 6)
-		gp->link_cntl = link_modes[link_mode];
-	else
-		gp->link_cntl = BMCR_ANENABLE;
 	gp->lstate = link_down;
 	gp->timer_ticks = 0;
+	netif_carrier_off(dev);
 
 	gp->regs = (unsigned long) ioremap(gemreg_base, gemreg_len);
 	if (gp->regs == 0UL) {
@@ -2977,16 +2757,18 @@
 	gem_stop(gp);
 	spin_unlock_irq(&gp->lock);
 
+	/* Fill up the mii_phy structure (even if we won't use it) */
+	gp->phy_mii.dev = dev;
+	gp->phy_mii.mdio_read = _phy_read;
+	gp->phy_mii.mdio_write = _phy_write;
+
+	/* By default, we start with autoneg */
+	gp->want_autoneg = 1;
+	
 	if (gem_check_invariants(gp))
 		goto err_out_iounmap;
 
-	spin_lock_irq(&gp->lock);
-	gp->hw_running = 1;
-	gem_init_phy(gp);
-	gem_begin_auto_negotiation(gp, NULL);
-	spin_unlock_irq(&gp->lock);
-
-	/* It is guarenteed that the returned buffer will be at least
+	/* It is guaranteed that the returned buffer will be at least
 	 * PAGE_SIZE aligned.
 	 */
 	gp->init_block = (struct gem_init_block *)
@@ -3012,12 +2794,23 @@
 
 	printk(KERN_INFO "%s: Sun GEM (PCI) 10/100/1000BaseT Ethernet ",
 	       dev->name);
-
 	for (i = 0; i < 6; i++)
 		printk("%2.2x%c", dev->dev_addr[i],
 		       i == 5 ? ' ' : ':');
 	printk("\n");
 
+	/* Detect & init PHY, start autoneg */
+	spin_lock_irq(&gp->lock);
+	gp->hw_running = 1;
+	gem_init_phy(gp);
+	gem_begin_auto_negotiation(gp, NULL);
+	spin_unlock_irq(&gp->lock);
+
+	if (gp->phy_type == phy_mii_mdio0 ||
+     	    gp->phy_type == phy_mii_mdio1)
+		printk(KERN_INFO "%s: Found %s PHY\n", dev->name, 
+			gp->phy_mii.def ? gp->phy_mii.def->name : "no");
+
 	pci_set_drvdata(pdev, dev);
 
 	dev->open = gem_open;
diff -urN drivers/net/sungem.h ../linux-2.4.22-ben2/drivers/net/sungem.h
--- drivers/net/sungem.h	2002-08-03 10:39:44.000000000 +1000
+++ ../linux-2.4.22-ben2/drivers/net/sungem.h	2003-08-31 19:39:02.000000000 +1000
@@ -805,14 +805,14 @@
 	u64	buffer;
 };
 
-#define TXDCTRL_BUFSZ	0x0000000000007fff	/* Buffer Size		*/
-#define TXDCTRL_CSTART	0x00000000001f8000	/* CSUM Start Offset	*/
-#define TXDCTRL_COFF	0x000000001fe00000	/* CSUM Stuff Offset	*/
-#define TXDCTRL_CENAB	0x0000000020000000	/* CSUM Enable		*/
-#define TXDCTRL_EOF	0x0000000040000000	/* End of Frame		*/
-#define TXDCTRL_SOF	0x0000000080000000	/* Start of Frame	*/
-#define TXDCTRL_INTME	0x0000000100000000	/* "Interrupt Me"	*/
-#define TXDCTRL_NOCRC	0x0000000200000000	/* No CRC Present	*/
+#define TXDCTRL_BUFSZ	0x0000000000007fffULL	/* Buffer Size		*/
+#define TXDCTRL_CSTART	0x00000000001f8000ULL	/* CSUM Start Offset	*/
+#define TXDCTRL_COFF	0x000000001fe00000ULL	/* CSUM Stuff Offset	*/
+#define TXDCTRL_CENAB	0x0000000020000000ULL	/* CSUM Enable		*/
+#define TXDCTRL_EOF	0x0000000040000000ULL	/* End of Frame		*/
+#define TXDCTRL_SOF	0x0000000080000000ULL	/* Start of Frame	*/
+#define TXDCTRL_INTME	0x0000000100000000ULL	/* "Interrupt Me"	*/
+#define TXDCTRL_NOCRC	0x0000000200000000ULL	/* No CRC Present	*/
 
 /* GEM requires that RX descriptors are provided four at a time,
  * aligned.  Also, the RX ring may not wrap around.  This means that
@@ -840,13 +840,13 @@
 	u64	buffer;
 };
 
-#define RXDCTRL_TCPCSUM	0x000000000000ffff	/* TCP Pseudo-CSUM	*/
-#define RXDCTRL_BUFSZ	0x000000007fff0000	/* Buffer Size		*/
-#define RXDCTRL_OWN	0x0000000080000000	/* GEM owns this entry	*/
-#define RXDCTRL_HASHVAL	0x0ffff00000000000	/* Hash Value		*/
-#define RXDCTRL_HPASS	0x1000000000000000	/* Passed Hash Filter	*/
-#define RXDCTRL_ALTMAC	0x2000000000000000	/* Matched ALT MAC	*/
-#define RXDCTRL_BAD	0x4000000000000000	/* Frame has bad CRC	*/
+#define RXDCTRL_TCPCSUM	0x000000000000ffffULL	/* TCP Pseudo-CSUM	*/
+#define RXDCTRL_BUFSZ	0x000000007fff0000ULL	/* Buffer Size		*/
+#define RXDCTRL_OWN	0x0000000080000000ULL	/* GEM owns this entry	*/
+#define RXDCTRL_HASHVAL	0x0ffff00000000000ULL	/* Hash Value		*/
+#define RXDCTRL_HPASS	0x1000000000000000ULL	/* Passed Hash Filter	*/
+#define RXDCTRL_ALTMAC	0x2000000000000000ULL	/* Matched ALT MAC	*/
+#define RXDCTRL_BAD	0x4000000000000000ULL	/* Frame has bad CRC	*/
 
 #define RXDCTRL_FRESH(gp)	\
 	((((RX_BUF_ALLOC_SIZE(gp) - RX_OFFSET) << 16) & RXDCTRL_BUFSZ) | \
@@ -936,16 +936,6 @@
 	phy_serdes,
 };
 
-enum gem_phy_model {
-	phymod_generic,
-	phymod_bcm5201,
-	phymod_bcm5221,
-	phymod_bcm5400,
-	phymod_bcm5401,
-	phymod_bcm5411,
-	phymod_m1011,
-};
-
 enum link_state {
 	link_down = 0,	/* No link, will retry */
 	link_aneg,	/* Autoneg in progress */
@@ -980,21 +970,20 @@
 	struct net_device_stats net_stats;
 
 	enum gem_phy_type	phy_type;
-	enum gem_phy_model	phy_mod;
+	struct mii_phy		phy_mii;
+	
 	int			tx_fifo_sz;
 	int			rx_fifo_sz;
 	int			rx_pause_off;
 	int			rx_pause_on;
 	int			mii_phy_addr;
-	int			gigabit_capable;
 
 	u32			mac_rx_cfg;
 	u32			swrst_base;
 
 	/* Autoneg & PHY control */
-	int			link_cntl;
-	int			link_advertise;
-	int			link_fcntl;
+	int			want_autoneg;
+	int			last_forced_speed;
 	enum link_state		lstate;
 	struct timer_list	link_timer;
 	int			timer_ticks;
@@ -1014,6 +1003,9 @@
 #endif
 };
 
+#define found_mii_phy(gp) ((gp->phy_type == phy_mii_mdio0 || gp->phy_type == phy_mii_mdio1) \
+				&& gp->phy_mii.def && gp->phy_mii.def->ops)
+			
 #define ALIGNED_RX_SKB_ADDR(addr) \
         ((((unsigned long)(addr) + (64UL - 1UL)) & ~(64UL - 1UL)) - (unsigned long)(addr))
 static __inline__ struct sk_buff *gem_alloc_skb(int size, int gfp_flags)
diff -urN drivers/net/sungem_phy.c ../linux-2.4.22-ben2/drivers/net/sungem_phy.c
--- drivers/net/sungem_phy.c	Thu Jan 01 10:00:00 1970
+++ ../linux-2.4.22-ben2/drivers/net/sungem_phy.c	Sun Aug 31 19:42:26 2003
@@ -0,0 +1,838 @@
+/*
+ * PHY drivers for the sungem ethernet driver.
+ * 
+ * This file could be shared with other drivers.
+ * 
+ * (c) 2002, Benjamin Herrenscmidt (benh@kernel.crashing.org)
+ *
+ * TODO:
+ *  - Implement WOL
+ *  - Add support for PHYs that provide an IRQ line
+ *  - Eventually moved the entire polling state machine in
+ *    there (out of the eth driver), so that it can easily be
+ *    skipped on PHYs that implement it in hardware.
+ *  - On LXT971 & BCM5201, Apple uses some chip specific regs
+ *    to read the link status. Figure out why and if it makes
+ *    sense to do the same (magic aneg ?)
+ *  - Apple has some additional power management code for some
+ *    Broadcom PHYs that they "hide" from the OpenSource version
+ *    of darwin, still need to reverse engineer that
+ */
+
+#include <linux/config.h>
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/delay.h>
+
+#include "sungem_phy.h"
+
+/* Link modes of the BCM5400 PHY */
+static int phy_BCM5400_link_table[8][3] = {
+	{ 0, 0, 0 },	/* No link */
+	{ 0, 0, 0 },	/* 10BT Half Duplex */
+	{ 1, 0, 0 },	/* 10BT Full Duplex */
+	{ 0, 1, 0 },	/* 100BT Half Duplex */
+	{ 0, 1, 0 },	/* 100BT Half Duplex */
+	{ 1, 1, 0 },	/* 100BT Full Duplex*/
+	{ 1, 0, 1 },	/* 1000BT */
+	{ 1, 0, 1 },	/* 1000BT */
+};
+
+static inline int __phy_read(struct mii_phy* phy, int id, int reg)
+{
+	return phy->mdio_read(phy->dev, id, reg);
+}
+
+static inline void __phy_write(struct mii_phy* phy, int id, int reg, int val)
+{
+	phy->mdio_write(phy->dev, id, reg, val);
+}
+
+static inline int phy_read(struct mii_phy* phy, int reg)
+{
+	return phy->mdio_read(phy->dev, phy->mii_id, reg);
+}
+
+static inline void phy_write(struct mii_phy* phy, int reg, int val)
+{
+	phy->mdio_write(phy->dev, phy->mii_id, reg, val);
+}
+
+static int reset_one_mii_phy(struct mii_phy* phy, int phy_id)
+{
+	u16 val;
+	int limit = 10000;
+	
+	val = __phy_read(phy, phy_id, MII_BMCR);
+	val &= ~BMCR_ISOLATE;
+	val |= BMCR_RESET;
+	__phy_write(phy, phy_id, MII_BMCR, val);
+
+	udelay(100);
+
+	while (limit--) {
+		val = __phy_read(phy, phy_id, MII_BMCR);
+		if ((val & BMCR_RESET) == 0)
+			break;
+		udelay(10);
+	}
+	if ((val & BMCR_ISOLATE) && limit > 0)
+		__phy_write(phy, phy_id, MII_BMCR, val & ~BMCR_ISOLATE);
+	
+	return (limit <= 0);
+}
+
+static int bcm5201_init(struct mii_phy* phy)
+{
+	u16 data;
+
+	data = phy_read(phy, MII_BCM5201_MULTIPHY);
+	data &= ~MII_BCM5201_MULTIPHY_SUPERISOLATE;
+	phy_write(phy, MII_BCM5201_MULTIPHY, data);
+
+	return 0;
+}
+
+static int bcm5201_suspend(struct mii_phy* phy, int wol_options)
+{
+	if (!wol_options)
+		phy_write(phy, MII_BCM5201_INTERRUPT, 0);
+
+	/* Here's a strange hack used by both MacOS 9 and X */
+	phy_write(phy, MII_LPA, phy_read(phy, MII_LPA));
+	
+	if (!wol_options) {
+#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
+		u16 val = phy_read(phy, MII_BCM5201_AUXMODE2)
+		phy_write(phy, MII_BCM5201_AUXMODE2,
+			  val & ~MII_BCM5201_AUXMODE2_LOWPOWER);
+#endif			
+		phy_write(phy, MII_BCM5201_MULTIPHY, MII_BCM5201_MULTIPHY_SUPERISOLATE);
+	}
+
+	return 0;
+}
+
+static int bcm5221_init(struct mii_phy* phy)
+{
+	u16 data;
+
+	data = phy_read(phy, MII_BCM5221_TEST);
+	phy_write(phy, MII_BCM5221_TEST,
+		data | MII_BCM5221_TEST_ENABLE_SHADOWS);
+
+	data = phy_read(phy, MII_BCM5221_SHDOW_AUX_STAT2);
+	phy_write(phy, MII_BCM5221_SHDOW_AUX_STAT2,
+		data | MII_BCM5221_SHDOW_AUX_STAT2_APD);
+
+	data = phy_read(phy, MII_BCM5221_SHDOW_AUX_MODE4);
+	phy_write(phy, MII_BCM5221_SHDOW_AUX_MODE4,
+		data | MII_BCM5221_SHDOW_AUX_MODE4_CLKLOPWR);
+
+	data = phy_read(phy, MII_BCM5221_TEST);
+	phy_write(phy, MII_BCM5221_TEST,
+		data & ~MII_BCM5221_TEST_ENABLE_SHADOWS);
+
+	return 0;
+}
+
+static int bcm5400_init(struct mii_phy* phy)
+{
+	u16 data;
+
+	/* Configure for gigabit full duplex */
+	data = phy_read(phy, MII_BCM5400_AUXCONTROL);
+	data |= MII_BCM5400_AUXCONTROL_PWR10BASET;
+	phy_write(phy, MII_BCM5400_AUXCONTROL, data);
+	
+	data = phy_read(phy, MII_BCM5400_GB_CONTROL);
+	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
+	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
+	
+	mdelay(10);
+
+	/* Reset and configure cascaded 10/100 PHY */
+	(void)reset_one_mii_phy(phy, 0x1f);
+	
+	data = __phy_read(phy, 0x1f, MII_BCM5201_MULTIPHY);
+	data |= MII_BCM5201_MULTIPHY_SERIALMODE;
+	__phy_write(phy, 0x1f, MII_BCM5201_MULTIPHY, data);
+
+	data = phy_read(phy, MII_BCM5400_AUXCONTROL);
+	data &= ~MII_BCM5400_AUXCONTROL_PWR10BASET;
+	phy_write(phy, MII_BCM5400_AUXCONTROL, data);
+
+	return 0;
+}
+
+static int bcm5400_suspend(struct mii_phy* phy, int wol_options)
+{
+#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
+	phy_write(phy, MII_BMCR, BMCR_PDOWN);
+#endif
+	return 0;
+}
+
+static int bcm5401_init(struct mii_phy* phy)
+{
+	u16 data;
+	int rev;
+
+	rev = phy_read(phy, MII_PHYSID2) & 0x000f;
+	if (rev == 0 || rev == 3) {
+		/* Some revisions of 5401 appear to need this
+		 * initialisation sequence to disable, according
+		 * to OF, "tap power management"
+		 * 
+		 * WARNING ! OF and Darwin don't agree on the
+		 * register addresses. OF seem to interpret the
+		 * register numbers below as decimal
+		 *
+		 * Note: This should (and does) match tg3_init_5401phy_dsp
+		 *       in the tg3.c driver. -DaveM
+		 */
+		phy_write(phy, 0x18, 0x0c20);
+		phy_write(phy, 0x17, 0x0012);
+		phy_write(phy, 0x15, 0x1804);
+		phy_write(phy, 0x17, 0x0013);
+		phy_write(phy, 0x15, 0x1204);
+		phy_write(phy, 0x17, 0x8006);
+		phy_write(phy, 0x15, 0x0132);
+		phy_write(phy, 0x17, 0x8006);
+		phy_write(phy, 0x15, 0x0232);
+		phy_write(phy, 0x17, 0x201f);
+		phy_write(phy, 0x15, 0x0a20);
+	}
+	
+	/* Configure for gigabit full duplex */
+	data = phy_read(phy, MII_BCM5400_GB_CONTROL);
+	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
+	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
+
+	mdelay(10);
+
+	/* Reset and configure cascaded 10/100 PHY */
+	(void)reset_one_mii_phy(phy, 0x1f);
+	
+	data = __phy_read(phy, 0x1f, MII_BCM5201_MULTIPHY);
+	data |= MII_BCM5201_MULTIPHY_SERIALMODE;
+	__phy_write(phy, 0x1f, MII_BCM5201_MULTIPHY, data);
+
+	return 0;
+}
+
+static int bcm5401_suspend(struct mii_phy* phy, int wol_options)
+{
+#if 0 /* Commented out in Darwin... someone has those dawn docs ? */
+	phy_write(phy, MII_BMCR, BMCR_PDOWN);
+#endif
+	return 0;
+}
+
+static int bcm5411_init(struct mii_phy* phy)
+{
+	u16 data;
+
+	/* Here's some more Apple black magic to setup
+	 * some voltage stuffs.
+	 */
+	phy_write(phy, 0x1c, 0x8c23);
+	phy_write(phy, 0x1c, 0x8ca3);
+	phy_write(phy, 0x1c, 0x8c23);
+
+	/* Here, Apple seems to want to reset it, do
+	 * it as well
+	 */
+	phy_write(phy, MII_BMCR, BMCR_RESET);
+	phy_write(phy, MII_BMCR, 0x1340);
+
+	data = phy_read(phy, MII_BCM5400_GB_CONTROL);
+	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
+	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
+
+	mdelay(10);
+
+	/* Reset and configure cascaded 10/100 PHY */
+	(void)reset_one_mii_phy(phy, 0x1f);
+	
+	return 0;
+}
+
+static int bcm5411_suspend(struct mii_phy* phy, int wol_options)
+{
+	phy_write(phy, MII_BMCR, BMCR_PDOWN);
+
+	return 0;
+}
+
+static int bcm5421_init(struct mii_phy* phy)
+{
+	u16 data;
+	int rev;
+
+	rev = phy_read(phy, MII_PHYSID2) & 0x000f;
+	if (rev == 0) {
+		/* This is borrowed from MacOS
+		 */
+		phy_write(phy, 0x18, 0x1007);
+		data = phy_read(phy, 0x18);
+		phy_write(phy, 0x18, data | 0x0400);
+		phy_write(phy, 0x18, 0x0007);
+		data = phy_read(phy, 0x18);
+		phy_write(phy, 0x18, data | 0x0800);
+		phy_write(phy, 0x17, 0x000a);
+		data = phy_read(phy, 0x15);
+		phy_write(phy, 0x15, data | 0x0200);
+	}
+#if 0
+	/* This has to be verified before I enable it */
+	/* Enable automatic low-power */
+	phy_write(phy, 0x1c, 0x9002);
+	phy_write(phy, 0x1c, 0xa821);
+	phy_write(phy, 0x1c, 0x941d);
+#endif
+	return 0;
+}
+
+static int bcm54xx_setup_aneg(struct mii_phy *phy, u32 advertise)
+{
+	u16 ctl, adv;
+	
+	phy->autoneg = 1;
+	phy->speed = SPEED_10;
+	phy->duplex = DUPLEX_HALF;
+	phy->pause = 0;
+	phy->advertising = advertise;
+
+	/* Setup standard advertise */
+	adv = phy_read(phy, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (advertise & ADVERTISED_10baseT_Half)
+		adv |= ADVERTISE_10HALF;
+	if (advertise & ADVERTISED_10baseT_Full)
+		adv |= ADVERTISE_10FULL;
+	if (advertise & ADVERTISED_100baseT_Half)
+		adv |= ADVERTISE_100HALF;
+	if (advertise & ADVERTISED_100baseT_Full)
+		adv |= ADVERTISE_100FULL;
+	phy_write(phy, MII_ADVERTISE, adv);
+
+	/* Setup 1000BT advertise */
+	adv = phy_read(phy, MII_1000BASETCONTROL);
+	adv &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP|MII_1000BASETCONTROL_HALFDUPLEXCAP);
+	if (advertise & SUPPORTED_1000baseT_Half)
+		adv |= MII_1000BASETCONTROL_HALFDUPLEXCAP;
+	if (advertise & SUPPORTED_1000baseT_Full)
+		adv |= MII_1000BASETCONTROL_FULLDUPLEXCAP;
+	phy_write(phy, MII_1000BASETCONTROL, adv);
+
+	/* Start/Restart aneg */
+	ctl = phy_read(phy, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int bcm54xx_setup_forced(struct mii_phy *phy, int speed, int fd)
+{
+	u16 ctl;
+	
+	phy->autoneg = 0;
+	phy->speed = speed;
+	phy->duplex = fd;
+	phy->pause = 0;
+
+	ctl = phy_read(phy, MII_BMCR);
+	ctl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_SPD2|BMCR_ANENABLE);
+
+	/* First reset the PHY */
+	phy_write(phy, MII_BMCR, ctl | BMCR_RESET);
+
+	/* Select speed & duplex */
+	switch(speed) {
+	case SPEED_10:
+		break;
+	case SPEED_100:
+		ctl |= BMCR_SPEED100;
+		break;
+	case SPEED_1000:
+		ctl |= BMCR_SPD2;
+	}
+	if (fd == DUPLEX_FULL)
+		ctl |= BMCR_FULLDPLX;
+
+	// XXX Should we set the sungem to GII now on 1000BT ?
+	
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int bcm54xx_read_link(struct mii_phy *phy)
+{
+	int link_mode;	
+	u16 val;
+	
+	if (phy->autoneg) {
+	    	val = phy_read(phy, MII_BCM5400_AUXSTATUS);
+		link_mode = ((val & MII_BCM5400_AUXSTATUS_LINKMODE_MASK) >>
+			     MII_BCM5400_AUXSTATUS_LINKMODE_SHIFT);
+		phy->duplex = phy_BCM5400_link_table[link_mode][0] ? DUPLEX_FULL : DUPLEX_HALF;
+		phy->speed = phy_BCM5400_link_table[link_mode][2] ?
+				SPEED_1000 :
+				(phy_BCM5400_link_table[link_mode][1] ? SPEED_100 : SPEED_10);
+		val = phy_read(phy, MII_LPA);
+		phy->pause = ((val & LPA_PAUSE) != 0);
+	}
+	/* On non-aneg, we assume what we put in BMCR is the speed,
+	 * though magic-aneg shouldn't prevent this case from occurring
+	 */
+
+	return 0;
+}
+
+static int marvell_setup_aneg(struct mii_phy *phy, u32 advertise)
+{
+	u16 ctl, adv;
+	
+	phy->autoneg = 1;
+	phy->speed = SPEED_10;
+	phy->duplex = DUPLEX_HALF;
+	phy->pause = 0;
+	phy->advertising = advertise;
+
+	/* Setup standard advertise */
+	adv = phy_read(phy, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (advertise & ADVERTISED_10baseT_Half)
+		adv |= ADVERTISE_10HALF;
+	if (advertise & ADVERTISED_10baseT_Full)
+		adv |= ADVERTISE_10FULL;
+	if (advertise & ADVERTISED_100baseT_Half)
+		adv |= ADVERTISE_100HALF;
+	if (advertise & ADVERTISED_100baseT_Full)
+		adv |= ADVERTISE_100FULL;
+	phy_write(phy, MII_ADVERTISE, adv);
+
+	/* Setup 1000BT advertise & enable crossover detect
+	 * XXX How do we advertise 1000BT ? Darwin source is
+	 * confusing here, they read from specific control and
+	 * write to control... Someone has specs for those
+	 * beasts ?
+	 */
+	adv = phy_read(phy, MII_M1011_PHY_SPEC_CONTROL);
+	adv |= MII_M1011_PHY_SPEC_CONTROL_AUTO_MDIX;
+	adv &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP |
+			MII_1000BASETCONTROL_HALFDUPLEXCAP);
+	if (advertise & SUPPORTED_1000baseT_Half)
+		adv |= MII_1000BASETCONTROL_HALFDUPLEXCAP;
+	if (advertise & SUPPORTED_1000baseT_Full)
+		adv |= MII_1000BASETCONTROL_FULLDUPLEXCAP;
+	phy_write(phy, MII_1000BASETCONTROL, adv);
+
+	/* Start/Restart aneg */
+	ctl = phy_read(phy, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int marvell_setup_forced(struct mii_phy *phy, int speed, int fd)
+{
+	u16 ctl, ctl2;
+	
+	phy->autoneg = 0;
+	phy->speed = speed;
+	phy->duplex = fd;
+	phy->pause = 0;
+
+	ctl = phy_read(phy, MII_BMCR);
+	ctl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_SPD2|BMCR_ANENABLE);
+	ctl |= BMCR_RESET;
+
+	/* Select speed & duplex */
+	switch(speed) {
+	case SPEED_10:
+		break;
+	case SPEED_100:
+		ctl |= BMCR_SPEED100;
+		break;
+	/* I'm not sure about the one below, again, Darwin source is
+	 * quite confusing and I lack chip specs
+	 */
+	case SPEED_1000:
+		ctl |= BMCR_SPD2;
+	}
+	if (fd == DUPLEX_FULL)
+		ctl |= BMCR_FULLDPLX;
+
+	/* Disable crossover. Again, the way Apple does it is strange,
+	 * though I don't assume they are wrong ;)
+	 */
+	ctl2 = phy_read(phy, MII_M1011_PHY_SPEC_CONTROL);
+	ctl2 &= ~(MII_M1011_PHY_SPEC_CONTROL_MANUAL_MDIX |
+		MII_M1011_PHY_SPEC_CONTROL_AUTO_MDIX |
+		MII_1000BASETCONTROL_FULLDUPLEXCAP |
+		MII_1000BASETCONTROL_HALFDUPLEXCAP);
+	if (speed == SPEED_1000)
+		ctl2 |= (fd == DUPLEX_FULL) ?
+			MII_1000BASETCONTROL_FULLDUPLEXCAP :
+			MII_1000BASETCONTROL_HALFDUPLEXCAP;
+	phy_write(phy, MII_1000BASETCONTROL, ctl2);
+
+	// XXX Should we set the sungem to GII now on 1000BT ?
+	
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int marvell_read_link(struct mii_phy *phy)
+{
+	u16 status;
+
+	if (phy->autoneg) {
+		status = phy_read(phy, MII_M1011_PHY_SPEC_STATUS);
+		if ((status & MII_M1011_PHY_SPEC_STATUS_RESOLVED) == 0)
+			return -EAGAIN;
+		if (status & MII_M1011_PHY_SPEC_STATUS_1000)
+			phy->speed = SPEED_1000;
+		else if (status & MII_M1011_PHY_SPEC_STATUS_100)
+			phy->speed = SPEED_100;
+		else
+			phy->speed = SPEED_10;
+		if (status & MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX)
+			phy->duplex = DUPLEX_FULL;
+		else
+			phy->duplex = DUPLEX_HALF;
+		phy->pause = 0; /* XXX Check against spec ! */
+	}
+	/* On non-aneg, we assume what we put in BMCR is the speed,
+	 * though magic-aneg shouldn't prevent this case from occurring
+	 */
+
+	return 0;
+}
+
+static int genmii_setup_aneg(struct mii_phy *phy, u32 advertise)
+{
+	u16 ctl, adv;
+	
+	phy->autoneg = 1;
+	phy->speed = SPEED_10;
+	phy->duplex = DUPLEX_HALF;
+	phy->pause = 0;
+	phy->advertising = advertise;
+
+	/* Setup standard advertise */
+	adv = phy_read(phy, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (advertise & ADVERTISED_10baseT_Half)
+		adv |= ADVERTISE_10HALF;
+	if (advertise & ADVERTISED_10baseT_Full)
+		adv |= ADVERTISE_10FULL;
+	if (advertise & ADVERTISED_100baseT_Half)
+		adv |= ADVERTISE_100HALF;
+	if (advertise & ADVERTISED_100baseT_Full)
+		adv |= ADVERTISE_100FULL;
+	phy_write(phy, MII_ADVERTISE, adv);
+
+	/* Start/Restart aneg */
+	ctl = phy_read(phy, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int genmii_setup_forced(struct mii_phy *phy, int speed, int fd)
+{
+	u16 ctl;
+	
+	phy->autoneg = 0;
+	phy->speed = speed;
+	phy->duplex = fd;
+	phy->pause = 0;
+
+	ctl = phy_read(phy, MII_BMCR);
+	ctl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_ANENABLE);
+
+	/* First reset the PHY */
+	phy_write(phy, MII_BMCR, ctl | BMCR_RESET);
+
+	/* Select speed & duplex */
+	switch(speed) {
+	case SPEED_10:
+		break;
+	case SPEED_100:
+		ctl |= BMCR_SPEED100;
+		break;
+	case SPEED_1000:
+	default:
+		return -EINVAL;
+	}
+	if (fd == DUPLEX_FULL)
+		ctl |= BMCR_FULLDPLX;
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
+static int genmii_poll_link(struct mii_phy *phy)
+{
+	u16 status;
+	
+	(void)phy_read(phy, MII_BMSR);
+	status = phy_read(phy, MII_BMSR);
+	if ((status & BMSR_LSTATUS) == 0)
+		return 0;
+	if (phy->autoneg && !(status & BMSR_ANEGCOMPLETE))
+		return 0;
+	return 1;
+}
+
+static int genmii_read_link(struct mii_phy *phy)
+{
+	u16 lpa;
+
+	if (phy->autoneg) {
+		lpa = phy_read(phy, MII_LPA);
+
+		if (lpa & (LPA_10FULL | LPA_100FULL))
+			phy->duplex = DUPLEX_FULL;
+		else
+			phy->duplex = DUPLEX_HALF;
+		if (lpa & (LPA_100FULL | LPA_100HALF))
+			phy->speed = SPEED_100;
+		else
+			phy->speed = SPEED_10;
+		phy->pause = 0;
+	}
+	/* On non-aneg, we assume what we put in BMCR is the speed,
+	 * though magic-aneg shouldn't prevent this case from occurring
+	 */
+
+	 return 0;
+}
+
+
+#define MII_BASIC_FEATURES	(SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full | \
+				 SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | \
+				 SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII)
+#define MII_GBIT_FEATURES	(MII_BASIC_FEATURES | \
+				 SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full)
+
+/* Broadcom BCM 5201 */
+static struct mii_phy_ops bcm5201_phy_ops = {
+	init:		bcm5201_init,
+	suspend:	bcm5201_suspend,
+	setup_aneg:	genmii_setup_aneg,
+	setup_forced:	genmii_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	genmii_read_link,
+};
+
+static struct mii_phy_def bcm5201_phy_def = {
+	phy_id:		0x00406210,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5201",
+	features:	MII_BASIC_FEATURES,
+	magic_aneg:	0,
+	ops:		&bcm5201_phy_ops
+};
+
+/* Broadcom BCM 5221 */
+static struct mii_phy_ops bcm5221_phy_ops = {
+	suspend:	bcm5201_suspend,
+	init:		bcm5221_init,
+	setup_aneg:	genmii_setup_aneg,
+	setup_forced:	genmii_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	genmii_read_link,
+};
+
+static struct mii_phy_def bcm5221_phy_def = {
+	phy_id:		0x004061e0,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5221",
+	features:	MII_BASIC_FEATURES,
+	magic_aneg:	0,
+	ops:		&bcm5221_phy_ops
+};
+
+/* Broadcom BCM 5400 */
+static struct mii_phy_ops bcm5400_phy_ops = {
+	init:		bcm5400_init,
+	suspend:	bcm5400_suspend,
+	setup_aneg:	bcm54xx_setup_aneg,
+	setup_forced:	bcm54xx_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5400_phy_def = {
+	phy_id:		0x00206040,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5400",
+	features:	MII_GBIT_FEATURES,
+	magic_aneg:	1,
+	ops:		&bcm5400_phy_ops
+};
+
+/* Broadcom BCM 5401 */
+static struct mii_phy_ops bcm5401_phy_ops = {
+	init:		bcm5401_init,
+	suspend:	bcm5401_suspend,
+	setup_aneg:	bcm54xx_setup_aneg,
+	setup_forced:	bcm54xx_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5401_phy_def = {
+	phy_id:		0x00206050,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5401",
+	features:	MII_GBIT_FEATURES,
+	magic_aneg:	1,
+	ops:		&bcm5401_phy_ops
+};
+
+/* Broadcom BCM 5411 */
+static struct mii_phy_ops bcm5411_phy_ops = {
+	init:		bcm5411_init,
+	suspend:	bcm5411_suspend,
+	setup_aneg:	bcm54xx_setup_aneg,
+	setup_forced:	bcm54xx_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5411_phy_def = {
+	phy_id:		0x00206070,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5411",
+	features:	MII_GBIT_FEATURES,
+	magic_aneg:	1,
+	ops:		&bcm5411_phy_ops
+};
+
+/* Broadcom BCM 5421 */
+static struct mii_phy_ops bcm5421_phy_ops = {
+	init:		bcm5421_init,
+	suspend:	bcm5411_suspend,
+	setup_aneg:	bcm54xx_setup_aneg,
+	setup_forced:	bcm54xx_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5421_phy_def = {
+	phy_id:		0x002060e0,
+	phy_id_mask:	0xfffffff0,
+	name:		"BCM5421",
+	features:	MII_GBIT_FEATURES,
+	magic_aneg:	1,
+	ops:		&bcm5421_phy_ops
+};
+
+/* Marvell 88E1101 (Apple seem to deal with 2 different revs,
+ * I masked out the 8 last bits to get both, but some specs
+ * would be useful here) --BenH.
+ */
+static struct mii_phy_ops marvell_phy_ops = {
+	setup_aneg:	marvell_setup_aneg,
+	setup_forced:	marvell_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	marvell_read_link
+};
+
+static struct mii_phy_def marvell_phy_def = {
+	phy_id:		0x01410c00,
+	phy_id_mask:	0xffffff00,
+	name:		"Marvell 88E1101",
+	features:	MII_GBIT_FEATURES,
+	magic_aneg:	1,
+	ops:		&marvell_phy_ops
+};
+
+/* Generic implementation for most 10/100 PHYs */
+static struct mii_phy_ops generic_phy_ops = {
+	setup_aneg:	genmii_setup_aneg,
+	setup_forced:	genmii_setup_forced,
+	poll_link:	genmii_poll_link,
+	read_link:	genmii_read_link
+};
+
+static struct mii_phy_def genmii_phy_def = {
+	phy_id:		0x00000000,
+	phy_id_mask:	0x00000000,
+	name:		"Generic MII",
+	features:	MII_BASIC_FEATURES,
+	magic_aneg:	0,
+	ops:		&generic_phy_ops
+};
+
+static struct mii_phy_def* mii_phy_table[] = {
+	&bcm5201_phy_def,
+	&bcm5221_phy_def,
+	&bcm5400_phy_def,
+	&bcm5401_phy_def,
+	&bcm5411_phy_def,
+	&bcm5421_phy_def,
+	&marvell_phy_def,
+	&genmii_phy_def,
+	NULL
+};
+
+int mii_phy_probe(struct mii_phy *phy, int mii_id)
+{
+	int rc;
+	u32 id;
+	struct mii_phy_def* def;
+	int i;
+
+	/* We do not reset the mii_phy structure as the driver
+	 * may re-probe the PHY regulary
+	 */
+	phy->mii_id = mii_id;
+	
+	/* Take PHY out of isloate mode and reset it. */
+	rc = reset_one_mii_phy(phy, mii_id);
+	if (rc)
+		goto fail;
+
+	/* Read ID and find matching entry */	
+	id = (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, MII_PHYSID2))
+			 	& 0xfffffff0;
+	for (i=0; (def = mii_phy_table[i]) != NULL; i++)
+		if ((id & def->phy_id_mask) == def->phy_id)
+			break;
+	/* Should never be NULL (we have a generic entry), but... */
+	if (def == NULL)
+		goto fail;
+
+	phy->def = def;
+	
+	return 0;
+fail:
+	phy->speed = 0;
+	phy->duplex = 0;
+	phy->pause = 0;
+	phy->advertising = 0;
+	return -ENODEV;
+}
+
+EXPORT_SYMBOL(mii_phy_probe);
+MODULE_LICENSE("GPL");
+
diff -urN drivers/net/sungem_phy.h ../linux-2.4.22-ben2/drivers/net/sungem_phy.h
--- drivers/net/sungem_phy.h	Thu Jan 01 10:00:00 1970
+++ ../linux-2.4.22-ben2/drivers/net/sungem_phy.h	Sun Aug 31 19:41:49 2003
@@ -0,0 +1,116 @@
+#ifndef __SUNGEM_PHY_H__
+#define __SUNGEM_PHY_H__
+
+struct mii_phy;
+
+/* Operations supported by any kind of PHY */
+struct mii_phy_ops
+{
+	int		(*init)(struct mii_phy *phy);
+	int		(*suspend)(struct mii_phy *phy, int wol_options);
+	int		(*setup_aneg)(struct mii_phy *phy, u32 advertise);
+	int		(*setup_forced)(struct mii_phy *phy, int speed, int fd);
+	int		(*poll_link)(struct mii_phy *phy);
+	int		(*read_link)(struct mii_phy *phy);
+};
+
+/* Structure used to statically define an mii/gii based PHY */
+struct mii_phy_def
+{
+	u32				phy_id;		/* Concatenated ID1 << 16 | ID2 */
+	u32				phy_id_mask;	/* Significant bits */
+	u32				features;	/* Ethtool SUPPORTED_* defines */
+	int				magic_aneg;	/* Autoneg does all speed test for us */
+	const char*			name;
+	const struct mii_phy_ops*	ops;
+};
+
+/* An instance of a PHY, partially borrowed from mii_if_info */
+struct mii_phy
+{
+	struct mii_phy_def*	def;
+	int			advertising;
+	int			mii_id;
+
+	/* 1: autoneg enabled, 0: disabled */
+	int			autoneg;
+
+	/* forced speed & duplex (no autoneg)
+	 * partner speed & duplex & pause (autoneg)
+	 */
+	int			speed;
+	int			duplex;
+	int			pause;
+
+	/* Provided by host chip */
+	struct net_device*	dev;
+	int (*mdio_read) (struct net_device *dev, int mii_id, int reg);
+	void (*mdio_write) (struct net_device *dev, int mii_id, int reg, int val);
+};
+
+/* Pass in a struct mii_phy with dev, mdio_read and mdio_write
+ * filled, the remaining fields will be filled on return
+ */
+extern int mii_phy_probe(struct mii_phy *phy, int mii_id);
+
+
+/* MII definitions missing from mii.h */
+
+#define BMCR_SPD2	0x0040		/* Gigabit enable (bcm54xx)	*/
+#define LPA_PAUSE	0x0400
+
+/* More PHY registers (model specific) */
+
+/* MII BCM5201 MULTIPHY interrupt register */
+#define MII_BCM5201_INTERRUPT			0x1A
+#define MII_BCM5201_INTERRUPT_INTENABLE		0x4000
+
+#define MII_BCM5201_AUXMODE2			0x1B
+#define MII_BCM5201_AUXMODE2_LOWPOWER		0x0008
+
+#define MII_BCM5201_MULTIPHY                    0x1E
+
+/* MII BCM5201 MULTIPHY register bits */
+#define MII_BCM5201_MULTIPHY_SERIALMODE         0x0002
+#define MII_BCM5201_MULTIPHY_SUPERISOLATE       0x0008
+
+/* MII BCM5221 Additional registers */
+#define MII_BCM5221_TEST			0x1f
+#define MII_BCM5221_TEST_ENABLE_SHADOWS		0x0080
+#define MII_BCM5221_SHDOW_AUX_STAT2		0x1b
+#define MII_BCM5221_SHDOW_AUX_STAT2_APD		0x0020
+#define MII_BCM5221_SHDOW_AUX_MODE4		0x1a
+#define MII_BCM5221_SHDOW_AUX_MODE4_CLKLOPWR	0x0004
+
+/* MII BCM5400 1000-BASET Control register */
+#define MII_BCM5400_GB_CONTROL			0x09
+#define MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP	0x0200
+
+/* MII BCM5400 AUXCONTROL register */
+#define MII_BCM5400_AUXCONTROL                  0x18
+#define MII_BCM5400_AUXCONTROL_PWR10BASET       0x0004
+
+/* MII BCM5400 AUXSTATUS register */
+#define MII_BCM5400_AUXSTATUS                   0x19
+#define MII_BCM5400_AUXSTATUS_LINKMODE_MASK     0x0700
+#define MII_BCM5400_AUXSTATUS_LINKMODE_SHIFT    8  
+
+/* 1000BT control (Marvell & BCM54xx at least) */
+#define MII_1000BASETCONTROL			0x09
+#define MII_1000BASETCONTROL_FULLDUPLEXCAP	0x0200
+#define MII_1000BASETCONTROL_HALFDUPLEXCAP	0x0100
+
+/* Marvell 88E1011 PHY control */
+#define MII_M1011_PHY_SPEC_CONTROL		0x10
+#define MII_M1011_PHY_SPEC_CONTROL_MANUAL_MDIX	0x20
+#define MII_M1011_PHY_SPEC_CONTROL_AUTO_MDIX	0x40
+
+/* Marvell 88E1011 PHY status */
+#define MII_M1011_PHY_SPEC_STATUS		0x11
+#define MII_M1011_PHY_SPEC_STATUS_1000		0x8000
+#define MII_M1011_PHY_SPEC_STATUS_100		0x4000
+#define MII_M1011_PHY_SPEC_STATUS_SPD_MASK	0xc000
+#define MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX	0x2000
+#define MII_M1011_PHY_SPEC_STATUS_RESOLVED	0x0800
+
+#endif /* __SUNGEM_PHY_H__ */

