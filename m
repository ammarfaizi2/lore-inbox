Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHIUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHIUUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHIUUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:20:31 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:18247 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S1751145AbWHIUU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:20:29 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net
Subject: [PATCH] not empty pages list after fuse_readpages
Date: Thu, 10 Aug 2006 00:20:29 +0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608100020.29880.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (493/060809)
X-SpamTest-Info: Profile: Detect Standard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

fuse_readpages looks buggy for me because it doesn't care 
about making the @pages list empty at exit.

If it is indeed a bug, I suggest the following patch:

don't let fuse_readpages leave the @pages list not empty
when exiting on error.

Signed-off-by: Alexander Zarochentsev <zam@namesys.com>
---
 fs/fuse/file.c          |   15 +++++++++++----
 include/linux/pagemap.h |    1 +
 mm/readahead.c          |   24 +++++++++++++++++-------
 3 files changed, 29 insertions(+), 11 deletions(-)

--- linux-2.6-git.orig/fs/fuse/file.c
+++ linux-2.6-git/fs/fuse/file.c
@@ -395,14 +395,18 @@ static int fuse_readpages(struct file *f
 	struct fuse_readpages_data data;
 	int err;
 
-	if (is_bad_inode(inode))
-		return -EIO;
+	if (is_bad_inode(inode)) {
+		err = -EIO;
+		goto clean_pages_up;
+	}
 
 	data.file = file;
 	data.inode = inode;
 	data.req = fuse_get_req(fc);
-	if (IS_ERR(data.req))
-		return PTR_ERR(data.req);
+	if (IS_ERR(data.req)) {
+		err = PTR_ERR(data.req);
+		goto clean_pages_up;
+	}
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
 	if (!err) {
@@ -411,6 +415,10 @@ static int fuse_readpages(struct file *f
 		else
 			fuse_put_request(fc, data.req);
 	}
+	if (0) {
+clean_pages_up:
+		readpages_cleanup_helper(pages);
+	}
 	return err;
 }
 
--- linux-2.6-git.orig/include/linux/pagemap.h
+++ linux-2.6-git/include/linux/pagemap.h
@@ -100,6 +100,7 @@ extern struct page * read_cache_page(str
 				void *data);
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
+extern void readpages_cleanup_helper(struct list_head *);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 					     unsigned long index, void *data)
--- linux-2.6-git.orig/mm/readahead.c
+++ linux-2.6-git/mm/readahead.c
@@ -229,6 +229,22 @@ static inline unsigned long get_next_ra_
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
@@ -260,13 +276,7 @@ int read_cache_pages(struct address_spac
 			__pagevec_lru_add(&lru_pvec);
 		}
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


