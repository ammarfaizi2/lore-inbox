Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWEMHCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWEMHCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWEMHCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 03:02:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbWEMHCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 03:02:42 -0400
Date: Fri, 12 May 2006 23:59:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 002 of 8] md/bitmap: Remove bitmap writeback daemon.
Message-Id: <20060512235932.12f5a295.akpm@osdl.org>
In-Reply-To: <17509.20239.993465.843942@cse.unsw.edu.au>
References: <20060512160121.7872.patches@notabene>
	<1060512060736.8006@suse.de>
	<20060512104035.5fee4e66.akpm@osdl.org>
	<17509.20239.993465.843942@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Friday May 12, akpm@osdl.org wrote:
> > NeilBrown <neilb@suse.de> wrote:
> > >
> > >  ./drivers/md/bitmap.c         |  115 ++----------------------------------------
> > 
> > hmm.  I hope we're not doing any of that filesystem I/O within the context
> > of submit_bio() or kblockd or anything like that.  Looks OK from a quick
> > scan.
> 
> No.  We do all the I/O from the context of the per-array thread.

OK.

> However some IO requests cannot complete until the filesystem I/O
> completes, so we need to be sure that the filesystem I/O won't block
> waiting for memory, or fail with -ENOMEM.

That sounds like a complex deadlock.  Suppose the bitmap writeout requres
some writeback to happen before it can get enough memory to proceed.

> bitmap.c is currently trying to do something every different.
> It uses ->readpage to get pages in the page cache (even though some
> address spaces don't define ->readpage) and then holds onto those
> pages without holding the page lock, and then calls ->writepage to
> flush them out from time to time.

That's OK.

> Before calling writepage it gets the pagelock, but doesn't re-check
> that ->mapping is correct (there is nothing much it can do if it isn't
> correct..).

We do that to find out if the page was truncated while we ewre waiting for
the page lock.

> I noticed this is particularly a problem with tmpfs.  When you call
> writepage on a tmpfs page, the page is swizzled into the swap cache,
> and ->mapping becomes NULL - not the behaviour that bitmap is
> expecting.

You shouldn't call writepage on tmpfs.  If !bdi_cap_writeback_dirty(), your
write_page() should immediately give up and "succeed".  Because this
filesystem has no permanent backing store anyway.

tmpfs doesn't implement bmap(), so your new patch fixes that problem ;)

> > We normally use PAGE_CACHE_SIZE for these things, not PAGE_SIZE.  Same diff.
> > 
> 
> Yeah.... why is that?  Why have two names for exactly the same value?

I guess at one time it was thought that we could use a different unit size
for pagecache.  Nowadays we use it by convention - it has little more than
documentary value.

> How does a poor develop know when to use one and when the other?  More
> particularly, how does one remember.

If the page is a pagecache page, use PAGE_CACHE_SIZE.  There are a few
spots where it blurs, but not many.

> > If you have a page and you want to write the whole thing out then there's
> > really no need to run prepare_write or commit_write at all.  Just
> > initialise the whole page, run set_page_dirty() then write_one_page().
> > 
> 
> I see that now.  But only after locking the page, and rechecking that
> ->mapping is correct, and if it isn't .... well, more work is involved
> that bitmap is in a position to do.

If you've bumped i_writecount to block truncate then there's no need to
check for truncation after locking the page.

i_mutex could be used similarly.


