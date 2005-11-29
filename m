Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVK2Qyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVK2Qyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVK2Qyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:54:41 -0500
Received: from silver.veritas.com ([143.127.12.111]:29803 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932187AbVK2Qyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:54:40 -0500
Date: Tue, 29 Nov 2005 16:54:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pfnmap: remove src_page from do_wp_page
In-Reply-To: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511291654020.5527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511291650400.5527@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Nov 2005 16:54:40.0069 (UTC) FILETIME=[96A0CF50:01C5F505]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean away do_wp_page's "src_page": cow_user_page makes it unnecessary.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- 2.6.15-rc3/mm/memory.c	2005-11-29 08:40:07.000000000 +0000
+++ linux/mm/memory.c	2005-11-29 15:59:34.000000000 +0000
@@ -1332,12 +1346,11 @@ static int do_wp_page(struct mm_struct *
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		spinlock_t *ptl, pte_t orig_pte)
 {
-	struct page *old_page, *src_page, *new_page;
+	struct page *old_page, *new_page;
 	pte_t entry;
 	int ret = VM_FAULT_MINOR;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
-	src_page = old_page;
 	if (!old_page)
 		goto gotten;
 
@@ -1365,7 +1378,7 @@ gotten:
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	if (src_page == ZERO_PAGE(address)) {
+	if (old_page == ZERO_PAGE(address)) {
 		new_page = alloc_zeroed_user_highpage(vma, address);
 		if (!new_page)
 			goto oom;
@@ -1373,7 +1386,7 @@ gotten:
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, src_page, address);
+		cow_user_page(new_page, old_page, address);
 	}
 
 	/*
