Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWIRUNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWIRUNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWIRUNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:13:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16645 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751904AbWIRUNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:13:45 -0400
Date: Mon, 18 Sep 2006 16:13:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060918191338.GH1294@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609181540110.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006, Paul E. McKenney wrote:

> > I wonder if it really is possible to find a complete set.  Perhaps 
> > examples can become arbitrarily complex and only some formal logical 
> > system would be able to generate all of them.  If that's the case then I 
> > would like to know what that logical system is.
> 
> Here is my nomination for the complete set:
> 
> 	A|B  B|A
> 
> 	L|L  L|L -- Independent of ordering
> 	L|L  L|S -- Pointless, since there is no second store
> 	L|L  S|L -- Pointless, since there is no second store
> 	L|L  S|S -- first pairing
> 
> 	L|S  L|L -- (DUP) single-store pointless
> 	L|S  L|S -- second pairing
> 	L|S  S|L -- problematic store-barrier-load
> 	L|S  S|S -- If CPU 0's load sees CPU 1's 2nd store, then CPU 0's
> 			store wins.  (third pairing)
> 
> 	S|L  L|L -- (DUP) single-store pointless
> 	S|L  L|S -- (DUP) problematic store-barrier-load
> 	S|L  S|L -- (DUP) problematic store-barrier-load
> 	S|L  S|S -- (DUP) problematic store-barrier-load
> 
> 	S|S  L|L -- (DUP) first pairing
> 	S|S  L|S -- (DUP) winning store.
> 	S|S  S|L -- (DUP) problematic store-barrier-load
> 	S|S  S|S -- Pointless, no loads
> 
> The first column is CPU 0's actions, the second is CPU 1's actions.
> "S" is store, "L" is load.  CPU 0 accesses A first, then B, while
> CPU 1 does the opposite.  The commentary is my guess at what happens.
> 
> I believe that more complex cases can be handled by superposition.
> For example, if CPU 0 load A, does a barrier, stores B and C, while
> CPU 1 loads B and C, does a barrier, and stores A, then one can apply
> the "second pairing" twice, once for A and B, and again for A and C.
> If B and C are the same variable, then P2 would also apply.
> 
> Counterexamples?  ;-)

You only considered actions by two CPUs, and you only considered orderings
induced by the memory barriers.  What about interactions among multiple
CPUs or orderings caused by control dependencies?  Two examples:

	CPU 0		CPU 1		CPU 2
	-----		-----		-----
	x = a;		y = b;		z = c;
	mb();		mb();		mb();
	b = 1;		c = 1;		a = 1;
	assert(x==0 || y==0 || z==0);


	CPU 0		CPU 1
	-----		-----
	x = a;		while (b == 0) ;
	mb();		a = 1;
	b = 1;
	assert(x==0);

I suspect your scheme can't handle either of these.  In fact, I rather
suspect that the "partial ordering" approach is fundamentally incapable of
generating all possible correct deductions about memory access
requirements, and that something more like my "every action happens at a
specific time" approach is necessary.  That is, after all, what led me to
consider it in the first place.


> > In any case, it is important to distinguish carefully between the two
> > classes of effects caused by memory barriers:
> > 
> > 	They prevent CPUs from reordering certain types of instructions;
> > 
> > 	They cause certain loads to obtain the results of certain stores.
> > 
> > The first is more of an effect on the CPUs whereas the second is more
> > of an effect on the caches.
> 
> From where I sit, the second is the architectural constraint, while the
> first is implementation-specific.  So I am very concerned about the
> second, but worried only about the first as needed to give examples.

It's true that this distinction depends very much on the system design.  
For the model where CPUs send requests to caches which then carry them 
out, the first effect is quite important.


> > There are other reasons for a write not becoming visible besides being
> > indefinitely delayed.  It could be masked entirely by a separate write.
> 
> OK.  I was assuming that there was no such separate write.  After all,
> you didn't show it on your diagram.

I had mentioned the possibility in the text earlier.  Something like this:

	CPU 0			CPU 1
	-----			-----
	a = 0;	// Suppose this gets hung up in a store buffer
		// for an indefinite length of time.  Then later...

		// Here's where the standard example starts
	y = b;			a = 1;
	rmb();			wmb();
	x = a;			b = 1;
	assert(!(y==1 && x==0));	// Might fail

It's a matter of boundary conditions.  So far the only stated boundary
condition has been that initially all variables are equal to 0.  There has
also been an unstated condition that there are no writes to the variables
during the time period in question other than the ones shown in the
example, whether by these CPUs or any others.

In the example above, the boundary conditions are all satisfied.  It's
still true that a is initially equal to 0, and the first line above is
supposed to execute before the time period in question for the standard
example.  Neverthless, the standard example fails.

Some stronger boundary condition is needed.  Something along the lines of: 
All writes to the variables preceding the time period in question have 
completed when the example starts.  That ought to be sufficient to 
guarantee that each of the writes will become visible eventually to the 
other CPU.


> So one approach would be to describe the abstract ordering principles,
> show how they work in code snippets, and then give a couple "bookend"
> examples of hardware being creative about adhering to these principles.
> 
> Seem reasonable?

Yes.

Alan

