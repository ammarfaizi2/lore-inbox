Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRDFX6C>; Fri, 6 Apr 2001 19:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132459AbRDFX5x>; Fri, 6 Apr 2001 19:57:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56488 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132439AbRDFX5l>; Fri, 6 Apr 2001 19:57:41 -0400
Subject: Re: [PATCH for 2.5] preemptible kernel
To: rusty@rustcorp.com.au, nigel@nrg.org
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFC4BD5737.728E9896-ON88256A26.008088FF@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Fri, 6 Apr 2001 16:52:25 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/06/2001 05:57:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please accept my apologies if I am missing something basic, but...

1.   On a busy system, isn't it possible for a preempted task
     to stay preempted for a -long- time, especially if there are
     lots of real-time tasks in the mix?

2.   Isn't it possible to get in trouble even on a UP if a task
     is preempted in a critical region?  For example, suppose the
     preempting task does a synchronize_kernel()?

If I understand the preemptible kernel patch, suppressing preemption
is quite cheap -- just increment preempt_count before and decrement
it after, with no locks, atomic operations, or disabling of interrupts
required.  I understand that disabling preemption for any long time
is a Bad Thing, however, Dipankar's patch is able to detect situations
where preemption has been suppressed for too long.  In addition, Rusty's
original synchronize_kernel() patch is much simpler than the two that
wait for preempted tasks to reach a voluntary context switch.

What am I missing here?

                                   Thanx, Paul

> > Here is an attempt at a possible version of synchronize_kernel() that
> > should work on a preemptible kernel. I haven't tested it yet.
>
> It's close, but...
>
> Those who suggest that we don't do preemtion on SMP make this much
> easier (synchronize_kernel() is a NOP on UP), and I'm starting to
> agree with them. Anyway:
>
> > if (p->state == TASK_RUNNING ||
> > (p->state == (TASK_RUNNING|TASK_PREEMPTED))) {
> > p->flags |= PF_SYNCING;
>
> Setting a running task's flags brings races, AFAICT, and checking
> p->state is NOT sufficient, consider wait_event(): you need p->has_cpu
> here I think. You could do it for TASK_PREEMPTED only, but you'd have
> to do the "unreal priority" part of synchronize_kernel() with some
> method to say "don't preempt anyone", but it will hurt latency.
> Hmmm...
>
> The only way I can see is to have a new element in "struct
> task_struct" saying "syncing now", which is protected by the runqueue
> lock. This looks like (and I prefer wait queues, they have such nice
> helpers):
>
>         static DECLARE_WAIT_QUEUE_HEAD(syncing_task);
>         static DECLARE_MUTEX(synchronize_kernel_mtx);
>         static int sync_count = 0;
>
> schedule():
>         if (!(prev->state & TASK_PREEMPTED) && prev->syncing)
>                 if (--sync_count == 0) wake_up(&syncing_task);
>
> synchronize_kernel():
> {
>         struct list_head *tmp;
>         struct task_struct *p;
>
>         /* Guard against multiple calls to this function */
>         down(&synchronize_kernel_mtx);
>
>         /* Everyone running now or currently preempted must
>            voluntarily schedule before we know we are safe. */
>         spin_lock_irq(&runqueue_lock);
>         list_for_each(tmp, &runqueue_head) {
>                 p = list_entry(tmp, struct task_struct, run_list);
>                 if (p->has_cpu || p->state
== (TASK_RUNNING|TASK_PREEMPTED)) {
>                         p->syncing = 1;
>                         sync_count++;
>                 }
>         }
>         spin_unlock_irq(&runqueue_lock);
>
>         /* Wait for them all */
>         wait_event(syncing_task, sync_count == 0);
>         up(&synchronize_kernel_mtx);
> }
>
> Also untested 8),
> Rusty.

