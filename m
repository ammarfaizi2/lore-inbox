Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271772AbRIDP4W>; Tue, 4 Sep 2001 11:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271890AbRIDP4O>; Tue, 4 Sep 2001 11:56:14 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:31499 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271772AbRIDP4D>;
	Tue, 4 Sep 2001 11:56:03 -0400
Message-Id: <200109032250.CAA07043@mops.inr.ac.ru>
Subject: Re: Transparent proxy support in 2.4 - revisited
To: nyh@math.technion.ac.IL (Nadav Har'El)
Date: Tue, 4 Sep 2001 02:50:50 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010903131240.A9791@leeor.math.technion.ac.il> from "Nadav Har'El" at Sep 3, 1 02:45:01 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> As I'm not an experienced Linux kernel hacker, and I'm barely familar with
> Linux's networking code, so I hesitate to attempt such a feat (resurrecting
> the transparent proxy code) myself, so I was wondering if anyone else had any
> plans of doing that?

Well, the patch which I used for this purpose, is enclosed.

The patch does not contain line óONFIG_IP_NONLOCAL_CONNECT in Config.in,
so that you have to add it yourself. Also it requires to call
setsockopt(..., SOL_IP, IP_NONLOCAL, 1, ) before binding to foreign
address.


> If not, does anyone know of a reason why this feature was abandoned 

Not __this__ feature was abandoned. The feature to __listen__ foreign
addresses and redirecting them to another port inside TCP i.e.
"transparent proxÕ" was moved to netfilter (not abandoned!).
Its implementation inside TCP even in 2.2 was full of bugs and
in 2.4 it is just impossible.

What's about active connect(), using nonlocal address, it was not abandoned.
Actually, I even was not aware of this feature and consider its presence
in 2.2 as very hard bug. It was not supposed to work and I have no idea
who opened this ugly hole. Even the person was me, it was misprint. :-)

But, actually, if someone reminded about this in time it could be repaired
in 2.2 in way proposed in the enclosed patch. I also would prefer to have it
in core, it is useful.

[ Dave, this forward is purely informational, of course. It is not a patch
 to apply :-) ]

Alexey


diff -ur ../vger3-010728/linux/include/linux/in.h linux/include/linux/in.h
--- ../vger3-010728/linux/include/linux/in.h	Thu Oct 26 18:06:21 2000
+++ linux/include/linux/in.h	Sun Aug  5 22:37:54 2001
@@ -67,6 +67,7 @@
 #define	IP_RECVTOS	13
 #define IP_MTU		14
 #define IP_FREEBIND	15
+#define IP_NONLOCAL	16
 
 /* BSD compatibility */
 #define IP_RECVRETOPTS	IP_RETOPTS
diff -ur ../vger3-010728/linux/include/net/route.h linux/include/net/route.h
--- ../vger3-010728/linux/include/net/route.h	Fri Jul 20 22:12:10 2001
+++ linux/include/net/route.h	Sun Aug  5 22:34:40 2001
@@ -36,10 +36,17 @@
 #endif
 
 #define RTO_ONLINK	0x01
-#define RTO_TPROXY	0x80000000
+#define RTO_TPROXY	0x8000
 
 #define RTO_CONN	0
 
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+#define RTO_SCONN(sk)	((sk)->reuse > 1 ? RTO_TPROXY : 0)
+#else
+#define RTO_SCONN(sk)	0
+#endif
+#define RT_CONN_FLAGS(sk)   (RT_TOS(sk->protinfo.af_inet.tos) | RTO_SCONN(sk) | sk->localroute)
+
 struct rt_key
 {
 	__u32			dst;
@@ -49,7 +56,7 @@
 #ifdef CONFIG_IP_ROUTE_FWMARK
 	__u32			fwmark;
 #endif
-	__u8			tos;
+	__u16			tos;
 	__u8			scope;
 };
 
diff -ur ../vger3-010728/linux/net/ipv4/af_inet.c linux/net/ipv4/af_inet.c
--- ../vger3-010728/linux/net/ipv4/af_inet.c	Wed Jun 13 21:14:05 2001
+++ linux/net/ipv4/af_inet.c	Sun Aug  5 23:24:15 2001
@@ -485,6 +485,24 @@
 
 	chk_addr_ret = inet_addr_type(addr->sin_addr.s_addr);
 
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+	if (sk->reuse > 1) {
+		if (chk_addr_ret != RTN_UNICAST) {
+			/* Not a foreign address really, hence port is ours. */ 
+			sk->reuse = 1;
+		} else {
+			if (!addr->sin_port)
+				return -EINVAL;
+			printk(KERN_DEBUG "bind to nonlocal\n");
+			sk->protinfo.af_inet.freebind = 1;
+		}
+	} else {
+		/* Not priviledged freebind option is not compatible with
+		 * nonlocal connect. */
+		sk->protinfo.af_inet.freebind = 0;
+	}
+#endif
+
 	/* Not specified by any standard per-se, however it breaks too
 	 * many applications when removed.  It is unfortunate since
 	 * allowing applications to make a non-local bind solves
diff -ur ../vger3-010728/linux/net/ipv4/ip_forward.c linux/net/ipv4/ip_forward.c
--- ../vger3-010728/linux/net/ipv4/ip_forward.c	Wed Dec 13 22:23:13 2000
+++ linux/net/ipv4/ip_forward.c	Sun Aug  5 22:01:02 2001
@@ -84,6 +84,15 @@
 	if (skb->pkt_type != PACKET_HOST)
 		goto drop;
 
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+	/* Could be done with a netfilter hook. Not clear how exactly. */
+	if (skb->nh.iph->protocol == IPPROTO_TCP) {
+		if ((skb = tcp_v4_nonlocal_deliver(skb)) == NULL)
+			return NET_RX_SUCCESS;
+		opt = &(IPCB(skb)->opt);
+	}
+#endif
+
 	skb->ip_summed = CHECKSUM_NONE;
 	
 	/*
diff -ur ../vger3-010728/linux/net/ipv4/ip_output.c linux/net/ipv4/ip_output.c
--- ../vger3-010728/linux/net/ipv4/ip_output.c	Fri Jul 20 22:12:11 2001
+++ linux/net/ipv4/ip_output.c	Sun Aug  5 22:01:02 2001
@@ -357,7 +357,7 @@
 		 * out.
 		 */
 		if (ip_route_output(&rt, daddr, sk->saddr,
-				    RT_TOS(sk->protinfo.af_inet.tos) | RTO_CONN | sk->localroute,
+				    RT_CONN_FLAGS(sk),
 				    sk->bound_dev_if))
 			goto no_route;
 		__sk_dst_set(sk, &rt->u.dst);
diff -ur ../vger3-010728/linux/net/ipv4/ip_sockglue.c linux/net/ipv4/ip_sockglue.c
--- ../vger3-010728/linux/net/ipv4/ip_sockglue.c	Tue Feb 20 22:13:53 2001
+++ linux/net/ipv4/ip_sockglue.c	Sun Aug  5 23:24:57 2001
@@ -392,7 +392,7 @@
 			    (1<<IP_RETOPTS) | (1<<IP_TOS) | 
 			    (1<<IP_TTL) | (1<<IP_HDRINCL) | 
 			    (1<<IP_MTU_DISCOVER) | (1<<IP_RECVERR) | 
-			    (1<<IP_ROUTER_ALERT) | (1<<IP_FREEBIND))) || 
+			    (1<<IP_ROUTER_ALERT) | (1<<IP_FREEBIND) | (1<<IP_NONLOCAL))) || 
 				optname == IP_MULTICAST_TTL || 
 				optname == IP_MULTICAST_LOOP) { 
 		if (optlen >= sizeof(int)) {
@@ -624,6 +624,17 @@
 			sk->protinfo.af_inet.freebind = !!val; 
 	                break;			
  
+		case IP_NONLOCAL:
+			if (optlen<1)
+				goto e_inval;
+			if (!capable(CAP_NET_ADMIN))
+				goto e_inval;
+			if (val)
+				sk->reuse = 2;
+			else if (sk->reuse == 2)
+				sk->reuse = 1;
+	                break;			
+
 		default:
 #ifdef CONFIG_NETFILTER
 			err = nf_setsockopt(sk, PF_INET, optname, optval, 
diff -ur ../vger3-010728/linux/net/ipv4/route.c linux/net/ipv4/route.c
--- ../vger3-010728/linux/net/ipv4/route.c	Fri Jul 20 22:12:11 2001
+++ linux/net/ipv4/route.c	Sun Aug  5 23:24:15 2001
@@ -1689,6 +1689,16 @@
 
 /*
  * Major route resolver routine.
+ *
+ * NOTE: about CONFIG_IP_NONLOCAL_CONNECT. Here it concides to
+ * CONFIG_IP_TRANSPARENT_PROXY used in linux-2.2. However, 
+ * [ Also, I constructed new song: "Yesterday, all my troubles..."
+ *   Whaat?! Well, words are the same, music may be the same too. Why not?
+ *   But its sense is absolutely different!
+ * ]
+ * jokes apart, it is _not_ used to steal connections, only
+ * connections opened by us are nonlocal, hence we have
+ * no problems with TCP port shifting etc.
  */
 
 int ip_route_output_slow(struct rtable **rp, const struct rt_key *oldkey)
@@ -1728,8 +1738,19 @@
 
 		/* It is equivalent to inet_addr_type(saddr) == RTN_LOCAL */
 		dev_out = ip_dev_find(oldkey->src);
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+		/* If address is not local, test for nonlocal flag;
+		 * if address is local --- clear the flag.
+		 */
+		if (dev_out == NULL) {
+			if (!(oldkey->tos & RTO_TPROXY) || inet_addr_type(oldkey->src) != RTN_UNICAST)
+				goto out;
+			flags |= RTCF_TPROXY;
+		}
+#else
 		if (dev_out == NULL)
 			goto out;
+#endif
 
 		/* I removed check for oif == dev_out->oif here.
 		   It was wrong by three reasons:
@@ -1740,6 +1761,9 @@
 		 */
 
 		if (oldkey->oif == 0
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+		    && dev_out
+#endif
 		    && (MULTICAST(oldkey->dst) || oldkey->dst == 0xFFFFFFFF)) {
 			/* Special hack: user can direct multicasts
 			   and limited broadcast via necessary interface
diff -ur ../vger3-010728/linux/net/ipv4/syncookies.c linux/net/ipv4/syncookies.c
--- ../vger3-010728/linux/net/ipv4/syncookies.c	Fri May 11 21:40:10 2001
+++ linux/net/ipv4/syncookies.c	Sun Aug  5 22:01:12 2001
@@ -178,7 +178,7 @@
 			    opt && 
 			    opt->srr ? opt->faddr : req->af.v4_req.rmt_addr,
 			    req->af.v4_req.loc_addr,
-			    sk->protinfo.af_inet.tos | RTO_CONN,
+			    RT_TOS(sk->protinfo.af_inet.tos) | RTO_CONN,
 			    0)) { 
 		tcp_openreq_free(req);
 		goto out; 
diff -ur ../vger3-010728/linux/net/ipv4/tcp_ipv4.c linux/net/ipv4/tcp_ipv4.c
--- ../vger3-010728/linux/net/ipv4/tcp_ipv4.c	Wed Apr 25 21:02:18 2001
+++ linux/net/ipv4/tcp_ipv4.c	Sun Aug  5 23:24:15 2001
@@ -213,6 +213,8 @@
 				break;
 	}
 	if (tb != NULL && tb->owners != NULL) {
+		if (sk->reuse > 1)
+			goto success;
 		if (tb->fastreuse != 0 && sk->reuse != 0 && sk->state != TCP_LISTEN) {
 			goto success;
 		} else {
@@ -221,6 +223,7 @@
 
 			for( ; sk2 != NULL; sk2 = sk2->bind_next) {
 				if (sk != sk2 &&
+				    sk2->reuse <= 1 &&
 				    sk->bound_dev_if == sk2->bound_dev_if) {
 					if (!sk_reuse	||
 					    !sk2->reuse	||
@@ -660,7 +663,8 @@
 	}
 
 	tmp = ip_route_connect(&rt, nexthop, sk->saddr,
-			       RT_TOS(sk->protinfo.af_inet.tos)|RTO_CONN|sk->localroute, sk->bound_dev_if);
+			       RT_CONN_FLAGS(sk),
+			       sk->bound_dev_if);
 	if (tmp < 0)
 		return tmp;
 
@@ -676,7 +680,7 @@
 		daddr = rt->rt_dst;
 
 	err = -ENOBUFS;
-	buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
+	buff = alloc_skb(MAX_TCP_HEADER + 15, sk->allocation);
 
 	if (buff == NULL)
 		goto failure;
@@ -1704,6 +1708,44 @@
 	goto discard_it;
 }
 
+#ifdef CONFIG_IP_NONLOCAL_CONNECT
+/* Could be done with netfilter hook. Not clear how to hook this in right place. */
+
+struct sk_buff *tcp_v4_nonlocal_deliver(struct sk_buff *skb)
+{
+	struct sock *sk;
+	struct tcphdr *th;
+	int ihl;
+
+	if (skb->nh.iph->frag_off & htons(IP_MF|IP_OFFSET)) {
+		skb = ip_defrag(skb);
+		if (!skb)
+			return NULL;
+	}
+
+	ihl = skb->nh.iph->ihl*4;
+
+	if (!pskb_may_pull(skb, ihl+8))
+		goto out;
+
+	th = (struct tcphdr*)(skb->nh.raw + ihl);
+
+	sk = __tcp_v4_lookup_established(skb->nh.iph->saddr, th->source,
+					 skb->nh.iph->daddr, ntohs(th->dest),
+					 0);
+	if (sk) {
+		sock_put(sk);
+		ip_local_deliver(skb);
+		return NULL;
+	}
+
+out:
+	return skb;
+}
+#endif
+
+
+
 /* With per-bucket locks this operation is not-atomic, so that
  * this version is not worse.
  */
@@ -1776,7 +1818,7 @@
 		daddr = sk->protinfo.af_inet.opt->faddr;
 
 	err = ip_route_output(&rt, daddr, sk->saddr,
-			      RT_TOS(sk->protinfo.af_inet.tos) | RTO_CONN | sk->localroute,
+			      RT_CONN_FLAGS(sk),
 			      sk->bound_dev_if);
 	if (!err) {
 		__sk_dst_set(sk, &rt->u.dst);
diff -ur ../vger3-010728/linux/net/ipv4/udp.c linux/net/ipv4/udp.c
--- ../vger3-010728/linux/net/ipv4/udp.c	Wed Mar  7 22:17:47 2001
+++ linux/net/ipv4/udp.c	Sun Aug  5 22:01:15 2001
@@ -724,7 +724,7 @@
 	sk_dst_reset(sk);
 
 	err = ip_route_connect(&rt, usin->sin_addr.s_addr, sk->saddr,
-			       sk->protinfo.af_inet.tos|sk->localroute, sk->bound_dev_if);
+			       RT_TOS(sk->protinfo.af_inet.tos), sk->bound_dev_if);
 	if (err)
 		return err;
 	if ((rt->rt_flags&RTCF_BROADCAST) && !sk->broadcast) {
diff -ur ../vger3-010728/linux/net/ipv6/tcp_ipv6.c linux/net/ipv6/tcp_ipv6.c
--- ../vger3-010728/linux/net/ipv6/tcp_ipv6.c	Wed Jun 13 21:14:05 2001
+++ linux/net/ipv6/tcp_ipv6.c	Sun Aug  5 22:01:18 2001
@@ -656,7 +656,7 @@
 	tp->mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
 
 	err = -ENOBUFS;
-	buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
+	buff = alloc_skb(MAX_TCP_HEADER + 15, sk->allocation);
 
 	if (buff == NULL)
 		goto failure;

