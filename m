Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSJCNwn>; Thu, 3 Oct 2002 09:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbSJCNwn>; Thu, 3 Oct 2002 09:52:43 -0400
Received: from web9601.mail.yahoo.com ([216.136.129.180]:64418 "HELO
	web9601.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263313AbSJCNwl>; Thu, 3 Oct 2002 09:52:41 -0400
Message-ID: <20021003135756.88786.qmail@web9601.mail.yahoo.com>
Date: Thu, 3 Oct 2002 06:57:56 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021003.063256.84377325.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-673985185-1033653476=:88411"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-673985185-1033653476=:88411
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>then every one of those ipv6 options you change 
>which are being used by userspace breaks.

I guess you're right. Smaller patch attached.

-Steve Grubb




__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
--0-673985185-1033653476=:88411
Content-Type: text/plain; name="2.5-patch1.diff"
Content-Description: 2.5-patch1.diff
Content-Disposition: inline; filename="2.5-patch1.diff"

diff -ur linux-2.5.40/net/ipv6/ipv6_sockglue.c linux-2.5.40a/net/ipv6/ipv6_sockglue.c
--- linux-2.5.40/net/ipv6/ipv6_sockglue.c	Tue Oct  1 03:06:16 2002
+++ linux-2.5.40a/net/ipv6/ipv6_sockglue.c	Thu Oct  3 07:23:59 2002
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
-			if (!(ipv6_addr_type(&np->daddr) & IPV6_ADDR_MAPPED)) {
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

--0-673985185-1033653476=:88411--
