Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSIEVJz>; Thu, 5 Sep 2002 17:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSIEVJz>; Thu, 5 Sep 2002 17:09:55 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:35853 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318061AbSIEVJy>; Thu, 5 Sep 2002 17:09:54 -0400
Message-ID: <3D77C8B7.1534A2DB@zip.com.au>
Date: Thu, 05 Sep 2002 14:12:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C0A7.F74A89D0@zip.com.au> <15735.50124.304510.10612@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > Probably, it worked OK with the global locking because nobody
>      > was taking a temp ref against those pages.
> 
> But we still have global locking in that readdir by means of the
> BKL. There should be no nasty races...
> 
>      > Please tell me exactly what semantics NFS needs in there.  Does
>      > truncate_inode_pages() do the wrong thing?
> 
> Definitely. In most cases we *cannot* wait on I/O completion because
> nfs_zap_caches() can be called directly from the 'rpciod' process by
> means of a callback. Since 'rpciod' is responsible for completing all
> asynchronous I/O, then truncate_inode_pages() would deadlock.

But if there are such pages, invalidate_inode_pages() would not
have removed them anyway?

> As I said: I don't believe the problem here has anything to do with
> invalidate_inode_pages vs. truncate_inode_pages:
>   - Pages should only be locked if they are actually being read from
>     the server.
>   - They should only be refcounted and/or cleared while the BKL is
>     held...
> There is no reason why code which worked fine under 2.2.x and 2.4.x
> shouldn't work under 2.5.x.

Trond, there are very good reasons why it broke.  Those pages are
visible to the whole world via global data structures - both the 
page LRUs and via the superblocks->inodes walk.  Those things exist
for legitimate purposes, and it is legitimate for async threads
of control to take a reference on those pages while playing with them.

It just "happened to work" in earlier kernels.

I suspect we can just remove the page_count() test from invalidate
and that will fix everything up.  That will give stronger invalidate
and anything which doesn't like that is probably buggy wrt truncate anyway.

Could you test that?
