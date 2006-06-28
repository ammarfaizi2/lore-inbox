Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWF1UTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWF1UTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWF1USY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:18:24 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1213 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751316AbWF1URy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:17:54 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Wed, 28 Jun 2006 22:17:47 +0200
Message-Id: <20060628201747.8792.44812.sendpatchset@lappy>
In-Reply-To: <20060628201702.8792.69638.sendpatchset@lappy>
References: <20060628201702.8792.69638.sendpatchset@lappy>
Subject: [PATCH 4/6] mm: optimize the new mprotect() code a bit
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
--- linux-2.6-dirty.orig/mm/mprotect.c	2006-06-28 19:49:27.000000000 +0200
+++ linux-2.6-dirty/mm/mprotect.c	2006-06-28 20:03:51.000000000 +0200
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
@@ -125,6 +136,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long charged = 0;
 	pgoff_t pgoff;
 	int error;
+	int dirty_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -181,14 +193,16 @@ success:
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = protection_map[newflags &
 		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
-	if (vma_wants_writenotify(vma))
+	if (vma_wants_writenotify(vma)) {
 		vma->vm_page_prot = protection_map[newflags &
 			(VM_READ|VM_WRITE|VM_EXEC)];
+		dirty_accountable = 1;
+	}
 
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
-		change_protection(vma, start, end, vma->vm_page_prot);
+		change_protection(vma, start, end, vma->vm_page_prot, dirty_accountable);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
