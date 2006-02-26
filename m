Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWBZWiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWBZWiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBZWiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:38:22 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:19161 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751411AbWBZWiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:38:22 -0500
Date: Sun, 26 Feb 2006 23:38:05 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt17
In-Reply-To: <Pine.LNX.4.58.0602260952590.2842@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602262317120.7277-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Feb 2006, Steven Rostedt wrote:

>
> Please inline patches!  it makes it a lot easier to comment on.
>
Ok, I set up the alternative editor in Pine now, so I can do it in the future.

>
> On Sat, 25 Feb 2006, Esben Nielsen wrote:
> > On Sat, 25 Feb 2006, Steven Rostedt wrote:
> > > On Sat, 25 Feb 2006, Esben Nielsen wrote:
> > >
> > > >
> > > > You didn't use the "TestRTMutex" I send along with the patch :-(
>
> These are good to have, but it should not be included in a kernel patch.
> You can always host this tool too.
>
On the contrary: The kernel should have a test/ directy at the top level and
a "make test" target which runs all sort of unit-tests. For all patches to be
accepted make test should be succesfull. Unit tests are best when maintained
along with the code it tests.

> > > >
> > > > Since I learned to use unittesting that way I have been a big fan. It does
> > > > catch a lot of stupid bugs without having to wait for the program to get
> > > > there while keeping the ability to debug with gdb and fix it right away.
> > > > And most important: you can keep the tests and check if your program still
> > > > parses them after a rewrite. Very usefull to prevent repeating bugs.
> > > >
> > > > So here is the issues I have found:
> > > >
> > > > 1) grablockBKL.tst failes. Apparently you can "grab" the BKL now? Is this
> > > > intended? I have updated the test to accept this.
> > >
> > > since the BKL is now released on semaphores, I guess this is ok.
> >
> > When I started on the tester this was so as well. It is a basic feature of
> > CONFIG_PREEMPT_BKL that you release the BKL semaphore when you block. The
> > problem in PREEMT_RT is that if you block in spin_lock() you should _not_
> > give BKL away.
>
> And we don't. The BKL is held, we fool the scheduler by lowering setting
> the lock depth to below zero, so the scheduler doesn't think we own it.
> Or did you test program not realize that?
>

Yes, it did. Here is teh test script (this time inlined):

#priorities:
threads:     101          102
#BKL is lock 0

           lock 0     spinlock 1
test:          +           +
test:      prio 101    prio 102

#Reverse the locks:
        spinlock 1       lock 0

#You do _not_ give away the BKL on a spin lock. Therefore we deadlock.
test:          -           -
test:     prio 101     prio 102


There is a test without spinlock, but just lock (meaning down). This will not
deadlock because BKL is given away.

> [...]
>
>
> > And now I remember why you couldn't grab BKL as any other lock before: The
> > pending owner flag was on the task. Now if you could grab BKL you could be
> > pending owner of both BKL and another mutex. With the new pending owner
> > implementation this is no longer a problem.
>
> Correct, but it still causes problems in the logic. Say task A blocks on
> semaphore X, which is owned by task B (which had the BKL and released it
> on schedule). But B is also blocked on semaphore Y.  Task A wakes B and
> when B goes to grab the BKL it blocks. Thus you are boosting two lines of
> pi. This is a really bad design, which was easily solved by releasing the
> BKL outside, of the rt_mutex logic.  When B really does have semaphore Y
> it then grabs the BKL.  This way if it fails, the pi logic is still sane.

*nod*

>
>  >
> > >
> > > >
> > > > 2) 2locksdeadlock.tst loops forever. It is a livelock: When two RT-tasks
> > > > "deadlocks" on two mutexes they keep waking up each other in other. I
> > > > quickly fixed that bug.
> > >
> > > I actually thought about that.  But it still is an improvement, since it
> > > doesn't deadlock the kernel. Just all processes that are of lower
> > > priority.
> >
> > Which are almost all the processes since only RT tasks can do this....
>
> And remember that this is also only a problem with futexes, since there
> are no deadlocks in the kernel ;-)  So if you have an RT task higher than
> all the others, it will still run. Allowing you to at least shutdown the
> machine nicely :)

Yeah, but futexes with PI will be something comming back in soonish I think.

>
> >
> > >  This still should be fixed, but it needs to not cause any
> > > noticable overhead.
> >
> > With this patch there is less overhead than before:
> > wake_up_process_mutex() is called less often.
> >
>
> Does it detect deadlocks??

No, it just only wake up the blocked owner after changing the priortu
when the priority is actually changed.

> [...]
> > >
> > > I'll take a look at this tomorrow.
> > >
>
> I'm looking at the last patch you sent:
>
> +static void adjust_prio_no_wakeup(task_t *task)
>  {
>         int prio = calc_pi_prio(task);
>
> -       if (task->prio != prio)
> +       if (task->prio != prio) {
> +               mutex_setprio(task, prio);
> +       }
> +}
>
> Remove the brackets.
>
> +static void adjust_prio_wakeup(task_t *task)
> +{
> +       int prio = calc_pi_prio(task);
> +
> +       if (task->prio < prio) {
>
> will always be false, since cal_pi_prio returns the highest priority of
> either the task or one of it's waiters (the lower prio is, the higher the
> priority).
>

No:

/*
 * Calculate task priority from the waiter list priority
 *
 * Return task->normal_prio when the waiter list is empty or when
 * the waiter is not allowed to do priority boosting
 */
static inline int calc_pi_prio(task_t *task)
{
	int prio = task->normal_prio;
...

When PI boosted task->prio < task->normal_prio and the condition can be true.
Notice that adjust_prio_wakeup() is called from remove_waiter().

> -- Steve
>

Esben

