Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbTCMWbo>; Thu, 13 Mar 2003 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTCMWa6>; Thu, 13 Mar 2003 17:30:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262573AbTCMW3f>;
	Thu, 13 Mar 2003 17:29:35 -0500
Subject: [PATCH] (4/5) Brlock removal from ipv4/ipv6
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595219.3141.106.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:40:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPV4 and IPV6 changes to remove use of brlock.

Change from earlier version of the patch is to use barrier() to avoid
possible compiler test/usage race.


diff -urN -X dontdiff linux-2.5.64/net/ipv4/af_inet.c linux-2.5-nobrlock/net/ipv4/af_inet.c
--- linux-2.5.64/net/ipv4/af_inet.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/af_inet.c	2003-03-12 14:52:50.000000000 -0800
@@ -94,7 +94,6 @@
 #include <linux/inet.h>
 #include <linux/igmp.h>
 #include <linux/netdevice.h>
-#include <linux/brlock.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/arp.h>
@@ -130,6 +129,7 @@
  * build a new socket.
  */
 struct list_head inetsw[SOCK_MAX];
+static spinlock_t inetsw_lock = SPIN_LOCK_UNLOCKED;
 
 /* New destruction routine */
 
@@ -337,8 +337,8 @@
 
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
-	br_read_lock_bh(BR_NETPROTO_LOCK);
-	list_for_each(p, &inetsw[sock->type]) {
+	rcu_read_lock();
+	list_for_each_rcu(p, &inetsw[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
 		/* Check the non-wild match. */
@@ -356,7 +356,7 @@
 		}
 		answer = NULL;
 	}
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 
 	err = -ESOCKTNOSUPPORT;
 	if (!answer)
@@ -978,7 +978,7 @@
 	int protocol = p->protocol;
 	struct list_head *last_perm;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&inetsw_lock);
 
 	if (p->type > SOCK_MAX)
 		goto out_illegal;
@@ -1007,9 +1007,9 @@
 	 * non-permanent entry.  This means that when we remove this entry, the 
 	 * system automatically returns to the old behavior.
 	 */
-	list_add(&p->list, last_perm);
+	list_add_rcu(&p->list, last_perm);
 out:
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inetsw_lock);
 	return;
 
 out_permanent:
@@ -1031,9 +1031,11 @@
 		       "Attempt to unregister permanent protocol %d.\n",
 		       p->protocol);
 	} else {
-		br_write_lock_bh(BR_NETPROTO_LOCK);
-		list_del(&p->list);
-		br_write_unlock_bh(BR_NETPROTO_LOCK);
+		spin_lock_bh(&inetsw_lock);
+		list_del_rcu(&p->list);
+		spin_unlock_bh(&inetsw_lock);
+
+		synchronize_kernel();
 	}
 }
 
diff -urN -X dontdiff linux-2.5.64/net/ipv4/icmp.c linux-2.5-nobrlock/net/ipv4/icmp.c
--- linux-2.5.64/net/ipv4/icmp.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/icmp.c	2003-03-13 11:52:50.000000000 -0800
@@ -702,6 +702,7 @@
 	 */
 
 	ipprot = inet_protos[hash];
+	barrier();
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, info);
 
diff -urN -X dontdiff linux-2.5.64/net/ipv4/ip_input.c linux-2.5-nobrlock/net/ipv4/ip_input.c
--- linux-2.5.64/net/ipv4/ip_input.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/ip_input.c	2003-03-13 11:54:32.000000000 -0800
@@ -232,7 +232,9 @@
 		if (raw_sk)
 			raw_v4_input(skb, skb->nh.iph, hash);
 
-		if ((ipprot = inet_protos[hash]) != NULL) {
+		ipprot = inet_protos[hash];
+		barrier();/* prevent RCU compiler optimization problems */
+		if (ipprot) {
 			int ret;
 
 			if (!ipprot->no_policy &&
diff -urN -X dontdiff linux-2.5.64/net/ipv4/ip_output.c linux-2.5-nobrlock/net/ipv4/ip_output.c
--- linux-2.5.64/net/ipv4/ip_output.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/ip_output.c	2003-03-12 14:52:51.000000000 -0800
@@ -1261,11 +1261,10 @@
 
 static struct packet_type ip_packet_type =
 {
-	__constant_htons(ETH_P_IP),
-	NULL,	/* All devices */
-	ip_rcv,
-	(void*)1,
-	NULL,
+	.type = __constant_htons(ETH_P_IP),
+	.dev = NULL,	/* All devices */
+	.func = ip_rcv,
+	.data = (void*)1,
 };
 
 /*
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_conntrack_core.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5.64/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-12 14:52:47.000000000 -0800
@@ -24,7 +24,6 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
@@ -1160,8 +1159,7 @@
 	WRITE_UNLOCK(&ip_conntrack_lock);
 
 	/* Someone could be still looking at the helper in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 }
 
 /* Refresh conntrack for this many jiffies. */
@@ -1402,8 +1400,7 @@
 	/* This makes sure all current packets have passed through
            netfilter framework.  Roll on, two-stage module
            delete... */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
  
  i_see_dead_people:
 	ip_ct_selective_cleanup(kill_all, NULL);
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_conntrack_standalone.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux-2.5.64/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-03-12 14:52:47.000000000 -0800
@@ -15,7 +15,6 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_conntrack_lock)
@@ -325,8 +324,7 @@
 	WRITE_UNLOCK(&ip_conntrack_lock);
 	
 	/* Somebody could be still looking at the proto in bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 
 	/* Remove all contrack entries for this protocol */
 	ip_ct_selective_cleanup(kill_proto, &proto->proto);
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_nat_core.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.5.64/net/ipv4/netfilter/ip_nat_core.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_core.c	2003-03-12 14:52:47.000000000 -0800
@@ -8,7 +8,6 @@
 #include <linux/timer.h>
 #include <linux/skbuff.h>
 #include <linux/netfilter_ipv4.h>
-#include <linux/brlock.h>
 #include <linux/vmalloc.h>
 #include <net/checksum.h>
 #include <net/icmp.h>
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_nat_helper.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_helper.c
--- linux-2.5.64/net/ipv4/netfilter/ip_nat_helper.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_helper.c	2003-03-12 14:52:47.000000000 -0800
@@ -20,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/skbuff.h>
 #include <linux/netfilter_ipv4.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 #include <net/icmp.h>
 #include <net/ip.h>
@@ -545,8 +544,7 @@
 	WRITE_UNLOCK(&ip_nat_lock);
 
 	/* Someone could be still looking at the helper in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 
 	/* Find anything using it, and umm, kill them.  We can't turn
 	   them into normal connections: if we've adjusted SYNs, then
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_nat_snmp_basic.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_snmp_basic.c
--- linux-2.5.64/net/ipv4/netfilter/ip_nat_snmp_basic.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_snmp_basic.c	2003-03-12 14:52:47.000000000 -0800
@@ -50,7 +50,6 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_nat.h>
 #include <linux/netfilter_ipv4/ip_nat_helper.h>
-#include <linux/brlock.h>
 #include <linux/types.h>
 #include <linux/ip.h>
 #include <net/udp.h>
@@ -1351,8 +1350,6 @@
 {
 	ip_nat_helper_unregister(&snmp);
 	ip_nat_helper_unregister(&snmp_trap);
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 }
 
 module_init(init);
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_nat_standalone.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_standalone.c
--- linux-2.5.64/net/ipv4/netfilter/ip_nat_standalone.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_standalone.c	2003-03-12 14:52:47.000000000 -0800
@@ -24,7 +24,6 @@
 #include <net/checksum.h>
 #include <linux/spinlock.h>
 #include <linux/version.h>
-#include <linux/brlock.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_nat_lock)
 #define ASSERT_WRITE_LOCK(x) MUST_BE_WRITE_LOCKED(&ip_nat_lock)
@@ -268,8 +267,7 @@
 	WRITE_UNLOCK(&ip_nat_lock);
 
 	/* Someone could be still looking at the proto in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 }
 
 static int init_or_cleanup(int init)
diff -urN -X dontdiff linux-2.5.64/net/ipv4/netfilter/ip_queue.c linux-2.5-nobrlock/net/ipv4/netfilter/ip_queue.c
--- linux-2.5.64/net/ipv4/netfilter/ip_queue.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_queue.c	2003-03-12 14:52:47.000000000 -0800
@@ -23,7 +23,6 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netlink.h>
 #include <linux/spinlock.h>
-#include <linux/brlock.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
@@ -685,8 +684,7 @@
 
 cleanup:
 	nf_unregister_queue_handler(PF_INET);
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+
 	ipq_flush(NF_DROP);
 	
 cleanup_sysctl:
diff -urN -X dontdiff linux-2.5.64/net/ipv4/protocol.c linux-2.5-nobrlock/net/ipv4/protocol.c
--- linux-2.5.64/net/ipv4/protocol.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/protocol.c	2003-03-12 14:52:50.000000000 -0800
@@ -37,7 +37,6 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/timer.h>
-#include <linux/brlock.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
@@ -49,6 +48,7 @@
 #include <linux/igmp.h>
 
 struct inet_protocol *inet_protos[MAX_INET_PROTOS];
+static spinlock_t inet_proto_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  *	Add a protocol handler to the hash tables
@@ -60,16 +60,14 @@
 
 	hash = protocol & (MAX_INET_PROTOS - 1);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
+	spin_lock_bh(&inet_proto_lock);
 	if (inet_protos[hash]) {
 		ret = -1;
 	} else {
 		inet_protos[hash] = prot;
 		ret = 0;
 	}
-
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inet_proto_lock);
 
 	return ret;
 }
@@ -84,16 +82,15 @@
 
 	hash = protocol & (MAX_INET_PROTOS - 1);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
+	spin_lock_bh(&inet_proto_lock);
 	if (inet_protos[hash] == prot) {
 		inet_protos[hash] = NULL;
 		ret = 0;
 	} else {
 		ret = -1;
 	}
-
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inet_proto_lock);
+	synchronize_kernel();
 
 	return ret;
 }
diff -urN -X dontdiff linux-2.5.64/net/ipv6/af_inet6.c linux-2.5-nobrlock/net/ipv6/af_inet6.c
--- linux-2.5.64/net/ipv6/af_inet6.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/af_inet6.c	2003-03-12 14:52:53.000000000 -0800
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
 
@@ -600,9 +599,9 @@
 	 * non-permanent entry.  This means that when we remove this entry, the 
 	 * system automatically returns to the old behavior.
 	 */
-	list_add(&p->list, last_perm);
+	list_add_rcu(&p->list, last_perm);
 out:
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&inetsw6_lock);
 	return;
 
 out_permanent:
diff -urN -X dontdiff linux-2.5.64/net/ipv6/icmp.c linux-2.5-nobrlock/net/ipv6/icmp.c
--- linux-2.5.64/net/ipv6/icmp.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/icmp.c	2003-03-13 11:56:00.000000000 -0800
@@ -441,6 +441,7 @@
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
 
 	ipprot = inet6_protos[hash];
+	barrier();/* prevent RCU compiler optimization problems */
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, NULL, type, code, inner_offset, info);
 
diff -urN -X dontdiff linux-2.5.64/net/ipv6/ip6_input.c linux-2.5-nobrlock/net/ipv6/ip6_input.c
--- linux-2.5.64/net/ipv6/ip6_input.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/ip6_input.c	2003-03-13 11:55:03.000000000 -0800
@@ -171,7 +171,9 @@
 		ipv6_raw_deliver(skb, nexthdr);
 
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
-	if ((ipprot = inet6_protos[hash]) != NULL) {
+	ipprot = inet6_protos[hash];
+	barrier();/* prevent RCU compiler optimization problems */
+	if (ipprot) {
 		int ret = ipprot->handler(skb);
 		if (ret < 0) {
 			nexthdr = -ret;
diff -urN -X dontdiff linux-2.5.64/net/ipv6/ipv6_sockglue.c linux-2.5-nobrlock/net/ipv6/ipv6_sockglue.c
--- linux-2.5.64/net/ipv6/ipv6_sockglue.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv6/ipv6_sockglue.c	2003-03-12 14:52:54.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv6/netfilter/ip6_queue.c	2003-03-12 14:52:52.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv6/protocol.c	2003-03-12 14:52:54.000000000 -0800
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



