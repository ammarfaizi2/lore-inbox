Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWISArD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWISArD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWISArC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:47:02 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60391 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751264AbWISArA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:47:00 -0400
Date: Mon, 18 Sep 2006 17:47:51 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060919004750.GJ1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060918191338.GH1294@us.ibm.com> <Pine.LNX.4.44L0.0609181540110.7192-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609181540110.7192-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 04:13:42PM -0400, Alan Stern wrote:
> On Mon, 18 Sep 2006, Paul E. McKenney wrote:
> 
> > > I wonder if it really is possible to find a complete set.  Perhaps 
> > > examples can become arbitrarily complex and only some formal logical 
> > > system would be able to generate all of them.  If that's the case then I 
> > > would like to know what that logical system is.
> > 
> > Here is my nomination for the complete set:
> > 
> > 	A|B  B|A
> > 
> > 	L|L  L|L -- Independent of ordering
> > 	L|L  L|S -- Pointless, since there is no second store
> > 	L|L  S|L -- Pointless, since there is no second store
> > 	L|L  S|S -- first pairing
> > 
> > 	L|S  L|L -- (DUP) single-store pointless
> > 	L|S  L|S -- second pairing
> > 	L|S  S|L -- problematic store-barrier-load
> > 	L|S  S|S -- If CPU 0's load sees CPU 1's 2nd store, then CPU 0's
> > 			store wins.  (third pairing)
> > 
> > 	S|L  L|L -- (DUP) single-store pointless
> > 	S|L  L|S -- (DUP) problematic store-barrier-load
> > 	S|L  S|L -- (DUP) problematic store-barrier-load
> > 	S|L  S|S -- (DUP) problematic store-barrier-load
> > 
> > 	S|S  L|L -- (DUP) first pairing
> > 	S|S  L|S -- (DUP) winning store.
> > 	S|S  S|L -- (DUP) problematic store-barrier-load
> > 	S|S  S|S -- Pointless, no loads
> > 
> > The first column is CPU 0's actions, the second is CPU 1's actions.
> > "S" is store, "L" is load.  CPU 0 accesses A first, then B, while
> > CPU 1 does the opposite.  The commentary is my guess at what happens.
> > 
> > I believe that more complex cases can be handled by superposition.
> > For example, if CPU 0 load A, does a barrier, stores B and C, while
> > CPU 1 loads B and C, does a barrier, and stores A, then one can apply
> > the "second pairing" twice, once for A and B, and again for A and C.
> > If B and C are the same variable, then P2 would also apply.
> > 
> > Counterexamples?  ;-)

Restating (and renumbering) the principles, all assuming no other stores
than those mentioned, assuming no aliasing among variables, and assuming
that each store changes the value of the target variable:

(P0):	Each CPU sees its own stores and loads as occurring in program
	order.

(P1):	If each CPU performs a series of stores to a single shared variable,
	then the series of values obtained by the a given CPUs stores and
	loads must be consistent with that obtained by each of the other
	CPUs.  It may or may not be possible to deduce a single global
	order from the full set of such series.

(P2a):	If two stores to A and B are ordered on CPU 0, and two loads from
	B and A are ordered on CPU 1, and if CPU 1's load from B sees
	CPU 0's store to B, then CPU 1's load from A must see CPU 0's
	store to A.

(P2b):	If a load from A is ordered before a store to B on CPU 0, and a
	load from B is ordered before a store to A on CPU 1, then if
	CPU 1's load from B sees CPU 0's store to B, then CPU 0's load
	from A cannot see CPU 1's store to A.

(P2c):	If a load from A is ordered before a store to B on CPU 0, and a
	store to B is ordered before a store to A on CPU 1, and if CPU 0's
	load from A gives the value stored to A by CPU 1, then CPU 1's
	store to B must be ordered before CPU 0's store to B, so that
	the final value of B is that stored by CPU 0.

> You only considered actions by two CPUs, and you only considered orderings
> induced by the memory barriers.  What about interactions among multiple
> CPUs or orderings caused by control dependencies?  Two examples:
> 
> 	CPU 0		CPU 1		CPU 2
> 	-----		-----		-----

As always, assuming all variables initially zero.  ;-)

> 	x = a;		y = b;		z = c;
> 	mb();		mb();		mb();
> 	b = 1;		c = 1;		a = 1;
> 	assert(x==0 || y==0 || z==0);

1.	On CPU 0, either x=a sees CPU 2's a=1 (and by P2b sees z=c and sets
	x==1) or does not (and thus might see either z=1 or z=0, but
	sets x==0).

2.	On CPU 2, z=c might see CPU 1's c=1 (and would by P2b also see
	y=b, but it does not look).

3.	CPU 1's situation is similar to that of CPU 2.

So, yes, some other principle would be required if we wanted to prove that
the assertion always succeeded.  Do we need this assertion to succeed?
(Sure, it would be a bit mind-bending if it were permitted to fail,
but that would not be unheard of when dealing with memory barriers.)
One litmus test is "would assertion failure break normal locking?".
So, let's apply that test.

However, note that the locking sequence differs significantly from the
locking scenario that drove memory ordering on many CPUs -- in the locking
scenario, the lock variable itself would be able to make use of P1.
To properly use locking, we end up with something like the following,
all variables initially zero:

	CPU 0		CPU 1		CPU 2
	-----		-----		-----
	testandset(l)	testandset(l)	testandset(l)
	mb()		mb()		mb()
	x = a;		y = b;		z = c;
	mb()		mb()		mb()
	clear(l)	clear(l)	clear(l)
	testandset(l)	testandset(l)	testandset(l)
	mb()		mb()		mb()
	b = 1;		c = 1;		a = 1;
	mb()		mb()		mb()
	clear(l)	clear(l)	clear(l)
	assert(x==0 || y==0 || z==0);

The key additional point is that all CPUs see the series of values
taken on by the lockword "l".  The load implied by a given testandtest(),
other than the first one, must see the store implied by the prior clear().
So far, nothing different.  But let's take a look at the ordering 1, 2, 0.

At the handoff from CPU 1 to CPU 2, CPU 2 has seen CPU 1's clear(l), and
thus must see CPU 1's assignment to y (by P2b).  At the handoff from
CPU 2 to CPU 0, again, CPU 0 has seen CPU 2's clear(l), thus CPU 2's
assignment to z.  However, because "l" is a single variable, we can
now use P1, so that CPU 0 has also seen the effect of CPU 1's earlier
clear(l), and thus also CPU 1's y=b.  Continuing this analysis shows that
the assertion always succeeds in this case.

A simpler sequence illustrating this is as follows:

	CPU 0		CPU 1		CPU 2		CPU 3
	-----		-----		-----		-----
	a = 1		while (b < 1);	while (b < 2);	y = c;
	mb()		mb()		mb();		mb();
	b = 1		b = 2;		c = 1;		x = a;
							assert(y == 0 || x == 1)

The fact that we have the single variable "b" tracing through this
sequence allows P1 to be applied.

So, is there a burning need for the assertion in your original example
to succeed?  If not, fewer principles allows Linux to deal with a larger
variety of CPUs.

> 	CPU 0		CPU 1
> 	-----		-----

Just to be obnoxious, again noting all variables initially zero.  ;-)

> 	x = a;		while (b == 0) ;
> 	mb();		a = 1;
> 	b = 1;
> 	assert(x==0);

Yep, here you are relying on a control dependency, and control dependencies
are not recognized by the principles.  And, possibly, also not by some
CPUs...

The fix would be to insert an mb() just after CPU 1's "while" loop.

> I suspect your scheme can't handle either of these.  In fact, I rather
> suspect that the "partial ordering" approach is fundamentally incapable of
> generating all possible correct deductions about memory access
> requirements, and that something more like my "every action happens at a
> specific time" approach is necessary.  That is, after all, what led me to
> consider it in the first place.

Agreed, these assertions cannot be proven using the principles outlined
above.  Is this necessarily bad?  In other words, are there real situations
where we need these assertions to hold, and do all CPUs really meet them?

> > > In any case, it is important to distinguish carefully between the two
> > > classes of effects caused by memory barriers:
> > > 
> > > 	They prevent CPUs from reordering certain types of instructions;
> > > 
> > > 	They cause certain loads to obtain the results of certain stores.
> > > 
> > > The first is more of an effect on the CPUs whereas the second is more
> > > of an effect on the caches.
> > 
> > From where I sit, the second is the architectural constraint, while the
> > first is implementation-specific.  So I am very concerned about the
> > second, but worried only about the first as needed to give examples.
> 
> It's true that this distinction depends very much on the system design.  
> For the model where CPUs send requests to caches which then carry them 
> out, the first effect is quite important.
> 
> 
> > > There are other reasons for a write not becoming visible besides being
> > > indefinitely delayed.  It could be masked entirely by a separate write.
> > 
> > OK.  I was assuming that there was no such separate write.  After all,
> > you didn't show it on your diagram.
> 
> I had mentioned the possibility in the text earlier.  Something like this:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	a = 0;	// Suppose this gets hung up in a store buffer
> 		// for an indefinite length of time.  Then later...
> 
> 		// Here's where the standard example starts
> 	y = b;			a = 1;
> 	rmb();			wmb();
> 	x = a;			b = 1;
> 	assert(!(y==1 && x==0));	// Might fail
> 
> It's a matter of boundary conditions.  So far the only stated boundary
> condition has been that initially all variables are equal to 0.  There has
> also been an unstated condition that there are no writes to the variables
> during the time period in question other than the ones shown in the
> example, whether by these CPUs or any others.

Touche on my failing to cover all the boundary conditions!  ;-)

> In the example above, the boundary conditions are all satisfied.  It's
> still true that a is initially equal to 0, and the first line above is
> supposed to execute before the time period in question for the standard
> example.  Neverthless, the standard example fails.
> 
> Some stronger boundary condition is needed.  Something along the lines of: 
> All writes to the variables preceding the time period in question have 
> completed when the example starts.  That ought to be sufficient to 
> guarantee that each of the writes will become visible eventually to the 
> other CPU.

Or: "there are no stores other than those shown in the example".

> > So one approach would be to describe the abstract ordering principles,
> > show how they work in code snippets, and then give a couple "bookend"
> > examples of hardware being creative about adhering to these principles.
> > 
> > Seem reasonable?
> 
> Yes.

Sounds good!

							Thanx, Paul
