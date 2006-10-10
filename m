Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWJJVNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWJJVNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWJJVNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:13:11 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44247 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030399AbWJJVNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:13:07 -0400
Date: Tue, 10 Oct 2006 16:13:05 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 14/21]: powerpc/cell spidernet NAPI polling info.
Message-ID: <20061010211305.GK4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves transmit queue cleanup code out of the 
interrupt context, and into the NAPI polling routine.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: James K Lewis <jklewis@us.ibm.com>

----

 drivers/net/spider_net.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:09:27.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:10:37.000000000 -0500
@@ -715,7 +715,7 @@ spider_net_release_tx_descr(struct spide
 	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
 	pci_unmap_single(card->pdev, descr->buf_addr, len,
 			PCI_DMA_TODEVICE);
-	dev_kfree_skb_any(skb);
+	dev_kfree_skb(skb);
 }
 
 static void
@@ -885,9 +885,10 @@ spider_net_xmit(struct sk_buff *skb, str
  * spider_net_cleanup_tx_ring - cleans up the TX ring
  * @card: card structure
  *
- * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
- * interrupts to cleanup our TX ring) and returns sent packets to the stack
- * by freeing them
+ * spider_net_cleanup_tx_ring is called by either the tx_timer
+ * or from the NAPI polling routine.
+ * This routine releases resources associted with transmitted
+ * packets, including updating the queue tail pointer.
  */
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
@@ -1092,6 +1093,7 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1504,10 +1506,8 @@ spider_net_interrupt(int irq, void *ptr,
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
-	if (status_reg & SPIDER_NET_TXINT ) {
-		spider_net_cleanup_tx_ring(card);
-		netif_wake_queue(netdev);
-	}
+	if (status_reg & SPIDER_NET_TXINT)
+		netif_rx_schedule(netdev);
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
