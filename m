Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWDJFeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWDJFeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWDJFef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:34:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15235 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750983AbWDJFef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:34:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: David Miller <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] deinline few large functions in inet6 code
Date: Mon, 10 Apr 2006 08:33:36 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x4eOEvNBfsf5JAC"
Message-Id: <200604100833.37016.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_x4eOEvNBfsf5JAC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Deinline a few functions which produce 200+ bytes of code.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_x4eOEvNBfsf5JAC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.16.inet6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.inet6.patch"

Size  Uses Wasted Name and definition
===== ==== ====== ================================================
  429    3    818 __inet6_lookup        include/net/inet6_hashtables.h
  404    2    384 __inet6_lookup_established    include/net/inet6_hashtables.h
  206    3    372 __inet6_hash  include/net/inet6_hashtables.h

diff -urpN linux-2.6.16.org/include/net/inet6_hashtables.h linux-2.6.16.inet6/include/net/inet6_hashtables.h
--- linux-2.6.16.org/include/net/inet6_hashtables.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.inet6/include/net/inet6_hashtables.h	Sun Apr  9 01:33:39 2006
@@ -48,31 +48,7 @@ static inline int inet6_sk_ehashfn(const
 	return inet6_ehashfn(laddr, lport, faddr, fport);
 }
 
-static inline void __inet6_hash(struct inet_hashinfo *hashinfo,
-				struct sock *sk)
-{
-	struct hlist_head *list;
-	rwlock_t *lock;
-
-	BUG_TRAP(sk_unhashed(sk));
-
-	if (sk->sk_state == TCP_LISTEN) {
-		list = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
-		lock = &hashinfo->lhash_lock;
-		inet_listen_wlock(hashinfo);
-	} else {
-		unsigned int hash;
-		sk->sk_hash = hash = inet6_sk_ehashfn(sk);
-		hash &= (hashinfo->ehash_size - 1);
-		list = &hashinfo->ehash[hash].chain;
-		lock = &hashinfo->ehash[hash].lock;
-		write_lock(lock);
-	}
-
-	__sk_add_node(sk, list);
-	sock_prot_inc_use(sk->sk_prot);
-	write_unlock(lock);
-}
+extern void __inet6_hash(struct inet_hashinfo *hashinfo, struct sock *sk);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -80,52 +56,12 @@ static inline void __inet6_hash(struct i
  *
  * The sockhash lock must be held as a reader here.
  */
-static inline struct sock *
-		__inet6_lookup_established(struct inet_hashinfo *hashinfo,
+extern struct sock *__inet6_lookup_established(struct inet_hashinfo *hashinfo,
 					   const struct in6_addr *saddr,
 					   const u16 sport,
 					   const struct in6_addr *daddr,
 					   const u16 hnum,
-					   const int dif)
-{
-	struct sock *sk;
-	const struct hlist_node *node;
-	const __u32 ports = INET_COMBINED_PORTS(sport, hnum);
-	/* Optimize here for direct hit, only listening connections can
-	 * have wildcards anyways.
-	 */
-	unsigned int hash = inet6_ehashfn(daddr, hnum, saddr, sport);
-	struct inet_ehash_bucket *head = inet_ehash_bucket(hashinfo, hash);
-
-	prefetch(head->chain.first);
-	read_lock(&head->lock);
-	sk_for_each(sk, node, &head->chain) {
-		/* For IPV6 do the cheaper port and family tests first. */
-		if (INET6_MATCH(sk, hash, saddr, daddr, ports, dif))
-			goto hit; /* You sunk my battleship! */
-	}
-	/* Must check for a TIME_WAIT'er before going to listener hash. */
-	sk_for_each(sk, node, &(head + hashinfo->ehash_size)->chain) {
-		const struct inet_timewait_sock *tw = inet_twsk(sk);
-
-		if(*((__u32 *)&(tw->tw_dport))	== ports	&&
-		   sk->sk_family		== PF_INET6) {
-			const struct inet6_timewait_sock *tw6 = inet6_twsk(sk);
-
-			if (ipv6_addr_equal(&tw6->tw_v6_daddr, saddr)	&&
-			    ipv6_addr_equal(&tw6->tw_v6_rcv_saddr, daddr)	&&
-			    (!sk->sk_bound_dev_if || sk->sk_bound_dev_if == dif))
-				goto hit;
-		}
-	}
-	read_unlock(&head->lock);
-	return NULL;
-
-hit:
-	sock_hold(sk);
-	read_unlock(&head->lock);
-	return sk;
-}
+					   const int dif);
 
 extern struct sock *inet6_lookup_listener(struct inet_hashinfo *hashinfo,
 					  const struct in6_addr *daddr,
diff -urpN linux-2.6.16.org/net/ipv6/inet6_hashtables.c linux-2.6.16.inet6/net/ipv6/inet6_hashtables.c
--- linux-2.6.16.org/net/ipv6/inet6_hashtables.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.inet6/net/ipv6/inet6_hashtables.c	Sun Apr  9 01:41:54 2006
@@ -23,6 +23,86 @@
 #include <net/inet6_hashtables.h>
 #include <net/ip.h>
 
+void __inet6_hash(struct inet_hashinfo *hashinfo,
+				struct sock *sk)
+{
+	struct hlist_head *list;
+	rwlock_t *lock;
+
+	BUG_TRAP(sk_unhashed(sk));
+
+	if (sk->sk_state == TCP_LISTEN) {
+		list = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
+		lock = &hashinfo->lhash_lock;
+		inet_listen_wlock(hashinfo);
+	} else {
+		unsigned int hash;
+		sk->sk_hash = hash = inet6_sk_ehashfn(sk);
+		hash &= (hashinfo->ehash_size - 1);
+		list = &hashinfo->ehash[hash].chain;
+		lock = &hashinfo->ehash[hash].lock;
+		write_lock(lock);
+	}
+
+	__sk_add_node(sk, list);
+	sock_prot_inc_use(sk->sk_prot);
+	write_unlock(lock);
+}
+EXPORT_SYMBOL(__inet6_hash);
+
+/*
+ * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
+ * we need not check it for TCP lookups anymore, thanks Alexey. -DaveM
+ *
+ * The sockhash lock must be held as a reader here.
+ */
+struct sock *__inet6_lookup_established(struct inet_hashinfo *hashinfo,
+					   const struct in6_addr *saddr,
+					   const u16 sport,
+					   const struct in6_addr *daddr,
+					   const u16 hnum,
+					   const int dif)
+{
+	struct sock *sk;
+	const struct hlist_node *node;
+	const __u32 ports = INET_COMBINED_PORTS(sport, hnum);
+	/* Optimize here for direct hit, only listening connections can
+	 * have wildcards anyways.
+	 */
+	unsigned int hash = inet6_ehashfn(daddr, hnum, saddr, sport);
+	struct inet_ehash_bucket *head = inet_ehash_bucket(hashinfo, hash);
+
+	prefetch(head->chain.first);
+	read_lock(&head->lock);
+	sk_for_each(sk, node, &head->chain) {
+		/* For IPV6 do the cheaper port and family tests first. */
+		if (INET6_MATCH(sk, hash, saddr, daddr, ports, dif))
+			goto hit; /* You sunk my battleship! */
+	}
+	/* Must check for a TIME_WAIT'er before going to listener hash. */
+	sk_for_each(sk, node, &(head + hashinfo->ehash_size)->chain) {
+		const struct inet_timewait_sock *tw = inet_twsk(sk);
+
+		if(*((__u32 *)&(tw->tw_dport))	== ports	&&
+		   sk->sk_family		== PF_INET6) {
+			const struct inet6_timewait_sock *tw6 = inet6_twsk(sk);
+
+			if (ipv6_addr_equal(&tw6->tw_v6_daddr, saddr)	&&
+			    ipv6_addr_equal(&tw6->tw_v6_rcv_saddr, daddr)	&&
+			    (!sk->sk_bound_dev_if || sk->sk_bound_dev_if == dif))
+				goto hit;
+		}
+	}
+	read_unlock(&head->lock);
+	return NULL;
+
+hit:
+	sock_hold(sk);
+	read_unlock(&head->lock);
+	return sk;
+}
+EXPORT_SYMBOL(__inet6_lookup_established);
+
 struct sock *inet6_lookup_listener(struct inet_hashinfo *hashinfo,
 				   const struct in6_addr *daddr,
 				   const unsigned short hnum, const int dif)

--Boundary-00=_x4eOEvNBfsf5JAC--
