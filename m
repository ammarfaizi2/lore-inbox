Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWIRTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIRTMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWIRTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:12:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:24223 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751659AbWIRTMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:12:47 -0400
Date: Mon, 18 Sep 2006 12:13:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060918191338.GH1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060916041905.GD1289@us.ibm.com> <Pine.LNX.4.44L0.0609161043540.10946-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609161043540.10946-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 11:28:39AM -0400, Alan Stern wrote:
> On Fri, 15 Sep 2006, Paul E. McKenney wrote:
> 
> > > > (P1a):	If two writes are ordered on one CPU, and two reads are ordered
> > > > 	on another CPU, and if the first read sees the result of the
> > > > 	second write, then the second read will see the result of the
> > > > 	first write.
> > > > 
> > > > (P1b):	If a read is ordered before a write on each of two CPUs,
> > > > 	and if the read on the second CPU sees the result of the write
> > > > 	on the first CPU, then the read on the first CPU will -not-
> > > > 	see the result of the write on the second CPU.
> > > > 
> > > > (P2):	All CPUs will see the results of writes to a single location
> > > > 	in orderings consistent with at least one total global order
> > > > 	of writes to that single location.
> > > 
> > > As you noted, your P1b is what I had called P2.  It is usually not
> > > presented in dicussions about memory barriers.  Nevertheless it is the
> > > only justification for the mb() instruction; P1a talks about only rmb()  
> > > and wmb().
> > 
> > And there is a P1c:
> > 
> > (P1c):	If one CPU does a load from A ordered before a store to B,
> > 	and if a second CPU does a store to B ordered before a
> > 	store to A, and if the first CPU's load from A gives
> > 	the value stored by the second CPU, then the first CPU's
> > 	store to B must happen after the second CPU's store to B,
> > 	hence the value stored by the first CPU persists.  (Or,
> > 	for the more competitively oriented, the first CPU's store
> > 	to B "wins".)
> > 
> > I am mapping out a complete set -- these three might cover them all,
> > but need to revisit after sleeping on it.  I also need to run this
> > by some CPU architects...
> 
> I wonder if it really is possible to find a complete set.  Perhaps 
> examples can become arbitrarily complex and only some formal logical 
> system would be able to generate all of them.  If that's the case then I 
> would like to know what that logical system is.

Here is my nomination for the complete set:

	A|B  B|A

	L|L  L|L -- Independent of ordering
	L|L  L|S -- Pointless, since there is no second store
	L|L  S|L -- Pointless, since there is no second store
	L|L  S|S -- first pairing

	L|S  L|L -- (DUP) single-store pointless
	L|S  L|S -- second pairing
	L|S  S|L -- problematic store-barrier-load
	L|S  S|S -- If CPU 0's load sees CPU 1's 2nd store, then CPU 0's
			store wins.  (third pairing)

	S|L  L|L -- (DUP) single-store pointless
	S|L  L|S -- (DUP) problematic store-barrier-load
	S|L  S|L -- (DUP) problematic store-barrier-load
	S|L  S|S -- (DUP) problematic store-barrier-load

	S|S  L|L -- (DUP) first pairing
	S|S  L|S -- (DUP) winning store.
	S|S  S|L -- (DUP) problematic store-barrier-load
	S|S  S|S -- Pointless, no loads

The first column is CPU 0's actions, the second is CPU 1's actions.
"S" is store, "L" is load.  CPU 0 accesses A first, then B, while
CPU 1 does the opposite.  The commentary is my guess at what happens.

I believe that more complex cases can be handled by superposition.
For example, if CPU 0 load A, does a barrier, stores B and C, while
CPU 1 loads B and C, does a barrier, and stores A, then one can apply
the "second pairing" twice, once for A and B, and again for A and C.
If B and C are the same variable, then P2 would also apply.

Counterexamples?  ;-)

> In any case, it is important to distinguish carefully between the two
> classes of effects caused by memory barriers:
> 
> 	They prevent CPUs from reordering certain types of instructions;
> 
> 	They cause certain loads to obtain the results of certain stores.
> 
> The first is more of an effect on the CPUs whereas the second is more
> of an effect on the caches.

>From where I sit, the second is the architectural constraint, while the
first is implementation-specific.  So I am very concerned about the
second, but worried only about the first as needed to give examples.

> > > > But isn't this the write-memory-barrier-read sequence that you (rightly)
> > > > convinced me was problematic in earlier email?
> > > 
> > > Indeed it is.  The problematic nature of that sequence means that in the 
> > > right conditions, a read can appear to leak partially in front of a 
> > > spin_lock().
> > 
> > The above sequence can reasonably be interpreted as having that effect.
> > Good reason to be -very- careful when modifying data used by a given
> > critical section without the protection of the corresponding lock.
> 
> The write-mb-read sequence is a good example showing how naive reasoning
> about memory barriers can give wrong answers.

That too!!!  ;-)

> > > Sorry, typo.  I meant CPU 0's write to a, not its write to b.  If you 
> > > can't guarantee that CPU 0's write to a will become visible to CPU 1 then 
> > > you can't guarantee the assertion will succeed.
> > 
> > Ah!
> > 
> > But if CPU 0's write to a is indefinitely delayed, then, by virtue of
> > CPU 0's wmb(), CPU 0's write to b must also be indefinitely delayed.
> > In this case, y==0&&x==0, so the assertion again always succeeds.
> 
> There are other reasons for a write not becoming visible besides being
> indefinitely delayed.  It could be masked entirely by a separate write.

OK.  I was assuming that there was no such separate write.  After all,
you didn't show it on your diagram.

If there was an additional write, then (P2) would apply if from CPU 0.
If it is from some other CPU, then the circumstances of that other write
are needed to work out what happens.

> > The guarantee is that b=1 will not become visible before a=1 is visible.
> > This guarantee is sufficient to cause the assertion to succeed.  I think.
> 
> No -- the guarantee is that _if_ a=1 and b=1 both become visible then
> a=1 will become visible first.  But it's possible for b=1 to become
> visible and a=1 not to, which would go against your wording of the
> guarantee.

Good point -- though I might choose to explicitly specify that there are
no other writes to the variables instead.  Then use an example showing
that if other writes are possible, that they need to be accounted for.

> > > In each of these examples an rmb() _would_ place constraints on its CPU's
> > > memory access, by forcing the CPU to make those choices (about whether to
> > > check for pending invalidates and allow loads in arbitrary order) in a
> > > particular way.  And it would do so whether or not any other CPUs executed
> > > a memory barrier.
> > 
> > Yes, my example differed from my earlier description -- but the underlying
> > point manages to survive, which is that the work performed by rmb() can
> > depend on what the other CPUs are doing (stores in my example, as opposed
> > to memory barriers in the description), and that in some situations, the
> > rmb() need impose no constraint on the order of loads on the CPU executing
> > the rmb().
> > 
> > For example, if CPU 0 executed x=a;rmb();y=b with a and b both initially
> > zero, and if both a and b are in cache, and if x and y are registers,
> > and if there are no pending invalidates, then CPU 0 would be within its
> > rights to load b before loading a.
> > 
> > Why?  Because there is no way that any other CPU could tell that CPU 0
> > had misbehaved.
> 
> I think now we're getting into semantics.  If rmb() causes a CPU (or
> cache) to modify its behavior based on what invalidates are pending,
> is this behavior change local to the CPU (& cache) or not?  Checking
> the queue of pending invalidates is indeed a local behavior, but the
> contents of that table will depend on what other CPUs do.
> 
> So I can reasonably say that rmb() causes a CPU to change its behavior
> based on its invalidate queue and this is a local change (given the
> same contents of the queue the CPU will always behave the same way,
> regardless of what other CPUs are doing).  And you can also reasonably
> say that rmb() causes a CPU to adjust its behavior according to the
> actions of other CPUs, because those actions will be reflected in the
> contents of the invalidate queue.

That does seem to be about the size of it.

> > > About the only reason I can think of for rmb() not placing contraints on a 
> > > CPU's memory accesses is if those accesses are already constrained to 
> > > occur in strict program order.
> > 
> > If there is no way for other CPUs to detect the misordering, why should
> > CPU 0 be prohibited from doing the misordering?  Perhaps prior loads
> > are queued up against the cache bank containing b, while the cache bank
> > containing a is idle.  Why delay the load of a unnecessarily?
> 
> Ah, but how does the CPU _know_ there is no way for other CPUs to
> detect the misordering?  Semantics again.

In an efficient hardware implementation, by inspecting its local state,
of course!  ;-)

> > For the modern CPU -implementations- I am aware of, rmb()'s effect on
> > ordering of loads would indeed -not- depend on whether other CPUs had
> > executed a memory barrier.  However, at the conceptual level, if the
> > CPU executing an rmb() was somehow telepathically aware that none of
> > the other CPUs were executing memory barriers anytime near the present,
> > then the CPU could simply ignore the rmb().
> > 
> > I agree that no real CPU is going to implement this telepathic awareness,
> > at least not until quantum computers become real (though I have been
> > surprised before).  ;-)
> > 
> > However, as noted above, there might well be real CPUs that ignore rmb()s
> > when there are no interfering writes.
> 
> In the model we've been talking about, where the CPU sends requests to
> the cache and the cache carries them out, I think the CPU can't afford
> to ignore rmb()s.  That is, only the cache knows whether there are any
> interfering writes, so the CPU has to respect the ordering enforced
> by the rmb().  Of course, the cache would then be free to interchange
> the loads.
> 
> Agreed, other architectural models could behave differently.

So one approach would be to describe the abstract ordering principles,
show how they work in code snippets, and then give a couple "bookend"
examples of hardware being creative about adhering to these principles.

Seem reasonable?

							Thanx, Paul
