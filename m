Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274119AbSITAUu>; Thu, 19 Sep 2002 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbSITAUt>; Thu, 19 Sep 2002 20:20:49 -0400
Received: from packet.digeo.com ([12.110.80.53]:57770 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S274119AbSITAUs>;
	Thu, 19 Sep 2002 20:20:48 -0400
Message-ID: <3D8A6B0A.D39EB994@digeo.com>
Date: Thu, 19 Sep 2002 17:25:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Hint benchmark reaches memory size limit on 4gb box
References: <20020920000147.GA21875@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 00:25:46.0604 (UTC) FILETIME=[43780AC0:01C2603C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> >> 1) hint (possibly FLOAT & LONGLONG together)
> >> 2) netperf -t TCP_RR    # request/response
> >> 3) chat # 2 rooms with semi-long lived clients
> >> 4) postmark     # 2 directories + lots of files
> >> 5) configure && make && make check GNU ed
> 
> >> Any suggestions?
> 
> > Dunno, Randy.  I'd say, yes, you hit 3G.  I guess one
> > needs to look to find a way to make it less consumptive.
> 
> It's been running for about 20 hours on 2.5.34-mm1.

Well it sounds like it's stable.  This is on the quad, I assume.

> A few observations:
> The swap happy processes from hint _really_ slowed
> down when they hit swap.

swapout is bust in that kernel.  2.5.36-mm1 has the fix, but
it's just a one-liner:
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.36/2.5.36-mm1/broken-out/vm-mapping-fix.patch

Really, I just haven't started looking at behaviour under
swappy loads.  Even with simple tests the kernel does seem
to be making incorrect eviction decisions, at a slow rate.

(The test: boot with mem=192m, start `vmstat 1', run your
standard memset(malloc(1G)) test.  On the second run the kernel
is continuously doing a trickle of reads.  Some from swap, some
from executables. It shouldn't.  2.5.26 doesn't. 2.4.19-ac1 does)

> I expect the hint processes to run until either swap
> is full, or they hit the ~3gb limit.  At the current
> rate it may be a day or two.

If a performance test takes more than 5-10 minutes to run, it's
being silly.  30 seconds is enough for most things.
 
> So I'm wondering if you think i should just abort the
> current test, and try 2.5.36-mm1, or if the benchmark
> needs adjustment.

Both, it looks.
 
> ...
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> 12571 root      16   0  1708  728  1636 S    52.1  0.0   1:15 netperf
> 12572 root      25   0  1656  552  1656 R    47.6  0.0   1:09 netserver
> 10889 root      15   0 20560  18M  1368 D    25.7  0.4 148:43 postmark-1_5
>    11 root      15   0     0    0     0 SW    5.1  0.0 107:05 kswapd0

OK, that's the sort of kswapd load which I see under heavy testing.
That's 1.25% of total CPU, and it really isn't just spinning wheels,
promise.

> ..
> 
> Here is some vmstat 30: cs is high.  Oddly si/so bi/bo and in are 0.
> That's with either procps-2.5.34-mm1 or rml's recent procps.

Yup.  That info got shuffled over to /proc/vmstat.  There will
be some brokenness for a while.

> ..
> iostat 30 says there is really disk activity:
> Device:        tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
> dev8-0      406.46      6285.98      2083.54     108056      35816  (root/swap)
> dev8-1      103.49      1149.51       916.35      19760      15752  (usr/swap)
> dev8-2      333.51     16341.13     13502.73     280904     232112  (raid5 array)

The sard code seems to be working nicely.
 
> Should the bench be adjusted, or should I boot 2.5.36-mm1?

Both, sorry.
