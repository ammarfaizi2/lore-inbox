Return-Path: <linux-kernel-owner+w=401wt.eu-S1758430AbWLJMfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbWLJMfI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759074AbWLJMfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:35:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49505 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758430AbWLJMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:35:04 -0500
Date: Sun, 10 Dec 2006 04:34:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-Id: <20061210043446.d7eda6f0.akpm@osdl.org>
In-Reply-To: <20061210121914.GA20466@elte.hu>
References: <20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
	<20061207205407.b4e356aa.akpm@osdl.org>
	<20061209102652.GA16607@elte.hu>
	<20061209114723.138b6e89.akpm@osdl.org>
	<20061210082616.GB14057@elte.hu>
	<20061210004318.8e1ef324.akpm@osdl.org>
	<20061210114943.GA14749@elte.hu>
	<20061210041600.56306676.akpm@osdl.org>
	<20061210121914.GA20466@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 13:19:15 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > This is actually not cpu-hotplug safe ;)  
> > 
> > > > > 	{
> > > > > 		int cpu = raw_smp_processor_id();
> > > > > 		/*
> > > > > 		 * Interrupts/softirqs are hotplug-safe:
> > > > > 		 */
> > > > > 		if (in_interrupt())
> > > > > 			return;
> > > > > 		if (current->hotplug_depth++)
> > > > > 			return;
> > 
> > <preempt, cpu hot-unplug, resume on different CPU>
> > 
> > > > > 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
> > 
> > <use-after-free>
> > 
> > > > > 		mutex_lock(current->hotplug_lock);
> > 
> > And it sleeps, so we can't use preempt_disable().
> 
> i explained it in the other mail - this is the 'read' side. The 'write' 
> side (code actually wanting to /do/ a CPU hotplug state transition) has 
> to take /all/ these locks before it can take a CPU down.

Doesn't matter - the race is still there.

Well, not really, because we don't free the percpu data of offlined CPUs,
but we'd like to.

And it's easily fixable by using a statically-allocated array.  That would
make life easier for code which wants to take this lock early in boot too.

> so this is still a global CPU hotplug lock, but made scalable.

Scalability is not the problem.  At present, at least.
