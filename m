Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTB1KIh>; Fri, 28 Feb 2003 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTB1KIh>; Fri, 28 Feb 2003 05:08:37 -0500
Received: from holomorphy.com ([66.224.33.161]:6278 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267716AbTB1KIf>;
	Fri, 28 Feb 2003 05:08:35 -0500
Date: Fri, 28 Feb 2003 02:18:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.63-2
Message-ID: <20030228101841.GA1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) fix longstanding binary compatibility bug             
	The problem this fixes is scrambled memory getting 
	accidentally scrambled by mprotect(). PTE_MASK was defined as
	PAGE_MASK, and the chain of dependencies meant it was used a
	grand total of once in mm/mprotect.c, and triggered only in
	corner cases where the PTE's pointed at subpfn's within pages.

(2) shrink initial userspace stack down to PAGE_MMUCOUNT == 1 size
	nothing really cares, but for strict binary compatibility...

(3) do the one-liner version of irqbalance disabling            
	hack until I merge with a mainline that has the fixes for
	the random garbage getting scribbled over my RTE's. But
	it looks like someone is still crapping on my RTE's...

(4) fix minor unit conversion bogon in filemap_getpage().

Applies incrementally atop pgcl-2.5.63-1

 arch/i386/kernel/io_apic.c |    2 +-
 fs/exec.c                  |   24 +++++++++++++++---------
 include/asm-i386/page.h    |    2 +-
 include/linux/binfmts.h    |   10 +++++++++-
 mm/filemap.c               |    2 +-
 5 files changed, 27 insertions(+), 13 deletions(-)


diff -urpN pgcl-2.5.63-1/arch/i386/kernel/io_apic.c pgcl-2.5.63-2/arch/i386/kernel/io_apic.c
--- pgcl-2.5.63-1/arch/i386/kernel/io_apic.c	2003-02-24 11:05:15.000000000 -0800
+++ pgcl-2.5.63-2/arch/i386/kernel/io_apic.c	2003-02-26 15:52:51.000000000 -0800
@@ -223,7 +223,7 @@ static void set_ioapic_affinity (unsigne
 
 extern unsigned long irq_affinity [NR_IRQS];
 int __cacheline_aligned pending_irq_balance_apicid [NR_IRQS];
-static int irqbalance_disabled __initdata = 0;
+static int irqbalance_disabled = no_balance_irq;
 static int physical_balance = 0;
 
 struct irq_cpu_info {
diff -urpN pgcl-2.5.63-1/fs/exec.c pgcl-2.5.63-2/fs/exec.c
--- pgcl-2.5.63-1/fs/exec.c	2003-02-24 22:04:53.000000000 -0800
+++ pgcl-2.5.63-2/fs/exec.c	2003-02-25 19:01:40.000000000 -0800
@@ -288,14 +288,14 @@ int copy_strings_kernel(int argc,char **
  *
  * tsk->mmap_sem is held for writing.
  */
-static void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address)
+static void put_dirty_page(task_t *tsk, struct page *page, int min_subpfn, unsigned long address)
 {
 	unsigned long page_pfn, subpfn;
 	struct pte_chain *pte_chain;
 
 	page_pfn = page_to_pfn(page);
 
-	for (subpfn = 0; subpfn < PAGE_MMUCOUNT; ++subpfn) {
+	for (subpfn = min_subpfn; subpfn < PAGE_MMUCOUNT; ++subpfn) {
 		pgd_t *pgd;
 		pmd_t *pmd;
 		pte_t *pte;
@@ -396,8 +396,8 @@ int setup_arg_pages(struct linux_binprm 
 	if (!mpnt)
 		return -ENOMEM;
 
-	/* must match hte length of mpnt below */
-	if (!vm_enough_memory((STACK_TOP-(PAGE_MASK&(unsigned long)bprm->p))/MMUPAGE_SIZE)) {
+	/* must match the length of mpnt below */
+	if (!vm_enough_memory((STACK_TOP-(MMUPAGE_MASK&(unsigned long)bprm->p))/MMUPAGE_SIZE)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
@@ -407,13 +407,12 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_mm = mm;
 #ifdef CONFIG_STACK_GROWSUP
 		mpnt->vm_start = stack_base;
-		mpnt->vm_end = MMUPAGE_MASK &
-			(MMUPAGE_SIZE - 1 + (unsigned long) bprm->p);
+		mpnt->vm_end = MMUPAGE_ALIGN((unsigned long)bprm->p);
 #else
 		/*
 		 * wild guess. NFI if this is remotely sound.
 		 */
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
+		mpnt->vm_start = MMUPAGE_MASK & (unsigned long)bprm->p;
 		mpnt->vm_end = STACK_TOP;
 #endif
 		mpnt->vm_page_prot = PAGE_COPY;
@@ -430,8 +429,15 @@ int setup_arg_pages(struct linux_binprm 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
+			int min_subpfn;
+
+			if (mpnt->vm_start <= stack_base)
+				min_subpfn = 0;
+			else
+				min_subpfn = (mpnt->vm_start - stack_base)/MMUPAGE_SIZE;
+
 			bprm->page[i] = NULL;
-			put_dirty_page(current, page, stack_base);
+			put_dirty_page(current, page, min_subpfn, stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
@@ -444,7 +450,7 @@ int setup_arg_pages(struct linux_binprm 
 
 #else
 
-#define put_dirty_page(tsk, page, address)
+#define put_dirty_page(tsk, page, min_subpfn, address)
 #define setup_arg_pages(bprm)			(0)
 static inline void free_arg_pages(struct linux_binprm *bprm)
 {
diff -urpN pgcl-2.5.63-1/include/asm-i386/page.h pgcl-2.5.63-2/include/asm-i386/page.h
--- pgcl-2.5.63-1/include/asm-i386/page.h	2003-02-24 22:04:53.000000000 -0800
+++ pgcl-2.5.63-2/include/asm-i386/page.h	2003-02-28 01:46:48.000000000 -0800
@@ -73,7 +73,7 @@ typedef struct { unsigned long pgd; } pg
 #define pte_val(x)	((x).pte_low)
 #define HPAGE_SHIFT	22
 #endif
-#define PTE_MASK	PAGE_MASK
+#define PTE_MASK	MMUPAGE_MASK
 
 #ifdef CONFIG_HUGETLB_PAGE
 #define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
diff -urpN pgcl-2.5.63-1/include/linux/binfmts.h pgcl-2.5.63-2/include/linux/binfmts.h
--- pgcl-2.5.63-1/include/linux/binfmts.h	2003-02-24 11:05:33.000000000 -0800
+++ pgcl-2.5.63-2/include/linux/binfmts.h	2003-02-26 11:44:15.000000000 -0800
@@ -2,6 +2,7 @@
 #define _LINUX_BINFMTS_H
 
 #include <linux/capability.h>
+#include <asm/page.h>			/* for PAGE_MMUCOUNT */
 
 struct pt_regs;
 
@@ -9,8 +10,15 @@ struct pt_regs;
  * MAX_ARG_PAGES defines the number of pages allocated for arguments
  * and envelope for the new program. 32 should suffice, this gives
  * a maximum env+arg of 128kB w/4KB pages!
+ * Now that PAGE_SIZE is a software construct and varies wildly,
+ * MAX_ARG_PAGES should represent a constant size of 128KB. When
+ * PAGE_SIZE exceeds that, we're in trouble.
  */
-#define MAX_ARG_PAGES 32
+#if PAGE_MMUCOUNT <= 32
+#define MAX_ARG_PAGES (32/PAGE_MMUCOUNT)
+#else
+#error PAGE_SIZE too large to enforce MAX_ARG_PAGES!
+#endif
 
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 128
diff -urpN pgcl-2.5.63-1/mm/filemap.c pgcl-2.5.63-2/mm/filemap.c
--- pgcl-2.5.63-1/mm/filemap.c	2003-02-24 22:04:53.000000000 -0800
+++ pgcl-2.5.63-2/mm/filemap.c	2003-02-25 19:19:56.000000000 -0800
@@ -1127,7 +1127,7 @@ success:
 	return page;
 
 no_cached_page:
-	error = page_cache_read(file, pgoff);
+	error = page_cache_read(file, pgoff/PAGE_CACHE_MMUCOUNT);
 
 	/*
 	 * The page we want has now been added to the page cache.
