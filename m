Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWDBE4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWDBE4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 23:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDBE4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 23:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751122AbWDBE4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 23:56:10 -0500
Date: Sat, 1 Apr 2006 20:55:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, neilb@suse.de, trond.myklebust@fys.uio.no
Subject: Re: [andrea@suse.de: Re: [NFS] Problems with mmap consistency]
Message-Id: <20060401205522.76f300c5.akpm@osdl.org>
In-Reply-To: <20060331124141.GC18093@opteron.random>
References: <20060331124141.GC18093@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Hello,
> 
> Just a reminder, the below patch should be applied to mainline (it's
> still missing according to my log).
> 

There's basically no description of what the patch does here.  Patches
which turn up in the middle of an email discussion tend to not get applied.
Normally someone will send a new patch with a reworked description once the
discussion has come to a conclusion.

> 
> I seem to remember I asked explanations on the "was_dirty" code in my
> first email on the subject (before noticing you also worked on the nfs
> part about at the same time ;), but I didn't get any answer.

It's all there in bk somewhere ;)

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm1/broken-out/invalidate_inode_pages-mmap-coherency-fix.patch

> I didn't check if this fixes the testcase, patch still untested sorry.
> 

Did it?

What was the testcase?

> 
> Index: sp3/mm/truncate.c
> --- sp3/mm/truncate.c.~1~	2006-02-23 06:31:14.000000000 +0100
> +++ sp3/mm/truncate.c	2006-02-24 04:36:02.000000000 +0100
> @@ -246,9 +246,14 @@ EXPORT_SYMBOL(invalidate_inode_pages);
>   * @start: the page offset 'from' which to invalidate
>   * @end: the page offset 'to' which to invalidate (inclusive)
>   * Any pages which are found to be mapped into pagetables are unmapped prior to
> - * invalidation.
> + * invalidation. invalidate_inode_pages2_range is non destructive and it can't
> + * lose dirty data (if dirty data exists -EIO will be returned). It's up to
> + * the caller to call unmap_mapping_range and filemap_write_and_wait before
> + * invalidate_inode_pages2 if needed.
>   *
> - * Returns -EIO if any pages could not be invalidated.
> + * Returns -EIO if any pages could not be invalidated. Before returning -EIO
> + * it tries invalidating all pages in the range, it doesn't stop at the first
> + * page invalidation failure.
>   */
>  int invalidate_inode_pages2_range(struct address_space *mapping,
>  			pgoff_t start, pgoff_t end)
> @@ -262,13 +267,12 @@ int invalidate_inode_pages2_range(struct
>  
>  	pagevec_init(&pvec, 0);
>  	next = start;
> -	while (next <= end && !ret && !wrapped &&
> +	while (next <= end && !wrapped &&
>  		pagevec_lookup(&pvec, mapping, next,
>  			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
> -		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
> +		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  			pgoff_t page_index;
> -			int was_dirty;
>  
>  			lock_page(page);
>  			if (page->mapping != mapping) {
> @@ -304,12 +308,9 @@ int invalidate_inode_pages2_range(struct
>  					  PAGE_CACHE_SIZE, 0);
>  				}
>  			}
> -			was_dirty = test_clear_page_dirty(page);
> -			if (!invalidate_complete_page(mapping, page)) {
> -				if (was_dirty)
> -					set_page_dirty(page);
> +
> +			if (!invalidate_complete_page(mapping, page))
>  				ret = -EIO;
> -			}
>  			unlock_page(page);
>  		}
>  		pagevec_release(&pvec);
> 

Two separate things are happening here.

a) We go all the way to the end of the range even if something went
   wrong partway through.  Why?

b) Remove the was_dirty logic.

   That's there to address the unmap-dirtyied-the-page-and-buffers
   problem described in the above changelog.  If that can happen then this
   patch will end up giving us a page which is marked clean but which in
   fact has dirty buffers.
  
