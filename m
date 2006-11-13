Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755222AbWKMQzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbWKMQzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbWKMQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42895 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755216AbWKMQyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:17 -0500
Date: Mon, 13 Nov 2006 11:30:08 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 3/16] x86_64: Kill temp_boot_pmds
Message-ID: <20061113163008.GD17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
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

Now alloc_low_page() and unmap_low_page() use 
early_iomap() and early_iounmap() to allocate/map and 
unmap a page.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head.S |    3 -
 arch/x86_64/mm/init.c     |  100 ++++++++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 58 deletions(-)

diff -puN arch/x86_64/kernel/head.S~x86_64-Kill-temp_boot_pmds arch/x86_64/kernel/head.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/head.S~x86_64-Kill-temp_boot_pmds	2006-11-09 22:53:32.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/head.S	2006-11-09 22:53:32.000000000 -0500
@@ -280,9 +280,6 @@ NEXT_PAGE(level2_ident_pgt)
 	.quad	i << 21 | 0x083
 	i = i + 1
 	.endr
-	/* Temporary mappings for the super early allocator in arch/x86_64/mm/init.c */
-	.globl temp_boot_pmds
-temp_boot_pmds:
 	.fill	492,8,0
 	
 NEXT_PAGE(level2_kernel_pgt)
diff -puN arch/x86_64/mm/init.c~x86_64-Kill-temp_boot_pmds arch/x86_64/mm/init.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/mm/init.c~x86_64-Kill-temp_boot_pmds	2006-11-09 22:53:32.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/mm/init.c	2006-11-09 22:53:32.000000000 -0500
@@ -167,23 +167,9 @@ __set_fixmap (enum fixed_addresses idx, 
 
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
-static __meminit void *alloc_low_page(int *index, unsigned long *phys)
+static __meminit void *alloc_low_page(unsigned long *phys)
 { 
-	struct temp_map *ti;
-	int i; 
-	unsigned long pfn = table_end++, paddr; 
+	unsigned long pfn = table_end++;
 	void *adr;
 
 	if (after_bootmem) {
@@ -194,57 +180,63 @@ static __meminit void *alloc_low_page(in
 
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
+
+	adr = early_ioremap(pfn * PAGE_SIZE, PAGE_SIZE);
 	memset(adr, 0, PAGE_SIZE);
-	*index = i; 
-	*phys  = pfn * PAGE_SIZE;  
-	return adr; 
-} 
+	*phys  = pfn * PAGE_SIZE;
+	return adr;
+}
 
-static __meminit void unmap_low_page(int i)
+static __meminit void unmap_low_page(void *adr)
 { 
-	struct temp_map *ti;
 
 	if (after_bootmem)
 		return;
 
-	ti = &temp_mappings[i];
-	set_pmd(ti->pmd, __pmd(0));
-	ti->allocated = 0; 
+	early_iounmap(adr, PAGE_SIZE);
 } 
 
 /* Must run before zap_low_mappings */
 __init void *early_ioremap(unsigned long addr, unsigned long size)
 {
-	unsigned long map = round_down(addr, LARGE_PAGE_SIZE); 
-
-	/* actually usually some more */
-	if (size >= LARGE_PAGE_SIZE) { 
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
+			set_pmd(pmd + i,__pmd(addr | _KERNPG_TABLE | _PAGE_PSE));
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
 
@@ -289,7 +281,6 @@ static void __meminit phys_pud_init(pud_
 
 
 	for (; i < PTRS_PER_PUD; i++, addr = (addr & PUD_MASK) + PUD_SIZE ) {
-		int map; 
 		unsigned long pmd_phys;
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
@@ -307,12 +298,12 @@ static void __meminit phys_pud_init(pud_
 			continue;
 		}
 
-		pmd = alloc_low_page(&map, &pmd_phys);
+		pmd = alloc_low_page(&pmd_phys);
 		spin_lock(&init_mm.page_table_lock);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
 		phys_pmd_init(pmd, addr, end);
 		spin_unlock(&init_mm.page_table_lock);
-		unmap_low_page(map);
+		unmap_low_page(pmd);
 	}
 	__flush_tlb();
 } 
@@ -364,7 +355,6 @@ void __meminit init_memory_mapping(unsig
 	end = (unsigned long)__va(end);
 
 	for (; start < end; start = next) {
-		int map;
 		unsigned long pud_phys; 
 		pgd_t *pgd = pgd_offset_k(start);
 		pud_t *pud;
@@ -372,7 +362,7 @@ void __meminit init_memory_mapping(unsig
 		if (after_bootmem)
 			pud = pud_offset(pgd, start & PGDIR_MASK);
 		else
-			pud = alloc_low_page(&map, &pud_phys);
+			pud = alloc_low_page(&pud_phys);
 
 		next = start + PGDIR_SIZE;
 		if (next > end) 
@@ -380,7 +370,7 @@ void __meminit init_memory_mapping(unsig
 		phys_pud_init(pud, __pa(start), __pa(next));
 		if (!after_bootmem)
 			set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
-		unmap_low_page(map);   
+		unmap_low_page(pud);
 	} 
 
 	if (!after_bootmem)
_
