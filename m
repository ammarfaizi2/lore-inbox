Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBZAIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUBZAIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:08:47 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62916 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261774AbUBZAIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:08:44 -0500
Date: Thu, 26 Feb 2004 01:06:01 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch] 2.4.26-pre1 - drivers/net/r8169.c
Message-ID: <20040226010601.A11789@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Feb 25, 2004 at 04:09:20PM -0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Marcelo Tosatti <marcelo.tosatti@cyclades.com> :
[...]
> Here goes -pre1.

Please apply attached patch.

Without patch, bogus descriptors are parsed as soon as
tp->cur_tx%NUM_TX_DESC + (tp->cur_tx - tp->dirty_tx) > NUM_TX_DESC
(assume for instance tp->dirty_tx = NUM_TX_DESC/2,
tp->cur_tx = NUM_TX_DESC - 1 and watch entry go beyond NUM_TX_DESC).

Missing stats update is fixed by the patch btw.

--
Ueimor

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-tx-desc-overflow.patch"

--- drivers/net/r8169.c.orig	2004-02-25 23:34:15.000000000 +0100
+++ drivers/net/r8169.c	2004-02-25 23:47:26.000000000 +0100
@@ -874,7 +874,6 @@ rtl8169_tx_interrupt(struct net_device *
 		     void *ioaddr)
 {
 	unsigned long dirty_tx, tx_left = 0;
-	int entry = tp->cur_tx % NUM_TX_DESC;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -884,14 +883,18 @@ rtl8169_tx_interrupt(struct net_device *
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
 

--nFreZHaLTZJo0R7j--
