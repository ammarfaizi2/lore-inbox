Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWHHTfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWHHTfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWHHTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:35:42 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:45448 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030243AbWHHTfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:35:24 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:34:47 +0200
Message-Id: <20060808193447.1396.59301.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 8/9] 3c59x driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the netdev_alloc_skb() API and the
NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 drivers/net/3c59x.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/net/3c59x.c
===================================================================
--- linux-2.6.orig/drivers/net/3c59x.c
+++ linux-2.6/drivers/net/3c59x.c
@@ -1383,6 +1383,8 @@ static int __devinit vortex_probe1(struc
 				(dev->features & NETIF_F_IP_CSUM) ? "en":"dis");
 	}
 
+	dev->features |= NETIF_F_MEMALLOC;
+
 	dev->stop = vortex_close;
 	dev->get_stats = vortex_get_stats;
 #ifdef CONFIG_PCI
@@ -1680,7 +1682,7 @@ vortex_open(struct net_device *dev)
 			vp->rx_ring[i].next = cpu_to_le32(vp->rx_ring_dma + sizeof(struct boom_rx_desc) * (i+1));
 			vp->rx_ring[i].status = 0;	/* Clear complete bit. */
 			vp->rx_ring[i].length = cpu_to_le32(PKT_BUF_SZ | LAST_FRAG);
-			skb = dev_alloc_skb(PKT_BUF_SZ);
+			skb = netdev_alloc_skb(dev, PKT_BUF_SZ);
 			vp->rx_skbuff[i] = skb;
 			if (skb == NULL)
 				break;			/* Bad news!  */
@@ -2405,7 +2407,7 @@ static int vortex_rx(struct net_device *
 			int pkt_len = rx_status & 0x1fff;
 			struct sk_buff *skb;
 
-			skb = dev_alloc_skb(pkt_len + 5);
+			skb = netdev_alloc_skb(dev, pkt_len + 5);
 			if (vortex_debug > 4)
 				printk(KERN_DEBUG "Receiving packet size %d status %4.4x.\n",
 					   pkt_len, rx_status);
@@ -2486,7 +2488,7 @@ boomerang_rx(struct net_device *dev)
 
 			/* Check if the packet is long enough to just accept without
 			   copying to a properly sized skbuff. */
-			if (pkt_len < rx_copybreak && (skb = dev_alloc_skb(pkt_len + 2)) != 0) {
+			if (pkt_len < rx_copybreak && (skb = netdev_alloc_skb(dev, pkt_len + 2)) != 0) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
 				pci_dma_sync_single_for_cpu(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
@@ -2525,7 +2527,7 @@ boomerang_rx(struct net_device *dev)
 		struct sk_buff *skb;
 		entry = vp->dirty_rx % RX_RING_SIZE;
 		if (vp->rx_skbuff[entry] == NULL) {
-			skb = dev_alloc_skb(PKT_BUF_SZ);
+			skb = netdev_alloc_skb(dev, PKT_BUF_SZ);
 			if (skb == NULL) {
 				static unsigned long last_jif;
 				if (time_after(jiffies, last_jif + 10 * HZ)) {
