Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJ2UcK>; Tue, 29 Oct 2002 15:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJ2UcK>; Tue, 29 Oct 2002 15:32:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60685 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262276AbSJ2UcI>; Tue, 29 Oct 2002 15:32:08 -0500
Date: Tue, 29 Oct 2002 15:37:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
In-Reply-To: <20021029163052.GH28982@clusterfs.com>
Message-ID: <Pine.LNX.3.96.1021029151551.8154A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Andreas Dilger wrote:

> On Oct 29, 2002  10:01 -0500, Bill Davidsen wrote:
> > On Sun, 27 Oct 2002, Andreas Dilger wrote:
> > > 1) It would be good if it were possible to select this with a config
> > >    option (I don't care which way the default goes), so that people who
> > >    don't need/care about the increased resolution don't need the extra
> > >    space in their inodes and minor extra overhead.  To make this a lot
> > >    easier to code, having something akin to the inode_update_time()
> > >    which does all of the i_[acm]time updates as appropriate.
> > 
> > Am I missing something? That would make it two file types, no? I bet
> > there's more overhead in handling that problem than just writing the time.
> 
> Not necessarily.  Most filesystems don't even have space for storing a
> sub-second time resolution, so having the extra time resolution is
> irrelevant.  For filesystems which do have room for sub-second timestamps
> they currently just fill in 0 there, and if the sub-second time is here
> they will fill in that field, so still no incompatible on-disk formats.

That was my concern.
 
> As for ext3 having sub-second timestamps, this will be done in a way
> which makes it compatible with older filesystem, so whether those
> timestamps are written or not written, the filesystem will still be
> readable on older kernels.

I was more thinking of a kernel compiled without the hi-res timer code, if
that should be done as an option.
 
> The "inode" space that I'm referring to is the in-memory inode struct,
> and the presence of that would be determined at compile time.  Granted,
> it would only be 12 bytes added to the inode, but if you have thousands
> or millions of inodes resident you start to feel the pinch.

I admit to being one of the "thousands" people, and even if I have 100k
inodes (more likely to be 10% of that) it's in the order of a MB, and any
machine which has 100k inodes open is likely to be large enough to ignore
a MB. One advantage of keeping the HRT in the in-core inode is that it
allows parallel make to work correctly even on a filesystem which doesn't
have space to save that information.

Feel free to tell me if that last isn't true.
 
> > > 2) Updating i_atime based on comparing the nsec timestamp is going to be
> > >    a killer.  I think AKPM saw dramatic performance improvements when he
> > >    changed the code to only do the update once/second, and even though
> > >    you are "only" updating the atime if the times are different, in
> > >    practise this will be always.  Even without the "per superblock interval"
> > >    you suggest we should probably only update the atime once a second (I
> > >    don't think anything is keyed off such high resolution atimes, unlike
> > >    make and mtime/ctime).
> > 
> > find -anewer seems to use as much resolution as it has. More to the point,
> > what is the overhead of updating the time when an i/o is done? It would
> > seem pretty trivial.
> 
> It would be trivial if you are already updating the inode (and we should
> optimize for this case), but if you are reading a file in 5-byte chunks
> and you update the atime a thousand times a second it most certainly IS
> a lot of overhead.  We currently limit atime updates to 1/second by
> checking if the atime has changed or not.  The proposed patch checks if
> the atime.ts_nsec has changed, and it most certainly will have, so this
> will always be updating the atime on disk.

1 - any program which does unbuffered 5 byte reads is probably going to
beat the machine to death anyway. Then the sysadmin will mount noatime.

2 - The patch isn't written in stone, going back to one per second
shouldn't matter except in the case of network or devices shared between
multiple systems (3.0?). processes on the same machine whould use the
in-core information.

3 - updating once/sec could still be default, with HRT being a mount
option like noatime.

4 - the time could be stored in register values, ticks, or whatever else,
avoiding any conversion to ns. Then the time could be converted only when
the inode was read, written out, etc. 

I'd really like your comments on these, you probably see things I've
missed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

