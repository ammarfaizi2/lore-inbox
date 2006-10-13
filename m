Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWJMWQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWJMWQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWJMWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:16:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751945AbWJMWQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:16:06 -0400
Date: Fri, 13 Oct 2006 15:14:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
Message-Id: <20061013151457.81bb7f03.akpm@osdl.org>
In-Reply-To: <20061013143616.15438.77140.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	<20061013143616.15438.77140.sendpatchset@linux.site>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 18:44:52 +0200 (CEST)
Nick Piggin <npiggin@suse.de> wrote:

> From: Andrew Morton <akpm@osdl.org> and Nick Piggin <npiggin@suse.de>
> 
> The idea is to modify the core write() code so that it won't take a pagefault
> while holding a lock on the pagecache page. There are a number of different
> deadlocks possible if we try to do such a thing:
> 
> 1.  generic_buffered_write
> 2.   lock_page
> 3.    prepare_write
> 4.     unlock_page+vmtruncate
> 5.     copy_from_user
> 6.      mmap_sem(r)
> 7.       handle_mm_fault
> 8.        lock_page (filemap_nopage)
> 9.    commit_write
> 1.   unlock_page
> 
> b. sys_munmap / sys_mlock / others
> c.  mmap_sem(w)
> d.   make_pages_present
> e.    get_user_pages
> f.     handle_mm_fault
> g.      lock_page (filemap_nopage)
> 
> 2,8	- recursive deadlock if page is same
> 2,8;2,7	- ABBA deadlock is page is different
> 2,6;c,g	- ABBA deadlock if page is same
> 
> - Instead of copy_from_user(), use inc_preempt_count() and
>   copy_from_user_inatomic().
> 
> - If the copy_from_user_inatomic() hits a pagefault, it'll return a short
>   copy.
> 
>   - if the page was not uptodate, we cannot commit the write, because the
>     uncopied bit could have uninitialised data. Commit zero length copy,
>     which should do the right thing (ie. not set the page uptodate).
> 
>   - if the page was uptodate, commit the copied portion so we make some
>     progress.
>     
>   - unlock_page()
> 
>   - go back and try to fault the page in again, redo the lock_page,
>     prepare_write, copy_from_user_inatomic(), etc.
> 
> - Now we have a non uptodate page, and we keep faulting on a 2nd or later
>   iovec, this gives a deadlock, because fault_in_pages readable only faults
>   in the first iovec. To fix this situation, if we fault on a !uptodate page,
>   make the next iteration only attempt to copy a single iovec.
> 
> - This also showed up a number of buggy prepare_write / commit_write
>   implementations that were setting the page uptodate in the prepare_write
>   side: bad! this allows uninitialised data to be read. Fix these.

Well.  It's non-buggy under the current protocol because the page remains
locked throughout.  This patch would make these ->prepare_write()
implementations buggy.

> +#ifdef CONFIG_DEBUG_VM
> +			fault_in_pages_readable(buf, bytes);
> +#endif

I'll need to remember to take that out later on.  Or reorder the patches, I
guess.

>  int simple_commit_write(struct file *file, struct page *page,
> -			unsigned offset, unsigned to)
> +			unsigned from, unsigned to)
>  {
> -	struct inode *inode = page->mapping->host;
> -	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> -
> -	/*
> -	 * No need to use i_size_read() here, the i_size
> -	 * cannot change under us because we hold the i_mutex.
> -	 */
> -	if (pos > inode->i_size)
> -		i_size_write(inode, pos);
> -	set_page_dirty(page);
> +	if (to > from) {
> +		struct inode *inode = page->mapping->host;
> +		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> +
> +		if (to - from == PAGE_CACHE_SIZE)
> +			SetPageUptodate(page);

This SetPageUptodate() can go away?

> @@ -2317,17 +2320,6 @@ int nobh_prepare_write(struct page *page
>  
>  	if (is_mapped_to_disk)
>  		SetPageMappedToDisk(page);
> -	SetPageUptodate(page);
> -
> -	/*
> -	 * Setting the page dirty here isn't necessary for the prepare_write
> -	 * function - commit_write will do that.  But if/when this function is
> -	 * used within the pagefault handler to ensure that all mmapped pages
> -	 * have backing space in the filesystem, we will need to dirty the page
> -	 * if its contents were altered.
> -	 */
> -	if (dirtied_it)
> -		set_page_dirty(page);
>  
>  	return 0;

Local variable `dirtied_it' can go away now.

Or can it?  We've modified the page's contents.  If the copy_from_user gets
a fault and we do a zero-length ->commit_write(), nobody ends up dirtying
the page.

> @@ -2450,6 +2436,7 @@ int nobh_truncate_page(struct address_sp
>  		memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
>  		flush_dcache_page(page);
>  		kunmap_atomic(kaddr, KM_USER0);
> +		SetPageUptodate(page);
>  		set_page_dirty(page);
>  	}
>  	unlock_page(page);

I've already forgotten why this was added.  Comment, please ;)
