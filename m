Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291825AbSBAQQN>; Fri, 1 Feb 2002 11:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291830AbSBAQQD>; Fri, 1 Feb 2002 11:16:03 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:32218 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S291825AbSBAQPx>; Fri, 1 Feb 2002 11:15:53 -0500
Date: Fri, 1 Feb 2002 17:15:45 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O(1) J9 scheduler: set_cpus_allowed
In-Reply-To: <Pine.LNX.4.33.0202011803350.11284-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0202011633580.6004-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I understand correctly that there is no clean way right now to change
cpus_allowed of a task (except for current)? In the old scheduler it was
enough to set cpus_allowed and need_resched=1...

On Fri, 1 Feb 2002, Ingo Molnar wrote:

> > the function set_cpus_allowed(task_t *p, unsigned long new_mask) works
> > "as is" only if called for the task p=current. The appended patch
> > corrects this and enables e.g. external load balancers to change the
> > cpus_allowed mask of an arbitrary process.
> 
> your patch does not solve the problem, the situation is more complex. What
> happens if the target task is not 'current' and is running on some other
> CPU? If we send the migration interrupt then nothing guarantees that the
> task will reschedule anytime soon, so the target CPU will keep spinning
> indefinitely. There are other problems too, like crossing calls to
> set_cpus_allowed(), etc. Right now set_cpus_allowed() can only be used for
> the current task, and must be used by kernel code that knows what it does.

I understand your point about crossing calls. Besides this I still think
that set_cpus_allowed() does the job, after all wait_task_inactive() has
to return sometime. But of course, the target CPU shouldn't spend this
time in an interrupt routine.

What if you just 'remember' the task you want to take over on the target
CPU and do the real work later in sched_tick()? After all the task to be
moved has the state TASK_UNINTERRUPTIBLE and should be dequeued soon. In
sched_tick() then one would check whether the array field is NULL instead
of wait_task_inactive()...


> > BTW: how about migrating the definition of the structures runqueue and
> > prio_array into include/linux/sched.h and exporting the symbol
> > runqueues? It would help with debugging, monitoring and other
> > developments.
> 
> for debugging you can export it temporarily. Otherwise i consider it a
> feature that no scheduler internals are visible externally in any way.

Hmmm, some things could be useful to see from outside. rq->nr_running, for
example.

Regards,

Erich

