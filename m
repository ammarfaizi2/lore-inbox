Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbRAPDyB>; Mon, 15 Jan 2001 22:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbRAPDxu>; Mon, 15 Jan 2001 22:53:50 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:25785 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130132AbRAPDxf>; Mon, 15 Jan 2001 22:53:35 -0500
Message-ID: <3A63BB5A.9BDCCFE8@mvista.com>
Date: Mon, 15 Jan 2001 19:09:14 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: nigel@nrg.org, Roger Larsson <roger.larsson@norran.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latency: allowing resheduling while holding spin_locks
In-Reply-To: <Pine.LNX.4.05.10101131335380.10740-100000@cosmic.nrg.org> <3A60ED83.1B70410A@mvista.com> <01011523020003.01217@dox>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> On Sunday 14 January 2001 01:06, george anzinger wrote:
> > Nigel Gamble wrote:
> > > On Sat, 13 Jan 2001, Roger Larsson wrote:
> > > > A rethinking of the rescheduling strategy...
> > >
> > > Actually, I think you have more-or-less described how successful
> > > preemptible kernels have already been developed, given that your
> > > "sleeping spin locks" are really just sleeping mutexes (or binary
> > > semaphores).
> > >
> > > 1.  Short critical regions are protected by spin_lock_irq().  The maximum
> > > value of "short" is therefore bounded by the maximum time we are happy
> > > to disable (local) interrupts - ideally ~100us.
> > >
> > > 2.  Longer regions are protected by sleeping mutexes.
> > >
> > > 3.  Algorithms are rearchitected until all of the highly contended locks
> > > are of type 1, and only low contention locks are of type 2.
> > >
> > > This approach has the advantage that we don't need to use a no-preempt
> > > count, and test it on exit from every spinlock to see if a preempting
> > > interrupt that has caused a need_resched has occurred, since we won't
> > > see the interrupt until it's safe to do the preemptive resched.
> >
> > I agree that this was true in days of yore.  But these days the irq
> > instructions introduce serialization points and, me thinks, may be much
> > more time consuming than the "++, --, if (false)" that a preemption
> > count implemtation introduces.  Could some one with a knowledge of the
> > hardware comment on this?
> >
> > I am not suggesting that the "++, --, if (false)" is faster than an
> > interrupt, but that it is faster than cli, sti.  Of course we are
> > assuming that there is <stuff> between the cli and the sti as there is
> > between the ++ and the -- if (false).
> >
> 
> The problem with counting scheme is that you can not schedule inside any
> spinlock - you have to split them up. Maybe you will have to do that anyway.
> But if your RT process never needs more memory - it should be quite safe.
> 
> The difference with a sleeping mutex is that it can be made lazier - keep it
> in the runlist, there should be very few...
> 
Nigel and I agree on the approach he has layed out with the possible
exception of just how to handle the short spinlocks.  It is agreed that
we can not preempt a task that has a spinlock.  He suggests that the
overhead of testing for preemption on the exit of a spinlock protected
with the preempt_count is higher than the cost of turning off and on the
interrupt system.  He may well be right, and surly was right 5 or 10
years ago.  Today the cost of an cli or sti is much higher relative to
the memory references, especially if we don't need to make the result
visible to other processors (and we don't).  We only have to serialize
WRT our own interrupt system, but the interrupt itself will do this, and
only when we need it.

snip

WRT your patch, A big problem with simple sleeping mutexes is that of
priority inversion.  An example:

Given tasks L of low priority, M of medium, and H of high and X a mutex.
If L is holding X when it is preempted by M and
M wants to run a long time....
Then when H preempts M and trys to get X it will have to wait while M
does his thing, just because L can not get the cycles needed to get out
of X.

A priority inherit mutex (pi_mutex) handles this by, when H trys to get
X, boosting the priority of L (the holder of X) to its own priority
until L releases X.  At this point L reverts to its prior priority and H
continues, now having suceeded in getting X.  This is all complicated,
of course, by remembering that a task can hold several mutexes at a time
and each can have several waiters.

>From a real time point of view, we would NEVER want to scan the task
list looking for someone to wake up.  We should know who to wake up from
the getgo.  Likewise, clutter in the run_list adds wasted cycles and
cache lines to the schedule process.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
