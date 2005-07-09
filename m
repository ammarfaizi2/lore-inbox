Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbVGIAsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVGIAsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVGIArL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:47:11 -0400
Received: from silver.veritas.com ([143.127.12.111]:51522 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263023AbVGIAok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:44:40 -0400
Date: Sat, 9 Jul 2005 01:46:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap don't test rss
Message-ID: <Pine.LNX.4.61.0507090144140.14262@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:44:38.0868 (UTC) FILETIME=[62F01140:01C5841F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the three get_mm_counter(mm, rss) tests from rmap.c: there was a
time when testing rss was important to avoid a particular race between
dup_mmap and the anonmm rmap; but now it's just a rather silly pseudo-
optimization, made even more obscure by the get_mm_counter macro.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/rmap.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

--- 2.6.13-rc2-mm1/mm/rmap.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/mm/rmap.c	2005-07-09 01:20:41.000000000 +0100
@@ -290,8 +290,6 @@ static int page_referenced_one(struct pa
 	pte_t *pte;
 	int referenced = 0;
 
-	if (!get_mm_counter(mm, rss))
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -522,8 +520,6 @@ static int try_to_unmap_one(struct page 
 	pte_t pteval;
 	int ret = SWAP_AGAIN;
 
-	if (!get_mm_counter(mm, rss))
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -771,8 +767,7 @@ static int try_to_unmap_file(struct page
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (get_mm_counter(vma->vm_mm, rss) &&
-				cursor < max_nl_cursor &&
+			while ( cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
