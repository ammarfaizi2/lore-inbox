Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSLUVg6>; Sat, 21 Dec 2002 16:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSLUVg6>; Sat, 21 Dec 2002 16:36:58 -0500
Received: from mta3n.bluewin.ch ([195.186.1.212]:54214 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264975AbSLUVgy>;
	Sat, 21 Dec 2002 16:36:54 -0500
Date: Sat, 21 Dec 2002 22:44:48 +0100
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: VIA Rhine 1.15exp1, patch for testing/discussion
Message-ID: <20021221214448.GA19739@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.52 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Main points (more details below):
- Tx underrun handling redone
- Give chip 10 us (instead of 10 ms) to reset
- Force a reset on VT6102 if necessary

Minor changes:
- use defined constants (especially MII), nuke mii_status_bits
- move clear_tally_counters() up so it can get inlined (pointed out by
  Luca Barbieri)
- fix namespace pollution

According to the spec and my own tests, the flag previously labeled
IntrMIIChange in fact indicates a Tx (FIFO, desc, or buffer, the specs are
not quite sure about that) underrun. The flag we've been testing supposedly
indicates a Tx underrun, too, but I've never seen it trigger. -- The new
code tests for both. IntrMIIChange handling got dropped in the process.

Tx underrun is more difficult to trigger than the abort, but I have seen
the Tx threshold increase to 0x40 and then to 0x60. With 0x60, I have not
been able to produce any Tx underruns. The fact that increasing the
threshold fixes the error is another strong hint that the specs are correct
in this case.

The current driver will not only fail to recognize a Tx underrun, it will
actually treat it as an abort _and_ restart autonegotiation (the interrupt
status is 0208). Instead of testing for TxError (used to be called
TxAbort), the new driver now tests for TxAborted. The autonegotiation issue
was due to IntrMIIChange as discussed above.

For the first time ever, and only once, I have seen a Rhine-II that refused
to reset with the current driver. That was just enough to confirm that the
force reset flag actually works, so that's in now.

In the same function, I nuked the code that waited up to 10 ms for the chip
to reset. I have yet to see a chip reset in 10 ms after it had failed to
reset in 10 us. This change may cause a regression, but I doubt it. If you
know it does, holler.

I've got more changes in the works, this is a snapshot with some of the
better tested pieces.

Roger

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c-1.15exp1.diff"

--- linux-2.5.52/drivers/net/via-rhine.c.orig	Fri Dec 20 20:13:55 2002
+++ linux-2.5.52/drivers/net/via-rhine.c	Sat Dec 21 21:09:25 2002
@@ -101,11 +101,14 @@
 	LK1.1.15 (jgarzik):
 	- Use new MII lib helper generic_mii_ioctl
 
+	LK1.1.15exp1 (Roger Luethi):
+	- [...]
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.15"
-#define DRV_RELDATE	"November-22-2002"
+#define DRV_VERSION	"1.1.15exp1"
+#define DRV_RELDATE	"December-21-2002"
 
 
 /* A few user-configurable values.
@@ -416,29 +419,15 @@ int mmio_verify_registers[] = {
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
 	IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
-	IntrTxDone=0x0002, IntrTxError=0x0008, IntrTxUnderrun=0x0010,
+	IntrTxDone=0x0002, IntrTxError=0x0008, IntrTxUnderrun=0x0210,
 	IntrPCIErr=0x0040,
-	IntrStatsMax=0x0080, IntrRxEarly=0x0100, IntrMIIChange=0x0200,
+	IntrStatsMax=0x0080, IntrRxEarly=0x0100,
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
@@ -533,30 +522,31 @@ static void via_rhine_set_rx_mode(struct
 static struct net_device_stats *via_rhine_get_stats(struct net_device *dev);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  via_rhine_close(struct net_device *dev);
-static inline void clear_tally_counters(long ioaddr);
-static inline void via_restart_tx(struct net_device *dev);
 
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
 	long ioaddr = dev->base_addr;
-	int i;
+
+	udelay(5);
+
+	if (readw(ioaddr + ChipCmd) & CmdReset) {
+		printk(KERN_INFO "%s: Reset did not complete in 5 us.\n", name);
+	}
 
 	/* VT86C100A may need long delay after reset (dlink) */
 	if (chip_id == VT86C100A)
 		udelay(100);
 
-	i = 0;
-	do {
-		udelay(5);
-		i++;
-		if(i > 2000) {
-			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n", name);
-			break;
-		}
-	} while(readw(ioaddr + ChipCmd) & CmdReset);
+	/* The VT6102 needs to be forced sometimes */
+	if (chip_id == VT6102) {
+		writeb(0x40, ioaddr + 0x81);
+	}
+
+	udelay(5);
+
 	if (debug > 1)
-		printk(KERN_INFO "%s: reset finished after %d microseconds.\n",
-			   name, 5*i);
+		printk(KERN_INFO "%s: Reset %s.\n", name,
+			(readw(ioaddr + ChipCmd) & CmdReset) ? "failed" : "succeeded");
 }
 
 #ifdef USE_MEM
@@ -787,17 +777,17 @@ static int __devinit via_rhine_init_one 
 		int phy, phy_idx = 0;
 		np->phys[0] = 1;		/* Standard for this chip. */
 		for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
+			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
-				np->mii_if.advertising = mdio_read(dev, phy, 4);
+				np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x Link %4.4x.\n",
 					   dev->name, phy, mii_status, np->mii_if.advertising,
-					   mdio_read(dev, phy, 5));
+					   mdio_read(dev, phy, MII_LPA));
 
 				/* set IFF_RUNNING */
-				if (mii_status & MIILink)
+				if (mii_status & BMSR_LSTATUS)
 					netif_carrier_on(dev);
 				else
 					netif_carrier_off(dev);
@@ -820,8 +810,8 @@ static int __devinit via_rhine_init_one 
 				   (option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
 				mdio_write(dev, np->phys[0], MII_BMCR,
-						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
-						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
+						   ((option & 0x300) ? BMCR_SPEED100 : 0) |  /* 100mbps? */
+						   ((option & 0x220) ? BMCR_FULLDPLX : 0));  /* Full duplex? */
 		}
 	}
 
@@ -1021,7 +1011,7 @@ static void init_registers(struct net_de
 	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
 		   IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
 		   IntrTxDone | IntrTxError | IntrTxUnderrun |
-		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
+		   IntrPCIErr | IntrStatsMax | IntrLinkChange,
 		   ioaddr + IntrEnable);
 
 	np->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
@@ -1066,10 +1056,10 @@ static void mdio_write(struct net_device
 	if (phy_id == np->phys[0]) {
 		switch (regnum) {
 		case MII_BMCR:					/* Is user forcing speed/duplex? */
-			if (value & 0x9000)			/* Autonegotiation. */
+			if (value & (BMCR_ANENABLE | BMCR_RESET))	/* Autonegotiation. */
 				np->mii_if.force_media = 0;
 			else
-				np->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
+				np->mii_if.full_duplex = (value & BMCR_FULLDPLX) ? 1 : 0;
 			break;
 		case MII_ADVERTISE:
 			np->mii_if.advertising = value;
@@ -1175,8 +1165,8 @@ static void via_rhine_timer(unsigned lon
 
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
 	mii_status = mdio_read(dev, np->phys[0], MII_BMSR);
-	if ( (mii_status & MIILink) != (np->mii_status & MIILink) ) {
-		if (mii_status & MIILink)
+	if ( (mii_status & BMSR_LSTATUS) != (np->mii_status & BMSR_LSTATUS) ) {
+		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
 		else
 			netif_carrier_off(dev);
@@ -1320,7 +1310,7 @@ static void via_rhine_interrupt(int irq,
 			via_rhine_tx(dev);
 
 		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |
+		if (intr_status & (IntrPCIErr | IntrLinkChange |
 				   IntrStatsMax | IntrTxError | IntrTxAborted |
 				   IntrTxUnderrun))
 			via_rhine_error(dev, intr_status);
@@ -1515,7 +1505,7 @@ static void via_rhine_rx(struct net_devi
 	writew(CmdRxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
 
-static inline void via_restart_tx(struct net_device *dev) {
+static inline void via_rhine_restart_tx(struct net_device *dev) {
 	struct netdev_private *np = dev->priv;
 	int entry = np->dirty_tx % TX_RING_SIZE;
 
@@ -1526,6 +1516,17 @@ static inline void via_restart_tx(struct
 	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
 
+/* Clears the "tally counters" for CRC errors and missed frames(?).
+   It has been reported that some chips need a write of 0 to clear
+   these, for others the counters are set to 1 when written to and
+   instead cleared when read. So we clear them both ways ... */
+static inline void clear_tally_counters(const long ioaddr)
+{
+	writel(0, ioaddr + RxMissed);
+	readw(ioaddr + RxCRCErrs);
+	readw(ioaddr + RxMissed);
+}
+
 static void via_rhine_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = dev->priv;
@@ -1533,7 +1534,7 @@ static void via_rhine_error(struct net_d
 
 	spin_lock (&np->lock);
 
-	if (intr_status & (IntrMIIChange | IntrLinkChange)) {
+	if (intr_status & (IntrLinkChange)) {
 		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
 			if (np->drv_flags & HasDavicomPhy)
@@ -1551,11 +1552,11 @@ static void via_rhine_error(struct net_d
 		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
-	if (intr_status & IntrTxError) {
+	if (intr_status & IntrTxAborted) {
 		if (debug > 1)
 			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
 				   dev->name, intr_status);
-		via_restart_tx(dev);
+		via_rhine_restart_tx(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
@@ -1564,9 +1565,9 @@ static void via_rhine_error(struct net_d
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
 				   "threshold now %2.2x.\n",
 				   dev->name, np->tx_thresh);
-		via_restart_tx(dev);
+		via_rhine_restart_tx(dev);
 	}
-	if (intr_status & ~( IntrLinkChange | IntrStatsMax |
+	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
  						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
 		if (debug > 1)
 			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
@@ -1593,17 +1594,6 @@ static struct net_device_stats *via_rhin
 	return &np->stats;
 }
 
-/* Clears the "tally counters" for CRC errors and missed frames(?).
-   It has been reported that some chips need a write of 0 to clear
-   these, for others the counters are set to 1 when written to and
-   instead cleared when read. So we clear them both ways ... */
-static inline void clear_tally_counters(const long ioaddr)
-{
-	writel(0, ioaddr + RxMissed);
-	readw(ioaddr + RxCRCErrs);
-	readw(ioaddr + RxMissed);
-}
-
 static void via_rhine_set_rx_mode(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;

--ZPt4rx8FFjLCG7dd--
