Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUL3JXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUL3JXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUL3JBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:01:00 -0500
Received: from smtp.knology.net ([24.214.63.101]:45699 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261588AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:36 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 15/22] typhoon: add outbound offload processing
Message-Id: <20041230035000.24@ori.thedillows.org>
References: <20041230035000.23@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:55:05-05:00 dave@thedillows.org 
#   Add outbound xfrm crypto offload processing to the packet path.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 00:54:46-05:00 dave@thedillows.org +130 -0
#   Add outbound xfrm crypto offload processing to the packet path.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:09:10 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:09:10 -05:00
@@ -352,6 +352,15 @@
 #define TSO_OFFLOAD_ON		0
 #endif
 
+#define IPSEC_NUM_DESCRIPTORS	1
+
+struct typhoon_xfrm_offload {
+	u16	sa_cookie;
+	u16	tunnel:1,
+		ah:1,
+		inbound:1;
+};
+
 static inline void
 typhoon_inc_index(u32 *index, const int count, const int num_entries)
 {
@@ -779,12 +788,115 @@
 	tcpd->status = 0;
 }
 
+static inline int
+typhoon_ipsec_fill(struct typhoon *tp, struct sk_buff *skb,
+				struct transmit_ring *txRing)
+{
+	struct xfrm_offload *xol;
+	struct typhoon_xfrm_offload *txo;
+	struct ipsec_desc *ipsec;
+	int last_was_esp = 0;
+	int i, entry;
+	u32 sa[3];
+
+	ipsec = (struct ipsec_desc *) (txRing->ringBase + txRing->lastWrite);
+	typhoon_inc_tx_index(&txRing->lastWrite, 1);
+
+	ipsec->flags = TYPHOON_OPT_DESC | TYPHOON_OPT_IPSEC;
+	ipsec->numDesc = 1;
+	ipsec->ipsecFlags = TYPHOON_IPSEC_USE_IV;
+	ipsec->reserved = 0;
+	sa[0] = sa[1] = sa[2] = 0;
+
+	/* Fill the offload descriptor with the cookies to indicate
+	 * which key set to use when. While we're looping through the
+	 * offloaded xfrms, if the last xfrm was ESP, and we're doing
+	 * AH now, * then we can move the ESP part to the top of the
+	 * descriptor. Otherwise, we'll need to move to the next one.
+	 * We overrun into sa[2] to prevent needing to check the entry
+	 * limit in the middile of things.
+	 */
+	entry = i = 0;
+	xol = skb_get_xfrm_offload(skb, i++);
+	while(xol && entry < 2) {
+		xfrm_offload_hold(xol);
+		txo = xfrm_offload_priv(xol);
+		if(sa[entry] && txo->tunnel)
+			entry++;
+		if(sa[entry] & 0xffff) {
+			if(last_was_esp && txo->ah)
+				sa[entry] <<= 16;
+			else
+				entry++;
+		}
+
+		sa[entry] |= txo->sa_cookie;
+		last_was_esp = !txo->ah;
+
+		xol = skb_get_xfrm_offload(skb, i++);
+	}
+
+	/* Make sure we used all of the xfrms that were offloaded.
+	 */
+	if(unlikely(entry == 2 && xol)) {
+		if(net_ratelimit())
+			printk(KERN_ERR "%s: failing to offload IPSEC packet "
+					"with too many xfrms!\n", tp->name);
+		goto bad_packet;
+	}
+
+	ipsec->sa[0] = cpu_to_le16(sa[0] & 0xffff);
+	ipsec->sa[1] = cpu_to_le16(sa[0] >> 16);
+	ipsec->sa[2] = cpu_to_le16(sa[1] & 0xffff);
+	ipsec->sa[3] = cpu_to_le16(sa[1] >> 16);
+
+	/* The current 3XP firmware seems to hang if we try to feed it
+	 * the same (non-zero) SA twice on the same packet. So, detect
+	 * and drop those packets as it is likely a stack bug, or
+	 * misconfiguration of policy.
+	 *
+	 * I.e., we should never hit this.
+	 */
+	if(unlikely(ipsec->sa[2])) {
+		if(unlikely(ipsec->sa[2] == ipsec->sa[3]))
+			goto avoiding_sa_hang;
+		if(unlikely(ipsec->sa[2] == ipsec->sa[0] ||
+					ipsec->sa[2] == ipsec->sa[1]))
+			goto avoiding_sa_hang;
+		if(unlikely(ipsec->sa[3] && (ipsec->sa[3] == ipsec->sa[0] ||
+					ipsec->sa[3] == ipsec->sa[1])))
+			goto avoiding_sa_hang;
+	}
+
+	if(unlikely(ipsec->sa[1] && ipsec->sa[0] == ipsec->sa[1]))
+		goto avoiding_sa_hang;
+
+	return 0;
+
+avoiding_sa_hang:
+	if(net_ratelimit())
+		printk(KERN_ERR "%s: failing attempted IPSEC offload with "
+				"duplicate SAs %08x %08x\n", tp->name,
+				sa[0], sa[1]);
+
+bad_packet:
+	/* Any xfrm_offloads we've attached to this skb will be
+	 * released for us when typhoon_start_tx() calls dev_kfree_skb_any()
+	 * on it.
+	 *
+	 * Return an error to indicate this packet cannot be offloaded as
+	 * specified and should never make it to the wire.
+	 */
+	return -EINVAL;
+}
+
 static int
 typhoon_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct typhoon *tp = netdev_priv(dev);
 	struct transmit_ring *txRing;
 	struct tx_desc *txd, *first_txd;
+	u32 origLastWrite;
 	dma_addr_t skb_dma;
 	int numDesc;
 
@@ -811,6 +923,9 @@
 	if(skb_tso_size(skb))
 		numDesc++;
 
+	if(skb_has_xfrm_offload(skb))
+		numDesc++;
+
 	/* When checking for free space in the ring, we need to also
 	 * account for the initial Tx descriptor, and we always must leave
 	 * at least one descriptor unused in the ring so that it doesn't
@@ -823,6 +938,7 @@
 	while(unlikely(typhoon_num_free_tx(txRing) < (numDesc + 2)))
 		smp_rmb();
 
+	origLastWrite = txRing->lastWrite;
 	first_txd = (struct tx_desc *) (txRing->ringBase + txRing->lastWrite);
 	typhoon_inc_tx_index(&txRing->lastWrite, 1);
 
@@ -855,6 +971,14 @@
 		typhoon_tso_fill(skb, txRing, tp->txlo_dma_addr);
 	}
 
+	if(skb_has_xfrm_offload(skb)) {
+		first_txd->processFlags |= TYPHOON_TX_PF_IPSEC;
+		first_txd->numDesc++;
+
+		if(typhoon_ipsec_fill(tp, skb, txRing))
+			goto error;
+	}
+
 	txd = (struct tx_desc *) (txRing->ringBase + txRing->lastWrite);
 	typhoon_inc_tx_index(&txRing->lastWrite, 1);
 
@@ -915,6 +1039,7 @@
 	 * Tx header.
 	 */
 	numDesc = MAX_SKB_FRAGS + TSO_NUM_DESCRIPTORS + 1;
+	numDesc += IPSEC_NUM_DESCRIPTORS;
 
 	if(typhoon_num_free_tx(txRing) < (numDesc + 2)) {
 		netif_stop_queue(dev);
@@ -927,6 +1052,11 @@
 			netif_wake_queue(dev);
 	}
 
+	return 0;
+
+error:
+	txRing->lastWrite = origLastWrite;
+	dev_kfree_skb_any(skb);
 	return 0;
 }
 
