Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSHLAX6>; Sun, 11 Aug 2002 20:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSHLAX6>; Sun, 11 Aug 2002 20:23:58 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:25077 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318500AbSHLAXz>;
	Sun, 11 Aug 2002 20:23:55 -0400
Date: Sun, 11 Aug 2002 20:27:39 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020812002739.GA778@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D56A83E.ECF747C6@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 11:09:02AM -0700, Andrew Morton wrote:
> Adam Kropelin wrote:
> > 
> > On Sun, Aug 11, 2002 at 12:38:19AM -0700, Andrew Morton wrote:
> > > Sorry, but there's a ton of stuff here.  It ends up as a 4600 line
> > > diff.  Some code dating back to 2.5.24.  It's almost all performance
> > 
> > Andrew,
> > 
> > Nearly all the patches against mm/vmscan.c are failing when applied
> > to the 2.5.31 Linus just released. Are these patches against a
> > slightly older BK rev?
> 
> Gee I hope not.
> 
> Try getting them from http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/,
> or the big rollup http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/everything.gz

The big rollup applied fine, thanks.

I did a bit of testing since I've always thought 2.4 (and 2.5) writeout behavior
left something to be desired. Testbed was a SMP x86 (2xPPro-200) with 160 MB
of RAM. I used everyone's favorite 2.5 scapegoat: IDE, with a single not-very-
fast IBM disk. Filesystem was ext3 in data=ordered mode. Test workload was an
inbound (from the point of view of the system under test) FTP transfer of a
600 MB iso image. All test runs were from a clean boot with all unnecessary
services shut down.

Results (average of 4 runs):

2.5.31-akpm: 2m 43s
2.5.31:      2m 33s
2.4.19:      2m 18s

`vmstat 1` shows some differences, expecially with respect to 2.4 vs. 2.5. In
about 40% of the cases when the bo drops to (near) 0, the machine stalled (FTP
transfer halted, vmstat output paused, etc.). With 2.5.31-akpm, the stalls were
about 3-4 seconds in length. With 2.5.31, the stalls were of the same duration,
but slightly less frequent. With 2.4.19, the stalls were very frequent (closer
to 70% of the time bo hit 0), but were only 1-2 seconds in duration.

Below are representative samples of `vmstat 1` for each kernel during the test. (Note that the low cache usage in the 2.5.31 sample is because the snapshot is
from early in the run when the cache is still filling.)

Let me know if I can provide more information...

--Adam

2.5.31-akpm:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  1    112   3436      0 140956   0   0     4 15480 5454   400   0  39  60
 0  2  1    112   3436      0 140956   0   0     0  7696 1093    69   0   2  98
 0  2  1    112   3436      0 140956   0   0     0  6268 1084    85   0  31  69
 1  0  2    112   2476      0 142012   0   0     0     4 2863   250   0  23  77
 1  0  0    112   3080      0 142080   0   0     0    68 6730   485   0  46  53
 0  1  1    112   2940      0 141968   0   0     0 11720 5025   340   1  33  67
 0  1  1    112   2936      0 141968   0   0     0   264 1085    45   0   1  99
 1  0  1    112   2812      0 142344   0   0     0    52 3104   203   0  18  82
 0  0  0    112   3300      0 141972   0   0     0     4 6761   469   1  42  57
 1  0  0    112   3492      0 141684   0   0     0     0 6859   495   1  42  56
 0  1  1    112   3548      0 141204   0   0     0 15508 4769   328   0  31  69
 0  1  1    112   3544      0 141204   0   0     0  2268 1081    63   0   2  98
 0  0  0    112   2436      0 142248   0   0     0    56 2006   147   0  10  90
 1  0  0    112   2952      0 142328   0   0     0     4 6760   452   1  43  56
 1  0  1    112   3432      0 141716   0   0     0     0 6955   464   1  42  57
 0  1  1    112   2940      0 141816   0   0     0 15612 4301   262   0  28  72
 0  1  1    112   2932      0 141816   0   0     0   588 1095    78   0   2  98
 1  0  0    112   2620      0 142660   0   0     0    52 4554   314   1  30  69
 1  0  0    112   3420      0 141808   0   0     0     4 6673   465   0  43  57
 0  0  0    112   2628      0 142456   0   0     0     4 6931   491   1  44  55

2.5.31:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 118940      0  28240   0   0     4     0 4171   256   1  21  78
 1  0  0      0 110904      0  36036   0   0     0     0 8937   590   1  53  46
 1  0  0      0 103260      0  43452   0   0     0     0 8558   559   1  50  49
 0  0  0      0  97100      0  49424   0   0     0     0 6919   460   1  41  58
 0  1  1      0  96048      0  50104   0   0     0 21036 1798    67   0   9  90
 0  1  1      0  96044      0  50104   0   0     0  3888 1087    55   0   2  98
 0  1  1      0  96044      0  50104   0   0     0     0 1081    65   0   1  99
 1  0  0      0  91516      0  54544   0   0     0    72 5305   352   0  33  67
 0  0  0      0  85392      0  60560   0   0     0     0 6972   458   0  44  56
 0  0  1      0  79344      0  66476   0   0     0 10788 6384  3173   1  48  50
 1  0  0      0  73296      0  72416   0   0     0    44 6705  1392   1  49  50
 0  0  0      0  67156      0  78444   0   0     0     0 6975   475   1  62  37
 1  0  0      0  61392      0  84104   0   0     0     0 6603   442   0  37  62
 0  1  1      0  55272      0  90016   0   0     0 15500 6940   451   1  42  57
 0  1  1      0  55272      0  90016   0   0     0  7696 1123    13   0   3  97

2.4.19:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0   4384   2124 140132   0   0     0    52 6961   645   0  54  45
 1  0  0      0   4372   2132 140024   0   0     0     0 6994   653   1  50  50
 0  1  1      0   4360   2136 139916   0   0     0  3956 6189   577   1  44  55
 0  1  1      0   4360   2136 139916   0   0     0  8196  223    14   0   2  97
 0  0  1      0   4344   2140 139908   0   0     0  6080 1189    90   0   9  91
 0  1  1      0   4440   2140 139764   0   0     4  7296 5902   557   0  43  57
 1  0  0      0   4360   2144 140044   0   0     0    56 3515   307   0  29  71
 0  1  1      0   4468   2144 139936   0   0     0  4036 5672   519   0  42  57
 0  1  1      0   4468   2144 139936   0   0     0  7960  220    14   0   1  99
 1  0  1      0   4464   2144 139980   0   0     0  5160 2073   178   0  17  82
 1  0  0      0   4396   2164 140092   0   0     0  3148 6965   656   1  51  48
 1  0  0      0   4396   2164 140068   0   0     0     0 7193   656   1  44  54
 0  2  1      0   4384   2164 139996   0   0     0  5848 4923   454   1  37  62
 0  2  1      0   4384   2164 139996   0   0     0  6148  222    10   0   0  99
 1  0  1      0   4400   2168 139900   0   0     0  7400 2961   258   0  24  75
 1  0  0      0   4464   2184 140004   0   0     0    52 7076   659   1  51  48
 1  0  0      0   4452   2184 139936   0   0     0     0 6960   638   0  54  46
 0  1  2      0   4404   2188 139932   0   0     0  5968 4332   399   0  30  69
 0  1  1      0   4404   2188 139932   0   0     0  4804  222    12   0   1  99

