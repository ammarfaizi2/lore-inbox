Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTF1Plf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 11:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTF1Plc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 11:41:32 -0400
Received: from holomorphy.com ([66.224.33.161]:35736 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265270AbTF1Pks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 11:40:48 -0400
Date: Sat, 28 Jun 2003 08:54:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030628155436.GY20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627202130.066c183b.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 08:21:30PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm2/
> Just bits and pieces.

Here's highpmd. This allocates L2 pagetables from highmem, decreasing
the per-process lowmem overhead on CONFIG_HIGHMEM64G from 20KB to 8KB.
Some attempts were made to update non-i386 architectures to the new
API's, though they're entirely untested. It's been tested for a while
in -wli on i386 machines, both lowmem and highmem boxen.

-- wli

diff -prauN mm2-2.5.73-1/arch/i386/Kconfig mm2-2.5.73-2/arch/i386/Kconfig
--- mm2-2.5.73-1/arch/i386/Kconfig	2003-06-28 03:09:46.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/Kconfig	2003-06-28 03:11:37.000000000 -0700
@@ -765,6 +765,15 @@ config HIGHPTE
 	  low memory.  Setting this option will put user-space page table
 	  entries in high memory.
 
+config HIGHPMD
+	bool "Allocate 2nd-level pagetables from highmem"
+	depends on HIGHMEM64G
+	help
+	  The VM uses one pmd entry for each pagetable page of physical
+	  memory allocated. For systems with extreme amounts of highmem,
+	  this cannot be tolerated. Setting this option will put
+	  userspace 2nd-level pagetables in highmem.
+
 config MATH_EMULATION
 	bool "Math emulation"
 	---help---
diff -prauN mm2-2.5.73-1/arch/i386/kernel/vm86.c mm2-2.5.73-2/arch/i386/kernel/vm86.c
--- mm2-2.5.73-1/arch/i386/kernel/vm86.c	2003-06-22 11:32:33.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/kernel/vm86.c	2003-06-28 03:11:37.000000000 -0700
@@ -144,12 +144,14 @@ static void mark_screen_rdonly(struct ta
 		pgd_clear(pgd);
 		goto out;
 	}
-	pmd = pmd_offset(pgd, 0xA0000);
-	if (pmd_none(*pmd))
+	pmd = pmd_offset_map(pgd, 0xA0000);
+	if (pmd_none(*pmd)) {
+		pmd_unmap(pmd);
 		goto out;
-	if (pmd_bad(*pmd)) {
+	} else if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
+		pmd_unmap(pmd);
 		goto out;
 	}
 	pte = mapped = pte_offset_map(pmd, 0xA0000);
@@ -159,6 +161,7 @@ static void mark_screen_rdonly(struct ta
 		pte++;
 	}
 	pte_unmap(mapped);
+	pmd_unmap(pmd);
 out:
 	spin_unlock(&tsk->mm->page_table_lock);
 	preempt_enable();
diff -prauN mm2-2.5.73-1/arch/i386/mm/fault.c mm2-2.5.73-2/arch/i386/mm/fault.c
--- mm2-2.5.73-1/arch/i386/mm/fault.c	2003-06-28 03:09:46.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/fault.c	2003-06-28 03:28:31.000000000 -0700
@@ -253,6 +253,7 @@ no_context:
 	printk(" printing eip:\n");
 	printk("%08lx\n", regs->eip);
 	asm("movl %%cr3,%0":"=r" (page));
+#ifndef CONFIG_HIGHPMD /* Oh boy. Error reporting is going to blow major goats. */
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
@@ -268,7 +269,14 @@ no_context:
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
@@ -336,8 +344,8 @@ vmalloc_fault:
 		 * and redundant with the set_pmd() on non-PAE.
 		 */
 
-		pmd = pmd_offset(pgd, address);
-		pmd_k = pmd_offset(pgd_k, address);
+		pmd = pmd_offset_kernel(pgd, address);
+		pmd_k = pmd_offset_kernel(pgd_k, address);
 		if (!pmd_present(*pmd_k))
 			goto no_context;
 		set_pmd(pmd, *pmd_k);
diff -prauN mm2-2.5.73-1/arch/i386/mm/hugetlbpage.c mm2-2.5.73-2/arch/i386/mm/hugetlbpage.c
--- mm2-2.5.73-1/arch/i386/mm/hugetlbpage.c	2003-06-22 11:33:17.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/hugetlbpage.c	2003-06-28 03:11:37.000000000 -0700
@@ -87,8 +87,8 @@ static pte_t *huge_pte_alloc(struct mm_s
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	pmd = pmd_alloc(mm, pgd, addr);
-	return (pte_t *) pmd;
+	pmd = pmd_alloc_map(mm, pgd, addr);
+	return (pte_t *)pmd;
 }
 
 static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
@@ -97,8 +97,8 @@ static pte_t *huge_pte_offset(struct mm_
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	pmd = pmd_offset(pgd, addr);
-	return (pte_t *) pmd;
+	pmd = pmd_offset_map(pgd, addr);
+	return (pte_t *)pmd;
 }
 
 static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
@@ -145,6 +145,8 @@ int copy_hugetlb_page_range(struct mm_st
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
+		pmd_unmap(dst_pte);
+		pmd_unmap_nested(src_pte);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
 	}
@@ -182,6 +184,7 @@ follow_hugetlb_page(struct mm_struct *mm
 
 			get_page(page);
 			pages[i] = page;
+			pmd_unmap(pte);
 		}
 
 		if (vmas)
@@ -271,6 +274,7 @@ follow_huge_pmd(struct mm_struct *mm, un
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
 		get_page(page);
 	}
+	pmd_unmap(pmd);
 	return page;
 }
 #endif
@@ -314,6 +318,7 @@ void unmap_hugepage_range(struct vm_area
 		page = pte_page(*pte);
 		huge_page_release(page);
 		pte_clear(pte);
+		pmd_unmap(pte);
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
@@ -358,16 +363,19 @@ int hugetlb_prefault(struct address_spac
 			page = alloc_hugetlb_page();
 			if (!page) {
 				ret = -ENOMEM;
+				pmd_unmap(pte);
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
 				free_huge_page(page);
+				pmd_unmap(pte);
 				goto out;
 			}
 		}
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		pmd_unmap(pte);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
diff -prauN mm2-2.5.73-1/arch/i386/mm/init.c mm2-2.5.73-2/arch/i386/mm/init.c
--- mm2-2.5.73-1/arch/i386/mm/init.c	2003-06-28 03:09:46.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/init.c	2003-06-28 03:22:00.000000000 -0700
@@ -59,10 +59,10 @@ static pmd_t * __init one_md_table_init(
 #ifdef CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
-	if (pmd_table != pmd_offset(pgd, 0)) 
+	if (pmd_table != pmd_offset_kernel(pgd, 0)) 
 		BUG();
 #else
-	pmd_table = pmd_offset(pgd, 0);
+	pmd_table = pmd_offset_kernel(pgd, 0);
 #endif
 
 	return pmd_table;
@@ -113,7 +113,7 @@ static void __init page_table_range_init
 		if (pgd_none(*pgd)) 
 			one_md_table_init(pgd);
 
-		pmd = pmd_offset(pgd, vaddr);
+		pmd = pmd_offset_kernel(pgd, vaddr);
 		for (; (pmd_idx < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_idx++) {
 			if (pmd_none(*pmd)) 
 				one_page_table_init(pmd);
@@ -194,7 +194,7 @@ pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset_kernel(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -218,7 +218,7 @@ void __init permanent_kmaps_init(pgd_t *
 	page_table_range_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
 
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
+	pmd = pmd_offset_kernel(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;	
 }
@@ -513,20 +513,9 @@ void __init mem_init(void)
 }
 
 kmem_cache_t *pgd_cache;
-kmem_cache_t *pmd_cache;
 
 void __init pgtable_cache_init(void)
 {
-	if (PTRS_PER_PMD > 1) {
-		pmd_cache = kmem_cache_create("pmd",
-					PTRS_PER_PMD*sizeof(pmd_t),
-					0,
-					SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
-					pmd_ctor,
-					NULL);
-		if (!pmd_cache)
-			panic("pgtable_cache_init(): cannot create pmd cache");
-	}
 	pgd_cache = kmem_cache_create("pgd",
 				PTRS_PER_PGD*sizeof(pgd_t),
 				0,
diff -prauN mm2-2.5.73-1/arch/i386/mm/ioremap.c mm2-2.5.73-2/arch/i386/mm/ioremap.c
--- mm2-2.5.73-1/arch/i386/mm/ioremap.c	2003-06-22 11:32:38.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/ioremap.c	2003-06-28 03:11:37.000000000 -0700
@@ -82,7 +82,7 @@ static int remap_area_pages(unsigned lon
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
+		pmd = pmd_alloc_kernel(&init_mm, dir, address);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
diff -prauN mm2-2.5.73-1/arch/i386/mm/pageattr.c mm2-2.5.73-2/arch/i386/mm/pageattr.c
--- mm2-2.5.73-1/arch/i386/mm/pageattr.c	2003-06-28 03:09:46.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/pageattr.c	2003-06-28 03:12:16.000000000 -0700
@@ -23,7 +23,7 @@ static inline pte_t *lookup_address(unsi
 	pmd_t *pmd;
 	if (pgd_none(*pgd))
 		return NULL;
-	pmd = pmd_offset(pgd, address); 	       
+	pmd = pmd_offset_kernel(pgd, address); 	       
 	if (pmd_none(*pmd))
 		return NULL;
 	if (pmd_large(*pmd))
@@ -79,7 +79,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 		pgd_t *pgd;
 		pmd_t *pmd;
 		pgd = (pgd_t *)page_address(page) + pgd_index(address);
-		pmd = pmd_offset(pgd, address);
+		pmd = pmd_offset_kernel(pgd, address);
 		set_pte_atomic((pte_t *)pmd, pte);
 	}
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -92,7 +92,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 static inline void revert_page(struct page *kpte_page, unsigned long address)
 {
 	pte_t *linear = (pte_t *) 
-		pmd_offset(pgd_offset(&init_mm, address), address);
+		pmd_offset_kernel(pgd_offset_k(address), address);
 	set_pmd_pte(linear,  address,
 		    pfn_pte((__pa(address) & LARGE_PAGE_MASK) >> PAGE_SHIFT,
 			    PAGE_KERNEL_LARGE));
diff -prauN mm2-2.5.73-1/arch/i386/mm/pgtable.c mm2-2.5.73-2/arch/i386/mm/pgtable.c
--- mm2-2.5.73-1/arch/i386/mm/pgtable.c	2003-06-28 03:09:46.000000000 -0700
+++ mm2-2.5.73-2/arch/i386/mm/pgtable.c	2003-06-28 08:20:29.000000000 -0700
@@ -70,7 +70,7 @@ static void set_pte_pfn(unsigned long va
 		BUG();
 		return;
 	}
-	pmd = pmd_offset(pgd, vaddr);
+	pmd = pmd_offset_kernel(pgd, vaddr);
 	if (pmd_none(*pmd)) {
 		BUG();
 		return;
@@ -110,7 +110,7 @@ void set_pmd_pfn(unsigned long vaddr, un
 		printk ("set_pmd_pfn: pgd_none\n");
 		return; /* BUG(); */
 	}
-	pmd = pmd_offset(pgd, vaddr);
+	pmd = pmd_offset_kernel(pgd, vaddr);
 	set_pmd(pmd, pfn_pmd(pfn, flags));
 	/*
 	 * It's enough to flush this one mapping.
@@ -152,11 +152,6 @@ struct page *pte_alloc_one(struct mm_str
 	return pte;
 }
 
-void pmd_ctor(void *pmd, kmem_cache_t *cache, unsigned long flags)
-{
-	memset(pmd, 0, PTRS_PER_PMD*sizeof(pmd_t));
-}
-
 /*
  * List of all pgd's needed for non-PAE so it can invalidate entries
  * in both cached and uncached pgd's; not needed for PAE since the
@@ -203,6 +198,12 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
+#ifdef CONFIG_HIGHPMD
+#define	GFP_PMD		(__GFP_REPEAT|__GFP_HIGHMEM|GFP_KERNEL)
+#else
+#define GFP_PMD		(__GFP_REPEAT|GFP_KERNEL)
+#endif
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
@@ -212,16 +213,17 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		return pgd;
 
 	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+		struct page *pmd = alloc_page(GFP_PMD);
 		if (!pmd)
 			goto out_oom;
-		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
+		clear_highpage(pmd);
+		set_pgd(&pgd[i], __pgd(1ULL | (u64)page_to_pfn(pmd) << PAGE_SHIFT));
 	}
 	return pgd;
 
 out_oom:
 	for (i--; i >= 0; i--)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		__free_page(pgd_page(pgd[i]));
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -233,7 +235,7 @@ void pgd_free(pgd_t *pgd)
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
 		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+			__free_page(pgd_page(pgd[i]));
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
diff -prauN mm2-2.5.73-1/arch/sparc/mm/srmmu.c mm2-2.5.73-2/arch/sparc/mm/srmmu.c
--- mm2-2.5.73-1/arch/sparc/mm/srmmu.c	2003-06-22 11:32:56.000000000 -0700
+++ mm2-2.5.73-2/arch/sparc/mm/srmmu.c	2003-06-28 03:11:37.000000000 -0700
@@ -2180,7 +2180,7 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(pte_pfn, srmmu_pte_pfn, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_page, srmmu_pmd_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_page, srmmu_pgd_page, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__pgd_page, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_SETHI(none_mask, 0xF0000000);
 
diff -prauN mm2-2.5.73-1/arch/sparc/mm/sun4c.c mm2-2.5.73-2/arch/sparc/mm/sun4c.c
--- mm2-2.5.73-1/arch/sparc/mm/sun4c.c	2003-06-22 11:33:06.000000000 -0700
+++ mm2-2.5.73-2/arch/sparc/mm/sun4c.c	2003-06-28 03:11:37.000000000 -0700
@@ -2252,5 +2252,5 @@ void __init ld_mmu_sun4c(void)
 
 	/* These should _never_ get called with two level tables. */
 	BTFIXUPSET_CALL(pgd_set, sun4c_pgd_set, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(pgd_page, sun4c_pgd_page, BTFIXUPCALL_RETO0);
+	BTFIXUPSET_CALL(__pgd_page, sun4c_pgd_page, BTFIXUPCALL_RETO0);
 }
diff -prauN mm2-2.5.73-1/drivers/char/drm/drm_memory.h mm2-2.5.73-2/drivers/char/drm/drm_memory.h
--- mm2-2.5.73-1/drivers/char/drm/drm_memory.h	2003-06-22 11:32:35.000000000 -0700
+++ mm2-2.5.73-2/drivers/char/drm/drm_memory.h	2003-06-28 03:11:37.000000000 -0700
@@ -123,7 +123,7 @@ static inline unsigned long
 drm_follow_page (void *vaddr)
 {
 	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
-	pmd_t *pmd = pmd_offset(pgd, (unsigned long) vaddr);
+	pmd_t *pmd = pmd_offset_kernel(pgd, (unsigned long)vaddr);
 	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
 	return pte_pfn(*ptep) << PAGE_SHIFT;
 }
diff -prauN mm2-2.5.73-1/fs/exec.c mm2-2.5.73-2/fs/exec.c
--- mm2-2.5.73-1/fs/exec.c	2003-06-28 03:09:53.000000000 -0700
+++ mm2-2.5.73-2/fs/exec.c	2003-06-28 03:11:37.000000000 -0700
@@ -304,10 +304,10 @@ void put_dirty_page(struct task_struct *
 	if (!pte_chain)
 		goto out_sig;
 	spin_lock(&tsk->mm->page_table_lock);
-	pmd = pmd_alloc(tsk->mm, pgd, address);
+	pmd = pmd_alloc_map(tsk->mm, pgd, address);
 	if (!pmd)
 		goto out;
-	pte = pte_alloc_map(tsk->mm, pmd, address);
+	pte = pte_alloc_map(tsk->mm, &pmd, address);
 	if (!pte)
 		goto out;
 	if (!pte_none(*pte)) {
@@ -319,6 +319,7 @@ void put_dirty_page(struct task_struct *
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
+	pmd_unmap(pmd);
 	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
 
@@ -326,6 +327,8 @@ void put_dirty_page(struct task_struct *
 	pte_chain_free(pte_chain);
 	return;
 out:
+	if (pmd)
+		pmd_unmap(pmd);
 	spin_unlock(&tsk->mm->page_table_lock);
 out_sig:
 	__free_page(page);
diff -prauN mm2-2.5.73-1/include/asm-alpha/pgtable.h mm2-2.5.73-2/include/asm-alpha/pgtable.h
--- mm2-2.5.73-1/include/asm-alpha/pgtable.h	2003-06-22 11:32:38.000000000 -0700
+++ mm2-2.5.73-2/include/asm-alpha/pgtable.h	2003-06-28 08:20:41.000000000 -0700
@@ -229,9 +229,11 @@ pmd_page_kernel(pmd_t pmd)
 #define pmd_page(pmd)	(mem_map + ((pmd_val(pmd) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pgd_page(pgd_t pgd)
+extern inline unsigned long __pgd_page(pgd_t pgd)
 { return PAGE_OFFSET + ((pgd_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
 
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
+
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
 extern inline void pte_clear(pte_t *ptep)	{ pte_val(*ptep) = 0; }
@@ -280,7 +282,7 @@ extern inline pte_t pte_mkyoung(pte_t pt
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
-	return (pmd_t *) pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	return (pmd_t *)__pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 }
 
 /* Find an entry in the third-level page table.. */
diff -prauN mm2-2.5.73-1/include/asm-arm/pgtable.h mm2-2.5.73-2/include/asm-arm/pgtable.h
--- mm2-2.5.73-1/include/asm-arm/pgtable.h	2003-06-22 11:32:38.000000000 -0700
+++ mm2-2.5.73-2/include/asm-arm/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -125,6 +125,11 @@ extern struct page *empty_zero_page;
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir, addr)	((pmd_t *)(dir))
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
 
 /* Find an entry in the third-level page table.. */
 #define __pte_index(addr)	(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
diff -prauN mm2-2.5.73-1/include/asm-arm26/pgtable.h mm2-2.5.73-2/include/asm-arm26/pgtable.h
--- mm2-2.5.73-1/include/asm-arm26/pgtable.h	2003-06-22 11:32:32.000000000 -0700
+++ mm2-2.5.73-2/include/asm-arm26/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -189,6 +189,12 @@ extern struct page *empty_zero_page;
 #define pte_unmap(pte)                  do { } while (0)
 #define pte_unmap_nested(pte)           do { } while (0)
 
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pgd, addr)			do { } while (0)
+#define pmd_unmap_nested(pgd, addr)		do { } while (0)
+
 
 #define _PAGE_PRESENT   0x01
 #define _PAGE_READONLY  0x02
diff -prauN mm2-2.5.73-1/include/asm-h8300/pgtable.h mm2-2.5.73-2/include/asm-h8300/pgtable.h
--- mm2-2.5.73-1/include/asm-h8300/pgtable.h	2003-06-22 11:32:42.000000000 -0700
+++ mm2-2.5.73-2/include/asm-h8300/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -15,6 +15,11 @@ typedef pte_t *pte_addr_t;
 #define pgd_clear(pgdp)
 #define kern_addr_valid(addr)	(1)
 #define	pmd_offset(a, b)	((void *)0)
+#define pmd_offset_kernel(a,b)		pmd_offset(a,b)
+#define pmd_offset_map(a,b)		pmd_offset(a,b)
+#define pmd_offset_map_nested(a,b)	pmd_offset(a,b)
+#define pmd_unmap(pmd)			do { } while (0)
+#define pmd_unmap_nested(pmd)		do { } while (0)
 
 #define PAGE_NONE		__pgprot(0)    /* these mean nothing to NO_MM */
 #define PAGE_SHARED		__pgprot(0)    /* these mean nothing to NO_MM */
diff -prauN mm2-2.5.73-1/include/asm-i386/kmap_types.h mm2-2.5.73-2/include/asm-i386/kmap_types.h
--- mm2-2.5.73-1/include/asm-i386/kmap_types.h	2003-06-22 11:33:01.000000000 -0700
+++ mm2-2.5.73-2/include/asm-i386/kmap_types.h	2003-06-28 03:11:37.000000000 -0700
@@ -17,14 +17,16 @@ D(3)	KM_USER0,
 D(4)	KM_USER1,
 D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
-D(7)	KM_PTE0,
-D(8)	KM_PTE1,
-D(9)	KM_PTE2,
-D(10)	KM_IRQ0,
-D(11)	KM_IRQ1,
-D(12)	KM_SOFTIRQ0,
-D(13)	KM_SOFTIRQ1,
-D(14)	KM_TYPE_NR
+D(7)	KM_PMD0,
+D(8)	KM_PMD1,
+D(9)	KM_PTE0,
+D(10)	KM_PTE1,
+D(11)	KM_PTE2,
+D(12)	KM_IRQ0,
+D(13)	KM_IRQ1,
+D(14)	KM_SOFTIRQ0,
+D(15)	KM_SOFTIRQ1,
+D(16)	KM_TYPE_NR
 };
 
 #undef D
diff -prauN mm2-2.5.73-1/include/asm-i386/pgalloc.h mm2-2.5.73-2/include/asm-i386/pgalloc.h
--- mm2-2.5.73-1/include/asm-i386/pgalloc.h	2003-06-22 11:32:31.000000000 -0700
+++ mm2-2.5.73-2/include/asm-i386/pgalloc.h	2003-06-28 08:06:24.000000000 -0700
@@ -46,6 +46,7 @@ static inline void pte_free(struct page 
  */
 
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
+#define pmd_alloc_one_kernel(mm, addr)	({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
diff -prauN mm2-2.5.73-1/include/asm-i386/pgtable-2level.h mm2-2.5.73-2/include/asm-i386/pgtable-2level.h
--- mm2-2.5.73-1/include/asm-i386/pgtable-2level.h	2003-06-22 11:32:55.000000000 -0700
+++ mm2-2.5.73-2/include/asm-i386/pgtable-2level.h	2003-06-28 03:11:37.000000000 -0700
@@ -48,13 +48,15 @@ static inline int pgd_present(pgd_t pgd)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
-((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+
+#define pmd_offset_map(pgd, addr)		({ (pmd_t *)(pgd); })
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset_map(pgd, addr)
+#define pmd_offset_kernel(pgd, addr)		pmd_offset_map(pgd, addr)
+
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
 
-static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
-{
-	return (pmd_t *) dir;
-}
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff -prauN mm2-2.5.73-1/include/asm-i386/pgtable-3level.h mm2-2.5.73-2/include/asm-i386/pgtable-3level.h
--- mm2-2.5.73-1/include/asm-i386/pgtable-3level.h	2003-06-28 03:09:54.000000000 -0700
+++ mm2-2.5.73-2/include/asm-i386/pgtable-3level.h	2003-06-28 08:21:14.000000000 -0700
@@ -64,12 +64,32 @@ static inline void set_pte(pte_t *ptep, 
  */
 static inline void pgd_clear (pgd_t * pgd) { }
 
-#define pgd_page(pgd) \
-((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+static inline unsigned long pgd_pfn(pgd_t pgd)
+{
+	return pgd_val(pgd) >> PAGE_SHIFT;
+}
+
+#define pgd_page(pgd)		pfn_to_page(pgd_pfn(pgd))
+
+#define pmd_offset_kernel(pgd, addr)					\
+	((pmd_t *)__va(pgd_val(*(pgd)) & PAGE_MASK) + pmd_index(addr))
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(dir, address) ((pmd_t *) pgd_page(*(dir)) + \
-			pmd_index(address))
+#ifdef CONFIG_HIGHPMD
+#define __pmd_offset(pgd, addr, type)					\
+	((pmd_t *)kmap_atomic(pgd_page(*(pgd)), type) + pmd_index(addr))
+#define __pmd_unmap(pmd, type)		kunmap_atomic(pmd, type)
+#else
+#define __pmd_offset(pgd, addr, type)					\
+	((pmd_t *)__va(pgd_val(*(pgd)) & PAGE_MASK) + pmd_index(addr))
+#define __pmd_unmap(pmd, type)		do { } while (0)
+#endif
+
+#define pmd_offset_map(pgd, addr)		__pmd_offset(pgd, addr, KM_PMD0)
+#define pmd_offset_map_nested(pgd, addr)	__pmd_offset(pgd, addr, KM_PMD1)
+
+#define pmd_unmap(pmd)				__pmd_unmap(pmd, KM_PMD0);
+#define pmd_unmap_nested(pmd)			__pmd_unmap(pmd, KM_PMD1);
 
 static inline pte_t ptep_get_and_clear(pte_t *ptep)
 {
diff -prauN mm2-2.5.73-1/include/asm-i386/pgtable.h mm2-2.5.73-2/include/asm-i386/pgtable.h
--- mm2-2.5.73-1/include/asm-i386/pgtable.h	2003-06-28 03:09:54.000000000 -0700
+++ mm2-2.5.73-2/include/asm-i386/pgtable.h	2003-06-28 08:18:44.000000000 -0700
@@ -33,11 +33,9 @@
 extern unsigned long empty_zero_page[1024];
 extern pgd_t swapper_pg_dir[1024];
 extern kmem_cache_t *pgd_cache;
-extern kmem_cache_t *pmd_cache;
 extern spinlock_t pgd_lock;
 extern struct list_head pgd_list;
 
-void pmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_dtor(void *, kmem_cache_t *, unsigned long);
 void pgtable_cache_init(void);
diff -prauN mm2-2.5.73-1/include/asm-ia64/pgtable.h mm2-2.5.73-2/include/asm-ia64/pgtable.h
--- mm2-2.5.73-1/include/asm-ia64/pgtable.h	2003-06-22 11:32:39.000000000 -0700
+++ mm2-2.5.73-2/include/asm-ia64/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -257,7 +257,8 @@ ia64_phys_addr_valid (unsigned long addr
 #define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)			((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define __pgd_page(pgd)			((unsigned long)__va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page(pgd)			virt_to_page(__pgd_page(pgd))
 
 /*
  * The following have defined behavior only work if pte_present() is true.
@@ -326,7 +327,13 @@ pgd_offset (struct mm_struct *mm, unsign
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir,addr) \
-	((pmd_t *) pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+	((pmd_t *)__pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
 
 /*
  * Find an entry in the third-level page table.  This looks more complicated than it
diff -prauN mm2-2.5.73-1/include/asm-m68k/motorola_pgtable.h mm2-2.5.73-2/include/asm-m68k/motorola_pgtable.h
--- mm2-2.5.73-1/include/asm-m68k/motorola_pgtable.h	2003-06-22 11:32:57.000000000 -0700
+++ mm2-2.5.73-2/include/asm-m68k/motorola_pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -115,6 +115,7 @@ extern inline void pgd_set(pgd_t * pgdp,
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define __pmd_page(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
 #define __pgd_page(pgd) ((unsigned long)__va(pgd_val(pgd) & _TABLE_MASK))
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
 
 
 #define pte_none(pte)		(!pte_val(pte))
diff -prauN mm2-2.5.73-1/include/asm-m68knommu/pgtable.h mm2-2.5.73-2/include/asm-m68knommu/pgtable.h
--- mm2-2.5.73-1/include/asm-m68knommu/pgtable.h	2003-06-22 11:32:56.000000000 -0700
+++ mm2-2.5.73-2/include/asm-m68knommu/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -21,7 +21,12 @@ typedef pte_t *pte_addr_t;
 #define pgd_bad(pgd)		(0)
 #define pgd_clear(pgdp)
 #define kern_addr_valid(addr)	(1)
-#define	pmd_offset(a, b)	((void *)0)
+#define	pmd_offset(a, b)		((void *)0)
+#define	pmd_offset_kernel(a, b)		pmd_offset(a, b)
+#define	pmd_offset_map(a, b)		pmd_offset(a, b)
+#define	pmd_offset_map_nested(a, b)	pmd_offset(a, b)
+#define pmd_unmap(pmd)			do { } while (0)
+#define pmd_unmap_nested(pmd)		do { } while (0)
 
 #define PAGE_NONE	__pgprot(0)
 #define PAGE_SHARED	__pgprot(0)
diff -prauN mm2-2.5.73-1/include/asm-mips64/pgtable.h mm2-2.5.73-2/include/asm-mips64/pgtable.h
--- mm2-2.5.73-1/include/asm-mips64/pgtable.h	2003-06-28 03:09:55.000000000 -0700
+++ mm2-2.5.73-2/include/asm-mips64/pgtable.h	2003-06-28 03:16:19.000000000 -0700
@@ -155,11 +155,13 @@ extern pmd_t empty_bad_pmd_table[2*PAGE_
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pmd_page_kernel(pmd)	pmd_val(pmd)
 
-static inline unsigned long pgd_page(pgd_t pgd)
+static inline unsigned long __pgd_page(pgd_t pgd)
 {
 	return pgd_val(pgd);
 }
 
+#define pgd_page(pgd)		virt_to_page(__pgd_page(pgd))
+
 static inline int pte_none(pte_t pte)
 {
 	return !(pte_val(pte) & ~_PAGE_GLOBAL);
@@ -397,7 +399,7 @@ static inline pte_t pte_modify(pte_t pte
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
 {
-	return (pmd_t *) pgd_page(*dir) +
+	return (pmd_t *)__pgd_page(*dir) +
 	       ((address >> PMD_SHIFT) & (PTRS_PER_PMD - 1));
 }
 
diff -prauN mm2-2.5.73-1/include/asm-parisc/pgtable.h mm2-2.5.73-2/include/asm-parisc/pgtable.h
--- mm2-2.5.73-1/include/asm-parisc/pgtable.h	2003-06-22 11:33:15.000000000 -0700
+++ mm2-2.5.73-2/include/asm-parisc/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -242,7 +242,8 @@ extern unsigned long *empty_zero_page;
 
 
 #ifdef __LP64__
-#define pgd_page(pgd) ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+#define __pgd_page(pgd) ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
 
 /* For 64 bit we have three level tables */
 
@@ -339,11 +340,17 @@ extern inline pte_t pte_modify(pte_t pte
 
 #ifdef __LP64__
 #define pmd_offset(dir,address) \
-((pmd_t *) pgd_page(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
+((pmd_t *)__pgd_page(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
 #else
 #define pmd_offset(dir,addr) ((pmd_t *) dir)
 #endif
 
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
+
 /* Find an entry in the third-level page table.. */ 
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
diff -prauN mm2-2.5.73-1/include/asm-ppc/pgtable.h mm2-2.5.73-2/include/asm-ppc/pgtable.h
--- mm2-2.5.73-1/include/asm-ppc/pgtable.h	2003-06-22 11:32:37.000000000 -0700
+++ mm2-2.5.73-2/include/asm-ppc/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -370,8 +370,9 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 #define pgd_clear(xp)				do { } while (0)
 
-#define pgd_page(pgd) \
+#define __pgd_page(pgd) \
 	((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
 
 /*
  * The following only work if pte_present() is true.
diff -prauN mm2-2.5.73-1/include/asm-ppc64/pgtable.h mm2-2.5.73-2/include/asm-ppc64/pgtable.h
--- mm2-2.5.73-1/include/asm-ppc64/pgtable.h	2003-06-22 11:33:18.000000000 -0700
+++ mm2-2.5.73-2/include/asm-ppc64/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -190,7 +190,8 @@ extern unsigned long empty_zero_page[PAG
 #define pgd_bad(pgd)		((pgd_val(pgd)) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0UL)
 #define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)		(__bpn_to_ba(pgd_val(pgd))) 
+#define __pgd_page(pgd)		(__bpn_to_ba(pgd_val(pgd))) 
+#define pgd_page(pgd)		virt_to_page(__pgd_page(pgd))
 
 /* 
  * Find an entry in a page-table-directory.  We combine the address region 
@@ -203,12 +204,18 @@ extern unsigned long empty_zero_page[PAG
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir,addr) \
-  ((pmd_t *) pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+  ((pmd_t *)__pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 /* Find an entry in the third-level page table.. */
 #define pte_offset_kernel(dir,addr) \
   ((pte_t *) pmd_page_kernel(*(dir)) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
+
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_unmap(pte)			do { } while(0)
diff -prauN mm2-2.5.73-1/include/asm-s390/pgtable.h mm2-2.5.73-2/include/asm-s390/pgtable.h
--- mm2-2.5.73-1/include/asm-s390/pgtable.h	2003-06-22 11:33:07.000000000 -0700
+++ mm2-2.5.73-2/include/asm-s390/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -613,6 +613,7 @@ static inline pte_t mk_pte_phys(unsigned
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
+#define pgd_page(pgd)	virt_to_page(pgd_page_kernel(pgd))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
@@ -634,6 +635,12 @@ extern inline pmd_t * pmd_offset(pgd_t *
 
 #endif /* __s390x__ */
 
+#define pmd_offset_kernel(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)					do { } while (0)
+#define pmd_unmap_nested(pmd)				do { } while (0)
+
 /* Find an entry in the third-level page table.. */
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
diff -prauN mm2-2.5.73-1/include/asm-sh/pgtable-2level.h mm2-2.5.73-2/include/asm-sh/pgtable-2level.h
--- mm2-2.5.73-1/include/asm-sh/pgtable-2level.h	2003-06-22 11:33:32.000000000 -0700
+++ mm2-2.5.73-2/include/asm-sh/pgtable-2level.h	2003-06-28 03:11:37.000000000 -0700
@@ -48,8 +48,9 @@ static inline void pgd_clear (pgd_t * pg
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
+#define __pgd_page(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
 
 static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
diff -prauN mm2-2.5.73-1/include/asm-sparc/pgtable.h mm2-2.5.73-2/include/asm-sparc/pgtable.h
--- mm2-2.5.73-1/include/asm-sparc/pgtable.h	2003-06-22 11:32:56.000000000 -0700
+++ mm2-2.5.73-2/include/asm-sparc/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -202,10 +202,11 @@ extern unsigned long empty_zero_page;
 /*
  */
 BTFIXUPDEF_CALL_CONST(struct page *, pmd_page, pmd_t)
-BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page, pgd_t)
+BTFIXUPDEF_CALL_CONST(unsigned long, __pgd_page, pgd_t)
 
 #define pmd_page(pmd) BTFIXUP_CALL(pmd_page)(pmd)
-#define pgd_page(pgd) BTFIXUP_CALL(pgd_page)(pgd)
+#define __pgd_page(pgd) BTFIXUP_CALL(__pgd_page)(pgd)
+#define pgd_page(pgd)	virt_to_page(__pgd_page(pgd))
 
 BTFIXUPDEF_SETHI(none_mask)
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
@@ -352,6 +353,11 @@ extern __inline__ pte_t pte_modify(pte_t
 /* Find an entry in the second-level page table.. */
 BTFIXUPDEF_CALL(pmd_t *, pmd_offset, pgd_t *, unsigned long)
 #define pmd_offset(dir,addr) BTFIXUP_CALL(pmd_offset)(dir,addr)
+#define pmd_offset_kernel(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)					do { } while (0)
+#define pmd_unmap_nested(pmd)				do { } while (0)
 
 /* Find an entry in the third-level page table.. */ 
 BTFIXUPDEF_CALL(pte_t *, pte_offset_kernel, pmd_t *, unsigned long)
diff -prauN mm2-2.5.73-1/include/asm-sparc64/pgtable.h mm2-2.5.73-2/include/asm-sparc64/pgtable.h
--- mm2-2.5.73-1/include/asm-sparc64/pgtable.h	2003-06-22 11:32:31.000000000 -0700
+++ mm2-2.5.73-2/include/asm-sparc64/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -228,7 +228,8 @@ static inline pte_t pte_modify(pte_t ori
 	(pgd_val(*(pgdp)) = (__pa((unsigned long) (pmdp)) >> 11UL))
 #define __pmd_page(pmd)			((unsigned long) __va((pmd_val(pmd)<<11UL)))
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pgd_page(pgd)			((unsigned long) __va((pgd_val(pgd)<<11UL)))
+#define __pgd_page(pgd)			((unsigned long) __va((pgd_val(pgd)<<11UL)))
+#define pgd_page(pgd)			virt_to_page(__pgd_page(pgd))
 #define pte_none(pte) 			(!pte_val(pte))
 #define pte_present(pte)		(pte_val(pte) & _PAGE_PRESENT)
 #define pte_clear(pte)			(pte_val(*(pte)) = 0UL)
@@ -270,8 +271,13 @@ static inline pte_t pte_modify(pte_t ori
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(dir, address)	((pmd_t *) pgd_page(*(dir)) + \
+#define pmd_offset(dir, address)	((pmd_t *)__pgd_page(*(dir)) + \
 					((address >> PMD_SHIFT) & (REAL_PTRS_PER_PMD-1)))
+#define pmd_offset_kernel(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)					do { } while (0)
+#define pmd_unmap_nested(pmd)				do { } while (0)
 
 /* Find an entry in the third-level page table.. */
 #define pte_index(dir, address)	((pte_t *) __pmd_page(*(dir)) + \
diff -prauN mm2-2.5.73-1/include/asm-v850/pgtable.h mm2-2.5.73-2/include/asm-v850/pgtable.h
--- mm2-2.5.73-1/include/asm-v850/pgtable.h	2003-06-22 11:32:58.000000000 -0700
+++ mm2-2.5.73-2/include/asm-v850/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -13,6 +13,11 @@ typedef pte_t *pte_addr_t;
 #define pgd_clear(pgdp)		((void)0)
 
 #define	pmd_offset(a, b)	((void *)0)
+#define pmd_offset_kernel(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)	pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)				do { } while (0)
+#define pmd_unmap_nested(pmd)			do { } while (0)
 
 #define kern_addr_valid(addr)	(1)
 
diff -prauN mm2-2.5.73-1/include/asm-x86_64/pgtable.h mm2-2.5.73-2/include/asm-x86_64/pgtable.h
--- mm2-2.5.73-1/include/asm-x86_64/pgtable.h	2003-06-28 03:09:57.000000000 -0700
+++ mm2-2.5.73-2/include/asm-x86_64/pgtable.h	2003-06-28 03:11:37.000000000 -0700
@@ -98,8 +98,9 @@ static inline void set_pml4(pml4_t *dst,
 	pml4_val(*dst) = pml4_val(val); 
 }
 
-#define pgd_page(pgd) \
+#define __pgd_page(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PHYSICAL_PAGE_MASK))
+#define pgd_page(pgd)		virt_to_page(__pgd_page(pgd))
 
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte, 0))
 #define pte_same(a, b)		((a).pte == (b).pte)
@@ -332,8 +333,13 @@ static inline pgd_t *current_pgd_offset_
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir, address) ((pmd_t *) pgd_page(*(dir)) + \
+#define pmd_offset(dir, address) ((pmd_t *)__pgd_page(*(dir)) + \
 			pmd_index(address))
+#define pmd_offset_kernel(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map(pgd, addr)			pmd_offset(pgd, addr)
+#define pmd_offset_map_nested(pgd, addr)		pmd_offset(pgd, addr)
+#define pmd_unmap(pmd)					do { } while (0)
+#define pmd_unmap_nested(pmd)				do { } while (0)
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
diff -prauN mm2-2.5.73-1/include/linux/mm.h mm2-2.5.73-2/include/linux/mm.h
--- mm2-2.5.73-1/include/linux/mm.h	2003-06-28 03:09:57.000000000 -0700
+++ mm2-2.5.73-2/include/linux/mm.h	2003-06-28 03:11:37.000000000 -0700
@@ -426,8 +426,9 @@ extern void invalidate_mmap_range(struct
 				  loff_t const holelen);
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
+pmd_t *FASTCALL(__pmd_alloc_kernel(struct mm_struct *mm, pgd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t **pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
@@ -488,12 +489,11 @@ static inline int set_page_dirty(struct 
  * inlining and the symmetry break with pte_alloc_map() that does all
  * of this out-of-line.
  */
-static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
-{
-	if (pgd_none(*pgd))
-		return __pmd_alloc(mm, pgd, address);
-	return pmd_offset(pgd, address);
-}
+#define pmd_alloc_map(mm, pgd, addr)				\
+	(pgd_none(*(pgd))? __pmd_alloc(mm,pgd,addr): pmd_offset_map(pgd,addr))
+
+#define pmd_alloc_kernel(mm, pgd, addr)				\
+	(pgd_none(*(pgd))? __pmd_alloc_kernel(mm,pgd,addr): pmd_offset_kernel(pgd,addr))
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
diff -prauN mm2-2.5.73-1/mm/fremap.c mm2-2.5.73-2/mm/fremap.c
--- mm2-2.5.73-1/mm/fremap.c	2003-06-22 11:32:31.000000000 -0700
+++ mm2-2.5.73-2/mm/fremap.c	2003-06-28 03:11:37.000000000 -0700
@@ -67,11 +67,11 @@ int install_page(struct mm_struct *mm, s
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
-	pmd = pmd_alloc(mm, pgd, addr);
+	pmd = pmd_alloc_map(mm, pgd, addr);
 	if (!pmd)
 		goto err_unlock;
 
-	pte = pte_alloc_map(mm, pmd, addr);
+	pte = pte_alloc_map(mm, &pmd, addr);
 	if (!pte)
 		goto err_unlock;
 
@@ -82,6 +82,7 @@ int install_page(struct mm_struct *mm, s
 	set_pte(pte, mk_pte(page, prot));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
+	pmd_unmap(pmd);
 	if (flush)
 		flush_tlb_page(vma, addr);
 	update_mmu_cache(vma, addr, *pte);
diff -prauN mm2-2.5.73-1/mm/memory.c mm2-2.5.73-2/mm/memory.c
--- mm2-2.5.73-1/mm/memory.c	2003-06-28 03:09:58.000000000 -0700
+++ mm2-2.5.73-2/mm/memory.c	2003-06-28 08:35:17.000000000 -0700
@@ -103,6 +103,7 @@ static inline void free_one_pmd(struct m
 static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
 {
 	pmd_t * pmd, * md, * emd;
+	struct page *page;
 
 	if (pgd_none(*dir))
 		return;
@@ -111,7 +112,8 @@ static inline void free_one_pgd(struct m
 		pgd_clear(dir);
 		return;
 	}
-	pmd = pmd_offset(dir, 0);
+	page = pgd_page(*dir);
+	pmd = pmd_offset_map(dir, 0);
 	pgd_clear(dir);
 	/*
 	 * Beware if changing the loop below.  It once used int j,
@@ -128,7 +130,8 @@ static inline void free_one_pgd(struct m
 	 */
 	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++)
 		free_one_pmd(tlb,md);
-	pmd_free_tlb(tlb, pmd);
+	pmd_unmap(pmd);
+	pmd_free_tlb(tlb, page);
 }
 
 /*
@@ -148,30 +151,40 @@ void clear_page_tables(struct mmu_gather
 	} while (--nr);
 }
 
-pte_t * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+/*
+ * error return happens with pmd unmapped
+ */
+pte_t *pte_alloc_map(struct mm_struct *mm, pmd_t **pmd, unsigned long address)
 {
-	if (!pmd_present(*pmd)) {
+	if (!pmd_present(**pmd)) {
+		pgd_t *pgd;
 		struct page *new;
 
+		pmd_unmap(*pmd);
 		spin_unlock(&mm->page_table_lock);
 		new = pte_alloc_one(mm, address);
 		spin_lock(&mm->page_table_lock);
-		if (!new)
+		if (!new) {
+			*pmd = NULL;
 			return NULL;
+		}
+
+		pgd = pgd_offset(mm, address);
+		*pmd = pmd_offset_map(pgd, address);
 
 		/*
 		 * Because we dropped the lock, we should re-check the
 		 * entry, as somebody else could have populated it..
 		 */
-		if (pmd_present(*pmd)) {
+		if (pmd_present(**pmd)) {
 			pte_free(new);
 			goto out;
 		}
 		pgtable_add_rmap(new, mm, address);
-		pmd_populate(mm, pmd, new);
+		pmd_populate(mm, *pmd, new);
 	}
 out:
-	return pte_offset_map(pmd, address);
+	return pte_offset_map(*pmd, address);
 }
 
 pte_t * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
@@ -256,11 +269,10 @@ skip_copy_pmd_range:	address = (address 
 			continue;
 		}
 
-		src_pmd = pmd_offset(src_pgd, address);
-		dst_pmd = pmd_alloc(dst, dst_pgd, address);
+		dst_pmd = pmd_alloc_map(dst, dst_pgd, address);
 		if (!dst_pmd)
 			goto nomem;
-
+		src_pmd = pmd_offset_map_nested(src_pgd, address);
 		do {
 			pte_t * src_pte, * dst_pte;
 		
@@ -273,15 +285,20 @@ skip_copy_pmd_range:	address = (address 
 				pmd_clear(src_pmd);
 skip_copy_pte_range:
 				address = (address + PMD_SIZE) & PMD_MASK;
-				if (address >= end)
+				if (address >= end) {
+					pmd_unmap(dst_pmd);
+					pmd_unmap_nested(src_pmd);
 					goto out;
+				}
 				goto cont_copy_pmd_range;
 			}
 
-			dst_pte = pte_alloc_map(dst, dst_pmd, address);
+			pmd_unmap_nested(src_pmd);
+			dst_pte = pte_alloc_map(dst, &dst_pmd, address);
 			if (!dst_pte)
 				goto nomem;
 			spin_lock(&src->page_table_lock);	
+			src_pmd = pmd_offset_map_nested(src_pgd, address);
 			src_pte = pte_offset_map_nested(src_pmd, address);
 			do {
 				pte_t pte = *src_pte;
@@ -348,6 +365,8 @@ skip_copy_pte_range:
 				 */
 				pte_unmap_nested(src_pte);
 				pte_unmap(dst_pte);
+				pmd_unmap_nested(src_pmd);
+				pmd_unmap(dst_pmd);
 				spin_unlock(&src->page_table_lock);	
 				spin_unlock(&dst->page_table_lock);	
 				pte_chain = pte_chain_alloc(GFP_KERNEL);
@@ -355,12 +374,16 @@ skip_copy_pte_range:
 				if (!pte_chain)
 					goto nomem;
 				spin_lock(&src->page_table_lock);
+				dst_pmd = pmd_offset_map(dst_pgd, address);
+				src_pmd = pmd_offset_map_nested(src_pgd, address);
 				dst_pte = pte_offset_map(dst_pmd, address);
 				src_pte = pte_offset_map_nested(src_pmd,
 								address);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
 				if (address >= end) {
+					pmd_unmap(dst_pmd);
+					pmd_unmap_nested(src_pmd);
 					pte_unmap_nested(src_pte);
 					pte_unmap(dst_pte);
 					goto out_unlock;
@@ -376,6 +399,8 @@ cont_copy_pmd_range:
 			src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
+		pmd_unmap_nested(src_pmd-1);
+		pmd_unmap(dst_pmd-1);
 	}
 out_unlock:
 	spin_unlock(&src->page_table_lock);
@@ -451,7 +476,7 @@ zap_pmd_range(struct mmu_gather *tlb, pg
 		pgd_clear(dir);
 		return;
 	}
-	pmd = pmd_offset(dir, address);
+	pmd = pmd_offset_map(dir, address);
 	end = address + size;
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
@@ -460,6 +485,7 @@ zap_pmd_range(struct mmu_gather *tlb, pg
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address < end);
+	pmd_unmap(pmd - 1);
 }
 
 void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
@@ -641,20 +667,27 @@ follow_page(struct mm_struct *mm, unsign
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		goto out;
 
-	pmd = pmd_offset(pgd, address);
+	pmd = pmd_offset_map(pgd, address);
 	if (pmd_none(*pmd))
-		goto out;
-	if (pmd_huge(*pmd))
-		return follow_huge_pmd(mm, address, pmd, write);
-	if (pmd_bad(*pmd))
-		goto out;
+		goto out_unmap;
+	if (pmd_bad(*pmd)) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		goto out_unmap;
+	}
+	if (pmd_huge(*pmd)) {
+		struct page *page = follow_huge_pmd(mm, address, pmd, write);
+		pmd_unmap(pmd);
+		return page;
+	}
 
 	ptep = pte_offset_map(pmd, address);
 	if (!ptep)
-		goto out;
+		goto out_unmap;
 
 	pte = *ptep;
 	pte_unmap(ptep);
+	pmd_unmap(pmd);
 	if (pte_present(pte)) {
 		if (!write || (pte_write(pte) && pte_dirty(pte))) {
 			pfn = pte_pfn(pte);
@@ -665,6 +698,9 @@ follow_page(struct mm_struct *mm, unsign
 
 out:
 	return NULL;
+out_unmap:
+	pmd_unmap(pmd);
+	goto out;
 }
 
 /* 
@@ -723,7 +759,7 @@ int get_user_pages(struct task_struct *t
 			pgd = pgd_offset_k(pg);
 			if (!pgd)
 				return i ? : -EFAULT;
-			pmd = pmd_offset(pgd, pg);
+			pmd = pmd_offset_kernel(pgd, pg);
 			if (!pmd)
 				return i ? : -EFAULT;
 			pte = pte_offset_kernel(pmd, pg);
@@ -815,8 +851,8 @@ static void zeromap_pte_range(pte_t * pt
 	} while (address && (address < end));
 }
 
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
-                                    unsigned long size, pgprot_t prot)
+static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t **pmd,
+			unsigned long address, unsigned long size, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -825,13 +861,13 @@ static inline int zeromap_pmd_range(stru
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
+		pte_t *pte = pte_alloc_map(mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		zeromap_pte_range(pte, address, end - address, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
+		(*pmd)++;
 	} while (address && (address < end));
 	return 0;
 }
@@ -851,13 +887,14 @@ int zeromap_page_range(struct vm_area_st
 
 	spin_lock(&mm->page_table_lock);
 	do {
-		pmd_t *pmd = pmd_alloc(mm, dir, address);
+		pmd_t *pmd = pmd_alloc_map(mm, dir, address);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = zeromap_pmd_range(mm, pmd, address, end - address, prot);
+		error = zeromap_pmd_range(mm, &pmd, address, end - address, prot);
 		if (error)
 			break;
+		pmd_unmap(pmd - 1);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -892,8 +929,9 @@ static inline void remap_pte_range(pte_t
 	} while (address && (address < end));
 }
 
-static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+static inline int remap_pmd_range(struct mm_struct *mm, pmd_t **pmd,
+				unsigned long address, unsigned long size,
+				unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long base, end;
 
@@ -904,13 +942,13 @@ static inline int remap_pmd_range(struct
 		end = PGDIR_SIZE;
 	phys_addr -= address;
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
+		pte_t *pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
 		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
+		(*pmd)++;
 	} while (address && (address < end));
 	return 0;
 }
@@ -932,13 +970,14 @@ int remap_page_range(struct vm_area_stru
 
 	spin_lock(&mm->page_table_lock);
 	do {
-		pmd_t *pmd = pmd_alloc(mm, dir, from);
+		pmd_t *pmd = pmd_alloc_map(mm, dir, from);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = remap_pmd_range(mm, pmd, from, end - from, phys_addr + from, prot);
+		error = remap_pmd_range(mm, &pmd, from, end - from, phys_addr + from, prot);
 		if (error)
 			break;
+		pmd_unmap(pmd - 1);
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (from && (from < end));
@@ -1008,6 +1047,7 @@ static int do_wp_page(struct mm_struct *
 		 * data, but for the moment just pretend this is OOM.
 		 */
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
 		goto oom;
@@ -1022,11 +1062,13 @@ static int do_wp_page(struct mm_struct *
 			establish_pte(vma, address, page_table,
 				pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			pte_unmap(page_table);
+			pmd_unmap(pmd);
 			ret = VM_FAULT_MINOR;
 			goto out;
 		}
 	}
 	pte_unmap(page_table);
+	pmd_unmap(pmd);
 
 	/*
 	 * Ok, we need to copy. Oh, well..
@@ -1046,6 +1088,7 @@ static int do_wp_page(struct mm_struct *
 	 * Re-check the pte - we dropped the lock
 	 */
 	spin_lock(&mm->page_table_lock);
+	pmd = pmd_offset_map(pgd_offset(mm, address), address);
 	page_table = pte_offset_map(pmd, address);
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
@@ -1059,6 +1102,7 @@ static int do_wp_page(struct mm_struct *
 		new_page = old_page;
 	}
 	pte_unmap(page_table);
+	pmd_unmap(pmd);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	ret = VM_FAULT_MINOR;
@@ -1227,6 +1271,7 @@ static int do_swap_page(struct mm_struct
 	struct pte_chain *pte_chain = NULL;
 
 	pte_unmap(page_table);
+	pmd_unmap(pmd);
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
@@ -1238,12 +1283,14 @@ static int do_swap_page(struct mm_struct
 			 * we released the page table lock.
 			 */
 			spin_lock(&mm->page_table_lock);
+			pmd = pmd_offset_map(pgd_offset(mm, address), address);
 			page_table = pte_offset_map(pmd, address);
 			if (pte_same(*page_table, orig_pte))
 				ret = VM_FAULT_OOM;
 			else
 				ret = VM_FAULT_MINOR;
 			pte_unmap(page_table);
+			pmd_unmap(pmd);
 			spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
@@ -1266,9 +1313,11 @@ static int do_swap_page(struct mm_struct
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
+	pmd = pmd_offset_map(pgd_offset(mm, address), address);
 	page_table = pte_offset_map(pmd, address);
 	if (!pte_same(*page_table, orig_pte)) {
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 		spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
 		page_cache_release(page);
@@ -1294,6 +1343,7 @@ static int do_swap_page(struct mm_struct
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
+	pmd_unmap(pmd);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -1319,11 +1369,13 @@ do_anonymous_page(struct mm_struct *mm, 
 	pte_chain = pte_chain_alloc(GFP_ATOMIC);
 	if (!pte_chain) {
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 		spin_unlock(&mm->page_table_lock);
 		pte_chain = pte_chain_alloc(GFP_KERNEL);
 		if (!pte_chain)
 			goto no_mem;
 		spin_lock(&mm->page_table_lock);
+		pmd = pmd_offset_map(pgd_offset(mm, addr), addr);
 		page_table = pte_offset_map(pmd, addr);
 	}
 		
@@ -1334,6 +1386,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 		spin_unlock(&mm->page_table_lock);
 
 		page = alloc_page(GFP_HIGHUSER);
@@ -1342,9 +1395,11 @@ do_anonymous_page(struct mm_struct *mm, 
 		clear_user_highpage(page, addr);
 
 		spin_lock(&mm->page_table_lock);
+		pmd = pmd_offset_map(pgd_offset(mm, addr), addr);
 		page_table = pte_offset_map(pmd, addr);
 
 		if (!pte_none(*page_table)) {
+			pmd_unmap(pmd);
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
@@ -1360,6 +1415,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	set_pte(page_table, entry);
 	/* ignores ZERO_PAGE */
 	pte_chain = page_add_rmap(page, page_table, pte_chain);
+	pmd_unmap(pmd);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1402,6 +1458,7 @@ do_no_page(struct mm_struct *mm, struct 
 		return do_anonymous_page(mm, vma, page_table,
 					pmd, write_access, address);
 	pte_unmap(page_table);
+	pmd_unmap(pmd);
 
 	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
 	sequence = atomic_read(&mapping->truncate_count);
@@ -1446,6 +1503,7 @@ retry:
 		page_cache_release(new_page);
 		goto retry;
 	}
+	pmd = pmd_offset_map(pgd_offset(mm, address), address);
 	page_table = pte_offset_map(pmd, address);
 
 	/*
@@ -1468,9 +1526,11 @@ retry:
 		set_pte(page_table, entry);
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 	} else {
 		/* One of our sibling threads was faster, back out. */
 		pte_unmap(page_table);
+		pmd_unmap(pmd);
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
 		ret = VM_FAULT_MINOR;
@@ -1514,6 +1574,7 @@ static int do_file_page(struct mm_struct
 	pgoff = pte_to_pgoff(*pte);
 
 	pte_unmap(pte);
+	pmd_unmap(pmd);
 	spin_unlock(&mm->page_table_lock);
 
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
@@ -1574,6 +1635,7 @@ static inline int handle_pte_fault(struc
 	entry = pte_mkyoung(entry);
 	establish_pte(vma, address, pte, entry);
 	pte_unmap(pte);
+	pmd_unmap(pmd);
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 }
@@ -1600,10 +1662,10 @@ int handle_mm_fault(struct mm_struct *mm
 	 * and the SMP-safe atomic PTE updates.
 	 */
 	spin_lock(&mm->page_table_lock);
-	pmd = pmd_alloc(mm, pgd, address);
+	pmd = pmd_alloc_map(mm, pgd, address);
 
 	if (pmd) {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
+		pte_t *pte = pte_alloc_map(mm, &pmd, address);
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
@@ -1640,7 +1702,30 @@ pmd_t *__pmd_alloc(struct mm_struct *mm,
 	}
 	pgd_populate(mm, pgd, new);
 out:
-	return pmd_offset(pgd, address);
+	return pmd_offset_map(pgd, address);
+}
+
+pmd_t *__pmd_alloc_kernel(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+{
+	pmd_t *new;
+
+	spin_unlock(&mm->page_table_lock);
+	new = pmd_alloc_one_kernel(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new)
+		return NULL;
+
+	/*
+	 * Because we dropped the lock, we should re-check the
+	 * entry, as somebody else could have populated it..
+	 */
+	if (pgd_present(*pgd)) {
+		pmd_free(new);
+		goto out;
+	}
+	pgd_populate(mm, pgd, new);
+out:
+	return pmd_offset_kernel(pgd, address);
 }
 
 int make_pages_present(unsigned long addr, unsigned long end)
@@ -1672,7 +1757,7 @@ struct page * vmalloc_to_page(void * vma
 	pte_t *ptep, pte;
   
 	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, addr);
+		pmd = pmd_offset_map(pgd, addr);
 		if (!pmd_none(*pmd)) {
 			preempt_disable();
 			ptep = pte_offset_map(pmd, addr);
@@ -1682,6 +1767,7 @@ struct page * vmalloc_to_page(void * vma
 			pte_unmap(ptep);
 			preempt_enable();
 		}
+		pmd_unmap(pmd);
 	}
 	return page;
 }
diff -prauN mm2-2.5.73-1/mm/mprotect.c mm2-2.5.73-2/mm/mprotect.c
--- mm2-2.5.73-1/mm/mprotect.c	2003-06-28 03:09:58.000000000 -0700
+++ mm2-2.5.73-2/mm/mprotect.c	2003-06-28 03:11:37.000000000 -0700
@@ -73,7 +73,7 @@ change_pmd_range(pgd_t *pgd, unsigned lo
 		pgd_clear(pgd);
 		return;
 	}
-	pmd = pmd_offset(pgd, address);
+	pmd = pmd_offset_map(pgd, address);
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
@@ -83,6 +83,7 @@ change_pmd_range(pgd_t *pgd, unsigned lo
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
+	pmd_unmap(pmd - 1);
 }
 
 static void
diff -prauN mm2-2.5.73-1/mm/mremap.c mm2-2.5.73-2/mm/mremap.c
--- mm2-2.5.73-1/mm/mremap.c	2003-06-28 03:09:58.000000000 -0700
+++ mm2-2.5.73-2/mm/mremap.c	2003-06-28 03:11:37.000000000 -0700
@@ -38,7 +38,7 @@ static pte_t *get_one_pte_map_nested(str
 		goto end;
 	}
 
-	pmd = pmd_offset(pgd, addr);
+	pmd = pmd_offset_map_nested(pgd, addr);
 	if (pmd_none(*pmd))
 		goto end;
 	if (pmd_bad(*pmd)) {
@@ -53,6 +53,7 @@ static pte_t *get_one_pte_map_nested(str
 		pte = NULL;
 	}
 end:
+	pmd_unmap_nested(pmd);
 	return pte;
 }
 
@@ -61,12 +62,15 @@ static inline int page_table_present(str
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+	int ret;
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none(*pgd))
 		return 0;
-	pmd = pmd_offset(pgd, addr);
-	return pmd_present(*pmd);
+	pmd = pmd_offset_map(pgd, addr);
+	ret = pmd_present(*pmd);
+	pmd_unmap(pmd);
+	return ret != 0;
 }
 #else
 #define page_table_present(mm, addr)	(1)
@@ -77,9 +81,10 @@ static inline pte_t *alloc_one_pte_map(s
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pmd = pmd_alloc(mm, pgd_offset(mm, addr), addr);
+	pmd = pmd_alloc_map(mm, pgd_offset(mm, addr), addr);
 	if (pmd)
-		pte = pte_alloc_map(mm, pmd, addr);
+		pte = pte_alloc_map(mm, &pmd, addr);
+	pmd_unmap(pmd);
 	return pte;
 }
 
diff -prauN mm2-2.5.73-1/mm/msync.c mm2-2.5.73-2/mm/msync.c
--- mm2-2.5.73-1/mm/msync.c	2003-06-22 11:32:42.000000000 -0700
+++ mm2-2.5.73-2/mm/msync.c	2003-06-28 03:11:37.000000000 -0700
@@ -82,7 +82,7 @@ static inline int filemap_sync_pmd_range
 		pgd_clear(pgd);
 		return 0;
 	}
-	pmd = pmd_offset(pgd, address);
+	pmd = pmd_offset_map(pgd, address);
 	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
 		end = (address & PGDIR_MASK) + PGDIR_SIZE;
 	error = 0;
@@ -91,6 +91,7 @@ static inline int filemap_sync_pmd_range
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
+	pmd_unmap(pmd - 1);
 	return error;
 }
 
diff -prauN mm2-2.5.73-1/mm/slab.c mm2-2.5.73-2/mm/slab.c
--- mm2-2.5.73-1/mm/slab.c	2003-06-28 03:09:58.000000000 -0700
+++ mm2-2.5.73-2/mm/slab.c	2003-06-28 03:27:00.000000000 -0700
@@ -2717,7 +2717,7 @@ void ptrinfo(unsigned long addr)
 			printk("No pgd.\n");
 			break;
 		}
-		pmd = pmd_offset(pgd, addr);
+		pmd = pmd_offset_kernel(pgd, addr);
 		if (pmd_none(*pmd)) {
 			printk("No pmd.\n");
 			break;
diff -prauN mm2-2.5.73-1/mm/swapfile.c mm2-2.5.73-2/mm/swapfile.c
--- mm2-2.5.73-1/mm/swapfile.c	2003-06-28 03:09:58.000000000 -0700
+++ mm2-2.5.73-2/mm/swapfile.c	2003-06-28 03:11:37.000000000 -0700
@@ -448,7 +448,7 @@ static int unuse_pgd(struct vm_area_stru
 		pgd_clear(dir);
 		return 0;
 	}
-	pmd = pmd_offset(dir, address);
+	pmd = pmd_offset_map(dir, address);
 	offset = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
@@ -463,6 +463,7 @@ static int unuse_pgd(struct vm_area_stru
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
+	pmd_unmap(pmd - 1);
 	return 0;
 }
 
diff -prauN mm2-2.5.73-1/mm/vmalloc.c mm2-2.5.73-2/mm/vmalloc.c
--- mm2-2.5.73-1/mm/vmalloc.c	2003-06-22 11:32:56.000000000 -0700
+++ mm2-2.5.73-2/mm/vmalloc.c	2003-06-28 03:11:37.000000000 -0700
@@ -70,7 +70,7 @@ static void unmap_area_pmd(pgd_t *dir, u
 		return;
 	}
 
-	pmd = pmd_offset(dir, address);
+	pmd = pmd_offset_kernel(dir, address);
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
@@ -159,7 +159,7 @@ int map_vm_area(struct vm_struct *area, 
 	dir = pgd_offset_k(address);
 	spin_lock(&init_mm.page_table_lock);
 	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
+		pmd_t *pmd = pmd_alloc_kernel(&init_mm, dir, address);
 		if (!pmd) {
 			err = -ENOMEM;
 			break;
