Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUBUNon (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUBUNon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:44:43 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7840 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261552AbUBUNok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:44:40 -0500
Date: Sat, 21 Feb 2004 14:43:04 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Daniel Egger <degger@fhm.edu>
Subject: Re: [PATCH] Re: rtl8169 problem and 2.4.23
Message-ID: <20040221144304.A3230@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeff,

  can you push the attached patch directly to both 2.6.x and 2.4.x ?
It will exhibit an offset of 3 lines against 2.4.x but it works the same
on 2.4.x and on 2.6.x. The fix already exists in -mm/-netdev serie.

Daniel Egger <degger@fhm.edu> confirmed I did not manage to add a giant
typo in a 4 lines patch. When hit, this bug is more or less a killer.

Daniel, I have no clear idea for the performance issues. Actually I am more
concerned with the stability side of this driver, especially in the new,
shamelessly hacked, branch of the driver. I'll probably regenerate a set
of patches and spam^W reach the testers to have a new data point.

--
Ueimor

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-tx-desc-overflow.patch"

Assume tp->dirty_tx = NUM_TX_DESC/2, tp->cur_tx = NUM_TX_DESC - 1,
watch "entry" go beyond NUM_TX_DESC. This bug was copied from the 
(2.6.x only) sis190 driver where it is now fixed.
Stats are fixed as an extra bonus.


diff -Nrup drivers/net/r8169.c.orig drivers/net/r8169.c
--- drivers/net/r8169.c.orig	Thu Dec 18 03:58:50 2003
+++ drivers/net/r8169.c	Sat Feb 21 14:11:31 2004
@@ -871,7 +871,6 @@ rtl8169_tx_interrupt(struct net_device *
 		     void *ioaddr)
 {
 	unsigned long dirty_tx, tx_left = 0;
-	int entry = tp->cur_tx % NUM_TX_DESC;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -881,14 +880,18 @@ rtl8169_tx_interrupt(struct net_device *
 	tx_left = tp->cur_tx - dirty_tx;
 
 	while (tx_left > 0) {
+		int entry = dirty_tx % NUM_TX_DESC;
+
 		if ((tp->TxDescArray[entry].status & OWNbit) == 0) {
-			dev_kfree_skb_irq(tp->
-					  Tx_skbuff[dirty_tx % NUM_TX_DESC]);
-			tp->Tx_skbuff[dirty_tx % NUM_TX_DESC] = NULL;
+			struct sk_buff *skb = tp->Tx_skbuff[entry];
+
+			tp->stats.tx_bytes += skb->len >= ETH_ZLEN ?
+					      skb->len : ETH_ZLEN;
 			tp->stats.tx_packets++;
+			dev_kfree_skb_irq(skb);
+			tp->Tx_skbuff[entry] = NULL;
 			dirty_tx++;
 			tx_left--;
-			entry++;
 		}
 	}
 

--7AUc2qLy4jB3hD7Z--
