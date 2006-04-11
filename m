Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDKMYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDKMYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWDKMYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:24:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12266 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750798AbWDKMYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:24:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/3] deinline a few large functions in vlan code - v3
Date: Tue, 11 Apr 2006 15:24:12 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
References: <200604111047.36941.vda@ilport.com.ua> <200604111111.12554.vda@ilport.com.ua> <20060411.013642.78129957.davem@davemloft.net>
In-Reply-To: <20060411.013642.78129957.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s/5OErUTOe6Heko"
Message-Id: <200604111524.12904.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_s/5OErUTOe6Heko
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 April 2006 11:36, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Tue, 11 Apr 2006 11:11:12 +0300
> 
> > Ok, one last try. Would you like this smallish patch instead?
> > It takes care of those BIG inlines.
> 
> You're putting vlan stuff into a net/core/*.c file, that
> is not correct.

This code is _already_ there, duplicated in every driver
of VLAN-capable NIC.

In other words:
if you have just one VLAN-capable NIC driver compiled in,
you have that code in bzImage. If you have ten drivers,
you have that code duplicated ten times.

On my current kernel, I have several dozens NIC drivers
compiled in, because I don't want to mess with modules
on initrd for network boot...

Regarding net/core/*.c. You are right.
The below patch puts this code into net/8021q/if_vlan.c.
Does it look better?
--
vda

--Boundary-00=_s/5OErUTOe6Heko
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.16.vlan_inline6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.vlan_inline6.patch"

diff -urpN linux-2.6.16.org/include/linux/if_vlan.h linux-2.6.16.vlanmini/include/linux/if_vlan.h
--- linux-2.6.16.org/include/linux/if_vlan.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlanmini/include/linux/if_vlan.h	Tue Apr 11 15:08:31 2006
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
diff -urpN linux-2.6.16.org/net/8021q/Makefile linux-2.6.16.vlanmini/net/8021q/Makefile
--- linux-2.6.16.org/net/8021q/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlanmini/net/8021q/Makefile	Tue Apr 11 15:08:51 2006
@@ -2,6 +2,8 @@
 # Makefile for the Linux VLAN layer.
 #
 
+obj-y			 += if_vlan.o
+
 obj-$(CONFIG_VLAN_8021Q) += 8021q.o
 
 8021q-objs := vlan.o vlan_dev.o
diff -urpN linux-2.6.16.org/net/8021q/if_vlan.c linux-2.6.16.vlanmini/net/8021q/if_vlan.c
--- linux-2.6.16.org/net/8021q/if_vlan.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.vlanmini/net/8021q/if_vlan.c	Tue Apr 11 15:07:09 2006
@@ -0,0 +1,106 @@
+/* 802.1q helpers.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
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
diff -urpN linux-2.6.16.org/net/Makefile linux-2.6.16.vlanmini/net/Makefile
--- linux-2.6.16.org/net/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.vlanmini/net/Makefile	Tue Apr 11 15:05:11 2006
@@ -41,7 +41,7 @@ obj-$(CONFIG_RXRPC)		+= rxrpc/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_DECNET)		+= decnet/
 obj-$(CONFIG_ECONET)		+= econet/
-obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
+obj-y				+= 8021q/
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
 obj-$(CONFIG_IEEE80211)		+= ieee80211/

--Boundary-00=_s/5OErUTOe6Heko--
