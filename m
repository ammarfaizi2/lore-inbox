Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSHDQEO>; Sun, 4 Aug 2002 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317975AbSHDQEO>; Sun, 4 Aug 2002 12:04:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317971AbSHDQEN>;
	Sun, 4 Aug 2002 12:04:13 -0400
Date: Sun, 4 Aug 2002 17:07:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compile fix for dl2k
Message-ID: <20020804170747.M24631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


synchronise_irq now takes an argument.
it was using set_bit / test_bit inappropriately.

diff -urpNX dontdiff linux-2.5.30/drivers/net/dl2k.c linux-2.5.30-willy/drivers/net/dl2k.c
--- linux-2.5.30/drivers/net/dl2k.c	2002-06-20 16:53:51.000000000 -0600
+++ linux-2.5.30-willy/drivers/net/dl2k.c	2002-08-04 08:23:47.000000000 -0600
@@ -1108,7 +1108,6 @@ set_multicast (struct net_device *dev)
 	u16 rx_mode = 0;
 	int i;
 	int bit;
-	int index, crc;
 	struct dev_mc_list *mclist;
 	struct netdev_private *np = dev->priv;
 	
@@ -1130,13 +1129,14 @@ set_multicast (struct net_device *dev)
 		for (i=0, mclist = dev->mc_list; mclist && i < dev->mc_count; 
 			i++, mclist=mclist->next) {
 
-			crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
+			int index = 0;
+			int crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
 
 			/* The inverted high significant 6 bits of CRC are
 			   used as an index to hashtable */
-			for (index = 0, bit = 0; bit < 6; bit++)
-				if (test_bit(31 - bit, &crc))
-					set_bit(bit, &index);
+			for (bit = 0; bit < 6; bit++)
+				if (crc & (1 << (31 - bit)))
+					index |= (1 << bit);
 
 			hash_table[index / 32] |= (1 << (index % 32));
 		}
@@ -1635,7 +1635,7 @@ rio_close (struct net_device *dev)
 
 	/* Stop Tx and Rx logics */
 	writel (TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl);
-	synchronize_irq ();
+	synchronize_irq (dev->irq);
 	free_irq (dev->irq, dev);
 	del_timer_sync (&np->timer);
 	

-- 
Revolutions do not require corporate support.
