Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTIXWem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTIXWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:34:42 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:60679 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S261642AbTIXWeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:34:20 -0400
Subject: [PATCH] 2.6.0-test5-bk11 PKT_CAN_SHARE_SKB [3/3] net/*
From: Joe Perches <joe@perches.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David S Miller <davem@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0309241012110.3178-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309241012110.3178-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1064442830.15437.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Sep 2003 15:33:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.6.0-test5/net/8021q/vlan.c shared_skb/net/8021q/vlan.c
-- linux-2.6.0-test5/net/8021q/vlan.c	2003-09-08 12:50:21.000000000 -0700
+++ shared_skb/net/8021q/vlan.c	2003-09-22 13:10:22.000000000 -0700
@@ -67,7 +67,7 @@
 static struct packet_type vlan_packet_type = {
 	.type = __constant_htons(ETH_P_8021Q),
 	.func = vlan_skb_recv, /* VLAN receive method */
-	.data = (void *)1,     /* understands shared skb */
+	.data = PKT_CAN_SHARE_SKB,
 };
 
 /* End of global variables definitions. */
diff -urN linux-2.6.0-test5/net/appletalk/ddp.c shared_skb/net/appletalk/ddp.c
-- linux-2.6.0-test5/net/appletalk/ddp.c	2003-09-08 12:50:43.000000000 -0700
+++ shared_skb/net/appletalk/ddp.c	2003-09-22 13:10:26.000000000 -0700
@@ -1872,13 +1872,13 @@
 struct packet_type ltalk_packet_type = {
 	.type		= __constant_htons(ETH_P_LOCALTALK),
 	.func		= ltalk_rcv,
-	.data		= (void *)1,
+	.data		= PKT_CAN_SHARE_SKB,
 };
 
 struct packet_type ppptalk_packet_type = {
 	.type		= __constant_htons(ETH_P_PPPTALK),
 	.func		= atalk_rcv,
-	.data		= (void *)1,
+	.data		= PKT_CAN_SHARE_SKB,
 };
 
 static unsigned char ddp_snap_id[] = { 0x08, 0x00, 0x07, 0x80, 0x9B };
diff -urN linux-2.6.0-test5/net/ax25/af_ax25.c shared_skb/net/ax25/af_ax25.c
-- linux-2.6.0-test5/net/ax25/af_ax25.c	2003-09-08 12:50:28.000000000 -0700
+++ shared_skb/net/ax25/af_ax25.c	2003-09-22 13:10:30.000000000 -0700
@@ -1978,7 +1978,7 @@
 	.type	=	__constant_htons(ETH_P_AX25),
 	.dev	=	NULL,				/* All devices */
 	.func	=	ax25_kiss_rcv,
-	.data	=	(void *) 1
+	.data	=	PKT_CAN_SHARE_SKB,
 };
 
 static struct notifier_block ax25_dev_notifier = {
diff -urN linux-2.6.0-test5/net/core/dev.c shared_skb/net/core/dev.c
-- linux-2.6.0-test5/net/core/dev.c	2003-09-22 08:04:06.000000000 -0700
+++ shared_skb/net/core/dev.c	2003-09-22 14:02:08.000000000 -0700
@@ -233,7 +233,7 @@
 	spin_lock_bh(&ptype_lock);
 #ifdef CONFIG_NET_FASTROUTE
 	/* Hack to detect packet socket */
-	if (pt->data && (long)(pt->data) != 1) {
+	if (pt->data && pt->data != PKT_CAN_SHARE_SKB) {
 		netdev_fastroute_obstacles++;
 		dev_clear_fastroute(pt->dev);
 	}
@@ -281,7 +281,7 @@
 	list_for_each_entry(pt1, head, list) {
 		if (pt == pt1) {
 #ifdef CONFIG_NET_FASTROUTE
-			if (pt->data)
+			if (pt->data && pt->data != PKT_CAN_SHARE_SKB)
 				netdev_fastroute_obstacles--;
 #endif
 			list_del_rcu(&pt->list);
diff -urN linux-2.6.0-test5/net/decnet/af_decnet.c shared_skb/net/decnet/af_decnet.c
-- linux-2.6.0-test5/net/decnet/af_decnet.c	2003-09-22 08:04:06.000000000 -0700
+++ shared_skb/net/decnet/af_decnet.c	2003-09-22 13:10:24.000000000 -0700
@@ -2081,7 +2081,7 @@
 	.type =		__constant_htons(ETH_P_DNA_RT),
 	.dev =		NULL,		/* All devices */
 	.func =		dn_route_rcv,
-	.data =		(void*)1,
+	.data =		PKT_CAN_SHARE_SKB,
 };
 
 #ifdef CONFIG_PROC_FS
diff -urN linux-2.6.0-test5/net/ipv4/arp.c shared_skb/net/ipv4/arp.c
-- linux-2.6.0-test5/net/ipv4/arp.c	2003-09-22 08:04:06.000000000 -0700
+++ shared_skb/net/ipv4/arp.c	2003-09-22 13:10:36.000000000 -0700
@@ -1108,7 +1108,7 @@
 static struct packet_type arp_packet_type = {
 	.type =	__constant_htons(ETH_P_ARP),
 	.func =	arp_rcv,
-	.data =	(void*) 1, /* understand shared skbs */
+	.data =	PKT_CAN_SHARE_SKB,
 };
 
 static int arp_proc_init(void);
diff -urN linux-2.6.0-test5/net/ipv4/ip_output.c shared_skb/net/ipv4/ip_output.c
-- linux-2.6.0-test5/net/ipv4/ip_output.c	2003-09-08 12:50:40.000000000 -0700
+++ shared_skb/net/ipv4/ip_output.c	2003-09-22 13:10:41.000000000 -0700
@@ -1299,7 +1299,7 @@
 	.type = __constant_htons(ETH_P_IP),
 	.dev  = NULL,	/* All devices */
 	.func = ip_rcv,
-	.data = (void*)1,
+	.data = PKT_CAN_SHARE_SKB,
 };
 
 /*
diff -urN linux-2.6.0-test5/net/ipv6/ipv6_sockglue.c shared_skb/net/ipv6/ipv6_sockglue.c
-- linux-2.6.0-test5/net/ipv6/ipv6_sockglue.c	2003-09-08 12:49:52.000000000 -0700
+++ shared_skb/net/ipv6/ipv6_sockglue.c	2003-09-22 13:10:28.000000000 -0700
@@ -62,7 +62,7 @@
 	.type = __constant_htons(ETH_P_IPV6), 
 	.dev  = NULL,				/* All devices */
 	.func = ipv6_rcv,
-	.data = (void*)1,
+	.data = PKT_CAN_SHARE_SKB,
 };
 
 /*
diff -urN linux-2.6.0-test5/net/ipx/af_ipx.c shared_skb/net/ipx/af_ipx.c
-- linux-2.6.0-test5/net/ipx/af_ipx.c	2003-09-08 12:49:54.000000000 -0700
+++ shared_skb/net/ipx/af_ipx.c	2003-09-22 14:01:56.000000000 -0700
@@ -1920,13 +1920,13 @@
 static struct packet_type ipx_8023_packet_type = {
 	.type		= __constant_htons(ETH_P_802_3),
 	.func		= ipx_rcv,
-	.data		= (void *)1,	/* yap, I understand shared skbs :-) */
+	.data		= PKT_CAN_SHARE_SKB,
 };
 
 static struct packet_type ipx_dix_packet_type = {
 	.type		= __constant_htons(ETH_P_IPX),
 	.func		= ipx_rcv,
-	.data		= (void *)1,	/* yap, I understand shared skbs :-) */
+	.data		= PKT_CAN_SHARE_SKB,
 };
 
 static struct notifier_block ipx_dev_notifier = {
diff -urN linux-2.6.0-test5/net/irda/irsyms.c shared_skb/net/irda/irsyms.c
-- linux-2.6.0-test5/net/irda/irsyms.c	2003-09-08 12:50:28.000000000 -0700
+++ shared_skb/net/irda/irsyms.c	2003-09-22 13:10:38.000000000 -0700
@@ -191,7 +191,7 @@
 	.type	= __constant_htons(ETH_P_IRDA),
 	.dev	= NULL,			/* Wildcard : All devices */
 	.func	= irlap_driver_rcv,	/* Packet type handler irlap_frame.c */
-	.data	= (void*) 1,		/* Understand shared skbs */
+	.data	= PKT_CAN_SHARE_SKB,
 	//.next	= NULL,
 };
 
diff -urN linux-2.6.0-test5/net/llc/llc_core.c shared_skb/net/llc/llc_core.c
-- linux-2.6.0-test5/net/llc/llc_core.c	2003-09-22 08:04:08.000000000 -0700
+++ shared_skb/net/llc/llc_core.c	2003-09-22 13:10:33.000000000 -0700
@@ -140,13 +140,13 @@
 static struct packet_type llc_packet_type = {
 	.type = __constant_htons(ETH_P_802_2),
 	.func = llc_rcv,
-	.data = (void *)1,
+	.data = PKT_CAN_SHARE_SKB,
 };
 
 static struct packet_type llc_tr_packet_type = {
 	.type = __constant_htons(ETH_P_TR_802_2),
 	.func = llc_rcv,
-	.data = (void *)1,
+	.data = PKT_CAN_SHARE_SKB,
 };
 
 static int __init llc_init(void)

