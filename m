Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbTCGV2e>; Fri, 7 Mar 2003 16:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261796AbTCGV2e>; Fri, 7 Mar 2003 16:28:34 -0500
Received: from main.gmane.org ([80.91.224.249]:54986 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261792AbTCGV2c>;
	Fri, 7 Mar 2003 16:28:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: [PATCH] fix SMP lockup in eepro100 with ethtool on unused interface
Date: Fri, 7 Mar 2003 21:38:29 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb6i4bm.a4a.lunz@stoli.localnet>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When support for the GSET and SSET ethtool ioctls was added to
eepro100.c in 2.4.20, the tx lock was overloaded to serialize their use.
Unfortunately, this lock is only initialized in dev->open(), causing
ethtool to deadlock the machine when used on an unconfigured eepro100
interface.

The fix is to initialize the spinlock at probe time. Jeff, the patch
below is against 2.4.21-pre5, but I'm assuming you'll integrate it into
2.5 and push it to Linus as well as Marcelo. It applies to both trees.

Jason


--- linux-2.4.21-pre5/drivers/net/eepro100.c	Thu Feb 27 14:21:34 2003
+++ linux-eepro100/drivers/net/eepro100.c	Fri Mar  7 16:38:17 2003
@@ -842,6 +842,7 @@
 	sp->lstats = (struct speedo_stats *)(sp->tx_ring + TX_RING_SIZE);
 	sp->lstats_dma = TX_RING_ELEM_DMA(sp, TX_RING_SIZE);
 	init_timer(&sp->timer); /* used in ioctl() */
+	spin_lock_init(&sp->lock);
 
 	sp->mii_if.full_duplex = option >= 0 && (option & 0x10) ? 1 : 0;
 	if (card_idx >= 0) {
@@ -993,7 +994,6 @@
 	sp->dirty_tx = 0;
 	sp->last_cmd = 0;
 	sp->tx_full = 0;
-	spin_lock_init(&sp->lock);
 	sp->in_interrupt = 0;
 
 	/* .. we can safely take handler calls during init. */

