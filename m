Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWFTQly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFTQly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFTQly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:41:54 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:63498 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S1751405AbWFTQlx (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:41:53 -0400
Subject: Re: batched write
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, dgc@sgi.com, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060620002659.08aee963.akpm@osdl.org>
References: <20060524175312.GA3579@zero> <44749E24.40203@namesys.com>
	 <20060608110044.GA5207@suse.de>
	 <1149766000.6336.29.camel@tribesman.namesys.com>
	 <20060608121006.GA8474@infradead.org>
	 <1150322912.6322.129.camel@tribesman.namesys.com>
	 <20060617100458.0be18073.akpm@osdl.org>
	 <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com>
	 <20060619185049.GH5817@schatzie.adilger.int>
	 <20060620000133.GB8770394@melbourne.sgi.com> <4497A17C.50804@namesys.com>
	 <20060620002659.08aee963.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-s5QIN7z4J9TTdtu41ngl"
Date: Tue, 20 Jun 2006 20:26:44 +0400
Message-Id: <1150820804.6447.45.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s5QIN7z4J9TTdtu41ngl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Tue, 2006-06-20 at 00:26 -0700, Andrew Morton wrote:
> On Tue, 20 Jun 2006 00:19:24 -0700
> Hans Reiser <reiser@namesys.com> wrote:
> 
> > So far we have XFS, FUSE, and reiser4 benefiting from the potential
> > ability to process more than 4k at a time.  Is it enough?
> 
> Spose so.  Let's see what the diff looks like?
> 
ok, the first draft version for evaluation is here.

--=-s5QIN7z4J9TTdtu41ngl
Content-Disposition: attachment; filename=batched-write.patch
Content-Type: text/x-patch; name=batched-write.patch; charset=utf-8
Content-Transfer-Encoding: 7bit


This patch adds a method fill_pages to struct address_space_operations.
A filesystem may want to implement this operation to improve write performance.
Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
it writes one page using prepare_write and commit_write address space operations.

NOTE: just for evaluation, compiliable only yet. 



diff -puN mm/filemap.c~batched-write mm/filemap.c
--- linux-2.6.17-rc6-mm2/mm/filemap.c~batched-write	2006-06-12 16:06:43.000000000 +0400
+++ linux-2.6.17-rc6-mm2-vs/mm/filemap.c	2006-06-20 19:52:53.000000000 +0400
@@ -2093,68 +2093,78 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+typedef size_t (*write_actor_t)(struct page *, unsigned long, size_t,
+				const write_descriptor_t *);
+struct write_descriptor {
+	loff_t pos;
+	size_t count;
+	const struct iovec *cur_iov;	/* current iovec */
+	size_t iov_base;		/* offset in the current iovec */
+	char __user *buf;
+	write_actor_t actor;
+};
+
+static size_t write_actor(struct page *page, unsigned long offset, size_t bytes,
+			  const write_descriptor_t *desc)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
-	struct inode 	*inode = mapping->host;
-	long		status = 0;
-	struct page	*page;
-	struct page	*cached_page = NULL;
-	size_t		bytes;
-	struct pagevec	lru_pvec;
-	const struct iovec *cur_iov = iov; /* current iovec */
-	size_t		iov_base = 0;	   /* offset in the current iovec */
-	char __user	*buf;
+	return filemap_copy_from_user(page, offset, desc->buf, bytes);
+}
 
-	pagevec_init(&lru_pvec, 0);
+static size_t write_iovec_actor(struct page *page, unsigned long offset,
+				size_t bytes, const write_descriptor_t *desc)
+{
+	return filemap_copy_from_user_iovec(page, offset, desc->cur_iov,
+					    desc->iov_base, bytes);
+}
+
+/**
+ * generic_fill_pages
+ * @file:
+ * @desc:
+ * @lru_pvec:
+ * @cached_page:
+ * @copied:
+ *
+ * Number of bytes written is returned via @copied.
+ */
+long generic_fill_pages(struct file *file, const write_descriptor_t *desc,
+			struct pagevec *lru_pvec, struct page **cached_page,
+			size_t *copied)
+{
+	const struct address_space_operations *a_ops = file->f_mapping->a_ops;
+	struct page *page;
+	unsigned long index;
+	size_t bytes;
+	unsigned long offset;
+	unsigned long maxlen;
+	long status;
+
+	offset = (desc->pos & (PAGE_CACHE_SIZE - 1)); /* Within page */
+	index = desc->pos >> PAGE_CACHE_SHIFT;
+	bytes = PAGE_CACHE_SIZE - offset;
+	if (bytes > desc->count)
+		bytes = desc->count;
 
 	/*
-	 * handle partial DIO write.  Adjust cur_iov if needed.
+	 * Bring in the user page that we will copy from _first_.
+	 * Otherwise there's a nasty deadlock on copying from the same
+	 * page as we're writing to, without it being marked
+	 * up-to-date.
 	 */
-	if (likely(nr_segs == 1))
-		buf = iov->iov_base + written;
-	else {
-		filemap_set_next_iovec(&cur_iov, &iov_base, written);
-		buf = cur_iov->iov_base + iov_base;
-	}
-
-	do {
-		unsigned long index;
-		unsigned long offset;
-		unsigned long maxlen;
-		size_t copied;
-
-		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
-		index = pos >> PAGE_CACHE_SHIFT;
-		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
-			bytes = count;
-
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 */
-		maxlen = cur_iov->iov_len - iov_base;
-		if (maxlen > bytes)
-			maxlen = bytes;
-		fault_in_pages_readable(buf, maxlen);
-
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
-		}
+	maxlen = desc->cur_iov->iov_len - desc->iov_base;
+	if (maxlen > bytes)
+		maxlen = bytes;
+
+	while (1) {
+		fault_in_pages_readable(desc->buf, maxlen);
+
+		page = __grab_cache_page(file->f_mapping, index, cached_page, lru_pvec);
+		if (!page)
+			return -ENOMEM;
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
+			loff_t isize = i_size_read(file->f_mapping->host);
 
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
@@ -2162,51 +2172,87 @@ generic_file_buffered_write(struct kiocb
 			if (status == AOP_TRUNCATED_PAGE)
 				continue;
 			/*
-			 * prepare_write() may have instantiated a few blocks
-			 * outside i_size.  Trim these off again.
+			 * prepare_write() may have instantiated a few
+			 * blocks outside i_size.  Trim these off
+			 * again.
 			 */
-			if (pos + bytes > isize)
-				vmtruncate(inode, isize);
-			break;
+			if (desc->pos + bytes > isize)
+				vmtruncate(file->f_mapping->host, isize);
+			return status;
 		}
-		if (likely(nr_segs == 1))
-			copied = filemap_copy_from_user(page, offset,
-							buf, bytes);
-		else
-			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_base, bytes);
+
+		*copied = desc->actor(page, offset, bytes, desc);
+
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
 			page_cache_release(page);
 			continue;
 		}
-		if (likely(copied > 0)) {
-			if (!status)
-				status = copied;
 
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
-					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_base;
-				} else {
-					iov_base += status;
-				}
-			}
-		}
-		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
+		break;
+	}
+	if (status)
+		*copied = 0;
+	else if (*copied != bytes)
+		status = -EFAULT;
+	return status;
+}
+
+ssize_t
+generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
+			    unsigned long nr_segs, loff_t pos, loff_t *ppos,
+			    size_t count, ssize_t written)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space * mapping = file->f_mapping;
+	const struct address_space_operations *a_ops = mapping->a_ops;
+	struct inode 	*inode = mapping->host;
+	long		status;
+	struct page	*cached_page = NULL;
+	struct pagevec	lru_pvec;
+	write_descriptor_t desc;
+	size_t copied = 0;
+
+	pagevec_init(&lru_pvec, 0);
+
+	desc.pos = pos;
+	desc.count = count;
+	desc.cur_iov = iov;
+	desc.iov_base = 0;
+
+	/*
+	 * handle partial DIO write.  Adjust cur_iov if needed.
+	 */
+	if (likely(nr_segs == 1)) {
+		desc.buf = iov->iov_base + written;
+		desc.actor = write_actor;
+	} else {
+		filemap_set_next_iovec(&desc.cur_iov, &desc.iov_base, written);
+		desc.buf = desc.cur_iov->iov_base + desc.iov_base;
+		desc.actor = write_iovec_actor;
+	}
+
+	do {
+		status = mapping->a_ops->fill_pages(file, &desc,
+						    &lru_pvec, &cached_page, &copied);
+		if (likely(copied > 0)) {
+			written += copied;
+			desc.count -= copied;
+			desc.pos += copied;
+			desc.buf += copied;
+			if (unlikely(nr_segs > 1)) {
+				filemap_set_next_iovec(&desc.cur_iov,
+						       &desc.iov_base, copied);
+				if (count)
+					desc.buf = desc.cur_iov->iov_base + desc.iov_base;
+			} else {
+				desc.iov_base += copied;
+			}
+		}
 		if (status < 0)
 			break;
 		balance_dirty_pages_ratelimited(mapping);
diff -puN include/linux/fs.h~batched-write include/linux/fs.h
--- linux-2.6.17-rc6-mm2/include/linux/fs.h~batched-write	2006-06-16 19:12:47.000000000 +0400
+++ linux-2.6.17-rc6-mm2-vs/include/linux/fs.h	2006-06-20 19:40:26.000000000 +0400
@@ -346,6 +346,9 @@ enum positive_aop_returns {
 struct page;
 struct address_space;
 struct writeback_control;
+typedef struct write_descriptor write_descriptor_t;
+
+#include <linux/pagevec.h>
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -367,6 +370,9 @@ struct address_space_operations {
 	 */
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	long (*fill_pages)(struct file *, const write_descriptor_t *,
+			   struct pagevec *, struct page **, size_t *copied);
+
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidatepage) (struct page *, unsigned long);

_

--=-s5QIN7z4J9TTdtu41ngl--

