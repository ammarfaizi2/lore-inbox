Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbTCLAGu>; Tue, 11 Mar 2003 19:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCLAGq>; Tue, 11 Mar 2003 19:06:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261696AbTCLAEc>;
	Tue, 11 Mar 2003 19:04:32 -0500
Subject: [PATCH] (6/8) Eliminate brlock from ipv4
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428113.15875.107.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:15:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace brlock in IPV4 with RCU

diff -urN -X dontdiff linux-2.5.64/net/ipv4/af_inet.c linux-2.5-nobrlock/net/ipv4/af_inet.c
--- linux-2.5.64/net/ipv4/af_inet.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/af_inet.c	2003-03-10 16:03:13.000000000 -0800
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
+		spin_lock_bh(&inetsw_lock);
 		list_del(&p->list);
-		br_write_unlock_bh(BR_NETPROTO_LOCK);
+		spin_unlock_bh(&inetsw_lock);
+
+		synchronize_kernel();
 	}
 }
 
diff -urN -X dontdiff linux-2.5.64/net/ipv4/ip_output.c linux-2.5-nobrlock/net/ipv4/ip_output.c
--- linux-2.5.64/net/ipv4/ip_output.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/ipv4/ip_output.c	2003-03-10 13:33:07.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-11 14:36:31.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-03-11 14:41:17.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_core.c	2003-03-11 14:37:51.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_helper.c	2003-03-11 14:38:23.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_snmp_basic.c	2003-03-11 15:03:15.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_nat_standalone.c	2003-03-11 15:05:05.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/netfilter/ip_queue.c	2003-03-11 14:40:45.000000000 -0800
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
+++ linux-2.5-nobrlock/net/ipv4/protocol.c	2003-03-11 14:42:32.000000000 -0800
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



