Return-Path: <linux-kernel-owner+w=401wt.eu-S1762558AbWLKGLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762558AbWLKGLN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762559AbWLKGLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:11:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59182 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762558AbWLKGLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:11:12 -0500
Date: Mon, 11 Dec 2006 07:09:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061211060936.GA20528@elte.hu>
References: <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org> <20061210082616.GB14057@elte.hu> <20061210004318.8e1ef324.akpm@osdl.org> <20061210114943.GA14749@elte.hu> <20061210041600.56306676.akpm@osdl.org> <20061210121914.GA20466@elte.hu> <20061210043446.d7eda6f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210043446.d7eda6f0.akpm@osdl.org>
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

> > > > > > 	{
> > > > > > 		int cpu = raw_smp_processor_id();
> > > > > > 		/*
> > > > > > 		 * Interrupts/softirqs are hotplug-safe:
> > > > > > 		 */
> > > > > > 		if (in_interrupt())
> > > > > > 			return;
> > > > > > 		if (current->hotplug_depth++)
> > > > > > 			return;
> > > 
> > > <preempt, cpu hot-unplug, resume on different CPU>
> > > 
> > > > > > 		current->hotplug_lock = &per_cpu(hotplug_lock, cpu);
> > > 
> > > <use-after-free>
> > > 
> > > > > > 		mutex_lock(current->hotplug_lock);
> > > 
> > > And it sleeps, so we can't use preempt_disable().
> > 
> > i explained it in the other mail - this is the 'read' side. The 'write' 
> > side (code actually wanting to /do/ a CPU hotplug state transition) has 
> > to take /all/ these locks before it can take a CPU down.
> 
> Doesn't matter - the race is still there.
> 
> Well, not really, because we don't free the percpu data of offlined 
> CPUs, but we'd like to.
>
> And it's easily fixable by using a statically-allocated array.  That 
> would make life easier for code which wants to take this lock early in 
> boot too.

yeah.

but i think your freeze_processes() idea is even better - it would unify 
the suspend and the CPU-hotplug infrastructure even more. (and kprobes 
wants to use freeze_processes() too)

	Ingo
