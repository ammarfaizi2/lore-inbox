Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292594AbSBUAId>; Wed, 20 Feb 2002 19:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292596AbSBUAI0>; Wed, 20 Feb 2002 19:08:26 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:54921 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S292594AbSBUAIN>; Wed, 20 Feb 2002 19:08:13 -0500
Date: Thu, 21 Feb 2002 01:07:55 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Paul Jackson <pj@engr.sgi.com>, Robert Love <rml@tech9.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Matthew Dobson <colpatch@us.ibm.com>, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.SGI.4.21.0202201220180.557863-100000@sam.engr.sgi.com>
Message-ID: <Pine.LNX.4.21.0202202337320.10032-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul & Robert,

> On 20 Feb 2002, Robert Love, responding to Erich Focht, wrote:
> > 
> > I was working on the same thing myself.

Oh! Then I hope you can give it a try and test it with your application?


> I do see things like minor spacing changes in this patch
> which might be bulking it up, but don't know the history
> of such changes (comment prefix changed from 3 chars " * "
> to 2 chars "* ", for example).
[...]
> 
> Would it not be cleaner to remove the lines, not leave old
> cruft laying around?  There are a half dozen other such
> commented out lines that this same notice might also apply to.

You're right, my mistake... Not beeing a patch for the latest kernel
but for 2.5.4 (with which Ingo's latest patch comes), it was more intended
as a discussion basis with people interested on cpus_allowed and
Ingo. I'll take more care of such details in future.


> > Do we need the function to act asynchronously?  In other words,
> > is it a requirement that the task reschedule immediately, or
> > only that when it next reschedules it obeys its affinity?
> 
> Excellent question, in my view.
> 
> I see three levels of synchonization possible here:
> 
> 1) As Erich did, use IPI to get immediate application
> 
> 2) Wakeup the target task, so that it will "soon" see the
>    cpus_allowed change, but don't bother with the IPI, or
> 
> 3) Make no effort to expedite notifcation, and let the
>    target notice its changed cpus_allowed when (and if)
>    it ever happens to be scheduled active again.

A running task has no reason to change the CPU! There is no code in
schedule() which makes it change the runqueue, this only happens if
load_balance() steals the task, but it wouldn't do so if there is only one
task running on a CPU. The alternative to sending an IPI is to put
additional code into schedule() which checks the cpus_allowed mask. This
is not desirable, I guess.

Another problem is the right moment to change the cpu field of the
task. One should better not change it while the task is enqueued because
there are a few calls to lock_task_rq() which could lock the wrong
RQ. Therefore we must wait for the task to be dequeued, which can be
achieved if we change it's state and wait for schedule() to throw it
out, then change the CPU. But which state should we restore? Between our
setting of the state and the schedule() the task may have changed state
itself... And might be woken up before we did our cpu change. I tried
some such variants and ended mostly in some deadlock :-( So I thought the
IPI to the source CPU is cleaner and avoids unnecessary wait in
set_cpus_allowed(). The IPI to the target CPU is the same as in the
initial design of Ingo. It has to wait for the task to unschedule and
knows it will find it dequeued.

Still, IPIs are only sent if we want to move a currently running
task. Other tasks are simply dequeued and enqueued, the additional code
for this (sched_move_task()) is minimal, in my oppinion.

> > Also, what is the reason for allowing multiple calls to
> > set_cpus_allowed?  How often would that even occur?

Multiple calls can and will occur if you allow users to change the
cpu masks of their processes. And the feature was easy to get by just
replicating the spinlocks.

Regards,
Erich

