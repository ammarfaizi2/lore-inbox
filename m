Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUCHUYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUCHUYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:24:40 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60178
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261183AbUCHUX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:23:59 -0500
Date: Mon, 8 Mar 2004 21:24:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040308202433.GA12612@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch avoids the allocation of rmap for shared memory and it uses
the objrmap framework to do find the mapping-ptes starting from a
page_t which is zero memory cost, (and zero cpu cost for the fast paths).

patch applies cleanly to linux-2.5 CVS. I suggest it for merging into
mainline.

without this patch not even the 4:4 tlb overhead would allow intensive
shm (shmfs+IPC) workloads to surivive on 32bit archs. Basically without
this fix it's like 2.6 is running w/o pte-highmem. 700 tasks with 2.7G
of shm mapped each would run the box out of zone-normal even with 4:4.
With 3:1 100 tasks would be enough. Math is easy:

	2.7*1024*1024*1024/4096*8*100/1024/1024/1024
	2.7*1024*1024*1024/4096*8*700/1024/1024/1024

But the real reason of this work is for huge 64bit archs, so we speedup
and avoid to waste tons of ram. on 32-ways the scalability is hurted
very badly by rmap, so it has to be removed (Martin can provide the
numbers I think).

Even with this fix removing rmap for the file mappings, the anonymous
memory will still pay for the rmap slowdown (still very relevant for
various critical apps), so I just finished designing a new method for
unmapping ptes of anonymous mappings too. it's not Hugh's anobjrmap
patch because (despite being very useful to get the right mindset) its
design was flawed since it was tracking mm not vmas and the page->index
as an absolute address not an offset, so it was breaking with mremap
(forcing him to reinstantiate rmap during mremap in the anobjrmap-5
patch), and it had several other implementation issues. But all my
further work will be against the below objrmap-core.  The below patch
just fixes the most serious bottlenecks. So I recommend it for
inclusion, the rest of the work for anonymous memory and non linear
vmas, is orthogonal with this.

Credit for this patch goes enterely to Dave McCracken (the original idea
of using the i_mmap lists for the vm instead of only using it for
truncate is as usual from David Miller), I only fixed two bugs in its
version before submitting it to you.

I speculate that because of rmap some people has been forced to use 4:4
generating >30% slowdowns to critical common server linux workloads even
to boxes with as little as 8G of ram.

I'm very convinced that it would be an huge mistake to force the
userbase with <=16G of ram to the 4:4 slowdown, but to avoid that we've
to drop rmap.

As part of my current anon_vma_chain vm work I'm also shrinking the
page_t to 40 bytes, and eventually it will be 32 bytes with further
patches, that combined with the usage of remap_file_pages (avoiding tons
of vmas) and the bio work not requiring flood of bh anymore (more
powerful than the 2.4 varyio), should reduce even further the needs of
normal-zone during high end workloads, allowing at least 16G boxes to
run perfectly fine with 3:1 design, like today with 2.4 we already run
huge shm workloads on 16G boxes with plenty of zone-normal margin in
production, even 32G seems to work fine (though the margin is not huge
there). With 2.6 I expect to raise the margin significantly (for
safety) in 32G boxes too with the most efficient 3:1 kernel split. Only
64G boxes will require either 2.5:1.5 or 4:4, and I think it's ok to
either use 4:4 or 2.5:1.5 there since they're less than 1% of the
userbase and with AMD64 hitting the market already I doubt the x86 64G
userbase will increase anytime.

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/fs/exec.c sles-objrmap/fs/exec.c
--- sles-ref/fs/exec.c	2004-02-29 17:47:21.000000000 +0100
+++ sles-objrmap/fs/exec.c	2004-03-03 06:45:38.716636864 +0100
@@ -323,6 +323,7 @@ void put_dirty_page(struct task_struct *
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
+	SetPageAnon(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/include/linux/mm.h sles-objrmap/include/linux/mm.h
--- sles-ref/include/linux/mm.h	2004-02-29 17:47:30.000000000 +0100
+++ sles-objrmap/include/linux/mm.h	2004-03-03 06:45:38.000000000 +0100
@@ -180,6 +180,7 @@ struct page {
 		struct pte_chain *chain;/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
+		int mapcount;
 	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/include/linux/page-flags.h sles-objrmap/include/linux/page-flags.h
--- sles-ref/include/linux/page-flags.h	2004-01-15 18:36:24.000000000 +0100
+++ sles-objrmap/include/linux/page-flags.h	2004-03-03 06:45:38.808622880 +0100
@@ -75,6 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_anon			20	/* Anonymous page */
 
 
 /*
@@ -270,6 +271,10 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
+#define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
+#define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/include/linux/swap.h sles-objrmap/include/linux/swap.h
--- sles-ref/include/linux/swap.h	2004-02-04 16:07:05.000000000 +0100
+++ sles-objrmap/include/linux/swap.h	2004-03-03 06:45:38.830619536 +0100
@@ -185,6 +185,8 @@ struct pte_chain *FASTCALL(page_add_rmap
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 int FASTCALL(try_to_unmap(struct page *));
 
+int page_convert_anon(struct page *);
+
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #else
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/filemap.c sles-objrmap/mm/filemap.c
--- sles-ref/mm/filemap.c	2004-02-29 17:47:33.000000000 +0100
+++ sles-objrmap/mm/filemap.c	2004-03-03 06:45:38.915606616 +0100
@@ -73,6 +73,9 @@
  *  ->mmap_sem
  *    ->i_sem			(msync)
  *
+ *  ->lock_page
+ *    ->i_shared_sem		(page_convert_anon)
+ *
  *  ->inode_lock
  *    ->sb_lock			(fs/fs-writeback.c)
  *    ->mapping->page_lock	(__sync_single_inode)
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/fremap.c sles-objrmap/mm/fremap.c
--- sles-ref/mm/fremap.c	2004-02-29 17:47:26.000000000 +0100
+++ sles-objrmap/mm/fremap.c	2004-03-03 06:45:38.936603424 +0100
@@ -61,10 +61,26 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 	struct pte_chain *pte_chain;
+	unsigned long pgidx;
 
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
 		goto err;
+
+	/*
+	 * Convert this page to anon for objrmap if it's nonlinear
+	 */
+	pgidx = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgidx += vma->vm_pgoff;
+	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+	if (!PageAnon(page) && (page->index != pgidx)) {
+		lock_page(page);
+		err = page_convert_anon(page);
+		unlock_page(page);
+		if (err < 0)
+			goto err_free;
+	}
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
@@ -85,12 +101,11 @@ int install_page(struct mm_struct *mm, s
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return 0;
 
+	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
+err_free:
 	pte_chain_free(pte_chain);
 err:
 	return err;
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/memory.c sles-objrmap/mm/memory.c
--- sles-ref/mm/memory.c	2004-02-29 17:47:33.000000000 +0100
+++ sles-objrmap/mm/memory.c	2004-03-03 06:45:38.965599016 +0100
@@ -1071,6 +1071,7 @@ static int do_wp_page(struct mm_struct *
 			++mm->rss;
 		page_remove_rmap(old_page, page_table);
 		break_cow(vma, new_page, address, page_table);
+		SetPageAnon(new_page);
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		lru_cache_add_active(new_page);
 
@@ -1310,6 +1311,7 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
+	SetPageAnon(page);
 	pte_chain = page_add_rmap(page, page_table, pte_chain);
 
 	/* No need to invalidate - it was non-present before */
@@ -1377,6 +1379,7 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
+		SetPageAnon(page);
 	}
 
 	set_pte(page_table, entry);
@@ -1444,6 +1447,10 @@ retry:
 	if (!pte_chain)
 		goto oom;
 
+	/* See if nopage returned an anon page */
+	if (!new_page->mapping || PageSwapCache(new_page))
+		SetPageAnon(new_page);
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1454,6 +1461,7 @@ retry:
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		lru_cache_add_active(page);
+		SetPageAnon(page);
 		new_page = page;
 	}
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/mmap.c sles-objrmap/mm/mmap.c
--- sles-ref/mm/mmap.c	2004-02-29 17:47:30.000000000 +0100
+++ sles-objrmap/mm/mmap.c	2004-03-03 06:53:46.000000000 +0100
@@ -267,9 +267,7 @@ static void vma_link(struct mm_struct *m
 
 	if (mapping)
 		down(&mapping->i_shared_sem);
-	spin_lock(&mm->page_table_lock);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
-	spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		up(&mapping->i_shared_sem);
 
@@ -318,6 +316,22 @@ static inline int is_mergeable_vma(struc
 	return 1;
 }
 
+/* requires that the relevant i_shared_sem be held by the caller */
+static void move_vma_start(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct inode *inode = NULL;
+	
+	if (vma->vm_file)
+		inode = vma->vm_file->f_dentry->d_inode;
+	if (inode)
+		__remove_shared_vm_struct(vma, inode);
+	/* If no vm_file, perhaps we should always keep vm_pgoff at 0?? */
+	vma->vm_pgoff += (long)(addr - vma->vm_start) >> PAGE_SHIFT;
+	vma->vm_start = addr;
+	if (inode)
+		__vma_link_file(vma);
+}
+
 /*
  * Return true if we can merge this (vm_flags,file,vm_pgoff,size)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -370,7 +384,6 @@ static int vma_merge(struct mm_struct *m
 			unsigned long end, unsigned long vm_flags,
 			struct file *file, unsigned long pgoff)
 {
-	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
 	struct semaphore *i_shared_sem;
 
@@ -402,7 +415,6 @@ static int vma_merge(struct mm_struct *m
 			down(i_shared_sem);
 			need_up = 1;
 		}
-		spin_lock(lock);
 		prev->vm_end = end;
 
 		/*
@@ -415,7 +427,6 @@ static int vma_merge(struct mm_struct *m
 			prev->vm_end = next->vm_end;
 			__vma_unlink(mm, next, prev);
 			__remove_shared_vm_struct(next, inode);
-			spin_unlock(lock);
 			if (need_up)
 				up(i_shared_sem);
 			if (file)
@@ -425,7 +436,6 @@ static int vma_merge(struct mm_struct *m
 			kmem_cache_free(vm_area_cachep, next);
 			return 1;
 		}
-		spin_unlock(lock);
 		if (need_up)
 			up(i_shared_sem);
 		return 1;
@@ -443,10 +453,7 @@ static int vma_merge(struct mm_struct *m
 		if (end == prev->vm_start) {
 			if (file)
 				down(i_shared_sem);
-			spin_lock(lock);
-			prev->vm_start = addr;
-			prev->vm_pgoff -= (end - addr) >> PAGE_SHIFT;
-			spin_unlock(lock);
+			move_vma_start(prev, addr);
 			if (file)
 				up(i_shared_sem);
 			return 1;
@@ -905,19 +912,16 @@ int expand_stack(struct vm_area_struct *
 	 */
 	address += 4 + PAGE_SIZE - 1;
 	address &= PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
 	
 	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -925,7 +929,6 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
 }
 
@@ -959,19 +962,16 @@ int expand_stack(struct vm_area_struct *
 	 * the spinlock only before relocating the vma range ourself.
 	 */
 	address &= PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
 	
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -980,7 +980,6 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
 }
 
@@ -1147,8 +1146,6 @@ static void unmap_region(struct mm_struc
 /*
  * Create a list of vma's touched by the unmap, removing them from the mm's
  * vma list as we go..
- *
- * Called with the page_table_lock held.
  */
 static void
 detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -1211,10 +1208,9 @@ int split_vma(struct mm_struct * mm, str
 		down(&mapping->i_shared_sem);
 	spin_lock(&mm->page_table_lock);
 
-	if (new_below) {
-		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
-	} else
+	if (new_below)
+		move_vma_start(vma, addr);
+	else
 		vma->vm_end = addr;
 
 	__insert_vm_struct(mm, new);
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/page_alloc.c sles-objrmap/mm/page_alloc.c
--- sles-ref/mm/page_alloc.c	2004-02-29 17:47:36.000000000 +0100
+++ sles-objrmap/mm/page_alloc.c	2004-03-03 06:45:38.992594912 +0100
@@ -230,6 +230,8 @@ static inline void free_pages_check(cons
 		bad_page(function, page);
 	if (PageDirty(page))
 		ClearPageDirty(page);
+	if (PageAnon(page))
+		ClearPageAnon(page);
 }
 
 /*
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/rmap.c sles-objrmap/mm/rmap.c
--- sles-ref/mm/rmap.c	2004-02-29 17:47:33.000000000 +0100
+++ sles-objrmap/mm/rmap.c	2004-03-03 07:01:39.200621104 +0100
@@ -102,6 +102,136 @@ pte_chain_encode(struct pte_chain *pte_c
  **/
 
 /**
+ * find_pte - Find a pte pointer given a vma and a struct page.
+ * @vma: the vma to search
+ * @page: the page to find
+ *
+ * Determine if this page is mapped in this vma.  If it is, map and rethrn
+ * the pte pointer associated with it.  Return null if the page is not
+ * mapped in this vma for any reason.
+ *
+ * This is strictly an internal helper function for the object-based rmap
+ * functions.
+ * 
+ * It is the caller's responsibility to unmap the pte if it is returned.
+ */
+static inline pte_t *
+find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long loffset;
+	unsigned long address;
+
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
+	if (address < vma->vm_start || address >= vma->vm_end)
+		goto out;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out;
+
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		goto out_unmap;
+
+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unmap;
+
+	if (addr)
+		*addr = address;
+
+	return pte;
+
+out_unmap:
+	pte_unmap(pte);
+out:
+	return NULL;
+}
+
+/**
+ * page_referenced_obj_one - referenced check for object-based rmap
+ * @vma: the vma to look in.
+ * @page: the page we're working on.
+ *
+ * Find a pte entry for a page/vma pair, then check and clear the referenced
+ * bit.
+ *
+ * This is strictly a helper function for page_referenced_obj.
+ */
+static int
+page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *pte;
+	int referenced = 0;
+
+	if (!spin_trylock(&mm->page_table_lock))
+		return 1;
+
+	pte = find_pte(vma, page, NULL);
+	if (pte) {
+		if (ptep_test_and_clear_young(pte))
+			referenced++;
+		pte_unmap(pte);
+	}
+
+	spin_unlock(&mm->page_table_lock);
+	return referenced;
+}
+
+/**
+ * page_referenced_obj_one - referenced check for object-based rmap
+ * @page: the page we're checking references on.
+ *
+ * For an object-based mapped page, find all the places it is mapped and
+ * check/clear the referenced flag.  This is done by following the page->mapping
+ * pointer, then walking the chain of vmas it holds.  It returns the number
+ * of references it found.
+ *
+ * This function is only called from page_referenced for object-based pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
+ * assume a reference count of 1.
+ */
+static int
+page_referenced_obj(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct vm_area_struct *vma;
+	int referenced = 0;
+
+	if (!page->pte.mapcount)
+		return 0;
+
+	if (!mapping)
+		BUG();
+
+	if (PageSwapCache(page))
+		BUG();
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return 1;
+	
+	list_for_each_entry(vma, &mapping->i_mmap, shared)
+		referenced += page_referenced_obj_one(vma, page);
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
+		referenced += page_referenced_obj_one(vma, page);
+
+	up(&mapping->i_shared_sem);
+
+	return referenced;
+}
+
+/**
  * page_referenced - test if the page was referenced
  * @page: the page to test
  *
@@ -123,6 +253,10 @@ int fastcall page_referenced(struct page
 	if (TestClearPageReferenced(page))
 		referenced++;
 
+	if (!PageAnon(page)) {
+		referenced += page_referenced_obj(page);
+		goto out;
+	}
 	if (PageDirect(page)) {
 		pte_t *pte = rmap_ptep_map(page->pte.direct);
 		if (ptep_test_and_clear_young(pte))
@@ -154,6 +288,7 @@ int fastcall page_referenced(struct page
 			__pte_chain_free(pc);
 		}
 	}
+out:
 	return referenced;
 }
 
@@ -176,6 +311,21 @@ page_add_rmap(struct page *page, pte_t *
 
 	pte_chain_lock(page);
 
+	/*
+	 * If this is an object-based page, just count it.  We can
+ 	 * find the mappings by walking the object vma chain for that object.
+	 */
+	if (!PageAnon(page)) {
+		if (!page->mapping)
+			BUG();
+		if (PageSwapCache(page))
+			BUG();
+		if (!page->pte.mapcount)
+			inc_page_state(nr_mapped);
+		page->pte.mapcount++;
+		goto out;
+	}
+
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
@@ -232,8 +382,25 @@ void fastcall page_remove_rmap(struct pa
 	pte_chain_lock(page);
 
 	if (!page_mapped(page))
-		goto out_unlock;	/* remap_page_range() from a driver? */
+		goto out_unlock;
 
+	/*
+	 * If this is an object-based page, just uncount it.  We can
+	 * find the mappings by walking the object vma chain for that object.
+	 */
+	if (!PageAnon(page)) {
+		if (!page->mapping)
+			BUG();
+		if (PageSwapCache(page))
+			BUG();
+		if (!page->pte.mapcount)
+			BUG();
+		page->pte.mapcount--;
+		if (!page->pte.mapcount)
+			dec_page_state(nr_mapped);
+		goto out_unlock;
+	}
+  
 	if (PageDirect(page)) {
 		if (page->pte.direct == pte_paddr) {
 			page->pte.direct = 0;
@@ -280,6 +447,102 @@ out_unlock:
 }
 
 /**
+ * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Determine whether a page is mapped in a given vma and unmap it if it's found.
+ *
+ * This function is strictly a helper function for try_to_unmap_obj.
+ */
+static inline int
+try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t *pte;
+	pte_t pteval;
+	int ret = SWAP_AGAIN;
+
+	if (!spin_trylock(&mm->page_table_lock))
+		return ret;
+
+	pte = find_pte(vma, page, &address);
+	if (!pte)
+		goto out;
+
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
+		ret =  SWAP_FAIL;
+		goto out_unmap;
+	}
+
+	flush_cache_page(vma, address);
+	pteval = ptep_get_and_clear(pte);
+	flush_tlb_page(vma, address);
+
+	if (pte_dirty(pteval))
+		set_page_dirty(page);
+
+	if (!page->pte.mapcount)
+		BUG();
+
+	mm->rss--;
+	page->pte.mapcount--;
+	page_cache_release(page);
+
+out_unmap:
+	pte_unmap(pte);
+
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
+/**
+ * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Find all the mappings of a page using the mapping pointer and the vma chains
+ * contained in the address_space struct it points to.
+ *
+ * This function is only called from try_to_unmap for object-based pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
+ * return a temporary error.
+ */
+static int
+try_to_unmap_obj(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct vm_area_struct *vma;
+	int ret = SWAP_AGAIN;
+
+	if (!mapping)
+		BUG();
+
+	if (PageSwapCache(page))
+		BUG();
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return ret;
+	
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		ret = try_to_unmap_obj_one(vma, page);
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
+			goto out;
+	}
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		ret = try_to_unmap_obj_one(vma, page);
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
+			goto out;
+	}
+
+out:
+	up(&mapping->i_shared_sem);
+	return ret;
+}
+
+/**
  * try_to_unmap_one - worker function for try_to_unmap
  * @page: page to unmap
  * @ptep: page table entry to unmap from page
@@ -397,6 +660,15 @@ int fastcall try_to_unmap(struct page * 
 	if (!page->mapping)
 		BUG();
 
+	/*
+	 * If it's an object-based page, use the object vma chain to find all
+	 * the mappings.
+	 */
+	if (!PageAnon(page)) {
+		ret = try_to_unmap_obj(page);
+		goto out;
+	}
+
 	if (PageDirect(page)) {
 		ret = try_to_unmap_one(page, page->pte.direct);
 		if (ret == SWAP_SUCCESS) {
@@ -453,12 +725,115 @@ int fastcall try_to_unmap(struct page * 
 		}
 	}
 out:
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
+		ret = SWAP_SUCCESS;
+	}
 	return ret;
 }
 
 /**
+ * page_convert_anon - Convert an object-based mapped page to pte_chain-based.
+ * @page: the page to convert
+ *
+ * Find all the mappings for an object-based page and convert them
+ * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
+ *
+ * This function takes the address_space->i_shared_sem, sets the PageAnon flag,
+ * then sets the mm->page_table_lock for each vma and calls page_add_rmap. This
+ * means there is a period when PageAnon is set, but still has some mappings
+ * with no pte_chain entry.  This is in fact safe, since page_remove_rmap will
+ * simply not find it.  try_to_unmap might erroneously return success, but it
+ * will never be called because the page_convert_anon() caller has locked the
+ * page.
+ *
+ * page_referenced() may fail to scan all the appropriate pte's and may return
+ * an inaccurate result.  This is so rare that it does not matter.
+ */
+int page_convert_anon(struct page *page)
+{
+	struct address_space *mapping;
+	struct vm_area_struct *vma;
+	struct pte_chain *pte_chain = NULL;
+	pte_t *pte;
+	int err = 0;
+
+	mapping = page->mapping;
+	if (mapping == NULL)
+		goto out;		/* truncate won the lock_page() race */
+
+	down(&mapping->i_shared_sem);
+	pte_chain_lock(page);
+
+	/*
+	 * Has someone else done it for us before we got the lock?
+	 * If so, pte.direct or pte.chain has replaced pte.mapcount.
+	 */
+	if (PageAnon(page)) {
+		pte_chain_unlock(page);
+		goto out_unlock;
+	}
+
+	SetPageAnon(page);
+	if (page->pte.mapcount == 0) {
+		pte_chain_unlock(page);
+		goto out_unlock;
+	}
+	/* This is gonna get incremented by page_add_rmap */
+	dec_page_state(nr_mapped);
+	page->pte.mapcount = 0;
+
+	/*
+	 * Now that the page is marked as anon, unlock it.  page_add_rmap will
+	 * lock it as necessary.
+	 */
+	pte_chain_unlock(page);
+
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (!pte_chain) {
+			pte_chain = pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pte = find_pte(vma, page, NULL);
+		if (pte) {
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
+		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (!pte_chain) {
+			pte_chain = pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pte = find_pte(vma, page, NULL);
+		if (pte) {
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
+		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+
+out_unlock:
+	pte_chain_free(pte_chain);
+	up(&mapping->i_shared_sem);
+out:
+	return err;
+}
+
+/**
  ** No more VM stuff below this comment, only pte_chain helper
  ** functions.
  **/
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids sles-ref/mm/swapfile.c sles-objrmap/mm/swapfile.c
--- sles-ref/mm/swapfile.c	2004-02-20 17:26:54.000000000 +0100
+++ sles-objrmap/mm/swapfile.c	2004-03-03 07:03:33.128301464 +0100
@@ -390,6 +390,7 @@ unuse_pte(struct vm_area_struct *vma, un
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	SetPageAnon(page);
 	*pte_chainp = page_add_rmap(page, dir, *pte_chainp);
 	swap_free(entry);
 }
