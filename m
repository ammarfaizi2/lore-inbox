Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUIVQgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUIVQgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUIVQgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:36:49 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32465 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266223AbUIVQcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:32:33 -0400
Message-ID: <4151A8EB.80408@de.ibm.com>
Date: Wed, 22 Sep 2004 18:31:39 +0200
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/2] ipv4 multipath routing, bk head
Content-Type: multipart/mixed;
 boundary="------------080000050907000406020006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080000050907000406020006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The intention of this patch is described in detail in the previous mail.

Regards
Einar.


--------------080000050907000406020006
Content-Type: text/x-patch;
 name="multipath_cached.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multipath_cached.diff"

diff -ruN linux-2.6.8.1.split/include/net/dst.h linux-2.6.8.1.multipath/include/net/dst.h
--- linux-2.6.8.1.split/include/net/dst.h	2004-09-22 10:01:01.000000000 +0200
+++ linux-2.6.8.1.multipath/include/net/dst.h	2004-09-22 14:18:40.000000000 +0200
@@ -48,6 +48,7 @@
 #define DST_NOXFRM		2
 #define DST_NOPOLICY		4
 #define DST_NOHASH		8
+#define DST_BALANCED            0x10
 	unsigned long		lastuse;
 	unsigned long		expires;
 
diff -ruN linux-2.6.8.1.split/include/net/flow.h linux-2.6.8.1.multipath/include/net/flow.h
--- linux-2.6.8.1.split/include/net/flow.h	2004-09-22 10:01:01.000000000 +0200
+++ linux-2.6.8.1.multipath/include/net/flow.h	2004-09-22 14:19:31.000000000 +0200
@@ -51,6 +51,7 @@
 
 	__u8	proto;
 	__u8	flags;
+#define FLOWI_FLAG_MULTIPATHOLDROUTE 0x01
 	union {
 		struct {
 			__u16	sport;
diff -ruN linux-2.6.8.1.split/include/net/ip_fib.h linux-2.6.8.1.multipath/include/net/ip_fib.h
--- linux-2.6.8.1.split/include/net/ip_fib.h	2004-09-22 10:01:01.000000000 +0200
+++ linux-2.6.8.1.multipath/include/net/ip_fib.h	2004-09-22 14:18:08.000000000 +0200
@@ -95,6 +95,10 @@
 	unsigned char	nh_sel;
 	unsigned char	type;
 	unsigned char	scope;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+	__u32           network;
+	__u32           netmask;
+#endif
 	struct fib_info *fi;
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 	struct fib_rule	*r;
@@ -119,6 +123,14 @@
 #define FIB_RES_DEV(res)		(FIB_RES_NH(res).nh_dev)
 #define FIB_RES_OIF(res)		(FIB_RES_NH(res).nh_oif)
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+#define FIB_RES_NETWORK(res)		((res).network)
+#define FIB_RES_NETMASK(res)	        ((res).netmask)
+#else /* CONFIG_IP_ROUTE_MULTIPATH_WRANDOM */
+#define FIB_RES_NETWORK(res)		(0)
+#define FIB_RES_NETMASK(res)	        (0)
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_WRANDOM */
+
 struct fib_table {
 	unsigned char	tb_id;
 	unsigned	tb_stamp;
diff -ruN linux-2.6.8.1.split/include/net/route.h linux-2.6.8.1.multipath/include/net/route.h
--- linux-2.6.8.1.split/include/net/route.h	2004-09-22 10:01:01.000000000 +0200
+++ linux-2.6.8.1.multipath/include/net/route.h	2004-09-22 15:00:29.000000000 +0200
@@ -46,6 +46,7 @@
 
 #define RT_CONN_FLAGS(sk)   (RT_TOS(inet_sk(sk)->tos) | sk->sk_localroute)
 
+struct fib_nh;
 struct inet_peer;
 struct rtable
 {
@@ -179,6 +180,9 @@
 		memcpy(&fl, &(*rp)->fl, sizeof(fl));
 		fl.fl_ip_sport = sport;
 		fl.fl_ip_dport = dport;
+#if defined(CONFIG_IP_ROUTE_MULTIPATH_CACHED)
+		fl.flags |= FLOWI_FLAG_MULTIPATHOLDROUTE;
+#endif
 		ip_rt_put(*rp);
 		*rp = NULL;
 		return ip_route_output_flow(rp, &fl, sk, 0);
@@ -197,4 +201,69 @@
 	return rt->peer;
 }
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+extern void __multipath_flush(void);
+static inline void multipath_flush(void) {
+	__multipath_flush();
+}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_WRANDOM */
+static inline void multipath_flush(void){}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_WRANDOM */
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+extern void __multipath_set_nhinfo(__u32 network,
+				   __u32 netmask,
+				   unsigned char prefixlen,
+				   const struct fib_nh* nh);
+static inline void multipath_set_nhinfo(__u32 network,
+					__u32 netmask,
+					unsigned char prefixlen,
+					const struct fib_nh* nh) {
+	__multipath_set_nhinfo(network, netmask, prefixlen, nh);
+}
+#else
+static inline void multipath_set_nhinfo(__u32 network,
+					__u32 netmask,
+					unsigned char prefixlen,
+					const struct fib_nh* nh) {
+}
+#endif
+
+
+
+#if defined(CONFIG_IP_ROUTE_MULTIPATH_RR) || defined(CONFIG_IP_ROUTE_MULTIPATH_DRR)
+extern void __multipath_remove(struct rtable *rt);
+static inline void multipath_remove(struct rtable *rt) {
+	if ( rt->u.dst.flags & DST_BALANCED ) {
+		__multipath_remove( rt );
+	}
+}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_RR || CONFIG_IP_ROUTE_MULTIPATH_DRR */
+static inline void multipath_remove(struct rtable *rt) {}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_RR || CONFIG_IP_ROUTE_MULTIPATH_DRR */
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
 #endif	/* _ROUTE_H */
diff -ruN linux-2.6.8.1.split/net/ipv4/fib_hash.c linux-2.6.8.1.multipath/net/ipv4/fib_hash.c
--- linux-2.6.8.1.split/net/ipv4/fib_hash.c	2004-09-22 10:01:21.000000000 +0200
+++ linux-2.6.8.1.multipath/net/ipv4/fib_hash.c	2004-09-22 15:01:49.000000000 +0200
@@ -292,6 +292,11 @@
 				res->type = f->fn_type;
 				res->scope = f->fn_scope;
 				res->prefixlen = fz->fz_order;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+				res->netmask = fz->fz_mask;
+				res->network = f->fn_key &
+					(0xFFFFFFFF >> (32 - fz->fz_order));
+#endif
 				goto out;
 			}
 			if (err < 0)
diff -ruN linux-2.6.8.1.split/net/ipv4/Kconfig linux-2.6.8.1.multipath/net/ipv4/Kconfig
--- linux-2.6.8.1.split/net/ipv4/Kconfig	2004-09-22 10:01:21.000000000 +0200
+++ linux-2.6.8.1.multipath/net/ipv4/Kconfig	2004-09-22 13:39:14.000000000 +0200
@@ -94,6 +94,54 @@
 	  equal "cost" and chooses one of them in a non-deterministic fashion
 	  if a matching packet arrives.
 
+config IP_ROUTE_MULTIPATH_CACHED
+	bool "IP: equal cost multipath with caching support (EXPERIMENTAL)"
+	depends on: IP_ROUTE_MULTIPATH
+	help
+	  Normally, equal cost multipath routing is not supported by the
+	  routing cache. If you say Y here, alternative routes are cached
+	  and on cache lookup a route is chosen in a configurable fashion.
+
+	  If unsure, say N.
+
+#
+# multipath policy configuration
+# 
+choice
+	prompt "Multipath policy"
+	depends on IP_ROUTE_MULTIPATH_CACHED
+	default IP_ROUTE_MULTIPATH_RANDOM
+
+config IP_ROUTE_MULTIPATH_RR
+	bool "round robin (EXPERIMENTAL)"
+	help
+	  Mulitpath routes are chosen according to Round Robin
+
+config IP_ROUTE_MULTIPATH_RANDOM
+	bool "random multipath (EXPERIMENTAL)"
+	help
+	  Multipath routes are chosen in a random fashion. Actually,
+	  there is no weight for a route. The advantage of this policy
+	  is that it is implemented stateless and therefore introduces only
+	  a very small delay.
+config IP_ROUTE_MULTIPATH_WRANDOM
+	bool "weighted random multipath (EXPERIMENTAL)"
+	help
+	  Multipath routes are chosen in a weighted random fashion. 
+	  The per route weights are the weights visible via ip route 2. As the
+	  corresponding state management introduces some overhead routing delay
+	  is increased.
+config IP_ROUTE_MULTIPATH_DRR
+	bool "interface round robin (EXPERIMENTAL)"
+	help
+	  Connections are distributed in a round robin fashion over the
+	  available interfaces. This policy makes sense if the connections 
+	  should be primarily distributed on interfaces and not on routes. 
+endchoice
+#
+# END OF multipath policy configuration
+#
+
 config IP_ROUTE_TOS
 	bool "IP: use TOS value as routing key"
 	depends on IP_ADVANCED_ROUTER
diff -ruN linux-2.6.8.1.split/net/ipv4/Makefile linux-2.6.8.1.multipath/net/ipv4/Makefile
--- linux-2.6.8.1.split/net/ipv4/Makefile	2004-09-22 10:01:21.000000000 +0200
+++ linux-2.6.8.1.multipath/net/ipv4/Makefile	2004-09-22 13:40:36.000000000 +0200
@@ -21,6 +21,10 @@
 obj-$(CONFIG_INET_IPCOMP) += ipcomp.o
 obj-$(CONFIG_INET_TUNNEL) += xfrm4_tunnel.o 
 obj-$(CONFIG_IP_PNP) += ipconfig.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_RR) += multipath_rr.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_RANDOM) += multipath_random.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_WRANDOM) += multipath_wrandom.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_DRR) += multipath_drr.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
 obj-$(CONFIG_IP_VS) += ipvs/
 
diff -ruN linux-2.6.8.1.split/net/ipv4/multipath_drr.c linux-2.6.8.1.multipath/net/ipv4/multipath_drr.c
--- linux-2.6.8.1.split/net/ipv4/multipath_drr.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath/net/ipv4/multipath_drr.c	2004-09-22 18:09:04.000000000 +0200
@@ -0,0 +1,292 @@
+/*
+ *              Device round robin policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath_drr.c,v 1.1.2.1 2004/09/16 07:42:34 elueck Exp $
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
+struct multipath_device 
+{
+	int ifi; /* interface index of device */
+	atomic_t usecount;
+	int allocated;
+};
+
+#define MULTIPATH_MAX_DEVICECANDIDATES 10
+
+static struct multipath_device state[MULTIPATH_MAX_DEVICECANDIDATES];
+static spinlock_t state_lock = SPIN_LOCK_UNLOCKED;
+static int registered_dev_notifier = 0;
+static struct rtable *last_selection = NULL;
+
+#define RTprint(a...)	// printk(KERN_DEBUG a)
+
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
+static  int __inline__ __multipath_findslot(void) {
+	int i;
+	for (i=0; i<MULTIPATH_MAX_DEVICECANDIDATES; ++i) {
+		if (state[i].allocated == 0) {
+			return i;
+		}
+	}
+	return -1;
+}
+
+static  int __inline__ __multipath_finddev(int ifindex) 
+{
+	int i;
+	for (i=0; i<MULTIPATH_MAX_DEVICECANDIDATES; ++i) {
+		if (state[i].allocated != 0 && state[i].ifi == ifindex) {
+			return i;
+		}
+	}
+	return -1;
+}
+
+static int multipath_dev_event(struct notifier_block *this, 
+			       unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+	int devidx;
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+	case NETDEV_DOWN:
+		spin_lock_bh(&state_lock);
+		
+		devidx = __multipath_finddev(dev->ifindex);
+		if (devidx != -1) {
+			state[devidx].allocated = 0;
+			state[devidx].ifi = 0;
+			atomic_set(&state[devidx].usecount, 0);
+			RTprint(KERN_DEBUG"%s: successfully removed device " \
+				"with index %d\n",__FUNCTION__, devidx);
+		}
+		else {
+			RTprint(KERN_DEBUG"%s: Device not relevant for " \
+				" multipath: %d\n",
+				__FUNCTION__, devidx);
+		}
+
+		spin_unlock_bh(&state_lock);
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+struct notifier_block multipath_dev_notifier = {
+	.notifier_call	= multipath_dev_event,
+};
+
+void __multipath_remove(struct rtable* rt) {
+	if (last_selection == rt) {
+		last_selection = NULL;
+	}
+}
+
+void __multipath_safe_inc(atomic_t* usecount)
+{
+	int n;
+	atomic_inc(usecount);
+	n = atomic_read(usecount);
+	if (n<=0) {
+		int i;
+		RTprint("%s: detected overflow, now ill will reset all "\
+			"usecounts\n", __FUNCTION__);
+
+		spin_lock_bh(&state_lock);
+		for (i=0; i<MULTIPATH_MAX_DEVICECANDIDATES; ++i) {
+			atomic_set(&state[i].usecount, 0);
+		}
+		spin_unlock_bh(&state_lock);
+	}
+}
+
+void __multipath_selectroute(const struct flowi *flp, 
+			     struct rtable *first, struct rtable **rp) 
+{
+	struct rtable *nh, *result, *cur_min;
+	int min_usecount = -1; 
+	int devidx = -1;
+	int cur_min_devidx = -1;
+	
+	/* register a notifier to stay informed about dying devices */
+	if (!registered_dev_notifier) {
+		registered_dev_notifier = 1;
+		register_netdevice_notifier(&multipath_dev_notifier);
+	}
+
+       	/* if necessary and possible utilize the old alternative */
+	if ( ( flp->flags & FLOWI_FLAG_MULTIPATHOLDROUTE ) != 0 && 
+	     last_selection != NULL ) {
+		RTprint( KERN_CRIT"%s: holding route \n", __FUNCTION__ );
+		result = last_selection;
+		*rp = result;
+		return;
+	}
+
+
+	/* 1. make sure all alt. nexthops have the same GC related data */
+	/* 2. determine the new candidate to be returned */
+	result = NULL;
+	cur_min = NULL;
+	for (nh = rcu_dereference(first); nh; 
+	     nh = rcu_dereference(nh->u.rt_next)) {
+		if ( ( nh->u.dst.flags & DST_BALANCED ) != 0 &&
+		     multipath_comparekeys(&nh->fl, flp ) ) {
+			int nh_ifidx = nh->u.dst.dev->ifindex; 
+			nh->u.dst.lastuse = jiffies;
+			nh->u.dst.__use++;
+			if (result != NULL) {
+				continue;
+			}
+
+			/* search for the output interface */
+			/* this is not SMP safe, only add/remove are
+			   SMP safe as wrong usecount updates have no big
+			   impact */
+			devidx = __multipath_finddev(nh_ifidx);
+			if (devidx==-1) {
+				/* add the interface to the array 
+				   SMP safe */
+				spin_lock_bh(&state_lock);
+
+				/* due to SMP: search again */
+				devidx = __multipath_finddev(nh_ifidx);
+				if (devidx==-1) {
+					/* add entry for device */
+					devidx = __multipath_findslot();
+					if (devidx==-1) {
+						/* unlikely but possible */
+						RTprint(KERN_DEBUG"%s: " \
+							"out of space\n",
+							__FUNCTION__);
+						continue;
+					}
+
+					state[devidx].allocated = 1;
+					state[devidx].ifi = nh_ifidx;
+					atomic_set(&state[devidx].usecount, 0);
+					min_usecount = 0;
+					RTprint(KERN_DEBUG"%s: created " \
+						" for " \
+						"device %d and " \
+						"min_usecount " \
+						" == -1\n",
+						__FUNCTION__, 
+						nh_ifidx );
+				}
+
+				spin_unlock_bh(&state_lock);
+			}
+
+			if (min_usecount == 0) {
+				/* if the device has not been used it is
+				   the primary target */
+				RTprint(KERN_DEBUG"%s: now setting " \
+					"result to device %d\n",
+					__FUNCTION__, nh_ifidx );
+
+				__multipath_safe_inc(&state[devidx].usecount);
+				result = nh;
+			}
+			else {
+				int count = 
+					atomic_read(&state[devidx].usecount);
+
+				if (min_usecount == -1 || 
+				    count < min_usecount) {
+					cur_min = nh;
+					cur_min_devidx = devidx;
+					min_usecount = count;
+					
+					RTprint(KERN_DEBUG"%s: found " \
+						"device " \
+						"%d with usecount == %d\n",
+						__FUNCTION__, 
+						nh_ifidx,
+						min_usecount);
+				}
+			}
+		}
+	}
+	
+	if (!result) {
+		if (cur_min) {
+			RTprint( KERN_DEBUG"%s: index of device in state "\
+				 "array: %d\n",
+				 __FUNCTION__, cur_min_devidx );
+			__multipath_safe_inc(&state[cur_min_devidx].usecount);
+			result = cur_min;
+		}
+		else {
+			RTprint( KERN_DEBUG"%s: utilized first\n",
+				 __FUNCTION__);
+			result = first;
+		}
+	}
+	else {
+		RTprint(KERN_DEBUG"%s: utilize result: found device " \
+			"%d with usecount == %d\n",
+			__FUNCTION__, result->u.dst.dev->ifindex,
+			min_usecount);
+
+	}
+		
+	*rp = result;
+	last_selection = result;
+}
diff -ruN linux-2.6.8.1.split/net/ipv4/multipath_random.c linux-2.6.8.1.multipath/net/ipv4/multipath_random.c
--- linux-2.6.8.1.split/net/ipv4/multipath_random.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath/net/ipv4/multipath_random.c	2004-09-22 17:59:24.000000000 +0200
@@ -0,0 +1,124 @@
+/*
+ *              Random policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath_random.c,v 1.1.2.3 2004/09/21 08:42:11 elueck Exp $
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
+/* interface to random number generation */
+static unsigned int RANDOM_SEED = 93186752;
+static __inline__ unsigned int  random(unsigned int ubound);
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
+	struct rtable *decision;
+	unsigned char candidate_count = 0;
+
+	/* count all candidate */
+	for (rt = rcu_dereference(first); rt; 
+	     rt = rcu_dereference(rt->u.rt_next)) {
+		if ( ( rt->u.dst.flags & DST_BALANCED ) != 0 && 
+		     multipath_comparekeys(&rt->fl, flp) ) {
+			++candidate_count;
+		}
+	}
+
+	/* choose a random candidate */
+	decision = first;
+	if ( candidate_count > 1 ) {
+		unsigned char i = 0;
+		unsigned char candidate_no = (unsigned char) 
+			random(candidate_count);
+		RTprint( "%s: randomly chosen candidate: %d (count: %d)\n",
+			 __FUNCTION__, candidate_no, candidate_count );
+		
+		
+		/* find chosen candidate and adjust GC data for all candidates
+		   to ensure they stay in cache */
+		for (rt = first; rt; rt = rt->u.rt_next) {
+			if ( ( rt->u.dst.flags & DST_BALANCED ) != 0 && 
+			     multipath_comparekeys(&rt->fl, flp) ) {
+				rt->u.dst.lastuse = jiffies;
+				if (i == candidate_no) {
+					decision = rt;
+				}
+				if (i >= candidate_count) {
+					break;
+				}
+				i++;
+			}
+		}
+	}
+			
+	decision->u.dst.__use++;
+	*rp = decision;
+}
+
+static __inline__ unsigned int random(unsigned int ubound)
+{
+	static unsigned int a = 1588635695,
+		q = 2, 
+		r = 1117695901;
+	RANDOM_SEED = a*(RANDOM_SEED % q) - r*(RANDOM_SEED / q);
+	return RANDOM_SEED % ubound;
+}
+
diff -ruN linux-2.6.8.1.split/net/ipv4/multipath_rr.c linux-2.6.8.1.multipath/net/ipv4/multipath_rr.c
--- linux-2.6.8.1.split/net/ipv4/multipath_rr.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath/net/ipv4/multipath_rr.c	2004-09-22 17:03:07.000000000 +0200
@@ -0,0 +1,118 @@
+/*
+ *              Round robin policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath_rr.c,v 1.1.2.2 2004/09/16 07:42:34 elueck Exp $
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
+static struct rtable* last_used = NULL;
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
+void __multipath_remove(struct rtable *rt) 
+{
+	if (last_used==rt) {
+		last_used = NULL;
+	}
+}
+
+void __multipath_selectroute(const struct flowi *flp, 
+			     struct rtable *first, struct rtable **rp) 
+{
+	struct rtable *nh, *result, *min_use_cand = NULL;
+	int min_use = -1;
+
+	/* if necessary and possible utilize the old alternative */
+	if ( ( flp->flags & FLOWI_FLAG_MULTIPATHOLDROUTE ) != 0 && 
+	     last_used != NULL ) {
+		RTprint( KERN_CRIT"%s: holding route \n",
+			 __FUNCTION__ );
+		result = last_used;
+		goto out;
+	}
+
+
+	/* 1. make sure all alt. nexthops have the same GC related data */
+	/* 2. determine the new candidate to be returned */
+	result = NULL;
+	for (nh = rcu_dereference(first); nh; 
+ 	     nh = rcu_dereference(nh->u.rt_next)) {
+		if ( ( nh->u.dst.flags & DST_BALANCED ) != 0 &&
+		     multipath_comparekeys(&nh->fl, flp ) ) {
+			nh->u.dst.lastuse = jiffies;
+
+			if (min_use == -1 || nh->u.dst.__use < min_use) {
+				min_use = nh->u.dst.__use;
+				min_use_cand = nh;
+			}
+			RTprint( KERN_CRIT"%s: found balanced entry\n",
+				 __FUNCTION__ );
+		}
+	}
+	result = min_use_cand;
+	if (!result) {
+		result = first;
+	}
+
+ out:	
+	last_used = result;
+	result->u.dst.__use++;
+	*rp = result;
+}
+
+
diff -ruN linux-2.6.8.1.split/net/ipv4/multipath_wrandom.c linux-2.6.8.1.multipath/net/ipv4/multipath_wrandom.c
--- linux-2.6.8.1.split/net/ipv4/multipath_wrandom.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1.multipath/net/ipv4/multipath_wrandom.c	2004-09-22 17:01:43.000000000 +0200
@@ -0,0 +1,374 @@
+/*
+ *              Weighted random policy for multipath.
+ *
+ *
+ * Version:	$Id: multipath_wrandom.c,v 1.1.2.3 2004/09/22 07:51:40 elueck Exp $
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
+#include <net/ip_fib.h>
+
+#define MPprint(a...)	// printk(KERN_DEBUG a)
+
+#define MULTIPATH_STATE_SIZE 15
+
+struct multipath_candidate {
+	struct multipath_candidate *next;
+	int                         power;
+	struct rtable              *rt;
+};
+
+struct multipath_dest {
+	struct list_head     list;
+
+	const struct fib_nh *nh_info;
+	__u32                netmask;
+	__u32                network;
+	unsigned char        prefixlen;
+
+	struct rcu_head  rcu;
+};
+
+struct multipath_bucket {
+	struct list_head head;
+	spinlock_t       lock;
+};
+
+struct multipath_route {
+	struct list_head list;
+
+	int              oif;
+	__u32            gw;
+	struct list_head dests;
+
+	struct rcu_head  rcu;
+};
+
+
+/* state: primarily weight per route information */
+static int multipath_state_initialized = 0;
+static spinlock_t state_big_lock = SPIN_LOCK_UNLOCKED;
+static struct multipath_bucket state[MULTIPATH_STATE_SIZE];
+
+
+/* interface to random number generation */
+static unsigned int RANDOM_SEED = 93186752;
+static __inline__ unsigned int random(unsigned int ubound);
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
+
+static unsigned char __multipath_lookup_weight(const struct flowi *fl,
+					       const struct rtable *rt) {
+	const int state_idx = rt->idev->dev->ifindex % MULTIPATH_STATE_SIZE;
+	struct multipath_route *r; 
+	struct multipath_route *target_route = NULL;
+	struct multipath_dest *d; 
+	int weight = 1;
+
+	/* lookup the weight information for a certain route */
+	rcu_read_lock();
+
+	/* find state entry for gateway or add one if necessary */
+	list_for_each_entry_rcu(r, &state[state_idx].head, list) {
+		if (r->gw == rt->rt_gateway && 
+		    r->oif == rt->idev->dev->ifindex) {
+			target_route = r;
+			break;
+		} 
+	}
+	if (!target_route) {
+		/* this should not happen... but we are prepared */
+		printk( KERN_CRIT"%s: missing state for gateway: %u and " \
+			"device %d\n", __FUNCTION__, rt->rt_gateway,
+			rt->idev->dev->ifindex);
+		goto out;
+	}
+
+	/* find state entry for destination */
+	list_for_each_entry_rcu(d, &target_route->dests, list) {
+		__u32 targetnetwork = fl->fl4_dst & 
+			(0xFFFFFFFF >> (32 - d->prefixlen));
+		
+		if ((targetnetwork & d->netmask) == d->network) {
+			weight = d->nh_info->nh_weight;
+			MPprint("%s: found weight %d for gateway %u\n",
+				__FUNCTION__, weight, rt->rt_gateway);
+			goto out;
+		}
+	}
+
+ out:
+	rcu_read_unlock();
+	return weight;
+}
+
+static void __multipath_init_state(void) 
+{
+	spin_lock(&state_big_lock);
+
+	/* check again due to SMP and to prevent contention */
+	if (!multipath_state_initialized) {
+		int i;
+		for (i = 0; i < MULTIPATH_STATE_SIZE; ++i) {
+			INIT_LIST_HEAD(&state[i].head);
+			state[i].lock = SPIN_LOCK_UNLOCKED;
+		}
+	}
+
+	/* now mark initialized */
+	multipath_state_initialized = 1;
+
+	spin_unlock(&state_big_lock);
+}
+
+static void inline __multipath_init(void) 
+{
+	/* do not spinlock to reduce unnecessary contention */
+	if (!multipath_state_initialized) {
+		__multipath_init_state();
+	}
+}
+
+void __multipath_selectroute(const struct flowi *flp, 
+			     struct rtable *first, 
+			     struct rtable **rp) {
+	struct rtable *rt;
+	struct rtable *decision;
+	struct multipath_candidate *first_mpc = NULL;
+	struct multipath_candidate *mpc, *last_mpc = NULL;
+	int power = 0;
+	int last_power;
+	int selector;
+	const size_t size_mpc = sizeof(struct multipath_candidate);
+
+	/* init state if necessary */
+	__multipath_init();
+	
+
+	/* collect all candidates and identify their weights */
+	for (rt = rcu_dereference(first); rt; 
+	     rt = rcu_dereference(rt->u.rt_next)) {
+		if ((rt->u.dst.flags & DST_BALANCED) != 0 &&
+		    multipath_comparekeys(&rt->fl, flp) ) {
+			struct multipath_candidate* mpc = 
+				(struct multipath_candidate*)
+				kmalloc(size_mpc, GFP_KERNEL);
+			
+			power += __multipath_lookup_weight(flp, rt) * 10000;
+			
+			mpc->power = power;
+			mpc->rt = rt;	
+			mpc->next = NULL;
+			
+			if (!first_mpc)
+				first_mpc = mpc;
+			else 
+				last_mpc->next = mpc;
+			
+			last_mpc = mpc;
+		}
+	}
+
+	/* choose a weighted random candidate */
+	decision = first; 
+	selector = random(power);
+	MPprint("%s: random number %d in range %d\n", __FUNCTION__, selector,
+		power);
+	last_power = 0;
+		
+		
+	/* select candidate, adjust GC data and cleanup local state */
+	decision = first;
+	last_mpc = NULL;
+	for (mpc = first_mpc; mpc; mpc = mpc->next) {
+		mpc->rt->u.dst.lastuse = jiffies;
+		MPprint("%s: last_power = %d, selector: %d, mpc->power: %d\n",
+			__FUNCTION__, last_power, selector, mpc->power);
+		if (last_power <= selector && selector < mpc->power) {
+			decision = mpc->rt;
+			MPprint("%s: selected %u\n", __FUNCTION__,
+				decision->rt_gateway);
+		}
+		last_power = mpc->power;
+		if (last_mpc) {
+			kfree(last_mpc);
+		}
+		last_mpc = mpc;
+	}			
+	if (last_mpc) {
+		/* concurrent __multipath_flush may lead to !last_mpc */
+		kfree(last_mpc);
+	}
+
+	decision->u.dst.__use++;
+	*rp = decision;
+}
+
+void __multipath_set_nhinfo(__u32 network,
+			    __u32 netmask,
+			    unsigned char prefixlen,
+			    const struct fib_nh* nh)
+{
+	const int state_idx = nh->nh_oif % MULTIPATH_STATE_SIZE;
+	struct multipath_route *r, *target_route = NULL;
+	struct multipath_dest *d, *target_dest = NULL;
+
+	/* init state if necessary */
+	__multipath_init();
+
+	/* store the weight information for a certain route */
+	spin_lock(&state[state_idx].lock);
+
+	/* find state entry for gateway or add one if necessary */
+	list_for_each_entry_rcu(r, &state[state_idx].head, list) {
+		if (r->gw == nh->nh_gw && r->oif == nh->nh_oif) {
+			target_route = r;
+			break;
+		} 
+	}
+	if (!target_route) {
+		const size_t size_rt = sizeof(struct multipath_route);
+		target_route = (struct multipath_route *) 
+			kmalloc(size_rt, GFP_KERNEL);
+
+		target_route->gw = nh->nh_gw;
+		target_route->oif = nh->nh_oif;
+		memset(&target_route->rcu, sizeof(struct rcu_head), 0);
+		INIT_LIST_HEAD(&target_route->dests);
+		
+		list_add_rcu(&target_route->list, &state[state_idx].head);
+	}
+
+	/* find state entry for destination or add one if necessary */
+	list_for_each_entry_rcu(d, &target_route->dests, list) {
+		if (d->nh_info == nh) {
+			target_dest = d;
+			break;
+		}
+	}
+	if (!target_dest) {
+		const size_t size_dst = sizeof(struct multipath_dest);
+		target_dest = (struct multipath_dest*)
+			kmalloc(size_dst, GFP_KERNEL);
+		
+		target_dest->nh_info = nh;
+		target_dest->network = network;
+		target_dest->netmask = netmask;
+		target_dest->prefixlen = prefixlen;
+		memset(&target_dest->rcu, sizeof(struct rcu_head), 0);
+
+		list_add_rcu(&target_dest->list, &target_route->dests);
+	}
+	/* else: we already stored this info for another destination =>
+	   we are finished */
+
+	spin_unlock(&state[state_idx].lock);
+}
+
+
+static void __multipath_free(struct rcu_head *head)
+{
+	struct multipath_route *rt = container_of(head, struct multipath_route,
+						  rcu);
+	kfree(rt);
+}
+
+static void __multipath_free_dst(struct rcu_head *head)
+{
+  	struct multipath_dest *dst = container_of(head,
+							 struct multipath_dest,
+							 rcu);
+	kfree(dst);
+}
+
+void __multipath_flush() 
+{
+	int i;
+
+	MPprint("%s: called\n", __FUNCTION__);
+
+	/* init state if necessary */
+	__multipath_init();
+
+	/* defere delete to all entries */
+	for (i = 0; i < MULTIPATH_STATE_SIZE; ++i) {
+		struct multipath_route *r;
+		spin_lock(&state[i].lock);
+		
+		list_for_each_entry_rcu(r, &state[i].head, list) {
+			struct multipath_dest *d;
+			list_for_each_entry_rcu(d, &r->dests, list) {
+				list_del_rcu(&d->list);
+				call_rcu(&d->rcu, 
+					    __multipath_free_dst);
+
+			}
+			list_del_rcu(&r->list);
+			call_rcu(&r->rcu, 
+				    __multipath_free);
+		}
+
+		spin_unlock(&state[i].lock);
+	}
+
+	MPprint("%s: finished\n", __FUNCTION__);
+}
+
+static __inline__ unsigned int random(unsigned int ubound)
+{
+	static unsigned int a = 1588635695,
+		q = 2, 
+		r = 1117695901;
+	RANDOM_SEED = a*(RANDOM_SEED % q) - r*(RANDOM_SEED / q);
+	return RANDOM_SEED % ubound;
+}
diff -ruN linux-2.6.8.1.split/net/ipv4/route.c linux-2.6.8.1.multipath/net/ipv4/route.c
--- linux-2.6.8.1.split/net/ipv4/route.c	2004-09-22 10:01:49.000000000 +0200
+++ linux-2.6.8.1.multipath/net/ipv4/route.c	2004-09-22 17:29:29.000000000 +0200
@@ -129,7 +129,7 @@
 int ip_rt_secret_interval	= 10 * 60 * HZ;
 static unsigned long rt_deadline;
 
-#define RTprint(a...)	printk(KERN_DEBUG a)
+#define RTprint(a...)	// printk(KERN_DEBUG a)
 
 static struct timer_list rt_flush_timer;
 static struct timer_list rt_periodic_timer;
@@ -442,11 +442,13 @@
   
 static __inline__ void rt_free(struct rtable *rt)
 {
+	multipath_remove( rt );
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
+	multipath_remove( rt );
 	ip_rt_put(rt);
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
@@ -508,6 +510,54 @@
 	return score;
 }
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+static struct rtable **rt_remove_balanced_route(struct rtable **chain_head,
+						struct rtable *expentry,
+						int* removed_count) 
+{
+	int passedexpired = 0;
+	struct rtable **nextstep = NULL;
+	struct rtable **rthp = chain_head;
+	struct rtable *rth;
+	if (removed_count)
+		*removed_count = 0;
+	while ((rth = *rthp) != NULL) {
+		if ( rth == expentry ) {
+			passedexpired = 1;
+		}
+
+		if (((*rthp)->u.dst.flags & DST_BALANCED) != 0  &&
+		    compare_keys(&(*rthp)->fl, &expentry->fl)) {
+			if (*rthp == expentry) {
+				*rthp = rth->u.rt_next;
+				continue;
+			}
+			else {
+				*rthp = rth->u.rt_next;
+				rt_free(rth);
+				if (removed_count)
+					++(*removed_count);
+			}
+		}
+		else {
+			if ( !((*rthp)->u.dst.flags & DST_BALANCED) && 
+			     passedexpired && !nextstep ) {
+				nextstep = &rth->u.rt_next;
+			}
+			rthp = &rth->u.rt_next;
+		}
+	}
+
+	rt_free(expentry);
+	if (removed_count)
+		++(*removed_count);
+	
+	return nextstep;
+}
+					       
+#endif
+
+
 /* This runs via a timer and thus is always in BH context. */
 static void rt_check_expire(unsigned long dummy)
 {
@@ -539,8 +589,24 @@
 			}
 
 			/* Cleanup aged off entries. */
-			*rthp = rth->u.rt_next;
-			rt_free(rth);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+			/* remove all related balanced entries if necessary */
+			if ( rth->u.dst.flags & DST_BALANCED ) {
+				rthp = rt_remove_balanced_route(
+					&rt_hash_table[i].chain,
+					rth, NULL);
+				if (!rthp) {
+					break;
+				}
+			}
+			else {
+				*rthp = rth->u.rt_next;
+				rt_free(rth);
+			}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
+ 			*rthp = rth->u.rt_next;
+ 			rt_free(rth);
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 		}
 		spin_unlock(&rt_hash_table[i].lock);
 
@@ -588,6 +654,9 @@
 	if (delay < 0)
 		delay = ip_rt_min_delay;
 
+	/* flush existing multipath state*/
+	multipath_flush();
+
 	spin_lock_bh(&rt_flush_lock);
 
 	if (del_timer(&rt_flush_timer) && delay > 0 && rt_deadline) {
@@ -706,9 +775,29 @@
 					rthp = &rth->u.rt_next;
 					continue;
 				}
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+				/* remove all related balanced entries if necessary */
+				if ( rth->u.dst.flags & DST_BALANCED ) {
+					int r;
+					rthp = rt_remove_balanced_route(
+						&rt_hash_table[i].chain,
+						rth,
+						&r);
+					goal -= r;
+					if (!rthp) {
+						break;
+					}
+				}
+				else {
+					*rthp = rth->u.rt_next;
+					rt_free(rth);
+					goal--;
+				}
+#else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 				*rthp = rth->u.rt_next;
 				rt_free(rth);
 				goal--;
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 			}
 			spin_unlock_bh(&rt_hash_table[k].lock);
 			if (goal <= 0)
@@ -789,7 +878,12 @@
 
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
@@ -1623,6 +1717,10 @@
 	}
 
 	rth->u.dst.flags= DST_HOST;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	if ( res->fi->fib_nhs > 1 )
+		rth->u.dst.flags |= DST_BALANCED;
+#endif
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
 	if (in_dev->cnf.no_xfrm)
@@ -1691,7 +1789,60 @@
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
+				       &rth );
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
+		/* forward hop information to multipath impl. */
+		multipath_set_nhinfo(FIB_RES_NETWORK(*res),
+				     FIB_RES_NETMASK(*res),
+				     res->prefixlen,
+				     &FIB_RES_NH(*res));
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
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED  */ 
 }
 
 
@@ -2012,6 +2163,10 @@
 	}		
 
 	rth->u.dst.flags= DST_HOST;
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+	if (res->fi->fib_nhs > 1)
+		rth->u.dst.flags |= DST_BALANCED;
+#endif
 	if (in_dev->cnf.no_xfrm)
 		rth->u.dst.flags |= DST_NOXFRM;
 	if (in_dev->cnf.no_policy)
@@ -2103,7 +2258,77 @@
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
+			err = __mkroute_output(&rth, res, fl, oldflp, 
+					       dev2nexthop, flags);
+
+			/** FIXME remove debug code */
+			RTprint( KERN_DEBUG"%s: balanced entry created: %d " \
+				 " (GW: %u)\n",
+				 __FUNCTION__,
+				 &rth->u.dst,
+				 FIB_RES_GW(*res) );
+
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
+			/* forward hop information to multipath impl. */
+			multipath_set_nhinfo(FIB_RES_NETWORK(*res),
+					     FIB_RES_NETMASK(*res),
+					     res->prefixlen,
+					     &FIB_RES_NH(*res));
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
+#endif
 }
 
 /*
@@ -2316,6 +2541,15 @@
 #endif
 		    !((rth->fl.fl4_tos ^ flp->fl4_tos) &
 			    (IPTOS_RT_MASK | RTO_ONLINK))) {
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

--------------080000050907000406020006--
