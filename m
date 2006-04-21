Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDUX3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDUX3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDUX3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:29:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2177 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750722AbWDUX3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:29:49 -0400
Date: Fri, 21 Apr 2006 18:29:42 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: benh@kernel.crashing.org, Maxim Shchetynin <maxim@de.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2]: Spider ethernet driver spinlocks
Message-ID: <20060421232942.GG7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please review/apply/ack/forward upstream.

--linas


The spider network driver currently uses hand-rolled spinlocks
in a few places. Replace these with industry standard spinlocks.
In particular, this should add some safety if multiple threads
are touching the tx and rx chain pointers.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   18 ++++++++----------
 drivers/net/spider_net.h |    4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

Index: linux-2.6.17-rc1/drivers/net/spider_net.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.c	2006-04-20 17:22:04.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.c	2006-04-21 11:52:39.000000000 -0500
@@ -335,8 +335,6 @@ spider_net_init_chain(struct spider_net_
 	struct spider_net_descr *descr;
 	dma_addr_t buf;
 
-	atomic_set(&card->rx_chain_refill,0);
-
 	descr = start_descr;
 	memset(descr, 0, sizeof(*descr) * no);
 
@@ -509,15 +507,15 @@ spider_net_refill_rx_chain(struct spider
 	 * and omitting it) is ok. If called by NAPI, we'll be called again
 	 * as spider_net_decode_one_descr is called several times. If some
 	 * interrupt calls us, the NAPI is about to clean up anyway. */
-	if (atomic_inc_return(&card->rx_chain_refill) == 1)
+	if (spin_trylock(&card->rx_chain_lock)) {
 		while (spider_net_get_descr_status(chain->head) ==
 		       SPIDER_NET_DESCR_NOT_IN_USE) {
 			if (spider_net_prepare_rx_descr(card, chain->head))
 				break;
 			chain->head = chain->head->next;
 		}
-
-	atomic_dec(&card->rx_chain_refill);
+		spin_unlock(&card->rx_chain_lock);
+	}
 }
 
 /**
@@ -596,10 +594,8 @@ spider_net_release_tx_chain(struct spide
 	struct spider_net_descr_chain *tx_chain = &card->tx_chain;
 	enum spider_net_descr_status status;
 
-	if (atomic_inc_return(&card->tx_chain_release) != 1) {
-		atomic_dec(&card->tx_chain_release);
+	if (!spin_trylock(&card->tx_chain_lock))
 		return 1;
-	}
 
 	for (;;) {
 		status = spider_net_get_descr_status(tx_chain->tail);
@@ -633,7 +629,7 @@ spider_net_release_tx_chain(struct spide
 		tx_chain->tail = tx_chain->tail->next;
 	}
 out:
-	atomic_dec(&card->tx_chain_release);
+	spin_unlock(&card->tx_chain_lock);
 
 	netif_wake_queue(card->netdev);
 
@@ -2072,7 +2068,9 @@ spider_net_setup_netdev(struct spider_ne
 
 	pci_set_drvdata(card->pdev, netdev);
 
-	atomic_set(&card->tx_chain_release,0);
+	spin_lock_init(&card->rx_chain_lock);
+	spin_lock_init(&card->tx_chain_lock);
+
 	card->rxram_full_tl.data = (unsigned long) card;
 	card->rxram_full_tl.func =
 		(void (*)(unsigned long)) spider_net_handle_rxram_full;
Index: linux-2.6.17-rc1/drivers/net/spider_net.h
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.h	2006-04-20 17:22:04.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.h	2006-04-21 11:47:17.000000000 -0500
@@ -451,8 +451,8 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
-	atomic_t rx_chain_refill;
-	atomic_t tx_chain_release;
+	spinlock_t rx_chain_lock;
+	spinlock_t tx_chain_lock;
 
 	struct net_device_stats netdev_stats;
 
