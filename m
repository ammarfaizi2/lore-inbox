Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWHPMqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWHPMqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWHPMqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:46:53 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:5111 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1751150AbWHPMqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:46:51 -0400
From: gerrit@erg.abdn.ac.uk
To: YOSHIFUJI Hideaki /
	 =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port code
Date: Wed, 16 Aug 2006 13:46:33 +0100
User-Agent: KMail/1.8.3
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <200608160846.48174@strip-the-willow> <20060816.175144.75075807.yoshfuji@linux-ipv6.org>
In-Reply-To: <20060816.175144.75075807.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161346.34195@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshifuji, 

|  > +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
|  > +				else if(sk->sk_family == PF_INET6     &&
|  > +					ipv6_rcv_saddr_equal(sk, sk2)     )
|  > +					goto fail;
|  > +			}
|  > +#endif
|  
|  This is not good because you cannot link ipv6_rcv_saddr_equal()
|  if you are compiling IPv6 as module.
Yes and the second ugliness was that ipv4/udp.c suddenly had to include <net/addrconf.h>. 

|  How about retaining udp_v{4,6}_get_port() and call
|  common udp_get_port() from both functions?
I enclose a realisation below - do you think that is better? 
Tested both IPv6 as module and as `y', double-checked all changes. 
Thank you for reviewing and comments.

Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
---

 include/net/udp.h |   18 +---------
 net/ipv4/udp.c    |   95 ++++++++++++++++++++++++++++++++++--------------------
 net/ipv6/udp.c    |   76 +------------------------------------------
 3 files changed, 64 insertions(+), 125 deletions(-)


diff --git a/include/net/udp.h b/include/net/udp.h
index 766fba1..c490a0f 100644
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
@@ -63,6 +47,8 @@ extern struct proto udp_prot;
 
 struct sk_buff;
 
+extern int	udp_get_port(struct sock *sk, unsigned short snum,
+			     int (*saddr_cmp)(struct sock *, struct sock *));
 extern void	udp_err(struct sk_buff *, u32);
 
 extern int	udp_sendmsg(struct kiocb *iocb, struct sock *sk,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3f93292..c5ee645 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -119,14 +119,34 @@ DEFINE_SNMP_STAT(struct udp_mib, udp_sta
 struct hlist_head udp_hash[UDP_HTABLE_SIZE];
 DEFINE_RWLOCK(udp_hash_lock);
 
-/* Shared by v4/v6 udp. */
+/* Shared by v4/v6 udp_get_port */
 int udp_port_rover;
 
-static int udp_v4_get_port(struct sock *sk, unsigned short snum)
+static inline int udp_lport_inuse(u16 num)
 {
+	struct sock *sk;
 	struct hlist_node *node;
+
+	sk_for_each(sk, node, &udp_hash[num & (UDP_HTABLE_SIZE - 1)])
+		if (inet_sk(sk)->num == num)
+			return 1;
+	return 0;
+}
+
+/**
+ *  udp_get_port  -  common port lookup for IPv4 and IPv6
+ *
+ *  @sk:          socket struct in question
+ *  @snum:        port number to look up
+ *  @saddr_comp:  AF-dependent comparison of bound local IP addresses
+ */
+int udp_get_port(struct sock *sk, unsigned short snum,
+		 int (*saddr_cmp)(struct sock *sk1, struct sock *sk2))
+{
+	struct hlist_node *node;
+	struct hlist_head *head;
 	struct sock *sk2;
-	struct inet_sock *inet = inet_sk(sk);
+	int    error = 1;
 
 	write_lock_bh(&udp_hash_lock);
 	if (snum == 0) {
@@ -138,11 +158,10 @@ static int udp_v4_get_port(struct sock *
 		best_size_so_far = 32767;
 		best = result = udp_port_rover;
 		for (i = 0; i < UDP_HTABLE_SIZE; i++, result++) {
-			struct hlist_head *list;
 			int size;
 
-			list = &udp_hash[result & (UDP_HTABLE_SIZE - 1)];
-			if (hlist_empty(list)) {
+			head = &udp_hash[result & (UDP_HTABLE_SIZE - 1)];
+			if (hlist_empty(head)) {
 				if (result > sysctl_local_port_range[1])
 					result = sysctl_local_port_range[0] +
 						((result - sysctl_local_port_range[0]) &
@@ -150,12 +169,11 @@ static int udp_v4_get_port(struct sock *
 				goto gotit;
 			}
 			size = 0;
-			sk_for_each(sk2, node, list)
-				if (++size >= best_size_so_far)
-					goto next;
-			best_size_so_far = size;
-			best = result;
-		next:;
+			sk_for_each(sk2, node, head)
+				if (++size < best_size_so_far) {
+					best_size_so_far = size;
+					best = result;
+				}
 		}
 		result = best;
 		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {
@@ -171,38 +189,44 @@ static int udp_v4_get_port(struct sock *
 gotit:
 		udp_port_rover = snum = result;
 	} else {
-		sk_for_each(sk2, node,
-			    &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]) {
-			struct inet_sock *inet2 = inet_sk(sk2);
-
-			if (inet2->num == snum &&
-			    sk2 != sk &&
-			    !ipv6_only_sock(sk2) &&
-			    (!sk2->sk_bound_dev_if ||
-			     !sk->sk_bound_dev_if ||
-			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
-			    (!inet2->rcv_saddr ||
-			     !inet->rcv_saddr ||
-			     inet2->rcv_saddr == inet->rcv_saddr) &&
-			    (!sk2->sk_reuse || !sk->sk_reuse))
+		head = &udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
+
+		sk_for_each(sk2, node, head)
+			if (inet_sk(sk2)->num == snum                        &&
+			    sk2 != sk                                        &&
+			    (!sk2->sk_reuse        || !sk->sk_reuse)         &&
+			    (!sk2->sk_bound_dev_if || !sk->sk_bound_dev_if
+			     || sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
+			    (*saddr_cmp)(sk, sk2)                              )
 				goto fail;
-		}
 	}
-	inet->num = snum;
+	inet_sk(sk)->num = snum;
 	if (sk_unhashed(sk)) {
-		struct hlist_head *h = &udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
-
-		sk_add_node(sk, h);
+		head = &udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
+		sk_add_node(sk, head);
 		sock_prot_inc_use(sk->sk_prot);
 	}
-	write_unlock_bh(&udp_hash_lock);
-	return 0;
-
+	error = 0;
 fail:
 	write_unlock_bh(&udp_hash_lock);
-	return 1;
+	return error;
+}
+
+static inline int  ipv4_rcv_saddr_equal(struct sock *sk1, struct sock *sk2)
+{
+	struct inet_sock *inet1 = inet_sk(sk1), *inet2 = inet_sk(sk2);
+
+	return 	( !ipv6_only_sock(sk2)  &&
+		  (!inet1->rcv_saddr || !inet2->rcv_saddr ||
+		   inet1->rcv_saddr == inet2->rcv_saddr      ));
+}
+
+static inline int udp_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	return udp_get_port(sk, snum, ipv4_rcv_saddr_equal);
 }
 
+
 static void udp_v4_hash(struct sock *sk)
 {
 	BUG();
@@ -1584,6 +1608,7 @@ EXPORT_SYMBOL(udp_hash);
 EXPORT_SYMBOL(udp_hash_lock);
 EXPORT_SYMBOL(udp_ioctl);
 EXPORT_SYMBOL(udp_port_rover);
+EXPORT_SYMBOL(udp_get_port);
 EXPORT_SYMBOL(udp_prot);
 EXPORT_SYMBOL(udp_sendmsg);
 EXPORT_SYMBOL(udp_poll);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8d3432a..74fd59a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -62,81 +62,9 @@ #include <linux/seq_file.h>
 
 DEFINE_SNMP_STAT(struct udp_mib, udp_stats_in6) __read_mostly;
 
-/* Grrr, addr_type already calculated by caller, but I don't want
- * to add some silly "cookie" argument to this method just for that.
- */
-static int udp_v6_get_port(struct sock *sk, unsigned short snum)
+static inline int udp_v6_get_port(struct sock *sk, unsigned short snum)
 {
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
+	return udp_get_port(sk, snum, ipv6_rcv_saddr_equal);
 }
 
 static void udp_v6_hash(struct sock *sk)
