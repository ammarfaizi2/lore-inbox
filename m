Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWDBFW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWDBFW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDBFW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:22:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751312AbWDBFW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:22:26 -0500
Date: Sat, 1 Apr 2006 21:21:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-Id: <20060401212138.3b48f634.akpm@osdl.org>
In-Reply-To: <20060331123622.GB18093@opteron.random>
References: <43C484BF.2030602@yahoo.com.au>
	<20060111082359.GV15897@opteron.random>
	<20060111005134.3306b69a.akpm@osdl.org>
	<20060111090225.GY15897@opteron.random>
	<20060111010638.0eb0f783.akpm@osdl.org>
	<20060111091327.GZ15897@opteron.random>
	<Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
	<43C75834.3040007@yahoo.com.au>
	<20060112234726.676c3873.akpm@osdl.org>
	<43C782F3.1090803@yahoo.com.au>
	<20060331123622.GB18093@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Fri, Jan 13, 2006 at 09:37:39PM +1100, Nick Piggin wrote:
> > Andrew Morton wrote:
> > >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > >
> > >>(I guess reclaim might be one, but quite rare -- any other significant
> > >>lock_page users that we might hit?)
> > >
> > >
> > >The only time 2.6 holds lock_page() for a significant duration is when
> > >bringing the page uptodate with readpage or memset.
> > >
> > 
> > Yes that's what I thought. And we don't really need to worry about this
> > case because filemap_nopage has to deal with it anyway (ie. we shouldn't
> > see a locked !uptodate page in do_no_page).
> > 
> > >The scalability risk here is 100 CPUs all faulting in the same file in the
> > >same pattern.  Like the workload which caused the page_table_lock splitup
> > >(that was with anon pages).  All the CPUs could pretty easily get into sync
> > >and start arguing over every single page's lock.
> > >
> > 
> > Yes, but in that case they're still going to hit the tree_lock anyway, and
> > if they do have a chance of synching up, the cacheline bouncing from count
> > and mapcount accounting is almost as likely to cause it as the lock_page
> > itself.
> > 
> > I did a nopage microbenchmark like you describe a while back. IIRC single
> > threaded is 2.5 times *more* throughput than 64 CPUs, even when those 64 are
> > faulting their own NUMA memory (and obviously different pages). Thanks to
> > tree_lock.
> 
> This is the discussed patch that fixes the smp race between do_no_page
> and invalidate_inode_pages2.

Again, please try to provide as complete a possible description of a bug
when proposing a fix for it.

> As a reminder the race has seen the light of the day when
> invalidate_inode_pages2 started dropping pages from the pagecache
> without verifying that their page_count was 1 (i.e. only in pagecache)
> while keeping the tree_lock held (that's what shrink_list does). In the
> past (including 2.4) to implement invalidate_inode_pages2 we were
> clearing only the PG_uptdate/PG_dirty bitflags while leaving the page in
> pagecache exactly to avoid breaking such invariant. But that was
> allowing not uptodate pagecache to be mapped in userland. Now instead we
> enforced a new invariant that mapped pagecache has to be uptodate, so
> we've to add synchronization between invalidate_inode_pages2 and
> do_no_page using something else and not only the tree_lock + page_count.
> 
> Without this patch some pages could be mapped in userland without being
> part of pagecache and without being freeable as well despite being part
> of regular filebacked vmas. This was triggering crashes with sles9 after
> the last invalidate_inode_pages2 from mainline, because of the more
> restrictive checks with bug-ons in page_add_file_rmap equivalalents that
> requried page->mapping not to be null for pagecache. It looks inferior
> that you increase page->mapcount for things like the zeropage in
> mainline, instead of making sure to add only filebacked pages in the
> rmap layer and so verifying explicitly that page->mapping is not null in
> page_add_file_rmap.
> 
> The new PG_truncate bitflag can be used as well to eliminate the
> truncate_count from all vmas etc... that would save substantial memory
> and remove some complexity, truncate_count grown a lot since the time we
> introduced it.
> 
> The PG_truncate is needed as well because we can't know in do_no_page if
> page->mapping is legitimate null or not (think bttv and other device
> drivers returning page->mapping null because they're private but not
> reserved pages etc..)
> 
> From: Andrea Arcangeli <andrea@suse.de>
> Subject: avoid race between invalidate_inode_pages2 and do_no_page
> 
> Use page lock and new bitflag to serialize.
> 
> Signed-off-by: Andrea Arcangeli <andrea@suse.de>

afaict, the race is this:

invalidate_inode_pages2_range():		do_no_page():

	unmap_mapping_range(page)
						  filemap_nopage()
						    page_cache_lookup()
	invalidate_complete_page(page)
	  __remove_from_page_cache()
						install page in pagetables

yes?

The patch will pretty clearly fix that.  But it really would be better to
place all the cost over on the invalidate side, rather than adding overhead
to the pagefault path.

Could we perhaps check the page_count(page) and/or page_mapped(page) in
invalidate_complete_page(), when we have tree_lock?

Do you have handy any test code which others can use to recreate this bug?
