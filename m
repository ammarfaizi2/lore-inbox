Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWFWWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWFWWcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWFWWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:32:12 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:57804 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752141AbWFWWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:31:47 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Sat, 24 Jun 2006 00:31:44 +0200
Message-Id: <20060623223144.11513.44443.sendpatchset@lappy>
In-Reply-To: <20060623223103.11513.50991.sendpatchset@lappy>
References: <20060623223103.11513.50991.sendpatchset@lappy>
Subject: [PATCH 4/5] mm: optimize the new mprotect() code a bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

mprotect() resets the page protections, which could result in extra write
faults for those pages whose dirty state we track using write faults
and are dirty already.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/mprotect.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

Index: 2.6-mm/mm/mprotect.c
===================================================================
--- 2.6-mm.orig/mm/mprotect.c	2006-06-23 01:35:24.000000000 +0200
+++ 2.6-mm/mm/mprotect.c	2006-06-23 15:06:10.000000000 +0200
@@ -28,7 +28,8 @@
 #include <asm/tlbflush.h>
 
 static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -43,7 +44,14 @@ static void change_pte_range(struct mm_s
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			ptent = pte_modify(ptep_get_and_clear(mm, addr, pte), newprot);
+			ptent = ptep_get_and_clear(mm, addr, pte);
+			ptent = pte_modify(ptent, newprot);
+			/*
+			 * Avoid taking write faults for pages we know to be
+			 * dirty.
+			 */
+			if (dirty_accountable && pte_dirty(ptent))
+				ptent = pte_mkwrite(ptent);
 			set_pte_at(mm, addr, pte, ptent);
 			lazy_mmu_prot_update(ptent);
 #ifdef CONFIG_MIGRATION
@@ -67,7 +75,8 @@ static void change_pte_range(struct mm_s
 }
 
 static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -77,12 +86,13 @@ static inline void change_pmd_range(stru
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		change_pte_range(mm, pmd, addr, next, newprot);
+		change_pte_range(mm, pmd, addr, next, newprot, dirty_accountable);
 	} while (pmd++, addr = next, addr != end);
 }
 
 static inline void change_pud_range(struct mm_struct *mm, pgd_t *pgd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -92,12 +102,13 @@ static inline void change_pud_range(stru
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		change_pmd_range(mm, pud, addr, next, newprot);
+		change_pmd_range(mm, pud, addr, next, newprot, dirty_accountable);
 	} while (pud++, addr = next, addr != end);
 }
 
 static void change_protection(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -111,7 +122,7 @@ static void change_protection(struct vm_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		change_pud_range(mm, pgd, addr, next, newprot);
+		change_pud_range(mm, pgd, addr, next, newprot, dirty_accountable);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
 }
@@ -128,6 +139,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
+	int dirty_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -190,8 +202,10 @@ success:
 			  (VM_WRITE|VM_SHARED)) &&
 	     vma->vm_file && vma->vm_file->f_mapping &&
 	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
-	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
+	    (vma->vm_ops && vma->vm_ops->page_mkwrite)) {
 		mask &= ~VM_SHARED;
+		dirty_accountable = 1;
+	}
 
 	newprot = protection_map[newflags & mask];
 
@@ -204,7 +218,7 @@ success:
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, newprot);
 	else
-		change_protection(vma, start, end, newprot);
+		change_protection(vma, start, end, newprot, dirty_accountable);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
