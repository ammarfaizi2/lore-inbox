Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWJMQuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWJMQuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWJMQuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:50:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55455 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751385AbWJMQuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:50:09 -0400
Date: Fri, 13 Oct 2006 09:51:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061013165112.GB1722@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061004153528.GA1584@us.ibm.com> <Pine.LNX.4.44L0.0610041324540.25067-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610041324540.25067-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 02:04:36PM -0400, Alan Stern wrote:
> On Wed, 4 Oct 2006, Paul E. McKenney wrote:
> 
> > > > Ah!  So ld(A,n) sees st(A,i) for the largest i<n?
> > > 
> > > No, the index numbers don't have any intrinsic meaning.  They're just 
> > > labels.  They don't have to appear in any numerical or temporal sequence.  
> > > You can think of them as nothing more than line numbers in the source 
> > > code.
> > > 
> > > Whether or not a particular load (considered as a line of code in the 
> > > program source) sees a particular store depends on the execution details.  
> > > The labels you put on the source lines have nothing to do with it.
> > 
> > OK.  Would a given label be repeated if the corresponding load was in
> > a loop or something?
> 
> I knew you would ask that!  No, for different iterations of a loop you 
> would use different labels.  They don't correspond exactly to locations in 
> the source code, more like to particular events during the execution.

Sorry to be so predictable.  ;-)

Just for full disclosure, my experience has been than formal models
of memory ordering are not all that helpful in explaining memory ordering
to people.  They -can- be good for formal verification, but their
track record even in that area has not been particularly stellar.

Formal verification of a particular -implementation- is another story,
that has worked -very- well -- but I am hoping for some machine
independence!

> > > I don't know quite how to deal with it.  It's beginning to look like the 
> > > original definition of "comes before" was too narrow.  We should instead 
> > > say that a store "comes before" a load if the load _would_ return the 
> > > value of the store, had there been no intervening stores.
> > 
> > Another approach is to define a (conceptual!!!) version number for each
> > variable that increments on every store to that variable.  Then a store
> > "comes before" a load if the load returns the value stored or some value
> > corresponding to a larger version number.
> 
> But that might not give the correct semantics.  See below.

[Biting tongue and reading ahead...]

> > > Interestingly, if simpler synchronization techniques were used instead of 
> > > the spin_lock operations then we might not expect the assertion to hold.  
> > > For example:
> > > 
> > > 	CPU 0			CPU 1			CPU 2
> > > 	-----			-----			-----
> > > 				a = 1;			while (x < 1) ;
> > > 				mb();			mb();
> > > 				x = 1;			b = a + 1;
> > > 							mb();
> > > 							x = 2;
> > > 	while (x < 2) ;
> > > 	rmb();
> > > 	assert(!(b==2 && a==0));
> > > 
> > > Imagine an architecture where stores get propagated rapidly from CPU 1 to
> > > CPU 2 and from CPU 2 to CPU 0, but they take a long time to go from CPU 1
> > > to CPU 0.  In that case it's quite possible for CPU 0 to see CPU 2's
> > > stores to x and b before it sees CPU 1's store to a (and it might not see 
> > > CPU 0's store to x at all).
> > 
> > You mean "CPU 1's store to x" in that last?
> 
> Yes, yet another typo.  They're impossible to eradicate.  :-(

For me as welll...  :-/

> >  In the sense that CPU 0
> > might never see x==1, agreed.  If one is taking a version-number approach,
> > then the fact that CPU 0 eventually sees x==2 would mean that it also
> > saw x==1 in the sense that it saw a later version.
> 
> And yet if you make that assumption (that CPU 0 "saw" x==1 because it does 
> see x==2), then the presence of the rmb() forces you to conclude that CPU 
> 0 also sees a==1 -- which it might not, at least, not until after the 
> assertion has already failed.
> 
> This illustrates how using the "version number" approach can lead to 
> an incorrect result.

My thought earlier was to allow transitivity in the case of stores and
loads to a single variable.  You later argued in favor of taking the
less-restrictive-to-hardware approach of only allowing transitivity for
CPUs whose last access to the variable in question was via an atomic
operation.  My "seen" approach would work for all CPU architectures
that I am familiar with, but your approach would also work for a few
even-more obnoxious CPUs that someone might someday build.

I have not yet decided which approach to take, will write things up
and talk to a few more CPU architects.

> > > So to make critical sections work as desired, there has to be something 
> > > very special about the primitive operation used in spin_lock().  It must 
> > > have a transitivity property:
> > > 
> > > 	st(L,i) c.b. st*(L,j) c.b. ac(L,k)  implies
> > > 		st(L,i) c.b. ac(L,k),
> > > 
> > > where st*(L,j) is the special sort of access used by spin_lock.  It might 
> > > be the store part of atomic_xchg(), for instance.
> > 
> > Except that spin_unlock() can be implemented by a normal store (preceded
> > by an explicit memory barrier on sufficiently weakly ordered machines).
> 
> That's right.  So long as the spin_lock() operation is special, it doesn't 
> matter if spin_unlock() is normal.

Yep.  The choices are:

1.	The spin_lock() operation is special, and makes all prior
	critical sections for the given lock visible.  (Your approach.)
	Since a CPU cannot tell spin_lock() from a hole in the
	ground (OK, outside of a few research efforts), this would
	seem to come down to an atomic operation.

2.	Seeing a given value of a particular variable has the same
	effect with respect to memory barriers as having seen any
	earlier value of that variable.  (My approach.)

I believe that any code that works on a CPU that does #1 would also
work on a CPU that does #2, but not vice versa.  If true, this would
certainly be a -major- point in favor of your approach.  ;-)

> > Hence my assertion in earlier email that visibility of stores to a single
> > variable has to be transitive.  By this I mean that if a CPU sees version
> > N of a given variable, it must be as if it has also seen all versions
> > i<N of that variable.  Otherwise the classic store-on-unlock form of
> > spinlocks don't work.
> > 
> > Or are you be arguing that you could get the same effect by something
> > special happening with the atomic operation that is part of spin_lock()?
> 
> Yes, that's exactly what I'm arguing.  It seems better to say that an
> atomic operation (which we already know can have strange effects on the
> memory bus) -- or whatever other operation is used in the native
> implementation of spin_lock() -- has special properties than it does to
> say that all stores to a single variable must be transitive.

OK, good point.

> > > Going back to the original example, we would then have (leaving out a few 
> > > minor details):
> > > 
> > > 	CPU 1:	st*(L,1)	// spin_lock(&L);
> > > 		mb(2);
> > > 		st(a,3);	// a = 1;
> > 
> > This notation is quite confusing -- my brain automatically interprets
> > "st(a,3)" as "store the value 3 to variable a" rather than the intended
> > "store some unknown value to variable a with source-code-line tag 3".
> 
> I'd be happy to use a different notation, if you want to suggest one.  
> Maybe something like 3:st(a).

I am going to try to write it up and see what happens.  My fear is that
any formal notation will be a barrier rather than a bridge to understanding.
That said, one possible approach would be to present informally and have
a formal notation in a separate appendix.

> > > > BTW, I like you approach of naming the orderings differently.  For
> > > > the pseudo-ordering implied by a memory barrier, would something like
> > > > "conditionally preceeds" and "conditionally follows" get across the
> > > > fact that -some- sort of ordering is happening, but not necessarily
> > > > strict temporal ordering?
> > > 
> > > Why use the word "conditionally"?  Conditional on what?
> > > 
> > > If you want a more neutral term for expressing an ordering relation, how 
> > > about something like "dominates" or "supersedes"?
> > 
> > Let me try again...
> > 
> > When a single CPU does loads and stores, its loads see its own stores
> > without needing any special ordering instructions.  When a bunch of
> > CPUs do loads and stores to a single variable, they see a consistent
> > view of the resulting sequence of values.  But when multiple CPUs do
> > loads and stores to multiple variables -- even with memory barriers
> > added -- things get strange.  The terms "comes before", "dominates",
> > "supersedes", etc. all imply some sort of linear ordering that simply
> > does not necessarily exist in this multi-CPU/multi-variable case.
> > 
> > So, conditional on what?  Conditional on the other CPUs involved making
> > proper use of explicit (or implicit) memory barriers.
> > 
> > Fair enough?
> 
> I see.  The term in my mind was more like "sequenced before", although it
> never got used in the message; you probably wouldn't like it either.  
> (You shouldn't object to "comes before", because that is defined to relate
> only accesses to a single variable.)

Agreed, I have no problem with globally ordered sequences for the values
taken on by a single variable.  Or for the sequence of loads and stores
performed by a single CPU -- but only from that CPU's viewpoint (other
CPUs of course might see different orderings).

> The thing is, your objection to these terms has to do with the lack of
> a single global linear ordering.  The fact that they imply a linear 
> ordering should be okay, provided you accept that it is a _local_ 
> ordering -- it makes sense only in the context of a single CPU.

If we are looking at a single CPU, then yes, a single global linear
order for that CPU's accesses does make sense.

> For example, in the program
> 
> 	ld(A)
> 	mb()
> 	st(B)
> 
> the load and the store really are very strongly ordered by the mb().  The
> CPU is prevented from rearranging them in ways that it normally would.  
> Sure, when you look at the results from the point of view of a different
> CPU this ordering might or might not be apparent -- but it's still there
> and very real.
>
> So perhaps the best terms would be "locally precedes" and "locally 
> follows".

Here I must disagree, at least for normal cached memory (MMIO I
discuss later).  Yes, there are many -implementations- of computer
systems that behave this way, and such implementations are indeed more
intuitively appealing to me than others, but it is really is possible to
create implementations where the CPU executing the above code really
does execute it out of order, where the rest of the system really
does see it out of order, and where it is up to the other CPU or the
interconnect to straighten things out based on the memory barriers.
For one (somewhat silly) example, imagine a system where each cache
line contained per-CPU sequence numbers.  A CPU increments its sequence
number when it executes a memory barrier, and tags cache lines with the
corresponding sequence number.  Would anyone actually do this?  I doubt
it, at least with today's technology.  But there are more subtle tricks
that can have this same effect in some situations.

Again, the ordering will only be guaranteed to take effect if the
memory barriers are properly paired.

OK, what about MMIO?  In that case, yes, the CPU must make sure that
the actual MMIO operations are carried out in the order indicated by
memory barriers.  The CPU can tell the difference -- some i386 CPUs use
memory-range registers, other types of CPUs use tags in the PTEs or TLB.
Either way, the memory range corresponding to MMIO is marked as "uncached"
or some such.  And real CPUs do in fact special-case MMIO accesses.

						Thanx, Paul
