Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWHJH5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWHJH5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWHJH5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:57:46 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:19636 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1161119AbWHJH5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:57:45 -0400
To: akpm@osdl.org, zam@namesys.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix error case in fuse_readpages
Message-Id: <E1GB5Pu-0002TI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 10 Aug 2006 09:57:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alex.

-mm also needs s/page_cache_release/read_cache_pages_release_page/ on patch

--
From: Alexander Zarochentsev <zam@namesys.com>

Don't let fuse_readpages leave the @pages list not empty when exiting
on error.

Signed-off-by: Alexander Zarochentsev <zam@namesys.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-08-10 09:41:12.000000000 +0200
+++ linux/fs/fuse/file.c	2006-08-10 09:43:36.000000000 +0200
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
+	readpages_cleanup_helper(pages);
+	return err;
 }
 
 static size_t fuse_send_write(struct fuse_req *req, struct file *file,
Index: linux/include/linux/pagemap.h
===================================================================
--- linux.orig/include/linux/pagemap.h	2006-08-10 09:41:14.000000000 +0200
+++ linux/include/linux/pagemap.h	2006-08-10 09:42:33.000000000 +0200
@@ -98,6 +98,7 @@ extern struct page * read_cache_page(str
 				void *data);
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
+extern void readpages_cleanup_helper(struct list_head *);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 					     unsigned long index, void *data)
Index: linux/mm/readahead.c
===================================================================
--- linux.orig/mm/readahead.c	2006-08-10 09:41:14.000000000 +0200
+++ linux/mm/readahead.c	2006-08-10 09:42:33.000000000 +0200
@@ -118,6 +118,22 @@ static inline unsigned long get_next_ra_
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
 /**
+ * may be useful in foo_fs_readpages method for the page pool cleanup
+ * before exiting on error.
+ */
+void readpages_cleanup_helper(struct list_head *pages)
+{
+	while (!list_empty(pages)) {
+		struct page *victim;
+
+		victim = list_to_page(pages);
+		list_del(&victim->lru);
+		page_cache_release(victim);
+	}
+}
+EXPORT_SYMBOL(readpages_cleanup_helper);
+
+/**
  * read_cache_pages - populate an address space with some pages & start reads against them
  * @mapping: the address_space
  * @pages: The address of a list_head which contains the target pages.  These
@@ -147,13 +163,7 @@ int read_cache_pages(struct address_spac
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
+			readpages_cleanup_helper(pages);
 			break;
 		}
 	}
