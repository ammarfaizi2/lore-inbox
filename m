Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWIHS4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWIHS4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWIHS4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:56:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:28095 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750743AbWIHS4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:56:48 -0400
Date: Fri, 8 Sep 2006 11:57:35 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060908185735.GF1314@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060908001445.GG1293@us.ibm.com> <Pine.LNX.4.44L0.0609081101090.7156-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609081101090.7156-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:55:46AM -0400, Alan Stern wrote:
> On Thu, 7 Sep 2006, Paul E. McKenney wrote:
> 
> > On Thu, Sep 07, 2006 at 05:25:51PM -0400, Alan Stern wrote:
> > > Paul:
> > > 
> > > Here's something I had been thinking about back in July but never got 
> > > around to discussing:  Under what circumstances would one ever want to use 
> > > "mb()" rather than "rmb()" or "wmb()"?
> > 
> > If there were reads needing to be separated from writes, for example
> > in spinlocks.  The spinlock-acquisition primitive could not use either
> > wmb() or rmb(), since reads in the critical section must remain ordered
> > with respect to the write to the spinlock itself.
> 
> Yes, okay, that's a general situation where mb() would be useful.  But the 
> actual application amounts to one of the two patterns below, as you will 
> see...

Hey, you asked!!!  ;-)

> Let's call the following pattern "write-mb-read", since that's what each
> CPU does (write a, mb, read b on CPU 0 and write b, mb, read a on CPU 1).
> 
> > > The obvious extension of the canonical example is to have CPU 0 write
> > > one location and read another, while CPU 1 reads and writes the same
> > > locations.  Example:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	while (y==0) relax();	y = -1;
> > > 	a = 1;			b = 1;
> > > 	mb();			mb();
> > > 	y = b;			x = a;
> > > 				while (y < 0) relax();
> > > 				assert(x==1 || y==1);	//???
> 
> > In the above code, there is nothing stopping CPU 1 from executing through
> > the "x=a" before CPU 0 starts, so that x==0.
> 
> Agreed.
> 
> >  In addition, CPU 1 imposes
> > no ordering between the assignment to y and b,
> 
> Agreed.
> 
> >  so there is nothing stopping
> > CPU 0 from seeing the new value of y, but failing to see the new value of
> > b,
> 
> Disagree: CPU 0 executes mb() between reading y and b.  You have assumed
> that CPU 1 executed its write to b and its mb() before CPU 0 got started, 
> so why wouldn't CPU 0's mb() guarantee that it sees the new value of b?  
> That's really the key point.

If we are talking about some specific CPUs, you might have a point.
But Linux must tolerate least-common-demoninator semantics...

And those least-common-denominator semantics are "if a CPU sees an
assignment from another CPU that followed a memory barrier on that
other CPU, then the first CPU is guaranteed to see any stores from
the other CPU -preceding- that memory barrier.

In your example, CPU 0 does not access x, so never sees any stores
from CPU 1 following the mb(), and thus is never guaranteed to see
the assignments preceding CPU 1's mb().

> To rephrase it in terms of partial orderings of events: CPU 1's mb()  
> orders the commit for the write to b before the read from a.  The fact
> that a was read as 0 means that the read occurred before CPU 0's write to
> a was committed.  The mb() on CPU 0 orders the commit for the write to a
> before the read from b.  By transitivity, the read from b must have
> occurred after the write to b was committed, so the value read must have
> been 1.

After CPU 1 sees the new value of y, then, yes, any operation ordered
after the read of y would see the new value of a.  But (1) the "x=a"
precedes the check for y and (2) there is no mb() following the check of y
to force any ordering whatsoever.

Assume that initially, a==0 in a cache line owned by CPU 1.  Assume that
b==0 and y==0 in separate cache lines owned by CPU 0.

	CPU 0			CPU 1
	-----			-----
				y = -1;  [this goes out quickly.]
	while (y==0) relax(); [picks up the value from CPU 1]
	a = 1;	[the cacheline is on CPU 1, so this one sits in
		 CPU 0's store queue.  CPU 0 transmits an invalidation
		 request, which will take time to reach CPU 1.]
				b = 1; [the cacheline is on CPU 0, so
					this one sits in CPU 1's store
					queue, and CPU 1 transmits an
					invalidation request, which again
					will take time to rech CPU 0.]
	mb(); [CPU 0 waits for acknowledgement of reception of all previously
	       transmitted invalidation requests, and also processes any
	       invalidation requests that it has previously received (none!)
	       before processing any subsequent loads.  Yes, CPU 1 already
	       sent the invalidation request for b, but there is no
	       guarantee that it has worked its way to CPU 0 yet!]
				mb();  [Ditto.]

	At this point, CPU 0 has received the invalidation request for b
	from CPU 1, and CPU 1 has received the invalidation request for
	a from CPU 0, but there is no guarantee that either of these
	invalidation requests have been processed.

				x = a; [Could therefore still be using
					the old cached version of a, so
					that x==0.]
	y = b; [Could also be still using the old cached version of b,
		so that y==0.]
				while (y < 0) relax(); [This will spin until
					the cache coherence protocol delivers
					the new value y==0.  At this point,
					CPU 1 is guaranteed to see the new
					value of a due to CPU 0's mb(), but
					it is too late...  And CPU 1 would
					need a memory barrier following the
					while loop in any case -- otherwise,
					CPU 1 would be within its rights
					on some CPUs to execute the code
					out of order.]
				assert(x==1 || y==1);	//???
					[This assertion can therefore fail.]

By the way, this sort of scenario is why maintainers have my full
sympathies when they automatically reject any patches containing explicit
memory barriers...

> > so that y==0 (assuming the initial value of b is zero).
> > 
> > Something like the following might illustrate your point:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 				b = 1;
> > 				wmb();
> > 	while (y==0) relax();	y = -1;
> > 	a = 1;
> > 	wmb();
> > 	y = b;			while (y < 0) relax();
> > 				rmb();
> > 				x = a;
> > 				assert(x==1 || y==1);	//???
> > 
> > Except that the memory barriers have all turned into rmb()s or wmb()s...
> 
> This seems like a non-sequitur.  My point was about mb(); how could this
> example illustrate it?  In particular, CPU 0's wmb() doesn't imply any 
> ordering between its read of y and its read of b.

Excellent point, thus CPU 0's wmb() needs to instead be an mb().

> Furthermore, in this example the stronger assertion x==1 would always 
> hold (it's a corollary of assert(y==-1 || x==1) combined with the 
> knowledge that the while loop has terminated).  Did you in fact intend CPU 
> 0's wmb() to be rmb()?

I was just confused, confusion being a common symptom of working with
explicit memory barriers.  :-/

If CPU 0 did mb(), then I believe assert(x==1&&y==1) would hold.

> Let's call the following pattern "read-mb-write".
> 
> > > The opposite approach would use reads followed by writes:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	while (x==0) relax();	x = -1;
> > > 	x = a;			y = b;
> > > 	mb();			mb();
> > > 	b = 1;			a = 1;
> > > 				while (x < 0) relax();
> > > 				assert(x==0 || y==0);	//???
> > > 
> > > Similar reasoning can be applied here.  However IIRC, you decided that
> > > neither of these assertions is actually guaranteed to hold.  If that's the
> > > case, then it looks like mb() is useless for coordinating two CPUs.
> > 
> > Yep, similar problems as with the earlier example.
> > 
> > > Am I correct?  Or are there some easily-explained situations where mb()  
> > > really should be used for inter-CPU synchronization?
> > 
> > Consider the following (lame) definitions for spinlock primitives,
> > but in an alternate universe where atomic_xchg() did not imply a
> > memory barrier, and on a weak-memory CPU:
> > 
> > 	typedef spinlock_t atomic_t;
> > 
> > 	void spin_lock(spinlock_t *l)
> > 	{
> > 		for (;;) {
> > 			if (atomic_xchg(l, 1) == 0) {
> > 				smp_mb();
> > 				return;
> > 			}
> > 			while (atomic_read(l) != 0) barrier();
> > 		}
> > 
> > 	}
> > 
> > 	void spin_unlock(spinlock_t *l)
> > 	{
> > 		smp_mb();
> > 		atomic_set(l, 0);
> > 	}
> > 
> > The spin_lock() primitive needs smp_mb() to ensure that all loads and
> > stores in the following critical section happen only -after- the lock
> > is acquired.  Similarly for the spin_unlock() primitive.
> 
> Really?  Let's take a closer look.  Let b be a pointer to a spinlock_t and 
> let a get accessed only within the critical sections:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	spin_lock(b);
> 	...
> 	x = a;
> 	spin_unlock(b);		spin_lock(b);
> 				a = 1;
> 				...
> 	assert(x==0); //???
> 
> Expanding out the code gives us a version of the read-mb-write pattern.  

Eh?   There is nothing guaranteeing that CPU 0 gets the lock before
CPU 1, so what is to assert?

> For the sake of argument, let's suppose that CPU 1's spin_lock succeeds
> immediately with no looping:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	...
> 	x = a;
> 	// spin_unlock(b):
> 	mb();
> 	atomic_set(b,0);	if (atomic_xchg(b,1) == 0)   // Succeeds
> 					mb();
> 				a = 1;
> 				...
> 	assert(x==0); //???
> 
> As you can see, this fits the pattern exactly.  CPU 0 does read a, mb, 
> write b, and CPU 1 does read b, mb, write a.

Again, you don't have anything that guarantees that CPU 0 will get the
lock first, so the assertion is bogus.  Also, the "if" shouldn't be
there -- since we are assuming CPU 1 got the lock immediately, it
would be unconditionally executing the mb(), right?

> We are supposing the read of b obtains the new value (no looping); can we
> then assert that the read of a obtained the old value?  If we can -- and
> we had better if spinlocks are to work correctly -- then doesn't this mean
> that the read-mb-write pattern will always succeed?

Since CPU 1 saw CPU 0's assignment to b (which follows CPU 0's mb()),
and since CPU 1 immediately executed a memory barrier, CPU 1's critical
section is guaranteed to follow that of CPU 0.  -Both- CPU 0's and CPU 1's
memory barriers are needed to make this work.  This does not rely on
anything fancy, simply the standard pair-wise memory-barrier guarantee.

(Which is: if CPU 1 sees an assignment by CPU 0 following CPU 0 executing
a memory barrier, then any code on CPU 1 following a later CPU 1 memory
barrier is guaranteed to see the effects of all references by CPU 0
that preceded CPU 0's memory barrier.)

David Howells's Documentation/memory-barriers.txt goes through this
sort of thing, IIRC.

							Thanx, Paul
