Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVAJFOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVAJFOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAJFOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:14:36 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:13828
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262087AbVAJFNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:13:49 -0500
Message-Id: <200501100735.j0A7Z5PW005735@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/28] UML - add some pudding
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pud_t support to UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/mem.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/mem.c	2005-01-07 11:10:47.000000000 -0500
@@ -135,7 +135,8 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)),\
+ 			  (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
Index: linux-2.6.10/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/process_kern.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/process_kern.c	2005-01-06 13:09:20.000000000 -0500
@@ -235,18 +235,28 @@
 		      pte_t *pte_out)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
 	if(task->mm == NULL) 
 		return(ERR_PTR(-EINVAL));
 	pgd = pgd_offset(task->mm, addr);
-	pmd = pmd_offset(pgd, addr);
+	if(!pgd_present(*pgd)) 
+		return(ERR_PTR(-EINVAL));
+	
+	pud = pud_offset(pgd, addr);
+	if(!pud_present(*pud)) 
+		return(ERR_PTR(-EINVAL));
+	
+	pmd = pmd_offset(pud, addr);
 	if(!pmd_present(*pmd)) 
 		return(ERR_PTR(-EINVAL));
+
 	pte = pte_offset_kernel(pmd, addr);
 	if(!pte_present(*pte)) 
 		return(ERR_PTR(-EINVAL));
+
 	if(pte_out != NULL)
 		*pte_out = *pte;
 	return((void *) (pte_val(*pte) & PAGE_MASK) + (addr & ~PAGE_MASK));
Index: linux-2.6.10/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/skas/tlb.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/skas/tlb.c	2005-01-07 11:10:47.000000000 -0500
@@ -18,6 +18,7 @@
 		      unsigned long end_addr, int force)
 {
 	pgd_t *npgd;
+	pmd_t *npud;
 	pmd_t *npmd;
 	pte_t *npte;
 	unsigned long addr;
@@ -27,7 +28,8 @@
 	fd = mm->context.skas.mm_fd;
 	for(addr = start_addr; addr < end_addr;){
 		npgd = pgd_offset(mm, addr);
-		npmd = pmd_offset(npgd, addr);
+		npud = pud_offset(npgd, addr);
+		npmd = pmd_offset(npud, addr);
 		if(pmd_present(*npmd)){
 			npte = pte_offset_kernel(npmd, addr);
 			r = pte_read(*npte);
@@ -79,7 +81,8 @@
 	mm = &init_mm;
 	for(addr = start; addr < end;){
 		pgd = pgd_offset(mm, addr);
-		pmd = pmd_offset(pgd, addr);
+		pud = pud_offset(pgd, addr);
+		pmd = pmd_offset(pud, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
 			if(!pte_present(*pte) || pte_newpage(*pte)){
Index: linux-2.6.10/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/tlb.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/tlb.c	2005-01-07 11:10:47.000000000 -0500
@@ -59,9 +59,14 @@
 	return(pgd_offset(mm, address));
 }
 
-pmd_t *pmd_offset_proc(pgd_t *pgd, unsigned long address)
+pud_t *pud_offset_proc(pgd_t *pgd, unsigned long address)
 {
-	return(pmd_offset(pgd, address));
+	return(pud_offset(pgd, address));
+}
+
+pmd_t *pmd_offset_proc(pud_t *pud, unsigned long address)
+{
+	return(pmd_offset(pud, address));
 }
 
 pte_t *pte_offset_proc(pmd_t *pmd, unsigned long address)
@@ -71,8 +76,11 @@
 
 pte_t *addr_pte(struct task_struct *task, unsigned long addr)
 {
-	return(pte_offset_kernel(pmd_offset(pgd_offset(task->mm, addr), addr), 
-				 addr));
+	pgd_t *pgd = pgd_offset(task->mm, addr);
+	pud_t *pud = pud_offset(pgd, addr);
+	pmd_t *pmd = pmd_offset(pud, addr);
+
+	return(pte_offset_map(pmd, addr));
 }
 
 /*
Index: linux-2.6.10/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/trap_kern.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/trap_kern.c	2005-01-07 11:10:47.000000000 -0500
@@ -13,6 +13,7 @@
 #include "linux/ptrace.h"
 #include "asm/semaphore.h"
 #include "asm/pgtable.h"
+#include "asm/pgalloc.h"
 #include "asm/tlbflush.h"
 #include "asm/a.out.h"
 #include "asm/current.h"
@@ -32,6 +33,7 @@
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev_vma;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long page;
@@ -57,8 +59,9 @@
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 	page = address & PAGE_MASK;
-	pgd = pgd_offset(mm, page);
-	pmd = pmd_offset(pgd, page);
+	pgd = pgd_offset(mm);
+	pud = pud_offset(pgd, page);
+	pmd = pmd_offset(pud, page);
 	do {
  survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
Index: linux-2.6.10/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/tt/tlb.c	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/tt/tlb.c	2005-01-07 11:10:47.000000000 -0500
@@ -19,6 +19,7 @@
 		      unsigned long end_addr, int force)
 {
 	pgd_t *npgd;
+	pud_t *npud;
 	pmd_t *npmd;
 	pte_t *npte;
 	unsigned long addr;
@@ -42,7 +43,8 @@
 			continue;
 		}
 		npgd = pgd_offset(mm, addr);
-		npmd = pmd_offset(npgd, addr);
+		npud = pud_offset(npgd, addr);
+		npmd = pmd_offset(npud, addr);
 		if(pmd_present(*npmd)){
 			npte = pte_offset_kernel(npmd, addr);
 			r = pte_read(*npte);
@@ -90,6 +92,7 @@
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	pud_t *pmd;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long addr;
@@ -98,7 +101,8 @@
 	mm = &init_mm;
 	for(addr = start; addr < end;){
 		pgd = pgd_offset(mm, addr);
-		pmd = pmd_offset(pgd, addr);
+		pud = pud_offset(pgd, addr);
+		pmd = pmd_offset(pud, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
 			if(!pte_present(*pte) || pte_newpage(*pte)){
@@ -155,6 +159,7 @@
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long addr;
@@ -162,7 +167,8 @@
 	mm = &init_mm;
 	for(addr = start_vm; addr < end_vm;){
 		pgd = pgd_offset(mm, addr);
-		pmd = pmd_offset(pgd, addr);
+		pud = pud_offset(pgd, addr);
+		pmd = pmd_offset(pud, addr);
 		if(pmd_present(*pmd)){
 			pte = pte_offset_kernel(pmd, addr);
 			if(pte_present(*pte)) protect_vm_page(addr, w, 0);
Index: linux-2.6.10/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-um/pgalloc.h	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/include/asm-um/pgalloc.h	2005-01-07 11:10:47.000000000 -0500
@@ -13,12 +13,14 @@
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, 
-				struct page *pte)
-{
-	set_pmd(pmd, __pmd(_PAGE_TABLE + page_to_phys(pte)));
-}
+#define pmd_populate(mm, pmd, pte) 				\
+	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
+		((unsigned long long)page_to_pfn(pte) <<	\
+			(unsigned long long) PAGE_SHIFT)))
 
+/*
+ * Allocate and free page tables.
+ */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(pgd_t *pgd);
 
@@ -45,7 +47,7 @@
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
-#define pgd_populate(mm, pmd, pte)	BUG()
+#define pud_populate(mm, pmd, pte)	BUG()
 
 #define check_pgt_cache()	do { } while (0)
 
Index: linux-2.6.10/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-um/pgtable.h	2005-01-06 13:09:17.000000000 -0500
+++ linux-2.6.10/include/asm-um/pgtable.h	2005-01-07 11:10:47.000000000 -0500
@@ -7,8 +7,6 @@
 #ifndef __UM_PGTABLE_H
 #define __UM_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
-
 #include "linux/sched.h"
 #include "asm/processor.h"
 #include "asm/page.h"
@@ -23,7 +21,6 @@
 #define pgtable_cache_init() do ; while (0)
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-#define PMD_SHIFT	22
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
@@ -39,7 +36,6 @@
 #define PTRS_PER_PTE	1024
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR       0
 
 #define pte_ERROR(e) \
@@ -176,6 +172,15 @@
 #define pmd_newpage(x)  (pmd_val(x) & _PAGE_NEWPAGE)
 #define pmd_mkuptodate(x) (pmd_val(x) &= ~_PAGE_NEWPAGE)
 
+#define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
+#define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
+
+static inline pud_t *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, 
+				 unsigned long addr)
+{
+	BUG();
+}
+
 /*
  * The "pgd_xxx()" functions here are trivial for a folded two-level
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
@@ -374,15 +379,15 @@
  * this macro returns the index of the entry in the pgd page which would
  * control the given virtual address
  */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+
+#define pgd_index_k(addr) pgd_index(addr)
 
 /*
  * pgd_offset() returns a (pgd_t *)
  * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
  */
-#define pgd_offset(mm, address) \
-((mm)->pgd + ((address) >> PGDIR_SHIFT))
-
+#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
 
 /*
  * a shortcut which implies the use of the kernel's pgd, instead
@@ -390,15 +395,15 @@
  */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
+/*
+ * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
+ *
+ * this macro returns the index of the entry in the pmd page which would
+ * control the given virtual address
+ */
 #define pmd_index(address) \
 		(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
-/* Find an entry in the second-level page table.. */
-static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
-{
-	return (pmd_t *) dir;
-}
-
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
  *
@@ -430,6 +435,8 @@
 
 #include <asm-generic/pgtable.h>
 
+#include <asm-um/pgtable-nopud.h>
+
 #endif
 
 #endif

