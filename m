Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUAYWIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUAYWIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:08:39 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36800 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265279AbUAYWIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:08:01 -0500
Date: Sun, 25 Jan 2004 23:07:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: [PATCH] Re: rtl8169 problem and 2.4.23
Message-ID: <20040125230753.A20686@electric-eye.fr.zoreil.com>
References: <1075059124.13750.38.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075059124.13750.38.camel@sonja>; from degger@fhm.edu on Sun, Jan 25, 2004 at 08:32:05PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> :
[r8169 stats broken]
> Furthermore the performance is really scary slow: I'm not even getting 
> 100Base-T speeds from an Athlon XP to my G4 PowerBook under MacOS X over
> a PtP connection.

Try the patch above. If it compiles, it should fix the stats and you get a
bugfix as an extra.

Please Cc: netdev@oss.sgi.com on followup.

--- linux-2.4.23.orig/drivers/net/r8169.c	Sun Jan 25 21:00:51 2004
+++ linux-2.4.23/drivers/net/r8169.c	Sun Jan 25 22:58:17 2004
@@ -874,7 +874,6 @@
 		     void *ioaddr)
 {
 	unsigned long dirty_tx, tx_left = 0;
-	int entry = tp->cur_tx % NUM_TX_DESC;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -884,14 +883,18 @@
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
 
