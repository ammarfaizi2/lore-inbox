Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTHQUEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTHQUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:04:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:28800 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270847AbTHQUDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:03:52 -0400
Date: Sun, 17 Aug 2003 21:02:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Con Kolivas <kernel@kolivas.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030817200253.GA3543@mail.jlokier.co.uk>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de> <20030816213901.GA25483@mail.jlokier.co.uk> <20030817144203.J670@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817144203.J670@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con, you're probably wondering what this thread has to do with you :)

It's because of the "wakee doesn't preempt waker" heuristic you
mentioned.  I would like to know if it had the properties described
below, near where I mention futexes.  Thanks :)

Nick Piggin wrote:
> Is it clear that this is a win over having a regular thread to
> perform the system call for you? Its obviously a lot more complicated.

See below.  It's about predictable latency (in the absense of
contention) and maximising throughput at the same time.

Ingo Oeser wrote:
> On Sat, Aug 16, 2003 at 10:39:01PM +0100, Jamie Lokier wrote:
> > Ingo Oeser wrote:
> > Nice idea, but it isn't quite right.  If my active task takes a second
> > in the system call, but doesn't block, I probably don't want the other
> > task to run at all.  There are occasions when a timer-initiated switch
> > like that would be useful, though.
>  
> Yes, I thought you are trying to solve a realtime latency
> problem. Instead you seem to be trying to solve a throughput
> problem.

No, I am trying to solve both problems together.  Throughput is easily
maximised by simply creating enough worker threads that the CPU is
never idle.  This is done by many server applications these days.

That causes unpredictable latencies, though.  If the userspace state
machines hardly ever block, for example because most of the filesystem
metadata they use is in cache, the worker threads will be scheduled by
the kernel as CPU hogs.

This means, and this is only an approximation, that each worker thread
will run for most or all of its timeslice, and then be preempted for a
_long time_ as each of the others runs for its portion of timeslice.

Most of the little state machines will be able to do their work
quickly, and satisfy desired low latencies so long as the data they
need is not stalled behind a slow I/O, but some of the little state
machines will just seem to pause for a long time _even when they are
not stalled by I/O requirements_.

This gives good throughput, but makes certain latency guarantees,
namely "if I do not actually wait for I/O I should not spontaneously
delay for a long time", very difficult to guarantee.

> > The real problem is that if my active task blocks immediately,
> > e.g. because I call open() and it issues a disk I/O, I want to
> > continue handling the next work item as soon as the CPU is free.  Not
> > after 1ms or 10ms of CPU idle time.
>  
> So you are always alone on the machine? You basically talk about
> completely occupying the CPU, if you application has any work
> to do without allowing any throuput to other maybe busy machines.

No, it is intended for server and interactive applications on machines
which _may_ have other tasks running.

I'm saying two things about CPU utilisation: 1. the CPU should never
be idle if my program has work to do that is not waiting on I/O;
2. it's ok to give some CPU up to other applications, _if there are
any running_, but it's not ok to give other applications _more_ CPU
than their fair share.

> > The ideal is something like async I/O, but that only works for a
> > subset of I/O operations, and it isn't practical to extend it to the
> > more complex I/O operations efficiently.  (Inefficiently, yes, but I
> > may as well use my own helper threads if that's what aio would use).
>  
> Yes, the big problem of vectorizing syscalls is error handling
> and errors following because of errors.

Vectorizing doesn't help.  In the example of 5 stat() calls, those
calls could easily be due to 5 different service state machines, each
responding to a different user request.  There's no easy way to work
out that they could have been submitted as a single vector.

This thread is about making system calls asynchronous; vector
syscalls are orthogonal to that, and best left for another time.

> This could be done today with having CPUs dedicated to thread
> sets. For processes we even have a solution to your problem: SIGSTOP
> and SIGCONT. You fork a shadow process for your running process and
> SIGSTOP it. If you think, you'll block you SIGCONT your shadow and
> the shadows blocks on your work indicator for you. If the
> maybe-blocking worker returns, it SIGSTOPs the shadow again.

Brilliant!  That's exactly what I had in mind. :)

It is not perfect, because of the large number of additional kill()
syscalls, and it doesn't help with blocking due to VM paging, but it's
a fine solution in principle.

There's a scheduling heuristic problem if SIGCONT were to run the
other thread immediately, as the shadow task is likely to be classed
as "interactive".  However, Con's "wakee doesn't preempt waker"
strategy may or may not prevent this.

What makes more sense to me is to wake up the shadow task, using a
futex, and leave the shadow task in the woken state all the time.
When it eventually runs, it checks whether its active partner is
currently running, and if so goes back to sleep, waiting on the futex.

This is nice because very few extra syscalls are needed: an occasional
FUTEX_WAIT and an occasional FUTEX_WAKE, but these aren't needed on
every potentially-blocking syscall.

The problem of course is that a nearly-always-runnable task will tend
to preempt the one which is running, so often that it become
inefficient.  It would be great if Con's "wakee doesn't preempt waker"
heuristic prevents this, and makes the shadow task behave as we want.

> Now the semantics work even better. You use SCHED_RR for
> scheduling and the normal task has a higher priority than the
> shadow. Now your task will BY DEFINITION always be scheduled
> until it blocks (strong priority scheduling here!).
> 
> It could be that I'm confusing this with SCHED_FIFO, but you get
> the idea ;-)

Yes, one of SCHED_RR or SCHED_FIFO would do it perfectly :)

Unfortunately that's not acceptable in a multi-user environment,
although SOFTRR _might_ work for some of the applications using this
technique.

In general, though, I hope the "wakee doesn't preempt waker" scheduler
heuristic will allow it to work, and still be fair in the presence of
other appliciations.

> Maybe we need a yield_this(tid) for this kind of work.

Maybe.  I like to think the old Hierarchical Fair Scheduler patches
had the right idea.  You could just use fixed priorities _within_
a node in the tree, and it would work and be fair with other processes.

-- Jamie
