Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbULOTJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbULOTJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbULOTJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:09:36 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:43749 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262392AbULOTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:03:58 -0500
Date: Wed, 15 Dec 2004 20:03:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215190343.GI16322@dualathlon.random>
References: <20041215011132.GA16099@kroah.com> <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain> <20041215175805.GA9207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215175805.GA9207@kroah.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was my original code in GA/SP1:

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

[..]

		/* a reserved vma cannot have pageable pages in it */
		BUG_ON(vma->vm_flags & VM_RESERVED);
[..]
	if (likely(pageable))
			page_add_rmap(new_page, vma, address, anon);




Hugh rejected all the above robustness bugcheck for no apparent good
reason.

In the process he seems that Hugh introduced a bug that didn't exist in
my original code, can you try this?

From: Andrea Arcangeli <andrea@suse.de>
Subject: don't track pages not belonging to a mapping out of ->nopage

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- sl9.2/mm/memory.c.~1~	2004-12-15 14:20:54.000000000 +0100
+++ sl9.2/mm/memory.c	2004-12-15 19:59:59.806978776 +0100
@@ -427,7 +427,8 @@ static void zap_pte_range(struct mmu_gat
 			if (pte_young(pte) && !PageAnon(page))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			if (page->mapping)
+				page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1495,7 +1496,7 @@ do_no_page(struct mm_struct *mm, struct 
 	pte_t entry;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
-	int anon = 0;
+	int anon, pageable, as;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
@@ -1517,9 +1518,26 @@ retry:
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
 
@@ -1532,6 +1550,10 @@ retry:
 		page_cache_release(new_page);
 		new_page = page;
 		anon = 1;
+		pageable = 1; /* not really necessary but cleaner */
+
+		/* a reserved vma cannot have pageable pages in it */
+		BUG_ON(vma->vm_flags & VM_RESERVED);
 	}
 
 	spin_lock(&mm->page_table_lock);
@@ -1571,7 +1593,7 @@ retry:
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else
+		} else if (pageable)
 			page_add_file_rmap(new_page);
 		pte_unmap(page_table);
 	} else {
