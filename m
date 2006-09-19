Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWISSPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWISSPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWISSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:15:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42450 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030310AbWISSPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:15:35 -0400
Date: Tue, 19 Sep 2006 11:16:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060919181626.GF1310@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060919004750.GJ1294@us.ibm.com> <Pine.LNX.4.44L0.0609191131140.22042-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609191131140.22042-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 12:04:15PM -0400, Alan Stern wrote:
> On Mon, 18 Sep 2006, Paul E. McKenney wrote:
> 
> > Restating (and renumbering) the principles, all assuming no other stores
> > than those mentioned, assuming no aliasing among variables, and assuming
> > that each store changes the value of the target variable:
> > 
> > (P0):	Each CPU sees its own stores and loads as occurring in program
> > 	order.
> > 
> > (P1):	If each CPU performs a series of stores to a single shared variable,
> > 	then the series of values obtained by the a given CPUs stores and
> > 	loads must be consistent with that obtained by each of the other
> > 	CPUs.  It may or may not be possible to deduce a single global
> > 	order from the full set of such series.
> 
> Suppose three CPUs respectively write the values 1, 2, and 3 to a single 
> variable.  Are you saying that some CPU A might see the values 1,2 (in 
> that order), CPU B might see 2,3 (in that order), and CPU C might see 3,1 
> (in that order)?  Each CPU's view would be consistent with each of the 
> others but there would not be any global order.

Right...  Good catch!!!

> Somehow I don't think that's what you intended.  In general the actual
> situation is much messier, with some writes masking others for some CPUs 
> in such a way that whenever two CPUs both see the same two writes, they 
> see them in the same order.  Is that all you meant to say?

I did indeed intend to say that there should be at least one global
ordering consistent with all the serieses of values.  How about the
following?

(P1):	If each CPU performs a series of stores to a single shared variable,
	then the series of values obtained by the a given CPUs stores
	and loads must be consistent with that obtained by each of the
	other CPUs.  It may or may not be possible to deduce a single
	global order from the full set of such series, however, there
	will be at least one global order that is consistent with each
	CPU's observed series of values.

> > (P2a):	If two stores to A and B are ordered on CPU 0, and two loads from
> > 	B and A are ordered on CPU 1, and if CPU 1's load from B sees
> > 	CPU 0's store to B, then CPU 1's load from A must see CPU 0's
> > 	store to A.
> > 
> > (P2b):	If a load from A is ordered before a store to B on CPU 0, and a
> > 	load from B is ordered before a store to A on CPU 1, then if
> > 	CPU 1's load from B sees CPU 0's store to B, then CPU 0's load
> > 	from A cannot see CPU 1's store to A.
> > 
> > (P2c):	If a load from A is ordered before a store to B on CPU 0, and a
> > 	store to B is ordered before a store to A on CPU 1, and if CPU 0's
> > 	load from A gives the value stored to A by CPU 1, then CPU 1's
> > 	store to B must be ordered before CPU 0's store to B, so that
> > 	the final value of B is that stored by CPU 0.
> 
> Implicit in P2a and P2b is that events can be ordered only if they all
> take place on the same CPU.  Now P2c introduces the idea of ordering two 
> events that occur on different CPUs.  This sounds to me like it's heading 
> for trouble.
> 
> You probably could revise P2c slightly and then be happy with P2[a-c].  
> They wouldn't be complete, although they might be adequate for all normal
> uses of memory barriers.

Good point -- perhaps I should just drop P2c entirely.  I am running it by
some CPU architects to get their thoughts on it.  But if we don't need it,
we should not specify it.  Keep Linux portable!!!  ;-)

> > > You only considered actions by two CPUs, and you only considered orderings
> > > induced by the memory barriers.  What about interactions among multiple
> > > CPUs or orderings caused by control dependencies?  Two examples:
> > > 
> > > 	CPU 0		CPU 1		CPU 2
> > > 	-----		-----		-----
> > 
> > As always, assuming all variables initially zero.  ;-)
> > 
> > > 	x = a;		y = b;		z = c;
> > > 	mb();		mb();		mb();
> > > 	b = 1;		c = 1;		a = 1;
> > > 	assert(x==0 || y==0 || z==0);
> > 
> > 1.	On CPU 0, either x=a sees CPU 2's a=1 (and by P2b sees z=c and sets
> > 	x==1) or does not (and thus might see either z=1 or z=0, but
> > 	sets x==0).
> > 
> > 2.	On CPU 2, z=c might see CPU 1's c=1 (and would by P2b also see
> > 	y=b, but it does not look).
> > 
> > 3.	CPU 1's situation is similar to that of CPU 2.
> > 
> > So, yes, some other principle would be required if we wanted to prove that
> > the assertion always succeeded.  Do we need this assertion to succeed?
> > (Sure, it would be a bit mind-bending if it were permitted to fail,
> > but that would not be unheard of when dealing with memory barriers.)
> > One litmus test is "would assertion failure break normal locking?".
> > So, let's apply that test.
> > 
> > However, note that the locking sequence differs significantly from the
> > locking scenario that drove memory ordering on many CPUs -- in the locking
> > scenario, the lock variable itself would be able to make use of P1.
> > To properly use locking, we end up with something like the following,
> > all variables initially zero:
> > 
> > 	CPU 0		CPU 1		CPU 2
> > 	-----		-----		-----
> > 	testandset(l)	testandset(l)	testandset(l)
> > 	mb()		mb()		mb()
> > 	x = a;		y = b;		z = c;
> > 	mb()		mb()		mb()
> > 	clear(l)	clear(l)	clear(l)
> > 	testandset(l)	testandset(l)	testandset(l)
> > 	mb()		mb()		mb()
> > 	b = 1;		c = 1;		a = 1;
> > 	mb()		mb()		mb()
> > 	clear(l)	clear(l)	clear(l)
> > 	assert(x==0 || y==0 || z==0);
> > 
> > The key additional point is that all CPUs see the series of values
> > taken on by the lockword "l".  The load implied by a given testandtest(),
> > other than the first one, must see the store implied by the prior clear().
> > So far, nothing different.  But let's take a look at the ordering 1, 2, 0.
> > 
> > At the handoff from CPU 1 to CPU 2, CPU 2 has seen CPU 1's clear(l), and
> > thus must see CPU 1's assignment to y (by P2b).  At the handoff from
> > CPU 2 to CPU 0, again, CPU 0 has seen CPU 2's clear(l), thus CPU 2's
> > assignment to z.  However, because "l" is a single variable, we can
> > now use P1, so that CPU 0 has also seen the effect of CPU 1's earlier
> > clear(l), and thus also CPU 1's y=b.  Continuing this analysis shows that
> > the assertion always succeeds in this case.
> > 
> > A simpler sequence illustrating this is as follows:
> > 
> > 	CPU 0		CPU 1		CPU 2		CPU 3
> > 	-----		-----		-----		-----
> > 	a = 1		while (b < 1);	while (b < 2);	y = c;
> > 	mb()		mb()		mb();		mb();
> > 	b = 1		b = 2;		c = 1;		x = a;
> > 							assert(y == 0 || x == 1)
> > 
> > The fact that we have the single variable "b" tracing through this
> > sequence allows P1 to be applied.
> 
> Isn't it possible that the write to c become visible on CPU 3 before the
> write to a?  In fact, isn't this essentially the same as one of the 
> examples in your manuscript?

No clue.  But I certainly didn't get this example right.  How about
the following instead?

	CPU 0		CPU 1		CPU 2
	-----		-----		-----
	a = 1		while (l < 1);	z = l;
	mb();		b = 1;		mb();
	l = 1		mb();		y = b;
			l = 2;		x = a;
					assert(l != 2 || (x == 1 && y == 1));

Here "l" is standing in for the lock variable -- if we acquire the lock,
we must see all the stores from all preceding critical sections for
that lock.  A similar example would show that any stores CPU 2 executes
after its mb() cannot affect any loads that CPUs 0 and 1 executed prior
to their mb()s.

> > So, is there a burning need for the assertion in your original example
> > to succeed?  If not, fewer principles allows Linux to deal with a larger
> > variety of CPUs.
> > 
> > > 	CPU 0		CPU 1
> > > 	-----		-----
> > 
> > Just to be obnoxious, again noting all variables initially zero.  ;-)
> > 
> > > 	x = a;		while (b == 0) ;
> > > 	mb();		a = 1;
> > > 	b = 1;
> > > 	assert(x==0);
> > 
> > Yep, here you are relying on a control dependency, and control dependencies
> > are not recognized by the principles.  And, possibly, also not by some
> > CPUs...
> 
> Not recognizing a control dependency like this would be tantamount to 
> doing a speculative write.  Any CPU indulging in such fancies isn't likely 
> to survive very long.

You might well be correct, though I would want to ask an Alpha expert.
In any case, there are a number of CPUs that do allow speculative -reads-
past control dependencies.  My fear is that people will over-generalize
the "can't do speculative writes" lesson into "cannot speculate
past a conditional branch".  So I would be OK saying that a memory
barrier is required in the above example -- but would be interested
in counter-examples where such code is desperately needed, and the
overhead of a memory barrier cannot be tolerated.

> > The fix would be to insert an mb() just after CPU 1's "while" loop.
> > 
> > > I suspect your scheme can't handle either of these.  In fact, I rather
> > > suspect that the "partial ordering" approach is fundamentally incapable of
> > > generating all possible correct deductions about memory access
> > > requirements, and that something more like my "every action happens at a
> > > specific time" approach is necessary.  That is, after all, what led me to
> > > consider it in the first place.
> > 
> > Agreed, these assertions cannot be proven using the principles outlined
> > above.  Is this necessarily bad?  In other words, are there real situations
> > where we need these assertions to hold, and do all CPUs really meet them?
> 
> As far as real situations are concerned, you could probably get away with 
> nothing more than P2a and P2b, maybe also P2c.  Gaining a clear and 
> precise understanding is a different story, though.

Yep, I suspect that it might be OK to ditch P2c from a "Linux absolutely
relies on this" viewpoint.  "But it seems so harmless!"  ;-)

And I agree that examples drawn from real
hardware will be helpful.  Or even examples drawn from imaginary "hostile"
hardware.  ;-)

> For instance, it's not clear to what extent the "ordering" in your scheme 
> is transitive.  Part of the problem is that the events you order are 
> individual loads and stores.  There's no acknowledgement of the fact that 
> a single store can become visible to different CPUs at different times (or 
> not at all).

I was trying to get at this with the "see the value stored" verbiage.
Any thoughts on ways to make this more clear?  Perhaps have the principles
first, followed by longer explanations and examples.

And transitivity is painful -- the Alpha "dereferencing does not imply
ordering" example being a similar case in point!

> I would much prefer to see an analysis where the primitive notions include 
> things like "This store becomes visible to that CPU before this load 
> occurs".  It would bear a closer correspondence to what actually happens 
> in the hardware.

I will think on better wording.

							Thanx, Paul
