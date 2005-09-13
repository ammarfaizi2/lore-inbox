Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVIMSjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVIMSjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVIMSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:38:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964977AbVIMSi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:38:58 -0400
Date: Tue, 13 Sep 2005 11:38:58 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>, jes@trained-monkey.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] hippi: change to not use skb private
Message-ID: <20050913113858.440d3a0f@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the following would fix hippi to not have to put
fields in sk_buff. The ifield looks appears to to be additional
header information that is being passed in the skb but could just
be put in the header.

Does anyone still have the hardware to test this? Is anyone
even using it on 2.6?

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


Index: hippi-2.6.13/drivers/net/rrunner.c
===================================================================
--- hippi-2.6.13.orig/drivers/net/rrunner.c
+++ hippi-2.6.13/drivers/net/rrunner.c
@@ -1432,7 +1432,6 @@ static int rr_start_xmit(struct sk_buff 
 	struct ring_ctrl *txctrl;
 	unsigned long flags;
 	u32 index, len = skb->len;
-	u32 *ifield;
 	struct sk_buff *new_skb;
 
 	if (readl(&regs->Mode) & FATAL_ERR)
@@ -1440,29 +1439,6 @@ static int rr_start_xmit(struct sk_buff 
 		       readl(&regs->Fail1), readl(&regs->Fail2));
 
 	/*
-	 * We probably need to deal with tbusy here to prevent overruns.
-	 */
-
-	if (skb_headroom(skb) < 8){
-		printk("incoming skb too small - reallocating\n");
-		if (!(new_skb = dev_alloc_skb(len + 8))) {
-			dev_kfree_skb(skb);
-			netif_wake_queue(dev);
-			return -EBUSY;
-		}
-		skb_reserve(new_skb, 8);
-		skb_put(new_skb, len);
-		memcpy(new_skb->data, skb->data, len);
-		dev_kfree_skb(skb);
-		skb = new_skb;
-	}
-
-	ifield = (u32 *)skb_push(skb, 8);
-
-	ifield[0] = 0;
-	ifield[1] = skb->private.ifield;
-
-	/*
 	 * We don't need the lock before we are actually going to start
 	 * fiddling with the control blocks.
 	 */
@@ -1475,7 +1451,7 @@ static int rr_start_xmit(struct sk_buff 
 	rrpriv->tx_skbuff[index] = skb;
 	set_rraddr(&rrpriv->tx_ring[index].addr, pci_map_single(
 		rrpriv->pci_dev, skb->data, len + 8, PCI_DMA_TODEVICE));
-	rrpriv->tx_ring[index].size = len + 8; /* include IFIELD */
+	rrpriv->tx_ring[index].size = len;
 	rrpriv->tx_ring[index].mode = PACKET_START | PACKET_END;
 	txctrl->pi = (index + 1) % TX_RING_ENTRIES;
 	wmb();
Index: hippi-2.6.13/include/linux/skbuff.h
===================================================================
--- hippi-2.6.13.orig/include/linux/skbuff.h
+++ hippi-2.6.13/include/linux/skbuff.h
@@ -194,7 +194,6 @@ struct skb_shared_info {
  *	@nfct: Associated connection, if any
  *	@nfctinfo: Relationship of this skb to the connection
  *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
- *      @private: Data which is private to the HIPPI implementation
  *	@tc_index: Traffic control index
  *	@tc_verd: traffic control verdict
  *	@tc_classid: traffic control classid
@@ -267,11 +266,7 @@ struct sk_buff {
 	struct nf_bridge_info	*nf_bridge;
 #endif
 #endif /* CONFIG_NETFILTER */
-#if defined(CONFIG_HIPPI)
-	union {
-		__u32		ifield;
-	} private;
-#endif
+
 #ifdef CONFIG_NET_SCHED
        __u32			tc_index;        /* traffic control index */
 #ifdef CONFIG_NET_CLS_ACT
Index: hippi-2.6.13/net/802/hippi.c
===================================================================
--- hippi-2.6.13.orig/net/802/hippi.c
+++ hippi-2.6.13/net/802/hippi.c
@@ -50,7 +50,8 @@ static int hippi_header(struct sk_buff *
 			unsigned short type, void *daddr, void *saddr,
 			unsigned len)
 {
-	struct hippi_hdr *hip = (struct hippi_hdr *)skb_push(skb, HIPPI_HLEN);
+	struct hippi_hdr *hip = (struct hippi_hdr *)skb_push(skb, HIPPI_HLEN + 8);
+	u32 *ifield = (u32 *) (hip + 1);
 
 	if (!len){
 		len = skb->len - HIPPI_HLEN;
@@ -81,13 +82,14 @@ static int hippi_header(struct sk_buff *
 	hip->snap.oui[2]	= 0x00;
 	hip->snap.ethertype	= htons(type);
 
-	if (daddr)
-	{
+	memset(ifield, 0, 2*sizeof(u32));
+	if (daddr) {
 		memcpy(hip->le.dest_switch_addr, daddr + 3, 3);
-		memcpy(&skb->private.ifield, daddr + 2, 4);
-		return HIPPI_HLEN;
+		memcpy(ifield+1, daddr + 2, 4);
+		return HIPPI_HLEN + 8;
 	}
-	return -((int)HIPPI_HLEN);
+
+	return -((int)HIPPI_HLEN - 8);
 }
 
 
@@ -200,7 +202,7 @@ static void hippi_setup(struct net_devic
 	 * still need a fake ARPHRD to make ifconfig and friends play ball.
 	 */
 	dev->type		= ARPHRD_HIPPI;
-	dev->hard_header_len 	= HIPPI_HLEN;
+	dev->hard_header_len 	= HIPPI_HLEN + 8;
 	dev->mtu		= 65280;
 	dev->addr_len		= HIPPI_ALEN;
 	dev->tx_queue_len	= 25 /* 5 */;
Index: hippi-2.6.13/net/core/skbuff.c
===================================================================
--- hippi-2.6.13.orig/net/core/skbuff.c
+++ hippi-2.6.13/net/core/skbuff.c
@@ -370,9 +370,6 @@ struct sk_buff *skb_clone(struct sk_buff
 	nf_bridge_get(skb->nf_bridge);
 #endif
 #endif /*CONFIG_NETFILTER*/
-#if defined(CONFIG_HIPPI)
-	C(private);
-#endif
 #ifdef CONFIG_NET_SCHED
 	C(tc_index);
 #ifdef CONFIG_NET_CLS_ACT
