Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWFMLX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFMLX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFMLWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:22:31 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26094 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750992AbWFMLW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:22:27 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Jun 2006 13:22:03 +0200
Message-Id: <20060613112203.27913.95809.sendpatchset@lappy>
In-Reply-To: <20060613112120.27913.71986.sendpatchset@lappy>
References: <20060613112120.27913.71986.sendpatchset@lappy>
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

Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c	2006-06-12 13:09:55.000000000 +0200
+++ linux-2.6/mm/mprotect.c	2006-06-13 11:43:13.000000000 +0200
@@ -27,7 +27,8 @@
 #include <asm/tlbflush.h>
 
 static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	pte_t *pte;
 	spinlock_t *ptl;
@@ -41,7 +42,13 @@ static void change_pte_range(struct mm_s
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
 		}
@@ -50,7 +57,8 @@ static void change_pte_range(struct mm_s
 }
 
 static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
-		unsigned long addr, unsigned long end, pgprot_t newprot)
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		int is_accountable)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -60,12 +68,13 @@ static inline void change_pmd_range(stru
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
@@ -75,12 +84,13 @@ static inline void change_pud_range(stru
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
@@ -94,7 +104,7 @@ static void change_protection(struct vm_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		change_pud_range(mm, pgd, addr, next, newprot);
+		change_pud_range(mm, pgd, addr, next, newprot, is_accountable);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
 }
@@ -112,6 +122,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
+	int is_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -165,8 +176,10 @@ success:
 	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
 	if (is_shared_writable(newflags) && vma->vm_file)
 		mapping = vma->vm_file->f_mapping;
-	if (mapping && mapping_cap_account_dirty(mapping))
+	if (mapping && mapping_cap_account_dirty(mapping)) {
 		mask &= ~VM_SHARED;
+		is_accountable = 1;
+	}
 
 	newprot = protection_map[newflags & mask];
 
@@ -179,7 +192,7 @@ success:
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, newprot);
 	else
-		change_protection(vma, start, end, newprot);
+		change_protection(vma, start, end, newprot, is_accountable);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
