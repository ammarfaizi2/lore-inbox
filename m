Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263339AbSJFGFx>; Sun, 6 Oct 2002 02:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbSJFGFx>; Sun, 6 Oct 2002 02:05:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:41095 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263339AbSJFGFw>;
	Sun, 6 Oct 2002 02:05:52 -0400
Message-ID: <3D9FD407.D595BC49@digeo.com>
Date: Sat, 05 Oct 2002 23:11:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, rcastro@ime.usp.br, ciarrocchi@linuxmail.org
Subject: Re: load additions to contest
References: <20021005182850.31930.qmail@linuxmail.org> <3D9F3A52.4FB46701@digeo.com> <200210061538.43778.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 06:11:21.0519 (UTC) FILETIME=[310CFBF0:01C26CFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> 
> tarc_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [2]              88.0    74      50      25      1.31
> 2.4.19-cc [1]           86.1    78      51      26      1.28
> 2.5.38 [1]              91.8    74      46      22      1.37
> 2.5.39 [1]              94.4    71      58      27      1.41
> 2.5.40 [1]              95.0    71      59      27      1.41
> 2.5.40-mm1 [1]          93.8    72      56      26      1.40
> 
> This load repeatedly creates a tar of the include directory of the linux
> kernel. You can see a decrease in performance was visible at 2.5.38 without a
> concomitant increase in loads, but this improved by 2.5.39.

Well the kernel compile took 7% longer, but the tar got 10% more
work done.  I expect this is a CPU scheduler artifact.  The scheduler
has changed so much, it's hard to draw any conclusions.

Everything there will be in cache.  I'd suggest that you increase the
size of the tarball a *lot*, so the two activities are competing for
disk.

> tarx_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [2]              87.6    74      13      24      1.30
> 2.4.19-cc [1]           81.5    80      12      24      1.21
> 2.5.38 [1]              296.5   23      54      28      4.41
> 2.5.39 [1]              108.2   64      9       12      1.61
> 2.5.40 [1]              107.0   64      8       11      1.59
> 2.5.40-mm1 [1]          120.5   58      12      16      1.79
> 
> This load repeatedly extracts a tar  of the include directory of the linux
> kernel. A performance boost is noted by the compressed cache kernel
> consistent with this data being cached better (less IO). 2.5.38 shows very
> heavy writing and a performance penalty with that. All the 2.5 kernels show
> worse performance than the 2.4 kernels as the time taken to compile the
> kernel is longer even though the amount of work done by the load has
> decreased.

hm, that's interesting.  I assume the tar file is being extracted
into the same place each time?  Is tar overwriting the old version,
or are you unlinking the destination first?

It would be most interesting to rename the untarred tree, so nothing
is getting deleted.

Which filesystem are you using here?
 
> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [2]              134.1   54      14      5       2.00
> 2.4.19-cc [2]           92.5    72      22      20      1.38
> 2.5.38 [2]              100.5   76      9       5       1.50
> 2.5.39 [2]              101.3   74      14      6       1.51
> 2.5.40 [1]              101.5   73      13      5       1.51
> 2.5.40-mm1 [1]          104.5   74      9       5       1.56
> 
> This load repeatedly copies a file the size of the physical memory to
> /dev/null. Compressed caching shows the performance boost of caching more of
> this data in physical ram - caveat is that this data would be simple to
> compress so the advantage is overstated. The 2.5 kernels show equivalent
> performance at 2.5.38 (time down at the expense of load down) but have better
> performance at 2.5.39-40 (time down with equivalent load being performed).
> 2.5.40-mm1 seems to exhibit the same performance as 2.5.38.

That's complex.  I expect there's a lot of eviction of executable
text happening here.  I'm working on tuning that up a bit.
 
> lslr_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [2]              83.1    77      34      24      1.24
> 2.4.19-cc [1]           82.8    79      34      24      1.23
> 2.5.38 [1]              74.8    89      16      13      1.11
> 2.5.39 [1]              76.7    88      18      14      1.14
> 2.5.40 [1]              74.9    89      15      12      1.12
> 2.5.40-mm1 [1]          76.0    89      15      12      1.13
> 
> This load repeatedly does a `ls -lR >/dev/null`. The performance seems to be
> overall similar, with the bias towards the kernel compilation being performed
> sooner.

How many files were under the `ls -lR'?  I'd suggest "zillions", so
we get heavily into slab reclaim, and lots of inode and directory
cache thrashing and seeking...
