Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbULPMnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbULPMnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 07:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbULPMnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 07:43:46 -0500
Received: from mail.renesas.com ([202.234.163.13]:26072 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262653AbULPMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:43:27 -0500
Date: Thu, 16 Dec 2004 21:43:16 +0900 (JST)
Message-Id: <20041216.214316.233694043.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Cause SIGSEGV for nonexec page
 execution (1/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041216.214100.278750319.takata.hirokazu@renesas.com>
References: <20041216.214100.278750319.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Cause SIGSEGV for nonexec page execution (1/3)
- Cause a segmentation fault for an illegal execution of a code on
  non-executable memory page.

Signed-off-by: Naoto Sugai <sugai@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/fault.c       |   37 ++++++++++++++++++++++++-------------
 include/asm-m32r/pgtable.h |   21 ++++++++++-----------
 2 files changed, 34 insertions(+), 24 deletions(-)


diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h	2004-12-15 18:21:40.000000000 +0900
+++ b/include/asm-m32r/pgtable.h	2004-12-16 10:17:15.000000000 +0900
@@ -146,8 +146,7 @@ extern unsigned long empty_zero_page[102
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_WRITE | _PAGE_READ \
 		| _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_COPY	\
-	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
-		| _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_COPY_X	\
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
 		| _PAGE_ACCESSED)
@@ -188,23 +187,23 @@ extern unsigned long empty_zero_page[102
  * the same are read. Also, write permissions imply read permissions.
  * This is the closest we can get..
  */
-	/* rwx */
+	/* xwr */
 #define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
-#define __P010	PAGE_COPY_X
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY_X
 #define __P101	PAGE_READONLY_X
 #define __P110	PAGE_COPY_X
 #define __P111	PAGE_COPY_X
 
 #define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
+#define __S001	PAGE_READONLY
 #define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY_X
 #define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
+#define __S110	PAGE_SHARED_X
 #define __S111	PAGE_SHARED_X
 
 /* page table for 0-4MB for everybody */
diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-12-15 17:06:52.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-12-16 10:53:10.000000000 +0900
@@ -96,6 +96,11 @@ void bust_spinlocks(int yes)
  *  bit 2 == 0 means kernel, 1 means user-mode
  *  bit 3 == 0 means data, 1 means instruction
  *======================================================================*/
+#define ACE_PROTECTION		1
+#define ACE_WRITE		2
+#define ACE_USERMODE		4
+#define ACE_INSTRUCTION		8
+
 asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code,
   unsigned long address)
 {
@@ -126,10 +131,10 @@ asmlinkage void do_page_fault(struct pt_
 	 * nothing more.
 	 *
 	 * This verifies that the fault happens in kernel space
-	 * (error_code & 4) == 0, and that the fault was not a
-	 * protection error (error_code & 1) == 0.
+	 * (error_code & ACE_USEMODE) == 0, and that the fault was not a
+	 * protection error (error_code & ACE_PROTECTION) == 0.
 	 */
-	if (address >= TASK_SIZE && !(error_code & 4))
+	if (address >= TASK_SIZE && !(error_code & ACE_USERMODE))
 		goto vmalloc_fault;
 
 	mm = tsk->mm;
@@ -157,7 +162,7 @@ asmlinkage void do_page_fault(struct pt_
 	 * thus avoiding the deadlock.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		if ((error_code & 4) == 0 &&
+		if ((error_code & ACE_USERMODE) == 0 &&
 		    !search_exception_tables(regs->psw))
 			goto bad_area_nosemaphore;
 		down_read(&mm->mmap_sem);
@@ -171,7 +176,7 @@ asmlinkage void do_page_fault(struct pt_
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
 #if 0
-	if (error_code & 4) {
+	if (error_code & ACE_USERMODE) {
 		/*
 		 * accessing the stack below "spu" is always a bug.
 		 * The "+ 4" is there due to the push instruction
@@ -191,27 +196,33 @@ asmlinkage void do_page_fault(struct pt_
 good_area:
 	info.si_code = SEGV_ACCERR;
 	write = 0;
-	switch (error_code & 3) {
+	switch (error_code & (ACE_WRITE|ACE_PROTECTION)) {
 		default:	/* 3: write, present */
 			/* fall through */
-		case 2:		/* write, not present */
+		case ACE_WRITE:	/* write, not present */
 			if (!(vma->vm_flags & VM_WRITE))
 				goto bad_area;
 			write++;
 			break;
-		case 1:		/* read, present */
+		case ACE_PROTECTION:	/* read, present */
 		case 0:		/* read, not present */
 			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 				goto bad_area;
 	}
 
+	/*
+	 * For instruction access exception, check if the area is executable
+	 */
+	if ((error_code & ACE_INSTRUCTION) && !(vma->vm_flags & VM_EXEC))
+	  goto bad_area;
+
 survive:
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	addr = (address & PAGE_MASK) | (error_code & 8);
+	addr = (address & PAGE_MASK) | (error_code & ACE_INSTRUCTION);
 	switch (handle_mm_fault(mm, vma, addr, write)) {
 		case VM_FAULT_MINOR:
 			tsk->min_flt++;
@@ -239,7 +250,7 @@ bad_area:
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
-	if (error_code & 4) {
+	if (error_code & ACE_USERMODE) {
 		tsk->thread.address = address;
 		tsk->thread.error_code = error_code | (address >= TASK_SIZE);
 		tsk->thread.trap_no = 14;
@@ -295,7 +306,7 @@ out_of_memory:
 		goto survive;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
-	if (error_code & 4)
+	if (error_code & ACE_USERMODE)
 		do_exit(SIGKILL);
 	goto no_context;
 
@@ -303,7 +314,7 @@ do_sigbus:
 	up_read(&mm->mmap_sem);
 
 	/* Kernel mode? Handle exception or die */
-	if (!(error_code & 4))
+	if (!(error_code & ACE_USERMODE))
 		goto no_context;
 
 	tsk->thread.address = address;
@@ -352,7 +363,7 @@ vmalloc_fault:
 		if (!pte_present(*pte_k))
 			goto no_context;
 
-		addr = (address & PAGE_MASK) | (error_code & 8);
+		addr = (address & PAGE_MASK) | (error_code & ACE_INSTRUCTION);
 		update_mmu_cache(NULL, addr, *pte_k);
 		return;
 	}

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
