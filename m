Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWIIAnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWIIAnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWIIAnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 20:43:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:61104 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750848AbWIIAnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 20:43:20 -0400
Date: Fri, 8 Sep 2006 17:44:06 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060909004406.GM1314@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060908185735.GF1314@us.ibm.com> <Pine.LNX.4.44L0.0609081644410.7953-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609081644410.7953-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 05:23:04PM -0400, Alan Stern wrote:
> On Fri, 8 Sep 2006, Paul E. McKenney wrote:
> 
> > > Yes, okay, that's a general situation where mb() would be useful.  But the 
> > > actual application amounts to one of the two patterns below, as you will 
> > > see...
> > 
> > Hey, you asked!!!  ;-)
> 
> I knew that starting this discussion would open a can of worms, but what 
> the heck...  I was curious!  :-)

;-)

> > If we are talking about some specific CPUs, you might have a point.
> > But Linux must tolerate least-common-demoninator semantics...
> > 
> > And those least-common-denominator semantics are "if a CPU sees an
> > assignment from another CPU that followed a memory barrier on that
> > other CPU, then the first CPU is guaranteed to see any stores from
> > the other CPU -preceding- that memory barrier.
> 
> The "canonical" memory-barrier guarantee.  But I'm interested in 
> non-canonical situations...

OK...  But beyond a certain point, that way lies madness...

> > Assume that initially, a==0 in a cache line owned by CPU 1.  Assume that
> > b==0 and y==0 in separate cache lines owned by CPU 0.
> 
> Ah, a meaty analysis with details of inner mechanisms.  Good.
> 
> > 	CPU 0			CPU 1
> > 	-----			-----
> > 				y = -1;  [this goes out quickly.]
> > 	while (y==0) relax(); [picks up the value from CPU 1]
> > 	a = 1;	[the cacheline is on CPU 1, so this one sits in
> > 		 CPU 0's store queue.  CPU 0 transmits an invalidation
> > 		 request, which will take time to reach CPU 1.]
> > 				b = 1; [the cacheline is on CPU 0, so
> > 					this one sits in CPU 1's store
> > 					queue, and CPU 1 transmits an
> > 					invalidation request, which again
> > 					will take time to rech CPU 0.]
> > 	mb(); [CPU 0 waits for acknowledgement of reception of all previously
> > 	       transmitted invalidation requests, and also processes any
> > 	       invalidation requests that it has previously received (none!)
> > 	       before processing any subsequent loads.  Yes, CPU 1 already
> > 	       sent the invalidation request for b, but there is no
> > 	       guarantee that it has worked its way to CPU 0 yet!]
> > 				mb();  [Ditto.]
> > 
> > 	At this point, CPU 0 has received the invalidation request for b
> > 	from CPU 1, and CPU 1 has received the invalidation request for
> > 	a from CPU 0, but there is no guarantee that either of these
> > 	invalidation requests have been processed.
> 
> Do you draw a distinction between an invalidation request being
> "acknowledged" and being "processed"?  CPU 0 won't finish its mb() until
> CPU 1 has acknowledged receiving the invalidation request for a's
> cacheline.  Does it make sense for CPU 1 to acknowledge reception of the
> request without having yet processed the request?

Yes.  At least for the definition for "make sense" that is used in
some CPU-design circles...

Here is one possible sequence of events for CPU 0's mb() operation:

1.	Mark all currently pending invalidation requests from other CPUs
	(but there are none).

2.	Wait for acknowledgements for all outstanding invalidation requests
	from CPU 0 to other CPUs (there is one, that corresponding to the
	assignment to a).

3.	At some point in this sequence, the invalidation request from
	CPU 1 corresponding to the assignment to b arrives.  However,
	it was not present before the mb() started executing, so is
	-not- marked.

4.	Ensure that all marked pending invalidation requests from other
	CPUs complete before any subsequence loads are allowed to
	commence on CPU 0 (but there are no marked pending invalidation
	requests).

Real CPUs are much more clever about performing these operations in a way
that reduces the probability of stalling, but the above sequence should
be good enough for this discussion.  The assignments to a and b pass in
the night -- there are no memory barriers forcing them to be ordered.

> Wouldn't that open a door for some nasty synchronization problems?

Ummm....  Yes!!!  ;-)

That is one reason why people should use the standard primitives that
already contain the necessary memory barriers whenever possible.

>                                                                    For
> example, suppose CPU 1 had previously modified some other variable c
> located in the same cacheline as a.  Acknowledging the invalidation
> request means it is giving permission for CPU 0 to own the cacheline;
> wouldn't this cause the modification of c to be lost?

Not necessarily.  Keep in mind that in this example, CPU 0 does not yet
have a copy of the cache line containing variables a and c.  CPU 1 is
therefore free to update the cacheline with the values of a and c before
transmitting it to CPU 0.

Unless, of course, there was a memory barrier between the two assignments,
and that memory barrier was executed -after- the reception of the
invalidation request.  In that case, CPU 1 would be required to update
the cache line with the first assignment (say to variable a), then ship
the cacheline to CPU 0.  But the assignment to c still will not be lost,
since CPU 1 can retain the assignment in its store queue.  CPU 1 would
send an invalidation request to CPU 0, and update the cacheline with
the assignment to c after getting the cacheline back from CPU 0.

This would be cache thrashing.  Or cacheline bouncing.

> > 				x = a; [Could therefore still be using
> > 					the old cached version of a, so
> > 					that x==0.]
> 
> Not if the invalidation request was processed as well as merely 
> acknowledged.

True enough.  But there is no -guarantee- that the invalidation request
will have been processed.

> > 	y = b; [Could also be still using the old cached version of b,
> > 		so that y==0.]
> > 				while (y < 0) relax(); [This will spin until
> > 					the cache coherence protocol delivers
> > 					the new value y==0.  At this point,
> > 					CPU 1 is guaranteed to see the new
> > 					value of a due to CPU 0's mb(), but
> > 					it is too late...  And CPU 1 would
> > 					need a memory barrier following the
> > 					while loop in any case -- otherwise,
> > 					CPU 1 would be within its rights
> > 					on some CPUs to execute the code
> > 					out of order.]
> > 				assert(x==1 || y==1);	//???
> > 					[This assertion can therefore fail.]
> > 
> > By the way, this sort of scenario is why maintainers have my full
> > sympathies when they automatically reject any patches containing explicit
> > memory barriers...
> 
> I sympathize.
> 
> > > Let's call the following pattern "read-mb-write".
> 
> I wish I had presented read-mb-write first, before write-mb-read.  It's
> more pertinent to the section on locking below.  Can you please give an
> equally detailed analysis, like the one above, showing how the assertion
> in thie pattern can fail?

See below...  But I would strongly advise nacking any patch involving
this sort of line of reasoning, especially given that I could have
written a significant amount of "normal" code in the time that it
took me to analyze this, and given the error rate on the part of
myself and of others.

> > > > > The opposite approach would use reads followed by writes:
> > > > > 
> > > > > 	CPU 0			CPU 1
> > > > > 	-----			-----
> > > > > 	while (x==0) relax();	x = -1;
> > > > > 	x = a;			y = b;
> > > > > 	mb();			mb();
> > > > > 	b = 1;			a = 1;
> > > > > 				while (x < 0) relax();
> > > > > 				assert(x==0 || y==0);	//???
> 
> Or does it turn out that read-mb-write does succeed, even though 
> write-mb-read can sometimes fail?

OK...  The initial value of a, b, x, and y are zero, right?

	CPU 0			CPU 1
	-----			-----
	while (x==0) relax();	x = -1;
	x = a;			y = b;
	mb();			mb();
	b = 1;			a = 1;
				while (x < 0) relax();
				assert(x==0 || y==0);	//???

For y!=0, CPU 1's assignment y=b must follow CPU 0's assignment b=1.
Since b=1 follows CPU 0's memory barrier, and since y=b precedes CPU 1's
memory barrier, any code after CPU 1's memory barrier must see the effect
of assignments from CPU 0 preceding CPU 0's memory barrier, so that CPU
1's assignment a=1 comes after CPU 0's assignment x=a, and so therefore
x=a=0 at CPU 1.  But CPU 1 also assigns x=-1.  The question the becomes
"which assignment to x came last?".  The "while" loop on CPU 0 cannot
exit before the assignment x=-1 on CPU 1 completes, but there is no memory
barrier between CPU 0's "while" loop and its subsequent assignment "x=a".

However, CPU 0 must see its own accesses as occurring in order, and all
CPUs have to see some single global ordering of a sequence of assignments
to a -single- given variable.  So I believe CPU 0's assignment x=a must be
seen by all CPUs as following CPU 1's assignment x=-1, implying that the
final value of x==0, and that the assertion does not trip.

But my head hurts...

Now, for x!=0...  We have established that CPU 0's assignment x=a must
follow CPU 0's assignment x=a.  Therefore, for x!=0, CPU 0's assignment
x=1 must also follow CPU 1's assignment a=1.  In this case, CPU 0 has
seen an assignment that follows CPU 1's memory barrier, and therefore CPU
1's subsequent assignment b=1 must see all of CPU 1's assignments prior
to the memory barrier -- in particular, y=b must have already happened,
so that y==0.  Again, the assertion does not trip.

So I was mistaken in my first email when I said that the assert() can
trip in this case -- it cannot.

But there had better be a -really- good reason for pulling this kind
of stunt...  And even then, there had better be some -really- good
comments...

> > > > Consider the following (lame) definitions for spinlock primitives,
> > > > but in an alternate universe where atomic_xchg() did not imply a
> > > > memory barrier, and on a weak-memory CPU:
> > > > 
> > > > 	typedef spinlock_t atomic_t;
> > > > 
> > > > 	void spin_lock(spinlock_t *l)
> > > > 	{
> > > > 		for (;;) {
> > > > 			if (atomic_xchg(l, 1) == 0) {
> > > > 				smp_mb();
> > > > 				return;
> > > > 			}
> > > > 			while (atomic_read(l) != 0) barrier();
> > > > 		}
> > > > 
> > > > 	}
> > > > 
> > > > 	void spin_unlock(spinlock_t *l)
> > > > 	{
> > > > 		smp_mb();
> > > > 		atomic_set(l, 0);
> > > > 	}
> > > > 
> > > > The spin_lock() primitive needs smp_mb() to ensure that all loads and
> > > > stores in the following critical section happen only -after- the lock
> > > > is acquired.  Similarly for the spin_unlock() primitive.
> > > 
> > > Really?  Let's take a closer look.  Let b be a pointer to a spinlock_t and 
> > > let a get accessed only within the critical sections:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	spin_lock(b);
> > > 	...
> > > 	x = a;
> > > 	spin_unlock(b);		spin_lock(b);
> > > 				a = 1;
> > > 				...
> > > 	assert(x==0); //???
> > > 
> > > Expanding out the code gives us a version of the read-mb-write pattern.  
> > 
> > Eh?   There is nothing guaranteeing that CPU 0 gets the lock before
> > CPU 1, so what is to assert?
> 
> Okay, I left out some stuff.  Suppose we have this instead:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 	spin_lock(b);
> 	...
> 	y = -1;			while (y == 0) relax();
> 	x = a;
> 	spin_unlock(b);		spin_lock(b);
> 				a = 1;
> 				...
> 	assert(x==0); //???
> 
> Now we _can_ guarantee that CPU 0 gets the lock before CPU 1.  The 
> discussion will not be significantly affected by this change.

-My- discussion is affected!

Anyway, the assignment a=1 must follow the assignment x=a, so the
assertion cannot trip.  Without the guarantee, CPU 1's critical
section could have preceded that of CPU 0, so that x==1, tripping
the assertion.

> > > For the sake of argument, let's suppose that CPU 1's spin_lock succeeds
> > > immediately with no looping:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	...
> Insert: y = -1; (goes out quickly)
> 				while (y == 0) relax();	(quickly terminates)
> > > 	x = a;
> > > 	// spin_unlock(b):
> > > 	mb();
> > > 	atomic_set(b,0);	if (atomic_xchg(b,1) == 0)   // Succeeds
> > > 					mb();
> > > 				a = 1;
> > > 				...
> > > 	assert(x==0); //???
> > > 
> > > As you can see, this fits the pattern exactly.  CPU 0 does read a, mb, 
> > > write b, and CPU 1 does read b, mb, write a.
> > 
> > Again, you don't have anything that guarantees that CPU 0 will get the
> > lock first, so the assertion is bogus.
> 
> Now we do have such a guarantee.

And preceding the y=-1 was a lock acquisition (presumably), so that
the assignment a=1 is again required to follow the assignment x=1,
so that x==0 and the assertion does not trip.  This works on IA64
as well (with its semi-permeable memory barriers associated with
locking), but the potential scenarios are more complicated.

However, if the lock acquisition follows the assignment y=-1, then
CPU 1 could potentially acquire the lock before CPU 0 does, in which
case one could end up with x==1, tripping the assertion.

> >  Also, the "if" shouldn't be
> > there -- since we are assuming CPU 1 got the lock immediately, it
> > would be unconditionally executing the mb(), right?
> 
> I copied the "if" from your original code.  If the "if" had failed then
> CPU 1 would have looped and retried the "if", until it did succeed.  As
> the "// Succeeds" comment indicates, we can assume for the sake of
> argument that the "if" succeeds the first time through.

OK.  But this stuff is grotesque enough without leaving assumptions
unstated, no matter how natural they might seem.  ;-)

> > > We are supposing the read of b obtains the new value (no looping); can we
> > > then assert that the read of a obtained the old value?  If we can -- and
> > > we had better if spinlocks are to work correctly -- then doesn't this mean
> > > that the read-mb-write pattern will always succeed?
> > 
> > Since CPU 1 saw CPU 0's assignment to b (which follows CPU 0's mb()),
> > and since CPU 1 immediately executed a memory barrier, CPU 1's critical
> > section is guaranteed to follow that of CPU 0.
> 
> Correct.
> 
> >  -Both- CPU 0's and CPU 1's
> > memory barriers are needed to make this work.  This does not rely on
> > anything fancy, simply the standard pair-wise memory-barrier guarantee.
> 
> Yes.  But you haven't answered the question: Must the assertion succeed?
> And if it must, what is the low-level mechanism which insures it will?
> How does this mechanism compare with the mechanism for the read-mb-write 
> pattern?

See above, but the answer applies only to the new version.  In the
old version of the code, the order of the critical sections could
have reversed, possibly tripping the assertion.

> > David Howells's Documentation/memory-barriers.txt goes through this
> > sort of thing, IIRC.
> 
> That's why I put him on the CC: list.  It doesn't explain things in quite 
> this much detail, though, and it doesn't consider these non-canonical 
> cases (except for one brief section on the implementation of 
> rw-semaphores).

I can't say I blame him -- I certainly would not want to be seen as in
any way encouraging non-canonical use of memory barriers, certainly not
if there is some reasonable alternative!  ;-)

							Thanx, Paul
