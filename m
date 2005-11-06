Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVKFXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVKFXuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVKFXuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:50:03 -0500
Received: from gold.veritas.com ([143.127.12.110]:63277 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932366AbVKFXuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:50:01 -0500
Date: Sun, 6 Nov 2005 23:48:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
In-Reply-To: <20051106151326.63cf16bd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511062348240.29944@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
 <20051106112838.0d524f65.akpm@osdl.org> <Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
 <20051106151326.63cf16bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Nov 2005 23:50:01.0003 (UTC) FILETIME=[CD294FB0:01C5E32C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > I'd checked that none of the architectures were using those page fields
> > of a page table page, but never considered that slab was using them: my
> > patch probably breaks all those which use slab for their page tables.
> 
> Ah, of course, yes.  pagetable pages which come from slab have a live
> page.lru even while the memory is in use by the caller.

arm26 seems to be the only arch which uses slab for pts other than ppc64.

But (without fully working it out) I think sparc (32) may also use page
parts: never mind slab using page->lru, I'm utterly broken using fields
of one struct page for two or more page tables, union or overlay or not.

So as well as reverting my poisonous patch, we'll need the patch at the
bottom, at least for now.  We could almost keep my poisonous patch (but
I expect you're well on your way reverting it), except for how it uses
the unsplit config to test the split - we could suppress its poisoning
and verification when ARM26 || SPARC32 || PPC64.  If reverting turns
out to be tiresome, then that would be another direction to try.

> > Drat.  I'm trying to think of the best way to retrieve the situation.
> 
> I suspect a slab-based fix/workaround would be unpleasant.  Simpler to not
> use slab for pagetable pages.
> 
> I doubt if there's much benefit to pagetable-pages-in-slab, really.  It
> _used_ to make sense because slab has the per-cpu LIFO magazines.  But now
> the page allocator has them too, it's probably better to rely upon that
> magazine to provide cache-warm pages.

I think they use slab, not for speed, but because they only need a
fraction of PAGE_SIZE for the page table - easy to imagine that in
the case of Ben's 64kB ppc64 pages, and he did mention that he was
trying to get away from the idea that a page table was a page.

> > The priority must be for you to get 2.6.14-mm1 out: is the easiest for
> > now simply to revert my patch (and the _private one(s) you added on top)?
> 
> yup, when I can get the steaming pile to compile.

Suppress split ptlock on arches which may use one page for multiple page
tables.  Reconsider what better to do (particularly on ppc64) later on.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.14-git/mm/Kconfig	2005-11-05 16:03:24.000000000 +0000
+++ linux/mm/Kconfig	2005-11-06 23:32:23.000000000 +0000
@@ -126,9 +126,11 @@ comment "Memory hotplug is currently inc
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
 # PA-RISC's debug spinlock_t is too large for the 32-bit struct page.
+# ARM26 and SPARC32 and PPC64 may use one page for multiple page tables.
 #
 config SPLIT_PTLOCK_CPUS
 	int
 	default "4096" if ARM && !CPU_CACHE_VIPT
 	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
+	default "4096" if ARM26 || SPARC32 || PPC64
 	default "4"
