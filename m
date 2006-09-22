Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWIVUi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWIVUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWIVUi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:38:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7443 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964902AbWIVUi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:38:56 -0400
Date: Fri, 22 Sep 2006 16:38:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060922050236.GA1287@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609221425460.8223-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Paul E. McKenney wrote:

> > To express the various P2 requirements, let's say that a read "comes
> > after" a write if it sees the value of the write, and a second write
> > "comes after" a first write if it overwrites the first value.
> 
> And a read "comes after" a read if the "later" read sees the value of at
> least one write that "comes after" the "earlier" read.

No, this doesn't make sense since we have no notion of a write "coming 
after" a read.

>  The relation of
> the write and read is the converse of your first requirement, but that
> should be OK -- could explicitly state it: a write "comes after" a read
> if the read does not see the value of the write, but not sure whether it
> is useful to do so.

Not only is this not useful, it can be positively wrong!  It allows you
to draw incorrect conclusions.  For example:

	CPU 0		CPU 1
	-----		-----
	a = 1;		b = 1;
	mb();		mb();
	x = b + 1;	y = a + 1;
			assert(!(x==1 && y==1));

The assertion can fail if the writes to a and b cross in the night.  But
if CPU 1 sees a==0 then you would say CPU 0's "a = 1" came after CPU 1's
read of a, hence CPU 0's read of b came after CPU 1's write to b, hence
x==2 and the assertion should hold.

So we can talk about a read or a write "coming after" a write.  In general
we cannot talk about anything "coming after" a read.  However it might be 
okay when both accesses are on the same CPU:

	A
	M
	A'

In this case we might allow ourselves to say that the A' access "comes 
after" the A access even when A is a read.  (When A is a write, it
follows from P0 that A' has to come after A.)  Though not particularly
useful in itself, it could be combined with transitivity -- if you decide 
to allow transitivity.

>  I need to think about it a bit, but this certainly
> seems to fit with what I was previously calling "partial order".

Maybe it does.  If you're careful.  It's not clear whether "comes after" 
really needs to be transitive.

> >                                                               Let A and B
> > be addresses in memory, let A(n) and B(n) stand for any sort of accesses
> > to A and B by CPU n, and let M stand for any appropriate memory barrier.  
> > Then whenever we have
> > 
> > 	A(0)	B(1)
> > 	M	M
> > 	B(0)	A(1)
> > 
> > the requirement is: B(1) comes after B(0) implies A(1) comes after A(0) --
> > or at least A(0) doesn't come after A(1) -- whenever this makes sense in
> > terms of the actual access and barrier operations.  This is a bit stronger
> > than your P2a-P2c all together.
> 
> As long as we avoid any notion of transitivity, I -think- I am OK with
> this.  (OK, so yes there is transitivity in the single-variable P1 case,
> but not necessarily in the dual-variable P2x cases.)
> 
> > For locking, let L stand for a lock operation and U for an unlock 
> > operation.  Then whenever we have
> > 
> > 	L		L
> > 	{A(0),B(0)}	{A(1),B(1)}
> > 	// For each n, A(n) and B(n) can occur in arbitrary order
> > 	U		U
> > 
> > the requirement is that A(1) comes after A(0) implies B(1) comes after
> > B(0) -- or at least B(0) doesn't come after B(1) -- again, whenever that
> > makes sense.  If L and U are implemented in terms of something like
> > atomic_xchg plus mb(), this ought to be derivable from the first
> > requirement.
> 
> In fact, the atomic-plus-mb() would define which memory-barrier properties
> Linux could safely rely on.

Sounds reasonable.  I haven't actually checked that this locking 
requirement follows from the memory barrier requirement plus that 
implementation.  Maybe you'd like to go through the details.  :-)

> > Taken together, I think these two schema express all the properties you
> > want for P2.  It's possible that you might want to state more strongly
> > that accesses cannot leak out of a critical section, even when viewed by a
> > CPU that's not in a critical section itself.  However I'm not sure this is
> > either necessary or correct.
> 
> They are free to leak out, but only from the viewpoint of code that
> is outside of any mutually excluded critical section.  Our example a
> few emails ago being a case in point.

Good.

> > It's not clear that the schema can handle your next example.
> > 
> > > 	CPU 0		CPU 1		CPU 2
> > > 	-----		-----		-----
> > > 	a = 1		while (l < 1);	z = l;
> > > 	mb();		b = 1;		mb();
> > > 	l = 1		mb();		y = b;
> > > 			l = 2;		x = a;
> > > 					assert(z != 2 || (x == 1 && y == 1));
> > 
> > We know by P2a between CPUs 1 and 2 that (z != 2 || y == 1) always holds.  
> > So you can simplify the assertion to
> > 
> > 					assert(!(z==2 && x==0));
> > 
> > > I believe that P0, P1, and P2a are sufficient in this case:
> > > 
> > > 0.	If CPU 2 sees l!=2, then by P0, it will see z!=2 at the
> > > 	assertion, which must therefore succeed.
> > > 1.	On the other hand, if CPU 2 sees l==2, then by P2a, it must
> > > 	also see b==1.
> > > 2.	By P0, CPU 1 observes that l==1 preceded l==2.
> > > 3.	By P1 and #2, neither CPU 0 nor CPU can see l==1 following l==2.
> > > 4.	Therefore, if CPU 2 observes l==2, there must have been
> > > 	an earlier l==1.
> > > 5.	By P2a, any implied observation by CPU 2 of l==1 requires it to
> > > 	see a==1.
> > 
> > I don't like step 5.  Reasoning with counterfactuals can easily lead to
> > trouble.  Since CPU 2 doesn't ever actually see l==2, we mustn't deduce
> > anything on the assumption that it does.
> 
> You lost me on the last sentence -- we only get here if CPU 2 did in fact
> see l==2.  Or did you mean to say l==1?

Yes, it was another typo.  I try to weed them out, but a few always manage 
to squeak through...

>  In the latter case, then, yes,
> the use of P1 in #3 was an example of the only permitted transitivity --
> successive stores to a single variable.  This is required for multiple
> successive lock-based critical sections, so I feel justified relying
> on it.  If I acquire a lock, I see the results not only of the immediately
> preceding critical section for that lock, but also of all earlier critical
> sections for that lock (to the extent that the results of these earlier
> critical sections were not overwritten by intervening critical sections,
> of course).
> 
> > > 6.	By #4 and #5, if CPU 2 sees l==2, it must also see a==1.
> > > 7.	By P0, if CPU 2 sees b==1, it must see y==1 at the assertion.
> > > 8.	By P0, if CPU 2 sees a==1, it must see x==1 at the assertion.
> > > 9.	#1, #6, #7, and #8 taken together implies that if CPU 2 sees
> > > 	l==2, the assertion succeeds.
> > > 10.	#0 and #9 taken together demonstrate that the assertion always
> > > 	succeeds.
> > > 
> > > I would need P2b or P2c if different combinations of reads and writes'
> > > happened in the critical section.
> > 
> > Maybe this example is complicated enough that you don't need to include it 
> > among the requirements for usable synchronization.
> 
> Yeah, the point was to stress-test the definitions, not to illuminate
> the readers.  I guess that any reader who found that example illuminating
> must have -really- been in the dark!  ;-)

And yet, are you certain that the assertion must hold?  The mb() on CPU 0 
means that CPU 2 has to see "a = 1" before it sees "l = 1".  And CPU 2 has 
to see "l = 2" before it can get going.  But I don't know of any reason 
why CPU 2 might not see "l = 2" first, "a = 1" later, and "l = 1" not at 
all.


> > It's worthwhile also explaining the difference between a data dependency
> > and a control dependency.  In fact, for writes there are two kinds of data
> > dependencies: In one kind, the dependency is through the address to be
> > written (like what you have here) and in the other, it's through the value
> > to be written.
> 
> Fair enough -- although as we discussed before, control dependency does
> not necessarily result in memory ordering.  The writes cannot speculate
> ahead of the branch (as far as I know), but earlier writes could be
> delayed on weak-memory machines, which could look the same from the
> viewpoint of another CPU.

Yes, an earlier write could be delayed until after the branch.  But a 
later write cannot be moved forward before the branch.


> Hmmm...  In a previous email dated September 14 2006 10:58AM EDT,
> you chose #6 for the writes "when CPUs send acknowledgements for the
> invalidation requests".  Consider the following sequence of events,
> with A==0 initially:
> 
> o	CPU 0 stores A=1, but the cacheline for A is local, and not
> 	present in any other CPU's cache, so the write happens quite
> 	quickly.
> 
> o	CPU 1 loads A, sending out a read transaction on the bus.
> 
> o	CPU 2 stores A=2, sending out invalidations.
> 
> o	CPU 0 responds to CPU 1's read transaction.
> 
> o	CPU 1 receives the invalidation request from CPU 2.  By
> 	your earlier choice, this is the time at which the subsequent
> 	write (the one -not- seen by CPU 1's load of A) occurs.
> 
> o	CPU 1 receives the read response from CPU 0.  By your current
> 	choice, this is the time at which CPU 0's load of A occurs.
> 	CPU 1 presumably grabs the value of A from the cache line,
> 	then responds to CPU 2's invalidation request, so that the
> 	cacheline does a touch-and-go in CPU 1's cache before heading
> 	off to CPU 2.
> 
> So even though the load of A happened -after- the store A=2, the load
> sees A==1 rather than A==2.

That's right.  It's exactly what I had in mind when I said that a load 
doesn't necessarily return the value of the most recent visible store.

> > CPU 1 does "a = 1" and then CPU 0 reads a==1.  A little later CPU 1 does
> > "a = 2".  CPU 0 acknowledges the invalidate message but hasn't yet
> > processed it when it tries to read a again and gets the old cached value
> > 1.  So even though both stores are visible to CPU 0, the second read
> > returns the value from the first store.
> 
> Both stores are really visible to CPU 0?  Or only to its cache?

I'm not distinguishing those two concepts.

> > To put it another way, at the time of the read the second store has not 
> > yet overwritten the first store on CPU 0.
> 
> Or from the viewpoint of code running on CPU 0, the first store has
> happened, but the second store has not.

Yes.  The reason for doing things this way is so that I can give a "local"  
description of how wmb() and rmb() affect the CPU they execute on.  For
example, wmb() guarantees that earlier stores will become visible before
later stores.  It can't guarantee that code running on another CPU will
load the values in that order -- not unless the other CPU executes rmb().  
But keeping track of whether or not some other CPU chooses to execute
rmb() is outside the scope of what wmb() should have to do.  It's not part
of the job description.  :-)


> > 	                               Also, if both stores are visible
> > 	to any CPU then it's not possible for the store that becomes
> > 	visible first to mask the other on any CPU.
> 
> Eh?  Regardless of which one is visible on what CPU, the one that
> comes first will come first, and thus be overwritten by any later
> store to that same variable.

I didn't say "overwrite", I said "mask".  They aren't the same.  An 
earlier store can mask a later store.  For instance, if CPU 0 does "a = 2" 
and the assignment sits in a store buffer while CPU 1 completes storing "a 
= 1", then "a = 2" will mask "a = 1" on CPU 0.  CPU 1 will see both stores 
in the order 1,2 and CPU 0 will see only the value 2.

This is my way of getting around the fact that _if_ both stores were
visible to CPU 0, they would become visible in the opposite order from
CPU 1.

> Part of the conflict here appears to be that you are trying to define
> what a single memory barrier does in isolation,

That's exactly right.  I firmly believe that such a description should be
possible.  For instance, in the MESI model there aren't any special
messages exchanged saying "I am executing a wmb()".  No CPU has any way to
know what instructions another CPU is executing; that information just
isn't in the protocol.  So whatever effects a memory barrier may have,
they shouldn't depend directly on what instructions other CPUs are
running.  They can depend only on the messages sent over the bus.

> and I am trying to
> avoid that like the plague.  ;-)

To each his own.

> > > > 	If multiple stores to the same location are visible when a CPU
> > > > 	executes rmb(), then after the rmb() the latest store has
> > > > 	overwritten all the earlier ones.
> > > 
> > > This is P1 and P0, even if there is no rmb().  The rmb() does not affect
> > > loads and stores to a single location.  In fact, no memory barrier
> > > affects loads and stores to a single location, except to the extent
> > > that it changes timing in a given implementation -- but a random number
> > > of trips through a loop containing only nops would change timing as well.
> > 
> > I disagree.  Without this principle, we could have:
> > 
> > 	CPU 0		CPU 1
> > 	-----		-----
> > 	a = 0;
> > 	// Long delay
> > 	a = 1;		y = b;
> > 	wmb();		rmb();
> > 	b = 1;		x = a;
> > 			assert(!(y==1 && x==0));
> > 
> > Suppose y==1.  Then when CPU 1 reads a, both writes to a are visible.  
> > However if the rmb() didn't affect the CPU's behavior with respect to the
> > repeated writes, then the read would not be obliged to return the value
> > from the latest visible write.  That's what the rmb() forces.
> 
> The only reason you need the rmb() is because you introduced the
> second variable that went unmentioned in your earlier email.  ;-)

What?  If the rmb() wasn't there then the assertion might fail.  The idea 
of this principle is to describe how the rmb() -- in isolation! -- affects 
the operation of CPU 1.

Alan

