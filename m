Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUJYH13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUJYH13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUJYH13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:27:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:9632 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261677AbUJYHZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:39 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2/17] Generic backward compatibility includes for 4level
Message-ID: <417CAA05.mail3Y411778M@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic backward compatibility includes for 4level

This adds some asm-generic file to allow conversion of 2level
and 3level architectures to 4levels without much duplicated code.

The pml4 is simply a pointer to the pgd.


Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-generic/nopml4-page.h linux-2.6.10rc1-4level/include/asm-generic/nopml4-page.h
--- linux-2.6.10rc1/include/asm-generic/nopml4-page.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-generic/nopml4-page.h	2004-10-25 04:48:10.000000000 +0200
@@ -0,0 +1,14 @@
+#ifndef _NOPML4_PAGE_H
+#define _NOPML4_PAGE_H 1
+
+#ifndef __ASSEMBLY__
+
+/* 
+ * Generic page.h declarations for architectures without four level
+ * page tables 
+ */
+
+typedef struct { pgd_t pgd; } pml4_t; 
+#endif
+
+#endif
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-generic/nopml4-pgalloc.h linux-2.6.10rc1-4level/include/asm-generic/nopml4-pgalloc.h
--- linux-2.6.10rc1/include/asm-generic/nopml4-pgalloc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-generic/nopml4-pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -0,0 +1,21 @@
+#ifndef _NOPML4_PGALLOC_H
+#define _NOPML4_PGALLOC_H 1
+
+/* Fallback used for architectures without 4 level pagetables */
+
+#define pml4_populate(mm, pml4, pgd) ((mm)->pml4 = (pml4_t *)(pgd)) 
+
+static inline pml4_t *pml4_alloc(struct mm_struct *mm)
+{
+	pml4_t dummy;
+	return (pml4_t *)__pgd_alloc(mm, &dummy, 0);
+} 
+
+static inline void pml4_free(pml4_t *pml4)
+{
+	pgd_free((pgd_t *)pml4);
+}
+
+#define __pgd_free_tlb(tlb,x)   do {} while(0)
+
+#endif
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-generic/nopml4-pgtable.h linux-2.6.10rc1-4level/include/asm-generic/nopml4-pgtable.h
--- linux-2.6.10rc1/include/asm-generic/nopml4-pgtable.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-generic/nopml4-pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -0,0 +1,43 @@
+#ifndef _NOPML4_H
+#define _NOPML4_H 1
+
+#ifndef __ASSEMBLY__
+
+/* Included by architectures that don't have a fourth page table level.
+
+   pml4 is simply casted to pgd */
+
+#define pml4_ERROR(x) 
+#define pml4_bad(x) 0
+#define pml4_clear(x) 
+
+/* Covers all address room. This implies that walks will usually wrap.
+   The code has to handle this. 
+
+   Could use TASK_SIZE here, but a lot of architectures make it different
+   for 32bit and 64bit tasks. */
+#define PML4_SIZE (~0UL)
+#define PML4_MASK 0UL
+
+#define pml4_offset(mm, addr) ((mm)->pml4)
+#define pml4_offset_k(addr) (init_mm.pml4)
+#define pml4_pgd_offset(pml4, addr) ((pgd_t *)(pml4) + pgd_index(addr))
+#define pml4_pgd_offset_k(pml4, addr) ((pgd_t *)(pml4) + pgd_index_k(addr))
+
+#define pml4_none(pml4) 0
+#define pml4_present(pml4) 1
+#define pml4_index(pml4) 0
+
+#define swapper_pml4 ((pml4_t *)swapper_pg_dir)
+
+/* Use pml4_pgd_offset and pml4_offset_k instead */
+
+#undef pgd_offset
+#define pgd_offset pgd_offset_is_obsolete
+
+#undef pgd_offset_k
+#define pgd_offset_k pgd_offset_k_is_obsolete
+
+#endif
+
+#endif
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-generic/pgtable.h linux-2.6.10rc1-4level/include/asm-generic/pgtable.h
--- linux-2.6.10rc1/include/asm-generic/pgtable.h	2004-10-19 01:55:32.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-generic/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -131,7 +131,7 @@ static inline void ptep_mkdirty(pte_t *p
 #endif
 
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
-#define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
+#define pml4_offset_gate(mm, addr)	pml4_offset(mm, addr)
 #endif
 
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-generic/tlb.h linux-2.6.10rc1-4level/include/asm-generic/tlb.h
--- linux-2.6.10rc1/include/asm-generic/tlb.h	2004-08-15 19:45:46.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-generic/tlb.h	2004-10-25 04:48:10.000000000 +0200
@@ -147,6 +147,12 @@ static inline void tlb_remove_page(struc
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
+#define pgd_free_tlb(tlb, pgdp)					\
+	do {							\
+		tlb->need_flush = 1;				\
+		__pgd_free_tlb(tlb, pgdp);			\
+	} while (0)
+
 #define tlb_migrate_finish(mm) do {} while (0)
 
 #endif /* _ASM_GENERIC__TLB_H */
