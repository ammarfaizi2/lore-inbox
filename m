Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWEBW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWEBW3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEBW3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:29:19 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:51656 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S965021AbWEBW3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:29:17 -0400
Date: Wed, 3 May 2006 00:30:48 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Francois Romieu <romieu@fr.zoreil.com>, David Vrabel <dvrabel@cantab.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ipg: removing more dead code
Message-ID: <20060502223048.GA32038@fargo>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	Francois Romieu <romieu@fr.zoreil.com>,
	David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231050.GC7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020936420.4066@sbz-30.cs.Helsinki.FI> <20060502183313.GA26357@electric-eye.fr.zoreil.com> <1146596687.13675.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1146596687.13675.1.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On May 02 at 10:04:47, Pekka Enberg wrote:
> OK. David & David, would appreciate if either you could give the patch a
> spin with Francois' changes. Thanks.

I'll test it tomorrow ASAP. For now, here is another patch removing
more dead code. This code is never reached (NOTGRACE is not defined)
and the *fiber_detect functions are subsequently never used.

--- drivers/net/ipg.c.old	2006-05-03 00:16:47.000000000 +0200
+++ drivers/net/ipg.c	2006-05-03 00:28:02.000000000 +0200
@@ -461,43 +461,6 @@
 	return 0;
 }
 
-#ifdef IPG_TMI_FIBER_DETECT
-static int ipg_sti_fiber_detect(struct net_device *dev)
-{
-	/* Determine if NIC is fiber based by reading the PhyMedia
-	 * bit in the AsicCtrl register.
-	 */
-
-	u32 asicctrl;
-	void __iomem *ioaddr = ipg_ioaddr(dev);
-
-	IPG_DEBUG_MSG("_sti_fiber_detect\n");
-
-	asicctrl = ioread32(ioaddr + IPG_ASICCTRL);
-
-	return asicctrl & IPG_AC_PHY_MEDIA;
-}
-
-static int ipg_tmi_fiber_detect(struct net_device *dev, int phyaddr)
-{
-	/* Determine if NIC is fiber based by reading the ID register
-	 * of the PHY and the GMII address.
-	 */
-
-	u16 phyid;
-
-	IPG_DEBUG_MSG("_tmi_fiber_detect\n");
-
-	phyid = read_phy_register(dev, phyaddr, GMII_PHY_ID_1);
-
-	IPG_DEBUG_MSG("PHY ID = %x\n", phyid);
-
-	/* We conclude the mode is fiber if the GMII address
-	 * is 0x1 and the PHY ID is 0x0000.
-	 */
-	return (phyaddr == 0x1) && (phyid == 0x0000);
-}
-#endif
 
 static int ipg_find_phyaddr(struct net_device *dev)
 {
@@ -524,434 +487,6 @@
 	return -1;
 }
 
-#ifdef NOTGRACE
-static int ipg_config_autoneg(struct net_device *dev)
-{
-	/* Configure IPG based on result of IEEE 802.3 PHY
-	 * auto-negotiation.
-	 */
-
-	int phyaddr = 0;
-	u8 phyctrl;
-	u32 asicctrl;
-	void __iomem *ioaddr = ipg_ioaddr(dev);
-	u16 status = 0;
-	u16 advertisement;
-	u16 linkpartner_ability;
-	u16 gigadvertisement;
-	u16 giglinkpartner_ability;
-	u16 techabilities;
-	int fiber;
-	int gig;
-	int fullduplex;
-	int txflowcontrol;
-	int rxflowcontrol;
-	struct ipg_nic_private *sp = netdev_priv(dev);
-
-	IPG_DEBUG_MSG("_config_autoneg\n");
-
-	asicctrl = ioread32(ioaddr + IPG_ASICCTRL);
-	phyctrl = ioread8(ioaddr + IPG_PHYCTRL);
-
-	/* Set flags for use in resolving auto-negotation, assuming
-	 * non-1000Mbps, half duplex, no flow control.
-	 */
-	fiber = 0;
-	fullduplex = 0;
-	txflowcontrol = 0;
-	rxflowcontrol = 0;
-	gig = 0;
-
-	/* To accomodate a problem in 10Mbps operation,
-	 * set a global flag if PHY running in 10Mbps mode.
-	 */
-	sp->tenmbpsmode = 0;
-
-	printk("Link speed = ");
-
-	/* Determine actual speed of operation. */
-	switch (phyctrl & IPG_PC_LINK_SPEED) {
-	case IPG_PC_LINK_SPEED_10MBPS:
-		printk("10Mbps.\n");
-		printk(KERN_INFO "%s: 10Mbps operational mode enabled.\n",
-		       dev->name);
-		sp->tenmbpsmode = 1;
-		break;
-	case IPG_PC_LINK_SPEED_100MBPS:
-		printk("100Mbps.\n");
-		break;
-	case IPG_PC_LINK_SPEED_1000MBPS:
-		printk("1000Mbps.\n");
-		gig = 1;
-		break;
-	default:
-		printk("undefined!\n");
-	}
-
-#ifndef IPG_TMI_FIBER_DETECT
-	fiber = ipg_sti_fiber_detect(dev);
-
-	/* Determine if auto-negotiation resolution is necessary.
-	 * First check for fiber based media 10/100 media.
-	 */
-	if ((fiber == 1) && (asicctrl &
-			     (IPG_AC_PHY_SPEED10 | IPG_AC_PHY_SPEED100))) {
-		printk(KERN_INFO
-		       "%s: Fiber based PHY, setting full duplex, no flow control.\n",
-		       dev->name);
-		return -EILSEQ;
-		iowrite32(IPG_MC_RSVD_MASK &
-			  ((ioread32(ioaddr + IPG_MACCTRL) |
-			    IPG_MC_DUPLEX_SELECT_FD) &
-			   ~IPG_MC_TX_FLOW_CONTROL_ENABLE &
-			   ~IPG_MC_RX_FLOW_CONTROL_ENABLE),
-			  ioaddr + IPG_MACCTRL);
-
-		return 0;
-	}
-#endif
-
-	/* Determine if PHY is auto-negotiation capable. */
-	phyaddr = ipg_find_phyaddr(dev);
-
-	if (phyaddr == -1) {
-		printk(KERN_INFO
-		       "%s: Error on read to GMII/MII Status register.\n",
-		       dev->name);
-		return -EILSEQ;
-	}
-
-	IPG_DEBUG_MSG("GMII/MII PHY address = %x\n", phyaddr);
-
-	status = read_phy_register(dev, phyaddr, GMII_PHY_STATUS);
-
-	printk("PHYStatus = %x \n", status);
-	if ((status & GMII_PHY_STATUS_AUTONEG_ABILITY) == 0) {
-		printk(KERN_INFO
-		       "%s: Error PHY unable to perform auto-negotiation.\n",
-		       dev->name);
-		return -EILSEQ;
-	}
-
-	advertisement = read_phy_register(dev, phyaddr,
-					  GMII_PHY_AUTONEGADVERTISEMENT);
-	linkpartner_ability = read_phy_register(dev, phyaddr,
-						GMII_PHY_AUTONEGLINKPARTABILITY);
-
-	printk("PHYadvertisement=%x LinkPartner=%x \n", advertisement,
-	       linkpartner_ability);
-	if ((advertisement == 0xFFFF) || (linkpartner_ability == 0xFFFF)) {
-		printk(KERN_INFO
-		       "%s: Error on read to GMII/MII registers 4 and/or 5.\n",
-		       dev->name);
-		return -EILSEQ;
-	}
-#ifdef IPG_TMI_FIBER_DETECT
-	fiber = ipg_tmi_fiber_detect(dev, phyaddr);
-#endif
-
-	/* Resolve full/half duplex if 1000BASE-X. */
-	if ((gig == 1) && (fiber == 1)) {
-		/* Compare the full duplex bits in the GMII registers
-		 * for the local device, and the link partner. If these
-		 * bits are logic 1 in both registers, configure the
-		 * IPG for full duplex operation.
-		 */
-		if ((advertisement & GMII_PHY_ADV_FULL_DUPLEX) ==
-		    (linkpartner_ability & GMII_PHY_ADV_FULL_DUPLEX)) {
-			fullduplex = 1;
-
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   GMII_PHY_CONTROL,
-					   read_phy_register
-					   (dev, phyaddr,
-					    GMII_PHY_CONTROL) |
-					   GMII_PHY_CONTROL_FULL_DUPLEX);
-
-		} else {
-			fullduplex = 0;
-
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   GMII_PHY_CONTROL,
-					   read_phy_register
-					   (dev, phyaddr,
-					    GMII_PHY_CONTROL) &
-					   ~GMII_PHY_CONTROL_FULL_DUPLEX);
-		}
-	}
-
-	/* Resolve full/half duplex if 1000BASE-T. */
-	if ((gig == 1) && (fiber == 0)) {
-		/* Read the 1000BASE-T "Control" and "Status"
-		 * registers which represent the advertised and
-		 * link partner abilities exchanged via next page
-		 * transfers.
-		 */
-		gigadvertisement = read_phy_register(dev,
-						     phyaddr,
-						     GMII_PHY_1000BASETCONTROL);
-		giglinkpartner_ability = read_phy_register(dev,
-							   phyaddr,
-							   GMII_PHY_1000BASETSTATUS);
-
-		/* Compare the full duplex bits in the 1000BASE-T GMII
-		 * registers for the local device, and the link partner.
-		 * If these bits are logic 1 in both registers, configure
-		 * the IPG for full duplex operation.
-		 */
-		if ((gigadvertisement & GMII_PHY_1000BASETCONTROL_FULL_DUPLEX)
-		    && (giglinkpartner_ability &
-			GMII_PHY_1000BASETSTATUS_FULL_DUPLEX)) {
-			fullduplex = 1;
-		} else {
-			fullduplex = 0;
-		}
-	}
-
-	/* Resolve full/half duplex for 10/100BASE-T. */
-	if (gig == 0) {
-		/* Autonegotiation Priority Resolution algorithm, as defined in
-		 * IEEE 802.3 Annex 28B.
-		 */
-		if (((advertisement & MII_PHY_SELECTORFIELD) ==
-		     MII_PHY_SELECTOR_IEEE8023) &&
-		    ((linkpartner_ability & MII_PHY_SELECTORFIELD) ==
-		     MII_PHY_SELECTOR_IEEE8023)) {
-			techabilities = (advertisement & linkpartner_ability &
-					 MII_PHY_TECHABILITYFIELD);
-
-			fullduplex = 0;
-
-			/* 10BASE-TX half duplex is lowest priority. */
-			if (techabilities & MII_PHY_TECHABILITY_10BT) {
-				fullduplex = 0;
-			}
-
-			if (techabilities & MII_PHY_TECHABILITY_10BTFD) {
-				fullduplex = 1;
-			}
-
-			if (techabilities & MII_PHY_TECHABILITY_100BTX) {
-				fullduplex = 0;
-			}
-
-			if (techabilities & MII_PHY_TECHABILITY_100BT4) {
-				fullduplex = 0;
-			}
-
-			/* 100BASE-TX half duplex is highest priority. *///Sorbica full duplex ?
-			if (techabilities & MII_PHY_TECHABILITY_100BTXFD) {
-				fullduplex = 1;
-			}
-
-			if (fullduplex == 1) {
-				/* If in full duplex mode, determine if PAUSE
-				 * functionality is supported by the local
-				 * device, and the link partner.
-				 */
-				if (techabilities & MII_PHY_TECHABILITY_PAUSE) {
-					txflowcontrol = 1;
-					rxflowcontrol = 1;
-				} else {
-					txflowcontrol = 0;
-					rxflowcontrol = 0;
-				}
-			}
-		}
-	}
-
-	/* If in 1000Mbps, fiber, and full duplex mode, resolve
-	 * 1000BASE-X PAUSE capabilities. */
-	if ((fullduplex == 1) && (fiber == 1) && (gig == 1)) {
-		/* In full duplex mode, resolve PAUSE
-		 * functionality.
-		 */
-		switch (((advertisement & GMII_PHY_ADV_PAUSE) >> 5) |
-			((linkpartner_ability & GMII_PHY_ADV_PAUSE) >> 7)) {
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
-	/* If in 1000Mbps, non-fiber, full duplex mode, resolve
-	 * 1000BASE-T PAUSE capabilities. */
-	if ((fullduplex == 1) && (fiber == 0) && (gig == 1)) {
-		/* Make sure the PHY is advertising we are PAUSE
-		 * capable.
-		 */
-		if (!(advertisement & (MII_PHY_TECHABILITY_PAUSE |
-				       MII_PHY_TECHABILITY_ASM_DIR))) {
-			/* PAUSE is not being advertised. Advertise
-			 * PAUSE and restart auto-negotiation.
-			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   MII_PHY_AUTONEGADVERTISEMENT,
-					   (advertisement |
-					    MII_PHY_TECHABILITY_PAUSE |
-					    MII_PHY_TECHABILITY_ASM_DIR));
-			write_phy_register(dev,
-					   phyaddr,
-					   MII_PHY_CONTROL,
-					   MII_PHY_CONTROL_RESTARTAN);
-
-			return -EAGAIN;
-		}
-
-		/* In full duplex mode, resolve PAUSE
-		 * functionality.
-		 */
-		switch (((advertisement &
-			  MII_PHY_TECHABILITY_PAUSE_FIELDS) >> 0x8) |
-			((linkpartner_ability &
-			  MII_PHY_TECHABILITY_PAUSE_FIELDS) >> 0xA)) {
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
-	/* If in 10/100Mbps, non-fiber, full duplex mode, assure
-	 * 10/100BASE-T PAUSE capabilities are advertised. */
-	if ((fullduplex == 1) && (fiber == 0) && (gig == 0)) {
-		/* Make sure the PHY is advertising we are PAUSE
-		 * capable.
-		 */
-		if (!(advertisement & (MII_PHY_TECHABILITY_PAUSE))) {
-			/* PAUSE is not being advertised. Advertise
-			 * PAUSE and restart auto-negotiation.
-			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   MII_PHY_AUTONEGADVERTISEMENT,
-					   (advertisement |
-					    MII_PHY_TECHABILITY_PAUSE));
-			write_phy_register(dev,
-					   phyaddr,
-					   MII_PHY_CONTROL,
-					   MII_PHY_CONTROL_RESTARTAN);
-
-			return -EAGAIN;
-		}
-
-	}
-
-	if (fiber == 1) {
-		printk(KERN_INFO "%s: Fiber based PHY, ", dev->name);
-	} else {
-		printk(KERN_INFO "%s: Copper based PHY, ", dev->name);
-	}
-
-	/* Configure full duplex, and flow control. */
-	if (fullduplex == 1) {
-		/* Configure IPG for full duplex operation. */
-		printk("setting full duplex, ");
-
-		iowrite32(IPG_MC_RSVD_MASK &
-			  (ioread32(ioaddr + IPG_MACCTRL) |
-			   IPG_MC_DUPLEX_SELECT_FD), ioaddr + IPG_MACCTRL);
-
-		if (txflowcontrol == 1) {
-			printk("TX flow control");
-			iowrite32(IPG_MC_RSVD_MASK &
-				  (ioread32(ioaddr + IPG_MACCTRL) |
-				   IPG_MC_TX_FLOW_CONTROL_ENABLE),
-				  ioaddr + IPG_MACCTRL);
-		} else {
-			printk("no TX flow control");
-			iowrite32(IPG_MC_RSVD_MASK &
-				  (ioread32(ioaddr + IPG_MACCTRL) &
-				   ~IPG_MC_TX_FLOW_CONTROL_ENABLE),
-				  ioaddr + IPG_MACCTRL);
-		}
-
-		if (rxflowcontrol == 1) {
-			printk(", RX flow control.");
-			iowrite32(IPG_MC_RSVD_MASK &
-				  (ioread32(ioaddr + IPG_MACCTRL) |
-				   IPG_MC_RX_FLOW_CONTROL_ENABLE),
-				  ioaddr + IPG_MACCTRL);
-		} else {
-			printk(", no RX flow control.");
-			iowrite32(IPG_MC_RSVD_MASK &
-				  (ioread32(ioaddr + IPG_MACCTRL) &
-				   ~IPG_MC_RX_FLOW_CONTROL_ENABLE),
-				  ioaddr + IPG_MACCTRL);
-		}
-
-		printk("\n");
-	} else {
-		/* Configure IPG for half duplex operation. */
-		printk
-		    ("setting half duplex, no TX flow control, no RX flow control.\n");
-
-		iowrite32(IPG_MC_RSVD_MASK &
-			  (ioread32(ioaddr + IPG_MACCTRL) &
-			   ~IPG_MC_DUPLEX_SELECT_FD &
-			   ~IPG_MC_TX_FLOW_CONTROL_ENABLE &
-			   ~IPG_MC_RX_FLOW_CONTROL_ENABLE),
-			  ioaddr + IPG_MACCTRL);
-	}
-
-	IPG_DEBUG_MSG("G/MII reg 4 (advertisement) = %4.4x\n", advertisement);
-	IPG_DEBUG_MSG("G/MII reg 5 (link partner)  = %4.4x\n",
-		      linkpartner_ability);
-	IPG_DEBUG_MSG("G/MII reg 9 (1000BASE-T control) = %4.4x\n",
-		      advertisement);
-	IPG_DEBUG_MSG("G/MII reg 10 (1000BASE-T status) = %4.4x\n",
-		      linkpartner_ability);
-
-	IPG_DEBUG_MSG("Auto-neg complete, MACCTRL = %8.8x\n",
-		      ioread32(ioaddr + IPG_MACCTRL));
-
-	return 0;
-}
-#else
 static int ipg_config_autoneg(struct net_device *dev)
 {
 	/* Configure IPG based on result of IEEE 802.3 PHY
@@ -1072,7 +607,6 @@
 	return 0;
 }
 
-#endif
 
 static int ipg_io_config(struct net_device *dev)
 {
