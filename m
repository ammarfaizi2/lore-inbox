Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbSJ1EhY>; Sun, 27 Oct 2002 23:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSJ1EhU>; Sun, 27 Oct 2002 23:37:20 -0500
Received: from ns.suse.de ([213.95.15.193]:38666 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262870AbSJ1EhQ>;
	Sun, 27 Oct 2002 23:37:16 -0500
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
References: <20021027121318.GA2249@averell.suse.lists.linux.kernel> <20021027214913.GA17533@clusterfs.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2002 05:42:57 +0100
In-Reply-To: Andreas Dilger's message of "27 Oct 2002 22:55:53 +0100"
Message-ID: <p73znszrx66.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> On Oct 27, 2002  13:13 +0100, Andi Kleen wrote:
> > Move time_t members in struct stat to struct timespec and allow subsecond
> > timestamps for files.  Too big to post on the list, because it edits
> > a lot of file systems and drivers in a straight forward way.
> > 
> > This is required for reliable "make" on fast computers.
> > 
> > File systems that support nsec storage are currently: XFS, JFS, NFSv3
> > (if the filesystem on the server supports it), VFAT (not quite nanosecond),
> > CIFS (unit in 100ns which is above what linux supports), SMBFS (for 
> > newer servers)
> 
> Two notes I might make about this:
> 1) It would be good if it were possible to select this with a config
>    option (I don't care which way the default goes), so that people who
>    don't need/care about the increased resolution don't need the extra
>    space in their inodes and minor extra overhead.  To make this a lot
>    easier to code, having something akin to the inode_update_time()
>    which does all of the i_[acm]time updates as appropriate.

You're joking right? That's twelve bytes of more state per struct inode
and I bet even with the most insidious micro benchmark you won't be 
able to detect a difference in speed from the basic manipulation.

What could hurt a bit is that the "only flush atime once a second"
optimization is gone currently. The right way to address that would
be a mount option "atime_flush_interval", not a CONFIG.

> 2) Updating i_atime based on comparing the nsec timestamp is going to be
>    a killer.  I think AKPM saw dramatic performance improvements when he
>    changed the code to only do the update once/second, and even though
>    you are "only" updating the atime if the times are different, in
>    practise this will be always.  Even without the "per superblock interval"
>    you suggest we should probably only update the atime once a second (I
>    don't think anything is keyed off such high resolution atimes, unlike
>    make and mtime/ctime).

Again I wrote about this in my original mail. Please see
ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec.notes

Basically I agree with you that it's a problem (although "killer" seems
to be an exaggeration to me). The right solution IMHO would be to implement
a new super block field / mount option that specifies that atime flush
(basically generalized noatime). Then you can say you only want it flushed
every 60s and the result will be much faster than what we have currently. 

Some file systems already implement intelligent atime flushing (like XFS) 
and they don't need it. 

But I didn't want to mix such a patch into the big patchkit. When the nsec
patchkit is integrated and benchmarks show it is a problem I will submit
a follow up patch instead.


> 3) The fields you are usurping in struct stat are actually there for the
>    Y2038 problem (when time_t wraps).  At least that's what Ted said when
>    we were looking into nsec times for ext2/3.  Granted, we may all be
>    using 64-bit systems by 2038...  I've always thought 64 bits is much
>    to large for time_t, so we could always use 20 or 30 bits for sub-second
>    times, and the remaining bits for extending time_t at the high end,
>    and mask those off for now, but that is a separate issue...

I wrote about this in my original notes (perhaps I should repost them,
I think they are still on the ftp server) For year 2038 we will need
lots of new syscalls: new time(2), new gettimeofday(2) and lots of 
others. When all these are added then a new stat isn't that big 
a problem. Also glibc currently doesn't know how to use these fields
for y2038, so all user programs need to be relinked anyways. Again
when that happens it's no big issue to add a new stat. I bet when 
y2038 comes there will be other reasons for a new stat too.
So it's fine to reuse these fields.

The make problem is much more pressing.

-Andi

