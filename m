Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRD3Mdt>; Mon, 30 Apr 2001 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRD3Mdj>; Mon, 30 Apr 2001 08:33:39 -0400
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:39174 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131497AbRD3Md2>;
	Mon, 30 Apr 2001 08:33:28 -0400
Date: Mon, 30 Apr 2001 14:33:21 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Using alloc_skb causes memory corruption in 2.4.4
Message-ID: <Pine.LNX.4.30.0104292052370.8703-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get severe memory corruption when forwarding packets from eth1 to eth0,
where eth0 is a 3Com 905C-TX (zc, hw checksumming), and eth1 is a Davicom
9102.  In every case it is the last two bytes of a 4096-byte block that
have been cleared.

To make a long bug hunting story short, the eth1 driver (dmfe) uses
alloc_skb for skbuf allocation, and if I change it into dev_alloc_skb, the
problem disappears.

Did I find the real problem, or did I just hide it?

/Tobias


diff -ru linux-2.4.4.orig/drivers/net/dmfe.c linux-2.4.4/drivers/net/dmfe.c
--- linux-2.4.4.orig/drivers/net/dmfe.c	Sat Apr 28 11:41:49 2001
+++ linux-2.4.4/drivers/net/dmfe.c	Mon Apr 30 15:15:02 2001
@@ -1306,7 +1306,7 @@
 	rxptr = db->rx_insert_ptr;

 	while (db->rx_avail_cnt < RX_DESC_CNT) {
-		if ((skb = alloc_skb(RX_ALLOC_SIZE, GFP_ATOMIC)) == NULL)
+		if ((skb = dev_alloc_skb(RX_ALLOC_SIZE)) == NULL)
 			break;
 		rxptr->rx_skb_ptr = (u32) skb;
 		rxptr->rdes2 = virt_to_bus(skb->tail);

