Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVJWHua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVJWHua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 03:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJWHua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 03:50:30 -0400
Received: from silver.veritas.com ([143.127.12.111]:5396 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751434AbVJWHu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 03:50:29 -0400
Date: Sun, 23 Oct 2005 08:49:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9 take 2] mm: uml kill unused
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510230847230.19503@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Oct 2005 07:50:25.0329 (UTC) FILETIME=[6D9A2A10:01C5D7A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In worrying over the various pte operations in different architectures,
I came across some unused functions in UML: remove mprotect_kernel_vm
and protect_vm_page; but leave addr_pte, Jeff notes it's useful in gdb.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This replaces yesterday's 6/9, following Jeff's feedback - thanks.

 arch/um/include/tlb.h   |    1 -
 arch/um/kernel/tt/tlb.c |   36 ------------------------------------
 2 files changed, 37 deletions(-)

--- mm5/arch/um/include/tlb.h	2005-10-11 12:07:16.000000000 +0100
+++ mm6/arch/um/include/tlb.h	2005-10-22 14:07:12.000000000 +0100
@@ -34,7 +34,6 @@ struct host_vm_op {
 	} u;
 };
 
-extern void mprotect_kernel_vm(int w);
 extern void force_flush_all(void);
 extern void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                              unsigned long end_addr, int force,
--- mm5/arch/um/kernel/tt/tlb.c	2005-10-11 12:07:16.000000000 +0100
+++ mm6/arch/um/kernel/tt/tlb.c	2005-10-22 14:07:12.000000000 +0100
@@ -74,42 +74,6 @@ void flush_tlb_kernel_range_tt(unsigned 
                 atomic_inc(&vmchange_seq);
 }
 
-static void protect_vm_page(unsigned long addr, int w, int must_succeed)
-{
-	int err;
-
-	err = protect_memory(addr, PAGE_SIZE, 1, w, 1, must_succeed);
-	if(err == 0) return;
-	else if((err == -EFAULT) || (err == -ENOMEM)){
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-		protect_vm_page(addr, w, 1);
-	}
-	else panic("protect_vm_page : protect failed, errno = %d\n", err);
-}
-
-void mprotect_kernel_vm(int w)
-{
-	struct mm_struct *mm;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long addr;
-	
-	mm = &init_mm;
-	for(addr = start_vm; addr < end_vm;){
-		pgd = pgd_offset(mm, addr);
-		pud = pud_offset(pgd, addr);
-		pmd = pmd_offset(pud, addr);
-		if(pmd_present(*pmd)){
-			pte = pte_offset_kernel(pmd, addr);
-			if(pte_present(*pte)) protect_vm_page(addr, w, 0);
-			addr += PAGE_SIZE;
-		}
-		else addr += PMD_SIZE;
-	}
-}
-
 void flush_tlb_kernel_vm_tt(void)
 {
         flush_tlb_kernel_range(start_vm, end_vm);
