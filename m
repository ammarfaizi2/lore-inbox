Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTBOLKm>; Sat, 15 Feb 2003 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTBOLKl>; Sat, 15 Feb 2003 06:10:41 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:4350 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261624AbTBOLJK>;
	Sat, 15 Feb 2003 06:09:10 -0500
Date: Sat, 15 Feb 2003 12:18:12 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [1/4][via-rhine][PATCH] Trivial changes; not affecting functionality
Message-ID: <20030215111812.GA11525@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20030215111705.GA11127@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

- nuke mii_status_bits
- move clear_tally_counters() up so it can get inlined (pointed out by
  Luca Barbieri)
- rename via_restart_tx() -> via_rhine_restart_tx()


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.16rc-01_trivial.diff"

--- 00_2.5.61/drivers/net/via-rhine.c	Sat Feb 15 10:42:53 2003
+++ 01_trivial/drivers/net/via-rhine.c	Fri Feb 14 18:09:48 2003
@@ -425,20 +425,6 @@ enum intr_status_bits {
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
@@ -533,8 +519,6 @@ static void via_rhine_set_rx_mode(struct
 static struct net_device_stats *via_rhine_get_stats(struct net_device *dev);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  via_rhine_close(struct net_device *dev);
-static inline void clear_tally_counters(long ioaddr);
-static inline void via_restart_tx(struct net_device *dev);
 
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
@@ -797,7 +781,7 @@ static int __devinit via_rhine_init_one 
 					   mdio_read(dev, phy, 5));
 
 				/* set IFF_RUNNING */
-				if (mii_status & MIILink)
+				if (mii_status & BMSR_LSTATUS)
 					netif_carrier_on(dev);
 				else
 					netif_carrier_off(dev);
@@ -1175,8 +1159,8 @@ static void via_rhine_timer(unsigned lon
 
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
 	mii_status = mdio_read(dev, np->phys[0], MII_BMSR);
-	if ( (mii_status & MIILink) != (np->mii_status & MIILink) ) {
-		if (mii_status & MIILink)
+	if ( (mii_status & BMSR_LSTATUS) != (np->mii_status & BMSR_LSTATUS) ) {
+		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
 		else
 			netif_carrier_off(dev);
@@ -1414,8 +1398,8 @@ static void via_rhine_rx(struct net_devi
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 
 	if (debug > 4) {
-		printk(KERN_DEBUG " In via_rhine_rx(), entry %d status %8.8x.\n",
-			   entry, le32_to_cpu(np->rx_head_desc->rx_status));
+		printk(KERN_DEBUG "%s: via_rhine_rx(), entry %d status %8.8x.\n",
+			   dev->name, entry, le32_to_cpu(np->rx_head_desc->rx_status));
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
@@ -1521,7 +1505,18 @@ static void via_rhine_rx(struct net_devi
 	writew(CmdRxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
 
-static inline void via_restart_tx(struct net_device *dev) {
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
+static inline void via_rhine_restart_tx(struct net_device *dev) {
 	struct netdev_private *np = dev->priv;
 	int entry = np->dirty_tx % TX_RING_SIZE;
 
@@ -1561,7 +1556,7 @@ static void via_rhine_error(struct net_d
 		if (debug > 1)
 			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
 				   dev->name, intr_status);
-		via_restart_tx(dev);
+		via_rhine_restart_tx(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
@@ -1570,7 +1565,7 @@ static void via_rhine_error(struct net_d
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
 				   "threshold now %2.2x.\n",
 				   dev->name, np->tx_thresh);
-		via_restart_tx(dev);
+		via_rhine_restart_tx(dev);
 	}
 	if (intr_status & ~( IntrLinkChange | IntrStatsMax |
  						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
@@ -1599,17 +1594,6 @@ static struct net_device_stats *via_rhin
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

--sdtB3X0nJg68CQEu--
