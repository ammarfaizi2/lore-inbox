Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbUK0XGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbUK0XGj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUK0XGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:06:39 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:45702 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261377AbUK0XF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:05:58 -0500
Date: Sun, 28 Nov 2004 00:05:52 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041126210501.GA23381@elte.hu>
Message-Id: <Pine.OSF.4.05.10411271106151.23754-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2004, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > it can produce such a flow on SMP, or if you add in a third non-RT
> > task (task-C). Agreed?
> 
> here's the 4-task flow. I've simplified the operations to make it easier
> to overview: "L1-success means" 'task locked lock1 and got it'. 
> "L1-wait" means it tried to get lock1 but has to wait. "RT-prio" means a
> non-RT task got boosted to RT priority. "old-prio" means priority got
> restored to the original non-RT value. "UL-1" means 'unlocked lock1'.
> 
> 	task-A		task-B		task-C		task-RT
> 	-------------------------------------------------------
> 	L2-success
> 			L1-success
> 					L1-wait
> 					.		L2-wait
> 					.		boost-A
> 	RT-prio				.		.
> 	L1-wait				.		.
> 	boost-B				.		.
> 	.		RT-prio		.		.
> 	.		[ 1 ms ]	.		.
> 	.		UL-1		.		.
> 	.		!RT-prio	.		.
> 	get-L1				.		.
> 	[ 1 ms ]			.		.
> 	UL-1				.		.
> 					get-L1		.
> 	UL-2						.
> 	old-prio					.
> 							get-L2
> 							L1-wait
> 							boost-C
> 					RT-prio		.
> 					[ 1 msec ]	.
> 					UL-1		.
> 					old-prio	.
> 							get-L1
> 							[ success ]
> 
> this is a 3 milliseconds worst-case. Ok?
> 
> 	Ingo
> 
Now I see it! The reason is that task-C is _given_ the lock by task A.
The action of transfering the lock from A to C is done in A's context with
RT-prio. 
My line of thinking was that although task-C is in the wait queue of lock1
it still actively have to go in and _take_ the lock. In that kind of setup
task-RT would get i first on UP. I have a detailed description of such
a design below but first I have to point out that the formula for the
worst case delay is not
 N*(N+1)/2
but
 2^N-1
! Why? Let us say lock1 is replaced by a locking structure which is N
deep in the above examble. The worst case delay on locking on that
structure is f(N). When the extra lockN+1 is added we thus get
 f(N+1) = 2*f(N) +1
because both task B and task C have to lock on the N depth structure
giving 2*f(N) and we have to wait for task A to finish giving the +1.
The solution to that recursive equation when f(0) = 0 is
 f(N) = 2^N -1
I.e.
   N      f(N)
   0        0
   1        1
   2        3
   3        7
   4       15

My tests doesn't show that - but it requires 2^N tasks to reproduce. I am
trying to do that now.

Ok, back to a design making
 f(N) = N
on UP:

When I made the mutex in U9.2-priom I originally made it like
that: In mutex_unlock() owner was set to NULL and the first task awaken.
But a high priority task could at that point get in and snap the mutex in
front of the newly awoken task. That setup would make stuff work better on
UP.

I have come to think about it in terms of state machines. In the current
implementation a mutex can have the following states: unlocked, owned by
task A, owned by task B, etc.. All transitions are possible, i.e.
 unlocked -> task  B -> task A -> unlocked.
The one I started out coding the only allowed transitions were between
unlocked and task X. Task B -> task A was not allowed. Task B simply set
the state to unlocked, woke up task A, which the _most likely_ would get
in and get the mutex:
 unlocked -> task B -> unlocked -> task A -> unlocked
Epsecially on a SMB system task C can however get in and "steal" it before
task A. 

We would fix the discussed problem on UP as well as the problem of the
above implementation by introducing a new state called "released". Allowed
transitions would be
 unlocked->task B
 task B->unlocked
 task B->released
 released->task C
So what does "released" mean? It means that task B is giving the task to
another - but it will _not_ pick the new owner. It will simply wake up the
highest priority task on the wait queue and set the mutex in "released"
state. When another task A, which could be the newly awoken task, then
tries to lock a mutex in "released" state, task A will only take the mutex
if it has higher priority than any on the wait-list. Otherwise task A will
block on the mutex as usual. In more detailed pseudo code:

__mutex_down:
 try_again:
  switch(mutex->state)
    case unlocked: /* the most common case, optimize for this */
        mutex->state = owned by current
        return;
    case released:
        if(current->prio <= first_on_wait_queue->prio)
            mutex->state = owned by current
            return
        /* fall through */
    case locked by A:
        add current to wait-queue
        schedule()
        remove current from wait-queue
        goto try_again;

__mutex_up:
    if(likely(list_empty(mutex->wait_queue)))
        mutex->state = unlocked;
        return
  
    wake_first_waiter(mutex->wait_queue)
    mutex->state = released
    reset priority
    return

Invariant: When the mutex is "released" there is always one task which
is in the wait queue in state "running" comming back to _try_ to take the
mutex.

I think this algorithm would guarantie a latency of depth * 1ms on UP
Let us try to repeate the discussed case on _UP_:

 	task-A		task-B		task-C		task-RT
 	-------------------------------------------------------
 	L2-success
 			L1-success
 					L1-wait
 					.		L2-wait
 					.		boost-A
 	RT-prio				.		.
 	L1-wait				.		.
 	boost-B				.		.
 	.		RT-prio		.		.
 	.		[ 1 ms ]	.		.
 	.		L1 -> released	.		.
 	[woken up]	!RT-prio	.		.
 	get-L1				.		.
 	[ 1 ms ]			.		.
 	L1 -> released			[set running]	.
 	L2 -> released					[set running]
 	old-prio					.
 							get-L2
 							get-l1
							L1->released
							L2->unlocked
							done!
					get-L1		.
            

The reason task RT gets L1 before task C is because C is starved and wont
be able to change the state of the mutex from "released" to "owned by C".
before task RT has done it. On the other hand task C wont notice that
task RT got there first because task RT gets in there does it's stuff
and puts the mutex back in released state while C is sitting quitely on
the run-queue.
On a SMP system task C will not be starved like that and will get L1
immediately.

Esben

