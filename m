Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTAGT6k>; Tue, 7 Jan 2003 14:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbTAGT6k>; Tue, 7 Jan 2003 14:58:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37276 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267439AbTAGT6h>;
	Tue, 7 Jan 2003 14:58:37 -0500
Message-ID: <3E1B334E.8030807@us.ibm.com>
Date: Tue, 07 Jan 2003 12:06:38 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux-mm@kvack.org
Subject: [RFC][PATCH] allow bigger PAGE_OFFSET with PAE
Content-Type: multipart/mixed;
 boundary="------------060309090405050403020204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309090405050403020204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently, with PAE enabled, we require the user:kernel split to occur
on a PMD boundary, so it can only be done in 1GB increments.  There
are 2 reasons for this.  First, kernel_physical_mapping_init()
assumes, when it is initializing the kernel's PMD entries, that they
start at offset 0 inside the PMD.  This is fixed by starting them at 
__pmd_offset(PAGE_OFFSET) instead.

Secondly, secondary SMP cpus require that the trampoline code be
identity mapped (map virtual addresses to the same as physical ones). 
  Right now, this is accomplished by setting the first PGD entry to
be the same as the last.  This is OK, as long as that PGD is
eventually mapping to physical 0x00000000.  My changes above break
that.  So, I allocate another PMD, and use it for the identity
mapping.  The current code is in place to allocate PTE if you're
using PAE without PSE support, but there is nothing to free them.  Any
suggestions for a clean way to do this?

Also, this gets the kernel's pagetables right, but neglects 
userspace's for now.  pgd_alloc() needs to be fixed to allocate 
another PMD, if the split isn't PMD-alighed.
-- 
Dave Hansen
haveblue@us.ibm.com


--------------060309090405050403020204
Content-Type: text/plain;
 name="unaligned-page_offset-pae-2.5.53-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unaligned-page_offset-pae-2.5.53-3.patch"

diff -ur linux-2.5.53-clean/arch/i386/mm/init.c linux-2.5.53-weirdsplit/arch/i386/mm/init.c
--- linux-2.5.53-clean/arch/i386/mm/init.c	Mon Dec 23 21:21:03 2002
+++ linux-2.5.53-weirdsplit/arch/i386/mm/init.c	Mon Jan  6 09:41:02 2003
@@ -117,6 +117,24 @@
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
@@ -127,8 +145,7 @@
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
-	int pgd_ofs, pmd_ofs, pte_ofs;
+	int pgd_ofs, pmd_ofs;
 
 	pgd_ofs = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + pgd_ofs;
@@ -138,19 +155,47 @@
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
+		printk("PAE enabled, but no support for PSE (large pages)!");
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
@@ -213,7 +258,7 @@
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;	
+	pkmap_page_table = pte;
 }
 
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
@@ -278,6 +323,7 @@
 	}
 
 	kernel_physical_mapping_init(pgd_base);
+	low_physical_mapping_init(pgd_base);
 	remap_numa_kva();
 
 	/*
@@ -286,19 +332,7 @@
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
@@ -310,6 +344,7 @@
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
+	free_page(pgd_page(swapper_pg_dir[0]));
 	for (i = 0; i < USER_PTRS_PER_PGD; i++)
 #if CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));

--------------060309090405050403020204--

