Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161468AbWG2Edz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161468AbWG2Edz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWG2Edz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:33:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:63751 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161466AbWG2Edy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:33:54 -0400
Date: Sat, 29 Jul 2006 14:33:25 +1000
To: "David S. Miller" <davem@davemloft.net>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
Message-ID: <20060729043325.GA7035@gondor.apana.org.au>
References: <20060728194531.GA17744@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728194531.GA17744@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 07:45:31PM +0000, Matt Domsch wrote:
> Triggered on Fedora rawhide kernel-2.6.17-1.2462.fc6 x86_64 which is
> based on 2.6.18rc2-git6.  IPv6 was in use at the time.
> 
> =================================
> [ INFO: inconsistent lock state ]
> ---------------------------------
> inconsistent {softirq-on-W} -> {in-softirq-R} usage.
> swapper/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&sk->sk_dst_lock){---?}, at: [<ffffffff80418ef3>]
>  sk_dst_check+0x26/0x12b
> {softirq-on-W} state was registered at:
>   [<ffffffff802a874d>] lock_acquire+0x4a/0x69
>   [<ffffffff802672a1>] _write_lock+0x24/0x31
>   [<ffffffff8044a26b>] ip4_datagram_connect+0x2e1/0x350
>   [<ffffffff80451214>] inet_dgram_connect+0x57/0x65
>   [<ffffffff8041652a>] sys_connect+0x7d/0xa4
>   [<ffffffff8025ff0d>] system_call+0x7d/0x83

Thanks for the report.  This is actually a false positive because
by these two paths can't intersect since one is a UDP while the other
is TCP.

However, here is a patch which should shut up the validator as well
as removing unnecessary locking from most callers of ip6_dst_lookup.

[IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls

The current users of ip6_dst_lookup can be divided into two classes:

1) The caller holds no locks and is in user-context (UDP).
2) The caller does not want to lookup the dst cache at all.

The second class covers everyone except UDP because most people do
the cache lookup directly before calling ip6_dst_lookup.  This patch
adds ip6_sk_dst_lookup for the first class.

Similarly ip6_dst_store users can be divded into those that need to
take the socket dst lock and those that don't.  This patch adds
__ip6_dst_store for those (everyone except UDP/datagram) that don't
need an extra lock.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index ab29daf..96b0e66 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -139,16 +139,22 @@ extern rwlock_t rt6_lock;
 /*
  *	Store a destination cache entry in a socket
  */
-static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
-				     struct in6_addr *daddr)
+static inline void __ip6_dst_store(struct sock *sk, struct dst_entry *dst,
+				   struct in6_addr *daddr)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct rt6_info *rt = (struct rt6_info *) dst;
 
-	write_lock(&sk->sk_dst_lock);
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 	np->dst_cookie = rt->rt6i_node ? rt->rt6i_node->fn_sernum : 0;
+}
+
+static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
+				 struct in6_addr *daddr)
+{
+	write_lock(&sk->sk_dst_lock);
+	__ip6_dst_store(sk, dst, daddr);
 	write_unlock(&sk->sk_dst_lock);
 }
 
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index a8fdf79..ece7e8a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -468,6 +468,9 @@ extern void			ip6_flush_pending_frames(s
 extern int			ip6_dst_lookup(struct sock *sk,
 					       struct dst_entry **dst,
 					       struct flowi *fl);
+extern int			ip6_sk_dst_lookup(struct sock *sk,
+						  struct dst_entry **dst,
+						  struct flowi *fl);
 
 /*
  *	skb processing functions
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 9f3d4d7..610c722 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -230,7 +230,7 @@ static int dccp_v6_connect(struct sock *
 	ipv6_addr_copy(&np->saddr, saddr);
 	inet->rcv_saddr = LOOPBACK4_IPV6;
 
-	ip6_dst_store(sk, dst, NULL);
+	__ip6_dst_store(sk, dst, NULL);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (np->opt != NULL)
@@ -863,7 +863,7 @@ static struct sock *dccp_v6_request_recv
 	 * comment in that function for the gory details. -acme
 	 */
 
-	ip6_dst_store(newsk, dst, NULL);
+	__ip6_dst_store(newsk, dst, NULL);
 	newsk->sk_route_caps = dst->dev->features & ~(NETIF_F_IP_CSUM |
 						      NETIF_F_TSO);
 	newdp6 = (struct dccp6_sock *)newsk;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 5a0ba58..ac85e9c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -658,7 +658,7 @@ int inet6_sk_rebuild_header(struct sock 
 			return err;
 		}
 
-		ip6_dst_store(sk, dst, NULL);
+		__ip6_dst_store(sk, dst, NULL);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 5c950cc..bf49107 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -185,7 +185,7 @@ int inet6_csk_xmit(struct sk_buff *skb, 
 			return err;
 		}
 
-		ip6_dst_store(sk, dst, NULL);
+		__ip6_dst_store(sk, dst, NULL);
 	}
 
 	skb->dst = dst_clone(dst);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3bc74ce..5e74a37 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -723,48 +723,51 @@ fail:
 	return err;
 }
 
-int ip6_dst_lookup(struct sock *sk, struct dst_entry **dst, struct flowi *fl)
+static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
+					  struct dst_entry *dst,
+					  struct flowi *fl)
 {
-	int err = 0;
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct rt6_info *rt = (struct rt6_info *)dst;
 
-	*dst = NULL;
-	if (sk) {
-		struct ipv6_pinfo *np = inet6_sk(sk);
-	
-		*dst = sk_dst_check(sk, np->dst_cookie);
-		if (*dst) {
-			struct rt6_info *rt = (struct rt6_info*)*dst;
-	
-			/* Yes, checking route validity in not connected
-			 * case is not very simple. Take into account,
-			 * that we do not support routing by source, TOS,
-			 * and MSG_DONTROUTE 		--ANK (980726)
-			 *
-			 * 1. If route was host route, check that
-			 *    cached destination is current.
-			 *    If it is network route, we still may
-			 *    check its validity using saved pointer
-			 *    to the last used address: daddr_cache.
-			 *    We do not want to save whole address now,
-			 *    (because main consumer of this service
-			 *    is tcp, which has not this problem),
-			 *    so that the last trick works only on connected
-			 *    sockets.
-			 * 2. oif also should be the same.
-			 */
-			if (((rt->rt6i_dst.plen != 128 ||
-			      !ipv6_addr_equal(&fl->fl6_dst,
-					       &rt->rt6i_dst.addr))
-			     && (np->daddr_cache == NULL ||
-				 !ipv6_addr_equal(&fl->fl6_dst,
-						  np->daddr_cache)))
-			    || (fl->oif && fl->oif != (*dst)->dev->ifindex)) {
-				dst_release(*dst);
-				*dst = NULL;
-			}
-		}
+	if (!dst)
+		goto out;
+
+	/* Yes, checking route validity in not connected
+	 * case is not very simple. Take into account,
+	 * that we do not support routing by source, TOS,
+	 * and MSG_DONTROUTE 		--ANK (980726)
+	 *
+	 * 1. If route was host route, check that
+	 *    cached destination is current.
+	 *    If it is network route, we still may
+	 *    check its validity using saved pointer
+	 *    to the last used address: daddr_cache.
+	 *    We do not want to save whole address now,
+	 *    (because main consumer of this service
+	 *    is tcp, which has not this problem),
+	 *    so that the last trick works only on connected
+	 *    sockets.
+	 * 2. oif also should be the same.
+	 */
+	if (((rt->rt6i_dst.plen != 128 ||
+	      !ipv6_addr_equal(&fl->fl6_dst, &rt->rt6i_dst.addr))
+	     && (np->daddr_cache == NULL ||
+		 !ipv6_addr_equal(&fl->fl6_dst, np->daddr_cache)))
+	    || (fl->oif && fl->oif != dst->dev->ifindex)) {
+		dst_release(dst);
+		dst = NULL;
 	}
 
+out:
+	return dst;
+}
+
+static int ip6_dst_lookup_tail(struct sock *sk,
+			       struct dst_entry **dst, struct flowi *fl)
+{
+	int err;
+
 	if (*dst == NULL)
 		*dst = ip6_route_output(sk, fl);
 
@@ -773,7 +776,6 @@ int ip6_dst_lookup(struct sock *sk, stru
 
 	if (ipv6_addr_any(&fl->fl6_src)) {
 		err = ipv6_get_saddr(*dst, &fl->fl6_dst, &fl->fl6_src);
-
 		if (err)
 			goto out_err_release;
 	}
@@ -786,8 +788,48 @@ out_err_release:
 	return err;
 }
 
+/**
+ *	ip6_dst_lookup - perform route lookup on flow
+ *	@sk: socket which provides route info
+ *	@dst: pointer to dst_entry * for result
+ *	@fl: flow to lookup
+ *
+ *	This function performs a route lookup on the given flow.
+ *
+ *	It returns zero on success, or a standard errno code on error.
+ */
+int ip6_dst_lookup(struct sock *sk, struct dst_entry **dst, struct flowi *fl)
+{
+	*dst = NULL;
+	return ip6_dst_lookup_tail(sk, dst, fl);
+}
 EXPORT_SYMBOL_GPL(ip6_dst_lookup);
 
+/**
+ *	ip6_sk_dst_lookup - perform socket cached route lookup on flow
+ *	@sk: socket which provides the dst cache and route info
+ *	@dst: pointer to dst_entry * for result
+ *	@fl: flow to lookup
+ *
+ *	This function performs a route lookup on the given flow with the
+ *	possibility of using the cached route in the socket if it is valid.
+ *	It will take the socket dst lock when operating on the dst cache.
+ *	As a result, this function can only be used in process context.
+ *
+ *	It returns zero on success, or a standard errno code on error.
+ */
+int ip6_sk_dst_lookup(struct sock *sk, struct dst_entry **dst, struct flowi *fl)
+{
+	*dst = NULL;
+	if (sk) {
+		*dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
+		*dst = ip6_sk_dst_check(sk, *dst, fl);
+	}
+
+	return ip6_dst_lookup_tail(sk, dst, fl);
+}
+EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup);
+
 static inline int ip6_ufo_append_data(struct sock *sk,
 			int getfrag(void *from, char *to, int offset, int len,
 			int odd, struct sk_buff *skb),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 923989d..b76fd7f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -270,7 +270,7 @@ static int tcp_v6_connect(struct sock *s
 	inet->rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL);
+	__ip6_dst_store(sk, dst, NULL);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (np->opt)
@@ -947,7 +947,7 @@ static struct sock * tcp_v6_syn_recv_soc
 	 */
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL);
+	__ip6_dst_store(newsk, dst, NULL);
 
 	newtcp6sk = (struct tcp6_sock *)newsk;
 	inet_sk(newsk)->pinet6 = &newtcp6sk->inet6;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ccc57f4..3d54f24 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -782,7 +782,7 @@ do_udp_sendmsg:
 		connected = 0;
 	}
 
-	err = ip6_dst_lookup(sk, &dst, fl);
+	err = ip6_sk_dst_lookup(sk, &dst, fl);
 	if (err)
 		goto out;
 	if (final_p)
