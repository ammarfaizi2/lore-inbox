Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWAIPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWAIPVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWAIPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:21:51 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:39592 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932324AbWAIPVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:21:50 -0500
Date: Mon, 9 Jan 2006 10:21:30 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200601091521.k09FLU1t022321@ap1.cs.vt.edu>
To: ak@suse.de, akpm@osdl.org
Subject: [patch 2/2] add x86-64 support for memory hot-add
Cc: discuss@x86-64.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add x86-64 specific memory hot-add functions, Kconfig options,
and runtime kernel page table update functions to make
hot-add usable on x86-64 machines.  Also, fixup the nefarious
conditional locking and exports pointed out by Andi.

Tested on Intel and IBM x86-64 memory hot-add capable systems. 

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---
diff -urNp linux-2.6.15/arch/x86_64/Kconfig linux-2.6.15-matt/arch/x86_64/Kconfig
--- linux-2.6.15/arch/x86_64/Kconfig	2006-01-06 14:42:45.000000000 -0500
+++ linux-2.6.15-matt/arch/x86_64/Kconfig	2006-01-06 11:32:12.000000000 -0500
@@ -283,7 +283,11 @@ config ARCH_DISCONTIGMEM_DEFAULT
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on NUMA
+	depends on (NUMA || EXPERIMENTAL)
+
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
@@ -293,6 +297,7 @@ source "mm/Kconfig"
 
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
+	depends on NUMA
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-256)"
diff -urNp linux-2.6.15/arch/x86_64/mm/init.c linux-2.6.15-matt/arch/x86_64/mm/init.c
--- linux-2.6.15/arch/x86_64/mm/init.c	2006-01-06 14:42:45.000000000 -0500
+++ linux-2.6.15-matt/arch/x86_64/mm/init.c	2006-01-06 12:56:35.000000000 -0500
@@ -23,6 +23,8 @@
 #include <linux/bootmem.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -174,13 +176,19 @@ static  struct temp_map { 
 	{}
 }; 
 
-static __init void *alloc_low_page(int *index, unsigned long *phys) 
+static __meminit void *alloc_low_page(int *index, unsigned long *phys) 
 { 
 	struct temp_map *ti;
 	int i; 
 	unsigned long pfn = table_end++, paddr; 
 	void *adr;
 
+	if (after_bootmem) {
+		adr = (void *)get_zeroed_page(GFP_ATOMIC);
+		*phys = __pa(adr);
+		return adr;
+	}
+
 	if (pfn >= end_pfn) 
 		panic("alloc_low_page: ran out of memory"); 
 	for (i = 0; temp_mappings[i].allocated; i++) {
@@ -193,55 +201,86 @@ static __init void *alloc_low_page(int *
 	ti->allocated = 1; 
 	__flush_tlb(); 	       
 	adr = ti->address + ((pfn << PAGE_SHIFT) & ~PMD_MASK); 
+	memset(adr, 0, PAGE_SIZE);
 	*index = i; 
 	*phys  = pfn * PAGE_SIZE;  
 	return adr; 
 } 
 
-static __init void unmap_low_page(int i)
+static __meminit void unmap_low_page(int i)
 { 
-	struct temp_map *ti = &temp_mappings[i];
+	struct temp_map *ti;
+
+	if (after_bootmem)
+		return;
+
+	ti = &temp_mappings[i];
 	set_pmd(ti->pmd, __pmd(0));
 	ti->allocated = 0; 
 } 
 
-static void __init phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+static void __meminit
+phys_pmd_init(pmd_t *pmd, unsigned long address, unsigned long end)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; pmd++, i++, address += PMD_SIZE) {
+		unsigned long entry;
+
+		if (address > end) {
+			for (; i < PTRS_PER_PMD; i++, pmd++)
+				set_pmd(pmd, __pmd(0));
+			break;
+		}
+		entry = _PAGE_NX|_PAGE_PSE|_KERNPG_TABLE|_PAGE_GLOBAL|address;
+		entry &= __supported_pte_mask;
+		set_pmd(pmd, __pmd(entry));
+	}
+}
+
+static void __meminit
+phys_pmd_update(pud_t *pud, unsigned long address, unsigned long end)
+{
+	pmd_t *pmd = pmd_offset(pud, (unsigned long)__va(address));
+	
+	if (pmd_none(*pmd)) {
+		spin_lock(&init_mm.page_table_lock);
+		phys_pmd_init(pmd, address, end);
+		spin_unlock(&init_mm.page_table_lock);
+		__flush_tlb_all();
+	}
+}
+
+static void __meminit phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
 { 
-	long i, j; 
+	long i = pud_index(address);
 
-	i = pud_index(address);
 	pud = pud + i;
+
+	if (after_bootmem && pud_val(*pud)) {
+		phys_pmd_update(pud, address, end);
+		return;
+	}
+
 	for (; i < PTRS_PER_PUD; pud++, i++) {
 		int map; 
 		unsigned long paddr, pmd_phys;
 		pmd_t *pmd;
 
-		paddr = address + i*PUD_SIZE;
-		if (paddr >= end) { 
-			for (; i < PTRS_PER_PUD; i++, pud++) 
-				set_pud(pud, __pud(0)); 
+		paddr = (address & PGDIR_MASK) + i*PUD_SIZE;
+		if (paddr >= end)
 			break;
-		} 
 
-		if (!e820_mapped(paddr, paddr+PUD_SIZE, 0)) { 
+		if (!after_bootmem && !e820_mapped(paddr, paddr+PUD_SIZE, 0)) { 
 			set_pud(pud, __pud(0)); 
 			continue;
 		} 
 
 		pmd = alloc_low_page(&map, &pmd_phys);
+		spin_lock(&init_mm.page_table_lock);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
-		for (j = 0; j < PTRS_PER_PMD; pmd++, j++, paddr += PMD_SIZE) {
-			unsigned long pe;
-
-			if (paddr >= end) { 
-				for (; j < PTRS_PER_PMD; j++, pmd++)
-					set_pmd(pmd,  __pmd(0)); 
-				break;
-		}
-			pe = _PAGE_NX|_PAGE_PSE | _KERNPG_TABLE | _PAGE_GLOBAL | paddr;
-			pe &= __supported_pte_mask;
-			set_pmd(pmd, __pmd(pe));
-		}
+		phys_pmd_init(pmd, paddr, end);
+		spin_unlock(&init_mm.page_table_lock);
 		unmap_low_page(map);
 	}
 	__flush_tlb();
@@ -262,12 +301,15 @@ static void __init find_early_table_spac
 
 	table_start >>= PAGE_SHIFT;
 	table_end = table_start;
+
+	early_printk("kernel direct mapping tables up to %lx @ %lx-%lx\n",
+		end, table_start << PAGE_SHIFT, table_end << PAGE_SHIFT);
 }
 
 /* Setup the direct mapping of the physical memory at PAGE_OFFSET.
    This runs before bootmem is initialized and gets pages directly from the 
    physical memory. To access them they are temporarily mapped. */
-void __init init_memory_mapping(unsigned long start, unsigned long end)
+void __meminit init_memory_mapping(unsigned long start, unsigned long end)
 { 
 	unsigned long next; 
 
@@ -279,7 +321,8 @@ void __init init_memory_mapping(unsigned
 	 * mapped.  Unfortunately this is done currently before the nodes are 
 	 * discovered.
 	 */
-	find_early_table_space(end);
+	if (!after_bootmem)
+		find_early_table_space(end);
 
 	start = (unsigned long)__va(start);
 	end = (unsigned long)__va(end);
@@ -287,20 +330,26 @@ void __init init_memory_mapping(unsigned
 	for (; start < end; start = next) {
 		int map;
 		unsigned long pud_phys; 
-		pud_t *pud = alloc_low_page(&map, &pud_phys);
+		pgd_t *pgd = pgd_offset_k(start);
+		pud_t *pud;
+
+		if (after_bootmem)
+			pud = pud_offset_k(pgd, __PAGE_OFFSET);
+		else
+			pud = alloc_low_page(&map, &pud_phys);
+
 		next = start + PGDIR_SIZE;
 		if (next > end) 
 			next = end; 
 		phys_pud_init(pud, __pa(start), __pa(next));
-		set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
+		if (!after_bootmem)
+			set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
 		unmap_low_page(map);   
 	} 
 
-	asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
+	if (!after_bootmem)
+		asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
 	__flush_tlb_all();
-	early_printk("kernel direct mapping tables upto %lx @ %lx-%lx\n", end, 
-	       table_start<<PAGE_SHIFT, 
-	       table_end<<PAGE_SHIFT);
 }
 
 void __cpuinit zap_low_mappings(int cpu)
@@ -375,6 +424,9 @@ size_zones(unsigned long *z, unsigned lo
 void __init paging_init(void)
 {
 	unsigned long zones[MAX_NR_ZONES], holes[MAX_NR_ZONES];
+
+	memory_present(0, 0, end_pfn);
+	sparse_init();
 	size_zones(zones, holes, 0, end_pfn);
 	free_area_init_node(0, NODE_DATA(0), zones,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, holes);
@@ -415,6 +467,50 @@ void __init clear_kernel_mapping(unsigne
 	__flush_tlb_all();
 } 
 
+/* 
+ * Memory hotplug specific functions
+ * These are only for non-NUMA machines right now.
+ */
+#ifdef CONFIG_MEMORY_HOTPLUG
+
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	set_page_count(page, 1);
+	__free_page(page);
+	totalram_pages++;
+	num_physpages++;
+}
+
+int add_memory(u64 start, u64 size)
+{
+	struct pglist_data *pgdat = NODE_DATA(0);
+	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
+
+	ret = __add_pages(zone, start_pfn, nr_pages);
+	if (ret)
+		goto error;
+	
+	init_memory_mapping(start, (start + size -1));
+
+	return ret;
+error:
+	printk("%s: Problem encountered in __add_pages!\n", __func__);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_memory);
+
+int remove_memory(u64 start, u64 size)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(remove_memory);
+
+#endif
+
 static struct kcore_list kcore_mem, kcore_vmalloc, kcore_kernel, kcore_modules,
 			 kcore_vsyscall;
 
