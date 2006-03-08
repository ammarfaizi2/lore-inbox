Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWCHQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWCHQdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWCHQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:33:52 -0500
Received: from adsl-67-65-19-105.dsl.austtx.swbell.net ([67.65.19.105]:45398
	"EHLO mail.es335.com") by vger.kernel.org with ESMTP
	id S1751487AbWCHQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:33:51 -0500
Subject: [PATCH][RFC] Notifier mechanism to notify RDMA devices of network
	events
From: Tom Tucker <tom@opengridcomputing.com>
Reply-To: tom@opengridcomputing.com
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:38:17 -0600
Message-Id: <1141835897.32470.43.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements a mechanism that allows interested clients to 
register for notification of certain network events. The intended use
is to allow RDMA(OpenIB) devices to be notified of neighbour updates, 
ICMP redirects, path MTU changes, and route changes. 

The reason these devices need update events is because they typically 
cache this information in hardware and need to be notified when
this information has been updated.

This approach is one of many possibilities and may be preferred because
it uses an existing notification mechanism that has precedent in the 
stack. 

This code does not yet implement path MTU change because the number of 
places in which this value is updated is large and if this mechanism seems
reasonable, it would be probably be best to funnel these updates through a 
single function.


diff -u -r -x '.*' --new-file linux-2.6.14.5/include/net/netevent.h linux-2.6.14.5.tom/include/net/netevent.h
--- linux-2.6.14.5/include/net/netevent.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14.5.tom/include/net/netevent.h	2006-01-16 13:42:09.000000000 -0600
@@ -0,0 +1,41 @@
+#ifndef _NET_EVENT_H
+#define _NET_EVENT_H
+
+/*
+ *	Generic netevent notifiers
+ *
+ *	Authors:
+ *      Tom Tucker              <tom@opengridcomputing.com>
+ *
+ * 	Changes:
+ */
+
+#ifdef __KERNEL__
+
+#include <net/dst.h>
+
+struct netevent_redirect {
+	struct dst_entry *old;
+	struct dst_entry *new;
+};
+
+struct netevent_route_change {
+        int event;
+        struct fib_info *fib_info;
+};
+
+enum netevent_notif_type {
+	NETEVENT_NEIGH_UPDATE = 1, /* arg is * struct neighbour */
+	NETEVENT_ROUTE_UPDATE,	   /* arg is * netevent_route_change */
+	NETEVENT_PMTU_UPDATE,
+	NETEVENT_REDIRECT,	   /* arg is * struct netevent_redirect */
+};
+
+extern int register_netevent_notifier(struct notifier_block *nb);
+extern int unregister_netevent_notifier(struct notifier_block *nb);
+extern int call_netevent_notifiers(unsigned long val, void *v);
+
+#endif
+#endif
+
+
diff -u -r -x '.*' --new-file linux-2.6.14.5/net/core/Makefile linux-2.6.14.5.tom/net/core/Makefile
--- linux-2.6.14.5/net/core/Makefile	2005-12-26 18:26:33.000000000 -0600
+++ linux-2.6.14.5.tom/net/core/Makefile	2006-01-16 13:41:42.000000000 -0600
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
+obj-y		     += dev.o ethtool.o dev_mcast.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
 obj-$(CONFIG_XFRM) += flow.o
diff -u -r -x '.*' --new-file linux-2.6.14.5/net/core/neighbour.c linux-2.6.14.5.tom/net/core/neighbour.c
--- linux-2.6.14.5/net/core/neighbour.c	2005-12-26 18:26:33.000000000 -0600
+++ linux-2.6.14.5.tom/net/core/neighbour.c	2006-01-16 13:41:42.000000000 -0600
@@ -30,9 +30,11 @@
 #include <net/neighbour.h>
 #include <net/dst.h>
 #include <net/sock.h>
+#include <net/netevent.h>
 #include <linux/rtnetlink.h>
 #include <linux/random.h>
 #include <linux/string.h>
+#include <linux/notifier.h>
 
 #define NEIGH_DEBUG 1
 
@@ -756,6 +758,7 @@
 			NEIGH_PRINTK2("neigh %p is suspected.\n", neigh);
 			neigh->nud_state = NUD_STALE;
 			neigh_suspect(neigh);
+			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		}
 	} else if (state & NUD_DELAY) {
 		if (time_before_eq(now, 
@@ -763,6 +766,7 @@
 			NEIGH_PRINTK2("neigh %p is now reachable.\n", neigh);
 			neigh->nud_state = NUD_REACHABLE;
 			neigh_connect(neigh);
+			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 			next = neigh->confirmed + neigh->parms->reachable_time;
 		} else {
 			NEIGH_PRINTK2("neigh %p is probed.\n", neigh);
@@ -781,6 +785,7 @@
 
 		neigh->nud_state = NUD_FAILED;
 		notify = 1;
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		NEIGH_CACHE_STAT_INC(neigh->tbl, res_failed);
 		NEIGH_PRINTK2("neigh %p is failed.\n", neigh);
 
@@ -1051,6 +1056,9 @@
 			(neigh->flags | NTF_ROUTER) :
 			(neigh->flags & ~NTF_ROUTER);
 	}
+
+	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+
 	write_unlock_bh(&neigh->lock);
 #ifdef CONFIG_ARPD
 	if (notify && neigh->parms->app_probes)
diff -u -r -x '.*' --new-file linux-2.6.14.5/net/core/netevent.c linux-2.6.14.5.tom/net/core/netevent.c
--- linux-2.6.14.5/net/core/netevent.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14.5.tom/net/core/netevent.c	2006-01-16 13:50:25.000000000 -0600
@@ -0,0 +1,69 @@
+/*
+ *	Network event notifiers
+ *
+ *	Authors:
+ *      Tom Tucker             <tom@opengridcomputing.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ *	Fixes:
+ */
+
+#include <linux/rtnetlink.h>
+#include <linux/notifier.h>
+
+static struct notifier_block *netevent_notif_chain;
+
+/**
+ *	register_netevent_notifier - register a netevent notifier block
+ *	@nb: notifier
+ *
+ *	Register a notifier to be called when a netevent occurs.
+ *	The notifier passed is linked into the kernel structures and must
+ *	not be reused until it has been unregistered. A negative errno code
+ *	is returned on a failure.
+ */
+int register_netevent_notifier(struct notifier_block *nb)
+{
+	int err;
+
+	rtnl_lock();
+	err = notifier_chain_register(&netevent_notif_chain, nb);
+	rtnl_unlock();
+	return err;
+}
+
+/**
+ *	netevent_unregister_notifier - unregister a netevent notifier block
+ *	@nb: notifier
+ *
+ *	Unregister a notifier previously registered by
+ *	register_neigh_notifier(). The notifier is unlinked into the
+ *	kernel structures and may then be reused. A negative errno code
+ *	is returned on a failure.
+ */
+
+int unregister_netevent_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&netevent_notif_chain, nb);
+}
+
+/**
+ *	call_netevent_notifiers - call all netevent notifier blocks
+ *      @val: value passed unmodified to notifier function
+ *      @v:   pointer passed unmodified to notifier function
+ *
+ *	Call all neighbour notifier blocks.  Parameters and return value
+ *	are as for notifier_call_chain().
+ */
+
+int call_netevent_notifiers(unsigned long val, void *v)
+{
+	return notifier_call_chain(&netevent_notif_chain, val, v);
+}
+
+EXPORT_SYMBOL(register_netevent_notifier);
+EXPORT_SYMBOL(unregister_netevent_notifier);
diff -u -r -x '.*' --new-file linux-2.6.14.5/net/ipv4/fib_semantics.c linux-2.6.14.5.tom/net/ipv4/fib_semantics.c
--- linux-2.6.14.5/net/ipv4/fib_semantics.c	2005-12-26 18:26:33.000000000 -0600
+++ linux-2.6.14.5.tom/net/ipv4/fib_semantics.c	2006-01-16 13:41:42.000000000 -0600
@@ -43,6 +43,7 @@
 #include <net/sock.h>
 #include <net/ip_fib.h>
 #include <net/ip_mp_alg.h>
+#include <net/netevent.h>
 
 #include "fib_lookup.h"
 
@@ -276,9 +277,15 @@
 	       struct nlmsghdr *n, struct netlink_skb_parms *req)
 {
 	struct sk_buff *skb;
+	struct netevent_route_change rev;
+
 	u32 pid = req ? req->pid : n->nlmsg_pid;
 	int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
 
+	rev.event = event;
+	rev.fib_info = fa->fa_info;
+	call_netevent_notifiers(NETEVENT_ROUTE_UPDATE, &rev);
+
 	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return;
diff -u -r -x '.*' --new-file linux-2.6.14.5/net/ipv4/route.c linux-2.6.14.5.tom/net/ipv4/route.c
--- linux-2.6.14.5/net/ipv4/route.c	2005-12-26 18:26:33.000000000 -0600
+++ linux-2.6.14.5.tom/net/ipv4/route.c	2006-01-16 13:41:42.000000000 -0600
@@ -103,6 +103,7 @@
 #include <net/icmp.h>
 #include <net/xfrm.h>
 #include <net/ip_mp_alg.h>
+#include <net/netevent.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
@@ -1118,6 +1119,7 @@
 	struct rtable *rth, **rthp;
 	u32  skeys[2] = { saddr, 0 };
 	int  ikeys[2] = { dev->ifindex, 0 };
+	struct netevent_redirect netevent;
 
 	tos &= IPTOS_RT_MASK;
 
@@ -1213,6 +1215,10 @@
 					rt_drop(rt);
 					goto do_next;
 				}
+				
+				netevent.old = &rth->u.dst;
+				netevent.new = &rt->u.dst;
+				call_netevent_notifiers(NETEVENT_REDIRECT, &netevent);
 
 				rt_del(hash, rth);
 				if (!rt_intern_hash(hash, rt, &rt))

