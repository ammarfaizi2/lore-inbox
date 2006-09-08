Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWIHPzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWIHPzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWIHPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:55:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:2315 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750865AbWIHPzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:55:47 -0400
Date: Fri, 8 Sep 2006 11:55:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060908001445.GG1293@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609081101090.7156-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Paul E. McKenney wrote:

> On Thu, Sep 07, 2006 at 05:25:51PM -0400, Alan Stern wrote:
> > Paul:
> > 
> > Here's something I had been thinking about back in July but never got 
> > around to discussing:  Under what circumstances would one ever want to use 
> > "mb()" rather than "rmb()" or "wmb()"?
> 
> If there were reads needing to be separated from writes, for example
> in spinlocks.  The spinlock-acquisition primitive could not use either
> wmb() or rmb(), since reads in the critical section must remain ordered
> with respect to the write to the spinlock itself.

Yes, okay, that's a general situation where mb() would be useful.  But the 
actual application amounts to one of the two patterns below, as you will 
see...

Let's call the following pattern "write-mb-read", since that's what each
CPU does (write a, mb, read b on CPU 0 and write b, mb, read a on CPU 1).

> > The obvious extension of the canonical example is to have CPU 0 write
> > one location and read another, while CPU 1 reads and writes the same
> > locations.  Example:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	while (y==0) relax();	y = -1;
> > 	a = 1;			b = 1;
> > 	mb();			mb();
> > 	y = b;			x = a;
> > 				while (y < 0) relax();
> > 				assert(x==1 || y==1);	//???

> In the above code, there is nothing stopping CPU 1 from executing through
> the "x=a" before CPU 0 starts, so that x==0.

Agreed.

>  In addition, CPU 1 imposes
> no ordering between the assignment to y and b,

Agreed.

>  so there is nothing stopping
> CPU 0 from seeing the new value of y, but failing to see the new value of
> b,

Disagree: CPU 0 executes mb() between reading y and b.  You have assumed
that CPU 1 executed its write to b and its mb() before CPU 0 got started, 
so why wouldn't CPU 0's mb() guarantee that it sees the new value of b?  
That's really the key point.

To rephrase it in terms of partial orderings of events: CPU 1's mb()  
orders the commit for the write to b before the read from a.  The fact
that a was read as 0 means that the read occurred before CPU 0's write to
a was committed.  The mb() on CPU 0 orders the commit for the write to a
before the read from b.  By transitivity, the read from b must have
occurred after the write to b was committed, so the value read must have
been 1.

> so that y==0 (assuming the initial value of b is zero).
> 
> Something like the following might illustrate your point:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 				b = 1;
> 				wmb();
> 	while (y==0) relax();	y = -1;
> 	a = 1;
> 	wmb();
> 	y = b;			while (y < 0) relax();
> 				rmb();
> 				x = a;
> 				assert(x==1 || y==1);	//???
> 
> Except that the memory barriers have all turned into rmb()s or wmb()s...

This seems like a non-sequitur.  My point was about mb(); how could this
example illustrate it?  In particular, CPU 0's wmb() doesn't imply any 
ordering between its read of y and its read of b.

Furthermore, in this example the stronger assertion x==1 would always 
hold (it's a corollary of assert(y==-1 || x==1) combined with the 
knowledge that the while loop has terminated).  Did you in fact intend CPU 
0's wmb() to be rmb()?

Let's call the following pattern "read-mb-write".

> > The opposite approach would use reads followed by writes:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	while (x==0) relax();	x = -1;
> > 	x = a;			y = b;
> > 	mb();			mb();
> > 	b = 1;			a = 1;
> > 				while (x < 0) relax();
> > 				assert(x==0 || y==0);	//???
> > 
> > Similar reasoning can be applied here.  However IIRC, you decided that
> > neither of these assertions is actually guaranteed to hold.  If that's the
> > case, then it looks like mb() is useless for coordinating two CPUs.
> 
> Yep, similar problems as with the earlier example.
> 
> > Am I correct?  Or are there some easily-explained situations where mb()  
> > really should be used for inter-CPU synchronization?
> 
> Consider the following (lame) definitions for spinlock primitives,
> but in an alternate universe where atomic_xchg() did not imply a
> memory barrier, and on a weak-memory CPU:
> 
> 	typedef spinlock_t atomic_t;
> 
> 	void spin_lock(spinlock_t *l)
> 	{
> 		for (;;) {
> 			if (atomic_xchg(l, 1) == 0) {
> 				smp_mb();
> 				return;
> 			}
> 			while (atomic_read(l) != 0) barrier();
> 		}
> 
> 	}
> 
> 	void spin_unlock(spinlock_t *l)
> 	{
> 		smp_mb();
> 		atomic_set(l, 0);
> 	}
> 
> The spin_lock() primitive needs smp_mb() to ensure that all loads and
> stores in the following critical section happen only -after- the lock
> is acquired.  Similarly for the spin_unlock() primitive.

Really?  Let's take a closer look.  Let b be a pointer to a spinlock_t and 
let a get accessed only within the critical sections:

	CPU 0			CPU 1
	-----			-----
	spin_lock(b);
	...
	x = a;
	spin_unlock(b);		spin_lock(b);
				a = 1;
				...
	assert(x==0); //???

Expanding out the code gives us a version of the read-mb-write pattern.  
For the sake of argument, let's suppose that CPU 1's spin_lock succeeds
immediately with no looping:

	CPU 0			CPU 1
	-----			-----
	...
	x = a;
	// spin_unlock(b):
	mb();
	atomic_set(b,0);	if (atomic_xchg(b,1) == 0)   // Succeeds
					mb();
				a = 1;
				...
	assert(x==0); //???

As you can see, this fits the pattern exactly.  CPU 0 does read a, mb, 
write b, and CPU 1 does read b, mb, write a.

We are supposing the read of b obtains the new value (no looping); can we
then assert that the read of a obtained the old value?  If we can -- and
we had better if spinlocks are to work correctly -- then doesn't this mean
that the read-mb-write pattern will always succeed?

Alan

