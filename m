Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWJNETr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWJNETr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 00:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWJNETr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 00:19:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10930 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752058AbWJNETq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 00:19:46 -0400
Date: Sat, 14 Oct 2006 06:19:28 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
Message-ID: <20061014041927.GA14467@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site> <20061013143616.15438.77140.sendpatchset@linux.site> <20061013151457.81bb7f03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013151457.81bb7f03.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 03:14:57PM -0700, Andrew Morton wrote:
> On Fri, 13 Oct 2006 18:44:52 +0200 (CEST)
> Nick Piggin <npiggin@suse.de> wrote:
> > 
> > - This also showed up a number of buggy prepare_write / commit_write
> >   implementations that were setting the page uptodate in the prepare_write
> >   side: bad! this allows uninitialised data to be read. Fix these.
> 
> Well.  It's non-buggy under the current protocol because the page remains
> locked throughout.  This patch would make these ->prepare_write()
> implementations buggy.

But if it becomes uptodate, then do_generic_mapping_read can read it
without locking it (and so can filemap_nopage at present, although it
looks like that's going to take the page lock soon).

> > +#ifdef CONFIG_DEBUG_VM
> > +			fault_in_pages_readable(buf, bytes);
> > +#endif
> 
> I'll need to remember to take that out later on.  Or reorder the patches, I
> guess.
> 
> >  int simple_commit_write(struct file *file, struct page *page,
> > -			unsigned offset, unsigned to)
> > +			unsigned from, unsigned to)
> >  {
> > -	struct inode *inode = page->mapping->host;
> > -	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> > -
> > -	/*
> > -	 * No need to use i_size_read() here, the i_size
> > -	 * cannot change under us because we hold the i_mutex.
> > -	 */
> > -	if (pos > inode->i_size)
> > -		i_size_write(inode, pos);
> > -	set_page_dirty(page);
> > +	if (to > from) {
> > +		struct inode *inode = page->mapping->host;
> > +		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
> > +
> > +		if (to - from == PAGE_CACHE_SIZE)
> > +			SetPageUptodate(page);
> 
> This SetPageUptodate() can go away?

It is needed because the prepare_write does not try to bring the page
uptodate if it is a full page write. (I was considering another patch
to just remove that completely, as it might be overkill for something
like sysfs, but it demonstrates the principle quite nicely).

> 
> > @@ -2317,17 +2320,6 @@ int nobh_prepare_write(struct page *page
> >  
> >  	if (is_mapped_to_disk)
> >  		SetPageMappedToDisk(page);
> > -	SetPageUptodate(page);
> > -
> > -	/*
> > -	 * Setting the page dirty here isn't necessary for the prepare_write
> > -	 * function - commit_write will do that.  But if/when this function is
> > -	 * used within the pagefault handler to ensure that all mmapped pages
> > -	 * have backing space in the filesystem, we will need to dirty the page
> > -	 * if its contents were altered.
> > -	 */
> > -	if (dirtied_it)
> > -		set_page_dirty(page);
> >  
> >  	return 0;
> 
> Local variable `dirtied_it' can go away now.
> 
> Or can it?  We've modified the page's contents.  If the copy_from_user gets
> a fault and we do a zero-length ->commit_write(), nobody ends up dirtying
> the page.

But only if the page is not uptodate. Otherwise we won't modify its contents
(no need to).

> > @@ -2450,6 +2436,7 @@ int nobh_truncate_page(struct address_sp
> >  		memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
> >  		flush_dcache_page(page);
> >  		kunmap_atomic(kaddr, KM_USER0);
> > +		SetPageUptodate(page);
> >  		set_page_dirty(page);
> >  	}
> >  	unlock_page(page);
> 
> I've already forgotten why this was added.  Comment, please ;)

Well, nobh_prepare_write no longer sets it uptodate, so we need to if
we're going to set_page_dirty. OTOH, why does truncate_page need to
zero the pagecache anyway? I wonder if we couldn't delete this whole
function? (not in this patchset!)
