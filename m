Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUDHPCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUDHPAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:00:22 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:45507 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261802AbUDHOkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:40:41 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 09:40:37 -0500
Message-Id: <1081435237.1885.144.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 09:16, Hugh Dickins wrote:
> Don't be afraid, that's good!  Is it still going vertically down
> i_mmap_shared and i_mmap?  Whereas it's only interested in vmas of
> the one mm, so could go horizontally along it.  Just an option to
> play with, but I don't believe it solves anything, just as unsafe
> when threaded.

Yes, I've attached the current code.  I'm afraid we have space
separation in our caches and tlbs, so we're interested in all mm's not
just the current one (that was the bug that just got fixed).

> Which we're not giving you at all at present.  I guess another layer
> of spinlocking/nopreemption, for parisc and arm, dissolving to nothing
> on other arches.

Whatever seems most convenient that won't impact the flushing fast path,
I suppose.  It's one of the hottest paths in the system since all data
transfers go through it for user visibility.

James

__flush_dcache_page(struct page *page)
{
	struct mm_struct *mm = current->active_mm;
	struct list_head *l;
	struct vm_area_struct *anyvma = NULL;

	flush_kernel_dcache_page(page_address(page));

	if (!page->mapping)
		return;

	/* We have ensured in arch_get_unmapped_area() that all shared
	 * mappings are mapped at equivalent addresses, so we only need
	 * to flush one for them all to become coherent */
	list_for_each(l, &page->mapping->i_mmap_shared) {
		struct vm_area_struct *mpnt;
		unsigned long off, addr;

		mpnt = list_entry(l, struct vm_area_struct, shared);

		if (page->index < mpnt->vm_pgoff)
			continue;

		off = page->index - mpnt->vm_pgoff;
		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
			continue;

		addr = mpnt->vm_start + (off << PAGE_SHIFT);

		/* flush instructions produce non access tlb misses.
		 * On PA, we nullify these instructions rather than 
		 * taking a page fault if the pte doesn't exist, so we
		 * have to find a congruent address with an existing
		 * translation */

		if (!translation_exists(mpnt, addr))
			continue;

		anyvma = mpnt;

		/*
		 * We try first to find a page in our current user process
		 */
		if (mpnt->vm_mm != mm)
			continue;


		__flush_cache_page(mpnt, addr);

		/* All user shared mappings should be equivalently mapped,
		 * so once we've flushed one we should be ok
		 */
		goto flush_unshared;
	}

	/* OK, shared page but not in our current process' address space */
	if (anyvma) {
		unsigned long addr = anyvma->vm_start
			+ ((page->index - anyvma->vm_pgoff) << PAGE_SHIFT);
		__flush_cache_page(anyvma, addr);
	}

 flush_unshared:

	/* Private mappings will not have congruent addresses, so we
	 * have to flush each of them individually to make the change
	 * in the kernel page visible */
	list_for_each(l, &page->mapping->i_mmap) {
		struct vm_area_struct *mpnt;
		unsigned long off, addr;

		mpnt = list_entry(l, struct vm_area_struct, shared);

		if (page->index < mpnt->vm_pgoff)
			continue;

		off = page->index - mpnt->vm_pgoff;
		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
			continue;

		addr = mpnt->vm_start + (off << PAGE_SHIFT);

		/* This is just for speed.  If the page translation isn't
		 * there there's no point exciting the nadtlb handler into
		 * a nullification frenzy */
		if(!translation_exists(mpnt, addr))
			continue;

		__flush_cache_page(mpnt, addr);
	}
}

