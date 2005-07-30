Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263108AbVG3TFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVG3TFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbVG3TDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:54 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:15782 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S263108AbVG3TCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:02:52 -0400
Subject: [patch 1/1] uml: avoid fixing faults while atomic
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 30 Jul 2005 21:05:46 +0200
Message-Id: <20050730190546.810CA1AEA4@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Following i386, we should maybe refuse trying to fault in pages when we're
doing atomic operations, because to handle the fault we could need to take
already taken spinlocks.

Also, if we're doing an atomic operation (in the sense of in_atomic()) we're
surely in kernel mode and we're surely going to handle adequately the failed
fault, so it's safe to behave this way.

Currently, on UML SMP is rarely used, and we don't support PREEMPT, so this is
unlikely to create problems right now, but it might in the future.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~uml-avoid-faults-while-atomic arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-avoid-faults-while-atomic	2005-07-30 17:04:10.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-07-30 17:04:10.000000000 +0200
@@ -39,6 +39,10 @@ int handle_page_fault(unsigned long addr
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
+
+	if (in_atomic()) //If the fault was during atomic operation, don't take the fault.
+		goto out_nosemaphore;
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if(!vma) 
@@ -52,7 +56,7 @@ int handle_page_fault(unsigned long addr
 	else if(expand_stack(vma, address)) 
 		goto out;
 
- good_area:
+good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
@@ -62,7 +66,7 @@ int handle_page_fault(unsigned long addr
 
 	page = address & PAGE_MASK;
 	do {
- survive:
+survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -88,8 +92,9 @@ int handle_page_fault(unsigned long addr
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, page);
- out:
+out:
 	up_read(&mm->mmap_sem);
+out_nosemaphore:
 	return(err);
 
 /*
_
