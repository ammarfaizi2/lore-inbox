Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbTIMNRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTIMNRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:17:46 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:7955 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262147AbTIMNRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:17:30 -0400
Date: Sat, 13 Sep 2003 22:18:13 +0900 (JST)
Message-Id: <20030913.221813.110764641.yoshfuji@linux-ipv6.org>
To: james.harper@bigpond.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: oops in inet_bind/tcp_v4_get_port
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3F630C59.5090004@bigpond.com>
References: <3F62EA61.1000804@bigpond.com>
	<20030913.192535.114458752.yoshfuji@linux-ipv6.org>
	<3F630C59.5090004@bigpond.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F630C59.5090004@bigpond.com> (at Sat, 13 Sep 2003 22:23:53 +1000), James Harper <james.harper@bigpond.com> says:

> The crash is happening in net/ipv4/tcp_ipv4.c - tcp_bind_conflict (it's 
> inline, which i guess is why it isn't in the oops trace, but it's called 
> from tcp_v4_get_port), specifically in the call to the macro 
> ipv6_only_sock. My guess is that while the sock says it's PF_INET6, it 
> doesn't have the extra ipv6 stuff (specifically the pointer to 
> ipv6_pinfo) so it's reading past the end of the structure, or that the 
> stuff past the main sock struct is getting corrupted. I think the former 
> is more likely but either possibility explains why I got a null pointer 
> dereference one time, and the other oops the other time.

good point.  please try this patch.

Index: linux-2.6/include/net/tcp.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/net/tcp.h,v
retrieving revision 1.45
diff -u -r1.45 tcp.h
--- linux-2.6/include/net/tcp.h	10 Jul 2003 02:18:15 -0000	1.45
+++ linux-2.6/include/net/tcp.h	13 Sep 2003 11:36:32 -0000
@@ -219,6 +219,7 @@
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	struct in6_addr		tw_v6_daddr;
 	struct in6_addr		tw_v6_rcv_saddr;
+	u8			tw_v6_v6only;
 #endif
 };
 
@@ -285,6 +286,18 @@
 extern void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo);
 extern void tcp_tw_deschedule(struct tcp_tw_bucket *tw);
 
+/* Check if tcp socket is the "v6only" socket */
+int inline tcp6_only_sock(const struct sock *sk)
+{
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	if (sk->sk_state == TCP_TIME_WAIT)
+		return tcptw_sk(sk)->tw_v6_v6only;
+	else
+		return ipv6_only_sock(sk);
+#else
+	return 0;
+#endif
+}
 
 /* Socket demux engine toys. */
 #ifdef __BIG_ENDIAN
Index: linux-2.6/net/ipv4/tcp_ipv4.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/tcp_ipv4.c,v
retrieving revision 1.57
diff -u -r1.57 tcp_ipv4.c
--- linux-2.6/net/ipv4/tcp_ipv4.c	9 Sep 2003 23:24:51 -0000	1.57
+++ linux-2.6/net/ipv4/tcp_ipv4.c	13 Sep 2003 11:36:32 -0000
@@ -186,7 +186,7 @@
 
 	sk_for_each_bound(sk2, node, &tb->owners) {
 		if (sk != sk2 &&
-		    !ipv6_only_sock(sk2) &&
+		    !tcp6_only_sock(sk2) &&
 		    sk->sk_bound_dev_if == sk2->sk_bound_dev_if) {
 			if (!reuse || !sk2->sk_reuse ||
 			    sk2->sk_state == TCP_LISTEN) {
@@ -418,7 +418,7 @@
 	sk_for_each(sk, node, head) {
 		struct inet_opt *inet = inet_sk(sk);
 
-		if (inet->num == hnum && !ipv6_only_sock(sk)) {
+		if (inet->num == hnum && !tcp6_only_sock(sk)) {
 			__u32 rcv_saddr = inet->rcv_saddr;
 
 			score = (sk->sk_family == PF_INET ? 1 : 0);
@@ -457,7 +457,7 @@
 
 		if (inet->num == hnum && !sk->sk_node.next &&
 		    (!inet->rcv_saddr || inet->rcv_saddr == daddr) &&
-		    (sk->sk_family == PF_INET || !ipv6_only_sock(sk)) &&
+		    (sk->sk_family == PF_INET || !tcp6_only_sock(sk)) &&
 		    !sk->sk_bound_dev_if)
 			goto sherry_cache;
 		sk = __tcp_v4_lookup_listener(head, daddr, hnum, dif);
Index: linux-2.6/net/ipv4/tcp_minisocks.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/tcp_minisocks.c,v
retrieving revision 1.40
diff -u -r1.40 tcp_minisocks.c
--- linux-2.6/net/ipv4/tcp_minisocks.c	27 Jun 2003 16:44:43 -0000	1.40
+++ linux-2.6/net/ipv4/tcp_minisocks.c	13 Sep 2003 11:36:32 -0000
@@ -367,7 +367,9 @@
 
 			ipv6_addr_copy(&tw->tw_v6_daddr, &np->daddr);
 			ipv6_addr_copy(&tw->tw_v6_rcv_saddr, &np->rcv_saddr);
-		}
+			tw->tw_v6_v6only = np->ipv6only;
+		} else
+			tw->tw_v6_v6only = 0;
 #endif
 		/* Linkage updates. */
 		__tcp_tw_hashdance(sk, tw);
Index: linux-2.6/net/ipv6/addrconf.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/addrconf.c,v
retrieving revision 1.53
diff -u -r1.53 addrconf.c
--- linux-2.6/net/ipv6/addrconf.c	9 Sep 2003 23:24:51 -0000	1.53
+++ linux-2.6/net/ipv6/addrconf.c	13 Sep 2003 11:36:32 -0000
@@ -968,16 +968,16 @@
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	int addr_type = ipv6_addr_type(&np->rcv_saddr);
 
-	if (!inet_sk(sk2)->rcv_saddr && !ipv6_only_sock(sk))
+	if (!inet_sk(sk2)->rcv_saddr && !tcp6_only_sock(sk))
 		return 1;
 
 	if (sk2->sk_family == AF_INET6 &&
 	    ipv6_addr_any(&inet6_sk(sk2)->rcv_saddr) &&
-	    !(ipv6_only_sock(sk2) && addr_type == IPV6_ADDR_MAPPED))
+	    !(tcp6_only_sock(sk2) && addr_type == IPV6_ADDR_MAPPED))
 		return 1;
 
 	if (addr_type == IPV6_ADDR_ANY &&
-	    (!ipv6_only_sock(sk) ||
+	    (!tcp6_only_sock(sk) ||
 	     !(sk2->sk_family == AF_INET6 ?
 	       (ipv6_addr_type(&inet6_sk(sk2)->rcv_saddr) == IPV6_ADDR_MAPPED) :
 	        1)))
@@ -991,7 +991,7 @@
 		return 1;
 
 	if (addr_type == IPV6_ADDR_MAPPED &&
-	    !ipv6_only_sock(sk2) &&
+	    !tcp6_only_sock(sk2) &&
 	    (!inet_sk(sk2)->rcv_saddr ||
 	     !inet_sk(sk)->rcv_saddr ||
 	     inet_sk(sk)->rcv_saddr == inet_sk(sk2)->rcv_saddr))

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
