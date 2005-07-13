Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVGMTKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVGMTKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVGMTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:08:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:48709 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262446AbVGMTF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:05:59 -0400
Date: Wed, 13 Jul 2005 20:07:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fix page-becoming-writable in do_wp_page
In-Reply-To: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507132004280.6748@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Jul 2005 19:05:57.0154 (UTC) FILETIME=[E6515820:01C587DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_wp_page_mk_pte_writable was rather broken: page_mkwrite is for shared
pages, whereas the code it was trying to share was for private pages, as
the recent addition of a PageAnon test there has made more explicit.

Sort that out and reabsorb it into do_wp_page: hch and others found that
separation less than helpful.  And page_cache_get on the old_page before
page_table_lock is dropped - nothing else stabilizes the page in there.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

[I sent this out an hour and a half ago, but it still hasn't appeared,
whereas 2/3 and 3/3 did: let's try again, and sorry if it's repeated.]

 mm/memory.c |  113 +++++++++++++++++++++++++++---------------------------------
 1 files changed, 51 insertions(+), 62 deletions(-)

--- 2.6.13-rc2-mm2/mm/memory.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/mm/memory.c	2005-07-11 20:01:28.000000000 +0100
@@ -1199,58 +1199,6 @@ static inline void break_cow(struct vm_a
 }
 
 /*
- * Make a PTE writeable for do_wp_page() on a shared-writable page
- */
-static inline int do_wp_page_mk_pte_writable(struct mm_struct *mm,
-					     struct vm_area_struct *vma,
-					     unsigned long address,
-					     pmd_t *pmd,
-					     pte_t *page_table,
-					     struct page *old_page,
-					     pte_t pte)
-{
-	pte_t entry;
-
-	/* See if the VMA's owner wants to know that the page is about to
-	 * become writable */
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
-		/* Notify the page owner without the lock held so they can
-		 * sleep if they want to */
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-
-		if (vma->vm_ops->page_mkwrite(vma, old_page) < 0)
-			goto bus_error;
-
-		spin_lock(&mm->page_table_lock);
-
-		/* Since we dropped the lock we need to revalidate the PTE as
-		 * someone else may have changed it. If they did, we just
-		 * return, as we can count on the MMU to tell us if they didn't
-		 * also make it writable
-		 */
-		page_table = pte_offset_map(pmd, address);
-		if (!pte_same(*page_table, pte))
-			goto minor_fault;
-	}
-
-	flush_cache_page(vma, address, page_to_pfn(old_page));
-	entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
-			      vma);
-	ptep_set_access_flags(vma, address, page_table, entry, 1);
-	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
-	pte_unmap(page_table);
-
- minor_fault:
-	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_MINOR;
-
- bus_error:
-	return VM_FAULT_SIGBUS;
-}
-
-/*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
  * and decrementing the shared-page counter for the old page.
@@ -1275,6 +1223,8 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
+	pte_t entry;
+	int reuse;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1290,21 +1240,53 @@ static int do_wp_page(struct mm_struct *
 	}
 	old_page = pfn_to_page(pfn);
 
-	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		int reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
-		if (reuse) {
-			/* We can just make the PTE writable */
-			return do_wp_page_mk_pte_writable(mm, vma, address, pmd,
-							  page_table, old_page,
-							  pte);
+	if (unlikely(vma->vm_flags & VM_SHARED)) {
+		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
+			/*
+			 * Notify the page owner without the lock held,
+			 * so they can sleep if they want to.
+			 */
+			pte_unmap(page_table);
+			if (!PageReserved(old_page))
+				page_cache_get(old_page);
+			spin_unlock(&mm->page_table_lock);
+
+			if (vma->vm_ops->page_mkwrite(vma, old_page) < 0)
+				goto unwritable_page;
+
+			spin_lock(&mm->page_table_lock);
+			page_cache_release(old_page);
+
+			/*
+			 * Since we dropped the lock we need to revalidate
+			 * the PTE as someone else may have changed it.  If
+			 * they did, we just return, as we can count on the
+			 * MMU to tell us if they didn't also make it writable.
+			 */
+			page_table = pte_offset_map(pmd, address);
+			if (!pte_same(*page_table, pte))
+				goto success;
 		}
+		reuse = 1;
+	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
+		reuse = can_share_swap_page(old_page);
+		unlock_page(old_page);
+	} else
+		reuse = 0;
+
+	if (reuse) {
+		flush_cache_page(vma, address, pfn);
+		entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)), vma);
+		ptep_set_access_flags(vma, address, page_table, entry, 1);
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+		goto success;
 	}
-	pte_unmap(page_table);
 
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
+	pte_unmap(page_table);
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
@@ -1321,6 +1303,7 @@ static int do_wp_page(struct mm_struct *
 			goto no_new_page;
 		copy_user_highpage(new_page, old_page, address);
 	}
+
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
@@ -1341,15 +1324,21 @@ static int do_wp_page(struct mm_struct *
 		/* Free the old page.. */
 		new_page = old_page;
 	}
-	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
+
+success:
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 
 no_new_page:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
+
+unwritable_page:
+	page_cache_release(old_page);
+	return VM_FAULT_SIGBUS;
 }
 
 /*
