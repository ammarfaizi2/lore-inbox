Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUINMvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUINMvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUINMug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:50:36 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63677 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S269415AbUINMkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:40:19 -0400
Message-ID: <4146E65D.6070309@de.ibm.com>
Date: Tue, 14 Sep 2004 14:38:53 +0200
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: hadi@cyberus.ca, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH 2/2] ip multipath, bk head (EXPERIMENTAL)
References: <41457848.6040808@de.ibm.com>	<1095129624.1060.45.camel@jzny.localdomain> <20040913224232.4b979c7d.davem@davemloft.net>
In-Reply-To: <20040913224232.4b979c7d.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------020102000800030904040805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102000800030904040805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I attached the patch the way you requested in the other thread.

Regards
Einar

--------------020102000800030904040805
Content-Type: text/x-patch;
 name="multipath_cached.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multipath_cached.diff"

diff -ruN linux-2.6.8.1.splitold/include/net/dst.h linux-2.6.8.1.multipath_cached/include/net/dst.h
--- linux-2.6.8.1.splitold/include/net/dst.h	2004-09-10 10:24:40.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/include/net/dst.h	2004-09-10 11:16:35.000000000 +0200
@@ -48,6 +48,7 @@
 #define DST_NOXFRM		2
 #define DST_NOPOLICY		4
 #define DST_NOHASH		8
+#define DST_BALANCED            0x10
 	unsigned long		lastuse;
 	unsigned long		expires;
 
diff -ruN linux-2.6.8.1.splitold/include/net/flow.h linux-2.6.8.1.multipath_cached/include/net/flow.h
--- linux-2.6.8.1.splitold/include/net/flow.h	2004-09-10 10:24:40.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/include/net/flow.h	2004-09-10 11:16:35.000000000 +0200
@@ -51,6 +51,9 @@
 
 	__u8	proto;
 	__u8	flags;
+#if defined(CONFIG_IP_ROUTE_MULTIPATH_CACHED)
+#define FLOWI_FLAG_MULTIPATHOLDROUTE 0x01
+#endif
 	union {
 		struct {
 			__u16	sport;
diff -ruN linux-2.6.8.1.splitold/include/net/route.h linux-2.6.8.1.multipath_cached/include/net/route.h
--- linux-2.6.8.1.splitold/include/net/route.h	2004-09-10 10:24:40.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/include/net/route.h	2004-09-10 11:16:35.000000000 +0200
@@ -179,6 +179,9 @@
 		memcpy(&fl, &(*rp)->fl, sizeof(fl));
 		fl.fl_ip_sport = sport;
 		fl.fl_ip_dport = dport;
+#if defined(CONFIG_IP_ROUTE_MULTIPATH_CACHED)
+		fl.flags |= FLOWI_FLAG_MULTIPATHOLDROUTE;
+#endif
 		ip_rt_put(*rp);
 		*rp = NULL;
 		return ip_route_output_flow(rp, &fl, sk, 0);
@@ -197,4 +200,41 @@
 	return rt->peer;
 }
 
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_RR
+extern void __multipath_remove(struct rtable *rt);
+static inline void multipath_remove(struct rtable *rt) {
+	if ( rt->u.dst.flags & DST_BALANCED ) {
+		__multipath_remove( rt );
+	}
+}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_RR */
+static inline void multipath_remove(struct rtable *rt) {}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_RR */
+
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+extern void __multipath_selectroute(const struct flowi *flp,
+				    struct rtable *rth,
+				    struct rtable **rp);
+static inline int multipath_selectroute(const struct flowi *flp,
+					struct rtable *rth,
+					struct rtable **rp) {
+	if ( rth->u.dst.flags & DST_BALANCED ) {
+		__multipath_selectroute( flp, rth, rp );
+		return 1;
+	}
+	else {
+		return 0;
+	}
+}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
+static inline int multipath_selectroute(const struct flowi *flp,
+					struct rtable *rth,
+					struct rtable **rp) {
+	return 0;
+}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
+
+
 #endif	/* _ROUTE_H */
diff -ruN linux-2.6.8.1.splitold/net/ipv4/Kconfig linux-2.6.8.1.multipath_cached/net/ipv4/Kconfig
--- linux-2.6.8.1.splitold/net/ipv4/Kconfig	2004-09-10 10:25:08.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/net/ipv4/Kconfig	2004-09-10 11:16:35.000000000 +0200
@@ -94,6 +94,41 @@
 	  equal "cost" and chooses one of them in a non-deterministic fashion
 	  if a matching packet arrives.
 
+config IP_ROUTE_MULTIPATH_CACHED
+	bool "IP: equal cost multipath with caching support (EXPERIMENTAL)"
+	depends on: IP_ROUTE_MULTIPATH
+	help
+	  Normally, equal cost multipath routing is not supported by the
+	  routing cache. If you say Y here, alternative routes are cached
+	  in the routing cache and on cache lookup route is chosen in 
+	  Round Robin fashon.
+
+	  If unsure, say N.
+
+#
+# multipath policy configuration
+# 
+choice
+	prompt "Multipath policy"
+	depends on IP_ROUTE_MULTIPATH_CACHED
+	default IP_ROUTE_MULTIPATH_RR
+
+config IP_ROUTE_MULTIPATH_RR
+	bool "round robin (EXPERIMENTAL)"
+	help
+	  Mulitpath routes are chosen according to Round Robin
+
+config IP_ROUTE_MULTIPATH_RANDOM
+	bool "random multipath (EXPERIMENTAL)"
+	help
+	  Multipath routes are chosen in a random fashion (naive 
+	  implementation)
+
+endchoice
+#
+# END OF multipath policy configuration
+#
+
 config IP_ROUTE_TOS
 	bool "IP: use TOS value as routing key"
 	depends on IP_ADVANCED_ROUTER
diff -ruN linux-2.6.8.1.splitold/net/ipv4/Makefile linux-2.6.8.1.multipath_cached/net/ipv4/Makefile
--- linux-2.6.8.1.splitold/net/ipv4/Makefile	2004-09-10 10:25:08.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/net/ipv4/Makefile	2004-09-10 11:16:35.000000000 +0200
@@ -21,6 +21,8 @@
 obj-$(CONFIG_INET_IPCOMP) += ipcomp.o
 obj-$(CONFIG_INET_TUNNEL) += xfrm4_tunnel.o 
 obj-$(CONFIG_IP_PNP) += ipconfig.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_RR) += multipath_rr.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_RANDOM) += multipath_random.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
 obj-$(CONFIG_IP_VS) += ipvs/
 
diff -ruN linux-2.6.8.1.splitold/net/ipv4/multipath_random.c linux-2.6.8.1.multipath_cached/net/ipv4/multipath_random.c
--- linux-2.6.8.1.splitold/net/ipv4/multipath_random.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath_cached/net/ipv4/multipath_random.c	2004-09-13 16:45:48.000000000 +0200
@@ -0,0 +1,107 @@
+/*
+ *              Random policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath.c,v 1.1.2.1 2004/09/02 20:01:27 elueck Exp $
+ *
+ * Authors:	Einar Lueck <elueck@de.ibm.com><lkml@einar-lueck.de>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/fcntl.h>
+#include <linux/stat.h>
+#include <linux/socket.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/igmp.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/mroute.h>
+#include <linux/init.h>
+#include <net/ip.h>
+#include <net/protocol.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/icmp.h>
+#include <net/udp.h>
+#include <net/raw.h>
+#include <linux/notifier.h>
+#include <linux/if_arp.h>
+#include <linux/netfilter_ipv4.h>
+#include <net/ipip.h>
+#include <net/checksum.h>
+
+#define RTprint(a...)	// printk(KERN_DEBUG a)
+
+#define MULTIPATH_MAX_CANDIDATES 40
+
+
+static int __inline__ multipath_comparekeys(const struct flowi *flp1,
+					    const struct flowi *flp2) {
+	return flp1->fl4_dst == flp2->fl4_dst &&
+		flp1->fl4_src == flp2->fl4_src &&
+		flp1->oif == flp2->oif &&
+#ifdef CONFIG_IP_ROUTE_FWMARK
+		flp1->fl4_fwmark == flp2->fl4_fwmark &&
+#endif
+		!((flp1->fl4_tos ^ flp2->fl4_tos) &
+		  (IPTOS_RT_MASK | RTO_ONLINK));
+}
+
+void __multipath_selectroute(const struct flowi *flp, 
+			     struct rtable *first, 
+			     struct rtable **rp) {
+	struct rtable *rt;
+	struct rtable *candidate[MULTIPATH_MAX_CANDIDATES];
+	struct rtable *decision;
+	unsigned char candidate_count = 0;
+	/* FIXME: remove debug code */
+	RTprint( KERN_DEBUG"%s called\n", __FUNCTION__ );
+
+	/* collect all candidate */
+	for (rt = rcu_dereference(first); rt;
+	     rt = rcu_dereference(rt->u.rt_next)) {
+		if ( ( rt->u.dst.flags & DST_BALANCED ) != 0 && 
+		     multipath_comparekeys(&rt->fl, flp) ) {
+			candidate[candidate_count] = rt;
+			++candidate_count;
+		}
+		if ( candidate_count >= MULTIPATH_MAX_CANDIDATES ) {
+			break;
+		}
+	}
+
+	/* choose a random candidate */
+	decision = candidate[0];
+	if ( candidate_count > 1 ) {
+		unsigned char i;
+		unsigned char candidate_no = net_random() % candidate_count;
+		decision = candidate[candidate_no];
+		
+		/* make sure all candidates stay in cache */
+		for ( i = 0; i < candidate_count; ++i ) {
+			candidate[i]->u.dst.lastuse = jiffies;
+		}
+	}
+			
+	decision->u.dst.__use++;
+	*rp = decision;
+}
+
+
+
diff -ruN linux-2.6.8.1.splitold/net/ipv4/multipath_rr.c linux-2.6.8.1.multipath_cached/net/ipv4/multipath_rr.c
--- linux-2.6.8.1.splitold/net/ipv4/multipath_rr.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath_cached/net/ipv4/multipath_rr.c	2004-09-10 11:16:35.000000000 +0200
@@ -0,0 +1,202 @@
+/*
+ *              Round robin policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath.c,v 1.1.2.1 2004/09/02 20:01:27 elueck Exp $
+ *
+ * Authors:	Einar Lueck <elueck@de.ibm.com><lkml@einar-lueck.de>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/fcntl.h>
+#include <linux/stat.h>
+#include <linux/socket.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/igmp.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/mroute.h>
+#include <linux/init.h>
+#include <net/ip.h>
+#include <net/protocol.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/icmp.h>
+#include <net/udp.h>
+#include <net/raw.h>
+#include <linux/notifier.h>
+#include <linux/if_arp.h>
+#include <linux/netfilter_ipv4.h>
+#include <net/ipip.h>
+#include <net/checksum.h>
+
+struct rt_cache_candidate
+{
+	struct rtable             *candidate;
+	struct rt_cache_candidate *next;
+};
+
+#define RTprint(a...)	// printk(KERN_DEBUG a)
+
+#define MULTIPATH_MAX_CANDIDATES 40
+
+static spinlock_t multipath_state_lock = SPIN_LOCK_UNLOCKED;
+static struct rt_cache_candidate *multipath_state = NULL;
+static int multipath_state_entrycount = 0;/* FIXME remove: is just for debug purposes */					   
+
+static int __inline__ multipath_comparekeys(const struct flowi *flp1,
+					    const struct flowi *flp2) {
+	return flp1->fl4_dst == flp2->fl4_dst &&
+		flp1->fl4_src == flp2->fl4_src &&
+		flp1->oif == flp2->oif &&
+#ifdef CONFIG_IP_ROUTE_FWMARK
+		flp1->fl4_fwmark == flp2->fl4_fwmark &&
+#endif
+		!((flp1->fl4_tos ^ flp2->fl4_tos) &
+		  (IPTOS_RT_MASK | RTO_ONLINK));
+}
+
+void __multipath_remove(struct rtable* rt) {
+	struct rt_cache_candidate *candidate;
+	struct rt_cache_candidate *previous = NULL;
+
+	/* DEBUG STUFF */
+	if ( !( rt->u.dst.flags & DST_BALANCED ) ) {
+		/* FIXME: remove debug code */
+		RTprint( KERN_DEBUG"%s: unexpected argument\n",
+			 __FUNCTION__ );
+		return;
+	}
+
+	spin_lock_bh(&multipath_state_lock);
+
+	for ( candidate = multipath_state; candidate != NULL; 
+	      candidate = candidate->next ) {
+		if ( multipath_comparekeys(&candidate->candidate->fl,
+					   &rt->fl) ) {
+			if ( candidate == multipath_state ) {
+				multipath_state = multipath_state->next;
+			}
+			else {
+				previous->next = candidate->next;
+			}
+			--multipath_state_entrycount;
+			kfree( candidate );
+			RTprint( KERN_DEBUG"%s: removed entry. Entry " \
+				 "count: %d\n", __FUNCTION__,
+				 multipath_state_entrycount );
+			break;
+		}
+		
+		previous = candidate;
+	}
+
+	spin_unlock_bh(&multipath_state_lock);
+}
+
+void __multipath_selectroute(const struct flowi *flp, 
+			     struct rtable *first, struct rtable **rp) 
+{
+	struct rt_cache_candidate *cand;
+	struct rtable *nh, *result;
+	int found_old = 0;
+	
+	spin_lock_bh(&multipath_state_lock);
+
+	/* determine entry with candidate returned last time */
+	for ( cand = multipath_state; cand != NULL; cand = cand->next ) {
+		if ( multipath_comparekeys(&cand->candidate->fl, flp) ) {
+
+			RTprint( KERN_CRIT"%s: determined candidate " \
+				 "returned last time\n",
+				 __FUNCTION__ );
+			break;
+		}
+	}
+
+
+	/* 1. make sure all alt. nexthops have the same GC related data */
+	/* 2. determine the new candidate to be returned */
+	result = NULL;
+	for (nh = rcu_dereference(first); nh;
+	     nh = rcu_dereference(nh->u.rt_next)) {
+		if ( ( nh->u.dst.flags & DST_BALANCED ) != 0 &&
+		     multipath_comparekeys(&nh->fl, flp ) ) {
+			nh->u.dst.lastuse = jiffies;
+			nh->u.dst.__use++;
+			RTprint( KERN_CRIT"%s: found balanced entry\n",
+				 __FUNCTION__ );
+
+			/* determine candidate to be returned */
+			if ( !(flp->flags & FLOWI_FLAG_MULTIPATHOLDROUTE ) ) {
+				if ( found_old && !result ) {
+					result = nh;
+				}
+				else if ( cand != NULL && 
+					  nh == cand->candidate ) {
+					found_old = 1;
+				}
+			}
+		}
+	}
+
+	/* if no previous alternative exists utilize first */
+	if ( result == NULL ) {
+		RTprint( KERN_CRIT"%s: reach end of"\
+			 " chain. Start again.\n",
+			 __FUNCTION__ );
+		
+		result = first;
+	}
+	else {
+		RTprint( KERN_CRIT"%s: found new " \
+			 "candidate\n",
+			 __FUNCTION__ );
+	}
+
+
+	/* if necessary and possible utilize the old alternative */
+	if ( ( flp->flags & FLOWI_FLAG_MULTIPATHOLDROUTE ) != 0 && 
+	     cand != NULL ) {
+		RTprint( KERN_CRIT"%s: holding route \n",
+			 __FUNCTION__ );
+		result = cand->candidate;
+	}
+
+	
+	/* store candidate to return in state */
+	if ( cand == NULL ) {
+                /* create new state entry if necessary */
+		cand = (struct rt_cachec_andidate*)
+			kmalloc( sizeof(struct rt_cache_candidate),
+				 GFP_KERNEL );
+		cand->next = multipath_state;
+		multipath_state = cand;
+		++multipath_state_entrycount;
+		RTprint( KERN_CRIT"%s: entrycount: %d\n",
+			 __FUNCTION__, multipath_state_entrycount );
+	}
+	cand->candidate = result;
+	
+	spin_unlock_bh(&multipath_state_lock);
+	
+	*rp = result;
+}
+
+
diff -ruN linux-2.6.8.1.splitold/net/ipv4/route.c linux-2.6.8.1.multipath_cached/net/ipv4/route.c
--- linux-2.6.8.1.splitold/net/ipv4/route.c	2004-09-14 09:38:49.000000000 +0200
+++ linux-2.6.8.1.multipath_cached/net/ipv4/route.c	2004-09-14 09:36:52.000000000 +0200
@@ -442,11 +442,13 @@
   
 static __inline__ void rt_free(struct rtable *rt)
 {
+	multipath_remove(rt);
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
+	multipath_remove(rt);
 	ip_rt_put(rt);
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
@@ -539,8 +541,28 @@
 			}
 
 			/* Cleanup aged off entries. */
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+			/* remove all related balanced entries if necessary */
+			if ( rth->u.dst.flags & DST_BALANCED ) {
+				struct rtable* first = rth;
+				*rthp = rth->u.rt_next;
+				while ( (*rthp)->u.dst.flags & DST_BALANCED &&
+					compare_keys(&(*rthp)->fl, 
+						     &first->fl)) {
+					rth = (*rthp);
+					*rthp = rth->u.rt_next;
+					rt_free( rth );
+				}
+				rt_free(first);
+			}
+			else {
+				*rthp = rth->u.rt_next;
+				rt_free(rth);
+			}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 			*rthp = rth->u.rt_next;
 			rt_free(rth);
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 		}
 		spin_unlock(&rt_hash_table[i].lock);
 
@@ -706,8 +728,28 @@
 					rthp = &rth->u.rt_next;
 					continue;
 				}
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+			/* remove all related balanced entries if necessary */
+			if ( rth->u.dst.flags & DST_BALANCED ) {
+				struct rtable* first = rth;
+				*rthp = rth->u.rt_next;
+				while ( (*rthp)->u.dst.flags & DST_BALANCED &&
+					compare_keys(&(*rthp)->fl, 
+						     &first->fl)) {
+					rth = (*rthp);
+					*rthp = rth->u.rt_next;
+					rt_free( rth );
+				}
+				rt_free(first);
+			}
+			else {
+				*rthp = rth->u.rt_next;
+				rt_free(rth);
+			}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 				*rthp = rth->u.rt_next;
 				rt_free(rth);
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 				goal--;
 			}
 			spin_unlock_bh(&rt_hash_table[k].lock);
@@ -789,7 +831,12 @@
 
 	spin_lock_bh(&rt_hash_table[hash].lock);
 	while ((rth = *rthp) != NULL) {
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+		if (!(rth->u.dst.flags & DST_BALANCED) &&
+		    compare_keys(&rth->fl, &rt->fl)) {
+#else
 		if (compare_keys(&rth->fl, &rt->fl)) {
+#endif
 			/* Put it first */
 			*rthp = rth->u.rt_next;
 			/*
@@ -1622,7 +1669,18 @@
 		goto cleanup;
 	}
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	if ( res->fi->fib_nhs > 1 )
+		RTprint( KERN_DEBUG"%s: balanced entry created: %d\n",
+			 __FUNCTION__,
+			 rth ); 
+#endif
+
 	rth->u.dst.flags= DST_HOST;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	if ( res->fi->fib_nhs > 1 )
+		rth->u.dst.flags |= DST_BALANCED;
+#endif
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
 	if (in_dev->cnf.no_xfrm)
@@ -1691,7 +1749,54 @@
 				   struct in_device *in_dev,
 				   u32 daddr, u32 saddr, u32 tos)
 {
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED 
+	struct rtable* rth;
+	unsigned char hop, hopcount, lasthop;
+	int err = -EINVAL;
+	unsigned hash;
+	hopcount = res->fi->fib_nhs;
+	lasthop = hopcount - 1;
+
+	/* distinguish between multipath and singlepath */
+	if ( hopcount < 2 ) 
+		return ip_mkroute_input_def(skb, res, fl, in_dev, daddr, 
+					    saddr, tos);
+	
+	RTprint( KERN_DEBUG"%s: entered (hopcount: %d)\n", __FUNCTION__,
+		 hopcount);
+
+	/* add all alternatives to the routing cache */
+	for ( hop = 0; hop < hopcount; ++hop ) {
+		res->nh_sel = hop;
+
+		RTprint( KERN_DEBUG"%s: entered (hopcount: %d)\n", 
+			 __FUNCTION__, hopcount);
+
+		/* create a routing cache entry */
+		err = __mkroute_input( skb, res, in_dev, daddr, saddr, tos, 
+					 &rth );
+		if ( err ) 
+			return err;
+	
+
+		/* put it into the cache */
+		hash = rt_hash_code(daddr, saddr ^ (fl->iif << 5), tos);
+		err = rt_intern_hash(hash, rth, (struct rtable**)&skb->dst);
+		if ( err ) 
+			return err;
+
+
+		/* only for the last hop the reference count is handled 
+		   outside */
+		RTprint( KERN_DEBUG"%s: balanced entry created: %d\n",
+			 __FUNCTION__, rth );
+		if ( hop == lasthop ) 
+			atomic_set(&(skb->dst->__refcnt), 1);
+	}
+	return err;
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED  */ 
 	return ip_mkroute_input_def(skb, res, fl, in_dev, daddr, saddr, tos);
+#endif
 }
 
 
@@ -1882,6 +1987,7 @@
 	goto done;
 
 martian_source:
+
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
 	goto e_inval;
 }
@@ -1907,6 +2013,17 @@
 		    rth->fl.fl4_fwmark == skb->nfmark &&
 #endif
 		    rth->fl.fl4_tos == tos) {
+			/* check if the route is a multipath route and if so
+			   select one of the alternatives */
+			if ( multipath_selectroute( 
+				     &rth->fl, rth, 
+				     (struct rtable**)&skb->dst) ) {
+				dst_hold(skb->dst);
+				rcu_read_unlock();
+
+				return 0;
+			}
+
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
@@ -2012,6 +2129,10 @@
 	}		
 
 	rth->u.dst.flags= DST_HOST;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	if (res->fi->fib_nhs > 1)
+		rth->u.dst.flags |= DST_BALANCED;
+#endif
 	if (in_dev->cnf.no_xfrm)
 		rth->u.dst.flags |= DST_NOXFRM;
 	if (in_dev->cnf.no_policy)
@@ -2103,7 +2224,71 @@
 				    struct net_device *dev_out,
 				    unsigned flags)
 {
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	u32 tos = RT_FL_TOS(oldflp);
+	unsigned char hop;
+	unsigned hash;
+	int err = -EINVAL;
+	unsigned char hopcount = res->fi->fib_nhs;
+	struct rtable* rth;
+
+	RTprint( KERN_DEBUG"%s: entered (hopcount: %d, fl->oif: %d)\n", 
+		 __FUNCTION__, hopcount, fl->oif);
+
+	if (res->fi->fib_nhs > 1) {		
+		for ( hop = 0; hop < hopcount; ++hop ) {
+			struct net_device *dev2nexthop;
+			RTprint( KERN_DEBUG"%s: hop %d of %d\n", __FUNCTION__,
+				 hop, hopcount );
+
+			res->nh_sel = hop;
+
+			/* hold a work reference to the output device */
+			dev2nexthop = FIB_RES_DEV(*res);
+			dev_hold(dev2nexthop);
+
+			/** FIXME remove debug code */
+			RTprint( KERN_DEBUG"%s: balanced entry created: %d " \
+				 " (GW: %u)\n",
+				 __FUNCTION__,
+				 rth,
+				 FIB_RES_GW(*res) );
+
+			err = __mkroute_output(&rth, res, fl, oldflp, 
+						 dev2nexthop, flags);
+			if ( err != 0 ) {
+				goto cleanup;
+			}
+
+			RTprint( KERN_DEBUG"%s: created successfully %d\n", 
+				 __FUNCTION__, hop );
+			
+			hash = rt_hash_code(oldflp->fl4_dst, 
+					    oldflp->fl4_src ^ 
+					    (oldflp->oif << 5), tos);
+			err = rt_intern_hash(hash, rth, rp);
+			RTprint( KERN_DEBUG"%s: hashed  %d\n", 
+				 __FUNCTION__, hop );
+
+		cleanup:
+			/* release work reference to output device */
+			dev_put(dev2nexthop);
+			
+			if ( err != 0 ) {
+				return err;
+			}
+		}
+		RTprint( KERN_DEBUG"%s: exited loop\n", __FUNCTION__ );
+		atomic_set(&(*rp)->u.dst.__refcnt, 1);
+		return err;
+	}
+	else {
+		return ip_mkroute_output_def(rp, res, fl, oldflp, dev_out, 
+					     flags);
+	}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 	return ip_mkroute_output_def(rp, res, fl, oldflp, dev_out, flags);
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 }
 
 /*
@@ -2316,6 +2501,16 @@
 #endif
 		    !((rth->fl.fl4_tos ^ flp->fl4_tos) &
 			    (IPTOS_RT_MASK | RTO_ONLINK))) {
+
+			/* check for multipath routes and choose one if
+			   necessary */
+			if (multipath_selectroute(flp, rth, rp)) {
+				dst_hold(&(*rp)->u.dst);
+				RT_CACHE_STAT_INC(out_hit);
+				rcu_read_unlock_bh();
+				return 0;
+			}
+
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;

--------------020102000800030904040805--
