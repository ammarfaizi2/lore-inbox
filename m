Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbSJCMjk>; Thu, 3 Oct 2002 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263293AbSJCMjk>; Thu, 3 Oct 2002 08:39:40 -0400
Received: from web9608.mail.yahoo.com ([216.136.129.187]:14099 "HELO
	web9608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263289AbSJCMji>; Thu, 3 Oct 2002 08:39:38 -0400
Message-ID: <20021003124509.83822.qmail@web9608.mail.yahoo.com>
Date: Thu, 3 Oct 2002 05:45:09 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
To: linux-kernel@vger.kernel.org, davem@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patch removes the deprecated
IPV6_ADDRFORM socket option from 2.5.40. I checked
OpenBSD & FreeBSD and both do not support this option,
so I think its safe to remove.

Cheers,
Steve Grubb

-------

diff -ur linux-2.5.40/include/linux/in6.h
linux-2.5.40a/include/linux/in6.h
--- linux-2.5.40/include/linux/in6.h	Tue Oct  1
03:07:07 2002
+++ linux-2.5.40a/include/linux/in6.h	Thu Oct  3
07:27:56 2002
@@ -134,17 +134,16 @@
  *	IPV6 socket options
  */
 
-#define IPV6_ADDRFORM		1
-#define IPV6_PKTINFO		2
-#define IPV6_HOPOPTS		3
-#define IPV6_DSTOPTS		4
-#define IPV6_RTHDR		5
-#define IPV6_PKTOPTIONS		6
-#define IPV6_CHECKSUM		7
-#define IPV6_HOPLIMIT		8
-#define IPV6_NEXTHOP		9
-#define IPV6_AUTHHDR		10
-#define IPV6_FLOWINFO		11
+#define IPV6_PKTINFO		1
+#define IPV6_HOPOPTS		2
+#define IPV6_DSTOPTS		3
+#define IPV6_RTHDR		4
+#define IPV6_PKTOPTIONS		5
+#define IPV6_CHECKSUM		6
+#define IPV6_HOPLIMIT		7
+#define IPV6_NEXTHOP		8
+#define IPV6_AUTHHDR		9
+#define IPV6_FLOWINFO		10
 
 #define IPV6_UNICAST_HOPS	16
 #define IPV6_MULTICAST_IF	17
diff -ur linux-2.5.40/net/ipv6/ipv6_sockglue.c
linux-2.5.40a/net/ipv6/ipv6_sockglue.c
--- linux-2.5.40/net/ipv6/ipv6_sockglue.c	Tue Oct  1
03:06:16 2002
+++ linux-2.5.40a/net/ipv6/ipv6_sockglue.c	Thu Oct  3
07:23:59 2002
@@ -143,66 +143,6 @@
 
 	switch (optname) {
 
-	case IPV6_ADDRFORM:
-		if (val == PF_INET) {
-			struct ipv6_txoptions *opt;
-			struct sk_buff *pktopt;
-
-			if (sk->protocol != IPPROTO_UDP &&
-			    sk->protocol != IPPROTO_TCP)
-				break;
-
-			if (sk->state != TCP_ESTABLISHED) {
-				retv = -ENOTCONN;
-				break;
-			}
-
-			if (!(ipv6_addr_type(&np->daddr) &
IPV6_ADDR_MAPPED)) {
-				retv = -EADDRNOTAVAIL;
-				break;
-			}
-
-			fl6_free_socklist(sk);
-			ipv6_sock_mc_close(sk);
-
-			if (sk->protocol == IPPROTO_TCP) {
-				struct tcp_opt *tp = tcp_sk(sk);
-
-				local_bh_disable();
-				sock_prot_dec_use(sk->prot);
-				sock_prot_inc_use(&tcp_prot);
-				local_bh_enable();
-				sk->prot = &tcp_prot;
-				tp->af_specific = &ipv4_specific;
-				sk->socket->ops = &inet_stream_ops;
-				sk->family = PF_INET;
-				tcp_sync_mss(sk, tp->pmtu_cookie);
-			} else {
-				local_bh_disable();
-				sock_prot_dec_use(sk->prot);
-				sock_prot_inc_use(&udp_prot);
-				local_bh_enable();
-				sk->prot = &udp_prot;
-				sk->socket->ops = &inet_dgram_ops;
-				sk->family = PF_INET;
-			}
-			opt = xchg(&np->opt, NULL);
-			if (opt)
-				sock_kfree_s(sk, opt, opt->tot_len);
-			pktopt = xchg(&np->pktoptions, NULL);
-			if (pktopt)
-				kfree_skb(pktopt);
-
-			sk->destruct = inet_sock_destruct;
-#ifdef INET_REFCNT_DEBUG
-			atomic_dec(&inet6_sock_nr);
-#endif
-			MOD_DEC_USE_COUNT;
-			retv = 0;
-			break;
-		}
-		goto e_inval;
-
 	case IPV6_PKTINFO:
 		np->rxopt.bits.rxinfo = valbool;
 		retv = 0;


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
