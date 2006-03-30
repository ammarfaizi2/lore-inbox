Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWC3NTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWC3NTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWC3NTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:19:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932202AbWC3NTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:19:07 -0500
Date: Thu, 30 Mar 2006 15:19:15 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, nickpiggin@yahoo.com.au
Subject: [PATCH] splice SPLICE_F_MOVE support
Message-ID: <20060330131915.GJ13476@suse.de>
References: <20060330131530.GI13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330131530.GI13476@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This applies on top of the splice #3 just posted, adding support for
moving of pages. The caller can use the SPLICE_F_MOVE flag to the splice
syscall to ask the kernel to try and move pages, if needed.

Disclaimer: this works for me, but may have vm issues that I missed.
CC'ing Nick :-)

---

From: Jens Axboe <axboe@suse.de>
Date: Thu Mar 30 15:16:46 2006 +0200
Subject: [PATCH] splice: add support for SPLICE_F_MOVE flag

This enables the caller to migrate pages from one address space page
cache to another. In buzz word marketing, you can do zero-copy file copies!

Signed-off-by: Jens Axboe <axboe@suse.de>

---

 fs/pipe.c                 |    8 +++
 fs/splice.c               |  121 +++++++++++++++++++++++++++++++--------------
 include/linux/pipe_fs_i.h |    8 +++
 3 files changed, 100 insertions(+), 37 deletions(-)

54facc65189d86f4b8b7eb9be5c0c5623090483d
diff --git a/fs/pipe.c b/fs/pipe.c
index 2414bf2..109a102 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -121,11 +121,19 @@ static void anon_pipe_buf_unmap(struct p
 	kunmap(buf->page);
 }
 
+static int anon_pipe_buf_steal(struct pipe_inode_info *info,
+			       struct pipe_buffer *buf)
+{
+	buf->stolen = 1;
+	return 0;
+}
+
 static struct pipe_buf_operations anon_pipe_buf_ops = {
 	.can_merge = 1,
 	.map = anon_pipe_buf_map,
 	.unmap = anon_pipe_buf_unmap,
 	.release = anon_pipe_buf_release,
+	.steal = anon_pipe_buf_steal,
 };
 
 static ssize_t
diff --git a/fs/splice.c b/fs/splice.c
index efa47c1..4a026f9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -21,6 +21,7 @@ #include <linux/file.h>
 #include <linux/pagemap.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/mm_inline.h>
+#include <linux/swap.h>
 
 /*
  * Passed to the actors
@@ -32,11 +33,37 @@ struct splice_desc {
 	loff_t pos;			/* file position */
 };
 
+static int page_cache_pipe_buf_steal(struct pipe_inode_info *info,
+				     struct pipe_buffer *buf)
+{
+	struct page *page = buf->page;
+
+	WARN_ON(!PageLocked(page));
+	WARN_ON(!PageUptodate(page));
+
+	if (!remove_mapping(page_mapping(page), page))
+		return 1;
+
+	if (PageLRU(page)) {
+		struct zone *zone = page_zone(page);
+
+		spin_lock_irq(&zone->lru_lock);
+		BUG_ON(!PageLRU(page));
+		__ClearPageLRU(page);
+		del_page_from_lru(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	buf->stolen = 1;
+	return 0;
+}
+
 static void page_cache_pipe_buf_release(struct pipe_inode_info *info,
 					struct pipe_buffer *buf)
 {
 	page_cache_release(buf->page);
 	buf->page = NULL;
+	buf->stolen = 0;
 }
 
 static void *page_cache_pipe_buf_map(struct file *file,
@@ -63,7 +90,8 @@ static void *page_cache_pipe_buf_map(str
 static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
 				      struct pipe_buffer *buf)
 {
-	unlock_page(buf->page);
+	if (!buf->stolen)
+		unlock_page(buf->page);
 	kunmap(buf->page);
 }
 
@@ -72,6 +100,7 @@ static struct pipe_buf_operations page_c
 	.map = page_cache_pipe_buf_map,
 	.unmap = page_cache_pipe_buf_unmap,
 	.release = page_cache_pipe_buf_release,
+	.steal = page_cache_pipe_buf_steal,
 };
 
 static ssize_t move_to_pipe(struct inode *inode, struct page **pages,
@@ -336,8 +365,8 @@ static int pipe_to_file(struct pipe_inod
 	struct address_space *mapping = file->f_mapping;
 	unsigned int offset;
 	struct page *page;
-	char *src, *dst;
 	pgoff_t index;
+	char *src;
 	int ret;
 
 	/*
@@ -350,40 +379,54 @@ static int pipe_to_file(struct pipe_inod
 	index = sd->pos >> PAGE_CACHE_SHIFT;
 	offset = sd->pos & ~PAGE_CACHE_MASK;
 
-find_page:
-	ret = -ENOMEM;
-	page = find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
-	if (!page)
-		goto out;
-
 	/*
-	 * If the page is uptodate, it is also locked. If it isn't
-	 * uptodate, we can mark it uptodate if we are filling the
-	 * full page. Otherwise we need to read it in first...
+	 * reuse buf page, if SPLICE_F_MOVE is set
 	 */
-	if (!PageUptodate(page)) {
-		if (sd->len < PAGE_CACHE_SIZE) {
-			ret = mapping->a_ops->readpage(file, page);
-			if (unlikely(ret))
-				goto out;
-
-			lock_page(page);
-
-			if (!PageUptodate(page)) {
-				/*
-				 * page got invalidated, repeat
-				 */
-				if (!page->mapping) {
-					unlock_page(page);
-					page_cache_release(page);
-					goto find_page;
+	if (sd->flags & SPLICE_F_MOVE) {
+		if (buf->ops->steal(info, buf))
+			goto find_page;
+
+		page = buf->page;
+		if (add_to_page_cache_lru(page, mapping, index,
+						mapping_gfp_mask(mapping)))
+			goto find_page;
+	} else {
+find_page:
+		ret = -ENOMEM;
+		page = find_or_create_page(mapping, index,
+						mapping_gfp_mask(mapping));
+		if (!page)
+			goto out;
+
+		/*
+		 * If the page is uptodate, it is also locked. If it isn't
+		 * uptodate, we can mark it uptodate if we are filling the
+		 * full page. Otherwise we need to read it in first...
+		 */
+		if (!PageUptodate(page)) {
+			if (sd->len < PAGE_CACHE_SIZE) {
+				ret = mapping->a_ops->readpage(file, page);
+				if (unlikely(ret))
+					goto out;
+
+				lock_page(page);
+
+				if (!PageUptodate(page)) {
+					/*
+					 * page got invalidated, repeat
+					 */
+					if (!page->mapping) {
+						unlock_page(page);
+						page_cache_release(page);
+						goto find_page;
+					}
+					ret = -EIO;
+					goto out;
 				}
-				ret = -EIO;
-				goto out;
+			} else {
+				WARN_ON(!PageLocked(page));
+				SetPageUptodate(page);
 			}
-		} else {
-			WARN_ON(!PageLocked(page));
-			SetPageUptodate(page);
 		}
 	}
 
@@ -391,10 +434,13 @@ find_page:
 	if (ret)
 		goto out;
 
-	dst = kmap_atomic(page, KM_USER0);
-	memcpy(dst + offset, src + buf->offset, sd->len);
-	flush_dcache_page(page);
-	kunmap_atomic(dst, KM_USER0);
+	if (!buf->stolen) {
+		char *dst = kmap_atomic(page, KM_USER0);
+
+		memcpy(dst + offset, src + buf->offset, sd->len);
+		flush_dcache_page(page);
+		kunmap_atomic(dst, KM_USER0);
+	}
 
 	ret = mapping->a_ops->commit_write(file, page, 0, sd->len);
 	if (ret < 0)
@@ -405,7 +451,8 @@ find_page:
 out:
 	if (ret < 0)
 		unlock_page(page);
-	page_cache_release(page);
+	if (!buf->stolen)
+		page_cache_release(page);
 	buf->ops->unmap(info, buf);
 	return ret;
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index b12e59c..75c7f55 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -9,6 +9,7 @@ struct pipe_buffer {
 	struct page *page;
 	unsigned int offset, len;
 	struct pipe_buf_operations *ops;
+	unsigned int stolen;
 };
 
 struct pipe_buf_operations {
@@ -16,6 +17,7 @@ struct pipe_buf_operations {
 	void * (*map)(struct file *, struct pipe_inode_info *, struct pipe_buffer *);
 	void (*unmap)(struct pipe_inode_info *, struct pipe_buffer *);
 	void (*release)(struct pipe_inode_info *, struct pipe_buffer *);
+	int (*steal)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
 struct pipe_inode_info {
@@ -52,5 +54,11 @@ void pipe_wait(struct inode * inode);
 
 struct inode* pipe_new(struct inode* inode);
 void free_pipe_info(struct inode* inode);
+
+/*
+ * splice is tied to pipes as a transport (at least for now), so we'll just
+ * add the splice flags here.
+ */
+#define SPLICE_F_MOVE	(0x01)	/* move pages instead of copying */
 
 #endif
-- 
1.3.0.rc1.g384e


-- 
Jens Axboe

