Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbUKWEcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbUKWEcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbUKVQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:40:45 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:22719 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262169AbUKVQMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:12:51 -0500
Date: Mon, 22 Nov 2004 17:12:41 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041122092302.GA7210@nietzsche.lynx.com>
Message-Id: <Pine.OSF.4.05.10411221205580.5188-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Bill Huey wrote:

> On Sun, Nov 21, 2004 at 09:29:23PM +0100, Esben Nielsen wrote:
> > [...]
> 
> [private reply cut and pastes to the list as requested]
[I'll try to respond to the whole list]
 
> IMO, their needs to be statistical code in the mutex itself so that it can
> measure the frequency of PI events as well as depth of the inheritance
> chains and all data structure traversals. The problem with writing that
> stuff now is that there isn't proper priority propagation through the entire
> dependency chain in any mutex code that I've publically seen yet. Patching
> this instrumentation in a mutex require a mutex with this built in
> functionality. IMO, PI should be considered a kind of contention overload
> condition and really a kind of fallback device to deal with these kind
> of exceptional circumstances.

Well, I try to make a test which does _not_ require instrumentation:
A white box test. I.e. I test for what you want to know as a real-time
developer: What are the worst case timings. The test isn't complete: It
does need to be extended to have deeper nestings of muteces and tasks
entering on different levels in the hirachy. But with sufficient
randomness in the sampling I believe that we will catch all the real-life
situations and tells us if the mutex implementation gives us 
"deterministic" locking times, which is the ultimate goal.

> 
> Turning this into a "priority inheritance world" is just going to turn
> this project into the FreeBSD SMP project where nobody is working on fixing
> the actual contention problems in the kernel and everybody is dependent on
> overloading an already half-overloaded scheduler with priority calculations.
> This eventually leads the kernel doing little effective work and is the main
> technical reason why DragonFly BSD exists, a vastly superior BSD development
> group (for many reasons).
> 
> http://citeseer.nj.nec.com/yodaiken01dangers.html
> 

>From what I read DragonFly uses a a kind of "weak mutex" called
"serializing tokens" instead of mutexes. They do prevent deadlocks by
automaticly releasing the critical section whenever the holder of the
mutex goes to sleep - forinstance when waiting for another token. This
means you really have to take care - you might have lost your lock
somewhere in the middle of your code. If it is worth anything that ought
to happen only at blocking calls - i.e. you can't be preempted. So are
preemption turned off while you have the token? In that case we are back
to a none-real-time system!  If preemption is on we are back to the
problems of priority inversion!

Another thing they seems to use is SPLs which looks a lot like the
priority ceiling protocol. Priority ceiling is a really good locking
mechanism which doesn't give you problems with priority inversion and is
very cheap run-time. See it as a level grained spin-lock: You give a
priority to your critical section and everything below that priority is
locked out. The problem is, that you have to give every critical section a
priority! But you can't do that in general, different applications need
different priority settings. Thus, priority ceiling is no good on a
general perpose system like Linux.

I haven't looked this deep into DragonFly, but as I see it it is at least
as far from being a real-time system as Linux is. They even proclaim they 
don't run SMP: Tasks are locked to specific CPUs. They might have to
optimizing techniques worth looking at, though.

As regards to the scheduler: PI doesn't add jobs to the scheduler. You
have to lock it out to reset the priority but that is all. The job of
resorting the mutex etc. should be in the context of one of the tasks
accessing the mutex  - preferably with releasing the spinlocks in
between to reduce the task latency. The only thing hammering on the
scheduler is that you get two "extra" task switchs, when you try to take a
congested region taken by a lower priority task: Switch that
in, and then out again when it is done. Priority ceiling would be better
as the high priority task wouldn't even be running (on a UP that is),
but again, but would in practise be very, very hard to configure 
correctly.

> IMO, is a pretty fair assessment some of the failures of using a "late" PI.
> It's not the whole story, but a pretty solid view of how it's been misunderstood,
> overused and then flat out abused. There might be places where, if algorithmically
> bounded somehow, reverting some of the heavy hammered sleeping locks back to
> spinlocks would make the system faster and more controlled. rtc_lock possibly
> could be one of those places and other places that are as heavily as used as
> that.
> 

Now I don't know what you mean by "late" PI. And I do agree spinlocks
perform a lot better than a mutex and that most locks ought to be keeped
as spinlocks to be "effective". Also many interrupt handles shouldn't be
defferered to tasks. But it all depends on you target system! If you
require a task latency of 1 ms, you can keep many more things the
"effective" way with spinlocks and interrupt handlers in interrupt
context, but when you want task lantecies in the order of say 100us you
have to be much more carefull. 
I say: Let it be something you can choose when you are compiling you
kernel. Let there be a special interface in "make (/x/menu)config" for
choosing say between "driver X runs in interrupt and locks with a
spinlock" or "driver X runs in a task and locks with a mutex". For
servers: Use he "effective" way. When you want a real-time system switch
everything to preemptable and only choose the few drivers you "trust"
and/or need in your real-time subsystem to be "effective". On a desktop:
Well, I assume someone (the distributers) can pick a nice setting which
suites most of the users - probably most drivers as running in interrupt
context but more high level stuff defered to task-context.

> That's my take on it.
> 
> bill
> 

By the way: I have thought of a special use (hack?) of a mutex. In the
current implementations every mutex have a spinlock embedded in it. What
we do in the uncongested situation is

lock the spinlock
check for congestion
mark the mutex as taken by this task
unlock the spinlock
do the job
lock the spinlock
mark the mutex as unlocked
unlock the spinlock

Why not allow the following workflow when the job is small (10
instructions or so):

lock the spinlock
check for congestion
do the job
unlock the spinlock

I.e. the mutex works like a spinlock in the uncongested case but the same
mutex can also be used to lock larger areas but when small areas are
locked it is nearly as effective as a spinlock.
The drawbacks: 1) You need high dicipline of the coders not to abuse this
giving us high latencies again. 2) You rely on the current implementation
using an embedded spinlock and might not be able to do general platform
specific optimizations.

Esben



