Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267730AbSLGFrf>; Sat, 7 Dec 2002 00:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbSLGFrf>; Sat, 7 Dec 2002 00:47:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:64722 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267730AbSLGFrd>;
	Sat, 7 Dec 2002 00:47:33 -0500
Message-ID: <3DF18D38.F493636C@digeo.com>
Date: Fri, 06 Dec 2002 21:55:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patch in 
 contest
References: <200212071620.05503.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 05:55:05.0366 (UTC) FILETIME=[30D45B60:01C29DB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here are some io_load contest benchmarks with 2.4.20 with the read latency2
> patch applied and varying the max bomb segments from 1-6 (SMP used to save
> time!)
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20 [5]              164.9   45      31      21      4.55
> 2420rl2b1 [5]           93.5    81      18      22      2.58
> 2420rl2b2 [5]           88.2    87      16      22      2.44
> 2420rl2b4 [5]           87.8    84      17      22      2.42
> 2420rl2b6 [5]           100.3   77      19      22      2.77

If the SMP machine is using scsi then that tends to make the elevator
changes less effective.  Because the disk sort-of has its own internal
elevator which in my testing on a Fujitsu disk has the same ill-advised
design as the kernel's elevator: it treats reads and writes in a similar
manner.

Setting the tag depth to zero helps heaps.

But as you're interested in `desktop responsiveness' you should be
mostly testing against IDE disks.  Their behavour tends to be quite
different.

If you can turn on write caching on the SCSI disks that would change
the picture too.

> io_other:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20 [5]              89.6    86      17      21      2.47
> 2420rl2b1 [3]           48.1    156     9       21      1.33
> 2420rl2b2 [3]           50.0    149     9       21      1.38
> 2420rl2b4 [5]           51.9    141     10      21      1.43
> 2420rl2b6 [5]           52.1    142     9       20      1.44
> 
> There seems to be a limit to the benefit of decreasing max bomb segments. It
> does not seem to have a significant effect on io load on another hard disk
> (although read latency2 is overall much better than vanilla).

hm.  I'm rather surprised it made much difference at all to io_other,
because you shouldn't have competing reads and writes against either
disk??

The problem with io_other should be tickling is where `gcc' tries to
allocate a page but ends up having to write out someone else's data,
and gets stuck sleeping on the disk queue due to the activity of
other processes.  (This doesn't happen much on a 4G machine, but it'll
happen a lot on a 256M machine).

But that's a write-latency problem, not a read-latency one.
