Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGEQxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGEQxj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWGEQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:53:38 -0400
Received: from chen.mtu.ru ([195.34.34.232]:43273 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S964773AbWGEQxi (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:53:38 -0400
Subject: Re: [PATCH 1/2] batch-write.patch
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, hch@infradead.org,
       Linux-Kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20060704151832.9f2d87b3.akpm@osdl.org>
References: <44A42750.5020807@namesys.com>
	 <20060629185017.8866f95e.akpm@osdl.org>
	 <1152011576.6454.36.camel@tribesman.namesys.com>
	 <20060704114836.GA1344@infradead.org> <44AAA8ED.5030906@namesys.com>
	 <20060704151832.9f2d87b3.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-ucWp/ZAhnosasKbpzH9X"
Date: Wed, 05 Jul 2006 20:45:35 +0400
Message-Id: <1152117935.6337.48.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ucWp/ZAhnosasKbpzH9X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Tue, 2006-07-04 at 15:18 -0700, Andrew Morton wrote:
> On Tue, 04 Jul 2006 10:44:13 -0700
> Hans Reiser <reiser@namesys.com> wrote:
> 
> > Christoph Hellwig wrote:
> > 
> > >On Tue, Jul 04, 2006 at 03:12:56PM +0400, Vladimir V. Saveliev wrote:
> > >  
> > >
> > >>>Should this be an address_space_operation or a file_operation?
> > >>>
> > >>>      
> > >>>
> > >>I was seeking to be minimal in my changes to the philosophy of the code.
> > >>So, it was an address_space operation. Now it is a file operation.
> > >>    
> > >>
> > >
> > >It definitly should not be a file_operation! It works at the address_space
> > >not the much higher file level.  Maybe all three should become callbacks
> > >for the generic write routines, but that's left for the future.
> > >
> > >
> > >  
> > >
> > I don't have a commitment to one way or the other, probably because
> > there are some things that are unclear in my mind.  Could you help me
> > with them?  Can you define what is the address space vs. the file level
> > please?  It is odd to be asking such a basic question, but these things
> > are genuinely unclear to me.  If the use of something varies according
> > to the file, is it a file method?  What things vary according to address
> > space and not according to file?  Should things that vary according to
> > address space be address space ops and things that vary according to
> > file be file ops?  If that logic seems valid, should a lot more be changed?
> > 
> > Oh, and Andrew, while such things are discussed, could you just pick one
> > way or the other and let the patch go in?
> > 
> 
> I wasn't sure, which was I asked rather than suggested..
> 
> Looking closer, yes I agree with Christoph, sorry.  It's called at the same
> level as ->prepare_write/commit_write so if there's any logic to this, it's
> logical that batched_write be an a_op too.
> 

ok, the attached is the final version of the patch.
Please, take a look and make comments.


> 

--=-ucWp/ZAhnosasKbpzH9X
Content-Disposition: inline; filename=batched-write.patch
Content-Type: message/rfc822; name=batched-write.patch

Date: Wed, 05 Jul 2006 20:45:18 +0400
Subject: No Subject
Message-Id: <1152117918.6337.47.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: 

From: Vladimir Saveliev <vs@namesys.com>

This patch adds a method batch_write to struct address_space_operations.
A filesystem may want to implement this operation to improve write performance.
Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
it writes one page using prepare_write and commit_write address space operations.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN include/linux/fs.h~batched-write include/linux/fs.h
--- linux-2.6.17-mm5/include/linux/fs.h~batched-write	2006-07-05 13:23:14.000000000 +0400
+++ linux-2.6.17-mm5-vs/include/linux/fs.h	2006-07-05 13:31:46.000000000 +0400
@@ -246,6 +246,7 @@ struct poll_table_struct;
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct pagevec;
 
 extern void __init inode_init(unsigned long);
 extern void __init inode_init_early(void);
@@ -347,6 +348,25 @@ struct page;
 struct address_space;
 struct writeback_control;
 
+/**
+ * struct write_descriptor - set of write arguments
+ * @pos: offset from the start of the file to write to
+ * @count: number of bytes to write
+ * @buf: pointer to data to be written
+ * @lru_pvec: multipage container to batch adding pages to LRU list
+ * @cached_page: allocated but not used on previous call
+ *
+ * This structure is to pass to batch_write file operation all
+ * information which is needed to continue write.
+ */
+struct write_descriptor {
+	loff_t pos;
+	size_t count;
+	char __user *buf;
+	struct page *cached_page;
+	struct pagevec *lru_pvec;
+};
+
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
@@ -367,6 +387,8 @@ struct address_space_operations {
 	 */
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	long (*batch_write)(struct file *file, struct write_descriptor *desc,
+			    size_t *written);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidatepage) (struct page *, unsigned long);
diff -puN mm/filemap.c~batched-write mm/filemap.c
--- linux-2.6.17-mm5/mm/filemap.c~batched-write	2006-07-05 13:23:14.000000000 +0400
+++ linux-2.6.17-mm5-vs/mm/filemap.c	2006-07-05 13:47:58.000000000 +0400
@@ -2159,78 +2159,59 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+/**
+ * generic_batch_write - generic batch_write address space operation
+ * @file: the file to write to
+ * @desc: set of write arguments
+ * @written: returned number of bytes successfully written
+ *
+ * This implementation of batch_write address space operation writes not more
+ * than one page of file. It faults in user space, allocates page and calls
+ * prepare_write and commit_write address space operations. User data are
+ * copied by filemap_copy_from_user.
+ */
+static long generic_batch_write(struct file *file,
+				struct write_descriptor *desc,
+				size_t *written)
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
-
-	pagevec_init(&lru_pvec, 0);
-
-	/*
-	 * handle partial DIO write.  Adjust cur_iov if needed.
-	 */
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
-		size_t copied;
-
-		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
-		index = pos >> PAGE_CACHE_SHIFT;
-		bytes = PAGE_CACHE_SIZE - offset;
-
-		/* Limit the size of the copy to the caller's write size */
-		bytes = min(bytes, count);
-
-		/*
-		 * Limit the size of the copy to that of the current segment,
-		 * because fault_in_pages_readable() doesn't know how to walk
-		 * segments.
-		 */
-		bytes = min(bytes, cur_iov->iov_len - iov_base);
+  	const struct address_space_operations *a_ops = file->f_mapping->a_ops;
+	struct page *page;
+	unsigned long index;
+	size_t bytes;
+	unsigned long offset;
+	long status;
+
+	/* offset within page write is to start at */
+	offset = (desc->pos & (PAGE_CACHE_SIZE - 1));
+
+	/* index of page we are to write to */
+	index = desc->pos >> PAGE_CACHE_SHIFT;
+
+	/* number of bytes which can be written to the page */
+	bytes = PAGE_CACHE_SIZE - offset;
+
+	/* limit the size of the copy to the caller's write size */
+	bytes = min(bytes, desc->count);
+	BUG_ON(bytes == 0);
 
+	while (1) {
 		/*
 		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
+		 * Otherwise there's a nasty deadlock on copying from the same
+		 * page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
-
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
-		}
+		fault_in_pages_readable(desc->buf, bytes);
 
-		if (unlikely(bytes == 0)) {
-			status = 0;
-			copied = 0;
-			goto zero_length_segment;
-		}
+		page = __grab_cache_page(file->f_mapping, index,
+					 &desc->cached_page, desc->lru_pvec);
+		if (!page)
+			return -ENOMEM;
 
-		status = a_ops->prepare_write(file, page, offset, offset+bytes);
+		status = a_ops->prepare_write(file, page, offset,
+					      offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
+			loff_t isize = i_size_read(file->f_mapping->host);
 
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
@@ -2241,58 +2222,120 @@ generic_file_buffered_write(struct kiocb
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
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
+		/* copy user data to the page */
+		*written = filemap_copy_from_user(page, offset, desc->buf,
+						  bytes);
+
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
 			page_cache_release(page);
 			continue;
 		}
-zero_length_segment:
-		if (likely(copied >= 0)) {
-			if (!status)
-				status = copied;
+  		unlock_page(page);
+  		mark_page_accessed(page);
+  		page_cache_release(page);
+		break;
+	}
+	/*
+	 * If commit_write returned error - write failed and we zero number of
+	 * written bytes. If filemap_copy_from_user copied less than it was
+	 * asked to we return -EFAULT and number of bytes actually written.
+	 */
+	if (status)
+		*written = 0;
+	else if (*written != bytes)
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
+	struct pagevec	lru_pvec;
+	struct write_descriptor desc;
+	size_t copied = 0;
+        const struct iovec *cur_iov = iov; /* current iovec */
+        size_t          iov_base = 0;      /* offset in the current iovec */
+	long (*batch_write)(struct file *file,
+			    struct write_descriptor *desc,
+			    size_t *written);
 
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
+	pagevec_init(&lru_pvec, 0);
+
+	/*
+	 * initialize write descriptor fields: position to write to
+	 * and number of bytes to write
+	 */
+	desc.pos = pos;
+	desc.cached_page = NULL;
+	desc.lru_pvec = &lru_pvec;
+
+	/*
+	 * handle partial DIO write.  Adjust cur_iov if needed.
+	 */
+	if (likely(nr_segs == 1))
+		iov_base = written;
+	else
+                filemap_set_next_iovec(&cur_iov, &iov_base, written);
+
+	/*
+	 * if file system implements batch_write method - use it, otherwise -
+	 * use generic_batch_write
+	 */
+	if (a_ops->batch_write)
+		batch_write = a_ops->batch_write;
+	else
+		batch_write = generic_batch_write;
+
+	do {
+		/* do not walk over current segment */
+		desc.buf = cur_iov->iov_base + iov_base;
+		desc.count = cur_iov->iov_len - iov_base;
+		if (desc.count > 0)
+			status = batch_write(file, &desc, &copied);
+		else {
+			copied = 0;
+			status = 0;
+		}
+		if (likely(copied >= 0)) {
+			written += copied;
+			count -= copied;
+			if (count) {
+				/*
+				 * not everything is written yet. Adjust write
+				 * descriptor for next iteration
+				 */
+				desc.pos += copied;
+				if (likely(nr_segs == 1))
+					iov_base += copied;
+				else
 					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_base;
-				} else {
-					iov_base += status;
-				}
+							       &iov_base,
+							       copied);
 			}
 		}
-		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
-		unlock_page(page);
-		mark_page_accessed(page);
-		page_cache_release(page);
-		if (status < 0)
-			break;
-		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
-	} while (count);
-	*ppos = pos;
-
-	if (cached_page)
-		page_cache_release(cached_page);
+  		if (status < 0)
+  			break;
+  		balance_dirty_pages_ratelimited(mapping);
+  		cond_resched();
+	} while (count);	
+	*ppos = pos + written;
+  
+  	if (desc.cached_page)
+  		page_cache_release(desc.cached_page);
 
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
diff -puN Documentation/filesystems/vfs.txt~batched-write Documentation/filesystems/vfs.txt
--- linux-2.6.17-mm5/Documentation/filesystems/vfs.txt~batched-write	2006-07-05 13:23:14.000000000 +0400
+++ linux-2.6.17-mm5-vs/Documentation/filesystems/vfs.txt	2006-07-05 19:36:15.000000000 +0400
@@ -534,6 +534,8 @@ struct address_space_operations {
 			struct list_head *pages, unsigned nr_pages);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	long (*batch_write)(struct file *file, struct write_descriptor *desc,
+			    size_t *written);
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
@@ -624,6 +626,17 @@ struct address_space_operations {
         operations.  It should avoid returning an error if possible -
         errors should have been handled by prepare_write.
 
+  batch_write: optional
+        When calling the filesystem for writes, there is processing
+        that must be done:
+        1) per word
+        2) per page
+        3) per call to the FS
+        If the FS is called per page, then it turns out that 3) costs more
+        than 1) and 2) for sophisticated filesystems.  To allow the FS to
+        choose to pay the cost of 3) only once we call batch_write, if the
+        FS supports it.
+
   bmap: called by the VFS to map a logical block offset within object to
   	physical block number. This method is used by the FIBMAP
   	ioctl and for working with swap-files.  To be able to swap to

_

--=-ucWp/ZAhnosasKbpzH9X--

