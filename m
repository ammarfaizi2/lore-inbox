Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbUCTRsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbUCTRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:48:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46550
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263485AbUCTRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:48:07 -0500
Date: Sat, 20 Mar 2004 18:48:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320174857.GA9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <20040320155739.GQ9009@dualathlon.random> <20040320161538.C6726@flint.arm.linux.org.uk> <20040320162534.GU9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320162534.GU9009@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed there was effectively one bug in anon_vma that would have
caused a VM_FAULT_OOM/SIGBUS to be mistaken for non-ram (I checked
VM_FAULT after pfn_valid oh well). So it's possible what Jens
experienced was a sigbus and not a non-ram condition, sorry.

So it's not certain anymore that alsa was returning non-ram, but it's
still possible in theory and it would have worked in practice up to
2.6.4 (not anymore in 2.6.5-rc1). The non-ram page_t would fall into the
direct mapping (for a 4G phys address, the page_t would be at address
3G+120M triggering an oops only on machines with less than 128m of ram,
and if the mmio region would been at lower than 4G even less ram would
be needed to hide the bug). This untested patch should make it working
with non-ram too, so it sounds safer for the short term. I will test it
a little bit and I'll upload an update.

--- x/mm/memory.c.~1~	2004-03-20 15:47:31.000000000 +0100
+++ x/mm/memory.c	2004-03-20 18:35:19.000000000 +0100
@@ -1384,7 +1384,7 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	int sequence = 0, reserved, anon;
+	int sequence = 0, reserved, anon, pageable, ram, as;
 	int ret = VM_FAULT_MINOR;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -1401,36 +1401,40 @@ do_no_page(struct mm_struct *mm, struct 
 retry:
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 
+	/* no page was available -- either SIGBUS or OOM */
+	if (new_page == NOPAGE_SIGBUS)
+		return VM_FAULT_SIGBUS;
+	if (new_page == NOPAGE_OOM)
+		return VM_FAULT_OOM;
+
 	/*
-	 * non-ram cannot be mapped via ->nopage, it must
-	 * be mapped via remap_page_range instead synchronously
-	 * in the ->mmap device driver callback.
-	 *
-	 * PageReserved pages can be mapped as far as they're under
-	 * a VM_RESERVED vma.
+	 * ->nopage should return a PFN not a page_t if here we
+	 * wanted to handle non-ram, though we've to make non-ram
+	 * work with page_t too for a number of device drivers
+	 * that may return non-ram via ->nopage.
 	 */
-	BUG_ON(!pfn_valid(page_to_pfn(new_page)));
-
-	/* ->nopage cannot return swapcache */
-	BUG_ON(PageSwapCache(new_page));
-	/* ->nopage cannot return anonymous pages */
-	BUG_ON(PageAnon(new_page));
+	pageable = ram = pfn_valid(page_to_pfn(new_page));
+	if (likely(ram)) {
+		pageable = !PageReserved(new_page);
+		as = !!new_page->mapping;
+
+		BUG_ON(!pageable && as);
+
+		pageable &= as;
+
+		/* ->nopage cannot return swapcache */
+		BUG_ON(PageSwapCache(new_page));
+		/* ->nopage cannot return anonymous pages */
+		BUG_ON(PageAnon(new_page));
+	}
 
 	/*
 	 * This is the entry point for memory under VM_RESERVED vmas.
 	 * That memory will not be tracked by the vm. These aren't
 	 * real anonymous pages, they're "device" reserved pages instead.
-	 * These pages under VM_RESERVED vmas are the only pages mapped
-	 * by the VM into userspace with page->as.mapping = NULL.
 	 */
-	reserved = vma->vm_flags & VM_RESERVED;
-	BUG_ON(!reserved && (!new_page->mapping || PageReserved(new_page)));
-
-	/* no page was available -- either SIGBUS or OOM */
-	if (new_page == NOPAGE_SIGBUS)
-		return VM_FAULT_SIGBUS;
-	if (new_page == NOPAGE_OOM)
-		return VM_FAULT_OOM;
+	reserved = !!(vma->vm_flags & VM_RESERVED);
+	BUG_ON(reserved != pageable);
 
 	/*
 	 * Should we do an early C-O-W break?
@@ -1438,6 +1442,8 @@ retry:
 	anon = 0;
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		struct page * page;
+		if (unlikely(!ram))
+			return VM_FAULT_SIGBUS;
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
 		page = alloc_page(GFP_HIGHUSER);
@@ -1460,7 +1466,8 @@ retry:
 	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
 		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
-		page_cache_release(new_page);
+		if (likely(ram))
+			page_cache_release(new_page);
 		goto retry;
 	}
 	page_table = pte_offset_map(pmd, address);
@@ -1477,20 +1484,21 @@ retry:
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		if (!PageReserved(new_page))
+		if (likely(ram && !PageReserved(new_page)))
 			++mm->rss;
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
-		if (likely(!reserved))
+		if (likely(ram))
 			page_add_rmap(new_page, vma, address, anon);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
 		pte_unmap(page_table);
-		page_cache_release(new_page);
+		if (likely(ram))
+			page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
 		goto out;
 	}
@@ -1502,7 +1510,8 @@ retry:
 	return ret;
 
  oom:
-	page_cache_release(new_page);
+	if (likely(ram))
+		page_cache_release(new_page);
 	ret = VM_FAULT_OOM;
 	goto out;
 }
