Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWAES0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWAES0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAES0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:26:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9711 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751876AbWAES0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:26:02 -0500
In-Reply-To: <Pine.LNX.4.44L0.0601051820000.3110-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0601051820000.3110-100000@lifa02.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B8B0DB3A-7E18-11DA-B7D6-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: <dino@in.ibm.com>, <robustmutexes@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Thu, 5 Jan 2006 10:26:00 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The rt deadlock check is also recursive, but it stops at a depth of 
>> 20,
>> deciding something must be corrupt to have a task blocked on more
>> than 20 locks.
>>
>> We should also set a limit.  We can either just hang an ill-behaved
>> app on the waitqueue or return an error code to the application.
>> Any suggestions on which would be best, hang an illbehaved app
>> or just return it an error?
>>
>
> Per default make the tasks block. You can always make the return code 
> an
> option on each futex, but it has to be off as default. Here is why I 
> think
> so:
>
> Having an return code would require you do the deadlock detection "up
> front" in the down() operation. That takes a lot of CPU cycles 
> .Ofcourse,
> if you return an error code, the application could use the info for 
> something
> constructive, but I am afraid must applications wont do anything 
> constructive
> about it anyway (i.e. such the application continues to run)  - such 
> error
> handling code would be hard to write.

Yes,  I agree.    I'll hang the app on a new waitqueue that will let 
the user
see with 'ps' that they are hung in futex_ill_behaved waitqueue or some 
other name
that makes it easy to see where the app is stopped.

thanks.


David

>
> What is needed in most application is that the stuff simply
> deadlocks with the tasks blocked on the various locks. Then you can go 
> in and
> trace the locks "postmortem".
>
> With the current setup, where you deadlock detection has to be 
> performed
> "up front" because the rt_mutex can make spinlock-deadlocks, the error
> code will be a natural thing. But when rt_mutex is "fixed" or
> replaced with something else, this feature  will force the kernel to 
> run
> deadlock detection "up front" even though it isn't used for anything
> usefull.
>
> Esben
>
>> David
>>
>>>
>>> I am working on a new way to do priority inheritance for nested locks
>>> in
>>> rt_mutex such you do not risc deadlocking the system on raw-spinlocks
>>> when you have a rt_mutex deadlock. But it wont have deadlock 
>>> detection
>>> without
>>> CONFIG_DEBUG_DEADLOCKS. On the other hand it would be possible to 
>>> make
>>> a
>>> deadlock scanner finding deadlocks in the system after they have
>>> happened.
>>> With a suitable /proc interface it could even be done in userspace.
>>>
>>> My patch to the rt_mutex is far from finished. I haven't even 
>>> compiled
>>> a
>>> kernel with it yet. I spend the little time I have between my
>>> family goes to bed and I simply have to go to bed myself writing a
>>> unittest framework for the  rt_mutex and have both the original and 
>>> the
>>> patched rt_mutex parsing all my tests. But I need more tests to 
>>> hammer
>>> out the details about task->state forinstance. If anyone is
>>> interrested I
>>> would be happy to send what I got right now.
>>>
>>> Esben
>>>
>>>>
>>>> 	It's also easier to see if a POSIX compliant app has deadlocked
>>>> itself.
>>>> the 'ps' command will show that the wait channel of a deadlocked
>>>> application is waiting at 'futex_deadlock'.
>>>>
>>>> 	Let me know if it passes all your tests.
>>>>
>>>> David
>>>>
>>>>
>>>>
>>>>
>>>> On Dec 20, 2005, at 7:50 AM, Dinakar Guniguntala wrote:
>>>>
>>>>> On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
>>>>>>
>>>>>> hm, i'm looking at -rf4 - these changes look fishy:
>>>>>>
>>>>>> -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>>>>>> +       if (current != lock_owner(lock)->task)
>>>>>> +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>>>>>>
>>>>>> why is this done?
>>>>>>
>>>>>
>>>>> Ingo, this is to prevent a kernel hang due to application error.
>>>>>
>>>>> Basically when an application does a pthread_mutex_lock twice on a
>>>>> _nonrecursive_ mutex with robust/PI attributes the whole system
>>>>> hangs.
>>>>> Ofcourse the application clearly should not be doing anything like
>>>>> that, but it should not end up hanging the system either
>>>>>
>>>>> 	-Dinakar
>>>>>
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
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>

