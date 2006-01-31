Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWAaKn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWAaKn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAaKn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:43:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23250
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750743AbWAaKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:43:25 -0500
Date: Tue, 31 Jan 2006 02:43:23 -0800 (PST)
Message-Id: <20060131.024323.83813817.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: mingo@elte.hu, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe ->
 soft-unsafe lock dependency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060131102758.GA31460@gondor.apana.org.au>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au>
	<20060128152204.GA13940@elte.hu>
	<20060131102758.GA31460@gondor.apana.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 31 Jan 2006 21:27:58 +1100

> tcp_close is only called from process context.  The rule for sk_dst_lock
> is that it must also only be obtained in process context.  On the other
> hand, it is true that sk_lock can be obtained in softirq context.
> 
> In this particular case, sk_dst_lock is obtained by tcp_close with
> softirqs disabled.  This is not a problem in itself since we're not
> trying to get sk_dst_lock from a real softirq context (as opposed to
> process context with softirq disabled).
> 
> I believe this warning comes about because the validator creates a
> dependency between sk_lock and sk_dst_lock.  It then infers from this
> dependency that in softirq contexts where sk_lock is obtained the code
> may also attempt to obtain sk_dst_lock.
> 
> This inference is where the validator errs.  sk_dst_lock is never
> (or should never be, and as far as I can see none of the traces show
> it to do so) obtained in a real softirq context.

Herbert's analysis is correct.  This unique locking strategy
is used by tcp_close() because at this point it knows that
every single reference to this socket in the system is gone
once it takes the socket lock with BH disabled.

And that known invariant is why this is correct, and the locking
validator has no way to figure this out.
