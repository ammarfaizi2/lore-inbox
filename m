Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272167AbTHNGJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272220AbTHNGJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:09:12 -0400
Received: from holomorphy.com ([66.224.33.161]:38840 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272167AbTHNGJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:09:00 -0400
Date: Wed, 13 Aug 2003 23:09:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030814060959.GK32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>, rob@landley.net,
	Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
	linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net> <3F382B8B.9000301@techsource.com> <20030812001759.GS1715@holomorphy.com> <3F39020C.6040408@techsource.com> <20030812233201.GT1715@holomorphy.com> <3F3A5D61.7080207@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A5D61.7080207@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> The equivalent for the 2.4.x scheduler is the "epoch"; essentially what
>> 2.6.x has implemented is incremental timeslice assignment for epoch
>> expiry. 

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> What do you mean by "incremental"?  And by 2.6.x, are you talking about 
> vanilla, or interactive?

I had no idea you had in mind Con Kolivas' changes vs. 2.6.x as
"vanilla" vs. otherwise; I thought you meant 2.4.x vs. 2.6.x. In
general, Con's patches just change how dynamic priorities are computed.

The "incremental" business meant that tasks have their timeslices
for the next epoch as they are moved onto the expired queue. In the
2.4.x scheduler this was not incremental, so when the epoch expired,
every task on the system had its timeslice recomputed in one large
(and time-consuming) loop. The 2.4.x case was also moderately wasteful
as it recomputed priorities for tasks regardless of whether they were
runnable, which IMHO is a flaw for which corrections are 2.4.x-mergeable.


William Lee Irwin III wrote:
>> The way that goes is that when a timeslice runs out, it's
>> recomputed, and the expired queue is used as a placeholder for the
>> information about what to run and in what order after the epoch expires
>> (i.e. the active queue empties). 

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> Where are blocked tasks placed?  Are they put somewhere else and readded 
> to the active queue when their I/O (or whatever) completes?  How is 
> their ordering in the queue determined?  That is, does a task which 
> wakes up preempt the running task?  Does it get run "next"?
> In Operating Systems design class in college, we were told that when an 
> I/O interrupt arrives, the currently active task isn't immediately 
> returned to, because the overhead of the context switch and the fact 
> that we don't know how near to the end the task is to its timeslice 
> makes it not worth it, so we just move on to the next task.

Blocked tasks are taken off the runqueues entirely, and are found by
device drivers etc. by putting them on a waitqueue so whenever whatever
they're blocked on happens, they can be found and put on the runqueue.


William Lee Irwin III wrote:
>>  When the epoch expires/active queue
>> empties, the two queues exchange places. The net effect is that the
>> duelling queues end up representing a circular list maintained in some
>> special order that can have insertions done into the middle of it for
>> tasks designated as "interactive", and that priority preemption's
>> effectiveness is unclear.

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> And by "middle", do you mean at the end of the active queue which is the 
> "middle" if you think of the expired queue as being a continuation of 
> the active queue?

The "middle" is some arbitrary position in this list that makes it
neither the last nor the first of the currently runnable tasks to be
run after the currently running task. The above analogy removes the
distinctions between active and expired queues, so it doesn't make
sense to ask about the boundary between the two.

To rehash, consider changing the representation of the scheduler's
internals from two arrays to a single doubly-linked list (obviously
it's not useful to implement this, but it is conceptually useful).
Movement from the active queue to the expired queue would then be
modeled by simply list_move_tail(&task->run_list, &run_list).
Recycling interactive tasks to the active list or inserting newly
woken tasks at particular priorities would involve hunting for a
special position in the list and doing list_add() to there. Timeslices
are entirely orthogonal; they control when list movement is done, but
not how it's done.

In this way, we can see that the priorities merely control how tasks
are jumbled together into the list because the above alternative
representation faithfully models the current arrangement. We're
essentially cycling through this circular list and have to struggle
to recover preferences for interactive tasks by fiddling with
timeslices and the like, as otherwise such a circular queue would be
completely fair, to the detriment of interactive tasks.

More common arrangements avoid this "tying of the knot" with the queue
swapping, and because of this, are capable of expressing long-term
preferences directly in terms of priorities, as opposed to having to
use timeslices to do so. Instead, timeslices are used to express the
"scale" on which scheduling events should happen, and as tasks become
more cpu-bound, they have longer timeslices, so that two cpu-bound
tasks of identical priority will RR very slowly and have reduced
context switch overhead, but are near infinitely preemptible by more
interactive or short-running tasks.


William Lee Irwin III wrote:
>> Obviously this threatens to degenerate to something RR-like that fails
>> to give the desired bonuses to short-running tasks. The way priorities
>> are enforced is dynamic timeslice assignment, where longer tasks
>> receive shorter timeslices and shorter tasks receive longer timeslices,

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> How do you vary timeslice?  Can you tell the interrupt hardware to 
> "interrupt me after X clock ticks"?  Or do you service the interrupt and 
> just do very little in the ISR if you're not going to switch contexts? 
> Isn't that a bit of overhead?

task_timeslice() does a computation based on the dynamic priority to
assign timeslices. This computation is effectively linear.


William Lee Irwin III wrote:
>> The active queue is scanned, but the queue data structure is organized
>> so that it's composed of a separate list for each priority, and a
>> bitmap is maintained alongside the array of lists for quicker searches
>> for the highest nonempty priority (numerically low), and so scanning is
>> an O(1) algorithm and touches very few cachelines (if more than one).

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> Cool.  So, it's not so much a "queue" as it is a sort of an array of 
> lists, eh?

The data structure itself is a priority queue; the implementation (or
representation) of it used in the scheduler is an array of lists with
a bitmap on the side. Other representations such as relaxed heaps or
complete binary tree (CBT) heaps are possible, though probably not
particularly useful for such small priority spaces, which are faster
to exhaustively search with ffz() and the like than to use such
structures to search.


William Lee Irwin III wrote:
>> Neither linearly nor exponentially; nice levels assign static
>> priorities; dynamic priorities (the ones used for scheduling decisions)
>> are restricted to the range where |dynamic_prio - static_prio| <= 5.
>> Nice values do not keep tasks off the expired queue. Tasks on the
>> expired queue are ordered by priority and not examined until the epoch
>> expiry.  

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> Doesn't it cause starvation of expired tasks if interactive tasks keep 
> hogging the active queue?  Does it matter?

It may very well cause starvation of expired tasks. It's unclear whether
it matters. Instrumentation for these kinds of things is lacking, along
with any results indicating what on earth is going on.


William Lee Irwin III wrote:
>> The 2.4.x scheduler had static priorities (nice numbers) and
>> recomputed what amounted to dynamic priorities (the "goodness" rating)
>> on the fly each time a task was examined. 2.4.x also recomputed
>> priorities via the infamous for_each_task() loop
>> 	for_each_task(p)
>> 		p->count = (p->counter >> 1) + NICE_TO_TICKS(p->nice)

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> What does this do, exactly?

It loops through every task on the system assigning timeslices to every
task according to its nice number.


William Lee Irwin III wrote:
>> in the if (unlikely(!c)) case of the repeat_schedule: label where 2.6.x
>> merely examines the priority when the task exhausts its timeslice to
>> recompute it (and so the expired queue is a useful part of the
>> mechanics of the algorithm: it's a placeholder for tasks whose
>> timeslices have been recomputed but don't actually deserve to be run).

On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> Is this recomputation of timeslice based on the heuristics in the 
> interactive scheduler, or does vanilla also do something like this? 
> What does it do differently?

The timeslices in 2.6.x are controlled indirectly by the dynamic
priority. But the dynamic priorities in 2.6.x are assigned according to
interactivity heuristics, in both vanilla and Kolivas' patches.


-- wli
