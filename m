Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUJOMdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUJOMdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJOMdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:33:47 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:22164 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S267745AbUJOMdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:33:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Oct 2004 08:32:32 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       Thomas Zanussi <trz@us.ibm.com>, Robert Wisniewski <bob@watson.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
In-Reply-To: <20041015065905.GA7457@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<416F0071.3040304@opersys.com>
	<20041014234603.GA22964@elte.hu>
	<416F14B4.8070002@opersys.com>
	<20041015065905.GA7457@elte.hu>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16751.49753.647324.718354@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Karim Yaghmour <karim@opersys.com> wrote:
 > 
 > > >i just added something ad-hoc.
 > >
 > > Yes, I understood as much. I'm suggesting it because a lot of people
 > > who need such ad-hoc functionality could easily be using relayfs.
 > 
 > the latency tracer is pretty specialized for a number of reasons, i'm
 > not sure there's a good match between the two. If relayfs were in the
 > mainline kernel i'd consider reusing parts of it.

:-)  it's nice we all have a sense of humor.


 > 
 > > >I wanted it to be accurate across
 > > >interrupt entries. I have not looked at the relayfs locking but how does
 > > >it solve that?
 > > 
 > > cmpxchg (basically: try reserve; if fail retry; else write), with
 > > per-cpu buffers.
 > 
 > this still does not solve all problems related to irq entries: if the
 > IRQ interrups the tracing code after a 'successful reserve' but before
 > the 'else write' point, and the trace is printed/saved from an
 > interrupt, then there will be an incomplete entry in the trace.

That is incorrect.  The system behavior needed to generate an incomplete
entry is far more complicated and unlikely than what you describe.


 > 
 > also, there is the problem of timestamp atomicity: if an IRQ interrupts
 > the tracing code and the trace timestamp is taken in the 'else' branch
 > then a time-reversal situation can occur: the entry will have a
 > timestamp _larger_ than the IRQ trace-entries. With cli/sti all tracing
 > entries occur atomically: either fully or not at all.
 > 
 > > >Also, cli/sti makes it obviously SMP-safe and is pretty
 > > >cheap on all x86 CPUs. (Also, i didnt want to use preempt_disable/enable
 > > >because the tracer interacts with that code quite heavily.)
 > > 
 > > No preempt_disable/enable found in the lockless logging in relayfs.
 > 
 > it would have to do that on PREEMPT_REALTIME. The irq flag solves both
 > the races, the predictability problem and the preemption problem nicely.
 > 
 > 	Ingo

If you do not care about performance then you're probably right, this is
fine.  If you are concerned about the time it takes to go through the
sequence of code, then probably not.


Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
