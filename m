Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWHHTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWHHTgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWHHTfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:35:17 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:20384 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030241AbWHHTex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:53 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:34:15 +0200
Message-Id: <20060808193415.1396.26744.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 5/9] r8169 driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the netdev_alloc_skb() API and the
NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 drivers/net/r8169.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/net/r8169.c
===================================================================
--- linux-2.6.orig/drivers/net/r8169.c
+++ linux-2.6/drivers/net/r8169.c
@@ -1480,6 +1480,8 @@ rtl8169_init_board(struct pci_dev *pdev,
 		}
 	}
 
+	dev->features |= NETIF_F_MEMALLOC;
+
 	pci_set_master(pdev);
 
 	/* ioremap MMIO region */
@@ -1909,14 +1911,15 @@ static inline void rtl8169_map_to_asic(s
 	rtl8169_mark_to_asic(desc, rx_buf_sz);
 }
 
-static int rtl8169_alloc_rx_skb(struct pci_dev *pdev, struct sk_buff **sk_buff,
+static int rtl8169_alloc_rx_skb(struct net_device *dev, struct pci_dev *pdev,
+				struct sk_buff **sk_buff,
 				struct RxDesc *desc, int rx_buf_sz)
 {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
 	int ret = 0;
 
-	skb = dev_alloc_skb(rx_buf_sz + NET_IP_ALIGN);
+	skb = netdev_alloc_skb(dev, rx_buf_sz + NET_IP_ALIGN);
 	if (!skb)
 		goto err_out;
 
@@ -1960,7 +1963,7 @@ static u32 rtl8169_rx_fill(struct rtl816
 		if (tp->Rx_skbuff[i])
 			continue;
 			
-		ret = rtl8169_alloc_rx_skb(tp->pci_dev, tp->Rx_skbuff + i,
+		ret = rtl8169_alloc_rx_skb(dev, tp->pci_dev, tp->Rx_skbuff + i,
 					   tp->RxDescArray + i, tp->rx_buf_sz);
 		if (ret < 0)
 			break;
@@ -2371,7 +2374,8 @@ static inline void rtl8169_rx_csum(struc
 		skb->ip_summed = CHECKSUM_NONE;
 }
 
-static inline int rtl8169_try_rx_copy(struct sk_buff **sk_buff, int pkt_size,
+static inline int rtl8169_try_rx_copy(struct net_device *dev,
+				      struct sk_buff **sk_buff, int pkt_size,
 				      struct RxDesc *desc, int rx_buf_sz)
 {
 	int ret = -1;
@@ -2379,7 +2383,7 @@ static inline int rtl8169_try_rx_copy(st
 	if (pkt_size < rx_copybreak) {
 		struct sk_buff *skb;
 
-		skb = dev_alloc_skb(pkt_size + NET_IP_ALIGN);
+		skb = netdev_alloc_skb(dev, pkt_size + NET_IP_ALIGN);
 		if (skb) {
 			skb_reserve(skb, NET_IP_ALIGN);
 			eth_copy_and_sum(skb, sk_buff[0]->data, pkt_size, 0);
@@ -2452,7 +2456,7 @@ rtl8169_rx_interrupt(struct net_device *
 				le64_to_cpu(desc->addr), tp->rx_buf_sz,
 				PCI_DMA_FROMDEVICE);
 
-			if (rtl8169_try_rx_copy(&skb, pkt_size, desc,
+			if (rtl8169_try_rx_copy(dev, &skb, pkt_size, desc,
 						tp->rx_buf_sz)) {
 				pci_action = pci_unmap_single;
 				tp->Rx_skbuff[entry] = NULL;
