Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUBLUVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUBLUVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:21:06 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:4239 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S266465AbUBLUU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:20:59 -0500
Message-ID: <402BE01E.2010506@jburgess.uklinux.net>
Date: Thu, 12 Feb 2004 20:20:46 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jon Burgess <lkml@jburgess.uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <402A7CA0.9040409@jburgess.uklinux.net> <20040212015626.48631555.akpm@osdl.org>
In-Reply-To: <20040212015626.48631555.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I don't know why the single-stream case would be slower, but the 
> two-stream
>
>case is probably due to writeback changes interacting with a weakness in
>the block allocator.  10 megs/sec is pretty awful either way.
>
>  
>
10MB/s is just because I did the test on an old machine, it maxes out at 
15MB/s with "hdparm -t".
I didn't want to do it on my main PC because I using it to record a TV 
program at the time :-)

>Either way, you have intermingled blocks in the files.
>  
>
Yes the blocks are intermingled. Thanks for the explanation of the 
2.4/2.6 difference.

>Reads will be slower too - you will probably find that reading back a file
>  
>
Yes reads are 50% for 2 streams, 25% for 4 etc. 2.4 and 2.6 perform the 
same.
I did a debugfs "stat" and it clearly shows the fragmented file blocks.

>You can probably address it quite well within the
>application itself by buffering up a good amount of data for each write()
>call.  Maybe a megabyte.
>  
>
Writes in the 256kB - 1MB region do avoid the problem. Unfortunately the 
way the application is written it makes this tricky to do. It wants to 
write out the data in one frame at a time, typically 10 - 50kB.

>XFS will do well at this.
>  
>
Yes, both XFS and JFS perform much better. Here is a summary of some 
tests done on 2.6, these were done on a faster machine / disk 
combination. This was the original test program which also measured the 
read speeds, you can get this  from http://www.jburgess.uklinux.net/slow.c

The ext2 result is a bit slow, but ext3 is really bad.

Num streams   |1       1       |2        2
Filesystem    |Write   Read    |Write    Read
--------------|----------------|--------------
Ext2          |27.7    29.17   | 5.89    14.43
ext3-ordered  |25.73   29.21   | 0.48     1.1
Reiserfs      |25.31   26.25   | 7.47    13.55
JFS           |26.27   26.95   |26.92    28.5
XFS           |27.51   26.00   |27.35    27.42

>You might be able to improve things significantly on ext2 by increasing
>EXT2_DEFAULT_PREALLOC_BLOCKS by a lot - make it 64 or 128.  I don't recall
>anyone trying that.
>  
>
I'll give it a go.

>But I must say, a 21x difference is pretty wild.  What filesytem was that
>with, and how much memory do you have, and what was the bandwidth of each
>stream, and how much data is the application passing to write()?
>  
>
The results were from running the test program I attached to the 
original email. It was writing 4kB at a time on a ext2 filesystem. It 
tries to write the data in a tight loop, taking as much bandwidth as it 
can get.

In the real application it records MPEG2 DVB streams from TV and radio. 
The bandwidths are as follows:
 TV ~ 500kByte/s, in 10 - 50kB blocks (one MPEG frame at a time).
 Radio ~ 24kByte/s, in blocks of around 2-4kB.

The write performance is not too critical. Even at 5MB/s I would still 
be able to record 10 TV channels.
I wrote the benchmark primarily to see why the read performance was so 
bad. I noticed that when I started moving the files between disks the 
transfer rate would be really erratic. Sometimes 40MB/s, sometimes 5MB/s.

The worst case that I found was when I record a TV and radio stream 
simultaneously. The data blocks are recorded in a patterm of 1 block of 
radio data followed by 20 blocks of TV. When I read back the radio 
stream I get only 1:20th of the disk performance (1 - 2 MB/s).

    Jon


