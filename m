Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULMWd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULMWd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULMWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:24:11 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:51608 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261212AbULMWSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:18:14 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:18:13 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 4/6] mv643xx_eth: Convert from pci_map_* to dma_map_* interface
Message-ID: <20041213221813.GD19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the use of the pci_map_* functions with the
corresponding dma_map_* functions.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-13 14:30:34.651531163 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:30:37.436993510 -0700
@@ -154,9 +154,9 @@
 			pkt_info.byte_cnt += 8;
 		}
 		pkt_info.buf_ptr =
-		    pci_map_single(0, skb->data,
+		    dma_map_single(NULL, skb->data,
 				   dev->mtu + ETH_HLEN + 4 + 2 + EXTRA_BYTES,
-				   PCI_DMA_FROMDEVICE);
+				   DMA_FROM_DEVICE);
 		pkt_info.return_info = skb;
 		if (eth_rx_return_buff(mp, &pkt_info) != ETH_OK) {
 			printk(KERN_ERR
@@ -340,11 +340,11 @@
 		 */
 		if (pkt_info.return_info) {
 			if (skb_shinfo(pkt_info.return_info)->nr_frags)
-				pci_unmap_page(NULL, pkt_info.buf_ptr,
-					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
+				dma_unmap_page(NULL, pkt_info.buf_ptr,
+					pkt_info.byte_cnt, DMA_TO_DEVICE);
 			else
-				pci_unmap_single(NULL, pkt_info.buf_ptr,
-					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
+				dma_unmap_single(NULL, pkt_info.buf_ptr,
+					pkt_info.byte_cnt, DMA_TO_DEVICE);
 
 			dev_kfree_skb_irq((struct sk_buff *)
 					  pkt_info.return_info);
@@ -359,8 +359,8 @@
 						"counter is corrupted");
 			mp->tx_ring_skbs--;
 		} else 
-			pci_unmap_page(NULL, pkt_info.buf_ptr,
-					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
+			dma_unmap_page(NULL, pkt_info.buf_ptr,
+					pkt_info.byte_cnt, DMA_TO_DEVICE);
 
 
 	}
@@ -827,7 +827,8 @@
 	mp->tx_desc_area_size = size;
 
 	/* Assumes allocated ring is 16 bytes alligned */
-	mp->p_tx_desc_area = pci_alloc_consistent(NULL, size, &mp->tx_desc_dma);
+	mp->p_tx_desc_area = dma_alloc_coherent(NULL, size, &mp->tx_desc_dma,
+								GFP_KERNEL);
 	if (!mp->p_tx_desc_area) {
 		printk(KERN_ERR "%s: Cannot allocate Tx Ring (size %d bytes)\n",
 		       dev->name, size);
@@ -847,16 +848,16 @@
 
 	/* Assumes allocated ring is 16 bytes aligned */
 
-	mp->p_rx_desc_area = pci_alloc_consistent(NULL, size, &mp->rx_desc_dma);
+	mp->p_rx_desc_area = dma_alloc_coherent(NULL, size, &mp->rx_desc_dma,
+								GFP_KERNEL);
 
 	if (!mp->p_rx_desc_area) {
 		printk(KERN_ERR "%s: Cannot allocate Rx ring (size %d bytes)\n",
 		       dev->name, size);
 		printk(KERN_ERR "%s: Freeing previously allocated TX queues...",
 		       dev->name);
-		pci_free_consistent(0, mp->tx_desc_area_size,
-				    (void *) mp->p_tx_desc_area,
-				    mp->tx_desc_dma);
+		dma_free_coherent(NULL, mp->tx_desc_area_size,
+				    mp->p_tx_desc_area, mp->tx_desc_dma);
 		return -ENOMEM;
 	}
 	memset(mp->p_rx_desc_area, 0, size);
@@ -921,8 +922,8 @@
 		printk("%s: Error on Tx descriptor free - could not free %d"
 		     " descriptors\n", dev->name,
 		     mp->tx_ring_skbs);
-	pci_free_consistent(0, mp->tx_desc_area_size,
-			    (void *) mp->p_tx_desc_area, mp->tx_desc_dma);
+	dma_free_coherent(0, mp->tx_desc_area_size,
+			    mp->p_tx_desc_area, mp->tx_desc_dma);
 }
 
 static void mv64340_eth_free_rx_rings(struct net_device *dev)
@@ -951,9 +952,8 @@
 		       "%s: Error in freeing Rx Ring. %d skb's still"
 		       " stuck in RX Ring - ignoring them\n", dev->name,
 		       mp->rx_ring_skbs);
-	pci_free_consistent(0, mp->rx_desc_area_size,
-			    (void *) mp->p_rx_desc_area,
-			    mp->rx_desc_dma);
+	dma_free_coherent(NULL, mp->rx_desc_area_size,
+			    mp->p_rx_desc_area, mp->rx_desc_dma);
 }
 
 /*
@@ -1016,13 +1016,11 @@
 	while (eth_tx_return_desc(mp, &pkt_info) == ETH_OK) {
 		if (pkt_info.return_info) {
 			if (skb_shinfo(pkt_info.return_info)->nr_frags) 
-                                 pci_unmap_page(NULL, pkt_info.buf_ptr,
-                                             pkt_info.byte_cnt,
-                                             PCI_DMA_TODEVICE);
+                                 dma_unmap_page(NULL, pkt_info.buf_ptr,
+                                             pkt_info.byte_cnt, DMA_TO_DEVICE);
 			else
-                                 pci_unmap_single(NULL, pkt_info.buf_ptr,
-                                             pkt_info.byte_cnt,
-                                             PCI_DMA_TODEVICE);
+                                 dma_unmap_single(NULL, pkt_info.buf_ptr,
+                                             pkt_info.byte_cnt, DMA_TO_DEVICE);
 
 			dev_kfree_skb_irq((struct sk_buff *)
                                                   pkt_info.return_info);
@@ -1030,8 +1028,8 @@
                         if (mp->tx_ring_skbs != 0)
                                 mp->tx_ring_skbs--;
                 } else 
-                       pci_unmap_page(NULL, pkt_info.buf_ptr, pkt_info.byte_cnt,
-                                      PCI_DMA_TODEVICE);
+                       dma_unmap_page(NULL, pkt_info.buf_ptr,
+					pkt_info.byte_cnt, DMA_TO_DEVICE);
 	}
 
 	if (netif_queue_stopped(dev) &&
@@ -1163,8 +1161,8 @@
 			}
 		}
 		pkt_info.byte_cnt = skb->len;
-		pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
-		                                  PCI_DMA_TODEVICE);
+		pkt_info.buf_ptr = dma_map_single(NULL, skb->data, skb->len,
+							  DMA_TO_DEVICE);
 		pkt_info.return_info = skb;
 		status = eth_port_send(mp, &pkt_info);
 		if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
@@ -1177,8 +1175,8 @@
 
                 /* first frag which is skb header */
                 pkt_info.byte_cnt = skb_headlen(skb);
-                pkt_info.buf_ptr = pci_map_single(0, skb->data,
-                                        skb_headlen(skb), PCI_DMA_TODEVICE);
+                pkt_info.buf_ptr = dma_map_single(NULL, skb->data,
+                                        skb_headlen(skb), DMA_TO_DEVICE);
                 pkt_info.return_info = 0;
                 pkt_info.cmd_sts = ETH_TX_FIRST_DESC;
 
@@ -1231,9 +1229,9 @@
                         }
                         pkt_info.byte_cnt = this_frag->size;
 
-                        pkt_info.buf_ptr = pci_map_page(NULL, this_frag->page,
+                        pkt_info.buf_ptr = dma_map_page(NULL, this_frag->page,
                                         this_frag->page_offset,
-                                        this_frag->size, PCI_DMA_TODEVICE);
+                                        this_frag->size, DMA_TO_DEVICE);
 
                         status = eth_port_send(mp, &pkt_info);
 
@@ -1253,8 +1251,8 @@
 	pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT | ETH_TX_FIRST_DESC |
 							ETH_TX_LAST_DESC;
 	pkt_info.byte_cnt = skb->len;
-	pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
-							PCI_DMA_TODEVICE);
+	pkt_info.buf_ptr = dma_map_single(NULL, skb->data, skb->len,
+								DMA_TO_DEVICE);
 	pkt_info.return_info = skb;
 	status = eth_port_send(mp, &pkt_info);
 	if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
