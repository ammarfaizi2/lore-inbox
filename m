Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWILSIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWILSIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWILSIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:08:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1547 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030335AbWILSIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:08:22 -0400
Date: Tue, 12 Sep 2006 14:08:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060911190005.GA1295@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609111551450.10623-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006, Paul E. McKenney wrote:

> > One insight has to do with why it is that read-mb-write succeeds
> > whereas write-mb-read can fail.  It comes down to this essential
> > asymmetry:
> > 
> > 	Suppose one CPU writes to a memory location at about the same
> > 	time as another CPU using a different cache reads from it.  If
> > 	the read completes before the write then the read is certain
> > 	to return the old value.  But if the write completes before the
> > 	read, the read is _not_ certain to return the new value.
> 
> Yes.  Of course, keeping in mind that "before" can be a partial ordering.
> In any real situation, you would need to say how you determined that the
> read did in fact happen "before" the write.  Some systems have fine-grained
> synchronized counters that make this easy, but most do not.  In the latter
> case, the memory operations themselves are about the only evidence you
> have to figure out what happened "before".

I think it makes sense to say this even in the absence of precise
definitions.  To put it another way, a CPU or cache can't read the
updated value from another CPU (or cache) before the second CPU (or cache)  
decides to make the updated value publicly available ("committed the
value").  It _can_ read the updated value after the value has been 
committed, but it isn't constrained to do so -- it's allowed to keep using 
the old value for a while.

Incidentally, I object very strongly to the way you hardware folk keep
talking about events being only partially ordered.  This isn't the case at
all.  Given a precise physical definition of what an event is (a
particular transistor changing state for example, or perhaps the entire
time interval starting when one transistor changes state and ending when
another does), each event takes place at a moment of time or during an
interval of time.

Now time really _is_ totally ordered (so long as you confine yourself to a
single reference frame!) and hence in any individual run of a computer
program so are the events -- provided you take proper care when discussing
events that encompass a time interval.

The difficulty is that program runs have a stochastic character; it's
difficult or impossible to predict exactly what the hardware will do.  So
the same program events could be ordered one way during a run and the
opposite way during another run.  Each run is still totally ordered.

If you want, you can derive a partial ordering by considering only those
pairs of events that will _always_ occur in the same order in _every_ run.
But thinking in terms of this sort of partial ordering is clearly
inadequate.  It doesn't even let you derive the properties of the
"canonical" pattern:

	CPU 0			CPU 1
	-----			-----
	a = 1;			y = b;
	wmb();			rmb();
	b = 1;			x = a;
				assert(!(y==1 && x==0));

In terms of partial orderings, we know that all the events on CPU 0 are
ordered by the wmb() and the events on CPU 1 are ordered by the rmb().  
But there is no ordering relation between the events on the two CPUs.  "y
= b" could occur either before or after "b = 1", hence these two events
are incomparable in the partial ordering.  So you can't conclude anything
about the assertion, if you confine your thinking to the partial ordering.


> > 	CPU 0			CPU 1
> > 	-----			-----
> > 	x = a;			y = b;
> > 	mb();			mb();
> > 	b = 1;			a = 1;
> > 	assert(x==0 || y==0);
> > 
> > I'm sure you can verify that this assertion will never fail.
> 
> Two cases, assuming that the initial value of all variables is zero:

Actually it's just one case.  Once you have proved that x!=0 implies y==0, 
by elementary logic you have also proved that y!=0 implies x==0 (one 
statement is the contrapositive of the other).

> 1.	If x!=0, then CPU 0 must have seen CPU 1's assignment a=1
> 	before CPU 0's memory barrier, so all of CPU 0's code after
> 	the memory barrier must see CPU 1's assignment to y.  In more
> 	detail:
> 
> 	CPU 0			CPU 1
> 	-----			-----
> 				y = b;
> 				mb();	The load of b must precede the
> 					store to a, and the invalidate
> 					of y must be queued at CPU 1.
> 				a = 1;
> 	x = a;	This saw CPU 1's a=1, so CPU 1's load of b must already
> 		have happened.
> 	mb();	The invalidate of y must have been received, so it will
> 		be processed prior to any subsequent load.
> 	b = 1;	This cannot affect CPU 1's assignment to y.
> 	assert(x==0 || y==0);
> 		Since y was invalidated, we must get the cacheline.  Since
> 		we saw the assignment to a, we must also see the assignment
> 		to y, which must be zero, since the assignment to y preceded
> 		the assignment to b.
> 
> 	So the assertion succeeds with y==0 in this case.
> 
> 2.	If y!=0, then CPU 1 must have seen CPU 0's assignment b=1.
> 	This is symmetric with case 1, so x==0 in this case.
> 
> So, yes, the assertion never trips.  And, yes, the intuitive approach
> would get the answer with much less hassle, but, given your prior examples,
> I figured that being pedantic was the correct approach.

One could derive the result a little more formally using the causality 
principle I mentioned above (LOAD before STORE cannot return the result of 
the STORE) together with another causality principle: A CPU cannot make 
the result of a STORE available to other CPUs (or to itself) before it 
knows the value to be stored.  A cache might send out invalidate messages 
before knowing the value to be stored, but it can't send out read 
responses.

> And, yes, removing the loops did not change the result.

As intended.

> > It's worth noting that since y is accessible to both CPUs, it must be
> > a variable stored in memory.  It follows that CPU 1's mb() could be
> > replaced with wmb() and the assertion would still always hold.  On the
> > other hand, the compiler is free to put x in a processor register.
> > This means that CPU 0's mb() cannot safely be replaced with wmb().
> 
> You might well be correct, but I must ask you to lay out the operations.
> If CPU 1's mb() becomes a wmb(), the CPU is within its rights to violate
> causality in the assignment y=b.  There are some very strange things
> that can happen in NUMA machines with nested shared caches.

What do you mean by "violate causality"?  Storing a value in y (and making
that value available to the other CPU) before the read has obtained b's
value?  I don't see how that could happen on any architecture, unless your 
machine uses thiotimoline.  :-)

> > Let's return to the question I asked at the start of this thread:
> > Under what circumstances is mb() truly needed?  Well, we've just seen
> > one.  If CPU 0's mb() were replaced with "rmb(); wmb();" the assertion
> > above might fail.  The cache would be free to carry out the operations
> > in a way such that the read of a completed after the write to b.
> 
> And this would be one of the causality violations that render an intuitive
> approach to this so hazardous.  Intuitively, the write of x must follow
> the read of a, and the write memory barrier would force the write of b
> to follow the write of x.  The question in this case is whether the
> intuitive application of transitivity really applies in this case.

I wouldn't put it that way.  Knowing that CPUs are free to reorder
operations in the absence of barriers to prevent such things, the
violation you mention wouldn't seem unintuitive to me.  I tend to have 
more trouble remembering that reads don't necessarily have to return the 
most recent values available.

> > This read-mb-write pattern turns out to be vital for implementing
> > sychronization primitives.  Take your own example:
> > 
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
> > In fact that last paragraph isn't quite right.  The spin_lock()
> > primitive would also work with smp_rmb() in place of smb_mb().  (I can
> > explain my reasoning later, if you're interested.)
> 
> With smp_rmb(), why couldn't the following, given globals b and c:
> 
> 	spin_lock(&mylock);
> 	b = 1;
> 	c = 1;
> 	spin_unlock(&mylock);
> 
> be executed by the CPU as follows?
> 
> 	c = 1;
> 	b = 1;
> 	spin_lock(&mylock);
> 	spin_unlock(&mylock);

Because of the conditional in spin_lock().

> This order of execution seems to me to be highly undesireable.  ;-)
> 
> So, what am I missing here???

A CPU cannot move a write back past a conditional.  Otherwise it runs
the risk of committing the write when (according to the program flow) the
write should never have taken place.  No CPU does speculative writes.


> > Here's another question: To what extent do memory barriers actually
> > force completions to occur in order?  Let me explain...
> 
> In general, they do not at all.  They instead simply impose ordering
> constraints.

What's the difference between imposing an ordering constraint and forcing
two events to occur in a particular order?  To me the phrases appear
synonymous.

> > We can think of a CPU and its cache as two semi-autonomous units.
> > From the cache's point of view, a load or a store initializes when the
> > CPU issues the request to the cache, and it completes when the data is
> > extracted from the cache for transmission to the CPU (for a load) or
> > when the data is placed in the cache (for a store).
> > 
> > Memory barriers prevent CPUs from reordering instructions, thereby
> > forcing loads and stores to initialize in order.  But this reflects
> > how the barriers affect the CPU, whereas I'm more concerned about how
> > they affect the cache.  So to what extent do barriers force
> > memory accesses to _complete_ in order?  Let's go through the
> > possibilities.
> > 
> > 	STORE A; wmb; STORE B;
> > 
> > This does indeed force the completion of STORE B to wait until STORE A
> > has completed.  Nothing else would have the desired effect.
> 
> CPU designers would not agree.  The completion of STORE B must -appear-
> -to- -software- to precede that of STORE A.  For example, you could get
> the effect by allowing the stores to complete out of order, but then
> constraining the ordering of concurrent loads of A and B, for example,
> delaying concurrent loads of A until the store to B completed.
> 
> Typical CPUs really do use both approaches!

Then it would be better to say that the wmb prevents the STORE A from
becoming visible on any particular CPU after the STORE B has become
visible on that CPU.  (Note that this is weaker than saying the STORE A
must not become visible to any CPU after the STORE B has become visible to
any CPU.)

> > 	READ A; mb; STORE B;
> > 
> > This also forces the completion of STORE B to wait until READ A has
> > completed.  Without such a guarantee the read-mb-write pattern wouldn't
> > work.
> 
> Again, this forces the STORE B to -appear- -to- -software- to have
> completed after the READ A.  The hardware is free to allow the operations
> to complete in either order, as long as it constrains the order of
> concurrent accesses to A and B so as to preserve the illusion of ordering.

Again, the mb forces the READ A to commit to a value before the STORE B
becomes visible to any CPU.

> > 	STORE A; mb; READ B;
> > 
> > This is one is strange.  For all I know the mb might very well force
> > the completions to occur in order... but it doesn't matter!  Even when
> > the completions do occur in order, it can appear to other CPUs as if
> > they did not!  This is exactly what happens when the write-mb-read
> > pattern fails.
> 
> ???
> 
> The corresponding accesses would be STORE B; mb; LOAD A.  If the LOAD A
> got the old value of A, but the STORE B did -not- affect the other CPU's
> READ B, we have a violation.  So I don't see anything strange about this
> one.  What am I missing?

You're missing something you described earlier: The two STORES can cross
in the night.  If neither cache has acknowledged the other's invalidate
message when the mb instructions are executed, then the mb's won't have
any effect.  The invalidate acknowledgments can then be sent and the
WRITEs allowed to update their respective caches.  If the processing of
the invalidates is delayed, the READs could be allowed to return the
caches' old data.

> > 	READ A; rmb; READ B;
> > 
> > Another peculiar case.  One almost always hears read barriers described
> > as forcing the second read to complete after the first.  But in reality
> > this is not sufficient.
> 
> Agreed, not if you want to think closer to the hardware.  If you are
> willing to work at a higher level of abstraction, then the description
> is reasonable.
> 
> > The additional requirement of rmb is: Unless there is a pending STORE
> > to B, READ B is not allowed to complete until all the invalidation
> > requests for B pending (i.e., acknowledged but not yet processed) at
> > the time of the rmb instruction have completed (i.e., been processed).
> 
> Did you mean to say "If there is a pending invalidate to B, READ B is
> not allowed to complete until all such pre-existing invalidate requests
> have completed"?  As opposed to "Unless..."?

I was trying to come to terms with the possibility that there might be a 
a pending STORE sitting in the store buffer when the rmb is executed.  In 
that case subsequent LOADs would not be forced to wait for pending 
invalidations; they could be satisfied directly from the store buffer.

Continuing with this reasoning leads to some annoying complications.  It 
becomes clear, for instance, that sometimes one CPU's STORE does not ever 
have to become visible to another CPU!  This is perhaps most obvious in a 
hierarchical cache arrangement, but it's true even in the simple flat 
model.

For example, imagine that CPU 0 does "a = 1" and CPU 1 does "a = 2" at
just about the same time.  Close enough together so that each CPU sees its
own assignment before it sees the other one.  Let's say that the final
value stored in a is 1.  Then the store of 2 could never have been visible
to CPU 0; otherwise CPU 0 would see the stores occuring in the order
1,2,1.

Or to put it another way, suppose CPU 0's write just sits in a store 
buffer while CPU 0 receives, acknowledges, and processes CPU 1's 
invalidate.  CPU 0 would never see the value associated with that 
invalidate because all reads would be satisfied directly from the store 
buffer.

Now that I realize this, it becomes a lot harder to describe what rmb 
really does.  Consider again the "canonical" pattern:

	CPU 0			CPU 1
	-----			-----
	a = 1;			y = b;
	wmb();			rmb();
	b = 1;			x = a;
				assert(!(y==1 && x==0));

We've been saying all along that initially a and b are equal to 0.  But 
suppose that the _reason_ a is equal to 0 is because some time in the past 
both CPUs executed "a = 0".  Suppose CPU 0's assignment completed
quickly, but CPU 1's assignment was delayed and is in fact still sitting 
in a store buffer.  Then the assertion might fail!

A more correct pattern would have to look like this:

	CPU 0			CPU 1
	-----			-----
	while (c == 0) ;	wmb();
				// Earlier writes to a or b are now flushed
				c = 1;

	// arbitrarily long delay with neither CPU writing to a or b

	a = 1;			y = b;
	wmb();			rmb();
	b = 1;			x = a;
				assert(!(y==1 && x==0));

In general you might say that a LOAD following rmb won't return the value 
from any STORE that became visible before the rmb other than the last one.  
But that leaves open the question of which STOREs actually do become 
visible.  I don't know how to deal with that in general.


> > There are consequences of these ideas with potential implications for
> > RCU.  Consider, as a simplified example, a thread T0 which constantly
> > repeats the following loop:
> > 
> > 	for (;;) {
> > 		++cnt;
> > 		mb();
> 
> Need an rcu_read_lock() here (or earlier).
> 
> > 		x = p;
> 
> The above assignment to x should be "x = rcu_dereference(p)", though it
> doesn't affect memory ordering except on Alpha.

True, but not relevant in this context.

> > 		// Do something time-consuming with *x
> 
> Need an rcu_read_unlock() here (or later).
> 
> > 	}
> > 
> > Now suppose another thread T1 wants to update the value of p and wait
> > until the old value is no longer being used (a typical RCU-ish sort of
> > thing).  The natural approach is this:
> > 
> > 	old_p = p;
> > 	p = new_p;
> 
> The above assignment should instead be "rcu_assign_pointer(p, new_p)",
> which would put an smp_wmb() before the actual assignment to p.  Not
> yet sure if this matters in this case, but just for the record...

You may assume there was a wmb() immediately prior to this.

> > 	mb();
> > 	c = cnt;
> > 	while (c == cnt)
> > 		barrier();
> 
> Yikes!!!  The above loop should be replaced by synchronize_rcu().
> Otherwise, you are in an extreme state of sin.

Perhaps you could explain why (other than the fact that it might fail!).

I actually do have code like this in one of my drivers.  But there are
significant differences from the example.  In the driver T0 doesn't run on
a CPU; it runs on a peripheral controller which accesses p via DMA and
makes cnt available over the I/O bus (inw).

Alan

