Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKTOKL>; Mon, 20 Nov 2000 09:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131787AbQKTOKC>; Mon, 20 Nov 2000 09:10:02 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:17592 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131615AbQKTOJo>; Mon, 20 Nov 2000 09:09:44 -0500
Message-ID: <3A192991.12BC2EC2@uow.edu.au>
Date: Tue, 21 Nov 2000 00:39:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Christoph Rohland <cr@sap.com>, David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A17CCB4.19416026@uow.edu.au> <Pine.LNX.4.10.10011191008150.1934-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> 
> I'll think about this some more. One thing I noticed is that the
> "wake_up(&sem->wait);" at the end of __down() is kind of bogus: we don't
> actually want to wake anybody up at that point at all, it's just that if
> we don't wake anybody up we'll end up having "sem = 0, sleeper = 0", and
> when we unlock the semaphore the "__up()" logic won't trigger, and we
> won't ever wake anybody up. That's just incredibly bogus.

There's another reason why we need the wakeup in the tail of __down():

1	void __down(struct semaphore * sem)
2	{
3		struct task_struct *tsk = current;
4		DECLARE_WAITQUEUE(wait, tsk);
5		tsk->state = TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE;
6		add_wait_queue_exclusive(&sem->wait, &wait);
7
8		spin_lock_irq(&semaphore_lock);
9		sem->sleepers++;
10		for (;;) {
11			int sleepers = sem->sleepers;
12
13			/*
14			 * Add "everybody else" into it. They aren't
15			 * playing, because we own the spinlock.
16			 */
17			if (!atomic_add_negative(sleepers - 1, &sem->count)) {
18				sem->sleepers = 0;
19				break;
20			}
21			sem->sleepers = 1;	/* us - see -1 above */
22			spin_unlock_irq(&semaphore_lock);
23
24			schedule();
25			tsk->state = TASK_UNINTERRUPTIBLE;
26			spin_lock_irq(&semaphore_lock);
27		}
28		spin_unlock_irq(&semaphore_lock);
29		remove_wait_queue(&sem->wait, &wait);
30		tsk->state = TASK_RUNNING;
31		wake_up(&sem->wait);
32	}

Suppose two tasks A and B are sleeping on the semaphore and somebody
does an up().  Task A wakes and sets TASK_UNINTERRUPTIBLE.

Task A then executes statements 26, 11, 17, 18, 19, 28 and 29 while
it's on the head of the exclusive waitqueue in state
TASK_UNINTERRUPTIBLE.  If during this, another CPU does an up() on the
semaphore the wakeup will be directed to Task A and will be lost.

Hence Task A must do the wakeup once it has removed itself from the
waitqueue just in case this happened.  Did anyone ever mention that
exclusive wakeups should atomically remove tasks from the waitqueue? :)


> Instead of the "wake_up()" at the end of __down(), we should have
> something like this at the end of __down() instead:
> 
>                         ... for-loop ...
>                 }
>                 tsk->state = TASK_RUNNING;
>                 remove_wait_queue(&sem->wait, &wait);
> 
>                 /* If there are others, mark the semaphore active */
>                 if (wait_queue_active(&sem_wait)) {
>                         atomic_dec(&sem->count);
>                         sem->sleepers = 1;
>                 }
>                 spin_unlock_irq(&semaphore_lock);
>         }
> 
> which would avoid an unnecessary reschedule, and cause the wakeup to
> happen at the proper point, namely "__up()" when we release the
> semaphore.

This won't help, because in the failure scenario we never get to
exit the 'for' loop.  Read on...

Here's why the `goto inside' thingy isn't working:

Assume the semaphore is free:

Task A does down():
-------------------

count->0
sleepers=0

Task B does down():
-------------------

count: 0 -> -1
sleepers: 0->1
if (sleepers > 1) is false
atomic_add_negative(1-1, -1): count -1 -> -1.
`if' fails.
sleepers: 1->1
schedule()

Task C does down():
-------------------

count: -1 -> -2
sleepers: 1->2
if (sleepers > 1) is true
schedule()

Someone does up():
------------------

(reminder: count=-2, sleepers=2)
count: -2 -> -1
wakeup()
-FINISHED-

Task C, CPU0					CPU1

wakes up
tsk->state = TASK_UNINTERRUPTIBLE
spin_lock
						down()
						count: -1->-2
						spins....
(reminder: sleepers=2, count=-2)
atomic_add_negative(2-1, -2): count->-1
aargh! `if' fails!
sleepers->1
spin_unlock()
schedule()
						unspins....
						sem->sleepers++ sleepers: 1->2
						if (sleepers > 1) is true
						aargh! atomic_add_negative test would have succeeded!
						spin_unlock()
						schedule()


	** Nobody woke up **


Someone does up(), but assume CPU1 gets the lock
------------------------------------------------

(reminder: count=-2, sleepers=2)

count: -2 -> -1
wakeup()
-FINISHED-

Task C, CPU0					CPU1

wakes up
tsk->state = TASK_UNINTERRUPTIBLE
						down()
						count: -1->-2
						spin_lock
spins...
						sem->sleepers++ sleepers: 2->3
						if (sleepers > 1) is true
						spin_unlock()
						schedule()
unspins...
(reminder: sleepers=3, count=-2)
atomic_add_negative(3-1, -2): count->0
'if' succeeds
sleepers->1
spin_unlock()
schedule()

	** OK, that worked, and it was "fair" **

Here's the story with the current (test11) implementation
=========================================================

Task A does down():
-------------------

count->0
sleepers=0

Task B does down():
-------------------

count: 0 -> -1
sleepers: 0->1
atomic_add_negative: count -1 -> -1. false.
sleepers->1
schedule()

Task C does down():
-------------------

count: -1 -> -2
sleepers: 1->2
atomic_add_negative: count -2 -> -1. false
sleepers->1
schedule()

Someone does up():
------------------

count: -1 -> 0
wakeup()
-FINISHED-

Task C, CPU0					CPU1

wakes up
tsk->state = TASK_UNINTERRUPTIBLE
spin_lock
						down()
						count: 0 -> -1
						spins....
(reminder: count=-1, sleepers=1)
atomic_add_negative(1-1, -1): count->-1
`if' fails.
sleepers->1
spin_unlock()
schedule()
						unspins...
						sem->sleepers++: 1->2
						atomic_add_negative(2-1, -1): count: -1->0
						'if' is true.
						sleepers->0
						break
						<runs>

	** OK, that worked too **
						

> I suspect this may be part of the trouble with the "sleepers" count
> playing: we had these magic rules that I know I thought about when the
> code was written, but that aren't really part of the "real" rules.

Linus, this code is too complex.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
