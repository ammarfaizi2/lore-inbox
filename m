Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWHJJ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWHJJ3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWHJJ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:29:21 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:34991 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751445AbWHJJ3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:29:20 -0400
To: akpm@osdl.org
CC: zam@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH try #2] fuse: fix error case in fuse_readpages
Message-Id: <E1GB6qO-0003qU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 10 Aug 2006 11:28:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zarochentsev <zam@namesys.com>

Don't let fuse_readpages leave the @pages list not empty when exiting
on error.

Signed-off-by: Alexander Zarochentsev <zam@namesys.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-08-10 09:41:12.000000000 +0200
+++ linux/fs/fuse/file.c	2006-08-10 11:13:35.000000000 +0200
@@ -395,14 +395,16 @@ static int fuse_readpages(struct file *f
 	struct fuse_readpages_data data;
 	int err;
 
+	err = -EIO;
 	if (is_bad_inode(inode))
-		return -EIO;
+		goto clean_pages_up;
 
 	data.file = file;
 	data.inode = inode;
 	data.req = fuse_get_req(fc);
+	err = PTR_ERR(data.req);
 	if (IS_ERR(data.req))
-		return PTR_ERR(data.req);
+		goto clean_pages_up;
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
 	if (!err) {
@@ -412,6 +414,10 @@ static int fuse_readpages(struct file *f
 			fuse_put_request(fc, data.req);
 	}
 	return err;
+
+clean_pages_up:
+	put_pages_list(pages);
+	return err;
 }
 
 static size_t fuse_send_write(struct fuse_req *req, struct file *file,
Index: linux/mm/readahead.c
===================================================================
--- linux.orig/mm/readahead.c	2006-08-10 09:41:14.000000000 +0200
+++ linux/mm/readahead.c	2006-08-10 11:12:27.000000000 +0200
@@ -147,13 +147,7 @@ int read_cache_pages(struct address_spac
 		if (!pagevec_add(&lru_pvec, page))
 			__pagevec_lru_add(&lru_pvec);
 		if (ret) {
-			while (!list_empty(pages)) {
-				struct page *victim;
-
-				victim = list_to_page(pages);
-				list_del(&victim->lru);
-				page_cache_release(victim);
-			}
+			put_pages_list(pages);
 			break;
 		}
 	}
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h	2006-08-10 11:06:05.000000000 +0200
+++ linux/include/linux/mm.h	2006-08-10 11:12:46.000000000 +0200
@@ -336,6 +336,7 @@ static inline void init_page_count(struc
 }
 
 void put_page(struct page *page);
+void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 
Index: linux/mm/swap.c
===================================================================
--- linux.orig/mm/swap.c	2006-08-10 11:02:34.000000000 +0200
+++ linux/mm/swap.c	2006-08-10 11:18:59.000000000 +0200
@@ -54,6 +54,24 @@ void put_page(struct page *page)
 }
 EXPORT_SYMBOL(put_page);
 
+/**
+ * Release page list.  Currently used by read_cache_pages() and related
+ * cleanup code.
+ *
+ * @pages: list of pages threaded on page->lru
+ */
+void put_pages_list(struct list_head *pages)
+{
+	while (!list_empty(pages)) {
+		struct page *victim;
+
+		victim = list_entry(pages->prev, struct page, lru);
+		list_del(&victim->lru);
+		page_cache_release(victim);
+	}
+}
+EXPORT_SYMBOL(put_pages_list);
+
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
