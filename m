Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWJJVVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWJJVVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJJVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:21:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:2990 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030402AbWJJVVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:21:13 -0400
Date: Tue, 10 Oct 2006 16:21:10 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 19/21]: powerpc/cell spidernet DMA direction fix
Message-ID: <20061010212110.GP4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ring buffer descriptors are DMA-accessed bidirectionally,
but are not declared in this way.  Fix this.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:35:33.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:37:40.000000000 -0500
@@ -301,7 +301,7 @@ static int
 spider_net_init_chain(struct spider_net_card *card,
 		       struct spider_net_descr_chain *chain,
 		       struct spider_net_descr *start_descr,
-		       int direction, int no)
+		       int no)
 {
 	int i;
 	struct spider_net_descr *descr;
@@ -316,7 +316,7 @@ spider_net_init_chain(struct spider_net_
 
 		buf = pci_map_single(card->pdev, descr,
 				     SPIDER_NET_DESCR_SIZE,
-				     direction);
+				     PCI_DMA_BIDIRECTIONAL);
 
 		if (pci_dma_mapping_error(buf))
 			goto iommu_error;
@@ -330,11 +330,6 @@ spider_net_init_chain(struct spider_net_
 	(descr-1)->next = start_descr;
 	start_descr->prev = descr-1;
 
-	descr = start_descr;
-	if (direction == PCI_DMA_FROMDEVICE)
-		for (i=0; i < no; i++, descr++)
-			descr->next_descr_addr = descr->next->bus_addr;
-
 	spin_lock_init(&chain->lock);
 	chain->head = start_descr;
 	chain->tail = start_descr;
@@ -347,7 +342,7 @@ iommu_error:
 		if (descr->bus_addr)
 			pci_unmap_single(card->pdev, descr->bus_addr,
 					 SPIDER_NET_DESCR_SIZE,
-					 direction);
+					 PCI_DMA_BIDIRECTIONAL);
 	return -ENOMEM;
 }
 
@@ -368,7 +363,7 @@ spider_net_free_rx_chain_contents(struct
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
 					 SPIDER_NET_MAX_FRAME,
-					 PCI_DMA_FROMDEVICE);
+					 PCI_DMA_BIDIRECTIONAL);
 		}
 		descr = descr->next;
 	}
@@ -1662,21 +1657,26 @@ int
 spider_net_open(struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
-	int result;
+	struct spider_net_descr *descr;
+	int i, result;
 
 	result = -ENOMEM;
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
-			PCI_DMA_TODEVICE, card->num_tx_desc))
+	                          card->num_tx_desc))
 		goto alloc_tx_failed;
 
 	card->low_watermark = NULL;
 
 	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->num_tx_desc,
-			PCI_DMA_FROMDEVICE, card->num_rx_desc))
+	                          card->descr + card->num_tx_desc,
+	                          card->num_rx_desc))
 		goto alloc_rx_failed;
 
+	descr = card->rx_chain.head;
+	for (i=0; i < card->num_rx_desc; i++, descr++)
+		descr->next_descr_addr = descr->next->bus_addr;
+
 	/* allocate rx skbs */
 	if (spider_net_alloc_rx_skbs(card))
 		goto alloc_skbs_failed;
