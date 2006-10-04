Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWJDPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWJDPem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWJDPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:34:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5598 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161242AbWJDPel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:34:41 -0400
Date: Wed, 4 Oct 2006 08:35:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061004153528.GA1584@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061002000645.GC3584@us.ibm.com> <Pine.LNX.4.44L0.0610021113170.7314-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610021113170.7314-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:44:36AM -0400, Alan Stern wrote:
> On Sun, 1 Oct 2006, Paul E. McKenney wrote:
> 
> > On Sat, Sep 30, 2006 at 05:01:05PM -0400, Alan Stern wrote:
> > > On Fri, 29 Sep 2006, Paul E. McKenney wrote:
> > > 
> > > > > Let's start with some new notation.  If A is a location in memory and n is
> > > > > an index number, let's write "ld(A,n)", "st(A,n)", and "ac(A,n)" to stand
> > > > > for a load, store, or arbitrary access to A.  The index n is simply a way
> > > > > to distinguish among multiple accesses to the same location.  If n isn't
> > > > > needed we may choose to omit it.
> > > > 
> > > > Don't we also need to have an argument indicating who is observing the
> > > > stores?
> > > 
> > > Not here.  Such an observation would itself have to be a separate load,
> > > and so would have its own index.
> > 
> > Ah!  So ld(A,n) sees st(A,i) for the largest i<n?
> 
> No, the index numbers don't have any intrinsic meaning.  They're just 
> labels.  They don't have to appear in any numerical or temporal sequence.  
> You can think of them as nothing more than line numbers in the source 
> code.
> 
> Whether or not a particular load (considered as a line of code in the 
> program source) sees a particular store depends on the execution details.  
> The labels you put on the source lines have nothing to do with it.

OK.  Would a given label be repeated if the corresponding load was in
a loop or something?

> > > I admit that this notion may be a little vague, since it's hard to say
> > > whether a particular store is visible to a particular CPU in the absence
> > > of a witnessing load.  The same objection applies to the issue of whether
> > > one store overwrites another -- if a third store comes along and
> > > overwrites both then it can be difficult or impossible to define the
> > > ordering of the first two.
> > 
> > Definitely a complication!
> 
> I don't know quite how to deal with it.  It's beginning to look like the 
> original definition of "comes before" was too narrow.  We should instead 
> say that a store "comes before" a load if the load _would_ return the 
> value of the store, had there been no intervening stores.

Another approach is to define a (conceptual!!!) version number for each
variable that increments on every store to that variable.  Then a store
"comes before" a load if the load returns the value stored or some value
corresponding to a larger version number.

> > In absence of CONFIG_X86_OOSTORE or CONFIG_X86_PPRO_FENCE, i386's
> > implementation of spin_unlock() ends up being a simple store:
> > 
> > 	#define __raw_spin_unlock_string \
> > 		"movb $1,%0" \
> > 			:"+m" (lock->slock) : : "memory"
> > 
> > No explicit memory barrier, as the x86's implicit store-ordering memory
> > barriers suffice to keep stores inside the critical section.  In addition,
> > x86 refuses to pull a store ahead of a load, so the loads are also confined
> > to the critical section.
> > 
> > So, your example then looks as follows:
> > 
> > 	CPU 0			CPU 1			CPU 2
> > 	-----			-----			-----
> > 				spin_lock(&L);		spin_lock(&L);
> > 				a = 1;			b = a + 1;
> > 				implicit_mb();		implicit_mb();
> > 				L=unlocked;		L=unlocked;
> > 	while (spin_is_locked(&L)) ;
> > 	rmb();
> > 	assert(!(b==2 && a==0));
> > 
> > I am then asserting that a very weak form of transitivity is required.
> > The fact that CPU 0 saw CPU 2's unlock and the fact that CPU 2 saw
> > CPU 1's assignment a=1 must imply that CPU 0 also sees CPU 1's a=1.
> > It is OK to also invoke the fact that CPU 2 also saw CPU 1's unlock before
> > seeing CPU 1's assignment a=1, and I am suggesting taking this latter
> > course, since it appears to me to be a weaker assumption.
> > 
> > Thoughts?
> 
> This does point out a weakness in the formalism.  You can make it even 
> more pointed by replacing CPU 0's
> 
> 	while (spin_is_locked(&L)) ;
> 	rmb();
> 
> with
> 
> 	spin_lock(&L);
> 
> and adding a corresponding spin_unlock(&L) to the end.
> 
> Interestingly, if simpler synchronization techniques were used instead of 
> the spin_lock operations then we might not expect the assertion to hold.  
> For example:
> 
> 	CPU 0			CPU 1			CPU 2
> 	-----			-----			-----
> 				a = 1;			while (x < 1) ;
> 				mb();			mb();
> 				x = 1;			b = a + 1;
> 							mb();
> 							x = 2;
> 	while (x < 2) ;
> 	rmb();
> 	assert(!(b==2 && a==0));
> 
> Imagine an architecture where stores get propagated rapidly from CPU 1 to
> CPU 2 and from CPU 2 to CPU 0, but they take a long time to go from CPU 1
> to CPU 0.  In that case it's quite possible for CPU 0 to see CPU 2's
> stores to x and b before it sees CPU 1's store to a (and it might not see 
> CPU 0's store to x at all).

You mean "CPU 1's store to x" in that last?  In the sense that CPU 0
might never see x==1, agreed.  If one is taking a version-number approach,
then the fact that CPU 0 eventually sees x==2 would mean that it also
saw x==1 in the sense that it saw a later version.

> So to make critical sections work as desired, there has to be something 
> very special about the primitive operation used in spin_lock().  It must 
> have a transitivity property:
> 
> 	st(L,i) c.b. st*(L,j) c.b. ac(L,k)  implies
> 		st(L,i) c.b. ac(L,k),
> 
> where st*(L,j) is the special sort of access used by spin_lock.  It might 
> be the store part of atomic_xchg(), for instance.

Except that spin_unlock() can be implemented by a normal store (preceded
by an explicit memory barrier on sufficiently weakly ordered machines).
Hence my assertion in earlier email that visibility of stores to a single
variable has to be transitive.  By this I mean that if a CPU sees version
N of a given variable, it must be as if it has also seen all versions
i<N of that variable.  Otherwise the classic store-on-unlock form of
spinlocks don't work.

Or are you be arguing that you could get the same effect by something
special happening with the atomic operation that is part of spin_lock()?

> Going back to the original example, we would then have (leaving out a few 
> minor details):
> 
> 	CPU 1:	st*(L,1)	// spin_lock(&L);
> 		mb(2);
> 		st(a,3);	// a = 1;

This notation is quite confusing -- my brain automatically interprets
"st(a,3)" as "store the value 3 to variable a" rather than the intended
"store some unknown value to variable a with source-code-line tag 3".

> 		mb(4);
> 		st(L,5);	// spin_unlock(&L);
> 
> 	CPU 2:	st*(L,6);	// spin_lock(&L);
> 		mb(7);
> 		ld(a,8);
> 		st(b,9);	// b = a + 1;
> 		mb(10);
> 		st(L,11);	// spin_unlock(&L);
> 
> 	CPU 0:	ld(L,12);	// while (!spin_is_locked(&L)) ;
> 		mb(13);
> 		ld(b,14);
> 		ld(a,15);	// assert(!(b==2 && a==0));
> 
> Assuming that CPU 0 sees b==2, we then get:
> 
>     st(a,3) < st(L,5) c.b. st*(L,6) < st(L,11) c.b. ld(L,12) < ld(a,15),
> 
> the <'s being justified by the various mb() instructions.  The second <
> can be absorbed, leaving
> 
> 	st(a,3) < st(L,5) c.b. st*(L,6) c.b. ld(L,12) < ld(a,15)
> 
> and then the new transitivity property gives us
> 
> 	st(a,3) < st(L,5) c.b. ld(L,12) < ld(a,15)
> 
> from which we get st(a,3) c.b. ld(a,15).  This means that CPU 0 sees a==1, 
> since there are no intervening stores to a.
> 
> 
> > BTW, I like you approach of naming the orderings differently.  For
> > the pseudo-ordering implied by a memory barrier, would something like
> > "conditionally preceeds" and "conditionally follows" get across the
> > fact that -some- sort of ordering is happening, but not necessarily
> > strict temporal ordering?
> 
> Why use the word "conditionally"?  Conditional on what?
> 
> If you want a more neutral term for expressing an ordering relation, how 
> about something like "dominates" or "supersedes"?

Let me try again...

When a single CPU does loads and stores, its loads see its own stores
without needing any special ordering instructions.  When a bunch of
CPUs do loads and stores to a single variable, they see a consistent
view of the resulting sequence of values.  But when multiple CPUs do
loads and stores to multiple variables -- even with memory barriers
added -- things get strange.  The terms "comes before", "dominates",
"supersedes", etc. all imply some sort of linear ordering that simply
does not necessarily exist in this multi-CPU/multi-variable case.

So, conditional on what?  Conditional on the other CPUs involved making
proper use of explicit (or implicit) memory barriers.

Fair enough?

						Thanx, Paul
