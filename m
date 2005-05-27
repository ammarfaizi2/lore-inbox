Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVE0JNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVE0JNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVE0JJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:09:55 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40379 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262401AbVE0JCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:02:17 -0400
Date: Fri, 27 May 2005 11:03:54 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 8/10] s390: fakell for high speed token ring
Message-ID: <20050527090354.GH8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 8/10] s390: fakell for high speed token ring.

From: Michael Holzheu <holzheu@de.ibm.com>

Implement fake-link-layer for high speed token ring. Without it
token ring packages get leading ethernet headers, which confuses
dhcp.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |    5 -
 drivers/s390/net/qeth_main.c |  136 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 114 insertions(+), 27 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-05-06 11:26:15.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.136 $"
+#define VERSION_QETH_H 		"$Revision: 1.137 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -288,7 +288,8 @@ qeth_is_ipa_enabled(struct qeth_ipa_info
 #define QETH_TX_TIMEOUT		100 * HZ
 #define QETH_HEADER_SIZE	32
 #define MAX_PORTNO 		15
-#define QETH_FAKE_LL_LEN 	ETH_HLEN
+#define QETH_FAKE_LL_LEN_ETH	ETH_HLEN
+#define QETH_FAKE_LL_LEN_TR	(sizeof(struct trh_hdr)-TR_MAXRIFLEN+sizeof(struct trllc))
 #define QETH_FAKE_LL_V6_ADDR_POS 24
 
 /*IPv6 address autoconfiguration stuff*/
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-05-06 11:26:15.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.207 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.209 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.207 $	 $Date: 2005/04/01 21:40:40 $
+ *    $Revision: 1.209 $	 $Date: 2005/04/18 11:58:48 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,7 +80,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.207 $"
+#define VERSION_QETH_C "$Revision: 1.209 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2152,9 +2152,15 @@ qeth_get_next_skb(struct qeth_card *card
 	if (!skb_len)
 		return NULL;
 	if (card->options.fake_ll){
-		if (!(skb = qeth_get_skb(skb_len + QETH_FAKE_LL_LEN)))
-			goto no_mem;
-		skb_pull(skb, QETH_FAKE_LL_LEN);
+		if(card->dev->type == ARPHRD_IEEE802_TR){
+			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_TR)))
+				goto no_mem;
+			skb_reserve(skb,QETH_FAKE_LL_LEN_TR);
+		} else {
+			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_ETH)))
+				goto no_mem;
+			skb_reserve(skb,QETH_FAKE_LL_LEN_ETH);
+		}
 	} else if (!(skb = qeth_get_skb(skb_len)))
 		goto no_mem;
 	data_ptr = element->addr + offset;
@@ -2229,14 +2235,68 @@ qeth_type_trans(struct sk_buff *skb, str
 }
 
 static inline void
-qeth_rebuild_skb_fake_ll(struct qeth_card *card, struct sk_buff *skb,
+qeth_rebuild_skb_fake_ll_tr(struct qeth_card *card, struct sk_buff *skb,
+			 struct qeth_hdr *hdr)
+{
+	struct trh_hdr *fake_hdr;
+	struct trllc *fake_llc;
+	struct iphdr *ip_hdr;
+
+	QETH_DBF_TEXT(trace,5,"skbfktr");
+	skb->mac.raw = skb->data - QETH_FAKE_LL_LEN_TR;
+	/* this is a fake ethernet header */
+	fake_hdr = (struct trh_hdr *) skb->mac.raw;
+
+	/* the destination MAC address */
+	switch (skb->pkt_type){
+	case PACKET_MULTICAST:
+		switch (skb->protocol){
+#ifdef CONFIG_QETH_IPV6
+		case __constant_htons(ETH_P_IPV6):
+			ndisc_mc_map((struct in6_addr *)
+				     skb->data + QETH_FAKE_LL_V6_ADDR_POS,
+				     fake_hdr->daddr, card->dev, 0);
+			break;
+#endif /* CONFIG_QETH_IPV6 */
+		case __constant_htons(ETH_P_IP):
+			ip_hdr = (struct iphdr *)skb->data;
+			ip_tr_mc_map(ip_hdr->daddr, fake_hdr->daddr);
+			break;
+		default:
+			memcpy(fake_hdr->daddr, card->dev->dev_addr, TR_ALEN);
+		}
+		break;
+	case PACKET_BROADCAST:
+		memset(fake_hdr->daddr, 0xff, TR_ALEN);
+		break;
+	default:
+		memcpy(fake_hdr->daddr, card->dev->dev_addr, TR_ALEN);
+	}
+	/* the source MAC address */
+	if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
+		memcpy(fake_hdr->saddr, &hdr->hdr.l3.dest_addr[2], TR_ALEN);
+	else
+		memset(fake_hdr->saddr, 0, TR_ALEN);
+	fake_hdr->rcf=0;
+	fake_llc = (struct trllc*)&(fake_hdr->rcf);
+	fake_llc->dsap = EXTENDED_SAP;
+	fake_llc->ssap = EXTENDED_SAP;
+	fake_llc->llc  = UI_CMD;
+	fake_llc->protid[0] = 0;
+	fake_llc->protid[1] = 0;
+	fake_llc->protid[2] = 0;
+	fake_llc->ethertype = ETH_P_IP;
+}
+
+static inline void
+qeth_rebuild_skb_fake_ll_eth(struct qeth_card *card, struct sk_buff *skb,
 			 struct qeth_hdr *hdr)
 {
 	struct ethhdr *fake_hdr;
 	struct iphdr *ip_hdr;
 
-	QETH_DBF_TEXT(trace,5,"skbfake");
-	skb->mac.raw = skb->data - QETH_FAKE_LL_LEN;
+	QETH_DBF_TEXT(trace,5,"skbfketh");
+	skb->mac.raw = skb->data - QETH_FAKE_LL_LEN_ETH;
 	/* this is a fake ethernet header */
 	fake_hdr = (struct ethhdr *) skb->mac.raw;
 
@@ -2253,10 +2313,7 @@ qeth_rebuild_skb_fake_ll(struct qeth_car
 #endif /* CONFIG_QETH_IPV6 */
 		case __constant_htons(ETH_P_IP):
 			ip_hdr = (struct iphdr *)skb->data;
-			if (card->dev->type == ARPHRD_IEEE802_TR)
-				ip_tr_mc_map(ip_hdr->daddr, fake_hdr->h_dest);
-			else
-				ip_eth_mc_map(ip_hdr->daddr, fake_hdr->h_dest);
+			ip_eth_mc_map(ip_hdr->daddr, fake_hdr->h_dest);
 			break;
 		default:
 			memcpy(fake_hdr->h_dest, card->dev->dev_addr, ETH_ALEN);
@@ -2278,6 +2335,16 @@ qeth_rebuild_skb_fake_ll(struct qeth_car
 }
 
 static inline void
+qeth_rebuild_skb_fake_ll(struct qeth_card *card, struct sk_buff *skb,
+			struct qeth_hdr *hdr)
+{
+	if (card->dev->type == ARPHRD_IEEE802_TR)
+		qeth_rebuild_skb_fake_ll_tr(card, skb, hdr);
+	else
+		qeth_rebuild_skb_fake_ll_eth(card, skb, hdr);
+}
+
+static inline void
 qeth_rebuild_skb_vlan(struct qeth_card *card, struct sk_buff *skb,
 		      struct qeth_hdr *hdr)
 {
@@ -3440,16 +3507,25 @@ qeth_fake_header(struct sk_buff *skb, st
 		     unsigned short type, void *daddr, void *saddr,
 		     unsigned len)
 {
-	struct ethhdr *hdr;
+	if(dev->type == ARPHRD_IEEE802_TR){
+		struct trh_hdr *hdr;
+        	hdr = (struct trh_hdr *)skb_push(skb, QETH_FAKE_LL_LEN_TR);
+		memcpy(hdr->saddr, dev->dev_addr, TR_ALEN);
+        	memcpy(hdr->daddr, "FAKELL", TR_ALEN);
+		return QETH_FAKE_LL_LEN_TR;
+
+	} else {
+		struct ethhdr *hdr;
+        	hdr = (struct ethhdr *)skb_push(skb, QETH_FAKE_LL_LEN_ETH);
+		memcpy(hdr->h_source, dev->dev_addr, ETH_ALEN);
+        	memcpy(hdr->h_dest, "FAKELL", ETH_ALEN);
+        	if (type != ETH_P_802_3)
+                	hdr->h_proto = htons(type);
+        	else
+                	hdr->h_proto = htons(len);
+		return QETH_FAKE_LL_LEN_ETH;
 
-        hdr = (struct ethhdr *)skb_push(skb, QETH_FAKE_LL_LEN);
-	memcpy(hdr->h_source, dev->dev_addr, ETH_ALEN);
-        memcpy(hdr->h_dest, "FAKELL", ETH_ALEN);
-        if (type != ETH_P_802_3)
-                hdr->h_proto = htons(type);
-        else
-                hdr->h_proto = htons(len);
-	return QETH_FAKE_LL_LEN;
+	}
 }
 
 static inline int
@@ -3882,9 +3958,15 @@ qeth_fill_header(struct qeth_card *card,
 			memcpy(hdr->hdr.l3.dest_addr, &skb->nh.ipv6h->daddr, 16);
 		}
 	} else { /* passthrough */
-		if (!memcmp(skb->data + sizeof(struct qeth_hdr),
+                if((skb->dev->type == ARPHRD_IEEE802_TR) &&
+                        !memcmp(skb->data + sizeof(struct qeth_hdr) + 2,
+                        skb->dev->broadcast, 6)) {
+                        hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
+                                                QETH_HDR_PASSTHRU;
+		} else if (!memcmp(skb->data + sizeof(struct qeth_hdr),
 			    skb->dev->broadcast, 6)) {   /* broadcast? */
-			hdr->hdr.l3.flags = QETH_CAST_BROADCAST | QETH_HDR_PASSTHRU;
+			hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
+						QETH_HDR_PASSTHRU;
 		} else {
  			hdr->hdr.l3.flags = (cast_type == RTN_MULTICAST) ?
  				QETH_CAST_MULTICAST | QETH_HDR_PASSTHRU :
@@ -4164,7 +4246,11 @@ qeth_send_packet(struct qeth_card *card,
                         	dev_kfree_skb_irq(skb);
                         	return 0;
                 	}
-                	skb_pull(skb, QETH_FAKE_LL_LEN);
+			if(card->dev->type == ARPHRD_IEEE802_TR){
+				skb_pull(skb, QETH_FAKE_LL_LEN_TR);
+			} else {
+                		skb_pull(skb, QETH_FAKE_LL_LEN_ETH);
+			}
 		}
 	}
 	cast_type = qeth_get_cast_type(card, skb);
