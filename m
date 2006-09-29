Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWI2X3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWI2X3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWI2X3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:29:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3240 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932250AbWI2X3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:29:13 -0400
Date: Fri, 29 Sep 2006 18:29:11 -0500
To: jeff@garzik.org, akpm@osdl.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6]: powerpc/cell spidernet refine locking
Message-ID: <20060929232911.GN6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
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
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   77 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 17:39:06.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-09-29 17:41:19.000000000 -0500
@@ -646,8 +646,9 @@ static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
 			    struct sk_buff *skb)
 {
-	struct spider_net_descr *descr = card->tx_chain.head;
+	struct spider_net_descr *descr;
 	dma_addr_t buf;
+	unsigned long flags;
 
 	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(buf)) {
@@ -658,6 +659,10 @@ spider_net_prepare_tx_descr(struct spide
 		return -ENOMEM;
 	}
 
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	descr = card->tx_chain.head;
+	card->tx_chain.head = card->tx_chain.head->next;
+
 	descr->buf_addr = buf;
 	descr->buf_size = skb->len;
 	descr->next_descr_addr = 0;
@@ -666,6 +671,8 @@ spider_net_prepare_tx_descr(struct spide
 
 	descr->dmac_cmd_status =
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
@@ -676,37 +683,16 @@ spider_net_prepare_tx_descr(struct spide
 			break;
 		}
 
+	/* Chain the bus address, so that the DMA engine finds this descr. */
 	descr->prev->next_descr_addr = descr->bus_addr;
 
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
-
-	card->tx_chain.tail = card->tx_chain.tail->next;
-	descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
-
-	/* unmap the skb */
-	skb = descr->skb;
-	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
-			PCI_DMA_TODEVICE);
-	dev_kfree_skb_any(skb);
-}
-
 static void
 spider_net_set_low_watermark(struct spider_net_card *card)
 {
+	unsigned long flags;
 	int status;
 	int cnt=0;
 	int i;
@@ -730,11 +716,13 @@ spider_net_set_low_watermark(struct spid
 		descr = descr->next;
 
 	/* Set the new watermark, clear the old wtermark */
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
 	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
 	if (card->low_watermark && card->low_watermark != descr)
 		card->low_watermark->dmac_cmd_status =
 		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
 	card->low_watermark = descr;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
 /**
@@ -753,22 +741,30 @@ static int
 spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
 {
 	struct spider_net_descr_chain *chain = &card->tx_chain;
+	struct spider_net_descr *descr;
+	struct sk_buff *skb;
+	u32 buf_addr;
+	unsigned long flags;
 	int status;
 	int rc=0;
 
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
 			if (!brutal) {
 				rc = 1;
+				spin_unlock_irqrestore(&chain->lock, flags);
 				goto done;
 			}
 			/* fallthrough, if we release the descriptors
@@ -788,9 +784,19 @@ spider_net_release_tx_chain(struct spide
 		default:
 			card->netdev_stats.tx_dropped++;
 			rc = 1;
+			spin_unlock_irqrestore(&chain->lock, flags);
 			goto done;
 		}
-		spider_net_release_tx_descr(card);
+
+		chain->tail = chain->tail->next;
+		descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
+		skb = descr->skb;
+		buf_addr = descr->buf_addr;
+		spin_unlock_irqrestore(&chain->lock, flags);
+
+		/* unmap the skb */
+		pci_unmap_single(card->pdev, buf_addr, skb->len, PCI_DMA_TODEVICE);
+		dev_kfree_skb_any(skb);
 	}
 done:
 	if (rc == 1)
@@ -847,11 +853,8 @@ spider_net_xmit(struct sk_buff *skb, str
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	struct spider_net_descr *descr = chain->head;
-	unsigned long flags;
 	int result;
 
-	spin_lock_irqsave(&chain->lock, flags);
-
 	spider_net_release_tx_chain(card, 0);
 
 	if (chain->head->next == chain->tail->prev) {
@@ -873,12 +876,9 @@ spider_net_xmit(struct sk_buff *skb, str
 	}
 
 	result = NETDEV_TX_OK;
-
 	spider_net_kick_tx_dma(card);
-	card->tx_chain.head = card->tx_chain.head->next;
 
 out:
-	spin_unlock_irqrestore(&chain->lock, flags);
 	netif_wake_queue(netdev);
 	return result;
 }
@@ -895,15 +895,9 @@ out:
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&card->tx_chain.lock, flags);
-
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
 	    (card->netdev->flags & IFF_UP))
 		spider_net_kick_tx_dma(card);
-
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
