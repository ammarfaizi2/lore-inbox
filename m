Return-Path: <linux-kernel-owner+w=401wt.eu-S1751121AbXANFiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbXANFiV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbXANFiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:38:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59258 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbXANFiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:38:19 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 11/11] powerpc vDSO: use install_special_mapping
X-Zippy-Says: I'll take ROAST BEEF if you're out of LAMB!!
Message-Id: <20070114053744.C866F1800E8@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:37:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch uses install_special_mapping for the powerpc vDSO setup,
consolidating duplicated code.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/vdso.c |  104 +++++++++++--------------------------------
 1 files changed, 27 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ae0ede1..50149ec 100644  
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -49,9 +49,13 @@
 /* Max supported size for symbol names */
 #define MAX_SYMNAME	64
 
+#define VDSO32_MAXPAGES	(((0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
+#define VDSO64_MAXPAGES	(((0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
+
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
 unsigned int vdso32_pages;
+static struct page *vdso32_pagelist[VDSO32_MAXPAGES];
 unsigned long vdso32_sigtramp;
 unsigned long vdso32_rt_sigtramp;
 
@@ -59,6 +63,7 @@ unsigned long vdso32_rt_sigtramp;
 extern char vdso64_start, vdso64_end;
 static void *vdso64_kbase = &vdso64_start;
 unsigned int vdso64_pages;
+static struct page *vdso64_pagelist[VDSO64_MAXPAGES];
 unsigned long vdso64_rt_sigtramp;
 #endif /* CONFIG_PPC64 */
 
@@ -165,55 +170,6 @@ static void dump_vdso_pages(struct vm_ar
 #endif /* DEBUG */
 
 /*
- * Keep a dummy vma_close for now, it will prevent VMA merging.
- */
-static void vdso_vma_close(struct vm_area_struct * vma)
-{
-}
-
-/*
- * Our nopage() function, maps in the actual vDSO kernel pages, they will
- * be mapped read-only by do_no_page(), and eventually COW'ed, either
- * right away for an initial write access, or by do_wp_page().
- */
-static struct page * vdso_vma_nopage(struct vm_area_struct * vma,
-				     unsigned long address, int *type)
-{
-	unsigned long offset = address - vma->vm_start;
-	struct page *pg;
-#ifdef CONFIG_PPC64
-	void *vbase = (vma->vm_mm->task_size > TASK_SIZE_USER32) ?
-		vdso64_kbase : vdso32_kbase;
-#else
-	void *vbase = vdso32_kbase;
-#endif
-
-	DBG("vdso_vma_nopage(current: %s, address: %016lx, off: %lx)\n",
-	    current->comm, address, offset);
-
-	if (address < vma->vm_start || address > vma->vm_end)
-		return NOPAGE_SIGBUS;
-
-	/*
-	 * Last page is systemcfg.
-	 */
-	if ((vma->vm_end - address) <= PAGE_SIZE)
-		pg = virt_to_page(vdso_data);
-	else
-		pg = virt_to_page(vbase + offset);
-
-	get_page(pg);
-	DBG(" ->page count: %d\n", page_count(pg));
-
-	return pg;
-}
-
-static struct vm_operations_struct vdso_vmops = {
-	.close	= vdso_vma_close,
-	.nopage	= vdso_vma_nopage,
-};
-
-/*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
@@ -221,20 +177,23 @@ int arch_setup_additional_pages(struct l
 				int executable_stack)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct page **vdso_pagelist;
 	unsigned long vdso_pages;
 	unsigned long vdso_base;
 	int rc;
 
 #ifdef CONFIG_PPC64
 	if (test_thread_flag(TIF_32BIT)) {
+		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
 		vdso_base = VDSO32_MBASE;
 	} else {
+		vdso_pagelist = vdso64_pagelist;
 		vdso_pages = vdso64_pages;
 		vdso_base = VDSO64_MBASE;
 	}
 #else
+	vdso_pagelist = vdso32_pagelist;
 	vdso_pages = vdso32_pages;
 	vdso_base = VDSO32_MBASE;
 #endif
@@ -262,17 +221,6 @@ int arch_setup_additional_pages(struct l
 		goto fail_mmapsem;
 	}
 
-
-	/* Allocate a VMA structure and fill it up */
-	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
-	if (vma == NULL) {
-		rc = -ENOMEM;
-		goto fail_mmapsem;
-	}
-	vma->vm_mm = mm;
-	vma->vm_start = vdso_base;
-	vma->vm_end = vma->vm_start + (vdso_pages << PAGE_SHIFT);
-
 	/*
 	 * our vma flags don't have VM_WRITE so by default, the process isn't
 	 * allowed to write those pages.
@@ -282,32 +230,26 @@ int arch_setup_additional_pages(struct l
 	 * and your nice userland gettimeofday will be totally dead.
 	 * It's fine to use that for setting breakpoints in the vDSO code
 	 * pages though
-	 */
-	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
-	/*
+	 *
 	 * Make sure the vDSO gets into every core dump.
 	 * Dumping its contents makes post-mortem fully interpretable later
 	 * without matching up the same kernel and hardware config to see
 	 * what PC values meant.
 	 */
-	vma->vm_flags |= VM_ALWAYSDUMP;
-	vma->vm_flags |= mm->def_flags;
-	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
-	vma->vm_ops = &vdso_vmops;
-
-	/* Insert new VMA */
-	rc = insert_vm_struct(mm, vma);
+	rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+				     VM_READ|VM_EXEC|
+				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				     VM_ALWAYSDUMP,
+				     vdso_pagelist);
 	if (rc)
-		goto fail_vma;
+		goto fail_mmapsem;
 
-	/* Put vDSO base into mm struct and account for memory usage */
+	/* Put vDSO base into mm struct */
 	current->mm->context.vdso_base = vdso_base;
-	mm->total_vm += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
 	up_write(&mm->mmap_sem);
 	return 0;
 
- fail_vma:
-	kmem_cache_free(vm_area_cachep, vma);
  fail_mmapsem:
 	up_write(&mm->mmap_sem);
 	return rc;
@@ -778,18 +720,26 @@ void __init vdso_init(void)
 	}
 
 	/* Make sure pages are in the correct state */
+	BUG_ON(vdso32_pages + 2 > VDSO32_MAXPAGES);
 	for (i = 0; i < vdso32_pages; i++) {
 		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
 		ClearPageReserved(pg);
 		get_page(pg);
-
+		vdso32_pagelist[i] = pg;
 	}
+	vdso32_pagelist[i++] = virt_to_page(vdso_data);
+	vdso32_pagelist[i] = NULL;
+
 #ifdef CONFIG_PPC64
+	BUG_ON(vdso64_pages + 2 > VDSO64_MAXPAGES);
 	for (i = 0; i < vdso64_pages; i++) {
 		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
 		ClearPageReserved(pg);
 		get_page(pg);
+		vdso64_pagelist[i] = pg;
 	}
+	vdso64_pagelist[i++] = virt_to_page(vdso_data);
+	vdso64_pagelist[i] = NULL;
 #endif /* CONFIG_PPC64 */
 
 	get_page(virt_to_page(vdso_data));
