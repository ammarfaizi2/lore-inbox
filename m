Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSIJBJi>; Mon, 9 Sep 2002 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319003AbSIJBJi>; Mon, 9 Sep 2002 21:09:38 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:47043 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318972AbSIJBJg>;
	Mon, 9 Sep 2002 21:09:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chuck Lever <cel@citi.umich.edu>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 03:07:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu>
In-Reply-To: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oZUa-0006wh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 01:51, Chuck Lever wrote:
> On Tue, 10 Sep 2002, Daniel Phillips wrote:
> > On Tuesday 10 September 2002 00:03, Andrew Morton wrote:
> > > But there are
> > > apparently reasons why NFS cannot sleepingly lock pages in this
> > > particular context.
> >
> > If only we knew what those were.  It's hard to keep the word 'bogosity'
> > from popping into my head.
> 
> rpciod must never call a function that sleeps.  if this happens, the whole
> NFS client stops working until the function wakes up again.  this is not
> really bogus -- it is similar to restrictions placed on socket callbacks.

Ah, a warm body with answers :-)

It *sounds* bogus: why should we be satisfied with a function that doesn't
do its job reliably (invalidate_inode_pages) in order to avoid coming up
with a way of keeping the client daemon from blocking?  How about having
invalidate_inode_pages come back with "sorry boss, I couldn't complete the
job so I started as much IO as I could and I'm back now, try again later"?

> async RPC tasks (ie, the rpciod process) invokes invalidate_inode_pages
> during normal, everyday processing, so it must not sleep.  that's why it
> today ignores locked pages.

OK, that's half the job, the other half is to know that something's been
ignored, and get back to it later.  Either there is a valid reason for 
getting rid of these pages or there isn't, and if there is a valid reason,
then getting rid of only some of them must surely leave the door wide
open to strange misbehaviour.

> thus:
> 
> 1.  whatever function purges a file's cached data must not sleep when
>     invoked from an async RPC task.

[otherwise other tasks using the client will stall needlessly]

>     ...likewise, such a function must not
>     sleep if the caller holds the file's i_sem.
> 
> 2.  access to the file must be serialized somehow with in-flight I/O
>     (locked pages).  we don't want to start new reads before all dirty
>     pages have been flushed back to the server.  dirty pages that have
>     not yet been scheduled must be dealt with correctly.

State machine!

> 3.  mmap'd pages must behave reasonably when a file's cache is purged.
>     clean pages should be faulted back in.  what to do with dirty mmap'd
>     pages?

I don't know, sorry.  What?

You've probably been through this before, but could you please explain
the ground rules behind the cache purging strategy?

-- 
Daniel
