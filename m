Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSIJPFE>; Tue, 10 Sep 2002 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSIJPFD>; Tue, 10 Sep 2002 11:05:03 -0400
Received: from citi.umich.edu ([141.211.92.141]:25408 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S319190AbSIJPFB>;
	Tue, 10 Sep 2002 11:05:01 -0400
Date: Tue, 10 Sep 2002 11:09:47 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <E17oZUa-0006wh-00@starship>
Message-ID: <Pine.BSO.4.33.0209101036040.5887-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Daniel Phillips wrote:

> On Tuesday 10 September 2002 01:51, Chuck Lever wrote:
> > rpciod must never call a function that sleeps.  if this happens, the whole
> > NFS client stops working until the function wakes up again.  this is not
> > really bogus -- it is similar to restrictions placed on socket callbacks.
>
> Ah, a warm body with answers :-)
>
> It *sounds* bogus: why should we be satisfied with a function that doesn't
> do its job reliably (invalidate_inode_pages) in order to avoid coming up
> with a way of keeping the client daemon from blocking?  How about having
> invalidate_inode_pages come back with "sorry boss, I couldn't complete the
> job so I started as much IO as I could and I'm back now, try again later"?

i'm not suggesting that invalidate_inode_pages behaves properly, i'm
simply trying to document why it works the way it does.  i agree that it
leaves a window open for broken behavior today.  what is *not* bogus is
the requirement for functions invoked by async RPC tasks not to sleep;
that's reasonable, i feel.

> > thus:
> >
> > 1.  whatever function purges a file's cached data must not sleep when
> >     invoked from an async RPC task.
>
> [otherwise other tasks using the client will stall needlessly]

correct.

> > 3.  mmap'd pages must behave reasonably when a file's cache is purged.
> >     clean pages should be faulted back in.  what to do with dirty mmap'd
> >     pages?
>
> I don't know, sorry.  What?

'twas a rhetorical question.  i'm trying to understand this myself.  the
case of what to do with dirty mmap'd pages is somewhat sticky.

> You've probably been through this before, but could you please explain
> the ground rules behind the cache purging strategy?

i can answer the question "when does the NFS client purge a file's cached
data?"

there are four major categories:

a.  directory changes require any cached readdir results be purged.  this
    forces the readdir results to be re-read from the server the next time
    the client needs them.  this is what broke with the recent changes in
    2.5.32/3 that triggered this thread.

b.  when the client discovers a file on the server was changed by some
    other client, all pages in the page cache for that file are purged
    (except the ones that can't be because they are locked, etc).  this
    is the case that is hit most often and in async RPC tasks, and is
    on many critical performance paths.

c.  when a file is locked or unlocked via lockf/fcntl, all pending writes
    are pushed back to the server and any cached data in the page cache is
    purged before the lock/unlock call returns.  applications sometimes
    depend on this behavior to checkpoint the client's cache.

d.  some error occurred while reading a directory, or the object on the
    server has changed type (like, a file becomes a directory but the
    file handle is still the same -- a protocol error, but the client
    checks for this just in case).

so let's talk about b.  before and after many operations, the NFS client
attempts to revalidate an inode.  this means it does a GETATTR operation,
or uses the attr results returned in many NFS requests, to compare the
file's size and mtime on the server with the same values it has cached
locally.  this revalidation can occur during XDR processing while the RPC
layer marshals and unmarshals the results of an NFS request.

i don't want to speculate too much without Trond around to keep me honest.
however, i think what we want here is behavior that is closer to category
c., with as few negative performance implications as possible.

i think one way to accomplish this is to create two separate revalidation
functions -- one that can be used by synchronous code in the NFS client
that uses the 100% bug killer, and one that can be used from async RPC
tasks that simply marks that a purge is necessary, and next time through
the sync one, the purge actually occurs.

the only outstanding issue then is how to handle pages that are dirtied
via mmap'd files, since they are touched without going through the NFS
client.  also, i'd really like to hear from maintainers of other network
file systems about how they manage cache coherency.

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

