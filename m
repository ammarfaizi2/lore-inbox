Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132351AbQLJDYm>; Sat, 9 Dec 2000 22:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132412AbQLJDYc>; Sat, 9 Dec 2000 22:24:32 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:22670 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132351AbQLJDYV>; Sat, 9 Dec 2000 22:24:21 -0500
Message-ID: <3A32F11F.8505CFEB@uow.edu.au>
Date: Sun, 10 Dec 2000 13:57:35 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: patch: blk-12
In-Reply-To: <20001209183556.G307@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> o Batch freeing of requests. Stock kernels have very bad behaviour
>   under I/O load (load here meaning that the request list is empty,
>   doesn't require much effort...), because as soon as a request is
>   completed and put back on the freelist, a read/write will grab it
>   and the queue will be unplugged again. This effectively disables
>   elevator merging efforts completely. Note -- even though wakeups
>   of wait_for_request are now not a 1-1 mapping, wake-one semantics
>   are maintained.
> 

Exclusive waitqueues do not give wake-one semantics.  They give
us wake-0.999999999 semantics :)

 1: static struct request *__get_request_wait(request_queue_t *q, int rw)
 2: {
 3:        register struct request *rq;
 4:        DECLARE_WAITQUEUE(wait, current);
 5:
 6:        add_wait_queue_exclusive(&q->wait_for_request, &wait);
 7:        for (;;) {
 8:                __set_current_state(TASK_UNINTERRUPTIBLE);
 9:                spin_lock_irq(&io_request_lock);
10:                rq = get_request(q, rw);
11:                spin_unlock_irq(&io_request_lock);
12:                if (rq)
13:                       break;
14:                generic_unplug_device(q);
15:                schedule();
16:        }
17:        remove_wait_queue(&q->wait_for_request, &wait);
18:        current->state = TASK_RUNNING;
19:        return rq;
20: }

Suppose there are two tasks on the waitqueue.  Someone does a wakeup.
One task wakes, loops around to line 8.  It sets TASK_UNINTERRUPTIBLE
and is now eligible for another wakeup.  So if someone does a wakeup
on the waitqueue while this task is running statements 9, 10, 11, 12,
13 and 17, that wakeup will be sent to the newly woken task.

The net effect: two tasks are sleeping, there were two wakeups but
only one task woke up.

Is this a problem in practice?  Presumably not.  This is probably
because the waitqueue is getting wakeups sent to it all the time,
and we muddle through.

One place where this race _would_ bite is in semaphores. __down()
has the same race, but it does an extra wake_up() on the queue after it
has taken itself off, which fixes things.  So `up()' can in fact be
wake-two.  err, make that wake-1.999999999.

The moral is: be careful with exclusive waitqueues.  They're
a minefield.

There's another interesting race with exclusive waitqueues.  In
a few places in the kernel a task can be on two exclusive waitqueues
at the same time.  If two CPUs simutaneously direct a wakeup to
the two waitqueues they can race and the net effect is that
they both wake the same task.  Depending on the behaviour
of the woken task when it returns to the outer waitloop that
can be a lost wakeup.

My proposal to fix this with a global spinlock in __wake_up_common
got nixed at Penguin HQ.  Instead I have a patch lying around here
somewhere which makes wake_up_process() return a success value.  If
__wake_up_common tries to wake an exclusive process but fails, it
keeps looking for someone to wake up.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
