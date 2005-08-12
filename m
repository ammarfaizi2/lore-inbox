Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVHLStT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVHLStT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVHLStP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:15 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39339 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1751185AbVHLStH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:07 -0400
Subject: [patch 24/39] remap_file_pages protection support: adapt to uml peculiarities
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:35:57 +0200
Message-Id: <20050812183557.D15FE24E7CB@zion.home.lan>
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

This isn't the final fix for UML, that's the next one.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3 arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3	2005-08-11 23:13:06.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:14:26.000000000 +0200
@@ -75,8 +75,21 @@ handle_fault:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
-			err = -EFAULT;
-			goto out;
+			/* Duplicate this code here. */
+			pgd = pgd_offset(mm, address);
+			pud = pud_offset(pgd, address);
+			pmd = pmd_offset(pud, address);
+			pte = pte_offset_kernel(pmd, address);
+			if (likely (pte_newpage(*pte) || pte_newprot(*pte))) {
+				/* This wasn't done by __handle_mm_fault(), and
+				 * the page hadn't been flushed. */
+				*pte = pte_mkyoung(*pte);
+				if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
+				break;
+			} else {
+				err = -EFAULT;
+				goto out;
+			}
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -89,8 +102,6 @@ handle_fault:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
-	*pte = pte_mkyoung(*pte);
-	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, address);
 
 	/* If the PTE is not present, the vma protection are not accurate if
_
