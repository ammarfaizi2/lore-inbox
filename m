Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAMRgk>; Sat, 13 Jan 2001 12:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAMRgb>; Sat, 13 Jan 2001 12:36:31 -0500
Received: from maile.telia.com ([194.22.190.16]:11781 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S129406AbRAMRgR>;
	Sat, 13 Jan 2001 12:36:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: george anzinger <george@mvista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Latency: allowing resheduling while holding spin_locks
Date: Sat, 13 Jan 2001 18:31:43 +0100
X-Mailer: KMail [version 1.2]
Cc: Nigel Gamble <nigel@nrg.org>
MIME-Version: 1.0
Message-Id: <01011315231600.01469@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A rethinking of the rescheduling strategy...

I have come to this conclusion.

A spinlock prevents other processes to enter that specific region.
But interrupts are allowed they might delay 
execution of a spin locked
reqion for a undefined (small but anyway) time.

Code with critical maximum times should use spin_lock_irq !

=> spin_locks are not about disallowing reschedules.


Prior to the introduction of spin locks it did not make sense to
allow reschedules in kernel since the big kernel lock was so big...
Any code that wanted do any non pure computation task would
hit it very quickly.

Now with spin locks the situation is quite different...

[First assume UP kernel for simplicity]

Suppose you have two processes one that normal (P) and one high priority 
(RTP).

P runs user code, makes a system call, enters a spin lock region.

Interrupt!

The interrupt service routine wakes up RTP, which marks P as need_reschedule, 
and returns, on return from interrupt it detects that P needs_reschedule -
do it even if it is executing in kernel and holding a spin_lock.

RTP starts, and if it does not hit the same spin_lock there is nothing 
special happening until it goes to sleep again. But suppose it does!

RTP tries to get the spin_lock but fails, since it is the currently highest 
prio process and P is running it wants to reschedule to P to get its own 
stuff done.

P runs the final part of its spin_locked region, upon spin_unlock it needs to
get RTP running.

Something like this:

spin_lock(lock)
{
	while (test_and_set(lock->lock)) {
		schedule_spinlock(); /* kind of yield, giving low goodness, sticky */
	}
}

spin_unlock(lock)
{
	clear(lock);

	/* note: someone with higher prio than me,
	   might steal the lock from even higher prio waiters here */

	if (lock->queue)
		wakeup_spinlock_yielder(lock);
}


schedule_spinlock()
{
	/* note: owner can not run here, it has lower prio */

	addqueue(lock->queue, current);

	p->policy |= SCHED_SPINLOCK;
	schedule();
}

wakeup_spinlock_yielder(lock)
{
	int need_resched = 0;

	int my_goodness = goodness(current);

	forall p in lock->queue
		p->policy &= ~SCHED_SPINLOCK;
		if (goodness(p) > my_goodness)
			need_resched = 1;
	}

	if (need_resched)
		schedule();
}


A final note on spin_lock_irq, since they prevent IRQs there will be no 
requests to wakeup any process during their locked region => no problems.

-- 
Home page:
  no currently
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
