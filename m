Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWEXLZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWEXLZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWEXLTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:09 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:42368 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932690AbWEXLTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:02 -0400
Message-ID: <348469539.16036@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111900.419314658@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:53 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Con Kolivas <kernel@kolivas.org>
Subject: [PATCH 07/33] readahead: insert cond_resched() calls
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
---


This patch is recommended by Con Kolivas to improve respond time for desktop.
Thanks!

 fs/mpage.c     |    4 +++-
 mm/readahead.c |    9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -146,8 +146,10 @@ int read_cache_pages(struct address_spac
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
@@ -297,6 +301,7 @@ __do_page_cache_readahead(struct address
 			continue;
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
--- linux-2.6.17-rc4-mm3.orig/fs/mpage.c
+++ linux-2.6.17-rc4-mm3/fs/mpage.c
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
