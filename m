Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317850AbSFMVwT>; Thu, 13 Jun 2002 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSFMVwS>; Thu, 13 Jun 2002 17:52:18 -0400
Received: from psmtp2.dnsg.net ([193.168.128.42]:30375 "HELO psmtp2.dnsg.net")
	by vger.kernel.org with SMTP id <S317850AbSFMVvY>;
	Thu, 13 Jun 2002 17:51:24 -0400
Subject: [PATCH][2.5.21] memory management change request.
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2002 01:46:48 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17IeJ2-0000GT-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to propose a change to the memory management to be able to optimize
the tlb handling on s/390. There are two major differences between the way
s/390 copes with tlbs and the way the rest of the world does it:

1) the dirty and the referenced bit is kept in the storage key (there is
   one for every physical page) and not in the page table entries. This
   difference is the reason for the new function "flush_tlb_dirty". In
   mm/msync.c:filemap_sync_pte() the dirty bit is 'moved' from the hardware
   to the page structure. The dirty bit is tested and cleared with
   ptep_test_and_clear_dirty and if it is set the tlb for the page is
   flushed and the dirty bit in the page structure is set:

	if (!PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
		flush_tlb_page(vma, address);
		set_page_dirty(page);
	}

   This is quite suboptimal on s/390 because the ptep_test_and_clear_dirty
   has already done everything that is needed. The tlb has nothing to do
   with the dirty bit on s/390! So we would like to replace flush_tlb_page
   with a new function flush_tlb_dirty:

	if (!PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
		flush_tlb_dirty(vma, address);
		set_page_dirty(page);
	}

   flush_tlb_dirty is defined as flush_tlb_page on all architectures
   but s/390. On s/390 we simply do nothing and do not have to take the
   performance penalty of a tlb flush.
   
2) s/390 has an instruction called ipte (invalidate page table entry) that
   is used to get rid of virtual pages. It does two things, first it sets
   the invalid bit in the pte and second it flushes the tlbs for this
   page on all cpus. Very handy but it requires that the pte it should
   flush is still valid. The introduction of establish_pte was a step
   into the right direction but it is defined in mm/memory.c. We need
   to be able to replace this function with a special s/390 variant.
   I tried to move establish_pte to include/asm/pgtable.h but this
   failed because of include order conflicts. Therefore I moved it
   to include/asm/pgalloc.h (and renamed it to ptep_establish). To make
   ptep_establish available on architectures that do not want to replace
   it (all others), I added asm-generic/pgalloc.h and an include in
   asm-<arch>/pgalloc.h for all architectures != s390. The same problem
   as with establish_pte exists with invalidating ptes. The sequence
   used e.g. in mm/vmscan.c is

	flush_cache_page(vma, address);
	pte = ptep_get_and_clear(page_table);
	flush_tlb_page(vma, addess);

   Again this makes it impossible to use the ipte in flush_tlb_page. The
   sequence of these tree lines is replaced by ptep_invalidate. The "old"
   implementation is moved to asm-generic/pgalloc.h and s/390 has its own
   implementation with ipte.

blue skies,
  Martin.

diff -urN linux-2.5.21/include/asm-alpha/pgalloc.h linux-2.5.21-ptep/include/asm-alpha/pgalloc.h
--- linux-2.5.21/include/asm-alpha/pgalloc.h	Sun Jun  9 07:26:29 2002
+++ linux-2.5.21-ptep/include/asm-alpha/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -72,4 +72,6 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ALPHA_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-alpha/tlbflush.h linux-2.5.21-ptep/include/asm-alpha/tlbflush.h
--- linux-2.5.21/include/asm-alpha/tlbflush.h	Sun Jun  9 07:26:23 2002
+++ linux-2.5.21-ptep/include/asm-alpha/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -133,6 +133,8 @@
 		flush_tlb_other(mm);
 }
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 /* Flush a specified range of user mapping.  On the Alpha we flush
    the whole user tlb.  */
 static inline void
@@ -149,6 +151,7 @@
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 extern void flush_tlb_range(struct vm_area_struct *, unsigned long,
 			    unsigned long);
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 
 #endif /* CONFIG_SMP */
 
diff -urN linux-2.5.21/include/asm-arm/pgalloc.h linux-2.5.21-ptep/include/asm-arm/pgalloc.h
--- linux-2.5.21/include/asm-arm/pgalloc.h	Sun Jun  9 07:31:24 2002
+++ linux-2.5.21-ptep/include/asm-arm/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -31,4 +31,6 @@
 
 #define check_pgt_cache()		do { } while (0)
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.5.21/include/asm-arm/proc-armo/pgalloc.h linux-2.5.21-ptep/include/asm-arm/proc-armo/pgalloc.h
--- linux-2.5.21/include/asm-arm/proc-armo/pgalloc.h	Sun Jun  9 07:28:14 2002
+++ linux-2.5.21-ptep/include/asm-arm/proc-armo/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -42,3 +42,5 @@
 #define pte_alloc_one(mm,addr)	((struct page *)pte_alloc_one_kernel(mm,addr))
 #define pte_free(pte)		pte_free_kernel((pte_t *)pte)
 #define pmd_populate(mm,pmdp,ptep) pmd_populate_kernel(mm,pmdp,(pte_t *)ptep)
+
+#include <asm-generic/pgalloc.h>
diff -urN linux-2.5.21/include/asm-arm/proc-armo/tlbflush.h linux-2.5.21-ptep/include/asm-arm/proc-armo/tlbflush.h
--- linux-2.5.21/include/asm-arm/proc-armo/tlbflush.h	Sun Jun  9 07:26:57 2002
+++ linux-2.5.21-ptep/include/asm-arm/proc-armo/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -5,12 +5,14 @@
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 #define flush_tlb_all()				memc_update_all()
 #define flush_tlb_mm(mm)			memc_update_mm(mm)
 #define flush_tlb_range(vma,start,end)		\
 		do { memc_update_mm(vma->vm_mm); (void)(start); (void)(end); } while (0)
 #define flush_tlb_page(vma, vmaddr)		do { } while (0)
+#define flush_tlb_dirty(vma, vmaddr)		do { } while (0)
 
 /*
  * The following handle the weird MEMC chip
diff -urN linux-2.5.21/include/asm-arm/proc-armv/pgalloc.h linux-2.5.21-ptep/include/asm-arm/proc-armv/pgalloc.h
--- linux-2.5.21/include/asm-arm/proc-armv/pgalloc.h	Sun Jun  9 07:26:24 2002
+++ linux-2.5.21-ptep/include/asm-arm/proc-armv/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -122,3 +122,6 @@
 	pmd_val(pmd) += 256 * sizeof(pte_t);
 	set_pmd(pmdp + 1, pmd);
 }
+
+#include <asm-generic/pgalloc.h>
+
diff -urN linux-2.5.21/include/asm-arm/proc-armv/tlbflush.h linux-2.5.21-ptep/include/asm-arm/proc-armv/tlbflush.h
--- linux-2.5.21/include/asm-arm/proc-armv/tlbflush.h	Sun Jun  9 07:28:02 2002
+++ linux-2.5.21-ptep/include/asm-arm/proc-armv/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -67,6 +67,7 @@
 #define flush_tlb_mm(mm)		__cpu_flush_user_tlb_mm(mm)
 #define flush_tlb_range(vma,start,end)	__cpu_flush_user_tlb_range(start,end,vma)
 #define flush_tlb_page(vma,vaddr)	__cpu_flush_user_tlb_page(vaddr,vma)
+#define flush_tlb_dirty(vma,vaddr)	__cpu_flush_user_tlb_page(vaddr,vma)
 #define flush_tlb_kernel_range(s,e)	__cpu_flush_kern_tlb_range(s,e)
 #define flush_tlb_kernel_page(kaddr)	__cpu_flush_kern_tlb_page(kaddr)
 
diff -urN linux-2.5.21/include/asm-cris/pgalloc.h linux-2.5.21-ptep/include/asm-cris/pgalloc.h
--- linux-2.5.21/include/asm-cris/pgalloc.h	Sun Jun  9 07:31:19 2002
+++ linux-2.5.21-ptep/include/asm-cris/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -112,4 +112,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.5.21/include/asm-cris/pgtable.h linux-2.5.21-ptep/include/asm-cris/pgtable.h
--- linux-2.5.21/include/asm-cris/pgtable.h	Sun Jun  9 07:26:34 2002
+++ linux-2.5.21-ptep/include/asm-cris/pgtable.h	Thu Jun 13 21:06:11 2002
@@ -135,7 +135,7 @@
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 
 extern void flush_tlb_all(void);
@@ -145,6 +145,8 @@
 extern void flush_tlb_range(struct vm_area_struct *vma,
 			    unsigned long start,
 			    unsigned long end);
+
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
                                       unsigned long start, unsigned long end)
diff -urN linux-2.5.21/include/asm-generic/pgalloc.h linux-2.5.21-ptep/include/asm-generic/pgalloc.h
--- linux-2.5.21/include/asm-generic/pgalloc.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.21-ptep/include/asm-generic/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -0,0 +1,29 @@
+#ifndef _ASM_GENERIC_PGALLOC_H
+#define _ASM_GENERIC_PGALLOC_H
+
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+static inline void
+ptep_establish(struct vm_area_struct *vma, 
+	       unsigned long address, pte_t *ptep, pte_t entry)
+{
+	set_pte(ptep, entry);
+	flush_tlb_page(vma, address);
+	update_mmu_cache(vma, address, entry);
+}
+
+static inline pte_t
+ptep_invalidate(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep)
+{
+	pte_t pte;
+
+	flush_cache_page(vma, address);
+        pte = ptep_get_and_clear(ptep);
+	flush_tlb_page(vma, address);
+	return pte;
+}
+
+#endif /* _ASM_GENERIC_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-i386/pgalloc.h linux-2.5.21-ptep/include/asm-i386/pgalloc.h
--- linux-2.5.21/include/asm-i386/pgalloc.h	Sun Jun  9 07:26:55 2002
+++ linux-2.5.21-ptep/include/asm-i386/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -52,4 +52,6 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _I386_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-i386/tlbflush.h linux-2.5.21-ptep/include/asm-i386/tlbflush.h
--- linux-2.5.21/include/asm-i386/tlbflush.h	Sun Jun  9 07:29:28 2002
+++ linux-2.5.21-ptep/include/asm-i386/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -62,6 +62,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  *
  * ..but the i386 has somewhat limited tlb flushing capabilities,
  * and page-granular flushes are available only on i486 and up.
@@ -86,6 +87,8 @@
 		__flush_tlb_one(addr);
 }
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
@@ -106,6 +109,7 @@
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 
 #define flush_tlb()	flush_tlb_current_task()
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 
 static inline void flush_tlb_range(struct vm_area_struct * vma, unsigned long start, unsigned long end)
 {
diff -urN linux-2.5.21/include/asm-ia64/pgalloc.h linux-2.5.21-ptep/include/asm-ia64/pgalloc.h
--- linux-2.5.21/include/asm-ia64/pgalloc.h	Sun Jun  9 07:26:35 2002
+++ linux-2.5.21-ptep/include/asm-ia64/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -181,4 +181,6 @@
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_IA64_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-ia64/tlbflush.h linux-2.5.21-ptep/include/asm-ia64/tlbflush.h
--- linux-2.5.21/include/asm-ia64/tlbflush.h	Sun Jun  9 07:28:50 2002
+++ linux-2.5.21-ptep/include/asm-ia64/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -63,6 +63,8 @@
 #endif
 }
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, addr)
+
 /*
  * Flush the TLB entries mapping the virtually mapped linear page
  * table corresponding to address range [START-END).
diff -urN linux-2.5.21/include/asm-m68k/pgalloc.h linux-2.5.21-ptep/include/asm-m68k/pgalloc.h
--- linux-2.5.21/include/asm-m68k/pgalloc.h	Sun Jun  9 07:30:07 2002
+++ linux-2.5.21-ptep/include/asm-m68k/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -16,4 +16,6 @@
 #include <asm/motorola_pgalloc.h>
 #endif
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* M68K_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-m68k/tlbflush.h linux-2.5.21-ptep/include/asm-m68k/tlbflush.h
--- linux-2.5.21/include/asm-m68k/tlbflush.h	Sun Jun  9 07:27:43 2002
+++ linux-2.5.21-ptep/include/asm-m68k/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -73,6 +73,8 @@
 		__flush_tlb_one(addr);
 }
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
@@ -166,6 +168,8 @@
 	sun3_put_context(oldctx);
 
 }
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 /* Flush a range of pages from TLB. */
 
 static inline void flush_tlb_range (struct vm_area_struct *vma,
diff -urN linux-2.5.21/include/asm-mips/pgalloc.h linux-2.5.21-ptep/include/asm-mips/pgalloc.h
--- linux-2.5.21/include/asm-mips/pgalloc.h	Sun Jun  9 07:30:22 2002
+++ linux-2.5.21-ptep/include/asm-mips/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -18,6 +18,7 @@
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
  *  - flush_tlb_page(vma, vmaddr) flushes a single page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
@@ -25,6 +26,8 @@
 			       unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 extern inline void flush_tlb_pgtables(struct mm_struct *mm,
                                       unsigned long start, unsigned long end)
 {
@@ -176,5 +179,7 @@
 #define pgd_populate(mm, pmd, pte)	BUG()
 
 extern int do_check_pgt_cache(int, int);
+
+#include <asm-generic/pgalloc.h>
 
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-mips64/pgalloc.h linux-2.5.21-ptep/include/asm-mips64/pgalloc.h
--- linux-2.5.21/include/asm-mips64/pgalloc.h	Sun Jun  9 07:28:42 2002
+++ linux-2.5.21-ptep/include/asm-mips64/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -18,6 +18,7 @@
  *  - flush_tlb_page(vma, vmaddr) flushes a single page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 extern void (*_flush_tlb_all)(void);
 extern void (*_flush_tlb_mm)(struct mm_struct *mm);
@@ -31,6 +32,7 @@
 #define flush_tlb_mm(mm)		_flush_tlb_mm(mm)
 #define flush_tlb_range(vma,vmaddr,end)	_flush_tlb_range(vma, vmaddr, end)
 #define flush_tlb_page(vma,page)	_flush_tlb_page(vma, page)
+#define flush_tlb_dirty(vma,vmaddr)	_flush_tlb_page(vma, vmaddr)
 
 #else /* CONFIG_SMP */
 
@@ -39,6 +41,8 @@
 extern void flush_tlb_range(struct vm_area_struct *, unsigned long, unsigned long);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 
+#define flush_tlb_dirty(vma,vmaddr) flush_tlb_page(vma,vmaddr)
+
 #endif /* CONFIG_SMP */
 
 extern inline void flush_tlb_pgtables(struct mm_struct *mm,
@@ -196,5 +200,7 @@
 extern pmd_t kpmdtbl[PTRS_PER_PMD];
 
 extern int do_check_pgt_cache(int, int);
+
+#include <asm-generic/pgalloc.h>
 
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-parisc/pgalloc.h linux-2.5.21-ptep/include/asm-parisc/pgalloc.h
--- linux-2.5.21/include/asm-parisc/pgalloc.h	Sun Jun  9 07:31:28 2002
+++ linux-2.5.21-ptep/include/asm-parisc/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -200,6 +200,8 @@
 		
 }
 
+#define flush_tlb_dirty(vma,vmaddr) flush_tlb_page(vma,vmaddr)
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
@@ -403,5 +405,7 @@
 }
 
 extern int do_check_pgt_cache(int, int);
+
+#include <asm-generic/pgalloc.h>
 
 #endif
diff -urN linux-2.5.21/include/asm-ppc/pgalloc.h linux-2.5.21-ptep/include/asm-ppc/pgalloc.h
--- linux-2.5.21/include/asm-ppc/pgalloc.h	Sun Jun  9 07:26:26 2002
+++ linux-2.5.21-ptep/include/asm-ppc/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -37,5 +37,7 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _PPC_PGALLOC_H */
 #endif /* __KERNEL__ */
diff -urN linux-2.5.21/include/asm-ppc/tlbflush.h linux-2.5.21-ptep/include/asm-ppc/tlbflush.h
--- linux-2.5.21/include/asm-ppc/tlbflush.h	Sun Jun  9 07:27:39 2002
+++ linux-2.5.21-ptep/include/asm-ppc/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -36,6 +36,7 @@
 static inline void flush_tlb_kernel_range(unsigned long start,
 				unsigned long end)
 	{ __tlbia(); }
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 #define update_mmu_cache(vma, addr, pte)	do { } while (0)
 
 #elif defined(CONFIG_8xx)
@@ -54,6 +55,7 @@
 static inline void flush_tlb_kernel_range(unsigned long start,
 				unsigned long end)
 	{ __tlbia(); }
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 #define update_mmu_cache(vma, addr, pte)	do { } while (0)
 
 #else	/* 6xx, 7xx, 7xxx cpus */
@@ -66,6 +68,7 @@
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 /*
  * This gets called at the end of handling a page fault, when
  * the kernel has put a new PTE into the page table for the process.
diff -urN linux-2.5.21/include/asm-ppc64/pgalloc.h linux-2.5.21-ptep/include/asm-ppc64/pgalloc.h
--- linux-2.5.21/include/asm-ppc64/pgalloc.h	Sun Jun  9 07:26:52 2002
+++ linux-2.5.21-ptep/include/asm-ppc64/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -89,4 +89,6 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _PPC64_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-ppc64/tlbflush.h linux-2.5.21-ptep/include/asm-ppc64/tlbflush.h
--- linux-2.5.21/include/asm-ppc64/tlbflush.h	Sun Jun  9 07:26:22 2002
+++ linux-2.5.21-ptep/include/asm-ppc64/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -13,6 +13,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 
 extern void flush_tlb_mm(struct mm_struct *mm);
@@ -24,6 +25,8 @@
 
 #define flush_tlb_kernel_range(start, end) \
 	__flush_tlb_range(&init_mm, (start), (end))
+
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
diff -urN linux-2.5.21/include/asm-s390/pgalloc.h linux-2.5.21-ptep/include/asm-s390/pgalloc.h
--- linux-2.5.21/include/asm-s390/pgalloc.h	Sun Jun  9 07:30:36 2002
+++ linux-2.5.21-ptep/include/asm-s390/pgalloc.h	Thu Jun 13 20:59:37 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.21/include/asm-s390/tlbflush.h linux-2.5.21-ptep/include/asm-s390/tlbflush.h
--- linux-2.5.21/include/asm-s390/tlbflush.h	Sun Jun  9 07:31:29 2002
+++ linux-2.5.21-ptep/include/asm-s390/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -15,6 +15,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 
 /*
@@ -53,6 +54,11 @@
 {
 	local_flush_tlb();
 }
+static inline void flush_tlb_dirty(struct vm_area_struct *vma,
+				   unsigned long addr)
+{
+	/* No need to flush TLB; bits are in the storage key */
+}
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
@@ -117,6 +123,11 @@
 				  unsigned long addr)
 {
 	__flush_tlb_mm(vma->vm_mm);
+}
+static inline void flush_tlb_dirty(struct vm_area_struct *vma,
+				   unsigned long addr)
+{
+	/* No need to flush TLB; bits are in the storage key */
 }
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
diff -urN linux-2.5.21/include/asm-s390x/pgalloc.h linux-2.5.21-ptep/include/asm-s390x/pgalloc.h
--- linux-2.5.21/include/asm-s390x/pgalloc.h	Sun Jun  9 07:27:32 2002
+++ linux-2.5.21-ptep/include/asm-s390x/pgalloc.h	Thu Jun 13 20:59:49 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5.21/include/asm-s390x/tlbflush.h linux-2.5.21-ptep/include/asm-s390x/tlbflush.h
--- linux-2.5.21/include/asm-s390x/tlbflush.h	Sun Jun  9 07:30:53 2002
+++ linux-2.5.21-ptep/include/asm-s390x/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -15,6 +15,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 
 /*
@@ -52,6 +53,11 @@
 {
 	local_flush_tlb();
 }
+static inline void flush_tlb_dirty(struct vm_area_struct *vma,
+				   unsigned long addr)
+{
+	/* No need to flush TLB; bits are in the storage key */
+}
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
@@ -114,6 +120,11 @@
 				  unsigned long addr)
 {
 	__flush_tlb_mm(vma->vm_mm);
+}
+static inline void flush_tlb_dirty(struct vm_area_struct *vma,
+				   unsigned long addr)
+{
+	/* No need to flush TLB; bits are in the storage key */
 }
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
diff -urN linux-2.5.21/include/asm-sh/pgalloc.h linux-2.5.21-ptep/include/asm-sh/pgalloc.h
--- linux-2.5.21/include/asm-sh/pgalloc.h	Sun Jun  9 07:30:02 2002
+++ linux-2.5.21-ptep/include/asm-sh/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -80,6 +80,7 @@
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  */
 
 extern void flush_tlb(void);
@@ -90,6 +91,8 @@
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 extern void __flush_tlb_page(unsigned long asid, unsigned long page);
 
+#define flush_tlb_dirty(vma,vmaddr) flush_tlb_page(vma,vmaddr)
+
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 { /* Nothing to do */
@@ -156,4 +159,7 @@
 	pte_t old_pte = *ptep;
 	set_pte(ptep, pte_mkdirty(old_pte));
 }
+
+#include <asm-generic/pgalloc.h>
+
 #endif /* __ASM_SH_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-sparc/pgalloc.h linux-2.5.21-ptep/include/asm-sparc/pgalloc.h
--- linux-2.5.21/include/asm-sparc/pgalloc.h	Sun Jun  9 07:27:13 2002
+++ linux-2.5.21-ptep/include/asm-sparc/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -78,6 +78,7 @@
 #define flush_tlb_mm(mm) BTFIXUP_CALL(flush_tlb_mm)(mm)
 #define flush_tlb_range(vma,start,end) BTFIXUP_CALL(flush_tlb_range)(vma,start,end)
 #define flush_tlb_page(vma,addr) BTFIXUP_CALL(flush_tlb_page)(vma,addr)
+#define flush_tlb_dirty(vma,addr) flush_tlb_page(vma,addr)
 
 BTFIXUPDEF_CALL(void, __flush_page_to_ram, unsigned long)
 BTFIXUPDEF_CALL(void, flush_sig_insns, struct mm_struct *, unsigned long)
@@ -140,5 +141,7 @@
 #define free_pte_fast(pte)	BTFIXUP_CALL(free_pte_fast)(pte)
 
 #define pte_free(pte)		free_pte_fast(pte)
+
+#include <asm-generic/pgalloc.h>
 
 #endif /* _SPARC_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-sparc64/pgalloc.h linux-2.5.21-ptep/include/asm-sparc64/pgalloc.h
--- linux-2.5.21/include/asm-sparc64/pgalloc.h	Sun Jun  9 07:29:15 2002
+++ linux-2.5.21-ptep/include/asm-sparc64/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -225,4 +225,6 @@
 #define pgd_free(pgd)		free_pgd_fast(pgd)
 #define pgd_alloc(mm)		get_pgd_fast()
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _SPARC64_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-sparc64/tlbflush.h linux-2.5.21-ptep/include/asm-sparc64/tlbflush.h
--- linux-2.5.21/include/asm-sparc64/tlbflush.h	Sun Jun  9 07:30:57 2002
+++ linux-2.5.21-ptep/include/asm-sparc64/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -53,6 +53,8 @@
 			 SECONDARY_CONTEXT); \
 } while(0)
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 #define flush_tlb_vpte_page(mm, addr) \
 do { struct mm_struct *__mm = (mm); \
      if(CTX_VALID(__mm->context)) \
@@ -80,6 +82,7 @@
 	smp_flush_tlb_kernel_range(start, end)
 #define flush_tlb_page(vma, page) \
 	smp_flush_tlb_page((vma)->vm_mm, page)
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 #define flush_tlb_vpte_page(mm, page) \
 	smp_flush_tlb_page((mm), page)
 
diff -urN linux-2.5.21/include/asm-x86_64/pgalloc.h linux-2.5.21-ptep/include/asm-x86_64/pgalloc.h
--- linux-2.5.21/include/asm-x86_64/pgalloc.h	Sun Jun  9 07:30:22 2002
+++ linux-2.5.21-ptep/include/asm-x86_64/pgalloc.h	Thu Jun 13 21:06:11 2002
@@ -75,5 +75,6 @@
 	__free_page(pte);
 } 
 
+#include <asm-generic/pgalloc.h>
 
 #endif /* _X86_64_PGALLOC_H */
diff -urN linux-2.5.21/include/asm-x86_64/tlbflush.h linux-2.5.21-ptep/include/asm-x86_64/tlbflush.h
--- linux-2.5.21/include/asm-x86_64/tlbflush.h	Sun Jun  9 07:26:34 2002
+++ linux-2.5.21-ptep/include/asm-x86_64/tlbflush.h	Thu Jun 13 21:06:11 2002
@@ -53,6 +53,7 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *  - flush_tlb_dirty(vma, vmaddr) flushes the dirty bit for one page
  *
  * ..but the x86_64 has somewhat limited tlb flushing capabilities,
  * and page-granular flushes are available only on i486 and up.
@@ -77,6 +78,8 @@
 		__flush_tlb_one(addr);
 }
 
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
@@ -95,6 +98,8 @@
 extern void flush_tlb_current_task(void);
 extern void flush_tlb_mm(struct mm_struct *);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+
+#define flush_tlb_dirty(vma, vmaddr) flush_tlb_page(vma, vmaddr)
 
 #define flush_tlb()	flush_tlb_current_task()
 
diff -urN linux-2.5.21/mm/memory.c linux-2.5.21-ptep/mm/memory.c
--- linux-2.5.21/mm/memory.c	Sun Jun  9 07:29:42 2002
+++ linux-2.5.21-ptep/mm/memory.c	Thu Jun 13 21:06:11 2002
@@ -918,20 +918,6 @@
 	return error;
 }
 
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- *
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	set_pte(page_table, entry);
-	flush_tlb_page(vma, address);
-	update_mmu_cache(vma, address, entry);
-}
 
 /*
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
@@ -941,7 +927,8 @@
 {
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
-	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+	ptep_establish(vma, address, page_table,
+		pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
 
 /*
@@ -979,7 +966,8 @@
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address);
-			establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+ 			ptep_establish(vma, address, page_table,
+				pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
 			return 1;	/* Minor fault */
@@ -1394,7 +1382,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	establish_pte(vma, address, pte, entry);
+	ptep_establish(vma, address, pte, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 	return 1;
diff -urN linux-2.5.21/mm/mremap.c linux-2.5.21-ptep/mm/mremap.c
--- linux-2.5.21/mm/mremap.c	Sun Jun  9 07:30:24 2002
+++ linux-2.5.21-ptep/mm/mremap.c	Thu Jun 13 21:06:11 2002
@@ -64,38 +64,29 @@
 	return pte;
 }
 
-static inline int copy_one_pte(struct mm_struct *mm, pte_t * src, pte_t * dst)
-{
-	int error = 0;
-	pte_t pte;
-
-	if (!pte_none(*src)) {
-		pte = ptep_get_and_clear(src);
-		if (!dst) {
-			/* No dest?  We must put it back. */
-			dst = src;
-			error++;
-		}
-		set_pte(dst, pte);
-	}
-	return error;
-}
-
 static int move_one_page(struct vm_area_struct *vma, unsigned long old_addr, unsigned long new_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error = 0;
 	pte_t *src, *dst;
+	pte_t pte;
 
 	spin_lock(&mm->page_table_lock);
 	src = get_one_pte_map_nested(mm, old_addr);
 	if (src) {
 		dst = alloc_one_pte_map(mm, new_addr);
-		error = copy_one_pte(mm, src, dst);
+		if (!pte_none(*src)) {
+			pte = ptep_invalidate(vma, old_addr, src);
+			if (!dst) {
+				/* No dest?  We must put it back. */
+				dst = src;
+				error++;
+			}
+			set_pte(dst, pte);
+		}
 		pte_unmap_nested(src);
 		pte_unmap(dst);
 	}
-	flush_tlb_page(vma, old_addr);
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
diff -urN linux-2.5.21/mm/msync.c linux-2.5.21-ptep/mm/msync.c
--- linux-2.5.21/mm/msync.c	Sun Jun  9 07:29:10 2002
+++ linux-2.5.21-ptep/mm/msync.c	Thu Jun 13 21:06:11 2002
@@ -30,8 +30,9 @@
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (!PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
-				flush_tlb_page(vma, address);
+			if (!PageReserved(page) &&
+			    ptep_test_and_clear_dirty(ptep)) {
+				flush_tlb_dirty(vma, address);
 				set_page_dirty(page);
 			}
 		}
diff -urN linux-2.5.21/mm/vmscan.c linux-2.5.21-ptep/mm/vmscan.c
--- linux-2.5.21/mm/vmscan.c	Sun Jun  9 07:27:31 2002
+++ linux-2.5.21-ptep/mm/vmscan.c	Thu Jun 13 21:06:11 2002
@@ -106,9 +106,7 @@
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
-	flush_cache_page(vma, address);
-	pte = ptep_get_and_clear(page_table);
-	flush_tlb_page(vma, address);
+	pte = ptep_invalidate(vma, address, page_table);
 
 	if (pte_dirty(pte))
 		set_page_dirty(page);
