Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946489AbWJSUzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946489AbWJSUzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946491AbWJSUzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:55:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40203 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1946487AbWJSUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:55:17 -0400
Date: Thu, 19 Oct 2006 16:55:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061019192158.GB2265@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610191557220.8492-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Paul E. McKenney wrote:

> > I see no reason to think the control dependency in CPU 1's assignment to B 
> > is any weaker than a memory barrier.
> 
> I am assuming that you have in mind a special restricted memory barrier
> that applies only to the load of A, and not necessarily to any other
> preceding operations.  Otherwise, these two code sequences would be
> equivalent, and they are not (as usual, all variables initially zero):
> 
> 	CPU 0, Sequence 1	CPU 0, Sequence 2	CPU 1
> 
> 	A=1			A=1			while (C==0);
> 	while (B==0);		while (B==0);		smp_mb();
> 	C=1			smp_mb();		assert(A==1);
> 				C=1
> 
> In sequence 1, CPU 1's assertion can fail.  Not so with sequence 2.

Yes, that's a very good point.  Indeed, I meant a restricted memory
barrier applying only to the two accesses involved.  In the same sort of
way rmb() is a restricted memory barrier, applying only to pairs of
loads.

> Regardless of your definition of your posited memory barrier corresponding
> to the control dependency, a counter example:
> 
> 	CPU 1			CPU 2
> 
> 	A=1;
> 	...
> 	while (A==0);		while (B==0);
> 	B=1			smp_mb()
> 				assert(A==1) <fails>
> 
> Here, placing an smp_mb() after the "while (A==0)" does make a difference.
> 
> Degenerate, perhaps, given that the same CPU is assigning and while-ing,
> but so it goes.

The smp_mb() does make a difference.  But it doesn't invalidate my notion
of a dependency acting as a restricted memory barrier.  The notion allows
you to conclude from this example only that ld_1(A) >v ld_2(A), which is
meaningless (using your convention for >v).  It doesn't allow you to
conclude st_1(A) >v ld_2(A).

> Even assuming a special restricted memory barrier, the example of DEC
> Alpha and pointer dereferencing gives me pause.  Feel free to berate
> me for this, as you have done in the past.  ;-)

Ah, interesting comment.  With the Alpha and pointer dereferencing, the
problems arise because of failure to respect a data dependency between two
loads.  Here I am talking about a dependency between a load and a
subsequent store, so it isn't the same thing at all.  Failure to respect
this kind of dependency would mean the CPU was writing a value before it
knew what value to write (or whether to write it, or where to write it).  
Not even the most aggressively speculative machine will do that!

> Seriously, my judgement of this would depend on exactly what part of
> the smp_mb() semantics you are claiming for the control dependency.
> I do not believe that we could make progress without appealing to a
> specific implementation, so I would rather ignore control dependencies,
> at least for non-MMIO accesses.  MMIO would be another story altogether.

What I'm claiming is exactly what was written in an earlier email:

	st(A) < st(B) >v ac(B) < ac(A)  implies  st(A) >v ac(A), and

	ld(A) < st(B) >v ac(B) < st(A)  implies  st(A) !>v ld(A).

Here I'm using your convention for >v, and < indicates either an explicit
barrier between two accesses or a dependency between a load and a later
store.

> > "Sequentially precedes" means that the system behaves as though there were 
> > a memory barrier between the two accesses.
> 
> OK.  As noted above, if I were to interpret "a memory barrier" as really
> being everything entailed by smp_mb(), I disagree with your statement in an
> earlier email stating:
> 
> 	Similarly, in the program "if (A) B = 2;" the load(A) sequentially
> 	precedes the store(B) -- thanks to the dependency or (if you
> 	prefer) the absence of speculative stores.
> 
> However, I don't believe that is what you mean by "a memory barrier" in
> this case -- my guess again is that you mean a special memory barrier that
> applies only the the load of A in one direction, but that applies to
> everything following the load in the other direction.

It applies to the load of A in one direction and to all later stores in
the other direction.  Not to later loads.


> I would use ">p" for the program-order relationship, and probably something
> like ">b" for the memory-barrier relationship.  There are other orderings,
> including the control-flow ordering discussed earlier, data dependencies,
> and so on.

> The literature is quite inconsistent.  The DEC Alpha manual takes your
> approach, while Gharachorloo's dissertation takes my approach.  Not to
> be outdone, Steinke and Nutt's JACM paper (written long after the other
> two) uses different directions for different types of orderings!!!
> See http://arxiv.org/PS_cache/cs/pdf/0208/0208027.pdf, page 49,
> Definitions A.5, A.6 on the one hand and Definition A.7 on the other.  ;-)

> This is the connotation conflict.  For you, it is confusing to write
> "A > B" when A precedes B.  For me, it is confusing to write "st < ld"
> when data flows from the "st" to the "ld".  So, the only way to resolve
> this is to avoid use of ">" like the plague!

Okay, let's change the notation.  I don't like <v very much.  Let's not
worry about potential confusion with implication signs, and use

	1:st(A) -> 2:st(A)

to indicate that 1:st occurs earlier than 2:st in the global ordering of 
all stores to A.  And let's use

	3:st(B) -> 4:ld(B)

to mean that 4:ld returned the value either of 3:st or of some other store 
to B occuring later in the global ordering of all such stores.  Lastly, 
let's use

	5:ac(A) +> 6:ac(B)

to indicate either that the two accesses are separated by a memory barrier 
or that 5:ac is a load and 6:ac is a dependent store (all occurring on the 
same CPU).


> And in a cache-coherent system, there must be.  Or, more precisely,
> there must not be different sequences of loads that indicate inconsistent
> orderings of stores to a given single variable.  If the system can
> prove that there are no concurrent loads during a given period of
> time, I guess it would be within its rights to ditch cache coherence
> for that variable during that time...

What about indirect indications of inconsistency?  See my example below.

> > (BTW, can you explain the difference between "cache coherent" and "cache 
> > consistent"?  I never quite got it straight...)
> 
> "Cache coherent" is the preferred term, though "cache consistent" is
> sometimes used as a synonym.  If you want to be painfully correct, you
> would say "cache coherent" when talking about stores to a single variable,
> and "memory consistency model" when talking about ordering of accesses
> to multiple variables.

Hmmm.  Then what about "DMA coherent" vs. "DMA consistent"?


> > The analogy breaks down for pairs of stores.  If stores are blind then 
> > they can't see other stores -- but we need them to.
> 
> I would instead say that you need to execute some loads in order to be
> able to see the effects of your pairs of stores.

Consider this example:

	CPU 0			CPU 1
	-----			-----
	A = 1;			B = 2;
	mb();			mb();
	B = 1;			X = A + 1;
	...
	assert(!(B==2 && X==1));

The assertion cannot fail.  But to prove it in our formalism requires 
writing  st_0(B=1) -> st_1(B=2).  In other words, CPU 1's store to B sees 
(i.e., overwrites) CPU 0's store to B.

Alan

