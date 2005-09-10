Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVIJR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVIJR6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVIJR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 13:58:13 -0400
Received: from xenotime.net ([66.160.160.81]:48332 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932093AbVIJR6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 13:58:13 -0400
Date: Sat, 10 Sep 2005 10:58:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, chris@zankel.net
Subject: [PATCH] feature removal of io_remap_page_range()
Message-Id: <20050910105810.1ef1bade.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

As written in Documentation/feature-removal-schedule.txt,
remove the io_remap_page_range() kernel API.

This leaves one remaining caller at
  arch/xtensa/kernel/pci.c:405:
and the xtensa maintainer (Chris Zankel) has committed to
sending a patch to convert this call this week.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/feature-removal-schedule.txt |    9 ---------
 include/asm-alpha/pgtable.h                |    7 -------
 include/asm-arm/pgtable.h                  |    5 +----
 include/asm-arm26/pgtable.h                |    5 +----
 include/asm-frv/pgtable.h                  |    3 ---
 include/asm-h8300/pgtable.h                |    2 --
 include/asm-i386/pgtable.h                 |    3 ---
 include/asm-ia64/pgtable.h                 |    4 ----
 include/asm-m32r/pgtable.h                 |    3 ---
 include/asm-m68k/pgtable.h                 |    3 ---
 include/asm-m68knommu/pgtable.h            |    2 --
 include/asm-mips/pgtable.h                 |   12 ------------
 include/asm-parisc/pgtable.h               |    3 ---
 include/asm-ppc/pgtable.h                  |   11 -----------
 include/asm-sh/pgtable.h                   |    3 ---
 include/asm-sh64/pgtable.h                 |    3 ---
 include/asm-x86_64/pgtable.h               |    3 ---
 include/asm-xtensa/pgtable.h               |    6 +++---
 18 files changed, 5 insertions(+), 82 deletions(-)

diff -Naurp linux-2613-git9/Documentation/feature-removal-schedule.txt~ioremap_pgrange_rm linux-2613-git9/Documentation/feature-removal-schedule.txt
--- linux-2613-git9/Documentation/feature-removal-schedule.txt~ioremap_pgrange_rm	2005-09-09 20:14:32.000000000 -0700
+++ linux-2613-git9/Documentation/feature-removal-schedule.txt	2005-09-09 20:41:34.000000000 -0700
@@ -25,15 +25,6 @@ Who:	Pavel Machek <pavel@suse.cz>
 
 ---------------------------
 
-What:	io_remap_page_range() (macro or function)
-When:	September 2005
-Why:	Replaced by io_remap_pfn_range() which allows more memory space
-	addressabilty (by using a pfn) and supports sparc & sparc64
-	iospace as part of the pfn.
-Who:	Randy Dunlap <rddunlap@osdl.org>
-
----------------------------
-
 What:	RAW driver (CONFIG_RAW_DRIVER)
 When:	December 2005
 Why:	declared obsolete since kernel 2.6.3
diff -Naurp linux-2613-git9/include/asm-alpha/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-alpha/pgtable.h
--- linux-2613-git9/include/asm-alpha/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-alpha/pgtable.h	2005-09-09 20:26:27.000000000 -0700
@@ -339,13 +339,6 @@ extern inline pte_t mk_swap_pte(unsigned
 #define kern_addr_valid(addr)	(1)
 #endif
 
-#define io_remap_page_range(vma, start, busaddr, size, prot)	\
-({								\
-	void *va = (void __force *)ioremap(busaddr, size);	\
-	unsigned long pfn = virt_to_phys(va) >> PAGE_SHIFT;	\
-	remap_pfn_range(vma, start, pfn, size, prot);		\
-})
-
 #define io_remap_pfn_range(vma, start, pfn, size, prot)	\
 		remap_pfn_range(vma, start, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-arm/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-arm/pgtable.h
--- linux-2613-git9/include/asm-arm/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-arm/pgtable.h	2005-09-09 20:27:43.000000000 -0700
@@ -445,12 +445,9 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
 #define HAVE_ARCH_UNMAPPED_AREA
 
 /*
- * remap a physical address `phys' of size `size' with page protection `prot'
+ * remap a physical page `pfn' of size `size' with page protection `prot'
  * into virtual address `from'
  */
-#define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma,from,pfn,size,prot) \
 		remap_pfn_range(vma, from, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-arm26/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-arm26/pgtable.h
--- linux-2613-git9/include/asm-arm26/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-arm26/pgtable.h	2005-09-09 20:28:33.000000000 -0700
@@ -294,12 +294,9 @@ static inline pte_t mk_pte_phys(unsigned
 #include <asm-generic/pgtable.h>
 
 /*
- * remap a physical address `phys' of size `size' with page protection `prot'
+ * remap a physical page `pfn' of size `size' with page protection `prot'
  * into virtual address `from'
  */
-#define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma,from,pfn,size,prot) \
 		remap_pfn_range(vma, from, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-frv/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-frv/pgtable.h
--- linux-2613-git9/include/asm-frv/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-frv/pgtable.h	2005-09-09 20:29:16.000000000 -0700
@@ -500,9 +500,6 @@ static inline int pte_file(pte_t pte)
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-h8300/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-h8300/pgtable.h
--- linux-2613-git9/include/asm-h8300/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-h8300/pgtable.h	2005-09-09 20:29:45.000000000 -0700
@@ -52,8 +52,6 @@ extern int is_in_rom(unsigned long);
  * No page table caches to initialise
  */
 #define pgtable_cache_init()   do { } while (0)
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
diff -Naurp linux-2613-git9/include/asm-i386/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-i386/pgtable.h
--- linux-2613-git9/include/asm-i386/pgtable.h~ioremap_pgrange_rm	2005-09-09 20:14:37.000000000 -0700
+++ linux-2613-git9/include/asm-i386/pgtable.h	2005-09-09 20:30:14.000000000 -0700
@@ -431,9 +431,6 @@ extern void noexec_setup(const char *str
 #define kern_addr_valid(addr)	(1)
 #endif /* CONFIG_FLATMEM */
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-ia64/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-ia64/pgtable.h
--- linux-2613-git9/include/asm-ia64/pgtable.h~ioremap_pgrange_rm	2005-09-09 20:14:37.000000000 -0700
+++ linux-2613-git9/include/asm-ia64/pgtable.h	2005-09-09 20:30:54.000000000 -0700
@@ -443,10 +443,6 @@ extern void paging_init (void);
 #define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
 #define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
 
-/* XXX is this right? */
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-m32r/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-m32r/pgtable.h
--- linux-2613-git9/include/asm-m32r/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-m32r/pgtable.h	2005-09-09 20:31:17.000000000 -0700
@@ -378,9 +378,6 @@ static inline void pmd_set(pmd_t * pmdp,
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)	\
-	remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)	\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-m68k/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-m68k/pgtable.h
--- linux-2613-git9/include/asm-m68k/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-m68k/pgtable.h	2005-09-09 20:31:42.000000000 -0700
@@ -141,9 +141,6 @@ static inline void update_mmu_cache(stru
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-m68knommu/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-m68knommu/pgtable.h
--- linux-2613-git9/include/asm-m68knommu/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-m68knommu/pgtable.h	2005-09-09 20:32:17.000000000 -0700
@@ -56,8 +56,6 @@ extern int is_in_rom(unsigned long);
  * No page table caches to initialise.
  */
 #define pgtable_cache_init()	do { } while (0)
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
diff -Naurp linux-2613-git9/include/asm-mips/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-mips/pgtable.h
--- linux-2613-git9/include/asm-mips/pgtable.h~ioremap_pgrange_rm	2005-09-09 20:14:37.000000000 -0700
+++ linux-2613-git9/include/asm-mips/pgtable.h	2005-09-09 20:34:18.000000000 -0700
@@ -358,16 +358,6 @@ static inline void update_mmu_cache(stru
 extern phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size);
 extern int remap_pfn_range(struct vm_area_struct *vma, unsigned long from, unsigned long pfn, unsigned long size, pgprot_t prot);
 
-static inline int io_remap_page_range(struct vm_area_struct *vma,
-		unsigned long vaddr,
-		unsigned long paddr,
-		unsigned long size,
-		pgprot_t prot)
-{
-	phys_t phys_addr_high = fixup_bigphys_addr(paddr, size);
-	return remap_pfn_range(vma, vaddr, phys_addr_high >> PAGE_SHIFT, size, prot);
-}
-
 static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 		unsigned long vaddr,
 		unsigned long pfn,
@@ -378,8 +368,6 @@ static inline int io_remap_pfn_range(str
 	return remap_pfn_range(vma, vaddr, pfn, size, prot);
 }
 #else
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif
diff -Naurp linux-2613-git9/include/asm-parisc/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-parisc/pgtable.h
--- linux-2613-git9/include/asm-parisc/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-parisc/pgtable.h	2005-09-09 20:34:45.000000000 -0700
@@ -498,9 +498,6 @@ static inline void ptep_set_wrprotect(st
 
 #endif /* !__ASSEMBLY__ */
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-ppc/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-ppc/pgtable.h
--- linux-2613-git9/include/asm-ppc/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-ppc/pgtable.h	2005-09-09 20:35:26.000000000 -0700
@@ -812,15 +812,6 @@ extern void kernel_set_cachemode (unsign
 #ifdef CONFIG_PHYS_64BIT
 extern int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 			unsigned long paddr, unsigned long size, pgprot_t prot);
-static inline int io_remap_page_range(struct vm_area_struct *vma,
-					unsigned long vaddr,
-					unsigned long paddr,
-					unsigned long size,
-					pgprot_t prot)
-{
-	phys_addr_t paddr64 = fixup_bigphys_addr(paddr, size);
-	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
-}
 
 static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 					unsigned long vaddr,
@@ -832,8 +823,6 @@ static inline int io_remap_pfn_range(str
 	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
 }
 #else
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif
diff -Naurp linux-2613-git9/include/asm-sh/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-sh/pgtable.h
--- linux-2613-git9/include/asm-sh/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-sh/pgtable.h	2005-09-09 20:36:36.000000000 -0700
@@ -277,9 +277,6 @@ typedef pte_t *pte_addr_t;
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-sh64/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-sh64/pgtable.h
--- linux-2613-git9/include/asm-sh64/pgtable.h~ioremap_pgrange_rm	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git9/include/asm-sh64/pgtable.h	2005-09-09 20:37:09.000000000 -0700
@@ -482,9 +482,6 @@ extern void update_mmu_cache(struct vm_a
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-x86_64/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-x86_64/pgtable.h
--- linux-2613-git9/include/asm-x86_64/pgtable.h~ioremap_pgrange_rm	2005-09-09 20:14:38.000000000 -0700
+++ linux-2613-git9/include/asm-x86_64/pgtable.h	2005-09-09 20:37:47.000000000 -0700
@@ -421,9 +421,6 @@ extern inline pte_t pte_modify(pte_t pte
 
 extern int kern_addr_valid(unsigned long addr); 
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff -Naurp linux-2613-git9/include/asm-xtensa/pgtable.h~ioremap_pgrange_rm linux-2613-git9/include/asm-xtensa/pgtable.h
--- linux-2613-git9/include/asm-xtensa/pgtable.h~ioremap_pgrange_rm	2005-09-09 20:14:38.000000000 -0700
+++ linux-2613-git9/include/asm-xtensa/pgtable.h	2005-09-09 20:39:41.000000000 -0700
@@ -441,11 +441,11 @@ extern  void update_mmu_cache(struct vm_
 			      unsigned long address, pte_t pte);
 
 /*
- * remap a physical address `phys' of size `size' with page protection `prot'
+ * remap a physical page `pfn' of size `size' with page protection `prot'
  * into virtual address `from'
  */
-#define io_remap_page_range(vma,from,phys,size,prot) \
-                remap_pfn_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
+#define io_remap_pfn_range(vma,from,pfn,size,prot) \
+                remap_pfn_range(vma, from, pfn, size, prot)
 
 
 /* No page table caches to init */


---

