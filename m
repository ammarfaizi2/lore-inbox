Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTANU3e>; Tue, 14 Jan 2003 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTANU3e>; Tue, 14 Jan 2003 15:29:34 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:25276 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265230AbTANU3B>;
	Tue, 14 Jan 2003 15:29:01 -0500
Message-ID: <3E2474F9.7020907@us.ibm.com>
Date: Tue, 14 Jan 2003 12:37:13 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, lse-tech@lists.sourceforge.net
Subject: [PATCH] allow non-PMD-aligned PAGE_OFFSET
Content-Type: multipart/mixed;
 boundary="------------020005040607090909070800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005040607090909070800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some crazy person with PAE thinks that they need more user virtual 
space,  This patch allows PAGE_OFFSET to be in much more arbitrary 
places, with PAE on.  I described the first bit of the patch here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104197008817507&w=2

This patch also allows us to simulate the conditions that occur when 
we have large amounts of physical RAM (like having pte chains and 
mem_map consuting all of ZONE_NORMAL) with much lower actual amounts 
of RAM.

This part adds the userspace page tables component, so that we can 
_actually_ run userspace programs.  Thanks to Bill Irwin for showing 
me how to do the pgd_alloc() in a relatively sane way.

The second patch I've attached will take you from the normal 3:1 
split, to a 7:1 split.  I've also booted on a machine with PAE on, 4GB 
of physical RAM, and a 15:1 split (PAGE_OFFSET == 0xF0000000).

This is from the 15:1 split:
3615MB HIGHMEM available.
128MB LOWMEM available.

MemTotal:      3790824 kB
MemFree:       3758920 kB
Buffers:          1472 kB
Cached:           7636 kB
SwapCached:          0 kB
Active:           6576 kB
Inactive:         4380 kB
HighTotal:     3702756 kB
HighFree:      3692160 kB
LowTotal:        88068 kB
LowFree:         66760 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             116 kB
Writeback:           0 kB
Mapped:           4804 kB
Slab:             5092 kB
Committed_AS:     2776 kB
PageTables:       1868 kB
ReverseMaps:      3091

-- 
Dave Hansen
haveblue@us.ibm.com

--------------020005040607090909070800
Content-Type: text/plain;
 name="weirdsplit-2.5.58-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="weirdsplit-2.5.58-2.patch"

diff -ur linux-2.5.58-clean/arch/i386/mm/init.c linux-2.5.58-weirdsplit/arch/i386/mm/init.c
--- linux-2.5.58-clean/arch/i386/mm/init.c	Mon Jan 13 21:59:09 2003
+++ linux-2.5.58-weirdsplit/arch/i386/mm/init.c	Tue Jan 14 11:45:50 2003
@@ -121,6 +121,24 @@
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
@@ -131,8 +149,7 @@
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
-	int pgd_ofs, pmd_ofs, pte_ofs;
+	int pgd_ofs, pmd_ofs;
 
 	pgd_ofs = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + pgd_ofs;
@@ -142,19 +159,47 @@
 		pmd = one_md_table_init(pgd);
 		if (pfn >= max_low_pfn)
 			continue;
-		for (pmd_ofs = 0; pmd_ofs < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_ofs++) {
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
+		if( pgd_ofs == __pgd_offset(PAGE_OFFSET) ) {
+			pmd_ofs = __pmd_offset(PAGE_OFFSET);
+			pmd = &pmd[pmd_ofs];
+		} else
+			pmd_ofs = 0;
+		
+		for (; pmd_ofs < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_ofs++) {
+			pmd_map_pfn_range(pmd, pfn, max_low_pfn);
+			pfn += PTRS_PER_PTE; 
 		}
-	}	
+	}
+}
+
+
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
+			
 }
 
 static inline int page_kills_ppro(unsigned long pagenr)
@@ -217,7 +262,7 @@
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;	
+	pkmap_page_table = pte;
 }
 
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
@@ -282,6 +327,7 @@
 	}
 
 	kernel_physical_mapping_init(pgd_base);
+	low_physical_mapping_init(pgd_base);
 	remap_numa_kva();
 
 	/*
@@ -290,19 +336,7 @@
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	page_table_range_init(vaddr, 0, pgd_base);
-
 	permanent_kmaps_init(pgd_base);
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
-#endif
 }
 
 void zap_low_mappings (void)
@@ -314,7 +348,7 @@
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+	for (i = 0; i < __USER_PTRS_PER_PGD; i++)
 #if CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -ur linux-2.5.58-clean/arch/i386/mm/pgtable.c linux-2.5.58-weirdsplit/arch/i386/mm/pgtable.c
--- linux-2.5.58-clean/arch/i386/mm/pgtable.c	Mon Jan 13 21:59:35 2003
+++ linux-2.5.58-weirdsplit/arch/i386/mm/pgtable.c	Tue Jan 14 11:45:50 2003
@@ -181,9 +181,20 @@
 			clear_page(pmd);
 			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
 		}
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		if (USER_PTRS_PER_PGD < PTRS_PER_PGD) 
+			memcpy(pgd + USER_PTRS_PER_PGD,
+				swapper_pg_dir + USER_PTRS_PER_PGD,
+				(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		if (PARTIAL_PGD) {
+			pgd_t *kpgd, *upgd;
+			pmd_t *kpmd, *upmd;
+		
+			kpgd = pgd_offset_k(TASK_SIZE);
+			upgd = pgd + __pgd_offset(TASK_SIZE);
+			kpmd = pmd_offset(kpgd, TASK_SIZE);
+			upmd = pmd_offset(upgd, TASK_SIZE);
+			memcpy(upmd, kpmd, (PTRS_PER_PMD-PARTIAL_PMD)*sizeof(pmd_t));
+		}
 	}
 	return pgd;
 out_oom:
diff -ur linux-2.5.58-clean/include/asm-alpha/pgtable.h linux-2.5.58-weirdsplit/include/asm-alpha/pgtable.h
--- linux-2.5.58-clean/include/asm-alpha/pgtable.h	Mon Jan 13 21:58:26 2003
+++ linux-2.5.58-weirdsplit/include/asm-alpha/pgtable.h	Tue Jan 14 12:04:51 2003
@@ -39,6 +39,7 @@
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Number of pointers that fit on a page:  this will go away. */
diff -ur linux-2.5.58-clean/include/asm-arm/pgtable.h linux-2.5.58-weirdsplit/include/asm-arm/pgtable.h
--- linux-2.5.58-clean/include/asm-arm/pgtable.h	Mon Jan 13 21:58:25 2003
+++ linux-2.5.58-weirdsplit/include/asm-arm/pgtable.h	Tue Jan 14 12:04:59 2003
@@ -45,6 +45,7 @@
 
 #define FIRST_USER_PGD_NR	1
 #define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /*
  * The table below defines the page protection levels that we insert into our
diff -ur linux-2.5.58-clean/include/asm-cris/pgtable.h linux-2.5.58-weirdsplit/include/asm-cris/pgtable.h
--- linux-2.5.58-clean/include/asm-cris/pgtable.h	Mon Jan 13 21:58:04 2003
+++ linux-2.5.58-weirdsplit/include/asm-cris/pgtable.h	Tue Jan 14 12:05:05 2003
@@ -203,6 +203,7 @@
  */
 
 #define USER_PTRS_PER_PGD       (TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 /*
diff -ur linux-2.5.58-clean/include/asm-i386/pgtable.h linux-2.5.58-weirdsplit/include/asm-i386/pgtable.h
--- linux-2.5.58-clean/include/asm-i386/pgtable.h	Mon Jan 13 21:59:08 2003
+++ linux-2.5.58-weirdsplit/include/asm-i386/pgtable.h	Tue Jan 14 11:45:50 2003
@@ -65,7 +65,14 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define __USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define PARTIAL_PGD	(TASK_SIZE > __USER_PTRS_PER_PGD*PGDIR_SIZE ? 1 : 0)
+#define PARTIAL_PMD	((TASK_SIZE % PGDIR_SIZE)/PMD_SIZE)
+#define USER_PTRS_PER_PGD	(PARTIAL_PGD + __USER_PTRS_PER_PGD)
+#define USER_PTRS_PER_PMD(x)	((PARTIAL_PGD && ((x)==USER_PTRS_PER_PGD-1)) ? \
+				 (PTRS_PER_PMD-PARTIAL_PMD) : \
+		 		 PTRS_PER_PMD)
+
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -ur linux-2.5.58-clean/include/asm-ia64/pgtable.h linux-2.5.58-weirdsplit/include/asm-ia64/pgtable.h
--- linux-2.5.58-clean/include/asm-ia64/pgtable.h	Mon Jan 13 21:58:27 2003
+++ linux-2.5.58-weirdsplit/include/asm-ia64/pgtable.h	Tue Jan 14 12:05:15 2003
@@ -87,6 +87,7 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(__IA64_UL(1) << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /*
diff -ur linux-2.5.58-clean/include/asm-m68k/pgtable.h linux-2.5.58-weirdsplit/include/asm-m68k/pgtable.h
--- linux-2.5.58-clean/include/asm-m68k/pgtable.h	Mon Jan 13 21:59:14 2003
+++ linux-2.5.58-weirdsplit/include/asm-m68k/pgtable.h	Tue Jan 14 12:05:19 2003
@@ -58,6 +58,7 @@
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 /* Virtual address region for use by kernel_map() */
diff -ur linux-2.5.58-clean/include/asm-mips/pgtable.h linux-2.5.58-weirdsplit/include/asm-mips/pgtable.h
--- linux-2.5.58-clean/include/asm-mips/pgtable.h	Mon Jan 13 21:58:26 2003
+++ linux-2.5.58-weirdsplit/include/asm-mips/pgtable.h	Tue Jan 14 12:05:20 2003
@@ -98,6 +98,7 @@
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define VMALLOC_START     KSEG2
diff -ur linux-2.5.58-clean/include/asm-mips64/pgtable.h linux-2.5.58-weirdsplit/include/asm-mips64/pgtable.h
--- linux-2.5.58-clean/include/asm-mips64/pgtable.h	Mon Jan 13 21:59:30 2003
+++ linux-2.5.58-weirdsplit/include/asm-mips64/pgtable.h	Tue Jan 14 12:05:23 2003
@@ -127,6 +127,7 @@
 #define PTRS_PER_PMD	1024
 #define PTRS_PER_PTE	512
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define KPTBL_PAGE_ORDER  1
diff -ur linux-2.5.58-clean/include/asm-parisc/pgtable.h linux-2.5.58-weirdsplit/include/asm-parisc/pgtable.h
--- linux-2.5.58-clean/include/asm-parisc/pgtable.h	Mon Jan 13 21:59:15 2003
+++ linux-2.5.58-weirdsplit/include/asm-parisc/pgtable.h	Tue Jan 14 12:05:28 2003
@@ -81,6 +81,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD    (1UL << (PAGE_SHIFT - PT_NLEVELS))
 #define USER_PTRS_PER_PGD       PTRS_PER_PGD
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 
 /* Definitions for 2nd level */
 #define pgtable_cache_init()	do { } while (0)
diff -ur linux-2.5.58-clean/include/asm-ppc/pgtable.h linux-2.5.58-weirdsplit/include/asm-ppc/pgtable.h
--- linux-2.5.58-clean/include/asm-ppc/pgtable.h	Mon Jan 13 21:58:24 2003
+++ linux-2.5.58-weirdsplit/include/asm-ppc/pgtable.h	Tue Jan 14 12:05:31 2003
@@ -83,6 +83,7 @@
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -ur linux-2.5.58-clean/include/asm-ppc64/pgtable.h linux-2.5.58-weirdsplit/include/asm-ppc64/pgtable.h
--- linux-2.5.58-clean/include/asm-ppc64/pgtable.h	Mon Jan 13 21:59:19 2003
+++ linux-2.5.58-weirdsplit/include/asm-ppc64/pgtable.h	Tue Jan 14 12:05:36 2003
@@ -36,6 +36,7 @@
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 #define USER_PTRS_PER_PGD	(1024)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
diff -ur linux-2.5.58-clean/include/asm-s390/pgtable.h linux-2.5.58-weirdsplit/include/asm-s390/pgtable.h
--- linux-2.5.58-clean/include/asm-s390/pgtable.h	Mon Jan 13 21:59:10 2003
+++ linux-2.5.58-weirdsplit/include/asm-s390/pgtable.h	Tue Jan 14 12:05:44 2003
@@ -74,6 +74,7 @@
  * pgd entries used up by user/kernel:
  */
 #define USER_PTRS_PER_PGD  512
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define USER_PGD_PTRS      512
 #define KERNEL_PGD_PTRS    512
 #define FIRST_USER_PGD_NR  0
diff -ur linux-2.5.58-clean/include/asm-s390x/pgtable.h linux-2.5.58-weirdsplit/include/asm-s390x/pgtable.h
--- linux-2.5.58-clean/include/asm-s390x/pgtable.h	Mon Jan 13 21:58:37 2003
+++ linux-2.5.58-weirdsplit/include/asm-s390x/pgtable.h	Tue Jan 14 12:05:46 2003
@@ -68,6 +68,7 @@
  * pgd entries used up by user/kernel:
  */
 #define USER_PTRS_PER_PGD  2048
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define USER_PGD_PTRS      2048
 #define KERNEL_PGD_PTRS    2048
 #define FIRST_USER_PGD_NR  0
diff -ur linux-2.5.58-clean/include/asm-sh/pgtable.h linux-2.5.58-weirdsplit/include/asm-sh/pgtable.h
--- linux-2.5.58-clean/include/asm-sh/pgtable.h	Mon Jan 13 21:59:34 2003
+++ linux-2.5.58-weirdsplit/include/asm-sh/pgtable.h	Tue Jan 14 12:05:50 2003
@@ -106,6 +106,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PTE_PHYS_MASK	0x1ffff000
diff -ur linux-2.5.58-clean/include/asm-sparc/pgtable.h linux-2.5.58-weirdsplit/include/asm-sparc/pgtable.h
--- linux-2.5.58-clean/include/asm-sparc/pgtable.h	Mon Jan 13 21:58:56 2003
+++ linux-2.5.58-weirdsplit/include/asm-sparc/pgtable.h	Tue Jan 14 12:05:54 2003
@@ -109,6 +109,7 @@
 #define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
 #define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
 #define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define PAGE_NONE      __pgprot(BTFIXUP_INT(page_none))
diff -ur linux-2.5.58-clean/include/asm-sparc64/pgtable.h linux-2.5.58-weirdsplit/include/asm-sparc64/pgtable.h
--- linux-2.5.58-clean/include/asm-sparc64/pgtable.h	Mon Jan 13 21:58:04 2003
+++ linux-2.5.58-weirdsplit/include/asm-sparc64/pgtable.h	Tue Jan 14 12:06:02 2003
@@ -93,6 +93,7 @@
 /* Kernel has a separate 44bit address space. */
 #define USER_PTRS_PER_PGD	((const int)(test_thread_flag(TIF_32BIT)) ? \
 				 (1) : (PTRS_PER_PGD))
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define pte_ERROR(e)	__builtin_trap()
diff -ur linux-2.5.58-clean/include/asm-um/pgtable.h linux-2.5.58-weirdsplit/include/asm-um/pgtable.h
--- linux-2.5.58-clean/include/asm-um/pgtable.h	Mon Jan 13 21:59:35 2003
+++ linux-2.5.58-weirdsplit/include/asm-um/pgtable.h	Tue Jan 14 12:06:07 2003
@@ -37,6 +37,7 @@
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR       0
 
 #define pte_ERROR(e) \
diff -ur linux-2.5.58-clean/include/asm-x86_64/pgtable.h linux-2.5.58-weirdsplit/include/asm-x86_64/pgtable.h
--- linux-2.5.58-clean/include/asm-x86_64/pgtable.h	Mon Jan 13 21:59:07 2003
+++ linux-2.5.58-weirdsplit/include/asm-x86_64/pgtable.h	Tue Jan 14 12:06:17 2003
@@ -109,6 +109,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PTRS_PER_PMD(x)	(PTRS_PER_PMD)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
diff -ur linux-2.5.58-clean/mm/memory.c linux-2.5.58-weirdsplit/mm/memory.c
--- linux-2.5.58-clean/mm/memory.c	Mon Jan 13 21:58:39 2003
+++ linux-2.5.58-weirdsplit/mm/memory.c	Tue Jan 14 11:51:55 2003
@@ -99,10 +99,11 @@
 	pte_free_tlb(tlb, page);
 }
 
-static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
+static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t *pgd, unsigned long pgdi)
 {
 	int j;
 	pmd_t * pmd;
+	pgd_t *dir = pgd + pgdi;
 
 	if (pgd_none(*dir))
 		return;
@@ -113,7 +114,7 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
+	for (j = 0; j < USER_PTRS_PER_PMD(pgdi) ; j++)
 		free_one_pmd(tlb, pmd+j);
 	pmd_free_tlb(tlb, pmd);
 }
@@ -127,11 +128,11 @@
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
 

--------------020005040607090909070800
Content-Type: text/plain;
 name="3.5_to_0.5-split.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3.5_to_0.5-split.patch"

--- linux-2.5.53/arch/i386/vmlinux.lds.S	Mon Dec 23 21:19:47 2002
+++ linux-2.5.53-weirdsplit/arch/i386/vmlinux.lds.S	Tue Dec 31 15:47:58 2002
@@ -7,7 +7,7 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = 0xE0000000 + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
--- linux-2.5.53/include/asm-i386/page.h	Mon Dec 23 21:19:45 2002
+++ linux-2.5.53-weirdsplit/include/asm-i386/page.h	Tue Dec 31 15:48:25 2002
@@ -89,7 +89,7 @@
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET		(0xC0000000)
+#define __PAGE_OFFSET		(0xE0000000)
 
 /*
  * This much address space is reserved for vmalloc() and iomap()

--------------020005040607090909070800--

