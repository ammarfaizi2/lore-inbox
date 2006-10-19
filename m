Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946192AbWJSQfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946192AbWJSQfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946194AbWJSQfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:35:34 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:14048 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1946192AbWJSQfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:35:32 -0400
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/3] MIPS: Fix COW D-cache aliasing on fork
Date: Thu, 19 Oct 2006 17:35:48 +0100
Message-Id: <1161275750378-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161275748231-git-send-email-ralf@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Provide a custom copy_user_highpage() to deal with aliasing issues on
MIPS.  It uses kmap_coherent() to map an user page for kernel with same
color.  Rewrite copy_to_user_page() and copy_from_user_page() with the
new interfaces to avoid extra cache flushing.

The main part of this patch was originally written by Ralf Baechle;
Atushi Nemoto did the the debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/mm/init.c           |  213 ++++++++++++++++++++++++++++++++++++++++--
 arch/mips/mm/pgtable-32.c     |    7 -
 arch/mips/mm/pgtable-64.c     |   11 ++
 include/asm-mips/cacheflush.h |   19 ---
 include/asm-mips/fixmap.h     |   14 ++
 include/asm-mips/page.h       |   17 +--
 6 files changed, 242 insertions(+), 39 deletions(-)

Index: upstream-linus/arch/mips/mm/init.c
===================================================================
--- upstream-linus.orig/arch/mips/mm/init.c	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/arch/mips/mm/init.c	2006-10-12 18:51:18.000000000 +0100
@@ -30,11 +30,39 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
+#include <asm/kmap_types.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/fixmap.h>
+
+/* CP0 hazard avoidance. */
+#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
+				     "nop; nop; nop; nop; nop; nop;\n\t" \
+				     ".set reorder\n\t")
+
+/* Atomicity and interruptability */
+#ifdef CONFIG_MIPS_MT_SMTC
+
+#include <asm/mipsmtregs.h>
+
+#define ENTER_CRITICAL(flags) \
+	{ \
+	unsigned int mvpflags; \
+	local_irq_save(flags);\
+	mvpflags = dvpe()
+#define EXIT_CRITICAL(flags) \
+	evpe(mvpflags); \
+	local_irq_restore(flags); \
+	}
+#else
+
+#define ENTER_CRITICAL(flags) local_irq_save(flags)
+#define EXIT_CRITICAL(flags) local_irq_restore(flags)
+
+#endif /* CONFIG_MIPS_MT_SMTC */
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -80,13 +108,183 @@ unsigned long setup_zero_pages(void)
 	return 1UL << order;
 }
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
+/*
+ * These are almost like kmap_atomic / kunmap_atmic except they take an
+ * additional address argument as the hint.
+ */
 
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), (vaddr))
 
+#ifdef CONFIG_MIPS_MT_SMTC
+static pte_t *kmap_coherent_pte;
+static void __init kmap_coherent_init(void)
+{
+	unsigned long vaddr;
+
+	/* cache the first coherent kmap pte */
+	vaddr = __fix_to_virt(FIX_CMAP_BEGIN);
+	kmap_coherent_pte = kmap_get_fixmap_pte(vaddr);
+}
+#else
+static inline void kmap_coherent_init(void) {}
+#endif
+
+static inline void *kmap_coherent(struct page *page, unsigned long addr)
+{
+	enum fixed_addresses idx;
+	unsigned long vaddr, flags, entrylo;
+	unsigned long old_ctx;
+	pte_t pte;
+	unsigned int tlbidx;
+
+	inc_preempt_count();
+	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
+#ifdef CONFIG_MIPS_MT_SMTC
+	idx += FIX_N_COLOURS * smp_processor_id();
+#endif
+	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
+	pte = mk_pte(page, PAGE_KERNEL);
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+	entrylo = pte.pte_high;
+#else
+	entrylo = pte_val(pte) >> 6;
+#endif
+
+	ENTER_CRITICAL(flags);
+	old_ctx = read_c0_entryhi();
+	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
+	write_c0_entrylo0(entrylo);
+	write_c0_entrylo1(entrylo);
+#ifdef CONFIG_MIPS_MT_SMTC
+	set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
+	/* preload TLB instead of local_flush_tlb_one() */
+	mtc0_tlbw_hazard();
+	tlb_probe();
+	BARRIER;
+	tlbidx = read_c0_index();
+	mtc0_tlbw_hazard();
+	if (tlbidx < 0)
+		tlb_write_random();
+	else
+		tlb_write_indexed();
+#else
+	tlbidx = read_c0_wired();
+	write_c0_wired(tlbidx + 1);
+	write_c0_index(tlbidx);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+#endif
+	tlbw_use_hazard();
+	write_c0_entryhi(old_ctx);
+	EXIT_CRITICAL(flags);
+
+	return (void*) vaddr;
+}
+
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
+static inline void kunmap_coherent(struct page *page)
+{
+#ifndef CONFIG_MIPS_MT_SMTC
+	unsigned int wired;
+	unsigned long flags, old_ctx;
+
+	ENTER_CRITICAL(flags);
+	old_ctx = read_c0_entryhi();
+	wired = read_c0_wired() - 1;
+	write_c0_wired(wired);
+	write_c0_index(wired);
+	write_c0_entryhi(UNIQUE_ENTRYHI(wired));
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	write_c0_entryhi(old_ctx);
+	EXIT_CRITICAL(flags);
+#endif
+	dec_preempt_count();
+	preempt_check_resched();
+}
+
+void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
+{
+	void *vfrom, *vto;
+
+	vto = kmap_atomic(to, KM_USER1);
+	if (cpu_has_dc_aliases) {
+		vfrom = kmap_coherent(from, vaddr);
+		copy_page(vto, vfrom);
+		kunmap_coherent(from);
+	} else {
+		vfrom = kmap_atomic(from, KM_USER0);
+		copy_page(vto, vfrom);
+		kunmap_atomic(vfrom, KM_USER0);
+	}
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+	kunmap_atomic(vto, KM_USER1);
+	/* Make sure this page is cleared on other CPU's too before using it */
+	smp_wmb();
+}
+
+EXPORT_SYMBOL(copy_user_highpage);
+
+void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+	struct page *to)
+{
+	if (cpu_has_dc_aliases) {
+		struct page *from = virt_to_page(vfrom);
+		vfrom = kmap_coherent(from, vaddr);
+		copy_page(vto, vfrom);
+		kunmap_coherent(from);
+	} else
+		copy_page(vto, vfrom);
+	if (!cpu_has_ic_fills_f_dc ||
+	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+}
+
+EXPORT_SYMBOL(copy_user_page);
+
+void copy_to_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, void *dst, const void *src,
+	unsigned long len)
+{
+	if (cpu_has_dc_aliases) {
+		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+		memcpy(vto, src, len);
+		kunmap_coherent(page);
+	} else
+		memcpy(dst, src, len);
+	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+		flush_cache_page(vma, vaddr, page_to_pfn(page));
+}
+
+EXPORT_SYMBOL(copy_to_user_page);
+
+void copy_from_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, void *dst, const void *src,
+	unsigned long len)
+{
+	if (cpu_has_dc_aliases) {
+		void *vfrom =
+			kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+		memcpy(dst, vfrom, len);
+		kunmap_coherent(page);
+	} else
+		memcpy(dst, src, len);
+}
+
+EXPORT_SYMBOL(copy_from_user_page);
+
+
+#ifdef CONFIG_HIGHMEM
+pte_t *kmap_pte;
+pgprot_t kmap_prot;
+
 static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
@@ -97,11 +295,12 @@ static void __init kmap_init(void)
 
 	kmap_prot = PAGE_KERNEL;
 }
+#endif /* CONFIG_HIGHMEM */
 
-#ifdef CONFIG_32BIT
 void __init fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
+#if defined(CONFIG_HIGHMEM) || defined(CONFIG_MIPS_MT_SMTC)
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -122,7 +321,7 @@ void __init fixrange_init(unsigned long 
 			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
 					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-					set_pmd(pmd, __pmd(pte));
+					set_pmd(pmd, __pmd((unsigned long)pte));
 					if (pte != pte_offset_kernel(pmd, 0))
 						BUG();
 				}
@@ -132,9 +331,8 @@ void __init fixrange_init(unsigned long 
 		}
 		j = 0;
 	}
+#endif
 }
-#endif /* CONFIG_32BIT */
-#endif /* CONFIG_HIGHMEM */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 extern void pagetable_init(void);
@@ -175,6 +373,7 @@ void __init paging_init(void)
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
+	kmap_coherent_init();
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
Index: upstream-linus/arch/mips/mm/pgtable-32.c
===================================================================
--- upstream-linus.orig/arch/mips/mm/pgtable-32.c	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/arch/mips/mm/pgtable-32.c	2006-10-12 18:51:18.000000000 +0100
@@ -31,9 +31,10 @@ void pgd_init(unsigned long page)
 
 void __init pagetable_init(void)
 {
-#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
+	pgd_t *pgd_base;
+#ifdef CONFIG_HIGHMEM
+	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -44,7 +45,6 @@ void __init pagetable_init(void)
 	pgd_init((unsigned long)swapper_pg_dir
 		 + sizeof(pgd_t) * USER_PTRS_PER_PGD);
 
-#ifdef CONFIG_HIGHMEM
 	pgd_base = swapper_pg_dir;
 
 	/*
@@ -53,6 +53,7 @@ void __init pagetable_init(void)
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, 0, pgd_base);
 
+#ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
Index: upstream-linus/arch/mips/mm/pgtable-64.c
===================================================================
--- upstream-linus.orig/arch/mips/mm/pgtable-64.c	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/arch/mips/mm/pgtable-64.c	2006-10-12 18:51:18.000000000 +0100
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <asm/fixmap.h>
 #include <asm/pgtable.h>
 
 void pgd_init(unsigned long page)
@@ -52,7 +53,17 @@ void pmd_init(unsigned long addr, unsign
 
 void __init pagetable_init(void)
 {
+	unsigned long vaddr;
+	pgd_t *pgd_base;
+
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
+
+	pgd_base = swapper_pg_dir;
+	/*
+	 * Fixed mappings:
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	fixrange_init(vaddr, 0, pgd_base);
 }
Index: upstream-linus/include/asm-mips/cacheflush.h
===================================================================
--- upstream-linus.orig/include/asm-mips/cacheflush.h	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/include/asm-mips/cacheflush.h	2006-10-12 18:51:18.000000000 +0100
@@ -55,24 +55,13 @@ extern void (*flush_icache_range)(unsign
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
-static inline void copy_to_user_page(struct vm_area_struct *vma,
+extern void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
-	unsigned long len)
-{
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-	__flush_icache_page(vma, page);
-}
+	unsigned long len);
 
-static inline void copy_from_user_page(struct vm_area_struct *vma,
+extern void copy_from_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
-	unsigned long len)
-{
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-}
+	unsigned long len);
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
Index: upstream-linus/include/asm-mips/fixmap.h
===================================================================
--- upstream-linus.orig/include/asm-mips/fixmap.h	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/include/asm-mips/fixmap.h	2006-10-12 18:51:18.000000000 +0100
@@ -45,8 +45,16 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+#define FIX_N_COLOURS 8
+	FIX_CMAP_BEGIN,
+#ifdef CONFIG_MIPS_MT_SMTC
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS),
+#else
+	FIX_CMAP_END = FIX_CMAP_BEGIN + FIX_N_COLOURS,
+#endif
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
 	__end_of_fixed_addresses
@@ -70,9 +78,9 @@ extern void __set_fixmap (enum fixed_add
  * at the top of mem..
  */
 #if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
-#define FIXADDR_TOP	(0xff000000UL - 0x2000)
+#define FIXADDR_TOP	((unsigned long)(long)(int)(0xff000000 - 0x20000))
 #else
-#define FIXADDR_TOP	(0xffffe000UL)
+#define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
 #endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
Index: upstream-linus/include/asm-mips/page.h
===================================================================
--- upstream-linus.orig/include/asm-mips/page.h	2006-10-12 18:51:03.000000000 +0100
+++ upstream-linus/include/asm-mips/page.h	2006-10-12 18:51:18.000000000 +0100
@@ -34,8 +34,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/cpu-features.h>
-
 extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);
 
@@ -59,16 +57,13 @@ static inline void clear_user_page(void 
 		flush_data_cache_page((unsigned long)addr);
 }
 
-static inline void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to)
-{
-	extern void (*flush_data_cache_page)(unsigned long addr);
+extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+	struct page *to);
+struct vm_area_struct;
+extern void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
 
-	copy_page(vto, vfrom);
-	if (!cpu_has_ic_fills_f_dc ||
-	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
-		flush_data_cache_page((unsigned long)vto);
-}
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 /*
  * These are used to make use of C type-checking..
