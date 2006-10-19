Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946395AbWJSTVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946395AbWJSTVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWJSTVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:21:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15328 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422795AbWJSTVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:21:05 -0400
Date: Thu, 19 Oct 2006 12:21:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061019192158.GB2265@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061018230159.GJ1902@us.ibm.com> <Pine.LNX.4.44L0.0610191024140.6471-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610191024140.6471-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 12:44:28PM -0400, Alan Stern wrote:
> On Wed, 18 Oct 2006, Paul E. McKenney wrote:
> 
> > > > > Basically "sequentially precedes" means that any other CPU using the
> > > > > appropriate memory barriers will observe the accesses apparently occurring
> > > > > in this order.
> > > > 
> > > > Your first example in the previous paragraph fits the description.
> > > > The second does not, as illustrated by the following scenario:
> > > > 
> > > > 	CPU 0			CPU 1			CPU 2
> > > > 
> > > > 	A=1			while (B==0);		while (C==0);
> > > > 	smp_mb()		C=1			smp_mb()
> > > > 	B=1						assert(A==1) <fails>
> > > 
> > > In what way is this inconsistent with my second example?
> > 
> > I believe that it -is- in fact consistent with your second example,
> > though more elaborate than needed.  But it doesn't matter, in the
> > following simpler example, the assertion also fails:
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 
> > 	A=1			while (A==0);		while (B==0);
> > 				B=1			smp_mb()
> > 							assert(A==1) <fails>
> 
> Again, there's nothing wrong with this.  Writing the example out 
> symbolically gives:
> 
> 	st_0(A=1) <v ld_1(A) < st_1(B=1) <v ld_2(B) < ld_2(A)
> 
> You seem to think that this implies ld_1(A) <v ld_2(A),

No, I thought that -you- thought that this implication held.  :-/

>                                                         from which you 
> derive st_0(A=1) <v ld_2(A).  But the reasoning is incorrect, because
> 
> 	ld_1(A) <v ld_2(A)
>
> is an invalid expression.  A load is never allowed to appear on the left
> side of <v.

Yep, you have thoroughly destroyed that particular strawman.  ;-)

> And again, it wouldn't matter if you inserted smp_mb() before CPU 1's
> store to B.  The assertion could fail anyway, and for the same reason.

This I agree with.

>                                                                         So 
> I see no reason to think the control dependency in CPU 1's assignment to B 
> is any weaker than a memory barrier.

I am assuming that you have in mind a special restricted memory barrier
that applies only to the load of A, and not necessarily to any other
preceding operations.  Otherwise, these two code sequences would be
equivalent, and they are not (as usual, all variables initially zero):

	CPU 0, Sequence 1	CPU 0, Sequence 2	CPU 1

	A=1			A=1			while (C==0);
	while (B==0);		while (B==0);		smp_mb();
	C=1			smp_mb();		assert(A==1);
				C=1

In sequence 1, CPU 1's assertion can fail.  Not so with sequence 2.

Regardless of your definition of your posited memory barrier corresponding
to the control dependency, a counter example:

	CPU 1			CPU 2

	A=1;
	...
	while (A==0);		while (B==0);
	B=1			smp_mb()
				assert(A==1) <fails>

Here, placing an smp_mb() after the "while (A==0)" does make a difference.

Degenerate, perhaps, given that the same CPU is assigning and while-ing,
but so it goes.

Even assuming a special restricted memory barrier, the example of DEC
Alpha and pointer dereferencing gives me pause.  Feel free to berate
me for this, as you have done in the past.  ;-)

Seriously, my judgement of this would depend on exactly what part of
the smp_mb() semantics you are claiming for the control dependency.
I do not believe that we could make progress without appealing to a
specific implementation, so I would rather ignore control dependencies,
at least for non-MMIO accesses.  MMIO would be another story altogether.

> > Perhaps I don't understand what you mean by "sequentially precedes"
> > in your earlier paragraph -- but you did say that "any other CPU using
> > the appropriate memory barriers will observe the accesses apparently
> > occurring in this order".  One interpretation might be that CPU 2's
> > load of A temporally follows CPU 1's load of A.  This would of course
> > not prevent CPU 2 from seeing an "earlier" value of A than did CPU 1,
> > as we have both noted many times.  ;-)
> 
> "Sequentially precedes" means that the system behaves as though there were 
> a memory barrier between the two accesses.

OK.  As noted above, if I were to interpret "a memory barrier" as really
being everything entailed by smp_mb(), I disagree with your statement in an
earlier email stating:

	Similarly, in the program "if (A) B = 2;" the load(A) sequentially
	precedes the store(B) -- thanks to the dependency or (if you
	prefer) the absence of speculative stores.

However, I don't believe that is what you mean by "a memory barrier" in
this case -- my guess again is that you mean a special memory barrier that
applies only the the load of A in one direction, but that applies to
everything following the load in the other direction.

> > We are using "<" backwards from each other.  You are using it as if
> > you were comparing time values (which I guess I should have anticipated
> > given your temporal viewpoint), while I was using it to indicate flow
> > of data (for ">v") or flow of control (for ">p").  In my notation,
> > st > ld makes sense (the store's data flows to the load), in yours it
> > would instead indicate that the store happened after the load.  I think.
> 
> In my notation "<" means "sequentially precedes" and ">" would therefore
> mean "sequentially follows".  So "st > ld" would indicate that the store
> and the load both occurred on the same CPU, with the load preceding the
> store in the object code, and there was either a dependency or an explicit
> memory barrier between them.
> 
> There isn't a direct temporal implication, only an implication about the
> order of statements in the object code.  The CPU would be free to carry
> out the two statements at any times and in any order it wants --
> backwards, forwards, or upside down -- "st > ld" isn't concerned with
> absolute or relative time values.  It only cares about the flow of
> execution.

Which is why we need to use a notation that very clearly denotes flow,
without the temporal-ordering connotation that ">" has to many people
(me in particular).

> > My guess is that you are using "<" to indicate presence of a memory barrier.
> 
> Approximately.  It indicates that the behavior is the same as if a memory
> barrier were present.  But it also indicates program ordering.  Given:
> 
> 	A = 1; mb(); B = 2;
> 
> Then we have st(A) < st(B) but not st(B) < st(A), because of the order
> of the two statements in the object code.  Perhaps you would want to 
> write it as st(A) >p st(B).

I would use ">p" for the program-order relationship, and probably something
like ">b" for the memory-barrier relationship.  There are other orderings,
including the control-flow ordering discussed earlier, data dependencies,
and so on.

> > Perhaps I should use ">>v", analogous to the C++ I/O operator, to 
> > emphasize that I am not comparing things.  Would that help?
> > 
> > Another alternative would be "->v", but that could be confused with
> > the implication operator.
> 
> Well, we can write our orderings using either < or > as we please, just so
> long as we are consistent.  BUT...  Considering that there is a strong
> intuitive association here with the flow of time, I think you would end up
> only confusing people with your convention:
> 
> 	We want to emphasize that the <v operator is not directly
> 	connected with the flow of time.  Hence we will write
> 	"x <v y" to mean that x logically follows y.
> 
> I don't think people will go for this.  :-)

The literature is quite inconsistent.  The DEC Alpha manual takes your
approach, while Gharachorloo's dissertation takes my approach.  Not to
be outdone, Steinke and Nutt's JACM paper (written long after the other
two) uses different directions for different types of orderings!!!
See http://arxiv.org/PS_cache/cs/pdf/0208/0208027.pdf, page 49,
Definitions A.5, A.6 on the one hand and Definition A.7 on the other.  ;-)

> > We are still disagreeing on the definition of "<v".  I could try writing
> > it as ld_1(A) <<v st_0(a=1) to make it clear that I am not comparing
> > timestamps.
> 
> It is already clear.  You don't need to do anything special to emphasize
> it.  We will explain that <v coincides only roughly with any actual time
> ordering.

Given the disagreement between the two of us, to say nothing of the
different notations used in the literature, I cannot agree that it
is clear.  And this stuff is confusing enough without conflicting
connotations!  ;-)

> > > It's one thing to say you don't know the order of stores.  It's another 
> > > thing to say that there _is_ no order -- especially if you're going to use 
> > > the "<v" notation to implicitly impose such an order!
> > 
> > ">v" only applies to single variables, at least in my viewpoint.
> 
> That's what I've been talking about.  By using ">v", you are implicitly 
> saying that there is a global order of all stores to a single variable.

And in a cache-coherent system, there must be.  Or, more precisely,
there must not be different sequences of loads that indicate inconsistent
orderings of stores to a given single variable.  If the system can
prove that there are no concurrent loads during a given period of
time, I guess it would be within its rights to ditch cache coherence
for that variable during that time...

> > > So maybe what you're claiming is that the stores to a single variable _do_ 
> > > have a global order at runtime, even though we might not know what it is, 
> > > and the view each CPU has is always a suborder of that global order.  (And 
> > > of course there is no fixed relation on how the global orders of stores to 
> > > two separate variables inter-relate, unless it is enforced by memory 
> > > barriers.)
> > > 
> > > Does this claim always make sense, even in a hierarchical cache system?
> > 
> > For a single variable in a cache-coherent system, yes.  Because if this
> > claim does not hold, then by definition, the system is not cache-coherent.
> 
> Okay, that's fine.  In a cache-coherent system, all stores to a single
> variable fall into a global ordering which has a strong temporal nature
> (if two stores are separated by a sufficiently long time, the earlier
> store is bound to be ordered before the later store).  In this situation
> it certainly is natural to think of the ordering as a temporal one, even
> though we know this is not exactly true.  And I think it's confusing to
> say that an earlier event is > a later event.

This is the connotation conflict.  For you, it is confusing to write
"A > B" when A precedes B.  For me, it is confusing to write "st < ld"
when data flows from the "st" to the "ld".  So, the only way to resolve
this is to avoid use of ">" like the plague!

> (BTW, can you explain the difference between "cache coherent" and "cache 
> consistent"?  I never quite got it straight...)

"Cache coherent" is the preferred term, though "cache consistent" is
sometimes used as a synonym.  If you want to be painfully correct, you
would say "cache coherent" when talking about stores to a single variable,
and "memory consistency model" when talking about ordering of accesses
to multiple variables.

> > > Basically yes, although I'm not sure how a load manages to be atomic.  
> > > Maybe if it's part of an atomic exchange or something like that.
> > 
> > Yes, an atomic exchange is indeed one way to implement a lock-acquisition
> > primitive, which is the case that requires transitivity.
> > 
> > Perhaps this could be denoted by atomic\_inc_1(A) or some such.
> 
> Or at_1(A+=1).

I do like your suggestion quite a bit better than I like mine!

> > > > Does this "sees"/"is seen by" nomenclature seem more reasonable?
> > > > Or perhaps "visibility includes"/"visible to"?  Or keep "sees"/"seen by"
> > > > and use "<s"/">s" to adjust the mneumonic?
> > > 
> > > I'm not keen on either one.  Does it make sense to say one store is
> > > visible to (or is seen by) another store?  Maybe...  But "comes before"  
> > > seems more natural.  Especially if you're assuming the existence of a
> > > global ordering on these stores.
> > 
> > In your time-based viewpoint, I would guess that "comes before" would
> > be quite natural -- and this makes complete sense for MMIO accesses,
> > as far as I can tell (never have done much in the way of parallel device
> > drivers, though).  For memory-based data structures, as we have discussed,
> > there are cases where taking a time-based approach can be misleading.
> > Or, in my case, can lead to bugs.  ;-)
> 
> The word "before" doesn't necessarily mean the same thing as "earlier in
> time".  Here it means "lower in the global ordering of all stores to this
> variable".
> 
> You're too hung up on this idea that something which _looks_ like a
> temporal ordering actually _must be_ a temporal ordering.  Not at all --
> it may resemble one for mnemonic purposes without actually being one.

Perhaps I am to hung up on this, but I came by this particular hangup
honestly!  ;-)

> > > Incidentally, although you haven't mentioned this, it's important never to
> > > state that a load is visible to (or is seen by or comes before) another
> > > access.  In other words, the global ordering of stores for a single
> > > variable doesn't extend to a global ordering of _all_ accesses for that
> > > variable.
> > 
> > Yes.  From my viewpoint (ignoring MMIO), stores are mute and loads
> > are deaf.  So stores can "hear" loads, but not vice versa.  I guess I
> > could make the "sees" analogy work just as well -- in that case stores
> > are blind and loads are invisible, so that loads can see stores, but
> > not vice versa.  And loads can neither see nor hear other loads.
> 
> The analogy breaks down for pairs of stores.  If stores are blind then 
> they can't see other stores -- but we need them to.

I would instead say that you need to execute some loads in order to be
able to see the effects of your pairs of stores.

> > In the MMIO case, a load may be visible to a subsequent store due to
> > changes in device state.  In principle, anyway, it has been awhile since
> > I have looked carefully at device-register specifications, so I have no
> > idea if any real devices do this -- on this, I must defer to you.
> 
> They sometimes do, in rather specialized circumstances.  It isn't very 
> common.

Good to know, thank you!

							Thanx, Paul
