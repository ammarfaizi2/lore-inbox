Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966119AbWK2Htw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119AbWK2Htw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966059AbWK2Htw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:49:52 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:53010 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S966031AbWK2Htv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:49:51 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: a.p.zijlstra@chello.nl (Peter Zijlstra)
Subject: Re: [PATCH] lockdep: fix sk->sk_callback_lock locking
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, gandalf@wlug.westbo.se
Organization: Core
In-Reply-To: <1164715642.6588.58.camel@twins>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GpKC4-0005Vc-00@gondolin.me.apana.org.au>
Date: Wed, 29 Nov 2006 18:49:24 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> =========================================================
> [ INFO: possible irq lock inversion dependency detected ]
> 2.6.19-rc6 #4
> ---------------------------------------------------------
> nc/1854 just changed the state of lock:
> (af_callback_keys + sk->sk_family#2){-.-?}, at: [<c0268a7f>] sock_def_error_report+0x1f/0x90
> but this lock was taken by another, soft-irq-safe lock in the past:
> (slock-AF_INET){-+..}
> 
> and interrupts could create inverse lock ordering between them.

I think this is bogus.  The slock is not a standard lock.  When we
hold it in process context we don't actually hold the spin lock part
of it.  However, it does prevent the softirq path from running in
critical sections which also prevents any attempt to grab the
callback lock from softirq context.

If you still think there is a problem, please show an actual scenario
where it dead locks.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
