Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTKRGf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 01:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKRGf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 01:35:56 -0500
Received: from web20710.mail.yahoo.com ([216.136.226.183]:33935 "HELO
	web20710.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262355AbTKRGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 01:35:51 -0500
Message-ID: <20031118063551.25057.qmail@web20710.mail.yahoo.com>
Date: Mon, 17 Nov 2003 22:35:51 -0800 (PST)
From: kernwek jalsl <edityacomm@yahoo.com>
Subject: Re: softirqd
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0311170914580.22131@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi;

Sorry in case I was not very clear with my
requirements.   With real time interrupt I meant a
real time task waiting for IO from this interrupt.
Assume that I have a high priority interrupt and a
real time task waiting for it. Well followimg are the
various latencies involved:
L1- interrupt latency
L2- hard and soft IRQ completion
L3 - scheduler latency
L4 - scheduler completion

L1 is pretty acceptable on Linux. For L3 we have the
preemption and low latency patch. And for L4 the O(1)
scheduler solves the problem. So I see L2 as the
bootleneck especially with soft IRQ since the softIRQs
get scheduled in a non real time thread and there is
no wayI can tell the softIRQd that I want highest
priority for the interrupt that will wake up my real
time task. I was seeking a solution to this. 

I know that TimeSYS has as patch for making the
softIRQ a real time thread as well as giving
priorities for both the top and bottom halves. Is
there any place where I can get some performance
figures for this patch?

Regards


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Mon, 17 Nov 2003, kernwek jalsl wrote:
> 
> > Hi All;
> >
> > On my embedded board I see that the preemption
> > patch(Love etal.) is not of much use because of
> the
> > following reaons:
> >
> > 1) calling the scheduler after the hardirq returns
> is
> > not of much use because the actual work of puting
> the
> > task in the run queue is done in the bottom half
> > executed by ksoftirqd
> > 2) ksoftirqd is not a real time thread
> >
> > Will the preemption patch work better if the
> ksoftirqd
> > is made a real time thread?
> >
> > Another related question : has anyone thought of
> > introducing prioirty among tasklets? Right now
> > ksoftirqd treats them in a FIFO manner. Adding
> > priority among the various tasklets and making
> sure
> > that ksoftirqd looks ahead in the queue would
> ensure a
> > real time treatment to a real time interrupt...
> >
> 
> What is the problem that you are attempting to fix?
> Stating that x is not y does not mean anything
> useful.
> 'Real-time' related to an 'interrupt' has no
> meaning.
> 
> An interrupt occurs as soon as hardware demands it.
> The software response to that interrupt, i.e.,
> interrupt-
> latency is dependent upon the ISR setup code in the
> kernel plus the execution time of any
> higher-priority
> interrupts that may be occurring plus the execution
> time
> of any prior code sharing the same interrupt. By the
> time
> your ISR code gets control, the time is bounded by
> some
> worse-case execution times and real-time has no
> meaning.
> 
> Then your ISR code must handle the immediate
> requirements
> of the hardware as fast and efficiently as possible.
> Things
> that can be deferred may be handed over to the
> soft-IRQ
> stuff. If you have things that can't be deferred,
> you must
> not do it in the soft-IRQ (used to be called
> bottom-half)
> handler(s).
> 
> Specifically, the things that can be handled in a
> soft-IRQ
> are hardware configuration changes and such where
> here are
> no deadlines. If you have deadlines, i.e., you must
> get
> the data out of a device now before it gets
> overwritten by
> new data, then it must be done in the top-half
> handler.
> 
> Also, If you ever enable interrupts in your ISR,
> plan that
> the CPU __will__ get taken away. It may be hundreds
> of
> milliseconds before your ISR ever gets the CPU
> again. It
> all depends upon the behavior of other drivers and
> some
> network drivers even loop inside their ISR. Once
> they get
> control, you may not get the CPU until a break in
> network
> traffic!
> 
> In the context of a multi-user time-share operating
> system,
> "real-time" means "fast enough". If your complete
> system can
> keep up with the demands of these external events
> without
> ever losing data, then it is "real-time". However,
> you can't
> use these kinds of systems (fast-enough systems) in
> closed
> servo-loops because the time from an interrupting
> event to
> the completion of the necessary response to that
> event is
> not known. For those kinds of "real-time" systems,
> you need
> a "real-time kernel". Real-time kernels define the
> poles in
> the system transfer-function so that the delay is
> known and
> bounded within strict limits. Such systems are not
> "better".
> In fact, they might be much slower in response to
> the usual
> requirements for interactivity.
> 
> Realtime kernels do this by scheduling on strict
> time-boundaries.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine
> (797.90 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
