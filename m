Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932873AbWCVWdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbWCVWdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWCVWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:32:42 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:34921 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932866AbWCVWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:22 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223148.12658.21044.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 04/34] mm: page-replace-use_once.patch
Date: Wed, 22 Mar 2006 23:32:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Allow for a use-once hint.

API:

give a hint to the page replace algorithm:

	void page_replace_hint_use_once(struct page *);

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    1 +
 include/linux/mm_use_once_policy.h |    4 ++++
 mm/filemap.c                       |   13 ++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6-git/mm/filemap.c
===================================================================
--- linux-2.6-git.orig/mm/filemap.c
+++ linux-2.6-git/mm/filemap.c
@@ -403,7 +403,18 @@ int add_to_page_cache(struct page *page,
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			page_cache_get(page);
-			SetPageLocked(page);
+			/*
+			 * shmem_getpage()
+			 *   lookup_swap_cache()
+			 *   TestSetPageLocked()
+			 *   move_from_swap_cache()
+			 *     add_to_page_cache()
+			 *
+			 * That path calls us with a LRU page instead of a new
+			 * page. Don't set the hint for LRU pages.
+			 */
+			if (!TestSetPageLocked(page))
+				page_replace_hint_use_once(page);
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -8,6 +8,7 @@
 #include <linux/pagevec.h>
 
 /* void page_replace_hint_active(struct page *); */
+/* void page_replace_hint_use_once(struct page *); */
 extern void fastcall page_replace_add(struct page *);
 /* void page_replace_add_drain(void); */
 extern void __page_replace_add_drain(unsigned int);
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -8,5 +8,9 @@ static inline void page_replace_hint_act
 	SetPageActive(page);
 }
 
+static inline void page_replace_hint_use_once(struct page *page)
+{
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
