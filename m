Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbRE2C65>; Mon, 28 May 2001 22:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbRE2C6r>; Mon, 28 May 2001 22:58:47 -0400
Received: from zeus.kernel.org ([209.10.41.242]:17825 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262023AbRE2C6j>;
	Mon, 28 May 2001 22:58:39 -0400
Message-ID: <3B13092F.F8AC6E92@uow.edu.au>
Date: Tue, 29 May 2001 12:27:59 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arthur Naseef <artn@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2: tq_scheduler functions scheduling and waiting
In-Reply-To: <BGEHKJAIFDCFCMFALMGPIEHACAAA.artn@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Naseef wrote:
> 
> All:
> 
> I have been diagnosing kernel panics for over a week and I have
> concerns with the use of tq_scheduler for which I was hoping I
> could get some assistance.
> 
> Is it considered acceptable for functions in the tq_scheduler
> task list to call schedule?  Is it acceptable for such functions
> to wait on wait queues?  What limitations exist?

When a task wants to exit, it cleans up all its stuff,
sets its state to TASK_ZOMBIE and then calls schedule().
The scheduler takes it off the runqueue and the task
is never again executed.  It's just a couple of stack
pages which are waiting for someone in wait4() to release.

But imagine what happens if the TASK_ZOMBIE task hits
schedule() and finds a tq_scheduler task to run.  And that
task calls schedule().  In state TASK_ZOMBIE.  Messy.

At the very least, the schedule() call will never return.

If the tq_scheduler task sets current->state to 
TASK_[UN]INTERRUPTIBLE (as it should) before calling
schedule() then it has overwritten TASK_ZOMBIE and the
task which is trying to exit has become magically
resurrected.  As far as I can tell, the "dead" task
will run again, do the `fake_volatile' thing in do_exit()
and try to go zombie again.

It would be very interesting to change the test in
schedule():

        sti();
-       if (tq_scheduler)
+       if (tq_scheduler && current->state != TASK_ZOMBIE)
                goto handle_tq_scheduler;

It's all rather unpleasant, and tq_scheduler was killed
in 2.4.  I suggest you take a look at all the serial
drivers in 2.4, see how I converted them to use schedule_task().
Someone kindly ported schedule_task() to 2.2.recent, so you
should be able to use that in the same way.

-
