Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVJMBVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVJMBVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJMBVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:21:06 -0400
Received: from gold.veritas.com ([143.127.12.110]:28949 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964853AbVJMBVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:21:05 -0400
Date: Thu, 13 Oct 2005 02:20:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] mm: xip_unmap ZERO_PAGE fix
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130218580.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:21:05.0136 (UTC) FILETIME=[61B61700:01C5CF94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small fix to the PageReserved patch: the mips ZERO_PAGE(address) depends
on address, so __xip_unmap is wrong to initialize page with that before
address is initialized; and in fact must re-evaluate it each iteration.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/filemap_xip.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- mm17/mm/filemap_xip.c	2005-10-11 12:16:50.000000000 +0100
+++ mm18/mm/filemap_xip.c	2005-10-11 23:58:14.000000000 +0100
@@ -174,7 +174,7 @@ __xip_unmap (struct address_space * mapp
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
-	struct page *page = ZERO_PAGE(address);
+	struct page *page;
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
@@ -182,6 +182,7 @@ __xip_unmap (struct address_space * mapp
 		address = vma->vm_start +
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+		page = ZERO_PAGE(address);
 		/*
 		 * We need the page_table_lock to protect us from page faults,
 		 * munmap, fork, etc...
