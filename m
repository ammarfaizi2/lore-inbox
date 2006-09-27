Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965425AbWI0Hb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965425AbWI0Hb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965427AbWI0Hb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:31:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:183 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965425AbWI0HbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:31:25 -0400
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
	<m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
	<20060927063415.GB16140@gnuppy.monkey.org>
Date: Wed, 27 Sep 2006 01:29:44 -0600
In-Reply-To: <20060927063415.GB16140@gnuppy.monkey.org> (Bill Huey's message
	of "Tue, 26 Sep 2006 23:34:15 -0700")
Message-ID: <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) <billh@gnuppy.monkey.org> writes:

> On Wed, Sep 27, 2006 at 12:02:21AM -0600, Eric W. Biederman wrote:
>> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
>> Interesting.  I think the easy solution would just be to assert that put_task_struct
>> can sleep and to fix any callers that expect differently.  I haven't looked very
>> closely but I don't recall anything that needs put_task_struct to be atomic.
>> With a function that complex I certainly would not expect it to never sleep unless
>> it had a big fat comment.
>
> One of the main claims about the -rt patch is that the kernel is basically
> conversion of the current locking semantics in the kernel. What you mentioned
> above would deviate from that and and clutter non-preemptive kernel maintenance.
> If you're suggesting a more general change to that function, then it wouldn't
> violate that.

Yes I am.  The motivator would be the RT work but I don't see a reason why
the it couldn't be put in the mainline kernel.  If not at least we need
the big fat comment in the mainline kernel that says put_task_struct must
be safe to call with interrupts disabled.

The way the code is structured now it deviates from the mainline kernel in
more than just changing locking behavior.  Which is what brought me into
this conversation in the first place.  So removing that point of discord
would be good.

>> Well I did find an instance where we call put_task_struct with a
>> spinlock held.  Inside of lib/rwsem.c:rwsem_down_failed_common(). 
>> 
>> Still that may be the only user that cares.  I suspect with a little
>> code rearrangement that case is fixable.  It's not like that code is a
>> fast path or anything.  It should just be a matter of passing the 
>> task struct outside of the spinlock before calling put_task_struct.
>
> Yeah, that's what the small patch of mine does outside of doing an RCU
> callback.

If you have fixed rwsem_down_failed_common() like it sounds like you have.
That would be a nice patch to for the mainline kernel.


>> But this is a path where we are freeing data, so GFP_ATOMIC should not come
>> into it.  I just read through the code and there are not allocations
>> there.
>
> Correct, I see it as a possibly bigger problem since memory allocators and
> destructors aren't available readily in preempt_disable critical sections.
> It's not the case in the regular kernel which could be a significant concern.

Yes.  I would say that memory allocators have never been readily available in
sections where we have preemption disabled, but they at least are available
and sometimes they will even give you the memory you asked for.

> There are a couple of issues here.
>
> (1) The RCU callback isn't used in this case to back other RCU read critical
> sections. It's just used as a generic callback mechanism in this case. Some
> consider it a hack.
>
> (2) RCU isn't necessarily bad for -rt since Paul McKenney and folks are
> working on making it preempt friendly. Any talk of removing the use RCU in -rt
> is premature and probably unlikely because of this work. There are many options
> here. RCU very useful for scalability so seeing it go away in -rt would be
> generally a bad thing IMO.

Agreed.  However until the issues are resolved with call_rcu it appears quite
silly to increase the usage of it in the RT tree.  

About the rcu removal discussion I heard it was more the possibility was
suggested because the downside was significant, and normal locks were
more deterministic.  The emphasis was that call_rcu could be a problem and
that something needs to happen to fix that. 

> The use of lock-free techinques is something that could eventually be more
> widely used in -rt since it'll make kernel call paths potentially more
> deterministic without worrying about hitting a contending mutex and that can
> effect determinism. It's not expect to be the case where calls into the kernel
> are going to be deterministic but to extend the basic idea of determinism into
> certain critical kernel paths like a read() to a special device driver, etc...
>
> Route table look up also comes to mind here that benefits from this case if
> there's a need for real time facilities in networking.
>
> Just some ideas here.

Agreed.  The normal rcu path is quite nice.  It is the call_rcu part used
to implement delayed freeing where things get ugly.

>> My gut feel now that I understand the pieces is that this approach has
>> all of the hallmarks of a hack, both the kmalloc/kfree thing and even
>> more calling put_task_struct in an atomic context.  If the callers
>> were fixed put_task_struct could safely sleep so kmalloc/kfree
>> sleeping would not be a problem.
>
> I can't say. The current logic just queues the request into a list and a
> thread wakes to reap that task_struct. It's sufficient and the need to
> convert put_task_struct so that it can block.

Yes the current logic is simple and requires no changes elsewhere.
It is always nice when you can do that.  But in this case it adds unnecessary
overhead, and indeterminism.   From what little I understand of RCU both
of those are bad things.  Thus my gut feeling that the approach is a hack
and should get fixed properly.

Anyway short of submitting a patch I think I have said enough.
Thank you for the explanation.

Eric
