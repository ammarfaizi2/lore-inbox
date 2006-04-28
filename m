Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWD1RAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWD1RAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWD1RAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:51 -0400
Received: from [83.101.157.13] ([83.101.157.13]:48914 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751671AbWD1RAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:36 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockless page cache test results
Date: Fri, 28 Apr 2006 19:58:53 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604281958.53888.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> On Wed, Apr 26, 2006 at 01:12:00PM -0700, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > > With a 16-page gang lookup in splice, the top profile for the 4-client
> > > case (which is now at 4GiB/sec instead of 3) are:
> > >
> > > samples  %        symbol name
> > > 30396    36.7217  __do_page_cache_readahead
> > > 25843    31.2212  find_get_pages_contig
> > > 9699     11.7174  default_idle
> >
> > __do_page_cache_readahead() should use gang lookup.  We never got around
> > to that, mainly because nothing really demonstrated a need.
>
> I have been testing a patch for this for a while. The new function
> looks like
>
> static int
> __do_page_cache_readahead(struct address_space *mapping, struct file
> *filp, pgoff_t offset, unsigned long nr_to_read) {
>         struct inode *inode = mapping->host;
>         struct page *page;
>         LIST_HEAD(page_pool);
>         pgoff_t last_index;     /* The last page we want to read */
>         pgoff_t hole_index;
>         int ret = 0;
>         loff_t isize = i_size_read(inode);
>         last_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
>
>         if (unlikely(!isize || !nr_to_read))
>                 goto out;
>         if (unlikely(last_index < offset))
>                 goto out;
>         if (last_index > offset + nr_to_read - 1 &&
>                 offset < offset + nr_to_read)
>                 last_index = offset + nr_to_read - 1;
>         /*
>          * Go through ranges of holes and preallocate all the absent
> pages. */
> next_hole_range:
>         cond_resched();
>         read_lock_irq(&mapping->tree_lock);
>         hole_index = radix_tree_scan_hole(&mapping->page_tree,
>                                         offset, last_index - offset + 1);
>
>         if (hole_index > last_index) {  /* no more holes? */
>                 read_unlock_irq(&mapping->tree_lock);
>                 goto submit_io;
>         }
>         offset = radix_tree_scan_data(&mapping->page_tree, (void **)&page,
>                                                 hole_index, last_index);
>         read_unlock_irq(&mapping->tree_lock);
>
>         ddprintk("ra range %lu-%lu(%p)-%lu\n", hole_index, offset, page,
> last_index);
>
>         for (;;) {
>                 page = page_cache_alloc_cold(mapping);
>                 if (!page)
>                         break;
>                 page->index = hole_index;
>                 list_add(&page->lru, &page_pool);
>                 ret++;
>                 BUG_ON(ret > nr_to_read);
>                 if (hole_index >= last_index)
>                         break;
>                 if (++hole_index >= offset)
>                         goto next_hole_range;
>         }
> submit_io:
>         /*
>          * Now start the IO.  We ignore I/O errors - if the page is not
>          * uptodate then the caller will launch readpage again, and
>          * will then handle the error.
>          */
>         if (ret)
>                 read_pages(mapping, filp, &page_pool, ret);
>         BUG_ON(!list_empty(&page_pool));
> out:
>         return ret;
> }
> The radix_tree_scan_data()/radix_tree_scan_hole() functions called
> above are more flexible than the original __lookup(). Perhaps we can
> rebase radix_tree_gang_lookup() and find_get_pages_contig() on them.
>
> If it is deemed ok, I'll clean it up and submit the patch asap.

Can you patch it up for 2.6.16 asap?

Thanks!

--
Al

