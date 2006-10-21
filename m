Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423381AbWJUTre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423381AbWJUTre (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbWJUTre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:47:34 -0400
Received: from mx2.rowland.org ([192.131.102.7]:46608 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1423381AbWJUTrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:47:33 -0400
Date: Sat, 21 Oct 2006 15:47:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061021005908.GB1751@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610211518140.28524-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Paul E. McKenney wrote:

> > > And the number before the colon is the CPU #, right?
> > 
> > No, it's an instance label (kind of like a line number).  As we've been 
> > doing before.  The CPU number is still a subscript.
> 
> When I started actually doing formulas, the use of ":" conflicted with
> the logic-expression operator ("for every x there exists y and z such
> that...", which turns into upside-down-A x backwards-E y,z colon ...,
> at least if I am remembering all this correctly).
> 
> So how about having the line number be a second subscript following the
> CPU number?

Make it a second subscript following the close paren.  That way either 
subscript can be omitted without confusion.

> > > > Consider this example:
> > > > 
> > > > 	CPU 0			CPU 1
> > > > 	-----			-----
> > > > 	A = 1;			B = 2;
> > > > 	mb();			mb();
> > > > 	B = 1;			X = A + 1;
> > > > 	...
> > > > 	assert(!(B==2 && X==1));
> > > > 
> > > > The assertion cannot fail.  But to prove it in our formalism requires 
> > > > writing  st_0(B=1) -> st_1(B=2).  In other words, CPU 1's store to B sees 
> > > > (i.e., overwrites) CPU 0's store to B.
> > 
> > I wrote that the assertion cannot fail, but I'm not so sure any more.  
> > Couldn't there be a system where CPU 1's statements run before any of CPU 
> > 0's writes become visible to CPU 1, but nevertheless the caching hardware 
> > decides that CPU 1's write to B "wins"?  More on this below...
> 
> The memory barriers require that if the caching hardware decides that
> CPU 1's B=2 "wins", then X=A+1 must see CPU 0's A=1.  Now the assertion
> could legally see B==2&&X==0, or B==1&&X={0,1,2}, but it cannot legally
> see B==2&&X==1 because that would violate the constraints that the
> memory barriers are supposed to be enforcing.

I won't say that you're wrong.  But how do you know for sure?  That is, 
exactly which constraint does it violate and where is it written in stone 
that the memory barriers are supposed to enforce this constraint?  After 
all, this doesn't fit the usual st-wmb-st / ld-rmb-ld pattern.


> > But now I wonder...  This approach might require too much of memory 
> > barriers.  If we have
> > 
> > 	st(A); mb(); st(B);
> > 
> > does the memory barrier really say anything about CPUs which never see one 
> > or both of those stores?  Or does it say only that CPUs which see both 
> > stores will see them in the correct order?
> 
> Only that CPUs that see both stores with appropriate use of memory barriers
> will see them in the correct order.

Right -- that's what I meant.

> > The only way to be certain a CPU sees a store is if it does a load which
> > returns the value of that store.  In the absence of such a criterion we
> > don't know what really happened.  For example:
> > 
> > 	CPU 0		CPU 1			CPU 2
> > 	-----		-----			-----
> > 	A = 1;		while (B < 1) ;		while (B < 2) ;
> > 	mb();		mb();			mb();
> > 	B = 1;		B = 2;			assert(A==1);

> Yep, which it must for locking to work, assuming my approach to transitivity.
> If we were using your approach to transitivity, we would have a different
> memory-barrier condition that required an atomic operation as the final
> link in a chain of changes to a given variable -- and in that case, we
> would find that the assertion could fail.
> 
> > But we know that the assertion may fail on some systems!
> 
> To be determined -- the fact that we are threading the single variable B
> through all three CPUs potentially makes a difference.  Working on the
> empirical end.  I know the assert() always would succeed on POWER, and
> empirical evidence agrees (fine-grained low-access-overhead synchronized
> time-base registers make this easier!).  I believe that the assert would
> also success on Alpha.

I overstated the case.  We don't know of any actual architectures where 
the assertion could fail, but we have considered a possible architecture 
where it might.  What about NUMA machines?

> >                                                          The reason being
> > that CPU 0's stores might propagate slowly to CPU 2 but the paths from
> > CPU 0 to CPU 1 and from CPU 1 to CPU 2 might be quick.  Hence CPU 0's
> > write to A might not be visible to CPU 2 when the assertion runs, and
> > CPU 0's write to B might never be visible to CPU 2.
> 
> Agreed -- if the assertion really is guaranteed to work, it is because
> the cache-coherence protocol is required to explicitly make it be so.
> One reason that I am not too pessimistic is that there are some popular
> textbook algorithms that cannot work otherwise (e.g., the various locking
> algorithms that don't use atomic instructions, possibly also some of the
> NBS algorithms).
> 
> > This wouldn't violate the guarantee made by CPU 0's mb().  The guarantee 
> > wouldn't apply to CPU 2, since CPU 2 never sees the "B = 1".
> 
> Again, this depends on the form of the memory-barrier guarantee --
> the presence of a "==>" vs. a "=>" is quite important!  ;-)

Just so.

> My hope is that the CPUs are guaranteed to act the way that I hope they
> do, so that the memory-barrier rule is given by:
> 
> st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) => ld(B) ->
> 	st(A) => ld(A)
> 
> If so, everything works nicely.  In your scenario, the memory-barrier
> rule would instead be something like:
> 
> st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) ==> ld(B) ->
> 	st(A) => ld(A)
> st_0(A) -p> wmb -p> st(B) && ld_1(B) -p> rmb -p> ld(A) && st_0(B) => ld_1(B) &&
> 	not-exist i: st_0(B) => st_i(B) => ld_1(B) ->
> 		st(A) => ld(A)

This is identical to the previous version, since by definition

	st_i(B) ==> ld_j(B)  is equivalent to  st_i(B) => ld_j(B) &&
		not exist k: st_i(B) => st_k(B) => ld_j(B).

> st(A) -p> wmb -p> st(B) && ld(B) -p> rmb -p> ld(A) && st(B) => at(B) ->
> 	st(A) => ld(A)
> 
> In other words, either: (1) the st(B) must immediately precede the ld(B), or
> (2) there can only be loads between the st(B) and ld(B) (yes, I would have
> to add other terms to exclude atomics and so on...), or (3) the access to A
> by CPU 1 must be an atomic operation.

(1) Yes; it's the same as saying that ld(B) returns the value of the 
st(B) (no intervening stores).

(2) doesn't make sense, since loads aren't part of the global ordering of
accesses of B -- they are invisible.  (BTW, you don't need to assume as
well that stores are blind; it's enough just to have loads be invisible.)  
Each load sees an initial sequence of stores ending in the store whose
value is returned by the load, but this doesn't mean that the load occurs
between that store and the next one.

(3) The assumption should be that both accesses of B are atomic; it 
doesn't matter whether the accesses of A are.

> Does this make sense?

Yes.  Maybe we should include these rules as an alternative set of "very
weak" memory ordering assumptions?  For normal uses they shouldn't make
any difference.

Alan

