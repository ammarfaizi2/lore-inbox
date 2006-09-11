Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWIKQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWIKQUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWIKQUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:20:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:30610 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932330AbWIKQUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:20:13 -0400
Date: Mon, 11 Sep 2006 09:21:00 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060911162059.GA1496@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 10:25:45PM -0400, Alan Stern wrote:
> On Sat, 9 Sep 2006, Oliver Neukum wrote:
> 
> > > But what _is_ the formal definition of a memory barrier?  I've never seen 
> > > one that was complete and correct.
> > 
> > I' d say "mb();" is "rmb();wmb();"
> > 
> > and they work so that:
> > 
> > CPU 0
> > 
> > a = TRUE;
> > wmb();
> > b = TRUE;
> > 
> > CPU 1
> > 
> > if (b) {
> > 	rmb();
> > 	assert(a);
> > }
> > 
> > is correct. Possibly that is not a complete definition though.
> 
> It isn't.  Paul has agreed that this assertion:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 	while (x == 0) relax();		x = -1;
> 	x = a;				y = b;
> 	mb();				mb();
> 	b = 1;				a = 1;
> 					while (x < 0) relax();
> 					assert(x==0 || y==0);
> 
> will not fail.  I think this would not be true if either of the mb() 
> statements were replaced with {rmb(); wmb();}.
> 
> To put it another way, {rmb(); wmb();} guarantees that any preceding read 
> will complete before any following read and any preceding write will 
> complete before any following write.  However it does not guarantee that 
> any preceding read will complete before any following write, whereas mb() 
> does guarantee that.  (To whatever extent these statements make sense.)

This is a summary of the Linux memory-barrier semantics as I understand
them:

1.	A given CPU will always perceive its own memory operations
	as occuring in program order.

2.	All stores to a given single memory location will be perceived
	as having occurred in the same order by all CPUs.  This is
	"coherence".  (And this is the property that I was forgetting
	about when I first looked at your second example.)

3.	A given type of memory barrier, when executed on a given CPU,
	causes that CPU's prior accesses of the corresponding type to
	be perceived by other CPUs as having occurred before the given
	CPU's subsequent accesses of the corresponding type.

	The types of memory barriers are rmb(), which segregates only
	reads, wmb(), which segregates only writes, and mb(), which
	segregates both.  There is also mmiowb(), which is like wmb(),
	but gives additional ordering guarantees that extend to I/O
	busses, such as PCI bridges.

Alan is quite correct when he says that rmb();wmb(); is not necessarily
equivalent to mb().  For example:

	Sequence 1		Sequence 2

	load A			load A
	store B			store B
	mb()			rmb();wmb()
	load C			load C
	store D			store D

In sequence 1, other CPUs will see the load from A and the store to B both
preceding the load from C and the store to D.  In sequence 2, other CPUs
might well see the store to D preceding the load from A, or, conversely,
the store to B following the load from C.  This second scenario might seem
unlikely, but there is real hardware that has similar properties (e.g.,
ppc's separately ordering accesses to cached and to non-cached memory).

In all these cases, of course, these other CPUs would themselves be needing
to use memory barriers to order their own accesses.

You guys asked!!!

							Thanx, Paul
