Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267393AbUHPDbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267393AbUHPDbw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHPDbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:31:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27090 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267393AbUHPD35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:29:57 -0400
Date: Sun, 15 Aug 2004 20:29:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@redhat.com>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
In-Reply-To: <20040815185644.24ecb247.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, David S. Miller wrote:

> On Sun, 15 Aug 2004 17:11:53 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
>
> > pgd/pmd walking should be possible always even without the vma semaphore
> > since the CPU can potentially walk the chain at anytime.
>
> munmap() can destroy pmd and pte tables.  somehow we have
> to protect against that, and currently that is having the
> VMA semaphore held for reading, see free_pgtables().

It looks to me like the code takes care to provide the correct
sequencing so that the integrity of pgd,pmd and pte links is
guaranteed from the viewpoint of the MMU in the CPUs. munmap is there to
protect one kernel thread messing with the addresses of these entities
that might be stored in another threads register.

Therefore it is safe to walk the chain only holding the semaphore read
lock?

If the mmap lock already guarantees the integrity of the pgd,pmd,pte
system, then pte locking would be okay as long as integrity of the
pgd,pmd and pte's is always guaranteed. Then also adding a lock bit would
work.

So then there are two ways of modifying the pgd,pmd and pte's.

A) Processor obtains vma semaphore write lock and does large scale
modifications to pgd,pmd,pte.

B) Processor obtains vma semaphore read lock but is still free to do
modifications on individual pte's while holding that vma lock. There is no
need to acquire the page_table_lock. These changes must be atomic.

The role of the page_table_lock is restricted *only* to the "struct
page" stuff? It says in the comments regarding handle_mm_fault that the
lock is taken for synchronization with kswapd in regards to the pte
entries. Seems that this use of the page_table_lock is wrong. A or B
should have been used.

We could simply remove the page_table_lock from handle_mm_fault and
provide the synchronization with kswapd with pte locks right? Both
processes are essentially doing modifications on pte's while holding the
vma read lock and I would be changing the way of synchronization between
these two processes.

F.e. something along these lines removing the page_table_lock from
handle_mm_fault and friends. Surprisingly this will also avoid many
rereads of the pte's since the pte's are really locked. This is just for
illustrative purpose and unfinished...

Index: linux-2.6.8.1/mm/memory.c
===================================================================
--- linux-2.6.8.1.orig/mm/memory.c	2004-08-15 06:03:04.000000000 -0700
+++ linux-2.6.8.1/mm/memory.c	2004-08-15 20:26:29.000000000 -0700
@@ -1035,8 +1035,7 @@
  * change only once the write actually happens. This avoids a few races,
  * and potentially makes it more efficient.
  *
- * We hold the mm semaphore and the page_table_lock on entry and exit
- * with the page_table_lock released.
+ * We hold the mm semaphore.
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
@@ -1051,10 +1050,10 @@
 		 * at least the kernel stops what it's doing before it corrupts
 		 * data, but for the moment just pretend this is OOM.
 		 */
+		ptep_unlock(page_table);
 		pte_unmap(page_table);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
-		spin_unlock(&mm->page_table_lock);
 		return VM_FAULT_OOM;
 	}
 	old_page = pfn_to_page(pfn);
@@ -1069,7 +1068,7 @@
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			/* pte lock unlocked by ptep_set_access */
 			return VM_FAULT_MINOR;
 		}
 	}
@@ -1080,7 +1079,7 @@
 	 */
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);
-	spin_unlock(&mm->page_table_lock);
+	ptep_unlock(page_table);

 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
@@ -1090,26 +1089,21 @@
 	copy_cow_page(old_page,new_page,address);

 	/*
-	 * Re-check the pte - we dropped the lock
+	 * There is no need to recheck. The pte was locked
 	 */
-	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
-	if (likely(pte_same(*page_table, pte))) {
-		if (PageReserved(old_page))
-			++mm->rss;
-		else
-			page_remove_rmap(old_page);
-		break_cow(vma, new_page, address, page_table);
-		lru_cache_add_active(new_page);
-		page_add_anon_rmap(new_page, vma, address);
+	if (PageReserved(old_page))
+		++mm->rss;
+	else
+		page_remove_rmap(old_page);
+	break_cow(vma, new_page, address, page_table);
+	lru_cache_add_active(new_page);
+	page_add_anon_rmap(new_page, vma, address);

-		/* Free the old page.. */
-		new_page = old_page;
-	}
+	/* Free the old page.. */
+	new_page = old_page;
 	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;

 no_new_page:
@@ -1314,8 +1308,8 @@
 }

 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore and a pte lock n entry and
+ * should release the pte lock on exit..
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1327,27 +1321,10 @@
 	int ret = VM_FAULT_MINOR;

 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
-		if (!page) {
-			/*
-			 * Back out if somebody else faulted in this pte while
-			 * we released the page table lock.
-			 */
-			spin_lock(&mm->page_table_lock);
-			page_table = pte_offset_map(pmd, address);
-			if (likely(pte_same(*page_table, orig_pte)))
-				ret = VM_FAULT_OOM;
-			else
-				ret = VM_FAULT_MINOR;
-			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
-		}
-
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		inc_page_state(pgmajfault);
@@ -1356,21 +1333,6 @@
 	mark_page_accessed(page);
 	lock_page(page);

-	/*
-	 * Back out if somebody else faulted in this pte while we
-	 * released the page table lock.
-	 */
-	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
-	if (unlikely(!pte_same(*page_table, orig_pte))) {
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-		unlock_page(page);
-		page_cache_release(page);
-		ret = VM_FAULT_MINOR;
-		goto out;
-	}
-
 	/* The page isn't present yet, go ahead with the fault. */

 	swap_free(entry);
@@ -1398,8 +1360,8 @@

 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
+	ptep_unlock(page_table);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
 }
@@ -1424,7 +1386,6 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1433,13 +1394,12 @@
 			goto no_mem;
 		clear_user_highpage(page, addr);

-		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);

 		if (!pte_none(*page_table)) {
+			ptep_unlock(page_table);
 			pte_unmap(page_table);
 			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
 		mm->rss++;
@@ -1456,7 +1416,6 @@

 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return VM_FAULT_MINOR;
 no_mem:
@@ -1472,8 +1431,8 @@
  * As this is called only for pages that do not currently exist, we
  * do not need to flush old virtual caches or the TLB.
  *
- * This is called with the MM semaphore held and the page table
- * spinlock held. Exit with the spinlock released.
+ * This is called with the MM semaphore held and pte lock
+ * held. Exit with the pte lock released.
  */
 static int
 do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -1489,9 +1448,9 @@
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
 					pmd, write_access, address);
+	ptep_unlock(page_table);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
-
+
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		sequence = atomic_read(&mapping->truncate_count);
@@ -1523,7 +1482,7 @@
 		anon = 1;
 	}

-	spin_lock(&mm->page_table_lock);
+	while (ptep_lock(page_table)) ;
 	/*
 	 * For a file-backed vma, someone could have truncated or otherwise
 	 * invalidated this page.  If unmap_mapping_range got called,
@@ -1532,7 +1491,7 @@
 	if (mapping &&
 	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
 		sequence = atomic_read(&mapping->truncate_count);
-		spin_unlock(&mm->page_table_lock);
+		ptep_unlock(page_table);
 		page_cache_release(new_page);
 		goto retry;
 	}
@@ -1565,15 +1524,15 @@
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
+		ptep_unlock(page_table);
 		pte_unmap(page_table);
 		page_cache_release(new_page);
-		spin_unlock(&mm->page_table_lock);
 		goto out;
 	}

 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
-	spin_unlock(&mm->page_table_lock);
+	ptep_unlock(page_table);
 out:
 	return ret;
 oom:
@@ -1606,8 +1565,8 @@

 	pgoff = pte_to_pgoff(*pte);

+	ptep_unlock(pte);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);

 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
@@ -1644,13 +1603,11 @@
 {
 	pte_t entry;

-	entry = *pte;
+	entry = *pte;	/* get the unlocked value so that we do not write the lock bit back */
+
+	if (ptep_lock(pte)) return VM_FAULT_MINOR;
+
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte, pmd);
 		if (pte_file(entry))
@@ -1668,7 +1625,6 @@
 	ptep_set_access_flags(vma, address, pte, entry, write_access);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 }

@@ -1688,12 +1644,6 @@

 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
-
-	/*
-	 * We need the page table lock to synchronize with kswapd
-	 * and the SMP-safe atomic PTE updates.
-	 */
-	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);

 	if (pmd) {
@@ -1701,7 +1651,6 @@
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }

Index: linux-2.6.8.1/mm/rmap.c
===================================================================
--- linux-2.6.8.1.orig/mm/rmap.c	2004-08-14 03:56:22.000000000 -0700
+++ linux-2.6.8.1/mm/rmap.c	2004-08-15 19:59:32.000000000 -0700
@@ -494,8 +494,14 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
+#ifdef __HAVE_ARCH_PTE_LOCK
+	/* If we would simply zero the pte then handle_mm_fault might
+	 * race against this code and reinstate an anonymous mapping
+	 */
+	pteval = ptep_clear_and_lock_flush(vma, address, pte);
+#else
 	pteval = ptep_clear_flush(vma, address, pte);
-
+#endif
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
@@ -508,9 +514,13 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
+		/* This is going to clear the lock that may have been set on the pte */
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 	}
+#ifdef __HAVE_ARCH_PTE_LOCK
+	else ptep_unlock(pte);
+#endif

 	mm->rss--;
 	BUG_ON(!page->mapcount);
