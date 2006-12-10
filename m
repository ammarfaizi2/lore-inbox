Return-Path: <linux-kernel-owner+w=401wt.eu-S1758499AbWLJLvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499AbWLJLvN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbWLJLvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:51:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57281 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758430AbWLJLvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:51:12 -0500
Date: Sun, 10 Dec 2006 12:49:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061210114943.GA14749@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org> <20061210082616.GB14057@elte.hu> <20061210004318.8e1ef324.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210004318.8e1ef324.akpm@osdl.org>
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

> > > > not a naked preempt_disable()! The concurrency rules for data 
> > > > structures changed via preempt_disable() are quite hard to sort out 
> > > > after the fact. (preempt_disable() is too opaque,
> > > 
> > > preempt_disable() is the preferred way of holding off cpu hotplug.
> > 
> > well, preempt_disable() is the scheduler's internal mechanism to keep 
> > tasks from being preempted. It is fast but it also has non-nice 
> > side-effect:
> > 
> > 1) nothing tells us what the connection between preempt-disable and data 
> >    structure is. If we let preempt_disable() spread then we'll end up 
> >    with a situation like the BKL: all preempt_disable() sections become 
> >    one big blob of code with hard-to-define specifications, and if we 
> >    take out code from that blob stuff mysteriously breaks.
> 
> Well we can add some suitably-named wrapper around preempt_disable() 
> to make it obvious why we're calling it.  But I haven't noticed any 
> such problem with existing usages.

ok, as long as there's a separate API for it (which just maps to 
disable_preempt(), or whatever), i'm fine with it. The complications 
with preempt_disable()/preempt_enable() and local_irq_disable()/enable() 
come when someone tries to implement something like a fully preemptible 
kernel :-)

it was quite some work to sort the irqs on/off + per-cpu assumptions out 
in the slab allocator and in the page allocator:

$ diffstat patches/rt-slab.patch
 mm/slab.c |  460 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 296 insertions(+), 164 deletions(-)

$ diffstat patches/rt-page_alloc.patch
 mm/page_alloc.c |  125 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file  changed, 90 insertions(+), 35 deletions(-)

> > 	void cpu_hotplug_lock(void)
> > 	{
> > 		int cpu = raw_smp_processor_id();
> > 		/*
> > 		 * Interrupts/softirqs are hotplug-safe:
> > 		 */
> > 		if (in_interrupt())
> > 			return;
> > 		if (current->hotplug_depth++)
> > 			return;
> > 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
> > 		mutex_lock(current->hotplug_lock);
> > 	}
> 
> That's functionally equivalent to what we have now, and it isn't 
> working too well.

hm, i thought the main reason of not using cpu_hotplug_lock() in a 
widespread manner was not related to its functionality but to its 
scalability - but i could be wrong. The one above is scalable and we 
could use it as /the/ method to control CPU hotplug. All the flux i 
remember related to cpu_hotplug_lock() use from the fork path and from 
other scheduler hotpaths related to its scalability bottleneck, not to 
its locking efficiency.

	Ingo
