Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWDRBsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWDRBsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 21:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWDRBsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 21:48:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53917 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932141AbWDRBsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 21:48:15 -0400
Subject: [RT] bad BUG_ON in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 21:48:07 -0400
Message-Id: <1145324887.17085.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the following BUG_ON can produce false positives.  Not sure if
this would be a problem though if the case was true.

Here in rt_adjust_prio_chain line 236 (2.6.16-rt16):


	/*
	 * When deadlock detection is off then we check, if further
	 * priority adjustment is necessary.
	 */
	if (!detect_deadlock && waiter->list_entry.prio == task->prio) {
		BUG_ON(waiter->pi_list_entry.prio != waiter->list_entry.prio);
		goto out_unlock_pi;
	}

This is only protected by the waiter->task->pi_lock.

Here's the race:

We have Process A blocked on some lock L1 (this owner doesn't matter).
A owns L2 and L3.

Say process B is blocked on lock L2 and process C is blocked on L3. We
can also say that B and C are of lower priority than A.

Process B owns lock L4 and process C owns lock L5.

We have Process D that comes and blocks on lock L4 of higher priority
than A.

At the same time we have process E blocking on L5 on another CPU that
just happens to be the same priority as D.

Here's a view of this scenario.

  L1 <=blocks= A
                 <=owns= L2
                           <=blocks= B <=owns= L4
                                                  <=blocks= D
                 <=owns= L3
                           <=blocks= C <=owns= L5
                                                  <=blocks= E

Remember both D and E are running on two different CPUs with the same
priority, but both are higher than A and the priority boosting is in
effect.

As D climbs the chain and finally gets to task == A and lock == L1

Then we get to this part of the code:

	/* Requeue the waiter */
	plist_del(&waiter->list_entry, &lock->wait_list);
	waiter->list_entry.prio = task->prio;
	plist_add(&waiter->list_entry, &lock->wait_list);

	/* Release the task */
	spin_unlock_irqrestore(&task->pi_lock, flags);
	put_task_struct(task);

	/* Grab the next task */
	task = rt_mutex_owner(lock);
	spin_lock_irqsave(&task->pi_lock, flags);


Now after we unlock the task->pi_lock, the waiter->list_entry.prio is
now equal to the task->prio but waiter->pi_list_entry.prio does not yet
equal waiter->pi_list_entry.prio.  And at this moment, we only have the
L1->wait_lock. And to make matters worst, interrupts can now be on.

Lets say before the above happened, process E was going up its chain,
and the above happened just as it reached:

 retry:
	/*
	 * Task can not go away as we did a get_task() before !
	 */
	spin_lock_irqsave(&task->pi_lock, flags);


And E blocked on the task->pi_lock (since task == A, and D had the
lock).

Now when D releases the pi_lock, E can continue, but it gets to the
problem compare:

	if (!detect_deadlock && waiter->list_entry.prio == task->prio) {
		BUG_ON(waiter->pi_list_entry.prio != waiter->list_entry.prio);
		goto out_unlock_pi;
	}

Remember that D had the same prio as E, so when E hits this point,
waiter->list_entry will equal task->prio (boosted by D), but when it
enters the condition, pi_list_entry.prio hasn't been updated yet by D,
so we have a legitimate condition that the BUG_ON test will produce a
true result.

So the question now is: is this a real bug?

-- Steve


