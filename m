Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEEKjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 06:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTEEKjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 06:39:52 -0400
Received: from holomorphy.com ([66.224.33.161]:62189 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261780AbTEEKjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 06:39:46 -0400
Date: Mon, 5 May 2003 03:52:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [CFT] re-slabify i386 pgd's and pmd's
Message-ID: <20030505105213.GO8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original pgd/pmd slabification patches had a critical bug on
non-PAE where both modifications of pgd entries to remove pagetables
attached for non-PSE mappings back to a PSE state and modifications of
pgd entries to attach pagetables to bring PSE mappings into a non-PSE
state were not propagated to cached pgd's. PAE was immune to it owing
to the shared kernel pmd.

The following patch vs. 2.5.69 restores the slabification done to cache
preconstructed pagetables with the proper propagation of conversions
to and from PSE mappings to cached pgd's for the non-PAE case.

This is an optimization to reduce the bitblitting overhead for spawning
small tasks (for larger ones, bottom-level pagetable copies dominate)
primarily on non-PAE; the PAE code change is largely to remove #ifdefs
and to treat the two cases uniformly, though some positive but small
performance improvement has been observed for PAE in one of mbligh's
posts. The non-PAE performance improvement has been observed on a box
running a script-heavy end-user workload as a large long-term profile
hit count reduction for pgd_alloc() and relatives thereof.

I would very much appreciate outside testers. Even though I've been
able to verify this boots and runs properly and survives several cycles
of restarting X on my non-PAE Thinkpad T21, that environment has never
been able to reproduce the bug. Those with the proper graphics hardware
to prod the affected codepaths into action are the ones best suited to
verify proper functionality. There is also some locking introduced; if
some performance verification on non-PAE SMP i386 targets (my SMP
targets unfortunately all require PAE due to arch code dependencies)
that also have the proper hardware could be done, that would help
determine whether alternative locking schemes that competed against
the one shown here are preferable (in particular, the ticket-based
scheme mentioned in the comments).


-- wli

diff -prauN linux-2.5.69-1/arch/i386/mm/init.c pgd_ctor-2.5.69-1/arch/i386/mm/init.c
--- linux-2.5.69-1/arch/i386/mm/init.c	Sat May  3 18:36:22 2003
+++ pgd_ctor-2.5.69-1/arch/i386/mm/init.c	Mon May  5 01:07:51 2003
@@ -505,20 +505,30 @@
 #endif
 }
 
-#if CONFIG_X86_PAE
-struct kmem_cache_s *pae_pgd_cachep;
+kmem_cache_t *pgd_cache;
+kmem_cache_t *pmd_cache;
 
 void __init pgtable_cache_init(void)
 {
-        /*
-         * PAE pgds must be 16-byte aligned:
-         */
-        pae_pgd_cachep = kmem_cache_create("pae_pgd", 32, 0,
-                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
-        if (!pae_pgd_cachep)
-                panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
+	if (PTRS_PER_PMD > 1) {
+		pmd_cache = kmem_cache_create("pmd",
+					PTRS_PER_PMD*sizeof(pmd_t),
+					0,
+					SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+					pmd_ctor,
+					NULL);
+		if (!pmd_cache)
+			panic("pgtable_cache_init(): cannot create pmd cache");
+	}
+	pgd_cache = kmem_cache_create("pgd",
+				PTRS_PER_PGD*sizeof(pgd_t),
+				0,
+				SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+				pgd_ctor,
+				PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
+	if (!pgd_cache)
+		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
-#endif
 
 /*
  * This function cannot be __init, since exceptions don't work in that
diff -prauN linux-2.5.69-1/arch/i386/mm/pageattr.c pgd_ctor-2.5.69-1/arch/i386/mm/pageattr.c
--- linux-2.5.69-1/arch/i386/mm/pageattr.c	Sun Mar  2 18:13:32 2003
+++ pgd_ctor-2.5.69-1/arch/i386/mm/pageattr.c	Mon May  5 01:07:51 2003
@@ -58,19 +58,22 @@
 
 static void set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte) 
 { 
+	struct page *page;
+	unsigned long flags;
+
 	set_pte_atomic(kpte, pte); 	/* change init_mm */
-#ifndef CONFIG_X86_PAE
-	{
-		struct list_head *l;
-		spin_lock(&mmlist_lock);
-		list_for_each(l, &init_mm.mmlist) { 
-			struct mm_struct *mm = list_entry(l, struct mm_struct, mmlist);
-			pmd_t *pmd = pmd_offset(pgd_offset(mm, address), address);
-			set_pte_atomic((pte_t *)pmd, pte);
-		} 
-		spin_unlock(&mmlist_lock);
+	if (PTRS_PER_PMD > 1)
+		return;
+
+	spin_lock_irqsave(&pgd_lock, flags);
+	list_for_each_entry(page, &pgd_list, lru) {
+		pgd_t *pgd;
+		pmd_t *pmd;
+		pgd = (pgd_t *)page_address(page) + pgd_index(address);
+		pmd = pmd_offset(pgd, address);
+		set_pte_atomic((pte_t *)pmd, pte);
 	}
-#endif
+	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
 /* 
diff -prauN linux-2.5.69-1/arch/i386/mm/pgtable.c pgd_ctor-2.5.69-1/arch/i386/mm/pgtable.c
--- linux-2.5.69-1/arch/i386/mm/pgtable.c	Sat May  3 18:36:22 2003
+++ pgd_ctor-2.5.69-1/arch/i386/mm/pgtable.c	Mon May  5 02:02:33 2003
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/spinlock.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -151,61 +152,88 @@
 	return pte;
 }
 
-#if CONFIG_X86_PAE
+void pmd_ctor(void *pmd, kmem_cache_t *cache, unsigned long flags)
+{
+	memset(pmd, 0, PTRS_PER_PMD*sizeof(pmd_t));
+}
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
+/*
+ * List of all pgd's needed for non-PAE so it can invalidate entries
+ * in both cached and uncached pgd's; not needed for PAE since the
+ * kernel pmd is shared. If PAE were not to share the pmd a similar
+ * tactic would be needed. This is essentially codepath-based locking
+ * against pageattr.c; it is the unique case in which a valid change
+ * of kernel pagetables can't be lazily synchronized by vmalloc faults.
+ * vmalloc faults work because attached pagetables are never freed.
+ * If the locking proves to be non-performant, a ticketing scheme with
+ * checks at dup_mmap(), exec(), and other mmlist addition points
+ * could be used. The locking scheme was chosen on the basis of
+ * manfred's recommendations and having no core impact whatsoever.
+ * -- wli
+ */
+spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(pgd_list);
+
+void pgd_ctor(void *pgd, kmem_cache_t *cache, unsigned long unused)
 {
-	int i;
-	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
+	unsigned long flags;
 
-	if (pgd) {
-		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
-			unsigned long pmd = __get_free_page(GFP_KERNEL);
-			if (!pmd)
-				goto out_oom;
-			clear_page(pmd);
-			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
-		}
-		memcpy(pgd + USER_PTRS_PER_PGD,
+	if (PTRS_PER_PMD == 1)
+		spin_lock_irqsave(&pgd_lock, flags);
+
+	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-out_oom:
-	for (i--; i >= 0; i--)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
-	return NULL;
+
+	if (PTRS_PER_PMD > 1)
+		return;
+
+	list_add(&virt_to_page(pgd)->lru, &pgd_list);
+	spin_unlock_irqrestore(&pgd_lock, flags);
+	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 }
 
-void pgd_free(pgd_t *pgd)
+/* never called when PTRS_PER_PMD > 1 */
+void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
 {
-	int i;
+	unsigned long flags; /* can be called from interrupt context */
 
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
+	spin_lock_irqsave(&pgd_lock, flags);
+	list_del(&virt_to_page(pgd)->lru);
+	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-#else
-
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	int i;
+	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	if (PTRS_PER_PMD == 1 || !pgd)
+		return pgd;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+		if (!pmd)
+			goto out_oom;
+		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
 	}
 	return pgd;
+
+out_oom:
+	for (i--; i >= 0; i--)
+		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pgd_cache, pgd);
+	return NULL;
 }
 
 void pgd_free(pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
-}
-
-#endif /* CONFIG_X86_PAE */
+	int i;
 
+	/* in the PAE case user pgd entries are overwritten before usage */
+	if (PTRS_PER_PMD > 1)
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
+	kmem_cache_free(pgd_cache, pgd);
+}
diff -prauN linux-2.5.69-1/include/asm-i386/pgtable-3level.h pgd_ctor-2.5.69-1/include/asm-i386/pgtable-3level.h
--- linux-2.5.69-1/include/asm-i386/pgtable-3level.h	Sat May  3 18:36:22 2003
+++ pgd_ctor-2.5.69-1/include/asm-i386/pgtable-3level.h	Mon May  5 01:07:51 2003
@@ -123,6 +123,4 @@
 #define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
 #define PTE_FILE_MAX_BITS       32
 
-extern struct kmem_cache_s *pae_pgd_cachep;
-
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -prauN linux-2.5.69-1/include/asm-i386/pgtable.h pgd_ctor-2.5.69-1/include/asm-i386/pgtable.h
--- linux-2.5.69-1/include/asm-i386/pgtable.h	Thu May  1 19:15:41 2003
+++ pgd_ctor-2.5.69-1/include/asm-i386/pgtable.h	Mon May  5 01:07:51 2003
@@ -21,15 +21,27 @@
 #include <asm/bitops.h>
 #endif
 
-extern pgd_t swapper_pg_dir[1024];
-extern void paging_init(void);
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page[1024];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+extern unsigned long empty_zero_page[1024];
+extern pgd_t swapper_pg_dir[1024];
+extern kmem_cache_t *pgd_cache;
+extern kmem_cache_t *pmd_cache;
+extern spinlock_t pgd_lock;
+extern struct list_head pgd_list;
+
+void pmd_ctor(void *, kmem_cache_t *, unsigned long);
+void pgd_ctor(void *, kmem_cache_t *, unsigned long);
+void pgd_dtor(void *, kmem_cache_t *, unsigned long);
+void pgtable_cache_init(void);
+void paging_init(void);
 
 #endif /* !__ASSEMBLY__ */
 
@@ -41,20 +53,8 @@
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
-
-/*
- * Need to initialise the X86 PAE caches
- */
-extern void pgtable_cache_init(void);
-
 #else
 # include <asm/pgtable-2level.h>
-
-/*
- * No page table caches to initialise
- */
-#define pgtable_cache_init()	do { } while (0)
-
 #endif
 #endif
 
