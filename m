Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWIPESR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWIPESR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 00:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWIPESR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 00:18:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28553 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932451AbWIPESQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 00:18:16 -0400
Date: Fri, 15 Sep 2006 21:19:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060916041905.GD1289@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060915051659.GA5186@us.ibm.com> <Pine.LNX.4.44L0.0609151007510.12515-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609151007510.12515-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 03:48:31PM -0400, Alan Stern wrote:
> At this stage I think we're violently approaching agreement.  :-)

;-)  ;-)  ;-)

> On Thu, 14 Sep 2006, Paul E. McKenney wrote:
> 
> > > That's okay.  There isn't any single notion of "This store occurred at 
> > > this time".  Instead, for each CPU there is a notion of "This store became 
> > > visible to this CPU at this time".
> > 
> > That is one way to look at it.  It may or may not be the best way to
> > look at it in a given situation -- for example, some stores never become
> > visible to some CPUs due to the effect of later stores.  For another
> > example, if the software doesn't look at a given situation, it cannot
> > tell whether or not a given store is visible to it.
> > 
> > The fact that there are indeed real events happening at real time isn't
> > necessarily relevant if they cannot be seen.  Accepting fuzzy stores
> > can decrease the size of the state space substantially.  This can be an
> > extremely good thing.
> 
> Okay.  I'll allow that both points of view are valid and each can be 
> useful in its own way.

Fair enough!!!

> > > Again, not a problem.  And for the same reason.  Although if the stores 
> > > are all to the same location, different CPUs should _not_ have different 
> > > opinions about the order in which they became visible.
> > 
> > The different CPUs might have different opinions -- in fact, they
> > usually -do- have different opinions.  The constraint is instead that
> > their different opinions must be consistent with -at- -least- -one-
> > totally ordered sequence of stores.  For an example, consider three
> > CPUs storing to the same location concurrently, and another CPU watching.
> > The CPUs will agree on who was the last CPU to do the store, but might
> > have no idea of the order of the other two stores.
> 
> The only way a CPU can have no idea of the order of the other two stores
> is if it fails to see one or both of them.  If it does see both stores
> then of course it knows in what order it saw them.

Yep, with the proviso that one way to see a store is to be the CPU
actually executing it.

> A less ambiguous way to phrase what I said before would be: two CPUs
> should not have different opinions about the order in which two stores
> became visible, provided both stores were visible to both CPUs.  Obviously 
> if a CPU doesn't see both of the stores then it can't have any opinion 
> about their ordering.

Good enough!

> > > (P1):	If two writes are ordered on the same CPU and two reads are
> > > 	ordered on another CPU, and the first read sees the result of
> > > 	the second write, then the second read will see the result of
> > > 	the first write.
> > > 
> > > Correct?
> > 
> > Partially.
> > 
> > (P1a):	If two writes are ordered on one CPU, and two reads are ordered
> > 	on another CPU, and if the first read sees the result of the
> > 	second write, then the second read will see the result of the
> > 	first write.
> > 
> > (P1b):	If a read is ordered before a write on each of two CPUs,
> > 	and if the read on the second CPU sees the result of the write
> > 	on the first CPU, then the read on the first CPU will -not-
> > 	see the result of the write on the second CPU.
> > 
> > (P2):	All CPUs will see the results of writes to a single location
> > 	in orderings consistent with at least one total global order
> > 	of writes to that single location.
> 
> As you noted, your P1b is what I had called P2.  It is usually not
> presented in dicussions about memory barriers.  Nevertheless it is the
> only justification for the mb() instruction; P1a talks about only rmb()  
> and wmb().

And there is a P1c:

(P1c):	If one CPU does a load from A ordered before a store to B,
	and if a second CPU does a store to B ordered before a
	store to A, and if the first CPU's load from A gives
	the value stored by the second CPU, then the first CPU's
	store to B must happen after the second CPU's store to B,
	hence the value stored by the first CPU persists.  (Or,
	for the more competitively oriented, the first CPU's store
	to B "wins".)

I am mapping out a complete set -- these three might cover them all,
but need to revisit after sleeping on it.  I also need to run this
by some CPU architects...

> > > I think that all you really need to do is remember that statements can be 
> > > reordered, that stores become visible to different CPUs at different 
> > > times, and that loads don't always return the value of the last visible 
> > > store.  Everything else is intuitive -- except for the way memory barriers 
> > > work!
> > 
> > Let me get this right.  In your viewpoint, memory barriers are strongly
> > counter-intuitive, yet you are trying to convince me to switch to your
> > viewpoint?  ;-)
> 
> Not the barriers themselves, but how they work!  You have to agree that
> their operation is deeply tied into the low-level nature of the
> memory-access hardware on any particular system.  Much more so than for
> most instructions.

It certainly is safe to say that arriving at a correct but simple
description of what they do has been unexpectedly challenging...

> > > Yes, it's true that given sufficiently weak ordering, the writes could 
> > > be moved back inbetween the load and store implicit in the atomic 
> > > exchange.  It's worth pointing out that even if this does occur, it will 
> > > not be visible to any CPU that accesses b and c only from within a 
> > > critical section.
> > 
> > The other key point is that some weakly ordered CPUs were designed
> > only to make spinlocks work.
> > 
> > >                   But it could be visible in a situation like this:
> > > 
> > > 	CPU 0				CPU 1
> > > 	-----				-----
> > > 	[call spin_lock(&mylock)]	x = b;
> > > 	read mylock, obtain 0		mb();
> > > 	b = 1; [moved up]		y = atomic_read(&mylock);
> > > 	write mylock = 1
> > > 	rmb();
> > > 	[leave spin_lock()]
> > > 					mb();
> > > 					assert(!(x==1 && y==0 && c==0));
> > > 	c = 1;
> > > 	spin_unlock(&mylock);
> > > 
> > > The assertion could indeed fail.  HOWEVER...
> > > 
> > > What you may not realize is that even when spin_lock() contains your
> > > original full mb(), if CPU 0 reads b (instead of writing b) that read
> > > could appear to another CPU to have occurred before the write to mylock.  
> > > Example:
> > > 
> > > 	CPU 0				CPU 1
> > > 	-----				-----
> > 
> > All variables initially zero?
> 
> Of course.

So I am paranoid.  What is your point?  ;-)

> > > 	[call spin_lock(&mylock)]	b = 1;
> > > 	read mylock, obtain 0		mb();
> > > 	write mylock = 1		y = atomic_read(&mylock);
> > > 	mb();
> > > 	[leave spin_lock()]
> > > 
> > > 	x = b + 1;			mb();
> > > 					assert(!(x==1 && y==0 && c==0));
> > > 	c = 1;
> > > 	spin_unlock(&mylock);
> > > 
> > > If the assertion fails, then CPU 1 will think that CPU 0 read the value of 
> > > b before setting mylock to 1.  But the assertion can fail!  It's another 
> > > example of the write-mb-read pattern.  If CPU 0's write to mylock crosses 
> > > with CPU 1's write to b, then both CPU 0's read of b and CPU 1's read of 
> > > mylock could obtain the old values.
> > > 
> > > So in this respect your implementation already fails to prevent reads from 
> > > leaking partway out of the critical section.  My implementation does the 
> > > same thing with writes, but otherwise is no worse.
> > 
> > But isn't this the write-memory-barrier-read sequence that you (rightly)
> > convinced me was problematic in earlier email?
> 
> Indeed it is.  The problematic nature of that sequence means that in the 
> right conditions, a read can appear to leak partially in front of a 
> spin_lock().

The above sequence can reasonably be interpreted as having that effect.
Good reason to be -very- careful when modifying data used by a given
critical section without the protection of the corresponding lock.

> > > > > A more correct pattern would have to look like this:
> > > > > 
> > > > > 	CPU 0			CPU 1
> > > > > 	-----			-----
> > > > > 	while (c == 0) ;	wmb();
> > > > > 				// Earlier writes to a or b are now flushed
> > > > > 				c = 1;

If CPU 0 might also have stored to a and b, you also need the following:

		wmb()			while (d == 0);
		d = 1;

Interestingly enough, this resembles one aspect of realtime
synchronize_rcu() where there are no barriers in rcu_read_lock()
and rcu_read_unlock(), and for roughly the same reason -- except
that mb() rather than wmb() is required for synchronize_rcu().
And synchronize_rcu() uses counters rather than binary variables in
order to allow the code to be "retriggered" after use.

> > > > > 	// arbitrarily long delay with neither CPU writing to a or b
> > > > > 
> > > > > 	a = 1;			y = b;
> > > > > 	wmb();			rmb();
> > > > > 	b = 1;			x = a;
> > > > > 				assert(!(y==1 && x==0));
> > > > > 
> > > > > In general you might say that a LOAD following rmb won't return the value 
> > > > > from any STORE that became visible before the rmb other than the last one.  
> > > > > But that leaves open the question of which STOREs actually do become 
> > > > > visible.  I don't know how to deal with that in general.
> > > > 
> > > > The best answer I can give is that an rmb() -by- -itself- means absolutely
> > > > nothing.  The only way it has any meaning is in conjunction with an
> > > > mb() or a wmb() on some other CPU.  The "pairwise" stuff in David's
> > > > documentation.
> > > 
> > > Even that isn't enough.  You also have to have some sort of additional 
> > > information that can guarantee CPU 0's write to b will become visible to 
> > > CPU 1.  If it never becomes visible then the assertion could fail.
> > 
> > Eh?  If the write to b never becomes visible, then y==0, and the assertion
> > always succeeds.  Or am I misreading this example?
> 
> Sorry, typo.  I meant CPU 0's write to a, not its write to b.  If you 
> can't guarantee that CPU 0's write to a will become visible to CPU 1 then 
> you can't guarantee the assertion will succeed.

Ah!

But if CPU 0's write to a is indefinitely delayed, then, by virtue of
CPU 0's wmb(), CPU 0's write to b must also be indefinitely delayed.
In this case, y==0&&x==0, so the assertion again always succeeds.

> > > But I can't think of any reasonable way to obtain such a guarantee that 
> > > isn't implementation-specific.  Which leaves things in a rather 
> > > unsatisfactory state...
> > 
> > But arbitrary delays can happen due to interrupts, preemption, etc.
> > So you are simply not allowed such a guarantee.
> 
> The delay isn't important.  What matters is that whatever else may happen 
> during the delay, neither CPU writes anything to a or b.
> 
> Strictly speaking even that's not quite right.  What's needed is a 
> condition that can guarantee CPU 0's write to a will become visible to 
> CPU 1.  Flushing CPU 1's store buffer may not be sufficient.

The guarantee is that b=1 will not become visible before a=1 is visible.
This guarantee is sufficient to cause the assertion to succeed.  I think.

> > > > In other words, if there was an rmb() in flight on one CPU, but none
> > > > of the other CPUs ever executed a memory barrier of any kind, then
> > > > the lone rmb() would not need to place any constraints on any CPU's
> > > > memory access.
> > > > 
> > > > Or, more accurately, if you wish to understand an rmb() in isolation,
> > > > you must do so in the context of a specific hardware implementation.
> > > 
> > > I'll buy that second description but not the first.  It makes no sense to
> > > say that what an rmb() instruction does to this CPU right here depends
> > > somehow on what that CPU way over there is doing.  Instructions are
> > > supposed to act locally.
> > 
> > A CPU might choose to note whether or not all the loads are to cachelines
> > in cache and whether or not there are pending invalidates to any of the
> > corresponding cachelines, and then decide to let the loads execute in
> > arbitrary order.  A CPU might also try executing the loads in arbitrary
> > order, and undo them if some event (such as reception of an invalidate)
> > occurred that invalidated the sequence chosen (speculative execution).
> > Real CPUs have been implemented in both ways, and in both cases, the
> > rmb() would have no effect on execution (in absence of interference from
> > other CPUs).
> 
> In each of these examples an rmb() _would_ place constraints on its CPU's
> memory access, by forcing the CPU to make those choices (about whether to
> check for pending invalidates and allow loads in arbitrary order) in a
> particular way.  And it would do so whether or not any other CPUs executed
> a memory barrier.

Yes, my example differed from my earlier description -- but the underlying
point manages to survive, which is that the work performed by rmb() can
depend on what the other CPUs are doing (stores in my example, as opposed
to memory barriers in the description), and that in some situations, the
rmb() need impose no constraint on the order of loads on the CPU executing
the rmb().

For example, if CPU 0 executed x=a;rmb();y=b with a and b both initially
zero, and if both a and b are in cache, and if x and y are registers,
and if there are no pending invalidates, then CPU 0 would be within its
rights to load b before loading a.

Why?  Because there is no way that any other CPU could tell that CPU 0
had misbehaved.

> About the only reason I can think of for rmb() not placing contraints on a 
> CPU's memory accesses is if those accesses are already constrained to 
> occur in strict program order.

If there is no way for other CPUs to detect the misordering, why should
CPU 0 be prohibited from doing the misordering?  Perhaps prior loads
are queued up against the cache bank containing b, while the cache bank
containing a is idle.  Why delay the load of a unnecessarily?

>                                Even then, the operation of rmb() 
> wouldn't depend on whether other CPUs had executed a memory barrier.

For the modern CPU -implementations- I am aware of, rmb()'s effect on
ordering of loads would indeed -not- depend on whether other CPUs had
executed a memory barrier.  However, at the conceptual level, if the
CPU executing an rmb() was somehow telepathically aware that none of
the other CPUs were executing memory barriers anytime near the present,
then the CPU could simply ignore the rmb().

I agree that no real CPU is going to implement this telepathic awareness,
at least not until quantum computers become real (though I have been
surprised before).  ;-)

However, as noted above, there might well be real CPUs that ignore rmb()s
when there are no interfering writes.

> > And the CPU's instructions are -still- acting locally!  ;-)
> > 
> > And I know of no non-implementation-specific reason that instructions
> > need to act locally.  Yes, things normally go faster if they do act
> > locally, but that would be an implementation issue.
> 
> Yes, all right.  It's true that a system _could_ be designed in which CPUs 
> really would coordinate directly with each other as opposed to passing 
> messages.  On such a system, rmb() could cause its CPU to ask all the 
> others whether they had done a wmb() recently or were going to do one in 
> the near future, and if the answers were all negative then the rmb() could 
> avoid putting any constraints on further memory accesses.  In theory, 
> anyway -- I'm not sure such a design would be feasible in practice.

Agreed!

However, CPUs can (and I suspect actually do) ignore memory barriers in
cases where there are no pending interfering writes.

							Thanx, Paul
