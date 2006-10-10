Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWJJVOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWJJVOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJJVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:14:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34996 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030406AbWJJVOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:14:36 -0400
Date: Tue, 10 Oct 2006 16:14:29 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 15/21]: powerpc/cell spidernet refine locking
Message-ID: <20061010211429.GL4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The transmit side of the spider ethernet driver currently
places locks around some very large chunks of code. This
results in a fair amount of lock contention is some cases. 
This patch makes the locks much more fine-grained, protecting
only the cirtical sections. One lock is used to protect 
three locations: the queue head and tail pointers, and the 
queue low-watermark location.


Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James K Lewis <jklewis@us.ibm.com>

----
 drivers/net/spider_net.c |   95 +++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 52 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:10:37.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:20:08.000000000 -0500
@@ -646,8 +646,9 @@ static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
 			    struct sk_buff *skb)
 {
-	struct spider_net_descr *descr = card->tx_chain.head;
+	struct spider_net_descr *descr;
 	dma_addr_t buf;
+	unsigned long flags;
 	int length;
 
 	length = skb->len;
@@ -666,6 +667,10 @@ spider_net_prepare_tx_descr(struct spide
 		return -ENOMEM;
 	}
 
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	descr = card->tx_chain.head;
+	card->tx_chain.head = descr->next;
+
 	descr->buf_addr = buf;
 	descr->buf_size = length;
 	descr->next_descr_addr = 0;
@@ -674,6 +679,8 @@ spider_net_prepare_tx_descr(struct spide
 
 	descr->dmac_cmd_status =
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
@@ -691,42 +698,17 @@ spider_net_prepare_tx_descr(struct spide
 	return 0;
 }
 
-/**
- * spider_net_release_tx_descr - processes a used tx descriptor
- * @card: card structure
- * @descr: descriptor to release
- *
- * releases a used tx descriptor (unmapping, freeing of skb)
- */
-static inline void
-spider_net_release_tx_descr(struct spider_net_card *card)
-{
-	struct spider_net_descr *descr = card->tx_chain.tail;
-	struct sk_buff *skb;
-	unsigned int len;
-
-	card->tx_chain.tail = card->tx_chain.tail->next;
-	descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
-
-	/* unmap the skb */
-	skb = descr->skb;
-	if (!skb)
-		return;
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
-	pci_unmap_single(card->pdev, descr->buf_addr, len,
-			PCI_DMA_TODEVICE);
-	dev_kfree_skb(skb);
-}
-
 static void
 spider_net_set_low_watermark(struct spider_net_card *card)
 {
+	unsigned long flags;
 	int status;
 	int cnt=0;
 	int i;
 	struct spider_net_descr *descr = card->tx_chain.tail;
 
-	/* Measure the length of the queue. */
+	/* Measure the length of the queue. Measurement does not
+	 * need to be precise -- does not need a lock. */
 	while (descr != card->tx_chain.head) {
 		status = descr->dmac_cmd_status & SPIDER_NET_DESCR_NOT_IN_USE;
 		if (status == SPIDER_NET_DESCR_NOT_IN_USE)
@@ -746,11 +728,13 @@ spider_net_set_low_watermark(struct spid
 		descr = descr->next;
 
 	/* Set the new watermark, clear the old watermark */
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
 	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
 	if (card->low_watermark && card->low_watermark != descr)
 		card->low_watermark->dmac_cmd_status =
 		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
 	card->low_watermark = descr;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
 /**
@@ -769,21 +753,31 @@ static int
 spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
 {
 	struct spider_net_descr_chain *chain = &card->tx_chain;
+	struct spider_net_descr *descr;
+	struct sk_buff *skb;
+	u32 buf_addr;
+	unsigned long flags;
 	int status;
 
 	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
 
 	while (chain->tail != chain->head) {
-		status = spider_net_get_descr_status(chain->tail);
+		spin_lock_irqsave(&chain->lock, flags);
+		descr = chain->tail;
+
+		status = spider_net_get_descr_status(descr);
 		switch (status) {
 		case SPIDER_NET_DESCR_COMPLETE:
 			card->netdev_stats.tx_packets++;
-			card->netdev_stats.tx_bytes += chain->tail->skb->len;
+			card->netdev_stats.tx_bytes += descr->skb->len;
 			break;
 
 		case SPIDER_NET_DESCR_CARDOWNED:
-			if (!brutal)
+			if (!brutal) {
+				spin_unlock_irqrestore(&chain->lock, flags);
 				return 1;
+			}
+
 			/* fallthrough, if we release the descriptors
 			 * brutally (then we don't care about
 			 * SPIDER_NET_DESCR_CARDOWNED) */
@@ -800,12 +794,25 @@ spider_net_release_tx_chain(struct spide
 
 		default:
 			card->netdev_stats.tx_dropped++;
-			if (!brutal)
+			if (!brutal) {
+				spin_unlock_irqrestore(&chain->lock, flags);
 				return 1;
+			}
 		}
-		spider_net_release_tx_descr(card);
-	}
 
+		chain->tail = descr->next;
+		descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
+		skb = descr->skb;
+		buf_addr = descr->buf_addr;
+		spin_unlock_irqrestore(&chain->lock, flags);
+
+		/* unmap the skb */
+		if (skb) {
+			int len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+			pci_unmap_single(card->pdev, buf_addr, len, PCI_DMA_TODEVICE);
+			dev_kfree_skb(skb);
+		}
+	}
 	return 0;
 }
 
@@ -857,27 +864,19 @@ spider_net_xmit(struct sk_buff *skb, str
 {
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
-	struct spider_net_descr *descr = chain->head;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chain->lock, flags);
 
 	spider_net_release_tx_chain(card, 0);
 
 	if ((chain->head->next == chain->tail->prev) ||
-	   (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) ||
 	   (spider_net_prepare_tx_descr(card, skb) != 0)) {
 
 		card->netdev_stats.tx_dropped++;
-		spin_unlock_irqrestore(&chain->lock, flags);
 		netif_stop_queue(netdev);
 		return NETDEV_TX_BUSY;
 	}
 
 	spider_net_set_low_watermark(card);
 	spider_net_kick_tx_dma(card);
-	card->tx_chain.head = card->tx_chain.head->next;
-	spin_unlock_irqrestore(&chain->lock, flags);
 	return NETDEV_TX_OK;
 }
 
@@ -893,16 +892,11 @@ spider_net_xmit(struct sk_buff *skb, str
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&card->tx_chain.lock, flags);
-
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
 	    (card->netdev->flags & IFF_UP)) {
 		spider_net_kick_tx_dma(card);
 		netif_wake_queue(card->netdev);
 	}
-	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
 /**
@@ -1930,10 +1924,7 @@ spider_net_stop(struct net_device *netde
 	spider_net_disable_rxdmac(card);
 
 	/* release chains */
-	if (spin_trylock(&card->tx_chain.lock)) {
-		spider_net_release_tx_chain(card, 1);
-		spin_unlock(&card->tx_chain.lock);
-	}
+	spider_net_release_tx_chain(card, 1);
 
 	spider_net_free_chain(card, &card->tx_chain);
 	spider_net_free_chain(card, &card->rx_chain);
