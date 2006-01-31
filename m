Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAaK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAaK2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWAaK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:28:21 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:50693 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750734AbWAaK2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:28:20 -0500
Date: Tue, 31 Jan 2006 21:27:58 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060131102758.GA31460@gondor.apana.org.au>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128152204.GA13940@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 04:22:04PM +0100, Ingo Molnar wrote:
> 
>  ===========================================================
>  [ BUG: soft-safe -> soft-unsafe lock dependency detected! ]
>  -----------------------------------------------------------
>  sshd/2853 [HC0[0]:SC0[1]:HE1:SE0] is trying to acquire:
>   (&newsk->sk_dst_lock){+-}, at: [<c048f385>] inet6_destroy_sock+0x25/0x100
>  
>  and this task is already holding:
>   (&((sk)->sk_lock.slock)){+-}, at: [<c0464832>] tcp_close+0x142/0x650
>  which would create a new lock dependency:
>    (&((sk)->sk_lock.slock)){+-} -> (&newsk->sk_dst_lock){+-}

OK, I believe this is a false positive.  However, Dave should
double-check this.

tcp_close is only called from process context.  The rule for sk_dst_lock
is that it must also only be obtained in process context.  On the other
hand, it is true that sk_lock can be obtained in softirq context.

In this particular case, sk_dst_lock is obtained by tcp_close with
softirqs disabled.  This is not a problem in itself since we're not
trying to get sk_dst_lock from a real softirq context (as opposed to
process context with softirq disabled).

I believe this warning comes about because the validator creates a
dependency between sk_lock and sk_dst_lock.  It then infers from this
dependency that in softirq contexts where sk_lock is obtained the code
may also attempt to obtain sk_dst_lock.

This inference is where the validator errs.  sk_dst_lock is never
(or should never be, and as far as I can see none of the traces show
it to do so) obtained in a real softirq context.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
