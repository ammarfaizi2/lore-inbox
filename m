Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKSQl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKSQl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 11:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVKSQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 11:41:58 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:5027 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1750711AbVKSQl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 11:41:57 -0500
Subject: [Patch 1/2] 2.6.15-rc1-mm2: disabling the pagecache for doing
	benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 17:41:27 +0100
Message-Id: <1132418487.11657.15.camel@home.sweethome>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in the do_generic-mapping_read function...



Signed-off-by: Dirk Gerdes
--


--- linux-2.6.15-rc1-mm2/mm/filemap.c	2005-11-19 12:31:43.000000000
+0100
+++ linux-2.6.15-rc1-mm2-pagecache/mm/filemap.c	2005-11-19 13:29:44.000000000 +0100
@@ -738,6 +738,55 @@ grab_cache_page_nowait(struct address_sp
 
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
+
+
+
+void make_page_not_uptodate(struct page *page)
+{
+        struct buffer_head *bh, *first;
+	//printk("make_page_not_uptodate_called\n");
+        lock_page(page);
+        if(!PageDirty(page)){
+                ClearPageUptodate(page);
+                if (page_has_buffers(page)){
+                        bh = page_buffers(page);
+                        first = bh;
+                        do{
+                                lock_buffer(bh);
+                                if(!buffer_dirty(bh)){
+                                        clear_buffer_uptodate(bh);
+                                }
+                      		unlock_buffer(bh);
+
+                                bh=bh->b_this_page;
+
+                        }while(bh != first);
+                }
+        }
+        unlock_page(page);
+        release_pages(&page, 1, 0);
+}
+
+int pagecache = 1;      // bool pagecache on / off
+                        // 1 : on
+			// 2 : off
+EXPORT_SYMBOL(pagecache);
+
+
+
 /*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
@@ -765,6 +814,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+        struct page *foundpage = NULL;
 	int error;
 	struct file_ra_state ra = *_ra;
 
@@ -780,6 +830,17 @@ void do_generic_mapping_read(struct addr
 		goto out;
 
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+
+/**
+if the needed page is in Page Cache its PageUptodate-Bit is cleared, so it have to be read again
+*/
+	if (pagecache == 0){
+		foundpage = find_get_page(mapping,index);
+		if (foundpage != NULL){
+			make_page_not_uptodate(foundpage);
+		}
+	}
+
 	for (;;) {
 		struct page *page;
 		unsigned long nr, ret;
@@ -797,9 +858,12 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
-			next_index = page_cache_readahead(mapping, &ra, filp,
-					index, last_index - index);
+
+/**page_cache_readahead should only be used, if pagecache is activated */
+                if (pagecache){
+			if (index == next_index)
+				next_index = page_cache_readahead(mapping, &ra, filp,index, last_index - index);
+		}
 
 find_page:
 		page = find_get_page(mapping, index);
@@ -842,8 +906,15 @@ page_ok:
 		offset &= ~PAGE_CACHE_MASK;
 
 		page_cache_release(page);
-		if (ret == nr && desc->count)
+		if (ret == nr && desc->count){
+			if (pagecache == 0){
+                                foundpage = find_get_page(mapping,index);
+                                if (foundpage != NULL){
+                                        make_page_not_uptodate(foundpage);
+                                }
+                        }
 			continue;
+		}
 		goto out;
 
 page_not_up_to_date:

