Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbVIYPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbVIYPsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVIYPsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:48:46 -0400
Received: from gold.veritas.com ([143.127.12.110]:5803 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751524AbVIYPsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:48:46 -0400
Date: Sun, 25 Sep 2005 16:48:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] mm: copy_pte_range progress fix
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251647390.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:48:45.0750 (UTC) FILETIME=[9CD1DD60:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 02/21] mm: copy_pte_range progress fix

My latency breaking in copy_pte_range didn't work as intended: instead
of checking at regularish intervals, after the first interval it checked
every time around the loop, too impatient to be preempted.  Fix that.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

--- mm01/mm/memory.c	2005-09-21 12:16:59.000000000 +0100
+++ mm02/mm/memory.c	2005-09-24 19:26:38.000000000 +0100
@@ -410,7 +410,7 @@ static int copy_pte_range(struct mm_stru
 {
 	pte_t *src_pte, *dst_pte;
 	unsigned long vm_flags = vma->vm_flags;
-	int progress;
+	int progress = 0;
 
 again:
 	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
@@ -418,17 +418,19 @@ again:
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
 
-	progress = 0;
 	spin_lock(&src_mm->page_table_lock);
 	do {
 		/*
 		 * We are holding two locks at this point - either of them
 		 * could generate latencies in another task on another CPU.
 		 */
-		if (progress >= 32 && (need_resched() ||
-		    need_lockbreak(&src_mm->page_table_lock) ||
-		    need_lockbreak(&dst_mm->page_table_lock)))
-			break;
+		if (progress >= 32) {
+			progress = 0;
+			if (need_resched() ||
+			    need_lockbreak(&src_mm->page_table_lock) ||
+			    need_lockbreak(&dst_mm->page_table_lock))
+				break;
+		}
 		if (pte_none(*src_pte)) {
 			progress++;
 			continue;
