Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423132AbWJRXAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423132AbWJRXAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423138AbWJRXAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:00:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50149 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423132AbWJRXAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:00:54 -0400
Date: Wed, 18 Oct 2006 16:01:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061018230159.GJ1902@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061017225838.GK2062@us.ibm.com> <Pine.LNX.4.44L0.0610181041420.6766-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610181041420.6766-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 03:05:26PM -0400, Alan Stern wrote:
> On Tue, 17 Oct 2006, Paul E. McKenney wrote:
> 
> > > It was taking the effect of memory barriers into account.  In the program
> > > "load(A); store(B)" the load doesn't sequentially precede the store.  But
> > > in the program "load(A); smp_mb(); store(B)" it does.  Similarly, in the
> > > program "if (A) B = 2;" the load(A) sequentially precedes the store(B) --
> > > thanks to the dependency or (if you prefer) the absence of speculative
> > > stores.
> > > 
> > > Basically "sequentially precedes" means that any other CPU using the
> > > appropriate memory barriers will observe the accesses apparently occurring
> > > in this order.
> > 
> > Your first example in the previous paragraph fits the description.
> > The second does not, as illustrated by the following scenario:
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 
> > 	A=1			while (B==0);		while (C==0);
> > 	smp_mb()		C=1			smp_mb()
> > 	B=1						assert(A==1) <fails>
> 
> In what way is this inconsistent with my second example?

I believe that it -is- in fact consistent with your second example,
though more elaborate than needed.  But it doesn't matter, in the
following simpler example, the assertion also fails:

	CPU 0			CPU 1			CPU 2

	A=1			while (A==0);		while (B==0);
				B=1			smp_mb()
							assert(A==1) <fails>

Perhaps I don't understand what you mean by "sequentially precedes"
in your earlier paragraph -- but you did say that "any other CPU using
the appropriate memory barriers will observe the accesses apparently
occurring in this order".  One interpretation might be that CPU 2's
load of A temporally follows CPU 1's load of A.  This would of course
not prevent CPU 2 from seeing an "earlier" value of A than did CPU 1,
as we have both noted many times.  ;-)

>                                                          Using "<" for 
> "sequentially precedes" we have:
> 
> 	st_0(A=1) < st_0(B=1) <v ld_1(B) < st_1(C=1) <v ld_2(C) < ld_2(A)

We are using "<" backwards from each other.  You are using it as if
you were comparing time values (which I guess I should have anticipated
given your temporal viewpoint), while I was using it to indicate flow
of data (for ">v") or flow of control (for ">p").  In my notation,
st > ld makes sense (the store's data flows to the load), in yours it
would instead indicate that the store happened after the load.  I think.

My guess is that you are using "<" to indicate presence of a memory barrier.

Perhaps I should use ">>v", analogous to the C++ I/O operator, to 
emphasize that I am not comparing things.  Would that help?

Another alternative would be "->v", but that could be confused with
the implication operator.

> You cannot derive st_0(A=1) <v ld_2(A) from this.  The rules are:
> 
> 	1:st(X) < 2:st(Y) <v 3:ac(Y) < 4:ac(X)  implies
> 		1:st(X) <v 4:ac(X)
> 
> and
> 
> 	1:ld(X) < 2:st(Y) <v 3:ac(Y) < 4:st(X)  implies
> 		4:st(X) !<v 1:ld(X).

Agreed.  If you -could- derive this, the assertion would never fail.

> > Please note that the "<fails>" is not a theoretical assertion -- I have
> > seen this happen in real life.  So, yes, the C=1 might not speculate ahead
> > of the load of B that produced a non-zero result, but CPU 2's assertion
> > can still fail, even though both CPU 2 and CPU 0 are using memory barriers.
> 
> Your example would be no less fallacious if CPU 1 executed smp_mb() before
> C = 1.  The assertion could still fail because CPU 1's write to C could
> become visible to CPU 2 before CPU 0's writes to A and B.

Yep, at least if I interpret "fallacious" to mean "prone to assertion
failure".

> > > Yes, I realize that.  But if several CPUs store values to the same
> > > variable at about the same time, it's not at all clear which stores are
> > > "<v" others.  Deciding this is tantamount to ordering all the stores to
> > > that variable.
> > 
> > Yep.  Consider the following case:
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 
> > 	A=1			B=1			X=C
> > 	smb_mb()		smp_mb()		smp_mb()
> > 	C=1			C=2			if (X==1) ???
> > 
> > In the then-clause of the "if", CPU 2 can only be sure that it will
> > see A==1.  It might or might not see B==1.  We simply don't know the
> > order of stores to C, even at runtime.
> 
> It's one thing to say you don't know the order of stores.  It's another 
> thing to say that there _is_ no order -- especially if you're going to use 
> the "<v" notation to implicitly impose such an order!

">v" only applies to single variables, at least in my viewpoint.

For multiple stores to multiple variables, it is easy to create scenarios
where people could disagree as to what the order of stores was, depending
on exactly which of the many events associated with a given store defined
that store's timestamp.

> So maybe what you're claiming is that the stores to a single variable _do_ 
> have a global order at runtime, even though we might not know what it is, 
> and the view each CPU has is always a suborder of that global order.  (And 
> of course there is no fixed relation on how the global orders of stores to 
> two separate variables inter-relate, unless it is enforced by memory 
> barriers.)
> 
> Does this claim always make sense, even in a hierarchical cache system?

For a single variable in a cache-coherent system, yes.  Because if this
claim does not hold, then by definition, the system is not cache-coherent.

> > Now consider the following:
> > 
> > 	CPU 0		CPU 1		CPU 2
> > 
> > 	A=1		B=1		X=C
> > 	smb_mb()	smp_mb()	smp_mb()
> > 	atomic_inc(&C)	atomic_inc(&C)	assert(C!=2 || (A==1 && B==1))
> > 
> > This assertion is guaranteed to succeed (using my semantics of the
> > transitivity of ">v"/"<v" -- using yours, CPU 2 would instead need to
> > use an atomic operation to fetch the value of C).  We still don't know
> > which atomic_inc() happened first (we would need atomic_inc_return()
> > to figure that out), but we can nevertheless determine if both have
> > happened and act accordingly.
> 
> Yes.  What is your point?  And how is it related to the existence of a 
> global ordering for all stores to a single variable?

The first example did not permit CPU 2 to detect when both CPU's stores
to C had completed, while the second example does permit this.

> > An alternative would be to use something like "sees" to describe "<v":
> > 
> > 	ld_1(A) <v st_0(A=1)
> > 
> > might be called "CPU 1's load of A sees CPU 0's store of 1 into A".
> 
> You wrote this backwards; it should say:  st_0(A=1) <v ld_1(A).

We are still disagreeing on the definition of "<v".  I could try writing
it as ld_1(A) <<v st_0(a=1) to make it clear that I am not comparing
timestamps.

> > Then "<v" would be "is seen by".  In my regime:
> > 
> > 	ld_2(A) <v ++_1(A=2) <v st_0(A=1) -> ld_2(A) <v st_0(A=1)
> 
> Backwards again.  You mean:
> 
>    st_0(A=1) <v ++_1(A=2) <v ld_2(A)  implies  st_0(A=1) <v ld_2(A)

Or:

	ld_2(A) <<v ++_1(A=2) <<v st_0(A=1) -> ld_2(A) <<v st_0(A=1)

> > In yours, this would not hold unless the ld_2() was replaced by an atomic
> > operation (if I understand your regime correctly).
> 
> Basically yes, although I'm not sure how a load manages to be atomic.  
> Maybe if it's part of an atomic exchange or something like that.

Yes, an atomic exchange is indeed one way to implement a lock-acquisition
primitive, which is the case that requires transitivity.

Perhaps this could be denoted by atomic\_inc_1(A) or some such.

> > Does this "sees"/"is seen by" nomenclature seem more reasonable?
> > Or perhaps "visibility includes"/"visible to"?  Or keep "sees"/"seen by"
> > and use "<s"/">s" to adjust the mneumonic?
> 
> I'm not keen on either one.  Does it make sense to say one store is
> visible to (or is seen by) another store?  Maybe...  But "comes before"  
> seems more natural.  Especially if you're assuming the existence of a
> global ordering on these stores.

In your time-based viewpoint, I would guess that "comes before" would
be quite natural -- and this makes complete sense for MMIO accesses,
as far as I can tell (never have done much in the way of parallel device
drivers, though).  For memory-based data structures, as we have discussed,
there are cases where taking a time-based approach can be misleading.
Or, in my case, can lead to bugs.  ;-)

> Incidentally, although you haven't mentioned this, it's important never to
> state that a load is visible to (or is seen by or comes before) another
> access.  In other words, the global ordering of stores for a single
> variable doesn't extend to a global ordering of _all_ accesses for that
> variable.

Yes.  From my viewpoint (ignoring MMIO), stores are mute and loads
are deaf.  So stores can "hear" loads, but not vice versa.  I guess I
could make the "sees" analogy work just as well -- in that case stores
are blind and loads are invisible, so that loads can see stores, but
not vice versa.  And loads can neither see nor hear other loads.

In the MMIO case, a load may be visible to a subsequent store due to
changes in device state.  In principle, anyway, it has been awhile since
I have looked carefully at device-register specifications, so I have no
idea if any real devices do this -- on this, I must defer to you.

							Thanx, Paul
