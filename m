Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCTIlq>; Tue, 20 Mar 2001 03:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCTIlg>; Tue, 20 Mar 2001 03:41:36 -0500
Received: from [32.97.166.34] ([32.97.166.34]:61855 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S129259AbRCTIl3>;
	Tue, 20 Mar 2001 03:41:29 -0500
Message-Id: <m14fHk9-001PKgC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: nigel@nrg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Wed, 14 Mar 2001 17:25:22 -0800."
             <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org> 
Date: Tue, 20 Mar 2001 19:43:50 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org> you write:
> Kernel preemption is not allowed while spinlocks are held, which means
> that this patch alone cannot guarantee low preemption latencies.  But
> as long held locks (in particular the BKL) are replaced by finer-grained
> locks, this patch will enable lower latencies as the kernel also becomes
> more scalable on large SMP systems.

Hi Nigel,

	I can see three problems with this approach, only one of which
is serious.

The first is code which is already SMP unsafe is now a problem for
everyone, not just the 0.1% of SMP machines.  I consider this a good
thing for 2.5 though.

The second is that there are "manual" locking schemes which are used
in several places in the kernel which rely on non-preemptability;
de-facto spinlocks if you will.  I consider all these uses flawed: (1)
they are often subtly broken anyway, (2) they make reading those parts
of the code much harder, and (3) they break when things like this are
done.

The third is that preemtivity conflicts with the naive
quiescent-period approach proposed for module unloading in 2.5, and
useful for several other things (eg. hotplugging CPUs).  This method
relies on knowing that when a schedule() has occurred on every CPU, we
know noone is holding certain references.  The simplest example is a
single linked list: you can traverse without a lock as long as you
don't sleep, and then someone can unlink a node, and wait for a
schedule on every other CPU before freeing it.  The non-SMP case is a
noop.  See synchonize_kernel() below.

This, too, is soluble, but it means that synchronize_kernel() must
guarantee that each task which was running or preempted in kernel
space when it was called, has been non-preemtively scheduled before
synchronize_kernel() can exit.  Icky.

Thoughts?
Rusty.
--
Premature optmztion is rt of all evl. --DK

/* We could keep a schedule count for each CPU and make idle tasks
   schedule (some don't unless need_resched), but this scales quite
   well (eg. 64 processors, average time to wait for first schedule =
   jiffie/64.  Total time for all processors = jiffie/63 + jiffie/62...

   At 1024 cpus, this is about 7.5 jiffies.  And that assumes noone
   schedules early. --RR */
void synchronize_kernel(void)
{
	unsigned long cpus_allowed, policy, rt_priority;

	/* Save current state */
	cpus_allowed = current->cpus_allowed;
	policy = current->policy;
	rt_priority = current->rt_priority;

	/* Create an unreal time task. */
	current->policy = SCHED_FIFO;
	current->rt_priority = 1001 + sys_sched_get_priority_max(SCHED_FIFO);

	/* Make us schedulable on all CPUs. */
	current->cpus_allowed = (1UL<<smp_num_cpus)-1;
	
	/* Eliminate current cpu, reschedule */
	while ((current->cpus_allowed &= ~(1 << smp_processor_id())) != 0)
		schedule();

	/* Back to normal. */
	current->cpus_allowed = cpus_allowed;
	current->policy = policy;
	current->rt_priority = rt_priority;
}
