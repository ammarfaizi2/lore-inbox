Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUEDWWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUEDWWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUEDWWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:22:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10510 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261347AbUEDWWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:22:16 -0400
Date: Tue, 4 May 2004 23:22:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 22 flush_dcache_mmap_lock
In-Reply-To: <Pine.LNX.4.44.0405042315160.2156-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405042320100.2156-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm and parisc __flush_dcache_page have been scanning the i_mmap(_shared)
list without locking or disabling preemption.  That may be even more
unsafe now it's a prio tree instead of a list.

It looks like we cannot use i_shared_lock for this protection: most uses
of flush_dcache_page are okay, and only one would need lock ordering
fixed (get_user_pages holds page_table_lock across flush_dcache_page);
but there's a few (e.g. in net and ntfs) which look as if they're using
it in I/O completion - and it would be restrictive to disallow it there.

So, on arm and parisc only, define flush_dcache_mmap_lock(mapping) as
spin_lock_irq(&(mapping)->tree_lock); on i386 (and other arches left
to the next patch) define it away to nothing; and use where needed.

While updating locking hierarchy in filemap.c, remove two layers of the
fossil record from add_to_page_cache comment: no longer used for swap.

I believe all the #includes will work out, but have only built i386.
I can see several things about this patch which might cause revulsion:
the name flush_dcache_mmap_lock?  the reuse of the page radix_tree's
tree_lock for this different purpose?  spin_lock_irqsave instead?
can't we somehow get i_shared_lock to handle the problem?

 arch/arm/mm/fault-armv.c        |    5 +++++
 arch/parisc/kernel/cache.c      |    2 ++
 include/asm-arm/cacheflush.h    |    5 +++++
 include/asm-i386/cacheflush.h   |    2 ++
 include/asm-parisc/cacheflush.h |    5 +++++
 kernel/fork.c                   |    2 ++
 mm/filemap.c                    |   10 +++-------
 mm/fremap.c                     |    2 ++
 mm/mmap.c                       |   10 +++++++++-
 9 files changed, 35 insertions(+), 8 deletions(-)

--- rmap21/arch/arm/mm/fault-armv.c	2004-05-04 21:21:28.883451832 +0100
+++ rmap22/arch/arm/mm/fault-armv.c	2004-05-04 21:21:50.954096584 +0100
@@ -94,6 +94,8 @@ void __flush_dcache_page(struct page *pa
 	 * and invalidate any user data.
 	 */
 	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+
+	flush_dcache_mmap_lock(mapping);
 	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
@@ -106,6 +108,7 @@ void __flush_dcache_page(struct page *pa
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		flush_cache_page(mpnt, mpnt->vm_start + offset);
 	}
+	flush_dcache_mmap_unlock(mapping);
 }
 
 static void
@@ -129,6 +132,7 @@ make_coherent(struct vm_area_struct *vma
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
+	flush_dcache_mmap_lock(mapping);
 	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
@@ -143,6 +147,7 @@ make_coherent(struct vm_area_struct *vma
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
 	}
+	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
 		adjust_pte(vma, addr);
 	else
--- rmap21/arch/parisc/kernel/cache.c	2004-05-04 21:21:28.883451832 +0100
+++ rmap22/arch/parisc/kernel/cache.c	2004-05-04 21:21:50.955096432 +0100
@@ -244,6 +244,7 @@ void __flush_dcache_page(struct page *pa
 
 	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
+	flush_dcache_mmap_lock(mapping);
 	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
@@ -262,6 +263,7 @@ void __flush_dcache_page(struct page *pa
 		 */
 		break;
 	}
+	flush_dcache_mmap_unlock(mapping);
 }
 EXPORT_SYMBOL(__flush_dcache_page);
 
--- rmap21/include/asm-arm/cacheflush.h	2004-04-28 07:07:11.000000000 +0100
+++ rmap22/include/asm-arm/cacheflush.h	2004-05-04 21:21:50.956096280 +0100
@@ -303,6 +303,11 @@ static inline void flush_dcache_page(str
 		__flush_dcache_page(page);
 }
 
+#define flush_dcache_mmap_lock(mapping) \
+	spin_lock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_unlock(mapping) \
+	spin_unlock_irq(&(mapping)->tree_lock)
+
 #define flush_icache_user_range(vma,page,addr,len) \
 	flush_dcache_page(page)
 
--- rmap21/include/asm-i386/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap22/include/asm-i386/cacheflush.h	2004-05-04 21:21:50.956096280 +0100
@@ -10,6 +10,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap21/include/asm-parisc/cacheflush.h	2004-04-28 07:07:13.000000000 +0100
+++ rmap22/include/asm-parisc/cacheflush.h	2004-05-04 21:21:50.957096128 +0100
@@ -78,6 +78,11 @@ static inline void flush_dcache_page(str
 	}
 }
 
+#define flush_dcache_mmap_lock(mapping) \
+	spin_lock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_unlock(mapping) \
+	spin_unlock_irq(&(mapping)->tree_lock)
+
 #define flush_icache_page(vma,page)	do { flush_kernel_dcache_page(page_address(page)); flush_kernel_icache_page(page_address(page)); } while (0)
 
 #define flush_icache_range(s,e)		do { flush_kernel_dcache_range_asm(s,e); flush_kernel_icache_range_asm(s,e); } while (0)
--- rmap21/kernel/fork.c	2004-04-30 11:58:46.000000000 +0100
+++ rmap22/kernel/fork.c	2004-05-04 21:21:50.958095976 +0100
@@ -331,7 +331,9 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&file->f_mapping->i_shared_lock);
+			flush_dcache_mmap_lock(mapping);
 			vma_prio_tree_add(tmp, mpnt);
+			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&file->f_mapping->i_shared_lock);
 		}
 
--- rmap21/mm/filemap.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap22/mm/filemap.c	2004-05-04 21:21:50.960095672 +0100
@@ -65,7 +65,9 @@
  *    ->i_shared_lock		(truncate->unmap_mapping_range)
  *
  *  ->mmap_sem
- *    ->i_shared_lock		(various places)
+ *    ->i_shared_lock
+ *      ->page_table_lock	(various places, mainly in mmap.c)
+ *        ->mapping->tree_lock	(arch-dependent flush_dcache_mmap_lock)
  *
  *  ->mmap_sem
  *    ->lock_page		(access_process_vm)
@@ -240,12 +242,6 @@ int filemap_write_and_wait(struct addres
 }
 
 /*
- * This adds a page to the page cache, starting out as locked, unreferenced,
- * not uptodate and with no errors.
- *
- * This function is used for two things: adding newly allocated pagecache
- * pages and for moving existing anon pages into swapcache.
- *
  * This function is used to add newly allocated pagecache pages:
  * the page is new, so we can just run SetPageLocked() against it.
  * The other page state flags were set by rmqueue().
--- rmap21/mm/fremap.c	2004-05-04 21:21:28.890450768 +0100
+++ rmap22/mm/fremap.c	2004-05-04 21:21:50.961095520 +0100
@@ -202,11 +202,13 @@ asmlinkage long sys_remap_file_pages(uns
 		    !(vma->vm_flags & VM_NONLINEAR)) {
 			mapping = vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_shared_lock);
+			flush_dcache_mmap_lock(mapping);
 			vma->vm_flags |= VM_NONLINEAR;
 			vma_prio_tree_remove(vma, &mapping->i_mmap);
 			vma_prio_tree_init(vma);
 			list_add_tail(&vma->shared.vm_set.list,
 					&mapping->i_mmap_nonlinear);
+			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&mapping->i_shared_lock);
 		}
 
--- rmap21/mm/mmap.c	2004-05-04 21:21:28.894450160 +0100
+++ rmap22/mm/mmap.c	2004-05-04 21:21:50.963095216 +0100
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 
 #include <asm/uaccess.h>
+#include <asm/cacheflush.h>
 #include <asm/tlb.h>
 
 /*
@@ -72,10 +73,12 @@ static inline void __remove_shared_vm_st
 	if (vma->vm_flags & VM_SHARED)
 		mapping->i_mmap_writable--;
 
+	flush_dcache_mmap_lock(mapping);
 	if (unlikely(vma->vm_flags & VM_NONLINEAR))
 		list_del_init(&vma->shared.vm_set.list);
 	else
 		vma_prio_tree_remove(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
 
 /*
@@ -264,11 +267,13 @@ static inline void __vma_link_file(struc
 		if (vma->vm_flags & VM_SHARED)
 			mapping->i_mmap_writable++;
 
+		flush_dcache_mmap_lock(mapping);
 		if (unlikely(vma->vm_flags & VM_NONLINEAR))
 			list_add_tail(&vma->shared.vm_set.list,
 					&mapping->i_mmap_nonlinear);
 		else
 			vma_prio_tree_insert(vma, &mapping->i_mmap);
+		flush_dcache_mmap_unlock(mapping);
 	}
 }
 
@@ -348,14 +353,17 @@ void vma_adjust(struct vm_area_struct *v
 	}
 	spin_lock(&mm->page_table_lock);
 
-	if (root)
+	if (root) {
+		flush_dcache_mmap_lock(mapping);
 		vma_prio_tree_remove(vma, root);
+	}
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
 	if (root) {
 		vma_prio_tree_init(vma);
 		vma_prio_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
 	}
 
 	if (next) {

