Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFZFPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 01:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265414AbTFZFPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 01:15:31 -0400
Received: from holomorphy.com ([66.224.33.161]:55942 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264450AbTFZFPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 01:15:05 -0400
Date: Wed, 25 Jun 2003 22:29:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-wli-1
Message-ID: <20030626052911.GS26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030625010513.GX20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625010513.GX20413@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 06:05:13PM -0700, William Lee Irwin III wrote:
> + RCU anon->lock
[...]
> 	first (actually mostly unrelated to RCU except for one). It
> 	should be fine in and of itself now, of course.

And the obligatory brown paper bag patch(es):


diff -prauN wli-2.5.73-29/arch/i386/mm/fault.c wli-2.5.73-30/arch/i386/mm/fault.c
--- wli-2.5.73-29/arch/i386/mm/fault.c	2003-06-23 10:31:02.000000000 -0700
+++ wli-2.5.73-30/arch/i386/mm/fault.c	2003-06-25 02:08:10.000000000 -0700
@@ -247,6 +247,7 @@ no_context:
 	printk(" printing eip:\n");
 	printk("%08lx\n", regs->eip);
 	asm("movl %%cr3,%0":"=r" (page));
+#ifndef CONFIG_HIGHPMD /* Oh boy. Error reporting is going to blow major goats. */
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
@@ -262,7 +263,14 @@ no_context:
 		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
-#endif
+#endif /* !CONFIG_HIGHPTE */
+#else	/* CONFIG_HIGHPMD */
+	printk(KERN_ALERT "%%cr3 = 0x%lx\n", page);
+	/* Mask off flag bits. It should end up 32B-aligned. */
+	page &= ~(PTRS_PER_PGD*sizeof(pgd_t) - 1);
+	printk(KERN_ALERT "*pdpte = 0x%Lx\n",
+			pgd_val(((pgd_t *)__va(page))[address >> PGDIR_SHIFT]));
+#endif /* CONFIG_HIGHPMD */
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
diff -prauN wli-2.5.73-29/include/linux/rmap.h wli-2.5.73-30/include/linux/rmap.h
--- wli-2.5.73-29/include/linux/rmap.h	2003-06-23 10:58:03.000000000 -0700
+++ wli-2.5.73-30/include/linux/rmap.h	2003-06-24 21:07:36.000000000 -0700
@@ -12,11 +12,13 @@
 #include <linux/gfp.h>
 #include <linux/cache.h>
 #include <linux/pagemap.h>
+#include <linux/rcupdate.h>
 
 struct anon {
 	atomic_t count;
 	spinlock_t lock;
 	struct list_head list;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_MMU
diff -prauN wli-2.5.73-29/mm/fremap.c wli-2.5.73-30/mm/fremap.c
--- wli-2.5.73-29/mm/fremap.c	2003-06-23 14:55:26.000000000 -0700
+++ wli-2.5.73-30/mm/fremap.c	2003-06-24 22:20:03.000000000 -0700
@@ -17,6 +17,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+/*
+ * This is never done to an anonymous page so page->mapping is never altered.
+ */
 static inline int zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, pte_t *ptep)
 {
diff -prauN wli-2.5.73-29/mm/memory.c wli-2.5.73-30/mm/memory.c
--- wli-2.5.73-29/mm/memory.c	2003-06-23 14:58:02.000000000 -0700
+++ wli-2.5.73-30/mm/memory.c	2003-06-25 01:59:06.000000000 -0700
@@ -1005,8 +1005,13 @@ static int do_wp_page(struct mm_struct *
 
 	if (!TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
-		if (reuse) {
+		/*
+		 * page_turn_rmap() could alter ->__mapping, so we can only
+		 * unlock_page(old_page) afterward.
+		 */
+		if (!reuse)
+			unlock_page(old_page);
+		else {
 			flush_cache_page(vma, address);
 			establish_pte(vma, address, page_table,
 				pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
@@ -1015,6 +1020,7 @@ static int do_wp_page(struct mm_struct *
 			pte_unmap(page_table);
 			pmd_unmap(pmd);
 			ret = VM_FAULT_MINOR;
+			unlock_page(old_page);
 			goto out;
 		}
 	}
@@ -1042,8 +1048,11 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
+			/* should be file-backed, ->__mapping not modified */
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
+
+		/* we have a unique reference, so PG_locked need not be held */
 		page_add_rmap(new_page, vma, address, 1);
 		lru_cache_add_active(new_page);
 
@@ -1073,6 +1082,8 @@ static void vmtruncate_list(struct list_
 	struct list_head *curr;
 
 	list_for_each_rcu(curr, head) {
+		struct mmu_gather *tlb;
+
 		vma = list_entry(curr, struct vm_area_struct, shared);
 
 		if (vma->vm_flags & VM_DEAD)
@@ -1083,10 +1094,8 @@ static void vmtruncate_list(struct list_
 		len = end - start;
 
 		/* mapping wholly truncated? */
-		if (vma->vm_pgoff >= pgoff) {
-			zap_page_range(vma, start, len);
-			continue;
-		}
+		if (vma->vm_pgoff >= pgoff)
+			goto nuke_it_all;
 
 		/* mapping wholly unaffected? */
 		len = len >> PAGE_SHIFT;
@@ -1097,7 +1106,13 @@ static void vmtruncate_list(struct list_
 		/* Ok, partially affected.. */
 		start += diff << PAGE_SHIFT;
 		len = (len - diff) << PAGE_SHIFT;
-		zap_page_range(vma, start, len);
+		end = start + len;
+nuke_it_all:
+		spin_lock(&vma->vm_mm->page_table_lock);
+		tlb = tlb_gather_mmu(vma->vm_mm, 0);
+		unmap_page_range(tlb, vma, start, end);
+		tlb_finish_mmu(tlb, start, end);
+		spin_unlock(&vma->vm_mm->page_table_lock);
 	}
 }
 
@@ -1250,11 +1265,11 @@ static int do_swap_page(struct mm_struct
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page))
 		pte = pte_mkdirty(pte_mkwrite(pte));
-	unlock_page(page);
 
 	flush_icache_page(vma, page);
 	vm_set_pte(vma, page_table, pte, address);
 	page_add_rmap(page, vma, address, 1);
+	unlock_page(page);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
@@ -1312,13 +1327,14 @@ do_anonymous_page(struct mm_struct *mm, 
 		}
 		mm->rss++;
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-		lru_cache_add_active(page);
-		mark_page_accessed(page);
 	}
 
 	vm_set_pte(vma, page_table, entry, addr);
-	if (write_access)
+	if (write_access) {
 		page_add_rmap(page, vma, addr, 1);
+		lru_cache_add_active(page);
+		mark_page_accessed(page);
+	}
 	pmd_unmap(pmd);
 	pte_unmap(page_table);
 
@@ -1375,9 +1391,9 @@ do_no_page(struct mm_struct *mm, struct 
 		struct page * page = alloc_page(GFP_HIGHUSER);
 		if (!page)
 			goto oom;
+		/* start with refcount 1 */
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
-		lru_cache_add_active(page);
 		anon = 1;
 		new_page = page;
 	}
@@ -1407,14 +1423,28 @@ do_no_page(struct mm_struct *mm, struct 
 		if (write_access)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 		vm_set_pte(vma, page_table, entry, address);
+
+		/*
+		 * PG_locked not held for the anon case, but we have a
+		 * unique reference. ->__mapping is untouched when file-backed
+		 */
 		if (!PageReserved(new_page))
 			page_add_rmap(new_page, vma, address, anon);
+
+		/* kswapd can find us now, but we're already prepped */
+		if (anon)
+			lru_cache_add_active(new_page);
 		pte_unmap(page_table);
 		pmd_unmap(pmd);
 	} else {
 		/* One of our sibling threads was faster, back out. */
 		pte_unmap(page_table);
 		pmd_unmap(pmd);
+		/*
+		 * In the anon case, we never hit the LRU, so we free instantly,
+		 * where in mainline the LRU retains a reference. In the file-
+		 * backed case, we merely release a reference acquired earlier.
+		 */
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
 		ret = VM_FAULT_MINOR;
diff -prauN wli-2.5.73-29/mm/rmap.c wli-2.5.73-30/mm/rmap.c
--- wli-2.5.73-29/mm/rmap.c	2003-06-23 23:32:52.000000000 -0700
+++ wli-2.5.73-30/mm/rmap.c	2003-06-25 01:32:57.000000000 -0700
@@ -56,6 +56,7 @@ static void anon_ctor(void *arg, kmem_ca
 	atomic_set(&anon->count, 2);
 	anon->lock = SPIN_LOCK_UNLOCKED;
 	INIT_LIST_HEAD(&anon->list);
+	INIT_RCU_HEAD(&anon->rcu);
 }
 
 static void rmap_chain_ctor(void *arg, kmem_cache_t *cache, unsigned long flags)
@@ -92,8 +93,8 @@ int exec_rmap(struct mm_struct *mm)
 	if (!anon)
 		return -ENOMEM;
 
-	spin_lock(&anon->lock);
 	mm->anon = anon;
+	spin_lock(&anon->lock);
 	list_add_rcu(&mm->anon_list, &anon->list);
 	spin_unlock(&anon->lock);
 	return 0;
@@ -109,23 +110,27 @@ void dup_rmap(struct mm_struct *new, str
 	spin_unlock(&anon->lock);
 }
 
+static void free_anon(void *__anon)
+{
+	struct anon *anon = (struct anon *)__anon;
+	INIT_LIST_HEAD(&anon->list);
+	atomic_set(&anon->count, 2);
+	kmem_cache_free(anon_cache, anon);
+}
+
 void exit_rmap(struct mm_struct *mm)
 {
 	struct anon *anon = mm->anon;
 
-	spin_lock(&anon->lock);
 	mm->anon = NULL;
-	wmb();
+	spin_lock(&anon->lock);
 	list_del_rcu(&mm->anon_list);
 	spin_unlock(&anon->lock);
 
 	if (!atomic_dec_and_test(&anon->count))
 		return;
 
-	/* RCU may not have quiesced things just yet */
-	INIT_LIST_HEAD(&anon->list);
-	atomic_set(&anon->count, 2);
-	kmem_cache_free(anon_cache, anon);
+	call_rcu(&anon->rcu, free_anon, anon);
 }
 
 /**
@@ -342,6 +347,10 @@ static inline int page_referenced_obj(st
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
+	/* bail if it's a Morton page */
+	if (!mapping)
+		return 0;
+
 	rcu_read_lock();	/* mapping->i_shared_lock */
 	list_for_each_entry_rcu(vma, &mapping->i_mmap, shared) {
 		if (vma->vm_flags & VM_DEAD)
@@ -569,6 +578,10 @@ static inline int try_to_unmap_obj(struc
 
 	mapping = page_mapping(page);
 
+	/* bail if it's a Morton page */
+	if (!mapping)
+		return SWAP_FAIL;
+
 	rcu_read_lock();		/* mapping->i_shared_lock */
 
 	list_for_each_entry_rcu(vma, &mapping->i_mmap, shared) {
