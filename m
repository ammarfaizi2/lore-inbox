Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJONKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJONKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUJONKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:10:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52638 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266561AbUJONKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:10:16 -0400
Date: Fri, 15 Oct 2004 15:11:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041015131138.GA27811@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <416F0071.3040304@opersys.com> <20041014234603.GA22964@elte.hu> <416F14B4.8070002@opersys.com> <20041015065905.GA7457@elte.hu> <16751.49753.647324.718354@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16751.49753.647324.718354@kix.watson.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Wisniewski <bob@watson.ibm.com> wrote:

>  > > cmpxchg (basically: try reserve; if fail retry; else write), with
>  > > per-cpu buffers.
>  > 
>  > this still does not solve all problems related to irq entries: if the
>  > IRQ interrups the tracing code after a 'successful reserve' but before
>  > the 'else write' point, and the trace is printed/saved from an
>  > interrupt, then there will be an incomplete entry in the trace.
> 
> That is incorrect.  The system behavior needed to generate an
> incomplete entry is far more complicated and unlikely than what you
> describe.

ah, but i'm talking about actual first-hand experience, not supposition. 
It happens quite easily with latency traces (which are saved/printed
from IRQ entries) and it can be very annoying to analyze. My first
tracers tried to do things without the IRQ flag, so i've seen both
methods.

and lets not forget this other issue:

>  > also, there is the problem of timestamp atomicity: if an IRQ interrupts
>  > the tracing code and the trace timestamp is taken in the 'else' branch
>  > then a time-reversal situation can occur: the entry will have a
>  > timestamp _larger_ than the IRQ trace-entries. With cli/sti all tracing
>  > entries occur atomically: either fully or not at all.


>  > > >Also, cli/sti makes it obviously SMP-safe and is pretty
                                                      ^^^^^^^^^^
>  > > >cheap on all x86 CPUs. (Also, i didnt want to use preempt_disable/enable
        ^^^^^^^^^^^^^^^^^^^^^^
>  > > >because the tracer interacts with that code quite heavily.)
>  > > 
>  > > No preempt_disable/enable found in the lockless logging in relayfs.
>  > 
>  > it would have to do that on PREEMPT_REALTIME. The irq flag solves both
>  > the races, the predictability problem and the preemption problem nicely.
>  > 
>  > 	Ingo
> 
> If you do not care about performance then you're probably right, this
> is fine.  If you are concerned about the time it takes to go through
> the sequence of code, then probably not.

see the portion i highlighted above. CPU makers are busy making cli/sti
as fast as possible. To make sure i tested it on a typical x86 box:

    # ./cli-latency
    CLI+STI latency: 8 cycles

Since the trace entry can be filled in a constant amount of time there's
no reason not to make use of that extra silicon that makes fast cli/sti
possible! How many trace entries can you generate per second via
relayfs, on a typical PC? Have you ever measured this?

in fact on a modern CPU cli/sti is very likely faster than a cmpxchgl
for the following reason: the cmpxchgl generates a read dependency on
the cacheline which must be fetched in. A single cachemiss can cost
_alot_ in comparison, 200 cycles easily. While in the cli/sti case we
stream out to a new cacheline in a linear fashion which is nicely
optimized by write-allocate cache policies in modern CPUs. No
cachemisses on the trace buffer! Just simple streaming out of data.

i challenge you to change your code to use cli/sti and compare it with
the cmpxchgl variant doing some heavy tracing on a modern PC. Please
just _do_ it and come back with numbers. I have done my own
measurements.

	Ingo
