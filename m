Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTBOLIt>; Sat, 15 Feb 2003 06:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTBOLIt>; Sat, 15 Feb 2003 06:08:49 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:21419 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261594AbTBOLIn>;
	Sat, 15 Feb 2003 06:08:43 -0500
Date: Sat, 15 Feb 2003 12:18:21 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [2/4][via-rhine][PATCH] Fix broken Tx underrun handling
Message-ID: <20030215111821.GA11533@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20030215111705.GA11127@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The Tx underrun handling in the current driver is broken. The details have
been explained in a posting "VIA Rhine 1.15exp1, patch for
testing/discussion" a couple of months ago.


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.16rc-02_underrun.diff"

--- 01_trivial/drivers/net/via-rhine.c	Fri Feb 14 18:09:48 2003
+++ 02_underrun/drivers/net/via-rhine.c	Fri Feb 14 19:05:54 2003
@@ -416,9 +416,9 @@ int mmio_verify_registers[] = {
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
@@ -1005,7 +1005,7 @@ static void init_registers(struct net_de
 	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
 		   IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
 		   IntrTxDone | IntrTxError | IntrTxUnderrun |
-		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
+		   IntrPCIErr | IntrStatsMax | IntrLinkChange,
 		   ioaddr + IntrEnable);
 
 	np->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
@@ -1310,7 +1310,7 @@ static void via_rhine_interrupt(int irq,
 			via_rhine_tx(dev);
 
 		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |
+		if (intr_status & (IntrPCIErr | IntrLinkChange |
 				   IntrStatsMax | IntrTxError | IntrTxAborted |
 				   IntrTxUnderrun))
 			via_rhine_error(dev, intr_status);
@@ -1534,7 +1534,7 @@ static void via_rhine_error(struct net_d
 
 	spin_lock (&np->lock);
 
-	if (intr_status & (IntrMIIChange | IntrLinkChange)) {
+	if (intr_status & (IntrLinkChange)) {
 		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
 			if (np->drv_flags & HasDavicomPhy)
@@ -1552,7 +1552,7 @@ static void via_rhine_error(struct net_d
 		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
-	if (intr_status & IntrTxError) {
+	if (intr_status & IntrTxAborted) {
 		if (debug > 1)
 			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
 				   dev->name, intr_status);
@@ -1567,7 +1567,7 @@ static void via_rhine_error(struct net_d
 				   dev->name, np->tx_thresh);
 		via_rhine_restart_tx(dev);
 	}
-	if (intr_status & ~( IntrLinkChange | IntrStatsMax |
+	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
  						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
 		if (debug > 1)
 			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",

--ew6BAiZeqk4r7MaW--
