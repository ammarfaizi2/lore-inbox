Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbRE2Lbd>; Tue, 29 May 2001 07:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbRE2LbX>; Tue, 29 May 2001 07:31:23 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:21381 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261889AbRE2LbM>; Tue, 29 May 2001 07:31:12 -0400
Message-ID: <3B13870D.16B34800@uow.edu.au>
Date: Tue, 29 May 2001 21:25:01 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arthur Naseef <artn@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2: tq_scheduler functions scheduling and waiting
In-Reply-To: <3B13092F.F8AC6E92@uow.edu.au> <BGEHKJAIFDCFCMFALMGPEEHBCAAA.artn@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Naseef wrote:
> 
> Andrew:
> 
> Excellent.  I will look at the 2.4 sources.
> 
> In addition to the TASK_ZOMBIE issue you mention, I believe there
> is an issue of false termination of wait queues.  Consider this:
> 
>         - Task places itself on a wait queue
>         - Calls schedule()
>         - tq_scheduler function does the same
> 
> Now, there are two events which could place the task in TASK_RUNNING
> and no clear way to differentiate.  And, since most of the kernel
> code does not check that the wait condition was actually met, this
> could lead to all types of problems, right?
> 

Yes.  The situation where one task is on two waitqueues
is rare, but does happen.  And yes, there is code out there
which does a bare schedule() and *assumes* that once the
schedule has returned, the thing it was waiting for has
indeed occurred.

Generally this is poor practice - it's safer to loop
over the schedule() call until the condition you're
sleeping on has been tested.

You really shouldn't be sleeping in this way on tq_scheduler
if there's any way in which the sleep can take an extended
period of time.  You may end up putting important kernel
tasks to sleep.

Best to use schedule_task(), or an independent kernel thread.

-
