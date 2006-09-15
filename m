Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWIOTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWIOTsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWIOTsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:48:33 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:29447 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751606AbWIOTsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:48:32 -0400
Date: Fri, 15 Sep 2006 15:48:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060915051659.GA5186@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609151007510.12515-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this stage I think we're violently approaching agreement.  :-)


On Thu, 14 Sep 2006, Paul E. McKenney wrote:

> > That's okay.  There isn't any single notion of "This store occurred at 
> > this time".  Instead, for each CPU there is a notion of "This store became 
> > visible to this CPU at this time".
> 
> That is one way to look at it.  It may or may not be the best way to
> look at it in a given situation -- for example, some stores never become
> visible to some CPUs due to the effect of later stores.  For another
> example, if the software doesn't look at a given situation, it cannot
> tell whether or not a given store is visible to it.
> 
> The fact that there are indeed real events happening at real time isn't
> necessarily relevant if they cannot be seen.  Accepting fuzzy stores
> can decrease the size of the state space substantially.  This can be an
> extremely good thing.

Okay.  I'll allow that both points of view are valid and each can be 
useful in its own way.


> > Again, not a problem.  And for the same reason.  Although if the stores 
> > are all to the same location, different CPUs should _not_ have different 
> > opinions about the order in which they became visible.
> 
> The different CPUs might have different opinions -- in fact, they
> usually -do- have different opinions.  The constraint is instead that
> their different opinions must be consistent with -at- -least- -one-
> totally ordered sequence of stores.  For an example, consider three
> CPUs storing to the same location concurrently, and another CPU watching.
> The CPUs will agree on who was the last CPU to do the store, but might
> have no idea of the order of the other two stores.

The only way a CPU can have no idea of the order of the other two stores
is if it fails to see one or both of them.  If it does see both stores
then of course it knows in what order it saw them.

A less ambiguous way to phrase what I said before would be: two CPUs
should not have different opinions about the order in which two stores
became visible, provided both stores were visible to both CPUs.  Obviously 
if a CPU doesn't see both of the stores then it can't have any opinion 
about their ordering.


> > (P1):	If two writes are ordered on the same CPU and two reads are
> > 	ordered on another CPU, and the first read sees the result of
> > 	the second write, then the second read will see the result of
> > 	the first write.
> > 
> > Correct?
> 
> Partially.
> 
> (P1a):	If two writes are ordered on one CPU, and two reads are ordered
> 	on another CPU, and if the first read sees the result of the
> 	second write, then the second read will see the result of the
> 	first write.
> 
> (P1b):	If a read is ordered before a write on each of two CPUs,
> 	and if the read on the second CPU sees the result of the write
> 	on the first CPU, then the read on the first CPU will -not-
> 	see the result of the write on the second CPU.
> 
> (P2):	All CPUs will see the results of writes to a single location
> 	in orderings consistent with at least one total global order
> 	of writes to that single location.

As you noted, your P1b is what I had called P2.  It is usually not
presented in dicussions about memory barriers.  Nevertheless it is the
only justification for the mb() instruction; P1a talks about only rmb()  
and wmb().


> > I think that all you really need to do is remember that statements can be 
> > reordered, that stores become visible to different CPUs at different 
> > times, and that loads don't always return the value of the last visible 
> > store.  Everything else is intuitive -- except for the way memory barriers 
> > work!
> 
> Let me get this right.  In your viewpoint, memory barriers are strongly
> counter-intuitive, yet you are trying to convince me to switch to your
> viewpoint?  ;-)

Not the barriers themselves, but how they work!  You have to agree that
their operation is deeply tied into the low-level nature of the
memory-access hardware on any particular system.  Much more so than for
most instructions.


> > Yes, it's true that given sufficiently weak ordering, the writes could 
> > be moved back inbetween the load and store implicit in the atomic 
> > exchange.  It's worth pointing out that even if this does occur, it will 
> > not be visible to any CPU that accesses b and c only from within a 
> > critical section.
> 
> The other key point is that some weakly ordered CPUs were designed
> only to make spinlocks work.
> 
> >                   But it could be visible in a situation like this:
> > 
> > 	CPU 0				CPU 1
> > 	-----				-----
> > 	[call spin_lock(&mylock)]	x = b;
> > 	read mylock, obtain 0		mb();
> > 	b = 1; [moved up]		y = atomic_read(&mylock);
> > 	write mylock = 1
> > 	rmb();
> > 	[leave spin_lock()]
> > 					mb();
> > 					assert(!(x==1 && y==0 && c==0));
> > 	c = 1;
> > 	spin_unlock(&mylock);
> > 
> > The assertion could indeed fail.  HOWEVER...
> > 
> > What you may not realize is that even when spin_lock() contains your
> > original full mb(), if CPU 0 reads b (instead of writing b) that read
> > could appear to another CPU to have occurred before the write to mylock.  
> > Example:
> > 
> > 	CPU 0				CPU 1
> > 	-----				-----
> 
> All variables initially zero?

Of course.

> > 	[call spin_lock(&mylock)]	b = 1;
> > 	read mylock, obtain 0		mb();
> > 	write mylock = 1		y = atomic_read(&mylock);
> > 	mb();
> > 	[leave spin_lock()]
> > 
> > 	x = b + 1;			mb();
> > 					assert(!(x==1 && y==0 && c==0));
> > 	c = 1;
> > 	spin_unlock(&mylock);
> > 
> > If the assertion fails, then CPU 1 will think that CPU 0 read the value of 
> > b before setting mylock to 1.  But the assertion can fail!  It's another 
> > example of the write-mb-read pattern.  If CPU 0's write to mylock crosses 
> > with CPU 1's write to b, then both CPU 0's read of b and CPU 1's read of 
> > mylock could obtain the old values.
> > 
> > So in this respect your implementation already fails to prevent reads from 
> > leaking partway out of the critical section.  My implementation does the 
> > same thing with writes, but otherwise is no worse.
> 
> But isn't this the write-memory-barrier-read sequence that you (rightly)
> convinced me was problematic in earlier email?

Indeed it is.  The problematic nature of that sequence means that in the 
right conditions, a read can appear to leak partially in front of a 
spin_lock().


> > > > A more correct pattern would have to look like this:
> > > > 
> > > > 	CPU 0			CPU 1
> > > > 	-----			-----
> > > > 	while (c == 0) ;	wmb();
> > > > 				// Earlier writes to a or b are now flushed
> > > > 				c = 1;
> > > > 
> > > > 	// arbitrarily long delay with neither CPU writing to a or b
> > > > 
> > > > 	a = 1;			y = b;
> > > > 	wmb();			rmb();
> > > > 	b = 1;			x = a;
> > > > 				assert(!(y==1 && x==0));
> > > > 
> > > > In general you might say that a LOAD following rmb won't return the value 
> > > > from any STORE that became visible before the rmb other than the last one.  
> > > > But that leaves open the question of which STOREs actually do become 
> > > > visible.  I don't know how to deal with that in general.
> > > 
> > > The best answer I can give is that an rmb() -by- -itself- means absolutely
> > > nothing.  The only way it has any meaning is in conjunction with an
> > > mb() or a wmb() on some other CPU.  The "pairwise" stuff in David's
> > > documentation.
> > 
> > Even that isn't enough.  You also have to have some sort of additional 
> > information that can guarantee CPU 0's write to b will become visible to 
> > CPU 1.  If it never becomes visible then the assertion could fail.
> 
> Eh?  If the write to b never becomes visible, then y==0, and the assertion
> always succeeds.  Or am I misreading this example?

Sorry, typo.  I meant CPU 0's write to a, not its write to b.  If you 
can't guarantee that CPU 0's write to a will become visible to CPU 1 then 
you can't guarantee the assertion will succeed.

> > But I can't think of any reasonable way to obtain such a guarantee that 
> > isn't implementation-specific.  Which leaves things in a rather 
> > unsatisfactory state...
> 
> But arbitrary delays can happen due to interrupts, preemption, etc.
> So you are simply not allowed such a guarantee.

The delay isn't important.  What matters is that whatever else may happen 
during the delay, neither CPU writes anything to a or b.

Strictly speaking even that's not quite right.  What's needed is a 
condition that can guarantee CPU 0's write to a will become visible to 
CPU 1.  Flushing CPU 1's store buffer may not be sufficient.


> > > In other words, if there was an rmb() in flight on one CPU, but none
> > > of the other CPUs ever executed a memory barrier of any kind, then
> > > the lone rmb() would not need to place any constraints on any CPU's
> > > memory access.
> > > 
> > > Or, more accurately, if you wish to understand an rmb() in isolation,
> > > you must do so in the context of a specific hardware implementation.
> > 
> > I'll buy that second description but not the first.  It makes no sense to
> > say that what an rmb() instruction does to this CPU right here depends
> > somehow on what that CPU way over there is doing.  Instructions are
> > supposed to act locally.
> 
> A CPU might choose to note whether or not all the loads are to cachelines
> in cache and whether or not there are pending invalidates to any of the
> corresponding cachelines, and then decide to let the loads execute in
> arbitrary order.  A CPU might also try executing the loads in arbitrary
> order, and undo them if some event (such as reception of an invalidate)
> occurred that invalidated the sequence chosen (speculative execution).
> Real CPUs have been implemented in both ways, and in both cases, the
> rmb() would have no effect on execution (in absence of interference from
> other CPUs).

In each of these examples an rmb() _would_ place constraints on its CPU's
memory access, by forcing the CPU to make those choices (about whether to
check for pending invalidates and allow loads in arbitrary order) in a
particular way.  And it would do so whether or not any other CPUs executed
a memory barrier.

About the only reason I can think of for rmb() not placing contraints on a 
CPU's memory accesses is if those accesses are already constrained to 
occur in strict program order.  Even then, the operation of rmb() 
wouldn't depend on whether other CPUs had executed a memory barrier.

> And the CPU's instructions are -still- acting locally!  ;-)
> 
> And I know of no non-implementation-specific reason that instructions
> need to act locally.  Yes, things normally go faster if they do act
> locally, but that would be an implementation issue.

Yes, all right.  It's true that a system _could_ be designed in which CPUs 
really would coordinate directly with each other as opposed to passing 
messages.  On such a system, rmb() could cause its CPU to ask all the 
others whether they had done a wmb() recently or were going to do one in 
the near future, and if the answers were all negative then the rmb() could 
avoid putting any constraints on further memory accesses.  In theory, 
anyway -- I'm not sure such a design would be feasible in practice.

Alan Stern

