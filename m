Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265371AbUFVTIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUFVTIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUFVST2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:19:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41029 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264278AbUFVRnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:00 -0400
Date: Tue, 22 Jun 2004 18:42:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] zap anonymous unremarkable
Message-ID: <Pine.LNX.4.44.0406221836570.7866-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_pte_range is wasting time marking anon pages accessed: its original
!PageSwapCache test should have been reinstated when page_mapping was
changed to return swapper_space; or more simply, just check !PageAnon.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.7/mm/memory.c	2004-06-16 06:20:40.000000000 +0100
+++ linux/mm/memory.c	2004-06-22 13:17:24.445430864 +0100
@@ -407,7 +407,7 @@ static void zap_pte_range(struct mmu_gat
 				set_pte(ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			if (pte_young(pte) && page_mapping(page))
+			if (pte_young(pte) && !PageAnon(page))
 				mark_page_accessed(page);
 			tlb->freed++;
 			page_remove_rmap(page);

