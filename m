Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVHLRyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVHLRyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVHLRyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:14 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:56970 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750766AbVHLRyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:14 -0400
Subject: [patch 07/39] uml: fault handler micro-cleanups
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:45 +0200
Message-Id: <20050812173146.16E5324E7D0@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid chomping low bits of address for functions doing it by themselves, fix
whitespace, add a correctness checking.

I did this for remap-file-pages protection support, it was useful on its own
too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   28 +++++++++++--------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~uml-fault-handler-changes arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-fault-handler-changes	2005-08-11 11:18:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 11:19:56.000000000 +0200
@@ -26,6 +26,7 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+/* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
 		      int is_write, int is_user, int *code_out)
 {
@@ -35,7 +36,6 @@ int handle_page_fault(unsigned long addr
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long page;
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
@@ -52,7 +52,7 @@ int handle_page_fault(unsigned long addr
 	else if(expand_stack(vma, address)) 
 		goto out;
 
- good_area:
+good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
@@ -60,9 +60,8 @@ int handle_page_fault(unsigned long addr
         if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
-	page = address & PAGE_MASK;
 	do {
- survive:
+survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -79,16 +78,16 @@ int handle_page_fault(unsigned long addr
 		default:
 			BUG();
 		}
-		pgd = pgd_offset(mm, page);
-		pud = pud_offset(pgd, page);
-		pmd = pmd_offset(pud, page);
-		pte = pte_offset_kernel(pmd, page);
+		pgd = pgd_offset(mm, address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
+		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
-	flush_tlb_page(vma, page);
- out:
+	flush_tlb_page(vma, address);
+out:
 	up_read(&mm->mmap_sem);
 	return(err);
 
@@ -144,19 +143,18 @@ unsigned long segv(struct faultinfo fi, 
 		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx", 
 		      address, ip);
 
-	if(err == -EACCES){
+	if (err == -EACCES) {
 		si.si_signo = SIGBUS;
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
 		si.si_addr = (void *)address;
                 current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
-	}
-	else if(err == -ENOMEM){
+	} else if (err == -ENOMEM) {
 		printk("VM: killing process %s\n", current->comm);
 		do_exit(SIGKILL);
-	}
-	else {
+	} else {
+		BUG_ON(err != -EFAULT);
 		si.si_signo = SIGSEGV;
 		si.si_addr = (void *) address;
                 current->thread.arch.faultinfo = fi;
_
