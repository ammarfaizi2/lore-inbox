Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280964AbRKLULg>; Mon, 12 Nov 2001 15:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRKLUL1>; Mon, 12 Nov 2001 15:11:27 -0500
Received: from zok.SGI.COM ([204.94.215.101]:43438 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280964AbRKLULJ>;
	Mon, 12 Nov 2001 15:11:09 -0500
Subject: Re: File System Performance
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF02702.34C21E75@zip.com.au>
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
	<3BEFF9D1.3CC01AB3@zip.com.au>
	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 
	<3BF02702.34C21E75@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 14:06:23 -0600
Message-Id: <1005595583.13307.5.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 13:46, Andrew Morton wrote:
> Ben Israel wrote:
> > 
> > Andrew
> > 
> >  Thank you very much for your response. I would like to know what ever I can
> > about File Systems that achieve near Raw Disk Transfer Speeds on large file
> > system modifications.
> 
> This is very filesystem-dependent.   Probably the XFS mailing list
> linux-xfs@oss.sgi.com is the place to ask for XFS.
> 
> > What does the "Orlov allocator" do differently?
> 
> 
> The Orlov algorithm (or at least Al's version of it) tries to
> spread top-level directories evenly across the partition, under
> the assumption that these contain unrelated information.  But for
> directories at a lower level, it is more aggressive about placing
> directories in the same block group as their parent.   It _will_
> move into a different block group, but only when it sees that the
> current one is filling up.

XFS does something similar to this - the filesystem is split into
'allocation groups' these are independent chunks of upto 4 Gbytes
of disk space. By default a directory is placed in a different
allocation group than it's parent, file inodes are placed in the
same allocation group - preferably 'close' to the directory inode,
file data also prefers the same allocation group as the inode.

This all works OK when the filesystem is not bursting at the seams,
and when there is some correspondence between logical block numbers
in the filesystem and physical drives underneath. I believe that once
you get into complex filesystems using raid devices and smart caching
drives it gets very hard for the filesystem to predict anything 
about latency of access for two blocks which it things are next
to each other in the filesystem.

> 
> > All File Systems I've used have this problem. XFS is
> > just supposedly high performance. It offers some improvement, but is still
> > off by a factor of 4.
> 

XFS on Irix can reach disk speeds, but for a limited set of workloads,
i.e. direct I/O into preallocated space. 

Looking at your original benchmark:

hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.71 seconds = 23.62 MB/sec

time cp -r /usr/src/linux-2.4.6 tst

real 0m47.376s
user 0m0.180s
sys 0m2.710s

du -bs tst
144187392 tst

Actual Performance
2*144MB/48s=6MB/sec

There is a lot of difference between doing a raw read of data from
the device, and copying a large directory tree. The raw read is
purely sequential, the tree copy is basically random access since
the kernel is being asked to read and then write a lot of small 
chunks of disk space.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
