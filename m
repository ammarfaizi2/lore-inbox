Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSIEWVF>; Thu, 5 Sep 2002 18:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318626AbSIEWVF>; Thu, 5 Sep 2002 18:21:05 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:17678 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318622AbSIEWVE>; Thu, 5 Sep 2002 18:21:04 -0400
Message-ID: <3D77D960.12558B54@zip.com.au>
Date: Thu, 05 Sep 2002 15:23:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Lever <cel@citi.umich.edu>
CC: trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C0A7.F74A89D0@zip.com.au> <15735.50124.304510.10612@charged.uio.no> <3D77C8B7.1534A2DB@zip.com.au> <3D77D44C.8060109@citi.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> 
> Andrew Morton wrote:
> 
> > Trond, there are very good reasons why it broke.  Those pages are
> > visible to the whole world via global data structures - both the
> > page LRUs and via the superblocks->inodes walk.  Those things exist
> > for legitimate purposes, and it is legitimate for async threads
> > of control to take a reference on those pages while playing with them.
> >
> > It just "happened to work" in earlier kernels.
> >
> > I suspect we can just remove the page_count() test from invalidate
> > and that will fix everything up.  That will give stronger invalidate
> > and anything which doesn't like that is probably buggy wrt truncate anyway.
> >
> > Could you test that?
> 
> removing that test from invalidate_inode_pages allows test6 to run to
> 
> completion.

OK, thanks.  I bet adding an lru_cache_drain() fixes it too.
 
> however, i don't see why the reference counts should be higher in
> 
> 2.5.32 than they were in 2.5.31.

Those pages are sitting in the cpu-local "to be added to the LRU soon"
queue, with their refcount elevated.

That queue really only makes sense for SMP, but it's enabled on UP so
we pick up any weird effects.  Voila.

>  is there a good way to test that
> these pages do not become orphaned?

Not that I know of - just run the test for ages and see if the box
runs out of memory.
