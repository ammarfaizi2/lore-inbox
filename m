Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUJOOxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUJOOxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJOOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:53:51 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:2987 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S267968AbUJOOu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:50:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Oct 2004 10:50:13 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Wisniewski <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
In-Reply-To: <20041015131138.GA27811@elte.hu>
References: <20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<416F0071.3040304@opersys.com>
	<20041014234603.GA22964@elte.hu>
	<416F14B4.8070002@opersys.com>
	<20041015065905.GA7457@elte.hu>
	<16751.49753.647324.718354@kix.watson.ibm.com>
	<20041015131138.GA27811@elte.hu>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16751.57790.72834.878118@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Robert Wisniewski <bob@watson.ibm.com> wrote:
 > 
 > >  > > cmpxchg (basically: try reserve; if fail retry; else write), with
 > >  > > per-cpu buffers.
 > >  > 
 > >  > this still does not solve all problems related to irq entries: if the
 > >  > IRQ interrups the tracing code after a 'successful reserve' but before
 > >  > the 'else write' point, and the trace is printed/saved from an
 > >  > interrupt, then there will be an incomplete entry in the trace.
 > > 
 > > That is incorrect.  The system behavior needed to generate an
 > > incomplete entry is far more complicated and unlikely than what you
 > > describe.
 > 
 > ah, but i'm talking about actual first-hand experience, not supposition. 
 > It happens quite easily with latency traces (which are saved/printed
 > from IRQ entries) and it can be very annoying to analyze. My first
 > tracers tried to do things without the IRQ flag, so i've seen both
 > methods.

This means that other code you've written has this happen, it doesn't mean
the fundamental model is broken.  Also, if what you claim is true and there
really is this contention, then it both means that 1) there are many many
other higher priority tasks in the system than the one you are trying to
trace, and 2) it's questionable whether you want to use locks.

 > and lets not forget this other issue:
 > 
 > >  > also, there is the problem of timestamp atomicity: if an IRQ interrupts
 > >  > the tracing code and the trace timestamp is taken in the 'else' branch
 > >  > then a time-reversal situation can occur: the entry will have a
 > >  > timestamp _larger_ than the IRQ trace-entries. With cli/sti all tracing
 > >  > entries occur atomically: either fully or not at all.
 > 
 > 
 > >  > > >Also, cli/sti makes it obviously SMP-safe and is pretty
 >                                                       ^^^^^^^^^^
 > >  > > >cheap on all x86 CPUs. (Also, i didnt want to use preempt_disable/enable
 >         ^^^^^^^^^^^^^^^^^^^^^^
 > >  > > >because the tracer interacts with that code quite heavily.)
 > >  > > 
 > >  > > No preempt_disable/enable found in the lockless logging in relayfs.
 > >  > 
 > >  > it would have to do that on PREEMPT_REALTIME. The irq flag solves both
 > >  > the races, the predictability problem and the preemption problem nicely.
 > >  > 
 > >  > 	Ingo
 > > 
 > > If you do not care about performance then you're probably right, this
 > > is fine.  If you are concerned about the time it takes to go through
 > > the sequence of code, then probably not.
 > 
 > see the portion i highlighted above. CPU makers are busy making cli/sti
 > as fast as possible. To make sure i tested it on a typical x86 box:
 > 
 >     # ./cli-latency
 >     CLI+STI latency: 8 cycles
 > 
 > Since the trace entry can be filled in a constant amount of time there's
 > no reason not to make use of that extra silicon that makes fast cli/sti
 > possible! How many trace entries can you generate per second via
 > relayfs, on a typical PC? Have you ever measured this?
 > 
 > in fact on a modern CPU cli/sti is very likely faster than a cmpxchgl
 > for the following reason: the cmpxchgl generates a read dependency on
 > the cacheline which must be fetched in. A single cachemiss can cost
 > _alot_ in comparison, 200 cycles easily. While in the cli/sti case we
 > stream out to a new cacheline in a linear fashion which is nicely
 > optimized by write-allocate cache policies in modern CPUs. No
 > cachemisses on the trace buffer! Just simple streaming out of data.
 > 
 > i challenge you to change your code to use cli/sti and compare it with
 > the cmpxchgl variant doing some heavy tracing on a modern PC. Please
 > just _do_ it and come back with numbers. I have done my own
 > measurements.
 > 
 > 	Ingo

This is an interesting analysis, do you have a paper you can point to, or
can you post the numbers from, and what the setup of the experiment was,
that you ran.  Sounds interesting.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
