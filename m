Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWE3VdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWE3VdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWE3VdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:33:06 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:14780 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932490AbWE3VdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:33:03 -0400
Date: Tue, 30 May 2006 23:29:38 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: =?unknown-8bit?B?amVzc2Uo5bu66IiIKQ==?= <jesse@icplus.com.tw>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Andrew Morton <akpm@osdl.org>,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: Sign-off for the IP1000A driver before inclusion
Message-ID: <20060530212938.GA27761@electric-eye.fr.zoreil.com>
References: <84144f020605230001s32b29f59w8f95c67fad7b380d@mail.gmail.com> <044a01c67ef8$9bdd0420$4964a8c0@icplus.com.tw> <Pine.LNX.4.58.0605240911400.26629@sbz-30.cs.Helsinki.FI> <021f01c683b0$34b5cbd0$4964a8c0@icplus.com.tw> <Pine.LNX.4.58.0605300915400.18933@sbz-30.cs.Helsinki.FI> <20060529234610.e5671e4c.akpm@osdl.org> <Pine.LNX.4.58.0605301024440.22126@sbz-30.cs.Helsinki.FI> <026801c683c8$e3f63860$4964a8c0@icplus.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <026801c683c8$e3f63860$4964a8c0@icplus.com.tw>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse\(建興\) <jesse@icplus.com.tw> :
[...]

> --Remove Threshold comfig and RxDMAInt from ipg_io_config(). Remove relative
> define form ipg.h

Naïve question: why ?

Hardware assisted Rx irq mitigation is cool (TM).

> --Remove and Rewrite ipg_config_autoneg() function.

- Is there any hardware reason why the bits in MAC_CTRL are set one (*1*) at
  a time through repeated use of iowrite32(ioread32(ioaddr+MAC_CTRL), ...) ?

  I already changed it in a7302ea588bccc3df88bc8162af8b4d4acd0e380 so I
  wonder if it was reverted by accident or not.

- The rewrite messed up the codingstyle (switch/case + some spaces/tabs +
  see below)
[...]
        struct ipg_nic_private* sp=netdev_priv(dev);
        void __iomem *ioaddr = sp->ioaddr;
        u8				phyctrl;
        u32				asicctrl;
        int                             fiber;
        int                             gig;
        int                             fullduplex;
        int                             txflowcontrol;
        int                             rxflowcontrol;
[...]
	/* Configure full duplex, and flow control. */
	if (fullduplex == 1)
	{
		/* Configure IPG for full duplex operation. */
        printk(KERN_INFO "setting full duplex, ");

		iowrite32(ioread32(ioaddr+MAC_CTRL) |IPG_MC_DUPLEX_SELECT_FD,ioaddr+MAC_CTRL);

		if (txflowcontrol == 1)
		{
        	printk("TX flow control");
		iowrite32(ioread32(ioaddr+MAC_CTRL) |IPG_MC_TX_FLOW_CONTROL_ENABLE,ioaddr+MAC_CTRL);
		} else
		{

- At the top of ipg_config_autoneg(), I noticed that:

        phyctrl =  ioread8(ioaddr + PHY_CTRL);

  turned into:

        phyctrl =  ioread32(ioaddr +PHY_CTRL);

  I changed it back to ioread8() since that's what the driver uses everywhere
  else when reading PHY_CTRL. Is it correct ?

Updated patch against fe0dd7dcecf6fbcc3b34099e064f7c0065caef71 below.
The patch has not been committed in the git tree so far.


diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 754ddb5..fe6ea02 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -5,6 +5,7 @@
  * IC Plus IP1000 Gigabit Ethernet Adapter Linux Driver v2.01
  * by IC Plus Corp. 2003
  *
+ * Initiator:
  * Craig Rich
  * Sundance Technology, Inc.
  * 1485 Saratoga Avenue
@@ -13,6 +14,14 @@
  * 408 873 4117
  * www.sundanceti.com
  * craig_rich@sundanceti.com
+ *
+ * Current Maintainer:
+ * Sorbica Shieh.
+ * 10F, No.47, Lane 2, Kwang-Fu RD.
+ * Sec. 2, Hsin-Chu, Taiwan, R.O.C.
+ * http://www.icplus.com.tw
+ * sorbica@icplus.com.tw
+ * Signed-off-by: Sorbica Shieh <sorbica@icplus.com.tw>
  */
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
@@ -478,13 +487,6 @@ static int ipg_config_autoneg(struct net
 	void __iomem *ioaddr = sp->ioaddr;
 	u32 asicctrl;
 	u32 mac_ctl;
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
@@ -511,14 +513,12 @@ static int ipg_config_autoneg(struct net
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
 		sp->tenmbpsmode = 1;
 		break;
 	case IPG_PC_LINK_SPEED_100MBPS:
@@ -530,282 +530,49 @@ static int ipg_config_autoneg(struct net
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
+		fullduplex    = 1;
+		txflowcontrol = 1;
+		rxflowcontrol = 1;
 	}
 
-	fiber = ipg_tmi_fiber_detect(dev, phyaddr);
+	mac_ctl = ioread32(ioaddr + MAC_CTRL);
 
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
+		mac_ctl |= IPG_MC_DUPLEX_SELECT_FD;
 
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr |= ADVERTISE_1000HALF; // Typo ?
+		if (txflowcontrol == 1) {
+			printk("TX flow control");
+			mac_ctl |= IPG_MC_TX_FLOW_CONTROL_ENABLE;
 		} else {
-			fullduplex = 0;
-
-			/* In 1000BASE-X using IPG's internal PCS
-			 * layer, so write to the GMII duplex bit.
-			 */
-			bmcr &= ~ADVERTISE_1000HALF; // Typo ?
+			printk("no TX flow control");
+			mac_ctl &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
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
+			mac_ctl |= IPG_MC_RX_FLOW_CONTROL_ENABLE;
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
-		}
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
+			printk(", no RX flow control.");
+			mac_ctl &= ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
 		}
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
+		printk("\n");
+	} else {
+		/* Configure IPG for half duplex operation. */
+	        printk(KERN_INFO "setting half duplex, no TX flow control, no RX flow control.\n");
 
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
+		mac_ctl &= ~IPG_MC_DUPLEX_SELECT_FD;
+		mac_ctl &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
+		mac_ctl &= ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
 	}
-
-	iowrite32(IPG_MC_RSVD_MASK & mac_ctl, ioaddr + MAC_CTRL);
+	iowrite32(mac_ctl, ioaddr + MAC_CTRL);
 
 	return 0;
 }
@@ -935,15 +702,7 @@ static int ipg_io_config(struct net_devi
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
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index 58b1417..47065e7 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
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
@@ -324,11 +321,7 @@ #define IPG_RU_RSVD_MASK                
 /* RxDMAPollPeriod */
 #define IPG_RP_RSVD_MASK                0xFF
 
-/* TxStartThresh */
-#define IPG_TT_RSVD_MASK                0x0FFF
 
-/* RxEarlyThresh */
-#define IPG_RE_RSVD_MASK                0x07FF
 
 /* ReceiveMode */
 #define IPG_RM_RSVD_MASK                0x3F
@@ -496,11 +489,6 @@ #define IPG_MC_RX_DISABLE               
 #define IPG_MC_RX_ENABLED               0x20000000
 #define IPG_MC_PAUSED                   0x40000000
 
-/* RxDMAIntCtrl */
-#define IPG_RI_RSVD_MASK                0xFFFF1CFF
-#define IPG_RI_RXFRAME_COUNT            0x000000FF
-#define IPG_RI_PRIORITY_THRESH          0x00001C00
-#define IPG_RI_RXDMAWAIT_TIME           0xFFFF0000
 
 /*
  *	Tune
@@ -662,32 +650,16 @@ #define		IPG_MAXRFDPROCESS_COUNT	0x80
  */
 #define		IPG_MINUSEDRFDSTOFREE	0x80
 
-/* Specify priority threshhold for a RxDMAPriority interrupt. */
-#define		IPG_PRIORITY_THRESH		0x07
-
 /* Specify the number of receive frames transferred via DMA
  * before a RX interrupt is issued.
  */
-#define		IPG_RXFRAME_COUNT		0x08
 
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
+/
 /* Key register values loaded at driver start up. */
 
 /* TXDMAPollPeriod is specified in 320ns increments.
@@ -700,7 +672,6 @@ #define		IPG_RXDMAWAIT_TIME		0x009C
  * 0xFF		~82us
  */
 #define		IPG_TXDMAPOLLPERIOD_VALUE	0x26
-#define		IPG_TXSTARTTHRESH_VALUE	0x0FFF
 
 /* TxDMAUrgentThresh specifies the minimum amount of
  * data in the transmit FIFO before asserting an
@@ -737,7 +708,6 @@ #define		IPG_TXDMABURSTTHRESH_VALUE	0x30
  * 0xFF		~82us
  */
 #define		IPG_RXDMAPOLLPERIOD_VALUE	0x01
-#define		IPG_RXEARLYTHRESH_VALUE	0x07FF
 
 /* RxDMAUrgentThresh specifies the minimum amount of
  * free space within the receive FIFO before asserting
@@ -905,6 +875,7 @@ struct nic_id nics_supported[] = {
 
 //variable record -- index by leading revision/length
 //Revision/Length(=N*4), Address1, Data1, Address2, Data2,...,AddressN,DataN
+//VIOLET20060530SUPPORT_BEF_42
 unsigned short DefaultPhyParam[] = {
 	// 11/12/03 IP1000A v1-3 rev=0x40
 	/*--------------------------------------------------------------------------
@@ -920,58 +891,6 @@ unsigned short DefaultPhyParam[] = {
 	(0x4100 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002, 27, 0xeb8e, 31,
 	    0x0000,
 	30, 0x005e, 9, 0x0700,
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
 	0x0000
 };
 
