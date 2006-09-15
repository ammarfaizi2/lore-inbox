Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWIOFRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWIOFRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 01:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWIOFRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 01:17:07 -0400
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:39281
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1750716AbWIOFRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 01:17:05 -0400
Date: Thu, 14 Sep 2006 22:16:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060915051659.GA5186@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060912202329.GH1291@us.ibm.com> <Pine.LNX.4.44L0.0609131207340.5908-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609131207340.5908-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 10:58:43AM -0400, Alan Stern wrote:
> On Tue, 12 Sep 2006, Paul E. McKenney wrote:
> 
> > > Incidentally, I object very strongly to the way you hardware folk keep
> > > talking about events being only partially ordered.  This isn't the case at
> > > all.  Given a precise physical definition of what an event is (a
> > > particular transistor changing state for example, or perhaps the entire
> > > time interval starting when one transistor changes state and ending when
> > > another does), each event takes place at a moment of time or during an
> > > interval of time.
> > 
> > Sorry, but there is absolutely no way I am carrying this discussion down
> > to the transistor level.  You need to talk to a real hardware guy for
> > that.  ;-)
> 
> I don't mind keeping the discussion at a higher level.  The real point is
> that physical events occur at real, physical times.

I agree that physical events do occur at real physical times (exceptions
a la Heisenberg not being relevant to the energy levels and timescales
we are discussing, besides which -you- are the physicist, not me),
but so what?

> > > Now time really _is_ totally ordered (so long as you confine yourself to a
> > > single reference frame!) and hence in any individual run of a computer
> > > program so are the events -- provided you take proper care when discussing
> > > events that encompass a time interval.
> > 
> > But different CPUs would have different opinions about the time at which
> > a given event (e.g., a store) occurred.
> 
> That's okay.  There isn't any single notion of "This store occurred at 
> this time".  Instead, for each CPU there is a notion of "This store became 
> visible to this CPU at this time".

That is one way to look at it.  It may or may not be the best way to
look at it in a given situation -- for example, some stores never become
visible to some CPUs due to the effect of later stores.  For another
example, if the software doesn't look at a given situation, it cannot
tell whether or not a given store is visible to it.

The fact that there are indeed real events happening at real time isn't
necessarily relevant if they cannot be seen.  Accepting fuzzy stores
can decrease the size of the state space substantially.  This can be an
extremely good thing.

> >  They would also have different
> > opinions about the order in which sequences of stores occurred.
> 
> Again, not a problem.  And for the same reason.  Although if the stores 
> are all to the same location, different CPUs should _not_ have different 
> opinions about the order in which they became visible.

The different CPUs might have different opinions -- in fact, they
usually -do- have different opinions.  The constraint is instead that
their different opinions must be consistent with -at- -least- -one-
totally ordered sequence of stores.  For an example, consider three
CPUs storing to the same location concurrently, and another CPU watching.
The CPUs will agree on who was the last CPU to do the store, but might
have no idea of the order of the other two stores.

On the "not a problem", yes, you -can- model stores as a set of events
that all happen at precise but unknowable times.  You can also assert
that this is the One True Way of modeling stores, but I am not buying.

In my experience, it is often extremely helpful to model stores as
being fuzzy.  You are free to disagree, but your disagreement will
not change my memory.  ;-)

> >  So the
> > linear underlying time is not all that relevant -- maybe it is there, maybe
> > not, but software cannot see it, so it cannot rely on it.  Hence the partial
> > order.
> 
> Maybe the software can't see it directly, but it can still help when
> you're trying to reason about the program's behavior.

Yes, it -can- -sometimes- help.  Other times it can result in useless
combinatorial explosion.

> > The underlying problem is a given load or store is actually made up of
> > many events, which will occur at different times.  You could arbitrarily
> > choose a particular event as being the key event that determines the
> > time for the corresponding load or store, but this won't really help.
> > Which of the following events should determine the timestamp for a
> > given store from CPU 0?
> 
> That's not a valid notion.  Let's ask instead what is the timestamp for 
> when a given store from CPU 0 becomes visible to CPU 1.

Yes it is a valid notion.

Yes, your question is sometimes the right thing to ask.  But not always.

> > 1.	When the instruction determines what value to store?
> > 
> > 2.	When an entry on CPU 0's store queue becomes available?
> > 
> > 3.	When the store-queue entry is filled in?  (This is the earliest
> > 	time that makes sense to me.)
> > 
> > 4.	When the invalidation request is transmitted (and more than
> > 	one such transmission is required on some architectures)?
> > 
> > 5.	When the invalidation request is received?  If so, by which
> > 	CPU?
> > 
> > 6.	When CPUs send acknowledgements for the invalidation requests?
> 
> This is a very good candidate: when CPU 1 sends its acknowledgement.  Any
> read on CPU 1 which commits to a return value before this time will not
> see the new value.  A read on CPU 1 which commits to a return value after
> this time may see the new value.

You cannot see it from software, so it is difficult to make use of,
unless you are running your software in an extremely detailed simulator
or on some types of in-circuit emulators.

I have sometimes had to live in this space, including quite recently.
Trust me, it is -not- where you want to be!!!

> > 7.	When CPU 0 receives the acknowledgments?  (The reception of
> > 	the last such acknowledgement would be a reasonable choice
> > 	in some cases.)
> > 
> > 8.	When CPU 0 applies the store-queue entry to the cache line?
> > 
> > 9.	When the other CPUs process the invalidate request?
> > 	(The processing of the invalidate request at the last
> > 	CPU to do so would be another reasonable choice in some cases.)
> > 
> > I have an easier time thinking of this as a partial order than to try
> > to keep track of many individual events that I cannot accurately measure.
> 
> All right, let's express things in terms of the partial order.  In those 
> terms, this is the principle you would expound:
> 
> (P1):	If two writes are ordered on the same CPU and two reads are
> 	ordered on another CPU, and the first read sees the result of
> 	the second write, then the second read will see the result of
> 	the first write.
> 
> Correct?

Partially.

(P1a):	If two writes are ordered on one CPU, and two reads are ordered
	on another CPU, and if the first read sees the result of the
	second write, then the second read will see the result of the
	first write.

(P1b):	If a read is ordered before a write on each of two CPUs,
	and if the read on the second CPU sees the result of the write
	on the first CPU, then the read on the first CPU will -not-
	see the result of the write on the second CPU.

(P2):	All CPUs will see the results of writes to a single location
	in orderings consistent with at least one total global order
	of writes to that single location.

> > > The difficulty is that program runs have a stochastic character; it's
> > > difficult or impossible to predict exactly what the hardware will do.  So
> > > the same program events could be ordered one way during a run and the
> > > opposite way during another run.  Each run is still totally ordered.
> > 
> > But if I must prove some property for all possible actual orderings, then
> > keeping track of a partial ordering does make sense.  Enumerating all of
> > the possible actual orderings is often infeasible.
> 
> You don't have to enumerate all possible cases to prove things.  
> Mathematics would still be stuck back at the time of the ancient Greeks if
> that were so.

You are correct that I was being overly dramatic.  Still, explicitly
demonstrating collapse of the state space is best avoided in many cases.

> > > If you want, you can derive a partial ordering by considering only those
> > > pairs of events that will _always_ occur in the same order in _every_ run.
> > > But thinking in terms of this sort of partial ordering is clearly
> > > inadequate.  It doesn't even let you derive the properties of the
> > > "canonical" pattern:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	a = 1;			y = b;
> > > 	wmb();			rmb();
> > > 	b = 1;			x = a;
> > > 				assert(!(y==1 && x==0));
> > > 
> > > In terms of partial orderings, we know that all the events on CPU 0 are
> > > ordered by the wmb() and the events on CPU 1 are ordered by the rmb().  
> > > But there is no ordering relation between the events on the two CPUs.  "y
> > > = b" could occur either before or after "b = 1", hence these two events
> > > are incomparable in the partial ordering.  So you can't conclude anything
> > > about the assertion, if you confine your thinking to the partial ordering.
> > 
> > But I don't need absolute timings, all I need to know is whether or not
> > CPU 1's "y=b" sees CPU 0's "b=1".
> 
> How does the partial-ordering point of view help you understand the
> read-mb-write pattern?
> 
> 	CPU 0			CPU 1
> 	-----			-----

All variables initially zero, correct?

> 	x = a;			y = b + 1;
> 	mb();			mb();
> 	b = 1;			a = 1;
> 	assert(!(x==1 && y!=1));
> 
> You would need an additional principle similar to P1 above.  Trying to
> apply P1 won't work; all you can deduce is that CPU 1 writes y and a
> whereas CPU 0 reads a and y, hence CPU 1 can assert only (!(x==1 &&
> y==0)), not (!(x==1 && y!=1)).

Yep, you need both my P1a (same as your P1) and my P1b.

> This idea, that some _new_ principle P2 is needed to explain
> read-mb-write, is one of the major points I have been trying to establish
> here.  Discussions like David's always mention P1 but they hardly ever
> mention this P2.  In fact I can't recall ever seeing it mentioned before
> this email thread.  And yet, as we've seen, P2 is essential for explaining
> why synchronization primitives work.

Is your P2 the same as my P1b?  If so, we might well be in agreement!  ;-)

> > > One could derive the result a little more formally using the causality 
> > > principle I mentioned above (LOAD before STORE cannot return the result of 
> > > the STORE) together with another causality principle: A CPU cannot make 
> > > the result of a STORE available to other CPUs (or to itself) before it 
> > > knows the value to be stored.  A cache might send out invalidate messages 
> > > before knowing the value to be stored, but it can't send out read 
> > > responses.
> > 
> > Yes but...  Some other CPU might see the resulting store before it
> > saw the information that the storing CPU based the stored value on.
> 
> Nothing wrong with that.  As I have mentioned before, stores don't have to 
> become visible to all CPUs at the same time.

Agreed.

> > > What do you mean by "violate causality"?  Storing a value in y (and making
> > > that value available to the other CPU) before the read has obtained b's
> > > value?  I don't see how that could happen on any architecture, unless your 
> > > machine uses thiotimoline.  :-)
> > 
> > Different CPUs can perceive a given event happening at different times,
> > so other CPUs might see the store into y before they saw the logically
> > earlier store into b.
> 
> Nothing wrong with that either, and for the same reason.

It breaks the intuitive notion of transitivity in some cases.

Stores "passing in the night", for example.

> >  Thiotimoline available on eBay?  I would be indeed
> > be interested!  ;-)
> 
> You and me both!

;-)

> > Your point might be that this example doesn't care, given that the CPU
> > doing the store into y is also doing the assert, but that doesn't change
> > my basic point that you have to be -very- careful when using causality
> > arguments when working out memory ordering.
> 
> I think that all you really need to do is remember that statements can be 
> reordered, that stores become visible to different CPUs at different 
> times, and that loads don't always return the value of the last visible 
> store.  Everything else is intuitive -- except for the way memory barriers 
> work!

Let me get this right.  In your viewpoint, memory barriers are strongly
counter-intuitive, yet you are trying to convince me to switch to your
viewpoint?  ;-)

(Seriously, you have convinced me that current explanations of memory
barriers fall short -- which I do very much appreciate!)

> > > I wouldn't put it that way.  Knowing that CPUs are free to reorder
> > > operations in the absence of barriers to prevent such things, the
> > > violation you mention wouldn't seem unintuitive to me.  I tend to have 
> > > more trouble remembering that reads don't necessarily have to return the 
> > > most recent values available.
> > 
> > So do I, which is one reason that I resist the notion that stores happen
> > at a single specific time.  If I consider stores to be fuzzy events, then
> > it is easier to for me to keep in mind that concurrent reads to the
> > same value from different CPUs might return different values.
> 
> Instead of considering stores to be fuzzy events, you can think of them as
> becoming visible at precise times to individual CPUs.  That sort of
> reasoning would help someone to understand P2, whereas the
> partially-ordered fuzzy-events approach would not.

Sure, I most certainly could.  But in many cases, it is better not to.

> > > > > This read-mb-write pattern turns out to be vital for implementing
> > > > > sychronization primitives.  Take your own example:
> > > > > 
> > > > > > Consider the following (lame) definitions for spinlock primitives,
> > > > > > but in an alternate universe where atomic_xchg() did not imply a
> > > > > > memory barrier, and on a weak-memory CPU:
> > > > > > 
> > > > > > 	typedef spinlock_t atomic_t;
> > > > > > 
> > > > > > 	void spin_lock(spinlock_t *l)
> > > > > > 	{
> > > > > > 		for (;;) {
> > > > > > 			if (atomic_xchg(l, 1) == 0) {
> > > > > > 				smp_mb();
> > > > > > 				return;
> > > > > > 			}
> > > > > > 			while (atomic_read(l) != 0) barrier();
> > > > > > 		}
> > > > > > 
> > > > > > 	}
> > > > > > 
> > > > > > 	void spin_unlock(spinlock_t *l)
> > > > > > 	{
> > > > > > 		smp_mb();
> > > > > > 		atomic_set(l, 0);
> > > > > > 	}
> > > > > > 
> > > > > > The spin_lock() primitive needs smp_mb() to ensure that all loads and
> > > > > > stores in the following critical section happen only -after- the lock
> > > > > > is acquired.  Similarly for the spin_unlock() primitive.
> > > > > 
> > > > > In fact that last paragraph isn't quite right.  The spin_lock()
> > > > > primitive would also work with smp_rmb() in place of smb_mb().  (I can
> > > > > explain my reasoning later, if you're interested.)
> > > > 
> > > > With smp_rmb(), why couldn't the following, given globals b and c:
> > > > 
> > > > 	spin_lock(&mylock);
> > > > 	b = 1;
> > > > 	c = 1;
> > > > 	spin_unlock(&mylock);
> > > > 
> > > > be executed by the CPU as follows?
> > > > 
> > > > 	c = 1;
> > > > 	b = 1;
> > > > 	spin_lock(&mylock);
> > > > 	spin_unlock(&mylock);
> > > 
> > > Because of the conditional in spin_lock().
> > > 
> > > > This order of execution seems to me to be highly undesireable.  ;-)
> > > > 
> > > > So, what am I missing here???
> > > 
> > > A CPU cannot move a write back past a conditional.  Otherwise it runs
> > > the risk of committing the write when (according to the program flow) the
> > > write should never have taken place.  No CPU does speculative writes.
> > 
> > From the perspective of some other CPU holding the lock, agreed (I
> > think...).  From the perspective of some other CPU reading the lock
> > word and the variables b and c, I do not agree.  The CPU doing the
> > stores does not have to move the writes back past the conditional --
> > all it has to do is move the "c=1" and "b=1" stores back past the store
> > implied by the atomic operation in the spin_lock().  All three stores
> > then appear to have happened after the conditional.
> 
> Ah.  I'm glad you mentioned this.
> 
> Yes, it's true that given sufficiently weak ordering, the writes could 
> be moved back inbetween the load and store implicit in the atomic 
> exchange.  It's worth pointing out that even if this does occur, it will 
> not be visible to any CPU that accesses b and c only from within a 
> critical section.

The other key point is that some weakly ordered CPUs were designed
only to make spinlocks work.

>                   But it could be visible in a situation like this:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 	[call spin_lock(&mylock)]	x = b;
> 	read mylock, obtain 0		mb();
> 	b = 1; [moved up]		y = atomic_read(&mylock);
> 	write mylock = 1
> 	rmb();
> 	[leave spin_lock()]
> 					mb();
> 					assert(!(x==1 && y==0 && c==0));
> 	c = 1;
> 	spin_unlock(&mylock);
> 
> The assertion could indeed fail.  HOWEVER...
> 
> What you may not realize is that even when spin_lock() contains your
> original full mb(), if CPU 0 reads b (instead of writing b) that read
> could appear to another CPU to have occurred before the write to mylock.  
> Example:
> 
> 	CPU 0				CPU 1
> 	-----				-----

All variables initially zero?

> 	[call spin_lock(&mylock)]	b = 1;
> 	read mylock, obtain 0		mb();
> 	write mylock = 1		y = atomic_read(&mylock);
> 	mb();
> 	[leave spin_lock()]
> 
> 	x = b + 1;			mb();
> 					assert(!(x==1 && y==0 && c==0));
> 	c = 1;
> 	spin_unlock(&mylock);
> 
> If the assertion fails, then CPU 1 will think that CPU 0 read the value of 
> b before setting mylock to 1.  But the assertion can fail!  It's another 
> example of the write-mb-read pattern.  If CPU 0's write to mylock crosses 
> with CPU 1's write to b, then both CPU 0's read of b and CPU 1's read of 
> mylock could obtain the old values.
> 
> So in this respect your implementation already fails to prevent reads from 
> leaking partway out of the critical section.  My implementation does the 
> same thing with writes, but otherwise is no worse.

But isn't this the write-memory-barrier-read sequence that you (rightly)
convinced me was problematic in earlier email?

> > > What's the difference between imposing an ordering constraint and forcing
> > > two events to occur in a particular order?  To me the phrases appear
> > > synonymous.
> > 
> > That is because you persist in believing that things happen at a
> > well-defined single time.  ;-)
> 
> Physical events _do_ happen at well-defined times.  Even if we don't know 
> exactly when those times occur.

Yes.  But that doesn't -require- me to think in those terms.

> > > A more correct pattern would have to look like this:
> > > 
> > > 	CPU 0			CPU 1
> > > 	-----			-----
> > > 	while (c == 0) ;	wmb();
> > > 				// Earlier writes to a or b are now flushed
> > > 				c = 1;
> > > 
> > > 	// arbitrarily long delay with neither CPU writing to a or b
> > > 
> > > 	a = 1;			y = b;
> > > 	wmb();			rmb();
> > > 	b = 1;			x = a;
> > > 				assert(!(y==1 && x==0));
> > > 
> > > In general you might say that a LOAD following rmb won't return the value 
> > > from any STORE that became visible before the rmb other than the last one.  
> > > But that leaves open the question of which STOREs actually do become 
> > > visible.  I don't know how to deal with that in general.
> > 
> > The best answer I can give is that an rmb() -by- -itself- means absolutely
> > nothing.  The only way it has any meaning is in conjunction with an
> > mb() or a wmb() on some other CPU.  The "pairwise" stuff in David's
> > documentation.
> 
> Even that isn't enough.  You also have to have some sort of additional 
> information that can guarantee CPU 0's write to b will become visible to 
> CPU 1.  If it never becomes visible then the assertion could fail.

Eh?  If the write to b never becomes visible, then y==0, and the assertion
always succeeds.  Or am I misreading this example?

> But I can't think of any reasonable way to obtain such a guarantee that 
> isn't implementation-specific.  Which leaves things in a rather 
> unsatisfactory state...

But arbitrary delays can happen due to interrupts, preemption, etc.
So you are simply not allowed such a guarantee.

> > In other words, if there was an rmb() in flight on one CPU, but none
> > of the other CPUs ever executed a memory barrier of any kind, then
> > the lone rmb() would not need to place any constraints on any CPU's
> > memory access.
> > 
> > Or, more accurately, if you wish to understand an rmb() in isolation,
> > you must do so in the context of a specific hardware implementation.
> 
> I'll buy that second description but not the first.  It makes no sense to
> say that what an rmb() instruction does to this CPU right here depends
> somehow on what that CPU way over there is doing.  Instructions are
> supposed to act locally.

A CPU might choose to note whether or not all the loads are to cachelines
in cache and whether or not there are pending invalidates to any of the
corresponding cachelines, and then decide to let the loads execute in
arbitrary order.  A CPU might also try executing the loads in arbitrary
order, and undo them if some event (such as reception of an invalidate)
occurred that invalidated the sequence chosen (speculative execution).
Real CPUs have been implemented in both ways, and in both cases, the
rmb() would have no effect on execution (in absence of interference from
other CPUs).

And the CPU's instructions are -still- acting locally!  ;-)

And I know of no non-implementation-specific reason that instructions
need to act locally.  Yes, things normally go faster if they do act
locally, but that would be an implementation issue.

> > > Perhaps you could explain why (other than the fact that it might fail!).
> > 
> > Ummm...  Isn't that reason enough?
> > 
> > One reason is that the ++cnt can be reordered by both CPU and compiler
> > to precede some of the code in "// Do something time-consuming with *x".
> > I am assuming that only one thread is permitted to execute in the loop
> > at the same time, otherwise there are many other failure mechanisms.
> 
> Yes.  There would have to be a barrier before ++cnt.

Or the CPU on the peripheral controller might do strict in-order
execution.  But that would be equivalent to having full barriers
between all instructions, so ends up agreeing with your point.

> > > I actually do have code like this in one of my drivers.  But there are
> > > significant differences from the example.  In the driver T0 doesn't run on
> > > a CPU; it runs on a peripheral controller which accesses p via DMA and
> > > makes cnt available over the I/O bus (inw).
> > 
> > OK, so there is only one thread T0...   And so it depends on the
> > peripheral controller's memory model.  I would hope that they sorted
> > out the synchronization.  ;-)
> 
> Me too!

;-)  ;-)

							Thanx, Paul
