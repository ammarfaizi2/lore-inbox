Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWITTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWITTjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWITTjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:39:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40722 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932315AbWITTjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:39:23 -0400
Date: Wed, 20 Sep 2006 15:39:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060919181626.GF1310@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609201433300.7265-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Paul E. McKenney wrote:

> I did indeed intend to say that there should be at least one global
> ordering consistent with all the serieses of values.  How about the
> following?
> 
> (P1):	If each CPU performs a series of stores to a single shared variable,
> 	then the series of values obtained by the a given CPUs stores
> 	and loads must be consistent with that obtained by each of the
> 	other CPUs.  It may or may not be possible to deduce a single
> 	global order from the full set of such series, however, there
> 	will be at least one global order that is consistent with each
> 	CPU's observed series of values.

How about just

(P1):	If two CPUs both see the same two stores to a single shared 
	variable, then they will see the stores in the same order.


> Good point -- perhaps I should just drop P2c entirely.  I am running it by
> some CPU architects to get their thoughts on it.  But if we don't need it,
> we should not specify it.  Keep Linux portable!!!  ;-)

What P2c really tries to do is specify conditions for which of two stores
to a single location will be visible last.  To do it properly requires
specifying an order for events that take place on more than one CPU,
something you've tried to avoid doing until now.


> No clue.  But I certainly didn't get this example right.  How about
> the following instead?
> 
> 	CPU 0		CPU 1		CPU 2
> 	-----		-----		-----
> 	a = 1		while (l < 1);	z = l;
> 	mb();		b = 1;		mb();
> 	l = 1		mb();		y = b;
> 			l = 2;		x = a;
> 					assert(l != 2 || (x == 1 && y == 1));

You probably meant to write "z" in the assertion rather than "l".

> Here "l" is standing in for the lock variable -- if we acquire the lock,
> we must see all the stores from all preceding critical sections for
> that lock.  A similar example would show that any stores CPU 2 executes
> after its mb() cannot affect any loads that CPUs 0 and 1 executed prior
> to their mb()s.

Right.  To do this properly requires a more fully developed notion of 
ordering than you've been using, and it also requires a notion of control 
dependencies for writes.

> > Not recognizing a control dependency like this would be tantamount to 
> > doing a speculative write.  Any CPU indulging in such fancies isn't likely 
> > to survive very long.
> 
> You might well be correct, though I would want to ask an Alpha expert.
> In any case, there are a number of CPUs that do allow speculative -reads-
> past control dependencies.  My fear is that people will over-generalize
> the "can't do speculative writes" lesson into "cannot speculate
> past a conditional branch".

I think that's important enough to be worth emphasizing, so that people 
won't get it wrong.

>  So I would be OK saying that a memory
> barrier is required in the above example -- but would be interested
> in counter-examples where such code is desperately needed, and the
> overhead of a memory barrier cannot be tolerated.

I don't have any good examples.


> I was trying to get at this with the "see the value stored" verbiage.
> Any thoughts on ways to make this more clear?  Perhaps have the principles
> first, followed by longer explanations and examples.
> 
> And transitivity is painful -- the Alpha "dereferencing does not imply
> ordering" example being a similar case in point!
> 
> > I would much prefer to see an analysis where the primitive notions include 
> > things like "This store becomes visible to that CPU before this load 
> > occurs".  It would bear a closer correspondence to what actually happens 
> > in the hardware.
> 
> I will think on better wording.

My thoughts have been moving in this direction:

	Describe everything in terms of a single global ordering.  It's
	easier to think about, and there shouldn't be a state-space
	explosion because you can always confine your attention to the
	events you care about and ignore the others.

	Reads take place at a particular time (when the return value is
	committed to) but writes become visible at different times to
	different CPUs (such as when they respond to the invalidate
	message).

	A CPU's own writes become visible to itself as soon as they
	execute.  They become visible to other CPUs at the same time or
	later, but not before.  A write might not ever become visible
	to some CPUs.

	A read will always return the value of a store that has already
	become visible to that CPU, but not necessarily the latest such
	store.

So far everything is straightforward.  The difficult part arises because 
multiple stores to the same location can mask and overwrite one another.

	If a read returns the value from a particular store, then later
	reads (on the same CPU and of the same location) will never return 
	values from stores that became visible earlier than that one.  
	(The value has overwritten any earlier stores.)

	A store can be masked from a particular CPU by earlier or later 
	stores to the same location (perhaps made by other CPUs).  A store
	is masked from a CPU iff it never becomes visible to that CPU.

In this setting we can describe the operation of the various sorts of
memory barriers.  Apart from the obvious effect of forcing instructions to
apparently execute in program order, we might have the following:

	If two stores are separated by wmb() then on any CPU where they
	both become visible, they become visible in the order they were
	executed.

	If multiple stores to the same location are visible when a CPU
	executes rmb(), then after the rmb() the latest store has
	overwritten all the earlier ones.

	If a CPU executes read-mb-store, then no other read on any CPU
	can return the value of the store before this read completes.
	(I'd like to say that the read completes before the store
	becomes visible on any CPU; I'm not sure that either is right.  
	What about on the executing CPU?)

But this isn't complete.  It doesn't say enough about when one write may
or may not mask another, or the fact that this occurs in such a way that
all CPUs will agree on the order of the stores to a single location they
see in common.

And certainly there should be something saying that one way or another,
stores do eventually complete.  Given a long enough time with no other
accesses, some single store to a given location should become visible to
every CPU.

Alan

