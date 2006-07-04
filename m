Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWGDLUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWGDLUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGDLUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:20:51 -0400
Received: from zotz.mtu.ru ([195.34.34.227]:43279 "EHLO zotz.mtu.ru")
	by vger.kernel.org with ESMTP id S1751284AbWGDLUu (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:20:50 -0400
Subject: Re: [PATCH 1/2] batch-write.patch
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <Linux-Kernel@vger.kernel.org>, reiserfs-dev@namesys.com
In-Reply-To: <20060629185017.8866f95e.akpm@osdl.org>
References: <44A42750.5020807@namesys.com>
	 <20060629185017.8866f95e.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-tKC7eLP3XWPJyk/hJBa4"
Date: Tue, 04 Jul 2006 15:12:56 +0400
Message-Id: <1152011576.6454.36.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tKC7eLP3XWPJyk/hJBa4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

Andrew, thanks a lot for your improvements.
Here is new version of the patch.

On Thu, 2006-06-29 at 18:50 -0700, Andrew Morton wrote:
> On Thu, 29 Jun 2006 12:17:36 -0700
> Hans Reiser <reiser@namesys.com> wrote:
> > 
> > 
> > This patch adds a method batch_write to struct address_space_operations.
> > A filesystem may want to implement this operation to improve write performance.
> > Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
> > it writes one page using prepare_write and commit_write address space operations.
> > 
> 
> Please remember to fill in the authorship and signed-off-by info.
> 

done.

> The approach seems sane.
> 
> > 
> > 
> > 
> > diff -puN include/linux/fs.h~batched-write include/linux/fs.h
> > --- linux-2.6.17-mm3/include/linux/fs.h~batched-write	2006-06-28 21:39:27.000000000 +0400
> > +++ linux-2.6.17-mm3-root/include/linux/fs.h	2006-06-28 21:39:27.000000000 +0400
> > @@ -346,6 +346,39 @@ enum positive_aop_returns {
> >  struct page;
> >  struct address_space;
> >  struct writeback_control;
> > +typedef struct write_descriptor write_descriptor_t;
> 
> Let's just use `struct write descriptor' throughout please.
> 

done.

> > +
> > +/*
> > + * This is "write_actor" function type, used by write() to copy data from user
> > + * space. There are two functions of this type: write_actor and
> > + * write_iovec_actor. First is used when user data are in one segment, second
> > + * is used in case of vectored write.
> > + */
> > +typedef size_t (*write_actor_t)(struct page *, unsigned long, size_t,
> > +				const write_descriptor_t *);
> 
> But yes, we do use typedefs for these things - they're such a mouthful.
> 

As long as now we never call batch_write to write from more than
segment - we do no need write_actor. filemap_copy_from_user is only used
to copy data.

> Can we please fill in the variable names in declarations such as this?  You
> look at it and wonder what that `unsigned long' and `size_t' actually _do_.
> It's so much clearer if the names are filled in.
> 
> > +/**
> > + * struct write_descriptor - set of write arguments
> > + * @pos: offset from the start of the file to write to
> > + * @count: number of bytes to write
> > + * @cur_iov: current i/o vector
> > + * @iov_off: offset within current i/o vector
> > + * @buf: user data
> > + * @actor: function to copy user data with 
> > + *
> > + * This structure is to pass to batch_write address space operation all
> > + * information which is needed to continue write.
> > + */
> > +struct write_descriptor {
> > +	loff_t pos;
> > +	size_t count;
> > +	const struct iovec *cur_iov;
> > +	size_t iov_off;
> > +	char __user *buf;
> > +	write_actor_t actor;
> > +};
> 
> Boy, it's complex, isn't it?  Not your fault though.
> 

struct write_descriptor changed. It has 5 fields now.

> > +#include <linux/pagevec.h>
> 
> A simple declaration:
> 
> struct pagevec;
> 
> would suffice here.  Please place it right at the top-of-file, with the others.
> 

done.

> >  struct address_space_operations {
> >  	int (*writepage)(struct page *page, struct writeback_control *wbc);
> > @@ -367,6 +400,8 @@ struct address_space_operations {
> >  	 */
> >  	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
> >  	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
> > +	long (*batch_write)(struct file *, const write_descriptor_t *,
> > +			    struct pagevec *, struct page **, size_t *);
> 
> It's nice to fill in the names here too, IMO.  Yes, there are past sins
> there.
> 

done.

> Should this be an address_space_operation or a file_operation?
> 

I was seeking to be minimal in my changes to the philosophy of the code.
So, it was an address_space operation. Now it is a file operation.


> > +/**
> > + * generic_batch_write - generic implementation of batched write
> 
> gneric_file_batch_write(), perhaps?  I guess that depends upon the
> answer to the previous question.
> 

renamed.

> > + * @file: the file to write to
> > + * @desc: set of write arguments
> > + * @lru_pvec: multipage container to batch adding pages to LRU list
> > + * @cached_page: allocated but not used on previous call
> > + * @written: returned number of bytes successfully written
> > + *
> > + * This implementation of batch_write method writes not more than one page of
> > + * file. It faults in user space, allocates page and calls prepare_write and
> > + * commit_write address space operations. User data are copied by an actor
> > + * which is set by caller depending on whether write or writev is on the way.
> > + */
> > +static long generic_batch_write(struct file *file,
> > + 				const write_descriptor_t *desc,
> > + 				struct pagevec *lru_pvec,
> > + 				struct page **cached_page, size_t *written)
> 
> I wonder if we really need that cached_page thing.
> 
> Did you consider putting more of these arguments into the (now non-const)
> `struct write_descriptor'?  It'd be sligtly more efficient and would save
> stack on some of our stack-hungriest codepaths.
> 

lru_pvec and cached_page are included to struct write_descriptor.

> > +{
> > + 	const struct address_space_operations *a_ops = file->f_mapping->a_ops;
> > +	struct page *page;
> > +	unsigned long index;
> > +	size_t bytes;
> > +	unsigned long offset;
> > +	long status;
> > +
> > +	/* offset within page write is to start at */
> > +	offset = (desc->pos & (PAGE_CACHE_SIZE - 1));
> >  
> > -	do {
> > -		unsigned long index;
> > -		unsigned long offset;
> > -		size_t copied;
> > -
> > -		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
> > -		index = pos >> PAGE_CACHE_SHIFT;
> > -		bytes = PAGE_CACHE_SIZE - offset;
> > +	/* index of page we are to write to */
> > +	index = desc->pos >> PAGE_CACHE_SHIFT;
> >  
> > -		/* Limit the size of the copy to the caller's write size */
> > -		bytes = min(bytes, count);
> > +	/* number of bytes which can be written to the page */
> > +	bytes = PAGE_CACHE_SIZE - offset;
> >  
> > -		/*
> > -		 * Limit the size of the copy to that of the current segment,
> > -		 * because fault_in_pages_readable() doesn't know how to walk
> > -		 * segments.
> > -		 */
> > -		bytes = min(bytes, cur_iov->iov_len - iov_base);
> > +	/* Limit the size of the copy to the caller's write size */
> > +	bytes = min(bytes, desc->count);
> >  
> > +	/*
> > +	 * Limit the size of the copy to that of the current segment,
> > +	 * because fault_in_pages_readable() doesn't know how to walk
> > +	 * segments.
> > +	 */
> > +	bytes = min(bytes, desc->cur_iov->iov_len - desc->iov_off);
> > +
> > +	while (1) {
> >  		/*
> >  		 * Bring in the user page that we will copy from _first_.
> >  		 * Otherwise there's a nasty deadlock on copying from the
> >  		 * same page as we're writing to, without it being marked
> >  		 * up-to-date.
> >  		 */
> > -		fault_in_pages_readable(buf, bytes);
> > +		fault_in_pages_readable(desc->buf, bytes);
> >  
> > -		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
> > -		if (!page) {
> > -			status = -ENOMEM;
> > -			break;
> > -		}
> > +		page = __grab_cache_page(file->f_mapping, index, cached_page,
> > +					 lru_pvec);
> > +		if (!page)
> > +			return -ENOMEM;
> >  
> > -		status = a_ops->prepare_write(file, page, offset, offset+bytes);
> > +		status = a_ops->prepare_write(file, page, offset,
> > +					      offset+bytes);
> 
> The code you're patching here changed this morning, and it'll change again
> (a little bit) in the next few days.
> 

New patch is against 2.6.17-mm5.

> And Neil has suggested some simplifications to filemap_set_next_iovec(),
> although I don't think anyone's working on that at present (everyone's
> justifiably afraid to touch this code).
> > +
> > +ssize_t
> > +generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
> > +			    unsigned long nr_segs, loff_t pos, loff_t *ppos,
> > +			    size_t count, ssize_t written)
> > +{
> > +	struct file *file = iocb->ki_filp;
> > +	struct address_space * mapping = file->f_mapping;
> > +	const struct address_space_operations *a_ops = mapping->a_ops;
> > +	struct inode 	*inode = mapping->host;
> > +	long		status;
> > +	struct page	*cached_page = NULL;
> > +	struct pagevec	lru_pvec;
> > +	write_descriptor_t desc;
> > +	size_t copied = 0;
> > +
> > +	pagevec_init(&lru_pvec, 0);
> > +
> > +	/*
> > +	 * initialize write descriptor fields: position to write to
> > +	 * and number of bytes to write
> > +	 */
> > +	desc.pos = pos;
> > +	desc.count = count;
> > +
> > +	/*
> > +	 * handle partial DIO write.  Adjust cur_iov if needed.
> > +	 */
> > +	if (likely(nr_segs == 1)) {
> > +		desc.cur_iov = iov;
> > +		desc.iov_off = written;
> > +		desc.actor = write_actor;
> > +	} else {
> > +		filemap_set_next_iovec(&desc.cur_iov, &desc.iov_off, written);
> > +		desc.actor = write_iovec_actor;
> > +	}
> > +	/* pointer to user buffer */
> > +	desc.buf = desc.cur_iov->iov_base + desc.iov_off;
> > +
> > +	do {
> > +		/*
> > +		 * When calling the filesystem for writes, there is processing
> > +		 * that must be done:
> > +		 * 1) per word
> > +		 * 2) per page
> > +		 * 3) per call to the FS
> > +		 * If the FS is called per page, then it turns out that 3)
> > +		 * costs more than 1) and 2) for sophisticated filesystems.  To
> > +		 * allow the FS to choose to pay the cost of 3) only once we
> > +		 * call batch_write, if the FS supports it.
> > +		 */
> 
> I think it's better that the more philosophical comments like this go in
> the comment block at the start of the function.
> 

This comment is moved at the start of this function.

> > +		if (a_ops->batch_write)
> > +			status = a_ops->batch_write(file, &desc, &lru_pvec,
> > +						    &cached_page, &copied);
> > +		else
> > +			status = generic_batch_write(file, &desc, &lru_pvec,
> > +						     &cached_page, &copied);
> > +		if (likely(copied > 0)) {
> 
> This is missing this morning's handle-zero-length-segment bugfix.
> 

I hope new patch deals properly with zero length segments. I writev-ed a
vector which had 3 zero length segments: first, last and 3rd.

> > +			written += copied;
> > +			desc.count -= copied;
> > +			if (desc.count) {
> > +				/*
> > +				 * not everything is written yet. Adjust write
> > +				 * descriptor for next iteration
> > +				 */
> > +				desc.pos += copied;
> > +				if (unlikely(nr_segs > 1))
> > +					filemap_set_next_iovec(&desc.cur_iov,
> > +							       &desc.iov_off,
> > +							       copied);
> > +				else
> > +					desc.iov_off += copied;
> > +				desc.buf = desc.cur_iov->iov_base +
> > +					desc.iov_off;
> > +			}
> > +		}
> >  		if (status < 0)
> >  			break;
> >  		balance_dirty_pages_ratelimited(mapping);
> >  		cond_resched();
> > -	} while (count);
> > -	*ppos = pos;
> > +	} while (desc.count);	
> > +	*ppos = pos + written;
> >  
> >  	if (cached_page)
> >  		page_cache_release(cached_page);
> 
> 

--=-tKC7eLP3XWPJyk/hJBa4
Content-Disposition: inline; filename=batched-write.patch
Content-Type: message/rfc822; name=batched-write.patch

Date: Tue, 04 Jul 2006 00:52:59 +0400
Subject: No Subject
Message-Id: <1151959979.6335.92.camel@tribesman.namesys.com>
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
--- linux-2.6.17-mm5/include/linux/fs.h~batched-write	2006-07-03 18:16:44.000000000 +0400
+++ linux-2.6.17-mm5-vs/include/linux/fs.h	2006-07-04 00:31:41.000000000 +0400
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
+ * This structure is to pass to batch_write address space operation
+ * all information which is needed to continue write.
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
--- linux-2.6.17-mm5/mm/filemap.c~batched-write	2006-07-03 18:16:44.000000000 +0400
+++ linux-2.6.17-mm5-vs/mm/filemap.c	2006-07-04 00:59:56.000000000 +0400
@@ -2159,78 +2159,58 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+/**
+ * generic_batch_write - generic implementation of batched write
+ * @file: the file to write to
+ * @desc: set of write arguments
+ * @written: returned number of bytes successfully written
+ *
+ * This implementation of batch_write method writes not more than one page of
+ * file. It faults in user space, allocates page and calls prepare_write and
+ * commit_write address space operations. User data are copied by an actor
+ * which is set by caller depending on whether write or writev is on the way.
+ */
+static long generic_batch_write(struct file *file,
+  				struct write_descriptor *desc,
+  				size_t *written)
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
+	/* Limit the size of the copy to the caller's write size */
+	bytes = min(bytes, desc->count);
+	BUG_ON(bytes == 0);
 
+	while (1) {
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		fault_in_pages_readable(desc->buf, bytes);
 
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
-		}
-
-		if (unlikely(bytes == 0)) {
-			status = 0;
-			copied = 0;
-			goto zero_length_segment;
-		}
+		page = __grab_cache_page(file->f_mapping, index, &desc->cached_page,
+					 desc->lru_pvec);
+		if (!page)
+			return -ENOMEM;
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
+			loff_t isize = i_size_read(file->f_mapping->host);
 
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
@@ -2238,61 +2218,139 @@ generic_file_buffered_write(struct kiocb
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
+		/*
+		 * call write actor in order to copy user data to the
+		 * page
+		 */
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
+	 * If commit_write returned error - write failed and we zero
+	 * number of written bytes. If filemap_copy_from_user copied
+	 * less than it was asked to we return -EFAULT and number of
+	 * bytes actually written.
+	 */
+	if (status)
+		*written = 0;
+	else if (*written != bytes)
+		status = -EFAULT;
+	return status;
+}
 
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
+/*
+ * When calling the filesystem for writes, there is processing
+ * that must be done:
+ * 1) per word
+ * 2) per page
+ * 3) per call to the FS
+ * If the FS is called per page, then it turns out that 3) costs more
+ * than 1) and 2) for sophisticated filesystems.  To allow the FS to
+ * choose to pay the cost of 3) only once we call batch_write, if the
+ * FS supports it.
+ */
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
+
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
+	 * if file system implements batch_write method - use it,
+	 * otherwise - use generic_batch_write
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

_

--=-tKC7eLP3XWPJyk/hJBa4
Content-Disposition: attachment; filename=batched-write.patch
Content-Type: message/rfc822; name=batched-write.patch

Date: Tue, 04 Jul 2006 15:12:56 +0400
Subject: No Subject
Message-Id: <1152011576.6454.37.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: 

From: Vladimir Saveliev <vs@namesys.com>

This patch adds a method batch_write to struct file_operations.
A filesystem may want to implement this operation to improve write performance.
Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
it writes one page using prepare_write and commit_write address space operations.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN include/linux/fs.h~batched-write include/linux/fs.h
--- linux-2.6.17-mm5/include/linux/fs.h~batched-write	2006-07-04 14:07:47.000000000 +0400
+++ linux-2.6.17-mm5-vs/include/linux/fs.h	2006-07-04 14:39:11.000000000 +0400
@@ -246,6 +246,7 @@ struct poll_table_struct;
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct pagevec;
 
 extern void __init inode_init(unsigned long);
 extern void __init inode_init_early(void);
@@ -1096,6 +1097,25 @@ typedef int (*read_actor_t)(read_descrip
 #define HAVE_COMPAT_IOCTL 1
 #define HAVE_UNLOCKED_IOCTL 1
 
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
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev, unlocked_ioctl and compat_ioctl
@@ -1123,6 +1143,8 @@ struct file_operations {
 	int (*lock) (struct file *, int, struct file_lock *);
 	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
 	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	long (*batch_write)(struct file *file, struct write_descriptor *desc,
+			    size_t *written);
 	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, void *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
diff -puN mm/filemap.c~batched-write mm/filemap.c
--- linux-2.6.17-mm5/mm/filemap.c~batched-write	2006-07-04 14:07:47.000000000 +0400
+++ linux-2.6.17-mm5-vs/mm/filemap.c	2006-07-04 15:09:58.000000000 +0400
@@ -2159,78 +2159,59 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+/**
+ * generic_file_batch_write - generic batch_write file operation
+ * @file: the file to write to
+ * @desc: set of write arguments
+ * @written: returned number of bytes successfully written
+ *
+ * This implementation of batch_write file operation method writes not
+ * more than one page of file. It faults in user space, allocates page
+ * and calls prepare_write and commit_write address space
+ * operations. User data are copied by filemap_copy_from_user.
+ */
+static long generic_file_batch_write(struct file *file,
+				     struct write_descriptor *desc,
+				     size_t *written)
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
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		fault_in_pages_readable(desc->buf, bytes);
 
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
-		}
+		page = __grab_cache_page(file->f_mapping, index,
+					 &desc->cached_page, desc->lru_pvec);
+		if (!page)
+			return -ENOMEM;
 
-		if (unlikely(bytes == 0)) {
-			status = 0;
-			copied = 0;
-			goto zero_length_segment;
-		}
-
-		status = a_ops->prepare_write(file, page, offset, offset+bytes);
+		status = a_ops->prepare_write(file, page, offset,
+					      offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
+			loff_t isize = i_size_read(file->f_mapping->host);
 
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
@@ -2238,61 +2219,139 @@ generic_file_buffered_write(struct kiocb
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
+		/*
+		 * call write actor in order to copy user data to the
+		 * page
+		 */
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
+	 * If commit_write returned error - write failed and we zero
+	 * number of written bytes. If filemap_copy_from_user copied
+	 * less than it was asked to we return -EFAULT and number of
+	 * bytes actually written.
+	 */
+	if (status)
+		*written = 0;
+	else if (*written != bytes)
+		status = -EFAULT;
+	return status;
+}
 
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
+/*
+ * When calling the filesystem for writes, there is processing
+ * that must be done:
+ * 1) per word
+ * 2) per page
+ * 3) per call to the FS
+ * If the FS is called per page, then it turns out that 3) costs more
+ * than 1) and 2) for sophisticated filesystems.  To allow the FS to
+ * choose to pay the cost of 3) only once we call batch_write, if the
+ * FS supports it.
+ */
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
+
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
+	 * if file system implements batch_write method - use it,
+	 * otherwise - use generic_batch_write
+	 */
+	if (file->f_op->batch_write)
+		batch_write = file->f_op->batch_write;
+	else
+		batch_write = generic_file_batch_write;
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
--- linux-2.6.17-mm5/Documentation/filesystems/vfs.txt~batched-write	2006-07-04 14:34:53.000000000 +0400
+++ linux-2.6.17-mm5-vs/Documentation/filesystems/vfs.txt	2006-07-04 14:37:16.000000000 +0400
@@ -717,6 +717,8 @@ struct file_operations {
 	int (*lock) (struct file *, int, struct file_lock *);
 	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
 	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	long (*batch_write)(struct file *file, struct write_descriptor *desc,
+			    size_t *written);
 	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, void *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
@@ -784,6 +786,8 @@ otherwise noted.
 
   writev: called by the writev(2) system call
 
+  batch_write: optional, if implemented called by writev(2) and write(2)
+
   sendfile: called by the sendfile(2) system call
 
   get_unmapped_area: called by the mmap(2) system call

_

--=-tKC7eLP3XWPJyk/hJBa4--

