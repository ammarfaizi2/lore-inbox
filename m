Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319221AbSILVS3>; Thu, 12 Sep 2002 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319298AbSILVS3>; Thu, 12 Sep 2002 17:18:29 -0400
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:18313 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319221AbSILVS1>;
	Thu, 12 Sep 2002 17:18:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, trond.myklebust@fys.uio.no
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Thu, 12 Sep 2002 23:15:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu> <15744.37092.812502.970281@charged.uio.no> <3D80DB32.4BF9D644@digeo.com>
In-Reply-To: <3D80DB32.4BF9D644@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pbJd-0007l2-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 20:21, Andrew Morton wrote:
> Trond Myklebust wrote:
> > 
> > >>>>> " " == Chuck Lever <cel@citi.umich.edu> writes:
> > 
> >      > rpciod must never call a function that sleeps.  if this
> >      > happens, the whole NFS client stops working until the function
> >      > wakes up again.  this is not really bogus -- it is similar to
> >      > restrictions placed on socket callbacks.
> > 
> > I'm in France at the moment, and am therefore not really able to
> > follow up on this thread for the moment. I'll try to clarify the above
> > though:
> > 
> > 2 reasons why rpciod cannot block:
> > 
> >   1) Doing so will slow down I/O for *all* NFS users.
> >   2) There's a minefield of possible deadlock situations: waiting on a
> >      locked page is the main no-no since rpciod itself is the process
> >      that needs to complete the read I/O and unlock the page.
> > 
> 
> Yes.  Both of these would indicate that rpciod is the wrong process
> to be performing the invalidation.
> 
> Is it not possible to co-opt a user process to perform the
> invalidation?  Just
> 
> 	inode->is_kaput = 1;
> 
> in rpciod?

There must be a way.  The key thing the VM needs to provide, and doesn't
now, is a function callable by the rpciod that will report to the caller
whether it was able to complete the invalidation without blocking.  (I
think I'm just rephrasing someone's earlier suggestion here.)

I'm now thinking in general terms about how to concoct a mechanism
that lets rpciod retry the invalidation later, for all those that turn
out to be blocking.  For example, rpciod could just keep a list of
all pending invalidates and retry each inode on the list every time
it has nothing to do.  This is crude and n-squarish, but it would
work.  Maybe it's efficient enough for the time being.  At least it's
correct, which would be a step forward.

Did you have some specific mechanism in mind?

-- 
Daniel
