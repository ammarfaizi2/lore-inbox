Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWDLTep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWDLTep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWDLTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:34:45 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:41169 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932115AbWDLTeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:34:44 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Ingo Oeser <netdev@axxeo.de>
Subject: [RFD][PATCH] typhoon and core sample for folding away VLAN stuff (was: Re: [PATCH] deinline a few large functions in vlan code v2)
Date: Wed, 12 Apr 2006 21:32:44 +0200
User-Agent: KMail/1.9.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, Dave Dillow <dave@thedillows.org>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604111502.52302.vda@ilport.com.ua> <200604111517.37215.netdev@axxeo.de>
In-Reply-To: <200604111517.37215.netdev@axxeo.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604122132.46113.ioe-lkml@rameria.de>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

here is a sample patch for the vlan core and API plus
typhoon driver converted as example.

Just so you can see, what I meant with "No #if in control flow code."

I couldn't resist cleaning up the vlan core, while I'm at it. 
Of course I can seperate this, if you want the pure unilining stuff only.

So I hope this style is clear enough that you can do the rest of 
the conversion without any problems.

Dave Dillow: Is this style clean enough to have it in your driver?

This kind of changes are important, because bloat creeps in byte by byte
of unused features. So I really appreciate your work here Denis.


Regards

Ingo Oeser

diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index c1ce87a..aab24b8 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -285,7 +285,9 @@ struct typhoon {
 	struct pci_dev *	pdev;
 	struct net_device *	dev;
 	spinlock_t		state_lock;
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct vlan_group *	vlgrp;
+#endif
 	struct basic_ring	rxHiRing;
 	struct basic_ring	rxBuffRing;
 	struct rxbuff_ent	rxbuffers[RXENT_ENTRIES];
@@ -350,6 +352,19 @@ enum state_values {
 #define TSO_OFFLOAD_ON		0
 #endif
 
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+static inline struct vlan_group *typhoon_get_vlgrp(struct typhoon *tp)
+{
+	return tp->vlgrp;
+}
+#else
+static inline struct vlan_group *typhoon_get_vlgrp(struct typhoon *tp)
+{
+	return NULL;
+}
+#endif
+
 static inline void
 typhoon_inc_index(u32 *index, const int count, const int num_entries)
 {
@@ -707,6 +722,7 @@ out:
 	return err;
 }
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 static void
 typhoon_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
@@ -754,6 +770,12 @@ typhoon_vlan_rx_kill_vid(struct net_devi
 		tp->vlgrp->vlan_devices[vid] = NULL;
 	spin_unlock_bh(&tp->state_lock);
 }
+#else
+
+#define typhoon_vlan_rx_register NULL
+#define typhoon_vlan_rx_kill_vid NULL
+
+#endif
 
 static inline void
 typhoon_tso_fill(struct sk_buff *skb, struct transmit_ring *txRing,
@@ -1686,6 +1708,7 @@ typhoon_rx(struct typhoon *tp, struct ba
 	struct rx_desc *rx;
 	struct sk_buff *skb, *new_skb;
 	struct rxbuff_ent *rxb;
+	struct vlan_group *vlgrp;
 	dma_addr_t dma_addr;
 	u32 local_ready;
 	u32 rxaddr;
@@ -1745,8 +1768,9 @@ typhoon_rx(struct typhoon *tp, struct ba
 			new_skb->ip_summed = CHECKSUM_NONE;
 
 		spin_lock(&tp->state_lock);
-		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
-			vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
+		vlgrp = typhoon_get_vlgrp(tp);
+		if(vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
+			vlan_hwaccel_receive_skb(new_skb, vlgrp,
 						 ntohl(rx->vlanTag) & 0xffff);
 		else
 			netif_receive_skb(new_skb);
@@ -2233,7 +2257,7 @@ typhoon_suspend(struct pci_dev *pdev, pm
 		return 0;
 
 	spin_lock_bh(&tp->state_lock);
-	if(tp->vlgrp && tp->wol_events & TYPHOON_WAKE_MAGIC_PKT) {
+	if(typhoon_get_vlgrp(tp) && tp->wol_events & TYPHOON_WAKE_MAGIC_PKT) {
 		spin_unlock_bh(&tp->state_lock);
 		printk(KERN_ERR "%s: cannot do WAKE_MAGIC with VLANS\n",
 				dev->name);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index eef0876..4ed541f 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -14,6 +14,8 @@
 #define _LINUX_IF_VLAN_H_
 
 #ifdef __KERNEL__
+#define HAVE_VLAN_PUT_TAG
+#define HAVE_VLAN_GET_TAG
 
 /* externally defined structs */
 struct vlan_group;
@@ -119,79 +121,29 @@ struct vlan_dev_info {
 	struct net_device_stats dev_stats; /* Device stats (rx-bytes, tx-pkts, etc...) */
 };
 
-#define VLAN_DEV_INFO(x) ((struct vlan_dev_info *)(x->priv))
-
-/* inline functions */
-
-static inline struct net_device_stats *vlan_dev_get_stats(struct net_device *dev)
-{
-	return &(VLAN_DEV_INFO(dev)->dev_stats);
-}
-
-static inline __u32 vlan_get_ingress_priority(struct net_device *dev,
-					      unsigned short vlan_tag)
-{
-	struct vlan_dev_info *vip = VLAN_DEV_INFO(dev);
-
-	return vip->ingress_priority_map[(vlan_tag >> 13) & 0x7];
-}
-
 /* VLAN tx hw acceleration helpers. */
 struct vlan_skb_tx_cookie {
 	u32	magic;
 	u32	vlan_tag;
 };
 
-#define VLAN_TX_COOKIE_MAGIC	0x564c414e	/* "VLAN" in ascii. */
 #define VLAN_TX_SKB_CB(__skb)	((struct vlan_skb_tx_cookie *)&((__skb)->cb[0]))
-#define vlan_tx_tag_present(__skb) \
-	(VLAN_TX_SKB_CB(__skb)->magic == VLAN_TX_COOKIE_MAGIC)
+
 #define vlan_tx_tag_get(__skb)	(VLAN_TX_SKB_CB(__skb)->vlan_tag)
 
-/* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
-static inline int __vlan_hwaccel_rx(struct sk_buff *skb,
-				    struct vlan_group *grp,
-				    unsigned short vlan_tag, int polling)
-{
-	struct net_device_stats *stats;
-
-	skb->dev = grp->vlan_devices[vlan_tag & VLAN_VID_MASK];
-	if (skb->dev == NULL) {
-		dev_kfree_skb_any(skb);
-
-		/* Not NET_RX_DROP, this is not being dropped
-		 * due to congestion.
-		 */
-		return 0;
-	}
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#define VLAN_DEV_INFO(x) ((struct vlan_dev_info *)(x->priv))
+#define VLAN_REAL_DEV(x) (VLAN_DEV_INFO(x)->real_dev)
 
-	skb->dev->last_rx = jiffies;
+#define VLAN_TX_COOKIE_MAGIC	0x564c414e	/* "VLAN" in ascii. */
 
-	stats = vlan_dev_get_stats(skb->dev);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
-
-	skb->priority = vlan_get_ingress_priority(skb->dev, vlan_tag);
-	switch (skb->pkt_type) {
-	case PACKET_BROADCAST:
-		break;
-
-	case PACKET_MULTICAST:
-		stats->multicast++;
-		break;
-
-	case PACKET_OTHERHOST:
-		/* Our lower layer thinks this is not local, let's make sure.
-		 * This allows the VLAN to have a different MAC than the underlying
-		 * device, and still route correctly.
-		 */
-		if (!memcmp(eth_hdr(skb)->h_dest, skb->dev->dev_addr, ETH_ALEN))
-			skb->pkt_type = PACKET_HOST;
-		break;
-	};
 
-	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
-}
+#define vlan_tx_tag_present(__skb) \
+	(VLAN_TX_SKB_CB(__skb)->magic == VLAN_TX_COOKIE_MAGIC)
+
+
+int __vlan_hwaccel_rx(struct sk_buff *skb, struct vlan_group *grp,
+				    unsigned short vlan_tag, int polling);
 
 static inline int vlan_hwaccel_rx(struct sk_buff *skb,
 				  struct vlan_group *grp,
@@ -207,55 +159,7 @@ static inline int vlan_hwaccel_receive_s
 	return __vlan_hwaccel_rx(skb, grp, vlan_tag, 1);
 }
 
-/**
- * __vlan_put_tag - regular VLAN tag inserting
- * @skb: skbuff to tag
- * @tag: VLAN tag to insert
- *
- * Inserts the VLAN tag into @skb as part of the payload
- * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
- * 
- * Following the skb_unshare() example, in case of error, the calling function
- * doesn't have to worry about freeing the original skb.
- */
-static inline struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag)
-{
-	struct vlan_ethhdr *veth;
-
-	if (skb_headroom(skb) < VLAN_HLEN) {
-		struct sk_buff *sk_tmp = skb;
-		skb = skb_realloc_headroom(sk_tmp, VLAN_HLEN);
-		kfree_skb(sk_tmp);
-		if (!skb) {
-			printk(KERN_ERR "vlan: failed to realloc headroom\n");
-			return NULL;
-		}
-	} else {
-		skb = skb_unshare(skb, GFP_ATOMIC);
-		if (!skb) {
-			printk(KERN_ERR "vlan: failed to unshare skbuff\n");
-			return NULL;
-		}
-	}
-
-	veth = (struct vlan_ethhdr *)skb_push(skb, VLAN_HLEN);
-
-	/* Move the mac addresses to the beginning of the new header. */
-	memmove(skb->data, skb->data + VLAN_HLEN, 2 * VLAN_ETH_ALEN);
-
-	/* first, the ethernet type */
-	veth->h_vlan_proto = __constant_htons(ETH_P_8021Q);
-
-	/* now, the tag */
-	veth->h_vlan_TCI = htons(tag);
-
-	skb->protocol = __constant_htons(ETH_P_8021Q);
-	skb->mac.raw -= VLAN_HLEN;
-	skb->nh.raw -= VLAN_HLEN;
-
-	return skb;
-}
-
+struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag);
 /**
  * __vlan_hwaccel_put_tag - hardware accelerated VLAN inserting
  * @skb: skbuff to tag
@@ -274,8 +178,6 @@ static inline struct sk_buff *__vlan_hwa
 	return skb;
 }
 
-#define HAVE_VLAN_PUT_TAG
-
 /**
  * vlan_put_tag - inserts VLAN tag according to device features
  * @skb: skbuff to tag
@@ -304,7 +206,7 @@ static inline int __vlan_get_tag(struct 
 {
 	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
 
-	if (veth->h_vlan_proto != __constant_htons(ETH_P_8021Q)) {
+	if (veth->h_vlan_proto != htons(ETH_P_8021Q)) {
 		return -EINVAL;
 	}
 
@@ -334,8 +236,6 @@ static inline int __vlan_hwaccel_get_tag
 	}
 }
 
-#define HAVE_VLAN_GET_TAG
-
 /**
  * vlan_get_tag - get the VLAN ID from the skb
  * @skb: skbuff to query
@@ -352,6 +252,41 @@ static inline int vlan_get_tag(struct sk
 	}
 }
 
+#else
+
+#define VLAN_REAL_DEV(x) x
+#define vlan_tx_tag_present(__skb) 0
+
+static inline int vlan_hwaccel_rx(struct sk_buff *skb,
+				  struct vlan_group *grp,
+				  unsigned short vlan_tag)
+{
+	return netif_rx(skb);
+}
+
+static inline int vlan_hwaccel_receive_skb(struct sk_buff *skb,
+				  struct vlan_group *grp,
+				  unsigned short vlan_tag)
+{
+	return netif_receive_skb(skb);
+}
+
+static inline struct sk_buff *vlan_put_tag(struct sk_buff *skb, unsigned short tag)
+{
+	return skb;
+}
+
+static inline int vlan_get_tag(struct sk_buff *skb, unsigned short *tag)
+{
+	*tag = 0;
+	return -EINVAL;
+}
+
+#endif /* defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE) */
+
+
+
+
 #endif /* __KERNEL__ */
 
 /* VLAN IOCTLs are found in sockios.h */
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index da9cfe9..d7c4eb1 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -37,6 +37,21 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 
+/* inline functions */
+
+static inline struct net_device_stats *vlan_dev_get_stats(struct net_device *dev)
+{
+	return &(VLAN_DEV_INFO(dev)->dev_stats);
+}
+
+static inline __u32 vlan_get_ingress_priority(struct net_device *dev,
+					      unsigned short vlan_tag)
+{
+	struct vlan_dev_info *vip = VLAN_DEV_INFO(dev);
+
+	return vip->ingress_priority_map[(vlan_tag >> 13) & 0x7];
+}
+
 /*
  *	Rebuild the Ethernet MAC header. This is called after an ARP
  *	(or in future other address resolution) has completed on this
@@ -71,7 +86,7 @@ int vlan_dev_rebuild_header(struct sk_bu
 	return 0;
 }
 
-static inline struct sk_buff *vlan_check_reorder_header(struct sk_buff *skb)
+static struct sk_buff *vlan_check_reorder_header(struct sk_buff *skb)
 {
 	if (VLAN_DEV_INFO(skb->dev)->flags & 1) {
 		if (skb_shared(skb) || skb_cloned(skb)) {
@@ -90,6 +105,104 @@ static inline struct sk_buff *vlan_check
 	return skb;
 }
 
+/**
+ * __vlan_put_tag - regular VLAN tag inserting
+ * @skb: skbuff to tag
+ * @tag: VLAN tag to insert
+ *
+ * Inserts the VLAN tag into @skb as part of the payload
+ * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ * 
+ * Following the skb_unshare() example, in case of error, the calling function
+ * doesn't have to worry about freeing the original skb.
+ */
+struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag)
+{
+	struct vlan_ethhdr *veth;
+
+	if (skb_headroom(skb) < VLAN_HLEN) {
+		struct sk_buff *sk_tmp = skb;
+		skb = skb_realloc_headroom(sk_tmp, VLAN_HLEN);
+		kfree_skb(sk_tmp);
+		if (!skb) {
+			printk(KERN_ERR "vlan: failed to realloc headroom\n");
+			return NULL;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb) {
+			printk(KERN_ERR "vlan: failed to unshare skbuff\n");
+			return NULL;
+		}
+	}
+
+	veth = (struct vlan_ethhdr *)skb_push(skb, VLAN_HLEN);
+
+	/* Move the mac addresses to the beginning of the new header. */
+	memmove(skb->data, skb->data + VLAN_HLEN, 2 * VLAN_ETH_ALEN);
+
+	/* first, the ethernet type */
+	veth->h_vlan_proto = __constant_htons(ETH_P_8021Q);
+
+	/* now, the tag */
+	veth->h_vlan_TCI = htons(tag);
+
+	skb->protocol = __constant_htons(ETH_P_8021Q);
+	skb->mac.raw -= VLAN_HLEN;
+	skb->nh.raw -= VLAN_HLEN;
+
+	return skb;
+}
+
+static void vlan_rx_common(struct sk_buff *skb, unsigned short vlan_tag)
+{
+	struct net_device_stats *stats;
+
+	stats = vlan_dev_get_stats(skb->dev);
+	stats->rx_packets++;
+	stats->rx_bytes += skb->len;
+
+	skb->priority = vlan_get_ingress_priority(skb->dev, vlan_tag);
+	switch (skb->pkt_type) {
+	case PACKET_BROADCAST:
+		break;
+
+	case PACKET_MULTICAST:
+		stats->multicast++;
+		break;
+
+	case PACKET_OTHERHOST:
+		/* Our lower layer thinks this is not local, let's make sure.
+		 * This allows the VLAN to have a different MAC than the underlying
+		 * device, and still route correctly.
+		 */
+		if (!compare_ether_addr(eth_hdr(skb)->h_dest, skb->dev->dev_addr)) {
+			skb->pkt_type = PACKET_HOST;
+		break;
+	};
+}
+
+/* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
+int __vlan_hwaccel_rx(struct sk_buff *skb,
+				    struct vlan_group *grp,
+				    unsigned short vlan_tag, int polling)
+{
+	skb->dev = grp->vlan_devices[vlan_tag & VLAN_VID_MASK];
+	if (skb->dev == NULL) {
+		dev_kfree_skb_any(skb);
+
+		/* Not NET_RX_DROP, this is not being dropped
+		 * due to congestion.
+		 */
+		return 0;
+	}
+
+
+	skb->dev->last_rx = jiffies;
+	vlan_rx_common(skb, vlan_tag);
+	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+}
+
 /*
  *	Determine the packet's protocol ID. The rule here is that we 
  *	assume 802.3 if the type field is short enough to be a length.
@@ -158,11 +271,6 @@ int vlan_skb_recv(struct sk_buff *skb, s
 
 	skb->dev->last_rx = jiffies;
 
-	/* Bump the rx counters for the VLAN device. */
-	stats = vlan_dev_get_stats(skb->dev);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
-
 	/* Take off the VLAN header (4 bytes currently) */
 	skb_pull_rcsum(skb, VLAN_HLEN);
 
@@ -184,42 +292,7 @@ int vlan_skb_recv(struct sk_buff *skb, s
 		return -1;
 	}
 
-	/*
-	 * Deal with ingress priority mapping.
-	 */
-	skb->priority = vlan_get_ingress_priority(skb->dev, ntohs(vhdr->h_vlan_TCI));
-
-#ifdef VLAN_DEBUG
-	printk(VLAN_DBG "%s: priority: %lu  for TCI: %hu (hbo)\n",
-		__FUNCTION__, (unsigned long)(skb->priority), 
-		ntohs(vhdr->h_vlan_TCI));
-#endif
-
-	/* The ethernet driver already did the pkt_type calculations
-	 * for us...
-	 */
-	switch (skb->pkt_type) {
-	case PACKET_BROADCAST: /* Yeah, stats collect these together.. */
-		// stats->broadcast ++; // no such counter :-(
-		break;
-
-	case PACKET_MULTICAST:
-		stats->multicast++;
-		break;
-
-	case PACKET_OTHERHOST: 
-		/* Our lower layer thinks this is not local, let's make sure.
-		 * This allows the VLAN to have a different MAC than the underlying
-		 * device, and still route correctly.
-		 */
-		if (!compare_ether_addr(eth_hdr(skb)->h_dest, skb->dev->dev_addr)) {
-			/* It is for our (changed) MAC-address! */
-			skb->pkt_type = PACKET_HOST;
-		}
-		break;
-	default:
-		break;
-	};
+	vlan_rx_common(skb, vlan_tag);
 
 	/*  Was a VLAN packet, grab the encapsulated protocol, which the layer
 	 * three protocols care about.
@@ -258,7 +331,7 @@ int vlan_skb_recv(struct sk_buff *skb, s
 	 * won't work for fault tolerant netware but does for the rest.
 	 */
 	if (*(unsigned short *)rawp == 0xFFFF) {
-		skb->protocol = __constant_htons(ETH_P_802_3);
+		skb->protocol = htons(ETH_P_802_3);
 		/* place it back on the queue to be handled by true layer 3 protocols.
 		 */
 
@@ -281,7 +354,7 @@ int vlan_skb_recv(struct sk_buff *skb, s
 	/*
 	 *	Real 802.2 LLC
 	 */
-	skb->protocol = __constant_htons(ETH_P_802_2);
+	skb->protocol = htons(ETH_P_802_2);
 	/* place it back on the queue to be handled by upper layer protocols.
 	 */
 
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 3da9264..dec3495 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -879,10 +879,8 @@ static unsigned int ip_sabotage_out(unsi
 	if ((out->hard_start_xmit == br_dev_xmit &&
 	     okfn != br_nf_forward_finish &&
 	     okfn != br_nf_local_out_finish && okfn != br_nf_dev_queue_xmit)
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	    || ((out->priv_flags & IFF_802_1Q_VLAN) &&
-		VLAN_DEV_INFO(out)->real_dev->hard_start_xmit == br_dev_xmit)
-#endif
+		VLAN_REAL_DEV(out)->hard_start_xmit == br_dev_xmit)
 	    ) {
 		struct nf_bridge_info *nf_bridge;
 
