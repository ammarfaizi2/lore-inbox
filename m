Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWHALFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWHALFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWHALFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2269 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932645AbWHALFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:42 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 18/33] x86_64: Kill temp_boot_pmds
Date: Tue,  1 Aug 2006 05:03:33 -0600
Message-Id: <11544302392378-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early in the boot process we need the ability to set
up temporary mappings, before our normal mechanisms are
initialized.  Currently this is used to map pages that
are part of the page tables we are building and pages
during the dmi scan.

The core problem is that we are using the user portion of
the page tables to implement this.  Which means that while
this mechanism is active we cannot catch NULL pointer dereferences
and we deviate from the normal ways of handling things.

In this patch I modify early_ioremap to map pages into
the kernel portion of address space, roughly where
we will later put modules, and I make the discovery of
which addresses we can use dynamic which removes all
kinds of static limits and remove the dependencies
on implementation details between different parts of the code.

I also modify the early page table initialization code
to use early_ioreamp and early_iounmap, instead of the
special case version of those functions that they are
now calling.

The only really silly part left with init_memory_mapping
is that find_early_table_space always finds pages below 1M.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head.S |    3 -
 arch/x86_64/mm/init.c     |  104 ++++++++++++++++++---------------------------
 2 files changed, 42 insertions(+), 65 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 6df05e6..ca57a37 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -278,9 +278,6 @@ NEXT_PAGE(level2_ident_pgt)
 	.quad	i << 21 | 0x083
 	i = i + 1
 	.endr
-	/* Temporary mappings for the super early allocator in arch/x86_64/mm/init.c */
-	.globl temp_boot_pmds
-temp_boot_pmds:
 	.fill	492,8,0
 	
 NEXT_PAGE(level2_kernel_pgt)
diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index 0522c1c..b46566a 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -167,76 +167,56 @@ __set_fixmap (enum fixed_addresses idx, 
 
 unsigned long __initdata table_start, table_end; 
 
-extern pmd_t temp_boot_pmds[]; 
-
-static  struct temp_map { 
-	pmd_t *pmd;
-	void  *address; 
-	int    allocated; 
-} temp_mappings[] __initdata = { 
-	{ &temp_boot_pmds[0], (void *)(40UL * 1024 * 1024) },
-	{ &temp_boot_pmds[1], (void *)(42UL * 1024 * 1024) }, 
-	{}
-}; 
-
-static __init void *alloc_low_page(int *index, unsigned long *phys)
+static __init unsigned long alloc_low_page(void)
 { 
-	struct temp_map *ti;
-	int i; 
-	unsigned long pfn = table_end++, paddr; 
-	void *adr;
+	unsigned long pfn = table_end++;
 
 	if (pfn >= end_pfn) 
 		panic("alloc_low_page: ran out of memory"); 
-	for (i = 0; temp_mappings[i].allocated; i++) {
-		if (!temp_mappings[i].pmd) 
-			panic("alloc_low_page: ran out of temp mappings"); 
-	} 
-	ti = &temp_mappings[i];
-	paddr = (pfn << PAGE_SHIFT) & PMD_MASK; 
-	set_pmd(ti->pmd, __pmd(paddr | _KERNPG_TABLE | _PAGE_PSE)); 
-	ti->allocated = 1; 
-	__flush_tlb(); 	       
-	adr = ti->address + ((pfn << PAGE_SHIFT) & ~PMD_MASK); 
-	memset(adr, 0, PAGE_SIZE);
-	*index = i; 
-	*phys  = pfn * PAGE_SIZE;  
-	return adr; 
-} 
-
-static __init void unmap_low_page(int i)
-{ 
-	struct temp_map *ti;
-
-	ti = &temp_mappings[i];
-	set_pmd(ti->pmd, __pmd(0));
-	ti->allocated = 0; 
+	return pfn << PAGE_SHIFT;
 } 
 
 /* Must run before zap_low_mappings */
 __init void *early_ioremap(unsigned long addr, unsigned long size)
 {
-	unsigned long map = round_down(addr, LARGE_PAGE_SIZE); 
-
-	/* actually usually some more */
-	if (size >= LARGE_PAGE_SIZE) { 
-		printk("SMBIOS area too long %lu\n", size);
-		return NULL;
+	unsigned long vaddr;
+	pmd_t *pmd, *last_pmd;
+	int i, pmds;
+
+	pmds = ((addr & ~PMD_MASK) + size + ~PMD_MASK) / PMD_SIZE;
+	vaddr = __START_KERNEL_map;
+	pmd = level2_kernel_pgt;
+	last_pmd = level2_kernel_pgt + PTRS_PER_PMD - 1;
+	for (; pmd <= last_pmd; pmd++, vaddr += PMD_SIZE) {
+		for (i = 0; i < pmds; i++) {
+			if (pmd_present(pmd[i]))
+				goto next;
+		}
+		vaddr += addr & ~PMD_MASK;
+		addr &= PMD_MASK;
+		for (i = 0; i < pmds; i++, addr += PMD_SIZE)
+			set_pmd(pmd + i,__pmd(addr | __PAGE_KERNEL_LARGE));
+		__flush_tlb();
+		return (void *)vaddr;
+	next:
+		;
 	}
-	set_pmd(temp_mappings[0].pmd,  __pmd(map | _KERNPG_TABLE | _PAGE_PSE));
-	map += LARGE_PAGE_SIZE;
-	set_pmd(temp_mappings[1].pmd,  __pmd(map | _KERNPG_TABLE | _PAGE_PSE));
-	__flush_tlb();
-	return temp_mappings[0].address + (addr & (LARGE_PAGE_SIZE-1));
+	printk("early_ioremap(0x%lx, %lu) failed\n", addr, size);
+	return NULL;
 }
 
 /* To avoid virtual aliases later */
 __init void early_iounmap(void *addr, unsigned long size)
 {
-	if ((void *)round_down((unsigned long)addr, LARGE_PAGE_SIZE) != temp_mappings[0].address)
-		printk("early_iounmap: bad address %p\n", addr);
-	set_pmd(temp_mappings[0].pmd, __pmd(0));
-	set_pmd(temp_mappings[1].pmd, __pmd(0));
+	unsigned long vaddr;
+	pmd_t *pmd;
+	int i, pmds;
+
+	vaddr = (unsigned long)addr;
+	pmds = ((vaddr & ~PMD_MASK) + size + ~PMD_MASK) / PMD_SIZE;
+	pmd = level2_kernel_pgt + pmd_index(vaddr);
+	for (i = 0; i < pmds; i++)
+		pmd_clear(pmd + i);
 	__flush_tlb();
 }
 
@@ -266,7 +246,6 @@ static void __init phys_pud_init(pud_t *
 	pud = pud + i;
 
 	for (; i < PTRS_PER_PUD; pud++, i++) {
-		int map; 
 		unsigned long paddr, pmd_phys;
 		pmd_t *pmd;
 
@@ -279,10 +258,11 @@ static void __init phys_pud_init(pud_t *
 			continue;
 		} 
 
-		pmd = alloc_low_page(&map, &pmd_phys);
+		pmd_phys = alloc_low_page();
+		pmd = early_ioremap(pmd_phys, PAGE_SIZE);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
 		phys_pmd_init(pmd, paddr, end);
-		unmap_low_page(map);
+		early_iounmap(pmd, PAGE_SIZE);
 	}
 	__flush_tlb();
 } 
@@ -333,19 +313,19 @@ void __init init_memory_mapping(unsigned
 	end = (unsigned long)__va(end);
 
 	for (; start < end; start = next) {
-		int map;
 		unsigned long pud_phys; 
 		pgd_t *pgd = pgd_offset_k(start);
 		pud_t *pud;
 
-		pud = alloc_low_page(&map, &pud_phys);
+		pud_phys = alloc_low_page();
+		pud = early_ioremap(pud_phys, PAGE_SIZE);
 
 		next = start + PGDIR_SIZE;
 		if (next > end) 
 			next = end; 
 		phys_pud_init(pud, __pa(start), __pa(next));
-		set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
-		unmap_low_page(map);   
+		set_pgd(pgd, mk_kernel_pgd(pud_phys));
+		early_iounmap(pud, PAGE_SIZE);
 	} 
 
 	asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
-- 
1.4.2.rc2.g5209e

