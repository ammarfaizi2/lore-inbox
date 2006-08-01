Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWHALML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWHALML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWHALMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:12:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8925 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932627AbWHALGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 17/33] x86_64: Separate normal memory map initialization from the hotplug case
Date: Tue,  1 Aug 2006 05:03:32 -0600
Message-Id: <11544302381069-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently initializing the two memory maps are combining into one
set of functions with if(after_bootmem) tests scattered all over
to handle the semantic differences.  Just trying to think about
what is supposed to happen when and why makes my head hurt.

In one case we initialize a page but in another we don't because
it has been zeroed by the allocator.

In one case we have to map and unmap pages and in another we
don't because we have a mapping of the pages already.

In one case we care if a page table is partially initialized
and in the other we don't.

It is ugly to reason through and makes maintenance difficult,
because the rules are different in the two cases.  So I have
separated these code paths so the can evolve separately.  I
think code duplication is the lesser of two evils here.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/mm/init.c |  147 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 98 insertions(+), 49 deletions(-)

diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index d14fb2d..0522c1c 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -179,19 +179,13 @@ static  struct temp_map { 
 	{}
 }; 
 
-static __meminit void *alloc_low_page(int *index, unsigned long *phys)
+static __init void *alloc_low_page(int *index, unsigned long *phys)
 { 
 	struct temp_map *ti;
 	int i; 
 	unsigned long pfn = table_end++, paddr; 
 	void *adr;
 
-	if (after_bootmem) {
-		adr = (void *)get_zeroed_page(GFP_ATOMIC);
-		*phys = __pa(adr);
-		return adr;
-	}
-
 	if (pfn >= end_pfn) 
 		panic("alloc_low_page: ran out of memory"); 
 	for (i = 0; temp_mappings[i].allocated; i++) {
@@ -210,13 +204,10 @@ static __meminit void *alloc_low_page(in
 	return adr; 
 } 
 
-static __meminit void unmap_low_page(int i)
+static __init void unmap_low_page(int i)
 { 
 	struct temp_map *ti;
 
-	if (after_bootmem)
-		return;
-
 	ti = &temp_mappings[i];
 	set_pmd(ti->pmd, __pmd(0));
 	ti->allocated = 0; 
@@ -249,7 +240,7 @@ __init void early_iounmap(void *addr, un
 	__flush_tlb();
 }
 
-static void __meminit
+static void __init
 phys_pmd_init(pmd_t *pmd, unsigned long address, unsigned long end)
 {
 	int i;
@@ -258,9 +249,8 @@ phys_pmd_init(pmd_t *pmd, unsigned long 
 		unsigned long entry;
 
 		if (address >= end) {
-			if (!after_bootmem)
-				for (; i < PTRS_PER_PMD; i++, pmd++)
-					set_pmd(pmd, __pmd(0));
+			for (; i < PTRS_PER_PMD; i++, pmd++)
+				set_pmd(pmd, __pmd(0));
 			break;
 		}
 		entry = _PAGE_NX|_PAGE_PSE|_KERNPG_TABLE|_PAGE_GLOBAL|address;
@@ -269,30 +259,12 @@ phys_pmd_init(pmd_t *pmd, unsigned long 
 	}
 }
 
-static void __meminit
-phys_pmd_update(pud_t *pud, unsigned long address, unsigned long end)
-{
-	pmd_t *pmd = pmd_offset(pud, (unsigned long)__va(address));
-
-	if (pmd_none(*pmd)) {
-		spin_lock(&init_mm.page_table_lock);
-		phys_pmd_init(pmd, address, end);
-		spin_unlock(&init_mm.page_table_lock);
-		__flush_tlb_all();
-	}
-}
-
-static void __meminit phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+static void __init phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
 { 
 	long i = pud_index(address);
 
 	pud = pud + i;
 
-	if (after_bootmem && pud_val(*pud)) {
-		phys_pmd_update(pud, address, end);
-		return;
-	}
-
 	for (; i < PTRS_PER_PUD; pud++, i++) {
 		int map; 
 		unsigned long paddr, pmd_phys;
@@ -302,16 +274,14 @@ static void __meminit phys_pud_init(pud_
 		if (paddr >= end)
 			break;
 
-		if (!after_bootmem && !e820_any_mapped(paddr, paddr+PUD_SIZE, 0)) {
+		if (!e820_any_mapped(paddr, paddr+PUD_SIZE, 0)) {
 			set_pud(pud, __pud(0)); 
 			continue;
 		} 
 
 		pmd = alloc_low_page(&map, &pmd_phys);
-		spin_lock(&init_mm.page_table_lock);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
 		phys_pmd_init(pmd, paddr, end);
-		spin_unlock(&init_mm.page_table_lock);
 		unmap_low_page(map);
 	}
 	__flush_tlb();
@@ -345,7 +315,7 @@ static void __init find_early_table_spac
 /* Setup the direct mapping of the physical memory at PAGE_OFFSET.
    This runs before bootmem is initialized and gets pages directly from the 
    physical memory. To access them they are temporarily mapped. */
-void __meminit init_memory_mapping(unsigned long start, unsigned long end)
+void __init init_memory_mapping(unsigned long start, unsigned long end)
 { 
 	unsigned long next; 
 
@@ -357,8 +327,7 @@ void __meminit init_memory_mapping(unsig
 	 * mapped.  Unfortunately this is done currently before the nodes are 
 	 * discovered.
 	 */
-	if (!after_bootmem)
-		find_early_table_space(end);
+	find_early_table_space(end);
 
 	start = (unsigned long)__va(start);
 	end = (unsigned long)__va(end);
@@ -369,22 +338,17 @@ void __meminit init_memory_mapping(unsig
 		pgd_t *pgd = pgd_offset_k(start);
 		pud_t *pud;
 
-		if (after_bootmem)
-			pud = pud_offset(pgd, start & PGDIR_MASK);
-		else
-			pud = alloc_low_page(&map, &pud_phys);
+		pud = alloc_low_page(&map, &pud_phys);
 
 		next = start + PGDIR_SIZE;
 		if (next > end) 
 			next = end; 
 		phys_pud_init(pud, __pa(start), __pa(next));
-		if (!after_bootmem)
-			set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
+		set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
 		unmap_low_page(map);   
 	} 
 
-	if (!after_bootmem)
-		asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
+	asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
 	__flush_tlb_all();
 }
 
@@ -529,6 +493,91 @@ int memory_add_physaddr_to_nid(u64 start
 }
 #endif
 
+static void
+late_phys_pmd_init(pmd_t *pmd, unsigned long address, unsigned long end)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; pmd++, i++, address += PMD_SIZE) {
+		unsigned long entry;
+
+		if (address >= end)
+			break;
+		entry = _PAGE_NX|_PAGE_PSE|_KERNPG_TABLE|_PAGE_GLOBAL|address;
+		entry &= __supported_pte_mask;
+		set_pmd(pmd, __pmd(entry));
+	}
+}
+
+static void
+late_phys_pmd_update(pud_t *pud, unsigned long address, unsigned long end)
+{
+	pmd_t *pmd = pmd_offset(pud, (unsigned long)__va(address));
+
+	if (pmd_none(*pmd)) {
+		spin_lock(&init_mm.page_table_lock);
+		late_phys_pmd_init(pmd, address, end);
+		spin_unlock(&init_mm.page_table_lock);
+		__flush_tlb_all();
+	}
+}
+
+static void late_phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+{
+	long i = pud_index(address);
+
+	pud = pud + i;
+
+	if (pud_val(*pud)) {
+		late_phys_pmd_update(pud, address, end);
+		return;
+	}
+
+	for (; i < PTR_PER_PUD; pud++, i++) {
+		unsigned long paddr, pmd_phys;
+		pmd_t *pmd;
+
+		paddr = (address & PGDIR_MASK) + i*PUD_SIZE;
+		if (paddr >= end)
+			break;
+
+		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+		phys_pmd = __pa(pmd);
+
+		spin_lock(&init_mm.page_table_lock);
+		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
+		late_phys_pmd_init(pmd, paddr, end);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+}
+
+/* Setup the direct mapping of the physical memory at PAGE_OFFSET.
+ * This runs after bootmem is initialized and gets pages normally.
+ */
+static void late_init_memory_mapping(unsigned long start, unsigned long end)
+{
+	unsigned long next;
+
+	Dprintk("add_memory_mapping\n");
+
+	start = (unsigned long)__va(start);
+	end = (unsigned long)__va(end);
+
+	for (; start < end; start = next) {
+		unsigned long pud_phys;
+		pgd_t *pgd = pgd_offset_k(start);
+		pud_t *pud;
+
+		pud = pud_offset(pgd, start & PGDIR_MASK);
+
+		next = start + PGDIR_SIZE;
+		if (next > end)
+			next = end;
+		late_phys_pud_init(pud, __pa(start), __pa(next));
+	}
+	__flush_tlb_all();
+}
+
 /*
  * Memory is added always to NORMAL zone. This means you will never get
  * additional DMA/DMA32 memory.
@@ -545,7 +594,7 @@ int arch_add_memory(int nid, u64 start, 
 	if (ret)
 		goto error;
 
-	init_memory_mapping(start, (start + size -1));
+	late_init_memory_mapping(start, (start + size -1));
 
 	return ret;
 error:
-- 
1.4.2.rc2.g5209e

