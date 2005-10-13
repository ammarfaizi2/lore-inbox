Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVJMArF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVJMArF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJMArF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:47:05 -0400
Received: from gold.veritas.com ([143.127.12.110]:49425 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751491AbVJMArC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:47:02 -0400
Date: Thu, 13 Oct 2005 01:46:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] mm: zap_pte_range dec rss
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130145460.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:47:01.0901 (UTC) FILETIME=[9FD92BD0:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small adjustment: zap_pte_range decrement its rss counts from 0 then
finally add, avoiding negations - we don't have or need a sub_mm_rss.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- mm01/mm/memory.c	2005-10-11 23:53:00.000000000 +0100
+++ mm02/mm/memory.c	2005-10-11 23:53:17.000000000 +0100
@@ -609,13 +609,13 @@ static void zap_pte_range(struct mmu_gat
 				set_pte_at(mm, addr, pte,
 					   pgoff_to_pte(page->index));
 			if (PageAnon(page))
-				anon_rss++;
+				anon_rss--;
 			else {
 				if (pte_dirty(ptent))
 					set_page_dirty(page);
 				if (pte_young(ptent))
 					mark_page_accessed(page);
-				file_rss++;
+				file_rss--;
 			}
 			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
@@ -632,7 +632,7 @@ static void zap_pte_range(struct mmu_gat
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	add_mm_rss(mm, -file_rss, -anon_rss);
+	add_mm_rss(mm, file_rss, anon_rss);
 	pte_unmap(pte - 1);
 }
 
