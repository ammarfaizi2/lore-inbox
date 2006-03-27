Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWC0PAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWC0PAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWC0PAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:00:30 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:30860 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751064AbWC0PA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:00:29 -0500
Date: Mon, 27 Mar 2006 16:00:24 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <20060327002105.GA29649@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603271501150.20599-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > > how do you guarantee that some other CPU doesnt send us on some
> > > goose-chase?
> >
> > How should another CPU suddenly be able to insert stuff into a lock
> > chain? Only the tasks themselves can do that and they are blocked on
> > some lock - at least when we tested in some previous iteration.
> > Ofcourse, they can have been signalled or timed out since, such they
> > are already unblocked when the deadlock is reported. But that is not
> > an error since the locks at some point actually were in a deadlock
> > situation.
>
> we are observing a non-time-coherent snapshot of the locking graph.
> There is no guarantee that due to timeouts or signals the chain we
> observe isnt artificially long - while if a time-coherent snapshot is
> taken it is always fine. E.g. lets take dentry locks as an example:
> their locking is ordered by the dentry (kernel-pointer) address. We
> could in theory have a 'chain' of subsequent locking dependencies
> related to 10,000 dentries, which are nicely ordered and create a
> 10,000-entry 'chain' if looked at in a non-time-coherent form. I.e. your
> code could detect a deadlock where there's none. The more CPUs there
> are, the larger the likelyhood is that other CPUs 'lure us' into a long
> chain.

I don't quite understand you examble: Are all 10,000 held at once?
If no, how are they all going to suddenly put into the lock chain due to
signals or timeouts? Those things unlocks locks and therefore breaks the
chain.

We need to cook up a specific examble we can discuss - also to see whether
it is a really an error or not.

>
> In other words: without taking all the locks we have no mathematical
> proof that we detected a deadlock!

Before you talk about a mathematical proof you need to make a mathematical
definition of a deadlock. Your definition seems to be that at some point
in time there is a circular dependency. (By the way: Time can be hard to
define too :-)

That definition does not make much sense in practice if you are rescued
by timeouts or signals within the time of the lock() call - which can be
very long as preemption is enabled in the prolog and the epilog of the call.

Deadlock detection therefore only makes sense in programs where the
mutex timeouts and signal spacing are long compared to the normal
timescale of the program. If not, the program will not "deadlock", i.e.
get stuck, but keep on running, even though at some point in time there
was a circular locking.

>
> also, how does the taking of 2 locks only improve latencies? We still
> have to hold the ->waiter_lock of this lock during this act, dont we? Or
> can we do boosting with totally unlocked (and interrupts-enabled)
> rescheduling points? If yes then the same situation could happen on UP
> too: if there's lots of rescheduling of this boosting chain.
>

Yes, lock->wait_lock is dropped during the iteration - otherwise it could
deadlock. The boosting is done with preemption and interrupts enabled once
in every iteration. And yes the problems you talk about are therefore
not specific to SMP but can also happen on UP - just with a lower rate.

> nevertheless it _might_ work in practice, and it's certainly elegant and
> thus tempting. Could you try to port your patch to -rt10? [you can skip
> most of the conflicting rt7->rt10 deltas in rtmutex.c i think.]
>

I'll try to see what I can do. I am bit busy right now. We are packing to
go to England for 4 months on Saturday. There are lot of practicalities
we are still missing - but ofcourse PI code much more fun :-) Maybe I can
"steal" some time tonight.

Esben

> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

