Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJVNty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJVNty (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWJVNty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:49:54 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15281 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750846AbWJVNtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:49:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Date: Sun, 22 Oct 2006 15:48:47 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221548.48204.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The purpose of the appended patch is to make swsusp work on i386 with PAE,
but it should also allow i386 systems without PSE to use swsusp.

The patch creates temporary page tables located in resume-safe page frames
during the resume and uses them for restoring the suspend image (the same
approach is used on x86-64).

It has been tested on an i386 system with PAE and survived several
suspend-resume cycles in a row, but I have no systems without PSE, so that
requires some testing.

Comments welcome.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/i386/power/Makefile  |    2 
 arch/i386/power/suspend.c |  153 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/power/swsusp.S  |    9 ++
 kernel/power/Kconfig      |    2 
 4 files changed, 162 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc2-mm2/arch/i386/power/swsusp.S
===================================================================
--- linux-2.6.19-rc2-mm2.orig/arch/i386/power/swsusp.S
+++ linux-2.6.19-rc2-mm2/arch/i386/power/swsusp.S
@@ -28,8 +28,9 @@ ENTRY(swsusp_arch_suspend)
 	call swsusp_save
 	ret
 
-ENTRY(swsusp_arch_resume)
-	movl	$swsusp_pg_dir-__PAGE_OFFSET, %ecx
+ENTRY(restore_image)
+	movl	resume_pg_dir, %ecx
+	subl	$__PAGE_OFFSET, %ecx
 	movl	%ecx, %cr3
 
 	movl	restore_pblist, %edx
@@ -51,6 +52,10 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+	/* go back to the original page tables */
+	movl	$swapper_pg_dir, %ecx
+	subl	$__PAGE_OFFSET, %ecx
+	movl	%ecx, %cr3
 	/* Flush TLB, including "global" things (vmalloc) */
 	movl	mmu_cr4_features, %eax
 	movl	%eax, %edx
Index: linux-2.6.19-rc2-mm2/arch/i386/power/suspend.c
===================================================================
--- /dev/null
+++ linux-2.6.19-rc2-mm2/arch/i386/power/suspend.c
@@ -0,0 +1,153 @@
+/*
+ * Suspend support specific for i386 - temporary page tables
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (c) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ */
+
+#include <linux/suspend.h>
+#include <linux/bootmem.h>
+
+#include <asm/system.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+/* Defined in arch/i386/power/swsusp.S */
+extern int restore_image(void);
+
+/* Pointer to the temporary resume page tables */
+pgd_t *resume_pg_dir;
+
+/* The following three functions are based on the analogous code in
+ * arch/i386/mm/init.c
+ */
+
+/*
+ * Create a middle page table on a resume-safe page and put a pointer to it in
+ * the given global directory entry.  This only returns the gd entry
+ * in non-PAE compilation mode, since the middle layer is folded.
+ */
+static pmd_t *resume_one_md_table_init(pgd_t *pgd)
+{
+	pud_t *pud;
+	pmd_t *pmd_table;
+
+#ifdef CONFIG_X86_PAE
+	pmd_table = (pmd_t *)get_safe_page(GFP_ATOMIC);
+	if (!pmd_table)
+		return pmd_table;
+
+	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
+	pud = pud_offset(pgd, 0);
+
+	BUG_ON(pmd_table != pmd_offset(pud, 0));
+#else
+	pud = pud_offset(pgd, 0);
+	pmd_table = pmd_offset(pud, 0);
+#endif
+
+	return pmd_table;
+}
+
+/*
+ * Create a page table on a resume-safe page and place a pointer to it in
+ * a middle page directory entry.
+ */
+static pte_t *resume_one_page_table_init(pmd_t *pmd)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *page_table = (pte_t *)get_safe_page(GFP_ATOMIC);
+		if (!page_table)
+			return page_table;
+
+		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
+
+		BUG_ON(page_table != pte_offset_kernel(pmd, 0));
+
+		return page_table;
+	}
+
+	return pte_offset_kernel(pmd, 0);
+}
+
+/*
+ * This maps the physical memory to kernel virtual address space, a total
+ * of max_low_pfn pages, by creating page tables starting from address
+ * PAGE_OFFSET.  The page tables are allocated out of resume-safe pages.
+ */
+static int resume_physical_mapping_init(pgd_t *pgd_base)
+{
+	unsigned long pfn;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	int pgd_idx, pmd_idx;
+
+	pgd_idx = pgd_index(PAGE_OFFSET);
+	pgd = pgd_base + pgd_idx;
+	pfn = 0;
+
+	for (; pgd_idx < PTRS_PER_PGD; pgd++, pgd_idx++) {
+		pmd = resume_one_md_table_init(pgd);
+		if (!pmd)
+			return -ENOMEM;
+
+		if (pfn >= max_low_pfn)
+			continue;
+
+		for (pmd_idx = 0; pmd_idx < PTRS_PER_PMD; pmd++, pmd_idx++) {
+			if (pfn >= max_low_pfn)
+				break;
+
+			/* Map with big pages if possible, otherwise create
+			 * normal page tables.
+			 * NOTE: We can mark everything as executable here
+			 */
+			if (cpu_has_pse) {
+				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
+				pfn += PTRS_PER_PTE;
+			} else {
+				pte_t *max_pte;
+
+				pte = resume_one_page_table_init(pmd);
+				if (!pte)
+					return -ENOMEM;
+
+				max_pte = pte + PTRS_PER_PTE;
+				for (; pte < max_pte; pte++, pfn++) {
+					if (pfn >= max_low_pfn)
+						break;
+
+					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+int swsusp_arch_resume(void)
+{
+	int error;
+
+	resume_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!resume_pg_dir)
+		return -ENOMEM;
+
+#ifdef CONFIG_X86_PAE
+	int i;
+	/* Init entries of the first-level page table to the zero page */
+	for (i = 0; i < PTRS_PER_PGD; i++)
+		set_pgd(resume_pg_dir + i,
+			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+#endif
+
+	error = resume_physical_mapping_init(resume_pg_dir);
+	if (error)
+		return error;
+
+	/* We have got enough memory and from now on we cannot recover */
+	restore_image();
+	return 0;
+}
Index: linux-2.6.19-rc2-mm2/arch/i386/power/Makefile
===================================================================
--- linux-2.6.19-rc2-mm2.orig/arch/i386/power/Makefile
+++ linux-2.6.19-rc2-mm2/arch/i386/power/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_PM)		+= cpu.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o suspend.o
Index: linux-2.6.19-rc2-mm2/kernel/power/Kconfig
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/Kconfig
+++ linux-2.6.19-rc2-mm2/kernel/power/Kconfig
@@ -78,7 +78,7 @@ config PM_SYSFS_DEPRECATED
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP) && !X86_PAE) || ((FRV || PPC32) && !SMP))
+	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need ACPI or APM.
