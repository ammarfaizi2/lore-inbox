Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268351AbUH2Wag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268351AbUH2Wag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUH2Wag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:30:36 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16585 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268350AbUH2WaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:30:03 -0400
Date: Mon, 30 Aug 2004 00:28:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH,RFT] 8139cp TSO support
Message-ID: <20040829222831.GA9496@electric-eye.fr.zoreil.com>
References: <20040829212205.GA2864@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829212205.GA2864@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Also, the r8169 implementation should be similar, if someone (Francois?)
> wants to tackle it.

I'll copy and test it tomorrow on r8169 if nobody beats me.

On a related note, 8139cp probably wants something like the patch below for
the usual SG handling (on top of 2.6.9-rc1 + -mm1 + TSO patch):

- suspicious length in pci_unmap_single;
- wait for the last frag before freeing the relevant skb;
- no need to crash when facing some unexpected csum combination.

diff -puN drivers/net/8139cp.c~8139cp-010 drivers/net/8139cp.c
--- linux-2.6.9-rc1/drivers/net/8139cp.c~8139cp-010	2004-08-29 23:47:07.000000000 +0200
+++ linux-2.6.9-rc1-fr/drivers/net/8139cp.c	2004-08-30 00:16:13.000000000 +0200
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
@@ -807,7 +807,6 @@ static int cp_start_xmit (struct sk_buff
 
 		cp->tx_skb[entry].skb = skb;
 		cp->tx_skb[entry].mapping = mapping;
-		cp->tx_skb[entry].frag = 0;
 		entry = NEXT_TX(entry);
 	} else {
 		struct cp_desc *txd;
@@ -824,8 +823,8 @@ static int cp_start_xmit (struct sk_buff
 		first_mapping = pci_map_single(cp->pdev, skb->data,
 					       first_len, PCI_DMA_TODEVICE);
 		cp->tx_skb[entry].skb = skb;
+		cp->tx_skb[entry].len = first_len;
 		cp->tx_skb[entry].mapping = first_mapping;
-		cp->tx_skb[entry].frag = 1;
 		entry = NEXT_TX(entry);
 
 		for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
@@ -868,7 +867,7 @@ static int cp_start_xmit (struct sk_buff
 
 			cp->tx_skb[entry].skb = skb;
 			cp->tx_skb[entry].mapping = mapping;
-			cp->tx_skb[entry].frag = frag + 2;
+			cp->tx_skb[entry].len = len;
 			entry = NEXT_TX(entry);
 		}
 
@@ -1082,7 +1081,6 @@ static int cp_refill_rx (struct cp_priva
 		cp->rx_skb[i].mapping = pci_map_single(cp->pdev,
 			skb->tail, cp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		cp->rx_skb[i].skb = skb;
-		cp->rx_skb[i].frag = 0;
 
 		cp->rx_ring[i].opts2 = 0;
 		cp->rx_ring[i].addr = cpu_to_le64(cp->rx_skb[i].mapping);
@@ -1134,9 +1132,6 @@ static void cp_clean_rings (struct cp_pr
 {
 	unsigned i;
 
-	memset(cp->rx_ring, 0, sizeof(struct cp_desc) * CP_RX_RING_SIZE);
-	memset(cp->tx_ring, 0, sizeof(struct cp_desc) * CP_TX_RING_SIZE);
-
 	for (i = 0; i < CP_RX_RING_SIZE; i++) {
 		if (cp->rx_skb[i].skb) {
 			pci_unmap_single(cp->pdev, cp->rx_skb[i].mapping,
@@ -1148,13 +1143,18 @@ static void cp_clean_rings (struct cp_pr
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
