Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWHPQTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHPQTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHPQTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:19:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18614 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751121AbWHPQTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:19:00 -0400
Date: Wed, 16 Aug 2006 11:18:56 -0500
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, akpm@osdl.org,
       jeff@garzik.org
Subject: [PATCH 1/2]:  powerpc/cell spidernet bottom half
Message-ID: <20060816161856.GD20551@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811170337.GH10638@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply and forward upstream. This patch requires the previous
sequence of 4 spidernet patches to be applied.

--linas


The recent set of low-waterark patches for the spider result in a
significant amount of computing being done in an interrupt context.
This patch moves this to a "bottom half" aka work queue, so that
the code runs in a normal kernel context. Curiously, this seems to 
result in a performance boost of about 5% for large packets.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>

----
 drivers/net/spider_net.c |   21 +++++++++++++++------
 drivers/net/spider_net.h |    4 +++-
 2 files changed, 18 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-15 14:25:50.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-15 14:28:56.000000000 -0500
@@ -883,9 +883,10 @@ out:
  * spider_net_cleanup_tx_ring - cleans up the TX ring
  * @card: card structure
  *
- * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
- * interrupts to cleanup our TX ring) and returns sent packets to the stack
- * by freeing them
+ * spider_net_cleanup_tx_ring is called by either the tx_timer
+ * or from a work-queue scheduled by the tx-empty interrupt.
+ * This routine releases resources associted with transmitted
+ * packets, including updating the queue tail pointer.
  */
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
@@ -895,12 +896,20 @@ spider_net_cleanup_tx_ring(struct spider
 	spin_lock_irqsave(&card->tx_chain.lock, flags);
 
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
-	    (card->netdev->flags & IFF_UP))
+	    (card->netdev->flags & IFF_UP)) {
 		spider_net_kick_tx_dma(card);
+		netif_wake_queue(card->netdev);
+	}
 
 	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
+static void
+spider_net_tx_cleanup_task(void * data)
+{
+	spider_net_cleanup_tx_ring((struct spider_net_card *) data);
+}
+
 /**
  * spider_net_do_ioctl - called for device ioctls
  * @netdev: interface device structure
@@ -1499,8 +1508,7 @@ spider_net_interrupt(int irq, void *ptr,
 		netif_rx_schedule(netdev);
 	}
 	if (status_reg & SPIDER_NET_TXINT ) {
-		spider_net_cleanup_tx_ring(card);
-		netif_wake_queue(netdev);
+		schedule_work(&card->tx_cleanup_task);
 	}
 
 	if (status_reg & SPIDER_NET_ERRINT )
@@ -2117,6 +2125,7 @@ spider_net_alloc_card(void)
 	card->netdev = netdev;
 	card->msg_enable = SPIDER_NET_DEFAULT_MSG;
 	INIT_WORK(&card->tx_timeout_task, spider_net_tx_timeout_task, netdev);
+	INIT_WORK(&card->tx_cleanup_task, spider_net_tx_cleanup_task, card);
 	init_waitqueue_head(&card->waitq);
 	atomic_set(&card->tx_timeout_task_counter, 0);
 
Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-15 14:25:50.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-15 14:28:56.000000000 -0500
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.1 A"
+#define VERSION "1.1 B"
 
 #include "sungem_phy.h"
 
@@ -441,6 +441,8 @@ struct spider_net_card {
 	atomic_t tx_timeout_task_counter;
 	wait_queue_head_t waitq;
 
+	struct work_struct tx_cleanup_task;
+
 	/* for ethtool */
 	int msg_enable;
 
