Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVJVRCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVJVRCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVJVRCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:02:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17163 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750754AbVJVRCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:02:46 -0400
Date: Sat, 22 Oct 2005 18:02:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Message-ID: <20051022170240.GA10631@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 05:22:20PM +0100, Hugh Dickins wrote:
> Signal handling's preserve and restore of iwmmxt context currently
> involves reading and writing that context to and from user space, while
> holding page_table_lock to secure the user page(s) against kswapd.  If
> we split the lock, then the structure might span two pages, secured by
> different locks.  That would be manageable; but it seems simpler just
> to read into and write from a kernel stack buffer, copying that out and
> in without locking (the structure is 160 bytes in size, and here we're
> near the top of the kernel stack).  Or would the overhead be noticeable?

Please contact Nicolas Pitre about that - that was my suggestion,
but ISTR apparantly the overhead is too high.

> arm_syscall's cmpxchg emulation use pte_offset_map_lock, instead of
> pte_offset_map and mm-wide page_table_lock; and strictly, it should now
> also take mmap_sem before descending to pmd, to guard against another
> thread munmapping, and the page table pulled out beneath this thread.

Now that I look at it, it's probably buggy - if the page isn't already
dirty, it will modify without the COW action.  Again, please contact
Nicolas about this.

> Updated two comments in fault-armv.c.  adjust_pte is interesting, since
> its modification of a pte in one part of the mm depends on the lock held
> when calling update_mmu_cache for a pte in some other part of that mm.
> This can't be done with a split page_table_lock (and we've already taken
> the lowest lock in the hierarchy here): so we'll have to disable split
> on arm, unless CONFIG_CPU_CACHE_VIPT to ensures adjust_pte never used.

Well, adjust_pte is extremely critical to ensure correct cache behaviour
(and therefore data integrity) so if split ptlock is incompatible with
this, split ptlock loses.

As far as adjust_pte being called, it's only called for VIVT caches,
which means the configuration has to do if VIVT, disable split ptlock.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
