Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbULJSoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbULJSoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbULJSoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:44:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53145 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261789AbULJSnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:43:51 -0500
Date: Fri, 10 Dec 2004 10:43:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412101006200.8714@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the thorough review of my patches. Comments below

On Thu, 9 Dec 2004, Hugh Dickins wrote:

> Your V12 patches would apply well to 2.6.10-rc3, except that (as noted
> before) your mailer or whatever is eating trailing whitespace: trivial
> patch attached to apply before yours, removing that whitespace so yours
> apply.  But what your patches need to apply to would be 2.6.10-mm.

I am still mystified as to why this is an issue at all. The patches apply
just fine to the kernel sources as is. I have patched kernels numerous
times with this patchset and never ran into any issue. quilt removes trailing
whitespace from patches when they are generated as far as I can tell.

Patches will be made against mm after Nick's modifications to the 4 level
patches are in.

> Your i386 HIGHMEM64G 3level ptep_cmpxchg forgets to use cmpxchg8b, would
> have tested out okay up to 4GB but not above: trivial patch attached.

Thanks for the patch.

> Your scalability figures show a superb improvement.  But they are (I
> presume) for the best case: intense initial faulting of distinct areas
> of anonymous memory by parallel cpus running a multithreaded process.
> This is not a common case: how much do what real-world apps benefit?

This is common during the startup of distributed applications on our large
machines. They seem to freeze for minutes on bootup. I am not sure how
much real-world apps benefit. The numbers show that the benefit would
mostly be for SMP applications. UP has only very minor improvements.

> Since you also avoid taking the page_table_lock in handle_pte_fault,
> there should be some scalability benefit to all kinds of page fault:
> do you have any results to show how much (perhaps hard to quantify,
> since even tmpfs file faults introduce other scalability issues)?

I have not done such tests (yet).

> The split rss patch, if it stays, needs some work.  For example,
> task_statm uses "get_shared" to total up rss-anon_rss from the tasks,
> but assumes mm->rss is already accurate.  Scrap the separate get_rss,
> get_anon_rss, get_shared functions: just one get_rss to make a single
> pass through the tasks adding up both rss and anon_rss at the same time.

Next rev will have that.

> Updating current->rss in do_anonymous_page, current->anon_rss in
> page_add_anon_rmap, is not always correct: ptrace's access_process_vm
> uses get_user_pages on another task.  You need check that current->mm ==
> mm (or vma->vm_mm) before incrementing current->rss or current->anon_rss,
> fall back to mm (or vma->vm_mm) in rare case not (taking page_table_lock
> for that).  You'll also need to check !(current->flags & PF_BORROWED_MM),
> to guard against use_mm.  Or... just go back to sloppy rss.

I will look into this issue.

> Moving to the main patch, 1/7, the major issue I see there is the way
> do_anonymous_page does update_mmu_cache after setting the pte, without
> any page_table_lock to bracket them together.  Obviously no problem on
> architectures where update_mmu_cache is a no-op!  But although there's
> been plenty of discussion, particularly with Ben and Nick, I've not
> noticed anything to guarantee that as safe on all architectures.  I do
> think it's fine for you to post your patches before completing hooks in
> all the arches, but isn't this a significant issue which needs to be
> sorted before your patches go into -mm?  You hazily refer to such issues
> in 0/7, but now you need to work with arch maintainers to settle them
> and show the patches.

I have worked with a couple of arches and received feedback that was
integrated. I certainly welcome more feedback. A vague idea if there is
more trouble on that front: One could take the ptl in the cmpxchg
emulation and then unlock on update_mmu cache.

> A lesser issue with the reordering in do_anonymous_page: don't you need
> to move the lru_cache_add_active after the page_add_anon_rmap, to avoid
> the very slight chance that vmscan will pick the page off the LRU and
> unmap it before you've counted it in, hitting page_remove_rmap's
> BUG_ON(page_mapcount(page) < 0)?

Changed.

> (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> lru_cache_add_active.  The other instances of lru_cache_add_active for
> an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> why here?  But that's nothing new with your patch, and although you've
> reordered the calls, the final page state is the same as before.)

The mark_page_accessed is likely there avoid a future fault just to set
the accessed bit.

> Where handle_pte_fault does "entry = *pte" without page_table_lock:
> you're quite right to passing down precisely that entry to the fault
> handlers below, but there's still a problem on the 32bit architectures
> supporting 64bit ptes (i386, mips, ppc), that the upper and lower ints
> of entry may be out of synch.  Not a problem for do_anonymous_page, or
> anything else relying on ptep_cmpxchg to check; but a problem for
> do_wp_page (which could find !pfn_valid and kill the process) and
> probably others (harder to think through).  Your 4/7 patch for i386 has
> an unused atomic get_64bit function from Nick, I think you'll have to
> define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.

That would be a performance issue.

> Hmm, that will only work if you're using atomic set_64bit rather than
> relying on page_table_lock in the complementary places which matter.
> Which I believe you are indeed doing in your 3level set_pte.  Shouldn't
> __set_64bit be using LOCK_PREFIX like __get_64bit, instead of lock?

> But by making every set_pte use set_64bit, you are significantly slowing
> down many operations which do not need that atomicity.  This is quite
> visible in the fork/exec/shell results from lmbench on i386 PAE (and is
> the only interesting difference, for good or bad, that I noticed with
> your patches in lmbench on 2*HT*P4), which run 5-20% slower.  There are
> no faults on dst mm (nor on src mm) while copy_page_range is copying,
> so its set_ptes don't need to be atomic; likewise during zap_pte_range
> (either mmap_sem is held exclusively, or it's in the final exit_mmap).
> Probably revert set_pte and set_pte_atomic to what they were, and use
> set_pte_atomic where it's needed.

Good suggestions. Will see what I can do but I will need some assistence
my main platform is ia64 and the hardware and opportunities for testing on
i386 are limited.

Again thanks for the detailed review.

