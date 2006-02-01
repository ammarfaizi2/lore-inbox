Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWBANeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWBANeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWBANeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:34:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51160 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964980AbWBANeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:34:04 -0500
Date: Wed, 1 Feb 2006 14:32:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060201133219.GA1435@elte.hu>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131.024323.83813817.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@davemloft.net> wrote:

> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Tue, 31 Jan 2006 21:27:58 +1100
> 
> > tcp_close is only called from process context.  The rule for sk_dst_lock
> > is that it must also only be obtained in process context.  On the other
> > hand, it is true that sk_lock can be obtained in softirq context.
> > 
> > In this particular case, sk_dst_lock is obtained by tcp_close with
> > softirqs disabled.  This is not a problem in itself since we're not
> > trying to get sk_dst_lock from a real softirq context (as opposed to
> > process context with softirq disabled).
> > 
> > I believe this warning comes about because the validator creates a
> > dependency between sk_lock and sk_dst_lock.  It then infers from this
> > dependency that in softirq contexts where sk_lock is obtained the code
> > may also attempt to obtain sk_dst_lock.
> > 
> > This inference is where the validator errs.  sk_dst_lock is never
> > (or should never be, and as far as I can see none of the traces show
> > it to do so) obtained in a real softirq context.
> 
> Herbert's analysis is correct.  This unique locking strategy is used 
> by tcp_close() because at this point it knows that every single 
> reference to this socket in the system is gone once it takes the 
> socket lock with BH disabled.
> 
> And that known invariant is why this is correct, and the locking 
> validator has no way to figure this out.

update: with all of Herbert's fixes i havent gotten these yet - so maybe 
the validator was not producing a false positive, but perhaps the 
inet6_destroy_sock()->sk_dst_reset() thing was causing the messages?

	Ingo
