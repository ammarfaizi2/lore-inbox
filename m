Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUH2VWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUH2VWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUH2VWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:22:18 -0400
Received: from havoc.gtf.org ([216.162.42.101]:18834 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268314AbUH2VWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:22:06 -0400
Date: Sun, 29 Aug 2004 17:22:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, romieu@fr.zoreil.com
Subject: [PATCH,RFT] 8139cp TSO support
Message-ID: <20040829212205.GA2864@havoc.gtf.org>
Reply-To: netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just added TSO support to the 8139cp driver, as it looked fairly
straightforward.

Anyone willing to give this some testing?

Also, the r8169 implementation should be similar, if someone (Francois?)
wants to tackle it.

	Jeff




# ChangeSet
#   2004/08/29 17:19:44-04:00 jgarzik@pobox.com 
#   [netdrvr 8139cp] TSO support
# 
diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	2004-08-29 17:19:59 -04:00
+++ b/drivers/net/8139cp.c	2004-08-29 17:19:59 -04:00
@@ -185,6 +185,9 @@
 	RingEnd		= (1 << 30), /* End of descriptor ring */
 	FirstFrag	= (1 << 29), /* First segment of a packet */
 	LastFrag	= (1 << 28), /* Final segment of a packet */
+	LargeSend	= (1 << 27), /* TCP Large Send Offload (TSO) */
+	MSSShift	= 16,	     /* MSS value position */
+	MSSMask		= 0xfff,     /* MSS value: 11 bits */
 	TxError		= (1 << 23), /* Tx error summary */
 	RxError		= (1 << 20), /* Rx error summary */
 	IPCS		= (1 << 18), /* Calculate IP checksum */
@@ -747,10 +750,11 @@
 {
 	struct cp_private *cp = netdev_priv(dev);
 	unsigned entry;
-	u32 eor;
+	u32 eor, flags;
 #if CP_VLAN_TAG_USED
 	u32 vlan_tag = 0;
 #endif
+	int mss = 0;
 
 	spin_lock_irq(&cp->lock);
 
@@ -770,6 +774,9 @@
 
 	entry = cp->tx_head;
 	eor = (entry == (CP_TX_RING_SIZE - 1)) ? RingEnd : 0;
+	if (dev->features & NETIF_F_TSO)
+		mss = skb_shinfo(skb)->tso_size;
+
 	if (skb_shinfo(skb)->nr_frags == 0) {
 		struct cp_desc *txd = &cp->tx_ring[entry];
 		u32 len;
@@ -781,21 +788,21 @@
 		txd->addr = cpu_to_le64(mapping);
 		wmb();
 
-		if (skb->ip_summed == CHECKSUM_HW) {
+		flags = eor | len | DescOwn | FirstFrag | LastFrag;
+
+		if (mss)
+			flags |= LargeSend | ((mss & MSSMask) << MSSShift);
+		else if (skb->ip_summed == CHECKSUM_HW) {
 			const struct iphdr *ip = skb->nh.iph;
 			if (ip->protocol == IPPROTO_TCP)
-				txd->opts1 = cpu_to_le32(eor | len | DescOwn |
-							 FirstFrag | LastFrag |
-							 IPCS | TCPCS);
+				flags |= IPCS | TCPCS;
 			else if (ip->protocol == IPPROTO_UDP)
-				txd->opts1 = cpu_to_le32(eor | len | DescOwn |
-							 FirstFrag | LastFrag |
-							 IPCS | UDPCS);
+				flags |= IPCS | UDPCS;
 			else
 				BUG();
-		} else
-			txd->opts1 = cpu_to_le32(eor | len | DescOwn |
-						 FirstFrag | LastFrag);
+		}
+
+		txd->opts1 = cpu_to_le32(flags);
 		wmb();
 
 		cp->tx_skb[entry].skb = skb;
@@ -834,16 +841,19 @@
 						 len, PCI_DMA_TODEVICE);
 			eor = (entry == (CP_TX_RING_SIZE - 1)) ? RingEnd : 0;
 
-			if (skb->ip_summed == CHECKSUM_HW) {
-				ctrl = eor | len | DescOwn | IPCS;
+			ctrl = eor | len | DescOwn;
+
+			if (mss)
+				ctrl |= LargeSend |
+					((mss & MSSMask) << MSSShift);
+			else if (skb->ip_summed == CHECKSUM_HW) {
 				if (ip->protocol == IPPROTO_TCP)
-					ctrl |= TCPCS;
+					ctrl |= IPCS | TCPCS;
 				else if (ip->protocol == IPPROTO_UDP)
-					ctrl |= UDPCS;
+					ctrl |= IPCS | UDPCS;
 				else
 					BUG();
-			} else
-				ctrl = eor | len | DescOwn;
+			}
 
 			if (frag == skb_shinfo(skb)->nr_frags - 1)
 				ctrl |= LastFrag;
@@ -1536,6 +1546,8 @@
 	.set_tx_csum		= ethtool_op_set_tx_csum, /* local! */
 	.get_sg			= ethtool_op_get_sg,
 	.set_sg			= ethtool_op_set_sg,
+	.get_tso		= ethtool_op_get_tso,
+	.set_tso		= ethtool_op_set_tso,
 	.get_regs		= cp_get_regs,
 	.get_wol		= cp_get_wol,
 	.set_wol		= cp_set_wol,
@@ -1765,6 +1777,10 @@
 
 	if (pci_using_dac)
 		dev->features |= NETIF_F_HIGHDMA;
+
+#if 0 /* disabled by default until verified */
+	dev->features |= NETIF_F_TSO;
+#endif
 
 	dev->irq = pdev->irq;
 
