Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292970AbSB0V43>; Wed, 27 Feb 2002 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292993AbSB0VzH>; Wed, 27 Feb 2002 16:55:07 -0500
Received: from adsl-64-123-56-158.dsl.stlsmo.swbell.net ([64.123.56.158]:1921
	"EHLO bigandy.naclos.org") by vger.kernel.org with ESMTP
	id <S292984AbSB0VyO>; Wed, 27 Feb 2002 16:54:14 -0500
Date: Wed, 27 Feb 2002 15:54:09 -0600 (CST)
From: Andy Carlson <naclos@swbell.net>
X-X-Sender: <naclos@bigandy.naclos.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Patch: 2.4.18 via-rhine
Message-ID: <Pine.LNX.4.33.0202271552310.978-100000@bigandy.naclos.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took Urban Widmark's via-rhine patch for 2.4.17 that fixed my rhine
interface, and made it apply to 2.4.18.

Andy Carlson                                    |\      _,,,---,,_
naclos@swbell.net                         ZZZzz /,`.-'`'    -.  ;-;;,_
Cat Pics: http://andyc.dyndns.org/animal.html  |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                           '---''(_/--'  `-'\_)

--- linux-2.4.18-orig/drivers/net/via-rhine.c	Mon Feb 25 13:38:00 2002
+++ linux-2.4.18-rhine/drivers/net/via-rhine.c	Wed Feb 27 15:17:40 2002
@@ -91,7 +91,7 @@
 /* A few user-configurable values.
    These may be modified when a driver module is loaded. */

-static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
+static int debug = 3;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 static int max_interrupt_work = 20;

 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
@@ -329,7 +329,7 @@

 enum chip_capability_flags {
 	CanHaveMII=1, HasESIPhy=2, HasDavicomPhy=4,
-	ReqTxAlign=0x10, HasWOL=0x20, };
+	ReqTxAlign=0x10, HasWOL=0x20, HasIntTxUnderFlow=0x40, };

 #ifdef USE_MEM
 #define RHINE_IOTYPE (PCI_USES_MEM | PCI_USES_MASTER | PCI_ADDR1)
@@ -343,11 +343,13 @@
 	{ "VIA VT86C100A Rhine", RHINE_IOTYPE, 128,
 	  CanHaveMII | ReqTxAlign },
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
-	  CanHaveMII | HasWOL },
+	  CanHaveMII | HasWOL | HasIntTxUnderFlow },
 	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
 	  CanHaveMII | ReqTxAlign }
 };

+#define MII_DAVICOM_DM9101		0x0181b800
+
 static struct pci_device_id via_rhine_pci_tbl[] __devinitdata =
 {
 	{0x1106, 0x6100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
@@ -384,27 +386,14 @@
 	IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
 	IntrTxDone=0x0002, IntrTxAbort=0x0008, IntrTxUnderrun=0x0010,
 	IntrPCIErr=0x0040,
-	IntrStatsMax=0x0080, IntrRxEarly=0x0100, IntrMIIChange=0x0200,
+	IntrStatsMax=0x0080, IntrRxEarly=0x0100,
+	IntrMIIChange=0x0200, IntrTxUnderflow=0x0200,	/* see HasIntTxUnderFlow */
 	IntrRxOverflow=0x0400, IntrRxDropped=0x0800, IntrRxNoBuf=0x1000,
 	IntrTxAborted=0x2000, IntrLinkChange=0x4000,
 	IntrRxWakeUp=0x8000,
 	IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
 };

-/* MII interface, status flags.
-   Not to be confused with the MIIStatus register ... */
-enum mii_status_bits {
-	MIICap100T4			= 0x8000,
-	MIICap10100HdFd		= 0x7800,
-	MIIPreambleSupr		= 0x0040,
-	MIIAutoNegCompleted	= 0x0020,
-	MIIRemoteFault		= 0x0010,
-	MIICapAutoNeg		= 0x0008,
-	MIILink				= 0x0004,
-	MIIJabber			= 0x0002,
-	MIIExtended			= 0x0001
-};
-
 /* The Rx and Tx buffer descriptors. */
 struct rx_desc {
 	s32 rx_status;
@@ -464,6 +453,7 @@

 	/* Frequently used values: keep some adjacent for cache effect. */
 	int chip_id, drv_flags;
+	u8 rev_id;
 	struct rx_desc *rx_head_desc;
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
@@ -480,14 +470,14 @@
 	u16 advertising;					/* NWay media advertisement */
 	unsigned char phys[MAX_MII_CNT];			/* MII device addresses. */
 	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
-	u16 mii_status;						/* last read MII status */
+	u32 mii;
 	struct mii_if_info mii_if;
 };

 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  via_rhine_open(struct net_device *dev);
-static void via_rhine_check_duplex(struct net_device *dev);
+static int via_rhine_check_duplex(struct net_device *dev);
 static void via_rhine_timer(unsigned long data);
 static void via_rhine_tx_timeout(struct net_device *dev);
 static int  via_rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
@@ -679,19 +669,32 @@
 		goto err_out_unmap;
 	}

+	/* "3065" specials ... */
 	if (chip_id == VT6102) {
+		u8 mode3_reg;
 		/*
 		 * for 3065D, EEPROM reloaded will cause bit 0 in MAC_REG_CFGA
 		 * turned on.  it makes MAC receive magic packet
 		 * automatically. So, we turn it off. (D-Link)
 		 */
-		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+ 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+
+                /*
+                * turn on bit2 in PCI configuration register 0x53 ("PCI_REG_MOD
+E3")
+                * 0x04 == MODE3_MIION
+                * FIXME: what does this do?
+                */
+               pci_read_config_byte(pdev, 0x53, &mode3_reg);
+               pci_write_config_byte(pdev, 0x53, mode3_reg | 0x04);
+
 	}

 	dev->irq = pdev->irq;

 	np = dev->priv;
 	spin_lock_init (&np->lock);
+        pci_read_config_byte(pdev, PCI_REVISION_ID, &(np->rev_id));
 	np->chip_id = chip_id;
 	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
 	np->pdev = pdev;
@@ -733,8 +736,9 @@
 	if (i)
 		goto err_out_unmap;

-	printk(KERN_INFO "%s: %s at 0x%lx, ",
+        printk(KERN_INFO "%s: %s (rev 0x%02x) at 0x%lx, ",
 		   dev->name, via_rhine_chip_info[chip_id].name,
+                   np->rev_id,
 		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);

 	for (i = 0; i < 5; i++)
@@ -747,23 +751,30 @@
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
 		for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
+			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
-				np->mii_if.advertising = mdio_read(dev, phy, 4);
-				printk(KERN_INFO "%s: MII PHY found at address %d, status "
+                                np->advertising = mdio_read(dev, phy, MII_ADVERTISE);
+                                np->mii = (mdio_read(dev, phy, MII_PHYSID1) << 16) +
+                                        mdio_read(dev, phy, MII_PHYSID2);
+                                printk(KERN_INFO "%s: MII PHY %8.8x found at add
+ress %d, status "
+
 					   "0x%4.4x advertising %4.4x Link %4.4x.\n",
-					   dev->name, phy, mii_status, np->mii_if.advertising,
-					   mdio_read(dev, phy, 5));
+                                           dev->name, np->mii, phy, mii_status, np->advertising,
+                                           mdio_read(dev, phy, MII_LPA));

-				/* set IFF_RUNNING */
-				if (mii_status & MIILink)
-					netif_carrier_on(dev);
-				else
-					netif_carrier_off(dev);
+                                if ((np->mii & ~0xf) == MII_DAVICOM_DM9101)
+                                        np->drv_flags |= HasDavicomPhy;
 			}
 		}
 		np->mii_cnt = phy_idx;
+                if (phy_idx == 0) {
+                        printk(KERN_WARNING "%s: MII PHY not found -- this devic
+e may "
+                                   "not operate correctly.\n", dev->name);
+                }
+
 		np->mii_if.phy_id = np->phys[0];
 	}

@@ -773,15 +784,14 @@
 			np->mii_if.full_duplex = 1;
 		np->default_port = option & 0x3ff;
 		if (np->default_port & 0x330) {
-			/* FIXME: shouldn't someone check this variable? */
-			/* np->medialock = 1; */
 			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
 				   (option & 0x300 ? 100 : 10),
 				   (option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
-				mdio_write(dev, np->phys[0], 0,
-						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
-						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
+                                mdio_write(dev, np->phys[0], MII_BMCR,
+                                                   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps */
+                                                   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex */
+
 		}
 	}

@@ -962,10 +972,27 @@
 	for (i = 0; i < 6; i++)
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);

-	/* Initialize other registers. */
+        /* Turn on bit3 (OFSET) in TCR during MAC initialization. */
+        writeb(readb(ioaddr + TxConfig) | 0x08, ioaddr + TxConfig);
+
+        /* Turn off mauto */
+        writeb(readb(ioaddr + MIICmd) & 0x7f, ioaddr + MIICmd);
+        if (np->drv_flags & HasDavicomPhy)  {
+                udelay(100);
+        } else {
+                int boguscnt = 0x3fff;
+                while (!(readb(ioaddr + MIIRegAddr) & 0x80) && --boguscnt > 0)
+                        ;
+        }
+
 	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
+
+        /* Clear the lower 4 bits in Config D. */
+        outb(inb(ioaddr + ConfigD) & 0xf0, ioaddr + ConfigD);
+
+
 	/* Configure the FIFO thresholds. */
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
+	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold */
 	np->tx_thresh = 0x20;
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */

@@ -988,13 +1015,33 @@
 		np->chip_cmd |= CmdFDuplex;
 	writew(np->chip_cmd, ioaddr + ChipCmd);

+        /* Restart MII auto-negotiation for davidcom phy bug */
+        if (np->drv_flags & HasDavicomPhy) {
+                mdio_write(dev,np->phys[0], MII_BMCR,
+                                   mdio_read(dev, np->phys[0], MII_BMCR) | 0x1200);
+                /* FIXME: shouldn't we wait for it to complete? Adding silly-delay. */
+                udelay(100);
+        }
+
+
 	via_rhine_check_duplex(dev);

 	/* The LED outputs of various MII xcvrs should be configured.  */
+        /* For Davicom phys, turn on bit 5 in register 0x16. */
 	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
 	/* For ESI phys, turn on bit 7 in register 0x17. */
-	mdio_write(dev, np->phys[0], 0x17, mdio_read(dev, np->phys[0], 0x17) |
-			   (np->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
+        if (np->drv_flags & HasDavicomPhy) {
+                mdio_write(dev, np->phys[0], 0x16,
+                                   mdio_read(dev, np->phys[0], 0x16) | 0x20);
+        } else if (np->drv_flags & HasESIPhy) {
+                mdio_write(dev, np->phys[0], 0x17,
+                                   mdio_read(dev, np->phys[0], 0x17) | 0x80);
+        } else {
+                /* All unknowns get this. Could be a problem. */
+                mdio_write(dev, np->phys[0], 0x17,
+                                   mdio_read(dev, np->phys[0], 0x17) | 0x01);
+        }
+
 }
 /* Read and write over the MII Management Data I/O (MDIO) interface. */

@@ -1089,29 +1136,70 @@
 	return 0;
 }

-static void via_rhine_check_duplex(struct net_device *dev)
+static int via_rhine_check_duplex(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	int mii_lpa = mdio_read(dev, np->phys[0], MII_LPA);
-	int negotiated = mii_lpa & np->mii_if.advertising;
+	int mii_reg;
 	int duplex;
+	int changed = 0;
+
+        mii_reg = mdio_read(dev, np->phys[0], MII_BMSR);
+        if (mii_reg == 0xffff)
+                return changed;
+
+        if (debug > 3)
+                printk(KERN_DEBUG "%s: MII #%d reports: %4.4x, carrier is: %d\n",
+                           dev->name, np->phys[0], mii_reg, netif_carrier_ok(dev));
+        if (!(mii_reg & BMSR_LSTATUS)) {
+                if (netif_carrier_ok(dev)) {
+                        if (debug > 1)
+                                printk(KERN_DEBUG "%s: MII #%d reports no link. Disabling watchdog.\n",
+                                           dev->name, np->phys[0]);
+                        netif_carrier_off(dev);
+                }
+        } else if (!netif_carrier_ok(dev)) {
+                if (debug > 1)
+                        printk(KERN_DEBUG "%s: MII #%d link is back. Enabling watchdog.\n",
+                                   dev->name, np->phys[0]);
+                netif_carrier_on(dev);
+        }
+
+        if (np->drv_flags & HasDavicomPhy) {
+                /* If the link partner doesn't support autonegotiation
+                 * the MII detects it's abilities with the "parallel detection".
+                 * Some MIIs update the LPA register to the result of the parallel
+                 * detection, some don't.
+                 * The Davicom PHY [at least 0181b800] doesn't.
+                 * Instead bit 8 and 13 of the BMCR are updated to the result
+                 * of the negotiation..
+                 */
+                mii_reg = mdio_read(dev, np->phys[0], MII_BMCR);
+                duplex = mii_reg & 0x100;
+        } else {
+                int negotiated;
+                mii_reg = mdio_read(dev, np->phys[0], MII_LPA);
+                negotiated = mii_reg & np->advertising;
+
+                duplex = (negotiated & 0x0100) || ((negotiated & 0x02C0) == 0x0040);
+        }

-	if (np->mii_if.duplex_lock  ||  mii_lpa == 0xffff)
-		return;
-	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
+	if (np->mii_if.duplex_lock  ||  mii_reg == 0xffff)
+		return changed;
 	if (np->mii_if.full_duplex != duplex) {
 		np->mii_if.full_duplex = duplex;
+		changed = 1;
 		if (debug)
 			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d link"
 				   " partner capability of %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", np->phys[0], mii_lpa);
+				   duplex ? "full" : "half", np->phys[0], mii_reg);
 		if (duplex)
 			np->chip_cmd |= CmdFDuplex;
 		else
 			np->chip_cmd &= ~CmdFDuplex;
 		writew(np->chip_cmd, ioaddr + ChipCmd);
 	}
+	return changed;
 }


@@ -1121,7 +1209,6 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int next_tick = 10*HZ;
-	int mii_status;

 	if (debug > 3) {
 		printk(KERN_DEBUG "%s: VIA Rhine monitor tick, status %4.4x.\n",
@@ -1129,19 +1216,8 @@
 	}

 	spin_lock_irq (&np->lock);
-
 	via_rhine_check_duplex(dev);

-	/* make IFF_RUNNING follow the MII status bit "Link established" */
-	mii_status = mdio_read(dev, np->phys[0], MII_BMSR);
-	if ( (mii_status & MIILink) != (np->mii_status & MIILink) ) {
-		if (mii_status & MIILink)
-			netif_carrier_on(dev);
-		else
-			netif_carrier_off(dev);
-	}
-	np->mii_status = mii_status;
-
 	spin_unlock_irq (&np->lock);

 	np->timer.expires = jiffies + next_tick;
@@ -1259,6 +1335,8 @@
 	long ioaddr;
 	u32 intr_status;
 	int boguscnt = max_interrupt_work;
+        struct netdev_private *np = dev->priv;
+        int underflow = np->drv_flags & HasIntTxUnderFlow ? IntrTxUnderflow : 0;

 	ioaddr = dev->base_addr;

@@ -1275,7 +1353,7 @@
 			via_rhine_rx(dev);

 		if (intr_status & (IntrTxDone | IntrTxAbort | IntrTxUnderrun |
-						   IntrTxAborted))
+						   IntrTxAborted | underflow))
 			via_rhine_tx(dev);

 		/* Abnormal error summary/uncommon events handlers. */
@@ -1323,7 +1401,13 @@
 			if (txstatus & 0x0100) np->stats.tx_aborted_errors++;
 			if (txstatus & 0x0080) np->stats.tx_heartbeat_errors++;
 			if (txstatus & 0x0002) np->stats.tx_fifo_errors++;
+
 			/* Transmitter restarted in 'abnormal' handler. */
+                        if (txstatus & 0x0900) {
+                                /* FIXME: also update TxRingPtr ??? */
+                                np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
+                        }
+
 		} else {
 			np->stats.collisions += (txstatus >> 3) & 15;
 			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
@@ -1465,30 +1549,46 @@
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+        int mii       = np->drv_flags & HasIntTxUnderFlow ? 0 : IntrMIIChange;
+        int underflow = np->drv_flags & HasIntTxUnderFlow ? IntrTxUnderflow : 0;

 	spin_lock (&np->lock);

-	if (intr_status & (IntrMIIChange | IntrLinkChange)) {
+        if (intr_status & (mii | IntrLinkChange)) {
+                int changed;
+                if (debug)
+                        printk(KERN_DEBUG "%s: Link change, status=%4.4x\n",
+                           dev->name, intr_status);
 		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
 			if (np->drv_flags & HasDavicomPhy)
 				mdio_write(dev, np->phys[0], MII_BMCR, 0x3300);
+                        /* Will the new link status be reported late? */
+                        changed = 0;
+
 		} else
-			via_rhine_check_duplex(dev);
-		if (debug)
+                        changed = via_rhine_check_duplex(dev);
+                if (debug && changed)
+
 			printk(KERN_ERR "%s: MII status changed: Autonegotiation "
 				   "advertising %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, np->phys[0], MII_ADVERTISE),
-			   mdio_read(dev, np->phys[0], MII_LPA));
+                           mdio_read(dev, np->phys[0], MII_ADVERTISE),
+                           mdio_read(dev, np->phys[0], MII_LPA));
+
 	}
 	if (intr_status & IntrStatsMax) {
 		np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
 		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
-	if (intr_status & IntrTxAbort) {
+        if (intr_status & (underflow | IntrTxAbort)) {
+
 		/* Stats counted in Tx-done handler, just restart Tx. */
 		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+                if (debug > 1)
+                        printk(KERN_INFO "%s: Transmitter underflow?, status %4.4x.\n",
+                                   dev->name, intr_status);
+
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
@@ -1497,8 +1597,7 @@
 			printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "
 				   "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);
 	}
-	if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
-						  IntrTxAbort | IntrTxAborted))) {
+        if ((intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxAborted))) {
 		if (debug > 1)
 			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 			   dev->name, intr_status);

