Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbTCQUJi>; Mon, 17 Mar 2003 15:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbTCQUJi>; Mon, 17 Mar 2003 15:09:38 -0500
Received: from main.gmane.org ([80.91.224.249]:18155 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261980AbTCQUJg>;
	Mon, 17 Mar 2003 15:09:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: [PATCH eepro100] fix SMP deadlock (uninitialized spinlock)
Date: Mon, 17 Mar 2003 20:19:36 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb7cbg7.q3.lunz@stoli.localnet>
References: <slrnb6i4bm.a4a.lunz@stoli.localnet>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When support for the ETHTOOL_GSET and ETHTOOL_SSET ethtool methods was
added to eepro100.c in 2.4.20, the tx lock was overloaded to serialize
their use.  Unfortunately, this lock is only initialized in dev->open(),
causing ethtool to deadlock the machine when used on a never-opened
eepro100 interface.

The fix is to initialize the spinlock at probe time. The patch below is
against 2.4.21-pre5, but also applies to 2.5.

please apply,

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

