Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTAXUd4>; Fri, 24 Jan 2003 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTAXUd4>; Fri, 24 Jan 2003 15:33:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:34521 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265409AbTAXUdy>;
	Fri, 24 Jan 2003 15:33:54 -0500
Date: Fri, 24 Jan 2003 13:02:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: dementiev@mpi-sb.mpg.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer leakage in kernel?
Message-Id: <20030124130208.52583b24.akpm@digeo.com>
In-Reply-To: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>
References: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 20:43:00.0711 (UTC) FILETIME=[2F3CDF70:01C2C3E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Dementiev <dementiev@mpi-sb.mpg.de> wrote:
>
> Hello everyone,
> 
> I've met with following problem (kernel 2.4.20-pre4 ):
> I write and read sequentially from/to 8 files each of 64 Gbytes (not a
> mistake, 64 Gbyte),
> each on different disk. The files are opened with flag O_DIRECT. I have
> 1 Gbyte RAM, no swap.
> While this scanning is running, number of "buffers" reported by ''free"
> and in /proc/meminfo
> is continuously increasing up to ~ 500 MB !!

You did not specify the filesystem type.  I shall assume ext2.

This buffer growth is expected - ext2 uses one 4k indirect block to describe
the disk location of 4M of file data.  Those indirect blocks are cached, and
appear as "buffers" in the memory accounting.

So after having read 500G of ext2 file with O_DIRECT, you would expect there
to be 500M of indirects in the block device pagecache.  (We shouldn't be
calling this "buffers" any more.  That is inaccurate, and confuses people
into thinking that Linux has a buffer cache).

> When the program exits
> normally or I break it, number
> of "buffers" does not decrease and even increases if I do operations on
> other files.

O_DIRECT operations, yes.  If you were to read one of these files without
O_DIRECT, you should see "Buffers" decreasing as they are reclaimed to make
way for the newly introduced file cache.

> This is not nice at all when I have another applications running
> with memory consumption > 500 MB: when my "scanner" approaches 50G
> border on
> each disk, I've got numerous  "Out of memory" murders :(. Even 'ssh' to
> this machine
> is killed :(
> 
> Could anyone explain why it happens? I suppose that it is a memory
> leakage in file system buffer management.

Sounds like a bug.

Are you reading these large files via a single application, or via one
process per file?

How large is the buffer into which the application is performing the O_DIRECT
read?

Please perform this test:

1: Wait until you have 500M "Buffers"
2: cat 64_gig_file > /dev/null
3: Now see how large "Buffers" is.  It should have reduced a lot.


