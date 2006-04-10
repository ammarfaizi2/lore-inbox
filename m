Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWDJORZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWDJORZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDJORZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:17:25 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41430 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751166AbWDJORY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:17:24 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] deinline a few large functions in vlan code v2
Date: Mon, 10 Apr 2006 17:16:58 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604100828.20994.vda@ilport.com.ua> <20060409.224559.124326025.davem@davemloft.net>
In-Reply-To: <20060409.224559.124326025.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ajmOE52oNSfsDo3"
Message-Id: <200604101716.58463.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ajmOE52oNSfsDo3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 10 April 2006 08:45, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Mon, 10 Apr 2006 08:28:20 +0300
> 
> > IOW: shouldn't calls to these functions sit in
> > #if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> > block? For example, typhoon.c:
> > 
> >                 spin_lock(&tp->state_lock);
> > +#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> >                 if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
> >                         vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
> >                                                  ntohl(rx->vlanTag) & 0xffff);
> >                 else
> > +#endif
> >                         netif_receive_skb(new_skb);
> >                 spin_unlock(&tp->state_lock);
> > 
> > Same for s2io.c, chelsio/sge.c, etc...
> 
> Very likely yes.  tp->vlgrp will never be non-NULL in such situations
> so it's not a correctness issue, but rather an optimization :-)

Done. Please see attached.

Deinline a few functions which produce 150+ bytes of code.

They are moved into new file, net/core/dev_vlan.c, which
is compiled to nothing if VLAN support is not enabled at all
(even as a module).

A few drivers which were trying to call vlan routines
on non-vlan-enabled kernel are fixed.

Compile tested (allyesconfig + "# CONFIG_VLAN_8021Q is not set").

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_ajmOE52oNSfsDo3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.16.1.vlan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.1.vlan.patch"

# size vmlinux.org vmlinux.new
    text    data     bss      dec     hex filename
20477010 6152182 1729804 28358996 1b0b954 vmlinux.org
20472545 6152150 1729804 28354499 1b0a7c3 vmlinux.new

diff -urpN linux-2.6.16.1.org/drivers/net/bnx2.c linux-2.6.16.1.vlan/drivers/net/bnx2.c
--- linux-2.6.16.1.org/drivers/net/bnx2.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/bnx2.c	Mon Apr 10 16:01:01 2006
@@ -4436,10 +4436,13 @@ bnx2_start_xmit(struct sk_buff *skb, str
 		vlan_tag_flags |= TX_BD_FLAGS_TCP_UDP_CKSUM;
 	}
 
+#ifdef BCM_VLAN
 	if (bp->vlgrp != 0 && vlan_tx_tag_present(skb)) {
 		vlan_tag_flags |=
 			(TX_BD_FLAGS_VLAN_TAG | (vlan_tx_tag_get(skb) << 16));
 	}
+#endif
+
 #ifdef BCM_TSO 
 	if ((mss = skb_shinfo(skb)->tso_size) &&
 		(skb->len > (bp->dev->mtu + ETH_HLEN))) {
diff -urpN linux-2.6.16.1.org/drivers/net/bnx2.h linux-2.6.16.1.vlan/drivers/net/bnx2.h
--- linux-2.6.16.1.org/drivers/net/bnx2.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/bnx2.h	Mon Apr 10 16:01:01 2006
@@ -40,7 +40,9 @@
 #include <linux/mii.h>
 #ifdef NETIF_F_HW_VLAN_TX
 #include <linux/if_vlan.h>
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #define BCM_VLAN 1
+#endif
 #endif
 #ifdef NETIF_F_TSO
 #include <net/ip.h>
diff -urpN linux-2.6.16.1.org/drivers/net/bonding/bond_alb.c linux-2.6.16.1.vlan/drivers/net/bonding/bond_alb.c
--- linux-2.6.16.1.org/drivers/net/bonding/bond_alb.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/bonding/bond_alb.c	Mon Apr 10 16:01:01 2006
@@ -502,6 +502,7 @@ static void rlb_update_client(struct rlb
 
 		skb->dev = client_info->slave->dev;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (client_info->tag) {
 			skb = vlan_put_tag(skb, client_info->vlan_id);
 			if (!skb) {
@@ -511,7 +512,7 @@ static void rlb_update_client(struct rlb
 				continue;
 			}
 		}
-
+#endif
 		arp_xmit(skb);
 	}
 }
@@ -870,7 +871,9 @@ static void rlb_clear_vlan(struct bondin
 
 static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[])
 {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	struct bonding *bond = bond_get_bond_by_slave(slave);
+#endif
 	struct learning_pkt pkt;
 	int size = sizeof(struct learning_pkt);
 	int i;
@@ -898,6 +901,7 @@ static void alb_send_learning_packets(st
 		skb->priority = TC_PRIO_CONTROL;
 		skb->dev = slave->dev;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (!list_empty(&bond->vlan_list)) {
 			struct vlan_entry *vlan;
 
@@ -918,7 +922,7 @@ static void alb_send_learning_packets(st
 				continue;
 			}
 		}
-
+#endif
 		dev_queue_xmit(skb);
 	}
 }
diff -urpN linux-2.6.16.1.org/drivers/net/bonding/bond_main.c linux-2.6.16.1.vlan/drivers/net/bonding/bond_main.c
--- linux-2.6.16.1.org/drivers/net/bonding/bond_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/bonding/bond_main.c	Mon Apr 10 16:01:01 2006
@@ -366,6 +366,7 @@ struct vlan_entry *bond_next_vlan(struct
  */
 int bond_dev_queue_xmit(struct bonding *bond, struct sk_buff *skb, struct net_device *slave_dev)
 {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	unsigned short vlan_id;
 
 	if (!list_empty(&bond->vlan_list) &&
@@ -380,9 +381,9 @@ int bond_dev_queue_xmit(struct bonding *
 			 */
 			return 0;
 		}
-	} else {
+	} else
+#endif
 		skb->dev = slave_dev;
-	}
 
 	skb->priority = 1;
 	dev_queue_xmit(skb);
@@ -2270,6 +2271,7 @@ static void bond_arp_send(struct net_dev
 		printk(KERN_ERR DRV_NAME ": ARP packet allocation failed\n");
 		return;
 	}
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (vlan_id) {
 		skb = vlan_put_tag(skb, vlan_id);
 		if (!skb) {
@@ -2277,6 +2279,7 @@ static void bond_arp_send(struct net_dev
 			return;
 		}
 	}
+#endif
 	arp_xmit(skb);
 }
 
diff -urpN linux-2.6.16.1.org/drivers/net/chelsio/sge.c linux-2.6.16.1.vlan/drivers/net/chelsio/sge.c
--- linux-2.6.16.1.org/drivers/net/chelsio/sge.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/chelsio/sge.c	Mon Apr 10 16:01:01 2006
@@ -978,6 +978,7 @@ static int sge_rx(struct sge *sge, struc
 	} else
 		skb->ip_summed = CHECKSUM_NONE;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (unlikely(adapter->vlan_grp && p->vlan_valid)) {
 		sge->port_stats[p->iff].vlan_xtract++;
 		if (adapter->params.sge.polling)
@@ -986,7 +987,9 @@ static int sge_rx(struct sge *sge, struc
 		else
 			vlan_hwaccel_rx(skb, adapter->vlan_grp,
 					ntohs(p->vlan));
-	} else if (adapter->params.sge.polling)
+	} else
+#endif
+	if (adapter->params.sge.polling)
 		netif_receive_skb(skb);
 	else
 		netif_rx(skb);
diff -urpN linux-2.6.16.1.org/drivers/net/e1000/e1000_main.c linux-2.6.16.1.vlan/drivers/net/e1000/e1000_main.c
--- linux-2.6.16.1.org/drivers/net/e1000/e1000_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/e1000/e1000_main.c	Mon Apr 10 16:01:01 2006
@@ -3714,23 +3714,25 @@ e1000_clean_rx_irq(struct e1000_adapter 
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_E1000_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 						 le16_to_cpu(rx_desc->special) &
 						 E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_E1000_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp &&
 			    (status & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 					le16_to_cpu(rx_desc->special) &
 					E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_E1000_NAPI */
 		netdev->last_rx = jiffies;
 #ifdef CONFIG_E1000_MQ
@@ -3861,21 +3863,23 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 			   cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP)))
 			adapter->rx_hdr_split++;
 #ifdef CONFIG_E1000_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_E1000_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->wb.middle.vlan) &
 				E1000_RXD_SPC_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_E1000_NAPI */
 		netdev->last_rx = jiffies;
 #ifdef CONFIG_E1000_MQ
diff -urpN linux-2.6.16.1.org/drivers/net/ixgb/ixgb_main.c linux-2.6.16.1.vlan/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.16.1.org/drivers/net/ixgb/ixgb_main.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/ixgb/ixgb_main.c	Mon Apr 10 16:01:01 2006
@@ -1905,21 +1905,23 @@ ixgb_clean_rx_irq(struct ixgb_adapter *a
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_IXGB_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_receive_skb(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_receive_skb(skb);
-		}
 #else /* CONFIG_IXGB_NAPI */
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if(adapter->vlgrp && (status & IXGB_RX_DESC_STATUS_VP)) {
 			vlan_hwaccel_rx(skb, adapter->vlgrp,
 				le16_to_cpu(rx_desc->special) &
 					IXGB_RX_DESC_SPECIAL_VLAN_MASK);
-		} else {
+		} else
+#endif
 			netif_rx(skb);
-		}
 #endif /* CONFIG_IXGB_NAPI */
 		netdev->last_rx = jiffies;
 
diff -urpN linux-2.6.16.1.org/drivers/net/s2io.c linux-2.6.16.1.vlan/drivers/net/s2io.c
--- linux-2.6.16.1.org/drivers/net/s2io.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/s2io.c	Mon Apr 10 16:01:01 2006
@@ -5680,21 +5680,23 @@ static int rx_osm_handler(ring_info_t *r
 
 	skb->protocol = eth_type_trans(skb, dev);
 #ifdef CONFIG_S2IO_NAPI
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_receive_skb(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
-	} else {
+	} else
+#endif
 		netif_receive_skb(skb);
-	}
 #else
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (sp->vlgrp && RXD_GET_VLAN_TAG(rxdp->Control_2)) {
 		/* Queueing the vlan frame to the upper layer */
 		vlan_hwaccel_rx(skb, sp->vlgrp,
 			RXD_GET_VLAN_TAG(rxdp->Control_2));
-	} else {
+	} else
+#endif
 		netif_rx(skb);
-	}
 #endif
 	dev->last_rx = jiffies;
 	atomic_dec(&sp->rx_bufs_left[ring_no]);
diff -urpN linux-2.6.16.1.org/drivers/net/typhoon.c linux-2.6.16.1.vlan/drivers/net/typhoon.c
--- linux-2.6.16.1.org/drivers/net/typhoon.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/drivers/net/typhoon.c	Mon Apr 10 16:01:01 2006
@@ -1745,10 +1745,12 @@ typhoon_rx(struct typhoon *tp, struct ba
 			new_skb->ip_summed = CHECKSUM_NONE;
 
 		spin_lock(&tp->state_lock);
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
 			vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
 						 ntohl(rx->vlanTag) & 0xffff);
 		else
+#endif
 			netif_receive_skb(new_skb);
 		spin_unlock(&tp->state_lock);
 
diff -urpN linux-2.6.16.1.org/include/linux/if_vlan.h linux-2.6.16.1.vlan/include/linux/if_vlan.h
--- linux-2.6.16.1.org/include/linux/if_vlan.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/include/linux/if_vlan.h	Mon Apr 10 16:01:01 2006
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
diff -urpN linux-2.6.16.1.org/net/core/Makefile linux-2.6.16.1.vlan/net/core/Makefile
--- linux-2.6.16.1.org/net/core/Makefile	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.1.vlan/net/core/Makefile	Mon Apr 10 16:01:01 2006
@@ -7,7 +7,7 @@ obj-y := sock.o request_sock.o skbuff.o 
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
+obj-y		     += dev.o ethtool.o dev_mcast.o dev_vlan.o dst.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
 obj-$(CONFIG_XFRM) += flow.o
diff -urpN linux-2.6.16.1.org/net/core/dev_vlan.c linux-2.6.16.1.vlan/net/core/dev_vlan.c
--- linux-2.6.16.1.org/net/core/dev_vlan.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.1.vlan/net/core/dev_vlan.c	Mon Apr 10 16:01:01 2006
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

--Boundary-00=_ajmOE52oNSfsDo3--
