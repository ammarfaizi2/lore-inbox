Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCUAZR>; Tue, 20 Mar 2001 19:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCUAZI>; Tue, 20 Mar 2001 19:25:08 -0500
Received: from nrg.org ([216.101.165.106]:27242 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129166AbRCUAYt>;
	Tue, 20 Mar 2001 19:24:49 -0500
Date: Tue, 20 Mar 2001 16:24:02 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <m14fHk9-001PKgC@mozart>
Message-ID: <Pine.LNX.4.05.10103201525480.26853-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Rusty Russell wrote:
> 	I can see three problems with this approach, only one of which
> is serious.
> 
> The first is code which is already SMP unsafe is now a problem for
> everyone, not just the 0.1% of SMP machines.  I consider this a good
> thing for 2.5 though.

So do I.

> The second is that there are "manual" locking schemes which are used
> in several places in the kernel which rely on non-preemptability;
> de-facto spinlocks if you will.  I consider all these uses flawed: (1)
> they are often subtly broken anyway, (2) they make reading those parts
> of the code much harder, and (3) they break when things like this are
> done.

Likewise.

> The third is that preemtivity conflicts with the naive
> quiescent-period approach proposed for module unloading in 2.5, and
> useful for several other things (eg. hotplugging CPUs).  This method
> relies on knowing that when a schedule() has occurred on every CPU, we
> know noone is holding certain references.  The simplest example is a
> single linked list: you can traverse without a lock as long as you
> don't sleep, and then someone can unlink a node, and wait for a
> schedule on every other CPU before freeing it.  The non-SMP case is a
> noop.  See synchonize_kernel() below.

So, to make sure I understand this, the code to free a node would look
like:

	prev->next = node->next; /* assumed to be atomic */
	synchronize_kernel();
	free(node);

So that any other CPU concurrently traversing the list would see a
consistent state, either including or not including "node" before the
call to synchronize_kernel(); but after synchronize_kernel() all other
CPUs are guaranteed to see a list that no longer includes "node", so it
is now safe to free it.

It looks like there are also implicit assumptions to this approach, like
no other CPU is trying to use the same approach simultaneously to free
"prev".  So my initial reaction is that this approach is, like the
manual locking schemes you commented on above, open to being subtly
broken when people don't understand all the implicit assumptions and
subsequently invalidate them.

> This, too, is soluble, but it means that synchronize_kernel() must
> guarantee that each task which was running or preempted in kernel
> space when it was called, has been non-preemtively scheduled before
> synchronize_kernel() can exit.  Icky.

Yes, you're right.

> Thoughts?

Perhaps synchronize_kernel() could take the run_queue lock, mark all the
tasks on it and count them.  Any task marked when it calls schedule()
voluntarily (but not if it is preempted) is unmarked and the count
decremented.  synchronize_kernel() continues until the count is zero.
As you said, "Icky."

> /* We could keep a schedule count for each CPU and make idle tasks
>    schedule (some don't unless need_resched), but this scales quite
>    well (eg. 64 processors, average time to wait for first schedule =
>    jiffie/64.  Total time for all processors = jiffie/63 + jiffie/62...
> 
>    At 1024 cpus, this is about 7.5 jiffies.  And that assumes noone
>    schedules early. --RR */
> void synchronize_kernel(void)
> {
> 	unsigned long cpus_allowed, policy, rt_priority;
> 
> 	/* Save current state */
> 	cpus_allowed = current->cpus_allowed;
> 	policy = current->policy;
> 	rt_priority = current->rt_priority;
> 
> 	/* Create an unreal time task. */
> 	current->policy = SCHED_FIFO;
> 	current->rt_priority = 1001 + sys_sched_get_priority_max(SCHED_FIFO);
> 
> 	/* Make us schedulable on all CPUs. */
> 	current->cpus_allowed = (1UL<<smp_num_cpus)-1;
> 	
> 	/* Eliminate current cpu, reschedule */
> 	while ((current->cpus_allowed &= ~(1 << smp_processor_id())) != 0)
> 		schedule();
> 
> 	/* Back to normal. */
> 	current->cpus_allowed = cpus_allowed;
> 	current->policy = policy;
> 	current->rt_priority = rt_priority;
> }
> 

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

