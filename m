Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSIWVo1>; Mon, 23 Sep 2002 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbSIWVo1>; Mon, 23 Sep 2002 17:44:27 -0400
Received: from zero.aec.at ([193.170.194.10]:17160 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261481AbSIWVna>;
	Mon, 23 Sep 2002 17:43:30 -0400
Date: Mon, 23 Sep 2002 23:48:36 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: Nanosecond resolution for stat(2) 
Message-ID: <20020923214836.GA8449@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[The original message for this included the patch and didn't make it to
l-k likely because it was too big. Reposted with out-of-line patch]

Linux currently uses second resolution (time_t) for st_[cam]time in stat(2).
This is a problem for highly parallel make -j, which cannot detect cases
when a make rule runs for less than a second. GNU make supports finer
grained timestamps for this on other OS, but Linux doesn't support it 
so far. This patch changes that. We also have several filesystems
in tree now that support better than second resolution for [cam]time in
their on disk inode (XFS,JFS,NFSv3 and VFAT). 

This patch extends the VFS and stat(2) to add nsec timestamps. 

Why nsecs? First to be compatible with Solaris and then when you add a new
32bit field then there is no reason to stop at msec. It just uses 
a POSIX struct timespec. This matches what the filesystems (NFSv3,JFS,XFS)
do. 

The real resolution is a jiffie current because it just uses xtime
instead of calling gettimeofday. In 2.5 that is 1ms, which should 
be hopefully good enough. If not we can change it later to use do_gettimeofday.
do-gettimeofday unfortunately takes a readlock currently on most architectures,
so before doing it it would be a good idea to fix at least i386 to use
lockless gettimeofday (implementations of that exist already). But xtime
should be good enough for now. 

I chose to reuse the "reserved for year 2036" fields in stat64 for nsec, because
y2036 will need many other system call and glibc changes anyways
(e.g. new time, new gettimeofday, glibc support) so adding a new stat64
by then won't be a big deal. The newer architectures have enough 

The current kernels fill the fields now reused for nsec always with 0,
so there is perfect compatibility.

On stat64 these fields are always there because everybody uses the glibc
layout. With stat on 64bit architectures it is unfortunately mixed.
The newer 64bit architectures use the stat64 layout. The older ones
unfortunately didn't reserve fields for this (this is mainly alpha) 
I think. For now alpha has no way to get at the nsec values. Fixing 
it probably requires a new stat64 call for alpha.

I had to add a preprocessor symbol for this case.

I fixed all the architectures for it.

The old utimes system call already supported timeval, so it works fine 
(that is ms instead of ns resolution, but should be good enough for now) 

I changed the inode and iattr fields to struct timespec.  and fixed all the
file systems and other code that accessed it. The rounding in general
is a bit crude from seconds - it should round, but they are currently
just truncated.

Some drivers (like mouse drivers or tty) do dubious inode [mac] time 
accesses of the on disk inode and without even marking it dirty. This is 
likely a bug. I fixed some of them but left others of these alone for now, 
but should probably be all fixed. 

[Linus noted that the tty drivers does this to keep 'w' updated. The
patch keeps this. It's probably nonsense for the mouse drivers and 
partly removed there.]

I didn't fix Intermezzo completely because it didn't compile at all.

This patch could in theory affect benchmarks a bit. Andrew Morton previously
did an optimization to put inodes only once a second onto the dirty list
when their [mca]time change. With this patch they will be put on the dirty
list each jiffie (1ms), so in the worst case 1000 times as often.  The
cost in this is mainly in taken the locks and putting the inode onto
the dirty list.  On many FS which do not have better than a second 
resolution this makes no sense, because they only change the value once a 
second anyways. If this should be a problem a new update_time file/inode
operation may need to be added. I didn't do this for now.

The kernel internally always keeps the nsec (or rather 1ms) resolution
stamp. When a filesystem doesn't support it in its inode (like ext2) 
and the inode is flushed to disk and then reloaded then an application
that is nanosecond aware could in theory see a backwards jumping time.
I didn't do anything anything against that yet, because it looks more
like a theoretical problem for me. If it should be one in practice 
it could be fixed by rounding the time up in this case.

Patch for 2.5.38 can be found at 
ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec-2.5.38-1.gz

-Andi
