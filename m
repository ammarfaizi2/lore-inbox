Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966308AbWKNULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966308AbWKNULX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966311AbWKNUJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966309AbWKNUJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:14 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/19] CacheFiles: Add a function to write a single page of data to an inode
Date: Tue, 14 Nov 2006 20:06:39 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200638.12943.61731.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to write one single whole page of data to an inode at a
page-aligned location (thus permitting the function to be highly optimised).
The function uses the prepare_write() and commit_write() address_space
operations to bound the actual write.

This is used by CacheFiles to store the contents of netfs pages into their
backing file pages.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/fs.h |    2 +
 mm/filemap.c       |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..2bb027f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1748,6 +1748,8 @@ extern ssize_t generic_file_direct_write
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern int generic_file_buffered_write_one_kernel_page(struct address_space *,
+						       pgoff_t, struct page *);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1b73d3a..b9eb8b2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2236,6 +2236,93 @@ zero_length_segment:
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
 
+/**
+ * generic_file_buffered_write_one_kernel_page - Write a single page of data to
+ * an inode
+ * @mapping - The address space of the target inode
+ * @index - The target page in the target inode to fill
+ * @source - The data to write into the target page
+ *
+ * Write the data from the source page to the page in the nominated address
+ * space at the @index specified
+ *
+ * The @source page does not need to have any association with the file or the
+ * target page offset
+ */
+int
+generic_file_buffered_write_one_kernel_page(struct address_space *mapping,
+					    pgoff_t index,
+					    struct page *source)
+{
+	const struct address_space_operations *a_ops = mapping->a_ops;
+	struct pagevec	lru_pvec;
+	struct page *page, *cached_page = NULL;
+	long status = 0;
+
+	pagevec_init(&lru_pvec, 0);
+
+	page = __grab_cache_page(mapping, index, &cached_page, &lru_pvec);
+	if (!page) {
+		BUG_ON(cached_page);
+		return -ENOMEM;
+	}
+
+	status = a_ops->prepare_write(NULL, page, 0, PAGE_CACHE_SIZE);
+	if (unlikely(status)) {
+		loff_t isize = i_size_read(mapping->host);
+
+		if (status != AOP_TRUNCATED_PAGE)
+			unlock_page(page);
+		page_cache_release(page);
+		if (status == AOP_TRUNCATED_PAGE)
+			goto sync;
+
+		/* prepare_write() may have instantiated a few blocks outside
+		 * i_size.  Trim these off again.
+		 */
+		if ((1ULL << (index + 1)) > isize)
+			vmtruncate(mapping->host, isize);
+		goto sync;
+	}
+
+	copy_highpage(page, source);
+	flush_dcache_page(page);
+
+	status = a_ops->commit_write(NULL, page, 0, PAGE_CACHE_SIZE);
+	if (status == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto sync;
+	}
+
+	if (status > 0)
+		status = 0;
+
+	unlock_page(page);
+	mark_page_accessed(page);
+	page_cache_release(page);
+	if (status < 0)
+		return status;
+
+	balance_dirty_pages_ratelimited(mapping);
+	cond_resched();
+
+sync:
+	if (cached_page)
+		page_cache_release(cached_page);
+
+	/* the caller must handle O_SYNC themselves, but we handle S_SYNC and
+	 * MS_SYNCHRONOUS here */
+	if (unlikely(IS_SYNC(mapping->host)) && !a_ops->writepage)
+		status = generic_osync_inode(mapping->host, mapping,
+					     OSYNC_METADATA | OSYNC_DATA);
+
+	/* the caller must handle O_DIRECT for themselves */
+
+	pagevec_lru_add(&lru_pvec);
+	return status;
+}
+EXPORT_SYMBOL(generic_file_buffered_write_one_kernel_page);
+
 static ssize_t
 __generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
