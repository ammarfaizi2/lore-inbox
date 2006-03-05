Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752071AbWCEHRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbWCEHRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWCEHRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:17:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752071AbWCEHRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:17:11 -0500
Date: Sat, 4 Mar 2006 23:15:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/8] [I/OAT] Utility functions for offloading sk_buff to
 iovec copies
Message-Id: <20060304231537.26a9bc5a.akpm@osdl.org>
In-Reply-To: <20060303214227.11908.75473.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214227.11908.75473.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> +
> +#define NUM_PAGES_SPANNED(start, length) \
> +	((PAGE_ALIGN((unsigned long)start + length) - \
> +	((unsigned long)start & PAGE_MASK)) >> PAGE_SHIFT)

static inline all-lower-case functions are much nicer.

> +/*
> + * Lock down all the iovec pages needed for len bytes.
> + * Return a struct dma_locked_list to keep track of pages locked down.
> + *
> + * We are allocating a single chunk of memory, and then carving it up into
> + * 3 sections, the latter 2 whose size depends on the number of iovecs and the
> + * total number of pages, respectively.
> + */
> +int dma_lock_iovec_pages(struct iovec *iov, size_t len, struct dma_locked_list
> +	**locked_list)

Please rename this to dma_pin_iovec_pages().  Locking a page is a quite
different concept from pinning it, and this function doesn't lock any
pages.

> +{
> +	struct dma_locked_list *local_list;
> +	struct page **pages;
> +	int i;
> +	int ret;
> +
> +	int nr_iovecs = 0;
> +	int iovec_len_used = 0;
> +	int iovec_pages_used = 0;

Extraneous blank line there.

> +	/* don't lock down non-user-based iovecs */
> +	if (segment_eq(get_fs(), KERNEL_DS)) {
> +		*locked_list = NULL;
> +		return 0;
> +	}

hm, haven't seen that before.  Makes sense, I guess.

> +	/* determine how many iovecs/pages there are, up front */
> +	do {
> +		iovec_len_used += iov[nr_iovecs].iov_len;
> +		iovec_pages_used += NUM_PAGES_SPANNED(iov[nr_iovecs].iov_base,
> +		                                      iov[nr_iovecs].iov_len);
> +		nr_iovecs++;
> +	} while (iovec_len_used < len);
> +
> +	/* single kmalloc for locked list, page_list[], and the page arrays */
> +	local_list = kmalloc(sizeof(*local_list)
> +		+ (nr_iovecs * sizeof (struct dma_page_list))
> +		+ (iovec_pages_used * sizeof (struct page*)), GFP_KERNEL);

What is the upper bound on the size of this allocation?

> +	if (!local_list)
> +		return -ENOMEM;
> +
> +	/* list of pages starts right after the page list array */
> +	pages = (struct page **) &local_list->page_list[nr_iovecs];
> +
> +	/* it's a userspace pointer */
> +	might_sleep();

kmalloc(GFP_KERNEL) already did that.

> +	for (i = 0; i < nr_iovecs; i++) {
> +		struct dma_page_list *page_list = &local_list->page_list[i];
> +
> +		len -= iov[i].iov_len;
> +
> +		if (!access_ok(VERIFY_WRITE, iov[i].iov_base, iov[i].iov_len)) {
> +			dma_unlock_iovec_pages(local_list);
> +			return -EFAULT;
> +		}

A return statement buried down in the guts of a largeish function isn't
good from a code maintainability POV.

> +		page_list->nr_pages = NUM_PAGES_SPANNED(iov[i].iov_base,
> +		                                        iov[i].iov_len);
> +		page_list->base_address = iov[i].iov_base;
> +
> +		page_list->pages = pages;
> +		pages += page_list->nr_pages;
> +
> +		/* lock pages down */
> +		down_read(&current->mm->mmap_sem);
> +		ret = get_user_pages(
> +			current,
> +			current->mm,
> +			(unsigned long) iov[i].iov_base,
> +			page_list->nr_pages,
> +			1,
> +			0,
> +			page_list->pages,
> +			NULL);

Yes, it has a lot of args.  It's nice to add comments like this:

		ret = get_user_pages(
			current,
			current->mm,
			(unsigned long) iov[i].iov_base,
			page_list->nr_pages,
			1,			/* write */
			0,			/* force */
			page_list->pages,
			NULL);


> +		up_read(&current->mm->mmap_sem);
> +
> +		if (ret != page_list->nr_pages) {
> +			goto mem_error;
> +		}

Unneded braces.

> +		local_list->nr_iovecs = i + 1;
> +	}
> +
> +	*locked_list = local_list;
> +	return 0;

Suggest you change this function to return locked_list, or an IS_ERR value
on error.

> +void dma_unlock_iovec_pages(struct dma_locked_list *locked_list)
> +{
> +	int i, j;
> +
> +	if (!locked_list)
> +		return;
> +
> +	for (i = 0; i < locked_list->nr_iovecs; i++) {
> +		struct dma_page_list *page_list = &locked_list->page_list[i];
> +		for (j = 0; j < page_list->nr_pages; j++) {
> +			SetPageDirty(page_list->pages[j]);
> +			page_cache_release(page_list->pages[j]);
> +		}
> +	}
> +
> +	kfree(locked_list);
> +}

SetPageDirty() is very wrong.  It fails to mark pagecache pages as dirty in
the radix tree so they won't get written back.

You'll need to use set_page_dirty_lock() here or, if you happen to have
protected the inode which backs this potential mmap (really the
address_space) from reclaim then set_page_dirty() will work.  Probably
it'll be set_page_dirty_lock().

If this is called from cant-sleep context then things get ugly.  If it's
called from interrupt context then moreso.  See fs/direct-io.c,
bio_set_pages_dirty(), bio_check_pages_dirty(), etc.


I don't see a check for "did we write to user pages" here.  Because we
don't need to dirty the pages if we were reading them (transmitting from
userspace).

But given that dma_lock_iovec_pages() is only set up for writing to
userspace I guess this code is implicitly receive-only.  It's hard to tell
when the description, is, like the code comments, so scant.

> +static dma_cookie_t dma_memcpy_tokerneliovec(struct dma_chan *chan, struct
> +	iovec *iov, unsigned char *kdata, size_t len)

You owe us two underscores ;)

> +/*
> + * We have already locked down the pages we will be using in the iovecs.

"pinned"

> + * Each entry in iov array has corresponding entry in locked_list->page_list.
> + * Using array indexing to keep iov[] and page_list[] in sync.
> + * Initial elements in iov array's iov->iov_len will be 0 if already copied into
> + *   by another call.
> + * iov array length remaining guaranteed to be bigger than len.
> + */
> +dma_cookie_t dma_memcpy_toiovec(struct dma_chan *chan, struct iovec *iov,
> +	struct dma_locked_list *locked_list, unsigned char *kdata, size_t len)
> +{
> +	int iov_byte_offset;
> +	int copy;
> +	dma_cookie_t dma_cookie = 0;
> +	int iovec_idx;
> +	int page_idx;
> +
> +	if (!chan)
> +		return memcpy_toiovec(iov, kdata, len);
> +
> +	/* -> kernel copies (e.g. smbfs) */
> +	if (!locked_list)
> +		return dma_memcpy_tokerneliovec(chan, iov, kdata, len);
> +
> +	iovec_idx = 0;
> +	while (iovec_idx < locked_list->nr_iovecs) {
> +		struct dma_page_list *page_list;
> +
> +		/* skip already used-up iovecs */
> +		while (!iov[iovec_idx].iov_len)
> +			iovec_idx++;

Is it assured that this array was zero-terminated?

> +
> +dma_cookie_t dma_memcpy_pg_toiovec(struct dma_chan *chan, struct iovec *iov,
> +	struct dma_locked_list *locked_list, struct page *page,
> +	unsigned int offset, size_t len)

pleeeeeze comment your code.

> +{
> +	int iov_byte_offset;
> +	int copy;
> +	dma_cookie_t dma_cookie = 0;
> +	int iovec_idx;
> +	int page_idx;
> +	int err;
> +
> +	/* this needs as-yet-unimplemented buf-to-buff, so punt. */
> +	/* TODO: use dma for this */
> +	if (!chan || !locked_list) {

Really you should rename locked_list to pinned_list throughout, and
dma_locked_list to dma_pinned_list.

> +	iovec_idx = 0;
> +	while (iovec_idx < locked_list->nr_iovecs) {
> +		struct dma_page_list *page_list;
> +
> +		/* skip already used-up iovecs */
> +		while (!iov[iovec_idx].iov_len)
> +			iovec_idx++;

Can this also run off the end?

> +int dma_lock_iovec_pages(struct iovec *iov, size_t len, struct dma_locked_list
> +	**locked_list)
> +{
> +	*locked_list = NULL;
> +
> +	return 0;
> +}
> +
> +void dma_unlock_iovec_pages(struct dma_locked_list* locked_list)
> +{ }

You might want to make these guys static inlines in a header and not
compile this file at all if !CONFIG_DMA_ENGINE.

> +struct dma_page_list
> +{

   struct dma_page_list {

> +struct dma_locked_list
> +{

   struct dma_pinned_list {

> +	int nr_iovecs;
> +	struct dma_page_list page_list[0];

We can use [] instead of [0] now that gcc-2.95.x has gone away.

> +int dma_lock_iovec_pages(struct iovec *iov, size_t len,
> +	struct dma_locked_list	**locked_list);
> +void dma_unlock_iovec_pages(struct dma_locked_list* locked_list);

"pin", "unpin".

> +#ifdef CONFIG_NET_DMA
> +
> +/**
> + *	dma_skb_copy_datagram_iovec - Copy a datagram to an iovec.
> + *	@skb - buffer to copy
> + *	@offset - offset in the buffer to start copying from
> + *	@iovec - io vector to copy to
> + *	@len - amount of data to copy from buffer to iovec
> + *	@locked_list - locked iovec buffer data
> + *
> + *	Note: the iovec is modified during the copy.

Modifying the caller's iovec is a bit rude.    Hard to avoid, I guess.

> + */
> +int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
> +			struct sk_buff *skb, int offset, struct iovec *to,
> +			size_t len, struct dma_locked_list *locked_list)
> +{
> +	int start = skb_headlen(skb);
> +	int i, copy = start - offset;
> +	dma_cookie_t cookie = 0;
> +
> +	/* Copy header. */
> +	if (copy > 0) {
> +		if (copy > len)
> +			copy = len;
> +		if ((cookie = dma_memcpy_toiovec(chan, to, locked_list,
> +		     skb->data + offset, copy)) < 0)
> +			goto fault;
> +		if ((len -= copy) == 0)
> +			goto end;

Please avoid

	if ((lhs = rhs))

constructs.  Instead do

	lhs = rhs;
	if (lhs)

(entire patchset - there are quite a lot)

> +		offset += copy;
> +	}
> +
> +	/* Copy paged appendix. Hmm... why does this look so complicated? */
> +	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		int end;
> +
> +		BUG_TRAP(start <= offset + len);

<wonders why BUG_TRAP still exists>

> +		if ((copy = end - offset) > 0) {
> ...
> +			if (!(len -= copy))
> ...
> +			if ((copy = end - offset) > 0) {
> ...
> +				if ((len -= copy) == 0)
>

See above.

> +#else
> +
> +int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
> +			const struct sk_buff *skb, int offset, struct iovec *to,
> +			size_t len, struct dma_locked_list *locked_list)
> +{
> +	return skb_copy_datagram_iovec(skb, offset, to, len);
> +}
> +
> +#endif

Again, consider putting this in a header as an inline, avoid compiling this
file altogether.

