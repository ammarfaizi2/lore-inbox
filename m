Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWJJVSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWJJVSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWJJVSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:18:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38546 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030416AbWJJVSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:18:20 -0400
Date: Tue, 10 Oct 2006 16:18:18 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 17/21]: powerpc/cell spidernet reduce DMA kicking
Message-ID: <20061010211818.GN4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current code attempts to start the TX dma every time a packet
is queued. This is too conservative, and wastes CPU time. This
patch changes behaviour to call the kick-dma function less often, 
only when the tx queue is at risk of emptying.

This reduces cpu usage, improves performance.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:21:41.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:28:43.000000000 -0500
@@ -698,7 +698,7 @@ spider_net_prepare_tx_descr(struct spide
 	return 0;
 }
 
-static void
+static int
 spider_net_set_low_watermark(struct spider_net_card *card)
 {
 	unsigned long flags;
@@ -719,7 +719,7 @@ spider_net_set_low_watermark(struct spid
 
 	/* If TX queue is short, don't even bother with interrupts */
 	if (cnt < card->tx_desc/4)
-		return;
+		return cnt;
 
 	/* Set low-watermark 3/4th's of the way into the queue. */
 	descr = card->tx_chain.tail;
@@ -735,6 +735,7 @@ spider_net_set_low_watermark(struct spid
 		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
 	card->low_watermark = descr;
 	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+	return cnt;
 }
 
 /**
@@ -819,8 +820,12 @@ spider_net_release_tx_chain(struct spide
  * @card: card structure
  * @descr: descriptor address to enable TX processing at
  *
- * spider_net_kick_tx_dma writes the current tx chain head as start address
- * of the tx descriptor chain and enables the transmission DMA engine
+ * This routine will start the transmit DMA running if
+ * it is not already running. This routine ned only be
+ * called when queueing a new packet to an empty tx queue.
+ * Writes the current tx chain head as start address
+ * of the tx descriptor chain and enables the transmission
+ * DMA engine.
  */
 static inline void
 spider_net_kick_tx_dma(struct spider_net_card *card)
@@ -860,6 +865,7 @@ out:
 static int
 spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
+	int cnt;
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 
@@ -873,8 +879,9 @@ spider_net_xmit(struct sk_buff *skb, str
 		return NETDEV_TX_BUSY;
 	}
 
-	spider_net_set_low_watermark(card);
-	spider_net_kick_tx_dma(card);
+	cnt = spider_net_set_low_watermark(card);
+	if (cnt < 5)
+		spider_net_kick_tx_dma(card);
 	return NETDEV_TX_OK;
 }
 
