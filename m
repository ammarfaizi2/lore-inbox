Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWIEReO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWIEReO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWIEReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:34:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47596 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965207AbWIEReL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:34:11 -0400
Date: Tue, 5 Sep 2006 13:34:00 -0400
From: Kimball Murray <kimball.murray@gmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: Kimball Murray <kimball.murray@gmail.com>, <kimball.murray@gmail.com>,
       <akpm@digeo.com>, <ak@suse.de>
Message-Id: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
Subject: [Feature] x86_64 page tracking for Stratus servers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a git patch that implements a feature that is used by Stratus
fault-tolerant servers running on Intel x86_64 platforms.  It provides the
kernel mechanism that allows a loadable module to be able to keep track of
recently dirtied pages for the purpose of copying live, currently active
memory, to a spare memory module.

In Stratus servers, this spare memory module (and CPUs) will be brought into
lockstep with the original memory (and CPUs) in order to achieve fault
tolerance.

In order to make this feature work, it is necessary to track pages which have
been recently dirtied.  A simplified view of the algorithm used in the kernel
module is this:

1. Turn on the tracking functionality.
2. Copy all memory from active to spare memory module.
3. Until done:
	a) Identify all pages that were dirtied in the active memory since
	   the last copy operation.
	b) Copy all pages identified in 3a to the spare memory module.
	c) If number of pages still dirty is less than some threshhold,
		i.  "black out" the system (enter SMI)
		ii.  copy remaining pages in blackout context
		iii. goto step 4
	   Else
		goto 3a.
4. synchronize cpus
5. leave SMI, return to OS
6. System is now "Duplexed", and fault tolerant.

Most of this work is done in the loadable module, especially since copying
memory from one module to another is specific to Stratus boards, as is the
system blackout and final copy which takes place in an SMI context.

Given that, it is desireable to make the kernel patch as small and
unobtrusive as possible.  Also, regardless of whether or not the memory tracking
is active, the OS should handle dirty pages in the same way it always has.

To achieve this, the provided patch borrows an usused bit in the page table and
defines it to be a "SOFTDIRTY" bit (bit 9).  It's purpose is to provide an
alternate representation for dirty pages.  A few OS macros are changed such
that a page is considered dirty if either the hardware dirty bit or the
SOFTDIRTY bit is set.  This provides the freedom for a kernel module to
scan the page tables and clear the hardware dirty bits in ptes as it sets
the corresponding SOFTDIRTY bit.  To the OS, the page is still dirty.  But
for Stratus memory-tracking software (the loadable kernel module), there
now exists the ability to determine if a dirty page that was previously
copied from active to spare memory has in fact become dirty again.

For those that have made it this far, you may have noticed a hole in the
algorithm above.  Since we are traversing the page tables on a periodic
basis, what happens if a page reference is lost between passes?  We'd have
no way of knowing if the discarded pte referred to a dirty page.  To plug
that hole, the kernel patch also intercepts set_pte(...) so we can take a
look at the old, departing page and decide then if we need to track it.

And if you're really digging into this, you may be wondering about DMA, which
could lead to dirty pages without a corresponding dirty bit in the pte.  This
is handled by Stratus hardware, which can send north-bound DMA traffic to
both the active and spare memory modules at the same time.  Finally, Stratus
hardware has the ability to verify the accuracy of the memory copy after it's
all done, providing a means of testing both the kernel module and kernel
patch.

This code has been used by Stratus in several, previously released Linux
products (i386), and on an x86_64 platform that ships with Redhat's RHEL4.
The patch has been modified slightly from the RHEL4 code base, as the newer
kernels use a page table layout like this:

	pgd -> pud -> pmd -> pte

whereas RHEL4 used:

	pml4 -> pgd -> pmd -> pte

It is my hope that this feature, while essential to Stratus platforms, might
be of some use to somebody who perhaps would like to develop a tool to profile
memory usage.  One could, if desired, use this interface to monitor which
physical pages in a system become dirtied of a period of time and under
various loads.  Other vendors that would like to mirror live memory might also
be able to use this interface.  But for now, I have decided to put this feature
in the kernel hacking arena as a debug option.  I have also made the tracking
functions replaceable in case some other use is found for them.  The functions
may be replaced safely whenever the mm_tracking_struct.active flag is cleared.

Please consider this feature for inclusion in the kernel tree, as it is very
important to Stratus.

Signed-off-by:  Kimball Murray kimball.murray@stratus.com

--------------- snip -------------------------------------------
diff --git a/arch/x86_64/mm/Makefile b/arch/x86_64/mm/Makefile
index d25ac86..0ac1353 100644
--- a/arch/x86_64/mm/Makefile
+++ b/arch/x86_64/mm/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpag
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_K8_NUMA) += k8topology.o
 obj-$(CONFIG_ACPI_NUMA) += srat.o
+obj-$(CONFIG_TRACK_DIRTY_PAGES) += track.o
 
 hugetlbpage-y = ../../i386/mm/hugetlbpage.o
diff --git a/arch/x86_64/mm/track.c b/arch/x86_64/mm/track.c
new file mode 100644
index 0000000..d797175
--- /dev/null
+++ b/arch/x86_64/mm/track.c
@@ -0,0 +1,109 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <asm/atomic.h>
+#include <asm/mm_track.h>
+#include <asm/pgtable.h>
+
+/*
+ * For memory-tracking purposes, see mm_track.h for details.
+ */
+struct mm_tracker mm_tracking_struct = {0, ATOMIC_INIT(0), 0, 0};
+EXPORT_SYMBOL_GPL(mm_tracking_struct);
+
+void default_mm_track_pte(void * val)
+{
+	pte_t *ptep = (pte_t*)val;
+	unsigned long pfn;
+
+	if (!pte_present(*ptep))
+		return;
+
+	if (!pte_val(*ptep) & _PAGE_DIRTY)
+		return;
+
+	pfn = pte_pfn(*ptep);
+
+	if (pfn >= mm_tracking_struct.bitcnt)
+		return;
+
+	if (!test_and_set_bit(pfn, mm_tracking_struct.vector))
+		atomic_inc(&mm_tracking_struct.count);
+}
+
+#define LARGE_PMD_SIZE	(1 << PMD_SHIFT)
+
+void default_mm_track_pmd(void *val)
+{
+	int i;
+	pte_t *pte;
+	pmd_t *pmd = (pmd_t*)val;
+
+	if (!pmd_present(*pmd))
+		return;
+
+	if (unlikely(pmd_large(*pmd))) {
+		unsigned long addr, end;
+
+		if (!pte_val(*(pte_t*)val) & _PAGE_DIRTY)
+			return;
+
+		addr = pte_pfn(*(pte_t*)val) << PAGE_SHIFT;
+		end = addr + LARGE_PMD_SIZE;
+
+		while (addr < end) {
+			do_mm_track_phys((void*)addr);
+			addr +=  PAGE_SIZE;
+		}
+		return;
+	}
+
+	pte = pte_offset_kernel(pmd, 0);
+
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++)
+		do_mm_track_pte(pte);
+}
+
+static inline void track_as_pte(void *val) {
+	unsigned long pfn = pte_pfn(*(pte_t*)val);
+	if (pfn >= mm_tracking_struct.bitcnt)
+		return;
+
+	if (!test_and_set_bit(pfn, mm_tracking_struct.vector))
+		atomic_inc(&mm_tracking_struct.count);
+}
+
+void default_mm_track_pud(void *val)
+{
+	track_as_pte(val);
+}
+
+void default_mm_track_pgd(void *val)
+{
+	track_as_pte(val);
+}
+
+void default_mm_track_phys(void *val)
+{
+	unsigned long pfn;
+
+	pfn = (unsigned long)val >> PAGE_SHIFT;
+
+	if (pfn >= mm_tracking_struct.bitcnt)
+		return;
+
+	if (!test_and_set_bit(pfn, mm_tracking_struct.vector))
+		atomic_inc(&mm_tracking_struct.count);
+}
+
+void (*do_mm_track_pte)(void *) = default_mm_track_pte;
+void (*do_mm_track_pmd)(void *) = default_mm_track_pmd;
+void (*do_mm_track_pud)(void *) = default_mm_track_pud;
+void (*do_mm_track_pgd)(void *) = default_mm_track_pgd;
+void (*do_mm_track_phys)(void *) = default_mm_track_phys;
+
+EXPORT_SYMBOL_GPL(do_mm_track_pte);
+EXPORT_SYMBOL_GPL(do_mm_track_pmd);
+EXPORT_SYMBOL_GPL(do_mm_track_pud);
+EXPORT_SYMBOL_GPL(do_mm_track_pgd);
+EXPORT_SYMBOL_GPL(do_mm_track_phys);
+
diff --git a/include/asm-x86_64/mm_track.h b/include/asm-x86_64/mm_track.h
new file mode 100644
index 0000000..9af1ef5
--- /dev/null
+++ b/include/asm-x86_64/mm_track.h
@@ -0,0 +1,77 @@
+#ifndef __X86_64_MMTRACK_H__
+#define __X86_64_MMTRACK_H__
+
+#ifndef CONFIG_TRACK_DIRTY_PAGES
+
+#define mm_track_pte(ptep)		do { ; } while (0)
+#define mm_track_pmd(ptep)		do { ; } while (0)
+#define mm_track_pud(ptep)		do { ; } while (0)
+#define mm_track_pgd(ptep)		do { ; } while (0)
+#define mm_track_phys(x)		do { ; } while (0)
+
+#else
+
+#include <asm/page.h>
+#include <asm/atomic.h>
+ /*
+  * For memory-tracking purposes, if active is true (non-zero), the other
+  * elements of the structure are available for use.  Each time mm_track_pte
+  * is called, it increments count and sets a bit in the bitvector table.
+  * Each bit in the bitvector represents a physical page in memory.
+  *
+  * This is declared in arch/x86_64/mm/track.c.
+  *
+  * The in_use element is used in the code which drives the memory tracking
+  * environment.  When tracking is complete, the vector may be freed, but 
+  * only after the active flag is set to zero and the in_use count goes to
+  * zero.
+  *
+  * The count element indicates how many pages have been stored in the
+  * bitvector.  This is an optimization to avoid counting the bits in the
+  * vector between harvest operations.
+  */
+struct mm_tracker {
+	int active;		// non-zero if this structure in use
+	atomic_t count;		// number of pages tracked by mm_track()
+	unsigned long * vector;	// bit vector of modified pages
+	unsigned long bitcnt;	// number of bits in vector
+};
+extern struct mm_tracker mm_tracking_struct;
+
+extern void (*do_mm_track_pte)(void *);
+extern void (*do_mm_track_pmd)(void *);
+extern void (*do_mm_track_pud)(void *);
+extern void (*do_mm_track_pgd)(void *);
+extern void (*do_mm_track_phys)(void *);
+
+/* The mm_track routine is needed by macros in the pgtable-2level.h
+ * and pgtable-3level.h.
+ */
+static __inline__ void mm_track_pte(void * val)
+{
+	if (unlikely(mm_tracking_struct.active))
+		do_mm_track_pte(val);
+}
+static __inline__ void mm_track_pmd(void * val)
+{
+	if (unlikely(mm_tracking_struct.active))
+		do_mm_track_pmd(val);
+}
+static __inline__ void mm_track_pud(void * val)
+{
+	if (unlikely(mm_tracking_struct.active))
+		do_mm_track_pud(val);
+}
+static __inline__ void mm_track_pgd(void * val)
+{
+	if (unlikely(mm_tracking_struct.active))
+		do_mm_track_pgd(val);
+}
+static __inline__ void mm_track_phys(void * val)
+{
+	if (unlikely(mm_tracking_struct.active))
+		do_mm_track_phys(val);
+}
+#endif /* CONFIG_TRACK_DIRTY_PAGES */
+
+#endif /* __X86_64_MMTRACK_H__ */
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index a31ab4e..346346c 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -10,6 +10,9 @@
 #include <asm/bitops.h>
 #include <linux/threads.h>
 #include <asm/pda.h>
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+#include <asm/mm_track.h>
+#endif
 
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_physmem_pgt[512];
@@ -72,17 +75,26 @@ extern unsigned long empty_zero_page[PAG
 
 static inline void set_pte(pte_t *dst, pte_t val)
 {
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+	mm_track_pte(dst);
+#endif
 	pte_val(*dst) = pte_val(val);
 } 
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
 static inline void set_pmd(pmd_t *dst, pmd_t val)
 {
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+	mm_track_pmd(dst);
+#endif
         pmd_val(*dst) = pmd_val(val); 
 } 
 
 static inline void set_pud(pud_t *dst, pud_t val)
 {
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+	mm_track_pud(dst);
+#endif
 	pud_val(*dst) = pud_val(val);
 }
 
@@ -93,6 +105,9 @@ static inline void pud_clear (pud_t *pud
 
 static inline void set_pgd(pgd_t *dst, pgd_t val)
 {
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+	mm_track_pgd(dst);
+#endif
 	pgd_val(*dst) = pgd_val(val); 
 } 
 
@@ -104,7 +119,15 @@ static inline void pgd_clear (pgd_t * pg
 #define pud_page(pud) \
 ((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
 
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *xp)
+{
+	mm_track_pte(xp);
+	return __pte(xchg(&(xp)->pte, 0));
+}
+#else
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
+#endif
 
 struct mm_struct;
 
@@ -113,6 +136,9 @@ static inline pte_t ptep_get_and_clear_f
 	pte_t pte;
 	if (full) {
 		pte = *ptep;
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+		mm_track_pte(ptep);
+#endif
 		*ptep = __pte(0);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
@@ -151,6 +177,9 @@ static inline pte_t ptep_get_and_clear_f
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+#define _PAGE_BIT_SOFTDIRTY	9	/* save dirty state when hdw dirty bit cleared */
+#endif
 #define _PAGE_BIT_NX           63       /* No execute: only valid after cpuid check */
 
 #define _PAGE_PRESENT	0x001
@@ -163,6 +192,9 @@ static inline pte_t ptep_get_and_clear_f
 #define _PAGE_PSE	0x080	/* 2MB page */
 #define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+#define _PAGE_SOFTDIRTY	0x200
+#endif
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
 #define _PAGE_NX        (1UL<<_PAGE_BIT_NX)
@@ -170,7 +202,11 @@ static inline pte_t ptep_get_and_clear_f
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+#define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SOFTDIRTY)
+#else
 #define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
+#endif
 
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_NX)
@@ -269,7 +305,11 @@ static inline pte_t pfn_pte(unsigned lon
 static inline int pte_user(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 static inline int pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & (_PAGE_DIRTY | _PAGE_SOFTDIRTY); }
+#else
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
+#endif
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
@@ -277,7 +317,11 @@ static inline int pte_huge(pte_t pte)		{
 
 static inline pte_t pte_rdprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+static inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~(_PAGE_SOFTDIRTY|_PAGE_DIRTY))); return pte; }
+#else
 static inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
+#endif
 static inline pte_t pte_mkold(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_ACCESSED)); return pte; }
 static inline pte_t pte_wrprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_RW)); return pte; }
 static inline pte_t pte_mkread(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_USER)); return pte; }
@@ -293,7 +337,13 @@ static inline int ptep_test_and_clear_di
 {
 	if (!pte_dirty(*ptep))
 		return 0;
+#ifdef CONFIG_TRACK_DIRTY_PAGES
+	mm_track_pte(ptep);
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep) |
+	       test_and_clear_bit(_PAGE_BIT_SOFTDIRTY, ptep);
+#else
 	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte);
+#endif
 }
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 554ee68..ddabdf1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -39,6 +39,17 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
+config TRACK_DIRTY_PAGES
+	bool "Enable dirty page tracking"
+	depends on X86_64
+	default n
+	help
+	  Turning this on allows third party modules to use a
+	  kernel interface that can track dirty page generation
+	  in the system.  This can be used to copy/mirror live
+	  memory to another system, or perhaps even a replacement
+	  DIMM.  Most users will say n here.
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
