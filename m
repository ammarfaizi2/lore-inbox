Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSILVyq>; Thu, 12 Sep 2002 17:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSILVyq>; Thu, 12 Sep 2002 17:54:46 -0400
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:40841 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315717AbSILVym>;
	Thu, 12 Sep 2002 17:54:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Thu, 12 Sep 2002 23:52:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu> <E17pbJd-0007l2-00@starship> <3D810942.3F1E91F6@digeo.com>
In-Reply-To: <3D810942.3F1E91F6@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pbsk-0007lN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 23:38, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ...
> > > Is it not possible to co-opt a user process to perform the
> > > invalidation?  Just
> > >
> > >       inode->is_kaput = 1;
> > >
> > > in rpciod?
> > 
> > There must be a way.  The key thing the VM needs to provide, and doesn't
> > now, is a function callable by the rpciod that will report to the caller
> > whether it was able to complete the invalidation without blocking.  (I
> > think I'm just rephrasing someone's earlier suggestion here.)
> > 
> > I'm now thinking in general terms about how to concoct a mechanism
> > that lets rpciod retry the invalidation later, for all those that turn
> > out to be blocking.  For example, rpciod could just keep a list of
> > all pending invalidates and retry each inode on the list every time
> > it has nothing to do.  This is crude and n-squarish, but it would
> > work.  Maybe it's efficient enough for the time being.  At least it's
> > correct, which would be a step forward.
> 
> rpciod is the wrong process to be performing this operation.  I'd suggest
> the userspace process which wants to read the directory be used for this.

It's not just directories as I understand it, it's also any file that's
locked or unlocked.

If we make userspace do it, we need an interface.  Is there

> > Did you have some specific mechanism in mind?
> 
> Testing mapping->nrpages will tell you if the invalidation was successful.

That's nice, so may be no need for a new flavor of invalidate_inode_pages
to write, but what I was really talking about is what should be done
after discovering it failed.

Another thing: we only care about pages that were in the mapping at the
time of the original invalidate attempt.  Coming back and invalidating
a bunch of pages that were already properly re-read from the server,
just to get those few we missed on the first attempt would be, in a 
word, horrible.

This one is harder than it first seems.  It's worth putting in the
effort to do the job correctly though.  The current arrangement is,
err, unreliable.

-- 
Daniel
