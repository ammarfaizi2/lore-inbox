Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRAaJOz>; Wed, 31 Jan 2001 04:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbRAaJOp>; Wed, 31 Jan 2001 04:14:45 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:34309 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131300AbRAaJOd>; Wed, 31 Jan 2001 04:14:33 -0500
Date: Wed, 31 Jan 2001 09:14:30 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Timur Tabi <ttabi@interactivesi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <27QDuD.A.1CC.2e1d6@dinero.interactivesi.com>
Message-ID: <Pine.LNX.4.30.0101310901030.6074-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Timur Tabi wrote:

> > If you have a task that looks like:
> > 
> >     loop:
> >         <do something important>
> >         sleep_on(q)
> > 
> > And you do wakeup(q) hoping to get something important done, then if the
> > task isn't sleeping at the time of the wakeup it will ignore the wakeup
> > and go to sleep, which imay not be what you wanted.
> 
> Ok, so how should this code have been written?

DECLARE_WAIT_QUEUE(wait, current);

while(1) {
	do_something_important()

	set_current_state(TASK_INTERRUPTIBLE);
	add_wait_queue(&q, &wait);

	/* Now if something arrives, we'll be 'woken' immediately -
	   - that is; our state will be set to TASK_RUNNING */

	if (!stuff_to_do()) {
		/* If the 'stuff' arrives here, we get woken anyway,
			so the schedule() returns immediately. You 
			can use schedule_timeout() here if you need
			a timeout, obviously */
		schedule();
	}

	set_current_state(TASK_RUNNING);
	remove_wait_queue(&q, &wait);

	if (signal_pending(current)) {
		/* You've been signalled. Deal with it. If you don't 
			want signals to wake you, use TASK_UNINTERRUPTIBLE
			above instead of TASK_INTERRUPTIBLE. Be aware
			that you'll add one to the load average all the
			time your task is sleeping then. */
		return -EINTR;
	}
}	


Alternatively, you could up() a semaphore for each task that's do be done, 
and down() it again each time you remove one from the queue. 

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
