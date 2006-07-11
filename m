Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWGKKNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWGKKNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGKKNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:13:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:34576 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750928AbWGKKNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:13:54 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mb@bu3sch.de (Michael Buesch)
Subject: Re: [PATCH] cancel_rearming_delayed_work infinite loop fix
Cc: akpm@osdl.org, jbenc@suse.cz, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200607110036.31574.mb@bu3sch.de>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G0FEl-0002lK-00@gondolin.me.apana.org.au>
Date: Tue, 11 Jul 2006 20:13:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mb@bu3sch.de> wrote:
> cancel_rearming_delayed_work{queue} is broken, because it is
> possible to enter an infinite loop if:
> We call the function on a work that is currently not executing or pending.

Why are you calling it on a work that was never scheduled? Sounds like
a bug to me.

> void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
>                                       struct work_struct *work)
> {
> -       while (!cancel_delayed_work(work))
> +       do {
> +               cancel_delayed_work(work);
>                flush_workqueue(wq);
> +       } while (test_bit(0, &work->pending));

This is broken.  If the work just starts running before your test_bit
you'd exit without cancelling it properly.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
