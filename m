Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275211AbRJJKTN>; Wed, 10 Oct 2001 06:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRJJKTD>; Wed, 10 Oct 2001 06:19:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27655 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275211AbRJJKTA>; Wed, 10 Oct 2001 06:19:00 -0400
Date: Wed, 10 Oct 2001 03:18:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: <linux-kernel@vger.kernel.org>, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <20011010153613.A17580@in.ibm.com>
Message-ID: <Pine.LNX.4.33.0110100302560.1555-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Oct 2001, Dipankar Sarma wrote:
>
> How does locking inside the kernel help you here ? You could face
> the same situation even if you protect the data by locking.
> Perhaps, I am missing something here. So, a specific example would help.

Oh, absolutely.

In the kernel, the regular usage is that we

	lock
	lookup
	increment usage count
	unlock

and then the freeing is done with either

	if (atomic_dec_and_lock()) {
		unhash
		unlock;
		free
	}

or

	lock
	unhash
	unlock
	if (atomic_dec()) {
		free
	}

that's the basic pattern for most data structures.

Yes, there are data structures that don't have refcounts. They aren't on
any global lists either, or they are buggy.

Now, with the lockless approach, the issue is that you _cannot_ just free
the thing on next schedule. You have to honor the reference count, which
means that either you have different "bins" for all different kinds of
users of RCU data structures (different "free" functions), or they all
have the reference count in a generic place for RCU.

The latter is probably pretty doable.

> Only relevant issue I can see here is preemption - if you hold
> a reference and get preempted out it is still a context switch
> and the logic of "when the data can be really deleted" must take
> into account such context switches. Alternatively, you could
> disable preemption while traversing such lists.

You have to disable pre-emption some way. The kernel does that by default
by not pre-empting kernel space, but it's easy enough to do other ways.
And you can (have to, in fact) use cpu-local data structures for it.

Locking does the same thing.

For RCU to work, it has to do all the things that locking guarantees. It
can try to do more of them locally, but that reference count increment
_is_ going to be a global atomic update, so it's not as if you can avoid
them all.

However, it should be noted that even if you add refcounts to RCU, which
makes them useful outside of atomic readers, you'll still find that most
of the really core kernel data structures need locking anyway: locking not
only protects the list traversal, it also is used to guarantee uniqueness
which is important for a lot of the data structures - inodes, buffers,
pages, etc all absolutely depend on the fact that the data structure is
unique (ie there had better _not_ be two pages in the page cache with the
same indexes, even if one process removes an old version at the same time
as another process tries to look it up and create it if necessary).

So I'm still at a loss for what this could actually be _used_. IP routing?
Certainly not sockets (which have uniqueness requirements).

		Linus

