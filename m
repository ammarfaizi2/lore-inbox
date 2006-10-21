Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992766AbWJUA6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992766AbWJUA6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992763AbWJUA6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:58:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47296 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030368AbWJUA6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:58:02 -0400
Date: Fri, 20 Oct 2006 17:59:08 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061021005908.GB1751@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061019224646.GC2265@us.ibm.com> <Pine.LNX.4.44L0.0610201157320.7060-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610201157320.7060-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 12:54:52PM -0400, Alan Stern wrote:
> On Thu, 19 Oct 2006, Paul E. McKenney wrote:
> 
> > Your notion of control-dependency barriers makes sense in an intuitive
> > sense.  Does Linux rely on it, other than for MMIO accesses?
> 
> I'm pretty sure that somewhere I saw some code which looked like it needed
> a memory barrier but didn't have one.  I decided it was okay because of
> exactly this sort of control dependency.  No way to know if it was
> deliberate or merely an oversight.  Don't ask me where that was; I can't
> remember.

There are a number of cases where this sort of code structure is OK,
even without assuming that control dependencies have any memory-ordering
consequences.  But they do have to be taken case by case...

> > > Okay, let's change the notation.  I don't like <v very much.  Let's not
> > > worry about potential confusion with implication signs, and use
> > > 
> > > 	1:st(A) -> 2:st(A)
> > 
> > Would "=>" work, or does that conflict with something else?
> 
> It's okay with me.
> 
> > And the number before the colon is the CPU #, right?
> 
> No, it's an instance label (kind of like a line number).  As we've been 
> doing before.  The CPU number is still a subscript.

When I started actually doing formulas, the use of ":" conflicted with
the logic-expression operator ("for every x there exists y and z such
that...", which turns into upside-down-A x backwards-E y,z colon ...,
at least if I am remembering all this correctly).

So how about having the line number be a second subscript following the
CPU number?

> > > to indicate that 1:st occurs earlier than 2:st in the global ordering of 
> > > all stores to A.  And let's use
> > > 
> > > 	3:st(B) -> 4:ld(B)
> > > 
> > > to mean that 4:ld returned the value either of 3:st or of some other store 
> > > to B occuring later in the global ordering of all such stores.
> > 
> > OK...  Though expressing your English description formally is a bit messy,
> > it does capture a very useful idiom.
> > 
> > > Lastly, let's use
> > > 
> > > 	5:ac(A) +> 6:ac(B)
> > > 
> > > to indicate either that the two accesses are separated by a memory barrier 
> > > or that 5:ac is a load and 6:ac is a dependent store (all occurring on the 
> > > same CPU).
> > 
> > So the number preceding the colon is the value being loaded or stored?
> 
> No, that value goes inside the parentheses.

Got it...

> > Either way, the symbols seem reasonable.  In a PDF, I would probably
> > set a symbol indicating the type of flow over a hollow arrow or something.
> 
> 
> > > Hmmm.  Then what about "DMA coherent" vs. "DMA consistent"?
> > 
> > No idea.  Having worked with systems where DMA did not play particularly
> > nicely with the cache-coherence protocol, they both sound like good things,
> > though.  ;-)
> > 
> > As near as I can tell by looking around, they are synonyms or nearly so.
> 
> I once saw someone draw a distinction between them, but I didn't 
> understand it at the time and now it has faded away.

I do remember some documentation mentioning this, will track it down.

> > > Consider this example:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	A = 1;			B = 2;
> > > 	mb();			mb();
> > > 	B = 1;			X = A + 1;
> > > 	...
> > > 	assert(!(B==2 && X==1));
> > > 
> > > The assertion cannot fail.  But to prove it in our formalism requires 
> > > writing  st_0(B=1) -> st_1(B=2).  In other words, CPU 1's store to B sees 
> > > (i.e., overwrites) CPU 0's store to B.
> 
> I wrote that the assertion cannot fail, but I'm not so sure any more.  
> Couldn't there be a system where CPU 1's statements run before any of CPU 
> 0's writes become visible to CPU 1, but nevertheless the caching hardware 
> decides that CPU 1's write to B "wins"?  More on this below...

The memory barriers require that if the caching hardware decides that
CPU 1's B=2 "wins", then X=A+1 must see CPU 0's A=1.  Now the assertion
could legally see B==2&&X==0, or B==1&&X={0,1,2}, but it cannot legally
see B==2&&X==1 because that would violate the constraints that the
memory barriers are supposed to be enforcing.

> > Alternatively, we could use a notation that states that a given load gets
> > exactly the value from a given store, for example "st ==> ld" as opposed
> > to "st => ld", where there might be an intervening store.
> 
> That's a useful concept.

Especially when defining cache coherence -- need to be able to say that
only stores can change the value, and that any loads between a pair of
stores see the value from the first of the two stores.  This can be done
without ==>, but it is more elaborate.

> > (1)	B==2 -> st_1(B=2) ==> ld_0(B==2)
> > 
> > 	Because there is only one store of 2 into B.
> > 
> > (2)	But st_0(B=1) =p> ld_0(B) -> st_0(B=1) => ld_0(B)
> > 
> > 	Here I use "=p>" to indicate program order, and rely on the
> > 	fact that a CPU must see its own accesses in order.
> 
> Right.
> 
> > (3)	(1) and (2) imply st_0(B=1) => st_1(B=2) ==> ld_0(B==2)
> 
> Yes.  st_0(B=1) => ld_0(B) means that the load must return the value
> either of the st_0 or of some later store.  Since the value returned was
> 2, we know that the store on CPU 1 occurred later than the store on
> CPU 0.
> 
> (By "later" I mean at a higher position according to the global ordering
> of all stores to B.  There doesn't seem to be any good way to express this
> without using time-related words.)

One could say "the store on CPU 1 overwrote that of CPU 0", but this
admittedly gets cumbersome if there is a long sequence of stores.

> > 	So, yes, we do end up saying something about the order of the
> > 	stores, but only indirectly, based on other observations -- in
> > 	this case, program order and direct value sequence.  In other
> > 	words, we can sometimes say things about the order of stores
> > 	even though stores are blind.
> 
> Which was my original point.

OK.  I misunderstood you.

> > (4)	By memory-barrier implication:
> > 
> > 	(a)	st_0(A=1) +> st_0(B=1) &&
> > 	
> > 	(b)	st_1(B=2) +> ld_1(A) &&
> > 	
> > 	(c)	st_0(B=1) => st_1(B=2)
> > 
> > 	-> st_0(A=1) => ld_1(A)
> > 
> > (5)	Since there is only one store to A: st_0(A=1) ==> ld_1(A==1)
> > 
> > (6)	Therefore, X==2 and the assertion cannot fail if B==2.  But
> > 	if the assertion fails, it must be true that B==2, so the
> > 	assertion cannot fail.
> > 
> > Is that more or less what you had in mind?
> 
> Yes it was.
> 
> But now I wonder...  This approach might require too much of memory 
> barriers.  If we have
> 
> 	st(A); mb(); st(B);
> 
> does the memory barrier really say anything about CPUs which never see one 
> or both of those stores?  Or does it say only that CPUs which see both 
> stores will see them in the correct order?

Only that CPUs that see both stores with appropriate use of memory barriers
will see them in the correct order.

> The only way to be certain a CPU sees a store is if it does a load which
> returns the value of that store.  In the absence of such a criterion we
> don't know what really happened.  For example:
> 
> 	CPU 0		CPU 1			CPU 2
> 	-----		-----			-----
> 	A = 1;		while (B < 1) ;		while (B < 2) ;
> 	mb();		mb();			mb();
> 	B = 1;		B = 2;			assert(A==1);
> 
> I put memory barriers in for CPUs 1 and 2 even though they shouldn't be 
> necessary.  Now look what we have:
> 
> 	st_0(A=1) +> st_0(B=1) ==> ld_1(B) =p>
> 
> 		st_1(B=2) ==> ld_2(B) +> ld_2(A).
> 
> >From this we can deduce that st_0(B=1) => st_1(B=2).  For if not then
> st_1(B=2) => st_0(B=1) => ld_1(B) and hence st_1(B) => ld_1(B), 
> contradicting the requirement that CPU 1 sees it own accesses in order.
> 
> But now we can go on to deduce st_0(B=1) => ld_2(B) (not ==>), and hence 
> st_0(A=1) => ld_2(A).  Since there are no other writes to A, we get
> st_0(A=1) ==> ld_2(A), meaning that the assertion must hold.

Yep, which it must for locking to work, assuming my approach to transitivity.
If we were using your approach to transitivity, we would have a different
memory-barrier condition that required an atomic operation as the final
link in a chain of changes to a given variable -- and in that case, we
would find that the assertion could fail.

> But we know that the assertion may fail on some systems!

To be determined -- the fact that we are threading the single variable B
through all three CPUs potentially makes a difference.  Working on the
empirical end.  I know the assert() always would succeed on POWER, and
empirical evidence agrees (fine-grained low-access-overhead synchronized
time-base registers make this easier!).  I believe that the assert would
also success on Alpha.

>                                                          The reason being
> that CPU 0's stores might propagate slowly to CPU 2 but the paths from
> CPU 0 to CPU 1 and from CPU 1 to CPU 2 might be quick.  Hence CPU 0's
> write to A might not be visible to CPU 2 when the assertion runs, and
> CPU 0's write to B might never be visible to CPU 2.

Agreed -- if the assertion really is guaranteed to work, it is because
the cache-coherence protocol is required to explicitly make it be so.
One reason that I am not too pessimistic is that there are some popular
textbook algorithms that cannot work otherwise (e.g., the various locking
algorithms that don't use atomic instructions, possibly also some of the
NBS algorithms).

> This wouldn't violate the guarantee made by CPU 0's mb().  The guarantee 
> wouldn't apply to CPU 2, since CPU 2 never sees the "B = 1".

Again, this depends on the form of the memory-barrier guarantee --
the presence of a "==>" vs. a "=>" is quite important!  ;-)

> To resolve this we need an additional notion, of a store to some variable
> being visible to a subsequent access of that variable.  The mere fact that
> one store precedes another in the global ordering isn't enough to make it
> visible.
> 
> How would you straighten this out?

My hope is that the CPUs are guaranteed to act the way that I hope they
do, so that the memory-barrier rule is given by:

st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) => ld(B) ->
	st(A) => ld(A)

If so, everything works nicely.  In your scenario, the memory-barrier
rule would instead be something like:

st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) ==> ld(B) ->
	st(A) => ld(A)
st_0(A) -p> wmb -p> st(B) && ld_1(B) -p> rmb -p> ld(A) && st_0(B) => ld_1(B) &&
	not-exist i: st_0(B) => st_i(B) => ld_1(B) ->
		st(A) => ld(A)
st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) => at(B) ->
	st(A) => ld(A)

In other words, either: (1) the st(B) must immediately precede the ld(B), or
(2) there can only be loads between the st(B) and ld(B) (yes, I would have
to add other terms to exclude atomics and so on...), or (3) the access to A
by CPU 1 must be an atomic operation.

Given this set of rules, the assertion could fail.  However, if the
"while (B < 2)" were replaced by (or followed by) an atomic operation
on B, as one would have with a lock, then the assertion would always
succeed.

Does this make sense?

							Thanx, Paul
