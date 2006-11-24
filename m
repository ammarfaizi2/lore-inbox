Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966209AbWKXV6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966209AbWKXV6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966216AbWKXV6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:58:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966209AbWKXV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:58:17 -0500
Date: Fri, 24 Nov 2006 22:58:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/: possible cleanups
Message-ID: <20061124215820.GI28363@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-net.patch
>...
>  git trees
>...
 
This patch contains the following possible cleanups:
- make the following needlessly global functions statis:
  - ipv4/tcp.c: __tcp_alloc_md5sig_pool()
  - ipv4/tcp_ipv4.c: tcp_v4_reqsk_md5_lookup()
  - ipv4/udplite.c: udplite_rcv()
  - ipv4/udplite.c: udplite_err()
- make the following needlessly global structs static:
  - ipv4/tcp_ipv4.c: tcp_request_sock_ipv4_ops
  - ipv4/tcp_ipv4.c: tcp_sock_ipv4_specific
  - ipv6/tcp_ipv6.c: tcp_request_sock_ipv6_ops
- net/ipv{4,6}/udplite.c: remove inline's from static functions
                          (gcc should know best when to inline them)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/tcp.c      |    2 +-
 net/ipv4/tcp_ipv4.c |    8 ++++----
 net/ipv4/udplite.c  |   10 +++++-----
 net/ipv6/tcp_ipv6.c |    2 +-
 net/ipv6/udplite.c  |   10 +++++-----
 5 files changed, 16 insertions(+), 16 deletions(-)

--- linux-2.6.19-rc6-mm1/net/ipv4/tcp.c.old	2006-11-24 01:30:11.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/ipv4/tcp.c	2006-11-24 01:31:21.000000000 +0100
@@ -2288,7 +2288,7 @@
 
 EXPORT_SYMBOL(tcp_free_md5sig_pool);
 
-struct tcp_md5sig_pool **__tcp_alloc_md5sig_pool(void)
+static struct tcp_md5sig_pool **__tcp_alloc_md5sig_pool(void)
 {
 	int cpu;
 	struct tcp_md5sig_pool **pool;
--- linux-2.6.19-rc6-mm1/net/ipv4/tcp_ipv4.c.old	2006-11-24 01:31:31.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/ipv4/tcp_ipv4.c	2006-11-24 01:33:00.000000000 +0100
@@ -841,8 +841,8 @@
 
 EXPORT_SYMBOL(tcp_v4_md5_lookup);
 
-struct tcp_md5sig_key *tcp_v4_reqsk_md5_lookup(struct sock *sk,
-					       struct request_sock *req)
+static struct tcp_md5sig_key *tcp_v4_reqsk_md5_lookup(struct sock *sk,
+						      struct request_sock *req)
 {
 	return tcp_v4_md5_do_lookup(sk, inet_rsk(req)->rmt_addr);
 }
@@ -1273,7 +1273,7 @@
 	.send_reset	=	tcp_v4_send_reset,
 };
 
-struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
+static struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 #ifdef CONFIG_TCP_MD5SIG
 	.md5_lookup	=	tcp_v4_reqsk_md5_lookup,
 #endif
@@ -1861,7 +1861,7 @@
 #endif
 };
 
-struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
+static struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 #ifdef CONFIG_TCP_MD5SIG
 	.md5_lookup		= tcp_v4_md5_lookup,
 	.calc_md5_hash		= tcp_v4_calc_md5_hash,
--- linux-2.6.19-rc6-mm1/net/ipv4/udplite.c.old	2006-11-24 01:33:19.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/ipv4/udplite.c	2006-11-24 01:34:07.000000000 +0100
@@ -18,23 +18,23 @@
 struct hlist_head 	udplite_hash[UDP_HTABLE_SIZE];
 static int		udplite_port_rover;
 
-__inline__ int udplite_get_port(struct sock *sk, unsigned short p,
-			int (*c)(const struct sock *, const struct sock *))
+int udplite_get_port(struct sock *sk, unsigned short p,
+		     int (*c)(const struct sock *, const struct sock *))
 {
 	return  __udp_lib_get_port(sk, p, udplite_hash, &udplite_port_rover, c);
 }
 
-static __inline__ int udplite_v4_get_port(struct sock *sk, unsigned short snum)
+static int udplite_v4_get_port(struct sock *sk, unsigned short snum)
 {
 	return udplite_get_port(sk, snum, ipv4_rcv_saddr_equal);
 }
 
-__inline__ int udplite_rcv(struct sk_buff *skb)
+static int udplite_rcv(struct sk_buff *skb)
 {
 	return __udp4_lib_rcv(skb, udplite_hash, 1);
 }
 
-__inline__ void udplite_err(struct sk_buff *skb, u32 info)
+static void udplite_err(struct sk_buff *skb, u32 info)
 {
 	return __udp4_lib_err(skb, info, udplite_hash);
 }
--- linux-2.6.19-rc6-mm1/net/ipv6/udplite.c.old	2006-11-24 01:34:21.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/ipv6/udplite.c	2006-11-24 01:51:24.000000000 +0100
@@ -17,14 +17,14 @@
 
 DEFINE_SNMP_STAT(struct udp_mib, udplite_stats_in6) __read_mostly;
 
-static __inline__ int udplitev6_rcv(struct sk_buff **pskb)
+static int udplitev6_rcv(struct sk_buff **pskb)
 {
 	return __udp6_lib_rcv(pskb, udplite_hash, 1);
 }
 
-static __inline__ void udplitev6_err(struct sk_buff *skb,
-				     struct inet6_skb_parm *opt,
-				     int type, int code, int offset, __be32 info)
+static void udplitev6_err(struct sk_buff *skb,
+			  struct inet6_skb_parm *opt,
+			  int type, int code, int offset, __be32 info)
 {
 	return __udp6_lib_err(skb, opt, type, code, offset, info, udplite_hash);
 }
@@ -35,7 +35,7 @@
 	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
 };
 
-static __inline__ int udplite_v6_get_port(struct sock *sk, unsigned short snum)
+static int udplite_v6_get_port(struct sock *sk, unsigned short snum)
 {
 	return udplite_get_port(sk, snum, ipv6_rcv_saddr_equal);
 }
--- linux-2.6.19-rc6-mm1/net/ipv6/tcp_ipv6.c.old	2006-11-24 01:35:02.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/ipv6/tcp_ipv6.c	2006-11-24 01:35:14.000000000 +0100
@@ -929,7 +929,7 @@
 	.send_reset	=	tcp_v6_send_reset
 };
 
-struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
+static struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 #ifdef CONFIG_TCP_MD5SIG
 	.md5_lookup	=	tcp_v6_reqsk_md5_lookup,
 #endif

