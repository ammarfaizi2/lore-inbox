Return-Path: <linux-kernel-owner+w=401wt.eu-S1760433AbWLJI2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760433AbWLJI2O (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760443AbWLJI2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:28:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43576 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760411AbWLJI2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:28:13 -0500
Date: Sun, 10 Dec 2006 09:26:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061210082616.GB14057@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209114723.138b6e89.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > Could do, not sure.  I'm planning on converting all the locking 
> > > around here to preempt_disable() though.
> > 
> > please at least use an owner-recursive per-CPU lock,
> 
> a wot?

something like the pseudocode further below - when applied to a data 
structure it has semantics and scalability close to that of 
preempt_disable(), but it is still preemptible and the lock is specific.

> > not a naked preempt_disable()! The concurrency rules for data 
> > structures changed via preempt_disable() are quite hard to sort out 
> > after the fact. (preempt_disable() is too opaque,
> 
> preempt_disable() is the preferred way of holding off cpu hotplug.

well, preempt_disable() is the scheduler's internal mechanism to keep 
tasks from being preempted. It is fast but it also has non-nice 
side-effect:

1) nothing tells us what the connection between preempt-disable and data 
   structure is. If we let preempt_disable() spread then we'll end up 
   with a situation like the BKL: all preempt_disable() sections become 
   one big blob of code with hard-to-define specifications, and if we 
   take out code from that blob stuff mysteriously breaks. If on the 
   other hand we use a specific lock, that is visible in the source 
   already (and can be programmatically attached to the data structure 
   too, like i did it in the PI-list debugging code, where the 
   connection between the lock and the list is explicit and the 
   debugging code checks that the lock is held when the data structure 
   is accessed.)

2) it disables 'all preemption', not 'CPU hotplug down on this CPU' - so 
   it's a cannon to shoot at sparrows.

> > it doesnt attach data structure to critical section, like normal 
> > locks do.)
> 
> the data structure is the CPU, and its per-cpu data.  And cpu_online_map.

The abstract data structure of CPU hotplug is /not/ "the CPU" but:

   a CPU's ability to run tasks, expressed via cpu_online_map, the
   runqueues, the per-CPU systems kthreads and all the other hotplug
   data structures.

"CPU hotplug code" is the implementation of that data structure, used 
via the 'bring CPU down' and 'CPU up' methods of the data structure.

preempt_disable() on the other hand is a scheduler-internal method that 
keeps a context from being forcibly rescheduled. As such it is a very 
broad superset of some of CPU-hotplug's requirements (because if a CPU 
has a task that cannot be rescheduled it then obviously the property of 
the CPU to run tasks is frozen), but IMO totally unsuitable for use as a 
real hotplug API. The two things are really quite fundamentally 
different.

the 'natural' locking method of the CPU hotplug data structures is: 
"keep this CPU from being brought down". The pseudocode below expresses 
this and only this.

	struct task_struct {
		...
		int hotplug_depth;
		struct mutex *hotplug_lock;
	}
	...

	DEFINE_PER_CPU(struct mutex, hotplug_lock);

	void cpu_hotplug_lock(void)
	{
		int cpu = raw_smp_processor_id();
		/*
		 * Interrupts/softirqs are hotplug-safe:
		 */
		if (in_interrupt())
			return;
		if (current->hotplug_depth++)
			return;
		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
		mutex_lock(current->hotplug_lock);
	}

	void cpu_hotplug_unlock(void)
	{
		int cpu;

		if (in_interrupt())
			return;
		if (DEBUG_LOCKS_WARN_ON(!current->hotplug_depth))
			return;
		if (--current->hotplug_depth)
			return;

		mutex_unlock(current->hotplug_lock);
		current->hotplug_lock = NULL;
	}

	...

	void do_exit(void)
	{
	...
		DEBUG_LOCKS_WARN_ON(current->hotplug_depth);
	...
	}
	...
	copy_process(void)
	{
	...
		p->hotplug_depth = 0;
		p->hotplug_lock = NULL;
	...
	}

	Ingo
