Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbRE2LVX>; Tue, 29 May 2001 07:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbRE2LVN>; Tue, 29 May 2001 07:21:13 -0400
Received: from femail9.sdc1.sfba.home.com ([24.0.95.89]:471 "EHLO
	femail9.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261856AbRE2LVJ>; Tue, 29 May 2001 07:21:09 -0400
From: "Arthur Naseef" <artn@home.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.2: tq_scheduler functions scheduling and waiting
Date: Tue, 29 May 2001 07:21:48 -0400
Message-ID: <BGEHKJAIFDCFCMFALMGPEEHBCAAA.artn@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B13092F.F8AC6E92@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

Excellent.  I will look at the 2.4 sources.

In addition to the TASK_ZOMBIE issue you mention, I believe there
is an issue of false termination of wait queues.  Consider this:

	- Task places itself on a wait queue
	- Calls schedule()
	- tq_scheduler function does the same

Now, there are two events which could place the task in TASK_RUNNING
and no clear way to differentiate.  And, since most of the kernel
code does not check that the wait condition was actually met, this
could lead to all types of problems, right?

-art

-----Original Message-----
From: akpm@uow.edu.au [mailto:akpm@uow.edu.au]On Behalf Of Andrew Morton
Sent: Monday, May 28, 2001 10:28 PM
To: Arthur Naseef
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2: tq_scheduler functions scheduling and waiting


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
