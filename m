Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQLXBYt>; Sat, 23 Dec 2000 20:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbQLXBYk>; Sat, 23 Dec 2000 20:24:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43803 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130290AbQLXBY2>; Sat, 23 Dec 2000 20:24:28 -0500
Date: Sun, 24 Dec 2000 01:53:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001224015346.A17046@athlon.random>
In-Reply-To: <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A454205.D33090A8@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 11:23:33AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 11:23:33AM +1100, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 1) could be fixed trivially by making the waitqueue_lock a spinlock, but
> > this way doesn't solve 2). And if we solve 2) properly than 1) gets fixed as

BTW (follow up myself), really making the lock a spinlock (not a readwrite
lock) would fix 2) as well (waitqueue_lock is global in 2.2.x I was thinking at
the per-waitqueue lock of 2.4.x ;).

> > well.
> 
> I don't understand the problem with 2) in 2.2?  Every task on both waitqueues
> gets woken up.  Won't it sort itself out OK?

Not every task if it's a wake-one on both waitqueues. The problem should be the
same in 2.2.x and 2.4.x. But if such usage makes sense is uncertain...

> For 2.4, 2) is an issue because we can have tasks on two waitqueues at the
> same time, with a mix of exclusive and non.  Putting a global spinlock
> into __wake_up_common would fix it, but was described as "horrid" by
> you-know-who :)

Yes. And that wouldn't fix the race number 3) below.

> > I agree the right fix for 2) (and in turn for 1) ) is to count the number of
> > exclusive wake_up_process that moves the task in the runqueue, if the task was
> > just in the runqueue we must not consider it as an exclusive wakeup (so in turn
> > we'll try again to wakeup the next exclusive-wakeup waiter). This will
> > fix both races. Since the fix is self contained in __wake_up it's fine
> > for 2.2.19pre3 as well and we can keep using a read_write lock then.
> 
> I really like this approach.  It fixes another problem in 2.4:
> 
> Example:
> 
> static struct request *__get_request_wait(request_queue_t *q, int rw)
> {
>         register struct request *rq;
>         DECLARE_WAITQUEUE(wait, current);
> 
>         add_wait_queue_exclusive(&q->wait_for_request, &wait);
>         for (;;) {
>                 __set_current_state(TASK_UNINTERRUPTIBLE);
> 	/* WINDOW HERE */
>                 spin_lock_irq(&io_request_lock);
>                 rq = get_request(q, rw);
>                 spin_unlock_irq(&io_request_lock);

note that the above is racy and can lose a wakeup, 2.4.x needs
set_current_state there (not __set_current_state): spin_lock isn't a two-way
barrier, it only forbids stuff ot exit the critical section. So on some
architecture (not on the alpha for example) the cpu could reorder the code
this way:

	spin_lock_irq()
	rq = get_request
	__set_current_state
	spin_unlock_irq

So inverting the order of operations. That needs to be fixed too (luckily
it's a one liner).

>                 if (rq)
>                         break;
>                 generic_unplug_device(q);
>                 schedule();
>         }
>         remove_wait_queue(&q->wait_for_request, &wait);
>         current->state = TASK_RUNNING;
>         return rq;
> }
> 
> If this task enters the schedule() and is then woken, and another
> wakeup is sent to the waitqueue while this task is executing in
> the marked window, __wake_up_common() will try to wake this
> task a second time and will then stop looking for tasks to wake.
> 
> The outcome: two wakeups sent to the queue, but only one task woken.

Correct.

And btw such race is new and it must been introduced in late 2.4.0-test1X or
so, I'm sure it couldn't happen in whole 2.3.x and 2.4.0-testX because the
wakeup was clearing atomically the exclusive bit from the task->state.

Still talking about late 2.4.x changes, why add_wait_queue_exclusive gone
in kernel/fork.c?? That's obviously not the right place :).

> I haven't thought about it super-hard, but I think that if
> __wake_up_common's exclusive-mode handling were changed
> as you describe, so that it keeps on scanning the queue until it has
> *definitely* moved a task onto the runqueue then this
> problem goes away.

Yes, that's true.

> > Those races of course are orthogonal with the issue we discussed previously
> > in this thread: a task registered in two waitqueues and wanting an exclusive
> > wakeup from one waitqueue and a wake-all from the other waitqueue (for
> > addressing that we need to move the wake-one information from the task struct
> > to the waitqueue_head and I still think that shoudln't be addressed in 2.2.x,
> > 2.2.x is fine with a per-task-struct wake-one information)
> 
> OK by me, as long as people don't uncautiously start using the
> capability for other things.
> 
> > Should I take care of the 2.2.x fix, or will you take care of it? I'm not using
> > the wake-one patch in 2.2.19pre3 because I don't like it (starting from the
> > useless wmb() in accept) so if you want to take care of 2.2.19pre3 yourself I'd
> > suggest to apply the wake-one patch against 2.2.19pre3 in my ftp-patch area
> > first.  Otherwise give me an ack and I'll extend myself my wake-one patch to
> > ignore the wake_up_process()es that doesn't move the task in the runqueue.
> 
> ack.
> 
> I'll take another look at the 2.4 patch and ask you to review that
> when I've finished with the netdevice wetworks, if that's
> OK.

OK. Thanks for the help.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
