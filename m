Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271626AbRHZXyO>; Sun, 26 Aug 2001 19:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271628AbRHZXyF>; Sun, 26 Aug 2001 19:54:05 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:63449 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271626AbRHZXx4>; Sun, 26 Aug 2001 19:53:56 -0400
Date: Mon, 27 Aug 2001 00:55:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Linux 2.4.8-ac12 not all there
In-Reply-To: <20010826171335.A9362@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0108270035470.9341-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Alan Cox wrote:
> 
> 2.4.8-ac12
> ....
> o	lock_kiovec page unwind fix			(Velizar B)
> o	do_swap_page recheck pte before failing		(Linus, Jeremy Linton)
> o	do_swap_page doesn't mkwrite when deleting	(Linus)
> 	| From 2.4.9 with extra comments etc		(Hugh Dickins)
> ....

Those items (not checked more) missing from patch-2.4.8-ac12.bz2:
the ac12 mm/memory.c same as ac11 version.  Perhaps that patch
collided with more general 2.4.9 merge and ended up reversing.
Patch below against 2.4.8-ac11 applies equally to 2.4.8-ac12.

Hugh

--- 2.4.8-ac11/mm/memory.c	Sat Aug 25 09:44:49 2001
+++ linux/mm/memory.c	Sat Aug 25 10:51:59 2001
@@ -613,9 +613,9 @@
 			
 			if (TryLockPage(page)) {
 				while (j--) {
-					page = *(--ppage);
-					if (page)
-						UnlockPage(page);
+					struct page *tmp = *--ppage;
+					if (tmp)
+						UnlockPage(tmp);
 				}
 				goto retry;
 			}
@@ -1101,9 +1101,10 @@
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
-	pte_t * page_table, swp_entry_t entry, int write_access)
+	pte_t * page_table, pte_t orig_pte, int write_access)
 {
 	struct page *page;
+	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = 1;
 
@@ -1116,7 +1117,11 @@
 		unlock_kernel();
 		if (!page) {
 			spin_lock(&mm->page_table_lock);
-			return -1;
+			/*
+			 * Back out if somebody else faulted in this pte while
+			 * we released the page table lock.
+			 */
+			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
 
 		/* Had to read the page from swap area: Major fault */
@@ -1135,7 +1140,7 @@
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
-	if (pte_present(*page_table)) {
+	if (!pte_same(*page_table, orig_pte)) {
 		UnlockPage(page);
 		page_cache_release(page);
 		return 1;
@@ -1146,21 +1151,25 @@
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	swap_free(entry);
-	if (write_access && exclusive_swap_page(page))
-		pte = pte_mkwrite(pte_mkdirty(pte));
-
-	/*
-	 * If swap space is getting low and we were the last user
-	 * of this piece of swap space, we free this space so
-	 * somebody else can be swapped out.
-	 *
-	 * We are protected against try_to_swap_out() because the
-	 * page is locked and against do_fork() because we have
-	 * read_lock(&mm->mmap_sem).
-	 */
-	if (vm_swap_full() && exclusive_swap_page(page)) {
-		delete_from_swap_cache_nolock(page);
-		pte = pte_mkwrite(pte_mkdirty(pte));
+	if (exclusive_swap_page(page)) {	
+		if (write_access)
+			pte = pte_mkwrite(pte_mkdirty(pte));
+		/*
+		 * If swap space is getting low and we were the last user
+		 * of this piece of swap space, we free this space so
+		 * somebody else can be swapped out.
+		 *
+		 * We hold the page lock (required whenever adding to or
+		 * removing from the swap cache), and the page_table_lock
+		 * prevents concurrent swap_duplicate()s of this exclusive
+		 * entry by try_to_swap_out() or fork's copy_page_range() -
+		 * there's even a second level of protection, page lock
+		 * prevents try_to_swap_out() and mmap_sem prevents do_fork().
+		 */
+		if (vm_swap_full()) {
+			delete_from_swap_cache_nolock(page);
+			pte = pte_mkdirty(pte);
+		}
 	}
 	UnlockPage(page);
 
@@ -1329,7 +1338,7 @@
 		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte);
-		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);
+		return do_swap_page(mm, vma, address, pte, entry, write_access);
 	}
 
 	entry = ptep_get_and_clear(pte);

