Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQLXFmx>; Sun, 24 Dec 2000 00:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLXFmm>; Sun, 24 Dec 2000 00:42:42 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:45975 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130393AbQLXFmk>; Sun, 24 Dec 2000 00:42:40 -0500
Message-ID: <3A4586D6.EF357D62@uow.edu.au>
Date: Sun, 24 Dec 2000 16:17:10 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>, <3A454205.D33090A8@uow.edu.au>; <20001224015346.A17046@athlon.random> <3A455F6B.FAC3A4B7@uow.edu.au>,
		<3A455F6B.FAC3A4B7@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 01:28:59PM +1100 <20001224052128.A24560@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Dec 24, 2000 at 01:28:59PM +1100, Andrew Morton wrote:
> > This could happen with the old scheme where exclusiveness
> > was stored in the task, not the waitqueue.
> >
> > >From test4:
> >
> >         for (;;) {
> >                 __set_current_state(TASK_UNINTERRUPTIBLE | TASK_EXCLUSIVE);
> >       /* WINDOW */
> >                 spin_lock_irq(&io_request_lock);
> >                 rq = get_request(q, rw);
> >                 spin_unlock_irq(&io_request_lock);
> >                 if (rq)
> >                         break;
> >                 generic_unplug_device(q);
> >                 schedule();
> >         }
> >
> > As soon as we set TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE, this
> > task becomes visible to __wake_up_common and can soak
> > up a second wakeup. [..]
> 
> I disagree, none wakeup could be lost in test4 in the above section of code
> (besides the __set_current_state that should be set_current_state ;) and that's
> not an issue for both x86 and alpha where spin_lock is a full memory barrier).
> 
> Let's examine what happens in test4:
> 
> [ snip ]

I was talking about a different scenario:

        add_wait_queue_exclusive(&q->wait_for_request, &wait);
        for (;;) {
                __set_current_state(TASK_UNINTERRUPTIBLE);
	/* WINDOW */
                spin_lock_irq(&io_request_lock);
                rq = get_request(q, rw);
                spin_unlock_irq(&io_request_lock);
                if (rq)
                        break;
                generic_unplug_device(q);
                schedule();
        }
        remove_wait_queue(&q->wait_for_request, &wait);

Suppose there are two tasks sleeping in the schedule().

A wakeup comes.  One task wakes.  It loops aound and reaches
the window.  At this point in time, another wakeup gets sent
to the waitqueue. It gets directed to the task which just
woke up!  It should have been directed to a sleeping task,
not the current one which just *looks* like it's sleeping,
because it's in state TASK_UNINTERRUPTIBLE.

This can happen in test4.

> This race is been introduced in test1X because there the task keeps asking for
> an exclusive wakeup even after getting a wakeup: until it has the time to
> cleanup and unregister explicitly.

No, I think it's the same in test4 and test1X.  In current kernels
it's still the case that the woken task gets atomically switched into
state TASK_RUNNING, and then becomes "hidden" from the wakeup code.

The problem is, the task bogusly sets itself back into
TASK_UNINTERRUPTIBLE for a very short period and becomes
eligible for another wakeup.

There's not much which ll_rw_blk.c can do about this.

> And btw, 2.2.19pre3 has the same race, while the alternate wake-one
> implementation in 2.2.18aa2 doesn't have it (for the same reasons).

The above scenario can happen in all kernels.

> And /* WINDOW */ is not the only window for such race: the window is the whole
> section where the task is registered in the waitqueue in exclusive mode:
> 
>         add_wait_queue_exclusive
>         /* all is WINDOW here */
>         remove_wait_queue
> 
> Until remove_wait_queue runs explicitly in the task context any second wakeup
> will keep waking up only such task (so in turn it will be lost). So it should
> trigger very easily under high load since two wakeups will happen much faster
> compared to the task that needs to be rescheduled in order run
> remove_wait_queue and cleanup.
> 
> Any deadlocks in test1X could be very well explained by this race condition.

Yes, but I haven't seen a "stuck in D state" report for a while.
I assume this is because this waitqueue gets lots of wakeups sent to it.

The ones in networking I expect are protected by other locking
which serialises the wakeups.

The one in the x86 semaphores avoids it by sending an extra wakeup
to the waitqueue on the way out.

> > Still, changing the wakeup code in the way we've discussed
> > seems the way to go. [..]
> 
> I agree. I'm quite convinced it's right way too and of course I see why we
> moved the exclusive information in the waitqueue instead of keeping it in the
> task struct to provide sane semantics in the long run ;).

Linus suggested at one point that we clear the waitqueue's
WQ_FLAG_EXCLUSIVE bit when we wake it up, so it falls back
to non-exclusive mode.  This was to address one of the
task-on-two-waitqueues problems...

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
