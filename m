Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBMPL5>; Wed, 13 Feb 2002 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBMPLf>; Wed, 13 Feb 2002 10:11:35 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:46472 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286161AbSBMPLa>;
	Wed, 13 Feb 2002 10:11:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: [patch] sys_sync livelock fix
Date: Wed, 13 Feb 2002 16:11:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
In-Reply-To: <Pine.LNX.3.96.1020212220340.8017A-100000@gatekeeper.tmr.com> <3C69E1AE.B225A392@mandrakesoft.com>
In-Reply-To: <3C69E1AE.B225A392@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b14Z-0001oR-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 04:46 am, Jeff Garzik wrote:
> Bill Davidsen wrote:
> > 
> > On Wed, 13 Feb 2002, Alan Cox wrote:
> > 
> > > > > Whats wrong with sync not terminating when there is permenantly I/O left ?
> > > > > Its seems preferably to suprise data loss
> > > >
> > > > Hard call.  What do we *want* sync to do?
> > >
> > > I'd rather not change the 2.4 behaviour - just in case. For 2.5 I really
> > > have no opinion either way if SuS doesn't mind
> > 
> > Alan, I think you have this one wrong, although SuS seems to have it wrong
> > as well, and if Linux did what SuS said there would be no problem.
> > 
> > - What SuS seems to say is that all dirty buffers will queued for physical
> >   write. I think if we did that the livelock would disappear, but data
> >   integrity might suffer.
> > - sync() could be followed by write() at the very next dispatch, and it
> >   was never intended to be the last call after which no writes would be
> >   done. It is a point in time.
> > - the most common use of sync() is to flush data write to all files of the
> >   current process. If there was a better way to do it which was portable,
> >   sync() would be called less. I doubt there are processes which alluse
> >   that no write will be done after sync() returns.
> > - since sync() can't promise "no new writes" why try to make it do so? It
> >   should mean "write current sirty buffers" and that's far more than SuS
> >   requires.
> > 
> > I don't think benchmarks are generally important, but in this case the
> > benchmark reveals that we have been implementing a system call in a way
> > which not only does more than SuS requires, but more than the user
> > expects. To leave it trying to do even more than that seems to have no
> > benefit and a high (possible) cost.
> 
> Yow, your message inspired me to re-read SuSv2 and indeed confirm,
> sync(2) schedules I/O but can return before completion,

I think that's just stupid and we have a duty to fix it, it's an anachronism.
The _natural_ expectation for the user is that sync means 'don't come back
until data is on disk' and any other interpretation is just apologizing for
halfway implementations.

Sync should mean: come back after all filesystem transactions submitted before
the sync are recorded, such that if the contents of RAM vanishes the data can
still be retrieved.

For dumb filesystems, this can degenerate to 'just try to write all the dirty
blocks', the traditional Linux interpretation, but for journalling filesystems
we can do the job properly.

> while fsync(2) schedules I/O and waits for completion.

Yes, right.

> So we need to implement system call checkpoint(2) ?  schedule I/O,
> introduce an I/O barrier, then sleep until that I/O barrier and all I/O
> scheduled before it occurs.

How about adding: sync --old-broken-way

On this topic, it would make a lot of sense from the user's point of view to
have a way of syncing a single volume, how would we express that?

-- 
Daniel
