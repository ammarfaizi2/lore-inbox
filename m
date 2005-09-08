Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVIHVMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVIHVMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVIHVMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:12:05 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:12028 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751401AbVIHVMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:12:03 -0400
Date: Thu, 8 Sep 2005 16:11:55 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] ppc: Merge tlb.h
Message-ID: <Pine.LNX.4.61.0509081611230.5055@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merged tlb.h between asm-ppc32 and asm-ppc64 into asm-powerpc.  Also, fixed
a compiler warning in arch/ppc/mm/tlb.c since it was roughly related.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit c5f0c343d08ad9c6862c1755e7b2239f31a2a633
tree c80721ace951bc55b14a8f2a3bf69599bca2e8e9
parent cebb2b156319990fc2fba615bbfeac81be62a86a
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 08 Sep 2005 16:09:42 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 08 Sep 2005 16:09:42 -0500

 arch/ppc/mm/tlb.c         |    1 +
 include/asm-powerpc/tlb.h |   50 +++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/tlb.h     |   57 ---------------------------------------------
 include/asm-ppc64/tlb.h   |   39 -------------------------------
 4 files changed, 51 insertions(+), 96 deletions(-)

diff --git a/arch/ppc/mm/tlb.c b/arch/ppc/mm/tlb.c
--- a/arch/ppc/mm/tlb.c
+++ b/arch/ppc/mm/tlb.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
diff --git a/include/asm-powerpc/tlb.h b/include/asm-powerpc/tlb.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/tlb.h
@@ -0,0 +1,50 @@
+#ifndef _ASM_POWERPC_TLB_H
+#define _ASM_POWERPC_TLB_H
+
+#include <asm/tlbflush.h>
+#include <asm/page.h>
+
+/* Nothing needed here in fact... */
+#define tlb_start_vma(tlb, vma)	do { } while (0)
+#define tlb_end_vma(tlb, vma)	do { } while (0)
+
+/* Avoid pulling in another include just for this */
+#define check_pgt_cache()	do { } while (0)
+
+#if defined(CONFIG_PPC64)
+struct mmu_gather;
+
+extern void pte_free_finish(void);
+
+#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	flush_tlb_pending();
+	pte_free_finish();
+}
+#elif defined(CONFIG_PPC_STD_MMU)
+/* Classic PPC with hash-table based MMU... */
+
+struct mmu_gather;
+extern void tlb_flush(struct mmu_gather *tlb);
+extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
+			     unsigned long address);
+#else
+/* Embedded PPC with software-loaded TLB, very simple... */
+
+#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
+#endif /* CONFIG_PPC64 */
+
+/* Get the generic bits... */
+#include <asm-generic/tlb.h>
+
+#ifdef CONFIG_PPC_STD_MMU
+static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
+					unsigned long address)
+{
+	if (pte_val(*ptep) & _PAGE_HASHPTE)
+		flush_hash_entry(tlb->mm, ptep, address);
+}
+#endif /* CONFIG_PPC_STD_MMU */
+#endif /* _ASM_POWERPC_TLB_H */
diff --git a/include/asm-ppc/tlb.h b/include/asm-ppc/tlb.h
deleted file mode 100644
--- a/include/asm-ppc/tlb.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- *	TLB shootdown specifics for PPC
- *
- * Copyright (C) 2002 Paul Mackerras, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _PPC_TLB_H
-#define _PPC_TLB_H
-
-#include <linux/config.h>
-#include <asm/pgtable.h>
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-#include <asm/page.h>
-#include <asm/mmu.h>
-
-#ifdef CONFIG_PPC_STD_MMU
-/* Classic PPC with hash-table based MMU... */
-
-struct mmu_gather;
-extern void tlb_flush(struct mmu_gather *tlb);
-
-/* Get the generic bits... */
-#include <asm-generic/tlb.h>
-
-/* Nothing needed here in fact... */
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
-
-static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
-					unsigned long address)
-{
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(tlb->mm, ptep, address);
-}
-
-#else
-/* Embedded PPC with software-loaded TLB, very simple... */
-
-#define tlb_start_vma(tlb, vma)		do { } while (0)
-#define tlb_end_vma(tlb, vma)		do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
-#define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
-
-/* Get the generic bits... */
-#include <asm-generic/tlb.h>
-
-#endif /* CONFIG_PPC_STD_MMU */
-
-#endif /* __PPC_TLB_H */
diff --git a/include/asm-ppc64/tlb.h b/include/asm-ppc64/tlb.h
deleted file mode 100644
--- a/include/asm-ppc64/tlb.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *	TLB shootdown specifics for PPC64
- *
- * Copyright (C) 2002 Anton Blanchard, IBM Corp.
- * Copyright (C) 2002 Paul Mackerras, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _PPC64_TLB_H
-#define _PPC64_TLB_H
-
-#include <asm/tlbflush.h>
-
-struct mmu_gather;
-
-extern void pte_free_finish(void);
-
-static inline void tlb_flush(struct mmu_gather *tlb)
-{
-	flush_tlb_pending();
-	pte_free_finish();
-}
-
-/* Avoid pulling in another include just for this */
-#define check_pgt_cache()	do { } while (0)
-
-/* Get the generic bits... */
-#include <asm-generic/tlb.h>
-
-/* Nothing needed here in fact... */
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
-
-#endif /* _PPC64_TLB_H */
