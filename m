Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbULOWtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbULOWtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbULOWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:49:11 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:16853 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262522AbULOWtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:49:00 -0500
Date: Wed, 15 Dec 2004 23:48:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215224826.GC28286@dualathlon.random>
References: <20041215011132.GA16099@kroah.com> <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain> <20041215175805.GA9207@kroah.com> <20041215190343.GI16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215190343.GI16322@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 08:03:43PM +0100, Andrea Arcangeli wrote:
> +			if (page->mapping)
> +				page_remove_rmap(page);

This had to be page_mapping, since I believe the page->mapping can go
away with the truncate while the page is still being mapped.

The rule is that if a page must not be accounted it will never be
accounted and page_mapping will be always 0. If it has been accounted
previously, then it must be unaccounted too. This worked fine so far.

Plus I noticed other goodness that got dropped in the same area from my
original 2.6.5 patches, and I resurrected those too in sync with SP1
(I'm talking about the fork path).
 
So here an updated patch, please give this one a spin.

From: Andrea Arcangeli <andrea@suse.de>
Subject: don't track pages not belonging to a mapping out of ->nopage

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- sl9.2/mm/memory.c.~1~	2004-12-15 14:20:54.000000000 +0100
+++ sl9.2/mm/memory.c	2004-12-15 23:20:05.353858232 +0100
@@ -327,7 +327,17 @@ skip_copy_pte_range:
 				get_page(page);
 				dst->rss++;
 				set_pte(dst_pte, pte);
-				page_dup_rmap(page);
+				if (likely(!(vma->vm_flags & VM_RESERVED))) {
+					/*
+					 * Device driver pages must not be
+					 * tracked by the VM for unmapping.
+					 */
+					if (likely(page_mapped(page) && page->mapping))
+						page_dup_rmap(page);
+				} else {
+					BUG_ON(page_mapped(page));
+					BUG_ON(page->mapping);
+				}
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
 				if (address >= end) {
@@ -427,7 +437,8 @@ static void zap_pte_range(struct mmu_gat
 			if (pte_young(pte) && !PageAnon(page))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			if (page_mapped(page))
+				page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1495,7 +1506,7 @@ do_no_page(struct mm_struct *mm, struct 
 	pte_t entry;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
-	int anon = 0;
+	int anon, pageable, as;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
@@ -1517,9 +1528,26 @@ retry:
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
+#ifndef CONFIG_DISCONTIGMEM
+	/* this check is unreliable with numa enabled */
+	BUG_ON(!pfn_valid(page_to_pfn(new_page)));
+#endif
+	pageable = !PageReserved(new_page);
+	as = !!new_page->mapping;
+
+	BUG_ON(!pageable && as);
+
+	pageable &= as;
+
+	/* ->nopage cannot return swapcache */
+	BUG_ON(PageSwapCache(new_page));
+	/* ->nopage cannot return anonymous pages */
+	BUG_ON(PageAnon(new_page));
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */
+	anon = 0;
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		struct page *page;
 
@@ -1532,6 +1560,10 @@ retry:
 		page_cache_release(new_page);
 		new_page = page;
 		anon = 1;
+		pageable = 1; /* not really necessary but cleaner */
+
+		/* a reserved vma cannot have pageable pages in it */
+		BUG_ON(vma->vm_flags & VM_RESERVED);
 	}
 
 	spin_lock(&mm->page_table_lock);
@@ -1571,7 +1603,7 @@ retry:
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else
+		} else if (pageable)
 			page_add_file_rmap(new_page);
 		pte_unmap(page_table);
 	} else {
