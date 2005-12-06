Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbVLFPX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbVLFPX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbVLFPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:23:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20472 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751703AbVLFPX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:23:57 -0500
In-Reply-To: <Pine.OSF.4.05.10512061404140.23158-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10512061404140.23158-100000@da410.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <508FF3F2-666C-11DA-91E3-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: robust futex heap support patch
Date: Tue, 6 Dec 2005 07:23:55 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 6, 2005, at 6:06 AM, Esben Nielsen wrote:

> On Mon, 5 Dec 2005, david singleton wrote:
>
>>
>> On Dec 5, 2005, at 2:30 PM, Esben Nielsen wrote:
>>
>> I'm currently trying to close a race condition between 
>> futex_wait_robust
>> and futex_wake_robust that Dave Carlson is seeing on his SMP system.
>>
>> The scenario is as follows:
>>
>> Thread A locks an pthread_mutex via the fast path and does not enter
>> the kernel.
>>
>> Thread B tries to lock the lock and sees it is already locked.  Thread
>> B sets the
>> waiters flag in the lock and enters the kernel to lock the lock on
>> behalf of
>> thread A and then block on the mutex waiting for it's release.
>>
>> Thread A unlocks the lock and sees the waiters flag set.  Thread A 
>> gets
>> to the futex_wake_robust before Thread B can get to futex_wait_robust.
>>
>> Thread A sees that it does not own the lock in the kernel and was
>> returning EINVAL.
>>
>> patch-2.6.14-rt21-rf8 was a preliminary patch for Dave Carlson to try
>> and get more information about
>> the race condition.   ( rf8 and rf9 are still returning EAGAIN from
>> thread B trying to
>> do the futex_wait_robust and the library should be retrying with
>> EAGAIN, but it currently isn't).
>>
>
> *nod*
> I just pointed out that you can't make thread A loop the way you do.
>
> What I would do was to do the user space flag checks while having the
> raw spinlock of the rt_mutex. That way you are sure that stuff in the
> kernel is serialized. But I don't know what to do exactly to do in
> there....

Yes, and you are correct.  That patch was an attempt at seeing how far 
the wake code
had to go to let the waiters in on an SMP machine.
>
>
>> When I get the race condition closed I'll post the patch and notify
>> everyone on lkml
>> and the robustmutexes mailing lists.
>
> Where can I sign up to that mailing list? I would like to follow the
> development, although I don't have much time to contibute.

The mail lists you cc'd will do it,  robustmutexes@lists.osdl.ork and 
linux-kernel@vger.kernel.org.

David

>
> Esben
>
>>
>> David
>>
>>
>>
>>> Hi,
>>>  I got a little time to look at your current patch (2.6.14-rt21-rf8).
>>> I noticed a problem in futex_wake_robust(). You have a "goto retry" 
>>> to
>>> solve the following situation:
>>>
>>>   Task A                             Task B
>>>       takes futex in userspace
>>>                                      Tries to take mutex and sets the
>>>                                      waiting bit in user space
>>>       releases futex, notices task B
>>>       calls kernel and enters
>>>       futex_wake_robust()
>>>
>>>     retry:
>>>       if not owner in rt_mutex
>>>          goto retry;
>>>                                      Calls kernel
>>>                                      Makes A owner in rt_mutex
>>>                                      blocks
>>>        Leaves retry-loop and
>>>        completes the futex wake
>>>        operation as normally.
>>>
>>>
>>> However,  if Task A is RT on a UP machine it will go on in the retry
>>> loop
>>> forever. Task B will never get the CPU to complete it's kernel-call.
>>>
>>> You have probably by manipulating the userspace flag from within the
>>> rt_mutex code :-(
>>>
>>> Esben
>>>
>>>
>>> On Fri, 25 Nov 2005, david singleton wrote:
>>>
>>>> There is a new patch, patch-2.6.14-rt15-rf1,  that adds support for
>>>> robust and priority inheriting
>>>> pthread_mutexes on the 'heap'.
>>>>
>>>> The previous patches only supported either file based 
>>>> pthread_mutexes
>>>> or mmapped anonymous memory based pthread_mutexes.  This patch 
>>>> allows
>>>> pthread_mutexes
>>>> to be 'malloc'ed while using the PTHREAD_MUTEX_ROBUST_NP attribute
>>>> or PTHREAD_PRIO_INHERIT attribute.
>>>>
>>>> The patch can be found at:
>>>>
>>>> http://source.mvista.com/~dsingleton
>>>>
>>>> David
>>>>
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-kernel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>
>>
>

