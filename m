Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWF0S3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWF0S3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWF0S3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:29:05 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:56558 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030272AbWF0S3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:29:00 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 27 Jun 2006 20:28:53 +0200
Message-Id: <20060627182853.20891.28744.sendpatchset@lappy>
In-Reply-To: <20060627182801.20891.11456.sendpatchset@lappy>
References: <20060627182801.20891.11456.sendpatchset@lappy>
Subject: [PATCH 4/5] mm: optimize the new mprotect() code a bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

mprotect() resets the page protections, which could result in extra write
faults for those pages whose dirty state we track using write faults
and are dirty already.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/mprotect.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

Index: linux-2.6-dirty/mm/mprotect.c
===================================================================
--- linux-2.6-dirty.orig/mm/mprotect.c	2006-06-27 13:26:19.000000000 +0200
+++ linux-2.6-dirty/mm/mprotect.c	2006-06-27 13:28:49.000000000 +0200
@@ -27,7 +27,8 @@
 #include <asm/tlbflush.h>
 
 static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -42,7 +43,14 @@ static void change_pte_range(struct mm_s
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
@@ -66,7 +74,8 @@ static void change_pte_range(struct mm_s
 }
 
 static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int dirty_accountable)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -76,12 +85,13 @@ static inline void change_pmd_range(stru
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
@@ -91,12 +101,13 @@ static inline void change_pud_range(stru
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
@@ -110,7 +121,7 @@ static void change_protection(struct vm_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		change_pud_range(mm, pgd, addr, next, newprot);
+		change_pud_range(mm, pgd, addr, next, newprot, dirty_accountable);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
 }
@@ -126,6 +137,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
 	pgoff_t pgoff;
 	int error;
+	int dirty_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -180,14 +192,16 @@ success:
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
-	if (vma_wants_writenotify(vma, VM_NOTIFY_NO_PROT))
+	if (vma_wants_writenotify(vma, VM_NOTIFY_NO_PROT)) {
 		mask &= ~VM_SHARED;
+		dirty_accountable = 1;
+	}
 	vma->vm_page_prot = protection_map[newflags & mask];
 
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
-		change_protection(vma, start, end, vma->vm_page_prot);
+		change_protection(vma, start, end, vma->vm_page_prot, dirty_accountable);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
