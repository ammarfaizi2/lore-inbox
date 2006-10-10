Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWJJVX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWJJVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWJJVX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:23:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46506 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030424AbWJJVX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:23:27 -0400
Date: Tue, 10 Oct 2006 16:23:24 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
Message-ID: <20061010212324.GR4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current driver code performs 512 DMA mappns of a bunch of 
32-byte structures. This is silly, as they are all in contiguous 
memory. Ths patch changes the code to DMA map the entie area
with just one call.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |  107 +++++++++++++++++++++++------------------------
 drivers/net/spider_net.h |   16 ++-----
 2 files changed, 59 insertions(+), 64 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:40:56.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:42:12.000000000 -0500
@@ -267,25 +267,6 @@ spider_net_get_descr_status(struct spide
 }
 
 /**
- * spider_net_free_chain - free descriptor chain
- * @card: card structure
- * @chain: address of chain
- *
- */
-static void
-spider_net_free_chain(struct spider_net_card *card,
-		      struct spider_net_descr_chain *chain)
-{
-	struct spider_net_descr *descr;
-
-	for (descr = chain->tail; !descr->bus_addr; descr = descr->next) {
-		pci_unmap_single(card->pdev, descr->bus_addr,
-				 SPIDER_NET_DESCR_SIZE, PCI_DMA_BIDIRECTIONAL);
-		descr->bus_addr = 0;
-	}
-}
-
-/**
  * spider_net_init_chain - links descriptor chain
  * @card: card structure
  * @chain: address of chain
@@ -297,15 +278,15 @@ spider_net_free_chain(struct spider_net_
  *
  * returns 0 on success, <0 on failure
  */
-static int
+static void
 spider_net_init_chain(struct spider_net_card *card,
 		       struct spider_net_descr_chain *chain,
 		       struct spider_net_descr *start_descr,
+		       dma_addr_t buf,
 		       int no)
 {
 	int i;
 	struct spider_net_descr *descr;
-	dma_addr_t buf;
 
 	descr = start_descr;
 	memset(descr, 0, sizeof(*descr) * no);
@@ -314,17 +295,12 @@ spider_net_init_chain(struct spider_net_
 	for (i=0; i<no; i++, descr++) {
 		descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 
-		buf = pci_map_single(card->pdev, descr,
-				     SPIDER_NET_DESCR_SIZE,
-				     PCI_DMA_BIDIRECTIONAL);
-
-		if (pci_dma_mapping_error(buf))
-			goto iommu_error;
-
 		descr->bus_addr = buf;
+		descr->next_descr_addr = 0;
 		descr->next = descr + 1;
 		descr->prev = descr - 1;
 
+		buf += sizeof(struct spider_net_descr);
 	}
 	/* do actual circular list */
 	(descr-1)->next = start_descr;
@@ -333,17 +309,6 @@ spider_net_init_chain(struct spider_net_
 	spin_lock_init(&chain->lock);
 	chain->head = start_descr;
 	chain->tail = start_descr;
-
-	return 0;
-
-iommu_error:
-	descr = start_descr;
-	for (i=0; i < no; i++, descr++)
-		if (descr->bus_addr)
-			pci_unmap_single(card->pdev, descr->bus_addr,
-					 SPIDER_NET_DESCR_SIZE,
-					 PCI_DMA_BIDIRECTIONAL);
-	return -ENOMEM;
 }
 
 /**
@@ -1658,24 +1623,32 @@ spider_net_open(struct net_device *netde
 {
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr *descr;
-	int i, result;
+	int result = -ENOMEM;
 
-	result = -ENOMEM;
-	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
-	                          card->num_tx_desc))
-		goto alloc_tx_failed;
+	card->descr_dma_addr = pci_map_single(card->pdev, card->descr,
+	        (card->num_tx_desc+card->num_rx_desc)*sizeof(struct spider_net_descr),
+				     PCI_DMA_BIDIRECTIONAL);
+	if (pci_dma_mapping_error(card->descr_dma_addr))
+		return -ENOMEM;
+
+	spider_net_init_chain(card, &card->tx_chain, card->descr,
+	                          card->descr_dma_addr,
+	                          card->num_tx_desc);
 
 	card->low_watermark = NULL;
 
 	/* rx_chain is after tx_chain, so offset is descr + tx_count */
-	if (spider_net_init_chain(card, &card->rx_chain,
+	spider_net_init_chain(card, &card->rx_chain,
 	                          card->descr + card->num_tx_desc,
-	                          card->num_rx_desc))
-		goto alloc_rx_failed;
+	                          card->descr_dma_addr
+					+ card->num_tx_desc * sizeof(struct spider_net_descr),
+	                          card->num_rx_desc);
 
 	descr = card->rx_chain.head;
-	for (i=0; i < card->num_rx_desc; i++, descr++)
+	do {
 		descr->next_descr_addr = descr->next->bus_addr;
+		descr = descr->next;
+	} while (descr != card->rx_chain.head);
 
 	/* allocate rx skbs */
 	if (spider_net_alloc_rx_skbs(card))
@@ -1701,10 +1674,21 @@ spider_net_open(struct net_device *netde
 register_int_failed:
 	spider_net_free_rx_chain_contents(card);
 alloc_skbs_failed:
-	spider_net_free_chain(card, &card->rx_chain);
-alloc_rx_failed:
-	spider_net_free_chain(card, &card->tx_chain);
-alloc_tx_failed:
+	descr = card->rx_chain.head;
+	do {
+		descr->bus_addr = 0;
+		descr = descr->next;
+	} while (descr != card->rx_chain.head);
+
+	descr = card->tx_chain.head;
+	do {
+		descr->bus_addr = 0;
+		descr = descr->next;
+	} while (descr != card->tx_chain.head);
+
+	pci_unmap_single(card->pdev, card->descr_dma_addr,
+	   (card->num_tx_desc+card->num_rx_desc)*sizeof(struct spider_net_descr),
+	                 PCI_DMA_BIDIRECTIONAL);
 	return result;
 }
 
@@ -1907,6 +1891,7 @@ int
 spider_net_stop(struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
+	struct spider_net_descr *descr;
 
 	tasklet_kill(&card->rxram_full_tl);
 	netif_poll_disable(netdev);
@@ -1930,9 +1915,23 @@ spider_net_stop(struct net_device *netde
 
 	/* release chains */
 	spider_net_release_tx_chain(card, 1);
+	spider_net_free_rx_chain_contents(card);
+
+	descr = card->rx_chain.head;
+	do {
+		descr->bus_addr = 0;
+		descr = descr->next;
+	} while (descr != card->rx_chain.head);
+
+	descr = card->tx_chain.head;
+	do {
+		descr->bus_addr = 0;
+		descr = descr->next;
+	} while (descr != card->tx_chain.head);
 
-	spider_net_free_chain(card, &card->tx_chain);
-	spider_net_free_chain(card, &card->rx_chain);
+	pci_unmap_single(card->pdev, card->descr_dma_addr,
+	      (card->num_tx_desc+card->num_rx_desc)*sizeof(struct spider_net_descr),
+	                 PCI_DMA_BIDIRECTIONAL);
 
 	return 0;
 }
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-10 13:35:33.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-10 13:42:12.000000000 -0500
@@ -397,8 +397,6 @@ struct spider_net_descr_chain {
  * 701b8000 would be correct, but every packets gets that flag */
 #define SPIDER_NET_DESTROY_RX_FLAGS	0x700b8000
 
-#define SPIDER_NET_DESCR_SIZE		32
-
 /* this will be bigger some time */
 struct spider_net_options {
 	int rx_csum; /* for rx: if 0 ip_summed=NONE,
@@ -437,28 +435,26 @@ struct spider_net_card {
 
 	void __iomem *regs;
 
+	int num_rx_desc;
+	int num_tx_desc;
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
 	struct spider_net_descr *low_watermark;
+	dma_addr_t descr_dma_addr;
 
-	struct net_device_stats netdev_stats;
-
-	struct spider_net_options options;
-
-	spinlock_t intmask_lock;
 	struct tasklet_struct rxram_full_tl;
 	struct timer_list tx_timer;
-
 	struct work_struct tx_timeout_task;
 	atomic_t tx_timeout_task_counter;
 	wait_queue_head_t waitq;
 
 	/* for ethtool */
 	int msg_enable;
-	int num_rx_desc;
-	int num_tx_desc;
+	struct net_device_stats netdev_stats;
 	struct spider_net_extra_stats spider_stats;
+	struct spider_net_options options;
 
+	/* Must be last element in the structure */
 	struct spider_net_descr descr[0];
 };
 
