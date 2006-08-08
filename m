Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWHHTel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWHHTel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWHHTel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:41 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:39446 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030235AbWHHTec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:32 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:33:55 +0200
Message-Id: <20060808193355.1396.71047.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 3/9] e1000 driver conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update the driver to make use of the NETIF_F_MEMALLOC feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 drivers/net/e1000/e1000_main.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6/drivers/net/e1000/e1000_main.c
@@ -822,7 +822,7 @@ e1000_probe(struct pci_dev *pdev,
 	if (pci_using_dac)
 		netdev->features |= NETIF_F_HIGHDMA;
 
-	netdev->features |= NETIF_F_LLTX;
+	netdev->features |= NETIF_F_LLTX | NETIF_F_MEMALLOC;
 
 	adapter->en_mng_pt = e1000_enable_mng_pass_thru(&adapter->hw);
 
@@ -4020,8 +4020,6 @@ e1000_alloc_rx_buffers(struct e1000_adap
 		 */
 		skb_reserve(skb, NET_IP_ALIGN);
 
-		skb->dev = netdev;
-
 		buffer_info->skb = skb;
 		buffer_info->length = adapter->rx_buffer_len;
 map_skb:
@@ -4099,8 +4097,11 @@ e1000_alloc_rx_buffers_ps(struct e1000_a
 		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
 			if (j < adapter->rx_ps_pages) {
 				if (likely(!ps_page->ps_page[j])) {
+					/* Perhaps we should alloc the skb first
+					 * and use something like sk_buff_gfp().
+					 */
 					ps_page->ps_page[j] =
-						alloc_page(GFP_ATOMIC);
+						alloc_page(GFP_ATOMIC | __GFP_MEMALLOC);
 					if (unlikely(!ps_page->ps_page[j])) {
 						adapter->alloc_rx_buff_failed++;
 						goto no_buffers;
@@ -4135,8 +4136,6 @@ e1000_alloc_rx_buffers_ps(struct e1000_a
 		 */
 		skb_reserve(skb, NET_IP_ALIGN);
 
-		skb->dev = netdev;
-
 		buffer_info->skb = skb;
 		buffer_info->length = adapter->rx_ps_bsize0;
 		buffer_info->dma = pci_map_single(pdev, skb->data,
