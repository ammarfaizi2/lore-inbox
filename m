Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281021AbRKLVcV>; Mon, 12 Nov 2001 16:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKLVcL>; Mon, 12 Nov 2001 16:32:11 -0500
Received: from rj.sgi.com ([204.94.215.100]:50884 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281021AbRKLVb7>;
	Mon, 12 Nov 2001 16:31:59 -0500
Subject: Re: File System Performance
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF03402.87D44589@zip.com.au>
In-Reply-To: <3BF02702.34C21E75@zip.com.au>,
	<00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
	<3BEFF9D1.3CC01AB3@zip.com.au>
	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 
	<3BF02702.34C21E75@zip.com.au>
	<1005595583.13307.5.camel@jen.americas.sgi.com> 
	<3BF03402.87D44589@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 15:27:11 -0600
Message-Id: <1005600431.13303.10.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 14:41, Andrew Morton wrote:
> Steve Lord wrote:
> > 
> > ...
> > This all works OK when the filesystem is not bursting at the seams,
> > and when there is some correspondence between logical block numbers
> > in the filesystem and physical drives underneath. I believe that once
> > you get into complex filesystems using raid devices and smart caching
> > drives it gets very hard for the filesystem to predict anything
> > about latency of access for two blocks which it things are next
> > to each other in the filesystem.
> > 
> 
> Well, file systems have for all time made efforts to write things
> out contiguously.  If an IO system were to come along and deoptimise
> that case it'd be pretty broken?

Yes you are right, I was just pointing out that there is so much
underneath us now that things get a little out of our control.

>   
> > ...
> > 
> > There is a lot of difference between doing a raw read of data from
> > the device, and copying a large directory tree. The raw read is
> > purely sequential, the tree copy is basically random access since
> > the kernel is being asked to read and then write a lot of small
> > chunks of disk space.
> 
> hum. Yes.  Copying a tree from and to the same disk won't
> achieve disk bandwidth.  If they're different disks then
> ext2+Orlov will actually get there.
> 
> We in fact do extremely well on IDE with Orlov for this workload,
> even though we're not doing inter-inode readahead.  This will be because
> the disk is doing the readhead for us.   It's going to be highly dependent
> upon the disk cache size, readahead cache partitioning algorithm, etc.

I tried an experiment which puzzled me somwhat:

>  mount /xfs
>  cd /xfs/lord/xfs-linux
>  time tar cf /dev/null linux

real    0m7.743s
user    0m0.510s
sys     0m1.380s

> hdparm -t /dev/sda5

/dev/sda5:
 Timing buffered disk reads:  64 MB in  3.76 seconds = 17.02 MB/sec

> du -sk linux
173028  linux

The tar got ~21 Mbytes/sec.




> 
> BTW, I've been trying to hunt down a suitable file system aging tool.
> We're not very happy with Keith Smith's workload because the directory
> infomation was lost (he was purely studying FFS algorithmic differences
> - the load isn't 100% suitable for testing other filesystems / algorithms).  Constantin Loizides' tools are proving to be rather complex to compile,
> drive and understand.  Does the XFS team have anything like this in the
> kitbag?

No, not really, there is one test we ship which basically does random
calls and creates a fairly deep directory tree, but I would not say it
bears much relationship to real life usage. It would also have to have
large chunks commented out for non xfs filesystems as it does extended
attributes etc. You can however vary the mix of calls it does as a
percentage of the whole.

In our cvs tree cmd/xfsprogs/tests/src/fsstress.c

Steve

> 
> -
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
