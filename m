Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVCVKjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVCVKjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVCVKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:39:36 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:65182 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262614AbVCVKjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:39:24 -0500
Date: Tue, 22 Mar 2005 11:38:48 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050322100446.GA448@nietzsche.lynx.com>
Message-Id: <Pine.OSF.4.05.10503221121580.25802-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Bill Huey wrote:

> On Fri, Mar 18, 2005 at 05:55:44PM +0100, Esben Nielsen wrote:
> > On Fri, 18 Mar 2005, Ingo Molnar wrote:
> > > i really have no intention to allow multiple readers for rt-mutexes. We
> > > got away with that so far, and i'd like to keep it so. Imagine 100
> > > threads all blocked in the same critical section (holding the read-lock)
> > > when a highprio writer thread comes around: instant 100x latency to let
> > > all of them roll forward. The only sane solution is to not allow
> > > excessive concurrency. (That limits SMP scalability, but there's no
> > > other choice i can see.)
> > 
> > Unless a design change is made: One could argue for a semantics where
> > write-locking _isn't_ deterministic and thus do not have to boost all the
> 
> RCU isn't write deterministic like typical RT apps are we can... (below :-))

It is: It takes place right away. But it is not non-deterministic when
_all_ readers actually read it. Also the cleanup is non-deterministic.
So unless you actually _wait_ for the cleanup to happen instead of
defering it you can safely do RCU writes in a RT-task.

> 
> > readers. Readers boost the writers but not the other way around. Readers
> > will be deterministic, but not writers.
> > Such a semantics would probably work for a lot of RT applications
> > happening not to take any write-locks - these will in fact perform better. 
> > But it will give the rest a lot of problems.
> 
> Just came up with an idea after I thought about how much of a bitch it
> would be to get a fast RCU multipule reader semantic (our current shared-
> exclusive lock inserts owners into a sorted priority list per-thread which
> makes it very expensive for a simple RCU case since they are typically very
> small batches of items being altered). Basically the RCU algorithm has *no*
> notion of writer priority and to propagate a PI operation down all reader
> is meaningless, so why not revert back to the original rwlock-semaphore to
> get the multipule reader semantics ?

Remember to boost the writer such RT tasks can enter read regions. I must
also warn against the dangers: A lot of code where a write-lock is taken 
need to marked as non-deterministic, i.e. must not-be called from
RT-tasks (maybe put a WARN_ON(rt_task(current)) in the write-lock
operation?)

> 
> A notion of priority across a quiescience operation is crazy anyways, so
> it would be safe just to use to the old rwlock-semaphore "in place" without
> any changes or priorty handling addtions. The RCU algorithm is only concerned
> with what is basically a coarse data guard and it isn't time or priority
> critical.

I don't find it crazy. I think it is elegant - but also dangerous as it
might take a long time.

> 
> What do you folks think ? That would make Paul's stuff respect multipule
> readers which reduces contention and gets around the problem of possibly
> overloading the current rt lock implementation that we've been bitching
> about. The current RCU development track seem wrong in the first place and
> this seem like it could be a better and more complete solution to the problem.
> 
> If this works, well, you heard it here first. :)
> 
> bill
> 
Esben

