Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbVG3ULk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVG3ULk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVG3UGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:06:30 -0400
Received: from gold.veritas.com ([143.127.12.110]:54089 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263140AbVG3UFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:05:22 -0400
Date: Sat, 30 Jul 2005 21:07:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
Subject: [PATCH mm] page fault patches: fix highpte in do_anon_page
Message-ID: <Pine.LNX.4.61.0507302103590.3933@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2005 20:05:22.0331 (UTC) FILETIME=[0459EEB0:01C59542]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "scheduling while atomic" messages below do_anonymous_page when
CONFIG_HIGHPTE=y: must unmap and remap the page_table around page
allocation.  And let's shift the usual pte_unmap to the minor_fault exit.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

Please don't interpret this fix as my approving the do_anonymous_page
without page_table_lock patches!  I'm still averse to this special
route with different locking rules; but let's get it right for testing.

 mm/memory.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- 2.6.13-rc3-mm3/mm/memory.c	2005-07-29 14:11:33.000000000 +0100
+++ linux/mm/memory.c	2005-07-29 20:58:54.000000000 +0100
@@ -1796,12 +1796,12 @@ do_anonymous_page(struct mm_struct *mm, 
 		} else {
 			inc_page_state(cmpxchg_fail_anon_read);
 		}
-		pte_unmap(page_table);
 		goto minor_fault;
 	}
 
 	/* This leaves the write case */
 	page_table_atomic_stop(mm);
+	pte_unmap(page_table);
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 
@@ -1812,10 +1812,10 @@ do_anonymous_page(struct mm_struct *mm, 
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 						vma->vm_page_prot)),
 				vma);
+	page_table = pte_offset_map(pmd, addr);
 	page_table_atomic_start(mm);
 
 	if (!ptep_cmpxchg(mm, addr, page_table, orig_entry, entry)) {
-		pte_unmap(page_table);
 		page_cache_release(page);
 		inc_page_state(cmpxchg_fail_anon_write);
 		goto minor_fault;
@@ -1829,12 +1829,12 @@ do_anonymous_page(struct mm_struct *mm, 
 	page_add_anon_rmap(page, vma, addr);
 	lru_cache_add_active(page);
 	inc_mm_counter(mm, rss);
-	pte_unmap(page_table);
 	update_mmu_cache(vma, addr, entry);
 	lazy_mmu_prot_update(entry);
 
 minor_fault:
 	page_table_atomic_stop(mm);
+	pte_unmap(page_table);
 	return VM_FAULT_MINOR;
 
 oom:
