Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVJMArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVJMArq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJMArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:47:46 -0400
Received: from silver.veritas.com ([143.127.12.111]:42388 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751489AbVJMArp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:47:45 -0400
Date: Thu, 13 Oct 2005 01:47:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] mm: do_swap_page race major
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130146240.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:47:44.0961 (UTC) FILETIME=[B9839B10:01C5CF8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small adjustment: do_swap_page should report its !pte_same race as a
major fault if it had to read into swap cache, because whatever raced
with it will have found page already in cache and reported minor fault.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

--- mm02/mm/memory.c	2005-10-11 23:53:17.000000000 +0100
+++ mm03/mm/memory.c	2005-10-11 23:53:35.000000000 +0100
@@ -1728,10 +1728,8 @@ static int do_swap_page(struct mm_struct
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
-	if (unlikely(!pte_same(*page_table, orig_pte))) {
-		ret = VM_FAULT_MINOR;
+	if (unlikely(!pte_same(*page_table, orig_pte)))
 		goto out_nomap;
-	}
 
 	if (unlikely(!PageUptodate(page))) {
 		ret = VM_FAULT_SIGBUS;
