Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275393AbTHNTkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275398AbTHNTkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:40:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:9479 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275393AbTHNTjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:39:48 -0400
Message-ID: <3F3BE8FB.3080600@techsource.com>
Date: Thu, 14 Aug 2003 15:54:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net> <3F382B8B.9000301@techsource.com> <20030812001759.GS1715@holomorphy.com> <3F39020C.6040408@techsource.com> <20030812233201.GT1715@holomorphy.com> <3F3A5D61.7080207@techsource.com> <20030814060959.GK32488@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again for your explanations.  I hope my questions don't 
eventually get on your nerves.  :)

William Lee Irwin III wrote:

> The "incremental" business meant that tasks have their timeslices
> for the next epoch as they are moved onto the expired queue. In the
> 2.4.x scheduler this was not incremental, so when the epoch expired,
> every task on the system had its timeslice recomputed in one large
> (and time-consuming) loop. The 2.4.x case was also moderately wasteful
> as it recomputed priorities for tasks regardless of whether they were
> runnable, which IMHO is a flaw for which corrections are 2.4.x-mergeable.

Ok, so aside from the waste, the difference is that 2.4 and 2.6 do the 
similar amounts of work to compute timeslices, but 2.4 did it all at 
once, while 2.6 does it one at a time?


> 
> William Lee Irwin III wrote:

> 
> Blocked tasks are taken off the runqueues entirely, and are found by
> device drivers etc. by putting them on a waitqueue so whenever whatever
> they're blocked on happens, they can be found and put on the runqueue.

Ah... so, say a driver has a bug where it forgets to wake up a task.  Is 
this what people are talking about when they complain about tasks being 
stuck in the "D" state?  What does the "D" stand for?


> 
> William Lee Irwin III wrote:
> 
>>> When the epoch expires/active queue
>>>empties, the two queues exchange places. The net effect is that the
>>>duelling queues end up representing a circular list maintained in some
>>>special order that can have insertions done into the middle of it for
>>>tasks designated as "interactive", and that priority preemption's
>>>effectiveness is unclear.
>>
> 
> On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> 
>>And by "middle", do you mean at the end of the active queue which is the 
>>"middle" if you think of the expired queue as being a continuation of 
>>the active queue?
> 
> 
> The "middle" is some arbitrary position in this list that makes it
> neither the last nor the first of the currently runnable tasks to be
> run after the currently running task. The above analogy removes the
> distinctions between active and expired queues, so it doesn't make
> sense to ask about the boundary between the two.


Are you saying that the boundary CAN be conceptually removed, or are you 
saying that by attempting to do that, I am demonstrating a 
misunderstanding of the point in having the two separate queues?

Ok, so beyond the prioritization based on dynamic priority, it seems 
that you have even finer-grained priorities which affect where in the 
queue for a given priority a task is placed once it expires


You talk about priorities being recomputed when a task expires.  Does 
vanilla do that just on timeslice expiration, while intsched does it 
also when a task blocks on I/O?


How many dynamic priority levels are there?


> 
> To rehash, consider changing the representation of the scheduler's
> internals from two arrays to a single doubly-linked list (obviously
> it's not useful to implement this, but it is conceptually useful).
> Movement from the active queue to the expired queue would then be
> modeled by simply list_move_tail(&task->run_list, &run_list).
> Recycling interactive tasks to the active list or inserting newly
> woken tasks at particular priorities would involve hunting for a
> special position in the list and doing list_add() to there. Timeslices
> are entirely orthogonal; they control when list movement is done, but
> not how it's done.

Ok, so timeslice length for a task is yet another level of 
prioritization then?  It seems we have a list of different things that 
affect when and how tasks are run that may be related to "priority" in a 
multidimentional way.

For active tasks:

- timeslice length (how long it's run)
- dynamic priority (when it's run relative to other priorities)
- position in dynamic priority list (when it's run relative to others at 
same priority)

For expired tasks:

- being on the expired queue
- position in the expired queue
- something else I don't know about


This hasn't been entirely clear to me, but is it correct that intsched, 
over vanilla, affects more of these things than vanilla (ie. maybe 
vanilla doesn't put active tasks in the middle of a queue?) and does so 
by paying attention to more about what the task does (ie. vanilla only 
recomputes dynamic priority based on expiration and doesn't put expired 
tasks into the active array?) ?


> 
> In this way, we can see that the priorities merely control how tasks
> are jumbled together into the list because the above alternative
> representation faithfully models the current arrangement. We're
> essentially cycling through this circular list and have to struggle
> to recover preferences for interactive tasks by fiddling with
> timeslices and the like, as otherwise such a circular queue would be
> completely fair, to the detriment of interactive tasks.

Hmmm...  I'm confused.  I was under the impression that the interactive 
scheduler affected both timeslice length AND ordering.  It looks like 
you're saying O(1)int doesn't affect ordering.

> More common arrangements avoid this "tying of the knot" with the queue
> swapping, and because of this, are capable of expressing long-term
> preferences directly in terms of priorities, as opposed to having to
> use timeslices to do so. 

What do you mean by "tying the knot"?

"More common" as in, things other than the way Linux does it?

Are you saying that as a result of the architecture of the O(1) 
scheduler, O(1)int has to fiddle with certain things (perhaps less 
optimal things?) than other architectures do, perhaps because they are 
not O(1)?

My understanding is that O(1)int adjusts dynamic priority based on task 
behavior.  It looks like you're saying that it doesn't.

> Instead, timeslices are used to express the
> "scale" on which scheduling events should happen, and as tasks become
> more cpu-bound, they have longer timeslices, so that two cpu-bound
> tasks of identical priority will RR very slowly and have reduced
> context switch overhead, but are near infinitely preemptible by more
> interactive or short-running tasks.

It makes sense to me to affect both ordering and timeslice length.  What 
heuristics affect each of those parameters?

Can you preempt a task in the middle, or do you have to wait until it's 
expired?

> 
> William Lee Irwin III wrote:
> 
>>>Obviously this threatens to degenerate to something RR-like that fails
>>>to give the desired bonuses to short-running tasks. The way priorities
>>>are enforced is dynamic timeslice assignment, where longer tasks
>>>receive shorter timeslices and shorter tasks receive longer timeslices,
>>
> 
> On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> 
>>How do you vary timeslice?  Can you tell the interrupt hardware to 
>>"interrupt me after X clock ticks"?  Or do you service the interrupt and 
>>just do very little in the ISR if you're not going to switch contexts? 
>>Isn't that a bit of overhead?
> 
> 
> task_timeslice() does a computation based on the dynamic priority to
> assign timeslices. This computation is effectively linear.

I was asking more of a hardware question.  If your timeslice granularity 
is 100Hz, does that mean you get an interrupt from a timer at 100Hz? 
What about tasks which have their timeslice adjusted to be 30ms instead 
of the minimum 10ms?  One of these must be the case:

1) The interrupt occurs at 100Hz, but for two of them, the ISR 
immediately returns to the task.  ISR runtime is minimized to minimize 
overhead of the ignored interrupts.

2) The hardware can be told to only interrupt after N number of timer ticks.


> 
> William Lee Irwin III wrote:
> 
>>>The active queue is scanned, but the queue data structure is organized
>>>so that it's composed of a separate list for each priority, and a
>>>bitmap is maintained alongside the array of lists for quicker searches
>>>for the highest nonempty priority (numerically low), and so scanning is
>>>an O(1) algorithm and touches very few cachelines (if more than one).
>>
> 
> On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> 
>>Cool.  So, it's not so much a "queue" as it is a sort of an array of 
>>lists, eh?
> 
> 
> The data structure itself is a priority queue; the implementation (or
> representation) of it used in the scheduler is an array of lists with
> a bitmap on the side. Other representations such as relaxed heaps or
> complete binary tree (CBT) heaps are possible, though probably not
> particularly useful for such small priority spaces, which are faster
> to exhaustively search with ffz() and the like than to use such
> structures to search.

Well, as I interpret what I read, it's more of a priority queue of 
priority queues, that is if you are able to affect the ordering _within_ 
a given priority level.



>>>The 2.4.x scheduler had static priorities (nice numbers) and
>>>recomputed what amounted to dynamic priorities (the "goodness" rating)
>>>on the fly each time a task was examined. 2.4.x also recomputed
>>>priorities via the infamous for_each_task() loop
>>>	for_each_task(p)
>>>		p->count = (p->counter >> 1) + NICE_TO_TICKS(p->nice)
>>
> 
> On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> 
>>What does this do, exactly?
> 
> 
> It loops through every task on the system assigning timeslices to every
> task according to its nice number.

So, a priority is measured in ticks, and a task has a accumulation of 
unused ticks, and that's divided by two and added to the nice boost and 
that's how many it gets next?

I'm just guessing from that code.  :)


> 
> William Lee Irwin III wrote:
> 
>>>in the if (unlikely(!c)) case of the repeat_schedule: label where 2.6.x
>>>merely examines the priority when the task exhausts its timeslice to
>>>recompute it (and so the expired queue is a useful part of the
>>>mechanics of the algorithm: it's a placeholder for tasks whose
>>>timeslices have been recomputed but don't actually deserve to be run).
>>
> 
> On Wed, Aug 13, 2003 at 11:46:41AM -0400, Timothy Miller wrote:
> 
>>Is this recomputation of timeslice based on the heuristics in the 
>>interactive scheduler, or does vanilla also do something like this? 
>>What does it do differently?
> 
> 
> The timeslices in 2.6.x are controlled indirectly by the dynamic
> priority. But the dynamic priorities in 2.6.x are assigned according to
> interactivity heuristics, in both vanilla and Kolivas' patches.

Indirectly... but what controls them directly?



Thanks.

