Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXCyk>; Sat, 23 Dec 2000 21:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbQLXCya>; Sat, 23 Dec 2000 21:54:30 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:191 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129458AbQLXCy2>; Sat, 23 Dec 2000 21:54:28 -0500
Message-ID: <3A455F6B.FAC3A4B7@uow.edu.au>
Date: Sun, 24 Dec 2000 13:28:59 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <3A41DDB3.7E38AC7@uow.edu.au>, <3A41DDB3.7E38AC7@uow.edu.au>; <20001221161952.B20843@athlon.random> <3A4303AC.C635F671@uow.edu.au>, <3A4303AC.C635F671@uow.edu.au>; <20001222141929.A13032@athlon.random> <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>,
		<3A454205.D33090A8@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 11:23:33AM +1100 <20001224015346.A17046@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> >                 if (rq)
> >                         break;
> >                 generic_unplug_device(q);
> >                 schedule();
> >         }
> >         remove_wait_queue(&q->wait_for_request, &wait);
> >         current->state = TASK_RUNNING;
> >         return rq;
> > }
> >
> > If this task enters the schedule() and is then woken, and another
> > wakeup is sent to the waitqueue while this task is executing in
> > the marked window, __wake_up_common() will try to wake this
> > task a second time and will then stop looking for tasks to wake.
> >
> > The outcome: two wakeups sent to the queue, but only one task woken.
> 
> Correct.
> 
> And btw such race is new and it must been introduced in late 2.4.0-test1X or
> so, I'm sure it couldn't happen in whole 2.3.x and 2.4.0-testX because the
> wakeup was clearing atomically the exclusive bit from the task->state.
> 

This could happen with the old scheme where exclusiveness
was stored in the task, not the waitqueue.

>From test4:

        for (;;) {
                __set_current_state(TASK_UNINTERRUPTIBLE | TASK_EXCLUSIVE);
	/* WINDOW */
                spin_lock_irq(&io_request_lock);
                rq = get_request(q, rw);
                spin_unlock_irq(&io_request_lock);
                if (rq)
                        break;
                generic_unplug_device(q);
                schedule();
        }

As soon as we set TASK_UNINTERRUPTIBLE|TASK_EXCLUSIVE, this
task becomes visible to __wake_up_common and can soak
up a second wakeup.  I assume this hasn't been a reported problem
because request queues get lots of wakeups sent to them?

Still, changing the wakeup code in the way we've discussed
seems the way to go.  It also makes the extra wake_up()
at the end of x86's __down() unnecessary, which is a small
performance win - semaphores are currently wake-two.

But Linus had a different reason why that wakeup was there.
Need to dig out the email and stare at it.  But I don't see a
good reason to muck with the semaphores at this time.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
