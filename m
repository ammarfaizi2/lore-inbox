Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWDHEqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWDHEqV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 00:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWDHEqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 00:46:21 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:64239 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965017AbWDHEqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 00:46:20 -0400
Subject: Re: RT task scheduling
From: Steven Rostedt <rostedt@goodmis.org>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, Darren Hart <dvhltc@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200604072128.36868.vernux@us.ibm.com>
References: <200604052025.05679.darren@dvhart.com>
	 <20060407233631.GA17574@gnuppy.monkey.org>
	 <1144465282.30689.62.camel@localhost.localdomain>
	 <200604072128.36868.vernux@us.ibm.com>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 00:45:49 -0400
Message-Id: <1144471549.21670.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vernon,


On Fri, 2006-04-07 at 21:28 -0700, Vernon Mauery wrote:

> 1) Deterministic scheduling algorithms (SWSRPS).  Basically, with uniprocessor 
> systems (or smp with a global run queue), it was really easy to say, run the 
> highest priority task in the queue.  But when there are several queues that 
> are independent of each other, it is difficult.  According to SWSRPS, nr_cpus 
> highest priority runnable tasks should _always_ be running (regardless of 
> which queue they are on).  This might mean that there are longer latencies a) 
> to determine the nr_cpus highest priority tasks and b) because of cache 
> issues.

Yep, and task cpu dancing.  Everytime a High prio task preempts a lower
prio RT task, that RT task might be pushed to another CPU.

> 
> 2) Maximum deterministic latency.  A task should be able to say that if it 
> relinquishes the processor for now, MAX_LATENCY nanoseconds (or ticks or 
> whatever you want to measure time in) later, it will be back in time to meet 
> a deadline.

Yep, but the more important thing than latency, is to make your
deadline.  Sometimes people forget that and just concentrate on latency.
But that's another story.


> 
> As I understand it, real time is all about determinism.  But there are several 
> places where we have to focus on determinism to make it all behave as it 
> should.
> 
> Priority A > B > C
> If a lower priority task C gets run just because it is the highest in that 
> CPU's run queue while there is a higher priority task B is sleeping while A 
> runs (on a 2 proc system), this is WRONG.

Argh, terminology is killing us all.  For this to be wrong, B isn't
"sleeping" it's "waiting" while in the run state.  "Sleeping" means that
it's not on the run queue and is just waiting for some event.  Which
would be OK for C to run then.  But if B is on the run queue and in the
the TASK_RUNNING state, it would be wrong for C to be running somewhere
where B could be running.

>   But then again, we need to make 
> sure that we can determine the maximum latency to preempt C to run B and try 
> to minimize that.

And here I don't know of another way besides an IPI to preempt C.  If C
is in userspace, how would you preempt C right a way if B suddenly wakes
up on the runqueue of A?

> 
> Poof!  More smoke in the air.  I hope that clears it up.

It's as clear as my face was in High School ;)

-- Steve


