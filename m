Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQKSTR3>; Sun, 19 Nov 2000 14:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbQKSTRU>; Sun, 19 Nov 2000 14:17:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56837 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129501AbQKSTRK>; Sun, 19 Nov 2000 14:17:10 -0500
Date: Sun, 19 Nov 2000 10:46:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Christoph Rohland <cr@sap.com>, David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A17CCB4.19416026@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10011191008150.1934-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, Andrew Morton wrote:
> 
> I don't see a path where David's patch can cause a lost wakeup in the
> way you describe.

Basically, if there are two up() calls, they might end up waking up only
one process, because the same process goes to sleep twice. That's wrong.
It should wake up two processes.

However, thinking about it more, that's obviously possible only for
semaphores that are used for more than just mutual exclusion, and
basically nobody does that anyway. 

> Next step is to move the waitqueue and wakeup operations so they're
> inside the spinlock.  Nope.  That doesn't work either.
> 
> Next step is to throw away the semaphore_lock and use the sem->wait
> lock instead.  That _does_ work.  This is probably just a
> fluke - it synchronises the waker with the sleepers and we get lucky.

Yes, especially on a two-cpu machine that kind of synchronization can
basically end up hiding real bugs.

I'll think about this some more. One thing I noticed is that the
"wake_up(&sem->wait);" at the end of __down() is kind of bogus: we don't
actually want to wake anybody up at that point at all, it's just that if
we don't wake anybody up we'll end up having "sem = 0, sleeper = 0", and
when we unlock the semaphore the "__up()" logic won't trigger, and we
won't ever wake anybody up. That's just incredibly bogus.

Instead of the "wake_up()" at the end of __down(), we should have
something like this at the end of __down() instead:

			... for-loop ...
		}
		tsk->state = TASK_RUNNING;
		remove_wait_queue(&sem->wait, &wait);

		/* If there are others, mark the semaphore active */
		if (wait_queue_active(&sem_wait)) {
			atomic_dec(&sem->count);
			sem->sleepers = 1;
		}
		spin_unlock_irq(&semaphore_lock);
	}

which would avoid an unnecessary reschedule, and cause the wakeup to
happen at the proper point, namely "__up()" when we release the
semaphore.

I suspect this may be part of the trouble with the "sleepers" count
playing: we had these magic rules that I know I thought about when the
code was written, but that aren't really part of the "real" rules.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
