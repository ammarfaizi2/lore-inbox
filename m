Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTHRNKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTHRNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:10:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61824 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271820AbTHRNKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:10:24 -0400
Date: Mon, 18 Aug 2003 14:09:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030818130911.GD7147@mail.jlokier.co.uk>
References: <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de> <20030816213901.GA25483@mail.jlokier.co.uk> <20030817144203.J670@nightmaster.csn.tu-chemnitz.de> <20030817200253.GA3543@mail.jlokier.co.uk> <20030818123829.L670@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818123829.L670@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Sun, Aug 17, 2003 at 09:02:53PM +0100, Jamie Lokier wrote:
> > It's because of the "wakee doesn't preempt waker" heuristic you
> > mentioned. 
> 
> Which could have strange effects, if not put in a scheduler class
> unreachable by the normal user or be at least a compile-out option.

Increasingly, a new type of futex with a hook into the scheduler looks
like the right answer to this question.  But I prefer not to need a
kernel patch.  Like most people with this dilemma, my programs are
likely to be run by folk who will not use non-mainstream kernels.

> That's why I didn't even considered solving it in the kernel
> scheduler and basically suggested rolling the scheduling of this
> special case your own ;-)

Indeed.  But how do you suggest rolling a scheduler on my own while
the kernel is blocking me? :)

> > Ingo Oeser wrote:
> > > Yes, I thought you are trying to solve a realtime latency
> > > problem. Instead you seem to be trying to solve a throughput
> > > problem.
> > 
> > No, I am trying to solve both problems together. 
> 
> So you are on a quest for the holy grail of the real time people.
> Do them a favor and write at least a paper about how you solved
> this and I'll have even more good arguments (pro Linux) for my
> new employer.

Heh :)  Am not really aiming for real-time, just reasonable response
times and no unnecessary idle time.  My goal is web servers, file
servers, database servers and interactive apps.  Real-time could be
another goal - does your employer pay for good papers? ;)

> > Most of the little state machines will be able to do their work
> > quickly, and satisfy desired low latencies so long as the data they
> > need is not stalled behind a slow I/O, but some of the little state
> > machines will just seem to pause for a long time _even when they are
> > not stalled by I/O requirements_.
>  
> Now I completely understand your problem. Does it also arise, if
> your application is alone on the machine? If it doesn't then you
> are just hit by the bad programming of other people.

It _only_ arises if the application is alone.  When there are others,
its quite reasonable to expect to be preempted, if we are not doing real-time.

When the application is alone those unwanted long stalls occur when an
application has _self-contention_, due to running too many kernel
worker threads which preempt each other.

This is the main fundamental reason for not just running lots of
threads.  (Secondary reasons are to reduce memory consumption and
reduce locking requirements).

> > This gives good throughput, but makes certain latency guarantees,
> > namely "if I do not actually wait for I/O I should not spontaneously
> > delay for a long time", very difficult to guarantee.
> 
> You can't guarantee that, if you are not higher priority AND in
> the realtime scheduler class (which you like to avoid, as seen
> below). There are other applications, which
> might want to run, even you are busy.

Quite; it's ok to give up CPU under those circumstances.  That is
fair, and not wasting anything.

> [SIGCONT/SIGSTOP as wakeup/wait]
> > It is not perfect, because of the large number of additional kill()
> > syscalls, and it doesn't help with blocking due to VM paging, but it's
> > a fine solution in principle.
>  
> It helps a lot, since you want these signals to have SIG_DFL
> handlers an thus they'll never reach user space. This could be
> made a fast path, if your usage pattern gets its lobby.

Even this "fast path" is two extra syscalls per original syscall.
Syscalls are not that fast that we are happy to sprinkle them around.

> And if the VM pages, you better not interfere, since you have not
> enough knowledge about the overall system state to interfere. If
> it becomes a problem, better fix the VM for low latency. The
> audio people will kiss your feet for that.

There is nothing wrong with trying to do some other work during a VM
page-in.  Folk do it all the time, it's called running multiple threads :)

> > There's a scheduling heuristic problem if SIGCONT were to run the
> > other thread immediately, as the shadow task is likely to be classed
> > as "interactive".  However, Con's "wakee doesn't preempt waker"
> > strategy may or may not prevent this.
> 
> This doesn't matter, since the thread will immediately block, if
> there is no work to do.

It matters because of two unwanted context switches per original
syscall.  That's overhead which would outweigh the gain in many benchmarks.

> But I would still prefer a timeout here
> to determine 'blocks too long' with this solution, to avoid even
> the context switch, when it's not necessary.
> 
> > What makes more sense to me is to wake up the shadow task, using a
> > futex, and leave the shadow task in the woken state all the time.
> > When it eventually runs, it checks whether its active partner is
> > currently running, and if so goes back to sleep, waiting on the futex.
>  
> Thats my 'work indicator'. My problem with this solution is that
> this activation is non-sense, if you go asleep most of the time.
> I timer will prevent exactly this, but will limit throughput as
> you added.

The point of wake-without-putting-back-to-sleep is to avoid most of
the extra syscalls and the context switches.  Otherwise the overhead
of the mechanism makes it perform poorly in the cases where there is
very little blocking.

-- Jamie
