Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWCSCnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWCSCnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWCSCed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:33 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:37570 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751277AbWCSCeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:31 -0500
Message-Id: <20060319023451.808130000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:20 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 07/23] readahead: insert cond_resched() calls
Content-Disposition: inline; filename=readahead-insert-cond_resched-calls.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm become more
complex, it becomes necessary to insert some cond_resched() calls in the
read-ahead path.

If desktop users still feel audio jitters with the new read-ahead code,
please try one of the following ways to get rid of it:

1) compile kernel with CONFIG_PREEMPT_VOLUNTARY/CONFIG_PREEMPT
2) reduce the read-ahead request size by running
	blockdev --setra 256 /dev/hda # or whatever device you are using

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


This patch is recommended by Con Kolivas to improve respond time for desktop.
Thanks!

 fs/mpage.c     |    4 +++-
 mm/readahead.c |    9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -145,8 +145,10 @@ int read_cache_pages(struct address_spac
 			continue;
 		}
 		ret = filler(data, page);
-		if (!pagevec_add(&lru_pvec, page))
+		if (!pagevec_add(&lru_pvec, page)) {
+			cond_resched();
 			__pagevec_lru_add(&lru_pvec);
+		}
 		if (ret) {
 			while (!list_empty(pages)) {
 				struct page *victim;
@@ -184,8 +186,10 @@ static int read_pages(struct address_spa
 					page->index, GFP_KERNEL)) {
 			ret = mapping->a_ops->readpage(filp, page);
 			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
+				if (!pagevec_add(&lru_pvec, page)) {
+					cond_resched();
 					__pagevec_lru_add(&lru_pvec);
+				}
 				continue;
 			} /* else fall through to release */
 		}
@@ -299,6 +303,7 @@ __do_page_cache_readahead(struct address
 			continue;
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
--- linux-2.6.16-rc6-mm2.orig/fs/mpage.c
+++ linux-2.6.16-rc6-mm2/fs/mpage.c
@@ -407,8 +407,10 @@ mpage_readpages(struct address_space *ma
 					&last_block_in_bio, &map_bh,
 					&first_logical_block,
 					get_block);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
+				cond_resched();
 				__pagevec_lru_add(&lru_pvec);
+			}
 		} else {
 			page_cache_release(page);
 		}

--
