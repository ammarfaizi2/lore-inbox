Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVDYKxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVDYKxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVDYKxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:53:38 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24844 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262580AbVDYKxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:53:36 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <426CB342.2010504@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au>
Date: Mon, 25 Apr 2005 20:52:51 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
> --- 70652aa8f30bea3ea83594cc4a47a11f7a8db89d/net/core/netfilter.c  (mode:100644 sha1:e51cfa46950cf8f1f4dea42be94e71d76d8c3c5b)
> +++ a469360c577fdf6919b9a771521eca120103db45/net/core/netfilter.c  (mode:100644 sha1:85936a0b23d9ea42e2cd9d45e8254c2f780eb786)
> @@ -611,7 +611,8 @@
>        /* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
>         * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
>         */
> -       if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
> +       if (inet_addr_type(iph->saddr) == RTN_LOCAL ||
> +           inet_addr_type(iph->daddr) == RTN_LOCAL) {
>                fl.nl_u.ip4_u.daddr = iph->daddr;
>                fl.nl_u.ip4_u.saddr = iph->saddr;
>                fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);

You'll still BUG if the destination is multicast/broadcast.  I'm also
unsure whether ipt_REJECT isn't susceptible to the same problem.
Luckily ipt_MIRROR is no more :)

What are the issues with getting rid of the ip_route_input path
altogether?

The only thing we gain over calling ip_route_output is the ability
to set the input device.  But even that is just a fake derived from
the source address in a deterministic way.  Therefore any effects
achievable through using ip_route_input can also be done by simply
reconfiguring the policy routing table to look at the local source
addresses instead of (or in conjunction with) the input device.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
