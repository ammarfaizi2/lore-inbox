Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbRE3Blz>; Tue, 29 May 2001 21:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbRE3Blp>; Tue, 29 May 2001 21:41:45 -0400
Received: from femail9.sdc1.sfba.home.com ([24.0.95.89]:15087 "EHLO
	femail9.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262558AbRE3Blb>; Tue, 29 May 2001 21:41:31 -0400
From: "Arthur Naseef" <artn@home.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.2: tq_scheduler functions scheduling and waiting
Date: Tue, 29 May 2001 21:16:34 -0400
Message-ID: <BGEHKJAIFDCFCMFALMGPMEHCCAAA.artn@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B13870D.16B34800@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested with a kernel thread running the tq_scheduler and it
is much more stable.  The kernel still ran into a problem in n_tty.c
in which the compiler optimized-out the check "if (!tty)" in
n_tty_set_termios(); I am still investigating the right solution to
this.

As a long term fix, I will review the 2.4 and latest 2.2 sources.

> Yes.  The situation where one task is on two waitqueues
> is rare, but does happen.  And yes, there is code out there
> which does a bare schedule() and *assumes* that once the
> schedule has returned, the thing it was waiting for has
> indeed occurred.
> 
> Generally this is poor practice - it's safer to loop
> over the schedule() call until the condition you're
> sleeping on has been tested.

I see your point.  It would prevent this type of problem if all code
waiting for conditions made certain those conditions were met.  However,
given the way the kernel works, it is not necessary to check unless the
task specifically expects more than one condition to awaken it - at
least it wasn't until tq_scheduler was introduced.  Actually, that is
not fair either - only when functions in tq_scheduler starting
"blocking" did this become a problem.

It would help me tremendously if these types of limitations and
requirements for working in the kernel were well documented.  It takes
significant effort to determine the requirements, and to verify that
my understanding is correct.

> 
> You really shouldn't be sleeping in this way on tq_scheduler
> if there's any way in which the sleep can take an extended
> period of time.  You may end up putting important kernel
> tasks to sleep.

I agree.  In addition, even if the tq_scheduler function did check for
its own condition, a problem still exists when the task returns to the
code using the first wait queue before its condition is met; since the
code using the second wait queue would set the task state to running
and would not set it back (which it couldn't without knowing the
conditions to check).

> 
> Best to use schedule_task(), or an independent kernel thread.
> 
> -
