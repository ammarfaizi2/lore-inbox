Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273908AbSISXxI>; Thu, 19 Sep 2002 19:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273955AbSISXxH>; Thu, 19 Sep 2002 19:53:07 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:7335 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S273908AbSISXxG>; Thu, 19 Sep 2002 19:53:06 -0400
Date: Thu, 19 Sep 2002 20:01:47 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Hint benchmark reaches memory size limit on 4gb box
Message-ID: <20020920000147.GA21875@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 1) hint (possibly FLOAT & LONGLONG together)
>> 2) netperf -t TCP_RR    # request/response
>> 3) chat # 2 rooms with semi-long lived clients
>> 4) postmark     # 2 directories + lots of files
>> 5) configure && make && make check GNU ed

>> Any suggestions?

> Dunno, Randy.  I'd say, yes, you hit 3G.  I guess one
> needs to look to find a way to make it less consumptive.

It's been running for about 20 hours on 2.5.34-mm1.

A few observations:
The swap happy processes from hint _really_ slowed
down when they hit swap.  swap is on two scsi spindles
shared with standard filesystems.  It seems they are
being penalized a lot for being swap hogs, though it
could be just that the swap devices are slow.  Hint
may be abnormal in that it really accesses all the
processes memory space.  (I'd prefer a combination
of a big process that uses a lot of mem, and other
processes that are big but relatively inactive so
they get paged out.)

I don't have any other systems to compare the 
current run to.   

I expect the hint processes to run until either swap
is full, or they hit the ~3gb limit.  At the current
rate it may be a day or two.

So I'm wondering if you think i should just abort the
current test, and try 2.5.36-mm1, or if the benchmark
needs adjustment.

netperf early in the run had a mostly "low confidence"
intervals.  i.e. confidence < 60%.  In the later runs,
now that swap is heavily utilized, confidence is high.

                Trans.   CPU    CPU    S.dem   S.dem
                Rate     local  remote local   remote
                per sec  % S    % S    us/Tr   us/Tr
early in run   15423.32  99.98  106.65 282.036  300.834
later in run   17494.21  99.98  106.65 228.648  243.888

I'm not running chat.  I may add that if I can teach it
to throttle sensibly.

I was surprised that early in the run, swap was ~ 300MB
used, though the hint processes were ~500 megs.  I.E. 
Swap was seeing some action earlier than I expected.

postmark creates ~65 gb of stuff.  It uses a lun that
isn't shared with swap.  

The ed compile loop is very fast.

This is a bit of top.  High system time here.

4:07pm  up 3 days, 22:18,  1 user,  load average: 5.86, 5.71, 5.65
59 processes: 56 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states: 3.12% user, 96.2% system,  0.0% nice,  0.0% idle
CPU1 states: 57.1% user, 42.4% system,  0.0% nice,  0.0% idle
CPU2 states: 68.3% user, 31.5% system,  0.0% nice,  0.0% idle
CPU3 states: 51.4% user, 48.1% system,  0.0% nice,  0.0% idle
Mem:  3723360K av, 3717740K used,    5620K free,       0K shrd,   74488K buff
                    730812K actv, 2662512K in_d,       0K in_c,       0K target
Swap: 4065056K av, 3073364K used,  991692K free                 1907636K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
12571 root      16   0  1708  728  1636 S    52.1  0.0   1:15 netperf
12572 root      25   0  1656  552  1656 R    47.6  0.0   1:09 netserver
10889 root      15   0 20560  18M  1368 D    25.7  0.4 148:43 postmark-1_5
   11 root      15   0     0    0     0 SW    5.1  0.0 107:05 kswapd0
27998 root      19   0  7408 5792  3788 R     3.8  0.1   0:00 cc1
21393 root      15   0 1626M 328M  1508 D     1.3  9.0 117:13 LONGLONG
21395 root      15   0 1788M 348M  1508 D     1.3  9.5 106:41 DOUBLE
21351 root      17   0  2240 1024  2140 S     0.1  0.0   0:26 run_ed
26002 root      15   0     0    0     0 SW    0.1  0.0   1:06 pdflush
    1 root      15   0  1420  476  1384 S     0.0  0.0   0:19 init


Here is some vmstat 30: cs is high.  Oddly si/so bi/bo and in are 0.
That's with either procps-2.5.34-mm1 or rml's recent procps.

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  3  0 3126544   5444  75556 2013780  0    0     0     0    0 36193 37 63  0
 1  3  1 3127780   5828  75832 2014888  0    0     0     0    0 31957 37 63  0
 4  3  0 3127676  11192  76252 2005696  0    0     0     0    0 36403 36 64  0
 3  3  0 3126180   5672  76220 2008508  0    0     0     0    0 31978 39 61  0
 3  3  0 3127720   6700  76364 2010060  0    0     0     0    0 36683 36 64  0
 2  3  0 3126988   5444  76492 2012024  0    0     0     0    0 31689 38 62  0


iostat 30 says there is really disk activity:
Device:        tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
dev8-0      406.46      6285.98      2083.54     108056      35816  (root/swap)
dev8-1      103.49      1149.51       916.35      19760      15752  (usr/swap)
dev8-2      333.51     16341.13     13502.73     280904     232112  (raid5 array)

Should the bench be adjusted, or should I boot 2.5.36-mm1?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

