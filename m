Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVKJCEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVKJCEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVKJCEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:04:22 -0500
Received: from silver.veritas.com ([143.127.12.111]:33834 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751429AbVKJCEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:04:22 -0500
Date: Thu, 10 Nov 2005 02:03:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] mm: get_user_pages check count
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100201430.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:04:21.0693 (UTC) FILETIME=[10F23ED0:01C5E59B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most calls to get_user_pages soon release the pages and then return to
user space, but some are long term - notably Infiniband's ib_umem_get.
That's blessed with good locked_vm checking, but if the system were
misconfigured, then it might be possible to build up a huge page_count.

Guard against overflow by page_count_too_high checks in get_user_pages:
refuse with -ENOMEM once page count reaches its final PID_MAX_LIMIT
(which is why we allowed for 2*PID_MAX_LIMIT in the 23 bits of count).

Sorry, can't touch get_user_pages without giving it more cleanup.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h |   16 ++++++++++++++++
 mm/memory.c        |   40 +++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 17 deletions(-)

--- mm12/include/linux/mm.h	2005-11-09 14:40:00.000000000 +0000
+++ mm13/include/linux/mm.h	2005-11-09 14:40:17.000000000 +0000
@@ -312,6 +312,7 @@ struct page {
  */
 #define PCOUNT_SHIFT	23
 #define PCOUNT_MASK	((1UL << PCOUNT_SHIFT) - 1)
+#define PCOUNT_HIGH	(PCOUNT_MASK - PID_MAX_LIMIT)
 
 /*
  * Drop a ref, return true if the logical refcount fell to zero
@@ -377,8 +378,17 @@ static inline int page_mapped(struct pag
 	return (unsigned long)atomic64_read(&page->_pcount) > PCOUNT_MASK;
 }
 
+static inline int page_count_too_high(struct page *page)
+{
+	/* get_user_pages check when nearing overflow */
+	return ((unsigned long)atomic64_read(&page->_pcount) & PCOUNT_MASK)
+							>= PCOUNT_HIGH;
+}
+
 #else /* !ATOMIC64_INIT */
 
+#define PCOUNT_HIGH	(INT_MAX - PID_MAX_LIMIT)
+
 /*
  * Drop a ref, return true if the logical refcount fell to zero
  * (the page has no users)
@@ -437,6 +447,12 @@ static inline int page_mapped(struct pag
 	return atomic_read(&page->_mapcount) >= 0;
 }
 
+static inline int page_count_too_high(struct page *page)
+{
+	/* get_user_pages check when nearing overflow */
+	return atomic_read(&page->_count) >= PCOUNT_HIGH;
+}
+
 #endif /* !ATOMIC64_INIT */
 
 void FASTCALL(__page_cache_release(struct page *));
--- mm12/mm/memory.c	2005-11-09 14:40:00.000000000 +0000
+++ mm13/mm/memory.c	2005-11-09 14:40:17.000000000 +0000
@@ -928,39 +928,43 @@ int get_user_pages(struct task_struct *t
 	do {
 		struct vm_area_struct *vma;
 		unsigned int foll_flags;
+		struct page *page;
 
 		vma = find_extend_vma(mm, start);
 		if (!vma && in_gate_area(tsk, start)) {
-			unsigned long pg = start & PAGE_MASK;
-			struct vm_area_struct *gate_vma = get_gate_vma(tsk);
 			pgd_t *pgd;
 			pud_t *pud;
 			pmd_t *pmd;
 			pte_t *pte;
+			pte_t ptent;
+
 			if (write) /* user gate pages are read-only */
 				return i ? : -EFAULT;
-			if (pg > TASK_SIZE)
-				pgd = pgd_offset_k(pg);
+			start &= PAGE_MASK;	/* what needs that? */
+			if (start >= TASK_SIZE)
+				pgd = pgd_offset_k(start);
 			else
-				pgd = pgd_offset_gate(mm, pg);
+				pgd = pgd_offset_gate(mm, start);
 			BUG_ON(pgd_none(*pgd));
-			pud = pud_offset(pgd, pg);
+			pud = pud_offset(pgd, start);
 			BUG_ON(pud_none(*pud));
-			pmd = pmd_offset(pud, pg);
+			pmd = pmd_offset(pud, start);
 			if (pmd_none(*pmd))
 				return i ? : -EFAULT;
-			pte = pte_offset_map(pmd, pg);
-			if (pte_none(*pte)) {
-				pte_unmap(pte);
+			pte = pte_offset_map(pmd, start);
+			ptent = *pte;
+			pte_unmap(pte);
+			if (pte_none(ptent))
 				return i ? : -EFAULT;
-			}
 			if (pages) {
-				pages[i] = pte_page(*pte);
-				get_page(pages[i]);
+				page = pte_page(ptent);
+				if (page_count_too_high(page))
+					return i ? : -ENOMEM;
+				get_page(page);
+				pages[i] = page;
 			}
-			pte_unmap(pte);
 			if (vmas)
-				vmas[i] = gate_vma;
+				vmas[i] = get_gate_vma(tsk);
 			i++;
 			start += PAGE_SIZE;
 			len--;
@@ -985,8 +989,6 @@ int get_user_pages(struct task_struct *t
 			foll_flags |= FOLL_ANON;
 
 		do {
-			struct page *page;
-
 			if (write)
 				foll_flags |= FOLL_WRITE;
 
@@ -1020,6 +1022,10 @@ int get_user_pages(struct task_struct *t
 				}
 			}
 			if (pages) {
+				if (page_count_too_high(page)) {
+					put_page(page);
+					return i ? : -ENOMEM;
+				}
 				pages[i] = page;
 				flush_dcache_page(page);
 			}
