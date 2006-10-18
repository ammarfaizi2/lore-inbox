Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWJRTF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWJRTF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJRTF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:05:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45841 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161042AbWJRTF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:05:27 -0400
Date: Wed, 18 Oct 2006 15:05:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061017225838.GK2062@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610181041420.6766-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Paul E. McKenney wrote:

> > It was taking the effect of memory barriers into account.  In the program
> > "load(A); store(B)" the load doesn't sequentially precede the store.  But
> > in the program "load(A); smp_mb(); store(B)" it does.  Similarly, in the
> > program "if (A) B = 2;" the load(A) sequentially precedes the store(B) --
> > thanks to the dependency or (if you prefer) the absence of speculative
> > stores.
> > 
> > Basically "sequentially precedes" means that any other CPU using the
> > appropriate memory barriers will observe the accesses apparently occurring
> > in this order.
> 
> Your first example in the previous paragraph fits the description.
> The second does not, as illustrated by the following scenario:
> 
> 	CPU 0			CPU 1			CPU 2
> 
> 	A=1			while (B==0);		while (C==0);
> 	smp_mb()		C=1			smp_mb()
> 	B=1						assert(A==1) <fails>

In what way is this inconsistent with my second example?  Using "<" for 
"sequentially precedes" we have:

	st_0(A=1) < st_0(B=1) <v ld_1(B) < st_1(C=1) <v ld_2(C) < ld_2(A)

You cannot derive st_0(A=1) <v ld_2(A) from this.  The rules are:

	1:st(X) < 2:st(Y) <v 3:ac(Y) < 4:ac(X)  implies
		1:st(X) <v 4:ac(X)

and

	1:ld(X) < 2:st(Y) <v 3:ac(Y) < 4:st(X)  implies
		4:st(X) !<v 1:ld(X).

> Please note that the "<fails>" is not a theoretical assertion -- I have
> seen this happen in real life.  So, yes, the C=1 might not speculate ahead
> of the load of B that produced a non-zero result, but CPU 2's assertion
> can still fail, even though both CPU 2 and CPU 0 are using memory barriers.

Your example would be no less fallacious if CPU 1 executed smp_mb() before
C = 1.  The assertion could still fail because CPU 1's write to C could
become visible to CPU 2 before CPU 0's writes to A and B.


> > Yes, I realize that.  But if several CPUs store values to the same
> > variable at about the same time, it's not at all clear which stores are
> > "<v" others.  Deciding this is tantamount to ordering all the stores to
> > that variable.
> 
> Yep.  Consider the following case:
> 
> 	CPU 0			CPU 1			CPU 2
> 
> 	A=1			B=1			X=C
> 	smb_mb()		smp_mb()		smp_mb()
> 	C=1			C=2			if (X==1) ???
> 
> In the then-clause of the "if", CPU 2 can only be sure that it will
> see A==1.  It might or might not see B==1.  We simply don't know the
> order of stores to C, even at runtime.

It's one thing to say you don't know the order of stores.  It's another 
thing to say that there _is_ no order -- especially if you're going to use 
the "<v" notation to implicitly impose such an order!

So maybe what you're claiming is that the stores to a single variable _do_ 
have a global order at runtime, even though we might not know what it is, 
and the view each CPU has is always a suborder of that global order.  (And 
of course there is no fixed relation on how the global orders of stores to 
two separate variables inter-relate, unless it is enforced by memory 
barriers.)

Does this claim always make sense, even in a hierarchical cache system?

> Now consider the following:
> 
> 	CPU 0		CPU 1		CPU 2
> 
> 	A=1		B=1		X=C
> 	smb_mb()	smp_mb()	smp_mb()
> 	atomic_inc(&C)	atomic_inc(&C)	assert(C!=2 || (A==1 && B==1))
> 
> This assertion is guaranteed to succeed (using my semantics of the
> transitivity of ">v"/"<v" -- using yours, CPU 2 would instead need to
> use an atomic operation to fetch the value of C).  We still don't know
> which atomic_inc() happened first (we would need atomic_inc_return()
> to figure that out), but we can nevertheless determine if both have
> happened and act accordingly.

Yes.  What is your point?  And how is it related to the existence of a 
global ordering for all stores to a single variable?


> An alternative would be to use something like "sees" to describe "<v":
> 
> 	ld_1(A) <v st_0(A=1)
> 
> might be called "CPU 1's load of A sees CPU 0's store of 1 into A".

You wrote this backwards; it should say:  st_0(A=1) <v ld_1(A).

> Then "<v" would be "is seen by".  In my regime:
> 
> 	ld_2(A) <v ++_1(A=2) <v st_0(A=1) -> ld_2(A) <v st_0(A=1)

Backwards again.  You mean:

   st_0(A=1) <v ++_1(A=2) <v ld_2(A)  implies  st_0(A=1) <v ld_2(A)

> In yours, this would not hold unless the ld_2() was replaced by an atomic
> operation (if I understand your regime correctly).

Basically yes, although I'm not sure how a load manages to be atomic.  
Maybe if it's part of an atomic exchange or something like that.

> Does this "sees"/"is seen by" nomenclature seem more reasonable?
> Or perhaps "visibility includes"/"visible to"?  Or keep "sees"/"seen by"
> and use "<s"/">s" to adjust the mneumonic?

I'm not keen on either one.  Does it make sense to say one store is
visible to (or is seen by) another store?  Maybe...  But "comes before"  
seems more natural.  Especially if you're assuming the existence of a
global ordering on these stores.

Incidentally, although you haven't mentioned this, it's important never to
state that a load is visible to (or is seen by or comes before) another
access.  In other words, the global ordering of stores for a single
variable doesn't extend to a global ordering of _all_ accesses for that
variable.

Alan

