Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQL0RHN>; Wed, 27 Dec 2000 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQL0RHE>; Wed, 27 Dec 2000 12:07:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14128 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129210AbQL0RGu>; Wed, 27 Dec 2000 12:06:50 -0500
Date: Wed, 27 Dec 2000 17:36:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
Message-ID: <20001227173604.C19378@athlon.random>
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>, <3A4937D2.B7FE7C28@uow.edu.au>; <20001227033459.A29610@athlon.random> <3A495A88.D44D19E6@uow.edu.au>, <3A495A88.D44D19E6@uow.edu.au>; <20001227043957.E29610@athlon.random> <3A49D659.843821FE@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A49D659.843821FE@uow.edu.au>; from andrewm@uow.edu.au on Wed, Dec 27, 2000 at 10:45:29PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 10:45:29PM +1100, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > 
> > Not a big deal but still I'd prefer the CONFIG_SMP #ifdef though, it looks even
> > more obvious that it's a compile check and at least in your usage I cannot see
> > a relevant readability advantage. And my own feeling is not having to rely on
> > more things to produce the wanted asm when there's no relevant advantage, but
> > if Linus likes it I won't object further.
> 
> Oh sob, what have you done?  My beautiful patch is full of ifdefs!

I was talking only about the CONFIG_SMP thing here. BTW, for other things you
could use the compiler too (instead of the preprocessor) if you really
wanted to.

The new way does:

	if (SMP_KERNEL && ...)
		xxx

instead of:

#ifdef CONFIG_SMP
	if (...)
		xxx
#endif

I don't see a big advantage in the first version (and it may waste stack). I
could see advantages if the SMP_KERNEL would be in the middle of a very complex
check, but the above usage wasn't the case.

> umm.. This use of queue_task almost _can't_ fail.  That's the point.

It can if the hardware fails. If hardware doesn't fail, also wake_up alomost
can't fail in the same way of queue_task.

> When kumon@fujitsu's 8-way was taking an oops in schedule() it took
> several days of mucking about to get the runqueue_lock deadlock out
> of the way. In fact we never got a decent backtrace because of it.

The runqueue_lock is completly unrelated to doing the wakeup in timer_bh.
runqueue_lock simply needs to be added to the bust_spinlocks() list so
we can see oops from schedule() in SMP.

> It's actually faster if you're doing more than one printk
> per jiffy.

Of course you can skip some wakeup with multiple printk at high frequency but
that has also the side effect that it will overflow the log buffer more easily
and that's not good either.

> > For the runqueue_lock right way to not having to trust schedule as well is to
> > add it to the bust_spinlocks list.
> 
> Yes.  Several weeks ago I did put up a patch which was designed to avoid
> all the remaining oops-deadlocks.  Amongst other things it did this:
> 
>         if (!oops_in_progress)
> 		wake_up_interruptible(&log_wait);
> 
> I'll resuscitate that patch.  Using this approach we can still get infinite
> recursion with WAITQUEUE_DEBUG enabled, but I guess we can live with that.

As said I think if wake_up can oops, queue_task can oops as well, so I don't
see a real advantage in the !oops_in_progress.

> Anyway, here's the revised patch.  Unless Linus wants SMP_KERNEL, I think
> we're done with this.

Thanks, I'll check it in some more time but so far it looks very good after a
short look ;)).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
