Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSITLah>; Fri, 20 Sep 2002 07:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSITLag>; Fri, 20 Sep 2002 07:30:36 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:42630 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S262258AbSITLa2>; Fri, 20 Sep 2002 07:30:28 -0400
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCH] PF_PACKET filtering hooks for netfilter
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 20 Sep 2002 13:35:10 +0200
Message-ID: <wrpsn04rj0x.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpheh1da00.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

David, Lkml,

The included patch adds two new hooks to the netfilter framework, at
the packet level.

With this patch, it is now possible to write filtering modules for non
IP/ARP protocols (or even filtering access to user-mode services bound
to a packet socket, encription at the device level...).

It also add the necessary logic to control such modules via
setsockopt/getsockopt.

I made two version of this patch : one for 2.4.20-pre5, the other for
2.5.33. I'd be very glad to have some feedback from people trying it,
as well as any comment about what is ok and what isn't with this patch.

Thanks a lot,

        M.


--=-=-=
Content-Disposition: attachment; filename=pf_packet-2.4.20-pre5.diff

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.612   -> 1.613  
#	net/packet/af_packet.c	1.10    -> 1.11   
#	      net/core/dev.c	1.28    -> 1.29   
#	               (new)	        -> 1.1     include/linux/netfilter_packet.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/07	maz@hina.wild-wind.fr.eu.org	1.613
# Implements PF_PACKET netfilter hooks, as well as PF_PACKET
# {get,set}sockopt operations to control modules.
# --------------------------------------------
#
diff -Nru a/include/linux/netfilter_packet.h b/include/linux/netfilter_packet.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/netfilter_packet.h	Sat Sep  7 18:25:04 2002
@@ -0,0 +1,17 @@
+#ifndef __LINUX_NETFILTER_PACKET_H
+#define __LINUX_NETFILTER_PACKET_H
+
+/* PF_PACKET-specific defines for netfilter.
+ * Written by Marc Zyngier <Marc.Zyngier@evidian.com>
+ * (C)2002 Evidian -- This code is GPL.
+ */
+
+#include <linux/config.h>
+#include <linux/netfilter.h>
+
+/* PF_PACKET filter hooks */
+
+#define NF_PACKET_INPUT		0
+#define NF_PACKET_OUTPUT	1
+
+#endif /* __LINUX_NETFILTER_PACKET_H */
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Sat Sep  7 18:25:04 2002
+++ b/net/core/dev.c	Sat Sep  7 18:25:04 2002
@@ -100,6 +100,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/netfilter_packet.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -986,40 +987,11 @@
  *	to congestion or traffic shaping.
  */
 
-int dev_queue_xmit(struct sk_buff *skb)
+static inline int dev_queue_xmit_finish(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
 	struct Qdisc  *q;
 
-	if (skb_shinfo(skb)->frag_list &&
-	    !(dev->features&NETIF_F_FRAGLIST) &&
-	    skb_linearize(skb, GFP_ATOMIC) != 0) {
-		kfree_skb(skb);
-		return -ENOMEM;
-	}
-
-	/* Fragmented skb is linearized if device does not support SG,
-	 * or if at least one of fragments is in highmem and device
-	 * does not support DMA from it.
-	 */
-	if (skb_shinfo(skb)->nr_frags &&
-	    (!(dev->features&NETIF_F_SG) || illegal_highdma(dev, skb)) &&
-	    skb_linearize(skb, GFP_ATOMIC) != 0) {
-		kfree_skb(skb);
-		return -ENOMEM;
-	}
-
-	/* If packet is not checksummed and device does not support
-	 * checksumming for this protocol, complete checksumming here.
-	 */
-	if (skb->ip_summed == CHECKSUM_HW &&
-	    (!(dev->features&(NETIF_F_HW_CSUM|NETIF_F_NO_CSUM)) &&
-	     (!(dev->features&NETIF_F_IP_CSUM) ||
-	      skb->protocol != htons(ETH_P_IP)))) {
-		if ((skb = skb_checksum_help(skb)) == NULL)
-			return -ENOMEM;
-	}
-
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
 	q = dev->qdisc;
@@ -1079,6 +1051,43 @@
 	return -ENETDOWN;
 }
 
+int dev_queue_xmit(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+
+	if (skb_shinfo(skb)->frag_list &&
+	    !(dev->features&NETIF_F_FRAGLIST) &&
+	    skb_linearize(skb, GFP_ATOMIC) != 0) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
+	/* Fragmented skb is linearized if device does not support SG,
+	 * or if at least one of fragments is in highmem and device
+	 * does not support DMA from it.
+	 */
+	if (skb_shinfo(skb)->nr_frags &&
+	    (!(dev->features&NETIF_F_SG) || illegal_highdma(dev, skb)) &&
+	    skb_linearize(skb, GFP_ATOMIC) != 0) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
+	/* If packet is not checksummed and device does not support
+	 * checksumming for this protocol, complete checksumming here.
+	 */
+	if (skb->ip_summed == CHECKSUM_HW &&
+	    (!(dev->features&(NETIF_F_HW_CSUM|NETIF_F_NO_CSUM)) &&
+	     (!(dev->features&NETIF_F_IP_CSUM) ||
+	      skb->protocol != htons(ETH_P_IP)))) {
+		if ((skb = skb_checksum_help(skb)) == NULL)
+			return -ENOMEM;
+	}
+
+	return NF_HOOK(PF_PACKET, NF_PACKET_OUTPUT, skb, NULL, dev,
+		       dev_queue_xmit_finish);
+}
+
 
 /*=======================================================================
 			Receiver routines
@@ -1424,28 +1433,12 @@
 }
 #endif   /* CONFIG_NET_DIVERT */
 
-int netif_receive_skb(struct sk_buff *skb)
+static inline int netif_receive_skb_finish(struct sk_buff *skb)
 {
 	struct packet_type *ptype, *pt_prev;
 	int ret = NET_RX_DROP;
 	unsigned short type = skb->protocol;
 
-	if (skb->stamp.tv_sec == 0)
-		do_gettimeofday(&skb->stamp);
-
-	skb_bond(skb);
-
-	netdev_rx_stat[smp_processor_id()].total++;
-
-#ifdef CONFIG_NET_FASTROUTE
-	if (skb->pkt_type == PACKET_FASTROUTE) {
-		netdev_rx_stat[smp_processor_id()].fastroute_deferred_out++;
-		return dev_queue_xmit(skb);
-	}
-#endif
-
-	skb->h.raw = skb->nh.raw = skb->data;
-
 	pt_prev = NULL;
 	for (ptype = ptype_all; ptype; ptype = ptype->next) {
 		if (!ptype->dev || ptype->dev == skb->dev) {
@@ -1503,6 +1496,28 @@
 	}
 
 	return ret;
+}
+
+int netif_receive_skb(struct sk_buff *skb)
+{
+	if (skb->stamp.tv_sec == 0)
+		do_gettimeofday(&skb->stamp);
+
+	skb_bond(skb);
+
+	netdev_rx_stat[smp_processor_id()].total++;
+
+#ifdef CONFIG_NET_FASTROUTE
+	if (skb->pkt_type == PACKET_FASTROUTE) {
+		netdev_rx_stat[smp_processor_id()].fastroute_deferred_out++;
+		return dev_queue_xmit(skb);
+	}
+#endif
+
+	skb->h.raw = skb->nh.raw = skb->data;
+
+	return NF_HOOK(PF_PACKET, NF_PACKET_INPUT, skb, skb->dev, NULL,
+		       netif_receive_skb_finish);
 }
 
 static int process_backlog(struct net_device *blog_dev, int *budget)
diff -Nru a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c	Sat Sep  7 18:25:04 2002
+++ b/net/packet/af_packet.c	Sat Sep  7 18:25:04 2002
@@ -77,6 +77,10 @@
 #include <net/inet_common.h>
 #endif
 
+#ifdef CONFIG_NETFILTER
+#include <linux/netfilter.h>
+#endif
+
 #ifdef CONFIG_DLCI
 extern int dlci_ioctl(unsigned int, void*);
 #endif
@@ -1321,7 +1325,12 @@
 	}
 #endif
 	default:
+#ifdef CONFIG_NETFILTER
+	        return nf_setsockopt(sock->sk, PF_PACKET, optname, optval,
+				     optlen);
+#else
 		return -ENOPROTOOPT;
+#endif
 	}
 }
 
@@ -1358,7 +1367,12 @@
 		break;
 	}
 	default:
+#ifdef CONFIG_NETFILTER
+	  	return nf_getsockopt(sock->sk, PF_PACKET, optname, optval,
+				     optlen);
+#else
 		return -ENOPROTOOPT;
+#endif
 	}
 
   	if (put_user(len, optlen))

--=-=-=
Content-Disposition: attachment; filename=pf_packet-2.5.33.diff

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.582   -> 1.583  
#	net/packet/af_packet.c	1.14    -> 1.15   
#	      net/core/dev.c	1.36    -> 1.37   
#	               (new)	        -> 1.1     include/linux/netfilter_packet.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/07	maz@hina.wild-wind.fr.eu.org	1.583
# Implements PF_PACKET netfilter hooks, as well as PF_PACKET
# {get,set}sockopt operations to control modules.
# --------------------------------------------
#
diff -Nru a/include/linux/netfilter_packet.h b/include/linux/netfilter_packet.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/netfilter_packet.h	Sat Sep  7 15:35:07 2002
@@ -0,0 +1,17 @@
+#ifndef __LINUX_NETFILTER_PACKET_H
+#define __LINUX_NETFILTER_PACKET_H
+
+/* PF_PACKET-specific defines for netfilter.
+ * Written by Marc Zyngier <Marc.Zyngier@evidian.com>
+ * (C)2002 Evidian -- This code is GPL.
+ */
+
+#include <linux/config.h>
+#include <linux/netfilter.h>
+
+/* PF_PACKET filter hooks */
+
+#define NF_PACKET_INPUT		0
+#define NF_PACKET_OUTPUT	1
+
+#endif /* __LINUX_NETFILTER_PACKET_H */
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Sat Sep  7 15:35:07 2002
+++ b/net/core/dev.c	Sat Sep  7 15:35:07 2002
@@ -105,6 +105,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/netfilter_packet.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -976,37 +977,12 @@
  *	to congestion or traffic shaping.
  */
 
-int dev_queue_xmit(struct sk_buff *skb)
+static inline int dev_queue_xmit_finish(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
 	struct Qdisc *q;
 	int rc = -ENOMEM;
 
-	if (skb_shinfo(skb)->frag_list &&
-	    !(dev->features & NETIF_F_FRAGLIST) &&
-	    skb_linearize(skb, GFP_ATOMIC))
-		goto out_kfree_skb;
-
-	/* Fragmented skb is linearized if device does not support SG,
-	 * or if at least one of fragments is in highmem and device
-	 * does not support DMA from it.
-	 */
-	if (skb_shinfo(skb)->nr_frags &&
-	    (!(dev->features & NETIF_F_SG) || illegal_highdma(dev, skb)) &&
-	    skb_linearize(skb, GFP_ATOMIC))
-		goto out_kfree_skb;
-
-	/* If packet is not checksummed and device does not support
-	 * checksumming for this protocol, complete checksumming here.
-	 */
-	if (skb->ip_summed == CHECKSUM_HW &&
-	    (!(dev->features & (NETIF_F_HW_CSUM | NETIF_F_NO_CSUM)) &&
-	     (!(dev->features & NETIF_F_IP_CSUM) ||
-	      skb->protocol != htons(ETH_P_IP)))) {
-		if ((skb = skb_checksum_help(skb)) == NULL)
-			goto out;
-	}
-
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
 	q = dev->qdisc;
@@ -1074,12 +1050,49 @@
 	spin_unlock_bh(&dev->queue_lock);
 out_enetdown:
 	rc = -ENETDOWN;
-out_kfree_skb:
 	kfree_skb(skb);
 out:
 	return rc;
 }
 
+int dev_queue_xmit(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	int rc = -ENOMEM;
+
+	if (skb_shinfo(skb)->frag_list &&
+	    !(dev->features & NETIF_F_FRAGLIST) &&
+	    skb_linearize(skb, GFP_ATOMIC))
+		goto out_kfree_skb;
+
+	/* Fragmented skb is linearized if device does not support SG,
+	 * or if at least one of fragments is in highmem and device
+	 * does not support DMA from it.
+	 */
+	if (skb_shinfo(skb)->nr_frags &&
+	    (!(dev->features & NETIF_F_SG) || illegal_highdma(dev, skb)) &&
+	    skb_linearize(skb, GFP_ATOMIC))
+		goto out_kfree_skb;
+
+	/* If packet is not checksummed and device does not support
+	 * checksumming for this protocol, complete checksumming here.
+	 */
+	if (skb->ip_summed == CHECKSUM_HW &&
+	    (!(dev->features & (NETIF_F_HW_CSUM | NETIF_F_NO_CSUM)) &&
+	     (!(dev->features & NETIF_F_IP_CSUM) ||
+	      skb->protocol != htons(ETH_P_IP)))) {
+		if ((skb = skb_checksum_help(skb)) == NULL)
+			goto out;
+	}
+
+	return NF_HOOK(PF_PACKET, NF_PACKET_OUTPUT, skb, NULL, dev,
+		       dev_queue_xmit_finish);
+
+out_kfree_skb:
+	kfree_skb(skb);
+out:
+	return rc;
+}
 
 /*=======================================================================
 			Receiver routines
@@ -1427,28 +1440,12 @@
 }
 #endif   /* CONFIG_NET_DIVERT */
 
-int netif_receive_skb(struct sk_buff *skb)
+static inline int netif_receive_skb_finish(struct sk_buff *skb)
 {
 	struct packet_type *ptype, *pt_prev;
 	int ret = NET_RX_DROP;
 	unsigned short type = skb->protocol;
 
-	if (!skb->stamp.tv_sec)
-		do_gettimeofday(&skb->stamp);
-
-	skb_bond(skb);
-
-	netdev_rx_stat[smp_processor_id()].total++;
-
-#ifdef CONFIG_NET_FASTROUTE
-	if (skb->pkt_type == PACKET_FASTROUTE) {
-		netdev_rx_stat[smp_processor_id()].fastroute_deferred_out++;
-		return dev_queue_xmit(skb);
-	}
-#endif
-
-	skb->h.raw = skb->nh.raw = skb->data;
-
 	pt_prev = NULL;
 	for (ptype = ptype_all; ptype; ptype = ptype->next) {
 		if (!ptype->dev || ptype->dev == skb->dev) {
@@ -1509,6 +1506,28 @@
 	}
 
 	return ret;
+}
+
+int netif_receive_skb(struct sk_buff *skb)
+{
+	if (!skb->stamp.tv_sec)
+		do_gettimeofday(&skb->stamp);
+
+	skb_bond(skb);
+
+	netdev_rx_stat[smp_processor_id()].total++;
+
+#ifdef CONFIG_NET_FASTROUTE
+	if (skb->pkt_type == PACKET_FASTROUTE) {
+		netdev_rx_stat[smp_processor_id()].fastroute_deferred_out++;
+		return dev_queue_xmit(skb);
+	}
+#endif
+
+	skb->h.raw = skb->nh.raw = skb->data;
+
+	return NF_HOOK(PF_PACKET, NF_PACKET_INPUT, skb, skb->dev, NULL,
+		       netif_receive_skb_finish);
 }
 
 static int process_backlog(struct net_device *backlog_dev, int *budget)
diff -Nru a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c	Sat Sep  7 15:35:07 2002
+++ b/net/packet/af_packet.c	Sat Sep  7 15:35:07 2002
@@ -77,6 +77,10 @@
 #include <net/inet_common.h>
 #endif
 
+#ifdef CONFIG_NETFILTER
+#include <linux/netfilter.h>
+#endif
+
 #ifdef CONFIG_DLCI
 extern int dlci_ioctl(unsigned int, void*);
 #endif
@@ -1333,7 +1337,12 @@
 	}
 #endif
 	default:
+#ifdef CONFIG_NETFILTER
+	        return nf_setsockopt(sock->sk, PF_PACKET, optname, optval,
+				     optlen);
+#else
 		return -ENOPROTOOPT;
+#endif
 	}
 }
 
@@ -1371,7 +1380,12 @@
 		break;
 	}
 	default:
+#ifdef CONFIG_NETFILTER
+	  	return nf_getsockopt(sock->sk, PF_PACKET, optname, optval,
+				     optlen);
+#else
 		return -ENOPROTOOPT;
+#endif
 	}
 
   	if (put_user(len, optlen))

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
