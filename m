Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVBDKW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVBDKW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVBDKW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:22:57 -0500
Received: from ozlabs.org ([203.10.76.45]:16011 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261854AbVBDKWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:22:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.19658.366944.187463@cargo.ozlabs.ibm.com>
Date: Fri, 4 Feb 2005 21:22:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: sfr@canb.auug.org.au, anton@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 replace last usage of vio dma mapping routines
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Stephen Rothwell <sfr@canb.auug.org.au>.

This patch just replaces the last usage of the vio dma mapping routines
with the equivalent generic dma mapping routines.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -ruNp linus-bk/drivers/net/ibmveth.c linus-bk-vio.1/drivers/net/ibmveth.c
--- linus-bk/drivers/net/ibmveth.c	2004-12-08 04:06:06.000000000 +1100
+++ linus-bk-vio.1/drivers/net/ibmveth.c	2005-01-31 16:45:28.000000000 +1100
@@ -218,7 +218,8 @@ static void ibmveth_replenish_buffer_poo
 		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
 		ibmveth_assert(pool->skbuff[index] == NULL);
 
-		dma_addr = vio_map_single(adapter->vdev, skb->data, pool->buff_size, DMA_FROM_DEVICE);
+		dma_addr = dma_map_single(&adapter->vdev->dev, skb->data,
+				pool->buff_size, DMA_FROM_DEVICE);
 
 		pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
 		pool->dma_addr[index] = dma_addr;
@@ -238,7 +239,9 @@ static void ibmveth_replenish_buffer_poo
 			pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
 			pool->skbuff[index] = NULL;
 			pool->consumer_index--;
-			vio_unmap_single(adapter->vdev, pool->dma_addr[index], pool->buff_size, DMA_FROM_DEVICE);
+			dma_unmap_single(&adapter->vdev->dev,
+					pool->dma_addr[index], pool->buff_size,
+					DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			adapter->replenish_add_buff_failure++;
 			break;
@@ -299,7 +302,7 @@ static void ibmveth_free_buffer_pool(str
 		for(i = 0; i < pool->size; ++i) {
 			struct sk_buff *skb = pool->skbuff[i];
 			if(skb) {
-				vio_unmap_single(adapter->vdev,
+				dma_unmap_single(&adapter->vdev->dev,
 						 pool->dma_addr[i],
 						 pool->buff_size,
 						 DMA_FROM_DEVICE);
@@ -337,7 +340,7 @@ static void ibmveth_remove_buffer_from_p
 
 	adapter->rx_buff_pool[pool].skbuff[index] = NULL;
 
-	vio_unmap_single(adapter->vdev,
+	dma_unmap_single(&adapter->vdev->dev,
 			 adapter->rx_buff_pool[pool].dma_addr[index],
 			 adapter->rx_buff_pool[pool].buff_size,
 			 DMA_FROM_DEVICE);
@@ -408,7 +411,9 @@ static void ibmveth_cleanup(struct ibmve
 {
 	if(adapter->buffer_list_addr != NULL) {
 		if(!dma_mapping_error(adapter->buffer_list_dma)) {
-			vio_unmap_single(adapter->vdev, adapter->buffer_list_dma, 4096, DMA_BIDIRECTIONAL);
+			dma_unmap_single(&adapter->vdev->dev,
+					adapter->buffer_list_dma, 4096,
+					DMA_BIDIRECTIONAL);
 			adapter->buffer_list_dma = DMA_ERROR_CODE;
 		}
 		free_page((unsigned long)adapter->buffer_list_addr);
@@ -417,7 +422,9 @@ static void ibmveth_cleanup(struct ibmve
 
 	if(adapter->filter_list_addr != NULL) {
 		if(!dma_mapping_error(adapter->filter_list_dma)) {
-			vio_unmap_single(adapter->vdev, adapter->filter_list_dma, 4096, DMA_BIDIRECTIONAL);
+			dma_unmap_single(&adapter->vdev->dev,
+					adapter->filter_list_dma, 4096,
+					DMA_BIDIRECTIONAL);
 			adapter->filter_list_dma = DMA_ERROR_CODE;
 		}
 		free_page((unsigned long)adapter->filter_list_addr);
@@ -426,7 +433,10 @@ static void ibmveth_cleanup(struct ibmve
 
 	if(adapter->rx_queue.queue_addr != NULL) {
 		if(!dma_mapping_error(adapter->rx_queue.queue_dma)) {
-			vio_unmap_single(adapter->vdev, adapter->rx_queue.queue_dma, adapter->rx_queue.queue_len, DMA_BIDIRECTIONAL);
+			dma_unmap_single(&adapter->vdev->dev,
+					adapter->rx_queue.queue_dma,
+					adapter->rx_queue.queue_len,
+					DMA_BIDIRECTIONAL);
 			adapter->rx_queue.queue_dma = DMA_ERROR_CODE;
 		}
 		kfree(adapter->rx_queue.queue_addr);
@@ -472,9 +482,13 @@ static int ibmveth_open(struct net_devic
 		return -ENOMEM;
 	}
 
-	adapter->buffer_list_dma = vio_map_single(adapter->vdev, adapter->buffer_list_addr, 4096, DMA_BIDIRECTIONAL);
-	adapter->filter_list_dma = vio_map_single(adapter->vdev, adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
-	adapter->rx_queue.queue_dma = vio_map_single(adapter->vdev, adapter->rx_queue.queue_addr, adapter->rx_queue.queue_len, DMA_BIDIRECTIONAL);
+	adapter->buffer_list_dma = dma_map_single(&adapter->vdev->dev,
+			adapter->buffer_list_addr, 4096, DMA_BIDIRECTIONAL);
+	adapter->filter_list_dma = dma_map_single(&adapter->vdev->dev,
+			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
+	adapter->rx_queue.queue_dma = dma_map_single(&adapter->vdev->dev,
+			adapter->rx_queue.queue_addr,
+			adapter->rx_queue.queue_len, DMA_BIDIRECTIONAL);
 
 	if((dma_mapping_error(adapter->buffer_list_dma) ) ||
 	   (dma_mapping_error(adapter->filter_list_dma)) ||
@@ -644,7 +658,7 @@ static int ibmveth_start_xmit(struct sk_
 
 	/* map the initial fragment */
 	desc[0].fields.length  = nfrags ? skb->len - skb->data_len : skb->len;
-	desc[0].fields.address = vio_map_single(adapter->vdev, skb->data,
+	desc[0].fields.address = dma_map_single(&adapter->vdev->dev, skb->data,
 					desc[0].fields.length, DMA_TO_DEVICE);
 	desc[0].fields.valid   = 1;
 
@@ -662,7 +676,7 @@ static int ibmveth_start_xmit(struct sk_
 	while(curfrag--) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[curfrag];
 		desc[curfrag+1].fields.address
-			= vio_map_single(adapter->vdev,
+			= dma_map_single(&adapter->vdev->dev,
 				page_address(frag->page) + frag->page_offset,
 				frag->size, DMA_TO_DEVICE);
 		desc[curfrag+1].fields.length = frag->size;
@@ -674,7 +688,7 @@ static int ibmveth_start_xmit(struct sk_
 			adapter->stats.tx_dropped++;
 			/* Free all the mappings we just created */
 			while(curfrag < nfrags) {
-				vio_unmap_single(adapter->vdev,
+				dma_unmap_single(&adapter->vdev->dev,
 						 desc[curfrag+1].fields.address,
 						 desc[curfrag+1].fields.length,
 						 DMA_TO_DEVICE);
@@ -714,7 +728,9 @@ static int ibmveth_start_xmit(struct sk_
 	}
 
 	do {
-		vio_unmap_single(adapter->vdev, desc[nfrags].fields.address, desc[nfrags].fields.length, DMA_TO_DEVICE);
+		dma_unmap_single(&adapter->vdev->dev,
+				desc[nfrags].fields.address,
+				desc[nfrags].fields.length, DMA_TO_DEVICE);
 	} while(--nfrags >= 0);
 
 	dev_kfree_skb(skb);
