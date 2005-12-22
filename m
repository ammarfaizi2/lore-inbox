Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVLVEhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVLVEhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLVEhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:37:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2297 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965007AbVLVEhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:37:42 -0500
In-Reply-To: <Pine.OSF.4.05.10512210047410.1720-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10512210047410.1720-100000@da410.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AFB6B784-72A4-11DA-8C46-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Wed, 21 Dec 2005 20:37:40 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 20, 2005, at 3:55 PM, Esben Nielsen wrote:

> On Tue, 20 Dec 2005, Steven Rostedt wrote:
>
>>
>> On Tue, 20 Dec 2005, Esben Nielsen wrote:
>>
>>>>
>>>
>>> The same lock taken twice is just a special case of deadlocking. It 
>>> would
>>> be very hard to check for the general case in the futex code without
>>> "fixing" the rt_mutex. Not that the rt_mutex code is broken - it just
>>> doesn't handle deadlocks very well as it wasn't supposed to. But as 
>>> the
>>> futex indirectly exposes the rt_mutex to userspace it becomes a 
>>> problem.
>>>
>>> The only _hack_ I can see is to force all robust futex calls to go 
>>> through
>>> one global lock to prevent the futex deadlocks becomming rt_mutex
>>> deadlocks which again can turn into spin-lock deadlocks.
>>>
>>> I instead argue for altering the premisses for the rt_mutex such
>>> they can handle deadlocks without turning them into spin-lock 
>>> deadlocks
>>> blocking the whole system. Then a futex deadlock will become a 
>>> rt_mutex
>>> deadlock which can be handled.
>>>
>>
>> For the type of deadlock you are talking about is the following:
>>
>> P1 -- grabs futex A (no system call)
>> P2 -- grabs futex B (no system call)
>>
>> P1 -- tries to grab futex B (system call to block and boost P2)
>>       But holds no other kernel rt_mutex!
>> P2 -- tries to grab futex A (system call to block and boost P1)
>>      spinning deadlock here,
>>
>> So, before P2 blocks on P1, can there be a circular check t see if 
>> this is
>> a deadlock.  You don't need to worry about other kernel rt_mutexes, 
>> you
>> only need to worry about blocked process.
>>
>> Is this feasible?
> Ofcourse it is - but it the exact same kind of traversal you do in the
> rt_mutex part to resolve the PI boosting. Thus by making the futex 
> code do
> this by it's own you essentially just move the complexity in there and
> make the total more complex. Notice, that the futex code can't rely on
> user-space flag - it can't be trusted for this (opening a local DOS
> attack). So it has to rely on the rt_mutex structure to do this - and
> therefore also the locks in there to protect against simultanious
> unlocking.


	Correct.  And it's one of the reasons why I chose the rt_mutex
	to back the pthread_mutex.   First we add robustness and
	then with the rt_mutex we get:

	1) priority queuing.   Tasks blocking on pthread_mutexes
	are queued in priority order, and the highest priority task is the 
first to be woken,
	with or without priority inheritance.

	2) priority inheritance, if so desired.

	3) With DEBUG_DEADLOCKS  on we get deadlock detection.

	I was hoping people would use the deadlock detection to
	fix incorrect apps, not file bugs against the kernel.

	The real difficulty lies with POSIX stating that a non-recursive
	mutex will hang if locked twice.  I would prefer to return
	-EWOULDDEADLOCK and not hang the app or the kernel,
	and we could in the case of robust mutexes, but POSIX
	priority inheriting mutexes could not, and be  POSIX compliant.

	It would be simple to detect a simple deadlock,  it's much more
	difficult to detect circular deadlocks, which is why I left it up
	to the rt_mutex's deadlock detect code.

	I understand the position that misbehaved apps should not
	be able to hang the kernel though.

	And this is where I ask two things:

	1) The really smart people helping with a brilliant solution.

	2) Anyone has a nice 4-way or 8-way for debugging purposes?
	
	I think I've pretty much exhausted UP debugging.

David

>
>>
>> -- Steve
>>
>

