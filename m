Return-Path: <linux-kernel-owner+w=401wt.eu-S1760795AbWLJOQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760795AbWLJOQY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 09:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbWLJOQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 09:16:24 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42340 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760795AbWLJOQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 09:16:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: workqueue deadlock
Date: Sun, 10 Dec 2006 15:18:38 +0100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, vatsa@in.ibm.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Myron Stowe <myron.stowe@hp.com>, Jens Axboe <axboe@kernel.dk>,
       Dipankar <dipankar@in.ibm.com>, Gautham shenoy <ego@in.ibm.com>,
       Pavel Machek <pavel@ucw.cz>
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061210114943.GA14749@elte.hu> <20061210041600.56306676.akpm@osdl.org>
In-Reply-To: <20061210041600.56306676.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612101518.39334.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 10 December 2006 13:16, Andrew Morton wrote:
> On Sun, 10 Dec 2006 12:49:43 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > > 	void cpu_hotplug_lock(void)
> 
> This is actually not cpu-hotplug safe ;)  
> 
> > > > 	{
> > > > 		int cpu = raw_smp_processor_id();
> > > > 		/*
> > > > 		 * Interrupts/softirqs are hotplug-safe:
> > > > 		 */
> > > > 		if (in_interrupt())
> > > > 			return;
> > > > 		if (current->hotplug_depth++)
> > > > 			return;
> 
> <preempt, cpu hot-unplug, resume on different CPU>
> 
> > > > 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
> 
> <use-after-free>
> 
> > > > 		mutex_lock(current->hotplug_lock);
> 
> And it sleeps, so we can't use preempt_disable().
> 
> > > > 	}
> 
> It's worth noting that this very common sequence:
> 
> 	preempt_disable();
> 	cpu = smp_processor_id();
> 	...
> 	preempt_enable();
> 
> also provides cpu-hotunplug protection against scenarios such as the above.
> 
> > > That's functionally equivalent to what we have now, and it isn't 
> > > working too well.
> > 
> > hm, i thought the main reason of not using cpu_hotplug_lock() in a 
> > widespread manner was not related to its functionality but to its 
> > scalability - but i could be wrong.
> 
> It hasn't been noticed yet.
> 
> I suspect a large part of the reason for that is that we only really care
> about hot-unplug when this CPU reaches across to some other CPU's data.  Often
> _all_ other CPU's data.  And that's a super-inefficient thing, so it's rare.
> 
> Most of the problems we've had are due to borkage in cpufreq.  And that's
> simply cruddy code - it's not due to the complexity of CPU hotplug per-se.
> 
> > The one above is scalable and we 
> > could use it as /the/ method to control CPU hotplug. All the flux i 
> > remember related to cpu_hotplug_lock() use from the fork path and from 
> > other scheduler hotpaths related to its scalability bottleneck, not to 
> > its locking efficiency.
> 
> One quite different way of addressing all of this is to stop using
> stop_machine_run() for hotplug synchronisation and switch to the swsusp
> freezer infrastructure: all kernel threads and user processes need to stop
> and park themselves in a known state before we allow the CPU to be removed.
> lock_cpu_hotplug() becomes a no-op.
> 
> Dunno if it'll work - I only just thought of it.  It sure would simplify
> things.

Hm, currently we're using the CPU hotplug to disable the nonboot CPUs before
the freezer is called. ;-)

However, we're now trying to make the freezer SMP-safe, so that we can disable
the nonboot CPUs after devices have been suspended (we want to do this for
some ACPI-related reasons).  In fact we're almost there, I'm only waiting for
the confirmation from Pavel to post the patches.

When this is done, we won't need the CPU hotplug that much and I think the CPU
hotplug code will be able to do something like:

freeze_processes
suspend_cpufreq (or even suspend_all_devices)
remove_the_CPU_in_question
resume_cpufreq
thaw_processes

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
