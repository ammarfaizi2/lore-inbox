Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSBMWz2>; Wed, 13 Feb 2002 17:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSBMWzS>; Wed, 13 Feb 2002 17:55:18 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55303 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289047AbSBMWzG>; Wed, 13 Feb 2002 17:55:06 -0500
Date: Wed, 13 Feb 2002 17:53:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16b1LV-0001ol-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020213173811.12448H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Daniel Phillips wrote:

> On February 13, 2002 06:21 am, Bill Davidsen wrote:

> >   The current behaviour allows the system to hang forever waiting for
> > sync(2). In practice it does actually wait minutes on a busy system (df
> > has --no-sync for that reason) when there is no reason for that to happen.
> > I think that not only sucks worse, it's non-standard as well.
> 
> Nothing sucks worse than losing your data.  Let's concentrate on fixing
> shutdown, not breaking (linux) sync.

If you have read my previous posts, you know that the current behaviour is
broken, allows users to glitch the system performance at no benefit to the
issuing process, etc. In other words sync is now currently broken, in
terms of both theory, practice, and standard.

> > > For example, ext3 users get to enjoy rebooting with `sync ; reboot -f'
> > > to get around all those silly shutdown scripts.  This very much relies
> > > upon the sync waiting upon the I/O.

Of course between the sync and execution of the reboot the disk buffers
may be totally full again, and if shutdown isn't close to instant perhaps
you have a faulty shutdown and should fix it.

> >   Because people count on something broken we should keep the bug? You do
> > realize that the sync may NEVER finish?
> 
> You do realize that if you lose your data you may NEVER get it back? ;-)

The sync doesn't protect my data, after my data has been written why
should I care to wait while all the data in every active program in the
system gets written. This makes checkpoints stop points on a busy system.
 
> > That's not in theory, I have news
> > servers which may wait overnight without finishing a "df" iwthout the
> > option.
> 
> OK, what you're really saying is, we need a way to kill the sync process
> if it runs overtime, no?

If that maps into write the current dirty buffers and get on with life,
yes. I posted a better solution for comment, I won't duplicate that here.
  
> > > I mean, according to SUS, our sys_sync() implementation could be
> > > 
> > > asmlinkage void sys_sync(void)
> > > {
> > > 	return;
> > > }
> > > 
> > > Because all I/O is already scheduled, thanks to kupdate.

I can't see anyone taking that reading or that implementation, so let's
not discuss how badly we can do a standard conforming kernel, this is
Linux, we do the best at everything once we figure out what that really
means;-)

> > Your example is a good example of bad practive, since even with
> > ext3 a program creating files quickly would lose data, even though the
> > directory structure is returned to a known state, without stopping the
> > writing processes the results are unknown.
> 
> Huh?  You know about journal commit, right?

Read or reread my other notes on that, journal prevents directory
corruption, it doesn't prevent data loss like a database transaction.
Returning to a known good state does not include "without losing any data
written to unclosed files."

I leave it to Mr Reiser to clarify that or correct me if data is protected
without using unbuffered writes.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

