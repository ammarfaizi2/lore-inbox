Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275234AbTHMPc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275237AbTHMPc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:32:26 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38668 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275234AbTHMPcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:32:11 -0400
Message-ID: <3F3A5D61.7080207@techsource.com>
Date: Wed, 13 Aug 2003 11:46:41 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net> <3F382B8B.9000301@techsource.com> <20030812001759.GS1715@holomorphy.com> <3F39020C.6040408@techsource.com> <20030812233201.GT1715@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for answering.  Your explanation are very enlightening.  You 
should be quoted on KernelTrap.org.  :)

I have more questions....


William Lee Irwin III wrote:
> On Tue, Aug 12, 2003 at 11:04:44AM -0400, Timothy Miller wrote:
> 
>>Ok... this reminds me that there is an aspect of all of this that I 
>>don't understand.  Please pardon my ignorance.  And furthermore, if 
>>there is some document which answers all of my questions, please direct 
>>me to it so I don't waste your time.
> 
> 
> No trouble at all.
> 
> 
> On Tue, Aug 12, 2003 at 11:04:44AM -0400, Timothy Miller wrote:
> 
>>I understand that the O(1) scheduler uses two queues.  One is the active 
>>queue, and the other is the expired queue.  When a process has exhausted 
>>its timeslice, it gets put into the expired queue (at the end, I 
>>presume).  If not, it gets put into the active queue.
>>Is this the vanilla scheduler?
> 
> 
> The equivalent for the 2.4.x scheduler is the "epoch"; essentially what
> 2.6.x has implemented is incremental timeslice assignment for epoch
> expiry. 

What do you mean by "incremental"?  And by 2.6.x, are you talking about 
vanilla, or interactive?

> The way that goes is that when a timeslice runs out, it's
> recomputed, and the expired queue is used as a placeholder for the
> information about what to run and in what order after the epoch expires
> (i.e. the active queue empties). 

Where are blocked tasks placed?  Are they put somewhere else and readded 
to the active queue when their I/O (or whatever) completes?  How is 
their ordering in the queue determined?  That is, does a task which 
wakes up preempt the running task?  Does it get run "next"?

In Operating Systems design class in college, we were told that when an 
I/O interrupt arrives, the currently active task isn't immediately 
returned to, because the overhead of the context switch and the fact 
that we don't know how near to the end the task is to its timeslice 
makes it not worth it, so we just move on to the next task.

 > When the epoch expires/active queue
> empties, the two queues exchange places. The net effect is that the
> duelling queues end up representing a circular list maintained in some
> special order that can have insertions done into the middle of it for
> tasks designated as "interactive", and that priority preemption's
> effectiveness is unclear.

And by "middle", do you mean at the end of the active queue which is the 
"middle" if you think of the expired queue as being a continuation of 
the active queue?

> Obviously this threatens to degenerate to something RR-like that fails
> to give the desired bonuses to short-running tasks. The way priorities
> are enforced is dynamic timeslice assignment, where longer tasks
> receive shorter timeslices and shorter tasks receive longer timeslices,

How do you vary timeslice?  Can you tell the interrupt hardware to 
"interrupt me after X clock ticks"?  Or do you service the interrupt and 
just do very little in the ISR if you're not going to switch contexts? 
Isn't that a bit of overhead?

> and they're readjusted at various times, which is a somewhat unusual
> design decision (as is the epoch bit). It also deviates from RR where
> interactive tasks can re-enter the active queue at timeslice expiry.
> So in this way, the favoring of short-running tasks is recovered from
> the otherwise atypical design, as the interactive tasks will often be
> re-inserted near the head of the queue as their priorities are high
> and their timeslices are retained while sleeping.
> 
> 
> On Tue, Aug 12, 2003 at 11:04:44AM -0400, Timothy Miller wrote:
> 
>>One thing I don't understand is, for a given queue, how do priorities 
>>affect running of processes?  Two possibilities come to mind:
>>1) All pri 10 processes will be run before any pri 11 processes.
>>2) A pri 10 process will be run SLIGHTLY more often than a pri 11 process.
>>For the former, is the active queue scanned for runnable processes of 
>>the highest priority?  If that's the case, why not have one queue for 
>>each priority level?  Wouldn't that reduce the amount of scanning 
>>through the queue?
> 
> 
> (1) is the case. Things differ a bit from what you might read about
> because of the epoch business.
> 
> The active queue is scanned, but the queue data structure is organized
> so that it's composed of a separate list for each priority, and a
> bitmap is maintained alongside the array of lists for quicker searches
> for the highest nonempty priority (numerically low), and so scanning is
> an O(1) algorithm and touches very few cachelines (if more than one).

Cool.  So, it's not so much a "queue" as it is a sort of an array of 
lists, eh?

> 
> On Tue, Aug 12, 2003 at 11:04:44AM -0400, Timothy Miller wrote:
> 
>>What it comes down to that I want to know is if priorities affect 
>>running of processes linearly or exponentially.
>>How do nice levels affect priorities?  (Vanilla and interactive)
>>How do priorities affect processes in the expired queue?
>>In the vanilla scheduler, can a low enough nice value keep an expired 
>>process off the expired queue?  How is that determined?
>>Does the vanilla scheduler have priorities?  If so, how are they determined?
> 
> 
> Neither linearly nor exponentially; nice levels assign static
> priorities; dynamic priorities (the ones used for scheduling decisions)
> are restricted to the range where |dynamic_prio - static_prio| <= 5.
> Nice values do not keep tasks off the expired queue. Tasks on the
> expired queue are ordered by priority and not examined until the epoch
> expiry.  

Doesn't it cause starvation of expired tasks if interactive tasks keep 
hogging the active queue?  Does it matter?

> The 2.4.x scheduler had static priorities (nice numbers) and
> recomputed what amounted to dynamic priorities (the "goodness" rating)
> on the fly each time a task was examined. 2.4.x also recomputed
> priorities via the infamous for_each_task() loop
> 	for_each_task(p)
> 		p->count = (p->counter >> 1) + NICE_TO_TICKS(p->nice)

What does this do, exactly?

> in the if (unlikely(!c)) case of the repeat_schedule: label where 2.6.x
> merely examines the priority when the task exhausts its timeslice to
> recompute it (and so the expired queue is a useful part of the
> mechanics of the algorithm: it's a placeholder for tasks whose
> timeslices have been recomputed but don't actually deserve to be run).

Is this recomputation of timeslice based on the heuristics in the 
interactive scheduler, or does vanilla also do something like this? 
What does it do differently?

