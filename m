Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVI2XMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVI2XMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVI2XMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:12:49 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:36831 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751359AbVI2XMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:12:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Fix] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 4)
Date: Fri, 30 Sep 2005 01:13:15 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Discuss x86-64 <discuss@x86-64.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509300113.16109.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes Bug #4959.  For this purpose it creates temporary
page translation tables including the kernel mapping (reused) and the direct
mapping (created from scratch) and makes swsusp switch to these tables
right before the image is restored.

The code that generates the direct mapping is based on the code in
arch/x86_64/mm/init.c.

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git7/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc2-git7.orig/arch/x86_64/kernel/suspend.c	2005-09-29 23:03:11.000000000 +0200
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/suspend.c	2005-09-29 23:25:28.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/smp.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
 
 struct saved_context saved_context;
 
@@ -140,4 +142,77 @@
 
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#define MAX_RESUME_PUD_ENTRIES	8
+#define MAX_RESUME_RAM_SIZE	(MAX_RESUME_PUD_ENTRIES * PTRS_PER_PMD * PMD_SIZE)
+
+int arch_prepare_suspend(void)
+{
+	if (MAX_RESUME_RAM_SIZE < (end_pfn << PAGE_SHIFT)) {
+		printk(KERN_ERR "Too much RAM for suspend (%lu K), max. allowed: %lu K",
+			end_pfn << (PAGE_SHIFT - 10), MAX_RESUME_RAM_SIZE >> 10);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* Defined in arch/x86_64/kernel/suspend_asm.S */
+extern asmlinkage int restore_image(void);
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+pgd_t resume_level4_pgt[PTRS_PER_PGD] __nosavedata;
+pud_t resume_level3_pgt[PTRS_PER_PUD] __nosavedata;
+pmd_t resume_level2_pgt[MAX_RESUME_PUD_ENTRIES*PTRS_PER_PMD] __nosavedata;
+
+static void phys_pud_init(pud_t *pud, unsigned long end)
+{
+	long i, j;
+	pmd_t *pmd = resume_level2_pgt;
+
+	for (i = 0; i < PTRS_PER_PUD; pud++, i++) {
+		unsigned long paddr;
+
+		paddr = i*PUD_SIZE;
+		if (paddr >= end) {
+			for (; i < PTRS_PER_PUD; i++, pud++)
+				set_pud(pud, __pud(0));
+			break;
+		}
+
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		for (j = 0; j < PTRS_PER_PMD; pmd++, j++, paddr += PMD_SIZE) {
+			unsigned long pe;
+
+			if (paddr >= end) {
+				for (; j < PTRS_PER_PMD; j++, pmd++)
+					set_pmd(pmd,  __pmd(0));
+				break;
+			}
+			pe = _PAGE_NX|_PAGE_PSE | _KERNPG_TABLE | _PAGE_GLOBAL | paddr;
+			pe &= __supported_pte_mask;
+			set_pmd(pmd, __pmd(pe));
+		}
+	}
+}
 
+static void set_up_temporary_mappings(void)
+{
+	/* It is safe to reuse the original kernel mapping */
+	set_pgd(resume_level4_pgt + pgd_index(__START_KERNEL_map),
+		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
+
+	/* Set up the direct mapping from scratch */
+	phys_pud_init(resume_level3_pgt, end_pfn << PAGE_SHIFT);
+	set_pgd(resume_level4_pgt + pgd_index(PAGE_OFFSET),
+		mk_kernel_pgd(__pa(resume_level3_pgt)));
+}
+
+int swsusp_arch_resume(void)
+{
+	set_up_temporary_mappings();
+	restore_image();
+	return 0;
+}
+#endif
Index: linux-2.6.14-rc2-git7/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc2-git7.orig/arch/x86_64/kernel/suspend_asm.S	2005-09-29 23:03:11.000000000 +0200
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/suspend_asm.S	2005-09-29 23:30:14.000000000 +0200
@@ -39,12 +39,12 @@
 	call swsusp_save
 	ret
 
-ENTRY(swsusp_arch_resume)
-	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
-	subq	$__START_KERNEL_map,%rax
-	movq	%rax,%cr3
-
+ENTRY(restore_image)
+	/* switch to temporary page tables */
+	leaq	resume_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
+	/* Flush TLB */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
 	andq	$~(1<<7), %rdx	# PGE
@@ -69,6 +69,10 @@
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* go back to the original page tables */
+	leaq	init_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
 	/* Flush TLB, including "global" things (vmalloc) */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
Index: linux-2.6.14-rc2-git7/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.14-rc2-git7.orig/include/asm-x86_64/suspend.h	2005-09-29 23:03:11.000000000 +0200
+++ linux-2.6.14-rc2-git7/include/asm-x86_64/suspend.h	2005-09-29 23:23:35.000000000 +0200
@@ -6,11 +6,15 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+extern int arch_prepare_suspend(void);
+#else
 static inline int
 arch_prepare_suspend(void)
 {
 	return 0;
 }
+#endif
 
 /* Image of the saved processor state. If you touch this, fix acpi_wakeup.S. */
 struct saved_context {
