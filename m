Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWELGIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWELGIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWELGIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:14791 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750951AbWELGIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:08:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:53 +1000
Message-Id: <1060512060753.8049@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 005 of 8] md/bitmap: Remove unnecessary page reference manipulations from md/bitmap code.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md/bitmap gets a collection of pages representing the bitmap when it
initialises the bitmap, and puts all the references when discarding
the bitmap.

It also occasionally takes extra references without any good reason,
and sometimes drops them ... though it doesn't always drop them, which
can result in a memory leak.

This patch removes the unnecessary 'get_page' calls, and the
corresponding 'put_page' calls.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 15:58:22.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 15:58:57.000000000 +1000
@@ -332,7 +332,6 @@ static int write_page(struct bitmap *bit
 		/* add to list to be waited for */
 		struct page_list *item = mempool_alloc(bitmap->write_pool, GFP_NOIO);
 		item->page = page;
-		get_page(page);
 		spin_lock(&bitmap->write_lock);
 		list_add(&item->list, &bitmap->complete_pages);
 		spin_unlock(&bitmap->write_lock);
@@ -548,7 +547,6 @@ static void bitmap_mask_state(struct bit
 		spin_unlock_irqrestore(&bitmap->lock, flags);
 		return;
 	}
-	get_page(bitmap->sb_page);
 	spin_unlock_irqrestore(&bitmap->lock, flags);
 	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
 	switch (op) {
@@ -559,7 +557,6 @@ static void bitmap_mask_state(struct bit
 		default: BUG();
 	}
 	kunmap_atomic(sb, KM_USER0);
-	put_page(bitmap->sb_page);
 }
 
 /*
@@ -641,7 +638,6 @@ static void drain_write_queues(struct bi
 
 	while ((item = dequeue_page(bitmap))) {
 		/* don't bother to wait */
-		put_page(item->page);
 		mempool_free(item, bitmap->write_pool);
 	}
 }
@@ -744,11 +740,6 @@ static void bitmap_file_set_bit(struct b
 	page = filemap_get_page(bitmap, chunk);
 	bit = file_page_offset(chunk);
 
-
-	/* make sure the page stays cached until it gets written out */
-	if (! test_page_attr(bitmap, page, BITMAP_PAGE_DIRTY))
-		get_page(page);
-
  	/* set the bit */
 	kaddr = kmap_atomic(page, KM_USER0);
 	if (bitmap->flags & BITMAP_HOSTENDIAN)
@@ -1028,10 +1019,9 @@ int bitmap_daemon_work(struct bitmap *bi
 			if (!test_page_attr(bitmap, page, BITMAP_PAGE_CLEAN)) {
 				int need_write = test_page_attr(bitmap, page,
 								BITMAP_PAGE_NEEDWRITE);
-				if (need_write) {
-					get_page(page);
+				if (need_write)
 					clear_page_attr(bitmap, page, BITMAP_PAGE_NEEDWRITE);
-				}
+
 				spin_unlock_irqrestore(&bitmap->lock, flags);
 				if (need_write) {
 					switch (write_page(bitmap, page, 0)) {
@@ -1043,13 +1033,11 @@ int bitmap_daemon_work(struct bitmap *bi
 					default:
 						bitmap_file_kick(bitmap);
 					}
-					put_page(page);
 				}
 				continue;
 			}
 
 			/* grab the new page, sync and release the old */
-			get_page(page);
 			if (lastpage != NULL) {
 				if (test_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE)) {
 					clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
@@ -1063,7 +1051,6 @@ int bitmap_daemon_work(struct bitmap *bi
 					set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 					spin_unlock_irqrestore(&bitmap->lock, flags);
 				}
-				put_page(lastpage);
 				if (err)
 					bitmap_file_kick(bitmap);
 			} else
@@ -1117,8 +1104,6 @@ int bitmap_daemon_work(struct bitmap *bi
 			set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
 			spin_unlock_irqrestore(&bitmap->lock, flags);
 		}
-
-		put_page(lastpage);
 	}
 
 	return err;
@@ -1140,7 +1125,6 @@ static void bitmap_writeback(struct bitm
 		PRINTK("finished page writeback: %p\n", page);
 
 		err = PageError(page);
-		put_page(page);
 		if (err) {
 			printk(KERN_WARNING "%s: bitmap file writeback "
 			       "failed (page %lu): %d\n",
