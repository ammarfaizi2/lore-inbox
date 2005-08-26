Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVHZRCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVHZRCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVHZRCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:52 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:38805 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965130AbVHZRCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:48 -0400
Subject: [patch 10/18] remap_file_pages protection support: adapt to uml peculiarities
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:38 +0200
Message-Id: <20050826165338.F3538254847@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Uml is particular in respect with other architectures (and possibly this is to
fix) in the fact that our arch fault handler handles indifferently both TLB
and page faults. In particular, we may get to call handle_mm_fault() when the
PTE is already correct, but simply it's not flushed.

And rfp-fault-sigsegv-2 breaks this, because when getting a fault on a
pte_present PTE and non-uniform VMA, it assumes the fault is due to a
protection fault, and signals the caller a SIGSEGV must be sent.

*** remap_file_pages protection support: fix unflushed TLB errors detection

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We got unflushed PTE's marked up-to-date, because they were protected to get
dirtying / accessing faults. So, don't test the PTE for being up-to-date, but
check directly the permission (since the PTE is not protected for that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   37 +++++++++++++++++++++----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-handle-tlb-faults arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-handle-tlb-faults	2005-08-21 21:32:13.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-21 21:32:13.000000000 +0200
@@ -35,7 +35,7 @@ int handle_page_fault(unsigned long addr
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, entry;
 	int err = -EFAULT;
 	int access_mask = 0;
 
@@ -84,8 +84,37 @@ handle_fault:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
-			err = -EFAULT;
-			goto out;
+			WARN_ON(!(vma->vm_flags & VM_NONUNIFORM));
+			/* Duplicate this code here. */
+			pgd = pgd_offset(mm, address);
+			pud = pud_offset(pgd, address);
+			pmd = pmd_offset(pud, address);
+			pte = pte_offset_kernel(pmd, address);
+			if (likely (pte_newpage(*pte) || pte_newprot(*pte)) ||
+				(is_write ? pte_write(*pte) : pte_read(*pte)) ) {
+				/* The page hadn't been flushed, or it had been
+				 * flushed but without access to get a dirtying
+				 * / accessing fault. */
+
+				/* __handle_mm_fault() didn't dirty / young this
+				 * PTE, probably we won't get another fault for
+				 * this page, so fix things now. */
+				entry = *pte;
+				entry = pte_mkyoung(*pte);
+				if(pte_write(entry))
+					entry = pte_mkdirty(entry);
+				/* Yes, this will set the page as NEWPAGE. We
+				 * want this, otherwise things won't work.
+				 * Indeed, the
+				 * *pte = pte_mkyoung(*pte);
+				 * we used to have (uselessly) didn't work at
+				 * all! */
+				set_pte(pte, entry);
+				break;
+			} else {
+				err = -EFAULT;
+				goto out;
+			}
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -98,8 +127,6 @@ handle_fault:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
-	*pte = pte_mkyoung(*pte);
-	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);
_
