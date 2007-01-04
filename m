Return-Path: <linux-kernel-owner+w=401wt.eu-S932251AbXADDwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbXADDwS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXADDwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:52:18 -0500
Received: from ricci.tusc.com.au ([203.2.177.24]:19486 "EHLO ricci.tusc.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbXADDwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:52:16 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 22:52:15 EST
Subject: [PATCH 2.6.19 1/2] X.25: Adds call forwarding to X.25
From: ahendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 14:37:02 +1100
Message-Id: <1167881822.5124.88.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds call forwarding to X.25, allowing it to operate like an X.25 router.
Useful if one needs to manipulate X.25 traffic with tools like tc.
This is an update/cleanup based off a patch submitted by Daniel Ferenci a few years ago.

Worked ok with Cisco XoT, linux X.25 back to back, and some old NTUs/PADs.

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/include/net/x25.h linux-2.6.19/include/net/x25.h
--- linux-2.6.19-vanilla/include/net/x25.h	2006-12-31 22:31:06.000000000 +1100
+++ linux-2.6.19/include/net/x25.h	2007-01-01 17:06:13.000000000 +1100
@@ -161,6 +161,14 @@ struct x25_sock {
 	unsigned long 		vc_facil_mask;	/* inc_call facilities mask */
 };
 
+struct x25_forward {
+	struct list_head	node;
+	unsigned int		lci;
+	struct net_device	*dev1;
+	struct net_device	*dev2;
+	atomic_t		refcnt;
+};
+
 static inline struct x25_sock *x25_sk(const struct sock *sk)
 {
 	return (struct x25_sock *)sk;
@@ -198,6 +206,12 @@ extern int x25_negotiate_facilities(stru
 				struct x25_dte_facilities *);
 extern void x25_limit_facilities(struct x25_facilities *, struct x25_neigh *);
 
+/* x25_forward.c */
+extern void x25_clear_forwards(struct net_device *);
+extern struct x25_neigh *x25_find_forward(int, struct x25_neigh *);
+extern int x25_forward_call(struct x25_address *, struct x25_neigh *,
+				struct sk_buff *, int);
+
 /* x25_in.c */
 extern int  x25_process_rx_frame(struct sock *, struct sk_buff *);
 extern int  x25_backlog_rcv(struct sock *, struct sk_buff *);
@@ -281,6 +295,8 @@ extern struct hlist_head x25_list;
 extern rwlock_t x25_list_lock;
 extern struct list_head x25_route_list;
 extern rwlock_t x25_route_list_lock;
+extern struct list_head x25_forward_list;
+extern rwlock_t x25_forward_list_lock;
 
 extern int x25_proc_init(void);
 extern void x25_proc_exit(void);
diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/net/x25/af_x25.c linux-2.6.19/net/x25/af_x25.c
--- linux-2.6.19-vanilla/net/x25/af_x25.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/af_x25.c	2007-01-01 00:32:48.000000000 +1100
@@ -850,6 +850,9 @@ int x25_rx_call_request(struct sk_buff *
 	struct x25_dte_facilities dte_facilities;
 	int len, rc;
 
+	struct sk_buff *skbn;
+	skbn = skb_clone(skb, GFP_ATOMIC);
+
 	/*
 	 *	Remove the LCI and frame type.
 	 */
@@ -875,11 +878,23 @@ int x25_rx_call_request(struct sk_buff *
 	sk = x25_find_listener(&source_addr,skb);
 	skb_push(skb,len);
 
+	if (sk != NULL && sk_acceptq_is_full(sk)) {
+		goto out_sock_put;
+	}
+
 	/*
-	 *	We can't accept the Call Request.
+	 *	We dont have any listeners for this incoming call.
+	 *	Try forwarding it.
 	 */
-	if (sk == NULL || sk_acceptq_is_full(sk))
-		goto out_clear_request;
+	if (sk == NULL) {
+		if (x25_forward_call(&dest_addr, nb, skbn, lci) == 0) {
+			/* Call was fowarded, dont process it any more */
+			return 0;
+		} else {
+			/* No listeners, can't forward, clear the call */
+			goto out_clear_request;
+		}
+	}
 
 	/*
 	 *	Try to reach a compromise on the requested facilities.
@@ -1600,6 +1615,9 @@ void x25_kill_by_neigh(struct x25_neigh 
 			x25_disconnect(s, ENETUNREACH, 0, 0);
 
 	write_unlock_bh(&x25_list_lock);
+
+	/* Remove any related forwards */
+	x25_clear_forwards(nb->dev);
 }
 
 static int __init x25_init(void)
diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/net/x25/Makefile linux-2.6.19/net/x25/Makefile
--- linux-2.6.19-vanilla/net/x25/Makefile	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/Makefile	2006-12-31 23:25:38.000000000 +1100
@@ -6,5 +6,5 @@ obj-$(CONFIG_X25) += x25.o
 
 x25-y			:= af_x25.o x25_dev.o x25_facilities.o x25_in.o \
 			   x25_link.o x25_out.o x25_route.o x25_subr.o \
-			   x25_timer.o x25_proc.o
+			   x25_timer.o x25_proc.o x25_forward.o
 x25-$(CONFIG_SYSCTL)	+= sysctl_net_x25.o
diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/net/x25/x25_dev.c linux-2.6.19/net/x25/x25_dev.c
--- linux-2.6.19-vanilla/net/x25/x25_dev.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/x25_dev.c	2007-01-01 17:07:30.000000000 +1100
@@ -29,6 +29,7 @@ static int x25_receive_data(struct sk_bu
 	struct sock *sk;
 	unsigned short frametype;
 	unsigned int lci;
+	struct x25_neigh *to_neigh;
 
 	frametype = skb->data[2];
         lci = ((skb->data[0] << 8) & 0xF00) + ((skb->data[1] << 0) & 0x0FF);
@@ -66,9 +67,19 @@ static int x25_receive_data(struct sk_bu
 		return x25_rx_call_request(skb, nb, lci);
 
 	/*
-	 *	Its not a Call Request, nor is it a control frame.
-	 *      Let caller throw it away.
+	 * 	Its not a Call Request, nor is it a control frame.
+	 *	Can we forward it?
 	 */
+
+	if (( to_neigh = x25_find_forward(lci, nb)) != NULL) {
+		struct sk_buff *skbn = pskb_copy (skb, GFP_ATOMIC);
+		x25_transmit_link(skbn, to_neigh);
+		if (frametype == X25_CLEAR_CONFIRMATION) {
+			x25_clear_forwards(nb->dev);
+		}
+		return 1;
+	}
+
 /*
 	x25_transmit_clear_request(nb, lci, 0x0D);
 */
diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/net/x25/x25_forward.c linux-2.6.19/net/x25/x25_forward.c
--- linux-2.6.19-vanilla/net/x25/x25_forward.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.19/net/x25/x25_forward.c	2007-01-01 17:07:24.000000000 +1100
@@ -0,0 +1,115 @@
+/*
+ *	This module:
+ *		This module is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ *	History
+ *	03-01-2007	Added forwarding for x.25	Andrew Hendry
+ */
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <net/x25.h>
+
+struct list_head x25_forward_list = LIST_HEAD_INIT(x25_forward_list);
+DEFINE_RWLOCK(x25_forward_list_lock);
+
+int x25_forward_call(struct x25_address *dest_addr, struct x25_neigh *from,
+			struct sk_buff *skbn, int lci)
+{
+	struct x25_route *rt;
+	struct x25_neigh *neigh_new;
+	struct list_head *entry;
+	struct x25_forward *x25_frwd, *new_frwd;
+	short same_lci = 0;
+
+	if ((rt = x25_get_route(dest_addr)) != NULL) {
+
+		if ((neigh_new = x25_get_neigh(rt->dev)) == NULL) {
+			/* This shouldnt happen, if it occurs somehow
+			 * do something sensible
+			 */
+			return 1;
+		}
+
+		/* Avoid a loop. This is the normal exit path for a
+		 * system with only one x.25 iface and default route
+		 */
+		if (rt->dev == from->dev) {
+			return 1;
+		}
+
+		/* Remote end sending a call request on an already
+		 * established LCI? It shouldnt happen, just in case..
+		 */
+		read_lock_bh(&x25_forward_list_lock);
+		list_for_each(entry, &x25_forward_list) {
+			x25_frwd = list_entry(entry, struct x25_forward, node);
+			if (x25_frwd->lci == lci) {
+				printk(KERN_WARNING "X.25: call request for lci which is already registered!, transmitting but not registering new pair\n");
+				same_lci = 1;
+			}
+		}
+		read_unlock_bh(&x25_forward_list_lock);
+
+		/* Save the forwarding details for future traffic */
+		if (!same_lci){
+			if ((new_frwd = kmalloc(sizeof(struct x25_forward), GFP_ATOMIC)) == NULL)
+				return -ENOMEM;
+			new_frwd->lci = lci;
+			new_frwd->dev1 = rt->dev;
+			new_frwd->dev2 = from->dev;
+			write_lock_bh(&x25_forward_list_lock);
+			list_add(&new_frwd->node, &x25_forward_list);
+			write_unlock_bh(&x25_forward_list_lock);
+		}
+
+		/* Forward the call request */
+		x25_transmit_link(skbn, neigh_new);
+		return 0;
+	} else
+		return 1;
+}
+
+
+struct x25_neigh *x25_find_forward(int lci, struct x25_neigh *from) {
+
+	struct x25_forward *frwd;
+	struct list_head *entry;
+	struct net_device *peer = NULL;
+
+	read_lock_bh(&x25_forward_list_lock);
+	list_for_each(entry, &x25_forward_list) {
+		frwd = list_entry(entry, struct x25_forward, node);
+		if (frwd->lci == lci) {
+			/* The call is established, either side can send */
+			if (from->dev == frwd->dev1) {
+				peer = frwd->dev2;
+			} else {
+				peer = frwd->dev1;
+			}
+			break;
+		}
+	}
+	read_unlock_bh(&x25_forward_list_lock);
+	return x25_get_neigh(peer);
+}
+
+
+void x25_clear_forwards(struct net_device *dev)
+{
+	struct x25_forward *fwd;
+	struct list_head *entry, *tmp;
+
+        /* Remove any related forwards */
+	write_lock_bh(&x25_forward_list_lock);
+
+	list_for_each_safe(entry, tmp, &x25_forward_list) {
+		fwd = list_entry(entry, struct x25_forward, node);
+		if ((fwd->dev1 == dev) || (fwd->dev2 == dev)){
+			list_del(&fwd->node);
+		}
+	}
+	write_unlock_bh(&x25_forward_list_lock);
+}
diff -uprN -X linux-2.6.19/Documentation/dontdiff linux-2.6.19-vanilla/net/x25/x25_route.c linux-2.6.19/net/x25/x25_route.c
--- linux-2.6.19-vanilla/net/x25/x25_route.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/x25_route.c	2006-12-31 23:23:17.000000000 +1100
@@ -119,6 +119,9 @@ void x25_route_device_down(struct net_de
 			__x25_remove_route(rt);
 	}
 	write_unlock_bh(&x25_route_list_lock);
+
+	/* Remove any related forwarding */
+	x25_clear_forwards(dev);
 }
 
 /*

