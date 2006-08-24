Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWHXOm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWHXOm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWHXOm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:42:56 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:15964 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932121AbWHXOmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:42:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eqQwMaa6efvaNHKWasyz6slZuyVQgB2exnXQDPForgvSrS2xhsRkAJjXOeyjRuqNse41BKPoEBys0OGh78YWggDp7X9eN5zOOJNAHWpHNZRlUvIlxC4Pd7lMjQ3pz9wJ3AKZKTJl8XjIezWqUAlAmXJuhDhe7LlpcPxqYSBr/rI=  ;
Message-ID: <44EDBAC6.3090809@yahoo.com.au>
Date: Fri, 25 Aug 2006 00:42:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
References: <32640.1156424442@warthog.cambridge.redhat.com>
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
[...]

Cool. How much RAM does it save?

> --- /dev/null
> +++ b/fs/no-block.c
> @@ -0,0 +1,160 @@
> +/* no-block.c: implementation of routines required for non-BLOCK configuration
> + *
> + * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/mpage.h>
> +#include <linux/writeback.h>
> +#include <linux/backing-dev.h>
> +#include <linux/pagevec.h>
> +#include <linux/pagemap.h>
> +
> +/**
> + * generic_writepages - walk the list of dirty pages of the given
> + *                      address space and writepage() all of them.
> + * 
> + * @mapping: address space structure to write
> + * @wbc: subtract the number of written pages from *@wbc->nr_to_write
> + *
> + * This is a library function, which implements the writepages()
> + * address_space_operation.
> + *
> + * If a page is already under I/O, generic_writepages() skips it, even
> + * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
> + * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
> + * and msync() need to guarantee that all the data which was dirty at the time
> + * the call was made get new I/O started against them.  If wbc->sync_mode is
> + * WB_SYNC_ALL then we were called for data integrity and we must wait for
> + * existing IO to complete.
> + */
> +int generic_writepages(struct address_space *mapping,
> +		       struct writeback_control *wbc)

This isn't the right thing to do. Even just ifdefing the bio stuff would
seem better... but you didn't seem shy about adding ifdefs in other code,
so what is the problem with doing it here?

You also forgot to put akpm in your copyright notice, fwiw.

> +{
> +	struct backing_dev_info *bdi = mapping->backing_dev_info;
> +	int ret = 0;
> +	int done = 0;
> +	int (*writepage)(struct page *page, struct writeback_control *wbc);
> +	struct pagevec pvec;
> +	int nr_pages;
> g+	pgoff_t index;
> +	pgoff_t end;		/* Inclusive */
> +	int scanned = 0;
> +	int range_whole = 0;
> +
> +	if (wbc->nonblocking && bdi_write_congested(bdi)) {
> +		wbc->encountered_congestion = 1;
> +		return 0;
> +	}
> +
> +	writepage = mapping->a_ops->writepage;
> +
> +	/* deal with chardevs and other special file */
> +	if (!writepage)
> +		return 0;
> +
> +	pagevec_init(&pvec, 0);
> +	if (wbc->range_cyclic) {
> +		index = mapping->writeback_index; /* Start from prev offset */
> +		end = -1;
> +	} else {
> +		index = wbc->range_start >> PAGE_CACHE_SHIFT;
> +		end = wbc->range_end >> PAGE_CACHE_SHIFT;
> +		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
> +			range_whole = 1;
> +		scanned = 1;
> +	}
> +retry:
> +	while (!done && (index <= end) &&
> +			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> +			PAGECACHE_TAG_DIRTY,
> +			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
> +		unsigned i;
> +
> +		scanned = 1;
> +		for (i = 0; i < nr_pages; i++) {
> +			struct page *page = pvec.pages[i];
> +
> +			/*
> +			 * At this point we hold neither mapping->tree_lock nor
> +			 * lock on the page itself: the page may be truncated or
> +			 * invalidated (changing page->mapping to NULL), or even
> +			 * swizzled back from swapper_space to tmpfs file
> +			 * mapping
> +			 */
> +
> +			lock_page(page);
> +
> +			if (unlikely(page->mapping != mapping)) {
> +				unlock_page(page);
> +				continue;
> +			}
> +
> +			if (!wbc->range_cyclic && page->index > end) {
> +				done = 1;
> +				unlock_page(page);
> +				continue;
> +			}
> +
> +			if (wbc->sync_mode != WB_SYNC_NONE)
> +				wait_on_page_writeback(page);
> +
> +			if (PageWriteback(page) ||
> +					!clear_page_dirty_for_io(page)) {
> +				unlock_page(page);
> +				continue;
> +			}
> +
> +			ret = (*writepage)(page, wbc);
> +			if (ret) {
> +				if (ret == -ENOSPC)
> +					set_bit(AS_ENOSPC, &mapping->flags);
> +				else
> +					set_bit(AS_EIO, &mapping->flags);
> +			}
> +
> +			if (unlikely(ret == AOP_WRITEPAGE_ACTIVATE))
> +				unlock_page(page);
> +			if (ret || (--(wbc->nr_to_write) <= 0))
> +				done = 1;
> +			if (wbc->nonblocking && bdi_write_congested(bdi)) {
> +				wbc->encountered_congestion = 1;
> +				done = 1;
> +			}
> +		}
> +		pagevec_release(&pvec);
> +		cond_resched();
> +	}
> +	if (!scanned && !done) {
> +		/*
> +		 * We hit the last page and there is more work to be done: wrap
> +		 * back to the start of the file
> +		 */
> +		scanned = 1;
> +		index = 0;
> +		goto retry;
> +	}
> +	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
> +		mapping->writeback_index = index;
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL(generic_writepages);

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
