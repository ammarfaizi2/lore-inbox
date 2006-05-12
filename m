Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWELILc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWELILc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWELILc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:11:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44262 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751073AbWELILb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:11:31 -0400
Date: Fri, 12 May 2006 10:10:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Mark Hounschell <markh@compro.net>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
Message-ID: <20060512081056.GA25378@elte.hu>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com> <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 12 May 2006, Ingo Molnar wrote:
> 
> > ah. This actually uncovered a real bug. We were calling __do_softirq()
> > with interrupts enabled (and being preemptible) - which is certainly
> > bad.
> 
> Hmm, I wonder if this is also affecting Mark's problem.
> 
> But since I showed that if hardirqs_disabled and running PREEMPT not 
> PREEMPT_RT, disable_irq can call schedule.  This is done in 
> drivers/net/3c59x.c.  It has a watchdog timeout calling disable_irq, 
> which calls synchronize_irq which might schedule:
> 
> void synchronize_irq(unsigned int irq)
> {
> 	struct irq_desc *desc = irq_desc + irq;
> 
> 	if (irq >= NR_IRQS)
> 		return;
> 
> 	if (hardirq_preemption && !(desc->status & IRQ_NODELAY))
> 		wait_event(desc->wait_for_handler,
> 			!(desc->status & IRQ_INPROGRESS));
> 	else
> 		while (desc->status & IRQ_INPROGRESS)
> 			cpu_relax();
> }
> 
> -- Steve
> 
> >
> > this was hidden before because the smp_processor_id() debugging code
> > handles tasks bound to a single CPU as per-cpu-safe.
> >
> > could you check the (totally untested) patch below and see if that fixes
> > things for you? I've also added your affinity change.
> >
