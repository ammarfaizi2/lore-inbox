Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLXPNw>; Sun, 24 Dec 2000 10:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLXPNm>; Sun, 24 Dec 2000 10:13:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:102 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129450AbQLXPNf>; Sun, 24 Dec 2000 10:13:35 -0500
Date: Sun, 24 Dec 2000 15:43:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001224154302.A844@athlon.random>
In-Reply-To: <3A444CAA.4C5A7A89@uow.edu.au>, <3A444CAA.4C5A7A89@uow.edu.au>; <20001223191159.B29450@athlon.random> <3A454205.D33090A8@uow.edu.au>, <3A454205.D33090A8@uow.edu.au>; <20001224015346.A17046@athlon.random> <3A455F6B.FAC3A4B7@uow.edu.au>, <3A455F6B.FAC3A4B7@uow.edu.au>; <20001224052128.A24560@athlon.random> <3A4586D6.EF357D62@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4586D6.EF357D62@uow.edu.au>; from andrewm@uow.edu.au on Sun, Dec 24, 2000 at 04:17:10PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 04:17:10PM +1100, Andrew Morton wrote:
> I was talking about a different scenario:
> 
>         add_wait_queue_exclusive(&q->wait_for_request, &wait);
>         for (;;) {
>                 __set_current_state(TASK_UNINTERRUPTIBLE);
> 	/* WINDOW */
>                 spin_lock_irq(&io_request_lock);
>                 rq = get_request(q, rw);
>                 spin_unlock_irq(&io_request_lock);
>                 if (rq)
>                         break;
>                 generic_unplug_device(q);
>                 schedule();
>         }
>         remove_wait_queue(&q->wait_for_request, &wait);
> 
> Suppose there are two tasks sleeping in the schedule().
> 
> A wakeup comes.  One task wakes.  It loops aound and reaches
> the window.  At this point in time, another wakeup gets sent
> to the waitqueue. It gets directed to the task which just
> woke up![..]

Ok, this is a very minor window compared to the current one, but yes, that
could happen too in test4.

> I assume this is because this waitqueue gets lots of wakeups sent to it.

It only gets the strictly necessary number of wakeups.

> Linus suggested at one point that we clear the waitqueue's
> WQ_FLAG_EXCLUSIVE bit when we wake it up, [..]

.. and then set it after checking if a new request is available, just
before schedule(). That would avoid the above race (and the one
I mentioned in previous email) but it doesn't address the lost wakeups
for example when setting USE_RW_WAIT_QUEUE_SPINLOCK to 1.

Considering wakeups only the ones that moves the task to the runqueue will get
rid of the races all together and it looks right conceptually so I prefer it.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
