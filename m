Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUBLJ4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 04:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266320AbUBLJ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 04:56:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:11703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266184AbUBLJ4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 04:56:20 -0500
Date: Thu, 12 Feb 2004 01:56:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Burgess <lkml@jburgess.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small
 interleaved writes
Message-Id: <20040212015626.48631555.akpm@osdl.org>
In-Reply-To: <402A7CA0.9040409@jburgess.uklinux.net>
References: <402A7CA0.9040409@jburgess.uklinux.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Burgess <lkml@jburgess.uklinux.net> wrote:
>
> I wrote a small benchmark tool to simulate the pattern of writes which 
> occur when slowly streaming files to disk.
> This is trying to replicate the filesystem activity when I record 
> multiple TV and radio channels to disk.
> 
> I have attached a copy of the test program. It measures how long it 
> takes to write a number of files in parallel, writing a small amount of 
> data to each file at a time. I noticed that results for ext2 on 2.6.2 
> are much slower than 2.4.22:
> 
> Write speed in MB/s using an ext2 filesystem for 1 and 2 streams:
> Num streams:     1      2
> linux-2.4.22   10.47  6.98
> linux-2.6.2     9.71  0.34

I don't know why the single-stream case would be slower, but the two-stream
case is probably due to writeback changes interacting with a weakness in
the block allocator.  10 megs/sec is pretty awful either way.

You have two files, each allocating blocks from the same part of the disk. 
So the blocks of the two files are intermingled.

The same happens in 2.4, although the effect can be worse in 2.6 if the two
files are in different directories (because 2.6 will still start these file
out in the same blockgroup, usually - 2.4 will spread different directories
around).


Either way, you have intermingled blocks in the files.

In 2.4, we write these blocks out in time-of-dirtying-the-block order, so
these blocks are written out to nice big linear chunks of disk - the block
write order is 1,2,3,4,5,6,7...

However in 2.6, we write the data out on a per-file basis.  So we write
file 1 (blocks 1,3,5,7,9,...) and then we write file 2 (blocks
2,4,6,8,10,...).  So you'll see that instead of a single full-bandwidth
write, we do two half-bandwidth writes.  If it weren't for disk writeback
caching, it would be as much as 4x slower.

Reads will be slower too - you will probably find that reading back a file
which was created at the same time as a second stream is significantly
slower than reading a file which was created all on its own.  2.4 and 2.6
shouldn't behave significantly differently here.

It's an unfortunate interaction.  The 2.6 writeback design is better,
really, because it is optimised for well-laid out files - the better your
filesystem is at laying the files out, the faster it all goes.  But in this
particular case, the poor layout decisions trip it up.

The ideal fix for this of course is to just fix the dang filesystems to not
do such a silly thing.  But nobody got to that in time.  Delayed allocation
would fix it too.  You can probably address it quite well within the
application itself by buffering up a good amount of data for each write()
call.  Maybe a megabyte.

XFS will do well at this.

You might be able to improve things significantly on ext2 by increasing
EXT2_DEFAULT_PREALLOC_BLOCKS by a lot - make it 64 or 128.  I don't recall
anyone trying that.


But I must say, a 21x difference is pretty wild.  What filesytem was that
with, and how much memory do you have, and what was the bandwidth of each
stream, and how much data is the application passing to write()?

