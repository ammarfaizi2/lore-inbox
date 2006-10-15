Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWJOL47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJOL47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWJOL47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 07:56:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:57324 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932104AbWJOL46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 07:56:58 -0400
Date: Sun, 15 Oct 2006 13:56:56 +0200
From: Nick Piggin <npiggin@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
Message-ID: <20061015115656.GA25243@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site> <20061013143616.15438.77140.sendpatchset@linux.site> <1160912230.5230.23.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160912230.5230.23.camel@lappy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 01:37:10PM +0200, Peter Zijlstra wrote:
> On Fri, 2006-10-13 at 18:44 +0200, Andrew Morton wrote:
> > The idea is to modify the core write() code so that it won't take a pagefault
> > while holding a lock on the pagecache page. There are a number of different
> > deadlocks possible if we try to do such a thing:
> > 
> > 1.  generic_buffered_write
> > 2.   lock_page
> > 3.    prepare_write
> > 4.     unlock_page+vmtruncate
> > 5.     copy_from_user
> > 6.      mmap_sem(r)
> > 7.       handle_mm_fault
> > 8.        lock_page (filemap_nopage)
> > 9.    commit_write
> > 1.   unlock_page
> > 
> > b. sys_munmap / sys_mlock / others
> > c.  mmap_sem(w)
> > d.   make_pages_present
> > e.    get_user_pages
> > f.     handle_mm_fault
> > g.      lock_page (filemap_nopage)
> > 
> > 2,8	- recursive deadlock if page is same
> > 2,8;2,7	- ABBA deadlock is page is different
> 
> 2,8;2,8 I think you mean

Right. I've asked akpm to make a note of it (I don't think I can send a
meta-patch ;))

> > +		/*
> > +		 * Must not enter the pagefault handler here, because we hold
> > +		 * the page lock, so we might recursively deadlock on the same
> > +		 * lock, or get an ABBA deadlock against a different lock, or
> > +		 * against the mmap_sem (which nests outside the page lock).
> > +		 * So increment preempt count, and use _atomic usercopies.
> > +		 */
> > +		inc_preempt_count();
> >  		if (likely(nr_segs == 1))
> > -			copied = filemap_copy_from_user(page, offset,
> > +			copied = filemap_copy_from_user_atomic(page, offset,
> >  							buf, bytes);
> >  		else
> > -			copied = filemap_copy_from_user_iovec(page, offset,
> > -						cur_iov, iov_offset, bytes);
> > +			copied = filemap_copy_from_user_iovec_atomic(page,
> > +						offset, cur_iov, iov_offset,
> > +						bytes);
> > +		dec_preempt_count();
> > +
> 
> Why use raw {inc,dec}_preempt_count() and not
> preempt_{disable,enable}()? Is the compiler barrier not needed here? And
> do we really want to avoid the preempt_check_resched()?

Counter to intuition, we actually don't mind being preempted here,
but we do mind entering the (core) pagefault handler. Incrementing
the preempt count causes the arch specific handler to bail out early
before it takes any locks.

Clear as mud? Wrapping it in a better name might be an improvement?
Or wrapping it into the copy*user_atomic functions themselves (which
is AFAIK the only place we use it).

> > Index: linux-2.6/mm/filemap.h
> > ===================================================================
> > --- linux-2.6.orig/mm/filemap.h
> > +++ linux-2.6/mm/filemap.h
> > @@ -22,19 +22,19 @@ __filemap_copy_from_user_iovec_inatomic(

> > +/*
> > + * This has the same sideeffects and return value as
> > + * filemap_copy_from_user_nonatomic().
> > + * The difference is that on a fault we need to memset the remainder of the
> > + * page (out to offset+bytes), to emulate filemap_copy_from_user_nonatomic()'s
> > + * single-segment behaviour.
> > + */
> > +static inline size_t
> > +filemap_copy_from_user_iovec_nonatomic(struct page *page, unsigned long offset,
> > +			const struct iovec *iov, size_t base, size_t bytes)
> > +{
> > +	char *kaddr;
> > +	size_t copied;
> > +
> > +	kaddr = kmap(page);
> > +	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
> > +							 base, bytes);
> > +	kunmap(page);
> >  	return copied;
> >  }
> >  
> 
> Why create the _nonatomic versions? There are no users.

This was leftover from Andrew's patch... maybe filemap_xip wants it and
I've forgotten about it?

