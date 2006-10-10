Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWJJVTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWJJVTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJJVTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:19:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:38825 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030410AbWJJVTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:19:37 -0400
Date: Tue, 10 Oct 2006 16:19:34 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 18/21]: powerpc/cell spidernet variable name change
Message-ID: <20061010211934.GO4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cosmetic patch: give the variable holding the numer of descriptors
a more descriptive name, so to avoid confusion.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c         |   12 ++++++------
 drivers/net/spider_net.h         |    4 ++--
 drivers/net/spider_net_ethtool.c |    4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:28:43.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:35:33.000000000 -0500
@@ -718,7 +718,7 @@ spider_net_set_low_watermark(struct spid
 	}
 
 	/* If TX queue is short, don't even bother with interrupts */
-	if (cnt < card->tx_desc/4)
+	if (cnt < card->num_tx_desc/4)
 		return cnt;
 
 	/* Set low-watermark 3/4th's of the way into the queue. */
@@ -1666,15 +1666,15 @@ spider_net_open(struct net_device *netde
 
 	result = -ENOMEM;
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
-			PCI_DMA_TODEVICE, card->tx_desc))
+			PCI_DMA_TODEVICE, card->num_tx_desc))
 		goto alloc_tx_failed;
 
 	card->low_watermark = NULL;
 
 	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->tx_desc,
-			PCI_DMA_FROMDEVICE, card->rx_desc))
+			card->descr + card->num_tx_desc,
+			PCI_DMA_FROMDEVICE, card->num_rx_desc))
 		goto alloc_rx_failed;
 
 	/* allocate rx skbs */
@@ -2060,8 +2060,8 @@ spider_net_setup_netdev(struct spider_ne
 
 	card->options.rx_csum = SPIDER_NET_RX_CSUM_DEFAULT;
 
-	card->tx_desc = tx_descriptors;
-	card->rx_desc = rx_descriptors;
+	card->num_tx_desc = tx_descriptors;
+	card->num_rx_desc = rx_descriptors;
 
 	spider_net_setup_netdev_ops(netdev);
 
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-10 13:09:27.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-10 13:35:33.000000000 -0500
@@ -455,8 +455,8 @@ struct spider_net_card {
 
 	/* for ethtool */
 	int msg_enable;
-	int rx_desc;
-	int tx_desc;
+	int num_rx_desc;
+	int num_tx_desc;
 	struct spider_net_extra_stats spider_stats;
 
 	struct spider_net_descr descr[0];
Index: linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net_ethtool.c	2006-10-10 12:20:05.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c	2006-10-10 13:35:33.000000000 -0500
@@ -158,9 +158,9 @@ spider_net_ethtool_get_ringparam(struct 
 	struct spider_net_card *card = netdev->priv;
 
 	ering->tx_max_pending = SPIDER_NET_TX_DESCRIPTORS_MAX;
-	ering->tx_pending = card->tx_desc;
+	ering->tx_pending = card->num_tx_desc;
 	ering->rx_max_pending = SPIDER_NET_RX_DESCRIPTORS_MAX;
-	ering->rx_pending = card->rx_desc;
+	ering->rx_pending = card->num_rx_desc;
 }
 
 static int spider_net_get_stats_count(struct net_device *netdev)
