Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTHRKlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 06:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271376AbTHRKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 06:41:13 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:61597 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S271375AbTHRKlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 06:41:06 -0400
Date: Mon, 18 Aug 2003 12:38:29 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030818123829.L670@nightmaster.csn.tu-chemnitz.de>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de> <20030816213901.GA25483@mail.jlokier.co.uk> <20030817144203.J670@nightmaster.csn.tu-chemnitz.de> <20030817200253.GA3543@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030817200253.GA3543@mail.jlokier.co.uk>; from jamie@shareable.org on Sun, Aug 17, 2003 at 09:02:53PM +0100
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19ohRf-0007pX-00*dhtu8UlAb.M*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sun, Aug 17, 2003 at 09:02:53PM +0100, Jamie Lokier wrote:
> It's because of the "wakee doesn't preempt waker" heuristic you
> mentioned. 

Which could have strange effects, if not put in a scheduler class
unreachable by the normal user or be at least a compile-out option.

That's why I didn't even considered solving it in the kernel
scheduler and basically suggested rolling the scheduling of this
special case your own ;-)

> Ingo Oeser wrote:
> > Yes, I thought you are trying to solve a realtime latency
> > problem. Instead you seem to be trying to solve a throughput
> > problem.
> 
> No, I am trying to solve both problems together. 

So you are on a quest for the holy grail of the real time people.
Do them a favor and write at least a paper about how you solved
this and I'll have even more good arguments (pro Linux) for my
new employer.

> Most of the little state machines will be able to do their work
> quickly, and satisfy desired low latencies so long as the data they
> need is not stalled behind a slow I/O, but some of the little state
> machines will just seem to pause for a long time _even when they are
> not stalled by I/O requirements_.
 
Now I completely understand your problem. Does it also arise, if
your application is alone on the machine? If it doesn't then you
are just hit by the bad programming of other people.

> This gives good throughput, but makes certain latency guarantees,
> namely "if I do not actually wait for I/O I should not spontaneously
> delay for a long time", very difficult to guarantee.

You can't guarantee that, if you are not higher priority AND in
the realtime scheduler class (which you like to avoid, as seen
below). There are other applications, which
might want to run, even you are busy.

stupid example:
   Consider syslogd logging loads of your debugging messages,
   because if you debug your application like this you generate
   most debugging messages, if you are really busy.

> No, it is intended for server and interactive applications on machines
> which _may_ have other tasks running.
> 
> I'm saying two things about CPU utilisation: 1. the CPU should never
> be idle if my program has work to do that is not waiting on I/O;
> 2. it's ok to give some CPU up to other applications, _if there are
> any running_, but it's not ok to give other applications _more_ CPU
> than their fair share.

1. and 2. seem to contradict in practise :-(

[SIGCONT/SIGSTOP as wakeup/wait]
> It is not perfect, because of the large number of additional kill()
> syscalls, and it doesn't help with blocking due to VM paging, but it's
> a fine solution in principle.
 
It helps a lot, since you want these signals to have SIG_DFL
handlers an thus they'll never reach user space. This could be
made a fast path, if your usage pattern gets its lobby.

And if the VM pages, you better not interfere, since you have not
enough knowledge about the overall system state to interfere. If
it becomes a problem, better fix the VM for low latency. The
audio people will kiss your feet for that.

> There's a scheduling heuristic problem if SIGCONT were to run the
> other thread immediately, as the shadow task is likely to be classed
> as "interactive".  However, Con's "wakee doesn't preempt waker"
> strategy may or may not prevent this.

This doesn't matter, since the thread will immediately block, if
there is no work to do. But I would still prefer a timeout here
to determine 'blocks too long' with this solution, to avoid even
the context switch, when it's not necessary.

> What makes more sense to me is to wake up the shadow task, using a
> futex, and leave the shadow task in the woken state all the time.
> When it eventually runs, it checks whether its active partner is
> currently running, and if so goes back to sleep, waiting on the futex.
 
Thats my 'work indicator'. My problem with this solution is that
this activation is non-sense, if you go asleep most of the time.
I timer will prevent exactly this, but will limit throughput as
you added.

> Yes, one of SCHED_RR or SCHED_FIFO would do it perfectly :)
> 
> Unfortunately that's not acceptable in a multi-user environment,
> although SOFTRR _might_ work for some of the applications using this
> technique.
> 
> In general, though, I hope the "wakee doesn't preempt waker" scheduler
> heuristic will allow it to work, and still be fair in the presence of
> other appliciations.
> 
> > Maybe we need a yield_this(tid) for this kind of work.
> 
> Maybe.  I like to think the old Hierarchical Fair Scheduler patches
> had the right idea.  You could just use fixed priorities _within_
> a node in the tree, and it would work and be fair with other processes.

That is the perfect solution of your problem. You tell the kernel
your priorities within the application and forget all the hacks
we talked about.

Problem: This scheduler is more complex.
Solution: With a distinction between the group and the members of
   a group, where both can be set through syscalls would simplify
   it a lot and provide most things we want.

   Group can be either thread pool or process pool, with
   explicitly set members.

   Unfortunatly I neither have the time, nor the problem, nor the
   machines to implement this.

   Con? Ingo?

Regards

Ingo Oeser
