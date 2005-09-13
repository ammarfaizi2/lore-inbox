Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVIMRhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVIMRhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVIMRhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:37:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48323 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964923AbVIMRhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:37:38 -0400
Date: Tue, 13 Sep 2005 10:37:24 -0700
From: Paul Jackson <pj@sgi.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050913103724.19ac5efa.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0509131120020.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank-you, Roman, for looking into cpuset locks.

I am starting to see the picture you are painting, with a global
cpuset_sem to guard changes in the cpuset hierarchy (add/remove)
and a per-cpuset spinlock to briefly pin down an active cpuset
and guard select values (such as mems_allowed) for access from
allocator callbacks and other tasks.

Roman wrote:
> If I read the source correctly, a cpuset cannot be removed or moved while 
> it's attached to a task, which makes it a lot simpler.

Yes - a cpuset cannot be removed while attached (count > 0).  And there
is no 'move' that I know of.  A rename(2) system call on a cpuset in
the cpuset filesystem gets the vfs default -EINVAL response.

So, yes, if I can pin a cpuset with a per-cpuset spinlock on it, then
its parent chain (and whatever else I take care to guard with that
spinlock) is held as well (the cpuset->parent chain is pinned).  I
guess this some of what you meant by your phrase "makes it a lot
simpler".


> This means you have to take the second lock ...

By "second lock", did you mean what you described in your earlier
message as:

> low-level lock (maybe even a spinlock) which manages the state of an 
> active cpuset.


You also wrote:
> You can BTW avoid locking in cpuset_exit() completely in the common case:
> 
> 	tsk->cpuset = NULL;
> 	if (atomic_dec_and_test(&cs->count) && notify_on_release(cs)) {

I don't think that works.  And I suspect you are proposing the same bug
that I had, and fixed with the following patch:

> changeset:   1793:feaa2e5b1e0026994365daf8d1ad3bd745ba8a14
> user:        Paul Jackson <pj@sgi.com>
> date:        Fri May 27 08:07:26 2005 +0019
> files:       kernel/cpuset.c
> description:
> [PATCH] cpuset exit NULL dereference fix
> 
> There is a race in the kernel cpuset code, between the code
> to handle notify_on_release, and the code to remove a cpuset.
> The notify_on_release code can end up trying to access a
> cpuset that has been removed.  In the most common case, this
> causes a NULL pointer dereference from the routine cpuset_path.
> However all manner of bad things are possible, in theory at least.
> 
> The existing code decrements the cpuset use count, and if the
> count goes to zero, processes the notify_on_release request,
> if appropriate.  However, once the count goes to zero, unless we
> are holding the global cpuset_sem semaphore, there is nothing to
> stop another task from immediately removing the cpuset entirely,
> and recycling its memory.


You also wrote:
> There may be a subtle problem with cpuset_fork()

Hmmm ... interesting.  I will think about this some more.

> The only (simple) solution I see is to do this:
> 
> 	lock();
> 	tsk->cpuset = current->cpuset;
> 	atomic_inc(&tsk->cpuset->count);
> 	unlock();

What "lock()" and "unlock()" is this?  Your "second lock",
aka "low-level lock (maybe even a spinlock)" ?

Separate question:

    When cpuset_excl_nodes_overlap() or cpuset_zone_allowed()
    callbacks are walking backup the cpuset hierarchy in the
    nearest_exclusive_ancestor() code, how do they handle the
    per-cpuset spinlocks?

    My assumption is that it would be like this.  Say my current task
    is attached to cpuset "/dev/cpuset/A/B/C", and it happens I will
    have to walk all the way to the top to find the exclusive ancestor
    that I am searching for.  I'd expect the spinlocks to get taken
    and released in the following order on these cpusets:

	    lock /A/B/C
	    lock /A/B
	    lock /A
	    lock /
	      ==> found what I was searching for
	    unlock /
	    unlock /A
	    unlock /A/B
	    unlock /A/B/C

    If at any point, perhaps in the creation of a cpuset, I had reason
    to want to get a child cpusets spinlock while already holding the
    parents, I would have to release the parent, and relock starting
    with the child first, working upward.  The proper order to obtain
    these locks would always be bottom up.

    Does this resemble what you are suggesting, Roman?

Your review of this is most appreciated.  Once again - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
