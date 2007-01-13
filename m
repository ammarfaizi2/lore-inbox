Return-Path: <linux-kernel-owner+w=401wt.eu-S1422826AbXAMXLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbXAMXLd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXAMXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:11:04 -0500
Received: from gw.goop.org ([64.81.55.164]:59917 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030529AbXAMXKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:32 -0500
Message-Id: <20070113014647.796412179@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:46 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 07/20] XEN-paravirt: paravirt shared kernel pmd flag
Content-Disposition: inline; filename=shared-kernel-pmd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xen does not allow guests to have the kernel pmd shared between page
tables, so parameterize pgtable.c to allow both modes of operation.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

--
 arch/i386/kernel/paravirt.c            |    1 
 arch/i386/mm/fault.c                   |    6 +--
 arch/i386/mm/pageattr.c                |    2 -
 arch/i386/mm/pgtable.c                 |   61 ++++++++++++++++++++------------
 include/asm-i386/page.h                |    7 ++-
 include/asm-i386/paravirt.h            |    1 
 include/asm-i386/pgtable-2level-defs.h |    2 +
 include/asm-i386/pgtable-2level.h      |    2 -
 include/asm-i386/pgtable-3level-defs.h |    6 +++
 include/asm-i386/pgtable-3level.h      |   16 ++------
 include/asm-i386/pgtable.h             |    7 +++
 11 files changed, 68 insertions(+), 43 deletions(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -572,6 +572,7 @@ struct paravirt_ops paravirt_ops = {
 	.name = "bare hardware",
 	.paravirt_enabled = 0,
 	.kernel_rpl = 0,
+	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
  	.patch = native_patch,
 	.banner = default_banner,
===================================================================
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -616,8 +616,7 @@ do_sigbus:
 	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
 }
 
-#ifndef CONFIG_X86_PAE
-void vmalloc_sync_all(void)
+void _vmalloc_sync_all(void)
 {
 	/*
 	 * Note that races in the updates of insync and start aren't
@@ -628,6 +627,8 @@ void vmalloc_sync_all(void)
 	static DECLARE_BITMAP(insync, PTRS_PER_PGD);
 	static unsigned long start = TASK_SIZE;
 	unsigned long address;
+
+	BUG_ON(SHARED_KERNEL_PMD);
 
 	BUILD_BUG_ON(TASK_SIZE & ~PGDIR_MASK);
 	for (address = start; address >= TASK_SIZE; address += PGDIR_SIZE) {
@@ -651,4 +652,3 @@ void vmalloc_sync_all(void)
 			start = address + PGDIR_SIZE;
 	}
 }
-#endif
===================================================================
--- a/arch/i386/mm/pageattr.c
+++ b/arch/i386/mm/pageattr.c
@@ -91,7 +91,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 	unsigned long flags;
 
 	set_pte_atomic(kpte, pte); 	/* change init_mm */
-	if (PTRS_PER_PMD > 1)
+	if (SHARED_KERNEL_PMD)
 		return;
 
 	spin_lock_irqsave(&pgd_lock, flags);
===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -241,31 +241,42 @@ static void pgd_ctor(pgd_t *pgd)
 	unsigned long flags;
 
 	if (PTRS_PER_PMD == 1) {
+		/* !PAE, no pagetable sharing */
 		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+
+		clone_pgd_range(pgd + USER_PTRS_PER_PGD,
+				swapper_pg_dir + USER_PTRS_PER_PGD,
+				KERNEL_PGD_PTRS);
+
 		spin_lock_irqsave(&pgd_lock, flags);
-	}
-
-	clone_pgd_range(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			KERNEL_PGD_PTRS);
-
-	if (PTRS_PER_PMD > 1)
-		return;
-
-	/* must happen under lock */
-	paravirt_alloc_pd_clone(__pa(pgd) >> PAGE_SHIFT,
-			__pa(swapper_pg_dir) >> PAGE_SHIFT,
-			USER_PTRS_PER_PGD, PTRS_PER_PGD - USER_PTRS_PER_PGD);
-
-	pgd_list_add(pgd);
-	spin_unlock_irqrestore(&pgd_lock, flags);
+
+		/* must happen under lock */
+		paravirt_alloc_pd_clone(__pa(pgd) >> PAGE_SHIFT,
+					__pa(swapper_pg_dir) >> PAGE_SHIFT,
+					USER_PTRS_PER_PGD,
+					PTRS_PER_PGD - USER_PTRS_PER_PGD);
+
+		pgd_list_add(pgd);
+		spin_unlock_irqrestore(&pgd_lock, flags);
+	} else {
+		/* PAE, PMD may be shared */
+		if (SHARED_KERNEL_PMD) {
+			clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
+					swapper_pg_dir + USER_PTRS_PER_PGD,
+					KERNEL_PGD_PTRS);
+		} else {
+			spin_lock_irqsave(&pgd_lock, flags);
+			pgd_list_add(pgd);
+			spin_unlock_irqrestore(&pgd_lock, flags);
+		}
+	}
 }
 
 static void pgd_dtor(pgd_t *pgd)
 {
 	unsigned long flags; /* can be called from interrupt context */
 
-	if (PTRS_PER_PMD == 1)
+	if (SHARED_KERNEL_PMD)
 		return;
 
 	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
@@ -279,19 +290,25 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
-	if (pgd)
+	if (likely(pgd))
 		pgd_ctor(pgd);
 
-	if (PTRS_PER_PMD == 1 || !pgd)
+	if (PTRS_PER_PMD == 1 || unlikely(!pgd))
 		return pgd;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+	for (i = 0; i < (SHARED_KERNEL_PMD ? USER_PTRS_PER_PGD : PTRS_PER_PGD); ++i) {
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
-		if (!pmd)
+		if (unlikely(!pmd))
 			goto out_oom;
+
+		if (i >= USER_PTRS_PER_PGD)
+			memcpy(pmd, (void *)pgd_page_vaddr(swapper_pg_dir[i]),
+			       sizeof(pmd_t) * PTRS_PER_PMD);
+
 		paravirt_alloc_pd(__pa(pmd) >> PAGE_SHIFT);
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
+
 	return pgd;
 
 out_oom:
@@ -312,7 +329,7 @@ void pgd_free(pgd_t *pgd)
 
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+		for (i = 0; i < (SHARED_KERNEL_PMD ? USER_PTRS_PER_PGD : PTRS_PER_PGD); ++i) {
 			pgd_t pgdent = pgd[i];
 			void* pmd = (void *)__va(pgd_val(pgdent)-1);
 			paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
===================================================================
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -50,21 +50,23 @@ typedef struct { unsigned long long pgpr
 #ifndef CONFIG_PARAVIRT
 #define pmd_val(x)	((x).pmd)
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+#define __pte(x) ((pte_t) { .pte_low = (x), .pte_high = ((x) >> 32) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #endif	/* CONFIG_PARAVIRT */
 #define HPAGE_SHIFT	21
 #include <asm-generic/pgtable-nopud.h>
-#else
+#else  /* !CONFIG_X86_PAE */
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define boot_pte_t pte_t /* or would you rather have a typedef */
 #ifndef CONFIG_PARAVIRT
+#define __pte(x) ((pte_t) { (x) })
 #define pte_val(x)	((x).pte_low)
 #endif
 #define HPAGE_SHIFT	22
 #include <asm-generic/pgtable-nopmd.h>
-#endif
+#endif	/* CONFIG_X86_PAE */
 #define PTE_MASK	PAGE_MASK
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -79,7 +81,6 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef CONFIG_PARAVIRT
 #define pgd_val(x)	((x).pgd)
-#define __pte(x) ((pte_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
 #endif
 
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -34,6 +34,7 @@ struct paravirt_ops
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
+	int shared_kernel_pmd;
  	int paravirt_enabled;
 	const char *name;
 
===================================================================
--- a/include/asm-i386/pgtable-2level-defs.h
+++ b/include/asm-i386/pgtable-2level-defs.h
@@ -1,5 +1,7 @@
 #ifndef _I386_PGTABLE_2LEVEL_DEFS_H
 #define _I386_PGTABLE_2LEVEL_DEFS_H
+
+#define SHARED_KERNEL_PMD	0
 
 /*
  * traditional i386 two-level paging structure:
===================================================================
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -66,6 +66,4 @@ static inline int pte_exec_kernel(pte_t 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-void vmalloc_sync_all(void);
-
 #endif /* _I386_PGTABLE_2LEVEL_H */
===================================================================
--- a/include/asm-i386/pgtable-3level-defs.h
+++ b/include/asm-i386/pgtable-3level-defs.h
@@ -1,5 +1,11 @@
 #ifndef _I386_PGTABLE_3LEVEL_DEFS_H
 #define _I386_PGTABLE_3LEVEL_DEFS_H
+
+#ifdef CONFIG_PARAVIRT
+#define SHARED_KERNEL_PMD	(paravirt_ops.shared_kernel_pmd)
+#else
+#define SHARED_KERNEL_PMD	1
+#endif
 
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -153,20 +153,14 @@ extern unsigned long long __supported_pt
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	pte_t pte;
-
-	pte.pte_high = (page_nr >> (32 - PAGE_SHIFT)) | \
-					(pgprot_val(pgprot) >> 32);
-	pte.pte_high &= (__supported_pte_mask >> 32);
-	pte.pte_low = ((page_nr << PAGE_SHIFT) | pgprot_val(pgprot)) & \
-							__supported_pte_mask;
-	return pte;
+	return __pte((((unsigned long long)page_nr << PAGE_SHIFT) | 
+		      pgprot_val(pgprot)) & __supported_pte_mask);
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	return __pmd((((unsigned long long)page_nr << PAGE_SHIFT) | \
-			pgprot_val(pgprot)) & __supported_pte_mask);
+	return __pmd((((unsigned long long)page_nr << PAGE_SHIFT) |
+		      pgprot_val(pgprot)) & __supported_pte_mask);
 }
 
 /*
@@ -186,6 +180,4 @@ static inline pmd_t pfn_pmd(unsigned lon
 
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
 
-#define vmalloc_sync_all() ((void)0)
-
 #endif /* _I386_PGTABLE_3LEVEL_H */
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -239,6 +239,13 @@ static inline pte_t pte_mkwrite(pte_t pt
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PSE; return pte; }
 
+extern void _vmalloc_sync_all(void);
+static inline void vmalloc_sync_all(void)
+{
+	if (!SHARED_KERNEL_PMD)
+		_vmalloc_sync_all();
+}
+
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else

-- 

