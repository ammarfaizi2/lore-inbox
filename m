Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319010AbSIIXq4>; Mon, 9 Sep 2002 19:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSIIXq4>; Mon, 9 Sep 2002 19:46:56 -0400
Received: from citi.umich.edu ([141.211.92.141]:59759 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S319010AbSIIXqz>;
	Mon, 9 Sep 2002 19:46:55 -0400
Date: Mon, 9 Sep 2002 19:51:40 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <E17oWsf-0006vQ-00@starship>
Message-ID: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Daniel Phillips wrote:

> On Tuesday 10 September 2002 00:03, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > > I'm very unkeen about using the inaccurate invalidate_inode_pages
> > > > for anything which matters, really.   And the consistency of pagecache
> > > > data matters.
> > > >
> > > > NFS should be using something stronger.  And that's basically
> > > > vmtruncate() without the i_size manipulation.
> > >
> > > Yes, that looks good.  Semantics are basically "and don't come back
> > > until every damm page is gone" which is enforced by the requirement
> > > that we hold the mapping->page_lock though one entire scan of the
> > > truncated region.  (Yes, I remember sweating this one out a year
> > > or two ago so it doesn't eat 100% CPU on regular occasions.)
> > >
> > > So, specifically, we want:
> > >
> > > void invalidate_inode_pages(struct inode *inode)
> > > {
> > >         truncate_inode_pages(mapping, 0);
> > > }
> > >
> > > Is it any harder than that?
> >
> > Pretty much - need to leave i_size where it was.
>
> This doesn't touch i_size.
>
> > But there are
> > apparently reasons why NFS cannot sleepingly lock pages in this particular
> > context.
>
> If only we knew what those were.  It's hard to keep the word 'bogosity'
> from popping into my head.

rpciod must never call a function that sleeps.  if this happens, the whole
NFS client stops working until the function wakes up again.  this is not
really bogus -- it is similar to restrictions placed on socket callbacks.

async RPC tasks (ie, the rpciod process) invokes invalidate_inode_pages
during normal, everyday processing, so it must not sleep.  that's why it
today ignores locked pages.

thus:

1.  whatever function purges a file's cached data must not sleep when
    invoked from an async RPC task.  likewise, such a function must not
    sleep if the caller holds the file's i_sem.

2.  access to the file must be serialized somehow with in-flight I/O
    (locked pages).  we don't want to start new reads before all dirty
    pages have been flushed back to the server.  dirty pages that have
    not yet been scheduled must be dealt with correctly.

3.  mmap'd pages must behave reasonably when a file's cache is purged.
    clean pages should be faulted back in.  what to do with dirty mmap'd
    pages?

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

