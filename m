Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFALQr>; Sat, 1 Jun 2002 07:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFALQq>; Sat, 1 Jun 2002 07:16:46 -0400
Received: from mta11n.bluewin.ch ([195.186.1.211]:59195 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S316571AbSFALQq>; Sat, 1 Jun 2002 07:16:46 -0400
Date: Sat, 1 Jun 2002 12:57:45 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix VIA Rhine time outs (some)
Message-ID: <20020601105745.GA2726@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If you experience time outs with via-rhine (typically while copying large
files over the network), this patch is for you.

The problem with at least some of the Rhine chips is that they are skipping
one frame when they stop the Tx engine. This means that every time an abort
(due to excessive collisions) occurs, the driver will stall and need a
reset via netdev timeout [1]. The patch addresses that by setting the Tx
ring buffer pointer to where the driver thinks the chip should continue.

Note: this fix is not sufficient for all time out cases, but it should
improve the situation without having negative side effects for anyone. I
have a more comprehensive solution in my development tree, for now I am
curious how many of the time outs people keep reporting persist after this
one is fixed.

Patch is against Jeff's via-rhine.c LK 1.1.14. It should work with the
older version in 2.4.19-pre9 as well.

Roger

[1] The same problem will likely happen with any other Tx error (e.g.
    underrun), abort is just the one I can easily produce here.

    It also seems that the interrupt status is not always reliable. I
    have one report of very mysterious behavior with a VT86C100A which
    seems to produce all kinds of obviously bogus errors. That's
    unrelated though and easier to study once the restart problems
    are fixed.

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c.7.patch"

--- via-rhine.c.org	Sat Jun  1 11:23:33 2002
+++ via-rhine.c	Sat Jun  1 12:19:18 2002
@@ -1502,7 +1502,12 @@ static void via_rhine_error(struct net_d
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAbort) {
-		/* Stats counted in Tx-done handler, just restart Tx. */
+		if (debug > 1)
+			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+				   dev->name, intr_status);
+		/* We know better than the chip where it should continue */
+		writel(virt_to_bus(&np->tx_ring[np->dirty_tx % TX_RING_SIZE]),
+			   dev->base_addr + TxRingPtr);
 		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 	}
 	if (intr_status & IntrTxUnderrun) {

--EVF5PPMfhYS0aIcm--
