Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbTFMVkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTFMVkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:40:02 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41135 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265542AbTFMVg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:36:29 -0400
Subject: [RFC] recursive pagetables for x86 PAE
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Content-Type: multipart/mixed; boundary="=-RBh9yQbpKMMLJ5sDMaXO"
Organization: 
Message-Id: <1055540875.3531.2581.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jun 2003 14:47:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RBh9yQbpKMMLJ5sDMaXO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When you have lots of tasks, the pagetables start taking up lots of
lowmem.  We have the ability to push the PTE pages into highmem, but
that exacts a penalty from the atomic kmaps which, depending on
workload, can be a 10-15% performance hit.

The following patches implement something which we like to call UKVA. 
It's a Kernel Virtual Area which is private to a process, just like
Userspace.  You can put any process-local data that you want in the
area.  But, for now, I just put PTE pages in there.

It has some really nice attributes, which aren't taken full advantage of
in this patch.  For one, since the PTE pages are laid out virtually in
line, it's really easy to figure out where the PTE that maps a
particular address is sitting.  The PTE that maps 0x00000000 is always
virtually at *FIRST_UKVA_PTE, just as the PTE that maps 0xFFFFFFFF is
always mapped at *LAST_UKVA_PTE.  This gives implicit behavior doing
things in hardware that we usually have software constructs like
follow_page() do instead.

Since only the current process's PTEs are mapped into the area, you
still need to use kmap_atomic() to get to another process's pagetables. 
That is why I started passing mm around everywhere.

If anyone wants to play with it, be my guest.  But, don't go applying it
to anything important.  It certainly won't compile or boot without
highpte and 64GB support.

I've done all of the work on top of 2.5.70-mjb1.  There are 3 patches on
which this is built:
reslabify-pmd-pgd-2.5.70-mjb1-0.patch
sepmd-2.5.70-mjb1-0.patch
banana_split-2.5.70-mjb1-1.patch

Here's a differential profile.  Higher numbers mean worse with UKVA,
lower numbers mean better.  I'm not sure why the total is so much
bigger.  I think my profiling script screwed up, and forgot to stop the
profiler at the right time.  Everything else looks OK.

158930 total
154829 default_idle
  1523 pmd_free_ukva
  1190 do_anonymous_page
   896 pmd_alloc_ukva
   754 free_hot_cold_page
   616 .text.lock.namei
   535 buffered_rmqueue
   454 __d_lookup
   ...
  -238 fd_install
  -394 .text.lock.libfs
  -445 filemap_nopage
  -506 pte_alloc_map
  -696 kmap_atomic_to_page
 -3747 kmap_atomic

Notice that there are a lot fewer kmap_atomic() calls, and
kmap_atomic_to_page() is called less, because UKVA is used instead.  The
increase in pmd_free_ukva, pmd_alloc_ukva, and free_hot_cold_page are
all due to the extra 4 pages per process that must be allocated. 
do_anonymous_page is probably due to the extra TLB overhead because of
disabling lazy tlb mode (which I plan to fix). pmd_free_ukva() and
pmd_alloc_ukva() probably doesn't need to be clearing the pages anyway. 
-- 
Dave Hansen
haveblue@us.ibm.com

--=-RBh9yQbpKMMLJ5sDMaXO
Content-Disposition: attachment; filename=reslabify-pmd-pgd-2.5.70-mjb1-0.patch
Content-Type: text/x-patch; name=reslabify-pmd-pgd-2.5.70-mjb1-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -ur linux-2.5.70-mjb1/arch/i386/mm/init.c linux-2.5.70-mjb1-reslab/arch/i386/mm/init.c
--- linux-2.5.70-mjb1/arch/i386/mm/init.c	Thu Jun 12 19:53:45 2003
+++ linux-2.5.70-mjb1-reslab/arch/i386/mm/init.c	Thu Jun 12 20:03:41 2003
@@ -511,20 +511,30 @@
 #endif
 }
 
-#ifdef CONFIG_X86_PAE
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
diff -ur linux-2.5.70-mjb1/arch/i386/mm/pageattr.c linux-2.5.70-mjb1-reslab/arch/i386/mm/pageattr.c
--- linux-2.5.70-mjb1/arch/i386/mm/pageattr.c	Thu Jun 12 19:50:34 2003
+++ linux-2.5.70-mjb1-reslab/arch/i386/mm/pageattr.c	Thu Jun 12 20:03:41 2003
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
diff -ur linux-2.5.70-mjb1/arch/i386/mm/pgtable.c linux-2.5.70-mjb1-reslab/arch/i386/mm/pgtable.c
--- linux-2.5.70-mjb1/arch/i386/mm/pgtable.c	Thu Jun 12 19:50:34 2003
+++ linux-2.5.70-mjb1-reslab/arch/i386/mm/pgtable.c	Thu Jun 12 20:03:41 2003
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
 
-#ifdef CONFIG_X86_PAE
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
diff -ur linux-2.5.70-mjb1/include/asm-i386/pgtable-3level.h linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable-3level.h
--- linux-2.5.70-mjb1/include/asm-i386/pgtable-3level.h	Thu Jun 12 19:50:25 2003
+++ linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable-3level.h	Thu Jun 12 20:03:41 2003
@@ -123,6 +123,4 @@
 #define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
 #define PTE_FILE_MAX_BITS       32
 
-extern struct kmem_cache_s *pae_pgd_cachep;
-
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -ur linux-2.5.70-mjb1/include/asm-i386/pgtable.h linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable.h
--- linux-2.5.70-mjb1/include/asm-i386/pgtable.h	Thu Jun 12 19:53:45 2003
+++ linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable.h	Thu Jun 12 20:03:41 2003
@@ -22,15 +22,27 @@
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
 
@@ -42,20 +54,8 @@
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
 

--=-RBh9yQbpKMMLJ5sDMaXO
Content-Disposition: attachment; filename=sepmd-2.5.70-mjb1-0.patch
Content-Type: text/x-patch; name=sepmd-2.5.70-mjb1-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Only in linux-2.5.70-mjb1-reslab/: .confiug
diff -urp linux-2.5.70-mjb1-reslab/arch/i386/mm/init.c linux-2.5.70-mjb1-sepmd/arch/i386/mm/init.c
--- linux-2.5.70-mjb1-reslab/arch/i386/mm/init.c	Thu Jun 12 20:03:41 2003
+++ linux-2.5.70-mjb1-sepmd/arch/i386/mm/init.c	Thu Jun 12 20:45:25 2003
@@ -513,6 +513,7 @@ void __init mem_init(void)
 
 kmem_cache_t *pgd_cache;
 kmem_cache_t *pmd_cache;
+kmem_cache_t *kernel_pmd_cache;
 
 void __init pgtable_cache_init(void)
 {
@@ -525,6 +526,15 @@ void __init pgtable_cache_init(void)
 					NULL);
 		if (!pmd_cache)
 			panic("pgtable_cache_init(): cannot create pmd cache");
+
+		kernel_pmd_cache = kmem_cache_create("pae_kernel_pmd",
+						(PTRS_PER_PMD*sizeof(pmd_t))*KERNEL_PGD_PTRS,
+						0,
+						SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+						kernel_pmd_ctor,
+						NULL);
+		if (!kernel_pmd_cache)
+			panic("pgtable_cache_init(): cannot create kernel pmd cache");
 	}
 	pgd_cache = kmem_cache_create("pgd",
 				PTRS_PER_PGD*sizeof(pgd_t),
diff -urp linux-2.5.70-mjb1-reslab/arch/i386/mm/pgtable.c linux-2.5.70-mjb1-sepmd/arch/i386/mm/pgtable.c
--- linux-2.5.70-mjb1-reslab/arch/i386/mm/pgtable.c	Thu Jun 12 20:03:41 2003
+++ linux-2.5.70-mjb1-sepmd/arch/i386/mm/pgtable.c	Thu Jun 12 21:35:47 2003
@@ -157,6 +157,15 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
 	memset(pmd, 0, PTRS_PER_PMD*sizeof(pmd_t));
 }
 
+void kernel_pmd_ctor(void *__pmd, kmem_cache_t *kernel_pmd_cache, unsigned long flags)
+{
+	int i;
+	for (i=USER_PGD_PTRS; i<PTRS_PER_PGD; i++) {
+		pmd_t *kern_pmd = (pmd_t *)pgd_page(swapper_pg_dir[i]); 
+		memcpy(__pmd+PAGE_SIZE*(i-USER_PGD_PTRS), kern_pmd, PAGE_SIZE);
+	}
+}
+
 /*
  * List of all pgd's needed for non-PAE so it can invalidate entries
  * in both cached and uncached pgd's; not needed for PAE since the
@@ -211,17 +220,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (PTRS_PER_PMD == 1 || !pgd)
 		return pgd;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+	for (i = 0; i < PTRS_PER_PGD; ++i) {
+		pmd_t *pmd = NULL;
+		
+		if (i == USER_PTRS_PER_PGD)
+			pmd = kmem_cache_alloc(kernel_pmd_cache, GFP_KERNEL);
+		else if (i < USER_PTRS_PER_PGD)
+			pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+		else
+			pmd += PTRS_PER_PMD;
+
 		if (!pmd)
 			goto out_oom;
+		/* bleh.  that's ugly, bad wli */
 		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
 	}
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; i--)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	for (i--; i >= 0; i--) {
+		pmd_t *pmd = pmd_offset(&pgd[i],0);
+		kmem_cache_free(pmd_cache, pmd);
+	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -231,9 +251,19 @@ void pgd_free(pgd_t *pgd)
 	int i;
 
 	/* in the PAE case user pgd entries are overwritten before usage */
-	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	if (PTRS_PER_PMD > 1) {
+		for (i = 0; i < PTRS_PER_PGD; i++) {
+			pmd_t *pmd_to_free = pmd_offset(&pgd[i],0);
+
+			set_pgd(&pgd[i], __pgd(0));
+			
+			if (i < USER_PGD_PTRS) {
+				kmem_cache_free(pmd_cache, pmd_to_free);
+			} else if (i == USER_PGD_PTRS) {
+				kmem_cache_free(kernel_pmd_cache, pmd_to_free);
+			}
+		}
+	}
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
diff -urp linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable.h linux-2.5.70-mjb1-sepmd/include/asm-i386/pgtable.h
--- linux-2.5.70-mjb1-reslab/include/asm-i386/pgtable.h	Thu Jun 12 20:03:41 2003
+++ linux-2.5.70-mjb1-sepmd/include/asm-i386/pgtable.h	Thu Jun 12 21:36:51 2003
@@ -35,9 +35,11 @@ extern unsigned long empty_zero_page[102
 extern pgd_t swapper_pg_dir[1024];
 extern kmem_cache_t *pgd_cache;
 extern kmem_cache_t *pmd_cache;
+extern kmem_cache_t *kernel_pmd_cache;
 extern spinlock_t pgd_lock;
 extern struct list_head pgd_list;
 
+void kernel_pmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_dtor(void *, kmem_cache_t *, unsigned long);

--=-RBh9yQbpKMMLJ5sDMaXO
Content-Disposition: attachment; filename=banana_split-2.5.70-mjb1-1.patch
Content-Type: text/x-patch; name=banana_split-2.5.70-mjb1-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urp linux-2.5.70-mjb1-sepmd/arch/i386/Kconfig linux-2.5.70-mjb1-banana_split/arch/i386/Kconfig
--- linux-2.5.70-mjb1-sepmd/arch/i386/Kconfig	Thu Jun 12 20:41:02 2003
+++ linux-2.5.70-mjb1-banana_split/arch/i386/Kconfig	Thu Jun 12 21:38:47 2003
@@ -697,7 +697,6 @@ choice
 	
 config	05GB
 	bool "3.5 GB"
-	depends on !HIGHMEM64G
 	
 config	1GB
 	bool "3 GB"
diff -urp linux-2.5.70-mjb1-sepmd/arch/i386/mm/init.c linux-2.5.70-mjb1-banana_split/arch/i386/mm/init.c
--- linux-2.5.70-mjb1-sepmd/arch/i386/mm/init.c	Thu Jun 12 20:45:25 2003
+++ linux-2.5.70-mjb1-banana_split/arch/i386/mm/init.c	Thu Jun 12 21:40:03 2003
@@ -123,6 +123,24 @@ static void __init page_table_range_init
 	}
 }
 
+
+/*
+ * Abstract out using large pages when mapping KVA, or the SMP identity
+ * mapping
+ */
+void pmd_map_pfn_range(pmd_t* pmd_entry, unsigned long pfn, unsigned long max_pfn)
+{
+	int pte_ofs;
+	/* Map with big pages if possible, otherwise create normal page tables. */
+	if (cpu_has_pse) {
+		set_pmd(pmd_entry, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+		pfn += PTRS_PER_PTE;
+	} else {
+		pte_t* pte = one_page_table_init(pmd_entry);
+		for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_pfn; pte++, pfn++, pte_ofs++)
+			set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+	}
+}
 /*
  * This maps the physical memory to kernel virtual address space, a total 
  * of max_low_pfn pages, by creating page tables starting from address 
@@ -133,8 +151,7 @@ static void __init kernel_physical_mappi
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
-	int pgd_idx, pmd_idx, pte_ofs;
+	int pgd_idx, pmd_idx;
 
 	pgd_idx = pgd_index(PAGE_OFFSET);
 	pgd = pgd_base + pgd_idx;
@@ -144,21 +161,48 @@ static void __init kernel_physical_mappi
 		pmd = one_md_table_init(pgd);
 		if (pfn >= max_low_pfn)
 			continue;
-		for (pmd_idx = 0; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
-			/* Map with big pages if possible, otherwise create normal page tables. */
-			if (cpu_has_pse) {
-				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
-				pfn += PTRS_PER_PTE;
-			} else {
-				pte = one_page_table_init(pmd);
-
-				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
-					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
-			}
+	
+		/* beware of starting KVA in the middle of a pmd. */
+		if( pgd_idx == pgd_index(PAGE_OFFSET) ) {
+			pmd_idx = pmd_index(PAGE_OFFSET);
+			pmd = &pmd[pmd_idx];
+		} else
+			pmd_idx = 0;
+
+		for (; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
+			pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+			pfn += PTRS_PER_PTE; 
 		}
 	}	
 }
 
+/*
+ * Add low memory identity-mappings - SMP needs it when
+ * starting up on an AP from real-mode. In the non-PAE
+ * case we already have these mappings through head.S.
+ * All user-space mappings are explicitly cleared after
+ * SMP startup in zap_low_mappings().
+ */
+static void __init low_physical_mapping_init(pgd_t *pgd_base)
+{
+#if CONFIG_X86_PAE
+	unsigned long pfn = 0;
+	int pmd_ofs = 0;
+	pmd_t *pmd = one_md_table_init(pgd_base);
+
+	if(!cpu_has_pse) {
+		printk("PAE enabled, but no support for PSE (large pages)!\n");
+		printk("this is likely to waste some RAM.");
+	}
+	
+	for (; pmd_ofs < PTRS_PER_PMD && pfn <= max_low_pfn; pmd++, pmd_ofs++) { 
+		pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+		pfn += PTRS_PER_PTE;
+	}		
+#endif
+}
+
+
 static inline int page_kills_ppro(unsigned long pagenr)
 {
 	if (pagenr >= 0x70000 && pagenr <= 0x7003F)
@@ -225,7 +269,7 @@ void __init permanent_kmaps_init(pgd_t *
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;	
+	pkmap_page_table = pte;
 }
 
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
@@ -290,6 +334,7 @@ static void __init pagetable_init (void)
 	}
 
 	kernel_physical_mapping_init(pgd_base);
+	low_physical_mapping_init(pgd_base);
 	remap_numa_kva();
 
 	/*
@@ -298,19 +343,7 @@ static void __init pagetable_init (void)
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	page_table_range_init(vaddr, 0, pgd_base);
-
 	permanent_kmaps_init(pgd_base);
-
-#ifdef CONFIG_X86_PAE
-	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
-	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
-#endif
 }
 
 void zap_low_mappings (void)
@@ -322,7 +355,7 @@ void zap_low_mappings (void)
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+	for (i = 0; i < FIRST_KERNEL_PGD_PTR; i++)
 #ifdef CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -urp linux-2.5.70-mjb1-sepmd/arch/i386/mm/pgtable.c linux-2.5.70-mjb1-banana_split/arch/i386/mm/pgtable.c
--- linux-2.5.70-mjb1-sepmd/arch/i386/mm/pgtable.c	Thu Jun 12 21:35:47 2003
+++ linux-2.5.70-mjb1-banana_split/arch/i386/mm/pgtable.c	Thu Jun 12 22:04:57 2003
@@ -159,10 +159,23 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
 
 void kernel_pmd_ctor(void *__pmd, kmem_cache_t *kernel_pmd_cache, unsigned long flags)
 {
+	pmd_t *pmd = __pmd;
 	int i;
-	for (i=USER_PGD_PTRS; i<PTRS_PER_PGD; i++) {
-		pmd_t *kern_pmd = (pmd_t *)pgd_page(swapper_pg_dir[i]); 
-		memcpy(__pmd+PAGE_SIZE*(i-USER_PGD_PTRS), kern_pmd, PAGE_SIZE);
+
+	/* 
+	 * you only need to memset the portion which isn't used by
+	 * the kernel
+	 */
+	clear_page(__pmd);
+
+	for (i=FIRST_KERNEL_PGD_PTR; i<PTRS_PER_PGD; i++, pmd+=PTRS_PER_PMD) {
+		pmd_t *kern_pmd = (pmd_t *)pgd_page(swapper_pg_dir[i]);
+		int start_index = USER_PTRS_PER_PMD(i);
+		pmd_t *dst_pmd = &pmd[start_index];
+		pmd_t *src_pmd = &kern_pmd[start_index];
+		int num_pmds = PTRS_PER_PMD-USER_PTRS_PER_PMD(i);
+		
+		memcpy(dst_pmd, src_pmd, num_pmds*sizeof(pmd_t));
 	}
 }
 
@@ -223,9 +236,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	for (i = 0; i < PTRS_PER_PGD; ++i) {
 		pmd_t *pmd = NULL;
 		
-		if (i == USER_PTRS_PER_PGD)
+		if (i == FIRST_KERNEL_PGD_PTR)
 			pmd = kmem_cache_alloc(kernel_pmd_cache, GFP_KERNEL);
-		else if (i < USER_PTRS_PER_PGD)
+		else if (i < FIRST_KERNEL_PGD_PTR)
 			pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		else
 			pmd += PTRS_PER_PMD;
@@ -257,11 +270,10 @@ void pgd_free(pgd_t *pgd)
 
 			set_pgd(&pgd[i], __pgd(0));
 			
-			if (i < USER_PGD_PTRS) {
+			if (i < FIRST_KERNEL_PGD_PTR)
 				kmem_cache_free(pmd_cache, pmd_to_free);
-			} else if (i == USER_PGD_PTRS) {
+			else if (i == FIRST_KERNEL_PGD_PTR)
 				kmem_cache_free(kernel_pmd_cache, pmd_to_free);
-			}
 		}
 	}
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-alpha/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-alpha/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-alpha/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-alpha/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -39,6 +39,7 @@
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Number of pointers that fit on a page:  this will go away. */
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-arm/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-arm/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-arm/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-arm/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -45,6 +45,7 @@ extern void __pgd_error(const char *file
 
 #define FIRST_USER_PGD_NR	1
 #define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /*
  * The table below defines the page protection levels that we insert into our
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-cris/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-cris/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-cris/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-cris/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -202,6 +202,7 @@ static inline void flush_tlb(void) 
  */
 
 #define USER_PTRS_PER_PGD       (TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 /*
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-i386/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-i386/pgtable.h	Thu Jun 12 21:36:51 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -66,7 +66,22 @@ void paging_init(void);
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define __USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define FIRST_KERNEL_PGD_PTR	(__USER_PTRS_PER_PGD)
+#define PARTIAL_PGD	(TASK_SIZE > __USER_PTRS_PER_PGD*PGDIR_SIZE ? 1 : 0)
+#define PARTIAL_PMD	((TASK_SIZE % PGDIR_SIZE)/PMD_SIZE)
+#define USER_PTRS_PER_PGD	(PARTIAL_PGD + __USER_PTRS_PER_PGD)
+#ifndef __ASSEMBLY__
+static inline int USER_PTRS_PER_PMD(int pgd_index) {
+	if (pgd_index < __USER_PTRS_PER_PGD)
+		return PTRS_PER_PMD;
+	else if (PARTIAL_PMD && (pgd_index == __USER_PTRS_PER_PGD))
+		return (PTRS_PER_PMD-PARTIAL_PMD);
+	else
+		return 0;
+}
+#endif
+
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-ia64/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-ia64/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-ia64/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-ia64/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -90,6 +90,7 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(__IA64_UL(1) << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /*
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-m68k/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-m68k/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-m68k/pgtable.h	Thu Jun 12 20:40:52 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-m68k/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -58,6 +58,7 @@
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Virtual address region for use by kernel_map() */
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-mips/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-mips/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-mips/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-mips/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -95,6 +95,7 @@ extern int add_temporary_entry(unsigned 
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define VMALLOC_START     KSEG2
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-mips64/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-mips64/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-mips64/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-mips64/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -124,6 +124,7 @@ extern void (*_flush_cache_l1)(void);
 #define PTRS_PER_PMD	1024
 #define PTRS_PER_PTE	512
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define KPTBL_PAGE_ORDER  2
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-parisc/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-parisc/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-parisc/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-parisc/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -81,6 +81,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD    (1UL << (PAGE_SHIFT - PT_NLEVELS))
 #define USER_PTRS_PER_PGD       PTRS_PER_PGD
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /* Definitions for 2nd level */
 #define pgtable_cache_init()	do { } while (0)
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-ppc/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-ppc/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-ppc/pgtable.h	Thu Jun 12 20:40:52 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-ppc/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -83,6 +83,7 @@ extern unsigned long ioremap_bot, iorema
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-ppc64/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-ppc64/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-ppc64/pgtable.h	Thu Jun 12 20:40:52 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-ppc64/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -36,6 +36,7 @@
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 #define USER_PTRS_PER_PGD	(1024)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-sh/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-sh/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-sh/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-sh/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -101,6 +101,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PTE_PHYS_MASK	0x1ffff000
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-sparc/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-sparc/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-sparc/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-sparc/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -125,6 +125,7 @@ BTFIXUPDEF_INT(page_kernel)
 #define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
 #define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
 #define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PAGE_NONE      __pgprot(BTFIXUP_INT(page_none))
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-sparc64/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-sparc64/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-sparc64/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-sparc64/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -93,6 +93,7 @@
 /* Kernel has a separate 44bit address space. */
 #define USER_PTRS_PER_PGD	((const int)(test_thread_flag(TIF_32BIT)) ? \
 				 (1) : (PTRS_PER_PGD))
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define pte_ERROR(e)	__builtin_trap()
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-um/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-um/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-um/pgtable.h	Thu Jun 12 20:40:53 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-um/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -40,6 +40,7 @@ extern unsigned long *empty_zero_page;
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 #define pte_ERROR(e) \
diff -urp linux-2.5.70-mjb1-sepmd/include/asm-x86_64/pgtable.h linux-2.5.70-mjb1-banana_split/include/asm-x86_64/pgtable.h
--- linux-2.5.70-mjb1-sepmd/include/asm-x86_64/pgtable.h	Thu Jun 12 20:40:52 2003
+++ linux-2.5.70-mjb1-banana_split/include/asm-x86_64/pgtable.h	Thu Jun 12 21:38:47 2003
@@ -112,6 +112,7 @@ static inline void set_pml4(pml4_t *dst,
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -urp linux-2.5.70-mjb1-sepmd/mm/memory.c linux-2.5.70-mjb1-banana_split/mm/memory.c
--- linux-2.5.70-mjb1-sepmd/mm/memory.c	Thu Jun 12 20:41:04 2003
+++ linux-2.5.70-mjb1-banana_split/mm/memory.c	Thu Jun 12 21:38:47 2003
@@ -100,9 +100,10 @@ static inline void free_one_pmd(struct m
 	pte_free_tlb(tlb, page);
 }
 
-static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
+static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * pgd, unsigned long pgdi)
 {
 	pmd_t * pmd, * md, * emd;
+	pgd_t *dir = pgd + pgdi;
 
 	if (pgd_none(*dir))
 		return;
@@ -126,7 +127,7 @@ static inline void free_one_pgd(struct m
 	 * found at 0x80000000 onwards.  The loop below compiles instead
 	 * to be terminated by unsigned address comparison using "jb".
 	 */
-	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++)
+	for (md = pmd, emd = pmd + USER_PTRS_PER_PMD(pgdi); md < emd; md++)
 		free_one_pmd(tlb,md);
 	pmd_free_tlb(tlb, pmd);
 }
@@ -140,11 +141,11 @@ static inline void free_one_pgd(struct m
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr)
 {
 	pgd_t * page_dir = tlb->mm->pgd;
-
-	page_dir += first;
+	int index = first;
+	
 	do {
-		free_one_pgd(tlb, page_dir);
-		page_dir++;
+		free_one_pgd(tlb, page_dir, index);
+		index++;
 	} while (--nr);
 }
 

--=-RBh9yQbpKMMLJ5sDMaXO
Content-Disposition: attachment; filename=ukva-2.5.70-mjb1-1.patch
Content-Type: text/x-patch; name=ukva-2.5.70-mjb1-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -rup linux-2.5.70-mjb1-banana_split/arch/i386/kernel/vm86.c linux-2.5.70-mjb1-ukva/arch/i386/kernel/vm86.c
--- linux-2.5.70-mjb1-banana_split/arch/i386/kernel/vm86.c	Thu Jun 12 21:37:20 2003
+++ linux-2.5.70-mjb1-ukva/arch/i386/kernel/vm86.c	Fri Jun 13 09:07:47 2003
@@ -152,7 +152,7 @@ static void mark_screen_rdonly(struct ta
 		pmd_clear(pmd);
 		goto out;
 	}
-	pte = mapped = pte_offset_map(pmd, 0xA0000);
+	pte = mapped = pte_offset_map(tsk->mm, pmd, 0xA0000);
 	for (i = 0; i < 32; i++) {
 		if (pte_present(*pte))
 			set_pte(pte, pte_wrprotect(*pte));
diff -rup linux-2.5.70-mjb1-banana_split/arch/i386/mm/init.c linux-2.5.70-mjb1-ukva/arch/i386/mm/init.c
--- linux-2.5.70-mjb1-banana_split/arch/i386/mm/init.c	Thu Jun 12 21:40:03 2003
+++ linux-2.5.70-mjb1-ukva/arch/i386/mm/init.c	Fri Jun 13 10:01:42 2003
@@ -304,6 +304,13 @@ extern void set_highmem_pages_init(int);
 
 unsigned long __PAGE_KERNEL = _PAGE_KERNEL;
 
+/*
+ * The UKVA pages are per-process, so the need to be flushed
+ * just like user pages.  (flushed by __tlb_flush() instead of
+ * just __tlb_flush_all())
+ */
+unsigned long __PAGE_UKVA = _PAGE_KERNEL;
+
 #ifndef CONFIG_DISCONTIGMEM
 #define remap_numa_kva() do {} while (0)
 #else
diff -rup linux-2.5.70-mjb1-banana_split/arch/i386/mm/pgtable.c linux-2.5.70-mjb1-ukva/arch/i386/mm/pgtable.c
--- linux-2.5.70-mjb1-banana_split/arch/i386/mm/pgtable.c	Thu Jun 12 22:04:57 2003
+++ linux-2.5.70-mjb1-ukva/arch/i386/mm/pgtable.c	Fri Jun 13 09:44:20 2003
@@ -225,6 +225,66 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
+/*
+ * There are 4 pages allocated, just for mapping the UKVA PTE area.
+ * They provide the virutal space necessary for mapping the 8MB
+ * of other PTEs
+ * 
+ * Of these pages, one is special, because it contains entries
+ * for itself and the other 3 pages.  The UKVA PTE area is aligned
+ * on an 8MB boundary, so that there stays only 1 of these special 
+ * pages, and the area doesn't get spread out over more than 1 PMD.  
+ * This reduces the number of pages which must be kmapped here.
+ */
+void pmd_alloc_ukva(pmd_t *pmd)
+{
+	/* the self-referential pte page */
+	struct page* recursive_pte_page;
+	pmd_t *ukva_pmd = pmd + pmd_index(UKVA_PTE_START);
+	pte_t *pte_page_kmap;
+	pte_t *pte;
+	int j;
+	
+	recursive_pte_page = alloc_pages(GFP_ATOMIC, 0);
+	
+	/* 
+	 * the recursive page must be kmapped because entries need
+	 * to be made in it, and the page tables that we're working
+	 * on aren't active yet. 
+	 */
+	pte_page_kmap = kmap_atomic(recursive_pte_page, KM_PTE0);
+	clear_page(pte_page_kmap);
+	
+	pte = &pte_page_kmap[pte_index(__FIRST_UKVA_PTE)];
+	for (j = 0; j < PTRS_PER_PGD; ++j, ukva_pmd++, pte++) {
+		struct page* ukva_page;
+		if (j != pgd_index(UKVA_PTE_START)) {
+			ukva_page = alloc_pages(GFP_ATOMIC, 0);
+			clear_highpage(ukva_page);
+		} else 
+			ukva_page = recursive_pte_page;
+		set_pte(pte, mk_pte(ukva_page, PAGE_KERNEL_UKVA));
+		pmd_populate(NULL, ukva_pmd, ukva_page);
+	}
+	
+	kunmap_atomic(pte_page_kmap, KM_PTE0);
+}
+
+/*
+ * for simplicity, the UKVA area is aligned so that
+ * it will all be mapped inside a single PMD.
+ */
+void pmd_free_ukva(pmd_t *pmd)
+{
+	pmd_t *ukva_pmd = pmd + pmd_index(UKVA_PTE_START);
+	int j;
+	for (j = 0; j < 4; j++) {
+		clear_highpage(pmd_page(ukva_pmd[j]));
+		__free_pages(pmd_page(ukva_pmd[j]), 0);
+		pmd_clear(&ukva_pmd[j]);
+	}
+}
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
@@ -247,6 +307,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 			goto out_oom;
 		/* bleh.  that's ugly, bad wli */
 		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
+
+		if (pgd_index(UKVA_PTE_START) == i )
+			pmd_alloc_ukva(pmd);
 	}
 	return pgd;
 
@@ -274,6 +337,9 @@ void pgd_free(pgd_t *pgd)
 				kmem_cache_free(pmd_cache, pmd_to_free);
 			else if (i == FIRST_KERNEL_PGD_PTR)
 				kmem_cache_free(kernel_pmd_cache, pmd_to_free);
+
+			if (i == pgd_index(UKVA_PTE_START))
+				pmd_free_ukva(pmd_to_free);
 		}
 	}
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
diff -rup linux-2.5.70-mjb1-banana_split/include/asm-generic/rmap.h linux-2.5.70-mjb1-ukva/include/asm-generic/rmap.h
--- linux-2.5.70-mjb1-banana_split/include/asm-generic/rmap.h	Thu Jun 12 21:37:18 2003
+++ linux-2.5.70-mjb1-ukva/include/asm-generic/rmap.h	Fri Jun 13 09:07:47 2003
@@ -47,16 +47,36 @@ static inline void pgtable_remove_rmap(s
 	dec_page_state(nr_page_table_pages);
 }
 
+static inline int is_ukva_pte(pte_t *pte) 
+{
+	unsigned long pteaddr = (unsigned long)pte;
+	if (pteaddr >= UKVA_PTE_START &&
+	    pteaddr <= UKVA_PTE_END ) 
+		return 1;
+	return 0;
+}
+
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
 {
-	struct page * page = kmap_atomic_to_page(ptep);
+	struct page * page;
+		
+	if (is_ukva_pte(ptep))
+		page = pte_page(*ptep);
+	else
+		page = kmap_atomic_to_page(ptep);
 	return (struct mm_struct *) page->mapping;
 }
 
 static inline unsigned long ptep_to_address(pte_t * ptep)
 {
-	struct page * page = kmap_atomic_to_page(ptep);
+	struct page * page;
 	unsigned long low_bits;
+	
+	if (is_ukva_pte(ptep))
+		page = pte_page(*ptep);
+	else
+		page = kmap_atomic_to_page(ptep);
+
 	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
 	return page->index + low_bits;
 }
@@ -64,8 +84,14 @@ static inline unsigned long ptep_to_addr
 #ifdef CONFIG_HIGHPTE
 static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
 {
+	unsigned long pfn;
 	pte_addr_t paddr;
-	paddr = ((pte_addr_t)page_to_pfn(kmap_atomic_to_page(ptep))) << PAGE_SHIFT;
+	if (is_ukva_pte(ptep)) {
+		pfn = pte_pfn(*ukva_pte_offset(ptep));
+	} else {
+		pfn = page_to_pfn(kmap_atomic_to_page(ptep));
+	}
+	paddr = (pte_addr_t)(pfn << PAGE_SHIFT);
 	return paddr + (pte_addr_t)((unsigned long)ptep & ~PAGE_MASK);
 }
 #else
diff -rup linux-2.5.70-mjb1-banana_split/include/asm-i386/mmu_context.h linux-2.5.70-mjb1-ukva/include/asm-i386/mmu_context.h
--- linux-2.5.70-mjb1-banana_split/include/asm-i386/mmu_context.h	Thu Jun 12 21:37:18 2003
+++ linux-2.5.70-mjb1-ukva/include/asm-i386/mmu_context.h	Fri Jun 13 09:07:47 2003
@@ -24,7 +24,7 @@ static inline void enter_lazy_tlb(struct
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {
-	if (likely(prev != next)) {
+	if (1 || likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
diff -rup linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable-3level.h linux-2.5.70-mjb1-ukva/include/asm-i386/pgtable-3level.h
--- linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable-3level.h	Thu Jun 12 21:37:19 2003
+++ linux-2.5.70-mjb1-ukva/include/asm-i386/pgtable-3level.h	Fri Jun 13 09:07:47 2003
@@ -53,6 +53,7 @@ static inline void set_pte(pte_t *ptep, 
 		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
 #define set_pmd(pmdptr,pmdval) \
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+
 #define set_pgd(pgdptr,pgdval) \
 		set_64bit((unsigned long long *)(pgdptr),pgd_val(pgdval))
 
diff -rup linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable.h linux-2.5.70-mjb1-ukva/include/asm-i386/pgtable.h
--- linux-2.5.70-mjb1-banana_split/include/asm-i386/pgtable.h	Thu Jun 12 21:38:47 2003
+++ linux-2.5.70-mjb1-ukva/include/asm-i386/pgtable.h	Fri Jun 13 10:36:08 2003
@@ -105,7 +105,56 @@ static inline int USER_PTRS_PER_PMD(int 
 						~(VMALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
 #ifdef CONFIG_HIGHMEM
-# define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
+# define UKVA_END	(PKMAP_BASE-2*PAGE_SIZE)
+# define UKVA_START 	(UKVA_END-(1<<20)*16)
+
+/* 
+ * there must be virtual space for enough ptes to map each
+ * of the pagetable pages in the system.
+ *
+ * the physical space which will underly this virutal space will
+ * be allocated later
+ *
+ * The start of this area is aligned on a 8MB boundary, which guarantees the
+ * UKVA PTE pages themselves will be able to be mapped by only 4 ptes.  These
+ * 4 ptes will be guaranteed to be mapped by a single pte.  This also 
+ * guarantees that a single PMD page will map it, too.  This makes PMD 
+ * allocation easier, and keeps us from kmapping as much during init.
+ */
+# define UKVA_PTE_SIZE	(PTRS_PER_PGD*PTRS_PER_PMD*PTRS_PER_PTE*sizeof(pte_t))
+# define UKVA_PTE_MASK	(~(UKVA_PTE_SIZE-1))
+
+/* 
+ * the virtual address of the first and last UKVA PTE.  Note that the END is 
+ * not the boundary of the space, but the virtual address of the last one.
+ *
+ * the area between UKVA_START and UKVA_PTE_START is available for other use
+ */
+# define UKVA_PTE_START	((UKVA_START&UKVA_PTE_MASK)+UKVA_PTE_SIZE)
+# define UKVA_PTE_END	(UKVA_PTE_START+UKVA_PTE_SIZE-sizeof(pte_t))
+
+/*
+ * These provide shortcuts to the ptes which map the UKVA PTE area itself
+ */
+# define FIRST_UKVA_PTE (ukva_pte_offset((void *)UKVA_PTE_START))
+# define LAST_UKVA_PTE  (ukva_pte_offset((void *)UKVA_PTE_END))
+# define __FIRST_UKVA_PTE ((unsigned long)FIRST_UKVA_PTE)
+# define __LAST_UKVA_PTE  ((unsigned long)LAST_UKVA_PTE)
+
+static inline unsigned long __ukva_pte_index(void *address)
+{
+	return ((unsigned long)address)>>PAGE_SHIFT;
+}
+
+/*
+ * ukva_pte_offset(address) calculates the UKVA virtual address of the pte
+ * which controls "address".  This doesn't guarantee that there will be 
+ * anything there, it just gives the address where it _would_ be.
+ */
+
+#define ukva_pte_offset(address) &((pte_t *)UKVA_PTE_START)[__ukva_pte_index(address)]
+	
+# define VMALLOC_END	(UKVA_START-2*PAGE_SIZE)
 #else
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
@@ -158,6 +207,7 @@ extern unsigned long __PAGE_KERNEL;
 #define __PAGE_KERNEL_LARGE	(__PAGE_KERNEL | _PAGE_PSE)
 
 #define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
+#define PAGE_KERNEL_UKVA	__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
@@ -306,11 +356,34 @@ static inline pte_t pte_modify(pte_t pte
 	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
 
 #if defined(CONFIG_HIGHPTE)
-#define pte_offset_map(dir, address) \
+extern int ukva_hits;
+extern int ukva_misses[];
+/*
+ * There are times where current->mm->pgd is not actually resident in 
+ * cr3.  This is during times when we're in a transitionary state,
+ * or doing some lazy flushing.  I need to figure out what's going on,
+ * but until then, take the cowardly route and fall back to kmap.
+ */
+#define funny_mm() (current->mm != current->active_mm)
+#define pte_offset_map(__mm, dir, address) \
+	(\
+	 	(!funny_mm() && (__mm) == current->mm) ? \
+			ukva_pte_offset((void*)address) \
+	 		:\
+			__pte_offset_map(dir,address)\
+	)
+#define __pte_offset_map(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
 #define pte_offset_map_nested(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
-#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
+#define pte_unmap(pte) do { 					\
+	if( (unsigned long)pte >= UKVA_PTE_START &&		\
+  	    (unsigned long)pte <= UKVA_PTE_END ){		\
+		/* it was a ukva pte, no need to unmap */	\
+	} 							\
+	else							\
+		kunmap_atomic(pte, KM_PTE0);			\
+} while (0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else
 #define pte_offset_map(dir, address) \
diff -rup linux-2.5.70-mjb1-banana_split/include/linux/mm.h linux-2.5.70-mjb1-ukva/include/linux/mm.h
--- linux-2.5.70-mjb1-banana_split/include/linux/mm.h	Thu Jun 12 21:37:18 2003
+++ linux-2.5.70-mjb1-ukva/include/linux/mm.h	Fri Jun 13 09:07:47 2003
@@ -414,7 +414,7 @@ void zap_page_range(struct vm_area_struc
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted);
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+void unmap_page_range(struct mm_struct *mm, struct mmu_gather *tlb, struct vm_area_struct *vma,
 			unsigned long address, unsigned long size);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
@@ -426,6 +426,7 @@ extern int vmtruncate(struct inode * ino
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(__pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address, int shouldwarn));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
diff -rup linux-2.5.70-mjb1-banana_split/mm/memory.c linux-2.5.70-mjb1-ukva/mm/memory.c
--- linux-2.5.70-mjb1-banana_split/mm/memory.c	Thu Jun 12 21:38:47 2003
+++ linux-2.5.70-mjb1-ukva/mm/memory.c	Fri Jun 13 10:43:07 2003
@@ -149,11 +149,51 @@ void clear_page_tables(struct mmu_gather
 	} while (--nr);
 }
 
+/*
+ * Go find the pte which controls "ukva_pte".  Point it to "new"
+ *
+ * This is effectively the fallback from UKVA to kmap, in the case
+ * that a pte allocation was requested for an mm which isn't resident
+ */
+u64 ukva_map_pte_other(struct mm_struct *mm, struct page* new, pte_t *ukva_pte)
+{
+	pgd_t *ukva_pgd;
+	pmd_t *ukva_pmd;
+	pte_t *ukva_mapped_pte;
+	unsigned long ukva_pte_addr = (unsigned long)ukva_pte;
+	u64 ret;
+	
+	ukva_pgd = pgd_offset(mm, ukva_pte_addr);
+	ukva_pmd = pmd_offset(ukva_pgd, ukva_pte_addr);
+	/* 
+	 * use __pte_offset_map(), so that this will never use the UKVA
+	 * addresses. 
+	 */
+	ukva_mapped_pte = __pte_offset_map(ukva_pmd, ukva_pte_addr);
+	set_pte(ukva_mapped_pte, mk_pte(new, PAGE_KERNEL_UKVA));
+	ret = pte_val(*ukva_mapped_pte);
+	pte_unmap(ukva_mapped_pte);
+	return ret;
+}
+
 pte_t * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
+
+	/* 
+	 * what is the address of the ukva pte which controls "address"? 
+	 * In other words, where will the newly allocated PTE reside
+	 * virtually?
+	 */
+	pte_t *ukva_pte_vaddr = ukva_pte_offset((void*)address);
+	/* 
+	 * what is the address of the pte that controls _that_ address? 
+	 * This will have to be set before there is anything mapped into the 
+	 * ukva_pte_vaddr address.
+	 */
+	pte_t *ukva_pte_controller = ukva_pte_offset(ukva_pte_vaddr);
+
 	if (!pmd_present(*pmd)) {
 		struct page *new;
-
 		spin_unlock(&mm->page_table_lock);
 		new = pte_alloc_one(mm, address);
 		spin_lock(&mm->page_table_lock);
@@ -168,11 +208,32 @@ pte_t * pte_alloc_map(struct mm_struct *
 			pte_free(new);
 			goto out;
 		}
+
+		/*
+		 * If we're running in the mm's context, we can take a shortcut
+		 * to the ukva entries, because they're already mapped
+		 */
+		if ( !funny_mm() && mm == current->mm )
+			set_pte(ukva_pte_controller, mk_pte(new, __pgprot(_PAGE_KERNEL)));
+		else {
+			/*
+			 *  If mm isn't the current one, we need to map the 
+			 *  pte falling back to kmap()s.  In addition
+			 *  to the kmap()ing, this function updates
+			 *  mm's pagetables to have valid ukva information
+			 *  for when that mm is active
+			 */
+			ukva_map_pte_other(mm, new, ukva_pte_vaddr);
+		}
 		pgtable_add_rmap(new, mm, address);
 		pmd_populate(mm, pmd, new);
-	}
+	} 
+
 out:
-	return pte_offset_map(pmd, address);
+	if (!funny_mm() && mm == current->mm)
+		return ukva_pte_vaddr;
+	else
+		return __pte_offset_map(pmd, address);
 }
 
 pte_t * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
@@ -272,6 +333,7 @@ skip_copy_pmd_range:	address = (address 
 			if (pmd_bad(*src_pmd)) {
 				pmd_ERROR(*src_pmd);
 				pmd_clear(src_pmd);
+				BUG();
 skip_copy_pte_range:
 				address = (address + PMD_SIZE) & PMD_MASK;
 				if (address >= end)
@@ -282,8 +344,25 @@ skip_copy_pte_range:
 			dst_pte = pte_alloc_map(dst, dst_pmd, address);
 			if (!dst_pte)
 				goto nomem;
-			spin_lock(&src->page_table_lock);	
+			spin_lock(&src->page_table_lock);
+			/*
+			 * copy_page_range() is only called by dup_mmap(), with
+			 * current->mm as its src mm.
+			 *
+			 * This used to be pte_offset_map_nested(), but because of
+			 * ukva, and the fact that src is always current->mm, we
+			 * can take the standard ukva shortcut here.
+			 *
+			 * if src ever becomes !current->mm, this will freak out
+			 * because pte_offset_map will fall back to kmapping(),
+			 * and collide with the above pte_alloc_map().  You could
+			 * always start passing a flag around to pte_alloc_map(), and
+			 * get it to switch to the nested kmap slot for this, if
+			 * you ever hit the bug, which will never happen :P
+			 */
+			BUG_ON(src != current->mm);
 			src_pte = pte_offset_map_nested(src_pmd, address);
+			/* src_pte = pte_offset_map(src, src_pmd, address); */
 			do {
 				pte_t pte = *src_pte;
 				struct page *page;
@@ -356,7 +435,7 @@ skip_copy_pte_range:
 				if (!pte_chain)
 					goto nomem;
 				spin_lock(&src->page_table_lock);
-				dst_pte = pte_offset_map(dst_pmd, address);
+				dst_pte = pte_offset_map(dst, dst_pmd, address);
 				src_pte = pte_offset_map_nested(src_pmd,
 								address);
 cont_copy_pte_range_noset:
@@ -389,7 +468,7 @@ nomem:
 }
 
 static void
-zap_pte_range(struct mmu_gather *tlb, pmd_t * pmd,
+zap_pte_range(struct mm_struct *mm, struct mmu_gather *tlb, pmd_t * pmd,
 		unsigned long address, unsigned long size)
 {
 	unsigned long offset;
@@ -402,7 +481,7 @@ zap_pte_range(struct mmu_gather *tlb, pm
 		pmd_clear(pmd);
 		return;
 	}
-	ptep = pte_offset_map(pmd, address);
+	ptep = pte_offset_map(mm, pmd, address);
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
@@ -439,7 +518,7 @@ zap_pte_range(struct mmu_gather *tlb, pm
 }
 
 static void
-zap_pmd_range(struct mmu_gather *tlb, pgd_t * dir,
+zap_pmd_range(struct mm_struct *mm, struct mmu_gather *tlb, pgd_t * dir,
 		unsigned long address, unsigned long size)
 {
 	pmd_t * pmd;
@@ -457,13 +536,13 @@ zap_pmd_range(struct mmu_gather *tlb, pg
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address);
+		zap_pte_range(mm, tlb, pmd, address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address < end);
 }
 
-void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+void unmap_page_range(struct mm_struct *mm, struct mmu_gather *tlb, struct vm_area_struct *vma,
 			unsigned long address, unsigned long end)
 {
 	pgd_t * dir;
@@ -478,7 +557,7 @@ void unmap_page_range(struct mmu_gather 
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address);
+		zap_pmd_range(mm, tlb, dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -572,7 +651,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 				tlb_start_valid = 1;
 			}
 
-			unmap_page_range(*tlbp, vma, start, start + block);
+			unmap_page_range(mm, *tlbp, vma, start, start + block);
 			start += block;
 			zap_bytes -= block;
 			if ((long)zap_bytes > 0)
@@ -650,7 +729,7 @@ follow_page(struct mm_struct *mm, unsign
 	if (pmd_bad(*pmd))
 		goto out;
 
-	ptep = pte_offset_map(pmd, address);
+	ptep = pte_offset_map(mm, pmd, address);
 	if (!ptep)
 		goto out;
 
@@ -814,7 +893,7 @@ static void zeromap_pte_range(pte_t * pt
 	} while (address && (address < end));
 }
 
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
+static int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
                                     unsigned long size, pgprot_t prot)
 {
 	unsigned long end;
@@ -891,7 +970,7 @@ static inline void remap_pte_range(pte_t
 	} while (address && (address < end));
 }
 
-static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
+static int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
 	unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long base, end;
@@ -1045,7 +1124,7 @@ static int do_wp_page(struct mm_struct *
 	 * Re-check the pte - we dropped the lock
 	 */
 	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
+	page_table = pte_offset_map(mm, pmd, address);
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
@@ -1203,7 +1282,7 @@ static int do_swap_page(struct mm_struct
 			 * we released the page table lock.
 			 */
 			spin_lock(&mm->page_table_lock);
-			page_table = pte_offset_map(pmd, address);
+			page_table = pte_offset_map(mm, pmd, address);
 			if (pte_same(*page_table, orig_pte))
 				ret = VM_FAULT_OOM;
 			else
@@ -1231,7 +1310,7 @@ static int do_swap_page(struct mm_struct
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
+	page_table = pte_offset_map(mm, pmd, address);
 	if (!pte_same(*page_table, orig_pte)) {
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
@@ -1290,7 +1369,7 @@ do_anonymous_page(struct mm_struct *mm, 
 		if (!pte_chain)
 			goto no_mem;
 		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+		page_table = pte_offset_map(mm, pmd, addr);
 	}
 		
 	/* Read-only mapping of ZERO_PAGE. */
@@ -1308,7 +1387,7 @@ do_anonymous_page(struct mm_struct *mm, 
 		clear_user_highpage(page, addr);
 
 		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+		page_table = pte_offset_map(mm, pmd, addr);
 
 		if (!pte_none(*page_table)) {
 			pte_unmap(page_table);
@@ -1402,7 +1481,7 @@ do_no_page(struct mm_struct *mm, struct 
 	}
 
 	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
+	page_table = pte_offset_map(mm, pmd, address);
 
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
@@ -1631,7 +1710,7 @@ struct page * vmalloc_to_page(void * vma
 		pmd = pmd_offset(pgd, addr);
 		if (!pmd_none(*pmd)) {
 			preempt_disable();
-			ptep = pte_offset_map(pmd, addr);
+			ptep = pte_offset_map(&init_mm, pmd, addr);
 			pte = *ptep;
 			if (pte_present(pte))
 				page = pte_page(pte);
diff -rup linux-2.5.70-mjb1-banana_split/mm/mprotect.c linux-2.5.70-mjb1-ukva/mm/mprotect.c
--- linux-2.5.70-mjb1-banana_split/mm/mprotect.c	Thu Jun 12 21:37:33 2003
+++ linux-2.5.70-mjb1-ukva/mm/mprotect.c	Fri Jun 13 10:34:54 2003
@@ -24,8 +24,10 @@
 #include <asm/tlbflush.h>
 
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pte_range(struct mm_struct *mm,
+		pmd_t *pmd, unsigned long address,
+		unsigned long size, pgprot_t newprot,
+		unsigned long realaddress)
 {
 	pte_t * pte;
 	unsigned long end;
@@ -37,7 +39,11 @@ change_pte_range(pmd_t *pmd, unsigned lo
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset_map(pmd, address);
+	/*
+	 * there is only one path leading here, and it always uses the
+	 * current process's pagetables, so we can use ukva here
+	 */
+	pte = ukva_pte_offset((void*)realaddress);
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -60,12 +66,14 @@ change_pte_range(pmd_t *pmd, unsigned lo
 }
 
 static inline void
-change_pmd_range(pgd_t *pgd, unsigned long address,
+change_pmd_range(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
 		unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
 	unsigned long end;
+	unsigned long realaddress = address;
 
+	
 	if (pgd_none(*pgd))
 		return;
 	if (pgd_bad(*pgd)) {
@@ -79,7 +87,7 @@ change_pmd_range(pgd_t *pgd, unsigned lo
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
+		change_pte_range(mm, pmd, address, end - address, newprot, realaddress);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -98,7 +106,7 @@ change_protection(struct vm_area_struct 
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
 	do {
-		change_pmd_range(dir, start, end - start, newprot);
+		change_pmd_range(current->mm, dir, start, end - start, newprot);
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
diff -rup linux-2.5.70-mjb1-banana_split/mm/msync.c linux-2.5.70-mjb1-ukva/mm/msync.c
--- linux-2.5.70-mjb1-banana_split/mm/msync.c	Thu Jun 12 21:37:33 2003
+++ linux-2.5.70-mjb1-ukva/mm/msync.c	Fri Jun 13 09:07:47 2003
@@ -53,7 +53,7 @@ static int filemap_sync_pte_range(pmd_t 
 		pmd_clear(pmd);
 		return 0;
 	}
-	pte = pte_offset_map(pmd, address);
+	pte = __pte_offset_map(pmd, address);
 	if ((address & PMD_MASK) != (end & PMD_MASK))
 		end = (address & PMD_MASK) + PMD_SIZE;
 	error = 0;
diff -rup linux-2.5.70-mjb1-banana_split/mm/rmap.c linux-2.5.70-mjb1-ukva/mm/rmap.c
--- linux-2.5.70-mjb1-banana_split/mm/rmap.c	Thu Jun 12 21:37:33 2003
+++ linux-2.5.70-mjb1-ukva/mm/rmap.c	Fri Jun 13 12:14:07 2003
@@ -138,7 +138,7 @@ find_pte(struct vm_area_struct *vma, str
 	if (!pmd_present(*pmd))
 		goto out;
 
-	pte = pte_offset_map(pmd, address);
+	pte = __pte_offset_map(pmd, address);
 	if (!pte_present(*pte))
 		goto out_unmap;
 
diff -rup linux-2.5.70-mjb1-banana_split/mm/swapfile.c linux-2.5.70-mjb1-ukva/mm/swapfile.c
--- linux-2.5.70-mjb1-banana_split/mm/swapfile.c	Thu Jun 12 21:37:33 2003
+++ linux-2.5.70-mjb1-ukva/mm/swapfile.c	Fri Jun 13 09:07:47 2003
@@ -406,7 +406,7 @@ static int unuse_pmd(struct vm_area_stru
 		pmd_clear(dir);
 		return 0;
 	}
-	pte = pte_offset_map(dir, address);
+	pte = __pte_offset_map(dir, address);
 	offset += address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;

--=-RBh9yQbpKMMLJ5sDMaXO--

