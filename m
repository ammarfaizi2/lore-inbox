Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUCULsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUCULsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:48:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62433
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263637AbUCULst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:48:49 -0500
Date: Sun, 21 Mar 2004 12:49:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Message-ID: <20040321114939.GA10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <200403211105.05908@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403211105.05908@WOLK>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:05:05AM +0100, Marc-Christian Petersen wrote:
> On Saturday 20 March 2004 22:03, Andrea Arcangeli wrote:
> 
> Hey Andrea,
> 
> > Fixed the sigbus in nopage and improved the page_t layout per Hugh's
> > suggestion. BUG() with discontigmem disabled if somebody returns non-ram
> > via do_no_page, that cannot work right on numa anyways.
> 
> I thought trying out your new -aa3 on my desktop is a good idea ;) ... As soon 
> I start VMware 4 (any-any update 53) I get the attached oops. .config also 
> attached.

this is easy to fix in the vmmon module, you can simply add ->vm_flags |=
VM_RESERVED somewhere in the vmware kernel modules, you should not find any
VM_RESERVED in that kernel module.

I'm enforcing modules that uses ->nopage to map non-VM-pageable
memory, to set VM_RESERVED like they must do in 2.4 to be safe. so that
we still enforce an API abstraction that in theory would allow to return doing
the pagetable walking if we wanted to (one obvious thing that the
pagetable walk avoids, is the lru_cache_add with a spinlock for
anonymous memory pagefaults), I don't think we'll ever go back, but it's
a little effort to add |= VM_RESERVED and last but not the least it adds
some hardness to the kernel as well.

I'd like to have feedback on this point and if people thinks I'm doing a
mistake enforcing drivers to use VM_RESERVED in 2.6 still. If we giveup
the ability to ever do a pagetable walk again, and we don't mind about
the additional hardness you could remove the BUG_ON on in memory.c at line
1432 (in 2.6.5-rc1-aa3 of course) and the VM would still work perfectly,
but you wouldn't catch drivers using ->nopage to fillup pagetables with
non-pageable memory and not setting VM_RESERVED at the same time anymore.

So it's up to you, if you prefer you can remove the BUG_ON, but I'd prefer if
you would add the one-liner fix to vmmon.

If you fixup vmware as I suggested please send me a patch too, thanks!

comments welcome.

[this is my current do_no_page for you to review, I believe my robustness
BUG_ON are correct and this is not a false positive, if we want to kill
VM_RESERVED I can remove the BUG_ON(reserved == pageable) which is the one
triggering with vmware right now]

static int
do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
{
	struct page * new_page;
	struct address_space *mapping = NULL;
	pte_t entry;
	int sequence = 0, reserved, anon, pageable, as;
	int ret = VM_FAULT_MINOR;

	if (!vma->vm_ops || !vma->vm_ops->nopage)
		return do_anonymous_page(mm, vma, page_table,
					pmd, write_access, address);
	pte_unmap(page_table);
	spin_unlock(&mm->page_table_lock);

	if (vma->vm_file) {
		mapping = vma->vm_file->f_mapping;
		sequence = atomic_read(&mapping->truncate_count);
	}
	smp_rmb();  /* Prevent CPU from reordering lock-free ->nopage() */
retry:
	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);

	/* no page was available -- either SIGBUS or OOM */
	if (new_page == NOPAGE_SIGBUS)
		return VM_FAULT_SIGBUS;
	if (new_page == NOPAGE_OOM)
		return VM_FAULT_OOM;

#ifndef CONFIG_DISCONTIGMEM
	/* this check is unreliable with numa enabled */
	BUG_ON(!pfn_valid(page_to_pfn(new_page)));
#endif
	pageable = !PageReserved(new_page);
	as = !!new_page->mapping;

	BUG_ON(!pageable && as);

	pageable &= as;

	/* ->nopage cannot return swapcache */
	BUG_ON(PageSwapCache(new_page));
	/* ->nopage cannot return anonymous pages */
	BUG_ON(PageAnon(new_page));

	/*
	 * This is the entry point for memory under VM_RESERVED vmas.
	 * That memory will not be tracked by the vm. These aren't
	 * real anonymous pages, they're "device" reserved pages instead.
	 */
	reserved = !!(vma->vm_flags & VM_RESERVED);
	BUG_ON(reserved == pageable);

	/*
	 * Should we do an early C-O-W break?
	 */
	anon = 0;
	if (write_access && !(vma->vm_flags & VM_SHARED)) {
		struct page * page;
		if (unlikely(anon_vma_prepare(vma)))
			goto oom;
		page = alloc_page(GFP_HIGHUSER);
		if (!page)
			goto oom;
		copy_user_highpage(page, new_page, address);
		page_cache_release(new_page);
		lru_cache_add_active(page);
		new_page = page;
		anon = 1;
	}

	spin_lock(&mm->page_table_lock);
	/*
	 * For a file-backed vma, someone could have truncated or otherwise
	 * invalidated this page.  If invalidate_mmap_range got called,
	 * retry getting the page.
	 */
	if (mapping &&
	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
		sequence = atomic_read(&mapping->truncate_count);
		spin_unlock(&mm->page_table_lock);
		page_cache_release(new_page);
		goto retry;
	}
	page_table = pte_offset_map(pmd, address);

	/*
	 * This silly early PAGE_DIRTY setting removes a race
	 * due to the bad i386 page protection. But it's valid
	 * for other architectures too.
	 *
	 * Note that if write_access is true, we either now have
	 * an exclusive copy of the page, or this is a shared mapping,
	 * so we can make it writable and dirty to avoid having to
	 * handle that later.
	 */
	/* Only go through if we didn't race with anybody else... */
	if (pte_none(*page_table)) {
		if (!PageReserved(new_page))
			++mm->rss;
		flush_icache_page(vma, new_page);
		entry = mk_pte(new_page, vma->vm_page_prot);
		if (write_access)
			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
		set_pte(page_table, entry);
		if (likely(pageable))
			page_add_rmap(new_page, vma, address, anon);
		pte_unmap(page_table);
	} else {
		/* One of our sibling threads was faster, back out. */
		pte_unmap(page_table);
		page_cache_release(new_page);
		spin_unlock(&mm->page_table_lock);
		goto out;
	}

	/* no need to invalidate: a not-present page shouldn't be cached */
	update_mmu_cache(vma, address, entry);
	spin_unlock(&mm->page_table_lock);
 out:
	return ret;

 oom:
	page_cache_release(new_page);
	ret = VM_FAULT_OOM;
	goto out;
}
