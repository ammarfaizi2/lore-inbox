Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWD3ReV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWD3ReV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWD3RdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:18 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45010 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751195AbWD3Rcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:39 -0400
Message-Id: <20060430173026.927517000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:07 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 14/14] remap_file_pages protection support: adapt to uml peculiarities
Content-Disposition: inline; filename=rfp/11-rfp-sigsegv-uml-handle-tlb-faults.diff
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

XXX: this is now wrong, since that SIGSEGV is not sent any more. I'll
subsequently verify whether this patch is still needed or not, but until now I
haven't had the time.

*) remap_file_pages protection support: fix unflushed TLB errors detection

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We got unflushed PTE's marked up-to-date; they were actually flushed, but still
protected, in order to get dirtying / accessing faults. So, don't test the PTE
for being up-to-date, but check directly the permission (since the PTE is not
protected for that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/trap_kern.c
+++ linux-2.6.git/arch/um/kernel/trap_kern.c
@@ -43,7 +43,7 @@ int handle_page_fault(unsigned long addr
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, entry;
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
@@ -93,8 +93,37 @@ survive:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
-			err = -EFAULT;
-			goto out;
+			WARN_ON(!(vma->vm_flags & VM_MANYPROTS));
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

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
