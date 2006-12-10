Return-Path: <linux-kernel-owner+w=401wt.eu-S1758738AbWLJMQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbWLJMQS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758762AbWLJMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:16:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48360 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758738AbWLJMQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:16:17 -0500
Date: Sun, 10 Dec 2006 04:16:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-Id: <20061210041600.56306676.akpm@osdl.org>
In-Reply-To: <20061210114943.GA14749@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com>
	<20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
	<20061207205407.b4e356aa.akpm@osdl.org>
	<20061209102652.GA16607@elte.hu>
	<20061209114723.138b6e89.akpm@osdl.org>
	<20061210082616.GB14057@elte.hu>
	<20061210004318.8e1ef324.akpm@osdl.org>
	<20061210114943.GA14749@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 12:49:43 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > > 	void cpu_hotplug_lock(void)

This is actually not cpu-hotplug safe ;)  

> > > 	{
> > > 		int cpu = raw_smp_processor_id();
> > > 		/*
> > > 		 * Interrupts/softirqs are hotplug-safe:
> > > 		 */
> > > 		if (in_interrupt())
> > > 			return;
> > > 		if (current->hotplug_depth++)
> > > 			return;

<preempt, cpu hot-unplug, resume on different CPU>

> > > 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);

<use-after-free>

> > > 		mutex_lock(current->hotplug_lock);

And it sleeps, so we can't use preempt_disable().

> > > 	}

It's worth noting that this very common sequence:

	preempt_disable();
	cpu = smp_processor_id();
	...
	preempt_enable();

also provides cpu-hotunplug protection against scenarios such as the above.

> > That's functionally equivalent to what we have now, and it isn't 
> > working too well.
> 
> hm, i thought the main reason of not using cpu_hotplug_lock() in a 
> widespread manner was not related to its functionality but to its 
> scalability - but i could be wrong.

It hasn't been noticed yet.

I suspect a large part of the reason for that is that we only really care
about hot-unplug when this CPU reaches across to some other CPU's data.  Often
_all_ other CPU's data.  And that's a super-inefficient thing, so it's rare.

Most of the problems we've had are due to borkage in cpufreq.  And that's
simply cruddy code - it's not due to the complexity of CPU hotplug per-se.

> The one above is scalable and we 
> could use it as /the/ method to control CPU hotplug. All the flux i 
> remember related to cpu_hotplug_lock() use from the fork path and from 
> other scheduler hotpaths related to its scalability bottleneck, not to 
> its locking efficiency.

One quite different way of addressing all of this is to stop using
stop_machine_run() for hotplug synchronisation and switch to the swsusp
freezer infrastructure: all kernel threads and user processes need to stop
and park themselves in a known state before we allow the CPU to be removed.
lock_cpu_hotplug() becomes a no-op.

Dunno if it'll work - I only just thought of it.  It sure would simplify
things.
