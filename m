Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946218AbWJSQoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946218AbWJSQoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946216AbWJSQoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:44:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:2830 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1946218AbWJSQob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:44:31 -0400
Date: Thu, 19 Oct 2006 12:44:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061018230159.GJ1902@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610191024140.6471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Paul E. McKenney wrote:

> > > > Basically "sequentially precedes" means that any other CPU using the
> > > > appropriate memory barriers will observe the accesses apparently occurring
> > > > in this order.
> > > 
> > > Your first example in the previous paragraph fits the description.
> > > The second does not, as illustrated by the following scenario:
> > > 
> > > 	CPU 0			CPU 1			CPU 2
> > > 
> > > 	A=1			while (B==0);		while (C==0);
> > > 	smp_mb()		C=1			smp_mb()
> > > 	B=1						assert(A==1) <fails>
> > 
> > In what way is this inconsistent with my second example?
> 
> I believe that it -is- in fact consistent with your second example,
> though more elaborate than needed.  But it doesn't matter, in the
> following simpler example, the assertion also fails:
> 
> 	CPU 0			CPU 1			CPU 2
> 
> 	A=1			while (A==0);		while (B==0);
> 				B=1			smp_mb()
> 							assert(A==1) <fails>

Again, there's nothing wrong with this.  Writing the example out 
symbolically gives:

	st_0(A=1) <v ld_1(A) < st_1(B=1) <v ld_2(B) < ld_2(A)

You seem to think that this implies ld_1(A) <v ld_2(A), from which you 
derive st_0(A=1) <v ld_2(A).  But the reasoning is incorrect, because

	ld_1(A) <v ld_2(A)

is an invalid expression.  A load is never allowed to appear on the left
side of <v.

And again, it wouldn't matter if you inserted smp_mb() before CPU 1's
store to B.  The assertion could fail anyway, and for the same reason.  So 
I see no reason to think the control dependency in CPU 1's assignment to B 
is any weaker than a memory barrier.


> Perhaps I don't understand what you mean by "sequentially precedes"
> in your earlier paragraph -- but you did say that "any other CPU using
> the appropriate memory barriers will observe the accesses apparently
> occurring in this order".  One interpretation might be that CPU 2's
> load of A temporally follows CPU 1's load of A.  This would of course
> not prevent CPU 2 from seeing an "earlier" value of A than did CPU 1,
> as we have both noted many times.  ;-)

"Sequentially precedes" means that the system behaves as though there were 
a memory barrier between the two accesses.

> We are using "<" backwards from each other.  You are using it as if
> you were comparing time values (which I guess I should have anticipated
> given your temporal viewpoint), while I was using it to indicate flow
> of data (for ">v") or flow of control (for ">p").  In my notation,
> st > ld makes sense (the store's data flows to the load), in yours it
> would instead indicate that the store happened after the load.  I think.

In my notation "<" means "sequentially precedes" and ">" would therefore
mean "sequentially follows".  So "st > ld" would indicate that the store
and the load both occurred on the same CPU, with the load preceding the
store in the object code, and there was either a dependency or an explicit
memory barrier between them.

There isn't a direct temporal implication, only an implication about the
order of statements in the object code.  The CPU would be free to carry
out the two statements at any times and in any order it wants --
backwards, forwards, or upside down -- "st > ld" isn't concerned with
absolute or relative time values.  It only cares about the flow of
execution.

> My guess is that you are using "<" to indicate presence of a memory barrier.

Approximately.  It indicates that the behavior is the same as if a memory
barrier were present.  But it also indicates program ordering.  Given:

	A = 1; mb(); B = 2;

Then we have st(A) < st(B) but not st(B) < st(A), because of the order
of the two statements in the object code.  Perhaps you would want to 
write it as st(A) >p st(B).


> Perhaps I should use ">>v", analogous to the C++ I/O operator, to 
> emphasize that I am not comparing things.  Would that help?
> 
> Another alternative would be "->v", but that could be confused with
> the implication operator.

Well, we can write our orderings using either < or > as we please, just so
long as we are consistent.  BUT...  Considering that there is a strong
intuitive association here with the flow of time, I think you would end up
only confusing people with your convention:

	We want to emphasize that the <v operator is not directly
	connected with the flow of time.  Hence we will write
	"x <v y" to mean that x logically follows y.

I don't think people will go for this.  :-)

> We are still disagreeing on the definition of "<v".  I could try writing
> it as ld_1(A) <<v st_0(a=1) to make it clear that I am not comparing
> timestamps.

It is already clear.  You don't need to do anything special to emphasize
it.  We will explain that <v coincides only roughly with any actual time
ordering.


> > It's one thing to say you don't know the order of stores.  It's another 
> > thing to say that there _is_ no order -- especially if you're going to use 
> > the "<v" notation to implicitly impose such an order!
> 
> ">v" only applies to single variables, at least in my viewpoint.

That's what I've been talking about.  By using ">v", you are implicitly 
saying that there is a global order of all stores to a single variable.

> > So maybe what you're claiming is that the stores to a single variable _do_ 
> > have a global order at runtime, even though we might not know what it is, 
> > and the view each CPU has is always a suborder of that global order.  (And 
> > of course there is no fixed relation on how the global orders of stores to 
> > two separate variables inter-relate, unless it is enforced by memory 
> > barriers.)
> > 
> > Does this claim always make sense, even in a hierarchical cache system?
> 
> For a single variable in a cache-coherent system, yes.  Because if this
> claim does not hold, then by definition, the system is not cache-coherent.

Okay, that's fine.  In a cache-coherent system, all stores to a single
variable fall into a global ordering which has a strong temporal nature
(if two stores are separated by a sufficiently long time, the earlier
store is bound to be ordered before the later store).  In this situation
it certainly is natural to think of the ordering as a temporal one, even
though we know this is not exactly true.  And I think it's confusing to
say that an earlier event is > a later event.

(BTW, can you explain the difference between "cache coherent" and "cache 
consistent"?  I never quite got it straight...)



> > Basically yes, although I'm not sure how a load manages to be atomic.  
> > Maybe if it's part of an atomic exchange or something like that.
> 
> Yes, an atomic exchange is indeed one way to implement a lock-acquisition
> primitive, which is the case that requires transitivity.
> 
> Perhaps this could be denoted by atomic\_inc_1(A) or some such.

Or at_1(A+=1).


> > > Does this "sees"/"is seen by" nomenclature seem more reasonable?
> > > Or perhaps "visibility includes"/"visible to"?  Or keep "sees"/"seen by"
> > > and use "<s"/">s" to adjust the mneumonic?
> > 
> > I'm not keen on either one.  Does it make sense to say one store is
> > visible to (or is seen by) another store?  Maybe...  But "comes before"  
> > seems more natural.  Especially if you're assuming the existence of a
> > global ordering on these stores.
> 
> In your time-based viewpoint, I would guess that "comes before" would
> be quite natural -- and this makes complete sense for MMIO accesses,
> as far as I can tell (never have done much in the way of parallel device
> drivers, though).  For memory-based data structures, as we have discussed,
> there are cases where taking a time-based approach can be misleading.
> Or, in my case, can lead to bugs.  ;-)

The word "before" doesn't necessarily mean the same thing as "earlier in
time".  Here it means "lower in the global ordering of all stores to this
variable".

You're too hung up on this idea that something which _looks_ like a
temporal ordering actually _must be_ a temporal ordering.  Not at all --
it may resemble one for mnemonic purposes without actually being one.


> > Incidentally, although you haven't mentioned this, it's important never to
> > state that a load is visible to (or is seen by or comes before) another
> > access.  In other words, the global ordering of stores for a single
> > variable doesn't extend to a global ordering of _all_ accesses for that
> > variable.
> 
> Yes.  From my viewpoint (ignoring MMIO), stores are mute and loads
> are deaf.  So stores can "hear" loads, but not vice versa.  I guess I
> could make the "sees" analogy work just as well -- in that case stores
> are blind and loads are invisible, so that loads can see stores, but
> not vice versa.  And loads can neither see nor hear other loads.

The analogy breaks down for pairs of stores.  If stores are blind then 
they can't see other stores -- but we need them to.

> In the MMIO case, a load may be visible to a subsequent store due to
> changes in device state.  In principle, anyway, it has been awhile since
> I have looked carefully at device-register specifications, so I have no
> idea if any real devices do this -- on this, I must defer to you.

They sometimes do, in rather specialized circumstances.  It isn't very 
common.

Alan

