Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVADUPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVADUPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVADUMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:12:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261858AbVADUC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:02:57 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Change PML4 -> PUD
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 04 Jan 2005 20:02:51 +0000
Message-ID: <18003.1104868971@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch changes the PML4 bits of the FRV arch to the new PUD way.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-pml4-pud-2610mm1.diff 
 arch/frv/kernel/gdb-stub.c    |    4 -
 arch/frv/mm/dma-alloc.c       |    6 +
 arch/frv/mm/fault.c           |   23 ++++---
 arch/frv/mm/init.c            |    4 -
 arch/frv/mm/mmu-context.c     |    4 -
 arch/frv/mm/pgalloc.c         |    2 
 include/asm-frv/mmu_context.h |    6 -
 include/asm-frv/page.h        |   13 ++--
 include/asm-frv/pgalloc.h     |    4 -
 include/asm-frv/pgtable.h     |  129 +++++++++++++++++++++++++++++++-----------
 10 files changed, 134 insertions(+), 61 deletions(-)


diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/kernel/gdb-stub.c linux-2.6.10-mm1-frv/arch/frv/kernel/gdb-stub.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/kernel/gdb-stub.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/kernel/gdb-stub.c	2005-01-04 15:44:41.000000000 +0000
@@ -449,12 +449,14 @@ static unsigned long __saved_dampr, __sa
 static inline unsigned long gdbstub_virt_to_pte(unsigned long vaddr)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long val, dampr5;
 
 	pgd = (pgd_t *) __get_DAMLR(3) + pgd_index(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
+	pud = pud_offset(pgd, vaddr);
+	pmd = pmd_offset(pud, vaddr);
 
 	if (pmd_bad(*pmd) || !pmd_present(*pmd))
 		return 0;
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/dma-alloc.c linux-2.6.10-mm1-frv/arch/frv/mm/dma-alloc.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/dma-alloc.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/mm/dma-alloc.c	2005-01-04 16:28:52.000000000 +0000
@@ -50,6 +50,7 @@
 static int map_page(unsigned long va, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pge;
+	pud_t *pue;
 	pmd_t *pme;
 	pte_t *pte;
 	int err = -ENOMEM;
@@ -57,8 +58,9 @@ static int map_page(unsigned long va, un
 	spin_lock(&init_mm.page_table_lock);
 
 	/* Use upper 10 bits of VA to index the first level map */
-	pge = pml4_pgd_offset_k(pml4_offset_k(va), va);
-	pme = pmd_offset(pge, va);
+	pge = pgd_offset_k(va);
+	pue = pud_offset(pge, va);
+	pme = pmd_offset(pue, va);
 
 	/* Use middle 10 bits of VA to index the second-level map */
 	pte = pte_alloc_kernel(&init_mm, pme, va);
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/fault.c linux-2.6.10-mm1-frv/arch/frv/mm/fault.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/fault.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/mm/fault.c	2005-01-04 16:27:15.000000000 +0000
@@ -36,8 +36,8 @@ asmlinkage void do_page_fault(int datamm
 	struct mm_struct *mm;
 	unsigned long _pme, lrai, lrad, fixup;
 	siginfo_t info;
-	pml4_t *pml4e;
 	pgd_t *pge;
+	pud_t *pue;
 	pte_t *pte;
 	int write;
 
@@ -230,9 +230,9 @@ asmlinkage void do_page_fault(int datamm
 
 	__break_hijack_kernel_event();
 
-	pml4e = pml4_offset(current->mm, ear0);
-	pge = pml4_pgd_offset(pml4e, ear0);
-	_pme = pge->pge[0].ste[0];
+	pge = pgd_offset(current->mm, ear0);
+	pue = pud_offset(pge, ear0);
+	_pme = pue->pue[0].ste[0];
 
 	printk(KERN_ALERT "  PGE : %8p { PME %08lx }\n", pge, _pme);
 
@@ -298,21 +298,28 @@ asmlinkage void do_page_fault(int datamm
 		 */
 		int index = pgd_index(ear0);
 		pgd_t *pgd, *pgd_k;
+		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
 		pgd = (pgd_t *) __get_TTBR();
 		pgd = (pgd_t *)__va(pgd) + index;
-		pgd_k = ((pgd_t *)(init_mm.pml4)) + index;
+		pgd_k = ((pgd_t *)(init_mm.pgd)) + index;
 
 		if (!pgd_present(*pgd_k))
 			goto no_context;
-		set_pgd(pgd, *pgd_k);
+		//set_pgd(pgd, *pgd_k); /////// gcc ICE's on this line
 
-		pmd = pmd_offset(pgd, ear0);
-		pmd_k = pmd_offset(pgd_k, ear0);
+		pud_k = pud_offset(pgd_k, ear0);
+		if (!pud_present(*pud_k))
+			goto no_context;
+
+		pmd_k = pmd_offset(pud_k, ear0);
 		if (!pmd_present(*pmd_k))
 			goto no_context;
+
+		pud = pud_offset(pgd, ear0);
+		pmd = pmd_offset(pud, ear0);
 		set_pmd(pmd, *pmd_k);
 
 		pte_k = pte_offset_kernel(pmd_k, ear0);
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/init.c linux-2.6.10-mm1-frv/arch/frv/mm/init.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/init.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/mm/init.c	2005-01-04 15:45:26.000000000 +0000
@@ -111,6 +111,7 @@ void __init paging_init(void)
 #if CONFIG_HIGHMEM
 	if (num_physpages - num_mappedpages) {
 		pgd_t *pge;
+		pud_t *pue;
 		pmd_t *pme;
 
 		pkmap_page_table = alloc_bootmem_pages(PAGE_SIZE);
@@ -118,7 +119,8 @@ void __init paging_init(void)
 		memset(pkmap_page_table, 0, PAGE_SIZE);
 
 		pge = swapper_pg_dir + pgd_index_k(PKMAP_BASE);
-		pme = pmd_offset(pge, PKMAP_BASE);
+		pue = pud_offset(pge, PKMAP_BASE);
+		pme = pmd_offset(pue, PKMAP_BASE);
 		__set_pmd(pme, virt_to_phys(pkmap_page_table) | _PAGE_TABLE);
 	}
 #endif
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/mmu-context.c linux-2.6.10-mm1-frv/arch/frv/mm/mmu-context.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/mmu-context.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/mm/mmu-context.c	2005-01-04 16:27:37.000000000 +0000
@@ -87,12 +87,10 @@ static unsigned get_cxn(mm_context_t *ct
  * restore the current TLB miss handler mapped page tables into the MMU context and set up a
  * mapping for the page directory
  */
-void change_mm_context(mm_context_t *old, mm_context_t *ctx, pml4_t *pml4)
+void change_mm_context(mm_context_t *old, mm_context_t *ctx, pgd_t *pgd)
 {
 	unsigned long _pgd;
-	pgd_t *pgd;
 
-	pgd = pml4_pgd_offset(pml4, 0);
 	_pgd = virt_to_phys(pgd);
 
 	/* save the state of the outgoing MMU context */
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/pgalloc.c linux-2.6.10-mm1-frv/arch/frv/mm/pgalloc.c
--- /warthog/kernels/linux-2.6.10-mm1/arch/frv/mm/pgalloc.c	2005-01-04 11:14:45.000000000 +0000
+++ linux-2.6.10-mm1-frv/arch/frv/mm/pgalloc.c	2005-01-04 15:46:36.000000000 +0000
@@ -129,7 +129,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/mmu_context.h linux-2.6.10-mm1-frv/include/asm-frv/mmu_context.h
--- /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/mmu_context.h	2005-01-04 11:15:24.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/asm-frv/mmu_context.h	2005-01-04 16:33:48.000000000 +0000
@@ -23,7 +23,7 @@ static inline void enter_lazy_tlb(struct
 
 #ifdef CONFIG_MMU
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-extern void change_mm_context(mm_context_t *old, mm_context_t *ctx, pml4_t *_pml4);
+extern void change_mm_context(mm_context_t *old, mm_context_t *ctx, pgd_t *_pgd);
 extern void destroy_context(struct mm_struct *mm);
 
 #else
@@ -35,12 +35,12 @@ extern void destroy_context(struct mm_st
 #define switch_mm(prev, next, tsk)						\
 do {										\
 	if (prev != next)							\
-		change_mm_context(&prev->context, &next->context, next->pml4);	\
+		change_mm_context(&prev->context, &next->context, next->pgd);	\
 } while(0)
 
 #define activate_mm(prev, next)						\
 do {									\
-	change_mm_context(&prev->context, &next->context, next->pml4);	\
+	change_mm_context(&prev->context, &next->context, next->pgd);	\
 } while(0)
 
 #define deactivate_mm(tsk, mm)			\
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/page.h linux-2.6.10-mm1-frv/include/asm-frv/page.h
--- /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/page.h	2005-01-04 11:15:24.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/asm-frv/page.h	2005-01-04 16:18:50.000000000 +0000
@@ -23,18 +23,21 @@
 /*
  * These are used to make use of C type-checking..
  */
-typedef struct { unsigned long pte;	} pte_t;
-typedef struct { unsigned long ste[64];	} pmd_t;
-typedef struct { pmd_t         pge[1];	} pgd_t;
-typedef struct { unsigned long pgprot;	} pgprot_t;
+typedef struct { unsigned long	pte;	} pte_t;
+typedef struct { unsigned long	ste[64];} pmd_t;
+typedef struct { pmd_t		pue[1]; } pud_t;
+typedef struct { pud_t		pge[1];	} pgd_t;
+typedef struct { unsigned long	pgprot;	} pgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).ste[0])
+#define pud_val(x)	((x).pue[0])
 #define pgd_val(x)	((x).pge[0])
 #define pgprot_val(x)	((x).pgprot)
 
 #define __pte(x)	((pte_t) { (x) } )
 #define __pmd(x)	((pmd_t) { (x) } )
+#define __pud(x)	((pud_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 #define PTE_MASK	PAGE_MASK
@@ -91,8 +94,6 @@ extern unsigned long max_pfn;
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 #endif
 
-#include <asm-generic/nopml4-page.h>
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/pgalloc.h linux-2.6.10-mm1-frv/include/asm-frv/pgalloc.h
--- /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/pgalloc.h	2005-01-04 11:15:24.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/asm-frv/pgalloc.h	2005-01-04 16:29:56.000000000 +0000
@@ -31,6 +31,7 @@ do {										\
  * Allocate and free page tables.
  */
 
+extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(pgd_t *);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
@@ -57,9 +58,6 @@ static inline void pte_free(struct page 
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *) 2); })
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
-#define pgd_populate(mm, pmd, pte)	BUG()
-
-#include <asm-generic/nopml4-pgalloc.h>
 
 #endif /* CONFIG_MMU */
 
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/pgtable.h linux-2.6.10-mm1-frv/include/asm-frv/pgtable.h
--- /warthog/kernels/linux-2.6.10-mm1/include/asm-frv/pgtable.h	2005-01-04 11:15:24.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/asm-frv/pgtable.h	2005-01-04 16:31:52.000000000 +0000
@@ -90,21 +90,21 @@ extern unsigned long empty_zero_page;
  * we use 2-level page tables, folding the PMD (mid-level table) into the PGE (top-level entry)
  * [see Documentation/fujitsu/frv/mmu-layout.txt]
  *
- * 4th-Level Page Directory:
- *  - Size: 16KB
- *  - 1 PML4Es per PML4
- *  - Each PML4E holds 1 PGD and covers 4GB
- *
  * Page Directory:
  *  - Size: 16KB
  *  - 64 PGEs per PGD
- *  - Each PGE holds 1 PMD and covers 64MB
+ *  - Each PGE holds 1 PUD and covers 64MB
+ *
+ * Page Upper Directory:
+ *  - Size: 256B
+ *  - 1 PUE per PUD
+ *  - Each PUE holds 1 PMD and covers 64MB
  *
  * Page Mid-Level Directory
+ *  - Size: 256B
  *  - 1 PME per PMD
  *  - Each PME holds 64 STEs, all of which point to separate chunks of the same Page Table
  *  - All STEs are instantiated at the same time
- *  - Size: 256B
  *
  * Page Table
  *  - Size: 16KB
@@ -115,7 +115,7 @@ extern unsigned long empty_zero_page;
  *  - Size: 4KB
  *
  * total PTEs
- *	= 1 PML4E * 64 PGEs * 1 PMEs * 4096 PTEs
+ *	= 1 PML4E * 64 PGEs * 1 PUEs * 1 PMEs * 4096 PTEs
  *	= 1 PML4E * 64 PGEs * 64 STEs * 64 PTEs/FR451-PT
  *	= 262144 (or 256 * 1024)
  */
@@ -124,6 +124,12 @@ extern unsigned long empty_zero_page;
 #define PGDIR_MASK		(~(PGDIR_SIZE - 1))
 #define PTRS_PER_PGD		64
 
+#define PUD_SHIFT		26
+#define PTRS_PER_PUD		1
+#define PUD_SIZE		(1UL << PUD_SHIFT)
+#define PUD_MASK		(~(PUD_SIZE - 1))
+#define PUE_SIZE		256
+
 #define PMD_SHIFT		26
 #define PMD_SIZE		(1UL << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE - 1))
@@ -152,38 +158,98 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte)
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pmd_val(pud_val(e)))
 #define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pmd_val(pgd_val(e)))
+	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pmd_val(pud_val(pgd_val(e))))
+
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#define set_pte(pteptr, pteval)				\
+do {							\
+	*(pteptr) = (pteval);				\
+	asm volatile("dcf %M0" :: "U"(*pteptr));	\
+} while(0)
+
+#define set_pte_atomic(pteptr, pteval)		set_pte((pteptr), (pteval))
+
+/*
+ * pgd_offset() returns a (pgd_t *)
+ * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
+ */
+#define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
+
+/*
+ * a shortcut which implies the use of the kernel's pgd, instead
+ * of a process's
+ */
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /*
  * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
+ * setup: the pud is never bad, and a pud always exists (as it's folded
  * into the pgd entry)
  */
 static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
-#define pgd_clear(xp)				do { } while (0)
+static inline void pgd_clear(pgd_t *pgd)	{ }
 
+#define pgd_populate(mm, pgd, pud)		do { } while (0)
 /*
- * Certain architectures need to do special things when PTEs
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
+ * (puds are folded into pgds so this doesn't get actually called,
+ * but the define is needed for a generic inline function.)
  */
-#define set_pte(pteptr, pteval)				\
+#define set_pgd(pgdptr, pgdval)				\
 do {							\
-	*(pteptr) = (pteval);				\
-	asm volatile("dcf %M0" :: "U"(*pteptr));	\
+	memcpy((pgdptr), &(pgdval), sizeof(pgd_t));	\
+	asm volatile("dcf %M0" :: "U"(*(pgdptr)));	\
 } while(0)
 
-#define set_pte_atomic(pteptr, pteval)		set_pte((pteptr), (pteval))
+static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
+{
+	return (pud_t *) pgd;
+}
+
+#define pgd_page(pgd)				(pud_page((pud_t){ pgd }))
+#define pgd_page_kernel(pgd)			(pud_page_kernel((pud_t){ pgd }))
 
 /*
- * (pmds are folded into pgds so this doesn't get actually called,
+ * allocating and freeing a pud is trivial: the 1-entry pud is
+ * inside the pgd, so has no extra memory associated with it.
+ */
+#define pud_alloc_one(mm, address)		NULL
+#define pud_free(x)				do { } while (0)
+#define __pud_free_tlb(tlb, x)			do { } while (0)
+
+/*
+ * The "pud_xxx()" functions here are trivial for a folded two-level
+ * setup: the pmd is never bad, and a pmd always exists (as it's folded
+ * into the pud entry)
+ */
+static inline int pud_none(pud_t pud)		{ return 0; }
+static inline int pud_bad(pud_t pud)		{ return 0; }
+static inline int pud_present(pud_t pud)	{ return 1; }
+static inline void pud_clear(pud_t *pud)	{ }
+
+#define pud_populate(mm, pmd, pte)		do { } while (0)
+
+/*
+ * (pmds are folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
-#define set_pgd(pgdptr, pgdval)			(*(pgdptr) = pgdval)
+#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
 
+#define pud_page(pud)				(pmd_page((pmd_t){ pud }))
+#define pud_page_kernel(pud)			(pmd_page_kernel((pmd_t){ pud }))
+
+/*
+ * (pmds are folded into pgds so this doesn't get actually called,
+ * but the define is needed for a generic inline function.)
+ */
 extern void __set_pmd(pmd_t *pmdptr, unsigned long __pmd);
 
 #define set_pmd(pmdptr, pmdval)			\
@@ -191,11 +257,9 @@ do {						\
 	__set_pmd((pmdptr), (pmdval).ste[0]);	\
 } while(0)
 
-#define pgd_page(pgd)				((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
-
 #define __pmd_index(address)			0
 
-static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
+static inline pmd_t *pmd_offset(pud_t *dir, unsigned long address)
 {
 	return (pmd_t *) dir + __pmd_index(address);
 }
@@ -377,14 +441,14 @@ static inline pte_t pte_modify(pte_t pte
 	return pte;
 }
 
-#define page_pte(page)	page_pte_prot(page, __pgprot(0))
+#define page_pte(page)	page_pte_prot((page), __pgprot(0))
 
 /* to find an entry in a page-table-directory. */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_index_k(addr) pgd_index(addr)
 
-/* Find an entry in the third-level page table.. */
-#define __pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+/* Find an entry in the bottom-level page table.. */
+#define __pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
@@ -403,11 +467,11 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_offset_map_nested(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
-#define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
+#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
 #else
 #define pte_offset_map(dir, address) \
 	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
-#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_offset_map_nested(dir, address) pte_offset_map((dir), (address))
 #define pte_unmap(pte) do { } while (0)
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
@@ -451,7 +515,6 @@ static inline int pte_file(pte_t pte)
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
-#include <asm-generic/nopml4-pgtable.h>
 
 /*
  * preload information about a newly instantiated PTE into the SCR0/SCR1 PGE cache
@@ -459,9 +522,9 @@ static inline int pte_file(pte_t pte)
 static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 {
 	unsigned long ampr;
-	pml4_t *pml4e = pml4_offset(current->mm, address);
-	pgd_t *pge = pml4_pgd_offset(pml4e, address);
-	pmd_t *pme = pmd_offset(pge, address);
+	pgd_t *pge = pgd_offset(current->mm, address);
+	pud_t *pue = pud_offset(pge, address);
+	pmd_t *pme = pmd_offset(pue, address);
 
 	ampr = pme->ste[0] & 0xffffff00;
 	ampr |= xAMPRx_L | xAMPRx_SS_16Kb | xAMPRx_S | xAMPRx_C | xAMPRx_V;
