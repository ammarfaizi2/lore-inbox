Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWAWAiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWAWAiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAWAiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:38:06 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:52215 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932406AbWAWAiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:38:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.0601230047290.31387-201000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0601230047290.31387-201000@lifa01.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8306430E-8BA8-11DA-96D0-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Bill Huey <billh@gnuppy.monkey.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
From: david singleton <dsingleton@mvista.com>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Date: Sun, 22 Jan 2006 16:38:02 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 22, 2006, at 4:20 PM, Esben Nielsen wrote:

> Ok this time around I have a patch against 2.6.15-rt12.
>
> Updated since the last time:
> 1) Fixed a bug wrt. BKL. The problem involved the grab-lock mechanism.
> 2) Updated the tester to detect the bug. See
> TestRTMutex/reaquire_bkl_while_waiting.tst :-)
>
> I still need testing on SMP and with robust futexes.
> I test with the old priority inheritance test of mine. Do you guys test
> with anything newer?

I'll try your patch with rt12 and robustness.  I have an SMP test I'm
working on.

David

>
> When looking at BKL i found that the buisness about reacquiring BKL is
> really bad for real-time. The problem is that you without knowing it
> suddenly can block on the BKL!
>
> Here is the problem:
>
> Task B (non-RT) takes BKL. It then takes mutex 1. Then B
> tries to lock mutex 2, which is owned by task C. B goes blocks and 
> releases the
> BKL. Our RT task A comes along and tries to get 1. It boosts task B
> which boosts task C which releases mutex 2. Now B can continue? No, it 
> has
> to reaquire BKL! The netto effect is that our RT task A waits for BKL 
> to
> be released without ever calling into a module using BKL. But just 
> because
> somebody in some non-RT code called into a module otherwise considered
> safe for RT usage with BKL held, A must wait on BKL!
>
> Esben
>
> On Wed, 18 Jan 2006, Esben Nielsen wrote:
>
>> Hi,
>>  I have updated it:
>>
>> 1) Now ALL_TASKS_PI is 0 again. Only RT tasks will be added to
>> task->pi_waiters. Therefore we avoid taking the owner->pi_lock when 
>> the
>> waiter isn't RT.
>> 2) Merged into 2.6.15-rt6.
>> 3) Updated the tester to test the hand over of BKL, which was 
>> mentioned
>> as a potential issue by Bill Huey. Also added/adjusted the tests for 
>> the
>> ALL_TASKS_PI==0 setup.
>> (I really like unittesting: If someone points out an issue or finds a 
>> bug,
>> make a test first demonstrating the problem. Then fixing the code is 
>> a lot
>> easier - especially in this case where I run rt.c in userspace where 
>> I can
>> easily use gdb.)
>>
>> Esben
>>
>> On Wed, 11 Jan 2006, Esben Nielsen wrote:
>>
>>> I have done 2 things which might be of interrest:
>>>
>>> I) A rt_mutex unittest suite. It might also be usefull against the 
>>> generic
>>> mutexes.
>>>
>>> II) I changed the priority inheritance mechanism in rt.c,
>>> optaining the following goals:
>>>
>>> 1) rt_mutex deadlocks doesn't become raw_spinlock deadlocks. And more
>>> importantly: futex_deadlocks doesn't become raw_spinlock deadlocks.
>>> 2) Time-Predictable code. No matter how deep you nest your locks
>>> (kernel or futex) the time spend in irqs or preemption off should be
>>> limited.
>>> 3) Simpler code. rt.c was kind of messy. Maybe it still is....:-)
>>>
>>> I have lost:
>>> 1) Some speed in the slow slow path. I _might_ have gained some in 
>>> the
>>> normal slow path, though, without meassuring it.
>>>
>>>
>>> Idea:
>>>
>>> When a task blocks on a lock it adds itself to the wait list and 
>>> calls
>>> schedule(). When it is unblocked it has the lock. Or rather due to
>>> grab-locking it has to check again. Therefore the schedule() call is
>>> wrapped in a loop.
>>>
>>> Now when a task is PI boosted, it is at the same time checked if it 
>>> is
>>> blocked on a rt_mutex. If it is, it is unblocked ( 
>>> wake_up_process_mutex()
>>> ). It will now go around in the above loop mentioned above. Within 
>>> this loop
>>> it will now boost the owner of the lock it is blocked on, maybe 
>>> unblocking the
>>> owner, which in turn can boost and unblock the next in the lock 
>>> chain...
>>> At all points there is at least one task boosted to the highest 
>>> priority
>>> required unblocked and working on boosting the next in the lock 
>>> chain and
>>> there is therefore no priority inversion.
>>>
>>> The boosting of a long list of blocked tasks will clearly take 
>>> longer than
>>> the previous version as there will be task switches. But remember, 
>>> it is
>>> in the slow slow path! And it only occurs when PI boosting is 
>>> happening on
>>> _nested_ locks.
>>>
>>> What is gained is that the amount of time where irq and preemption 
>>> is off
>>> is limited: One task does it's work with preemption disabled, wakes 
>>> up the
>>> next and enable preemption and schedules. The amount of time spend 
>>> with
>>> preemption disabled is has a clear upper limit, untouched by how
>>> complicated and deep the lock structure is.
>>>
>>> So how many locks do we have to worry about? Two.
>>> One for locking the lock. One for locking various PI related data on 
>>> the
>>> task structure, as the pi_waiters list, blocked_on, pending_owner - 
>>> and
>>> also prio.
>>> Therefore only lock->wait_lock and sometask->pi_lock will be locked 
>>> at the
>>> same time. And in that order. There is therefore no spinlock 
>>> deadlocks.
>>> And the code is simpler.
>>>
>>> Because of the simplere code I was able to implement an optimization:
>>> Only the first waiter on each lock is member of the 
>>> owner->pi_waiters.
>>> Therefore it is not needed to do any list traversels on neither
>>> owner->pi_waiters, not lock->wait_list. Every operation requires 
>>> touching
>>> only removing and/or adding one element to these lists.
>>>
>>> As for robust futexes: They ought to work out of the box now, 
>>> blocking in
>>> deadlock situations. I have added an entry to /proc/<pid>/status
>>> "BlckOn: <pid>". This can be used to do "post mortem" deadlock 
>>> detection
>>> from userspace.
>>>
>>> What am I missing:
>>> Testing on SMP. I have no SMP machine. The unittest can mimic the SMP
>>> somewhat
>>> but no unittest can catch _all_ errors.
>>>
>>> Testing with futexes.
>>>
>>> ALL_PI_TASKS are always switched on now. This is for making the code
>>> simpler.
>>>
>>> My machine fails to run with CONFIG_DEBUG_DEADLOCKS and 
>>> CONFIG_DEBUG_PREEMPT
>>> on at the same time. I need a serial cabel and on consol over serial 
>>> to
>>> debug it. My screen is too small to see enough there.
>>>
>>> Figure out more tests to run in my unittester.
>>>
>>> So why aren't I doing those things before sending the patch? 1) Well 
>>> my
>>> girlfriend comes back tomorrow with our child. I know I will have no 
>>> time to code anything substential
>>> then. 2) I want to make sure Ingo sees this approach before he starts
>>> merging preempt_rt and rt_mutex with his now mainstream mutex.
>>>
>>> Esben
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>
>>
> <pi_lock.patch-rt12><TestRTMutex.tgz>

