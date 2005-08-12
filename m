Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVHLSvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVHLSvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVHLStY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:24 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:48572 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750987AbVHLSs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:56 -0400
Subject: [patch 25/39] remap_file_pages protection support: fix unflushed TLB errors detection
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:00 +0200
Message-Id: <20050812183600.7D46D24E7D0@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We got unflushed PTE's marked up-to-date, because they were protected to get
dirtying / accessing faults. So, don't test the PTE for being up-to-date, but
check directly the permission (since the PTE is not protected for that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   28 +++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3-fix arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3-fix	2005-08-11 23:14:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:14:58.000000000 +0200
@@ -35,7 +35,7 @@ int handle_page_fault(unsigned long addr
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, entry;
 	int err = -EFAULT;
 	int access_mask = 0;
 
@@ -75,16 +75,32 @@ handle_fault:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
+			WARN_ON(!(vma->vm_flags & VM_NONUNIFORM));
 			/* Duplicate this code here. */
 			pgd = pgd_offset(mm, address);
 			pud = pud_offset(pgd, address);
 			pmd = pmd_offset(pud, address);
 			pte = pte_offset_kernel(pmd, address);
-			if (likely (pte_newpage(*pte) || pte_newprot(*pte))) {
-				/* This wasn't done by __handle_mm_fault(), and
-				 * the page hadn't been flushed. */
-				*pte = pte_mkyoung(*pte);
-				if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
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
 				break;
 			} else {
 				err = -EFAULT;
_
