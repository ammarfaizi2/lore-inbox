Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWIUU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWIUU7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWIUU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:59:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46606 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751554AbWIUU7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:59:01 -0400
Date: Thu, 21 Sep 2006 16:59:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060921013458.GF1292@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609211413120.9279-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are really discussing two different things here.  On one hand you're 
trying to present a high-level description of the requirements memory 
barriers must fulfill in order to support usable synchronization.  On the 
other, I'm trying to present a lower-level description of how memory 
barriers operate, from which one could prove that your higher-level 
requirements are satisfied as a sort of emergent behavior.


On Wed, 20 Sep 2006, Paul E. McKenney wrote:

> That is what I was thinking, but then I realized that P2c is absolutely
> required for locking.  For example:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	spin_lock(&l);		spin_lock(&l);
> 	x = 0;			x = 1;
> 	spin_unlock(&l);	spin_unlock(&l);
> 
> Whichever CPU acquires the lock last had better be the one whose value
> "sticks" in x.  So, if I see that the other CPU has released its lock,
> then any writes that I do need to override whatever writes the other CPU
> did within its critical section.

Yes.

On the whole, the best way to present your approach might be like this.  
P0 and P1 are simple basic requirements for any SMP system.  They have
nothing to do with memory barriers especially.  So let's concentrate on
P2.

To express the various P2 requirements, let's say that a read "comes
after" a write if it sees the value of the write, and a second write
"comes after" a first write if it overwrites the first value.  Let A and B
be addresses in memory, let A(n) and B(n) stand for any sort of accesses
to A and B by CPU n, and let M stand for any appropriate memory barrier.  
Then whenever we have

	A(0)	B(1)
	M	M
	B(0)	A(1)

the requirement is: B(1) comes after B(0) implies A(1) comes after A(0) --
or at least A(0) doesn't come after A(1) -- whenever this makes sense in
terms of the actual access and barrier operations.  This is a bit stronger
than your P2a-P2c all together.

For locking, let L stand for a lock operation and U for an unlock 
operation.  Then whenever we have

	L		L
	{A(0),B(0)}	{A(1),B(1)}
	// For each n, A(n) and B(n) can occur in arbitrary order
	U		U

the requirement is that A(1) comes after A(0) implies B(1) comes after
B(0) -- or at least B(0) doesn't come after B(1) -- again, whenever that
makes sense.  If L and U are implemented in terms of something like
atomic_xchg plus mb(), this ought to be derivable from the first
requirement.

Taken together, I think these two schema express all the properties you
want for P2.  It's possible that you might want to state more strongly
that accesses cannot leak out of a critical section, even when viewed by a
CPU that's not in a critical section itself.  However I'm not sure this is
either necessary or correct.

It's not clear that the schema can handle your next example.

> 	CPU 0		CPU 1		CPU 2
> 	-----		-----		-----
> 	a = 1		while (l < 1);	z = l;
> 	mb();		b = 1;		mb();
> 	l = 1		mb();		y = b;
> 			l = 2;		x = a;
> 					assert(z != 2 || (x == 1 && y == 1));

We know by P2a between CPUs 1 and 2 that (z != 2 || y == 1) always holds.  
So you can simplify the assertion to

					assert(!(z==2 && x==0));

> I believe that P0, P1, and P2a are sufficient in this case:
> 
> 0.	If CPU 2 sees l!=2, then by P0, it will see z!=2 at the
> 	assertion, which must therefore succeed.
> 1.	On the other hand, if CPU 2 sees l==2, then by P2a, it must
> 	also see b==1.
> 2.	By P0, CPU 1 observes that l==1 preceded l==2.
> 3.	By P1 and #2, neither CPU 0 nor CPU can see l==1 following l==2.
> 4.	Therefore, if CPU 2 observes l==2, there must have been
> 	an earlier l==1.
> 5.	By P2a, any implied observation by CPU 2 of l==1 requires it to
> 	see a==1.

I don't like step 5.  Reasoning with counterfactuals can easily lead to
trouble.  Since CPU 2 doesn't ever actually see l==2, we mustn't deduce
anything on the assumption that it does.

> 6.	By #4 and #5, if CPU 2 sees l==2, it must also see a==1.
> 7.	By P0, if CPU 2 sees b==1, it must see y==1 at the assertion.
> 8.	By P0, if CPU 2 sees a==1, it must see x==1 at the assertion.
> 9.	#1, #6, #7, and #8 taken together implies that if CPU 2 sees
> 	l==2, the assertion succeeds.
> 10.	#0 and #9 taken together demonstrate that the assertion always
> 	succeeds.
> 
> I would need P2b or P2c if different combinations of reads and writes'
> happened in the critical section.

Maybe this example is complicated enough that you don't need to include it 
among the requirements for usable synchronization.


> > I think that's important enough to be worth emphasizing, so that people 
> > won't get it wrong.
> 
> Yep.  Just as it is necessary that in head->a, the fetch of "head" might
> well follow the fetch of "head->a".  ;-)

It's worthwhile also explaining the difference between a data dependency
and a control dependency.  In fact, for writes there are two kinds of data
dependencies: In one kind, the dependency is through the address to be
written (like what you have here) and in the other, it's through the value
to be written.


> > My thoughts have been moving in this direction:
> > 
> > 	Describe everything in terms of a single global ordering.  It's
> > 	easier to think about, and there shouldn't be a state-space
> > 	explosion because you can always confine your attention to the
> > 	events you care about and ignore the others.
> 
> I may well need to use both viewpoints.  However, my experience has been
> that thinking in terms of a single global ordering leads me to miss race
> conditions, so I am -extremely- reluctant (as you might have noticed!) to
> rely solely on explaining this in terms of a single global ordering.

That's a reasonable objection.  Doesn't thinking in terms of partial 
orders also lead you to miss race conditions?  In my experience they are 
easy to miss no matter how you organize your thinking!  :-)

> > 	Reads take place at a particular time (when the return value is
> > 	committed to) but writes become visible at different times to
> > 	different CPUs (such as when they respond to the invalidate
> > 	message).
> 
> Reads are as fuzzy as writes.  The candidate times for a read would be:
> 
> 0.	When the CPU hands the read request to the cache (BTW, I do agree
> 	with your earlier suggestion to separate CPU and cache actions,
> 	though I might well change my mind after running through an example
> 	or three...).
> 
> 1.	When all invalidates that arrived at the local cache before the
> 	read have been processed.  (Assuming the read reaches the local
> 	cache -- it might instead have been satisfied by the store queue.)
> 
> 2.	When the read request is transmitted from the cache to the rest
> 	of the system.  (Assuming it missed in the cache.)
> 
> 3.	When the last prior conflicting write completes -- with the
> 	list of possible write-completion times given in a previous
> 	email.  As near as I can tell, this is your preferred event
> 	for defining the time at which a read takes place.

No, I would prefer 4.  That's when the value is committed to.  3 could 
easily occur long before the read was executed.

> 4.	When the cacheline containing the variable being read is
> 	received at the local cache.
> 
> 5.	When the value being read is delivered to the CPU.
> 
> Of course, real CPUs are more complicated, so present more possible events
> to tag as being "when the read took place".  ;-)

Yes.  This is meant to be more of a suggestive model than an actual "this 
is how the hardware works" pronouncement.

BTW, I'm starting to think that the time when a write becomes visible to a
CPU might better be defined as the time when the value is first written to
a cacheline or store buffer accessible by that CPU.  Obviously any read
which completes before this time can't return the new value.  In a
flat cache architecture this would mean that writes _do_ become visible at
the same time to all CPUs except the one doing the write.  With a
hierarchical cache arrangement things get more complicated.

> > 	A CPU's own writes become visible to itself as soon as they
> > 	execute.  They become visible to other CPUs at the same time or
> > 	later, but not before.  A write might not ever become visible
> > 	to some CPUs.
> 
> The first sentence is implied by P0.  Not sure the second sentence is
> needed -- example?  The third sentence is implied by P1.

The second sentence probably isn't needed.  It merely states the obvious 
fact that a write can't become visible before it executes.  (Another 
reason for not defining the time as when the invalidate response is sent.  
There's no reason a CPU couldn't send an early invalidate message, even 
before it knew whether it was going to execute the write.)

But your interpretation for the first and third sentences is backward.  
They aren't implied by P0 and P1; rather P0 and P1 _follow_ as emergent 
consequences of the behavior described here.

> > 	A read will always return the value of a store that has already
> > 	become visible to that CPU, but not necessarily the latest such
> > 	store.
> 
> Not sure that this sentence is needed -- example?

CPU 1 does "a = 1" and then CPU 0 reads a==1.  A little later CPU 1 does
"a = 2".  CPU 0 acknowledges the invalidate message but hasn't yet
processed it when it tries to read a again and gets the old cached value
1.  So even though both stores are visible to CPU 0, the second read
returns the value from the first store.

To put it another way, at the time of the read the second store has not 
yet overwritten the first store on CPU 0.

> > So far everything is straightforward.  The difficult part arises
> > because multiple stores to the same location can mask and overwrite
> > one another.
> > 
> > 	If a read returns the value from a particular store, then later
> > 	reads (on the same CPU and of the same location) will never return 
> > 	values from stores that became visible earlier than that one.  
> > 	(The value has overwritten any earlier stores.)
> 
> Implied separately by each of P0 and P1, depending on your taste.

Backward again.  This is _used_ to show that P0 and P1 hold.

> > 	A store can be masked from a particular CPU by earlier or later 
> > 	stores to the same location (perhaps made by other CPUs).  A store
> > 	is masked from a CPU iff it never becomes visible to that CPU.

Some coherency requirements I thought of later:

	If two stores are made to the same location, it's not possible
	for the first to mask the second on one CPU and the second to
	mask the first on another CPU.  Also, if both stores are visible
	to any CPU then it's not possible for the store that becomes
	visible first to mask the other on any CPU.

> > 	If two stores are separated by wmb() then on any CPU where they
> > 	both become visible, they become visible in the order they were
> > 	executed.
> 
> This is P2a.

No it isn't, since P2a doesn't say anything about stores being visible or
orders.  It only talks about the whether certain reads return the values
of certain stores.  Furthermore, you need the next principle as well as
this one before you can deduce P2a.

> > 	If multiple stores to the same location are visible when a CPU
> > 	executes rmb(), then after the rmb() the latest store has
> > 	overwritten all the earlier ones.
> 
> This is P1 and P0, even if there is no rmb().  The rmb() does not affect
> loads and stores to a single location.  In fact, no memory barrier
> affects loads and stores to a single location, except to the extent
> that it changes timing in a given implementation -- but a random number
> of trips through a loop containing only nops would change timing as well.

I disagree.  Without this principle, we could have:

	CPU 0		CPU 1
	-----		-----
	a = 0;
	// Long delay
	a = 1;		y = b;
	wmb();		rmb();
	b = 1;		x = a;
			assert(!(y==1 && x==0));

Suppose y==1.  Then when CPU 1 reads a, both writes to a are visible.  
However if the rmb() didn't affect the CPU's behavior with respect to the
repeated writes, then the read would not be obliged to return the value
from the latest visible write.  That's what the rmb() forces.

> > 	If a CPU executes read-mb-store, then no other read on any CPU
> > 	can return the value of the store before this read completes.
> > 	(I'd like to say that the read completes before the store
> > 	becomes visible on any CPU; I'm not sure that either is right.  
> > 	What about on the executing CPU?)
> 
> This is P2b.  I think.

I'm not so sure.

> > But this isn't complete.  It doesn't say enough about when one write may
> > or may not mask another, or the fact that this occurs in such a way that
> > all CPUs will agree on the order of the stores to a single location they
> > see in common.
> 
> This would be covered by P1.

The coherency principle I added covers much of this.  For the rest, it's 
still necessary to add:

	Two stores cannot become visible in opposite orders to two CPUs.

> > And certainly there should be something saying that one way or another,
> > stores do eventually complete.  Given a long enough time with no other
> > accesses, some single store to a given location should become visible to
> > every CPU.
> 
> This would certainly be needed in order to analyze liveness, as opposed
> to "simply" analyzing SMP correctness (or lack thereof, as the case may be).
> SMP correctness "only" requires a full state-space search -- preferably
> -after- collapsing the state space.  ;-)

There should also be time limits on how long a store is able to mask or 
overwrite other stores.

> My thought is to take a more portability-paranoid approach.  Start with
> locking, deriving the memory-barrier properties required for locking
> to work correctly.  Rely only on those properties, since a number of
> CPUs seem to have been designed (to say nothing of validated!!!) only
> for locking.  After all, if a CPU doesn't support locking, it cannot
> support an SMP build of Linux.

That's the high-level approach I mentioned at the beginning of this email.  
It certainly is simpler that the lower-level approach.

Alan

