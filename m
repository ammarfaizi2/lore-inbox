Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVIYPuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVIYPuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIYPuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:50:18 -0400
Received: from silver.veritas.com ([143.127.12.111]:24246 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932231AbVIYPuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:50:16 -0400
Date: Sun, 25 Sep 2005 16:49:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] mm: zap_pte_range dont dirty anon
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:50:15.0875 (UTC) FILETIME=[D289D930:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_pte_range already avoids wasting time to mark_page_accessed on anon
pages: it can also skip anon set_page_dirty - the page only needs to be
marked dirty if shared with another mm, but that will say pte_dirty too.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- mm03/mm/memory.c	2005-09-24 19:26:38.000000000 +0100
+++ mm04/mm/memory.c	2005-09-24 19:27:05.000000000 +0100
@@ -574,12 +574,14 @@ static void zap_pte_range(struct mmu_gat
 						addr) != page->index)
 				set_pte_at(tlb->mm, addr, pte,
 					   pgoff_to_pte(page->index));
-			if (pte_dirty(ptent))
-				set_page_dirty(page);
 			if (PageAnon(page))
 				dec_mm_counter(tlb->mm, anon_rss);
-			else if (pte_young(ptent))
-				mark_page_accessed(page);
+			else {
+				if (pte_dirty(ptent))
+					set_page_dirty(page);
+				if (pte_young(ptent))
+					mark_page_accessed(page);
+			}
 			tlb->freed++;
 			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
