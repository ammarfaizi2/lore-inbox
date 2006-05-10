Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWEJC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWEJC4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWEJC4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:39 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:50237 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932422AbWEJC4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:20 -0400
Date: Tue, 9 May 2006 19:55:57 -0700
Message-Id: <200605100255.k4A2tvqm031661@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] dl2k gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/net/dl2k.c: In function 'rio_free_tx':
drivers/net/dl2k.c:768: warning: integer constant is too large for 'long' type
drivers/net/dl2k.c: In function 'receive_packet':
drivers/net/dl2k.c:896: warning: integer constant is too large for 'long' type
drivers/net/dl2k.c:904: warning: integer constant is too large for 'long' type
drivers/net/dl2k.c:916: warning: integer constant is too large for 'long' type
drivers/net/dl2k.c: In function 'rio_close':
drivers/net/dl2k.c:1803: warning: integer constant is too large for 'long' type
drivers/net/dl2k.c:1813: warning: integer constant is too large for 'long' type

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/net/dl2k.c
===================================================================
--- linux-2.6.16.orig/drivers/net/dl2k.c
+++ linux-2.6.16/drivers/net/dl2k.c
@@ -765,7 +765,7 @@ rio_free_tx (struct net_device *dev, int
 			break;
 		skb = np->tx_skbuff[entry];
 		pci_unmap_single (np->pdev,
-				  np->tx_ring[entry].fraginfo & 0xffffffffffff,
+				  np->tx_ring[entry].fraginfo & 0xffffffffffffULL,
 				  skb->len, PCI_DMA_TODEVICE);
 		if (irq)
 			dev_kfree_skb_irq (skb);
@@ -893,7 +893,7 @@ receive_packet (struct net_device *dev)
 			/* Small skbuffs for short packets */
 			if (pkt_len > copy_thresh) {
 				pci_unmap_single (np->pdev,
-						  desc->fraginfo & 0xffffffffffff,
+						  desc->fraginfo & 0xffffffffffffULL,
 						  np->rx_buf_sz,
 						  PCI_DMA_FROMDEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
@@ -901,7 +901,7 @@ receive_packet (struct net_device *dev)
 			} else if ((skb = dev_alloc_skb (pkt_len + 2)) != NULL) {
 				pci_dma_sync_single_for_cpu(np->pdev,
 				  			    desc->fraginfo & 
-							    	0xffffffffffff,
+							    	0xffffffffffffULL,
 							    np->rx_buf_sz,
 							    PCI_DMA_FROMDEVICE);
 				skb->dev = dev;
@@ -913,7 +913,7 @@ receive_packet (struct net_device *dev)
 				skb_put (skb, pkt_len);
 				pci_dma_sync_single_for_device(np->pdev,
 				  			       desc->fraginfo &
-							       	 0xffffffffffff,
+							       	 0xffffffffffffULL,
 							       np->rx_buf_sz,
 							       PCI_DMA_FROMDEVICE);
 			}
@@ -1800,7 +1800,7 @@ rio_close (struct net_device *dev)
 		skb = np->rx_skbuff[i];
 		if (skb) {
 			pci_unmap_single(np->pdev, 
-					 np->rx_ring[i].fraginfo & 0xffffffffffff,
+					 np->rx_ring[i].fraginfo & 0xffffffffffffULL,
 					 skb->len, PCI_DMA_FROMDEVICE);
 			dev_kfree_skb (skb);
 			np->rx_skbuff[i] = NULL;
@@ -1810,7 +1810,7 @@ rio_close (struct net_device *dev)
 		skb = np->tx_skbuff[i];
 		if (skb) {
 			pci_unmap_single(np->pdev, 
-					 np->tx_ring[i].fraginfo & 0xffffffffffff,
+					 np->tx_ring[i].fraginfo & 0xffffffffffffULL,
 					 skb->len, PCI_DMA_TODEVICE);
 			dev_kfree_skb (skb);
 			np->tx_skbuff[i] = NULL;
