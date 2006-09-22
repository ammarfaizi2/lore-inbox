Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWIVOSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWIVOSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWIVOSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:18:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1469 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932525AbWIVOSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:18:30 -0400
Date: Thu, 21 Sep 2006 22:02:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060922050236.GA1287@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060921013458.GF1292@us.ibm.com> <Pine.LNX.4.44L0.0609211413120.9279-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609211413120.9279-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 04:59:00PM -0400, Alan Stern wrote:
> We are really discussing two different things here.  On one hand you're 
> trying to present a high-level description of the requirements memory 
> barriers must fulfill in order to support usable synchronization.  On the 
> other, I'm trying to present a lower-level description of how memory 
> barriers operate, from which one could prove that your higher-level 
> requirements are satisfied as a sort of emergent behavior.

I do want to do both -- just need to start with the requirements to make
sure we don't end up overconstraining things.

> On Wed, 20 Sep 2006, Paul E. McKenney wrote:
> 
> > That is what I was thinking, but then I realized that P2c is absolutely
> > required for locking.  For example:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	spin_lock(&l);		spin_lock(&l);
> > 	x = 0;			x = 1;
> > 	spin_unlock(&l);	spin_unlock(&l);
> > 
> > Whichever CPU acquires the lock last had better be the one whose value
> > "sticks" in x.  So, if I see that the other CPU has released its lock,
> > then any writes that I do need to override whatever writes the other CPU
> > did within its critical section.
> 
> Yes.
> 
> On the whole, the best way to present your approach might be like this.  
> P0 and P1 are simple basic requirements for any SMP system.  They have
> nothing to do with memory barriers especially.  So let's concentrate on
> P2.

True enough, P0 and P1 are the ordering properties you can count on
even in absence of memory barriers.

> To express the various P2 requirements, let's say that a read "comes
> after" a write if it sees the value of the write, and a second write
> "comes after" a first write if it overwrites the first value.

And a read "comes after" a read if the "later" read sees the value of at
least one write that "comes after" the "earlier" read.  The relation of
the write and read is the converse of your first requirement, but that
should be OK -- could explicitly state it: a write "comes after" a read
if the read does not see the value of the write, but not sure whether it
is useful to do so.  I need to think about it a bit, but this certainly
seems to fit with what I was previously calling "partial order".

>                                                               Let A and B
> be addresses in memory, let A(n) and B(n) stand for any sort of accesses
> to A and B by CPU n, and let M stand for any appropriate memory barrier.  
> Then whenever we have
> 
> 	A(0)	B(1)
> 	M	M
> 	B(0)	A(1)
> 
> the requirement is: B(1) comes after B(0) implies A(1) comes after A(0) --
> or at least A(0) doesn't come after A(1) -- whenever this makes sense in
> terms of the actual access and barrier operations.  This is a bit stronger
> than your P2a-P2c all together.

As long as we avoid any notion of transitivity, I -think- I am OK with
this.  (OK, so yes there is transitivity in the single-variable P1 case,
but not necessarily in the dual-variable P2x cases.)

> For locking, let L stand for a lock operation and U for an unlock 
> operation.  Then whenever we have
> 
> 	L		L
> 	{A(0),B(0)}	{A(1),B(1)}
> 	// For each n, A(n) and B(n) can occur in arbitrary order
> 	U		U
> 
> the requirement is that A(1) comes after A(0) implies B(1) comes after
> B(0) -- or at least B(0) doesn't come after B(1) -- again, whenever that
> makes sense.  If L and U are implemented in terms of something like
> atomic_xchg plus mb(), this ought to be derivable from the first
> requirement.

In fact, the atomic-plus-mb() would define which memory-barrier properties
Linux could safely rely on.

> Taken together, I think these two schema express all the properties you
> want for P2.  It's possible that you might want to state more strongly
> that accesses cannot leak out of a critical section, even when viewed by a
> CPU that's not in a critical section itself.  However I'm not sure this is
> either necessary or correct.

They are free to leak out, but only from the viewpoint of code that
is outside of any mutually excluded critical section.  Our example a
few emails ago being a case in point.

> It's not clear that the schema can handle your next example.
> 
> > 	CPU 0		CPU 1		CPU 2
> > 	-----		-----		-----
> > 	a = 1		while (l < 1);	z = l;
> > 	mb();		b = 1;		mb();
> > 	l = 1		mb();		y = b;
> > 			l = 2;		x = a;
> > 					assert(z != 2 || (x == 1 && y == 1));
> 
> We know by P2a between CPUs 1 and 2 that (z != 2 || y == 1) always holds.  
> So you can simplify the assertion to
> 
> 					assert(!(z==2 && x==0));
> 
> > I believe that P0, P1, and P2a are sufficient in this case:
> > 
> > 0.	If CPU 2 sees l!=2, then by P0, it will see z!=2 at the
> > 	assertion, which must therefore succeed.
> > 1.	On the other hand, if CPU 2 sees l==2, then by P2a, it must
> > 	also see b==1.
> > 2.	By P0, CPU 1 observes that l==1 preceded l==2.
> > 3.	By P1 and #2, neither CPU 0 nor CPU can see l==1 following l==2.
> > 4.	Therefore, if CPU 2 observes l==2, there must have been
> > 	an earlier l==1.
> > 5.	By P2a, any implied observation by CPU 2 of l==1 requires it to
> > 	see a==1.
> 
> I don't like step 5.  Reasoning with counterfactuals can easily lead to
> trouble.  Since CPU 2 doesn't ever actually see l==2, we mustn't deduce
> anything on the assumption that it does.

You lost me on the last sentence -- we only get here if CPU 2 did in fact
see l==2.  Or did you mean to say l==1?  In the latter case, then, yes,
the use of P1 in #3 was an example of the only permitted transitivity --
successive stores to a single variable.  This is required for multiple
successive lock-based critical sections, so I feel justified relying
on it.  If I acquire a lock, I see the results not only of the immediately
preceding critical section for that lock, but also of all earlier critical
sections for that lock (to the extent that the results of these earlier
critical sections were not overwritten by intervening critical sections,
of course).

> > 6.	By #4 and #5, if CPU 2 sees l==2, it must also see a==1.
> > 7.	By P0, if CPU 2 sees b==1, it must see y==1 at the assertion.
> > 8.	By P0, if CPU 2 sees a==1, it must see x==1 at the assertion.
> > 9.	#1, #6, #7, and #8 taken together implies that if CPU 2 sees
> > 	l==2, the assertion succeeds.
> > 10.	#0 and #9 taken together demonstrate that the assertion always
> > 	succeeds.
> > 
> > I would need P2b or P2c if different combinations of reads and writes'
> > happened in the critical section.
> 
> Maybe this example is complicated enough that you don't need to include it 
> among the requirements for usable synchronization.

Yeah, the point was to stress-test the definitions, not to illuminate
the readers.  I guess that any reader who found that example illuminating
must have -really- been in the dark!  ;-)

> > > I think that's important enough to be worth emphasizing, so that people 
> > > won't get it wrong.
> > 
> > Yep.  Just as it is necessary that in head->a, the fetch of "head" might
> > well follow the fetch of "head->a".  ;-)
> 
> It's worthwhile also explaining the difference between a data dependency
> and a control dependency.  In fact, for writes there are two kinds of data
> dependencies: In one kind, the dependency is through the address to be
> written (like what you have here) and in the other, it's through the value
> to be written.

Fair enough -- although as we discussed before, control dependency does
not necessarily result in memory ordering.  The writes cannot speculate
ahead of the branch (as far as I know), but earlier writes could be
delayed on weak-memory machines, which could look the same from the
viewpoint of another CPU.

> > > My thoughts have been moving in this direction:
> > > 
> > > 	Describe everything in terms of a single global ordering.  It's
> > > 	easier to think about, and there shouldn't be a state-space
> > > 	explosion because you can always confine your attention to the
> > > 	events you care about and ignore the others.
> > 
> > I may well need to use both viewpoints.  However, my experience has been
> > that thinking in terms of a single global ordering leads me to miss race
> > conditions, so I am -extremely- reluctant (as you might have noticed!) to
> > rely solely on explaining this in terms of a single global ordering.
> 
> That's a reasonable objection.  Doesn't thinking in terms of partial 
> orders also lead you to miss race conditions?  In my experience they are 
> easy to miss no matter how you organize your thinking!  :-)

I stand corrected.  I should have said "leads me to miss -even- -more-
race conditions".  ;-)

> > > 	Reads take place at a particular time (when the return value is
> > > 	committed to) but writes become visible at different times to
> > > 	different CPUs (such as when they respond to the invalidate
> > > 	message).
> > 
> > Reads are as fuzzy as writes.  The candidate times for a read would be:
> > 
> > 0.	When the CPU hands the read request to the cache (BTW, I do agree
> > 	with your earlier suggestion to separate CPU and cache actions,
> > 	though I might well change my mind after running through an example
> > 	or three...).
> > 
> > 1.	When all invalidates that arrived at the local cache before the
> > 	read have been processed.  (Assuming the read reaches the local
> > 	cache -- it might instead have been satisfied by the store queue.)
> > 
> > 2.	When the read request is transmitted from the cache to the rest
> > 	of the system.  (Assuming it missed in the cache.)
> > 
> > 3.	When the last prior conflicting write completes -- with the
> > 	list of possible write-completion times given in a previous
> > 	email.  As near as I can tell, this is your preferred event
> > 	for defining the time at which a read takes place.
> 
> No, I would prefer 4.  That's when the value is committed to.  3 could 
> easily occur long before the read was executed.

Hmmm...  In a previous email dated September 14 2006 10:58AM EDT,
you chose #6 for the writes "when CPUs send acknowledgements for the
invalidation requests".  Consider the following sequence of events,
with A==0 initially:

o	CPU 0 stores A=1, but the cacheline for A is local, and not
	present in any other CPU's cache, so the write happens quite
	quickly.

o	CPU 1 loads A, sending out a read transaction on the bus.

o	CPU 2 stores A=2, sending out invalidations.

o	CPU 0 responds to CPU 1's read transaction.

o	CPU 1 receives the invalidation request from CPU 2.  By
	your earlier choice, this is the time at which the subsequent
	write (the one -not- seen by CPU 1's load of A) occurs.

o	CPU 1 receives the read response from CPU 0.  By your current
	choice, this is the time at which CPU 0's load of A occurs.
	CPU 1 presumably grabs the value of A from the cache line,
	then responds to CPU 2's invalidation request, so that the
	cacheline does a touch-and-go in CPU 1's cache before heading
	off to CPU 2.

So even though the load of A happened -after- the store A=2, the load
sees A==1 rather than A==2.

Situations like this helped break me of my desire to think of loads
and stores as being non-fuzzy.  Though I will admit that I did beat
my head against that particular wall for a bit before giving in...

> > 4.	When the cacheline containing the variable being read is
> > 	received at the local cache.
> > 
> > 5.	When the value being read is delivered to the CPU.
> > 
> > Of course, real CPUs are more complicated, so present more possible events
> > to tag as being "when the read took place".  ;-)
> 
> Yes.  This is meant to be more of a suggestive model than an actual "this 
> is how the hardware works" pronouncement.

Agreed, as I have no desire to try to drag people through a real CPU.
Hey, I don't even have much desire to drag -myself- through a real CPU!!!

> BTW, I'm starting to think that the time when a write becomes visible to a
> CPU might better be defined as the time when the value is first written to
> a cacheline or store buffer accessible by that CPU.  Obviously any read
> which completes before this time can't return the new value.  In a
> flat cache architecture this would mean that writes _do_ become visible at
> the same time to all CPUs except the one doing the write.  With a
> hierarchical cache arrangement things get more complicated.

Yep.  In particular, different reads from different CPUs issuing at the
same time can see different values.  You can have quite a bit of fun
if your system happens to have a perfectly synchronized fine-grained
counter available at low overhead to each CPU, as you can then write a
small program that proves that a given variable is taking on different
values at different CPUs at the same time -- the store buffers could
each be holding a different value for that variable for the length of
time required to pull the cache line in from DRAM.  ;-)

Of course if you choose "written to a store buffer" as the time for
a write, then later reads might not see that write, despite its having
happened earlier.  So I don't see the value of labelling any one of
these events as being "the" time the write occurred -- but I do agree
that I must at least show how things look from this sort of viewpoint,
as it is no doubt a very natural one for anyone who has not spent 16
years beating their head against SMP hardware.

> > > 	A CPU's own writes become visible to itself as soon as they
> > > 	execute.  They become visible to other CPUs at the same time or
> > > 	later, but not before.  A write might not ever become visible
> > > 	to some CPUs.
> > 
> > The first sentence is implied by P0.  Not sure the second sentence is
> > needed -- example?  The third sentence is implied by P1.
> 
> The second sentence probably isn't needed.  It merely states the obvious 
> fact that a write can't become visible before it executes.  (Another 
> reason for not defining the time as when the invalidate response is sent.  
> There's no reason a CPU couldn't send an early invalidate message, even 
> before it knew whether it was going to execute the write.)

On i386, the programmer can force an early invalidation manually,
as well -- "atomic_add(&v, 0);".  Yes, this -is- cheating.  What is
your point?  ;-)

Seriously, I vaguely remember several CPUs having cache-control
instructions that effectively allow assembly-language programmers and
compiler writers to issue the invalidate long before the write occurs.

> But your interpretation for the first and third sentences is backward.  
> They aren't implied by P0 and P1; rather P0 and P1 _follow_ as emergent 
> consequences of the behavior described here.

>From your viewpoint, yes (I think).  But if you are reasoning from any
given starting point, all the other points are consequences of that
starting point.

> > > 	A read will always return the value of a store that has already
> > > 	become visible to that CPU, but not necessarily the latest such
> > > 	store.
> > 
> > Not sure that this sentence is needed -- example?
> 
> CPU 1 does "a = 1" and then CPU 0 reads a==1.  A little later CPU 1 does
> "a = 2".  CPU 0 acknowledges the invalidate message but hasn't yet
> processed it when it tries to read a again and gets the old cached value
> 1.  So even though both stores are visible to CPU 0, the second read
> returns the value from the first store.

Both stores are really visible to CPU 0?  Or only to its cache?

> To put it another way, at the time of the read the second store has not 
> yet overwritten the first store on CPU 0.

Or from the viewpoint of code running on CPU 0, the first store has
happened, but the second store has not.

> > > So far everything is straightforward.  The difficult part arises
> > > because multiple stores to the same location can mask and overwrite
> > > one another.
> > > 
> > > 	If a read returns the value from a particular store, then later
> > > 	reads (on the same CPU and of the same location) will never return 
> > > 	values from stores that became visible earlier than that one.  
> > > 	(The value has overwritten any earlier stores.)
> > 
> > Implied separately by each of P0 and P1, depending on your taste.
> 
> Backward again.  This is _used_ to show that P0 and P1 hold.

To be expected, given our opposing viewpoints.

> > > 	A store can be masked from a particular CPU by earlier or later 
> > > 	stores to the same location (perhaps made by other CPUs).  A store
> > > 	is masked from a CPU iff it never becomes visible to that CPU.
> 
> Some coherency requirements I thought of later:
> 
> 	If two stores are made to the same location, it's not possible
> 	for the first to mask the second on one CPU and the second to
> 	mask the first on another CPU.

P1 again -- accesses to a given single variable are seen in consistent
order by all CPUs.

> 	                               Also, if both stores are visible
> 	to any CPU then it's not possible for the store that becomes
> 	visible first to mask the other on any CPU.

Eh?  Regardless of which one is visible on what CPU, the one that
comes first will come first, and thus be overwritten by any later
store to that same variable.

> > > 	If two stores are separated by wmb() then on any CPU where they
> > > 	both become visible, they become visible in the order they were
> > > 	executed.
> > 
> > This is P2a.
> 
> No it isn't, since P2a doesn't say anything about stores being visible or
> orders.  It only talks about the whether certain reads return the values
> of certain stores.  Furthermore, you need the next principle as well as
> this one before you can deduce P2a.

It is P2a -- the pair of ordered reads required by P2a are implied by
"they become visible in the order they were executed", at least if
we choose an appropriate definition of "executed".

Part of the conflict here appears to be that you are trying to define
what a single memory barrier does in isolation, and I am trying to
avoid that like the plague.  ;-)

> > > 	If multiple stores to the same location are visible when a CPU
> > > 	executes rmb(), then after the rmb() the latest store has
> > > 	overwritten all the earlier ones.
> > 
> > This is P1 and P0, even if there is no rmb().  The rmb() does not affect
> > loads and stores to a single location.  In fact, no memory barrier
> > affects loads and stores to a single location, except to the extent
> > that it changes timing in a given implementation -- but a random number
> > of trips through a loop containing only nops would change timing as well.
> 
> I disagree.  Without this principle, we could have:
> 
> 	CPU 0		CPU 1
> 	-----		-----
> 	a = 0;
> 	// Long delay
> 	a = 1;		y = b;
> 	wmb();		rmb();
> 	b = 1;		x = a;
> 			assert(!(y==1 && x==0));
> 
> Suppose y==1.  Then when CPU 1 reads a, both writes to a are visible.  
> However if the rmb() didn't affect the CPU's behavior with respect to the
> repeated writes, then the read would not be obliged to return the value
> from the latest visible write.  That's what the rmb() forces.

The only reason you need the rmb() is because you introduced the
second variable that went unmentioned in your earlier email.  ;-)

> > > 	If a CPU executes read-mb-store, then no other read on any CPU
> > > 	can return the value of the store before this read completes.
> > > 	(I'd like to say that the read completes before the store
> > > 	becomes visible on any CPU; I'm not sure that either is right.  
> > > 	What about on the executing CPU?)
> > 
> > This is P2b.  I think.
> 
> I'm not so sure.

It is either P2b, or it is overconstrained.  The other CPU would not be
permitted to do a write conflicting with the first CPU's initial read,
but even then, there have to be memory barriers on the second CPU to
enforce this.

> > > But this isn't complete.  It doesn't say enough about when one write may
> > > or may not mask another, or the fact that this occurs in such a way that
> > > all CPUs will agree on the order of the stores to a single location they
> > > see in common.
> > 
> > This would be covered by P1.
> 
> The coherency principle I added covers much of this.  For the rest, it's 
> still necessary to add:
> 
> 	Two stores cannot become visible in opposite orders to two CPUs.

If they are to the same variable, yes.  But I thought we covered this
earlier.

> > > And certainly there should be something saying that one way or another,
> > > stores do eventually complete.  Given a long enough time with no other
> > > accesses, some single store to a given location should become visible to
> > > every CPU.
> > 
> > This would certainly be needed in order to analyze liveness, as opposed
> > to "simply" analyzing SMP correctness (or lack thereof, as the case may be).
> > SMP correctness "only" requires a full state-space search -- preferably
> > -after- collapsing the state space.  ;-)
> 
> There should also be time limits on how long a store is able to mask or 
> overwrite other stores.

For liveness/latency, yes.  And most computer systems I know of do have
hardware timeouts should the cache-coherence protocol leave something
stranded for too long, but if these trigger, it is typically "game over"
for the software.  On NUMA-Q, the hardware essentially takes a crash dump
of the cache-coherence protocol state when this happens, in which appear
only random physical addresses and cache tags (maybe values sometimes,
I don't recall).  In early prototypes of the hardware, it was possible
for the software to force such an event (in one case, by doing something
to the effect of referencing a virtual address that was mapped to a
"hole" in the physical address space that was populated by neither RAM
nor MMIO).  We were thankfully able to shame the hardware guys into
taking more reasonable action in such cases, as debugging these sorts
of things was quite painful.

> > My thought is to take a more portability-paranoid approach.  Start with
> > locking, deriving the memory-barrier properties required for locking
> > to work correctly.  Rely only on those properties, since a number of
> > CPUs seem to have been designed (to say nothing of validated!!!) only
> > for locking.  After all, if a CPU doesn't support locking, it cannot
> > support an SMP build of Linux.
> 
> That's the high-level approach I mentioned at the beginning of this email.  
> It certainly is simpler that the lower-level approach.

OK, so I will start from locking, derive rules, and show how they look
from the hardware.  Give or take what happens when I actually try to
do this.  ;-)

						Thanx, Paul
