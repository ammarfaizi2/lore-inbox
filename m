Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUINDen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUINDen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUINDen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:34:43 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58639 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268670AbUINDel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:34:41 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: 2.6.9-rc1-mm5: TCP oopses
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20040913190858.12544431.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C745E-00024r-00@gondolin.me.apana.org.au>
Date: Tue, 14 Sep 2004 13:34:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
>
> @@ -968,11 +972,17 @@
>                return -EAGAIN;
> 
>        if (skb->len > cur_mss) {
> +               int old_factor = TCP_SKB_CB(skb)->tso_factor;
> +               int new_factor;
> +
>                if (tcp_fragment(sk, skb, cur_mss))
>                        return -ENOMEM; /* We'll try again later. */
> 
>                /* New SKB created, account for it. */
> -               tcp_inc_pcount(&tp->packets_out, skb);
> +               new_factor = TCP_SKB_CB(skb)->tso_factor;
> +               tcp_dec_pcount_explicit(&tp->packets_out,
> +                                       new_factor - old_factor);

That should be tcp_inc_pcount_explicit.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
