Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSIEWRU>; Thu, 5 Sep 2002 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSIEWRU>; Thu, 5 Sep 2002 18:17:20 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:17933 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318366AbSIEWRP>; Thu, 5 Sep 2002 18:17:15 -0400
Message-ID: <3D77D879.7F7A3385@zip.com.au>
Date: Thu, 05 Sep 2002 15:19:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C8B7.1534A2DB@zip.com.au> <15735.52512.886434.46650@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> ...
>      > Trond, there are very good reasons why it broke.  Those pages
>      > are visible to the whole world via global data structures -
>      > both the page LRUs and via the superblocks->inodes walk.  Those
>      > things exist for legitimate purposes, and it is legitimate for
>      > async threads of control to take a reference on those pages
>      > while playing with them.
> 
> I don't buy that explanation w.r.t. readdir: those pages should always
> be clean. The global data structures might walk them in order to throw
> them out, but that should be a bonus here.

It's not related to cleanliness - the VM evicts clean pages and
to do that it needs to manipulate them.  To manipulate them the
VM needs to pin them down: via spinlocks, via PageLocked or via
page_count().

And a 2.4 kernel right now will set PG_locked while looking at
a clean NFS directory page at the tail of the LRU.  A concurrent
invalidate_inode_page will not invalidate that page, so there
is exposure in 2.4 SMP.  Except everything is serialised under
the LRU lock in 2.4...

> In any case it seems a bit far fetched that they should be pinning
> *all* the readdir pages...
> 
>      > I suspect we can just remove the page_count() test from
>      > invalidate and that will fix everything up.  That will give
>      > stronger invalidate and anything which doesn't like that is
>      > probably buggy wrt truncate anyway.
> 
> I never liked the page_count() test, but Linus overruled me because of
> the concern for consistency w.r.t. shared mmap(). Is the latter case
> resolved now?

Oh, I see.

I'm not sure what semantics we really want for this.  If we were to
"invalidate" a mapped page then it would become anonymous, which
makes some sense.

But if we want to keep the current "don't detach mapped pages from
pagecache" semantics then we should test page->pte.direct rather than
page_count(page).  Making that 100% reliable would be tricky because
of the need for locking wrt concurrent page faults.

This only really matters (I think) for invalidate_inode_pages2(),
where we take down pagecache after O_DIRECT IO.  In that case I
suspect we _should_ anonymise mapped cache, because we've gone
and changed the data on-disk.

> I notice for instance that you've added mapping->releasepage().
> What should we be doing for that?

page->private is "anonymous data which only the address_space knows
about".

If the mapping has some data at page->private it must set PG_private
inside lock_page and increment page->count.

If the VM wants to reclaim a page, and it has PG_private set then
the vm will run mapping->releasepage() against the page.  The mapping's
releasepage must try to clear away whatever is held at ->private.  If
that was successful then releasepage() must clear PG_private, decrement
page->count and return non-zero.  If the info at ->private is not
freeable, releasepage returns zero.  ->releasepage() may not sleep in
2.5.

So.  NFS can put anything it likes at page->private.  If you're not
doing that then you don't need a releasepage.  If you are doing that
then you must have a releasepage().
