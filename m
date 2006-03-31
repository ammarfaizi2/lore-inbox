Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWCaAKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWCaAKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCaAKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:10:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751113AbWCaAKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:10:21 -0500
Date: Thu, 30 Mar 2006 16:12:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Introduce sys_splice() system call
Message-Id: <20060330161240.11ee3d5f.akpm@osdl.org>
In-Reply-To: <200603302109.k2UL9Auj011419@hera.kernel.org>
References: <200603302109.k2UL9Auj011419@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> commit 5274f052e7b3dbd81935772eb551dfd0325dfa9d
> tree c79f813ec513660edb6f1e4a75cb366c6b84f53f
> parent 5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866
> author Jens Axboe <axboe@suse.de> Thu, 30 Mar 2006 15:15:30 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 31 Mar 2006 04:28:18 -0800
> 
> [PATCH] Introduce sys_splice() system call

eek.



splice.c should include syscalls.h.

> ...
>
> +static int __generic_file_splice_read(struct file *in, struct inode *pipe,
> +				      size_t len)
> +{
> +	struct address_space *mapping = in->f_mapping;
> +	unsigned int offset, nr_pages;
> +	struct page *pages[PIPE_BUFFERS], *shadow[PIPE_BUFFERS];
> +	struct page *page;
> +	pgoff_t index, pidx;
> +	int i, j;
> +
> +	index = in->f_pos >> PAGE_CACHE_SHIFT;
> +	offset = in->f_pos & ~PAGE_CACHE_MASK;
> +	nr_pages = (len + offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
> +
> +	if (nr_pages > PIPE_BUFFERS)
> +		nr_pages = PIPE_BUFFERS;
> +
> +	/*
> +	 * initiate read-ahead on this page range
> +	 */
> +	do_page_cache_readahead(mapping, in, index, nr_pages);
> +
> +	/*
> +	 * Get as many pages from the page cache as possible..
> +	 * Start IO on the page cache entries we create (we
> +	 * can assume that any pre-existing ones we find have
> +	 * already had IO started on them).
> +	 */
> +	i = find_get_pages(mapping, index, nr_pages, pages);
> +
> +	/*
> +	 * common case - we found all pages and they are contiguous,
> +	 * kick them off
> +	 */
> +	if (i && (pages[i - 1]->index == index + i - 1))
> +		goto splice_them;
> +
> +	/*
> +	 * fill shadow[] with pages at the right locations, so we only
> +	 * have to fill holes
> +	 */
> +	memset(shadow, 0, i * sizeof(struct page *));

This leaves shadow[i] up to shadow[nr_pages - 1] uninitialised.

> +	for (j = 0, pidx = index; j < i; pidx++, j++)
> +		shadow[pages[j]->index - pidx] = pages[j];

This can overindex shadow[].

> +	/*
> +	 * now fill in the holes
> +	 */
> +	for (i = 0, pidx = index; i < nr_pages; pidx++, i++) {

We've lost `i', which is the number of pages in pages[], and the number of
initialised entries in shadow[].


> +		int error;
> +
> +		if (shadow[i])
> +			continue;

As this loop iterates up to nr_pages, which can be greater than the
now-lost `i', we're playing with potentially-uninitialised entries in
shadow[].

Doing

	nr_pages = find_get_pages(..., nr_pages, ...)

up above would be a good start on getting this sorted out.

> +		/*
> +		 * no page there, look one up / create it
> +		 */
> +		page = find_or_create_page(mapping, pidx,
> +						   mapping_gfp_mask(mapping));
> +		if (!page)
> +			break;

So if OOM happened, we can still have NULLs and live page*'s in shadow[],
outside `i'

> +		if (PageUptodate(page))
> +			unlock_page(page);
> +		else {
> +			error = mapping->a_ops->readpage(in, page);
> +
> +			if (unlikely(error)) {
> +				page_cache_release(page);
> +				break;
> +			}
> +		}
> +		shadow[i] = page;
> +	}
> +
> +	if (!i) {
> +		for (i = 0; i < nr_pages; i++) {
> +			 if (shadow[i])
> +				page_cache_release(shadow[i]);
> +		}
> +		return 0;
> +	}

OK.

> +	memcpy(pages, shadow, i * sizeof(struct page *));

If we hit oom above, there can be live page*'s in shadow[], between the
current value of `i' and the now-lost return from find_get_pages().

The pages will leak.

> +
> +/*
> + * Send 'len' bytes to socket from 'file' at position 'pos' using sendpage().

sd->len, actually.

> + */
> +static int pipe_to_sendpage(struct pipe_inode_info *info,
> +			    struct pipe_buffer *buf, struct splice_desc *sd)
> +{
> +	struct file *file = sd->file;
> +	loff_t pos = sd->pos;
> +	unsigned int offset;
> +	ssize_t ret;
> +	void *ptr;
> +
> +	/*
> +	 * sub-optimal, but we are limited by the pipe ->map. we don't
> +	 * need a kmap'ed buffer here, we just want to make sure we
> +	 * have the page pinned if the pipe page originates from the
> +	 * page cache
> +	 */
> +	ptr = buf->ops->map(file, info, buf);
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +
> +	offset = pos & ~PAGE_CACHE_MASK;
> +
> +	ret = file->f_op->sendpage(file, buf->page, offset, sd->len, &pos,
> +					sd->len < sd->total_len);
> +
> +	buf->ops->unmap(info, buf);
> +	if (ret == sd->len)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +/*
> + * This is a little more tricky than the file -> pipe splicing. There are
> + * basically three cases:
> + *
> + *	- Destination page already exists in the address space and there
> + *	  are users of it. For that case we have no other option that
> + *	  copying the data. Tough luck.
> + *	- Destination page already exists in the address space, but there
> + *	  are no users of it. Make sure it's uptodate, then drop it. Fall
> + *	  through to last case.
> + *	- Destination page does not exist, we can add the pipe page to
> + *	  the page cache and avoid the copy.
> + *
> + * For now we just do the slower thing and always copy pages over, it's
> + * easier than migrating pages from the pipe to the target file. For the
> + * case of doing file | file splicing, the migrate approach had some LRU
> + * nastiness...
> + */
> +static int pipe_to_file(struct pipe_inode_info *info, struct pipe_buffer *buf,
> +			struct splice_desc *sd)
> +{
> +	struct file *file = sd->file;
> +	struct address_space *mapping = file->f_mapping;
> +	unsigned int offset;
> +	struct page *page;
> +	char *src, *dst;
> +	pgoff_t index;
> +	int ret;
> +
> +	/*
> +	 * after this, page will be locked and unmapped
> +	 */
> +	src = buf->ops->map(file, info, buf);
> +	if (IS_ERR(src))
> +		return PTR_ERR(src);
> +
> +	index = sd->pos >> PAGE_CACHE_SHIFT;
> +	offset = sd->pos & ~PAGE_CACHE_MASK;
> +
> +find_page:
> +	ret = -ENOMEM;
> +	page = find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
> +	if (!page)
> +		goto out;
> +
> +	/*
> +	 * If the page is uptodate, it is also locked. If it isn't
> +	 * uptodate, we can mark it uptodate if we are filling the
> +	 * full page. Otherwise we need to read it in first...
> +	 */
> +	if (!PageUptodate(page)) {
> +		if (sd->len < PAGE_CACHE_SIZE) {
> +			ret = mapping->a_ops->readpage(file, page);
> +			if (unlikely(ret))
> +				goto out;
> +
> +			lock_page(page);
> +
> +			if (!PageUptodate(page)) {
> +				/*
> +				 * page got invalidated, repeat
> +				 */
> +				if (!page->mapping) {
> +					unlock_page(page);
> +					page_cache_release(page);
> +					goto find_page;
> +				}
> +				ret = -EIO;
> +				goto out;
> +			}
> +		} else {
> +			WARN_ON(!PageLocked(page));
> +			SetPageUptodate(page);
> +		}
> +	}
> +
> +	ret = mapping->a_ops->prepare_write(file, page, 0, sd->len);
> +	if (ret)
> +		goto out;
> +
> +	dst = kmap_atomic(page, KM_USER0);
> +	memcpy(dst + offset, src + buf->offset, sd->len);
> +	flush_dcache_page(page);
> +	kunmap_atomic(dst, KM_USER0);
> +
> +	ret = mapping->a_ops->commit_write(file, page, 0, sd->len);
> +	if (ret < 0)
> +		goto out;
> +
> +	set_page_dirty(page);
> +	ret = write_one_page(page, 0);

Still want to know why this is here??

> +out:
> +	if (ret < 0)
> +		unlock_page(page);

If write_one_page()'s call to ->writepage() failed, this will cause a
double unlock.

> +	page_cache_release(page);
> +	buf->ops->unmap(info, buf);
> +	return ret;
> +}
> +
> +

