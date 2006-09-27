Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965379AbWI0GN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbWI0GN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWI0GN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:13:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48062 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965376AbWI0GNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:13:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
References: <20060920141907.GA30765@elte.hu>
	<20060921065624.GA9841@gnuppy.monkey.org>
	<m1irjaqaqa.fsf@ebiederm.dsl.xmission.com>
	<20060927050856.GA16140@gnuppy.monkey.org>
Date: Wed, 27 Sep 2006 00:02:21 -0600
In-Reply-To: <20060927050856.GA16140@gnuppy.monkey.org> (Bill Huey's message
	of "Tue, 26 Sep 2006 22:08:56 -0700")
Message-ID: <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) <billh@gnuppy.monkey.org> writes:

> On Tue, Sep 26, 2006 at 08:55:41PM -0600, Eric W. Biederman wrote:
>> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
>> > This patch moves put_task_struct() reaping into a thread instead of an
>> > RCU callback function as discussed with Esben publically and Ingo privately:
>> 
>> Stupid question.
>
> It's a great question actually.
>
>> Why does the rt tree make all calls to put_task_struct an rcu action?
>> We only need the rcu callback from kernel/exit.c
>
> Because the conversion of memory allocation routines like kmalloc and kfree aren't
> safely callable within a preempt_disable critical section since they were incompletely
> converted in the -rt. It can run into the sleeping in atomic scenario which can result
> in a deadlock since those routines use blocking locks internally in the implementation
> now as a result of the spinlock_t conversion to blocking locks.

Interesting.  I think the easy solution would just be to assert that put_task_struct
can sleep and to fix any callers that expect differently.  I haven't looked very
closely but I don't recall anything that needs put_task_struct to be atomic.
With a function that complex I certainly would not expect it to never sleep unless
it had a big fat comment.

Well I did find an instance where we call put_task_struct with a
spinlock held.  Inside of lib/rwsem.c:rwsem_down_failed_common(). 

Still that may be the only user that cares.  I suspect with a little
code rearrangement that case is fixable.  It's not like that code is a
fast path or anything.  It should just be a matter of passing the 
task struct outside of the spinlock before calling put_task_struct.

>> Nothing else needs those semantics.
>
> Right, blame it on the incomplete conversion of the kmalloc and friends. GFP_ATOMIC is
> is kind of meaningless in the -rt tree and it might be a good thing to add something
> like GFP_RT_ATOMIC for cases like this to be handled properly and restore that
> particular semantic in a more meaningful way.

But this is a path where we are freeing data, so GFP_ATOMIC should not come
into it.  I just read through the code and there are not allocations
there.
  
>> I agree that put_task_struct is the most common point so this is unlikely
>> to remove your issues with rcu callbacks but it just seems completely backwards
>> to increase the number of rcu callbacks in the rt tree.
>
> I'm not sure what mean here, but if you mean that you don't like the RCU API abuse then
> I agree with you on that. However, Ingo disagrees and I'm not going to argue it with him.
> Although, I'm not going stop you if you do. :)

What I was thinking is that rcu isn't terribly friendly to realtime
activities because it postpones work and can wind up with a lot of
work to do at some random time later which can be bad for latencies. 

So I was very surprised to see an rt patch making more things under
rcu protection.  Especially as I have heard other developers worried
about rt issues discussing removing the rcu functionality.

My gut feel now that I understand the pieces is that this approach has
all of the hallmarks of a hack, both the kmalloc/kfree thing and even
more calling put_task_struct in an atomic context.  If the callers
were fixed put_task_struct could safely sleep so kmalloc/kfree
sleeping would not be a problem.

Eric

