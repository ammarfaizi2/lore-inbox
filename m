Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWFUINY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWFUINY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWFUINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:13:24 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:58296 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751313AbWFUINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:13:23 -0400
Date: Wed, 21 Jun 2006 04:13:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606210406310.29673@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
 <1150816429.6780.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2006, Esben Nielsen wrote:
> >>
> >> Let say you have a bunch of callback running at priority 1 and then the
> >> next hrt timer with priority 99 expires. Then the callback which
> >> is running will be boosted to priority 99. So the overall latency at
> >> priority 99 will at least the latency of the worst hrtimer callback.
> >
> > You mean for those that expire at the same time?
> >
>
> No, when the priority 1 (userspace prio) expires just before the
> priority 99.

So you are worried about a priority 1 timer running when the 99 priority
timer expires?  In this case we should up the timer softirq to 99 and make
the currently running timer just like a critical section.  So the latency
would be just the time of the longest running timer callback.

>
> > I don't think this is a problem, because the run_hrtimer_hres_queue runs
> > the hightest priorty callback first, then it adjusts its prio to the next
> > priority callback.  See hrtimer_adjust_softirq_prio.
> >
> >> And worse: What if the callback running is blocked on a mutex? Will the
> >> owner of the mutex be boosted as well? Not according to the code in
> >> sched.c. Therefore you get priority inversion to priority 1. That is the
> >> worst case hrtimer latency is that of priority 1.
> >
> > I don't see this.
>
> Look at this situation:
> softirq-hrt, running some callback, is priority 1 (US prio as always)
> blocked for a mutex owned by some task, A. This now have priority 1 (in
> the worst case).The HRT interrupt comes and calls setscheduler(... prio 99).
> That doesn't change the priority of task A as far as I can see from the code.
> So in effect the priority 99 callback will wait for task A which is still
> priority 1. That is a priority inversion.

OK, that sounds like a bug.

>
> >
> >>
> >> Therefore, a simpler and more robust design would be to give the thread
> >> priority 99 as a default - just as the posix_cpu_timer thread. Then the
> >> system designer can move it around with chrt when needed.
> >> In fact you can say the current design have both the worst cases of having
> >> it running as priority 99 and at priority 1!
> >
> > I still don't see this happening.
>
> The two worst cases are:
> 1) The system wide system 99 worst case latency is at least that of the
> longest callback.

If the above bug is fixed, that should read "at most" that of the longest
callback.

> 2) The worst case latency of softirq-hrt is that of priority 1.

We really do need the softirq-hrt dynamic. For what I deal with it helps a
lot.  I want the sleeping high priority task wake up when its timer goes
off, and I don't want it preempted when it's not sleeping by timers of
lower priority tasks.

>
> If you could set it by chrt you could at least choose which evil thing you
> want.

Doesn't work for my situation. Unless I tell the application programers to
up the timer softirq-hrt just before the highest prio thread goes to
sleep. But they are Java programmers and I don't expect them to do this ;)

>
> >
> >>
> >> Another complicated design would be to make a task for each priority.
> >> Then the interrupt wakes the highest priority one, which handles the first
> >> callback and awakes the next one etc.
> >
> > Don't think that is necessary.
>
> Me neither :-) Running sofhtirq-hrt at priority 99 - or whatever is
> set by chrt - should be sufficient.

No, I think fixing the bug you found is better :)

-- Steve
