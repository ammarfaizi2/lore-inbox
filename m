Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278245AbRJSA77>; Thu, 18 Oct 2001 20:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278247AbRJSA7v>; Thu, 18 Oct 2001 20:59:51 -0400
Received: from patan.Sun.COM ([192.18.98.43]:26810 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278245AbRJSA7n>;
	Thu, 18 Oct 2001 20:59:43 -0400
Message-ID: <3BCF7A4D.B6060973@sun.com>
Date: Thu, 18 Oct 2001 17:56:45 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jgarzik@mandrakesoft.com, manfred@colorfullife.com, alan@redhat.com
Subject: Another Natsemi patch
Content-Type: multipart/mixed;
 boundary="------------387C01EAE29B9F26CC6000AB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------387C01EAE29B9F26CC6000AB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hey guys,

Ttime for my monthly natsemi patch :)  I have a couple issues still pending
with NSC, but I wanted to get this patch out ASAP.

* increase RX ring
* DP83816 strings
* PCI ID
* WoL cleanup
* try to wait for AnegDone bit
* Magic registers have constant values
* Catch nasty PHY resets that happen periodically
* some formatting
* SOPASS only on revD and higher

Pretty heavily tested.  Issues still pending:

* Some report of "Something Wicked" happening to the point of no network
traffic at all - investigating
* A report of "Something Wicked" under heavy load - can't repro here, but
can on reporting machine - may need to grow RX ring by a lot.
* Report of slowdown since EEPROM reload added - can't repro.
* Perhaps teh WoL config register should be saved/restored across calls to
natsemi_reset?  Comments?

Please apply for next 2.4.x.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------387C01EAE29B9F26CC6000AB
Content-Type: text/plain; charset=us-ascii;
 name="natsemi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi.diff"

diff -ruN dist-2.4.12+patches/drivers/net/natsemi.c cvs-2.4.12+patches/drivers/net/natsemi.c
--- dist-2.4.12+patches/drivers/net/natsemi.c	Mon Oct 15 10:22:07 2001
+++ cvs-2.4.12+patches/drivers/net/natsemi.c	Mon Oct 15 10:22:08 2001
@@ -85,6 +85,10 @@
 		* use long for ee_addr (various)
 		* print pointers properly (DaveM)
 		* include asm/irq.h (?)
+	
+	version 1.0.11:
+		* check and reset if PHY errors appear (Adrian Sun)
+		* WoL cleanup (Tim Hockin)
 
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
@@ -96,7 +100,6 @@
 #define DRV_VERSION	"1.07+LK1.0.10"
 #define DRV_RELDATE	"Oct 09, 2001"
 
-
 /* Updated to recommendations in pci-skeleton v2.03. */
 
 /* Automatically extracted configuration info:
@@ -106,7 +109,7 @@
 c-help-name: National Semiconductor DP8381x series PCI Ethernet support
 c-help-symbol: CONFIG_NATSEMI
 c-help: This driver is for the National Semiconductor DP8381x series,
-c-help: including the 83815 chip.
+c-help: including the 83815/83816 chips.
 c-help: More specific information and updates are available from 
 c-help: http://www.scyld.com/network/natsemi.html
 */
@@ -144,7 +147,7 @@
    There are no ill effects from too-large receive rings. */
 #define TX_RING_SIZE	16
 #define TX_QUEUE_LEN	10		/* Limit ring entries actually used, min 4.  */
-#define RX_RING_SIZE	32
+#define RX_RING_SIZE	64
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
@@ -308,11 +311,14 @@
 	const char *name;
 	unsigned long flags;
 } natsemi_pci_info[] __devinitdata = {
-	{ "NatSemi DP83815", PCI_IOTYPE },
+	{ "NatSemi DP83815/DP83816", PCI_IOTYPE },
 };
 
+#ifndef PCI_DEVICE_ID_NS_83815
+#define PCI_DEVICE_ID_NS_83815 0x0020
+#endif
 static struct pci_device_id natsemi_pci_tbl[] __devinitdata = {
-	{ 0x100B, 0x0020, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, natsemi_pci_tbl);
@@ -336,8 +342,13 @@
 
 	/* These are from the spec, around page 78... on a separate table.
 	 * The meaning of these registers depend on the value of PGSEL. */
-	PGSEL=0xCC, PMDCSR=0xE4, TSTDAT=0xFC, DSPCFG=0xF4, SDCFG=0x8C
+	PGSEL=0xCC, PMDCSR=0xE4, TSTDAT=0xFC, DSPCFG=0xF4, SDCFG=0xF8
 };
+/* the values for the 'magic' registers above (PGSEL=1) */
+#define PMDCSR_VAL	0x189C
+#define TSTDAT_VAL	0x0
+#define DSPCFG_VAL	0x5040
+#define SDCFG_VAL	0x008c
 
 /* misc PCI space registers */
 enum PCISpaceRegs {
@@ -364,9 +375,18 @@
 	WOLPkt=0x2000,
 	RxResetDone=0x1000000, TxResetDone=0x2000000,
 	IntrPCIErr=0x00f00000,
-	IntrNormalSummary=0x025f, IntrAbnormalSummary=0xCD20,
+	IntrAbnormalSummary=0xCD20,
 };
 
+/*
+ * Interrupts:
+ * Rx OK, Rx Packet Error, Rx Overrun, 
+ * Tx OK, Tx Packet Error, Tx Underrun, 
+ * MIB Service, Phy Interrupt, High Bits,
+ * Rx Status FIFO overrun,
+ * Received Target Abort, Received Master Abort, 
+ * Signalled System Error, Received Parity Error
+ */
 #define DEFAULT_INTR 0x00f1cd65
 
 /* Bits in the RxMode register. */
@@ -516,9 +536,9 @@
 	 * to be brought to D0 in this manner.
 	 */
 	pci_read_config_dword(pdev, PCIPM, &tmp);
-	if (tmp & (0x03|0x100)) {
+	if (tmp & 0x03) {
 		/* D0 state, disable PME assertion */
-		u32 newtmp = tmp & ~(0x03|0x100);
+		u32 newtmp = tmp & ~0x03;
 		pci_write_config_dword(pdev, PCIPM, newtmp);
 	}
 
@@ -790,7 +810,7 @@
 	init_timer(&np->timer);
 	np->timer.expires = jiffies + 3*HZ;
 	np->timer.data = (unsigned long)dev;
-	np->timer.function = &netdev_timer;				/* timer handler */
+	np->timer.function = &netdev_timer; /* timer handler */
 	add_timer(&np->timer);
 
 	return 0;
@@ -849,6 +869,17 @@
 		printk(KERN_DEBUG "%s: found silicon revision %xh.\n",
 				dev->name, readl(ioaddr + SiliconRev));
 
+	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
+		if (readl(dev->base_addr + ChipConfig) & CfgAnegDone)
+			break;
+		udelay(10);
+	}
+	if (i==NATSEMI_HW_TIMEOUT && debug) {
+		printk(KERN_INFO 
+			"%s: autonegotiation did not complete in %d usec.\n",
+			dev->name, i*10);
+	}
+
 	/* On page 78 of the spec, they recommend some settings for "optimum
 	   performance" to be done in sequence.  These settings optimize some
 	   of the 100Mbit autodetection circuitry.  They say we only want to 
@@ -856,20 +887,26 @@
 	   Kennedy) recommends always setting them.  If you don't, you get 
 	   errors on some autonegotiations that make the device unusable.
 	*/
-	writew(0x0001, ioaddr + PGSEL);
-	writew(0x189C, ioaddr + PMDCSR);
-	writew(0x0000, ioaddr + TSTDAT);
-	writew(0x5040, ioaddr + DSPCFG);
-	writew(0x008C, ioaddr + SDCFG);
-	writew(0x0000, ioaddr + PGSEL);
+	writew(1, ioaddr + PGSEL);
+	writew(PMDCSR_VAL, ioaddr + PMDCSR);
+	writew(TSTDAT_VAL, ioaddr + TSTDAT);
+	writew(DSPCFG_VAL, ioaddr + DSPCFG);
+	writew(SDCFG_VAL, ioaddr + SDCFG);
+	writew(0, ioaddr + PGSEL);
 
 	/* Enable PHY Specific event based interrupts.  Link state change
 	   and Auto-Negotiation Completion are among the affected.
+	   Read the intr status to clear it (needed for wake events).
 	*/
+	readw(ioaddr + MIntrStatus);
 	writew(0x0002, ioaddr + MIntrCtrl);
 
+	/* clear any interrupts that are pending, such as wake events */
+	readl(ioaddr + IntrStatus);
+
 	writel(np->ring_dma, ioaddr + RxRingPtr);
-	writel(np->ring_dma + RX_RING_SIZE * sizeof(struct netdev_desc), ioaddr + TxRingPtr);
+	writel(np->ring_dma + RX_RING_SIZE * sizeof(struct netdev_desc), 
+		ioaddr + TxRingPtr);
 
 	for (i = 0; i < ETH_ALEN; i += 2) {
 		writel(i, ioaddr + RxFilterAddr);
@@ -907,23 +944,36 @@
 	 * nothing will be written to memory. */
 	np->SavedClkRun = readl(ioaddr + ClkRun);
 	writel(np->SavedClkRun & ~0x100, ioaddr + ClkRun);
+	if (np->SavedClkRun & 0x8000) {
+		printk(KERN_NOTICE "%s: Wake-up event %8.8x\n", 
+			dev->name, readl(ioaddr + WOLCmd));
+	}
 
 	check_link(dev);
 	__set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
- 	writel(DEFAULT_INTR, ioaddr + IntrMask);
+	writel(DEFAULT_INTR, ioaddr + IntrMask);
 	writel(1, ioaddr + IntrEnable);
 
 	writel(RxOn | TxOn, ioaddr + ChipCmd);
 	writel(4, ioaddr + StatsCtrl); /* Clear Stats */
 }
 
+/* 
+ * The frequency on this has been increased because of a nasty little problem.
+ * It seems that a reference set for this chip went out with incorrect info,
+ * and there exist boards that aren't quite right.  An unexpected voltage drop
+ * can cause the PHY to get itself in a weird state (basically reset..).
+ * NOTE: this only seems to affect revC chips.
+ */
 static void netdev_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
-	int next_tick = 60*HZ;
+	int next_tick = 5*HZ;
+	long ioaddr = dev->base_addr;
+	u16 dspcfg;
 
 	if (debug > 3) {
 		/* DO NOT read the IntrStatus register, 
@@ -933,10 +983,27 @@
 			   dev->name);
 	}
 	spin_lock_irq(&np->lock);
-	check_link(dev);
+
+	/* check for a nasty random phy-reset - use dspcfg as a flag */
+	writew(1, ioaddr+PGSEL);
+	dspcfg = readw(ioaddr+DSPCFG);
+	writew(0, ioaddr+PGSEL);
+	if (dspcfg != DSPCFG_VAL) {
+		if (!netif_queue_stopped(dev)) {
+			printk(KERN_INFO 
+				"%s: possible phy reset: re-initializing\n",
+				dev->name);
+			init_registers(dev);
+		} else {
+			/* hurry back */
+			next_tick = HZ;
+		}
+	} else {
+		/* init_registers() calls check_link() for the above case */
+		check_link(dev);
+	}
 	spin_unlock_irq(&np->lock);
-	np->timer.expires = jiffies + next_tick;
-	add_timer(&np->timer);
+	mod_timer(&np->timer, jiffies + next_tick);
 }
 
 static void dump_ring(struct net_device *dev)
@@ -946,15 +1013,18 @@
 	if (debug > 2) {
 		int i;
 		printk(KERN_DEBUG "  Tx ring at %p:\n", np->tx_ring);
-		for (i = 0; i < TX_RING_SIZE; i++)
+		for (i = 0; i < TX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",
 				   i, np->tx_ring[i].next_desc,
-				   np->tx_ring[i].cmd_status, np->tx_ring[i].addr);
+				   np->tx_ring[i].cmd_status, 
+				   np->tx_ring[i].addr);
+		}
 		printk(KERN_DEBUG "  Rx ring %p:\n", np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",
 				   i, np->rx_ring[i].next_desc,
-				   np->rx_ring[i].cmd_status, np->rx_ring[i].addr);
+				   np->rx_ring[i].cmd_status, 
+				   np->rx_ring[i].addr);
 		}
 	}
 }
@@ -964,12 +1034,12 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
-
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
 	if (netif_device_present(dev)) {
 		printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-			   " resetting...\n", dev->name, readl(ioaddr + IntrStatus));
+			" resetting...\n", 
+			dev->name, readl(ioaddr + IntrStatus));
 		dump_ring(dev);
 
 		natsemi_reset(dev);
@@ -977,8 +1047,9 @@
 		init_ring(dev);
 		init_registers(dev);
 	} else {
-		printk(KERN_WARNING "%s: tx_timeout while in suspended state?\n",
-		   		dev->name);
+		printk(KERN_WARNING 
+			"%s: tx_timeout while in suspended state?\n",
+		   	dev->name);
 	}
 	spin_unlock_irq(&np->lock);
 	enable_irq(dev->irq);
@@ -1019,7 +1090,7 @@
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma
 				+sizeof(struct netdev_desc)
-				 *((i+1)%RX_RING_SIZE));
+				*((i+1)%RX_RING_SIZE));
 		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
 		np->rx_skbuff[i] = NULL;
 	}
@@ -1107,7 +1178,8 @@
 	
 	if (netif_device_present(dev)) {
 		np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | skb->len);
-		/* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */
+		/* StrongARM: Explicitly cache flush np->tx_ring and 
+		 * skb->data,skb->len. */
 		wmb();
 		np->cur_tx++;
 		if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
@@ -1219,7 +1291,7 @@
 		}
 	} while (1);
 
-	if (debug > 3)
+	if (debug > 4)
 		printk(KERN_DEBUG "%s: exiting interrupt.\n",
 			   dev->name);
 }
@@ -1553,24 +1625,33 @@
 	u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
-	if (newval & WAKE_PHY)
+	if (newval & WAKE_PHY) {
 		data |= WakePhy;
-	if (newval & WAKE_UCAST)
+	}
+	if (newval & WAKE_UCAST) {
 		data |= WakeUnicast;
-	if (newval & WAKE_MCAST)
+	}
+	if (newval & WAKE_MCAST) {
 		data |= WakeMulticast;
-	if (newval & WAKE_BCAST)
+	}
+	if (newval & WAKE_BCAST) {
 		data |= WakeBroadcast;
-	if (newval & WAKE_ARP)
+	}
+	if (newval & WAKE_ARP) {
 		data |= WakeArp;
-	if (newval & WAKE_MAGIC)
+	}
+	if (newval & WAKE_MAGIC) {
 		data |= WakeMagic;
-	if (newval & WAKE_MAGICSECURE)
-		data |= WakeMagicSecure;
+	}
+	if (readl(dev->base_addr + SiliconRev) >= 0x403) {
+		if (newval & WAKE_MAGICSECURE) {
+			data |= WakeMagicSecure;
+		}
+	}
 
 	writel(data, dev->base_addr + WOLCmd);
 
-	/* should we burn these into the EEPROM? */
+	/* FIXME: should we burn these into the EEPROM? */
 	
 	return 0;
 }
@@ -1580,23 +1661,37 @@
 	u32 regval = readl(dev->base_addr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST 
-			| WAKE_ARP | WAKE_MAGIC | WAKE_MAGICSECURE);
+			| WAKE_ARP | WAKE_MAGIC);
+	
+	if (readl(dev->base_addr + SiliconRev) >= 0x403) {
+		/* SOPASS works on revD and higher */
+		*supported |= WAKE_MAGICSECURE;
+	}
 	*cur = 0;
+
 	/* translate from chip bitmasks */
-	if (regval & 0x1)
+	if (regval & WakePhy) {
 		*cur |= WAKE_PHY;
-	if (regval & 0x2)
+	}
+	if (regval & WakeUnicast) {
 		*cur |= WAKE_UCAST;
-	if (regval & 0x4)
+	}
+	if (regval & WakeMulticast) {
 		*cur |= WAKE_MCAST;
-	if (regval & 0x8)
+	}
+	if (regval & WakeBroadcast) {
 		*cur |= WAKE_BCAST;
-	if (regval & 0x10)
+	}
+	if (regval & WakeArp) {
 		*cur |= WAKE_ARP;
-	if (regval & 0x200)
+	}
+	if (regval & WakeMagic) {
 		*cur |= WAKE_MAGIC;
-	if (regval & 0x400)
+	}
+	if (regval & WakeMagicSecure) {
+		/* this can be on in revC, but it's broken */
 		*cur |= WAKE_MAGICSECURE;
+	}
 
 	return 0;
 }
@@ -1604,9 +1699,14 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
 	u16 *sval = (u16 *)newval;
-	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+	u32 addr;
+	
+	if (readl(dev->base_addr + SiliconRev) < 0x403) {
+		return 0;
+	}
 
 	/* enable writing to these registers by disabling the RX filter */
+	addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
 	addr &= ~0x80000000;
 	writel(addr, dev->base_addr + RxFilterAddr);
 
@@ -1623,7 +1723,7 @@
 	/* re-enable the RX filter */
 	writel(addr | 0x80000000, dev->base_addr + RxFilterAddr);
 
-	/* should we burn this into the EEPROM? */
+	/* FIXME: should we burn this into the EEPROM? */
 
 	return 0;
 }
@@ -1631,9 +1731,16 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
 	u16 *sval = (u16 *)data;
-	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+	u32 addr;
+
+	if (readl(dev->base_addr + SiliconRev) < 0x403) {
+		sval[0] = sval[1] = sval[2] = 0;
+		return 0;
+	}
 
 	/* read the three words from (undocumented) RFCR vals 0xa, 0xc, 0xe */
+	addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+
 	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
 	sval[0] = readw(dev->base_addr + RxFilterData);
 
@@ -1643,6 +1750,8 @@
 	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
 	sval[2] = readw(dev->base_addr + RxFilterData);
 	
+	writel(addr, dev->base_addr + RxFilterAddr);
+
 	return 0;
 }
 
@@ -1795,16 +1904,24 @@
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
 	long ioaddr = dev->base_addr;
+	struct netdev_private *np = dev->priv;
 
 	if (debug > 1)
 		printk(KERN_INFO "%s: remaining active for wake-on-lan\n", 
 			dev->name);
+
 	/* For WOL we must restart the rx process in silent mode.
 	 * Write NULL to the RxRingPtr. Only possible if
 	 * rx process is stopped
 	 */
 	writel(0, ioaddr + RxRingPtr);
 
+	/* read WoL status to clear */
+	readl(ioaddr + WOLCmd);
+
+	/* PME on, clear status */
+	writel(np->SavedClkRun | 0x8100, ioaddr + ClkRun);
+
 	/* and restart the rx process */
 	writel(RxOn, ioaddr + ChipCmd);
 
@@ -1822,9 +1939,10 @@
 	struct netdev_private *np = dev->priv;
 
 	netif_stop_queue(dev);
+	netif_carrier_off(dev);
 
 	if (debug > 1) {
- 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
+		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
 			   dev->name, (int)readl(ioaddr + ChipCmd));
 		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
@@ -1835,9 +1953,13 @@
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
 
+	/* Disable and clear interrupts */
 	writel(0, ioaddr + IntrEnable);
-	writel(0, ioaddr + IntrMask);
-	writel(2, ioaddr + StatsCtrl); 	/* Freeze Stats */
+	readl(ioaddr + IntrMask);
+	readw(ioaddr + MIntrStatus);
+
+ 	/* Freeze Stats */
+	writel(2, ioaddr + StatsCtrl);
 	    
 	/* Stop the chip's Tx and Rx processes. */
 	natsemi_stop_rxtx(dev);
@@ -1865,20 +1987,15 @@
 
 	 {
 		u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
-		u32 clkrun = np->SavedClkRun;
-		/* Restore PME enable bit */
 		if (wol) {
 			/* restart the NIC in WOL mode.
 			 * The nic must be stopped for this.
 			 */
 			enable_wol_mode(dev, 0);
-			/* make sure to enable PME */
-			clkrun |= 0x100;
+		} else {
+			/* Restore PME enable bit unmolested */
+			writel(np->SavedClkRun, ioaddr + ClkRun);
 		}
-		writel(clkrun, ioaddr + ClkRun);
-#if 0
-		writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */
-#endif
 	}
 	return 0;
 }
@@ -1913,8 +2030,8 @@
  *	* intr_handler: doesn't acquire the spinlock. suspend calls
  *		disable_irq() to enforce synchronization.
  *
- * netif_device_detach must occur under spin_unlock_irq(), interrupts from a detached
- * device would cause an irq storm.
+ * netif_device_detach must occur under spin_unlock_irq(), interrupts from a
+ * detached device would cause an irq storm.
  */
 
 static int natsemi_suspend (struct pci_dev *pdev, u32 state)
@@ -1945,7 +2062,6 @@
 		drain_ring(dev);
 		{
 			u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
-			u32 clkrun = np->SavedClkRun;
 			/* Restore PME enable bit */
 			if (wol) {
 				/* restart the NIC in WOL mode.
@@ -1953,10 +2069,10 @@
 				 * FIXME: use the WOL interupt 
 				 */
 				enable_wol_mode(dev, 0);
-				/* make sure to enable PME */
-				clkrun |= 0x100;
+			} else {
+				/* Restore PME enable bit unmolested */
+				writel(np->SavedClkRun, ioaddr + ClkRun);
 			}
-			writel(clkrun, ioaddr + ClkRun);
 		}
 	} else {
 		netif_device_detach(dev);
@@ -1985,8 +2101,7 @@
 		netif_device_attach(dev);
 		spin_unlock_irq(&np->lock);
 
-		np->timer.expires = jiffies + 1*HZ;
-		add_timer(&np->timer);
+		mod_timer(&np->timer, jiffies + 1*HZ);
 	} else {
 		netif_device_attach(dev);
 	}
diff -ruN dist-2.4.12+patches/include/linux/pci_ids.h cvs-2.4.12+patches/include/linux/pci_ids.h
--- dist-2.4.12+patches/include/linux/pci_ids.h	Mon Oct 15 10:23:43 2001
+++ cvs-2.4.12+patches/include/linux/pci_ids.h	Mon Oct 15 10:23:43 2001
@@ -285,6 +285,7 @@
 #define PCI_DEVICE_ID_NS_87415		0x0002
 #define PCI_DEVICE_ID_NS_87560_LIO	0x000e
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
+#define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c

--------------387C01EAE29B9F26CC6000AB--

