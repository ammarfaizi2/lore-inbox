Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQKSNVg>; Sun, 19 Nov 2000 08:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQKSNV1>; Sun, 19 Nov 2000 08:21:27 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:43471 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129473AbQKSNVM>; Sun, 19 Nov 2000 08:21:12 -0500
Message-ID: <3A17CCB4.19416026@uow.edu.au>
Date: Sun, 19 Nov 2000 23:51:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Christoph Rohland <cr@sap.com>, David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A172918.BD09CA9@uow.edu.au> <Pine.LNX.4.10.10011181732080.1413-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> But the algorithm itself should allow for other values. In fact, I think
> that you'll find that it works fine if you switch to non-exclusive
> wait-queues, and the only reason you see the repeatable D states is
> exactly the case where we didn't "take" the semaphore even though we were
> awake, and that basically makes us an exclusive process that didn't react
> to an exclusive wakeup.
> 
> (Think of it this way: with the "inside" patch, the process does
> 
>         tsk->state = TASK_INTERRUPTIBLE;
> 
> twice, even though there was only one semaphore that woke it up: we
> basically "lost" a wakeup event, not because "sleepers" cannot be 2, but
> because we didn't pick up the wakeup that we might have gotten.

I don't see a path where David's patch can cause a lost wakeup in the
way you describe.

> Instead of the "goto inside", how about just doing it without the "double
> sleep", and doing something like
> 
>         tsk->state = TASK_INTERRUPTIBLE;
>         add_wait_queue_exclusive(&sem->wait, &wait);
> 
>         spin_lock_irq(&semaphore_lock);
>         sem->sleepers ++;
> +       if (sem->sleepers > 1) {
> +               spin_unlock_irq(&semaphore_lock);
> +               schedule();
> +               spin_lock_irq(&semaphore_lock);
> +       }
>         for (;;) {
> 
> The only difference between the above and the "goto inside" variant is
> really that the above sets "tsk->state = TASK_INTERRUPTIBLE;" just once
> per loop, not twice as the "inside" case did. So if we happened to get an
> exclusive wakeup at just the right point, we won't go to sleep again and
> miss it.

This still causes stuck processes.  There's a bonnie++ test which hammers
pipes.  It's quite easy to get four instances of bonnie++ stuck on a pipe
semaphore.  This is with your suggested change applied to both __down and
__down_interruptible, BTW.  Switching both functions to use non-exclusive
waitqueues didn't help.  Still missing a wakeup somewhere.

Moving on to this version:

void __down(struct semaphore * sem)
{
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);
        tsk->state = TASK_UNINTERRUPTIBLE;
        add_wait_queue_exclusive(&sem->wait, &wait);

        spin_lock_irq(&semaphore_lock);
        if (sem->sleepers)
                goto inside;
        for (;;) {
                /*
                 * Add "everybody else" into it. They aren't
                 * playing, because we own the spinlock.
                 */
                if (!atomic_add_negative(sem->sleepers, &sem->count)) {
                        sem->sleepers = 0;
                        break;
                }
                sem->sleepers = 1;      /* us - see -1 above */
inside:
                spin_unlock_irq(&semaphore_lock);

                schedule();
                tsk->state = TASK_UNINTERRUPTIBLE;
                spin_lock_irq(&semaphore_lock);
        }
        spin_unlock_irq(&semaphore_lock);
        remove_wait_queue(&sem->wait, &wait);
        tsk->state = TASK_RUNNING;
        wake_up(&sem->wait);
}

The only difference here is that we're not allowing `sem->sleepers'
to take the value '2' outside the spinlock.  But it still turns
bonnie++ into Rip van Winkle.

Next step is to move the waitqueue and wakeup operations so they're
inside the spinlock.  Nope.  That doesn't work either.

Next step is to throw away the semaphore_lock and use the sem->wait
lock instead.  That _does_ work.  This is probably just a
fluke - it synchronises the waker with the sleepers and we get lucky.

But at least it's now benchmarkable.  It works well.  Kernel build
times are unaffected.  bw_tcp is down a few percent.  Worth pursuing.

David, could you please verify that the patch at
	http://www.uow.edu.au/~andrewm/linux/semaphore.patch
still fixes the starvation problem?

> But these things are very subtle. The current semaphore algorithm was
> basically perfected over a week of some serious thinking. The fairness
> change should similarly get a _lot_ of attention. It's way too easy to
> miss things.

Agree.  The fact that this algorithm can work while random CPUs are
asynchronously incrementing and decrementing sem->count makes
analysis and understanding a _lot_ harder.

There's a lot more work needed here.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
