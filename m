Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUC2T5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUC2T5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:57:24 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58317 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263124AbUC2T5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:57:18 -0500
Date: Mon, 29 Mar 2004 21:56:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bernd Fuhrmann <silverbanana@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
Message-ID: <20040329215631.A4694@electric-eye.fr.zoreil.com>
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <4067489E.2090400@gmx.de> <20040329003600.A24995@electric-eye.fr.zoreil.com> <40687B75.3090709@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40687B75.3090709@gmx.de>; from silverbanana@gmx.de on Mon, Mar 29, 2004 at 09:39:33PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bernd Fuhrmann <silverbanana@gmx.de> :
[...]
> problem. Linux still crashes after a couple of MBytes have passed the r8169.
> 
> Thanks for your effort. Any other idea how to fix that problem (like 
> doing things that make r8169 stable while loosing performance)?

The attached patch applies on top of 2.6.5-rc2-mm5 without fuss.

Could you verify that the computer is otherwise stable if you issue a
'dd if=/dev/hda of=/dev/null bs=1024k' for 120~150 seconds ?

An output of lspci -vx/dmesg/lsmod is always welcome btw.

--
Ueimor

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-break-irq-loop.patch"

 drivers/net/r8169.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff -puN drivers/net/r8169.c~r8169-break-irq-loop drivers/net/r8169.c
--- linux-2.6.5-rc2-mm5/drivers/net/r8169.c~r8169-break-irq-loop	2004-03-29 21:45:07.000000000 +0200
+++ linux-2.6.5-rc2-mm5-fr/drivers/net/r8169.c	2004-03-29 21:45:38.000000000 +0200
@@ -1352,21 +1352,21 @@ rtl8169_tx_interrupt(struct net_device *
 
 	while (tx_left > 0) {
 		int entry = dirty_tx % NUM_TX_DESC;
+		struct sk_buff *skb = tp->Tx_skbuff[entry];
+		u32 status = le32_to_cpu(tp->TxDescArray[entry].status);
 
-		if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
-			struct sk_buff *skb = tp->Tx_skbuff[entry];
+		if (status & OWNbit)
+			break;
 
-			/* FIXME: is it really accurate for TxErr ? */
-			tp->stats.tx_bytes += skb->len >= ETH_ZLEN ?
-					      skb->len : ETH_ZLEN;
-			tp->stats.tx_packets++;
-			rtl8169_unmap_tx_skb(tp->pci_dev, tp->Tx_skbuff + entry,
-					     tp->TxDescArray + entry);
-			dev_kfree_skb_irq(skb);
-			tp->Tx_skbuff[entry] = NULL;
-			dirty_tx++;
-			tx_left--;
-		}
+		/* FIXME: is it really accurate for TxErr ? */
+		tp->stats.tx_bytes += skb->len >= ETH_ZLEN ?
+				      skb->len : ETH_ZLEN;
+		tp->stats.tx_packets++;
+		rtl8169_unmap_tx_skb(tp->pci_dev, tp->Tx_skbuff + entry,
+				     tp->TxDescArray + entry);
+		dev_kfree_skb_irq(skb);
+		dirty_tx++;
+		tx_left--;
 	}
 
 	if (tp->dirty_tx != dirty_tx) {
@@ -1404,6 +1404,7 @@ rtl8169_rx_interrupt(struct net_device *
 {
 	unsigned long cur_rx, rx_left;
 	int delta;
+	int max_try = 8192;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -1412,7 +1413,7 @@ rtl8169_rx_interrupt(struct net_device *
 	cur_rx = tp->cur_rx;
 	rx_left = NUM_RX_DESC + tp->dirty_rx - cur_rx;
 
-	while (rx_left > 0) {
+	while ((rx_left > 0) && --max_try) {
 		int entry = cur_rx % NUM_RX_DESC;
 		u32 status = le32_to_cpu(tp->RxDescArray[entry].status);
 
@@ -1455,6 +1456,9 @@ rtl8169_rx_interrupt(struct net_device *
 		rx_left--;
 	}
 
+	if (!max_try)
+		printk(KERN_INFO "%s: strangeness in Rx handler", dev->name);
+
 	tp->cur_rx = cur_rx;
 
 	delta = rtl8169_rx_fill(tp, dev, tp->dirty_rx, tp->cur_rx);

_

--k1lZvvs/B4yU6o8G--
