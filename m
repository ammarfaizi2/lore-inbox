Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJ2Q12>; Tue, 29 Oct 2002 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSJ2Q11>; Tue, 29 Oct 2002 11:27:27 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:34039 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261514AbSJ2Q10>; Tue, 29 Oct 2002 11:27:26 -0500
Date: Tue, 29 Oct 2002 09:30:52 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021029163052.GH28982@clusterfs.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20021027214913.GA17533@clusterfs.com> <Pine.LNX.3.96.1021029094310.6686C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021029094310.6686C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2002  10:01 -0500, Bill Davidsen wrote:
> On Sun, 27 Oct 2002, Andreas Dilger wrote:
> > 1) It would be good if it were possible to select this with a config
> >    option (I don't care which way the default goes), so that people who
> >    don't need/care about the increased resolution don't need the extra
> >    space in their inodes and minor extra overhead.  To make this a lot
> >    easier to code, having something akin to the inode_update_time()
> >    which does all of the i_[acm]time updates as appropriate.
> 
> Am I missing something? That would make it two file types, no? I bet
> there's more overhead in handling that problem than just writing the time.

Not necessarily.  Most filesystems don't even have space for storing a
sub-second time resolution, so having the extra time resolution is
irrelevant.  For filesystems which do have room for sub-second timestamps
they currently just fill in 0 there, and if the sub-second time is here
they will fill in that field, so still no incompatible on-disk formats.

As for ext3 having sub-second timestamps, this will be done in a way
which makes it compatible with older filesystem, so whether those
timestamps are written or not written, the filesystem will still be
readable on older kernels.

The "inode" space that I'm referring to is the in-memory inode struct,
and the presence of that would be determined at compile time.  Granted,
it would only be 12 bytes added to the inode, but if you have thousands
or millions of inodes resident you start to feel the pinch.

> > 2) Updating i_atime based on comparing the nsec timestamp is going to be
> >    a killer.  I think AKPM saw dramatic performance improvements when he
> >    changed the code to only do the update once/second, and even though
> >    you are "only" updating the atime if the times are different, in
> >    practise this will be always.  Even without the "per superblock interval"
> >    you suggest we should probably only update the atime once a second (I
> >    don't think anything is keyed off such high resolution atimes, unlike
> >    make and mtime/ctime).
> 
> find -anewer seems to use as much resolution as it has. More to the point,
> what is the overhead of updating the time when an i/o is done? It would
> seem pretty trivial.

It would be trivial if you are already updating the inode (and we should
optimize for this case), but if you are reading a file in 5-byte chunks
and you update the atime a thousand times a second it most certainly IS
a lot of overhead.  We currently limit atime updates to 1/second by
checking if the atime has changed or not.  The proposed patch checks if
the atime.ts_nsec has changed, and it most certainly will have, so this
will always be updating the atime on disk.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

