Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWIHVXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWIHVXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWIHVXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:23:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:15877 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751264AbWIHVXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:23:05 -0400
Date: Fri, 8 Sep 2006 17:23:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060908185735.GF1314@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609081644410.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Paul E. McKenney wrote:

> > Yes, okay, that's a general situation where mb() would be useful.  But the 
> > actual application amounts to one of the two patterns below, as you will 
> > see...
> 
> Hey, you asked!!!  ;-)

I knew that starting this discussion would open a can of worms, but what 
the heck...  I was curious!  :-)

> If we are talking about some specific CPUs, you might have a point.
> But Linux must tolerate least-common-demoninator semantics...
> 
> And those least-common-denominator semantics are "if a CPU sees an
> assignment from another CPU that followed a memory barrier on that
> other CPU, then the first CPU is guaranteed to see any stores from
> the other CPU -preceding- that memory barrier.

The "canonical" memory-barrier guarantee.  But I'm interested in 
non-canonical situations...

> Assume that initially, a==0 in a cache line owned by CPU 1.  Assume that
> b==0 and y==0 in separate cache lines owned by CPU 0.

Ah, a meaty analysis with details of inner mechanisms.  Good.

> 	CPU 0			CPU 1
> 	-----			-----
> 				y = -1;  [this goes out quickly.]
> 	while (y==0) relax(); [picks up the value from CPU 1]
> 	a = 1;	[the cacheline is on CPU 1, so this one sits in
> 		 CPU 0's store queue.  CPU 0 transmits an invalidation
> 		 request, which will take time to reach CPU 1.]
> 				b = 1; [the cacheline is on CPU 0, so
> 					this one sits in CPU 1's store
> 					queue, and CPU 1 transmits an
> 					invalidation request, which again
> 					will take time to rech CPU 0.]
> 	mb(); [CPU 0 waits for acknowledgement of reception of all previously
> 	       transmitted invalidation requests, and also processes any
> 	       invalidation requests that it has previously received (none!)
> 	       before processing any subsequent loads.  Yes, CPU 1 already
> 	       sent the invalidation request for b, but there is no
> 	       guarantee that it has worked its way to CPU 0 yet!]
> 				mb();  [Ditto.]
> 
> 	At this point, CPU 0 has received the invalidation request for b
> 	from CPU 1, and CPU 1 has received the invalidation request for
> 	a from CPU 0, but there is no guarantee that either of these
> 	invalidation requests have been processed.

Do you draw a distinction between an invalidation request being
"acknowledged" and being "processed"?  CPU 0 won't finish its mb() until
CPU 1 has acknowledged receiving the invalidation request for a's
cacheline.  Does it make sense for CPU 1 to acknowledge reception of the
request without having yet processed the request?

Wouldn't that open a door for some nasty synchronization problems?  For
example, suppose CPU 1 had previously modified some other variable c
located in the same cacheline as a.  Acknowledging the invalidation
request means it is giving permission for CPU 0 to own the cacheline;
wouldn't this cause the modification of c to be lost?

> 
> 				x = a; [Could therefore still be using
> 					the old cached version of a, so
> 					that x==0.]

Not if the invalidation request was processed as well as merely 
acknowledged.

> 	y = b; [Could also be still using the old cached version of b,
> 		so that y==0.]
> 				while (y < 0) relax(); [This will spin until
> 					the cache coherence protocol delivers
> 					the new value y==0.  At this point,
> 					CPU 1 is guaranteed to see the new
> 					value of a due to CPU 0's mb(), but
> 					it is too late...  And CPU 1 would
> 					need a memory barrier following the
> 					while loop in any case -- otherwise,
> 					CPU 1 would be within its rights
> 					on some CPUs to execute the code
> 					out of order.]
> 				assert(x==1 || y==1);	//???
> 					[This assertion can therefore fail.]
> 
> By the way, this sort of scenario is why maintainers have my full
> sympathies when they automatically reject any patches containing explicit
> memory barriers...

I sympathize.


> > Let's call the following pattern "read-mb-write".

I wish I had presented read-mb-write first, before write-mb-read.  It's
more pertinent to the section on locking below.  Can you please give an
equally detailed analysis, like the one above, showing how the assertion
in thie pattern can fail?

> > > > The opposite approach would use reads followed by writes:
> > > > 
> > > > 	CPU 0			CPU 1
> > > > 	-----			-----
> > > > 	while (x==0) relax();	x = -1;
> > > > 	x = a;			y = b;
> > > > 	mb();			mb();
> > > > 	b = 1;			a = 1;
> > > > 				while (x < 0) relax();
> > > > 				assert(x==0 || y==0);	//???

Or does it turn out that read-mb-write does succeed, even though 
write-mb-read can sometimes fail?


> > > Consider the following (lame) definitions for spinlock primitives,
> > > but in an alternate universe where atomic_xchg() did not imply a
> > > memory barrier, and on a weak-memory CPU:
> > > 
> > > 	typedef spinlock_t atomic_t;
> > > 
> > > 	void spin_lock(spinlock_t *l)
> > > 	{
> > > 		for (;;) {
> > > 			if (atomic_xchg(l, 1) == 0) {
> > > 				smp_mb();
> > > 				return;
> > > 			}
> > > 			while (atomic_read(l) != 0) barrier();
> > > 		}
> > > 
> > > 	}
> > > 
> > > 	void spin_unlock(spinlock_t *l)
> > > 	{
> > > 		smp_mb();
> > > 		atomic_set(l, 0);
> > > 	}
> > > 
> > > The spin_lock() primitive needs smp_mb() to ensure that all loads and
> > > stores in the following critical section happen only -after- the lock
> > > is acquired.  Similarly for the spin_unlock() primitive.
> > 
> > Really?  Let's take a closer look.  Let b be a pointer to a spinlock_t and 
> > let a get accessed only within the critical sections:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	spin_lock(b);
> > 	...
> > 	x = a;
> > 	spin_unlock(b);		spin_lock(b);
> > 				a = 1;
> > 				...
> > 	assert(x==0); //???
> > 
> > Expanding out the code gives us a version of the read-mb-write pattern.  
> 
> Eh?   There is nothing guaranteeing that CPU 0 gets the lock before
> CPU 1, so what is to assert?

Okay, I left out some stuff.  Suppose we have this instead:

	CPU 0			CPU 1
	-----			-----
	spin_lock(b);
	...
	y = -1;			while (y == 0) relax();
	x = a;
	spin_unlock(b);		spin_lock(b);
				a = 1;
				...
	assert(x==0); //???

Now we _can_ guarantee that CPU 0 gets the lock before CPU 1.  The 
discussion will not be significantly affected by this change.

> > For the sake of argument, let's suppose that CPU 1's spin_lock succeeds
> > immediately with no looping:
> > 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	...
Insert: y = -1; (goes out quickly)
				while (y == 0) relax();	(quickly terminates)
> > 	x = a;
> > 	// spin_unlock(b):
> > 	mb();
> > 	atomic_set(b,0);	if (atomic_xchg(b,1) == 0)   // Succeeds
> > 					mb();
> > 				a = 1;
> > 				...
> > 	assert(x==0); //???
> > 
> > As you can see, this fits the pattern exactly.  CPU 0 does read a, mb, 
> > write b, and CPU 1 does read b, mb, write a.
> 
> Again, you don't have anything that guarantees that CPU 0 will get the
> lock first, so the assertion is bogus.

Now we do have such a guarantee.

>  Also, the "if" shouldn't be
> there -- since we are assuming CPU 1 got the lock immediately, it
> would be unconditionally executing the mb(), right?

I copied the "if" from your original code.  If the "if" had failed then
CPU 1 would have looped and retried the "if", until it did succeed.  As
the "// Succeeds" comment indicates, we can assume for the sake of
argument that the "if" succeeds the first time through.

> > We are supposing the read of b obtains the new value (no looping); can we
> > then assert that the read of a obtained the old value?  If we can -- and
> > we had better if spinlocks are to work correctly -- then doesn't this mean
> > that the read-mb-write pattern will always succeed?
> 
> Since CPU 1 saw CPU 0's assignment to b (which follows CPU 0's mb()),
> and since CPU 1 immediately executed a memory barrier, CPU 1's critical
> section is guaranteed to follow that of CPU 0.

Correct.

>  -Both- CPU 0's and CPU 1's
> memory barriers are needed to make this work.  This does not rely on
> anything fancy, simply the standard pair-wise memory-barrier guarantee.

Yes.  But you haven't answered the question: Must the assertion succeed?
And if it must, what is the low-level mechanism which insures it will?
How does this mechanism compare with the mechanism for the read-mb-write 
pattern?


> David Howells's Documentation/memory-barriers.txt goes through this
> sort of thing, IIRC.

That's why I put him on the CC: list.  It doesn't explain things in quite 
this much detail, though, and it doesn't consider these non-canonical 
cases (except for one brief section on the implementation of 
rw-semaphores).

Alan

