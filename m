Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVCVI4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVCVI4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVCVI4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:56:14 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:41099 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262574AbVCVI4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:56:08 -0500
Date: Tue, 22 Mar 2005 09:55:26 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, dipankar@in.ibm.com, shemminger@osdl.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050322055327.GB1295@us.ibm.com>
Message-Id: <Pine.OSF.4.05.10503220929500.5287-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Mar 2005, Paul E. McKenney wrote:

> On Mon, Mar 21, 2005 at 12:23:22AM +0100, Esben Nielsen wrote:
> > > [...] 
> > Well, I was actually thinking of an API like
> >  preempt_by_nonrt_disable()
> >  preempt_by_nonrt_enable()
> > working like the old preempt_disable()/preempt_enable() but still
> > allowing RT tasks (as well as priority inheriting non-RT tasks) to be
> > scheduled. That would kind of help "split" the kernel into two halfs: the
> > RT part and the non-RT part. The non-RT part would in many ways work as it
> > has always done.
> 
> Does sound in some ways similar to the migration approach -- there, the
> RT/non-RT split is made across CPUs.  But if RT is allowed to preempt,
> then you still have to deal with preemption for locking correctness, right?
> 
Yes. It is not a locking mechanism, it should just prevent scheduling of
"normal" userspace tasks.

> > [..] 
> > Well, in my patch I do not leave preemption off - only while doing the
> > simple ++/--. In effect, I let rcu_qsctr_inc know that some RCU reader
> > might be active, i.e. preempted, on the current CPU such that this isn't
> > and quiescent point after all.
> > (To others: Paul nicely unfolded my attachment below - I left it in
> > the mail such you can read it.)
> > The problem with this approach is ofcourse that user space programs might
> > preempt an RCU reader for a very long time such that RCU batches are never
> > really run. The boosting of non-RT tasks mentioned above would help a
> > lot.
> > A plus(?) in it: You can actually sleep while having the rcu_read_lock !!
> 
> This is in some ways similar to the K42 approach to RCU (which they call
> "generations").  Dipankar put together a similar patch for Linux, but
> the problem was that grace periods could be deferred for an extremely
> long time.  Which I suspect is what you were calling out as causing
> RCU batches never to run.
> 

That is where the preempt_by_nonrt_disable/enable() is supposed to help:
Then it can't take longer than the normal kernel in the situation where
there is no RT tasks running. RT tasks will prolong the grace periods if
they go into RCU regions, but they are supposed to be relatively small -
and deterministic!

> > > The counter approach might work, and is also what the implementation #5
> > > does -- check out rcu_read_lock() in Ingo's most recent patch.
> > > 
> > 
> > Do you refer to your original mail with implementing it in 5 steps?
> > In #5 in that one (-V0.7.41-00, right?) you use a lock and as you say that
> > forces syncronization between the CPUs - bad for scaling. It does make the
> > RCU batches somewhat deterministic, as the RCU task can boost the readers
> > to the rcu-task's priority.
> > The problem about this approach is that everybody calling into RCU code
> > have a worst case behaviour of the systemwide worst case RCU reader 
> > section - which can be pretty large (in principle infinite if somebody.)
> > So if somebody uses a call to a function in the code containing a RCU read
> > area the worst case behavious would be the same as teh worst case latency
> > in the simple world where preempt_disable()/preempt_enable() was used.
> 
> I missed something here -- readers would see the worst-case -writer-
> latency rather than the worst-case -reader- latency, right?  Or are you
> concerned about the case where some reader blocks the write-side
> acquisitions in _synchronize_kernel(), but not before the writer has
> grabbed a lock, blocking any readers on the corresponding CPU?
> 

I am conserned that readers block each other, too. You do need an rw-mutex
allowing an unlimited number of readers for doing this. With the current
rw-mutex the readers block each other. I.e. the worst case latency is the
worst case reader latency - globally!
On the other hand with a rw-lock being unlimited - and thus do not keep
track of it readers - the readers can't be boosted by the writer. Then you
are back to square 1: The grace period can take a very long time.

> Yes, but this is true of every other lock in the system as well, not?

Other locks are not globaly used but only used for a specific subsystem.
On a real-time system you are supposed to know which subsystems you can
call into and still have a low enough latency as each subsystem has it's
own bound. But with a global RCU locking mechanism all RCU using code is
to be regarded as _one_ such subsystem.

> In a separate conversation a few weeks ago, Steve Hemminger suggested
> placing checks in long RCU read-side critical sections -- this could
> be used to keep the worst-case reader latency within the desired bounds.
> Not pretty, but, then again, bounding lock latency will require a fair
> number of similar changes, I suspect.
> 
> 						Thanx, Paul
> 

Esben

