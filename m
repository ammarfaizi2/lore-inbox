Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQLXEwk>; Sat, 23 Dec 2000 23:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLXEwa>; Sat, 23 Dec 2000 23:52:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19784 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130393AbQLXEwS>; Sat, 23 Dec 2000 23:52:18 -0500
Date: Sun, 24 Dec 2000 05:21:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001224052128.A24560@athlon.random>
In-Reply-To: <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>, <3A454205.D33090A8@uow.edu.au>; <20001224015346.A17046@athlon.random> <3A455F6B.FAC3A4B7@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A455F6B.FAC3A4B7@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 01:28:59PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 01:28:59PM +1100, Andrew Morton wrote:
> This could happen with the old scheme where exclusiveness
> was stored in the task, not the waitqueue.
> 
> >From test4:
> 
>         for (;;) {
>                 __set_current_state(TASK_UNINTERRUPTIBLE | TASK_EXCLUSIVE);
> 	/* WINDOW */
>                 spin_lock_irq(&io_request_lock);
>                 rq = get_request(q, rw);
>                 spin_unlock_irq(&io_request_lock);
>                 if (rq)
>                         break;
>                 generic_unplug_device(q);
>                 schedule();
>         }
> 
> As soon as we set TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE, this
> task becomes visible to __wake_up_common and can soak
> up a second wakeup. [..]

I disagree, none wakeup could be lost in test4 in the above section of code
(besides the __set_current_state that should be set_current_state ;) and that's
not an issue for both x86 and alpha where spin_lock is a full memory barrier).

Let's examine what happens in test4:

1) before the `for' loop, the task is just visible to __wake_up_common

2) as soon as we set the task state to TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE
   the task _start_ asking for an exclusive wakeup from __wake_up_common

At this point consider two different cases:

3a) assume we get a wakup in the /* WINDOW */: the task->state become
    runnable from under us (no problem, that's expected). And if it's true we
    got a wakeup in /* WINDOW */, then it means get_request will also return
    a valid rq and we'll break the loop and we'll use the resource. No wakeup
    lost in this case. So far so good. This was the 1 wakeup case.

3b) Assume _two_ wakeups happens in /* WINDOW */: the first one just make
    us RUNNABLE as in the 3a) case, the second one will wakeup any _other_
    wake-one task _after_ us in the wait queue (normal FIFO order), because the
    first wakeup implicitly made us RUNNABLE (not anymore TASK_EXCLUSIVE so we
    were not asking anymore for an exclusive wakeup).

    The task after us may as well be running in /* WINDOW */ and in such case
    it will get as well a `rq' from get_request (as in case 3a) without having
    to sleep). All right.

    No wakeup could be lost in any case. Two wakeups happened and two
    tasks got their I/O request even if both wakeups happend in /* WINDOW */.
    Example with N wakeups and N tasks is equivalent.

This race is been introduced in test1X because there the task keeps asking for
an exclusive wakeup even after getting a wakeup: until it has the time to
cleanup and unregister explicitly.

And btw, 2.2.19pre3 has the same race, while the alternate wake-one
implementation in 2.2.18aa2 doesn't have it (for the same reasons).

And /* WINDOW */ is not the only window for such race: the window is the whole
section where the task is registered in the waitqueue in exclusive mode:

	add_wait_queue_exclusive
	/* all is WINDOW here */
	remove_wait_queue

Until remove_wait_queue runs explicitly in the task context any second wakeup
will keep waking up only such task (so in turn it will be lost). So it should
trigger very easily under high load since two wakeups will happen much faster
compared to the task that needs to be rescheduled in order run
remove_wait_queue and cleanup.

Any deadlocks in test1X could be very well explained by this race condition.

> Still, changing the wakeup code in the way we've discussed
> seems the way to go. [..]

I agree. I'm quite convinced it's right way too and of course I see why we
moved the exclusive information in the waitqueue instead of keeping it in the
task struct to provide sane semantics in the long run ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
