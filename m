Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132824AbRDDODg>; Wed, 4 Apr 2001 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRDDOD0>; Wed, 4 Apr 2001 10:03:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26322 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132825AbRDDODQ>;
	Wed, 4 Apr 2001 10:03:16 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: <mingo@elte.hu>
Cc: Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 10:03:10 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 10:02:33 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I grant you that the code is not as clean as the current scheduler,
so maybe you missed that part.

For the priority scheduler:
Yes the task_to_qid assumes a NON-affinity (no cpu, no mm) to determine
the list index to where the task has to be enqueued.
However, if you wonder down to the search_range section of the scheduler,
you see that we  do add the "+1" for equal mm. All I did here was take
the goodness() function a part for search_range in order to insert some
extra code that speeds up the code.

Again, I don't want to lean to hard on the priority scheduler, because
we only did this to have a reference point regarding lock contention and
lock hold. This is stuff that many operating systems did years ago, most
of which have moved on to add MQ to that. So that is what the LSE
scheduling team is pushing.

I understand the dilemma that the Linux scheduler is in, namely satisfy
the low end at all cost. But I believe that in order for Linux to push
into the high end we need to address the scalability of the current
scheduler.
Simply handwaving and declaring that lots of running tasks is a stupid
idea doesn't get us there.
If indeed you assume that there #running-tasks ~ #cpus then each task
should alot a reasonable amount of work and any small overhead incurred
should be amortizable. However as we contend if #running-tasks >> #cpus
is a situation we need to deal with, the living with the current lock
contention can really drag us down.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Ingo Molnar <mingo@elte.hu>@elte.hu> on 04/04/2001 02:28:31 AM

Please respond to <mingo@elte.hu>

Sent by:  <mingo@elte.hu>


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   Hubertus Franke/Watson/IBM@IBMUS, Fabio Riccardi
      <fabio@chromium.com>, Linux Kernel List
      <linux-kernel@vger.kernel.org>
Subject:  Re: a quest for a better scheduler




On Tue, 3 Apr 2001, Mike Kravetz wrote:

> Our 'priority queue' implementation uses almost the same goodness
> function as the current scheduler.  The main difference between our
> 'priority queue' scheduler and the current scheduler is the structure
> of the runqueue.  We break up the single runqueue into a set of
> priority based runqueues. The 'goodness' of a task determines what
> sub-queue a task is placed in.  Tasks with higher goodness values are
> placed in higher priority queues than tasks with lower goodness
> values. [...]

we are talking about the same thing, re-read my mail. this design assumes
that 'goodness' is constant in the sense that it does not depend on the
previous process.

and no, your are not using the same goodness() function, you omitted the
prev->mm == next->mm component to goodness(), due to this design
limitation.

     Ingo





