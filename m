Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292406AbSBUOjK>; Thu, 21 Feb 2002 09:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292404AbSBUOjC>; Thu, 21 Feb 2002 09:39:02 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:34526 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S292407AbSBUOiq>; Thu, 21 Feb 2002 09:38:46 -0500
Date: Thu, 21 Feb 2002 15:38:22 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Paul Jackson <pj@engr.sgi.com>
cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com>
Message-ID: <Pine.LNX.4.21.0202211154190.12765-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

well I whished this kind of feedback came at my first attempt to have a
discussion on this subject. Would have saved me lots of reboots :-) The
reaction those days was:

Ingo> your patch does not solve the problem, the situation is more
Ingo> complex. What happens if the target task is not 'current' and is
Ingo> running on some other CPU? If we send the migration interrupt then
Ingo> nothing guarantees that the task will reschedule anytime soon, so
Ingo> the target CPU will keep spinning indefinitely. There are other
Ingo> problems too, like crossing calls to set_cpus_allowed(), etc. Right
Ingo> now set_cpus_allowed() can only be used for
Ingo> the current task, and must be used by kernel code that knows what it
Ingo> does.

and later:

Ingo> well, there is a way, by fixing the current mechanizm. But since
Ingo> nothing uses it currently it wont get much testing. I only pointed
Ingo> out that the patch does not solve some of the races.

So I kept Ingo's design idea of sending IPIs. And I made it survive
crossing calls and avoid spinning around for long time, specially in
interrupt.


On Wed, 20 Feb 2002, Paul Jackson wrote:

> > A running task has no reason to change the CPU!
> 
> well ... so ... it will check, every time slice or so,
> whether it should give up the CPU, right?  That is, the
> code sched.c scheduler() does run every slice or so, right?

A task gives up the CPU in schedule() and is immediately enqueued in the
corresponding expired priority array of the _same_ runqueue. So it stays
on the same CPU! When the expired array is selected as the active one the
task will run again on the CPU which doesn't fit to its cpus_allowed
mask. That's a problem for Kimi's CPU hotplug, I guess...


> > ... The alternative to sending an IPI is to put additional
> > code into schedule() which checks the cpus_allowed mask. This
> > is not desirable, I guess.
> 
> Well ... not exactly "check the cpus_allowed mask" because that
> mask is no longer something we can change from another process,
> with Ingo's latest scheduler.

The cpus_allowed mask still has its old meaning: load_balance() checks
whether it is allowed to migrate the task to its own CPU.

I didn't dare to extend the schedule() code for a seldom used
feature, especially after I saw how happy people were with lat_ctx
results getting lower with each new patch from Ingo.


> Rather check some other task field.  Say we had a
> "proposed_cpus_allowed" field of the task_struct, settable by
> any process (perhaps including an associated lock, if need be).
> 
> Say this field was normally set to zero, but could be
> set to some non-zero value by some other process wanting
> to change the current process cpus_allowed.  Then in the
> scheduler, at the very bottom of schedule(), check to see if
> current->proposed_cpus_allowed is non-zero.  If it is, use
> set_cpus_allowed() to set cpus_allowed to the proposed value.

You mean after switching context? That increases the cost of schedule(),
too. But you are right, then you at least are in the happy case of needing
to change the current task.


> How about not changing anything of the target task synchronously,
> except for some new "proposed_cpus_allowed" field.  Set that
> field and get out of there.  Let the target process run the
> set_cpus_allowed() routine on itself, next time it passes through
> the schedule() code.  Leave it the case that the set_cpus_allowed()
> routine can only be run on the current process.

Yes, it is the simplest solution, I agree. If Ingo wants to make the 
schedule() path longer.


> > Multiple calls can and will occur if you allow users to change the
> > cpu masks of their processes. And the feature was easy to get by just
> > replicating the spinlocks.
> 
> Isn't it customary in Linux kernel work to minimize the number
> of locks -- avoid replication unless there is a genuine need
> (a hot lock, say) to replicate locks?  We don't routinely add
> features because they are easy -- we add them because they are
> needed.

>From Ingo's initial reaction I interpreted it as a desireable feature. 

All I want is a working solution and I hope this discussion will show that
there is demand for it and set_cpus_allowed() will be fixed, one way or
another...

Best regards,

Erich Focht

---
NEC European Supercomputer Systems, European HPC Technology Center



