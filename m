Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936205AbWK3LrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936205AbWK3LrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936209AbWK3LrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:47:00 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12775 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936205AbWK3Lq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:46:59 -0500
Date: Thu, 30 Nov 2006 12:46:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130114617.GA2324@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130031933.5d30ec09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130031933.5d30ec09.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > This would be done totally serialized and while holding the hotplug 
> > lock, so no CPU could go away or arrive while this operation is 
> > going on.
> 
> You said "the hotplug lock".  That is the problem.

maybe i'm too dense today but i still dont see the fundamental problem. 

Even with complex inter-subsystem interactions, hotplugging could be 
effectively and scalably controlled via a self-recursive per-CPU mutex, 
and a pointer to it embedded in task_struct:

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

50 lines of code at most. The only rule is to not use cpu_hotplug_lock() 
in process-context non-preemptible code [interrupt contexts are 
automatically ignored]. What am i missing?

	Ingo
