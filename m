Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932864AbWCVWbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbWCVWbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWCVWby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:31:54 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31800 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932868AbWCVWbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:31:52 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223118.12658.36826.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 01/34] mm: kill-page-activate.patch
Date: Wed, 22 Mar 2006 23:31:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Get rid of activate_page() callers.

Instead, page activation is achieved through mark_page_accessed()
interface.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---

 include/linux/swap.h |    1 -
 mm/swapfile.c        |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h	2006-03-13 20:37:08.000000000 +0100
+++ linux-2.6/include/linux/swap.h	2006-03-13 20:37:22.000000000 +0100
@@ -164,7 +164,6 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int lru_add_drain_all(void);
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c	2006-03-13 20:37:08.000000000 +0100
+++ linux-2.6/mm/swapfile.c	2006-03-13 20:37:22.000000000 +0100
@@ -435,7 +435,7 @@ static void unuse_pte(struct vm_area_str
 	 * Move the page to the active list so it is not
 	 * immediately swapped out again after swapon.
 	 */
-	activate_page(page);
+	mark_page_accessed(page);
 }
 
 static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -537,7 +537,7 @@ static int unuse_mm(struct mm_struct *mm
 		 * Activate page so shrink_cache is unlikely to unmap its
 		 * ptes while lock is dropped, so swapoff can make progress.
 		 */
-		activate_page(page);
+		mark_page_accessed(page);
 		unlock_page(page);
 		down_read(&mm->mmap_sem);
 		lock_page(page);
