Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUGORAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUGORAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUGORAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:00:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64355 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266243AbUGORAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:00:43 -0400
Date: Thu, 15 Jul 2004 18:00:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs preempt count panic
Message-ID: <Pine.LNX.4.44.0407151755350.7808-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just unearthed another of my warcrimes: reading a 17-page sparse file,
I mean holey file, hits the in_interrupt panic in do_exit on a current
highmem kernel (but 2.6.7 is okay).  Fix mismatched preempt count from
shmem_swp_alloc's swapindex hole case by mapping an empty_zero_page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.8-rc1/mm/shmem.c	2004-07-11 21:59:42.000000000 +0100
+++ linux/mm/shmem.c	2004-07-15 17:27:58.545771152 +0100
@@ -337,7 +337,6 @@ static swp_entry_t *shmem_swp_alloc(stru
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct page *page = NULL;
 	swp_entry_t *entry;
-	static const swp_entry_t unswapped = { 0 };
 
 	if (sgp != SGP_WRITE &&
 	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))
@@ -345,7 +344,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 
 	while (!(entry = shmem_swp_entry(info, index, &page))) {
 		if (sgp == SGP_READ)
-			return (swp_entry_t *) &unswapped;
+			return shmem_swp_map(ZERO_PAGE(0));
 		/*
 		 * Test free_blocks against 1 not 0, since we have 1 data
 		 * page (and perhaps indirect index pages) yet to allocate:

