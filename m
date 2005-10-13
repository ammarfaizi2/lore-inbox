Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVJMAq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJMAq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJMAq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:46:26 -0400
Received: from gold.veritas.com ([143.127.12.110]:45841 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751275AbVJMAqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:46:25 -0400
Date: Thu, 13 Oct 2005 01:45:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] mm: copy_one_pte inc rss
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130144550.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:46:25.0370 (UTC) FILETIME=[8A12FBA0:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small adjustment, following Nick's suggestion: it's more straightforward
for copy_pte_range to let copy_one_pte do the rss incrementation, than
use an index it passed back.  Saves a #define, and 16 bytes of .text.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

--- mm00/mm/memory.c	2005-10-11 12:16:50.000000000 +0100
+++ mm01/mm/memory.c	2005-10-11 23:53:00.000000000 +0100
@@ -340,8 +340,6 @@ static inline void add_mm_rss(struct mm_
 		add_mm_counter(mm, anon_rss, anon_rss);
 }
 
-#define NO_RSS 2	/* Increment neither file_rss nor anon_rss */
-
 /*
  * This function is called to print an error when a pte in a
  * !VM_RESERVED region is found pointing to an invalid pfn (which
@@ -368,16 +366,15 @@ void print_bad_pte(struct vm_area_struct
  * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
 
-static inline int
+static inline void
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr)
+		unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	unsigned long pfn;
-	int anon = NO_RSS;
 
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
@@ -428,11 +425,10 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	pte = pte_mkold(pte);
 	get_page(page);
 	page_dup_rmap(page);
-	anon = !!PageAnon(page);
+	rss[!!PageAnon(page)]++;
 
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
-	return anon;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -441,7 +437,7 @@ static int copy_pte_range(struct mm_stru
 {
 	pte_t *src_pte, *dst_pte;
 	int progress = 0;
-	int rss[NO_RSS+1], anon;
+	int rss[2];
 
 again:
 	rss[1] = rss[0] = 0;
@@ -467,8 +463,7 @@ again:
 			progress++;
 			continue;
 		}
-		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma,addr);
-		rss[anon]++;
+		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 	spin_unlock(&src_mm->page_table_lock);
