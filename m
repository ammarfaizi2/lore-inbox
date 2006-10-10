Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWJJVEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWJJVEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWJJVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:04:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48307 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030383AbWJJVEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:04:02 -0400
Date: Tue, 10 Oct 2006 16:04:00 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 8/21]: Spidernet stop queue when queue is full.
Message-ID: <20061010210400.GE4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a call to netif_stop_queue() when there is
no more room for more packets on the transmit queue.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:51:26.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:52:42.000000000 -0500
@@ -823,39 +823,25 @@ spider_net_xmit(struct sk_buff *skb, str
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	struct spider_net_descr *descr = chain->head;
 	unsigned long flags;
-	int result;
 
 	spin_lock_irqsave(&chain->lock, flags);
 
 	spider_net_release_tx_chain(card, 0);
 
-	if (chain->head->next == chain->tail->prev) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
-	}
+	if ((chain->head->next == chain->tail->prev) ||
+	   (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) ||
+	   (spider_net_prepare_tx_descr(card, skb) != 0)) {
 
-	if (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) {
 		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
+		spin_unlock_irqrestore(&chain->lock, flags);
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
 	}
 
-	if (spider_net_prepare_tx_descr(card, skb) != 0) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_BUSY;
-		goto out;
-	}
-
-	result = NETDEV_TX_OK;
-
 	spider_net_kick_tx_dma(card);
 	card->tx_chain.head = card->tx_chain.head->next;
-
-out:
 	spin_unlock_irqrestore(&chain->lock, flags);
-	netif_wake_queue(netdev);
-	return result;
+	return NETDEV_TX_OK;
 }
 
 /**
@@ -874,9 +860,10 @@ spider_net_cleanup_tx_ring(struct spider
 	spin_lock_irqsave(&card->tx_chain.lock, flags);
 
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
-	    (card->netdev->flags & IFF_UP))
+	    (card->netdev->flags & IFF_UP)) {
 		spider_net_kick_tx_dma(card);
-
+		netif_wake_queue(card->netdev);
+	}
 	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
