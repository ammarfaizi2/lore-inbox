Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWFSRxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWFSRxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFSRxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:53:46 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:500 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S964818AbWFSRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:53:39 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 19 Jun 2006 19:53:26 +0200
Message-Id: <20060619175326.24655.90153.sendpatchset@lappy>
In-Reply-To: <20060619175243.24655.76005.sendpatchset@lappy>
References: <20060619175243.24655.76005.sendpatchset@lappy>
Subject: [PATCH 4/6] mm: optimize the new mprotect() code a bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

mprotect() resets the page protections, which could result in extra write
faults for those pages whos dirty state we track using write faults
and are dirty already.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/mprotect.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

Index: 2.6-mm/mm/mprotect.c
===================================================================
--- 2.6-mm.orig/mm/mprotect.c	2006-06-19 16:19:42.000000000 +0200
+++ 2.6-mm/mm/mprotect.c	2006-06-19 16:20:42.000000000 +0200
@@ -28,7 +28,8 @@
 #include <asm/tlbflush.h>
 
 static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -43,7 +44,13 @@ static void change_pte_range(struct mm_s
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			ptent = pte_modify(ptep_get_and_clear(mm, addr, pte), newprot);
+			ptent = ptep_get_and_clear(mm, addr, pte);
+			ptent = pte_modify(ptent, newprot);
+			/* Avoid taking write faults for pages we know to be
+			 * dirty.
+			 */
+			if (is_accountable && pte_dirty(ptent))
+				ptent = pte_mkwrite(ptent);
 			set_pte_at(mm, addr, pte, ptent);
 			lazy_mmu_prot_update(ptent);
 #ifdef CONFIG_MIGRATION
@@ -67,7 +74,8 @@ static void change_pte_range(struct mm_s
 }
 
 static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -77,12 +85,13 @@ static inline void change_pmd_range(stru
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		change_pte_range(mm, pmd, addr, next, newprot);
+		change_pte_range(mm, pmd, addr, next, newprot, is_accountable);
 	} while (pmd++, addr = next, addr != end);
 }
 
 static inline void change_pud_range(struct mm_struct *mm, pgd_t *pgd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -92,12 +101,13 @@ static inline void change_pud_range(stru
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		change_pmd_range(mm, pud, addr, next, newprot);
+		change_pmd_range(mm, pud, addr, next, newprot, is_accountable);
 	} while (pud++, addr = next, addr != end);
 }
 
 static void change_protection(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -111,7 +121,7 @@ static void change_protection(struct vm_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		change_pud_range(mm, pgd, addr, next, newprot);
+		change_pud_range(mm, pgd, addr, next, newprot, is_accountable);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
 }
@@ -129,6 +139,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
+	int is_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -184,8 +195,10 @@ success:
 	if (is_shared_writable(newflags) && vma->vm_file)
 		mapping = vma->vm_file->f_mapping;
 	if ((mapping && mapping_cap_account_dirty(mapping)) ||
-			(vma->vm_ops && vma->vm_ops->page_mkwrite))
+			(vma->vm_ops && vma->vm_ops->page_mkwrite)) {
 		mask &= ~VM_SHARED;
+		is_accountable = 1;
+	}
 
 	newprot = protection_map[newflags & mask];
 
@@ -198,7 +211,7 @@ success:
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, newprot);
 	else
-		change_protection(vma, start, end, newprot);
+		change_protection(vma, start, end, newprot, is_accountable);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
