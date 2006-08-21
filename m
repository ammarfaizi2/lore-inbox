Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWHUIp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWHUIp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWHUIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:45:28 -0400
Received: from msr52.hinet.net ([168.95.4.152]:15328 "EHLO msr52.hinet.net")
	by vger.kernel.org with ESMTP id S1030389AbWHUIp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:45:26 -0400
Subject: [PATCH] IP1000A: IC Plus update
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Content-Type: text/plain
Date: Mon, 21 Aug 2006 16:32:07 -0400
Message-Id: <1156192327.5852.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All:
I had regenerate this patch from:
git://git.kernel.org/pub/scm/linux/kernel/git/penberg/netdev-ipg-2.6.git

And, submit those modifications as one patch.

From: Jesse Huang <jesse@icplus.com.tw>

Change Logs:
   - update maintainer information
   - remove some default phy params
   - remove threshold config from ipg_io_config
   - ip1000 ipg_config_autoneg rewrite
   - modify coding style of ipg_config_autoneg
   - Add IPG_AC_FIFO flag when Tx reset
   - For compatible at PCI 66MHz issue

Signed-off-by: Jesse Huang <jesse@icplus.com.tw>

Thanks! 

Best Regards,
Jesse Huang

---

 ipg.c |  394 +++++++++++++++--------------------------------------------------
 ipg.h |   96 +---------------
 2 files changed, 92 insertions(+), 398 deletions(-)

8bd0325e52d2578c37cd251aeac2136f7cca9098
diff --git a/ipg.c b/ipg.c
index 754ddb5..7c541c2 100644
--- a/ipg.c
+++ b/ipg.c
@@ -1,18 +1,26 @@
-/*PCI_DEVICE_ID_IP1000
+/*
+ * ipg.c: Device Driver for the IP1000 Gigabit Ethernet Adapter
+ *
+ * Copyright (C) 2003, 2006  IC Plus Corp.
+ *
+ * Original Author:
  *
- * ipg.c
+ *   Craig Rich
+ *   Sundance Technology, Inc.
+ *   1485 Saratoga Avenue
+ *   Suite 200
+ *   San Jose, CA 95129
+ *   408 873 4117
+ *   www.sundanceti.com
+ *   craig_rich@sundanceti.com
  *
- * IC Plus IP1000 Gigabit Ethernet Adapter Linux Driver v2.01
- * by IC Plus Corp. 2003
+ * Current Maintainer:
  *
- * Craig Rich
- * Sundance Technology, Inc.
- * 1485 Saratoga Avenue
- * Suite 200
- * San Jose, CA 95129
- * 408 873 4117
- * www.sundanceti.com
- * craig_rich@sundanceti.com
+ *   Sorbica Shieh.
+ *   10F, No.47, Lane 2, Kwang-Fu RD.
+ *   Sec. 2, Hsin-Chu, Taiwan, R.O.C.
+ *   http://www.icplus.com.tw
+ *   sorbica@icplus.com.tw
  */
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
@@ -476,26 +484,20 @@ static int ipg_config_autoneg(struct net
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
+	long mac_ctrl_value;
 
 	IPG_DEBUG_MSG("_config_autoneg\n");
 
 	asicctrl = ioread32(ioaddr + ASIC_CTRL);
-	phyctrl = ioread8(ioaddr + PHY_CTRL);
+   	phyctrl = ioread8(ioaddr + PHY_CTRL);
+   	mac_ctrl_value = ioread32(ioaddr + MAC_CTRL);
 
 	/* Set flags for use in resolving auto-negotation, assuming
 	 * non-1000Mbps, half duplex, no flow control.
@@ -511,14 +513,13 @@ static int ipg_config_autoneg(struct net
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
@@ -530,283 +531,50 @@ static int ipg_config_autoneg(struct net
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
-		       "%s: Fiber based PHY, setting full duplex, no flow control.\n",
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
+	if (phyctrl & IPG_PC_DUPLEX_STATUS) {
+		fullduplex = 1;
+		txflowcontrol = 1;
+		rxflowcontrol = 1;
+	} else {
+		fullduplex = 0;
+		txflowcontrol = 0;
+		rxflowcontrol = 0;
 	}
 
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
-	}
-
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
+		mac_ctrl_value |= IPG_MC_DUPLEX_SELECT_FD;
 
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr |= ADVERTISE_1000HALF; // Typo ?
+		if (txflowcontrol == 1) {
+			printk("TX flow control");
+			mac_ctrl_value |= IPG_MC_TX_FLOW_CONTROL_ENABLE;
 		} else {
-			fullduplex = 0;
-
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr &= ~ADVERTISE_1000HALF; // Typo ?
+			printk("no TX flow control");
+			mac_ctrl_value &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
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
+			mac_ctrl_value |= IPG_MC_RX_FLOW_CONTROL_ENABLE;
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
-			/* 100BASE-TX half duplex is highest priority. *///Sorbica full duplex ?
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
+			mac_ctrl_value = mac_ctrl_value & ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
 		}
-	}
-
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
 
-		case 0xD:
-			txflowcontrol = 0;
-			rxflowcontrol = 1;
-			break;
+		printk("\n");
+	} else {
+		/* Configure IPG for half duplex operation. */
+	        printk(KERN_INFO "setting half duplex, no TX flow control, no RX flow control.\n");
 
-		default:
-			txflowcontrol = 0;
-			rxflowcontrol = 0;
-		}
+		mac_ctrl_value &= ~IPG_MC_DUPLEX_SELECT_FD & ~IPG_MC_TX_FLOW_CONTROL_ENABLE & ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
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
-#define ADVERTISE_PAUSE_ANY (ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM)
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
+	iowrite32(mac_ctrl_value , ioaddr+MAC_CTRL);
 	return 0;
 }
 
@@ -935,15 +703,7 @@ static int ipg_io_config(struct net_devi
 	ipg_nic_set_multicast_list(dev);
 
 	iowrite16(IPG_MAX_RXFRAME_SIZE, ioaddr + MAX_FRAME_SIZE);
-	iowrite16(IPG_RE_RSVD_MASK & (IPG_RXEARLYTHRESH_VALUE),
-		  ioaddr + RX_EARLY_THRESH);
-	iowrite32(IPG_TT_RSVD_MASK & (IPG_TXSTARTTHRESH_VALUE),
-		  ioaddr + TX_START_THRESH);
-	iowrite32((IPG_RI_RSVD_MASK &
-		   ((IPG_RI_RXFRAME_COUNT & IPG_RXFRAME_COUNT) |
-		    (IPG_RI_PRIORITY_THRESH & (IPG_PRIORITY_THRESH << 12)) |
-		    (IPG_RI_RXDMAWAIT_TIME & (IPG_RXDMAWAIT_TIME << 16)))),
-		  ioaddr + RX_DMA_INT_CTRL);
+
 	iowrite8(IPG_RP_RSVD_MASK & (IPG_RXDMAPOLLPERIOD_VALUE),
 		 ioaddr + RX_DMA_POLL_PERIOD);
 	iowrite8(IPG_RU_RSVD_MASK & (IPG_RXDMAURGENTTHRESH_VALUE),
@@ -1125,10 +885,7 @@ static int init_tfdlist(struct net_devic
 	IPG_DEBUG_MSG("_init_tfdlist\n");
 
 	for (i = 0; i < IPG_TFDLIST_LENGTH; i++) {
-		sp->TFDList[i].TFDNextPtr = cpu_to_le64(sp->TFDListDMAhandle +
-							((sizeof(struct TFD)) *
-							 ((i + 1) %
-							  IPG_TFDLIST_LENGTH)));
+		sp->TFDList[i].TFDNextPtr = 0;
 
 		sp->TFDList[i].TFC = cpu_to_le64(IPG_TFC_TFDDONE);
 		if (sp->TxBuff[i] != NULL)
@@ -1146,6 +903,7 @@ static int init_tfdlist(struct net_devic
 	iowrite32((u32) (sp->TFDListDMAhandle), ioaddr + TFD_LIST_PTR_0);
 	iowrite32(0x00000000, ioaddr + TFD_LIST_PTR_1);
 
+	sp->ResetCurrentTFD=1;
 	return 0;
 }
 
@@ -1158,6 +916,7 @@ static void ipg_nic_txfree(struct net_de
 	struct ipg_nic_private *sp = netdev_priv(dev);
 	int NextToFree;
 	int maxtfdcount;
+	long CurrentTxTFDPtr=(ioread32(ipg_ioaddr(dev)+TFD_LIST_PTR_0)-(long)sp->TFDListDMAhandle)/(long)sizeof(struct TFD);
 
 	IPG_DEBUG_MSG("_nic_txfree\n");
 
@@ -1180,8 +939,10 @@ static void ipg_nic_txfree(struct net_de
 		 * If the TFDDone bit is set, free the associated
 		 * buffer.
 		 */
-		if ((le64_to_cpu(sp->TFDList[NextToFree].TFC) &
-		     IPG_TFC_TFDDONE) && (NextToFree != sp->CurrentTFD)) {
+		if((NextToFree != sp->CurrentTFD)&&(NextToFree!=CurrentTxTFDPtr))
+		{
+			//JesseAdd: setup TFDDONE for compatible issue.
+			sp->TFDList[NextToFree].TFC = cpu_to_le64(sp->TFDList[NextToFree].TFC|IPG_TFC_TFDDONE);
 			/* Free the transmit buffer. */
 			if (sp->TxBuff[NextToFree] != NULL) {
 				pci_unmap_single(sp->pdev,
@@ -1204,6 +965,15 @@ static void ipg_nic_txfree(struct net_de
 		maxtfdcount--;
 
 	} while (maxtfdcount != 0);
+	if(sp->LastTFDHoldCnt>1000) {
+		sp->LastTFDHoldCnt=0;
+		ipg_reset(dev, IPG_AC_TX_RESET | IPG_AC_DMA | IPG_AC_NETWORK | IPG_AC_FIFO);
+		// Re-configure after DMA reset. 
+		if ((ipg_io_config(dev) < 0) ||(init_tfdlist(dev) < 0)) {
+			printk(KERN_INFO"%s: Error during re-configuration.\n",dev->name);
+		}
+		iowrite32(IPG_MC_RSVD_MASK & (ioread32(ipg_ioaddr(dev) + MAC_CTRL) | IPG_MC_TX_ENABLE),ipg_ioaddr(dev) + MAC_CTRL);
+	}	
 }
 
 /*
@@ -1275,7 +1045,7 @@ static void ipg_nic_txcleanup(struct net
 				IPG_DEBUG_MSG("Transmitter underrun.\n");
 				sp->stats.tx_fifo_errors++;
 				ipg_reset(dev, IPG_AC_TX_RESET |
-					  IPG_AC_DMA | IPG_AC_NETWORK);
+					  IPG_AC_DMA | IPG_AC_NETWORK| IPG_AC_FIFO);
 
 				/* Re-configure after DMA reset. */
 				if ((ipg_io_config(dev) < 0) ||
@@ -2280,10 +2050,17 @@ static int ipg_nic_hard_start_xmit(struc
 	 * counter, modulus the length of the TFDList.
 	 */
 	NextTFD = (sp->CurrentTFD + 1) % IPG_TFDLIST_LENGTH;
+	if(sp->ResetCurrentTFD!=0)
+	{
+		sp->ResetCurrentTFD=0;
+		NextTFD=0;	
+	}
+	/* Check for availability of next TFD. Reserve 1 for not become ring*/
+	if (NextTFD == sp->LastFreedTxBuff) {
+		
+		if(sp->LastTFDHoldAddr==sp->CurrentTFD) sp->LastTFDHoldCnt++;
+		else {sp->LastTFDHoldAddr=sp->CurrentTFD;sp->LastTFDHoldCnt=0;}
 
-	/* Check for availability of next TFD. */
-	if (!(le64_to_cpu(sp->TFDList[NextTFD].TFC) &
-	      IPG_TFC_TFDDONE) || (NextTFD == sp->LastFreedTxBuff)) {
 		IPG_DEBUG_MSG("Next TFD not available.\n");
 
 		/* Attempt to free any used TFDs. */
@@ -2297,8 +2074,11 @@ #ifdef IPG_DEBUG
 		sp->TFDunavailCount++;
 #endif
 
+		iowrite32(IPG_DC_RSVD_MASK & (IPG_DC_TX_DMA_POLL_NOW),ioaddr + DMA_CTRL);
 		return -ENOMEM;
 	}
+	
+	sp->TFDList[NextTFD].TFDNextPtr=0;
 
 	sp->TxBuffDMAhandle[NextTFD].len = skb->len;
 	sp->TxBuffDMAhandle[NextTFD].dmahandle =
@@ -2390,6 +2170,8 @@ #endif
 	 * for transfer to the IPG.
 	 */
 	sp->TFDList[NextTFD].TFC &= cpu_to_le64(~IPG_TFC_TFDDONE);
+	sp->TFDList[sp->CurrentTFD].TFDNextPtr=cpu_to_le64(sp->TFDListDMAhandle+
+sizeof(struct TFD)*NextTFD);
 
 	/* Record frame transmit start time (jiffies = Linux
 	 * kernel current time stamp).
diff --git a/ipg.h b/ipg.h
index 58b1417..9688483 100644
--- a/ipg.h
+++ b/ipg.h
@@ -80,14 +80,11 @@ enum ipg_regs {
 	RX_DMA_BURST_THRESH	= 0x24,
 	RX_DMA_URGENT_THRESH	= 0x25,
 	RX_DMA_POLL_PERIOD	= 0x26,
-	RX_DMA_INT_CTRL		= 0x28,
 	DEBUG_CTRL		= 0x2c,
 	ASIC_CTRL		= 0x30,
 	FIFO_CTRL		= 0x38, // Unused
-	RX_EARLY_THRESH		= 0x3a,
 	FLOW_OFF_THRESH		= 0x3c,
 	FLOW_ON_THRESH		= 0x3e,
-	TX_START_THRESH		= 0x44,
 	EEPROM_DATA		= 0x48,
 	EEPROM_CTRL		= 0x4a,
 	EXPROM_ADDR		= 0x4c, // Unused
@@ -324,12 +321,6 @@ #define IPG_RU_RSVD_MASK                
 /* RxDMAPollPeriod */
 #define IPG_RP_RSVD_MASK                0xFF
 
-/* TxStartThresh */
-#define IPG_TT_RSVD_MASK                0x0FFF
-
-/* RxEarlyThresh */
-#define IPG_RE_RSVD_MASK                0x07FF
-
 /* ReceiveMode */
 #define IPG_RM_RSVD_MASK                0x3F
 #define IPG_RM_RECEIVEUNICAST           0x01
@@ -496,12 +487,6 @@ #define IPG_MC_RX_DISABLE               
 #define IPG_MC_RX_ENABLED               0x20000000
 #define IPG_MC_PAUSED                   0x40000000
 
-/* RxDMAIntCtrl */
-#define IPG_RI_RSVD_MASK                0xFFFF1CFF
-#define IPG_RI_RXFRAME_COUNT            0x000000FF
-#define IPG_RI_PRIORITY_THRESH          0x00001C00
-#define IPG_RI_RXDMAWAIT_TIME           0xFFFF0000
-
 /*
  *	Tune
  */
@@ -662,32 +647,11 @@ #define		IPG_MAXRFDPROCESS_COUNT	0x80
  */
 #define		IPG_MINUSEDRFDSTOFREE	0x80
 
-/* Specify priority threshhold for a RxDMAPriority interrupt. */
-#define		IPG_PRIORITY_THRESH		0x07
-
-/* Specify the number of receive frames transferred via DMA
- * before a RX interrupt is issued.
- */
-#define		IPG_RXFRAME_COUNT		0x08
-
 /* specify the jumbo frame maximum size
  * per unit is 0x600 (the RxBuffer size that one RFD can carry)
  */
 #define     MAX_JUMBOSIZE	        0x8	// max is 12K
 
-/* Specify the maximum amount of time (in 64ns increments) to wait
- * before issuing a RX interrupt if number of frames received
- * is less than IPG_RXFRAME_COUNT.
- *
- * Value	Time
- * -------------------
- * 0x3D09	~1ms
- * 0x061A	~100us
- * 0x009C	~10us
- * 0x000F	~1us
- */
-#define		IPG_RXDMAWAIT_TIME		0x009C
-
 /* Key register values loaded at driver start up. */
 
 /* TXDMAPollPeriod is specified in 320ns increments.
@@ -700,7 +664,6 @@ #define		IPG_RXDMAWAIT_TIME		0x009C
  * 0xFF		~82us
  */
 #define		IPG_TXDMAPOLLPERIOD_VALUE	0x26
-#define		IPG_TXSTARTTHRESH_VALUE	0x0FFF
 
 /* TxDMAUrgentThresh specifies the minimum amount of
  * data in the transmit FIFO before asserting an
@@ -737,7 +700,6 @@ #define		IPG_TXDMABURSTTHRESH_VALUE	0x30
  * 0xFF		~82us
  */
 #define		IPG_RXDMAPOLLPERIOD_VALUE	0x01
-#define		IPG_RXEARLYTHRESH_VALUE	0x07FF
 
 /* RxDMAUrgentThresh specifies the minimum amount of
  * free space within the receive FIFO before asserting
@@ -872,7 +834,9 @@ #endif
 
 	struct mutex		mii_mutex;
 	struct mii_if_info	mii_if;
-
+	long LastTFDHoldAddr;
+	int  LastTFDHoldCnt;
+	int ResetCurrentTFD;
 #ifdef IPG_DEBUG
 	int TFDunavailCount;
 	int RFDlistendCount;
@@ -919,59 +883,7 @@ unsigned short DefaultPhyParam[] = {
 	// 01/09/04 IP1000A v1-5 rev=0x41
 	(0x4100 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
 	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x42
-	(0x4200 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x43
-	(0x4300 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x44
-	(0x4400 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x45
-	(0x4500 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x46
-	(0x4600 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x47
-	(0x4700 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x48
-	(0x4800 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x49
-	(0x4900 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x4A
-	(0x4A00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x4B
-	(0x4B00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x4C
-	(0x4C00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x4D
-	(0x4D00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
-	// 01/09/04 IP1000A v1-5 rev=0x4E
-	(0x4E00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
-	    0x0000,
-	30, 0x005e, 9, 0x0700,
+	30, 0x005e, 9, 0x0700,	
 	0x0000
 };
 
-- 
1.3.GIT



