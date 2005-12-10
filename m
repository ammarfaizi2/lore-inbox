Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVLJA2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVLJA2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVLJA2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:28:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932535AbVLJA2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:28:48 -0500
Date: Fri, 9 Dec 2005 16:29:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] vm: enhance __alloc_pages to prioritize pagecache
 eviction when pressed for memory
Message-Id: <20051209162901.71728620.akpm@osdl.org>
In-Reply-To: <20051207220401.GB13577@hmsreliant.homelinux.net>
References: <20051207220401.GB13577@hmsreliant.homelinux.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> wrote:
>
> Hey all-
>      I was recently shown this issue, wherein, if the kernel was kept full of
> pagecache via applications that were constantly writing large amounts of data to
> disk, the box could find itself in a position where the vm, in __alloc_pages
> would invoke the oom killer repetatively within try_to_free_pages, until such
> time as the box had no candidate processes left to kill, at which point it would
> panic.

That's pretty bad.  Are you able to provide a description which would permit
others to reproduce this?

>  /*
> + * Writeback nr_pages from pagecache to disk synchronously
> + * blocks until the writeback is complete
> + */
> +void clean_pagecache(long nr_pages)
> +{
> +	struct writeback_control wbc = {
> +		.bdi            = NULL,
> +		.sync_mode      = WB_SYNC_ALL,
> +		.older_than_this = NULL,
> +		.nr_to_write    = nr_pages,
> +		.nonblocking    = 0,
> +	};
> +
> +	writeback_inodes(&wbc);
> +}

Interesting.

> +/*
>   * Start writeback of `nr_pages' pages.  If `nr_pages' is zero, write back
>   * the whole world.  Returns 0 if a pdflush thread was dispatched.  Returns
>   * -1 if all pdflush threads were busy.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -949,6 +949,16 @@ rebalance:
>  	reclaim_state.reclaimed_slab = 0;
>  	p->reclaim_state = &reclaim_state;
>  
> +	/*
> +	 * We're pinched for memory, so before we try to reclaim some 
> +	 * pages synchronously, lets try to force some more pages out
> +	 * of pagecache, to raise our chances of this succeding.
> +	 * specifically, lets write out the number of pages that this
> +	 * allocation is requesting, in the hopes that they will be
> +	 * contiguous
> +	 */
> +	clean_pagecache(1<<order);
> +
>  	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);

I suspect that we shuld be passing more than (1<<order) into
clean_pagecache() - if we're going to do this sort of writeback then we
might as well do a decent amount.  Maybe something like (number of pages on
the eligible LRUs * proportion of dirty memory) or something.  But then,
page reclaim does writeback off the LRU, so none of this should be
needed...   Need to work out why it broke.

And we should not be calling into filesystem writeback unless the caller
specified __GFP_FS.
