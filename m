Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWBAKma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWBAKma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWBAKma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:42:30 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:7690 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161000AbWBAKm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:42:28 -0500
Date: Wed, 1 Feb 2006 21:42:14 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060201104214.GA9085@gondor.apana.org.au>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131212432.GA18812@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20060131212432.GA18812@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2006 at 10:24:32PM +0100, Ingo Molnar wrote:
>
>  [<c04de9e8>] _write_lock+0x8/0x10
>  [<c0499015>] inet6_destroy_sock+0x25/0x100
>  [<c04b8672>] tcp_v6_destroy_sock+0x12/0x20
>  [<c046bbda>] inet_csk_destroy_sock+0x4a/0x150
>  [<c047625c>] tcp_rcv_state_process+0xd4c/0xdd0
>  [<c047d8e9>] tcp_v4_do_rcv+0xa9/0x340
>  [<c047eabb>] tcp_v4_rcv+0x8eb/0x9d0

OK this is definitely broken.  We should never touch the dst lock in
softirq context.  Since inet6_destroy_sock may be called from that
context due to the asynchronous nature of sockets, we can't take the
lock there.

In fact this sk_dst_reset is totally redundant since all IPv6 sockets
use inet_sock_destruct as their socket destructor which always cleans
up the dst anyway.  So the solution is to simply remove the call.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=inet6-destroy-sock-should-not-reset-dst

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -369,12 +369,6 @@ int inet6_destroy_sock(struct sock *sk)
 	struct sk_buff *skb;
 	struct ipv6_txoptions *opt;
 
-	/*
-	 *	Release destination entry
-	 */
-
-	sk_dst_reset(sk);
-
 	/* Release rx options */
 
 	if ((skb = xchg(&np->pktoptions, NULL)) != NULL)

--X1bOJ3K7DJ5YkBrT--
