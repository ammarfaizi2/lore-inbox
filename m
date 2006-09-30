Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWI3BKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWI3BKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWI3BKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:10:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:39342 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161049AbWI3BKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:10:53 -0400
Date: Fri, 29 Sep 2006 18:11:49 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060930011148.GL1315@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060922050236.GA1287@us.ibm.com> <Pine.LNX.4.44L0.0609271137480.6627-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609271137480.6627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 05:06:57PM -0400, Alan Stern wrote:
> Paul:
> 
> Thinking about this a little more, I came up with something that you might
> like.  It's a bit abstract, but it does seem to capture all the essential
> ingredients.
> 
> Let's start with some new notation.  If A is a location in memory and n is
> an index number, let's write "ld(A,n)", "st(A,n)", and "ac(A,n)" to stand
> for a load, store, or arbitrary access to A.  The index n is simply a way
> to distinguish among multiple accesses to the same location.  If n isn't
> needed we may choose to omit it.

Don't we also need to have an argument indicating who is observing the
stores?

> This approach uses two important relations.  The first is the "comes 
> before" relation we have already seen.  Let's abbreviate it "c.b.", or 
> "c.a." for the converse "comes after" relation.
> 
> "Comes before" applies across CPUs, but only for accesses to the same 
> location in memory.  st(A) c.b. ld(A) if the load returns the value of the 
> store.  st(A,m) c.b. st(A,n) if the second store overwrites the first.  
> We do not allow loads to "come before" anything.  This reflects the fact 
> that even though a store may have completed and may be visible to a 
> particular CPU, a subsequent load might not return the value of the store 
> (for example, if an invalidate message has been acknowledged but not 
> yet processed).
> 
> "Comes before" need not be transitive, depending on the architecture.  We 
> can safely allow it to be transitive among stores that are all visible to 
> some single CPU, but not all stores need to be so visible.

OK, I agree with total ordering on a specific variable, and also on
all loads and stores from a given CPU -- but the latter only from the
viewpoint of that particular CPU.

> As an example, consider a 4-CPU system where CPUs 0,1 share the cache C01
> and CPUs 2,3 share the cache C23.  Suppose that each CPU executes a store
> to A concurrently.  Then C01 might decide that the store from CPU 0 will
> overwrite the store from CPU 1, and C23 might decide that the store from
> CPU 2 will overwrite the store from CPU 3.  Similarly, the two caches
> together might decide that the store from CPU 0 will overwrite the store
> from CPU 2.  Under these conditions it makes no sense to compare the
> stores from CPUs 1 and 3, because nowhere are both stores visible.

Agreed -- in the absence of concurrent loads from A or use of things
like atomic_xchg() to do the stores, there is no way for the software
to know anything except that CPU 0 was the eventual winner.  This means
that the six permutations of 1, 2, and 3 are possible from the software's
viewpoint -- it has no way of knowing that the order 3, 2, 1, 0 is the
"real" order.

> As a special case, we can assume that stores taking place under a bus lock

[or to a cacheline owned for the duration by the CPU doing the stores]

> (such as the store in atomic_xchg) will be visible to all CPUs or caches,
> and hence all such stores to a particular location can be placed in a
> global total order consistent with the "comes before" relation.
> 
> As part of your P0, we can assert that whenever the sequence
> 
> 	st(A,m)
> 	ac(A,n)
> 
> occurs on a single CPU, st(A,m) c.b. ac(A,n).  In other words, each CPU 
> always sees the results of its own stores.
> 
> The second relation I'll call "sequencing", and I'll write it using the
> standard "<" and ">" symbols.  Unlike "comes before", sequencing applies
> to arbitrary memory locations but only to accesses on a single CPU.  It is
> fully transitive, hence a genuine partial ordering.  It's kind of a
> strengthened form of "comes before", just as "comes before" is a
> strengthened form of "occurs earlier in time".
> 
> If M is a memory barrier, then in this code
> 
> 	ac(A)
> 	M
> 	ac(B)
> 
> we will have ac(A) < ac(B), provided the barrier type is appropriate for 
> the sorts of access.  As a special extra case, if st(B) has any kind of 
> dependency (control, data, or address) on a previous ld(A), then ld(A) < 
> st(B) even without a memory barrier.  In other words, CPUs don't do 
> speculative writes.  But in general, if two accesses are not separated by 
> a memory barrier then they are not sequenced.
> 
> Given this background, the operation of memory barries can be explained 
> very simply as follows.  Whenever we have
> 
> 	ac(A,i) < ac(B,j) c.b. ac(B,k) < ac(A,l)
> 
> then ac(A,i) c.b. ac(A,l), or if i is a load and l is a store, then
> st(A,l) !c.b. ld(A,i).
> 
> As degenerate subcases, when A and B are the same location we also have:
> 
> 	ac(A,i) < ac(A,j) c.b. ac(A,k)  implies
> 		ac(A,i) c.b. ac(A,k), or ac(A,k) !c.b. ac(A,i);
> 
> 	ac(A,j) c.b. ac(A,k) < ac(A,l)  implies
> 		ac(A,j) c.b. ac(A,l), or ac(A,l) !c.b. ac(A,j).
> 
> One way to view all this is that sequencing is transitive with "comes 
> before", roughly speaking.
> 
> 
> Now, if we consider atomic_xchg() to be a combined load followed by a
> store, its atomic nature is expressed by requiring that no other store can
> occur in the middle.  Symbolically, let's say atomic_xchg(&A) is
> represented by
> 
> 	ld(A,m); st(A,n);
> 
> and we can even stipulate that since these are atomic accesses, ld(A,m) <
> st(A,n).  Then for any other st(A,k) on any CPU, if st(A,k) c.b. st(A,n)  
> we must have st(A,k) c.b. ld(A,m).  The reverse implication follows from
> one of the degenerate subcases above.
> 
> >From this you can prove that for any two atomic_xchg() calls on the same
> atomic_t variable, one "comes before" the other.  Going on from there, you
> can show that -- assuming spinlocks are implemented via atomic_xchg() --
> for any two critical sections, one comes completely before the other. 
> Furthermore every CPU will agree on which came first, so there is a 
> global total ordering of critical sections.
> 
> On the other hand, the fact that c.b. isn't transitive for all stores 
> means that this code can't be proved to work (all values initially 0):
> 
> 	CPU 0		CPU 1		CPU 2
> 	-----		-----		-----
> 	a = 1;		while (b < 1) ;
> 	mb();		c = 1;
> 	b = 1;		mb();
> 			b = 2;		while (b < 2) ;
> 					mb();
> 					assert(a==1 && c==1);
> 
> CPU 2 would have been safe in asserting that c==1 alone.  But the 
> possibility remains that CPU 2 might see b=2 before seeing a=1, and it 
> might not see b=1 at all.  Symbolically, even though we have
> 
> 	a=1 < b=1 c.b. b=2 c.b. !(b<2) < (a==1)
> 
> we can't conclude that a=1 c.b. (a==1).
> 
> What do you think?

Interesting!

However, I believe we can safely claim a little bit more, given that
some CPUs do a blind store for the spin_unlock() operation.  In this
blind-store case, a CPU that sees the store corresponding to (say) CPU
0's unlock would necessarily see the all the accesses corresponding to
(say) CPU 1's "earlier" critical section.  Therefore, at least some
degree of transitivity can be assumed for sequences of loads and stores
to a single variable.

Thoughts?

						Thanx, Paul
