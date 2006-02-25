Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWBYVaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBYVaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWBYVaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:30:17 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:46023 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750758AbWBYVaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:30:15 -0500
Date: Sat, 25 Feb 2006 22:29:52 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt17
In-Reply-To: <Pine.LNX.4.58.0602251229400.19527@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602251924270.20024-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006, Steven Rostedt wrote:

>
> On Sat, 25 Feb 2006, Esben Nielsen wrote:
>
> > On Thu, 23 Feb 2006, Thomas Gleixner wrote:
> >
> > > On Wed, 2006-02-22 at 17:50 +0100, Esben Nielsen wrote:
> > > > I didn't know anyone looked at my patch! I am ofcourse happy about it :-)
> > >
> > > Was just delayed due to other work in progress.
> > >
> >
> > You didn't use the "TestRTMutex" I send along with the patch :-(
> >
> > Since I learned to use unittesting that way I have been a big fan. It does
> > catch a lot of stupid bugs without having to wait for the program to get
> > there while keeping the ability to debug with gdb and fix it right away.
> > And most important: you can keep the tests and check if your program still
> > parses them after a rewrite. Very usefull to prevent repeating bugs.
> >
> > So here is the issues I have found:
> >
> > 1) grablockBKL.tst failes. Apparently you can "grab" the BKL now? Is this
> > intended? I have updated the test to accept this.
>
> since the BKL is now released on semaphores, I guess this is ok.

When I started on the tester this was so as well. It is a basic feature of
CONFIG_PREEMPT_BKL that you release the BKL semaphore when you block. The
problem in PREEMT_RT is that if you block in spin_lock() you should _not_
give BKL away.
And now I remember why you couldn't grab BKL as any other lock before: The
pending owner flag was on the task. Now if you could grab BKL you could be
pending owner of both BKL and another mutex. With the new pending owner
implementation this is no longer a problem.

>
> >
> > 2) 2locksdeadlock.tst loops forever. It is a livelock: When two RT-tasks
> > "deadlocks" on two mutexes they keep waking up each other in other. I
> > quickly fixed that bug.
>
> I actually thought about that.  But it still is an improvement, since it
> doesn't deadlock the kernel. Just all processes that are of lower
> priority.

Which are almost all the processes since only RT tasks can do this....

>  This still should be fixed, but it needs to not cause any
> noticable overhead.

With this patch there is less overhead than before:
wake_up_process_mutex() is called less often.

>
> >
> > 3) While fixing that I came to think about what happens when you signal a
> > task blocked on a task blocked on a task. I thus wrote
> > 2lock3tasksBoostSignal.tst. Well, the priorities wasn't set back
> > correctly. I fixed that too.
> >

This time around wake_up_process_mutex() wasn't called when it ought to
be... Now that I think about it there still is a problem with the
patch I sent: First the priority is set down, then the task is woken up.
But then it can't continue to de-boost the next task... Let me write a
test with 4 tasks and 3 locks to demonstrate.


> > I have attached the patch againt 2.6.17-rt17 (and therefore also
> > included the previous patch) along with the updated tester and tests.
> >
> > Esben
>
> I'll take a look at this tomorrow.
>
> -- Steve
>
> >
> >
> > > > That was why I had _reversed_ the lock ordering relative to normal in the
> > > > original patch: First lock task->pi_lock. Assign lock. Lock
> > > > lock->wait_lock. Then unlock task->pi_lock. Now it is safe to refer to
> > > > lock. To avoid deadlocks I used _raw_spin_trylock() when locking the 2.
> > > > lock.
> > >
> > > Stupid me. I messed that one up. Should show up in the next -rt
> > >
> > > Thanks
> > >
> > > 	tglx
> > >
> > >
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

