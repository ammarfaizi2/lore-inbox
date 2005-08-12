Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVHLSvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVHLSvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVHLStW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:22 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:48572 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750899AbVHLStC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:02 -0400
Subject: [patch 22/39] remap file pages protection support: use FAULT_SIGSEGV for protection checking, uml bits
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:35:51 +0200
Message-Id: <20050812183551.C296524E0A7@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This adapts the changes to the i386 handler to the UML one. It isn't enough to
make UML work, however, because UML has some peculiarities. Subsequent patches
fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   32 +++++++++++++++++++++----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-fault-sigsegv-2-uml arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-fault-sigsegv-2-uml	2005-08-11 23:09:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:09:32.000000000 +0200
@@ -37,6 +37,7 @@ int handle_page_fault(unsigned long addr
 	pmd_t *pmd;
 	pte_t *pte;
 	int err = -EFAULT;
+	int access_mask = 0;
 
 	*code_out = SEGV_MAPERR;
 	down_read(&mm->mmap_sem);
@@ -55,14 +56,15 @@ int handle_page_fault(unsigned long addr
 good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
-		goto out;
+		goto prot_bad;
 
         if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
-                goto out;
+                goto prot_bad;
 
+	access_mask = is_write ? VM_WRITE : 0;
 	do {
-survive:
-		switch (handle_mm_fault(mm, vma, address, is_write)){
+handle_fault:
+		switch (__handle_mm_fault(mm, vma, address, access_mask)) {
 		case VM_FAULT_MINOR:
 			current->min_flt++;
 			break;
@@ -72,6 +74,9 @@ survive:
 		case VM_FAULT_SIGBUS:
 			err = -EACCES;
 			goto out;
+		case VM_FAULT_SIGSEGV:
+			err = -EFAULT;
+			goto out;
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -87,10 +92,27 @@ survive:
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, address);
+
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_NONUNIFORM; present PTE's are correct for VM_NONUNIFORM and were
+	 * already handled otherwise. */
 out:
 	up_read(&mm->mmap_sem);
 	return(err);
 
+prot_bad:
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		access_mask = is_write ? VM_WRITE : 0;
+		/* Otherwise, on a legitimate read fault on a page mapped as
+		 * exec-only, we get problems. Probably, we should lower
+		 * requirements... we should always test just
+		 * pte_read/write/exec, on vma->vm_page_prot! This way is
+		 * cumbersome. However, for now things should work for UML. */
+		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC : VM_READ;
+		goto handle_fault;
+	}
+	goto out;
+	
 /*
  * We ran out of memory, or some other thing happened to us that made
  * us unable to handle the page fault gracefully.
@@ -100,7 +122,7 @@ out_of_memory:
 		up_read(&mm->mmap_sem);
 		yield();
 		down_read(&mm->mmap_sem);
-		goto survive;
+		goto handle_fault;
 	}
 	goto out;
 }
_
