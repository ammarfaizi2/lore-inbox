Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUKOOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUKOOew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKOOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:34:52 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:20111 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261610AbUKOOeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:34:23 -0500
Date: Mon, 15 Nov 2004 15:34:10 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Real-Time Preemption, another mutex implementation.
In-Reply-To: <20041115023407.GA23686@nietzsche.lynx.com>
Message-Id: <Pine.OSF.4.05.10411151058170.19306-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Nov 2004, Bill Huey wrote:

> On Sat, Nov 13, 2004 at 06:29:09PM +0100, Esben Nielsen wrote:
> > [...]
> 
> I read a bit of the atpch, but I'm uncertain as to how to use it in
> relation to the context of the project. I get the feeling that this is
> suppose to be for mostly UP machines, since that category would only
> the ability to guarantee strict priority enforcement. Is this how this
> should be used ?
> 

No, I made it with SMB in mind. In fact on UP things are _a lot_ easier to
implement. Disable preemption, set the priorities, re-sort the lists,
enable preemption again.
I deliberately tried to make it work on a SMB system. I do not have such a
system to test it on, but I constructed the whole thing using spinlocks
and took care of not writing anything which can deadlock on SMB.

But does it work on SMB? I would say yes - but only "half as good" as on
UP :-)

But hey! I have to make clear what I mean by "it works". What I want to
obtain is the ability to share resources between high priority real-time
tasks and lower priority tasks without destroying the determinism of the
real-time task(s). Ofcourse, I could use a raw spinlock but I might
hold the resource for too long for that. So I have to use a mutex.
But use muteces without a mechanism to prevent priority invertion is
undeterministic: It can make you sleep until even the lowest prioritezed
task is done with it.

On a RTOS with a mutex with working priority inheritance you can think
like this: The execution time (aka number of instructions) of the 
real-time task is increased by the maximum execution time a lower-priority
time can hold the mutex. Ofcourse, if this isn't bounded, the determinism
is destroyed. (This is assuming that tasks switches and mutex internal
code is neglicible.)

(Ofcourse, execution time isn't equal to actual time since your real-time
task can be interrupted or preempted by higher priority tasks but that is
something you always have to take into account. I assume you know the
equation _actual time_ =  execution time + time preemted during _actual
time_, which you have to solve iteratively since actual time occurs on
both sides of the = .)

So the keyword is: Determinism. Assuming the code paths while having the
mutex(ces) in question are deterministic the goal is that taking the mutex
is deterministic. I.e. if you someone wants to use Linux for a hard
real-time system you can say "yes, when you only use these subsystems,
where all paths are bounded, you can count on it." Ofcourse, I do not
think anyone will sit down and calculate the execution times, but I mean
deterministic in the sense that the deployed system will not deviate 
much from the behaviour under test - even under extreme loads.

With my implementation the worst case increase in execution time is
_twice_ the maximum execution time within the mutex - even on a SMB
system.  This is not as good as on a usual RTOS but it is good enough: it
is deterministic.

There is a but: Even if you insert the owner of a mutex at the head of the
run-queue on the other CPU it wont be scheduled until the next
time the scheduler is run on that CPU. I need to somehow interrupt that 
other CPU so it can schedule the owner of that CPU. I haven't look at that
yet (I don't have a SMB system). Until then: You have to count with an 
extra latency of 1/HZ seconds. Another option is to migrate the task to
the current CPU but I have no clue how expensive that is...

> We're working on a priority inheritance mutex here internally that will
> be released when it's done, partially tested, etc... but it doesn't have
> sort wait or contention queues.

Can the rest of us see it, please? It is better to review it and
potentially shoot it down now than later :-)

Without resorting you run into problems when you nested muteces:

A wants to lock mutex1 owned by B who waits for mutex2 owned by C. Task D,
having higher priority than B initially, also waits on mutex2.
If you simply increase the priority of B and C without resorting B's entry
into mutex2's wait list, C will not wake up task B, but D. Suddenly A
sees a undeterministic behaviour as there could be any number of tasks
like D on the list.

When I go home tonight I will start write a test-suite which hopefulle
will catch these kind of things. What I will do is, that I will
rewrite reelfeel to not only meassure the task-latency but also the
latency after taking and releasing a mutex which is shared with one or
more lowpriority tasks. (I probably need to write a small kernel module to
expose the kernel level mutex to user space, though.) Or have other people
written such a test already?

> 
> bill
> 

Esben


