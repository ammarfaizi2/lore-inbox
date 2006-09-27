Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030767AbWI0U3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbWI0U3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbWI0U3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:29:11 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:65434 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1030769AbWI0U3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:29:09 -0400
Date: Wed, 27 Sep 2006 22:28:34 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Bill Huey <billh@gnuppy.monkey.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re:
 2.6.18-rt1]
In-Reply-To: <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0609272203310.9792@frodo.shire>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org>
 <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org>
 <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Eric W. Biederman wrote:

> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
>
>> On Tue, Sep 26, 2006 at 08:55:41PM -0600, Eric W. Biederman wrote:
>>> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
>>>> This patch moves put_task_struct() reaping into a thread instead of an
>>>> RCU callback function as discussed with Esben publically and Ingo privately:
>>>
>>> Stupid question.
>>
>> It's a great question actually.
>>
>>> Why does the rt tree make all calls to put_task_struct an rcu action?
>>> We only need the rcu callback from kernel/exit.c
>>
>> Because the conversion of memory allocation routines like kmalloc and kfree aren't
>> safely callable within a preempt_disable critical section since they were incompletely
>> converted in the -rt. It can run into the sleeping in atomic scenario which can result
>> in a deadlock since those routines use blocking locks internally in the implementation
>> now as a result of the spinlock_t conversion to blocking locks.
>
> Interesting.  I think the easy solution would just be to assert that put_task_struct
> can sleep and to fix any callers that expect differently.  I haven't looked very
> closely but I don't recall anything that needs put_task_struct to be atomic.
> With a function that complex I certainly would not expect it to never sleep unless
> it had a big fat comment.
>
> Well I did find an instance where we call put_task_struct with a
> spinlock held.  Inside of lib/rwsem.c:rwsem_down_failed_common().
>
> Still that may be the only user that cares.  I suspect with a little
> code rearrangement that case is fixable.  It's not like that code is a
> fast path or anything.  It should just be a matter of passing the
> task struct outside of the spinlock before calling put_task_struct.
>
>>> Nothing else needs those semantics.
>>
>> Right, blame it on the incomplete conversion of the kmalloc and friends. GFP_ATOMIC is
>> is kind of meaningless in the -rt tree and it might be a good thing to add something
>> like GFP_RT_ATOMIC for cases like this to be handled properly and restore that
>> particular semantic in a more meaningful way.
>
> But this is a path where we are freeing data, so GFP_ATOMIC should not come
> into it.  I just read through the code and there are not allocations
> there.
>
>>> I agree that put_task_struct is the most common point so this is unlikely
>>> to remove your issues with rcu callbacks but it just seems completely backwards
>>> to increase the number of rcu callbacks in the rt tree.
>>
>> I'm not sure what mean here, but if you mean that you don't like the RCU API abuse then
>> I agree with you on that. However, Ingo disagrees and I'm not going to argue it with him.
>> Although, I'm not going stop you if you do. :)
>
> What I was thinking is that rcu isn't terribly friendly to realtime
> activities because it postpones work and can wind up with a lot of
> work to do at some random time later which can be bad for latencies.
>

Only activities with no deadlines are postponed. And therefore RCU is good 
for the latencies of the application. No high-priority, low-latency task
should bother spend time traversing and freeing a complicated datastructure.
Defer that to some lower priority task.

Esben

> So I was very surprised to see an rt patch making more things under
> rcu protection.  Especially as I have heard other developers worried
> about rt issues discussing removing the rcu functionality.
>
> My gut feel now that I understand the pieces is that this approach has
> all of the hallmarks of a hack, both the kmalloc/kfree thing and even
> more calling put_task_struct in an atomic context.  If the callers
> were fixed put_task_struct could safely sleep so kmalloc/kfree
> sleeping would not be a problem.
>

That put_task_struct uses RCU is a hack to defer the job to a lower 
priority task. I think the right solution is to  defer the job to a lower 
priority task using a cheaper mechanism. put_task_struct() is used from 
high priority tasks in the priority inheritance code and should only do 
the minimal job of defering the real work to another task.

Esben

> Eric
>
