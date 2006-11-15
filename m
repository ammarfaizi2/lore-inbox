Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWKOHwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWKOHwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966409AbWKOHvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:08 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31949 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755480AbWKOHuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:37 -0500
Message-ID: <363577022.21912@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075026.121499794@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 06/28] readahead: insert cond_resched() calls
Content-Disposition: inline; filename=readahead-insert-cond_resched-calls.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm more
complex, it becomes necessary to insert some cond_resched() calls in
the read-ahead path.

If desktop users still feel audio jitters with the new read-ahead code,
please try one of the following ways to get rid of it:

1) compile kernel with CONFIG_PREEMPT_VOLUNTARY/CONFIG_PREEMPT
2) reduce the read-ahead request size by running
	blockdev --setra 256 /dev/hda # or whatever device you are using

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/fs/mpage.c
+++ linux-2.6.19-rc5-mm2/fs/mpage.c
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
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -182,8 +182,10 @@ int read_cache_pages(struct address_spac
 			continue;
 		}
 		ret = filler(data, page);
-		if (!pagevec_add(&lru_pvec, page))
+		if (!pagevec_add(&lru_pvec, page)) {
+			cond_resched();
 			__pagevec_lru_add(&lru_pvec);
+		}
 		if (ret) {
 			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
@@ -216,8 +218,10 @@ static int read_pages(struct address_spa
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
 			mapping->a_ops->readpage(filp, page);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
+				cond_resched();
 				__pagevec_lru_add(&lru_pvec);
+			}
 		} else
 			page_cache_release(page);
 	}
@@ -330,6 +334,7 @@ __do_page_cache_readahead(struct address
 
 		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
+		cond_resched();
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;

--
