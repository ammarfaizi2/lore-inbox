Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWD1L1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWD1L1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWD1L1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:27:55 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:36566 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965086AbWD1L1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:27:54 -0400
Message-ID: <346223668.21667@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 28 Apr 2006 19:28:35 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060428112835.GA8072@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
	linux-mm@kvack.org
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426131200.516cbabc.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:12:00PM -0700, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > With a 16-page gang lookup in splice, the top profile for the 4-client
> > case (which is now at 4GiB/sec instead of 3) are:
> > 
> > samples  %        symbol name
> > 30396    36.7217  __do_page_cache_readahead
> > 25843    31.2212  find_get_pages_contig
> > 9699     11.7174  default_idle
> 
> __do_page_cache_readahead() should use gang lookup.  We never got around to
> that, mainly because nothing really demonstrated a need.

I have been testing a patch for this for a while. The new function
looks like

static int
__do_page_cache_readahead(struct address_space *mapping, struct file *filp,
			pgoff_t offset, unsigned long nr_to_read)
{
	struct inode *inode = mapping->host;
	struct page *page;
	LIST_HEAD(page_pool);
	pgoff_t last_index;	/* The last page we want to read */
	pgoff_t hole_index;
	int ret = 0;
	loff_t isize = i_size_read(inode);

	last_index = ((isize - 1) >> PAGE_CACHE_SHIFT);

	if (unlikely(!isize || !nr_to_read))
		goto out;
	if (unlikely(last_index < offset))
		goto out;

	if (last_index > offset + nr_to_read - 1 &&
		offset < offset + nr_to_read)
		last_index = offset + nr_to_read - 1;

	/*
	 * Go through ranges of holes and preallocate all the absent pages.
	 */
next_hole_range:
	cond_resched();

	read_lock_irq(&mapping->tree_lock);
	hole_index = radix_tree_scan_hole(&mapping->page_tree,
					offset, last_index - offset + 1);

	if (hole_index > last_index) {	/* no more holes? */
		read_unlock_irq(&mapping->tree_lock);
		goto submit_io;
	}

	offset = radix_tree_scan_data(&mapping->page_tree, (void **)&page,
						hole_index, last_index);
	read_unlock_irq(&mapping->tree_lock);

	ddprintk("ra range %lu-%lu(%p)-%lu\n", hole_index, offset, page, last_index);

	for (;;) {
                page = page_cache_alloc_cold(mapping);
		if (!page)
			break;

		page->index = hole_index;
		list_add(&page->lru, &page_pool);
		ret++;
		BUG_ON(ret > nr_to_read);

		if (hole_index >= last_index)
			break;

		if (++hole_index >= offset)
			goto next_hole_range;
	}

submit_io:
	/*
	 * Now start the IO.  We ignore I/O errors - if the page is not
	 * uptodate then the caller will launch readpage again, and
	 * will then handle the error.
	 */
	if (ret)
		read_pages(mapping, filp, &page_pool, ret);
	BUG_ON(!list_empty(&page_pool));
out:
	return ret;
}

The radix_tree_scan_data()/radix_tree_scan_hole() functions called
above are more flexible than the original __lookup(). Perhaps we can
rebase radix_tree_gang_lookup() and find_get_pages_contig() on them.

If it is deemed ok, I'll clean it up and submit the patch asap.

Thanks,
Wu
