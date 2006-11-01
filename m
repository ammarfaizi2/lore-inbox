Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946757AbWKAKeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946757AbWKAKeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946762AbWKAKeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:34:50 -0500
Received: from ozlabs.org ([203.10.76.45]:7107 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946757AbWKAKet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:34:49 -0500
Subject: [PATCH 7/7] paravirtualization: Add mmu virtualization to
	paravirt-ops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162377150.23462.16.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
	 <1162377043.23462.12.camel@localhost.localdomain>
	 <1162377093.23462.14.camel@localhost.localdomain>
	 <1162377150.23462.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:34:44 +1100
Message-Id: <1162377284.23462.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
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

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -31,6 +31,7 @@
 #include <asm/delay.h>
 #include <asm/fixmap.h>
 #include <asm/apic.h>
+#include <asm/tlbflush.h>
 
 /* nop stub */
 static void native_nop(void)
@@ -373,6 +374,97 @@ static fastcall void native_io_delay(voi
 {
 	asm volatile("outb %al,$0x80");
 }
+
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
 
 /* These are in entry.S */
 extern fastcall void native_iret(void);
@@ -449,6 +541,23 @@ struct paravirt_ops paravirt_ops = {
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
===================================================================
--- a/arch/i386/mm/boot_ioremap.c
+++ b/arch/i386/mm/boot_ioremap.c
@@ -16,6 +16,7 @@
  */
 
 #undef CONFIG_X86_PAE
+#undef CONFIG_PARAVIRT
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -4,6 +4,7 @@
  * para-virtualization: those hooks are defined here. */
 #include <linux/linkage.h>
 #include <linux/stringify.h>
+#include <asm/page.h>
 
 #ifdef CONFIG_PARAVIRT
 /* These are the most performance critical ops, so we want to be able to patch
@@ -27,6 +28,7 @@ struct thread_struct;
 struct thread_struct;
 struct Xgt_desc_struct;
 struct tss_struct;
+struct mm_struct;
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
@@ -119,6 +121,23 @@ struct paravirt_ops
 	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
 	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
 	unsigned long (fastcall *apic_read)(unsigned long reg);
+#endif
+
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
 #endif
 
 	/* These two are jmp to, not actually called. */
@@ -302,6 +321,62 @@ static __inline unsigned long apic_read(
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
===================================================================
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
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
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -42,6 +42,7 @@ static inline int pte_exec_kernel(pte_t 
 	return pte_x(pte);
 }
 
+#ifndef CONFIG_PARAVIRT
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
@@ -71,32 +72,6 @@ static inline void set_pte_present(struc
 	ptep->pte_low = pte.pte_low;
 }
 
-#define set_pte_atomic(pteptr,pteval) \
-		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
-#define set_pmd(pmdptr,pmdval) \
-		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
-#define set_pud(pudptr,pudval) \
-		(*(pudptr) = (pudval))
-
-/*
- * Pentium-II erratum A13: in PAE mode we explicitly have to flush
- * the TLB via cr3 if the top-level pgd is changed...
- * We do not let the generic code free and clear pgd entries due to
- * this erratum.
- */
-static inline void pud_clear (pud_t * pud) { }
-
-#define pud_page(pud) \
-((struct page *) __va(pud_val(pud) & PAGE_MASK))
-
-#define pud_page_vaddr(pud) \
-((unsigned long) __va(pud_val(pud) & PAGE_MASK))
-
-
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
-			pmd_index(address))
-
 /*
  * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
  * entry, so clear the bottom half first and enforce ordering with a compiler
@@ -116,6 +91,33 @@ static inline void pmd_clear(pmd_t *pmd)
 	smp_wmb();
 	*(tmp + 1) = 0;
 }
+
+#define set_pte_atomic(pteptr,pteval) \
+		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+#define set_pmd(pmdptr,pmdval) \
+		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+#define set_pud(pudptr,pudval) \
+		(*(pudptr) = (pudval))
+#endif
+
+/*
+ * Pentium-II erratum A13: in PAE mode we explicitly have to flush
+ * the TLB via cr3 if the top-level pgd is changed...
+ * We do not let the generic code free and clear pgd entries due to
+ * this erratum.
+ */
+static inline void pud_clear (pud_t * pud) { }
+
+#define pud_page(pud) \
+((struct page *) __va(pud_val(pud) & PAGE_MASK))
+
+#define pud_page_vaddr(pud) \
+((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+			pmd_index(address))
 
 static inline pte_t raw_ptep_get_and_clear(pte_t *ptep)
 {
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
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
===================================================================
--- a/include/asm-i386/tlbflush.h
+++ b/include/asm-i386/tlbflush.h
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
@@ -45,9 +56,6 @@
 	} while (0)
 
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
-
-#define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg (%0)" ::"r" (addr) : "memory")
 
 #ifdef CONFIG_X86_INVLPG
 # define __flush_tlb_one(addr) __flush_tlb_single(addr)


