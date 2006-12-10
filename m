Return-Path: <linux-kernel-owner+w=401wt.eu-S1758637AbWLJMVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637AbWLJMVM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbWLJMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:21:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48967 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757574AbWLJMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:21:11 -0500
Date: Sun, 10 Dec 2006 13:19:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061210121914.GA20466@elte.hu>
References: <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org> <20061210082616.GB14057@elte.hu> <20061210004318.8e1ef324.akpm@osdl.org> <20061210114943.GA14749@elte.hu> <20061210041600.56306676.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210041600.56306676.akpm@osdl.org>
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

i explained it in the other mail - this is the 'read' side. The 'write' 
side (code actually wanting to /do/ a CPU hotplug state transition) has 
to take /all/ these locks before it can take a CPU down.

so this is still a global CPU hotplug lock, but made scalable.

	Ingo
