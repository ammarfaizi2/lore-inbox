Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289764AbSA2SPT>; Tue, 29 Jan 2002 13:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSA2SPK>; Tue, 29 Jan 2002 13:15:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8058 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289764AbSA2SPC>; Tue, 29 Jan 2002 13:15:02 -0500
Date: Tue, 29 Jan 2002 17:42:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Xeno <xeno@overture.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4: NFS client kmapping across I/O
In-Reply-To: <3C560804.C68BC6F4@overture.com>
Message-ID: <Pine.LNX.4.21.0201291701510.1367-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Xeno wrote:
> 
> Now I also have time to mention the other NFS client issue we ran into
> recently, I have not found mention of it on the mailing lists.  The NFS
> client is kmapping pages for the duration of reads from and writes to
> the server.  This creates a scaling limitation, especially under
> CONFIG_HIGHMEM64G and i386 where there are only 512 entries in the
> highmem kmap table.  Under I/O load, it is easy to fill up the table,
> hanging all processes that need to map highmem pages a substantial
> fraction of the time.
> ...
> I've thought about bumping up LAST_PKMAP to increase the size of the
> highmem kmap table, but the table looks like it was designed to be
> small.

You're right that kmap users should avoid holding them for very long,
I'd certainly not discourage anyone from pursuing that effort.

But in case it helps in the short term, below is 2.4.18-pre7 version
of patch I prepared earlier for 2.4.18-pre4aa1: plus now defaults to
1800 kmaps for both HIGHMEM4G and HIGHMEM64G.  And as a side-effect,
it raises the overly strict limit on the i386 vmalloc area, like -aa.
But I've not touched PPC or Sparc, their limits are unchanged.

I don't think the kmap area was really designed to be so small, it's
just that nobody ever got around to allowing more than one page table
for it.  It was surely absurd that HIGHMEM64G (doubly-sized ptes so half
as many per page table) should be limited to fewer kmaps than HIGHMEM4G.

Hugh

diff -urN 2.4.18-pre7/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- 2.4.18-pre7/arch/i386/mm/init.c	Mon Jan  7 13:02:56 2002
+++ linux/arch/i386/mm/init.c	Tue Jan 29 16:02:23 2002
@@ -167,44 +167,6 @@
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
 	unsigned long vaddr, end;
@@ -221,8 +183,24 @@
 
 	pgd_base = swapper_pg_dir;
 #if CONFIG_X86_PAE
-	for (i = 0; i < PTRS_PER_PGD; i++)
+	/*
+	 * First set all four entries of the pgd.
+	 * Usually only one page is needed here: if PAGE_OFFSET lowered,
+	 * maybe three pages: need not be contiguous, but might as well.
+	 */
+	pmd = (pmd_t *)alloc_bootmem_low_pages(KERNEL_PGD_PTRS*PAGE_SIZE);
+	for (i = 1; i < USER_PGD_PTRS; i++)
 		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
+	for (; i < PTRS_PER_PGD; i++, pmd += PTRS_PER_PMD)
+		set_pgd(pgd_base + i, __pgd(1 + __pa(pmd)));
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	pgd_base[0] = pgd_base[USER_PGD_PTRS];
 #endif
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
@@ -231,14 +209,7 @@
 		vaddr = i*PGDIR_SIZE;
 		if (end && (vaddr >= end))
 			break;
-#if CONFIG_X86_PAE
-		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
-#else
-		pmd = (pmd_t *)pgd;
-#endif
-		if (pmd != pmd_offset(pgd, 0))
-			BUG();
+		pmd = pmd_offset(pgd, 0);
 		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
 			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
 			if (end && (vaddr >= end))
@@ -274,34 +245,27 @@
 	}
 
 	/*
-	 * Fixed mappings, only the page table structure has to be
-	 * created - mappings will be set by set_fixmap():
+	 * Leave vmalloc() to create its own page tables as needed,
+	 * but create the page tables at top of virtual memory, to be
+	 * populated by kmap_high(), kmap_atomic(), and set_fixmap().
+	 * kmap_high() assumes pkmap_page_table contiguous throughout.
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
-
 #if CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
-	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+#else
+	vaddr = FIXADDR_START;
+#endif
+	pmd = pmd_offset(pgd_offset_k(vaddr), vaddr);
+	i = (0UL - (vaddr & PMD_MASK)) >> PMD_SHIFT;
+	pte = (pte_t *)alloc_bootmem_low_pages(i*PAGE_SIZE);
+	for (; --i >= 0; pmd++, pte += PTRS_PER_PTE)
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
 
+#if CONFIG_HIGHMEM
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset(pmd, vaddr);
 	pkmap_page_table = pte;
-#endif
-
-#if CONFIG_X86_PAE
-	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
-	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
 #endif
 }
 
diff -urN 2.4.18-pre7/include/asm-i386/highmem.h linux/include/asm-i386/highmem.h
--- 2.4.18-pre7/include/asm-i386/highmem.h	Mon Jan 28 18:42:17 2002
+++ linux/include/asm-i386/highmem.h	Tue Jan 29 16:02:23 2002
@@ -42,17 +42,13 @@
 extern void kmap_init(void) __init;
 
 /*
- * Right now we initialize only a single pte table. It can be extended
- * easily, subsequent pte tables have to be allocated in one physical
- * chunk of RAM.
+ * LAST_PKMAP is the maximum number of persistent (non-atomic) kmappings
+ * outstanding at one time.  1800 was chosen as more than the previous
+ * 1024, not necessarily a power of 2, and 2000 would need one more
+ * page table (since last shared with fixmaps): redefine it if you need.
  */
-#define PKMAP_BASE (0xfe000000UL)
-#ifdef CONFIG_X86_PAE
-#define LAST_PKMAP 512
-#else
-#define LAST_PKMAP 1024
-#endif
-#define LAST_PKMAP_MASK (LAST_PKMAP-1)
+#define LAST_PKMAP	1800
+#define PKMAP_BASE	(FIXADDR_START - (LAST_PKMAP << PAGE_SHIFT))
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
diff -urN 2.4.18-pre7/mm/highmem.c linux/mm/highmem.c
--- 2.4.18-pre7/mm/highmem.c	Mon Jan  7 13:03:04 2002
+++ linux/mm/highmem.c	Tue Jan 29 16:02:23 2002
@@ -85,8 +85,8 @@
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

