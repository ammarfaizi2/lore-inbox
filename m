Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936306AbWK3MoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936306AbWK3MoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936305AbWK3MoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:44:16 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:60336 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S936306AbWK3MoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:44:14 -0500
Date: Thu, 30 Nov 2006 18:14:21 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Gautham R Shenoy <ego@in.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130124421.GB25439@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130031933.5d30ec09.akpm@osdl.org> <20061130114617.GA2324@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130114617.GA2324@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 12:46:17PM +0100, Ingo Molnar wrote:
> 
> 	struct task_struct {
> 		...
> 		int hotplug_depth;
> 		struct mutex *hotplug_lock;
> 	}
> 	...
> 
> 	DEFINE_PER_CPU(struct mutex, hotplug_lock);
> 
> 	void cpu_hotplug_lock(void)
> 	{
> 		int cpu = raw_smp_processor_id();
> 		/*
> 		 * Interrupts/softirqs are hotplug-safe:
> 		 */
> 		if (in_interrupt())
> 			return;
> 		if (current->hotplug_depth++)
> 			return;
> 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
> 		mutex_lock(current->hotplug_lock);
> 	}
> 
> 	void cpu_hotplug_unlock(void)
> 	{
> 		int cpu;
> 
> 		if (in_interrupt())
> 			return;
> 		if (DEBUG_LOCKS_WARN_ON(!current->hotplug_depth))
> 			return;
> 		if (--current->hotplug_depth)
> 			return;
> 
> 		mutex_unlock(current->hotplug_lock);
> 		current->hotplug_lock = NULL;
> 	}
> 

In process context preemptible code, 
Lets say we are currently running on processor i.

cpu_hotplug_lock() ; /* does mutex_lock(&percpu(hotplug_lock, i)) */

/* do some operation, which might sleep */
/* migrates to cpu j */

cpu_hotplug_unlock(); /* does mutex_unlock(&percpu(hotplug_lock, i)
			 while running on cpu j */

This would cause cacheline ping pong, no?

> 
> 	Ingo

regards 
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
