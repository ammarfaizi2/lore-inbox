Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWF3LSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWF3LSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWF3LSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:18:44 -0400
Received: from [64.62.148.172] ([64.62.148.172]:29969 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1750823AbWF3LSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:18:44 -0400
Date: Fri, 30 Jun 2006 21:17:34 +1000
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630111734.GA22202@gondor.apana.org.au>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630091850.GA10713@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 11:18:50AM +0200, Ingo Molnar wrote:
> 
> Herbert, do the acquire/release semantics as expressed in the 
> lockdep-annotate-slock.patch match sk_lock semantics?

I think it should be fine.
 
> @@ -250,9 +283,18 @@ int sk_receive_skb(struct sock *sk, stru
>  	skb->dev = NULL;
>  
>  	bh_lock_sock(sk);
> -	if (!sock_owned_by_user(sk))
> +	if (!sock_owned_by_user(sk)) {
> +		/*
> +		 * trylock + unlock semantics:
> +		 */
> +		spin_release(&sk->sk_lock.slock.dep_map, 1, _RET_IP_);
> +		mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);

Although it would seem that keeping the spin lock would fit the actual
semantics better.  I suppose there must be a technical reason why this
wouldn't work.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
