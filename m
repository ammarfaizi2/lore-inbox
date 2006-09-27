Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965384AbWI0Geh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbWI0Geh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965387AbWI0Geh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:34:37 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:62153
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965384AbWI0Geg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:34:36 -0400
Date: Tue, 26 Sep 2006 23:34:15 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927063415.GB16140@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 12:02:21AM -0600, Eric W. Biederman wrote:
> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
> > Because the conversion of memory allocation routines like kmalloc and kfree aren't
> > safely callable within a preempt_disable critical section since they were incompletely
> > converted in the -rt. It can run into the sleeping in atomic scenario which can result
> > in a deadlock since those routines use blocking locks internally in the implementation
> > now as a result of the spinlock_t conversion to blocking locks.
> 
> Interesting.  I think the easy solution would just be to assert that put_task_struct
> can sleep and to fix any callers that expect differently.  I haven't looked very
> closely but I don't recall anything that needs put_task_struct to be atomic.
> With a function that complex I certainly would not expect it to never sleep unless
> it had a big fat comment.

One of the main claims about the -rt patch is that the kernel is basically
conversion of the current locking semantics in the kernel. What you mentioned
above would deviate from that and and clutter non-preemptive kernel maintenance.
If you're suggesting a more general change to that function, then it wouldn't
violate that.

> Well I did find an instance where we call put_task_struct with a
> spinlock held.  Inside of lib/rwsem.c:rwsem_down_failed_common(). 
> 
> Still that may be the only user that cares.  I suspect with a little
> code rearrangement that case is fixable.  It's not like that code is a
> fast path or anything.  It should just be a matter of passing the 
> task struct outside of the spinlock before calling put_task_struct.

Yeah, that's what the small patch of mine does outside of doing an RCU
callback.

> > Right, blame it on the incomplete conversion of the kmalloc and friends. GFP_ATOMIC is
> > is kind of meaningless in the -rt tree and it might be a good thing to add something
> > like GFP_RT_ATOMIC for cases like this to be handled properly and restore that
> > particular semantic in a more meaningful way.
> 
> But this is a path where we are freeing data, so GFP_ATOMIC should not come
> into it.  I just read through the code and there are not allocations
> there.

Correct, I see it as a possibly bigger problem since memory allocators and
destructors aren't available readily in preempt_disable critical sections.
It's not the case in the regular kernel which could be a significant concern.

> > I'm not sure what mean here, but if you mean that you don't like the RCU API abuse then
> > I agree with you on that. However, Ingo disagrees and I'm not going to argue it with him.
> > Although, I'm not going stop you if you do. :)
> 
> What I was thinking is that rcu isn't terribly friendly to realtime
> activities because it postpones work and can wind up with a lot of
> work to do at some random time later which can be bad for latencies. 
> 
> So I was very surprised to see an rt patch making more things under
> rcu protection.  Especially as I have heard other developers worried
> about rt issues discussing removing the rcu functionality.

There are a couple of issues here.

(1) The RCU callback isn't used in this case to back other RCU read critical
sections. It's just used as a generic callback mechanism in this case. Some
consider it a hack.

(2) RCU isn't necessarily bad for -rt since Paul McKenney and folks are
working on making it preempt friendly. Any talk of removing the use RCU in -rt
is premature and probably unlikely because of this work. There are many options
here. RCU very useful for scalability so seeing it go away in -rt would be
generally a bad thing IMO.

The use of lock-free techinques is something that could eventually be more
widely used in -rt since it'll make kernel call paths potentially more
deterministic without worrying about hitting a contending mutex and that can
effect determinism. It's not expect to be the case where calls into the kernel
are going to be deterministic but to extend the basic idea of determinism into
certain critical kernel paths like a read() to a special device driver, etc...

Route table look up also comes to mind here that benefits from this case if
there's a need for real time facilities in networking.

Just some ideas here.

> My gut feel now that I understand the pieces is that this approach has
> all of the hallmarks of a hack, both the kmalloc/kfree thing and even
> more calling put_task_struct in an atomic context.  If the callers
> were fixed put_task_struct could safely sleep so kmalloc/kfree
> sleeping would not be a problem.

I can't say. The current logic just queues the request into a list and a
thread wakes to reap that task_struct. It's sufficient and the need to
convert put_task_struct so that it can block.

bill

