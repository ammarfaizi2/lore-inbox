Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTH1Ilo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTH1Iln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:41:43 -0400
Received: from dp.samba.org ([66.70.73.150]:42700 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263839AbTH1IEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:04:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Tue, 26 Aug 2003 23:20:39 MST."
             <20030826232039.626f5a4c.akpm@osdl.org> 
Date: Thu, 28 Aug 2003 10:47:36 +1000
Message-Id: <20030828080403.DC3272C640@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030826232039.626f5a4c.akpm@osdl.org> you write:
> >  I assumed that for non-anonymous pages the mapping + index was always
> >  a unique identifier, even as they were swapped out.  We need a
> >  persistent unique identifier for a page, OR a callback to
> >  unhash/rehash it when the identifier changes.  Hence mapping + index
> >  where mapping != NULL, and the struct page and callbacks for swap
> >  pages.  Using the callbacks for wherever else page->mapping changes is
> >  simple (but may be slow).
> 
> swap_writepage() and end_swap_bio_read() are not really companion
> functions.  The page is in use and may be mapped into user pagetables
> during swap_writepage().  It won't actually be freed up for a very long
> time, if at all.
> 
> I guess this means that there could be a large number of futexes which are
> considered "swapped out" which are in fact not swapped out at all.  
> 
> I'm starting to dimly understand what this code does.  You get 2/10 for
> patch explanation ;)

Heh, you get 4/10 for reading comprehension.  See: "Name: Futexes
without pinning pages" at the top of the patch.

lkml trains people to use Alan Cox-style maximal density descriptions,
to avoid being accused of insulting colleagues' intelligence (or being
accused of not being 31337 enough).  You seem to be cut of a different
cloth.  I will try to be more verbose here, and I think we'll all be
better for it.

> I think a better place to rehash the futex would be at the point where the
> page is added to and removed from swapcache.

This is simplest: the current code actually moves the futex queue out
of the hash.  If we make the rule: "call futex_rehash" every time
page->mapping (or page->index) changes, we avoid races and make the
code simpler.

But this means it could be called quite often.  One answer is to
restrict the futex hashing so we don't have to search the entire
table.  Another is to have a separate futexed pages hash.  The third
is to implement the "futex_was_here" bit in the page->flags, which I
think will work well in practice.  I'll implement it as a separate
patch however.

> Similarly, all places which change the page's hash keys (mapping and index)
> need to be locked against the futex lookup code.

Yes.  I'll look at everywhere that mapping is changed: thanks for the
hints [snipped].

> Please make sure it builds with CONFIG_SWAP=n
> 
> Please make sure it builds with CONFIG_FUTEX=n (sorry)

Will do.

> Please augment the lock ranking comment at the top of filemap.c

Yes.

> If a futex resides in a pagecache page which is then truncated, a
> futex_wake() should really send the caller a SIGBUS; it looks like the code
> will return -EFAULT, which is good enough.  Any waiters on that futex will
> not be wakeable, but they will be killable.

It would be nice, but it's not worth more than a couple of lines of
kernel code.  There's a similar case where one thread is waiting in an
mmapped file and it is unmapped by the other thread.  It's a
programmer bug since obviously noone can now wake the futex you're
waiting on...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
