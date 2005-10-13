Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVJMAtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVJMAtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJMAtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:49:15 -0400
Received: from gold.veritas.com ([143.127.12.110]:64273 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932444AbVJMAtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:49:14 -0400
Date: Thu, 13 Oct 2005 01:48:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/21] mm: zap_pte out of line
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130147560.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:49:14.0367 (UTC) FILETIME=[EECDE0F0:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There used to be just one call to zap_pte, but it shouldn't be inline
now there are two.  Check for the common case pte_none before calling,
and move its rss accounting up into install_page or install_file_pte -
which helps the next patch.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/fremap.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

--- mm04/mm/fremap.c	2005-10-11 12:16:50.000000000 +0100
+++ mm05/mm/fremap.c	2005-10-11 23:54:15.000000000 +0100
@@ -20,34 +20,32 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+static int zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = *ptep;
+	struct page *page = NULL;
 
-	if (pte_none(pte))
-		return;
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
-		struct page *page;
-
 		flush_cache_page(vma, addr, pfn);
 		pte = ptep_clear_flush(vma, addr, ptep);
 		if (unlikely(!pfn_valid(pfn))) {
 			print_bad_pte(vma, pte, addr);
-			return;
+			goto out;
 		}
 		page = pfn_to_page(pfn);
 		if (pte_dirty(pte))
 			set_page_dirty(page);
 		page_remove_rmap(page);
 		page_cache_release(page);
-		dec_mm_counter(mm, file_rss);
 	} else {
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
 		pte_clear(mm, addr, ptep);
 	}
+out:
+	return !!page;
 }
 
 /*
@@ -93,9 +91,9 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
-	zap_pte(mm, vma, addr, pte);
+	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
+		inc_mm_counter(mm, file_rss);
 
-	inc_mm_counter(mm, file_rss);
 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
@@ -142,7 +140,8 @@ int install_file_pte(struct mm_struct *m
 	if (!pte)
 		goto err_unlock;
 
-	zap_pte(mm, vma, addr, pte);
+	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte))
+		dec_mm_counter(mm, file_rss);
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
