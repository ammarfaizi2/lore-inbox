Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUCVR0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUCVR0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:26:12 -0500
Received: from ns.suse.de ([195.135.220.2]:63385 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262133AbUCVRZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:25:53 -0500
Date: Mon, 22 Mar 2004 18:25:51 +0100
From: Michael Schroeder <mls@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new "fromarp" route flag
Message-ID: <20040322172551.GC8210@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch implements a new route flag, "fromarp".

Problem description:
--------------------

Zeroconf hardware automatically assigns an ip address from the
link local range (169.254.1.0 - 169.254.254.255). This ip addresses
don't get routed and are local to the interfaces. To address such
a component, one can add a link local route:

    ip route add 169.254.0.0/16 dev eth0

Things get ugly if a host is multihomed and zeroconf hardware is
conected to more than one interface. It is not possible to add
a route in that case.

Solution:
---------

My patch adds a new route flag, "fromarp", to the kernel. Example:

    ip route add 169.254.0.0/16 fromarp nexthop dev eth0 nexthop dev eth1

If a packet is to be send with such a route, the kernel
checks the arp cache of the interfaces specified in the route.
If a match is found, the packet is send to the matching interface.
Otherwise an arp request is sent from all of the interfaces.

Comments anyone?

--- ./include/linux/in_route.h.orig	2004-03-19 11:20:12.000000000 +0000
+++ ./include/linux/in_route.h	2004-03-19 11:21:18.000000000 +0000
@@ -18,6 +18,7 @@
 #define RTCF_MASQ	0x00400000
 #define RTCF_SNAT	0x00800000
 #define RTCF_DOREDIRECT 0x01000000
+#define RTCF_FROMARP    0x02000000
 #define RTCF_DIRECTSRC	0x04000000
 #define RTCF_DNAT	0x08000000
 #define RTCF_BROADCAST	0x10000000
--- ./include/linux/rtnetlink.h.orig	2004-03-19 11:20:12.000000000 +0000
+++ ./include/linux/rtnetlink.h	2004-03-19 11:21:18.000000000 +0000
@@ -170,6 +170,7 @@
 #define RTM_F_CLONED		0x200	/* This route is cloned		*/
 #define RTM_F_EQUALIZE		0x400	/* Multipath equalizer: NI	*/
 #define RTM_F_PREFIX		0x800	/* Prefix addresses		*/
+#define RTM_F_FROMARP		0x1000	/* Select if from arpcache      */
 
 /* Reserved table identifiers */
 
--- ./net/ipv4/arp.c.orig	2004-03-19 11:19:43.000000000 +0000
+++ ./net/ipv4/arp.c	2004-03-19 11:21:18.000000000 +0000
@@ -952,6 +952,12 @@
 	return 0;
 }
 
+struct neighbour *arp_lookup(u32 ip, struct net_device *dev, int creat)
+{
+        return __neigh_lookup(&arp_tbl, &ip, dev, creat);
+}
+
+
 /*
  *	User level interface (ioctl)
  */
--- ./net/ipv4/fib_semantics.c.orig	2004-03-19 11:20:18.000000000 +0000
+++ ./net/ipv4/fib_semantics.c	2004-03-19 11:21:18.000000000 +0000
@@ -1035,4 +1035,52 @@
 	res->nh_sel = 0;
 	spin_unlock_bh(&fib_multipath_lock);
 }
+
+extern struct neighbour *arp_lookup(u32 ip, struct net_device *dev, int creat);
+
+int fib_select_fromarp(const struct flowi *flp, struct fib_result *res)
+{
+	struct net_device *dev;
+	struct fib_info *fi = res->fi;
+	struct neighbour *n;
+	u32 ip;
+	int i, new;
+
+	res->nh_sel = 0;
+	ip = flp->nl_u.ip4_u.daddr;
+	if (ip == 0xffffffff || MULTICAST(ip))
+		return 1;
+	spin_lock_bh(&fib_multipath_lock);
+	for (i = 0, new = -1; i < fi->fib_nhs; i++) {
+		dev = fi->fib_nh[i].nh_dev;
+		n = arp_lookup(ip, dev, 0);
+		if (!n) {
+			if (new < 0)
+				new = i;
+			continue;
+		}
+		if ((n->nud_state&(NUD_CONNECTED|NUD_DELAY|NUD_PROBE)) != 0) {
+			res->nh_sel = i;
+			neigh_release(n);
+			spin_unlock_bh(&fib_multipath_lock);
+			return 1;
+		}
+		neigh_release(n);
+	}
+	if (new < 0)
+		new = 0;
+	res->nh_sel = new;
+	for (i = 0; i < fi->fib_nhs; i++) {
+		if (i == new)
+			continue;
+		dev = fi->fib_nh[i].nh_dev;
+		if ((n = arp_lookup(ip, dev, 1)) != 0) {
+			neigh_event_send(n, (struct sk_buff *)0);
+			neigh_release(n);
+		}
+	}
+	spin_unlock_bh(&fib_multipath_lock);
+	return 0;
+}
+
 #endif
--- ./net/ipv4/route.c.orig	2004-03-19 11:20:18.000000000 +0000
+++ ./net/ipv4/route.c	2004-03-19 11:21:18.000000000 +0000
@@ -1332,7 +1332,9 @@
 {
 	struct rtable *rt;
 
-	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
+	rt = (struct rtable *) skb->dst;
+	if (!rt || !(rt->rt_flags & RTCF_FROMARP))
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
 
 	rt = (struct rtable *) skb->dst;
 	if (rt)
@@ -2077,9 +2079,13 @@
 	}
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-	if (res.fi->fib_nhs > 1 && fl.oif == 0)
-		fib_select_multipath(&fl, &res);
-	else
+	if (res.fi->fib_nhs > 1 && fl.oif == 0) {
+		if (res.fi->fib_flags & RTM_F_FROMARP) {
+			if (!fib_select_fromarp(&fl, &res))
+				flags |= RTCF_FROMARP;
+		} else
+			fib_select_multipath(&fl, &res);
+	}
 #endif
 	if (!res.prefixlen && res.type == RTN_UNICAST && !fl.oif)
 		fib_select_default(&fl, &res);
@@ -2190,8 +2196,18 @@
 
 	rth->rt_flags = flags;
 
-	hash = rt_hash_code(oldflp->fl4_dst, oldflp->fl4_src ^ (oldflp->oif << 5), tos);
-	err = rt_intern_hash(hash, rth, rp);
+	if (flags & RTCF_FROMARP) {
+		err = 0;
+		if (rth->rt_type == RTN_UNICAST || rth->fl.iif == 0) {
+			if ((err = arp_bind_neighbour(&rth->u.dst)) != 0)
+				rt_drop(rth);
+		}
+		if (!err)
+			*rp = rth;
+	} else {
+		hash = rt_hash_code(oldflp->fl4_dst, oldflp->fl4_src ^ (oldflp->oif << 5), tos);
+		err = rt_intern_hash(hash, rth, rp);
+	}
 done:
 	if (free_res)
 		fib_res_put(&res);


Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
