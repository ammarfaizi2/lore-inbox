Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317397AbSGZORy>; Fri, 26 Jul 2002 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGZORy>; Fri, 26 Jul 2002 10:17:54 -0400
Received: from mail.gmx.de ([213.165.64.20]:42308 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317397AbSGZORo>;
	Fri, 26 Jul 2002 10:17:44 -0400
Date: Fri, 26 Jul 2002 17:18:07 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386/mm cleanup
Message-ID: <20020726141807.GA25975@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.478, 2002-07-26 16:23:54+03:00, da-x@gmx.net
  i385 mm cleanup:
    + cleanup init.c and split into pgtable.c
    + split declaration of _text, _etext outside into sections.h


 arch/i386/mm/Makefile             |    2 
 arch/i386/mm/init.c               |  532 +++++++++++++++-----------------------
 arch/i386/mm/pgtable.c            |  188 +++++++++++++
 include/asm-generic/sections.h    |   11 
 include/asm-i386/pgtable-3level.h |    2 
 include/asm-i386/sections.h       |    7 
 6 files changed, 421 insertions(+), 321 deletions(-)


diff -Nru a/arch/i386/mm/Makefile b/arch/i386/mm/Makefile
--- a/arch/i386/mm/Makefile	Fri Jul 26 16:37:35 2002
+++ b/arch/i386/mm/Makefile	Fri Jul 26 16:37:35 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := mm.o
 
-obj-y	 := init.o fault.o ioremap.o extable.o pageattr.o
+obj-y	 := init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
 export-objs := pageattr.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Fri Jul 26 16:37:35 2002
+++ b/arch/i386/mm/init.c	Fri Jul 26 16:37:35 2002
@@ -38,15 +38,146 @@
 #include <asm/apic.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/sections.h>
 
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
 
 /*
- * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
- * physical space so we can cache the place of the first one and move
- * around without checking the pgd every time.
+ * Creates a middle page table and puts a pointer to it in the
+ * given global directory entry. This only returns the gd entry
+ * in non-PAE compilation mode, since the middle layer is folded.
  */
+static pmd_t * __init one_md_table_init(pgd_t *pgd)
+{
+	pmd_t *pmd_table;
+		
+#if CONFIG_X86_PAE
+	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	set_pgd(pgd, __pgd(__pa(md_table) | _PAGE_PRESENT));
+	if (pmd_table != pmd_offset(pgd, 0)) 
+		BUG();
+#else
+	pmd_table = pmd_offset(pgd, 0);
+#endif
+
+	return pmd_table;
+}
+
+/*
+ * Create a page table and place a pointer to it in a middle page
+ * directory entry.
+ */
+static pte_t * __init one_page_table_init(pmd_t *pmd)
+{
+	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
+	if (page_table != pte_offset_kernel(pmd, 0))
+		BUG();	
+
+	return page_table;
+}
+
+/*
+ * This function initializes a certain range of kernel virtual memory 
+ * with new bootmem page tables, everywhere page tables are missing in
+ * the given range.
+ */
+
+/*
+ * NOTE: The pagetables are allocated contiguous on the physical space 
+ * so we can cache the place of the first one and move around without 
+ * checking the pgd every time.
+ */
+static void __init page_table_range_init (unsigned long start, unsigned long end, pgd_t *pgd_base)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	int pgd_ofs, pmd_ofs;
+	unsigned long vaddr;
+
+	vaddr = start;
+	pgd_ofs = __pgd_offset(vaddr);
+	pmd_ofs = __pmd_offset(vaddr);
+	pgd = pgd_base + pgd_ofs;
+
+	for ( ; (pgd_ofs < PTRS_PER_PGD) && (vaddr != end); pgd++, pgd_ofs++) {
+		if (pgd_none(*pgd)) 
+			one_md_table_init(pgd);
+
+		pmd = pmd_offset(pgd, vaddr);
+		for (; (pmd_ofs < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_ofs++) {
+			if (pmd_none(*pmd)) 
+				one_page_table_init(pmd);
+
+			vaddr += PMD_SIZE;
+		}
+		pmd_ofs = 0;
+	}
+}
+
+/*
+ * This maps the physical memory to kernel virtual address space, a total 
+ * of max_low_pfn pages, by creating page tables starting from address 
+ * PAGE_OFFSET.
+ */
+static void __init kernel_physical_mapping_init(pgd_t *pgd_base)
+{
+	unsigned long pfn;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	int pgd_ofs, pmd_ofs, pte_ofs;
+
+	pgd_ofs = __pgd_offset(PAGE_OFFSET);
+	pgd = pgd_base + pgd_ofs;
+	pfn = 0;
+
+	for (; pgd_ofs < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, pgd_ofs++) {
+		pmd = one_md_table_init(pgd);
+		for (pmd_ofs = 0; pmd_ofs < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_ofs++) {
+			/* Map with big pages if possible, otherwise create normal page tables. */
+			if (cpu_has_pse) {
+				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+				pfn += PTRS_PER_PTE;
+			} else {
+				pte = one_page_table_init(pmd);
+
+				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
+					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+			}
+		}
+	}	
+}
+
+static inline int page_kills_ppro(unsigned long pagenr)
+{
+	if (pagenr >= 0x70000 && pagenr <= 0x7003F)
+		return 1;
+	return 0;
+}
+
+static inline int page_is_ram(unsigned long pagenr)
+{
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long addr, end;
+
+		if (e820.map[i].type != E820_RAM)	/* not usable memory */
+			continue;
+		/*
+		 *	!!!FIXME!!! Some BIOSen report areas as RAM that
+		 *	are not. Notably the 640->1Mb area. We need a sanity
+		 *	check here.
+		 */
+		addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+		end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
+		if  ((pagenr >= addr) && (pagenr < end))
+			return 1;
+	}
+	return 0;
+}
 
 #if CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -65,186 +196,88 @@
 
 	kmap_prot = PAGE_KERNEL;
 }
-#endif /* CONFIG_HIGHMEM */
 
-void show_mem(void)
-{
-	int i, total = 0, reserved = 0;
-	int shared = 0, cached = 0;
-	int highmem = 0;
-
-	printk("Mem-info:\n");
-	show_free_areas();
-	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
-	i = max_mapnr;
-	while (i-- > 0) {
-		total++;
-		if (PageHighMem(mem_map+i))
-			highmem++;
-		if (PageReserved(mem_map+i))
-			reserved++;
-		else if (PageSwapCache(mem_map+i))
-			cached++;
-		else if (page_count(mem_map+i))
-			shared += page_count(mem_map+i) - 1;
-	}
-	printk("%d pages of RAM\n", total);
-	printk("%d pages of HIGHMEM\n",highmem);
-	printk("%d reserved pages\n",reserved);
-	printk("%d pages shared\n",shared);
-	printk("%d pages swap cached\n",cached);
-}
-
-/* References to section boundaries */
-
-extern char _text, _etext, _edata, __bss_start, _end;
-extern char __init_begin, __init_end;
-
-static inline void set_pte_phys (unsigned long vaddr,
-			unsigned long phys, pgprot_t flags)
+void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long vaddr;
+
+	vaddr = PKMAP_BASE;
+	page_table_range_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
-	if (pgd_none(*pgd)) {
-		printk("PAE BUG #00!\n");
-		return;
-	}
 	pmd = pmd_offset(pgd, vaddr);
-	if (pmd_none(*pmd)) {
-		printk("PAE BUG #01!\n");
-		return;
-	}
 	pte = pte_offset_kernel(pmd, vaddr);
-	/* <phys,flags> stored as-is, to permit clearing entries */
-	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
-
-	/*
-	 * It's enough to flush this one mapping.
-	 * (PGE mappings get flushed as well)
-	 */
-	__flush_tlb_one(vaddr);
+	pkmap_page_table = pte;	
 }
 
-void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
+void __init set_highmem_pages_init(int bad_ppro) 
 {
-	unsigned long address = __fix_to_virt(idx);
-
-	if (idx >= __end_of_fixed_addresses) {
-		printk("Invalid __set_fixmap\n");
-		return;
-	}
-	set_pte_phys(address, phys, flags);
-}
+	int pfn;
+	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++) {
+		struct page *page = mem_map + pfn;
 
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
+		if (!page_is_ram(pfn)) {
+			SetPageReserved(page);
+			continue;
 		}
-		pmd = pmd_offset(pgd, vaddr);
-#else
-		pmd = (pmd_t *)pgd;
-#endif
-		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
-			if (pmd_none(*pmd)) {
-				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-				if (pte != pte_offset_kernel(pmd, 0))
-					BUG();
-			}
-			vaddr += PMD_SIZE;
+		if (bad_ppro && page_kills_ppro(pfn))
+		{
+			SetPageReserved(page);
+			continue;
 		}
-		j = 0;
+		ClearPageReserved(page);
+		set_bit(PG_highmem, &page->flags);
+		atomic_set(&page->count, 1);
+		__free_page(page);
+		totalhigh_pages++;
 	}
+	totalram_pages += totalhigh_pages;
 }
 
+#else
+#define kmap_init() do { } while (0)
+#define permanent_kmaps_init(pgd_base) do { } while (0)
+#define set_highmem_pages_init(bad_ppro) do { } while (0)
+#endif /* CONFIG_HIGHMEM */
+
 unsigned long __PAGE_KERNEL = _PAGE_KERNEL;
 
 static void __init pagetable_init (void)
 {
-	unsigned long vaddr, pfn;
-	pgd_t *pgd, *pgd_base;
-	int i, j, k;
-	pmd_t *pmd;
-	pte_t *pte, *pte_base;
+	unsigned long vaddr;
+	pgd_t *pgd_base = swapper_pg_dir;
+	int i;
 
-	pgd_base = swapper_pg_dir;
 #if CONFIG_X86_PAE
+	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
 #endif
+
+	/* Enable PSE if available */
 	if (cpu_has_pse) {
 		set_in_cr4(X86_CR4_PSE);
 	}
+
+	/* Enable PGE if available */
 	if (cpu_has_pge) {
 		set_in_cr4(X86_CR4_PGE);
 		__PAGE_KERNEL |= _PAGE_GLOBAL;
 	}
 
-	i = __pgd_offset(PAGE_OFFSET);
-	pfn = 0;
-	pgd = pgd_base + i;
-
-	for (; i < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, i++) {
-#if CONFIG_X86_PAE
-		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) | _PAGE_PRESENT));
-#else
-		pmd = (pmd_t *) pgd;
-#endif
-		for (j = 0; j < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, j++) {
-			if (cpu_has_pse) {
-				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
-				pfn += PTRS_PER_PTE;
-			} else {
-				pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-
-				for (k = 0; k < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, k++)
-					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
-
-				set_pmd(pmd, __pmd(__pa(pte_base) | _KERNPG_TABLE));
-			}
-		}
-	}
+	kernel_physical_mapping_init(pgd_base);
 
 	/*
 	 * Fixed mappings, only the page table structure has to be
 	 * created - mappings will be set by set_fixmap():
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
+	page_table_range_init(vaddr, 0, pgd_base);
 
-#if CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
-	 */
-	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
-
-	pgd = swapper_pg_dir + __pgd_offset(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;
-#endif
+	permanent_kmaps_init(pgd_base);
 
 #if CONFIG_X86_PAE
 	/*
@@ -276,6 +309,27 @@
 	flush_tlb_all();
 }
 
+void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned int max_dma, high, low;
+	
+	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	low = max_low_pfn;
+	high = highend_pfn;
+	
+	if (low < max_dma)
+		zones_size[ZONE_DMA] = low;
+	else {
+		zones_size[ZONE_DMA] = max_dma;
+		zones_size[ZONE_NORMAL] = low - max_dma;
+#ifdef CONFIG_HIGHMEM
+		zones_size[ZONE_HIGHMEM] = high - low;
+#endif
+	}
+	free_area_init(zones_size);	
+}
+
 /*
  * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
@@ -297,32 +351,10 @@
 	if (cpu_has_pae)
 		set_in_cr4(X86_CR4_PAE);
 #endif
-
 	__flush_tlb_all();
 
-#ifdef CONFIG_HIGHMEM
 	kmap_init();
-#endif
-	{
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-		unsigned int max_dma, high, low;
-
-		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-		low = max_low_pfn;
-		high = highend_pfn;
-
-		if (low < max_dma)
-			zones_size[ZONE_DMA] = low;
-		else {
-			zones_size[ZONE_DMA] = max_dma;
-			zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-			zones_size[ZONE_HIGHMEM] = high - low;
-#endif
-		}
-		free_area_init(zones_size);
-	}
-	return;
+	zone_sizes_init();
 }
 
 /*
@@ -373,35 +405,6 @@
 		printk("Ok.\n");
 	}
 }
-
-static inline int page_is_ram (unsigned long pagenr)
-{
-	int i;
-
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long addr, end;
-
-		if (e820.map[i].type != E820_RAM)	/* not usable memory */
-			continue;
-		/*
-		 *	!!!FIXME!!! Some BIOSen report areas as RAM that
-		 *	are not. Notably the 640->1Mb area. We need a sanity
-		 *	check here.
-		 */
-		addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
-		end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
-		if  ((pagenr >= addr) && (pagenr < end))
-			return 1;
-	}
-	return 0;
-}
-
-static inline int page_kills_ppro(unsigned long pagenr)
-{
-	if(pagenr >= 0x70000 && pagenr <= 0x7003F)
-		return 1;
-	return 0;
-}
 	
 void __init mem_init(void)
 {
@@ -436,27 +439,9 @@
 		 */
 		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
 			reservedpages++;
-#ifdef CONFIG_HIGHMEM
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
 
-		if (!page_is_ram(tmp)) {
-			SetPageReserved(page);
-			continue;
-		}
-		if (bad_ppro && page_kills_ppro(tmp))
-		{
-			SetPageReserved(page);
-			continue;
-		}
-		ClearPageReserved(page);
-		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
-		__free_page(page);
-		totalhigh_pages++;
-	}
-	totalram_pages += totalhigh_pages;
-#endif
+	set_highmem_pages_init(bad_ppro);
+
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
@@ -487,8 +472,22 @@
 #ifndef CONFIG_SMP
 	zap_low_mappings();
 #endif
+}
+
+#if CONFIG_X86_PAE
+struct kmem_cache_s *pae_pgd_cachep;
 
+void __init pgtable_cache_init(void)
+{
+        /*
+         * PAE pgds must be 16-byte aligned:
+         */
+        pae_pgd_cachep = kmem_cache_create("pae_pgd", 32, 0,
+                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
+        if (!pae_pgd_cachep)
+                panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
 }
+#endif
 
 /* Put this after the callers, so that it cannot be inlined */
 static int do_test_wp_bit(unsigned long vaddr)
@@ -541,110 +540,3 @@
 	}
 }
 #endif
-
-#if defined(CONFIG_X86_PAE)
-static struct kmem_cache_s *pae_pgd_cachep;
-
-void __init pgtable_cache_init(void)
-{
-	/*
-	 * PAE pgds must be 16-byte aligned:
-	 */
-	pae_pgd_cachep = kmem_cache_create("pae_pgd", 32, 0,
-		SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
-	if (!pae_pgd_cachep)
-		panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
-}
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	int i;
-	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
-
-	if (pgd) {
-		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
-			unsigned long pmd = __get_free_page(GFP_KERNEL);
-			if (!pmd)
-				goto out_oom;
-			clear_page(pmd);
-			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
-		}
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-out_oom:
-	for (i--; i >= 0; i--)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
-	return NULL;
-}
-
-void pgd_free(pgd_t *pgd)
-{
-	int i;
-
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
-}
-
-#else
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-}
-
-void pgd_free(pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-#endif /* CONFIG_X86_PAE */
-
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	int count = 0;
-	pte_t *pte;
-   
-   	do {
-		pte = (pte_t *) __get_free_page(GFP_KERNEL);
-		if (pte)
-			clear_page(pte);
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
-	return pte;
-}
-
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	int count = 0;
-	struct page *pte;
-   
-   	do {
-#if CONFIG_HIGHPTE
-		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
-#else
-		pte = alloc_pages(GFP_KERNEL, 0);
-#endif
-		if (pte)
-			clear_highpage(pte);
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
-	return pte;
-}
diff -Nru a/arch/i386/mm/pgtable.c b/arch/i386/mm/pgtable.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mm/pgtable.c	Fri Jul 26 16:37:35 2002
@@ -0,0 +1,188 @@
+/*
+ *  linux/arch/i386/mm/pgtable.c
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/smp.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/fixmap.h>
+#include <asm/e820.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+
+void show_mem(void)
+{
+	int i, total = 0, reserved = 0;
+	int shared = 0, cached = 0;
+	int highmem = 0;
+
+	printk("Mem-info:\n");
+	show_free_areas();
+	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
+	i = max_mapnr;
+	while (i-- > 0) {
+		total++;
+		if (PageHighMem(mem_map+i))
+			highmem++;
+		if (PageReserved(mem_map+i))
+			reserved++;
+		else if (PageSwapCache(mem_map+i))
+			cached++;
+		else if (page_count(mem_map+i))
+			shared += page_count(mem_map+i) - 1;
+	}
+	printk("%d pages of RAM\n", total);
+	printk("%d pages of HIGHMEM\n",highmem);
+	printk("%d reserved pages\n",reserved);
+	printk("%d pages shared\n",shared);
+	printk("%d pages swap cached\n",cached);
+}
+
+/*
+ * Associate a virtual page frame with a given physical page frame 
+ * and protection flags for that frame.
+ */ 
+static void set_pte_phys (unsigned long vaddr, unsigned long phys, pgprot_t flags)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = swapper_pg_dir + __pgd_offset(vaddr);
+	if (pgd_none(*pgd)) {
+		BUG();
+		return;
+	}
+	pmd = pmd_offset(pgd, vaddr);
+	if (pmd_none(*pmd)) {
+		BUG();
+		return;
+	}
+	pte = pte_offset_kernel(pmd, vaddr);
+	/* <phys,flags> stored as-is, to permit clearing entries */
+	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
+
+	/*
+	 * It's enough to flush this one mapping.
+	 * (PGE mappings get flushed as well)
+	 */
+	__flush_tlb_one(vaddr);
+}
+
+void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
+{
+	unsigned long address = __fix_to_virt(idx);
+
+	if (idx >= __end_of_fixed_addresses) {
+		BUG();
+		return;
+	}
+	set_pte_phys(address, phys, flags);
+}
+
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	int count = 0;
+	pte_t *pte;
+   
+   	do {
+		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+		if (pte)
+			clear_page(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
+	return pte;
+}
+
+struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	int count = 0;
+	struct page *pte;
+   
+   	do {
+#if CONFIG_HIGHPTE
+		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
+#else
+		pte = alloc_pages(GFP_KERNEL, 0);
+#endif
+		if (pte)
+			clear_highpage(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
+	return pte;
+}
+
+#if CONFIG_X86_PAE
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	int i;
+	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
+
+	if (pgd) {
+		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
+			unsigned long pmd = __get_free_page(GFP_KERNEL);
+			if (!pmd)
+				goto out_oom;
+			clear_page(pmd);
+			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
+		}
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			swapper_pg_dir + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+out_oom:
+	for (i--; i >= 0; i--)
+		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pae_pgd_cachep, pgd);
+	return NULL;
+}
+
+void pgd_free(pgd_t *pgd)
+{
+	int i;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pae_pgd_cachep, pgd);
+}
+
+#else
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+
+	if (pgd) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			swapper_pg_dir + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+void pgd_free(pgd_t *pgd)
+{
+	free_page((unsigned long)pgd);
+}
+
+#endif /* CONFIG_X86_PAE */
+
diff -Nru a/include/asm-generic/sections.h b/include/asm-generic/sections.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/sections.h	Fri Jul 26 16:37:35 2002
@@ -0,0 +1,11 @@
+#ifndef _ASM_GENERIC_SECTIONS_H_
+#define _ASM_GENERIC_SECTIONS_H_
+
+/* References to section boundaries */
+
+extern char _text, _etext;
+extern char _data, _edata;
+extern char __bss_start;
+extern char __init_begin, __init_end;
+
+#endif /* _ASM_GENERIC_SECTIONS_H_ */
diff -Nru a/include/asm-i386/pgtable-3level.h b/include/asm-i386/pgtable-3level.h
--- a/include/asm-i386/pgtable-3level.h	Fri Jul 26 16:37:35 2002
+++ b/include/asm-i386/pgtable-3level.h	Fri Jul 26 16:37:35 2002
@@ -106,4 +106,6 @@
 	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
 }
 
+extern struct kmem_cache_s *pae_pgd_cachep;
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -Nru a/include/asm-i386/sections.h b/include/asm-i386/sections.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/sections.h	Fri Jul 26 16:37:35 2002
@@ -0,0 +1,7 @@
+#ifndef _I386_SECTIONS_H
+#define _I386_SECTIONS_H
+
+/* nothing to see, move along */
+#include <asm-generic/sections.h>
+
+#endif

===================================================================


This BitKeeper patch contains the following changesets:
1.478
## Wrapped with gzip_uu ##


begin 664 bkpatch25908
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
9(:#K1KSPW[:-3F>B*=/J_P!HC](,XD``````
`
end


-- 
Dan Aloni
da-x@gmx.net
