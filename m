Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWF1Vxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWF1Vxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWF1Vxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:53:49 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:28850 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751571AbWF1Vxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:53:47 -0400
Message-ID: <44A2FA66.5070303@fr.ibm.com>
Date: Wed, 28 Jun 2006 23:53:42 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com> <20060627215859.A20679@castle.nmd.msu.ru> <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com> <20060628150605.A29274@castle.nmd.msu.ru>
In-Reply-To: <20060628150605.A29274@castle.nmd.msu.ru>
Content-Type: multipart/mixed;
 boundary="------------020608020308010406000005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608020308010406000005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrey Savochkin wrote:

> Ok, fine.
> Now I'm working on socket code.
> 
> We still have a question about implicit vs explicit function parameters.
> This question becomes more important for sockets: if we want to allow to use
> sockets belonging to namespaces other than the current one, we need to do
> something about it.
> 
> One possible option to resolve this question is to show 2 relatively short
> patches just introducing namespaces for sockets in 2 ways: with explicit
> function parameters and using implicit current context.
> Then people can compare them and vote.
> Do you think it's worth the effort?
> 

The attached patch can have some part interesting for you for the socket 
tagging. It is in the IPV4 isolation (part 5/6). With this and the 
private routing table you will probably have a good IPV4 isolation.

--------------020608020308010406000005
Content-Type: text/x-patch;
 name="inet_isolation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inet_isolation.patch"

This patch partially isolates ipv4 by adding the network namespace
structure in the structure sock, bind bucket and skbuf. When a socket
is created, the pointer to the network namespace is stored in the
struct sock and the socket belongs to the namespace by this way. That
allows to identify sockets related to a namespace for lookup and
procfs. 

The lookup is extended with a network namespace pointer, in
order to identify listen points binded to the same port. That allows
to have several applications binded to INADDR_ANY:port in different
network namespace without conflicting. The bind is checked against
port and network namespace.

When an outgoing packet has the loopback destination addres, the
skbuff is filled with the network namespace. So the loopback packets
never go outside the namespace. This approach facilitate the migration
of loopback because identification is done by network namespace and
not by address. The loopback has been benchmarked by tbench and the
overhead is roughly 1.5 %

Replace-Subject: [Network namespace] ipv4 isolation
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 include/linux/skbuff.h           |    2 ++
 include/net/inet_hashtables.h    |   34 ++++++++++++++++++++++++----------
 include/net/inet_timewait_sock.h |    1 +
 include/net/sock.h               |    4 ++++
 net/dccp/ipv4.c                  |    7 ++++---
 net/ipv4/af_inet.c               |    2 ++
 net/ipv4/inet_connection_sock.c  |    3 ++-
 net/ipv4/inet_diag.c             |    3 ++-
 net/ipv4/inet_hashtables.c       |    6 +++++-
 net/ipv4/inet_timewait_sock.c    |    1 +
 net/ipv4/ip_output.c             |    4 ++++
 net/ipv4/tcp_ipv4.c              |   25 ++++++++++++++++---------
 net/ipv4/udp.c                   |    7 +++++--
 13 files changed, 72 insertions(+), 27 deletions(-)

Index: 2.6-mm/include/linux/skbuff.h
===================================================================
--- 2.6-mm.orig/include/linux/skbuff.h
+++ 2.6-mm/include/linux/skbuff.h
@@ -27,6 +27,7 @@
 #include <linux/poll.h>
 #include <linux/net.h>
 #include <linux/textsearch.h>
+#include <linux/net_ns.h>
 #include <net/checksum.h>
 #include <linux/dmaengine.h>
 
@@ -301,6 +302,7 @@
 				*data,
 				*tail,
 				*end;
+	struct net_namespace    *net_ns;
 };
 
 #ifdef __KERNEL__
Index: 2.6-mm/include/net/inet_hashtables.h
===================================================================
--- 2.6-mm.orig/include/net/inet_hashtables.h
+++ 2.6-mm/include/net/inet_hashtables.h
@@ -23,6 +23,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/in.h>
+#include <linux/net_ns.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_sock.h>
@@ -78,6 +80,7 @@
 	signed short		fastreuse;
 	struct hlist_node	node;
 	struct hlist_head	owners;
+	struct net_namespace    *net_ns;
 };
 
 #define inet_bind_bucket_for_each(tb, node, head) \
@@ -274,13 +277,15 @@
 extern struct sock *__inet_lookup_listener(const struct hlist_head *head,
 					   const u32 daddr,
 					   const unsigned short hnum,
-					   const int dif);
+					   const int dif,
+					   const struct net_namespace *net_ns);
 
 /* Optimize the common listener case. */
 static inline struct sock *
 		inet_lookup_listener(struct inet_hashinfo *hashinfo,
 				     const u32 daddr,
-				     const unsigned short hnum, const int dif)
+				     const unsigned short hnum, const int dif,
+				     const struct net_namespace *net_ns)
 {
 	struct sock *sk = NULL;
 	const struct hlist_head *head;
@@ -294,8 +299,9 @@
 		    (!inet->rcv_saddr || inet->rcv_saddr == daddr) &&
 		    (sk->sk_family == PF_INET || !ipv6_only_sock(sk)) &&
 		    !sk->sk_bound_dev_if)
-			goto sherry_cache;
-		sk = __inet_lookup_listener(head, daddr, hnum, dif);
+			if (sk->sk_net_ns == net_ns && LOOPBACK(daddr))
+				goto sherry_cache;
+		sk = __inet_lookup_listener(head, daddr, hnum, dif, net_ns);
 	}
 	if (sk) {
 sherry_cache:
@@ -358,7 +364,8 @@
 	__inet_lookup_established(struct inet_hashinfo *hashinfo,
 				  const u32 saddr, const u16 sport,
 				  const u32 daddr, const u16 hnum,
-				  const int dif)
+				  const int dif,
+				  const struct net_namespace *net_ns)
 {
 	INET_ADDR_COOKIE(acookie, saddr, daddr)
 	const __u32 ports = INET_COMBINED_PORTS(sport, hnum);
@@ -373,12 +380,16 @@
 	prefetch(head->chain.first);
 	read_lock(&head->lock);
 	sk_for_each(sk, node, &head->chain) {
+		if (sk->sk_net_ns != net_ns && LOOPBACK(daddr))
+			continue;
 		if (INET_MATCH(sk, hash, acookie, saddr, daddr, ports, dif))
 			goto hit; /* You sunk my battleship! */
 	}
 
 	/* Must check for a TIME_WAIT'er before going to listener hash. */
 	sk_for_each(sk, node, &(head + hashinfo->ehash_size)->chain) {
+		if (sk->sk_net_ns != net_ns && LOOPBACK(daddr))
+			continue;
 		if (INET_TW_MATCH(sk, hash, acookie, saddr, daddr, ports, dif))
 			goto hit;
 	}
@@ -394,22 +405,25 @@
 static inline struct sock *__inet_lookup(struct inet_hashinfo *hashinfo,
 					 const u32 saddr, const u16 sport,
 					 const u32 daddr, const u16 hnum,
-					 const int dif)
+					 const int dif,
+					 const struct net_namespace *net_ns)
 {
 	struct sock *sk = __inet_lookup_established(hashinfo, saddr, sport, daddr,
-						    hnum, dif);
-	return sk ? : inet_lookup_listener(hashinfo, daddr, hnum, dif);
+						    hnum, dif, net_ns);
+	return sk ? : inet_lookup_listener(hashinfo, daddr, hnum, dif, net_ns);
 }
 
 static inline struct sock *inet_lookup(struct inet_hashinfo *hashinfo,
 				       const u32 saddr, const u16 sport,
 				       const u32 daddr, const u16 dport,
-				       const int dif)
+				       const int dif,
+				       const struct net_namespace *net_ns)
 {
 	struct sock *sk;
 
 	local_bh_disable();
-	sk = __inet_lookup(hashinfo, saddr, sport, daddr, ntohs(dport), dif);
+	sk = __inet_lookup(hashinfo, saddr, sport, daddr, ntohs(dport),
+			   dif, net_ns);
 	local_bh_enable();
 
 	return sk;
Index: 2.6-mm/include/net/inet_timewait_sock.h
===================================================================
--- 2.6-mm.orig/include/net/inet_timewait_sock.h
+++ 2.6-mm/include/net/inet_timewait_sock.h
@@ -115,6 +115,7 @@
 #define tw_refcnt		__tw_common.skc_refcnt
 #define tw_hash			__tw_common.skc_hash
 #define tw_prot			__tw_common.skc_prot
+#define tw_net_ns               __tw_common.skc_net_ns
 	volatile unsigned char	tw_substate;
 	/* 3 bits hole, try to pack */
 	unsigned char		tw_rcv_wscale;
Index: 2.6-mm/include/net/sock.h
===================================================================
--- 2.6-mm.orig/include/net/sock.h
+++ 2.6-mm/include/net/sock.h
@@ -47,6 +47,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/net_ns.h>
 
 #include <linux/filter.h>
 
@@ -94,6 +95,7 @@
  *	@skc_refcnt: reference count
  *	@skc_hash: hash value used with various protocol lookup tables
  *	@skc_prot: protocol handlers inside a network family
+ *      @skc_net_ns: network namespace owning the socket
  *
  *	This is the minimal network layer representation of sockets, the header
  *	for struct sock and struct inet_timewait_sock.
@@ -108,6 +110,7 @@
 	atomic_t		skc_refcnt;
 	unsigned int		skc_hash;
 	struct proto		*skc_prot;
+	struct net_namespace    *skc_net_ns;
 };
 
 /**
@@ -183,6 +186,7 @@
 #define sk_refcnt		__sk_common.skc_refcnt
 #define sk_hash			__sk_common.skc_hash
 #define sk_prot			__sk_common.skc_prot
+#define sk_net_ns               __sk_common.skc_net_ns
 	unsigned char		sk_shutdown : 2,
 				sk_no_check : 2,
 				sk_userlocks : 4;
Index: 2.6-mm/net/dccp/ipv4.c
===================================================================
--- 2.6-mm.orig/net/dccp/ipv4.c
+++ 2.6-mm/net/dccp/ipv4.c
@@ -308,7 +308,8 @@
 	}
 
 	sk = inet_lookup(&dccp_hashinfo, iph->daddr, dh->dccph_dport,
-			 iph->saddr, dh->dccph_sport, inet_iif(skb));
+			 iph->saddr, dh->dccph_sport, inet_iif(skb),
+			 skb->net_ns);
 	if (sk == NULL) {
 		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
 		return;
@@ -610,7 +611,7 @@
 	nsk = __inet_lookup_established(&dccp_hashinfo,
 					iph->saddr, dh->dccph_sport,
 					iph->daddr, ntohs(dh->dccph_dport),
-					inet_iif(skb));
+					inet_iif(skb), skb->net_ns);
 	if (nsk != NULL) {
 		if (nsk->sk_state != DCCP_TIME_WAIT) {
 			bh_lock_sock(nsk);
@@ -924,7 +925,7 @@
 	sk = __inet_lookup(&dccp_hashinfo,
 			   skb->nh.iph->saddr, dh->dccph_sport,
 			   skb->nh.iph->daddr, ntohs(dh->dccph_dport),
-			   inet_iif(skb));
+			   inet_iif(skb), skb->net_ns);
 
 	/* 
 	 * Step 2:
Index: 2.6-mm/net/ipv4/af_inet.c
===================================================================
--- 2.6-mm.orig/net/ipv4/af_inet.c
+++ 2.6-mm/net/ipv4/af_inet.c
@@ -325,6 +325,7 @@
 	sk->sk_family	   = PF_INET;
 	sk->sk_protocol	   = protocol;
 	sk->sk_backlog_rcv = sk->sk_prot->backlog_rcv;
+	sk->sk_net_ns      = net_ns();
 
 	inet->uc_ttl	= -1;
 	inet->mc_loop	= 1;
@@ -616,6 +617,7 @@
 
 	sock_graft(sk2, newsock);
 
+	sk2->sk_net_ns = net_ns();
 	newsock->state = SS_CONNECTED;
 	err = 0;
 	release_sock(sk2);
Index: 2.6-mm/net/ipv4/inet_connection_sock.c
===================================================================
--- 2.6-mm.orig/net/ipv4/inet_connection_sock.c
+++ 2.6-mm/net/ipv4/inet_connection_sock.c
@@ -116,7 +116,7 @@
 		head = &hashinfo->bhash[inet_bhashfn(snum, hashinfo->bhash_size)];
 		spin_lock(&head->lock);
 		inet_bind_bucket_for_each(tb, node, &head->chain)
-			if (tb->port == snum)
+			if (tb->port == snum && tb->net_ns == net_ns())
 				goto tb_found;
 	}
 	tb = NULL;
@@ -146,6 +146,7 @@
 	} else if (tb->fastreuse &&
 		   (!sk->sk_reuse || sk->sk_state == TCP_LISTEN))
 		tb->fastreuse = 0;
+	tb->net_ns = net_ns();
 success:
 	if (!inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, snum);
Index: 2.6-mm/net/ipv4/inet_diag.c
===================================================================
--- 2.6-mm.orig/net/ipv4/inet_diag.c
+++ 2.6-mm/net/ipv4/inet_diag.c
@@ -241,7 +241,8 @@
 	if (req->idiag_family == AF_INET) {
 		sk = inet_lookup(hashinfo, req->id.idiag_dst[0],
 				 req->id.idiag_dport, req->id.idiag_src[0],
-				 req->id.idiag_sport, req->id.idiag_if);
+				 req->id.idiag_sport, req->id.idiag_if,
+				 in_skb->net_ns);
 	}
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
 	else if (req->idiag_family == AF_INET6) {
Index: 2.6-mm/net/ipv4/inet_hashtables.c
===================================================================
--- 2.6-mm.orig/net/ipv4/inet_hashtables.c
+++ 2.6-mm/net/ipv4/inet_hashtables.c
@@ -126,7 +126,8 @@
  * wildcarded during the search since they can never be otherwise.
  */
 struct sock *__inet_lookup_listener(const struct hlist_head *head, const u32 daddr,
-				    const unsigned short hnum, const int dif)
+				    const unsigned short hnum, const int dif,
+				    const struct net_namespace *net_ns)
 {
 	struct sock *result = NULL, *sk;
 	const struct hlist_node *node;
@@ -139,6 +140,9 @@
 			const __u32 rcv_saddr = inet->rcv_saddr;
 			int score = sk->sk_family == PF_INET ? 1 : 0;
 
+			if (sk->sk_net_ns != net_ns && LOOPBACK(daddr))
+				continue;
+
 			if (rcv_saddr) {
 				if (rcv_saddr != daddr)
 					continue;
Index: 2.6-mm/net/ipv4/inet_timewait_sock.c
===================================================================
--- 2.6-mm.orig/net/ipv4/inet_timewait_sock.c
+++ 2.6-mm/net/ipv4/inet_timewait_sock.c
@@ -110,6 +110,7 @@
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
 		tw->tw_prot	    = sk->sk_prot_creator;
+		tw->tw_net_ns       = sk->sk_net_ns;
 		atomic_set(&tw->tw_refcnt, 1);
 		inet_twsk_dead_node_init(tw);
 		__module_get(tw->tw_prot->owner);
Index: 2.6-mm/net/ipv4/ip_output.c
===================================================================
--- 2.6-mm.orig/net/ipv4/ip_output.c
+++ 2.6-mm/net/ipv4/ip_output.c
@@ -284,6 +284,10 @@
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
+	if ((skb->nh.iph->protocol == IPPROTO_TCP ||
+	     skb->nh.iph->protocol == IPPROTO_UDP) &&
+	    LOOPBACK(skb->nh.iph->daddr))
+			skb->net_ns = skb->sk->sk_net_ns;
 
 	return NF_HOOK_COND(PF_INET, NF_IP_POST_ROUTING, skb, NULL, dev,
 		            ip_finish_output,
Index: 2.6-mm/net/ipv4/tcp_ipv4.c
===================================================================
--- 2.6-mm.orig/net/ipv4/tcp_ipv4.c
+++ 2.6-mm/net/ipv4/tcp_ipv4.c
@@ -349,7 +349,7 @@
 	}
 
 	sk = inet_lookup(&tcp_hashinfo, iph->daddr, th->dest, iph->saddr,
-			 th->source, inet_iif(skb));
+			 th->source, inet_iif(skb), skb->net_ns);
 	if (!sk) {
 		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
 		return;
@@ -933,7 +933,8 @@
 
 	nsk = __inet_lookup_established(&tcp_hashinfo, skb->nh.iph->saddr,
 					th->source, skb->nh.iph->daddr,
-					ntohs(th->dest), inet_iif(skb));
+					ntohs(th->dest), inet_iif(skb),
+					skb->net_ns);
 
 	if (nsk) {
 		if (nsk->sk_state != TCP_TIME_WAIT) {
@@ -1071,7 +1072,7 @@
 
 	sk = __inet_lookup(&tcp_hashinfo, skb->nh.iph->saddr, th->source,
 			   skb->nh.iph->daddr, ntohs(th->dest),
-			   inet_iif(skb));
+			   inet_iif(skb), skb->net_ns);
 
 	if (!sk)
 		goto no_tcp_socket;
@@ -1149,7 +1150,8 @@
 		struct sock *sk2 = inet_lookup_listener(&tcp_hashinfo,
 							skb->nh.iph->daddr,
 							ntohs(th->dest),
-							inet_iif(skb));
+							inet_iif(skb),
+							skb->net_ns);
 		if (sk2) {
 			inet_twsk_deschedule((struct inet_timewait_sock *)sk,
 					     &tcp_death_row);
@@ -1395,7 +1397,8 @@
 	}
 get_sk:
 	sk_for_each_from(sk, node) {
-		if (sk->sk_family == st->family) {
+		if (sk->sk_family == st->family &&
+		    sk->sk_net_ns == net_ns()) {
 			cur = sk;
 			goto out;
 		}
@@ -1446,7 +1449,8 @@
 
 		read_lock(&tcp_hashinfo.ehash[st->bucket].lock);
 		sk_for_each(sk, node, &tcp_hashinfo.ehash[st->bucket].chain) {
-			if (sk->sk_family != st->family) {
+			if (sk->sk_family != st->family ||
+			    sk->sk_net_ns != net_ns()) {
 				continue;
 			}
 			rc = sk;
@@ -1455,7 +1459,8 @@
 		st->state = TCP_SEQ_STATE_TIME_WAIT;
 		inet_twsk_for_each(tw, node,
 				   &tcp_hashinfo.ehash[st->bucket + tcp_hashinfo.ehash_size].chain) {
-			if (tw->tw_family != st->family) {
+			if (tw->tw_family != st->family ||
+			    tw->tw_net_ns != net_ns()) {
 				continue;
 			}
 			rc = tw;
@@ -1481,7 +1486,8 @@
 		tw = cur;
 		tw = tw_next(tw);
 get_tw:
-		while (tw && tw->tw_family != st->family) {
+		while (tw && (tw->tw_family != st->family ||
+			      tw->tw_net_ns != net_ns())) {
 			tw = tw_next(tw);
 		}
 		if (tw) {
@@ -1505,7 +1511,8 @@
 		sk = sk_next(sk);
 
 	sk_for_each_from(sk, node) {
-		if (sk->sk_family == st->family)
+		if (sk->sk_family == st->family &&
+		    sk->sk_net_ns == net_ns())
 			goto found;
 	}
 
Index: 2.6-mm/net/ipv4/udp.c
===================================================================
--- 2.6-mm.orig/net/ipv4/udp.c
+++ 2.6-mm/net/ipv4/udp.c
@@ -184,6 +184,7 @@
 			    (!inet2->rcv_saddr ||
 			     !inet->rcv_saddr ||
 			     inet2->rcv_saddr == inet->rcv_saddr) &&
+			    sk2->sk_net_ns == sk->sk_net_ns &&
 			    (!sk2->sk_reuse || !sk->sk_reuse))
 				goto fail;
 		}
@@ -1404,7 +1405,8 @@
 	for (state->bucket = 0; state->bucket < UDP_HTABLE_SIZE; ++state->bucket) {
 		struct hlist_node *node;
 		sk_for_each(sk, node, &udp_hash[state->bucket]) {
-			if (sk->sk_family == state->family)
+			if (sk->sk_family == state->family &&
+			    sk->sk_net_ns == net_ns())
 				goto found;
 		}
 	}
@@ -1421,7 +1423,8 @@
 		sk = sk_next(sk);
 try_again:
 		;
-	} while (sk && sk->sk_family != state->family);
+	} while (sk && (sk->sk_family != state->family ||
+			sk->sk_net_ns != net_ns()));
 
 	if (!sk && ++state->bucket < UDP_HTABLE_SIZE) {
 		sk = sk_head(&udp_hash[state->bucket]);

--


--------------020608020308010406000005--
