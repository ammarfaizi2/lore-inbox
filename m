Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290153AbSAQTCN>; Thu, 17 Jan 2002 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290152AbSAQTCG>; Thu, 17 Jan 2002 14:02:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24379 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290151AbSAQTBp>; Thu, 17 Jan 2002 14:01:45 -0500
Date: Thu, 17 Jan 2002 19:02:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020117190924.B4847@athlon.random>
Message-ID: <Pine.LNX.4.21.0201171833550.2407-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> On Thu, Jan 17, 2002 at 05:57:15PM +0000, Hugh Dickins wrote:
> 
> we need more than one serie, no way, or it can deadlock, the default
> serie is for pages, the other series are for pagetables.
> 
> > 3.  KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2 pte_offset2 all just
> >     for copy_page_range src?  Why distinguished from KM_SERIE_PAGETABLE?
> >     Often it will already be KM_SERIE_PAGETABLE.  I can imagine you might
> >     want an atomic at that point (holding spinlock), but I don't see what
> >     the PAGETABLE2 distinction gives you.
> 
> deadlock avoidance. It's the same reason as the mempool, you need tow
> mempool if you need two objects from the same task or it can deadlock
> (yes, it would be hard to deadlock it but possible).

Sorry, I'm still struggling: I can imagine deadlocks from having too
few kmaps altogether, and I can see how separating data from pagetables
protects pagetable code from bugs (missing kunmaps) in other code, but
I don't see how separating the three series make a crucial difference.

> in fork the pte_offset kmap could be an atomic one, but atomic are more
> costly with the invlpg I believe, to do it in a raw the 2 variant with a
> different serie should be faster for fork(2).

Yes, maybe, maybe not.

> > 4.  You've lifted the PAE restriction to LAST_PKMAP 512 in i386/highmem.h,
> >     and use pkmap_page_table as one long array in mm/highmem.c, but I
> >     don't see where you enforce the contiguity of page table pages in
> >     i386/mm/init.c.  (I do already have a patch for lifting the 1024,512
> >     kmaps limit, simplifying i386/mm/init.c, we've been using for months:
> >     I can update that from 2.4.9 if you'd like it.)
> 
> correct, currently it works because the bootmem tends to return
> physically contigous pages but it is not enforced and it may trigger
> with a weird e820 layout. If you've a patch very feel free to post it!!  :)
> thanks for the review.

Okay, I've attached the existing patch against 2.4.9 below.  It originated
from my Large PAGE_SIZE patch, where it became clear that the fixmaps are
appropriate for MMUPAGE_SIZE maps but the kmaps for PAGE_SIZE maps (later,
with Ben's work on Large PAGE_CACHE_SIZE, it became clear that actually
kmaps should be PAGE_CACHE_SIZE, but I've not added in that complication).

So the atomic kmaps are no longer done by fixmap.h, but come after the
vmallocs, before the regular kmaps, in highmem.h.  It also doesn't waste
so much virtual space either end of the vmalloc area.  The mm/init.c diff
looks a lot, mainly because the result is a lot simpler.  If it would
help you for me to update to a release of your choice, let me know
(perhaps the next aa, with your mods in).

> > 5.  Shouldn't mm/vmscan.c be in the patch?
> 
> can you elaborate?

swap_out_pmd() uses pte_offset() on user page tables,
so doesn't it need to pte_kunmap() afterwards?

Hugh

diff -urN 249/arch/i386/mm/init.c 249-morekmaps/arch/i386/mm/init.c
--- 249/arch/i386/mm/init.c	Sat Apr 21 00:15:20 2001
+++ 249-morekmaps/arch/i386/mm/init.c	Sat Jan 12 21:26:28 2002
@@ -36,10 +36,15 @@
 #include <asm/e820.h>
 #include <asm/apic.h>
 
-unsigned long highstart_pfn, highend_pfn;
 static unsigned long totalram_pages;
 static unsigned long totalhigh_pages;
 
+#ifdef CONFIG_HIGHMEM
+unsigned long highstart_pfn, highend_pfn;
+pgprot_t kmap_prot;
+pte_t *kmap_pte;
+#endif
+
 int do_check_pgt_cache(int low, int high)
 {
 	int freed = 0;
@@ -62,31 +67,6 @@
 	return freed;
 }
 
-/*
- * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
- * physical space so we can cache the place of the first one and move
- * around without checking the pgd every time.
- */
-
-#if CONFIG_HIGHMEM
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
-
-#define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
-
-	kmap_prot = PAGE_KERNEL;
-}
-#endif /* CONFIG_HIGHMEM */
-
 void show_mem(void)
 {
 	int i, total = 0, reserved = 0;
@@ -164,141 +144,92 @@
 	set_pte_phys(address, phys, flags);
 }
 
-static void __init fixrange_init (unsigned long start, unsigned long end, pgd_t *pgd_base)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i, j;
-	unsigned long vaddr;
-
-	vaddr = start;
-	i = __pgd_offset(vaddr);
-	j = __pmd_offset(vaddr);
-	pgd = pgd_base + i;
-
-	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
-#if CONFIG_X86_PAE
-		if (pgd_none(*pgd)) {
-			pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-			set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
-			if (pmd != pmd_offset(pgd, 0))
-				printk("PAE BUG #02!\n");
-		}
-		pmd = pmd_offset(pgd, vaddr);
-#else
-		pmd = (pmd_t *)pgd;
-#endif
-		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
-			if (pmd_none(*pmd)) {
-				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-				if (pte != pte_offset(pmd, 0))
-					BUG();
-			}
-			vaddr += PMD_SIZE;
-		}
-		j = 0;
-	}
-}
-
 static void __init pagetable_init (void)
 {
-	unsigned long vaddr, end;
-	pgd_t *pgd, *pgd_base;
-	int i, j, k;
+	unsigned long entry, end;
 	pmd_t *pmd;
-	pte_t *pte, *pte_base;
+	pte_t *pte;
+	int i;
 
 	/*
-	 * This can be zero as well - no problem, in that case we exit
-	 * the loops anyway due to the PTRS_PER_* conditions.
+	 * It's generally assumed that the user/kernel boundary
+	 * coincides with a pgd entry boundary (4MB, or 1GB if PAE):
+	 * the restriction could be lifted but why bother? just check.
 	 */
-	end = (unsigned long)__va(max_low_pfn*PAGE_SIZE);
-
-	pgd_base = swapper_pg_dir;
-#if CONFIG_X86_PAE
-	for (i = 0; i < PTRS_PER_PGD; i++)
-		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
+#if (__PAGE_OFFSET & (PGDIR_SIZE - 1))
+#error PAGE_OFFSET should be a multiple of PGDIR_SIZE!
 #endif
-	i = __pgd_offset(PAGE_OFFSET);
-	pgd = pgd_base + i;
 
-	for (; i < PTRS_PER_PGD; pgd++, i++) {
-		vaddr = i*PGDIR_SIZE;
-		if (end && (vaddr >= end))
-			break;
 #if CONFIG_X86_PAE
-		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
-#else
-		pmd = (pmd_t *)pgd;
+	/*
+	 * Usually only one page is needed here: if PAGE_OFFSET lowered,
+	 * maybe three pages: need not be contiguous, but might as well.
+	 */
+	pmd = (pmd_t *)alloc_bootmem_low_pages(KERNEL_PGD_PTRS*PAGE_SIZE);
+	for (i = 1; i < USER_PGD_PTRS; i++)
+		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
+	for (; i < PTRS_PER_PGD; i++, pmd += PTRS_PER_PMD)
+		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(pmd)));
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	swapper_pg_dir[0] = swapper_pg_dir[USER_PGD_PTRS];
 #endif
-		if (pmd != pmd_offset(pgd, 0))
-			BUG();
-		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
-			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
-			if (end && (vaddr >= end))
-				break;
-			if (cpu_has_pse) {
-				unsigned long __pe;
-
-				set_in_cr4(X86_CR4_PSE);
-				boot_cpu_data.wp_works_ok = 1;
-				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
-				/* Make it "global" too if supported */
-				if (cpu_has_pge) {
-					set_in_cr4(X86_CR4_PGE);
-					__pe += _PAGE_GLOBAL;
-				}
-				set_pmd(pmd, __pmd(__pe));
-				continue;
-			}
 
-			pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-
-			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
-				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
-				if (end && (vaddr >= end))
-					break;
-				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
-			}
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
-			if (pte_base != pte_offset(pmd, 0))
-				BUG();
+	/*
+	 * Map in all the low memory pages: using PSE if available,
+	 * or by allocating and populating page tables if no PSE.
+	 */
+	pmd = pmd_offset(pgd_offset_k(PAGE_OFFSET), PAGE_OFFSET);
+	end = max_low_pfn << PAGE_SHIFT;
 
+	if (cpu_has_pse) {
+		set_in_cr4(X86_CR4_PSE);
+		boot_cpu_data.wp_works_ok = 1;
+		entry = _KERNPG_TABLE | _PAGE_PSE;
+		/* Make it "global" too if supported */
+		if (cpu_has_pge) {
+			entry |= _PAGE_GLOBAL;
+			set_in_cr4(X86_CR4_PGE);
 		}
+		for (; entry < end; pmd++, entry += PTRS_PER_PTE*PAGE_SIZE)
+			set_pmd(pmd, __pmd(entry));
+	}
+	else for (entry = 0; entry < end; pmd++) {
+		pte = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+		for (i = 0; i < PTRS_PER_PTE; i++, pte++, entry += PAGE_SIZE) {
+			if (entry >= end)
+				break;
+			*pte = mk_pte_phys(entry, PAGE_KERNEL);
+		}
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte - i)));
 	}
 
 	/*
-	 * Fixed mappings, only the page table structure has to be
-	 * created - mappings will be set by set_fixmap():
-	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
-
-#if CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
+	 * Leave vmalloc() to create its own page tables as needed,
+	 * but create the page tables at top of virtual memory, to be
+	 * populated by kmap_atomic(), kmap_high() and set_fixmap().
+	 * kmap_high() assumes pkmap_page_table contiguous throughout.
 	 */
-	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
-
-	pgd = swapper_pg_dir + __pgd_offset(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
-	pkmap_page_table = pte;
-#endif
+	pmd = pmd_offset(pgd_offset_k(VMALLOC_END), VMALLOC_END);
+	i = (0UL - (VMALLOC_END & PMD_MASK)) >> PMD_SHIFT;
+	pte = (pte_t *)alloc_bootmem_low_pages(i*PAGE_SIZE);
+	for (; --i >= 0; pmd++, pte += PTRS_PER_PTE)
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_HIGHMEM
 	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
+	 * For asm/highmem.h kmap_atomic() and mm/highmem.c kmap_high().
 	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
+	kmap_prot = PAGE_KERNEL;
+	kmap_pte = pte_offset(pmd_offset(pgd_offset_k(
+		KMAP_BASE), KMAP_BASE), KMAP_BASE);
+	pkmap_page_table = kmap_pte +
+		((PKMAP_BASE - KMAP_BASE) >> PAGE_SHIFT);
 #endif
 }
 
@@ -344,24 +275,18 @@
 
 	__flush_tlb_all();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 	{
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-		unsigned int max_dma, high, low;
-
-		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-		low = max_low_pfn;
-		high = highend_pfn;
+		unsigned int max_dma_pfn;
 
-		if (low < max_dma)
-			zones_size[ZONE_DMA] = low;
+		max_dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+		if (max_low_pfn < max_dma_pfn)
+			zones_size[ZONE_DMA] = max_low_pfn;
 		else {
-			zones_size[ZONE_DMA] = max_dma;
-			zones_size[ZONE_NORMAL] = low - max_dma;
+			zones_size[ZONE_DMA] = max_dma_pfn;
+			zones_size[ZONE_NORMAL] = max_low_pfn - max_dma_pfn;
 #ifdef CONFIG_HIGHMEM
-			zones_size[ZONE_HIGHMEM] = high - low;
+			zones_size[ZONE_HIGHMEM] = highend_pfn - max_low_pfn;
 #endif
 		}
 		free_area_init(zones_size);
diff -urN 249/include/asm-i386/fixmap.h 249-morekmaps/include/asm-i386/fixmap.h
--- 249/include/asm-i386/fixmap.h	Wed Aug 15 22:21:11 2001
+++ 249-morekmaps/include/asm-i386/fixmap.h	Sat Jan 12 21:26:28 2002
@@ -17,10 +17,6 @@
 #include <linux/kernel.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
-#ifdef CONFIG_HIGHMEM
-#include <linux/threads.h>
-#include <asm/kmap_types.h>
-#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -40,13 +36,6 @@
  * TLB entries of such buffers will not be flushed across
  * task switches.
  */
-
-/*
- * on UP currently we will have no trace of the fixmap mechanizm,
- * no page table allocations, etc. This might change in the
- * future, say framebuffers for the console driver(s) could be
- * fix-mapped?
- */
 enum fixed_addresses {
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
@@ -60,10 +49,6 @@
 	FIX_CO_APIC,	/* Cobalt APIC Redirection Table */ 
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
-#endif
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
 	__end_of_fixed_addresses
 };
diff -urN 249/include/asm-i386/highmem.h 249-morekmaps/include/asm-i386/highmem.h
--- 249/include/asm-i386/highmem.h	Wed Aug 15 22:21:21 2001
+++ 249-morekmaps/include/asm-i386/highmem.h	Sat Jan 12 21:26:28 2002
@@ -23,11 +23,12 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/threads.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
 /* undef for production */
-#define HIGHMEM_DEBUG 1
+#define HIGHMEM_DEBUG 0
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
@@ -36,21 +37,14 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
- * Right now we initialize only a single pte table. It can be extended
- * easily, subsequent pte tables have to be allocated in one physical
- * chunk of RAM.
+ * Allow for somewhat less than 2048 kmaps, ending at FIXADDR_START.
+ * First the per-cpu atomic kmaps, then the persistent shared kmaps.
  */
-#define PKMAP_BASE (0xfe000000UL)
-#ifdef CONFIG_X86_PAE
-#define LAST_PKMAP 512
-#else
-#define LAST_PKMAP 1024
-#endif
-#define LAST_PKMAP_MASK (LAST_PKMAP-1)
-#define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
+#define KMAP_BASE	(0UL - (2048 << PAGE_SHIFT))
+#define PKMAP_BASE	(KMAP_BASE + (KM_TYPE_NR*NR_CPUS*PAGE_SIZE))
+#define LAST_PKMAP	((FIXADDR_START - PKMAP_BASE) >> PAGE_SHIFT)
+#define PKMAP_NR(virt)  (((virt) - PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
 extern void * FASTCALL(kmap_high(struct page *page));
@@ -58,8 +52,6 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -67,8 +59,6 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
@@ -77,24 +67,23 @@
 /*
  * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
  * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
+ * be used in IRQ contexts, so in some (very limited) cases we need it.
  */
 static inline void *kmap_atomic(struct page *page, enum km_type type)
 {
-	enum fixed_addresses idx;
 	unsigned long vaddr;
+	int idx;
 
 	if (page < highmem_start_page)
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	vaddr = KMAP_BASE + (idx << PAGE_SHIFT);
 #if HIGHMEM_DEBUG
-	if (!pte_none(*(kmap_pte-idx)))
+	if (!pte_none(*(kmap_pte+idx)))
 		BUG();
 #endif
-	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
+	set_pte(kmap_pte+idx, mk_pte(page, __pgprot(__PAGE_KERNEL)));
 	__flush_tlb_one(vaddr);
 
 	return (void*) vaddr;
@@ -103,20 +92,22 @@
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
 #if HIGHMEM_DEBUG
-	unsigned long vaddr = (unsigned long) kvaddr;
-	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
+	unsigned long vaddr;
+	int idx;
 
-	if (vaddr < FIXADDR_START) // FIXME
+	if (kvaddr < high_memory)
 		return;
 
-	if (vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx))
+	vaddr = (unsigned long) kvaddr;
+	idx = type + KM_TYPE_NR*smp_processor_id();
+	if (vaddr != KMAP_BASE + (idx << PAGE_SHIFT))
 		BUG();
 
 	/*
 	 * force other mappings to Oops if they'll try to access
 	 * this pte without first remap it
 	 */
-	pte_clear(kmap_pte-idx);
+	pte_clear(kmap_pte+idx);
 	__flush_tlb_one(vaddr);
 #endif
 }
diff -urN 249/include/asm-i386/pgtable.h 249-morekmaps/include/asm-i386/pgtable.h
--- 249/include/asm-i386/pgtable.h	Wed Aug 15 22:21:11 2001
+++ 249-morekmaps/include/asm-i386/pgtable.h	Sat Jan 12 21:26:28 2002
@@ -15,7 +15,6 @@
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #include <asm/fixmap.h>
-#include <linux/threads.h>
 
 #ifndef _I386_BITOPS_H
 #include <asm/bitops.h>
@@ -129,21 +128,16 @@
 
 
 #ifndef __ASSEMBLY__
-/* Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 8MB value just means that there will be a 8MB "hole" after the
- * physical memory until the kernel virtual memory starts.  That means that
- * any out-of-bounds memory accesses will hopefully be caught.
- * The vmalloc() routines leaves a hole of 4kB between each vmalloced
- * area for the same reason. ;)
+/*
+ * Maximize the virtual memory range available to vmalloc(),
+ * but start at a new page table since it cannot use a PSE entry.
  */
-#define VMALLOC_OFFSET	(8*1024*1024)
-#define VMALLOC_START	(((unsigned long) high_memory + 2*VMALLOC_OFFSET-1) & \
-						~(VMALLOC_OFFSET-1))
+#define VMALLOC_START	(((unsigned long) high_memory + ~PMD_MASK) & PMD_MASK)
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
 #if CONFIG_HIGHMEM
-# define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
+# define VMALLOC_END	KMAP_BASE
 #else
-# define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
+# define VMALLOC_END	FIXADDR_START
 #endif
 
 /*
diff -urN 249/mm/highmem.c 249-morekmaps/mm/highmem.c
--- 249/mm/highmem.c	Thu Aug 16 17:42:45 2001
+++ 249-morekmaps/mm/highmem.c	Sat Jan 12 21:26:28 2002
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -85,8 +86,8 @@
 	count = LAST_PKMAP;
 	/* Find an empty entry */
 	for (;;) {
-		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
-		if (!last_pkmap_nr) {
+		if (++last_pkmap_nr >= LAST_PKMAP) {
+			last_pkmap_nr = 0;
 			flush_all_zero_pkmaps();
 			count = LAST_PKMAP;
 		}
@@ -135,6 +136,9 @@
 	 *
 	 * We cannot call this from interrupts, as it may block
 	 */
+	if (in_interrupt())
+		BUG();
+
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
 	if (!vaddr)
@@ -151,6 +155,9 @@
 	unsigned long vaddr;
 	unsigned long nr;
 	int need_wakeup;
+
+	if (in_interrupt())
+		BUG();
 
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;

