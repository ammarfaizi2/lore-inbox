Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTB0Lff>; Thu, 27 Feb 2003 06:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTB0Lff>; Thu, 27 Feb 2003 06:35:35 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:13813 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264729AbTB0LfS>;
	Thu, 27 Feb 2003 06:35:18 -0500
Date: Thu, 27 Feb 2003 12:45:06 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: [2/2][via-rhine][PATCH] fix races
Message-ID: <20030227114506.GA4299@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20030227114417.GA3970@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch addresses two distinct races:

- Until now, the driver started the chip for Tx regardless of errors
  pending in the status register. Not good if an error occured while
  we were queueing packets -- the chip counter had not been reset,
  so Tx died. (We can't reliably get an interrupt for every error
  condition)

- The Rhine-II (when under load) frequently produces a Tx descriptor
  write-back race error. Failing to handle this means waiting for the
  netdev watchdog. Fixed.

  In addition, we must wait for the Tx engine to turn off on error
  conditions before we scavenge the descriptor entries. Failing to do
  so will typically lead to performance going down to about 10%: Burst,
  timeout, burst, timeout.. (again, with a Rhine-II under load).


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.17rc-02_tdwb_race.diff"

--- 07_reset/drivers/net/via-rhine.c	Sat Feb 22 01:18:26 2003
+++ 08_tdwb_race/drivers/net/via-rhine.c	Thu Feb 27 11:45:47 2003
@@ -405,7 +405,8 @@ enum register_offsets {
 	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72, MACRegEEcsr=0x74,
 	ConfigA=0x78, ConfigB=0x79, ConfigC=0x7A, ConfigD=0x7B,
 	RxMissed=0x7C, RxCRCErrs=0x7E, MiscCmd=0x81,
-	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
+	StickyHW=0x83, IntrStatus2=0x84, WOLcrClr=0xA4, WOLcgClr=0xA7,
+	PwrcsrClr=0xAC,
 };
 
 /* Bits in ConfigD */
@@ -432,6 +433,8 @@ enum intr_status_bits {
 	IntrTxAborted=0x2000, IntrLinkChange=0x4000,
 	IntrRxWakeUp=0x8000,
 	IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
+	IntrTxDescRace=0x080000,	/* mapped from IntrStatus2 */
+	IntrTxErrSummary=0x082210,
 };
 
 /* The Rx and Tx buffer descriptors. */
@@ -529,6 +532,19 @@ static struct net_device_stats *via_rhin
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  via_rhine_close(struct net_device *dev);
 
+static inline u32 get_intr_status(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	struct netdev_private *np = dev->priv;
+	u32 intr_status;
+
+	intr_status = readw(ioaddr + IntrStatus);
+	/* On Rhine-II, Bit 3 indicates Tx descriptor write-back race. */
+	if (np->chip_id == VT6102)
+		intr_status |= readb(ioaddr + IntrStatus2) << 16;
+	return intr_status;
+}
+
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
 	long ioaddr = dev->base_addr;
@@ -1231,6 +1247,7 @@ static int via_rhine_start_tx(struct sk_
 {
 	struct netdev_private *np = dev->priv;
 	unsigned entry;
+	u32 intr_status;
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -1280,8 +1297,15 @@ static int via_rhine_start_tx(struct sk_
 
 	/* Non-x86 Todo: explicitly flush cache lines here. */
 
-	/* Wake the potentially-idle transmit channel. */
-	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	/*
+	 * Wake the potentially-idle transmit channel unless errors are
+	 * pending (the ISR must sort them out first).
+	 */
+	intr_status = get_intr_status(dev);
+	if ((intr_status & IntrTxErrSummary) == 0) {
+		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	}
+	IOSYNC;
 
 	if (np->cur_tx == np->dirty_tx + TX_QUEUE_LEN)
 		netif_stop_queue(dev);
@@ -1308,38 +1332,51 @@ static void via_rhine_interrupt(int irq,
 
 	ioaddr = dev->base_addr;
 	
-	while ((intr_status = readw(ioaddr + IntrStatus))) {
+	while ((intr_status = get_intr_status(dev))) {
 		/* Acknowledge all of the current interrupt sources ASAP. */
+		if (intr_status & IntrTxDescRace)
+			writeb(0x08, ioaddr + IntrStatus2);
 		writew(intr_status & 0xffff, ioaddr + IntrStatus);
+		IOSYNC;
 
 		if (debug > 4)
-			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
+			printk(KERN_DEBUG "%s: Interrupt, status %8.8x.\n",
 				   dev->name, intr_status);
 
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
 						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
 			via_rhine_rx(dev);
 
-		if (intr_status & (IntrTxDone | IntrTxError | IntrTxUnderrun |
-						   IntrTxAborted))
+		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
+			if (intr_status & IntrTxErrSummary) {
+				int cnt = 20;
+				/* Avoid scavenging before Tx engine turned off */
+				while ((readw(ioaddr+ChipCmd) & CmdTxOn) && --cnt)
+					udelay(5);
+				if (debug > 2 && !cnt)
+					printk(KERN_WARNING "%s: via_rhine_interrupt() "
+						   "Tx engine still on.\n",
+						   dev->name);
+			}
 			via_rhine_tx(dev);
+		}
 
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & (IntrPCIErr | IntrLinkChange |
 				   IntrStatsMax | IntrTxError | IntrTxAborted |
-				   IntrTxUnderrun))
+				   IntrTxUnderrun | IntrTxDescRace))
 			via_rhine_error(dev, intr_status);
 
 		if (--boguscnt < 0) {
 			printk(KERN_WARNING "%s: Too much work at interrupt, "
-				   "status=0x%4.4x.\n",
+				   "status=%#8.8x.\n",
 				   dev->name, intr_status);
 			break;
 		}
 	}
 
 	if (debug > 3)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%4.4x.\n",
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%8.8x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 }
 
@@ -1517,7 +1554,8 @@ static void via_rhine_rx(struct net_devi
 	}
 
 	/* Pre-emptively restart Rx engine. */
-	writew(CmdRxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	writew(readw(dev->base_addr + ChipCmd) | CmdRxOn | CmdRxDemand,
+		   dev->base_addr + ChipCmd);
 }
 
 /* Clears the "tally counters" for CRC errors and missed frames(?).
@@ -1531,15 +1569,35 @@ static inline void clear_tally_counters(
 	readw(ioaddr + RxMissed);
 }
 
-static inline void via_rhine_restart_tx(struct net_device *dev) {
+static void via_rhine_restart_tx(struct net_device *dev) {
 	struct netdev_private *np = dev->priv;
+	long ioaddr = dev->base_addr;
 	int entry = np->dirty_tx % TX_RING_SIZE;
+	u32 intr_status;
 
-	/* We know better than the chip where it should continue */
-	writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
-		   dev->base_addr + TxRingPtr);
+	/*
+	 * If new errors occured, we need to sort them out before doing Tx.
+	 * In that case the ISR will be back here RSN anyway.
+	 */
+	intr_status = get_intr_status(dev);
+
+	if ((intr_status & IntrTxErrSummary) == 0) {
+
+		/* We know better than the chip where it should continue. */
+		writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+			   ioaddr + TxRingPtr);
+
+		writew(CmdTxDemand | np->chip_cmd, ioaddr + ChipCmd);
+		IOSYNC;
+	}
+	else {
+		/* This should never happen */
+		if (debug > 1)
+			printk(KERN_WARNING "%s: via_rhine_restart_tx() "
+				   "Another error occured %8.8x.\n",
+				   dev->name, intr_status);
+	}
 
-	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
 
 static void via_rhine_error(struct net_device *dev, int intr_status)
@@ -1569,9 +1627,8 @@ static void via_rhine_error(struct net_d
 	}
 	if (intr_status & IntrTxAborted) {
 		if (debug > 1)
-			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+			printk(KERN_INFO "%s: Abort %8.8x, frame dropped.\n",
 				   dev->name, intr_status);
-		via_rhine_restart_tx(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
@@ -1580,15 +1637,21 @@ static void via_rhine_error(struct net_d
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
 				   "threshold now %2.2x.\n",
 				   dev->name, np->tx_thresh);
-		via_rhine_restart_tx(dev);
 	}
+	if (intr_status & IntrTxDescRace) {
+		if (debug > 2)
+			printk(KERN_INFO "%s: Tx descriptor write-back race.\n",
+				   dev->name);
+	}
+	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace ))
+		via_rhine_restart_tx(dev);
+
 	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
- 						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
+ 						 IntrTxError | IntrTxAborted | IntrNormalSummary |
+						 IntrTxDescRace )) {
 		if (debug > 1)
-			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
-			   dev->name, intr_status);
-		/* Recovery for other fault sources not known. */
-		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+			printk(KERN_ERR "%s: Something Wicked happened! %8.8x.\n",
+				   dev->name, intr_status);
 	}
 
 	spin_unlock (&np->lock);

--vtzGhvizbBRQ85DL--
