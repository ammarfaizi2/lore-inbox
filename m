Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRC3U01>; Fri, 30 Mar 2001 15:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRC3U0R>; Fri, 30 Mar 2001 15:26:17 -0500
Received: from out2.prserv.net ([32.97.166.32]:30453 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S131020AbRC3U0E>;
	Fri, 30 Mar 2001 15:26:04 -0500
Message-Id: <m14j5FD-001PKFC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: nigel@nrg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Thu, 29 Mar 2001 16:26:44 PST."
             <Pine.LNX.4.05.10103291555390.8122-100000@cosmic.nrg.org> 
Date: Sat, 31 Mar 2001 06:11:39 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.05.10103291555390.8122-100000@cosmic.nrg.org> you write:
> Here is an attempt at a possible version of synchronize_kernel() that
> should work on a preemptible kernel.  I haven't tested it yet.

It's close, but...

Those who suggest that we don't do preemtion on SMP make this much
easier (synchronize_kernel() is a NOP on UP), and I'm starting to
agree with them.  Anyway:

> 		if (p->state == TASK_RUNNING ||
> 				(p->state == (TASK_RUNNING|TASK_PREEMPTED))) {
> 			p->flags |= PF_SYNCING;

Setting a running task's flags brings races, AFAICT, and checking
p->state is NOT sufficient, consider wait_event(): you need p->has_cpu
here I think.  You could do it for TASK_PREEMPTED only, but you'd have
to do the "unreal priority" part of synchronize_kernel() with some
method to say "don't preempt anyone", but it will hurt latency.
Hmmm...

The only way I can see is to have a new element in "struct
task_struct" saying "syncing now", which is protected by the runqueue
lock.  This looks like (and I prefer wait queues, they have such nice
helpers):

	static DECLARE_WAIT_QUEUE_HEAD(syncing_task);
	static DECLARE_MUTEX(synchronize_kernel_mtx);
	static int sync_count = 0;

schedule():
	if (!(prev->state & TASK_PREEMPTED) && prev->syncing)
		if (--sync_count == 0) wake_up(&syncing_task);

synchronize_kernel():
{
	struct list_head *tmp;
	struct task_struct *p;

	/* Guard against multiple calls to this function */
	down(&synchronize_kernel_mtx);

	/* Everyone running now or currently preempted must
	   voluntarily schedule before we know we are safe. */
	spin_lock_irq(&runqueue_lock);
	list_for_each(tmp, &runqueue_head) {
		p = list_entry(tmp, struct task_struct, run_list);
		if (p->has_cpu || p->state == (TASK_RUNNING|TASK_PREEMPTED)) {
			p->syncing = 1;
			sync_count++;
		}
	}
	spin_unlock_irq(&runqueue_lock);

	/* Wait for them all */
	wait_event(syncing_task, sync_count == 0);
	up(&synchronize_kernel_mtx);
}

Also untested 8),
Rusty.
--
Premature optmztion is rt of all evl. --DK
