Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHPHrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHPHrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWHPHrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:47:07 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:48593 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1750984AbWHPHrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:47:06 -0400
From: gerrit@erg.abdn.ac.uk
To: netdev@vger.kernel.org
Subject: [PATCH 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port code
Date: Wed, 16 Aug 2006 08:46:48 +0100
User-Agent: KMail/1.8.3
Cc: davem@davemloft.net, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608160846.48174@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UDPv4 and UDPv6 use an almost identical version of the get_port function,
which is unnecessary since the (long) code differs in only one if-statement.

By disentangling the if statement and adding v4/v6 checks appropriately, this
code duplication can be removed and further
   * udp_port_rover can stay in net/ipv4/udp.c
   * udp_lport_inuse can become static in net/ipv4/udp.c (only called by
     udp_get_port

The text below discusses the re-arrangement of the if-statement. This is implemented
by enclosed patch (works both on stable and Torvalds' release). The patch also dispenses 
with a goto statement whose jump label is referenced only once.

                  D i s c u s s i o n

The following compares the statements for udp_v{4,6}_get_port. 
    
A) In udp_v4_get_port():
=========================
if (inet2->num == snum                                 && 
    sk2 != sk                                          && 
    !ipv6_only_sock(sk2)                               &&
    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if 
     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if)   && 
    (!inet2->rcv_saddr || !inet->rcv_saddr 
     || inet2->rcv_saddr == inet->rcv_saddr)           && 
    (!sk2->sk_reuse || !sk->sk_reuse)                     )
  goto fail;

This function is called from IPv4 context, hence sk->sk_family == PF_INET.
   
  
B) In udp_v6_get_port():
=========================
if (inet_sk(sk2)->num == snum                           &&
    sk2 != sk                                           &&
    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if
     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if)    && 
    (!sk2->sk_reuse || !sk->sk_reuse)                   && 
    ipv6_rcv_saddr_equal(sk, sk2)                          )
  goto fail;

This function is called from IPv6 context, hence sk->sk_family == PF_INET6.

Common denominator: 
===================
By re-ordering some of the last literals, both functions share the following
conjunction of conditions:

if (inet_sk(sk2)->num == snum  && sk2 != sk             &&
    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if 
     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if)    && 
    (!sk2->sk_reuse || !sk->sk_reuse)                      ) 

To make the function applicable to both v4 and v6 contexts, a second if statement
is added, which branches according to sk's sk_family. 


Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
---

 include/net/udp.h |   17 +----------
 net/ipv4/udp.c    |   57 ++++++++++++++++++++++++--------------
 net/ipv6/udp.c    |   79 +----------------------------------------------------
 3 files changed, 38 insertions(+), 115 deletions(-)


diff --git a/include/net/udp.h b/include/net/udp.h
index 766fba1..69d4288 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -30,25 +30,9 @@ #include <linux/seq_file.h>
 
 #define UDP_HTABLE_SIZE		128
 
-/* udp.c: This needs to be shared by v4 and v6 because the lookup
- *        and hashing code needs to work with different AF's yet
- *        the port space is shared.
- */
 extern struct hlist_head udp_hash[UDP_HTABLE_SIZE];
 extern rwlock_t udp_hash_lock;
 
-extern int udp_port_rover;
-
-static inline int udp_lport_inuse(u16 num)
-{
-	struct sock *sk;
-	struct hlist_node *node;
-
-	sk_for_each(sk, node, &udp_hash[num & (UDP_HTABLE_SIZE - 1)])
-		if (inet_sk(sk)->num == num)
-			return 1;
-	return 0;
-}
 
 /* Note: this must match 'valbool' in sock_setsockopt */
 #define UDP_CSUM_NOXMIT		1
@@ -63,6 +47,7 @@ extern struct proto udp_prot;
 
 struct sk_buff;
 
+extern int	udp_get_port(struct sock *sk, unsigned short snum);
 extern void	udp_err(struct sk_buff *, u32);
 
 extern int	udp_sendmsg(struct kiocb *iocb, struct sock *sk,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3f93292..eb3aa82 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -102,6 +102,7 @@ #include <net/protocol.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <net/addrconf.h>
 #include <net/sock.h>
 #include <net/udp.h>
 #include <net/icmp.h>
@@ -119,10 +120,20 @@ DEFINE_SNMP_STAT(struct udp_mib, udp_sta
 struct hlist_head udp_hash[UDP_HTABLE_SIZE];
 DEFINE_RWLOCK(udp_hash_lock);
 
-/* Shared by v4/v6 udp. */
 int udp_port_rover;
 
-static int udp_v4_get_port(struct sock *sk, unsigned short snum)
+static inline int udp_lport_inuse(u16 num)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+
+	sk_for_each(sk, node, &udp_hash[num & (UDP_HTABLE_SIZE - 1)])
+		if (inet_sk(sk)->num == num)
+			return 1;
+	return 0;
+}
+
+int udp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct hlist_node *node;
 	struct sock *sk2;
@@ -151,11 +162,10 @@ static int udp_v4_get_port(struct sock *
 			}
 			size = 0;
 			sk_for_each(sk2, node, list)
-				if (++size >= best_size_so_far)
-					goto next;
-			best_size_so_far = size;
-			best = result;
-		next:;
+				if (++size < best_size_so_far) {
+					best_size_so_far = size;
+					best = result;
+				}
 		}
 		result = best;
 		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {
@@ -175,24 +185,29 @@ gotit:
 			    &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]) {
 			struct inet_sock *inet2 = inet_sk(sk2);
 
-			if (inet2->num == snum &&
-			    sk2 != sk &&
-			    !ipv6_only_sock(sk2) &&
+			if (inet2->num == snum                 &&
+			    sk2 != sk                          &&
+			    (!sk2->sk_reuse || !sk->sk_reuse)  &&
 			    (!sk2->sk_bound_dev_if ||
-			     !sk->sk_bound_dev_if ||
-			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
-			    (!inet2->rcv_saddr ||
-			     !inet->rcv_saddr ||
-			     inet2->rcv_saddr == inet->rcv_saddr) &&
-			    (!sk2->sk_reuse || !sk->sk_reuse))
-				goto fail;
+			     !sk->sk_bound_dev_if  ||
+			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) ) {
+				if (sk->sk_family == PF_INET          &&
+				    !ipv6_only_sock(sk2)              &&
+				    (!inet2->rcv_saddr ||
+				     !inet->rcv_saddr  ||
+				     inet2->rcv_saddr == inet->rcv_saddr) )
+					goto fail;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+				else if(sk->sk_family == PF_INET6     &&
+					ipv6_rcv_saddr_equal(sk, sk2)     )
+					goto fail;
+			}
+#endif
 		}
 	}
 	inet->num = snum;
 	if (sk_unhashed(sk)) {
-		struct hlist_head *h = &udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
-
-		sk_add_node(sk, h);
+		sk_add_node(sk, &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]);
 		sock_prot_inc_use(sk->sk_prot);
 	}
 	write_unlock_bh(&udp_hash_lock);
@@ -1385,7 +1400,7 @@ struct proto udp_prot = {
 	.backlog_rcv	   = udp_queue_rcv_skb,
 	.hash		   = udp_v4_hash,
 	.unhash		   = udp_v4_unhash,
-	.get_port	   = udp_v4_get_port,
+	.get_port	   = udp_get_port,
 	.obj_size	   = sizeof(struct udp_sock),
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt = compat_udp_setsockopt,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8d3432a..0d8b739 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -62,83 +62,6 @@ #include <linux/seq_file.h>
 
 DEFINE_SNMP_STAT(struct udp_mib, udp_stats_in6) __read_mostly;
 
-/* Grrr, addr_type already calculated by caller, but I don't want
- * to add some silly "cookie" argument to this method just for that.
- */
-static int udp_v6_get_port(struct sock *sk, unsigned short snum)
-{
-	struct sock *sk2;
-	struct hlist_node *node;
-
-	write_lock_bh(&udp_hash_lock);
-	if (snum == 0) {
-		int best_size_so_far, best, result, i;
-
-		if (udp_port_rover > sysctl_local_port_range[1] ||
-		    udp_port_rover < sysctl_local_port_range[0])
-			udp_port_rover = sysctl_local_port_range[0];
-		best_size_so_far = 32767;
-		best = result = udp_port_rover;
-		for (i = 0; i < UDP_HTABLE_SIZE; i++, result++) {
-			int size;
-			struct hlist_head *list;
-
-			list = &udp_hash[result & (UDP_HTABLE_SIZE - 1)];
-			if (hlist_empty(list)) {
-				if (result > sysctl_local_port_range[1])
-					result = sysctl_local_port_range[0] +
-						((result - sysctl_local_port_range[0]) &
-						 (UDP_HTABLE_SIZE - 1));
-				goto gotit;
-			}
-			size = 0;
-			sk_for_each(sk2, node, list)
-				if (++size >= best_size_so_far)
-					goto next;
-			best_size_so_far = size;
-			best = result;
-		next:;
-		}
-		result = best;
-		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {
-			if (result > sysctl_local_port_range[1])
-				result = sysctl_local_port_range[0]
-					+ ((result - sysctl_local_port_range[0]) &
-					   (UDP_HTABLE_SIZE - 1));
-			if (!udp_lport_inuse(result))
-				break;
-		}
-		if (i >= (1 << 16) / UDP_HTABLE_SIZE)
-			goto fail;
-gotit:
-		udp_port_rover = snum = result;
-	} else {
-		sk_for_each(sk2, node,
-			    &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]) {
-			if (inet_sk(sk2)->num == snum &&
-			    sk2 != sk &&
-			    (!sk2->sk_bound_dev_if ||
-			     !sk->sk_bound_dev_if ||
-			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
-			    (!sk2->sk_reuse || !sk->sk_reuse) &&
-			    ipv6_rcv_saddr_equal(sk, sk2))
-				goto fail;
-		}
-	}
-
-	inet_sk(sk)->num = snum;
-	if (sk_unhashed(sk)) {
-		sk_add_node(sk, &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]);
-		sock_prot_inc_use(sk->sk_prot);
-	}
-	write_unlock_bh(&udp_hash_lock);
-	return 0;
-
-fail:
-	write_unlock_bh(&udp_hash_lock);
-	return 1;
-}
-
 static void udp_v6_hash(struct sock *sk)
 {
 	BUG();
@@ -1083,7 +1006,7 @@ struct proto udpv6_prot = {
 	.backlog_rcv	   = udpv6_queue_rcv_skb,
 	.hash		   = udp_v6_hash,
 	.unhash		   = udp_v6_unhash,
-	.get_port	   = udp_v6_get_port,
+	.get_port	   = udp_get_port,
 	.obj_size	   = sizeof(struct udp6_sock),
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt = compat_udpv6_setsockopt,
