Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSEVImd>; Wed, 22 May 2002 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSEVImc>; Wed, 22 May 2002 04:42:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60593 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316893AbSEVImU>;
	Wed, 22 May 2002 04:42:20 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15595.22927.521949.528064@argo.ozlabs.ibm.com>
Date: Wed, 22 May 2002 18:40:47 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <Pine.LNX.4.33.0205211609210.15094-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the bits I currently have for doing the TLB flushing on PPC.

The declaration I have for tlb_flush is a bit ugly but AFAICS the only
alternative is to make it a #define.  I wanted to make it a static
inline but I can't do that before the #include <asm-generic/tlb.h>
(since we don't have the mmu_gather_t declaration at that point) and
it is no use afterwards (since it has already been referenced).

Regards,
Paul.

diff -urN linux-2.5/include/asm-generic/tlb.h pmac-2.5/include/asm-generic/tlb.h
--- linux-2.5/include/asm-generic/tlb.h	Tue May 21 15:27:47 2002
+++ pmac-2.5/include/asm-generic/tlb.h	Wed May 22 14:10:54 2002
@@ -37,6 +37,8 @@
 	struct mm_struct	*mm;
 	unsigned long		nr;	/* set to ~0UL means fast mode */
 	unsigned long		freed;
+	unsigned long		start;	/* virtual address range, */
+	unsigned long		end;	/* used on PPC */
 	struct page *		pages[FREE_PTE_NR];
 } mmu_gather_t;
 
@@ -55,6 +57,7 @@
 
 	/* Use fast mode if only one CPU is online */
 	tlb->nr = smp_num_cpus > 1 ? 0UL : ~0UL;
+	tlb_init_tlb(tlb);
 	return tlb;
 }
 
@@ -88,11 +91,10 @@
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
diff -urN linux-2.5/include/asm-i386/tlb.h pmac-2.5/include/asm-i386/tlb.h
--- linux-2.5/include/asm-i386/tlb.h	Tue May 21 15:27:47 2002
+++ pmac-2.5/include/asm-i386/tlb.h	Wed May 22 14:11:05 2002
@@ -5,6 +5,7 @@
  * x86 doesn't need any special per-pte or
  * per-vma handling..
  */
+#define tlb_init_tlb(tlb) do { } while (0)
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
diff -urN linux-2.5/include/asm-ppc/tlb.h pmac-2.5/include/asm-ppc/tlb.h
--- linux-2.5/include/asm-ppc/tlb.h	Tue Feb  5 18:40:23 2002
+++ pmac-2.5/include/asm-ppc/tlb.h	Wed May 22 15:06:57 2002
@@ -1,4 +1,85 @@
 /*
- * BK Id: SCCS/s.tlb.h 1.5 05/17/01 18:14:26 cort
+ *	TLB shootdown specifics for PPC
+ *
+ * Copyright (C) 2002 Paul Mackerras, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
+#ifndef _PPC_TLB_H
+#define _PPC_TLB_H
+
+#include <linux/config.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+
+#ifdef CONFIG_PPC_STD_MMU
+/* Classic PPC with hash-table based MMU... */
+
+#define _NO_ADDR	(~0UL)
+#define tlb_init_tlb(tlb)	((tlb)->start = _NO_ADDR)
+
+struct free_pte_ctx;		/* same as mmu_gather_t */
+extern void tlb_flush(struct free_pte_ctx *tlb);
+
+#else
+/* Embedded PPC with software-loaded TLB, very simple... */
+
+#define tlb_init_tlb(tlb)	do { } while (0)
+#define tlb_start_vma(tlb, vma)	do { } while (0)
+#define tlb_end_vma(tlb, vma)	do { } while (0)
+#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
+
+#endif /* CONFIG_PPC_STD_MMU */
+
+/* Get the generic bits... */
 #include <asm-generic/tlb.h>
+
+#ifdef CONFIG_PPC_STD_MMU
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
+	if (tlb->start != _NO_ADDR)
+		tlb_flush(tlb);
+}
+
+static inline void tlb_remove_tlb_entry(mmu_gather_t *tlb, pte_t pte,
+					unsigned long address)
+{
+	if (pte_val(pte) & _PAGE_HASHPTE) {
+		if (tlb->start == _NO_ADDR) {
+			tlb->start = address;
+		} else if (address - tlb->end > 32 * PAGE_SIZE) {
+			/*
+			 * If there is a big gap in the range of addresses
+			 * needing to be flushed, it is better to do two
+			 * separate calls to flush_tlb_mm_range rather than
+			 * a single call with a lot of ptes that it will
+			 * have to skip over in the middle of the range.
+			 */
+			tlb_flush(tlb);
+			tlb->start = address;
+		}
+		tlb->end = address + PAGE_SIZE;
+	}
+}
+#endif /* CONFIG_PPC_STD_MMU */
+
+#endif /* __PPC_TLB_H */
diff -urN linux-2.5/arch/ppc/mm/tlb.c pmac-2.5/arch/ppc/mm/tlb.c
--- linux-2.5/arch/ppc/mm/tlb.c	Mon Apr 15 09:48:49 2002
+++ pmac-2.5/arch/ppc/mm/tlb.c	Wed May 22 15:08:06 2002
@@ -31,6 +31,8 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #include "mmu_decl.h"
 
@@ -59,7 +61,24 @@
 #define FINISH_FLUSH	do { } while (0)
 #endif
 
-static void flush_range(struct mm_struct *mm, unsigned long start,
+void tlb_flush(mmu_gather_t *tlb)
+{
+	if (Hash != 0) {
+		if (tlb->start != _NO_ADDR) {
+			flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end);
+			tlb->start = _NO_ADDR;
+		}
+	} else {
+		/*
+		 * 603 needs to flush the whole TLB here; we will
+		 * have tlb->start = _NO_ADDR since none of its PTEs
+		 * can be in the hash table.
+		 */
+		_tlbia();
+	}
+}
+
+void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end)
 {
 	pmd_t *pmd;
@@ -110,7 +129,7 @@
 	 */
 	printk(KERN_ERR "flush_tlb_all called from %p\n",
 	       __builtin_return_address(0));
-	flush_range(&init_mm, TASK_SIZE, ~0UL);
+	flush_tlb_mm_range(&init_mm, TASK_SIZE, ~0UL);
 	FINISH_FLUSH;
 }
 
@@ -119,7 +138,7 @@
  */
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	flush_range(&init_mm, start, end);
+	flush_tlb_mm_range(&init_mm, start, end);
 	FINISH_FLUSH;
 }
 
@@ -130,18 +149,15 @@
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
 
@@ -170,6 +186,6 @@
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	flush_range(vma->vm_mm, start, end);
+	flush_tlb_mm_range(vma->vm_mm, start, end);
 	FINISH_FLUSH;
 }
