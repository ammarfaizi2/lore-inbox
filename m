Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWCVGHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWCVGHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWCVGHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:07:24 -0500
Received: from ns1.siteground.net ([207.218.208.2]:10413 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750796AbWCVGHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:07:23 -0500
Date: Tue, 21 Mar 2006 22:08:07 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: [patch 2/2] net: Node aware multipath device round robin -- device locality check
Message-ID: <20060322060807.GB3603@localhost.localdomain>
References: <20060322060540.GA3603@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322060540.GA3603@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks device locality on every ip packet xmit.
In multipath configuration tcp connection to route association is done at 
session startup time. The tcp session process is migrated to different nodes 
after this association.  This would mean a remote NIC is chosen for xmit,
although a local NIC could be available.   Following patch checks if a 
local NIC is available for the desitnation, and recalculates routes if so.
his leads to remote NIC  transfer  in some tcp work load such as AB.
    
Downside: adds a bitmap to struct rtable.  But only if 
CONFIG_IP_ROUTE_MULTIPATH_NODE is enabled.

Comments, suggestions welcome. 

Signed-off by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16/include/net/route.h
===================================================================
--- linux-2.6.16.orig/include/net/route.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/net/route.h	2006-03-20 14:52:24.000000000 -0800
@@ -75,6 +75,13 @@ struct rtable
 	/* Miscellaneous cached information */
 	__u32			rt_spec_dst; /* RFC1122 specific destination */
 	struct inet_peer	*peer; /* long-living peer info */
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_NODE
+	/*  bitmap bit is set if current node has a local multi-path device for
+	 *  this route.
+	 */
+	DECLARE_BITMAP          (mp_if_bitmap, MAX_NUMNODES);
+#endif
+
 };
 
 struct ip_rt_acct
@@ -201,4 +208,21 @@ static inline struct inet_peer *rt_get_p
 
 extern ctl_table ipv4_route_table[];
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_NODE
+
+#include <linux/ip_mp_alg.h>
+
+static inline int dst_dev_node_check(struct rtable *rt)
+{
+	int cnode = numa_node_id();
+	if (unlikely(netdev_node(rt->u.dst.dev) != cnode)) {
+		if (test_bit(cnode, rt->mp_if_bitmap))
+			return 1;
+	}
+	return 0;
+}
+#else
+#define dst_dev_node_check(rt)			0
+#endif
+
 #endif	/* _ROUTE_H */
Index: linux-2.6.16/net/ipv4/ip_output.c
===================================================================
--- linux-2.6.16.orig/net/ipv4/ip_output.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/net/ipv4/ip_output.c	2006-03-20 14:52:24.000000000 -0800
@@ -309,7 +309,7 @@ int ip_queue_xmit(struct sk_buff *skb, i
 
 	/* Make sure we can route this packet. */
 	rt = (struct rtable *)__sk_dst_check(sk, 0);
-	if (rt == NULL) {
+	if ((rt == NULL ) || dst_dev_node_check(rt)) {
 		u32 daddr;
 
 		/* Use correct destination address if we have options. */
Index: linux-2.6.16/net/ipv4/route.c
===================================================================
--- linux-2.6.16.orig/net/ipv4/route.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/net/ipv4/route.c	2006-03-20 14:52:24.000000000 -0800
@@ -2313,6 +2313,22 @@ static inline int ip_mkroute_output(stru
 	if (res->fi && res->fi->fib_nhs > 1) {
 		unsigned char hopcount = res->fi->fib_nhs;
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_NODE
+		DECLARE_BITMAP (mp_if_bitmap, MAX_NUMNODES);
+		bitmap_zero(mp_if_bitmap, MAX_NUMNODES);
+		/* Calculating device bitmap for this multipath route */
+		if (res->fi->fib_mp_alg == IP_MP_ALG_DRR) {
+			for (hop = 0; hop < hopcount; hop++) {
+				struct net_device *dev2nexthop;
+
+				res->nh_sel = hop;
+				dev2nexthop = FIB_RES_DEV(*res);
+				dev_hold(dev2nexthop);
+				set_bit(netdev_node(dev2nexthop), mp_if_bitmap);
+				dev_put(dev2nexthop);
+			}
+		}
+#endif
 		for (hop = 0; hop < hopcount; hop++) {
 			struct net_device *dev2nexthop;
 
@@ -2343,6 +2359,10 @@ static inline int ip_mkroute_output(stru
 					     FIB_RES_NETMASK(*res),
 					     res->prefixlen,
 					     &FIB_RES_NH(*res));
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_NODE
+			bitmap_copy(rth->mp_if_bitmap, mp_if_bitmap, MAX_NUMNODES);
+#endif
 		cleanup:
 			/* release work reference to output device */
 			dev_put(dev2nexthop);
