Return-Path: <linux-kernel-owner+w=401wt.eu-S1422797AbXAMXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbXAMXQs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422812AbXAMXKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:53 -0500
Received: from gw.goop.org ([64.81.55.164]:59885 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030521AbXAMXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:25 -0500
Message-Id: <20070113014647.376622753@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:42 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 03/20] XEN-paravirt: paravirt: page-table accessors
Content-Disposition: inline; filename=paravirt-pte-accessors.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a set of accessors to pack, unpack and modify page table entries
(at all levels).  This allows a paravirt implementation to control the
contents of pgd/pmd/pte entries.  For example, Xen uses this to
convert the (pseudo-)physical address into a machine address when
populating a pagetable entry, and converting back to pphys address
when an entry is read.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

--
 arch/i386/kernel/paravirt.c       |  113 +++++++++++++++++++++++++++++++++----
 arch/i386/kernel/vmlinux.lds.S    |    3 
 include/asm-i386/page.h           |   18 ++++-
 include/asm-i386/paravirt.h       |   68 +++++++++++++++++++++-
 include/asm-i386/pgtable-2level.h |    5 -
 include/asm-i386/pgtable-3level.h |   27 ++++----
 6 files changed, 199 insertions(+), 35 deletions(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -34,7 +34,7 @@
 #include <asm/tlbflush.h>
 
 /* nop stub */
-static void native_nop(void)
+void native_nop(void)
 {
 }
 
@@ -400,38 +400,74 @@ static fastcall void native_flush_tlb_si
 }
 
 #ifndef CONFIG_X86_PAE
-static fastcall void native_set_pte(pte_t *ptep, pte_t pteval)
+fastcall void native_set_pte(pte_t *ptep, pte_t pteval)
 {
 	*ptep = pteval;
 }
 
-static fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
+fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
 {
 	*ptep = pteval;
 }
 
-static fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
 	*pmdp = pmdval;
 }
 
+fastcall unsigned long native_pte_val(pte_t pte)
+{
+	return pte.pte_low;
+}
+
+fastcall unsigned long native_pmd_val(pmd_t pmd)
+{
+	BUG();
+	return 0;
+}
+
+fastcall unsigned long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+fastcall pte_t native_make_pte(unsigned long pte)
+{
+	return (pte_t){ pte };
+}
+
+fastcall pmd_t native_make_pmd(unsigned long pmd)
+{
+	BUG();
+}
+
+fastcall pgd_t native_make_pgd(unsigned long pgd)
+{
+	return (pgd_t){ pgd };
+}
+
+fastcall pte_t native_ptep_get_and_clear(pte_t *ptep)
+{
+	return __pte(xchg(&(ptep)->pte_low, 0));
+}
+
 #else /* CONFIG_X86_PAE */
 
-static fastcall void native_set_pte(pte_t *ptep, pte_t pte)
+fastcall void native_set_pte(pte_t *ptep, pte_t pte)
 {
 	ptep->pte_high = pte.pte_high;
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 }
 
-static fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
+fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
 {
 	ptep->pte_high = pte.pte_high;
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 }
 
-static fastcall void native_set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+fastcall void native_set_pte_present(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
 {
 	ptep->pte_low = 0;
 	smp_wmb();
@@ -440,34 +476,76 @@ static fastcall void native_set_pte_pres
 	ptep->pte_low = pte.pte_low;
 }
 
-static fastcall void native_set_pte_atomic(pte_t *ptep, pte_t pteval)
+fastcall void native_set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
 	set_64bit((unsigned long long *)ptep,pte_val(pteval));
 }
 
-static fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
 	set_64bit((unsigned long long *)pmdp,pmd_val(pmdval));
 }
 
-static fastcall void native_set_pud(pud_t *pudp, pud_t pudval)
+fastcall void native_set_pud(pud_t *pudp, pud_t pudval)
 {
 	*pudp = pudval;
 }
 
-static fastcall void native_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+fastcall void native_pte_clear(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
 	ptep->pte_low = 0;
 	smp_wmb();
 	ptep->pte_high = 0;
 }
 
-static fastcall void native_pmd_clear(pmd_t *pmd)
+fastcall void native_pmd_clear(pmd_t *pmd)
 {
 	u32 *tmp = (u32 *)pmd;
 	*tmp = 0;
 	smp_wmb();
 	*(tmp + 1) = 0;
+}
+
+fastcall unsigned long long native_pte_val(pte_t pte)
+{
+	return pte.pte_low | ((unsigned long long)pte.pte_high << 32);
+}
+
+fastcall unsigned long long native_pmd_val(pmd_t pmd)
+{
+	return pmd.pmd;
+}
+
+fastcall unsigned long long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+fastcall pte_t native_make_pte(unsigned long long pte)
+{
+	return (pte_t){ pte };
+}
+
+fastcall pmd_t native_make_pmd(unsigned long long pmd)
+{
+	return (pmd_t){ pmd };
+}
+
+fastcall pgd_t native_make_pgd(unsigned long long pgd)
+{
+	return (pgd_t){ pgd };
+}
+
+fastcall pte_t native_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits */
+	res.pte_low = xchg(&ptep->pte_low, 0);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = 0;
+
+	return res;
 }
 #endif /* CONFIG_X86_PAE */
 
@@ -564,6 +642,9 @@ struct paravirt_ops paravirt_ops = {
 	.set_pmd = native_set_pmd,
 	.pte_update = (void *)native_nop,
 	.pte_update_defer = (void *)native_nop,
+
+	.ptep_get_and_clear = native_ptep_get_and_clear,
+
 #ifdef CONFIG_X86_PAE
 	.set_pte_atomic = native_set_pte_atomic,
 	.set_pte_present = native_set_pte_present,
@@ -572,6 +653,14 @@ struct paravirt_ops paravirt_ops = {
 	.pmd_clear = native_pmd_clear,
 #endif
 
+	.pte_val = native_pte_val,
+	.pmd_val = native_pmd_val,
+	.pgd_val = native_pgd_val,
+
+	.make_pte = native_make_pte,
+	.make_pmd = native_make_pmd,
+	.make_pgd = native_make_pgd,
+
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 
===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -21,6 +21,9 @@
 #include <asm/page.h>
 #include <asm/cache.h>
 #include <asm/boot.h>
+
+#undef ENTRY
+#undef ALIGN
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
===================================================================
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -11,7 +11,6 @@
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
-
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -48,9 +47,11 @@ typedef struct { unsigned long long pmd;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 typedef struct { unsigned long long pgprot; } pgprot_t;
+#ifndef CONFIG_PARAVIRT
 #define pmd_val(x)	((x).pmd)
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define __pmd(x) ((pmd_t) { (x) } )
+#endif	/* CONFIG_PARAVIRT */
 #define HPAGE_SHIFT	21
 #include <asm-generic/pgtable-nopud.h>
 #else
@@ -58,7 +59,9 @@ typedef struct { unsigned long pgd; } pg
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define boot_pte_t pte_t /* or would you rather have a typedef */
+#ifndef CONFIG_PARAVIRT
 #define pte_val(x)	((x).pte_low)
+#endif
 #define HPAGE_SHIFT	22
 #include <asm-generic/pgtable-nopmd.h>
 #endif
@@ -71,12 +74,14 @@ typedef struct { unsigned long pgprot; }
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
+#define pgprot_val(x)	((x).pgprot)
+#define __pgprot(x)	((pgprot_t) { (x) } )
+
+#ifndef CONFIG_PARAVIRT
 #define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
-
 #define __pte(x) ((pte_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
-#define __pgprot(x)	((pgprot_t) { (x) } )
+#endif
 
 #endif /* !__ASSEMBLY__ */
 
@@ -143,6 +148,11 @@ extern int page_is_ram(unsigned long pag
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#ifdef CONFIG_PARAVIRT
+/* After pte_t, etc, have been defined */
+#include <asm/paravirt.h>
+#endif
+
 #define __HAVE_ARCH_GATE_AREA 1
 #endif /* __KERNEL__ */
 
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -25,6 +25,8 @@
 #define CLBR_ANY 0x7
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 struct thread_struct;
 struct Xgt_desc_struct;
 struct tss_struct;
@@ -140,12 +142,31 @@ struct paravirt_ops
 	void (fastcall *set_pmd)(pmd_t *pmdp, pmd_t pmdval);
 	void (fastcall *pte_update)(struct mm_struct *mm, u32 addr, pte_t *ptep);
 	void (fastcall *pte_update_defer)(struct mm_struct *mm, u32 addr, pte_t *ptep);
+
+	pte_t (fastcall *ptep_get_and_clear)(pte_t *ptep);
+
 #ifdef CONFIG_X86_PAE
 	void (fastcall *set_pte_atomic)(pte_t *ptep, pte_t pteval);
-	void (fastcall *set_pte_present)(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
+	void (fastcall *set_pte_present)(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte);
 	void (fastcall *set_pud)(pud_t *pudp, pud_t pudval);
-	void (fastcall *pte_clear)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+	void (fastcall *pte_clear)(struct mm_struct *mm, u32 addr, pte_t *ptep);
 	void (fastcall *pmd_clear)(pmd_t *pmdp);
+
+	unsigned long long (fastcall *pte_val)(pte_t);
+	unsigned long long (fastcall *pmd_val)(pmd_t);
+	unsigned long long (fastcall *pgd_val)(pgd_t);
+
+	pte_t (fastcall *make_pte)(unsigned long long pte);
+	pmd_t (fastcall *make_pmd)(unsigned long long pmd);
+	pgd_t (fastcall *make_pgd)(unsigned long long pgd);
+#else  /* !CONFIG_X86_PAE */
+	unsigned long (fastcall *pte_val)(pte_t);
+	unsigned long (fastcall *pmd_val)(pmd_t);
+	unsigned long (fastcall *pgd_val)(pgd_t);
+
+	pte_t (fastcall *make_pte)(unsigned long pte);
+	pmd_t (fastcall *make_pmd)(unsigned long pmd);
+	pgd_t (fastcall *make_pgd)(unsigned long pgd);
 #endif
 
 	void (fastcall *set_lazy_mode)(int mode);
@@ -163,6 +184,24 @@ struct paravirt_ops
 		__attribute__((__section__(".paravirtprobe"))) = fn
 
 extern struct paravirt_ops paravirt_ops;
+
+#ifdef CONFIG_X86_PAE
+fastcall unsigned long long native_pte_val(pte_t);
+fastcall unsigned long long native_pmd_val(pmd_t);
+fastcall unsigned long long native_pgd_val(pgd_t);
+
+fastcall pte_t native_make_pte(unsigned long long pte);
+fastcall pmd_t native_make_pmd(unsigned long long pmd);
+fastcall pgd_t native_make_pgd(unsigned long long pgd);
+#else
+fastcall unsigned long native_pte_val(pte_t);
+fastcall unsigned long native_pmd_val(pmd_t);
+fastcall unsigned long native_pgd_val(pgd_t);
+
+fastcall pte_t native_make_pte(unsigned long pte);
+fastcall pmd_t native_make_pmd(unsigned long pmd);
+fastcall pgd_t native_make_pgd(unsigned long pgd);
+#endif
 
 #define paravirt_enabled() (paravirt_ops.paravirt_enabled)
 
@@ -215,6 +254,8 @@ static inline void __cpuid(unsigned int 
 #define read_cr4() paravirt_ops.read_cr4()
 #define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
 #define write_cr4(x) paravirt_ops.write_cr4(x)
+
+#define raw_ptep_get_and_clear(xp)	(paravirt_ops.ptep_get_and_clear(xp))
 
 static inline void raw_safe_halt(void)
 {
@@ -297,6 +338,17 @@ static inline void halt(void)
 	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
 #define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
 
+#define __pte(x)	paravirt_ops.make_pte(x)
+#define __pgd(x)	paravirt_ops.make_pgd(x)
+
+#define pte_val(x)	paravirt_ops.pte_val(x)
+#define pgd_val(x)	paravirt_ops.pgd_val(x)
+
+#ifdef CONFIG_X86_PAE
+#define __pmd(x)	paravirt_ops.make_pmd(x)
+#define pmd_val(x)	paravirt_ops.pmd_val(x)
+#endif
+
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void) {
 	paravirt_ops.io_delay();
@@ -336,6 +388,18 @@ static inline void setup_secondary_clock
 	paravirt_ops.setup_secondary_clock();
 }
 #endif
+
+
+fastcall void native_set_pte(pte_t *ptep, pte_t pteval);
+fastcall void native_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval);
+fastcall void native_set_pmd(pmd_t *pmdp, pmd_t pmdval);
+fastcall void native_set_pte_present(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte);
+fastcall void native_set_pte_atomic(pte_t *ptep, pte_t pteval);
+fastcall void native_set_pud(pud_t *pudp, pud_t pudval);
+fastcall void native_pte_clear(struct mm_struct *mm, u32 addr, pte_t *ptep);
+fastcall void native_pmd_clear(pmd_t *pmd);
+fastcall pte_t native_ptep_get_and_clear(pte_t *ptep);
+void native_nop(void);
 
 #ifdef CONFIG_SMP
 static inline void startup_ipi_hook(int phys_apicid, unsigned long start_eip,
===================================================================
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -15,6 +15,7 @@
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#define raw_ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 #endif
 
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
@@ -23,11 +24,9 @@
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 
-#define raw_ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
-
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
-#define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
+#define pte_pfn(x)		(pte_val(x) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -98,6 +98,18 @@ static inline void pmd_clear(pmd_t *pmd)
 	smp_wmb();
 	*(tmp + 1) = 0;
 }
+
+static inline pte_t raw_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits */
+	res.pte_low = xchg(&ptep->pte_low, 0);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = 0;
+
+	return res;
+}
 #endif
 
 /*
@@ -119,18 +131,6 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
-static inline pte_t raw_ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t res;
-
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low = xchg(&ptep->pte_low, 0);
-	res.pte_high = ptep->pte_high;
-	ptep->pte_high = 0;
-
-	return res;
-}
-
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t a, pte_t b)
 {
@@ -146,8 +146,7 @@ static inline int pte_none(pte_t pte)
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte.pte_low >> PAGE_SHIFT) |
-		(pte.pte_high << (32 - PAGE_SHIFT));
+	return pte_val(pte) >> PAGE_SHIFT;
 }
 
 extern unsigned long long __supported_pte_mask;

-- 

