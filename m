Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKIOPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKIOPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKIOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:15:24 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:62848 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750827AbVKIOPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:15:11 -0500
Message-Id: <20051109141554.307245000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:54 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 16/16] io: reduce lantency
Content-Disposition: inline; filename=io-low-delay.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is recommended by Con Kolivas to improve respond time for desktop.

Since the VM_MAX_READAHEAD is greatly enlarged, it may be necessary to insert
some cond_resched() calls. Correct me, I'm not quite sure about the effects.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 fs/mpage.c     |    4 +++-
 mm/readahead.c |    5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -582,8 +582,10 @@ static int read_pages(struct address_spa
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
 			mapping->a_ops->readpage(filp, page);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
 				__pagevec_lru_add(&lru_pvec);
+				cond_resched();
+			}
 		} else {
 			page_cache_release(page);
 		}
@@ -701,6 +703,7 @@ __do_page_cache_readahead(struct address
 		}
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
--- linux-2.6.14-mm1.orig/fs/mpage.c
+++ linux-2.6.14-mm1/fs/mpage.c
@@ -343,8 +343,10 @@ mpage_readpages(struct address_space *ma
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
 					&last_block_in_bio, get_block);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
 				__pagevec_lru_add(&lru_pvec);
+				cond_resched();
+			}
 		} else {
 			page_cache_release(page);
 		}

--
