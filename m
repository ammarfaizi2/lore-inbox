Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUBPRyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUBPRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:54:17 -0500
Received: from crimson.namesys.com ([212.16.7.70]:58544 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S265769AbUBPRyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:54:03 -0500
Date: Mon, 16 Feb 2004 20:51:27 +0300
From: Alex Zarochentsev <zam@namesys.com>
To: Jon Burgess <lkml@jburgess.uklinux.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved writes
Message-ID: <20040216175127.GJ1298@backtop.namesys.com>
References: <402BE01E.2010506@jburgess.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402BE01E.2010506@jburgess.uklinux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 08:20:46PM +0000, Jon Burgess wrote:
> Andrew Morton wrote:
> 
> >I don't know why the single-stream case would be slower, but the 
> >two-stream
> >
> >case is probably due to writeback changes interacting with a weakness in
> >the block allocator.  10 megs/sec is pretty awful either way.
> >
> > 
> >
> 10MB/s is just because I did the test on an old machine, it maxes out at 
> 15MB/s with "hdparm -t".
> I didn't want to do it on my main PC because I using it to record a TV 
> program at the time :-)
> 
> >Either way, you have intermingled blocks in the files.
> > 
> >
> Yes the blocks are intermingled. Thanks for the explanation of the 
> 2.4/2.6 difference.
> 
> >Reads will be slower too - you will probably find that reading back a file
> > 
> >
> Yes reads are 50% for 2 streams, 25% for 4 etc. 2.4 and 2.6 perform the 
> same.
> I did a debugfs "stat" and it clearly shows the fragmented file blocks.
> 
> >You can probably address it quite well within the
> >application itself by buffering up a good amount of data for each write()
> >call.  Maybe a megabyte.
> > 
> >
> Writes in the 256kB - 1MB region do avoid the problem. Unfortunately the 
> way the application is written it makes this tricky to do. It wants to 
> write out the data in one frame at a time, typically 10 - 50kB.
> 
> >XFS will do well at this.
> > 
> >
> Yes, both XFS and JFS perform much better. Here is a summary of some 
> tests done on 2.6, these were done on a faster machine / disk 
> combination. This was the original test program which also measured the 
> read speeds, you can get this  from http://www.jburgess.uklinux.net/slow.c
> 
> The ext2 result is a bit slow, but ext3 is really bad.
> 
> Num streams   |1       1       |2        2
> Filesystem    |Write   Read    |Write    Read
> --------------|----------------|--------------
> Ext2          |27.7    29.17   | 5.89    14.43
> ext3-ordered  |25.73   29.21   | 0.48     1.1
> Reiserfs      |25.31   26.25   | 7.47    13.55
> JFS           |26.27   26.95   |26.92    28.5
> XFS           |27.51   26.00   |27.35    27.42

I ran slow.c on Reiser4, it is different hardware, ext2 results are for
comparing:

server config:
        2xXeon, hyperthreading, 256 MB RAM 
        Linux-2.6.2

Test:
        /tests/slow  foo 1024
        it writes 1GB to one or two files.

Results:
---------+------------+-----------+-----------+-----------+
         |       1 stream         |       2 streams       |
---------+------------+-----------+-----------+-----------+
         | WRITE      | READ      | WRITE     | READ      |
---------+------------+-----------+-----------+-----------+
REISER4  | 33.67 Mb/s | 40.97Mb/s | 30.78Mb/s | 38.37Mb/s |
---------+------------+-----------+-----------+-----------+
EXT2     | 33.32Mb/s  | 40.82Mb/s | 9.45Mb/s  | 20.39Mb/s |
---------+------------+-----------+-----------+-----------+

The fs with delayed block allocation (Reiser4, XFS, seems JFS too) look much
better.


-- 
Alex.
