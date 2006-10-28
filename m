Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWJ2Cq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWJ2Cq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWJ2CqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:46:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2473 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964951AbWJ2Cpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:45:50 -0400
Message-Id: <20061029024607.896903000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 7/7] Add mmu virtualization to paravirt-ops.
Content-Disposition: inline; filename=paravirt-mmu.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the three bare TLB accessor functions to paravirt-ops.  Most amusingly,
flush_tlb is redefined on SMP, so I can't call the paravirt op flush_tlb.
Instead, I chose to indicate the actual flush type, kernel (global) vs. user
(non-global).  Global in this sense means using the global bit in the page
table entry, which makes TLB entries persistent across CR3 reloads, not
global as in the SMP sense of invoking remote shootdowns, so the term is
confusingly overloaded.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

---
 arch/i386/kernel/paravirt.c       |  109 ++++++++++++++++++++++++++++++++++++++
 arch/i386/mm/boot_ioremap.c       |    1 
 include/asm-i386/paravirt.h       |   75 ++++++++++++++++++++++++++
 include/asm-i386/pgtable-2level.h |    5 +
 include/asm-i386/pgtable-3level.h |   42 +++++++-------
 include/asm-i386/pgtable.h        |    4 +
 include/asm-i386/tlbflush.h       |   18 ++++--
 7 files changed, 227 insertions(+), 27 deletions(-)

--- linux-2.6-pv.orig/arch/i386/kernel/paravirt.c
+++ linux-2.6-pv/arch/i386/kernel/paravirt.c
@@ -30,6 +30,7 @@
 #include <asm/delay.h>
 #include <asm/fixmap.h>
 #include <asm/apic.h>
+#include <asm/tlbflush.h>
 
 /* nop stub */
 static void native_nop(void)
@@ -404,6 +405,97 @@ static fastcall unsigned long native_api
 }
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+static fastcall void native_flush_tlb(void)
+{
+	__native_flush_tlb();
+}
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+static fastcall void native_flush_tlb_global(void)
+{
+	__native_flush_tlb_global();
+}
+
+static fastcall void native_flush_tlb_single(u32 addr)
+{
+	__native_flush_tlb_single(addr);
+}
+
+#ifndef CONFIG_X86_PAE
+static fastcall void native_set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+}
+
+static fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+}
+
+static fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	*pmdp = pmdval;
+}
+
+#else /* CONFIG_X86_PAE */
+
+static fastcall void native_set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+
+static fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+
+static fastcall void native_set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+
+static fastcall void native_set_pte_atomic(pte_t *ptep, pte_t pteval)
+{
+	set_64bit((unsigned long long *)ptep,pte_val(pteval));
+}
+
+static fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	set_64bit((unsigned long long *)pmdp,pmd_val(pmdval));
+}
+
+static fastcall void native_set_pud(pud_t *pudp, pud_t pudval)
+{
+	*pudp = pudval;
+}
+
+static fastcall void native_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = 0;
+}
+
+static fastcall void native_pmd_clear(pmd_t *pmd)
+{
+	u32 *tmp = (u32 *)pmd;
+	*tmp = 0;
+	smp_wmb();
+	*(tmp + 1) = 0;
+}
+#endif /* CONFIG_X86_PAE */
+
 /* These are in entry.S */
 extern fastcall void native_iret(void);
 extern fastcall void native_irq_enable_sysexit(void);
@@ -480,6 +572,23 @@ struct paravirt_ops paravirt_ops = {
 	.apic_read = native_apic_read,
 #endif
 
+	.flush_tlb_user = native_flush_tlb,
+	.flush_tlb_kernel = native_flush_tlb_global,
+	.flush_tlb_single = native_flush_tlb_single,
+
+	.set_pte = native_set_pte,
+	.set_pte_at = native_set_pte_at,
+	.set_pmd = native_set_pmd,
+	.pte_update = (void *)native_nop,
+	.pte_update_defer = (void *)native_nop,
+#ifdef CONFIG_X86_PAE
+	.set_pte_atomic = native_set_pte_atomic,
+	.set_pte_present = native_set_pte_present,
+	.set_pud = native_set_pud,
+	.pte_clear = native_pte_clear,
+	.pmd_clear = native_pmd_clear,
+#endif
+
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
--- linux-2.6-pv.orig/arch/i386/mm/boot_ioremap.c
+++ linux-2.6-pv/arch/i386/mm/boot_ioremap.c
@@ -16,6 +16,7 @@
  */
 
 #undef CONFIG_X86_PAE
+#undef CONFIG_PARAVIRT
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
--- linux-2.6-pv.orig/include/asm-i386/paravirt.h
+++ linux-2.6-pv/include/asm-i386/paravirt.h
@@ -4,6 +4,7 @@
  * para-virtualization: those hooks are defined here. */
 #include <linux/linkage.h>
 #include <linux/stringify.h>
+#include <asm/page.h>
 
 #ifdef CONFIG_PARAVIRT
 /* These are the most performance critical ops, so we want to be able to patch
@@ -27,6 +28,7 @@
 struct thread_struct;
 struct Xgt_desc_struct;
 struct tss_struct;
+struct mm_struct;
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
@@ -121,6 +123,23 @@ struct paravirt_ops
 	unsigned long (fastcall *apic_read)(unsigned long reg);
 #endif
 
+	void (fastcall *flush_tlb_user)(void);
+	void (fastcall *flush_tlb_kernel)(void);
+	void (fastcall *flush_tlb_single)(u32 addr);
+
+	void (fastcall *set_pte)(pte_t *ptep, pte_t pteval);
+	void (fastcall *set_pte_at)(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval);
+	void (fastcall *set_pmd)(pmd_t *pmdp, pmd_t pmdval);
+	void (fastcall *pte_update)(struct mm_struct *mm, u32 addr, pte_t *ptep);
+	void (fastcall *pte_update_defer)(struct mm_struct *mm, u32 addr, pte_t *ptep);
+#ifdef CONFIG_X86_PAE
+	void (fastcall *set_pte_atomic)(pte_t *ptep, pte_t pteval);
+	void (fastcall *set_pte_present)(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
+	void (fastcall *set_pud)(pud_t *pudp, pud_t pudval);
+	void (fastcall *pte_clear)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+	void (fastcall *pmd_clear)(pmd_t *pmdp);
+#endif
+
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
@@ -307,6 +326,62 @@ static __inline unsigned long apic_read(
 #endif
 
 
+#define __flush_tlb() paravirt_ops.flush_tlb_user()
+#define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
+#define __flush_tlb_single(addr) paravirt_ops.flush_tlb_single(addr)
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte(ptep, pteval);
+}
+
+static inline void set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	paravirt_ops.set_pmd(pmdp, pmdval);
+}
+
+static inline void pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	paravirt_ops.pte_update(mm, addr, ptep);
+}
+
+static inline void pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	paravirt_ops.pte_update_defer(mm, addr, ptep);
+}
+
+#ifdef CONFIG_X86_PAE
+static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte_atomic(ptep, pteval);
+}
+
+static inline void set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	paravirt_ops.set_pte_present(mm, addr, ptep, pte);
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pudval)
+{
+	paravirt_ops.set_pud(pudp, pudval);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	paravirt_ops.pte_clear(mm, addr, ptep);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	paravirt_ops.pmd_clear(pmdp);
+}
+#endif
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */
--- linux-2.6-pv.orig/include/asm-i386/pgtable-2level.h
+++ linux-2.6-pv/include/asm-i386/pgtable-2level.h
@@ -11,11 +11,14 @@
  * within a page table are directly modified.  Thus, the following
  * hook is made available.
  */
+#ifndef CONFIG_PARAVIRT
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#endif
+
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
 #define set_pte_present(mm,addr,ptep,pteval) set_pte_at(mm,addr,ptep,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
--- linux-2.6-pv.orig/include/asm-i386/pgtable-3level.h
+++ linux-2.6-pv/include/asm-i386/pgtable-3level.h
@@ -42,6 +42,7 @@ static inline int pte_exec_kernel(pte_t 
 	return pte_x(pte);
 }
 
+#ifndef CONFIG_PARAVIRT
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
@@ -71,12 +72,33 @@ static inline void set_pte_present(struc
 	ptep->pte_low = pte.pte_low;
 }
 
+/*
+ * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
+ * entry, so clear the bottom half first and enforce ordering with a compiler
+ * barrier.
+ */
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = 0;
+}
+
+static inline void pmd_clear(pmd_t *pmd)
+{
+	u32 *tmp = (u32 *)pmd;
+	*tmp = 0;
+	smp_wmb();
+	*(tmp + 1) = 0;
+}
+
 #define set_pte_atomic(pteptr,pteval) \
 		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
 #define set_pmd(pmdptr,pmdval) \
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
 		(*(pudptr) = (pudval))
+#endif
 
 /*
  * Pentium-II erratum A13: in PAE mode we explicitly have to flush
@@ -97,26 +119,6 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
-/*
- * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
- * entry, so clear the bottom half first and enforce ordering with a compiler
- * barrier.
- */
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	ptep->pte_low = 0;
-	smp_wmb();
-	ptep->pte_high = 0;
-}
-
-static inline void pmd_clear(pmd_t *pmd)
-{
-	u32 *tmp = (u32 *)pmd;
-	*tmp = 0;
-	smp_wmb();
-	*(tmp + 1) = 0;
-}
-
 static inline pte_t raw_ptep_get_and_clear(pte_t *ptep)
 {
 	pte_t res;
--- linux-2.6-pv.orig/include/asm-i386/pgtable.h
+++ linux-2.6-pv/include/asm-i386/pgtable.h
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
+#include <asm/paravirt.h>
 
 #ifndef _I386_BITOPS_H
 #include <asm/bitops.h>
@@ -246,6 +247,7 @@ static inline pte_t pte_mkhuge(pte_t pte
 # include <asm/pgtable-2level.h>
 #endif
 
+#ifndef CONFIG_PARAVIRT
 /*
  * Rules for using pte_update - it must be called after any PTE update which
  * has not been done using the set_pte / clear_pte interfaces.  It is used by
@@ -261,7 +263,7 @@ static inline pte_t pte_mkhuge(pte_t pte
  */
 #define pte_update(mm, addr, ptep)		do { } while (0)
 #define pte_update_defer(mm, addr, ptep)	do { } while (0)
-
+#endif
 
 /*
  * We only update the dirty/accessed state if we set
--- linux-2.6-pv.orig/include/asm-i386/tlbflush.h
+++ linux-2.6-pv/include/asm-i386/tlbflush.h
@@ -4,7 +4,15 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
-#define __flush_tlb()							\
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define __flush_tlb() __native_flush_tlb()
+#define __flush_tlb_global() __native_flush_tlb_global()
+#define __flush_tlb_single(addr) __native_flush_tlb_single(addr)
+#endif
+
+#define __native_flush_tlb()						\
 	do {								\
 		unsigned int tmpreg;					\
 									\
@@ -19,7 +27,7 @@
  * Global pages have to be flushed a bit differently. Not a real
  * performance problem because this does not happen often.
  */
-#define __flush_tlb_global()						\
+#define __native_flush_tlb_global()					\
 	do {								\
 		unsigned int tmpreg, cr4, cr4_orig;			\
 									\
@@ -36,6 +44,9 @@
 			: "memory");					\
 	} while (0)
 
+#define __native_flush_tlb_single(addr) 				\
+	__asm__ __volatile__("invlpg (%0)" ::"r" (addr) : "memory")
+
 # define __flush_tlb_all()						\
 	do {								\
 		if (cpu_has_pge)					\
@@ -46,9 +57,6 @@
 
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
 
-#define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg (%0)" ::"r" (addr) : "memory")
-
 #ifdef CONFIG_X86_INVLPG
 # define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else

--
