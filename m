Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWCMSN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWCMSN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWCMSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:13:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:35853 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932278AbWCMSNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:13:55 -0500
Date: Mon, 13 Mar 2006 10:13:50 -0800
Message-Id: <200603131813.k2DIDo1g005760@zach-dev.vmware.com>
Subject: [RFC, PATCH 19/24] i386 Vmi mmu changes
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:13:50.0708 (UTC) FILETIME=[E130CB40:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MMU code movement.  Unfortunately, this one is a little bit more
complicated than the rest.  We have to override the default accessors
that directly write to page table entries.  Because of the 2/3-level
PAE split in Linux, this turned out to be really ugly at first, but
by allowing the sub-arch layer to override the definitions and keeping
the native definitions in place, the code becomes much cleaner.

The assembly changes are because pgtable.h is not needed in these
files, and now generates bad input to the assembler due to raw C function
prototypes.

The change to process.c is somewhat different, but included here
because it makes use of the flush_deferred_cpu_state() subarch function,
which is used to synchronize all CPU state, including segmentation and
page tables.  This is required immediately before attempting to reload
the %fs and %gs segments.

The most recent addition was the sub-arch map_linear_pg/range functions,
which serve the purpose of notifying the hypervisor about remapped
page tables.  In early VMI initialization, the linearly mapped memory
range is communicated to the hypervisor by calling map_linear_range(),
which is sufficient for allowing VA->PA conversion during MMU calls in
most cases.  It is not sufficient if the kernel is compiled with page
tables in high memory, since the page tables may then be mapped in at
will.  In this case, the kernel must notify the hypervisor of these
mappings when they change.  This is the purpose of the changes to the
pte_offset_map functions.

This need more comments.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/kernel/efi_stub.S
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/efi_stub.S	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/efi_stub.S	2006-03-10 13:03:39.000000000 -0800
@@ -8,7 +8,6 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 
 /*
  * efi_call_phys(void *, ...) is a function with variable parameters.
Index: linux-2.6.16-rc5/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/head.S	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/head.S	2006-03-10 13:03:39.000000000 -0800
@@ -13,7 +13,6 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 #include <asm/desc.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
Index: linux-2.6.16-rc5/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/process.c	2006-03-10 13:03:36.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/process.c	2006-03-10 15:57:34.000000000 -0800
@@ -662,18 +662,6 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
-	 * Restore %fs and %gs if needed.
-	 *
-	 * Glibc normally makes %fs be zero, and %gs is one of
-	 * the TLS segments.
-	 */
-	if (unlikely(prev->fs | next->fs))
-		loadsegment(fs, next->fs);
-
-	if (prev->gs | next->gs)
-		loadsegment(gs, next->gs);
-
-	/*
 	 * Restore IOPL if needed.
 	 */
 	if (unlikely(prev->iopl != next->iopl))
@@ -696,6 +684,19 @@ struct task_struct fastcall * __switch_t
 		handle_io_bitmap(next, tss);
 
 	disable_tsc(prev_p, next_p);
+	flush_deferred_cpu_state();
+
+	/*
+	 * Restore %fs and %gs if needed.
+	 *
+	 * Glibc normally makes %fs be zero, and %gs is one of
+	 * the TLS segments.
+	 */
+	if (unlikely(prev->fs | next->fs))
+		loadsegment(fs, next->fs);
+
+	if (prev->gs | next->gs)
+		loadsegment(gs, next->gs);
 
 	return prev_p;
 }
Index: linux-2.6.16-rc5/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/smp.c	2006-03-10 13:03:36.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/smp.c	2006-03-10 15:57:34.000000000 -0800
@@ -346,6 +346,7 @@ out:
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
+	flush_deferred_cpu_state();
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
Index: linux-2.6.16-rc5/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/setup.c	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/setup.c	2006-03-10 13:03:39.000000000 -0800
@@ -1555,6 +1555,7 @@ void __init setup_arch(char **cmdline_p)
 	parse_cmdline_early(cmdline_p);
 
 	max_low_pfn = setup_memory();
+	mach_map_linear_range(__PAGE_OFFSET, max_low_pfn, 0);
 
 	/*
 	 * NOTE: before this point _nobody_ is allowed to allocate
Index: linux-2.6.16-rc5/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mm/fault.c	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mm/fault.c	2006-03-10 15:57:08.000000000 -0800
@@ -552,6 +552,13 @@ vmalloc_fault:
 			goto no_context;
 		set_pmd(pmd, *pmd_k);
 
+		/*
+		 * Needed.  We have just updated this root with a copy of
+		 * the kernel pmd.  To return without flushing would
+		 * introduce a fault loop.
+		 */
+		update_mmu_cache(NULL, pmd, pmd_k->pmd);
+
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
Index: linux-2.6.16-rc5/arch/i386/mm/init.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mm/init.c	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mm/init.c	2006-03-10 15:57:08.000000000 -0800
@@ -69,7 +69,6 @@ static pmd_t * __init one_md_table_init(
 	pud = pud_offset(pgd, 0);
 	pmd_table = pmd_offset(pud, 0);
 #endif
-
 	return pmd_table;
 }
 
@@ -81,6 +80,7 @@ static pte_t * __init one_page_table_ini
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		mach_setup_pte(__pa(page_table) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		if (page_table != pte_offset_kernel(pmd, 0))
 			BUG();	
@@ -382,6 +382,7 @@ static void __init pagetable_init (void)
 	 */
 	set_pgd(&pgd_base[0], pgd_base[USER_PTRS_PER_PGD]);
 #endif
+
 }
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
Index: linux-2.6.16-rc5/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mm/pgtable.c	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mm/pgtable.c	2006-03-10 15:57:08.000000000 -0800
@@ -240,20 +240,37 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
-	if (PTRS_PER_PMD == 1 || !pgd)
+	if (!pgd)
 		return pgd;
 
+	if (PTRS_PER_PMD == 1) {
+		mach_setup_pgd(__pa(pgd) >> PAGE_SHIFT, 
+                               __pa(swapper_pg_dir) >> PAGE_SHIFT,
+                               USER_PTRS_PER_PGD,
+                               PTRS_PER_PGD - USER_PTRS_PER_PGD);
+		return pgd;
+	}
+
+	/* PAE mode will set up the pmds here */
+	mach_setup_pgd(__pa(pgd) >> PAGE_SHIFT,
+                       __pa(swapper_pg_dir) >> PAGE_SHIFT,
+                       USER_PTRS_PER_PGD,
+                       PTRS_PER_PGD - USER_PTRS_PER_PGD);
 	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
+		mach_setup_pmd(__pa(pmd) >> PAGE_SHIFT);
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
+		mach_release_pmd(pgd_val(pgd[i]) >> PAGE_SHIFT);
 		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	}
+	mach_release_pgd(__pa(pgd) >> PAGE_SHIFT);
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -263,9 +280,13 @@ void pgd_free(pgd_t *pgd)
 	int i;
 
 	/* in the PAE case user pgd entries are overwritten before usage */
-	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
+	if (PTRS_PER_PMD > 1) {
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			mach_release_pmd(pgd_val(pgd[i]) >> PAGE_SHIFT);
 			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
-	/* in the non-PAE case, free_pgtables() clears user pgd entries */
+		}
+	}
+	/* in the non-PAE case, clear_page_range() clears user pgd entries */
+	mach_release_pgd(__pa(pgd) >> PAGE_SHIFT);
 	kmem_cache_free(pgd_cache, pgd);
 }
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/setup.c
===================================================================
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/smpboot_hooks.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/smpboot_hooks.c	2006-03-10 13:03:33.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/smpboot_hooks.c	2006-03-10 13:03:39.000000000 -0800
@@ -110,6 +110,7 @@ void __init smpboot_pre_start_secondary_
 {
         if (vmi_hypervisor_found()) {
                 *(unsigned long *) trampoline_base = 0xa5a5a5a5;
+		mach_map_linear_range(__PAGE_OFFSET, max_low_pfn, 0);
         }
 }
 
Index: linux-2.6.16-rc5/fs/binfmt_elf.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/binfmt_elf.c	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/fs/binfmt_elf.c	2006-03-10 13:03:39.000000000 -0800
@@ -951,6 +951,7 @@ static int load_elf_binary(struct linux_
 		sys_close(elf_exec_fileno);
 
 	set_binfmt(&elf_format);
+	arch_flush_predirty();
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = arch_setup_additional_pages(bprm, executable_stack);
Index: linux-2.6.16-rc5/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/pgalloc.h	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/pgalloc.h	2006-03-10 15:57:08.000000000 -0800
@@ -5,14 +5,22 @@
 #include <asm/fixmap.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
+#include <mach_pgalloc.h>
 
-#define pmd_populate_kernel(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
+#define pmd_populate_kernel(mm, pmd, pte) 			\
+do {								\
+	mach_setup_pte(__pa(pte) >> PAGE_SHIFT);		\
+	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)));		\
+} while (0)
 
 #define pmd_populate(mm, pmd, pte) 				\
+do {								\
+	mach_setup_pte(page_to_pfn(pte));			\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
-			(unsigned long long) PAGE_SHIFT)))
+			(unsigned long long) PAGE_SHIFT)));	\
+} while (0)
+
 /*
  * Allocate and free page tables.
  */
@@ -33,7 +41,11 @@ static inline void pte_free(struct page 
 }
 
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) 		\
+do {						\
+	tlb_remove_page((tlb),(pte));		\
+	mach_release_pte(page_to_pfn(pte));	\
+} while (0)
 
 #ifdef CONFIG_X86_PAE
 /*
Index: linux-2.6.16-rc5/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/pgtable-2level.h	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/pgtable-2level.h	2006-03-10 13:03:39.000000000 -0800
@@ -8,17 +8,6 @@
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-/*
- * Certain architectures need to do special things when PTEs
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
- */
-#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-#define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
@@ -61,4 +50,17 @@ static inline int pte_exec_kernel(pte_t 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#ifndef __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS
+#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#define ptep_get_and_clear(mm,addr,xp) __pte(xchg(&(xp)->pte_low, 0))
+#endif /* __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS */
+
+#define set_pte_atomic(pteptr, pteval) set_pte((pteptr), (pteval))
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
Index: linux-2.6.16-rc5/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/pgtable-3level.h	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/pgtable-3level.h	2006-03-10 15:57:08.000000000 -0800
@@ -44,36 +44,6 @@ static inline int pte_exec_kernel(pte_t 
 	return pte_x(pte);
 }
 
-/* Rules for using set_pte: the pte being assigned *must* be
- * either not present or in a state where the hardware will
- * not attempt to update the pte.  In places where this is
- * not possible, use pte_get_and_clear to obtain the old pte
- * value and then use set_pte to update it.  -ben
- */
-static inline void set_pte(pte_t *ptep, pte_t pte)
-{
-	ptep->pte_high = pte.pte_high;
-	smp_wmb();
-	ptep->pte_low = pte.pte_low;
-}
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
-#define __HAVE_ARCH_SET_PTE_ATOMIC
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
 #define pud_page(pud) \
 ((struct page *) __va(pud_val(pud) & PAGE_MASK))
 
@@ -85,18 +55,6 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
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
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
@@ -150,6 +108,54 @@ static inline pmd_t pfn_pmd(unsigned lon
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })
 
-#define __pmd_free_tlb(tlb, x)		do { } while (0)
+/*
+ * Sub-arch is allowed to override these, so check for definition first.
+ * New functions which write to hardware page table entries should go here.
+ */
+#ifndef __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS
+
+/* Rules for using set_pte: the pte being assigned *must* be
+ * either not present or in a state where the hardware will
+ * not attempt to update the pte.  In places where this is
+ * not possible, use pte_get_and_clear to obtain the old pte
+ * value and then use set_pte to update it.  -ben
+ */
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+
+#define set_pte_atomic(pteptr,pteval) \
+	        set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+
+#define set_pmd(pmdptr,pmdval) \
+	        set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+#define set_pud(pudptr,pudval) \
+	        (*(pudptr) = (pudval))
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
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
+#endif /* __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS */
+
+/*
+ * Pentium-II erratum A13: in PAE mode we explicitly have to flush
+ * the TLB via cr3 if the top-level pgd is changed...
+ * We do not let the generic code free and clear pgd entries due to
+ * this erratum.
+ */
+static inline void pud_clear (pud_t * pud) { }
+
+#define __HAVE_ARCH_SET_PTE_ATOMIC
 
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: linux-2.6.16-rc5/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/pgtable.h	2006-03-10 12:55:05.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/pgtable.h	2006-03-10 15:57:08.000000000 -0800
@@ -204,12 +204,10 @@ extern unsigned long long __PAGE_KERNEL,
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 /* To avoid harmful races, pmd_none(x) should check only the lower when PAE */
 #define pmd_none(x)	(!(unsigned long)pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 
@@ -244,19 +242,29 @@ static inline pte_t pte_mkyoung(pte_t pt
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= __LARGE_PTE; return pte; }
 
+#include <mach_pgtable.h>
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else
 # include <asm/pgtable-2level.h>
 #endif
 
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
+
+/*
+ * We give sub-architectures a chance to override functions which write to page
+ * tables, thus we check for existing definitions first.
+ */
+#ifndef __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	if (!pte_dirty(*ptep))
 		return 0;
 	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
 }
-
+ 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	if (!pte_young(*ptep))
@@ -281,6 +289,15 @@ static inline void ptep_set_wrprotect(st
 	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
 }
 
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	do {								  \
+		if (__dirty) {						  \
+			(__ptep)->pte_low = (__entry).pte_low;	  	  \
+			flush_tlb_page(__vma, __address);		  \
+		}							  \
+	} while (0)
+#endif /* !__HAVE_SUBARCH_PTE_WRITE_FUNCTIONS */
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
@@ -397,11 +414,26 @@ extern pte_t *lookup_address(unsigned lo
 
 extern void noexec_setup(const char *str);
 
+#include <asm/pgalloc.h>
 #if defined(CONFIG_HIGHPTE)
-#define pte_offset_map(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
-#define pte_offset_map_nested(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
+#define pte_offset_map(dir, address) 					\
+({									\
+	pte_t *__ptep;							\
+	unsigned pfn = pmd_val(*dir) >> PAGE_SHIFT;			\
+	__ptep = (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE0);	\
+	mach_map_linear_pt(0, __ptep, pfn);				\
+	__ptep = __ptep + pte_index(address);				\
+	__ptep;								\
+})
+#define pte_offset_map_nested(dir, address) 				\
+({									\
+	pte_t *__ptep;							\
+	unsigned pfn = pmd_val(*dir) >> PAGE_SHIFT;			\
+	__ptep = (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE1);	\
+	mach_map_linear_pt(1, __ptep, pfn);				\
+	__ptep = __ptep + pte_index(address);				\
+	__ptep;								\
+})
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else
@@ -412,26 +444,6 @@ extern void noexec_setup(const char *str
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
-/*
- * The i386 doesn't have any external MMU info: the kernel page
- * tables contain all the necessary information.
- *
- * Also, we only update the dirty/accessed state if we set
- * the dirty bit by hand in the kernel, since the hardware
- * will do the accessed bit for us, and we don't want to
- * race with other CPU's that might be updating the dirty
- * bit at the same time.
- */
-#define update_mmu_cache(vma,address,pte) do { } while (0)
-#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-	do {								  \
-		if (__dirty) {						  \
-			(__ptep)->pte_low = (__entry).pte_low;	  	  \
-			flush_tlb_page(__vma, __address);		  \
-		}							  \
-	} while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_FLATMEM
@@ -450,6 +462,7 @@ extern void noexec_setup(const char *str
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_pgtable.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_pgtable.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_pgtable.h	2006-03-10 15:58:48.000000000 -0800
@@ -0,0 +1,18 @@
+#ifndef _MACH_PGTABLE_H
+#define _MACH_PGTABLE_H
+
+/*
+ * The i386 doesn't have any external MMU info: the kernel page
+ * tables contain all the necessary information.
+ *
+ * Also, we only update the dirty/accessed state if we set
+ * the dirty bit by hand in the kernel, since the hardware
+ * will do the accessed bit for us, and we don't want to
+ * race with other CPU's that might be updating the dirty
+ * bit at the same time.
+ */
+#define update_mmu_cache(vma,address,pte) do { } while (0)
+  
+#define arch_flush_predirty()
+
+#endif /* _PGTABLE_OPS_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_pgalloc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_pgalloc.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_pgalloc.h	2006-03-10 15:58:58.000000000 -0800
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#ifndef _MACH_PGALLOC_H
+#define _MACH_PGALLOC_H
+
+#define mach_setup_pte(pfn)
+#define mach_release_pte(pfn)
+
+#define mach_setup_pmd(pfn)
+#define mach_release_pmd(pfn)
+
+#define mach_setup_pgd(pfn, root, base, pdirs)
+#define mach_release_pgd(pfn)
+
+#define mach_map_linear_pt(num, ptep, pfn)
+#define mach_map_linear_range(start, pages, pfn)
+
+#endif /* _MACH_PGALLOC_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/pgtable-2level-ops.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/pgtable-2level-ops.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/pgtable-2level-ops.h	2006-03-10 15:57:08.000000000 -0800
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+
+#ifndef _MACH_PGTABLE_LEVEL_OPS_H
+#define _MACH_PGTABLE_LEVEL_OPS_H
+
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#define set_pte(pteptr, pteval) \
+	vmi_set_pxe((unsigned long *)pteptr, pteval.pte_low)
+
+/*
+ * (pmds are folded into pgds so this doesn't get actually called,
+ * but the define is needed for a generic inline function.)
+ */
+#define set_pmd(pmdptr, pmdval) \
+	vmi_set_pxe((unsigned long *) pmdptr, (pmdval).pud.pgd.pgd)
+
+#define ptep_get_and_clear(mm,addr,xp) \
+	__pte(vmi_swap_pxe(&(xp)->pte_low, 0))
+
+static inline  int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)	
+{
+        int retval = vmi_test_and_clear_pxe_bit(&ptep->pte_low, _PAGE_BIT_DIRTY);
+	return retval;
+}
+
+static inline  int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)	
+{ 
+        int retval = vmi_test_and_clear_pxe_bit(&ptep->pte_low, _PAGE_BIT_ACCESSED);
+	return retval;
+}
+
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)		
+{ 
+        (void)vmi_test_and_clear_pxe_bit(&ptep->pte_low, _PAGE_BIT_RW);
+}
+
+#endif /* _MACH_PGTABLE_LEVEL_OPS_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/pgtable-3level-ops.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/pgtable-3level-ops.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/pgtable-3level-ops.h	2006-03-10 15:57:08.000000000 -0800
@@ -0,0 +1,44 @@
+#ifndef _MACH_PGTABLE_LEVEL_OPS_H
+#define _MACH_PGTABLE_LEVEL_OPS_H
+
+/* Rules for using set_pte: the pte being assigned *must* be
+ * either not present or in a state where the hardware will
+ * not attempt to update the pte.  In places where this is
+ * not possible, use pte_get_and_clear to obtain the old pte
+ * value and then use set_pte to update it.  -ben
+ */
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	vmi_set_pxe_long(pte_val(pte), ptep);
+}
+
+#define set_pte_atomic(pteptr,pteval) \
+		(void)VMI_SwapPxELongAtomic(pte_val(pteval), (uint64_t *)pteptr)
+
+#define set_pmd(pmdptr,pmdval) \
+		(void)VMI_SwapPxELongAtomic(pmd_val(pmdval), (uint64_t *)pmdptr)
+
+#define set_pud(pudptr,pudval) \
+		(void)VMI_SwapPxELongAtomic(pud_val(pudval), (uint64_t *)pudptr)
+
+#define ptep_get_and_clear(mm,addr,xp) \
+	__pte(VMI_DeactivatePxELongAtomic((uint64_t *)&(xp)->pte_low))
+
+static inline  int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr,pte_t *ptep)	
+{
+        int retval = vmi_test_and_clear_pxe_long_bit(ptep, _PAGE_BIT_DIRTY);
+	return retval;
+}
+
+static inline  int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr,pte_t *ptep)	
+{ 
+        int retval = vmi_test_and_clear_pxe_long_bit(ptep, _PAGE_BIT_ACCESSED);
+	return retval;
+}
+
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)		
+{ 
+        (void)vmi_test_and_clear_pxe_long_bit(ptep, _PAGE_BIT_RW);
+}
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_pgalloc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_pgalloc.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_pgalloc.h	2006-03-10 13:03:39.000000000 -0800
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#ifndef _MACH_PGALLOC_H
+#define _MACH_PGALLOC_H
+
+#include <vmi.h>
+
+#ifndef CONFIG_X86_PAE
+
+#define mach_setup_pte(pfn) vmi_allocate_page(pfn, VMI_PAGE_PT, 0, 0, 0)
+#define mach_release_pte(pfn) vmi_release_page(pfn, VMI_PAGE_PT)
+
+#define mach_setup_pmd(pfn)
+#define mach_release_pmd(pfn) 
+
+#define mach_setup_pgd(pfn, root, base, count) \
+        vmi_allocate_page(pfn, VMI_PAGE_PD, root, base, count)
+#define mach_release_pgd(pfn) vmi_release_page(pfn, VMI_PAGE_PD)
+
+#else /* CONFIG_X86_PAE */
+
+#define mach_setup_pte(pfn) vmi_allocate_page(pfn, VMI_PAGE_PAE|VMI_PAGE_PT, 0, 0, 0)
+#define mach_release_pte(pfn) vmi_release_page(pfn, VMI_PAGE_PAE|VMI_PAGE_PT)
+
+#define mach_setup_pmd(pfn) vmi_allocate_page(pfn, VMI_PAGE_PAE|VMI_PAGE_PD, 0, 0, 0)
+#define mach_release_pmd(pfn) vmi_release_page(pfn, VMI_PAGE_PAE|VMI_PAGE_PD)
+
+#define mach_setup_pgd(pfn, root, base, count) \
+        vmi_allocate_page(pfn, VMI_PAGE_PDP, root, base, count)
+#define mach_release_pgd(pfn) vmi_release_page(pfn, VMI_PAGE_PDP)
+#endif
+
+static inline void vmi_set_linear_mapping(const int slot, const u32 va, const u32 pages, const u32 ppn)
+{
+	vmi_wrap_call(
+		SetLinearMapping, "",
+		VMI_NO_OUTPUT,
+		4, XCONC(VMI_IREG1(slot), VMI_IREG2(va), VMI_IREG3(pages), VMI_IREG4(ppn)),
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+#define mach_map_linear_pt(num, ptep, pfn) \
+	vmi_set_linear_mapping(num+1, (uint32_t)ptep, 1, pfn)
+#define mach_map_linear_range(start, pages, pfn) \
+	vmi_set_linear_mapping(0, start, pages, pfn)
+
+#endif /* _MACH_PGALLOC_H */
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_pgtable.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_pgtable.h	2006-03-10 13:03:39.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_pgtable.h	2006-03-10 15:57:08.000000000 -0800
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+
+#ifndef _MACH_PGTABLE_H
+#define _MACH_PGTABLE_H
+
+#include <vmi.h>
+
+#define __HAVE_SUBARCH_PTE_WRITE_FUNCTIONS
+
+#ifdef CONFIG_X86_PAE
+# include <pgtable-3level-ops.h>
+#else
+# include <pgtable-2level-ops.h>
+#endif
+
+/*
+ * XXXpara - perhaps this really should use set_pte(), but for now this is
+ * more efficient.  We can't assume in general that ptes are writable even
+ * if the page table is about to be disconnected.
+ */
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
+{
+	pte_t pte;
+	if (full) {
+		pte = *ptep;
+		*ptep = __pte(0);
+	} else {
+		pte = ptep_get_and_clear(mm, addr, ptep);
+	}
+	return pte;
+}
+
+#define __HAVE_ARCH_PTE_CLEAR_FULL
+static inline void pte_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
+{
+	if (full)
+		*ptep = __pte(0);
+	else
+		set_pte(ptep, __pte(0));
+}
+
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	do {								  \
+		if (__dirty) {						  \
+			set_pte(__ptep, __entry);		  	  \
+			flush_tlb_page(__vma, __address);		  \
+		}							  \
+	} while (0)
+
+/*
+ * Catch NP->P transitions which need to flush the update queue
+ */
+#define update_mmu_cache(vma,address,pte) vmi_flush_pt_updates()
+
+#define arch_flush_predirty() vmi_flush_pt_updates()
+
+#endif /* _PGTABLE_OPS_H */
