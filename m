Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWELH7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWELH7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWELH7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:59:47 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:22412 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751050AbWELH7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:59:47 -0400
Date: Fri, 12 May 2006 03:59:33 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Mark Hounschell <markh@compro.net>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
In-Reply-To: <20060512055025.GA25824@elte.hu>
Message-ID: <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
 <20060512055025.GA25824@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Ingo Molnar wrote:

> ah. This actually uncovered a real bug. We were calling __do_softirq()
> with interrupts enabled (and being preemptible) - which is certainly
> bad.

Hmm, I wonder if this is also affecting Mark's problem.

But since I showed that if hardirqs_disabled and running PREEMPT not
PREEMPT_RT, disable_irq can call schedule.  This is done in
drivers/net/3c59x.c.  It has a watchdog timeout calling disable_irq, which
calls synchronize_irq which might schedule:

void synchronize_irq(unsigned int irq)
{
	struct irq_desc *desc = irq_desc + irq;

	if (irq >= NR_IRQS)
		return;

	if (hardirq_preemption && !(desc->status & IRQ_NODELAY))
		wait_event(desc->wait_for_handler,
			!(desc->status & IRQ_INPROGRESS));
	else
		while (desc->status & IRQ_INPROGRESS)
			cpu_relax();
}

-- Steve

>
> this was hidden before because the smp_processor_id() debugging code
> handles tasks bound to a single CPU as per-cpu-safe.
>
> could you check the (totally untested) patch below and see if that fixes
> things for you? I've also added your affinity change.
>
