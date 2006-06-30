Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933119AbWF3BuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119AbWF3BuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbWF3BuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:50:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933119AbWF3BuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:50:23 -0400
Date: Thu, 29 Jun 2006 18:50:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-Id: <20060629185017.8866f95e.akpm@osdl.org>
In-Reply-To: <44A42750.5020807@namesys.com>
References: <44A42750.5020807@namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 12:17:36 -0700
Hans Reiser <reiser@namesys.com> wrote:
> 
> 
> This patch adds a method batch_write to struct address_space_operations.
> A filesystem may want to implement this operation to improve write performance.
> Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
> it writes one page using prepare_write and commit_write address space operations.
> 

Please remember to fill in the authorship and signed-off-by info.

The approach seems sane.

> 
> 
> 
> diff -puN include/linux/fs.h~batched-write include/linux/fs.h
> --- linux-2.6.17-mm3/include/linux/fs.h~batched-write	2006-06-28 21:39:27.000000000 +0400
> +++ linux-2.6.17-mm3-root/include/linux/fs.h	2006-06-28 21:39:27.000000000 +0400
> @@ -346,6 +346,39 @@ enum positive_aop_returns {
>  struct page;
>  struct address_space;
>  struct writeback_control;
> +typedef struct write_descriptor write_descriptor_t;

Let's just use `struct write descriptor' throughout please.

> +
> +/*
> + * This is "write_actor" function type, used by write() to copy data from user
> + * space. There are two functions of this type: write_actor and
> + * write_iovec_actor. First is used when user data are in one segment, second
> + * is used in case of vectored write.
> + */
> +typedef size_t (*write_actor_t)(struct page *, unsigned long, size_t,
> +				const write_descriptor_t *);

But yes, we do use typedefs for these things - they're such a mouthful.

Can we please fill in the variable names in declarations such as this?  You
look at it and wonder what that `unsigned long' and `size_t' actually _do_.
It's so much clearer if the names are filled in.

> +/**
> + * struct write_descriptor - set of write arguments
> + * @pos: offset from the start of the file to write to
> + * @count: number of bytes to write
> + * @cur_iov: current i/o vector
> + * @iov_off: offset within current i/o vector
> + * @buf: user data
> + * @actor: function to copy user data with 
> + *
> + * This structure is to pass to batch_write address space operation all
> + * information which is needed to continue write.
> + */
> +struct write_descriptor {
> +	loff_t pos;
> +	size_t count;
> +	const struct iovec *cur_iov;
> +	size_t iov_off;
> +	char __user *buf;
> +	write_actor_t actor;
> +};

Boy, it's complex, isn't it?  Not your fault though.

> +#include <linux/pagevec.h>

A simple declaration:

struct pagevec;

would suffice here.  Please place it right at the top-of-file, with the others.

>  struct address_space_operations {
>  	int (*writepage)(struct page *page, struct writeback_control *wbc);
> @@ -367,6 +400,8 @@ struct address_space_operations {
>  	 */
>  	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
>  	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
> +	long (*batch_write)(struct file *, const write_descriptor_t *,
> +			    struct pagevec *, struct page **, size_t *);

It's nice to fill in the names here too, IMO.  Yes, there are past sins
there.

Should this be an address_space_operation or a file_operation?

> +/**
> + * generic_batch_write - generic implementation of batched write

gneric_file_batch_write(), perhaps?  I guess that depends upon the
answer to the previous question.

> + * @file: the file to write to
> + * @desc: set of write arguments
> + * @lru_pvec: multipage container to batch adding pages to LRU list
> + * @cached_page: allocated but not used on previous call
> + * @written: returned number of bytes successfully written
> + *
> + * This implementation of batch_write method writes not more than one page of
> + * file. It faults in user space, allocates page and calls prepare_write and
> + * commit_write address space operations. User data are copied by an actor
> + * which is set by caller depending on whether write or writev is on the way.
> + */
> +static long generic_batch_write(struct file *file,
> + 				const write_descriptor_t *desc,
> + 				struct pagevec *lru_pvec,
> + 				struct page **cached_page, size_t *written)

I wonder if we really need that cached_page thing.

Did you consider putting more of these arguments into the (now non-const)
`struct write_descriptor'?  It'd be sligtly more efficient and would save
stack on some of our stack-hungriest codepaths.

> +{
> + 	const struct address_space_operations *a_ops = file->f_mapping->a_ops;
> +	struct page *page;
> +	unsigned long index;
> +	size_t bytes;
> +	unsigned long offset;
> +	long status;
> +
> +	/* offset within page write is to start at */
> +	offset = (desc->pos & (PAGE_CACHE_SIZE - 1));
>  
> -	do {
> -		unsigned long index;
> -		unsigned long offset;
> -		size_t copied;
> -
> -		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
> -		index = pos >> PAGE_CACHE_SHIFT;
> -		bytes = PAGE_CACHE_SIZE - offset;
> +	/* index of page we are to write to */
> +	index = desc->pos >> PAGE_CACHE_SHIFT;
>  
> -		/* Limit the size of the copy to the caller's write size */
> -		bytes = min(bytes, count);
> +	/* number of bytes which can be written to the page */
> +	bytes = PAGE_CACHE_SIZE - offset;
>  
> -		/*
> -		 * Limit the size of the copy to that of the current segment,
> -		 * because fault_in_pages_readable() doesn't know how to walk
> -		 * segments.
> -		 */
> -		bytes = min(bytes, cur_iov->iov_len - iov_base);
> +	/* Limit the size of the copy to the caller's write size */
> +	bytes = min(bytes, desc->count);
>  
> +	/*
> +	 * Limit the size of the copy to that of the current segment,
> +	 * because fault_in_pages_readable() doesn't know how to walk
> +	 * segments.
> +	 */
> +	bytes = min(bytes, desc->cur_iov->iov_len - desc->iov_off);
> +
> +	while (1) {
>  		/*
>  		 * Bring in the user page that we will copy from _first_.
>  		 * Otherwise there's a nasty deadlock on copying from the
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		fault_in_pages_readable(buf, bytes);
> +		fault_in_pages_readable(desc->buf, bytes);
>  
> -		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
> -		if (!page) {
> -			status = -ENOMEM;
> -			break;
> -		}
> +		page = __grab_cache_page(file->f_mapping, index, cached_page,
> +					 lru_pvec);
> +		if (!page)
> +			return -ENOMEM;
>  
> -		status = a_ops->prepare_write(file, page, offset, offset+bytes);
> +		status = a_ops->prepare_write(file, page, offset,
> +					      offset+bytes);

The code you're patching here changed this morning, and it'll change again
(a little bit) in the next few days.

And Neil has suggested some simplifications to filemap_set_next_iovec(),
although I don't think anyone's working on that at present (everyone's
justifiably afraid to touch this code).

> +
> +ssize_t
> +generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
> +			    unsigned long nr_segs, loff_t pos, loff_t *ppos,
> +			    size_t count, ssize_t written)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct address_space * mapping = file->f_mapping;
> +	const struct address_space_operations *a_ops = mapping->a_ops;
> +	struct inode 	*inode = mapping->host;
> +	long		status;
> +	struct page	*cached_page = NULL;
> +	struct pagevec	lru_pvec;
> +	write_descriptor_t desc;
> +	size_t copied = 0;
> +
> +	pagevec_init(&lru_pvec, 0);
> +
> +	/*
> +	 * initialize write descriptor fields: position to write to
> +	 * and number of bytes to write
> +	 */
> +	desc.pos = pos;
> +	desc.count = count;
> +
> +	/*
> +	 * handle partial DIO write.  Adjust cur_iov if needed.
> +	 */
> +	if (likely(nr_segs == 1)) {
> +		desc.cur_iov = iov;
> +		desc.iov_off = written;
> +		desc.actor = write_actor;
> +	} else {
> +		filemap_set_next_iovec(&desc.cur_iov, &desc.iov_off, written);
> +		desc.actor = write_iovec_actor;
> +	}
> +	/* pointer to user buffer */
> +	desc.buf = desc.cur_iov->iov_base + desc.iov_off;
> +
> +	do {
> +		/*
> +		 * When calling the filesystem for writes, there is processing
> +		 * that must be done:
> +		 * 1) per word
> +		 * 2) per page
> +		 * 3) per call to the FS
> +		 * If the FS is called per page, then it turns out that 3)
> +		 * costs more than 1) and 2) for sophisticated filesystems.  To
> +		 * allow the FS to choose to pay the cost of 3) only once we
> +		 * call batch_write, if the FS supports it.
> +		 */

I think it's better that the more philosophical comments like this go in
the comment block at the start of the function.

> +		if (a_ops->batch_write)
> +			status = a_ops->batch_write(file, &desc, &lru_pvec,
> +						    &cached_page, &copied);
> +		else
> +			status = generic_batch_write(file, &desc, &lru_pvec,
> +						     &cached_page, &copied);
> +		if (likely(copied > 0)) {

This is missing this morning's handle-zero-length-segment bugfix.

> +			written += copied;
> +			desc.count -= copied;
> +			if (desc.count) {
> +				/*
> +				 * not everything is written yet. Adjust write
> +				 * descriptor for next iteration
> +				 */
> +				desc.pos += copied;
> +				if (unlikely(nr_segs > 1))
> +					filemap_set_next_iovec(&desc.cur_iov,
> +							       &desc.iov_off,
> +							       copied);
> +				else
> +					desc.iov_off += copied;
> +				desc.buf = desc.cur_iov->iov_base +
> +					desc.iov_off;
> +			}
> +		}
>  		if (status < 0)
>  			break;
>  		balance_dirty_pages_ratelimited(mapping);
>  		cond_resched();
> -	} while (count);
> -	*ppos = pos;
> +	} while (desc.count);	
> +	*ppos = pos + written;
>  
>  	if (cached_page)
>  		page_cache_release(cached_page);

