Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWHRW3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWHRW3G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbWHRW3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:29:06 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19150 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964808AbWHRW3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:29:04 -0400
Date: Fri, 18 Aug 2006 17:29:02 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: [PATCH 6/6]:  powerpc/cell spidernet refine locking
Message-ID: <20060818222902.GM26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
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

This, with the previous patches, result in the following 
performance, using netperf, averaged over 5 minute runs:

pkt size    rate
--------    ----
1500        804 Mbits/sec
 800        701 Mbits/sec
 600        600 Mbits/sec
 300        280 Mbits/sec
  60         60 Mbits/sec


Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>

----
 drivers/net/spider_net.c |   77 ++++++++++++++++++++---------------------------
 drivers/net/spider_net.h |    2 -
 2 files changed, 35 insertions(+), 44 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-15 14:28:56.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-15 14:29:36.000000000 -0500
@@ -644,8 +644,9 @@ static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
 			    struct sk_buff *skb)
 {
-	struct spider_net_descr *descr = card->tx_chain.head;
+	struct spider_net_descr *descr;
 	dma_addr_t buf;
+	unsigned long flags;
 
 	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	if (buf == DMA_ERROR_CODE) {
@@ -655,6 +656,10 @@ spider_net_prepare_tx_descr(struct spide
 		return -ENOMEM;
 	}
 
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	descr = card->tx_chain.head;
+	card->tx_chain.head = card->tx_chain.head->next;
+
 	descr->buf_addr = buf;
 	descr->buf_size = skb->len;
 	descr->next_descr_addr = 0;
@@ -663,6 +668,8 @@ spider_net_prepare_tx_descr(struct spide
 
 	descr->dmac_cmd_status =
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
@@ -673,37 +680,16 @@ spider_net_prepare_tx_descr(struct spide
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
@@ -727,11 +713,13 @@ spider_net_set_low_watermark(struct spid
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
@@ -750,22 +738,30 @@ static int
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
@@ -785,9 +781,19 @@ spider_net_release_tx_chain(struct spide
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
@@ -844,11 +850,8 @@ spider_net_xmit(struct sk_buff *skb, str
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	struct spider_net_descr *descr = chain->head;
-	unsigned long flags;
 	int result;
 
-	spin_lock_irqsave(&chain->lock, flags);
-
 	spider_net_release_tx_chain(card, 0);
 
 	if (chain->head->next == chain->tail->prev) {
@@ -869,12 +872,9 @@ spider_net_xmit(struct sk_buff *skb, str
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
@@ -891,17 +891,11 @@ out:
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
-
-	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
 static void
@@ -1932,10 +1926,7 @@ spider_net_stop(struct net_device *netde
 	spider_net_disable_rxdmac(card);
 
 	/* release chains */
-	if (spin_trylock(&card->tx_chain.lock)) {
-		spider_net_release_tx_chain(card, 1);
-		spin_unlock(&card->tx_chain.lock);
-	}
+	spider_net_release_tx_chain(card, 1);
 
 	spider_net_free_chain(card, &card->tx_chain);
 	spider_net_free_chain(card, &card->rx_chain);
Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-15 14:28:56.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-15 14:29:36.000000000 -0500
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.1 B"
+#define VERSION "1.1 C"
 
 #include "sungem_phy.h"
 
