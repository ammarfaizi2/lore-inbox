Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWHQH6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWHQH6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWHQH6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:58:45 -0400
Received: from msr43.hinet.net ([168.95.4.143]:36601 "EHLO msr43.hinet.net")
	by vger.kernel.org with ESMTP id S932253AbWHQH6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:58:43 -0400
Subject: [PATCH 4/7] ip1000: ipg_config_autoneg rewrite
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:45:51 -0400
Message-Id: <1155843951.5006.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

ipg_config_autoneg rewrite

Change Logs:
    ipg_config_autoneg rewrite

---

 drivers/net/ipg.c |  307
++++++-----------------------------------------------
 1 files changed, 32 insertions(+), 275 deletions(-)

c3f6df15430f9c05e19f36b8485b31110d52a091
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index a996c45..f859107 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -484,26 +484,18 @@ static int ipg_config_autoneg(struct net
 {
 	struct ipg_nic_private *sp = netdev_priv(dev);
 	void __iomem *ioaddr = sp->ioaddr;
+	u8 phyctrl;
 	u32 asicctrl;
-	u32 mac_ctl;
-	int phyaddr = 0;
-	u16 status = 0;
-	u16 advertisement;
-	u16 linkpartner_ability;
-	u16 gigadvertisement;
-	u16 giglinkpartner_ability;
-	u16 techabilities;
 	int fiber;
 	int gig;
 	int fullduplex;
 	int txflowcontrol;
 	int rxflowcontrol;
-	u8 phyctrl;
 
 	IPG_DEBUG_MSG("_config_autoneg\n");
 
 	asicctrl = ioread32(ioaddr + ASIC_CTRL);
-	phyctrl = ioread8(ioaddr + PHY_CTRL);
+	phyctrl = ioread32(ioaddr + PHY_CTRL);
 
 	/* Set flags for use in resolving auto-negotation, assuming
 	 * non-1000Mbps, half duplex, no flow control.
@@ -519,14 +511,13 @@ static int ipg_config_autoneg(struct net
 	 */
 	sp->tenmbpsmode = 0;
 
-	printk("Link speed = ");
+	printk(KERN_INFO "Link speed = ");
 
 	/* Determine actual speed of operation. */
 	switch (phyctrl & IPG_PC_LINK_SPEED) {
 	case IPG_PC_LINK_SPEED_10MBPS:
 		printk("10Mbps.\n");
-		printk(KERN_INFO "%s: 10Mbps operational mode enabled.\n",
-		       dev->name);
+		printk("%s: 10Mbps operational mode enabled.\n",dev->name);
 		sp->tenmbpsmode = 1;
 		break;
 	case IPG_PC_LINK_SPEED_100MBPS:
@@ -538,283 +529,49 @@ static int ipg_config_autoneg(struct net
 		break;
 	default:
 		printk("undefined!\n");
-	}
-
-	fiber = ipg_sti_fiber_detect(dev);
-
-	/* Determine if auto-negotiation resolution is necessary.
-	 * First check for fiber based media 10/100 media.
-	 */
-	if ((fiber == 1) &&
-	    (asicctrl & (IPG_AC_PHY_SPEED10 | IPG_AC_PHY_SPEED100))) {
-		printk(KERN_INFO
-		       "%s: Fiber based PHY, setting full duplex, no flow
control.\n",
-		       dev->name);
-
-		mac_ctl  = ioread32(ioaddr + MAC_CTRL);
-		mac_ctl |= IPG_MC_DUPLEX_SELECT_FD;
-		mac_ctl &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
-		mac_ctl &= ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
-
-		iowrite32(IPG_MC_RSVD_MASK & mac_ctl, ioaddr + MAC_CTRL);
-
 		return 0;
 	}
 
-	/* Determine if PHY is auto-negotiation capable. */
-	phyaddr = ipg_find_phyaddr(dev);
-
-	if (phyaddr == -1) {
-		printk(KERN_INFO
-		       "%s: Error on read to GMII/MII Status register.\n",
-		       dev->name);
-		return -EILSEQ;
-	}
-	sp->mii_if.phy_id = phyaddr;
-
-	IPG_DEBUG_MSG("GMII/MII PHY address = %x\n", phyaddr);
-
-	status = mdio_read(dev, phyaddr, MII_BMSR);
-
-	printk("PHYStatus = %x \n", status);
-	if ((status & BMSR_ANEGCAPABLE) == 0) {
-		printk(KERN_INFO
-		       "%s: Error PHY unable to perform auto-negotiation.\n",
-		       dev->name);
-		return -EILSEQ;
-	}
-
-	advertisement = mdio_read(dev, phyaddr, MII_ADVERTISE);
-	linkpartner_ability = mdio_read(dev, phyaddr, MII_LPA);
-
-	printk("PHYadvertisement=%x LinkPartner=%x \n", advertisement,
-	       linkpartner_ability);
-	if ((advertisement == 0xFFFF) || (linkpartner_ability == 0xFFFF)) {
-		printk(KERN_INFO
-		       "%s: Error on read to GMII/MII registers 4 and/or 5.\n",
-		       dev->name);
-		return -EILSEQ;
+	if (phyctrl & IPG_PC_DUPLEX_STATUS) {
+		fullduplex = 1;
+		txflowcontrol = 1;
+		rxflowcontrol = 1;
+	} else {
+		fullduplex = 0;
+		txflowcontrol = 0;
+		rxflowcontrol = 0;
 	}
 
-	fiber = ipg_tmi_fiber_detect(dev, phyaddr);
-
-	/* Resolve full/half duplex if 1000BASE-X. */
-	if ((gig == 1) && (fiber == 1)) {
-		int bmcr;
-		/*
-		 * Compare the full duplex bits in the GMII registers
-		 * for the local device, and the link partner. If these
-		 * bits are logic 1 in both registers, configure the
-		 * IPG for full duplex operation.
-		 */
-		bmcr = mdio_read(dev, phyaddr, MII_BMCR);
+	/* Configure full duplex, and flow control. */
+	if (fullduplex == 1) {
+		/* Configure IPG for full duplex operation. */
+		printk(KERN_INFO "setting full duplex, ");
 
-		if ((advertisement & ADVERTISE_1000XFULL) ==
-		    (linkpartner_ability & ADVERTISE_1000XFULL)) {
-			fullduplex = 1;
+		iowrite32(ioread32(ioaddr + MAC_CTRL) | IPG_MC_DUPLEX_SELECT_FD,
ioaddr + MAC_CTRL);
 
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr |= ADVERTISE_1000HALF; // Typo ?
+		if (txflowcontrol == 1) {
+			printk("TX flow control");
+			iowrite32(ioread32(ioaddr + MAC_CTRL) |
IPG_MC_TX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
 		} else {
-			fullduplex = 0;
-
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr &= ~ADVERTISE_1000HALF; // Typo ?
+			printk("no TX flow control");
+			iowrite32(ioread32(ioaddr + MAC_CTRL) &
~IPG_MC_TX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
 		}
-		mdio_write(dev, phyaddr, MII_BMCR, bmcr);
-	}
 
-	/* Resolve full/half duplex if 1000BASE-T. */
-	if ((gig == 1) && (fiber == 0)) {
-		/* Read the 1000BASE-T "Control" and "Status"
-		 * registers which represent the advertised and
-		 * link partner abilities exchanged via next page
-		 * transfers.
-		 */
-		gigadvertisement = mdio_read(dev, phyaddr, MII_CTRL1000);
-		giglinkpartner_ability = mdio_read(dev, phyaddr, MII_STAT1000);
-
-		/* Compare the full duplex bits in the 1000BASE-T GMII
-		 * registers for the local device, and the link partner.
-		 * If these bits are logic 1 in both registers, configure
-		 * the IPG for full duplex operation.
-		 */
-		if ((gigadvertisement & ADVERTISE_1000FULL) &&
-		    (giglinkpartner_ability & ADVERTISE_1000FULL)) {
-			fullduplex = 1;
+		if (rxflowcontrol == 1) {
+			printk(", RX flow control.");
+			iowrite32(ioread32(ioaddr+MAC_CTRL) | IPG_MC_RX_FLOW_CONTROL_ENABLE,
ioaddr + MAC_CTRL);
 		} else {
-			fullduplex = 0;
-		}
-	}
-
-	/* Resolve full/half duplex for 10/100BASE-T. */
-	if (gig == 0) {
-		/* Autonegotiation Priority Resolution algorithm, as defined in
-		 * IEEE 802.3 Annex 28B.
-		 */
-		if (((advertisement & ADVERTISE_SLCT) ==
-		     MII_PHY_SELECTOR_IEEE8023) &&
-		    ((linkpartner_ability & ADVERTISE_SLCT) ==
-		     MII_PHY_SELECTOR_IEEE8023)) {
-			techabilities = (advertisement & linkpartner_ability &
-					 MII_PHY_TECHABILITYFIELD);
-
-			fullduplex = 0;
-
-			/* 10BASE-TX half duplex is lowest priority. */
-			if (techabilities & LPA_10HALF)
-				fullduplex = 0;
-
-			if (techabilities & LPA_10FULL)
-				fullduplex = 1;
-
-			if (techabilities & LPA_100HALF)
-				fullduplex = 0;
-
-			if (techabilities & LPA_100BASE4)
-				fullduplex = 0;
-
-			/* 100BASE-TX half duplex is highest priority. *///Sorbica full
duplex ?
-			if (techabilities & LPA_100FULL)
-				fullduplex = 1;
-
-			if (fullduplex == 1) {
-				/* If in full duplex mode, determine if PAUSE
-				 * functionality is supported by the local
-				 * device, and the link partner.
-				 */
-				if (techabilities & LPA_PAUSE_CAP) {
-					txflowcontrol = 1;
-					rxflowcontrol = 1;
-				} else {
-					txflowcontrol = 0;
-					rxflowcontrol = 0;
-				}
-			}
+			printk(", no RX flow control.");
+			iowrite32(ioread32(ioaddr+MAC_CTRL) &
~IPG_MC_RX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
 		}
-	}
 
-	/* If in 1000Mbps, fiber, and full duplex mode, resolve
-	 * 1000BASE-X PAUSE capabilities. */
-	if ((fullduplex == 1) && (fiber == 1) && (gig == 1)) {
-		/* In full duplex mode, resolve PAUSE
-		 * functionality.
-		 */
-		u8 flow_ctl;
-#define LPA_PAUSE_ANY	(LPA_1000XPAUSE_ASYM | LPA_1000XPAUSE)
-
-		flow_ctl  = (advertisement & LPA_PAUSE_ANY) >> 5;
-		flow_ctl |= (linkpartner_ability & LPA_PAUSE_ANY) >> 7;
-		switch (flow_ctl) {
-		case 0x7:
-			txflowcontrol = 1;
-			rxflowcontrol = 0;
-			break;
-
-		case 0xA:
-		case 0xB:
-		case 0xE:
-		case 0xF:
-			txflowcontrol = 1;
-			rxflowcontrol = 1;
-			break;
-
-		case 0xD:
-			txflowcontrol = 0;
-			rxflowcontrol = 1;
-			break;
+		printk("\n");
+	} else {
+		/* Configure IPG for half duplex operation. */
+	        printk(KERN_INFO "setting half duplex, no TX flow control, no
RX flow control.\n");
 
-		default:
-			txflowcontrol = 0;
-			rxflowcontrol = 0;
-		}
+		iowrite32(ioread32(ioaddr+MAC_CTRL) & ~IPG_MC_DUPLEX_SELECT_FD &
~IPG_MC_TX_FLOW_CONTROL_ENABLE & ~IPG_MC_RX_FLOW_CONTROL_ENABLE, ioaddr
+ MAC_CTRL);
 	}
-
-	/*
-	 * If in 1000Mbps, non-fiber, full duplex mode, resolve
-	 * 1000BASE-T PAUSE capabilities.
-	 */
-	if ((fullduplex == 1) && (fiber == 0) && (gig == 1)) {
-		/*
-		 * Make sure the PHY is advertising we are PAUSE capable.
-		 * Otherwise advertise PAUSE and restart auto-negotiation.
-		 */
-#define ADVERTISE_PAUSE_ANY (ADVERTISE_PAUSE_CAP |
ADVERTISE_PAUSE_ASYM)
-
-		if (!(ADVERTISE_PAUSE_ANY & advertisement)) {
-			advertisement |= ADVERTISE_PAUSE_ANY;
-			mdio_write(dev, phyaddr, MII_ADVERTISE, advertisement);
-			mdio_write(dev, phyaddr, MII_BMCR, BMCR_ANRESTART);
-
-			return -EAGAIN;
-		}
-		/* In full duplex mode, resolve PAUSE functionality. */
-		switch (((ADVERTISE_PAUSE_ANY & advertisement) >> 0x8) |
-			((ADVERTISE_PAUSE_ANY & linkpartner_ability) >> 0xa)) {
-		case 0x7:
-			txflowcontrol = 1;
-			rxflowcontrol = 0;
-			break;
-
-		case 0xA:
-		case 0xB:
-		case 0xE:
-		case 0xF:
-			txflowcontrol = 1;
-			rxflowcontrol = 1;
-			break;
-
-		case 0xD:
-			txflowcontrol = 0;
-			rxflowcontrol = 1;
-			break;
-
-		default:
-			txflowcontrol = 0;
-			rxflowcontrol = 0;
-		}
-	}
-
-	/*
-	 * If in 10/100Mbps, non-fiber, full duplex mode, assure
-	 * 10/100BASE-T PAUSE capabilities are advertised.
-	 * Otherwise advertise PAUSE and restart auto-negotiation.
-	 */
-	if ((fullduplex == 1) && (fiber == 0) && (gig == 0) &&
-	    !(advertisement & ADVERTISE_PAUSE_CAP)) {
-		advertisement |= ADVERTISE_PAUSE_CAP;
-		mdio_write(dev, phyaddr, MII_ADVERTISE, advertisement);
-		mdio_write(dev, phyaddr, MII_BMCR, BMCR_ANRESTART);
-		return -EAGAIN;
-	}
-
-	printk(KERN_INFO "%s: %s based PHY, ", dev->name,
-		(fiber == 1) ? "fiber" : "copper");
-
-	/* Configure full duplex, and flow control. */
-
-	mac_ctl  = ioread32(ioaddr + MAC_CTRL);
-
-	mac_ctl &= ~IPG_MC_DUPLEX_SELECT_FD;
-	mac_ctl &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
-	mac_ctl &= ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
-
-	if (fullduplex == 1) {
-		mac_ctl |= IPG_MC_DUPLEX_SELECT_FD;
-
-		if (txflowcontrol == 1)
-			mac_ctl |= IPG_MC_TX_FLOW_CONTROL_ENABLE;
-
-		if (rxflowcontrol == 1)
-			mac_ctl |= IPG_MC_RX_FLOW_CONTROL_ENABLE;
-	}
-
-	iowrite32(IPG_MC_RSVD_MASK & mac_ctl, ioaddr + MAC_CTRL);
-
 	return 0;
 }
 
-- 
1.3.2



