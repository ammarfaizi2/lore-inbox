Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUEHV4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUEHV4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUEHV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:56:47 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47679 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264170AbUEHV4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:56:38 -0400
Date: Sat, 8 May 2004 22:56:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 24 pte_young first
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082255430.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>

rmap test pte_young before doing the costlier ptep_test_and_clear_young.

 rmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- rmap24/mm/rmap.c	2004-05-08 20:54:32.421571016 +0100
+++ rmap25/mm/rmap.c	2004-05-08 20:54:43.358908288 +0100
@@ -198,7 +198,7 @@ static int page_referenced_one(struct pa
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	if (ptep_test_and_clear_young(pte))
+	if (pte_young(*pte) && ptep_test_and_clear_young(pte))
 		referenced++;
 
 	(*mapcount)--;
@@ -506,7 +506,7 @@ static int try_to_unmap_one(struct page 
 	 * skipped over this mm) then we should reactivate it.
 	 */
 	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
-			ptep_test_and_clear_young(pte)) {
+	    (pte_young(*pte) && ptep_test_and_clear_young(pte))) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -606,7 +606,7 @@ static int try_to_unmap_cluster(struct m
 		if (PageReserved(page))
 			continue;
 
-		if (ptep_test_and_clear_young(pte))
+		if (pte_young(*pte) && ptep_test_and_clear_young(pte))
 			continue;
 
 		/* Nuke the page table entry. */

