Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUH3V6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUH3V6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUH3V6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 17:58:17 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50385 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263448AbUH3V6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:58:08 -0400
Date: Mon, 30 Aug 2004 23:56:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1-mm1-tso 1/2] 8139cp: SG support fixes
Message-ID: <20040830215636.GA26455@electric-eye.fr.zoreil.com>
References: <20040829212205.GA2864@havoc.gtf.org> <20040829222831.GA9496@electric-eye.fr.zoreil.com> <41326079.9090402@pobox.com> <20040830215227.GA23857@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830215227.GA23857@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- suspicious length in pci_unmap_single;
- wait for the last frag before freeing the relevant skb;
- no need to crash when facing some unexpected csum combination.

diff -puN drivers/net/8139cp.c~8139cp-010 drivers/net/8139cp.c
--- linux-2.6.9-rc1/drivers/net/8139cp.c~8139cp-010	2004-08-29 23:47:07.000000000 +0200
+++ linux-2.6.9-rc1-fr/drivers/net/8139cp.c	2004-08-30 21:21:23.000000000 +0200
@@ -314,7 +314,7 @@ struct cp_desc {
 struct ring_info {
 	struct sk_buff		*skb;
 	dma_addr_t		mapping;
-	unsigned		frag;
+	u32			len;
 };
 
 struct cp_dma_stats {
@@ -708,7 +708,7 @@ static void cp_tx (struct cp_private *cp
 			BUG();
 
 		pci_unmap_single(cp->pdev, cp->tx_skb[tx_tail].mapping,
-					skb->len, PCI_DMA_TODEVICE);
+				 cp->tx_skb[tx_tail].len, PCI_DMA_TODEVICE);
 
 		if (status & LastFrag) {
 			if (status & (TxError | TxFIFOUnder)) {
@@ -799,7 +799,7 @@ static int cp_start_xmit (struct sk_buff
 			else if (ip->protocol == IPPROTO_UDP)
 				flags |= IPCS | UDPCS;
 			else
-				BUG();
+				WARN_ON(1);	/* we need a WARN() */
 		}
 
 		txd->opts1 = cpu_to_le32(flags);
@@ -807,7 +807,7 @@ static int cp_start_xmit (struct sk_buff
 
 		cp->tx_skb[entry].skb = skb;
 		cp->tx_skb[entry].mapping = mapping;
-		cp->tx_skb[entry].frag = 0;
+		cp->tx_skb[entry].len = len;
 		entry = NEXT_TX(entry);
 	} else {
 		struct cp_desc *txd;
@@ -825,7 +825,7 @@ static int cp_start_xmit (struct sk_buff
 					       first_len, PCI_DMA_TODEVICE);
 		cp->tx_skb[entry].skb = skb;
 		cp->tx_skb[entry].mapping = first_mapping;
-		cp->tx_skb[entry].frag = 1;
+		cp->tx_skb[entry].len = first_len;
 		entry = NEXT_TX(entry);
 
 		for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
@@ -868,7 +868,7 @@ static int cp_start_xmit (struct sk_buff
 
 			cp->tx_skb[entry].skb = skb;
 			cp->tx_skb[entry].mapping = mapping;
-			cp->tx_skb[entry].frag = frag + 2;
+			cp->tx_skb[entry].len = len;
 			entry = NEXT_TX(entry);
 		}
 
@@ -1082,7 +1082,6 @@ static int cp_refill_rx (struct cp_priva
 		cp->rx_skb[i].mapping = pci_map_single(cp->pdev,
 			skb->tail, cp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		cp->rx_skb[i].skb = skb;
-		cp->rx_skb[i].frag = 0;
 
 		cp->rx_ring[i].opts2 = 0;
 		cp->rx_ring[i].addr = cpu_to_le64(cp->rx_skb[i].mapping);
@@ -1134,9 +1133,6 @@ static void cp_clean_rings (struct cp_pr
 {
 	unsigned i;
 
-	memset(cp->rx_ring, 0, sizeof(struct cp_desc) * CP_RX_RING_SIZE);
-	memset(cp->tx_ring, 0, sizeof(struct cp_desc) * CP_TX_RING_SIZE);
-
 	for (i = 0; i < CP_RX_RING_SIZE; i++) {
 		if (cp->rx_skb[i].skb) {
 			pci_unmap_single(cp->pdev, cp->rx_skb[i].mapping,
@@ -1148,13 +1144,18 @@ static void cp_clean_rings (struct cp_pr
 	for (i = 0; i < CP_TX_RING_SIZE; i++) {
 		if (cp->tx_skb[i].skb) {
 			struct sk_buff *skb = cp->tx_skb[i].skb;
+
 			pci_unmap_single(cp->pdev, cp->tx_skb[i].mapping,
-					 skb->len, PCI_DMA_TODEVICE);
-			dev_kfree_skb(skb);
+				 	 cp->tx_skb[i].len, PCI_DMA_TODEVICE);
+			if (le32_to_cpu(cp->tx_ring[i].opts1) & LastFrag)
+				dev_kfree_skb(skb);
 			cp->net_stats.tx_dropped++;
 		}
 	}
 
+	memset(cp->rx_ring, 0, sizeof(struct cp_desc) * CP_RX_RING_SIZE);
+	memset(cp->tx_ring, 0, sizeof(struct cp_desc) * CP_TX_RING_SIZE);
+
 	memset(&cp->rx_skb, 0, sizeof(struct ring_info) * CP_RX_RING_SIZE);
 	memset(&cp->tx_skb, 0, sizeof(struct ring_info) * CP_TX_RING_SIZE);
 }

_
