Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbUKKRxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbUKKRxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbUKKRqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:46:49 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:7172
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262323AbUKKRoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:44:21 -0500
Message-Id: <200411111957.iABJvFPV004132@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - pml4 support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Nov 2004 14:57:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds stub pml4 support to UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/mem.c	2004-10-20 20:23:41.000000000 -0400
+++ linux-2.6.9/arch/um/kernel/mem.c	2004-11-11 12:26:40.000000000 -0500
@@ -140,7 +140,8 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), 
+						     vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -285,15 +286,16 @@
  * Allocate and free page tables.
  */
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 
 	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD, 
-		       swapper_pg_dir + USER_PTRS_PER_PGD, 
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		memset(pgd, 0, USER_PGDS_IN_LAST_PML4 * sizeof(pgd_t));
+		memcpy(pgd + USER_PGDS_IN_LAST_PML4, 
+		       swapper_pg_dir + USER_PGDS_IN_LAST_PML4, 
+		       (PTRS_PER_PGD - USER_PGDS_IN_LAST_PML4) * 
+		       sizeof(pgd_t));
 	}
 	return pgd;
 }
Index: linux-2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/process_kern.c	2004-11-11 12:19:32.000000000 -0500
+++ linux-2.6.9/arch/um/kernel/process_kern.c	2004-11-11 12:20:26.000000000 -0500
@@ -239,7 +239,7 @@
 
 	if(task->mm == NULL) 
 		return(ERR_PTR(-EINVAL));
-	pgd = pgd_offset(task->mm, addr);
+	pgd = pml4_pgd_offset(pml4_offset(task->mm, addr), addr);
 	pmd = pmd_offset(pgd, addr);
 	if(!pmd_present(*pmd)) 
 		return(ERR_PTR(-EINVAL));
Index: linux-2.6.9/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/skas/tlb.c	2004-10-20 20:23:41.000000000 -0400
+++ linux-2.6.9/arch/um/kernel/skas/tlb.c	2004-11-11 12:20:26.000000000 -0500
@@ -26,7 +26,7 @@
 	if(mm == NULL) return;
 	fd = mm->context.skas.mm_fd;
 	for(addr = start_addr; addr < end_addr;){
-		npgd = pgd_offset(mm, addr);
+		npgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		npmd = pmd_offset(npgd, addr);
 		if(pmd_present(*npmd)){
 			npte = pte_offset_kernel(npmd, addr);
@@ -78,7 +78,7 @@
 
 	mm = &init_mm;
 	for(addr = start; addr < end;){
-		pgd = pgd_offset(mm, addr);
+		pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		pmd = pmd_offset(pgd, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
Index: linux-2.6.9/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/tlb.c	2004-06-16 01:19:44.000000000 -0400
+++ linux-2.6.9/arch/um/kernel/tlb.c	2004-11-11 12:20:26.000000000 -0500
@@ -56,7 +56,7 @@
 
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
 {
-	return(pgd_offset(mm, address));
+	return(pml4_pgd_offset(pml4_offset(mm, address), address));
 }
 
 pmd_t *pmd_offset_proc(pgd_t *pgd, unsigned long address)
@@ -71,8 +71,8 @@
 
 pte_t *addr_pte(struct task_struct *task, unsigned long addr)
 {
-	return(pte_offset_kernel(pmd_offset(pgd_offset(task->mm, addr), addr), 
-				 addr));
+	return(pte_offset_kernel(pmd_offset(pgd_offset_proc(task->mm, addr), 
+					    addr), addr));
 }
 
 /*
Index: linux-2.6.9/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/trap_kern.c	2004-11-11 12:19:32.000000000 -0500
+++ linux-2.6.9/arch/um/kernel/trap_kern.c	2004-11-11 12:20:26.000000000 -0500
@@ -57,7 +57,7 @@
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 	page = address & PAGE_MASK;
-	pgd = pgd_offset(mm, page);
+	pgd = pml4_pgd_offset(pml4_offset(mm, page), page);
 	pmd = pmd_offset(pgd, page);
 	do {
  survive:
Index: linux-2.6.9/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.9.orig/arch/um/kernel/tt/tlb.c	2004-10-20 20:23:41.000000000 -0400
+++ linux-2.6.9/arch/um/kernel/tt/tlb.c	2004-11-11 12:20:26.000000000 -0500
@@ -41,7 +41,7 @@
 			addr = STACK_TOP - ABOVE_KMEM;
 			continue;
 		}
-		npgd = pgd_offset(mm, addr);
+		npgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		npmd = pmd_offset(npgd, addr);
 		if(pmd_present(*npmd)){
 			npte = pte_offset_kernel(npmd, addr);
@@ -97,7 +97,7 @@
 
 	mm = &init_mm;
 	for(addr = start; addr < end;){
-		pgd = pgd_offset(mm, addr);
+		pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		pmd = pmd_offset(pgd, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
@@ -161,7 +161,7 @@
 	
 	mm = &init_mm;
 	for(addr = start_vm; addr < end_vm;){
-		pgd = pgd_offset(mm, addr);
+		pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 		pmd = pmd_offset(pgd, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
Index: linux-2.6.9/include/asm-um/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-um/page.h	2004-11-11 12:19:57.000000000 -0500
+++ linux-2.6.9/include/asm-um/page.h	2004-11-11 12:20:26.000000000 -0500
@@ -50,4 +50,6 @@
 extern void arch_free_page(struct page *page, int order);
 #define HAVE_ARCH_FREE_PAGE
 
+#include <asm-generic/nopml4-page.h>
+
 #endif
Index: linux-2.6.9/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.9.orig/include/asm-um/pgalloc.h	2004-06-16 01:19:52.000000000 -0400
+++ linux-2.6.9/include/asm-um/pgalloc.h	2004-11-11 12:20:26.000000000 -0500
@@ -19,9 +19,6 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE + page_to_phys(pte)));
 }
 
-extern pgd_t *pgd_alloc(struct mm_struct *);
-extern void pgd_free(pgd_t *pgd);
-
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
 extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
 
@@ -49,6 +46,10 @@
 
 #define check_pgt_cache()	do { } while (0)
 
+extern void pgd_free(pgd_t *pgd);
+
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif
 
 /*
Index: linux-2.6.9/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-um/pgtable.h	2004-10-20 20:23:52.000000000 -0400
+++ linux-2.6.9/include/asm-um/pgtable.h	2004-11-11 12:20:26.000000000 -0500
@@ -37,7 +37,7 @@
 #define PTRS_PER_PTE	1024
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PGDS_IN_LAST_PML4  (TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR       0
 
 #define pte_ERROR(e) \
@@ -372,19 +372,7 @@
  */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
-/*
- * pgd_offset() returns a (pgd_t *)
- * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
- */
-#define pgd_offset(mm, address) \
-((mm)->pgd + ((address) >> PGDIR_SHIFT))
-
-
-/*
- * a shortcut which implies the use of the kernel's pgd, instead
- * of a process's
- */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(addr) pgd_index(addr)
 
 #define pmd_index(address) \
 		(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
@@ -427,6 +415,8 @@
 
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif
 
 #endif

