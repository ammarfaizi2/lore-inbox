Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315934AbSETMoo>; Mon, 20 May 2002 08:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315935AbSETMon>; Mon, 20 May 2002 08:44:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:7810 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315934AbSETMoj>;
	Mon, 20 May 2002 08:44:39 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15592.61285.98743.781939@argo.ozlabs.ibm.com>
Date: Mon, 20 May 2002 22:43:17 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205191820100.20628-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch splits up the existing tlb_remove_page into
tlb_remove_tlb_entry (for pages that are/were mapped into userspace)
and tlb_remove_page, as you suggested.  It also adds the necessary
stuff for PPC, which has its own include/asm-ppc/tlb.h now.  This
works on at least one PPC machine. :)

Thanks,
Paul.

diff -urN linux-2.5/include/asm-generic/tlb.h pmac-2.5/include/asm-generic/tlb.h
--- linux-2.5/include/asm-generic/tlb.h	Sun May 19 21:04:28 2002
+++ pmac-2.5/include/asm-generic/tlb.h	Mon May 20 11:46:18 2002
@@ -83,11 +83,10 @@
 	tlb_flush_mmu(tlb, start, end);
 }
 
-
-/* void tlb_remove_page(mmu_gather_t *tlb, pte_t *ptep, unsigned long addr)
- *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
- *	handling the additional races in SMP caused by other CPUs caching valid
- *	mappings in their TLBs.
+/* void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
+ *	This should free the page given after flushing any reference
+ *	to it from the TLB.  This should be done no later than the
+ *	next call to tlb_finish_mmu for this tlb.
  */
 static inline void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
 {
@@ -99,6 +98,18 @@
 	tlb->pages[tlb->nr++] = page;
 	if (tlb->nr >= FREE_PTE_NR)
 		tlb_flush_mmu(tlb, 0, 0);
+}
+
+/* void tlb_remove_tlb_entry(mmu_gather_t *tlb, struct page *page, unsigned long address)
+ *	This is similar to tlb_remove_page, except that we are given the
+ *	virtual address at which the page was mapped.  The address parameter
+ *	is unused here but is used on some architectures.
+ */
+static inline void tlb_remove_tlb_entry(mmu_gather_t *tlb, struct page *page,
+					unsigned long address)
+{
+	tlb->freed++;
+	tlb_remove_page(tlb, page);
 }
 
 #endif /* _ASM_GENERIC__TLB_H */
diff -urN linux-2.5/mm/memory.c pmac-2.5/mm/memory.c
--- linux-2.5/mm/memory.c	Thu May 16 20:31:42 2002
+++ pmac-2.5/mm/memory.c	Mon May 20 14:06:58 2002
@@ -353,7 +353,7 @@
 				if (!PageReserved(page)) {
 					if (pte_dirty(pte))
 						set_page_dirty(page);
-					tlb_remove_page(tlb, page);
+					tlb_remove_tlb_entry(tlb, page, address+offset);
 				}
 			}
 		} else {
diff -urN linux-2.5/include/asm-ppc/tlb.h pmac-2.5/include/asm-ppc/tlb.h
--- linux-2.5/include/asm-ppc/tlb.h	Tue Feb  5 18:40:23 2002
+++ pmac-2.5/include/asm-ppc/tlb.h	Mon May 20 20:14:20 2002
@@ -1,4 +1,141 @@
 /*
- * BK Id: SCCS/s.tlb.h 1.5 05/17/01 18:14:26 cort
+ * include/asm-ppc/tlb.h
+ *
+ *	TLB shootdown code for PPC
+ *
+ * Based on include/asm-generic/tlb.h, which is
+ * Copyright 2001 Red Hat, Inc.
+ * Based on code from mm/memory.c Copyright Linus Torvalds and others.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
-#include <asm-generic/tlb.h>
+#ifndef _ASM_PPC__TLB_H
+#define _ASM_PPC__TLB_H
+
+#include <linux/config.h>
+#include <asm/tlbflush.h>
+#include <asm/page.h>
+
+/*
+ * This makes sizeof(mmu_gather_t) a power of 2.
+ * We assume we get some advantage from batching up the invalidations.
+ * It would be nice to measure how much ...
+ */
+#define FREE_PTE_NR	507
+
+/* mmu_gather_t is an opaque type used by the mm code for passing around any
+ * data needed by arch specific code for tlb_remove_page.  This structure can
+ * be per-CPU or per-MM as the page table lock is held for the duration of TLB
+ * shootdown.
+ */
+typedef struct free_pte_ctx {
+	struct mm_struct	*mm;
+	unsigned long		nr;	/* set to ~0UL means fast mode */
+	unsigned long		freed;
+	unsigned long		start;
+	unsigned long		end;
+	struct page *		pages[FREE_PTE_NR];
+} mmu_gather_t;
+
+/* Declared in arch/ppc/mm/init.c. */
+extern mmu_gather_t	mmu_gathers[NR_CPUS];
+
+/*
+ * Actually do the flushes that we have gathered up, and
+ * then free the corresponding pages.
+ */
+static inline void tlb_flush_mmu(mmu_gather_t *tlb)
+{
+	unsigned long nr;
+
+	nr = tlb->nr;
+	if (nr != 0) {
+		unsigned long i;
+		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end + PAGE_SIZE);
+		tlb->nr = 0;
+		for (i = 0; i < nr; i++)
+			free_page_and_swap_cache(tlb->pages[i]);
+	}
+}
+
+/* tlb_gather_mmu
+ *	Return a pointer to an initialized mmu_gather_t.
+ */
+static inline mmu_gather_t *tlb_gather_mmu(struct mm_struct *mm)
+{
+	mmu_gather_t *tlb = &mmu_gathers[smp_processor_id()];
+
+	tlb->mm = mm;
+	tlb->freed = 0;
+	tlb->nr = 0;
+	return tlb;
+}
+
+/* tlb_finish_mmu
+ *	Called at the end of the shootdown operation to free up any resources
+ *	that were required.  The page table lock is still held at this point.
+ */
+static inline void tlb_finish_mmu(mmu_gather_t *tlb, unsigned long start, unsigned long end)
+{
+	int freed = tlb->freed;
+	struct mm_struct *mm = tlb->mm;
+	int rss = mm->rss;
+
+	if (rss < freed)
+		freed = rss;
+	mm->rss = rss - freed;
+}
+
+/* Nothing needed here in fact... */
+#define tlb_start_vma(tlb, vma) do { } while (0)
+
+/*
+ * flush_tlb_mm_range looks at the pte pages for the range of addresses
+ * in order to check the _PAGE_HASHPTE bit.  Thus we can't defer
+ * the tlb_flush_mmu call to tlb_finish_mmu time, since by then the
+ * pointers to the pte pages in the pgdir have been zeroed.
+ * Instead we do the tlb_flush_mmu here.  In future we could possibly
+ * do something cleverer, like keeping our own pointer(s) to the pte
+ * page(s) that we are interested in.
+ */
+static inline void tlb_end_vma(mmu_gather_t *tlb, struct vm_area_struct *vma)
+{
+	tlb_flush_mmu(tlb);
+}
+
+/* void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
+ *
+ *	On PPC this should never be called.
+ */
+static inline void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
+{
+	BUG();
+}
+
+/* void tlb_remove_tlb_entry(mmu_gather_t *tlb, struct page *page, unsigned long address)
+ *	This should free the page given after flushing any reference
+ *	to it from the MMU hash table and TLB.  This should be done no
+ *	later than the next call to tlb_finish_mmu for this tlb.
+ *	We get given the virtual address at which the page was mapped.
+ */
+static inline void tlb_remove_tlb_entry(mmu_gather_t *tlb, struct page *page,
+					unsigned long address)
+{
+	tlb->freed++;
+
+	if (tlb->nr == 0)
+		tlb->start = address;
+	else if (address - tlb->end > 32 * PAGE_SIZE) {
+		tlb_flush_mmu(tlb);
+		tlb->start = address;
+	}
+	tlb->end = address;
+	tlb->pages[tlb->nr++] = page;
+	if (tlb->nr >= FREE_PTE_NR)
+		tlb_flush_mmu(tlb);
+}
+
+#endif /* _ASM_PPC__TLB_H */
diff -urN linux-2.5/include/asm-ppc/tlbflush.h pmac-2.5/include/asm-ppc/tlbflush.h
--- linux-2.5/include/asm-ppc/tlbflush.h	Fri May 10 10:14:59 2002
+++ pmac-2.5/include/asm-ppc/tlbflush.h	Mon May 20 12:00:24 2002
@@ -27,6 +27,9 @@
 	{ __tlbia(); }
 static inline void flush_tlb_mm(struct mm_struct *mm)
 	{ __tlbia(); }
+static inline void flush_tlb_mm_range(struct mm_struct *mm,
+				unsigned long start, unsigned long end);
+	{ __tlbia(); }
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
 	{ _tlbie(vmaddr); }
@@ -45,6 +48,9 @@
 	{ __tlbia(); }
 static inline void flush_tlb_mm(struct mm_struct *mm)
 	{ __tlbia(); }
+static inline void flush_tlb_mm_range(struct mm_struct *mm,
+				unsigned long start, unsigned long end)
+	{ __tlbia(); }
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
 	{ _tlbie(vmaddr); }
@@ -61,6 +67,8 @@
 struct vm_area_struct;
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_mm_range(struct mm_struct *mm,
+			       unsigned long start, unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
diff -urN linux-2.5/include/asm-ppc/pgalloc.h pmac-2.5/include/asm-ppc/pgalloc.h
--- linux-2.5/include/asm-ppc/pgalloc.h	Wed Apr 10 17:56:21 2002
+++ pmac-2.5/include/asm-ppc/pgalloc.h	Mon May 20 11:18:03 2002
@@ -20,6 +20,7 @@
  */
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)                     do { } while (0)
+#define pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
 
 #define pmd_populate_kernel(mm, pmd, pte)	\
@@ -31,6 +32,8 @@
 extern struct page *pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 extern void pte_free_kernel(pte_t *pte);
 extern void pte_free(struct page *pte);
+
+#define pte_free_tlb(tlb, pte)	pte_free((pte))
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5/arch/ppc/mm/tlb.c pmac-2.5/arch/ppc/mm/tlb.c
--- linux-2.5/arch/ppc/mm/tlb.c	Mon Apr 15 09:48:49 2002
+++ pmac-2.5/arch/ppc/mm/tlb.c	Mon May 20 22:21:40 2002
@@ -59,7 +59,7 @@
 #define FINISH_FLUSH	do { } while (0)
 #endif
 
-static void flush_range(struct mm_struct *mm, unsigned long start,
+void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end)
 {
 	pmd_t *pmd;
@@ -110,7 +110,7 @@
 	 */
 	printk(KERN_ERR "flush_tlb_all called from %p\n",
 	       __builtin_return_address(0));
-	flush_range(&init_mm, TASK_SIZE, ~0UL);
+	flush_tlb_mm_range(&init_mm, TASK_SIZE, ~0UL);
 	FINISH_FLUSH;
 }
 
@@ -119,7 +119,7 @@
  */
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	flush_range(&init_mm, start, end);
+	flush_tlb_mm_range(&init_mm, start, end);
 	FINISH_FLUSH;
 }
 
@@ -130,18 +130,15 @@
  */
 void flush_tlb_mm(struct mm_struct *mm)
 {
+	struct vm_area_struct *mp;
+
 	if (Hash == 0) {
 		_tlbia();
 		return;
 	}
 
-	if (mm->map_count) {
-		struct vm_area_struct *mp;
-		for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
-			flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
-	} else {
-		flush_range(mm, 0, TASK_SIZE);
-	}
+	for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
+		flush_tlb_mm_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 	FINISH_FLUSH;
 }
 
@@ -170,6 +167,6 @@
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	flush_range(vma->vm_mm, start, end);
+	flush_tlb_mm_range(vma->vm_mm, start, end);
 	FINISH_FLUSH;
 }
