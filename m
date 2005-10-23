Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVJWI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVJWI27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJWI27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 04:28:59 -0400
Received: from silver.veritas.com ([143.127.12.111]:25622 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750822AbVJWI26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 04:28:58 -0400
Date: Sun, 23 Oct 2005 09:27:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Nicolas Pitre <nico@cam.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-Reply-To: <20051022170240.GA10631@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0510230900550.19527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Oct 2005 08:28:58.0378 (UTC) FILETIME=[D0496EA0:01C5D7AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for your rapid response...

On Sat, 22 Oct 2005, Russell King wrote:
> On Sat, Oct 22, 2005 at 05:22:20PM +0100, Hugh Dickins wrote:
> > Signal handling's preserve and restore of iwmmxt context currently
> > involves reading and writing that context to and from user space, while
> > holding page_table_lock to secure the user page(s) against kswapd.  If
> > we split the lock, then the structure might span two pages, secured by
> > different locks.  That would be manageable; but it seems simpler just
> > to read into and write from a kernel stack buffer, copying that out and
> > in without locking (the structure is 160 bytes in size, and here we're
> > near the top of the kernel stack).  Or would the overhead be noticeable?
> 
> Please contact Nicolas Pitre about that - that was my suggestion,
> but ISTR apparantly the overhead is too high.

Right, I've CC'ed him, and will forward the original patch in a moment.

It'd be perfectly possible to lock two extents in there, just seems like
over-engineering, and yet more strange mm-dependent code down in the arch
than I'd like to put there.

If Nicolas insists on avoiding the copies, then the simplest answer is
to disable split ptlock in the CONFIG_IWMMXT case too, and replace my
signal.c mods by just a comment highlighting the issue.

ARM is not the architecture (ia64) which prompted this page fault
scalability business.  I've no idea of its benefit or otherwise on ARM.
Just didn't want ARM to be the only one not invited to the party.

> > arm_syscall's cmpxchg emulation use pte_offset_map_lock, instead of
> > pte_offset_map and mm-wide page_table_lock; and strictly, it should now
> > also take mmap_sem before descending to pmd, to guard against another
> > thread munmapping, and the page table pulled out beneath this thread.
> 
> Now that I look at it, it's probably buggy - if the page isn't already
> dirty, it will modify without the COW action.  Again, please contact
> Nicolas about this.

That hadn't crossed my mind, good catch.  (Though bad both before and
after my change.)  I did wonder about the alignment, the assumption that
*(unsigned long *)addr all fits within the same page - but assumed ARM's
instructions are suitably aligned?

It does look like that cmpxchg emulation needs to be done another way,
quite unrelated to my changes.
 
> > Updated two comments in fault-armv.c.  adjust_pte is interesting, since
> > its modification of a pte in one part of the mm depends on the lock held
> > when calling update_mmu_cache for a pte in some other part of that mm.
> > This can't be done with a split page_table_lock (and we've already taken
> > the lowest lock in the hierarchy here): so we'll have to disable split
> > on arm, unless CONFIG_CPU_CACHE_VIPT to ensures adjust_pte never used.
> 
> Well, adjust_pte is extremely critical to ensure correct cache behaviour
> (and therefore data integrity) so if split ptlock is incompatible with
> this, split ptlock loses.

Unquestionably.

> As far as adjust_pte being called, it's only called for VIVT caches,
> which means the configuration has to do if VIVT, disable split ptlock.

Yes, patch 7/9 disables it on ARM unless CPU_CACHE_VIPT
(since in other cases cache_is_vivt may be determined at runtime).

config SPLIT_PTLOCK_CPUS
	int
	default "4096" if ARM && !CPU_CACHE_VIPT
	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
	default "4"

Please let me know when ARM supports 4096 cpus, I'll change that then!

Hugh
