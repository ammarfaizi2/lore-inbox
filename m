Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWI3VBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWI3VBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWI3VBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:01:08 -0400
Received: from mx2.rowland.org ([192.131.102.7]:64516 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751971AbWI3VBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:01:07 -0400
Date: Sat, 30 Sep 2006 17:01:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060930011148.GL1315@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609301625280.15977-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Paul E. McKenney wrote:

> > Let's start with some new notation.  If A is a location in memory and n is
> > an index number, let's write "ld(A,n)", "st(A,n)", and "ac(A,n)" to stand
> > for a load, store, or arbitrary access to A.  The index n is simply a way
> > to distinguish among multiple accesses to the same location.  If n isn't
> > needed we may choose to omit it.
> 
> Don't we also need to have an argument indicating who is observing the
> stores?

Not here.  Such an observation would itself have to be a separate load,
and so would have its own index.

> > "Comes before" need not be transitive, depending on the architecture.  We 
> > can safely allow it to be transitive among stores that are all visible to 
> > some single CPU, but not all stores need to be so visible.
> 
> OK, I agree with total ordering on a specific variable, and also on
> all loads and stores from a given CPU -- but the latter only from the
> viewpoint of that particular CPU.

What I meant above was that the ordering can be total on all stores for a
specific variable that are visible to a given CPU, regardless of the CPUs
executing the stores.  ("Comes before" never tries to compare accesses to
different variables.)

I admit that this notion may be a little vague, since it's hard to say
whether a particular store is visible to a particular CPU in the absence
of a witnessing load.  The same objection applies to the issue of whether
one store overwrites another -- if a third store comes along and
overwrites both then it can be difficult or impossible to define the
ordering of the first two.

> > As an example, consider a 4-CPU system where CPUs 0,1 share the cache C01
> > and CPUs 2,3 share the cache C23.  Suppose that each CPU executes a store
> > to A concurrently.  Then C01 might decide that the store from CPU 0 will
> > overwrite the store from CPU 1, and C23 might decide that the store from
> > CPU 2 will overwrite the store from CPU 3.  Similarly, the two caches
> > together might decide that the store from CPU 0 will overwrite the store
> > from CPU 2.  Under these conditions it makes no sense to compare the
> > stores from CPUs 1 and 3, because nowhere are both stores visible.
> 
> Agreed -- in the absence of concurrent loads from A or use of things
> like atomic_xchg() to do the stores, there is no way for the software
> to know anything except that CPU 0 was the eventual winner.  This means
> that the six permutations of 1, 2, and 3 are possible from the software's
> viewpoint -- it has no way of knowing that the order 3, 2, 1, 0 is the
> "real" order.

It's worse than you say.  Even if there _are_ concurrent loads that see
the various intermediate states, there's still no single CPU that can see
both the CPU 1 and CPU 3 values.  No matter how hard you looked, you
wouldn't be able to order those two stores.


> > Now, if we consider atomic_xchg() to be a combined load followed by a
> > store, its atomic nature is expressed by requiring that no other store can
> > occur in the middle.  Symbolically, let's say atomic_xchg(&A) is
> > represented by
> > 
> > 	ld(A,m); st(A,n);
> > 
> > and we can even stipulate that since these are atomic accesses, ld(A,m) <
> > st(A,n).  Then for any other st(A,k) on any CPU, if st(A,k) c.b. st(A,n)  
> > we must have st(A,k) c.b. ld(A,m).  The reverse implication follows from
> > one of the degenerate subcases above.
> > 
> > >From this you can prove that for any two atomic_xchg() calls on the same
> > atomic_t variable, one "comes before" the other.  Going on from there, you
> > can show that -- assuming spinlocks are implemented via atomic_xchg() --
> > for any two critical sections, one comes completely before the other. 
> > Furthermore every CPU will agree on which came first, so there is a 
> > global total ordering of critical sections.

> Interesting!
> 
> However, I believe we can safely claim a little bit more, given that
> some CPUs do a blind store for the spin_unlock() operation.  In this
> blind-store case, a CPU that sees the store corresponding to (say) CPU
> 0's unlock would necessarily see the all the accesses corresponding to
> (say) CPU 1's "earlier" critical section.  Therefore, at least some
> degree of transitivity can be assumed for sequences of loads and stores
> to a single variable.
> 
> Thoughts?

I'm not quite sure what you're saying.  In practice does it amount to 
this?

	CPU 0			CPU 1			CPU 2
	-----			-----			-----
				spin_lock(&L);		spin_lock(&L);
				a = 1;			b = a + 1;
				spin_unlock(&L);	spin_unlock(&L);
	while (spin_is_locked(&L)) ;
	rmb();
	assert(!(b==2 && a==0));

I think this follows from the principles I laid out.  But of course it 
depends crucially on the protection provided by the critical sections.

Alan

