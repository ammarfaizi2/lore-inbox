Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWFURvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWFURvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFURvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:51:00 -0400
Received: from mail.gmx.de ([213.165.64.21]:19655 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932297AbWFURu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:50:59 -0400
X-Authenticated: #704063
Subject: Re: Possible leaks in network drivers
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, kmliu@sis.com
In-Reply-To: <1150909982.15275.100.camel@localhost.localdomain>
References: <1150907317.8320.0.camel@alice>
	 <1150909982.15275.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 19:50:56 +0200
Message-Id: <1150912256.8784.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 18:13 +0100, Alan Cox wrote:
> Ar Mer, 2006-06-21 am 18:28 +0200, ysgrifennodd Eric Sesterhenn:
> > of the driver. Where we call skb=skb_padto(skb, ETH_ZLEN),
> > and dont free the skb later when something goes wrong.
> 
> skb_padto() returns either a new buffer or the existing one depending
> upon the space situation. If it returns a new buffer then it frees the
> old one.
> 
> The sequence is
> 
> dev_queue_xmit(skb)
> 	->hard_start_xmit(dev, skb)
> 	if (0)
> 		free skb
> 	return
> 
> Which I think means that the error path for a short packet would double
> free the skb buffer and leak nskb.
> 
> 
> So these drivers should indeed be checking their status before they
> clone the buffer. At the point they do an skb_padto they must not fail
> if the skb_padto succeeds.

So something like this would be the correct fix for the example?

Fix skb leak found by coverity checker (id #628), skb_put() might
return a new skb, which gets never freed when we return with
NETDEV_TX_BUSY. This patch moves the check above the skb_put().

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/sis190.c.orig	2006-06-21 19:44:18.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/sis190.c	2006-06-21 19:46:06.000000000 +0200
@@ -1155,6 +1155,18 @@ static int sis190_start_xmit(struct sk_b
 	struct TxDesc *desc;
 	dma_addr_t mapping;
 
+
+	entry = tp->cur_tx % NUM_TX_DESC;
+	desc = tp->TxDescRing + entry;
+
+	if (unlikely(le32_to_cpu(desc->status) & OWNbit)) {
+		netif_stop_queue(dev);
+		net_tx_err(tp, KERN_ERR PFX
+			"%s: BUG! Tx Ring full when queue awake!\n",
+			dev->name);
+		return NETDEV_TX_BUSY;
+	}
+
 	if (unlikely(skb->len < ETH_ZLEN)) {
 		skb = skb_padto(skb, ETH_ZLEN);
 		if (!skb) {
@@ -1166,17 +1178,6 @@ static int sis190_start_xmit(struct sk_b
 		len = skb->len;
 	}
 
-	entry = tp->cur_tx % NUM_TX_DESC;
-	desc = tp->TxDescRing + entry;
-
-	if (unlikely(le32_to_cpu(desc->status) & OWNbit)) {
-		netif_stop_queue(dev);
-		net_tx_err(tp, KERN_ERR PFX
-			   "%s: BUG! Tx Ring full when queue awake!\n",
-			   dev->name);
-		return NETDEV_TX_BUSY;
-	}
-
 	mapping = pci_map_single(tp->pci_dev, skb->data, len, PCI_DMA_TODEVICE);
 
 	tp->Tx_skbuff[entry] = skb;


