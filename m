Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbQJ0UWI>; Fri, 27 Oct 2000 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbQJ0UV6>; Fri, 27 Oct 2000 16:21:58 -0400
Received: from ns.caldera.de ([212.34.180.1]:50948 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130285AbQJ0UVu>;
	Fri, 27 Oct 2000 16:21:50 -0400
Date: Fri, 27 Oct 2000 22:21:43 +0200
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001027222143.A8059@caldera.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, forgot to Cc linux-kernel ...
Please Cc linus on reply.

----- Forwarded message from Christoph Hellwig <hch@caldera.de> -----

Date: Fri, 27 Oct 2000 22:03:54 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
X-Mailer: Mutt 1.0i

Hi Linus,

Stephen Tweedies last kiobuf patchset contained a lot bu fixes
besides new features. These bug-fixes are not yet merged in 2.4.0.

This patch contains forward-ports of the follwoing fixes
(quote from his 00README):

01-mapfix.diff

	map_user_kiobuf() retries failed maps to cover a race in which
	the swapper steals a page before the kiobuf has grabbed and
	locked it.

02-iocount.diff

	Kanoj Sarcar's fixes to allow kiobufs to work properly over
	fork(), even on threaded applications.

04-eiofix.diff

	Fix to return -EIO instead of 0 if a raw I/O read or write
	encounters an error in the first block.

06-enxio.diff
	Return ENXIO on read/write at or beyond the end of the device
	for raw I/O

Please apply.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.


diff -uNr --exclude-from=dontdiff linux.orig/drivers/char/raw.c linux/drivers/char/raw.c
--- linux.orig/drivers/char/raw.c	Thu Oct 19 13:21:24 2000
+++ linux/drivers/char/raw.c	Tue Oct 24 13:25:47 2000
@@ -277,8 +277,11 @@
 	
 	if ((*offp & sector_mask) || (size & sector_mask))
 		return -EINVAL;
-	if ((*offp >> sector_bits) > limit)
+	if ((*offp >> sector_bits) > limit) {
+		if (size)
+			return -ENXIO;
 		return 0;
+	}
 
 	/* 
 	 * We'll just use one kiobuf
diff -uNr --exclude-from=dontdiff linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Tue Oct 24 13:15:49 2000
+++ linux/fs/buffer.c	Tue Oct 24 13:26:31 2000
@@ -1924,6 +1924,8 @@
 	
 	spin_unlock(&unused_list_lock);
 
+	if (!iosize)
+		return -EIO;
 	return iosize;
 }
 
diff -uNr --exclude-from=dontdiff linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Tue Oct 24 13:15:56 2000
+++ linux/include/linux/mm.h	Tue Oct 24 14:41:46 2000
@@ -157,8 +157,9 @@
 	wait_queue_head_t wait;
 	struct page **pprev_hash;
 	struct buffer_head * buffers;
-	void *virtual; /* non-NULL if kmapped */
+	void *virtual;		/* non-NULL if kmapped */
 	struct zone_struct *zone;
+	atomic_t rawcount;	/* count of raw io in progress */
 } mem_map_t;
 
 #define get_page(p)		atomic_inc(&(p)->count)
diff -uNr --exclude-from=dontdiff linux.orig/mm/memory.c linux/mm/memory.c
--- linux.orig/mm/memory.c	Tue Oct 24 13:15:58 2000
+++ linux/mm/memory.c	Tue Oct 24 16:09:22 2000
@@ -138,6 +138,30 @@
 	check_pgt_cache();
 }
 
+/*
+ * Establish a new mapping:
+ *  - flush the old one
+ *  - update the page tables
+ *  - inform the TLB about the new one
+ */
+static inline void establish_pte(struct vm_area_struct * vma, unsigned long address,
+				pte_t *page_table, pte_t entry)
+{
+	flush_tlb_page(vma, address);
+	set_pte(page_table, entry);
+	update_mmu_cache(vma, address, entry);
+}
+
+static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page,
+				struct page * new_page, unsigned long address, 
+		pte_t *page_table)
+{
+	copy_cow_page(old_page,new_page,address);
+	flush_page_to_ram(new_page);
+	flush_cache_page(vma, address);
+	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+}
+
 #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
 
@@ -227,6 +251,22 @@
 
 				/* If it's a COW mapping, write protect it both in the parent and the child */
 				if (cow) {
+					/* Rawio in progress? */
+					if (atomic_read(&ptepage->rawcount)) {
+						/*
+						 * If pte is dirty, its a private page,
+						 * rawio was initiated by a clone.
+						 * For dmain operation, need to break
+						 * cow.
+						 */
+						if (pte_dirty(pte)) {
+							struct page * new_page = alloc_page(GFP_HIGHUSER);
+							if (!new_page)
+								goto nomem;
+							break_cow(vma, ptepage, new_page, address, dst_pte);
+							goto cont_copy_pte_range;
+						}
+					}
 					ptep_clear_wrprotect(src_pte);
 					pte = *src_pte;
 				}
@@ -382,9 +422,12 @@
 
 
 /*
- * Do a quick page-table lookup for a single page. 
+ * Do a quick page-table lookup for a single page. We have already verified
+ * access type, and done a fault in. But, kswapd might have stolen the page
+ * in the meantime. Return an indication of whether we should retry the fault
+ * in. Writability test is superfluous but conservative.
  */
-static struct page * follow_page(unsigned long address) 
+static struct page * follow_page(unsigned long address, int writeacc, int * ret) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -393,10 +436,15 @@
 	pmd = pmd_offset(pgd, address);
 	if (pmd) {
 		pte_t * pte = pte_offset(pmd, address);
-		if (pte && pte_present(*pte))
+		if (pte && pte_present(*pte)) {
+			if (writeacc && !pte_write(*pte))
+				goto retry;
 			return pte_page(*pte);
+		}
 	}
-	
+
+retry:
+	*ret = 1;
 	return NULL;
 }
 
@@ -428,7 +476,8 @@
 	struct page *		map;
 	int			i;
 	int			datain = (rw == READ);
-	
+	int			failed;
+
 	/* Make sure the iobuf is not already mapped somewhere. */
 	if (iobuf->nr_pages)
 		return -EINVAL;
@@ -467,23 +516,28 @@
 			}
 			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
 					(!(vma->vm_flags & VM_READ))) {
-				err = -EACCES;
 				goto out_unlock;
 			}
 		}
+
+faultin:
 		if (handle_mm_fault(current->mm, vma, ptr, datain) <= 0) 
 			goto out_unlock;
 		spin_lock(&mm->page_table_lock);
-		map = follow_page(ptr);
-		if (!map) {
+		map = follow_page(ptr, datain, &failed);
+		if (failed) {
+			/*
+			 * Page got stolen before we could lock it down.
+			 * Retry.
+			 */
 			spin_unlock(&mm->page_table_lock);
-			dprintk (KERN_ERR "Missing page in map_user_kiobuf\n");
-			goto out_unlock;
+			goto faultin;
 		}
 		map = get_page_map(map);
-		if (map)
+		if (map) { 
 			atomic_inc(&map->count);
-		else
+			atomic_inc(&map->rawcount);
+		} else
 			printk (KERN_INFO "Mapped page missing [%d]\n", i);
 		spin_unlock(&mm->page_table_lock);
 		iobuf->maplist[i] = map;
@@ -519,6 +573,7 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
+			atomic_dec(&map->rawcount);
 			__free_page(map);
 		}
 	}
@@ -771,28 +826,6 @@
 	} while (from && (from < end));
 	flush_tlb_range(current->mm, beg, end);
 	return error;
-}
-
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	flush_tlb_page(vma, address);
-	set_pte(page_table, entry);
-	update_mmu_cache(vma, address, entry);
-}
-
-static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page, struct page * new_page, unsigned long address, 
-		pte_t *page_table)
-{
-	copy_cow_page(old_page,new_page,address);
-	flush_page_to_ram(new_page);
-	flush_cache_page(vma, address);
-	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
 
 /*
diff -uNr --exclude-from=dontdiff linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Tue Oct 24 13:15:58 2000
+++ linux/mm/page_alloc.c	Tue Oct 24 13:36:44 2000
@@ -98,6 +98,8 @@
 		BUG();
 	if (PageInactiveClean(page))
 		BUG();
+	if (atomic_read(&page->rawcount))
+		BUG();
 
 	page->flags &= ~(1<<PG_referenced);
 	page->age = PAGE_AGE_START;
@@ -819,6 +821,7 @@
 	 */
 	for (p = lmem_map; p < lmem_map + totalpages; p++) {
 		set_page_count(p, 0);
+		atomic_set(&(p)->rawcount, 0);
 		SetPageReserved(p);
 		init_waitqueue_head(&p->wait);
 		memlist_init(&p->list);

----- End forwarded message -----

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
