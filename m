Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292604AbSBUBNK>; Wed, 20 Feb 2002 20:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292601AbSBUBNA>; Wed, 20 Feb 2002 20:13:00 -0500
Received: from rj.SGI.COM ([204.94.215.100]:47254 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S292604AbSBUBMt>;
	Wed, 20 Feb 2002 20:12:49 -0500
Date: Wed, 20 Feb 2002 17:12:21 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Erich Focht <focht@ess.nec.de>
cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.LNX.4.21.0202202337320.10032-100000@sx6.ess.nec.de>
Message-ID: <Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Erich Focht, responding to Paul Jackson, wrote:
>
> Hi Paul & Robert,
> 
> > On 20 Feb 2002, Robert Love, responding to Erich Focht, wrote:
> > > 
> > > ...
> > >
> > > Do we need the function to act asynchronously?  In other words,
> > > is it a requirement that the task reschedule immediately, or
> > > only that when it next reschedules it obeys its affinity?
> > 
> > ... [ we could ] ...
> > 
> > 1) As Erich did, use IPI to get immediate application
> > 
> > 2) Wakeup the target task, so that it will "soon" see the
> >    cpus_allowed change, but don't bother with the IPI, or
> > 
> > 3) Make no effort to expedite notifcation, and let the
> >    target notice its changed cpus_allowed when (and if)
> >    it ever happens to be scheduled active again.
> 
> A running task has no reason to change the CPU!

well ... so ... it will check, every time slice or so,
whether it should give up the CPU, right?  That is, the
code sched.c scheduler() does run every slice or so, right?


> ... The alternative to sending an IPI is to put additional
> code into schedule() which checks the cpus_allowed mask. This
> is not desirable, I guess.

Well ... not exactly "check the cpus_allowed mask" because that
mask is no longer something we can change from another process,
with Ingo's latest scheduler.

Rather check some other task field.  Say we had a
"proposed_cpus_allowed" field of the task_struct, settable by
any process (perhaps including an associated lock, if need be).

Say this field was normally set to zero, but could be
set to some non-zero value by some other process wanting
to change the current process cpus_allowed.  Then in the
scheduler, at the very bottom of schedule(), check to see if
current->proposed_cpus_allowed is non-zero.  If it is, use
set_cpus_allowed() to set cpus_allowed to the proposed value.

[I am painfully aware that I am not an expert in this code,
 so please be gentle if I'm spouting gibberish ...]


> Another problem is the right moment to change the cpu field of the
> task. ... The IPI to the target CPU is the same as in the
> initial design of Ingo. It has to wait for the task to unschedule and
> knows it will find it dequeued.

How about not changing anything of the target task synchronously,
except for some new "proposed_cpus_allowed" field.  Set that
field and get out of there.  Let the target process run the
set_cpus_allowed() routine on itself, next time it passes through
the schedule() code.  Leave it the case that the set_cpus_allowed()
routine can only be run on the current process.

Perhaps others need this cpus_allowed change (and the migration
of a task to a different allowed cpu) to happen "right away".
But I don't, and I don't (yet) know that anyone else does.


> Still, IPIs are only sent if we want to move a currently running
> task. Other tasks are simply dequeued and enqueued, the additional code
> for this (sched_move_task()) is minimal, in my oppinion.

And the need for this (sched_move_task()) also seems minimal.


> > > Also, what is the reason for allowing multiple calls to
> > > set_cpus_allowed?  How often would that even occur?
> 
> Multiple calls can and will occur if you allow users to change the
> cpu masks of their processes. And the feature was easy to get by just
> replicating the spinlocks.

Isn't it customary in Linux kernel work to minimize the number
of locks -- avoid replication unless there is a genuine need
(a hot lock, say) to replicate locks?  We don't routinely add
features because they are easy -- we add them because they are
needed.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

