Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWDKHsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWDKHsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWDKHsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:48:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7126 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932325AbWDKHsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:48:06 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3/3] deinline a few large functions in vlan code - v3
Date: Tue, 11 Apr 2006 10:47:36 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
References: <200604111043.13605.vda@ilport.com.ua> <200604111044.05847.vda@ilport.com.ua>
In-Reply-To: <200604111044.05847.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y81OE7ygvqSZeS+"
Message-Id: <200604111047.36941.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Y81OE7ygvqSZeS+
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 April 2006 10:44, Denis Vlasenko wrote:
On Tuesday 11 April 2006 10:43, Denis Vlasenko wrote:
> These patches exclude VLAN code from netdevice drivers
> and from bonding module, and even remove vlan-related
> members of struct netdevice if VLAN is not configured.
> 
> Compile tested on allyesconfig kernel with CONFIG_8021Q=y,m,n.

This one add #ifdefs around vlan_rx_* members of struct netdevice,
and moves large inlines out-of-line.
--
vda

--Boundary-00=_Y81OE7ygvqSZeS+
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.16.vlan_inline5_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.vlan_inline5_core.patch"

diff -urpN linux-2.6.16.org/include/linux/if_vlan.h linux-2.6.16.vlan/include/linux/if_vlan.h
--- linux-2.6.16.org/include/linux/if_vlan.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/include/linux/if_vlan.h	Tue Apr 11 10:15:59 2006
@@ -149,49 +149,9 @@ struct vlan_skb_tx_cookie {
 #define vlan_tx_tag_get(__skb)	(VLAN_TX_SKB_CB(__skb)->vlan_tag)
 
 /* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
-static inline int __vlan_hwaccel_rx(struct sk_buff *skb,
+int __vlan_hwaccel_rx(struct sk_buff *skb,
 				    struct vlan_group *grp,
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
-
-	skb->dev->last_rx = jiffies;
-
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
-
-	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
-}
+				    unsigned short vlan_tag, int polling);
 
 static inline int vlan_hwaccel_rx(struct sk_buff *skb,
 				  struct vlan_group *grp,
@@ -218,43 +178,7 @@ static inline int vlan_hwaccel_receive_s
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
  */
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
+struct sk_buff *__vlan_put_tag(struct sk_buff *skb, unsigned short tag);
 
 /**
  * __vlan_hwaccel_put_tag - hardware accelerated VLAN inserting
diff -urpN linux-2.6.16.org/include/linux/netdevice.h linux-2.6.16.vlan/include/linux/netdevice.h
--- linux-2.6.16.org/include/linux/netdevice.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/include/linux/netdevice.h	Tue Apr 11 10:15:59 2006
@@ -475,12 +475,14 @@ struct net_device
 #define HAVE_TX_TIMEOUT
 	void			(*tx_timeout) (struct net_device *dev);
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	void			(*vlan_rx_register)(struct net_device *dev,
 						    struct vlan_group *grp);
 	void			(*vlan_rx_add_vid)(struct net_device *dev,
 						   unsigned short vid);
 	void			(*vlan_rx_kill_vid)(struct net_device *dev,
 						    unsigned short vid);
+#endif
 
 	int			(*hard_header_parse)(struct sk_buff *skb,
 						     unsigned char *haddr);
diff -urpN linux-2.6.16.org/net/core/Makefile linux-2.6.16.vlan/net/core/Makefile
--- linux-2.6.16.org/net/core/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlan/net/core/Makefile	Tue Apr 11 10:15:59 2006
@@ -7,7 +7,7 @@ obj-y := sock.o request_sock.o skbuff.o 
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
+obj-y		     += dev.o ethtool.o dev_mcast.o dev_vlan.o dst.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
 obj-$(CONFIG_XFRM) += flow.o
diff -urpN linux-2.6.16.org/net/core/dev_vlan.c linux-2.6.16.vlan/net/core/dev_vlan.c
--- linux-2.6.16.org/net/core/dev_vlan.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.vlan/net/core/dev_vlan.c	Tue Apr 11 10:15:59 2006
@@ -0,0 +1,110 @@
+/* 802.1q helpers.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
+
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+
+/* VLAN rx hw acceleration helper.  This acts like netif_{rx,receive_skb}(). */
+int __vlan_hwaccel_rx(struct sk_buff *skb,
+				    struct vlan_group *grp,
+				    unsigned short vlan_tag, int polling)
+{
+	struct net_device_stats *stats;
+
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
+	skb->dev->last_rx = jiffies;
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
+		if (!memcmp(eth_hdr(skb)->h_dest, skb->dev->dev_addr, ETH_ALEN))
+			skb->pkt_type = PACKET_HOST;
+		break;
+	};
+
+	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+}
+EXPORT_SYMBOL(__vlan_hwaccel_rx);
+
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
+EXPORT_SYMBOL(__vlan_put_tag);
+
+#endif

--Boundary-00=_Y81OE7ygvqSZeS+--
