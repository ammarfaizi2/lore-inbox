Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWJQW5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWJQW5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWJQW5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:57:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59074 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751003AbWJQW5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:57:36 -0400
Date: Tue, 17 Oct 2006 15:58:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061017225838.GK2062@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061017201500.GI2062@us.ibm.com> <Pine.LNX.4.44L0.0610171707170.3627-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610171707170.3627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 05:21:33PM -0400, Alan Stern wrote:
> On Tue, 17 Oct 2006, Paul E. McKenney wrote:
> 
> > > Earlier I defined two separate kinds of orderings: "comes before" and
> > > "sequentially precedes".  My "comes before" is essentially the same as
> > > your "<v", applying only to accesses of the same variable.  You don't have
> > > any direct analog to "sequentially precedes", which is perhaps a weakness:  
> > > It will be harder for you to denote the effect of a load dependency on a
> > > subsequent store.  My "sequentially precedes" does _not_ require the
> > > accesses to be to the same variable, but it does require them to take
> > > place on the same CPU.
> > 
> > This is similar to my ">p"/"<p" -- or was your "sequentially precedes"
> > somehow taking effects of other CPUs into account.
> 
> It was taking the effect of memory barriers into account.  In the program
> "load(A); store(B)" the load doesn't sequentially precede the store.  But
> in the program "load(A); smp_mb(); store(B)" it does.  Similarly, in the
> program "if (A) B = 2;" the load(A) sequentially precedes the store(B) --
> thanks to the dependency or (if you prefer) the absence of speculative
> stores.
> 
> Basically "sequentially precedes" means that any other CPU using the
> appropriate memory barriers will observe the accesses apparently occurring
> in this order.

Your first example in the previous paragraph fits the description.
The second does not, as illustrated by the following scenario:

	CPU 0			CPU 1			CPU 2

	A=1			while (B==0);		while (C==0);
	smp_mb()		C=1			smp_mb()
	B=1						assert(A==1) <fails>

Please note that the "<fails>" is not a theoretical assertion -- I have
seen this happen in real life.  So, yes, the C=1 might not speculate ahead
of the load of B that produced a non-zero result, but CPU 2's assertion
can still fail, even though both CPU 2 and CPU 0 are using memory barriers.

> > > >      My example formalism for a memory barrier says nothing about the
> > > >      actual order in which the assignments to A and B occurred, nor about
> > > >      the actual order in which the loads from A and B occurred.  No such
> > > >      ordering is required to describe the action of the memory barrier.
> > > 
> > > Are you sure about that?  I would think it was implicit in your definition
> > > of "<v".  Talking about the order of values in a variable during the past
> > > isn't very different from talking about the order in which the
> > > corresponding stores occurred.
> > 
> > My "<v" is valid only for a single variable.  A computer that reversed
> > the order of execution of CPU 0's two assignments would be permitted,
> > as long as the loads on CPU 1 and CPU 2 got the correct values.
> 
> Yes, I realize that.  But if several CPUs store values to the same
> variable at about the same time, it's not at all clear which stores are
> "<v" others.  Deciding this is tantamount to ordering all the stores to
> that variable.

Yep.  Consider the following case:

	CPU 0			CPU 1			CPU 2

	A=1			B=1			X=C
	smb_mb()		smp_mb()		smp_mb()
	C=1			C=2			if (X==1) ???

In the then-clause of the "if", CPU 2 can only be sure that it will
see A==1.  It might or might not see B==1.  We simply don't know the
order of stores to C, even at runtime.

Now consider the following:

	CPU 0		CPU 1		CPU 2

	A=1		B=1		X=C
	smb_mb()	smp_mb()	smp_mb()
	atomic_inc(&C)	atomic_inc(&C)	assert(C!=2 || (A==1 && B==1))

This assertion is guaranteed to succeed (using my semantics of the
transitivity of ">v"/"<v" -- using yours, CPU 2 would instead need to
use an atomic operation to fetch the value of C).  We still don't know
which atomic_inc() happened first (we would need atomic_inc_return()
to figure that out), but we can nevertheless determine if both have
happened and act accordingly.

> > > For that matter, the whole concept of "the value in a variable" is itself
> > > rather fuzzy.  Even the sequence of values might not be well defined: If
> > > you had some single CPU do nothing but repeatedly load the variable and
> > > note its value, you could end up missing some of the values perceived by
> > > other CPUs.  That is, it could be possible for CPU 0 to see A take on the
> > > values 0,1,2 while CPU 1 sees only the values 0,2.
> > 
> > Heck, if you have a synchronized clock register with sufficient accuracy,
> > you can catch different CPUs thinking that a given variable has different
> > values at the same point in time.  ;-)
> 
> Exactly.  That's why I'm not too comfortable with your "<v" -- and I'm not 
> completely certain of the validity of "comes before" either.  Hardly 
> surprising, since they mean pretty much the same thing.

An alternative would be to use something like "sees" to describe "<v":

	ld_1(A) <v st_0(A=1)

might be called "CPU 1's load of A sees CPU 0's store of 1 into A".
Then "<v" would be "is seen by".  In my regime:

	ld_2(A) <v ++_1(A=2) <v st_0(A=1) -> ld_2(A) <v st_0(A=1)

In yours, this would not hold unless the ld_2() was replaced by an atomic
operation (if I understand your regime correctly).

Does this "sees"/"is seen by" nomenclature seem more reasonable?
Or perhaps "visibility includes"/"visible to"?  Or keep "sees"/"seen by"
and use "<s"/">s" to adjust the mneumonic?

							Thanx, Paul
