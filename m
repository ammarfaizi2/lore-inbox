Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbQKSCSC>; Sat, 18 Nov 2000 21:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbQKSCRw>; Sat, 18 Nov 2000 21:17:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44036 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130540AbQKSCRi>; Sat, 18 Nov 2000 21:17:38 -0500
Date: Sat, 18 Nov 2000 17:47:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Christoph Rohland <cr@sap.com>, David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A172918.BD09CA9@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10011181732080.1413-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, Andrew Morton wrote:
> 
> Has anyone tried it on SMP?  I get fairly repeatable instances of immortal
> `D'-state processes with this patch.

Too bad. I really thought it should be safe to do.

> The patch isn't right - it allows `sleepers' to increase without bound.
> But it's a boolean!

It's not a boolean. It's really a "bias count". It happens to get only the
values 0 and 1 simply becase the logic is that we always account for all
the other people when any process goes to sleep, so "sleepers" only ever
counts the one process that went to sleep last. 

But the algorithm itself should allow for other values. In fact, I think
that you'll find that it works fine if you switch to non-exclusive
wait-queues, and the only reason you see the repeatable D states is
exactly the case where we didn't "take" the semaphore even though we were
awake, and that basically makes us an exclusive process that didn't react
to an exclusive wakeup.

(Think of it this way: with the "inside" patch, the process does

	tsk->state = TASK_INTERRUPTIBLE;

twice, even though there was only one semaphore that woke it up: we
basically "lost" a wakeup event, not because "sleepers" cannot be 2, but
because we didn't pick up the wakeup that we might have gotten.

Instead of the "goto inside", how about just doing it without the "double
sleep", and doing something like

	tsk->state = TASK_INTERRUPTIBLE;
	add_wait_queue_exclusive(&sem->wait, &wait);

	spin_lock_irq(&semaphore_lock);
	sem->sleepers ++;
+	if (sem->sleepers > 1) {
+		spin_unlock_irq(&semaphore_lock);
+		schedule();
+		spin_lock_irq(&semaphore_lock);
+	}
	for (;;) {

The only difference between the above and the "goto inside" variant is
really that the above sets "tsk->state = TASK_INTERRUPTIBLE;" just once
per loop, not twice as the "inside" case did. So if we happened to get an
exclusive wakeup at just the right point, we won't go to sleep again and
miss it.

But these things are very subtle. The current semaphore algorithm was
basically perfected over a week of some serious thinking. The fairness
change should similarly get a _lot_ of attention. It's way too easy to
miss things.

Does the above work for you even in SMP?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
