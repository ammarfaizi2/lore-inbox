Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbRICCOh>; Sun, 2 Sep 2001 22:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271082AbRICCO3>; Sun, 2 Sep 2001 22:14:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24087 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271072AbRICCOJ>; Sun, 2 Sep 2001 22:14:09 -0400
Date: Mon, 3 Sep 2001 04:14:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre2aa3
Message-ID: <20010903041457.F699@athlon.random>
In-Reply-To: <20010901193711.B30745@athlon.random> <p05100303b7b887a0a664@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05100303b7b887a0a664@[207.213.214.37]>; from jlundell@pobox.com on Sun, Sep 02, 2001 at 06:21:42PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc'ed to l-k with Jonathan's approval ]

On Sun, Sep 02, 2001 at 06:21:42PM -0700, Jonathan Lundell wrote:
> At 7:37 PM +0200 2001-09-01, Andrea Arcangeli wrote:
> >Only in 2.4.10pre2aa3: 00_x86-sa_interrupt-1
> >Only in 2.4.10pre2aa3: 54_uml-sa_interrupt-1
> >
> >	Don't break SA_INTERRUPT with shared irqs. (long term fix
> >	is to get rid of SA_INTERRUPT altogether)
> 
> Thanks for picking up the patch. A minor point: if you feel compelled 
> to use the if/else construction (I wouldn't), it would be prettier to 
> say:
> 
> 
> +		if (action->flags & SA_INTERRUPT)
> +			__cli();
> +		else
> +			__sti();
> +

Well, I tend to think the "if true" case as the fast path, and nobody
should use SA_INTERRUPT so... ;)

> I have a couple of other comments about this routine.
> 
> One is the SA_SAMPLE_RANDOM logic. The logic
> 
> 	if (status & SA_SAMPLE_RANDOM)
> 		add_interrupt_randomness(irq);
> 
> gets invoked if any driver in the action chain has SA_SAMPLE_RANDOM 
> set. This is not correct; it should be invoked only if the flag is 

Agreed, but the SA_SAMPLE_RANDOM flag should die as well as the
SA_INTERRUPT flag: we should call add_interrupt_randomness in the irq
handler, this will improve performance and it will solve such bug as
well.

> The Solaris approach is for handlers to be declared boolean, and to 
> return a flag indicating that they actually processed an interrupt. 
> Since Linux handlers are void, and since there are a lot of them, 
> this would be a pretty disruptive change.
> 
> A more gentle change would be to implement two SA_ flags, one to say 
> explicitly that an interrupt had been handled, and the other to say 
> that one had not. The caller would clear both flags before calling 
> the handler; if both flags came back clear it would indicate an 
> old-style handler and we'd perform some default action.

I don't like to do such work in the highlevel code, it's just a waste of
cpu cycles.

> This might be relevant to my last comment, on a comment at the head 
> of request_irq():
> 
> /*
>   * This should really return information about whether
>   * we should do bottom half handling etc. Right now we
>   * end up _always_ checking the bottom half, which is a
>   * waste of time and is not what some drivers would
>   * prefer.
>   */
> 
> Is this still valid, given the relatively recent 2.4.x cleanup of 
> softirq/bh logic? If so, similar considerations apply here as with 

Theoretically it could be still valid but again if we want to change
such part of the irq handler API I'd prefer if the irq handler will be
required to do the softirq check itself before returning if it did
anything that could raise a softirq (this will avoid checks on the
return value and a branch in the irq highlevel code).

Also it would be a dubious optimization to add yet another branch to the
highlevel code to choose if to do such a light check (ok, the irq
handler retval check would always execute in CPU core but the pending
softirq cacheline is quite hot anyways usually).

So I think the comment will never apply to the code.

Andrea
