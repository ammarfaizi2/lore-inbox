Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWIUBeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWIUBeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIUBeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:34:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:19649 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750950AbWIUBeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:34:07 -0400
Date: Wed, 20 Sep 2006 18:34:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060921013458.GF1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060919181626.GF1310@us.ibm.com> <Pine.LNX.4.44L0.0609201433300.7265-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609201433300.7265-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 03:39:22PM -0400, Alan Stern wrote:
> On Tue, 19 Sep 2006, Paul E. McKenney wrote:
> 
> > I did indeed intend to say that there should be at least one global
> > ordering consistent with all the serieses of values.  How about the
> > following?
> > 
> > (P1):	If each CPU performs a series of stores to a single shared variable,
> > 	then the series of values obtained by the a given CPUs stores
> > 	and loads must be consistent with that obtained by each of the
> > 	other CPUs.  It may or may not be possible to deduce a single
> > 	global order from the full set of such series, however, there
> > 	will be at least one global order that is consistent with each
> > 	CPU's observed series of values.
> 
> How about just
> 
> (P1):	If two CPUs both see the same two stores to a single shared 
> 	variable, then they will see the stores in the same order.
> 
> 
> > Good point -- perhaps I should just drop P2c entirely.  I am running it by
> > some CPU architects to get their thoughts on it.  But if we don't need it,
> > we should not specify it.  Keep Linux portable!!!  ;-)
> 
> What P2c really tries to do is specify conditions for which of two stores
> to a single location will be visible last.  To do it properly requires
> specifying an order for events that take place on more than one CPU,
> something you've tried to avoid doing until now.

That is what I was thinking, but then I realized that P2c is absolutely
required for locking.  For example:

	CPU 0			CPU 1
	-----			-----
	spin_lock(&l);		spin_lock(&l);
	x = 0;			x = 1;
	spin_unlock(&l);	spin_unlock(&l);

Whichever CPU acquires the lock last had better be the one whose value
"sticks" in x.  So, if I see that the other CPU has released its lock,
then any writes that I do need to override whatever writes the other CPU
did within its critical section.

> > No clue.  But I certainly didn't get this example right.  How about
> > the following instead?
> > 
> > 	CPU 0		CPU 1		CPU 2
> > 	-----		-----		-----
> > 	a = 1		while (l < 1);	z = l;
> > 	mb();		b = 1;		mb();
> > 	l = 1		mb();		y = b;
> > 			l = 2;		x = a;
> > 					assert(l != 2 || (x == 1 && y == 1));
> 
> You probably meant to write "z" in the assertion rather than "l".

That I did...  As follows:

	CPU 0		CPU 1		CPU 2
	-----		-----		-----
	a = 1		while (l < 1);	z = l;
	mb();		b = 1;		mb();
	l = 1		mb();		y = b;
			l = 2;		x = a;
					assert(z != 2 || (x == 1 && y == 1));

> > Here "l" is standing in for the lock variable -- if we acquire the lock,
> > we must see all the stores from all preceding critical sections for
> > that lock.  A similar example would show that any stores CPU 2 executes
> > after its mb() cannot affect any loads that CPUs 0 and 1 executed prior
> > to their mb()s.
> 
> Right.  To do this properly requires a more fully developed notion of 
> ordering than you've been using, and it also requires a notion of control 
> dependencies for writes.

I believe that P0, P1, and P2a are sufficient in this case:

0.	If CPU 2 sees l!=2, then by P0, it will see z!=2 at the
	assertion, which must therefore succeed.
1.	On the other hand, if CPU 2 sees l==2, then by P2a, it must
	also see b==1.
2.	By P0, CPU 1 observes that l==1 preceded l==2.
3.	By P1 and #2, neither CPU 0 nor CPU can see l==1 following l==2.
4.	Therefore, if CPU 2 observes l==2, there must have been
	an earlier l==1.
5.	By P2a, any implied observation by CPU 2 of l==1 requires it to
	see a==1.
6.	By #4 and #5, if CPU 2 sees l==2, it must also see a==1.
7.	By P0, if CPU 2 sees b==1, it must see y==1 at the assertion.
8.	By P0, if CPU 2 sees a==1, it must see x==1 at the assertion.
9.	#1, #6, #7, and #8 taken together implies that if CPU 2 sees
	l==2, the assertion succeeds.
10.	#0 and #9 taken together demonstrate that the assertion always
	succeeds.

I would need P2b or P2c if different combinations of reads and writes'
happened in the critical section.

> > > Not recognizing a control dependency like this would be tantamount to 
> > > doing a speculative write.  Any CPU indulging in such fancies isn't likely 
> > > to survive very long.
> > 
> > You might well be correct, though I would want to ask an Alpha expert.
> > In any case, there are a number of CPUs that do allow speculative -reads-
> > past control dependencies.  My fear is that people will over-generalize
> > the "can't do speculative writes" lesson into "cannot speculate
> > past a conditional branch".
> 
> I think that's important enough to be worth emphasizing, so that people 
> won't get it wrong.

Yep.  Just as it is necessary that in head->a, the fetch of "head" might
well follow the fetch of "head->a".  ;-)

> >  So I would be OK saying that a memory
> > barrier is required in the above example -- but would be interested
> > in counter-examples where such code is desperately needed, and the
> > overhead of a memory barrier cannot be tolerated.
> 
> I don't have any good examples.

OK, until someone comes up with an example, I will not add the "writes
cannot speculate" assumption.

> > I was trying to get at this with the "see the value stored" verbiage.
> > Any thoughts on ways to make this more clear?  Perhaps have the principles
> > first, followed by longer explanations and examples.
> > 
> > And transitivity is painful -- the Alpha "dereferencing does not imply
> > ordering" example being a similar case in point!
> > 
> > > I would much prefer to see an analysis where the primitive notions include 
> > > things like "This store becomes visible to that CPU before this load 
> > > occurs".  It would bear a closer correspondence to what actually happens 
> > > in the hardware.
> > 
> > I will think on better wording.
> 
> My thoughts have been moving in this direction:
> 
> 	Describe everything in terms of a single global ordering.  It's
> 	easier to think about, and there shouldn't be a state-space
> 	explosion because you can always confine your attention to the
> 	events you care about and ignore the others.

I may well need to use both viewpoints.  However, my experience has been
that thinking in terms of a single global ordering leads me to miss race
conditions, so I am -extremely- reluctant (as you might have noticed!) to
rely solely on explaining this in terms of a single global ordering.

Modern CPUs resemble beehives more than they resemble assembly lines.  ;-)
(That is, each CPU acts like a beehive, so that the system is a collection
of interacting beehives, each individual bee representing either an
instruction or some data.  For whatever it is worth, the honeycomb would
be the cache and the flowers main memory.  There is no queen bee, at least
not in well-designed parallel code.  OK, so BKL is the queen bee!!!)

> 	Reads take place at a particular time (when the return value is
> 	committed to) but writes become visible at different times to
> 	different CPUs (such as when they respond to the invalidate
> 	message).

Reads are as fuzzy as writes.  The candidate times for a read would be:

0.	When the CPU hands the read request to the cache (BTW, I do agree
	with your earlier suggestion to separate CPU and cache actions,
	though I might well change my mind after running through an example
	or three...).

1.	When all invalidates that arrived at the local cache before the
	read have been processed.  (Assuming the read reaches the local
	cache -- it might instead have been satisfied by the store queue.)

2.	When the read request is transmitted from the cache to the rest
	of the system.  (Assuming it missed in the cache.)

3.	When the last prior conflicting write completes -- with the
	list of possible write-completion times given in a previous
	email.  As near as I can tell, this is your preferred event
	for defining the time at which a read takes place.

4.	When the cacheline containing the variable being read is
	received at the local cache.

5.	When the value being read is delivered to the CPU.

Of course, real CPUs are more complicated, so present more possible events
to tag as being "when the read took place".  ;-)

> 	A CPU's own writes become visible to itself as soon as they
> 	execute.  They become visible to other CPUs at the same time or
> 	later, but not before.  A write might not ever become visible
> 	to some CPUs.

The first sentence is implied by P0.  Not sure the second sentence is
needed -- example?  The third sentence is implied by P1.

> 	A read will always return the value of a store that has already
> 	become visible to that CPU, but not necessarily the latest such
> 	store.

Not sure that this sentence is needed -- example?

> So far everything is straightforward.  The difficult part arises because 
> multiple stores to the same location can mask and overwrite one another.
> 
> 	If a read returns the value from a particular store, then later
> 	reads (on the same CPU and of the same location) will never return 
> 	values from stores that became visible earlier than that one.  
> 	(The value has overwritten any earlier stores.)

Implied separately by each of P0 and P1, depending on your taste.

> 	A store can be masked from a particular CPU by earlier or later 
> 	stores to the same location (perhaps made by other CPUs).  A store
> 	is masked from a CPU iff it never becomes visible to that CPU.

Implied by P1.

> In this setting we can describe the operation of the various sorts of
> memory barriers.  Apart from the obvious effect of forcing instructions to
> apparently execute in program order, we might have the following:
> 
> 	If two stores are separated by wmb() then on any CPU where they
> 	both become visible, they become visible in the order they were
> 	executed.

This is P2a.

> 	If multiple stores to the same location are visible when a CPU
> 	executes rmb(), then after the rmb() the latest store has
> 	overwritten all the earlier ones.

This is P1 and P0, even if there is no rmb().  The rmb() does not affect
loads and stores to a single location.  In fact, no memory barrier
affects loads and stores to a single location, except to the extent
that it changes timing in a given implementation -- but a random number
of trips through a loop containing only nops would change timing as well.

> 	If a CPU executes read-mb-store, then no other read on any CPU
> 	can return the value of the store before this read completes.
> 	(I'd like to say that the read completes before the store
> 	becomes visible on any CPU; I'm not sure that either is right.  
> 	What about on the executing CPU?)

This is P2b.  I think.

> But this isn't complete.  It doesn't say enough about when one write may
> or may not mask another, or the fact that this occurs in such a way that
> all CPUs will agree on the order of the stores to a single location they
> see in common.

This would be covered by P1.

> And certainly there should be something saying that one way or another,
> stores do eventually complete.  Given a long enough time with no other
> accesses, some single store to a given location should become visible to
> every CPU.

This would certainly be needed in order to analyze liveness, as opposed
to "simply" analyzing SMP correctness (or lack thereof, as the case may be).
SMP correctness "only" requires a full state-space search -- preferably
-after- collapsing the state space.  ;-)

My thought is to take a more portability-paranoid approach.  Start with
locking, deriving the memory-barrier properties required for locking
to work correctly.  Rely only on those properties, since a number of
CPUs seem to have been designed (to say nothing of validated!!!) only
for locking.  After all, if a CPU doesn't support locking, it cannot
support an SMP build of Linux.

							Thanx, Paul
