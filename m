Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275482AbRJJLin>; Wed, 10 Oct 2001 07:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275506AbRJJLid>; Wed, 10 Oct 2001 07:38:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57764 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275482AbRJJLiP>;
	Wed, 10 Oct 2001 07:38:15 -0400
Date: Wed, 10 Oct 2001 17:13:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010171355.C16959@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011010153613.A17580@in.ibm.com> <Pine.LNX.4.33.0110100302560.1555-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0110100302560.1555-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 10, 2001 at 03:18:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 03:18:23AM -0700, Linus Torvalds wrote:
> 
> On Wed, 10 Oct 2001, Dipankar Sarma wrote:
> >
> > How does locking inside the kernel help you here ? You could face
> > the same situation even if you protect the data by locking.
> > Perhaps, I am missing something here. So, a specific example would help.
> 
> Oh, absolutely.
> 
> In the kernel, the regular usage is that we
> 
> 	lock
> 	lookup
> 	increment usage count
> 	unlock
> 
> and then the freeing is done with either
> 
> 	if (atomic_dec_and_lock()) {
> 		unhash
> 		unlock;
> 		free
> 	}
> 
> that's the basic pattern for most data structures.
> 
> Yes, there are data structures that don't have refcounts. They aren't on
> any global lists either, or they are buggy.

Ok, I get it now. You are talking about the situation where we
may not be able to update *all* the global pointers to the
data before they are "deferred deleted". I think once such example is the
ipv4 route cache dst entry we have to honor the refcounts.

> 
> Now, with the lockless approach, the issue is that you _cannot_ just free
> the thing on next schedule. You have to honor the reference count, which
> means that either you have different "bins" for all different kinds of
> users of RCU data structures (different "free" functions), or they all
> have the reference count in a generic place for RCU.
> 
> The latter is probably pretty doable.

Agreed. One approach I took for my experimental ipv4 route
cache code was to do "deferred delete" *after* refcount becomes
zero. I am not sure whether this is possible in all scenerios, but
the my understanding is that if you remove the global pointers
(like hash table links) to data to prevent new references and
do a "deferred delete" after refcount becomes zero, it would work.
Of course, I am in no position to make a generalized comment on this.


> > Only relevant issue I can see here is preemption - if you hold
> > a reference and get preempted out it is still a context switch
> > and the logic of "when the data can be really deleted" must take
> > into account such context switches. Alternatively, you could
> > disable preemption while traversing such lists.
> 
> You have to disable pre-emption some way. The kernel does that by default
> by not pre-empting kernel space, but it's easy enough to do other ways.
> And you can (have to, in fact) use cpu-local data structures for it.

That is what the preemption patch allows (atleast when I last looked
at it).

> However, it should be noted that even if you add refcounts to RCU, which
> makes them useful outside of atomic readers, you'll still find that most
> of the really core kernel data structures need locking anyway: locking not
> only protects the list traversal, it also is used to guarantee uniqueness
> which is important for a lot of the data structures - inodes, buffers,
> pages, etc all absolutely depend on the fact that the data structure is
> unique (ie there had better _not_ be two pages in the page cache with the
> same indexes, even if one process removes an old version at the same time
> as another process tries to look it up and create it if necessary).

Uniqueness can be ensured even with RCU, albeit it is not very
straitforward. One common technique we used was to mark elements
deleted *before* updating global pointers. However this usually
requires you to lock the element (not the list itself) while
reading its contents.

> 
> So I'm still at a loss for what this could actually be _used_. IP routing?
> Certainly not sockets (which have uniqueness requirements).

Yes. We used it in IP routing in DYNIX/ptx back then at Sequent as well
as for Multipath I/O routes for storage. That is all I can remember,
but Paul will remember and know more about it. Paul ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
