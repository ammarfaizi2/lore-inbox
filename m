Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTAXI3N>; Fri, 24 Jan 2003 03:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbTAXI3N>; Fri, 24 Jan 2003 03:29:13 -0500
Received: from tml.hut.fi ([130.233.44.1]:34569 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S267598AbTAXI3I>;
	Fri, 24 Jan 2003 03:29:08 -0500
Date: Fri, 24 Jan 2003 10:38:06 +0200 (EET)
From: Ville Nuorvala <vnuorval@morphine.tml.hut.fi>
To: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
cc: davem@redhat.com, <kuznet@ms2.inr.ac.ru>
Subject: [PATCH] IPv6: fixes to proxy Neighbor discovery
Message-ID: <Pine.GSO.4.44.0301231650330.8330-100000@morphine.tml.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch contains some fixes to proxy Neighbor Discovery.

1) Source address fixed in neigbor advertisements:

RFC 2461
4.4.  Neighbor Advertisement Message Format
"      Source Address
                     An address assigned to the interface from which the
                     advertisement is sent."

This also applies to proxy Neighbor Adverisements.

2) Proxy protects against Duplicate Address Detection:

RFC 2461
7.2.3. Receipt of Neighbor Solicitations
"  A valid Neighbor Solicitation that does not meet any the following
   requirements MUST be silently discarded:

    - The Target Address is a "valid" unicast or anycast address
      assigned to the receiving interface [ADDRCONF],

    - The Target Address is a unicast address for which the node is
      offering proxy service, or

    - The Target Address is a "tentative" address on which Duplicate
      Address Detection is being performed [ADDRCONF].

   If the Target Address is tentative, the Neighbor Solicitation should
   be processed as described in [ADDRCONF].  Otherwise, the following
   description applies.  If the Source Address is not the unspecified
   address and, on link layers that have addresses, the solicitation
   includes a Source Link-Layer Address option, then the recipient
   SHOULD create or update the Neighbor Cache entry for the IP Source
   Address of the solicitation."
   ....
"  If the Source Address is the unspecified address the node MUST NOT
   create or update the Neighbor Cache entry.

   After any updates to the Neighbor Cache, the node sends a Neighbor
   Advertisement response as described in the next section."

This clearly means the proxy should protect the address against DAD.

Below are patches against both the 2.4 and 2.5 bk trees.

Thanks,
Ville

===== net/ipv6/ndisc.c 1.16 vs edited =====
--- 1.16/net/ipv6/ndisc.c	Sat Dec 21 09:43:20 2002
+++ edited/net/ipv6/ndisc.c	Fri Jan 24 10:14:33 2003
@@ -23,6 +23,7 @@
  *						and moved to net/core.
  *	Pekka Savola			:	RFC2461 validation
  *	YOSHIFUJI Hideaki @USAGI	:	Verify ND options properly
+ *	Ville Nuorvala			:	RFC2461 fixes to proxy ND
  */

 /* Set to 3 to get tracing... */
@@ -370,8 +371,9 @@
  */

 void ndisc_send_na(struct net_device *dev, struct neighbour *neigh,
-		   struct in6_addr *daddr, struct in6_addr *solicited_addr,
-		   int router, int solicited, int override, int inc_opt)
+		   struct in6_addr *daddr, struct in6_addr *saddr,
+		   struct in6_addr *solicited_addr, int router,
+		   int solicited, int override, int inc_opt)
 {
         struct sock *sk = ndisc_socket->sk;
         struct nd_msg *msg;
@@ -401,7 +403,7 @@
 		return;
 	}

-	ip6_nd_hdr(sk, skb, dev, solicited_addr, daddr, IPPROTO_ICMPV6, len);
+	ip6_nd_hdr(sk, skb, dev, saddr, daddr, IPPROTO_ICMPV6, len);

 	msg = (struct nd_msg *) skb_put(skb, len);

@@ -421,7 +423,7 @@
 		ndisc_fill_option(msg->opt, ND_OPT_TARGET_LL_ADDR, dev->dev_addr, dev->addr_len);

 	/* checksum */
-	msg->icmph.icmp6_cksum = csum_ipv6_magic(solicited_addr, daddr, len,
+	msg->icmph.icmp6_cksum = csum_ipv6_magic(saddr, daddr, len,
 						 IPPROTO_ICMPV6,
 						 csum_partial((__u8 *) msg,
 							      len, 0));
@@ -669,8 +671,8 @@
 			struct in6_addr maddr;

 			ipv6_addr_all_nodes(&maddr);
-			ndisc_send_na(dev, NULL, &maddr, &ifp->addr,
-				      ifp->idev->cnf.forwarding, 0,
+			ndisc_send_na(dev, NULL, &maddr, &ifp->addr,
+				      &ifp->addr, ifp->idev->cnf.forwarding, 0,
 				      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1,
 				      1);
 			in6_ifa_put(ifp);
@@ -693,7 +695,8 @@
 			neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);

 			if (neigh || !dev->hard_header) {
-				ndisc_send_na(dev, neigh, saddr, &ifp->addr,
+				ndisc_send_na(dev, neigh, saddr,
+					      &ifp->addr, &ifp->addr,
 					      ifp->idev->cnf.forwarding, 1,
 					      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1,
 					      1);
@@ -707,7 +710,8 @@
 		int addr_type = ipv6_addr_type(saddr);

 		if (in6_dev && in6_dev->cnf.forwarding &&
-		    (addr_type & IPV6_ADDR_UNICAST) &&
+		    (addr_type & IPV6_ADDR_UNICAST ||
+		     addr_type == IPV6_ADDR_ANY) &&
 		    pneigh_lookup(&nd_tbl, &msg->target, dev, 0)) {
 			int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;

@@ -715,17 +719,38 @@
 			    skb->pkt_type == PACKET_HOST ||
 			    inc == 0 ||
 			    in6_dev->nd_parms->proxy_delay == 0) {
+				struct in6_addr na_saddr;
+
 				if (inc)
 					nd_tbl.stats.rcv_probes_mcast++;
 				else
 					nd_tbl.stats.rcv_probes_ucast++;
-
-				neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);

-				if (neigh) {
-					ndisc_send_na(dev, neigh, saddr, &msg->target,
-						      0, 1, 0, 1);
-					neigh_release(neigh);
+				/*
+				 * RFC2461 4.4:
+				 * The souce address is always an address assigned to the interface,
+				 * this also applies to proxies
+				 */
+				if (ipv6_get_lladdr(dev, &na_saddr)) {
+					in6_dev_put(in6_dev);
+					return;
+				}
+				if (addr_type & IPV6_ADDR_UNICAST) {
+					neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);
+
+					if (neigh) {
+						ndisc_send_na(dev, neigh, saddr,
+							      &na_saddr, &msg->target,
+							      0, 1, 0, 1);
+						neigh_release(neigh);
+					}
+				} else {
+					/* the proxy should also protect against DAD */
+					struct in6_addr maddr;
+					ipv6_addr_all_nodes(&maddr);
+					ndisc_send_na(dev, NULL, &maddr,
+						      &na_saddr, &msg->target,
+						      0, 0, 0, 1);
 				}
 			} else {
 				struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);

===== net/ipv6/ndisc.c 1.21 vs edited =====
--- 1.21/net/ipv6/ndisc.c	Sat Dec 21 09:14:32 2002
+++ edited/net/ipv6/ndisc.c	Fri Jan 24 10:17:18 2003
@@ -23,6 +23,7 @@
  *						and moved to net/core.
  *	Pekka Savola			:	RFC2461 validation
  *	YOSHIFUJI Hideaki @USAGI	:	Verify ND options properly
+ *	Ville Nuorvala			:	RFC2461 fixes to proxy ND
  */

 /* Set to 3 to get tracing... */
@@ -375,8 +376,9 @@
  */

 static void ndisc_send_na(struct net_device *dev, struct neighbour *neigh,
-		   struct in6_addr *daddr, struct in6_addr *solicited_addr,
-		   int router, int solicited, int override, int inc_opt)
+			  struct in6_addr *daddr, struct in6_addr *saddr,
+			  struct in6_addr *solicited_addr, int router,
+			  int solicited, int override, int inc_opt)
 {
         struct sock *sk = ndisc_socket->sk;
         struct nd_msg *msg;
@@ -406,7 +408,7 @@
 		return;
 	}

-	ip6_nd_hdr(sk, skb, dev, solicited_addr, daddr, IPPROTO_ICMPV6, len);
+	ip6_nd_hdr(sk, skb, dev, saddr, daddr, IPPROTO_ICMPV6, len);

 	msg = (struct nd_msg *) skb_put(skb, len);

@@ -426,7 +428,7 @@
 		ndisc_fill_option(msg->opt, ND_OPT_TARGET_LL_ADDR, dev->dev_addr, dev->addr_len);

 	/* checksum */
-	msg->icmph.icmp6_cksum = csum_ipv6_magic(solicited_addr, daddr, len,
+	msg->icmph.icmp6_cksum = csum_ipv6_magic(saddr, daddr, len,
 						 IPPROTO_ICMPV6,
 						 csum_partial((__u8 *) msg,
 							      len, 0));
@@ -674,8 +676,8 @@
 			struct in6_addr maddr;

 			ipv6_addr_all_nodes(&maddr);
-			ndisc_send_na(dev, NULL, &maddr, &ifp->addr,
-				      ifp->idev->cnf.forwarding, 0,
+			ndisc_send_na(dev, NULL, &maddr, &ifp->addr,
+				      &ifp->addr, ifp->idev->cnf.forwarding, 0,
 				      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1,
 				      1);
 			in6_ifa_put(ifp);
@@ -698,7 +700,8 @@
 			neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);

 			if (neigh || !dev->hard_header) {
-				ndisc_send_na(dev, neigh, saddr, &ifp->addr,
+				ndisc_send_na(dev, neigh, saddr,
+					      &ifp->addr, &ifp->addr,
 					      ifp->idev->cnf.forwarding, 1,
 					      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1,
 					      1);
@@ -712,7 +715,8 @@
 		int addr_type = ipv6_addr_type(saddr);

 		if (in6_dev && in6_dev->cnf.forwarding &&
-		    (addr_type & IPV6_ADDR_UNICAST) &&
+		    (addr_type & IPV6_ADDR_UNICAST ||
+		     addr_type == IPV6_ADDR_ANY) &&
 		    pneigh_lookup(&nd_tbl, &msg->target, dev, 0)) {
 			int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;

@@ -720,17 +724,38 @@
 			    skb->pkt_type == PACKET_HOST ||
 			    inc == 0 ||
 			    in6_dev->nd_parms->proxy_delay == 0) {
+				struct in6_addr na_saddr;
+
 				if (inc)
 					nd_tbl.stats.rcv_probes_mcast++;
 				else
 					nd_tbl.stats.rcv_probes_ucast++;
-
-				neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);

-				if (neigh) {
-					ndisc_send_na(dev, neigh, saddr, &msg->target,
-						      0, 1, 0, 1);
-					neigh_release(neigh);
+				/*
+				 * RFC2461 4.4:
+				 * The souce address is always an address assigned to the interface,
+				 * this also applies to proxies
+				 */
+				if (ipv6_get_lladdr(dev, &na_saddr)) {
+					in6_dev_put(in6_dev);
+					return;
+				}
+				if (addr_type & IPV6_ADDR_UNICAST) {
+					neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);
+
+					if (neigh) {
+						ndisc_send_na(dev, neigh, saddr,
+							      &na_saddr, &msg->target,
+							      0, 1, 0, 1);
+						neigh_release(neigh);
+					}
+				} else {
+					/* the proxy should also protect against DAD */
+					struct in6_addr maddr;
+					ipv6_addr_all_nodes(&maddr);
+					ndisc_send_na(dev, NULL, &maddr,
+						      &na_saddr, &msg->target,
+						      0, 0, 0, 1);
 				}
 			} else {
 				struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);
--
Ville Nuorvala
Research Assistant, Institute of Digital Communications,
Helsinki University of Technology
email: vnuorval@tml.hut.fi, phone: +358 (0)9 451 5257











