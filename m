Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWC3KRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWC3KRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWC3KRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:17:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751338AbWC3KRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:17:04 -0500
Date: Thu, 30 Mar 2006 02:16:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-Id: <20060330021644.7f7c5282.akpm@osdl.org>
In-Reply-To: <20060330100630.GT13476@suse.de>
References: <20060330100630.GT13476@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Hi,
> 
> This patch should resolve all issues mentioned so far. I'd still like to
> implement the page moving, but that should just be a separate patch.
> After this round of patching, I thought I'd toss a fresh version out
> there for all to look at.
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> ...
>
> --- a/arch/ia64/kernel/entry.S
> +++ b/arch/ia64/kernel/entry.S
> @@ -1605,5 +1605,6 @@ sys_call_table:
>  	data8 sys_ni_syscall			// reserved for pselect
>  	data8 sys_ni_syscall			// 1295 reserved for ppoll
>  	data8 sys_unshare
> +	date8 sys_splice

typo

> +static void *page_cache_pipe_buf_map(struct file *file,
> +				     struct pipe_inode_info *info,
> +				     struct pipe_buffer *buf)
> +{
> +	struct page *page = buf->page;
> +
> +	lock_page(page);
> +
> +	if (!PageUptodate(page)) {

 || page->mapping == NULL

> +	struct page *pages[PIPE_BUFFERS];
> +	struct page *page;
> +	pgoff_t index, pidx;
> +	int i;
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
> +	memset(&pages[i], 0, (nr_pages - i) * sizeof(struct page *));
> +
> +	/*
> +	 * find_get_pages() may not return consecutive pages, so loop
> +	 * over the array moving pages and filling the rest, if need be.
> +	 */
> +	for (i = 0, pidx = index; i < nr_pages; pidx++, i++) {
> +		if (!pages[i]) {
> +			int error;
> +fill_page:
> +			/*
> +			 * no page there, look one up / create it
> +			 */
> +			page = find_or_create_page(mapping, pidx,
> +						   mapping_gfp_mask(mapping));
> +			if (!page)
> +				break;
> +
> +			if (PageUptodate(page))
> +				unlock_page(page);
> +			else {
> +				error = mapping->a_ops->readpage(in, page);
> +
> +				if (unlikely(error)) {
> +					page_cache_release(page);
> +					break;
> +				}
> +			}
> +			pages[i] = page;
> +		} else if (pages[i]->index != pidx) {
> +			page = pages[i];
> +			/*
> +			 * page isn't in the right spot, move it and jump
> +			 * back to filling this one. we know that ->index
> +			 * is larger than pidx
> +			 */
> +			pages[i + page->index - pidx] = page;
> +			pages[i] = NULL;
> +			goto fill_page;
> +		}
> +	}
> +
> +	if (!i)
> +		return 0;
> +
> +	/*
> +	 * Now we splice them into the pipe..
> +	 */
> +splice_them:
> +	return move_to_pipe(pipe, pages, i, offset, len);
> +}

OK, and this returns the number of bytes transferred all the way up to
userspace.

And, like read(), if we hit an IO error or ENOMEM partway through we'll
just return a short read which is indistinguishable from EOF.

But if we do get an IO error, we'll detect it in page_cache_pipe_buf_map().
Does the code still follow these read() return value semantics in that
case?

> ...

argh, am all reviewed out, and infiniband isn't compiling.  Will look later.
