Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCLAGW>; Tue, 11 Mar 2003 19:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCLAGM>; Tue, 11 Mar 2003 19:06:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261697AbTCLAEj>;
	Tue, 11 Mar 2003 19:04:39 -0500
Subject: [PATCH] (7/8) Eliminate brlock from IPV6
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428121.15869.111.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:15:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace brlock in IPV6 with RCU.

diff -urN -X dontdiff linux-2.5.64/net/ipv6/af_inet6.c linux-2.5-nobrlock/net/ipv6/af_inet6.c
--- linux-2.5.64/net/ipv6/af_inet6.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/af_inet6.c	2003-03-10 16:05:21.000000000 -0800
@@ -45,7 +45,6 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/icmpv6.h>
-#include <linux/brlock.h>
 #include <linux/smp_lock.h>
 
 #include <net/ip.h>
@@ -101,6 +100,7 @@
  * build a new socket.
  */
 struct list_head inetsw6[SOCK_MAX];
+static spinlock_t inetsw6_lock = SPIN_LOCK_UNLOCKED;
 
 static void inet6_sock_destruct(struct sock *sk)
 {
@@ -161,8 +161,8 @@
 
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
-	br_read_lock_bh(BR_NETPROTO_LOCK);
-	list_for_each(p, &inetsw6[sock->type]) {
+	rcu_read_lock();
+	list_for_each_rcu(p, &inetsw6[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
 		/* Check the non-wild match. */
@@ -180,7 +180,7 @@
 		}
 		answer = NULL;
 	}
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 
 	if (!answer)
 		goto free_and_badtype;
@@ -571,8 +571,7 @@
 	int protocol = p->protocol;
 	struct list_head *last_perm;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
+	spin_lock_bh(&inetsw6_lock);
 	if (p->type > SOCK_MAX)
 		goto out_illegal;
 
@@ -602,7 +601,7 @@
 	 */
 	list_add(&p->list, last_perm);
 out:
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inetsw6_lock);
 	return;
 
 out_permanent:
diff -urN -X dontdiff linux-2.5.64/net/ipv6/ipv6_sockglue.c linux-2.5-nobrlock/net/ipv6/ipv6_sockglue.c
--- linux-2.5.64/net/ipv6/ipv6_sockglue.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/ipv6_sockglue.c	2003-03-10 13:33:07.000000000 -0800
@@ -54,11 +54,10 @@
 
 static struct packet_type ipv6_packet_type =
 {
-	__constant_htons(ETH_P_IPV6), 
-	NULL,					/* All devices */
-	ipv6_rcv,
-	(void*)1,
-	NULL
+	.type = __constant_htons(ETH_P_IPV6), 
+	.dev = NULL,					/* All devices */
+	.func = ipv6_rcv,
+	.data = (void*)1,
 };
 
 /*
diff -urN -X dontdiff linux-2.5.64/net/ipv6/netfilter/ip6_queue.c linux-2.5-nobrlock/net/ipv6/netfilter/ip6_queue.c
--- linux-2.5.64/net/ipv6/netfilter/ip6_queue.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/netfilter/ip6_queue.c	2003-03-11 15:05:18.000000000 -0800
@@ -26,7 +26,6 @@
 #include <linux/netfilter.h>
 #include <linux/netlink.h>
 #include <linux/spinlock.h>
-#include <linux/brlock.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <net/sock.h>
@@ -688,8 +687,6 @@
 
 cleanup:
 	nf_unregister_queue_handler(PF_INET6);
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	ipq_flush(NF_DROP);
 	
 cleanup_sysctl:
diff -urN -X dontdiff linux-2.5.64/net/ipv6/protocol.c linux-2.5-nobrlock/net/ipv6/protocol.c
--- linux-2.5.64/net/ipv6/protocol.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/protocol.c	2003-03-11 14:37:06.000000000 -0800
@@ -32,7 +32,6 @@
 #include <linux/in6.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
-#include <linux/brlock.h>
 
 #include <net/sock.h>
 #include <net/snmp.h>
@@ -41,21 +40,21 @@
 #include <net/protocol.h>
 
 struct inet6_protocol *inet6_protos[MAX_INET_PROTOS];
+static spinlock_t inet6_proto_lock = SPIN_LOCK_UNLOCKED;
 
 int inet6_add_protocol(struct inet6_protocol *prot, unsigned char protocol)
 {
 	int ret, hash = protocol & (MAX_INET_PROTOS - 1);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 
+	spin_lock_bh(&inet6_proto_lock);
 	if (inet6_protos[hash]) {
 		ret = -1;
 	} else {
 		inet6_protos[hash] = prot;
 		ret = 0;
 	}
-
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inet6_proto_lock);
 
 	return ret;
 }
@@ -68,7 +67,7 @@
 {
 	int ret, hash = protocol & (MAX_INET_PROTOS - 1);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&inet6_proto_lock);
 
 	if (inet6_protos[hash] != prot) {
 		ret = -1;
@@ -76,8 +75,9 @@
 		inet6_protos[hash] = NULL;
 		ret = 0;
 	}
+	spin_unlock_bh(&inet6_proto_lock);
 
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 
 	return ret;
 }



