Return-Path: <linux-kernel-owner+w=401wt.eu-S1760400AbWLJIno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760400AbWLJIno (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760485AbWLJInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:43:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34294 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760360AbWLJInn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:43:43 -0500
Date: Sun, 10 Dec 2006 00:43:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-Id: <20061210004318.8e1ef324.akpm@osdl.org>
In-Reply-To: <20061210082616.GB14057@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com>
	<20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
	<20061207205407.b4e356aa.akpm@osdl.org>
	<20061209102652.GA16607@elte.hu>
	<20061209114723.138b6e89.akpm@osdl.org>
	<20061210082616.GB14057@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 09:26:16 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > > Could do, not sure.  I'm planning on converting all the locking 
> > > > around here to preempt_disable() though.
> > > 
> > > please at least use an owner-recursive per-CPU lock,
> > 
> > a wot?
> 
> something like the pseudocode further below - when applied to a data 
> structure it has semantics and scalability close to that of 
> preempt_disable(), but it is still preemptible and the lock is specific.
> 
> > > not a naked preempt_disable()! The concurrency rules for data 
> > > structures changed via preempt_disable() are quite hard to sort out 
> > > after the fact. (preempt_disable() is too opaque,
> > 
> > preempt_disable() is the preferred way of holding off cpu hotplug.
> 
> well, preempt_disable() is the scheduler's internal mechanism to keep 
> tasks from being preempted. It is fast but it also has non-nice 
> side-effect:
> 
> 1) nothing tells us what the connection between preempt-disable and data 
>    structure is. If we let preempt_disable() spread then we'll end up 
>    with a situation like the BKL: all preempt_disable() sections become 
>    one big blob of code with hard-to-define specifications, and if we 
>    take out code from that blob stuff mysteriously breaks.

Well we can add some suitably-named wrapper around preempt_disable() to make
it obvious why we're calling it.  But I haven't noticed any such problem with
existing usages.

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

That's functionally equivalent to what we have now, and it isn't working
too well.
