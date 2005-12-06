Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbVLFEvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbVLFEvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbVLFEvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:51:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44019 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751574AbVLFEvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:51:10 -0500
In-Reply-To: <Pine.OSF.4.05.10512052144530.26388-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10512052144530.26388-100000@da410.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EABD795D-6613-11DA-B91D-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: robust futex heap support patch
Date: Mon, 5 Dec 2005 20:51:08 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 5, 2005, at 2:30 PM, Esben Nielsen wrote:

I'm currently trying to close a race condition between futex_wait_robust
and futex_wake_robust that Dave Carlson is seeing on his SMP system.

The scenario is as follows:

Thread A locks an pthread_mutex via the fast path and does not enter 
the kernel.

Thread B tries to lock the lock and sees it is already locked.  Thread 
B sets the
waiters flag in the lock and enters the kernel to lock the lock on 
behalf of
thread A and then block on the mutex waiting for it's release.

Thread A unlocks the lock and sees the waiters flag set.  Thread A gets
to the futex_wake_robust before Thread B can get to futex_wait_robust.

Thread A sees that it does not own the lock in the kernel and was 
returning EINVAL.

patch-2.6.14-rt21-rf8 was a preliminary patch for Dave Carlson to try 
and get more information about
the race condition.   ( rf8 and rf9 are still returning EAGAIN from 
thread B trying to
do the futex_wait_robust and the library should be retrying with 
EAGAIN, but it currently isn't).

When I get the race condition closed I'll post the patch and notify 
everyone on lkml
and the robustmutexes mailing lists.

David



> Hi,
>  I got a little time to look at your current patch (2.6.14-rt21-rf8).
> I noticed a problem in futex_wake_robust(). You have a "goto retry" to
> solve the following situation:
>
>   Task A                             Task B
>       takes futex in userspace
>                                      Tries to take mutex and sets the
>                                      waiting bit in user space
>       releases futex, notices task B
>       calls kernel and enters
>       futex_wake_robust()
>
>     retry:
>       if not owner in rt_mutex
>          goto retry;
>                                      Calls kernel
>                                      Makes A owner in rt_mutex
>                                      blocks
>        Leaves retry-loop and
>        completes the futex wake
>        operation as normally.
>
>
> However,  if Task A is RT on a UP machine it will go on in the retry 
> loop
> forever. Task B will never get the CPU to complete it's kernel-call.
>
> You have probably by manipulating the userspace flag from within the
> rt_mutex code :-(
>
> Esben
>
>
> On Fri, 25 Nov 2005, david singleton wrote:
>
>> There is a new patch, patch-2.6.14-rt15-rf1,  that adds support for
>> robust and priority inheriting
>> pthread_mutexes on the 'heap'.
>>
>> The previous patches only supported either file based pthread_mutexes
>> or mmapped anonymous memory based pthread_mutexes.  This patch allows
>> pthread_mutexes
>> to be 'malloc'ed while using the PTHREAD_MUTEX_ROBUST_NP attribute
>> or PTHREAD_PRIO_INHERIT attribute.
>>
>> The patch can be found at:
>>
>> http://source.mvista.com/~dsingleton
>>
>> David
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>

