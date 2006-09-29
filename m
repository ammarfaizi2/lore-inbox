Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWI2X0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWI2X0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWI2X03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:26:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2224 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932243AbWI2X02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:26:28 -0400
Date: Fri, 29 Sep 2006 18:26:25 -0500
To: jeff@garzik.org, akpm@osdl.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6]: powerpc/cell spidernet ethtool -i version number
Message-ID: <20060929232625.GM6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim, as the official maintainer, you should explicitly ack this patch.
--linas

This patch moves transmit queue cleanup code out of the 
interrupt context, and into the NAPI polling routine.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 17:01:39.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-09-29 17:39:06.000000000 -0500
@@ -887,9 +887,10 @@ out:
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
@@ -1093,6 +1094,7 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1505,10 +1507,8 @@ spider_net_interrupt(int irq, void *ptr,
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
