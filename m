Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSIJQQm>; Tue, 10 Sep 2002 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIJQQm>; Tue, 10 Sep 2002 12:16:42 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:42961 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317520AbSIJQQj>;
	Tue, 10 Sep 2002 12:16:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chuck Lever <cel@citi.umich.edu>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 18:13:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101036040.5887-100000@citi.umich.edu>
In-Reply-To: <Pine.BSO.4.33.0209101036040.5887-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oneD-0007Dk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 17:09, Chuck Lever wrote:
> On Tue, 10 Sep 2002, Daniel Phillips wrote:
> > On Tuesday 10 September 2002 01:51, Chuck Lever wrote:
> > > rpciod must never call a function that sleeps.  if this happens, the whole
> > > NFS client stops working until the function wakes up again.  this is not
> > > really bogus -- it is similar to restrictions placed on socket callbacks.
> >
> > Ah, a warm body with answers :-)
> >
> > It *sounds* bogus: why should we be satisfied with a function that doesn't
> > do its job reliably (invalidate_inode_pages) in order to avoid coming up
> > with a way of keeping the client daemon from blocking?  How about having
> > invalidate_inode_pages come back with "sorry boss, I couldn't complete the
> > job so I started as much IO as I could and I'm back now, try again later"?
> 
> i'm not suggesting that invalidate_inode_pages behaves properly, i'm
> simply trying to document why it works the way it does.

And nicely too, thanks.

> > > 3.  mmap'd pages must behave reasonably when a file's cache is purged.
> > >     clean pages should be faulted back in.  what to do with dirty mmap'd
> > >     pages?
> >
> > I don't know, sorry.  What?
> 
> 'twas a rhetorical question.

A rhetorical answer as well ;-)

> i'm trying to understand this myself.  the
> case of what to do with dirty mmap'd pages is somewhat sticky.

What I meant was, could you please explain the problem with dirty mmaped
pages.  I see you explained it below: you mean that writes to mmaps bypass
the client, but the client really needs to know about them (and is
largely ignorant of them at present).

> > You've probably been through this before, but could you please explain
> > the ground rules behind the cache purging strategy?
> 
> i can answer the question "when does the NFS client purge a file's cached
> data?"
> 
> there are four major categories:
> 
> a.  directory changes require any cached readdir results be purged.

That is, the client changes the directory itself?  I suppose an NFS
server is incapable of reporting directory changes caused by other
clients, because of being stateless.

>     ...this
>     forces the readdir results to be re-read from the server the next time
>     the client needs them.  this is what broke with the recent changes in
>     2.5.32/3 that triggered this thread.
> 
> b.  when the client discovers a file on the server was changed by some
>     other client, all pages in the page cache for that file are purged
>     (except the ones that can't be because they are locked, etc).  this
>     is the case that is hit most often and in async RPC tasks, and is
>     on many critical performance paths.
> 
> c.  when a file is locked or unlocked via lockf/fcntl, all pending writes
>     are pushed back to the server and any cached data in the page cache is
>     purged before the lock/unlock call returns.

Do you mean, the client locks/unlocks the file, or some other client?
I'm trying to fit this into my model of how the server must work.  It
must be that the locked/unlocked state is recorded at the server, in
the underlying file, and that the server reports the locked/unlocked
state of the file to every client via attr results.  So now, why purge
at *both* lock and unlock time?

>     ...applications sometimes
>     depend on this behavior to checkpoint the client's cache.
> 
> d.  some error occurred while reading a directory, or the object on the
>     server has changed type (like, a file becomes a directory but the
>     file handle is still the same -- a protocol error, but the client
>     checks for this just in case).
> 
> so let's talk about b.  before and after many operations, the NFS client
> attempts to revalidate an inode.  this means it does a GETATTR operation,
> or uses the attr results returned in many NFS requests, to compare the
> file's size and mtime on the server with the same values it has cached
> locally.  this revalidation can occur during XDR processing while the RPC
> layer marshals and unmarshals the results of an NFS request.

OK, so if this revalidation fails the client does the purge, as you
described in b.

> i don't want to speculate too much without Trond around to keep me honest.
> however, i think what we want here is behavior that is closer to category
> c., with as few negative performance implications as possible.

Actually, this is really, really useful and gives me lots pointers I
can follow for more details.

> i think one way to accomplish this is to create two separate revalidation
> functions -- one that can be used by synchronous code in the NFS client
> that uses the 100% bug killer, and one that can be used from async RPC
> tasks that simply marks that a purge is necessary, and next time through
> the sync one, the purge actually occurs.

That would certainly be easy from the VM side, then we could simply
use a derivative of vmtruncate that leaves the file size alone, as
Andrew suggested.

If this method isn't satisfactory, then with considerably more effort
we (you guys) could build a state machine in the client that relies
on an (as yet unwritten but pretty straightforward) atomic purger with
the ability to report the fact that it was unable to complete the
purge atomically.

Your suggestion is oh-so-much-easier.  I hope it works out.

> the only outstanding issue then is how to handle pages that are dirtied
> via mmap'd files, since they are touched without going through the NFS
> client.

Hmm.  And what do you want?  Would a function that walks through the
radix tree and returns the OR of page_dirty for every page in it be
useful?  That would be easy, but efficiency is another question.  I
suppose that even if you had such a function, the need to poll
mmaped files constantly would be a stopper.

Would it be satisfactory to know within a second or two that the mmap
was dirtied?  If so, the dirty scan could possibly be rolled into the
regular refill_inactive/shrink_cache scan, though at some cost to
structural cleanliness.

Could the client mprotect the mmap, and receive a signal the first
time somebody writes it?  Jeff Dike does things like that with UML
and they seem to work pretty well.  Of these approaches, this is the
one that sounds must satisfactory from the performance and
correctness point of view, and it is a proven technique, however
scary it may sound.

You want to know about the dirty pages only so you can send them
to the server, correct?  Not because the client needs to purge
anything.

> also, i'd really like to hear from maintainers of other network
> file systems about how they manage cache coherency.

Yes, unfortunately, if we break Samba, Tridge knows where I live ;-)

-- 
Daniel
