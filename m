Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRHMG3J>; Mon, 13 Aug 2001 02:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269889AbRHMG3A>; Mon, 13 Aug 2001 02:29:00 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:4517 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S269770AbRHMG2t>; Mon, 13 Aug 2001 02:28:49 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.7-ac4 disk thrashing (SOLVED?)
Date: Mon, 13 Aug 2001 08:24:08 +0200
X-Mailer: KMail [version 1.2.3]
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List),
        mason@suse.com (Chris Mason), NikitaDanilov@Yahoo.COM (Nikita Danilov),
        tmv5@home.com (Tom Vier)
In-Reply-To: <E15UR2B-00051d-00@the-village.bc.nu> <01080817411402.00351@starship> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010813062854Z269770-760+722@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. August 2001 18:03 schrieb Dieter Nützel:
> Am Mittwoch, 8. August 2001 17:41 schrieb Daniel Phillips:
> > On Wednesday 08 August 2001 12:57, Alan Cox wrote:
> > > > Could it be that the ReiserFS cleanups in ac4 do harm?
> > > > http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D99683332027428&w=3D2
> > >
> > > I suspect the use once patch is the more relevant one.
> >
> > Two things to check:
> >
> >   - Linus found a bug in balance_dirty_state yesterday.  Is the
> >     fix applied?
>
> No, I'll try.
>
> >   - The original use-once patch tends to leave a referenced pages
> >     on the inactive_dirty queue longer, not in itself a problem,
> >     but can expose other problems.  The previously posted patch
> >     below fixes that, is it applied?
> >
> > To apply (with use-once already applied):
>
> Yes, it was with -ac9.

Here are my latest results.
Kupdated seems to be the disk IO performance killer for ReiserFS (even with 
2.4.7-ac4 and beyond, latest version I've tested was 2.4.8 and 2.4.8-ac1).

2.4.7-ac1 +
use-once-pages                                  		Daniel Phillips
use-once-pages-2                                		Daniel Phillips
transaction-tracking-2.diff                             		Chris Mason
2.4.7-unlink-truncate-rename-rmdir.dif          	Vladimir V.Saveliev
2.4.7-plug-hole-and-pap-5660-pathrelse-fixes.dif       Vladimir V.Saveliev

2.4.8 +
use-once-pages-2                                		Daniel Phillips
transaction-tracking-2.diff                             		Chris Mason
2.4.7-unlink-truncate-rename-rmdir.dif          	Vladimir V.Saveliev
2.4.7-plug-hole-and-pap-5660-pathrelse-fixes.dif       Vladimir V.Saveliev

The first two lines per dbench run present the results for "normal"
kernel settings and the second two lines show the results for "killall
-STOP kupdated" and "echo 80 64 64 256 500 6000 90 >
/proc/sys/vm/bdflush" like Linus suggested.

dbench-1.1: 48

2.4.8
Throughput 21.467 MB/sec (NB=26.8337 MB/sec  214.67 MBit/sec)
39.270u 125.690s 4:55.17 55.8%  0+0k 0+0io 1310pf+0w
Throughput 28.1733 MB/sec (NB=35.2166 MB/sec  281.733 MBit/sec)
37.920u 123.120s 3:44.92 71.5%  0+0k 0+0io 1310pf+0w

2.4.7-ac1
Throughput 29.4888 MB/sec (NB=36.861 MB/sec  294.888 MBit/sec)
38.380u 114.120s 3:34.90 70.9%  0+0k 0+0io 1310pf+0w
Throughput 30.7171 MB/sec (NB=38.3964 MB/sec  307.171 MBit/sec)
38.160u 127.720s 3:26.31 80.4%  0+0k 0+0io 1310pf+0w


dbench-1.1: 32

2.4.8
Throughput 21.5015 MB/sec (NB=26.8769 MB/sec  215.015 MBit/sec)
25.470u 80.170s 3:17.46 53.4%   0+0k 0+0io 911pf+0w
Throughput 33.5427 MB/sec (NB=41.9284 MB/sec  335.427 MBit/sec)
25.380u 83.350s 2:06.94 85.6%   0+0k 0+0io 911pf+0w

2.4.7-ac1
Throughput 33.5394 MB/sec (NB=41.9243 MB/sec  335.394 MBit/sec)
25.460u 74.220s 2:06.95 78.5%   0+0k 0+0io 911pf+0w
Throughput 34.4063 MB/sec (NB=43.0078 MB/sec  344.063 MBit/sec)
25.270u 84.510s 2:03.78 88.6%   0+0k 0+0io 911pf+0w


dbench-1.1: 16

2.4.8
Throughput 25.373 MB/sec (NB=31.7163 MB/sec  253.73 MBit/sec)
12.610u 36.380s 1:23.24 58.8%   0+0k 0+0io 510pf+0w
Throughput 42.1528 MB/sec (NB=52.691 MB/sec  421.528 MBit/sec)
12.770u 35.870s 0:50.11 97.0%   0+0k 0+0io 510pf+0w

2.4.7-ac1
Throughput 36.8195 MB/sec (NB=46.0244 MB/sec  368.195 MBit/sec)
12.750u 36.280s 0:57.36 85.4%   0+0k 0+0io 510pf+0w
Throughput 41.0814 MB/sec (NB=51.3518 MB/sec  410.814 MBit/sec)
13.520u 36.370s 0:51.41 97.0%   0+0k 0+0io 510pf+0w


dbench-1.1: 8

2.4.8
Throughput 23.9236 MB/sec (NB=29.9045 MB/sec  239.236 MBit/sec)
6.090u 18.510s 0:45.15 54.4%    0+0k 0+0io 311pf+0w
Throughput 43.1126 MB/sec (NB=53.8908 MB/sec  431.126 MBit/sec)
6.580u 16.760s 0:25.50 91.5%    0+0k 0+0io 311pf+0w

2.4.7-ac1
Throughput 41.315 MB/sec (NB=51.6437 MB/sec  413.15 MBit/sec)
6.590u 17.000s 0:26.56 88.8%    0+0k 0+0io 311pf+0w
Throughput 42.9713 MB/sec (NB=53.7142 MB/sec  429.713 MBit/sec)
6.180u 17.210s 0:25.58 91.4%    0+0k 0+0io 311pf+0w


dbench-1.1: 4

2.4.8
Throughput 23.2973 MB/sec (NB=29.1216 MB/sec  232.973 MBit/sec)
3.430u 8.510s 0:23.67 50.4%     0+0k 0+0io 211pf+0w
Throughput 42.6651 MB/sec (NB=53.3313 MB/sec  426.651 MBit/sec)
3.010u 8.310s 0:12.38 91.4%     0+0k 0+0io 210pf+0w

2.4.7-ac1
Throughput 41.1515 MB/sec (NB=51.4394 MB/sec  411.515 MBit/sec)
3.040u 8.500s 0:12.83 89.9%     0+0k 0+0io 210pf+0w
Throughput 41.7318 MB/sec (NB=52.1647 MB/sec  417.318 MBit/sec)
3.140u 8.430s 0:13.67 84.6%     0+0k 0+0io 211pf+0w


dbench-1.1: 2

2.4.8
Throughput 28.002 MB/sec (NB=35.0025 MB/sec  280.02 MBit/sec)
1.630u 4.240s 0:10.44 56.2%     0+0k 0+0io 161pf+0w
Throughput 40.2392 MB/sec (NB=50.2991 MB/sec  402.392 MBit/sec)
1.640u 3.880s 0:07.56 73.0%     0+0k 0+0io 161pf+0w

2.4.7-ac1
Throughput 37.7007 MB/sec (NB=47.1259 MB/sec  377.007 MBit/sec)
1.540u 4.250s 0:08.01 72.2%     0+0k 0+0io 161pf+0w
Throughput 37.7846 MB/sec (NB=47.2308 MB/sec  377.846 MBit/sec)
1.560u 4.240s 0:07.99 72.5%     0+0k 0+0io 161pf+0w


dbench-1.1: 1

2.4.8
Throughput 40.6674 MB/sec (NB=50.8342 MB/sec  406.674 MBit/sec)
0.720u 2.150s 0:04.25 67.5%     0+0k 0+0io 136pf+0w
Throughput 35.7121 MB/sec (NB=44.6401 MB/sec  357.121 MBit/sec)
0.720u 1.970s 0:04.70 57.2%     0+0k 0+0io 136pf+0w

2.4.7-ac1
Throughput 32.982 MB/sec (NB=41.2275 MB/sec  329.82 MBit/sec)
0.620u 2.240s 0:05.01 57.0%     0+0k 0+0io 136pf+0w
Throughput 33.6056 MB/sec (NB=42.007 MB/sec  336.056 MBit/sec)
0.870u 2.000s 0:04.94 58.0%     0+0k 0+0io 136pf+0w



Now, I only have tested 2.4.8 (patches like above) with different dirty
balancing numbers and with/without kupdated stopped.
Please compare the results with the above numbers.

dbench-1.1: 32

echo 30 64 64 256 500 3000 60 > /proc/sys/vm/bdflush	(normal mode)
Throughput 21.2009 MB/sec (NB=26.5011 MB/sec  212.009 MBit/sec)
25.930u 81.180s 3:20.25 53.4%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 3000 60 > /proc/sys/vm/bdflush
Throughput 21.6827 MB/sec (NB=27.1034 MB/sec  216.827 MBit/sec)
25.620u 82.950s 3:15.83 55.4%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 6000 60 > /proc/sys/vm/bdflush
Throughput 20.8374 MB/sec (NB=26.0468 MB/sec  208.374 MBit/sec)
26.010u 82.830s 3:23.72 53.4%   0+0k 0+0io 911pf+0w


killall -STOP kupdated

echo 30 64 64 256 500 3000 60 > /proc/sys/vm/bdflush	(normal mode)
Throughput 29.1071 MB/sec (NB=36.3838 MB/sec  291.071 MBit/sec)
25.950u 81.530s 2:26.13 73.5%   0+0k 0+0io 911pf+0w

echo 30 64 64 256 500 6000 60 > /proc/sys/vm/bdflush
Throughput 29.4383 MB/sec (NB=36.7979 MB/sec  294.383 MBit/sec)
25.450u 83.530s 2:24.50 75.4%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 3000 60 > /proc/sys/vm/bdflush
Throughput 31.3666 MB/sec (NB=39.2083 MB/sec  313.666 MBit/sec)
25.660u 88.830s 2:15.67 84.3%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 6000 60 > /proc/sys/vm/bdflush
Throughput 32.1513 MB/sec (NB=40.1891 MB/sec  321.513 MBit/sec)
25.260u 83.190s 2:12.39 81.9%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 3000 70 > /proc/sys/vm/bdflush
Throughput 31.9838 MB/sec (NB=39.9797 MB/sec  319.838 MBit/sec)
25.050u 83.990s 2:13.08 81.9%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 6000 70 > /proc/sys/vm/bdflush
Throughput 32.5191 MB/sec (NB=40.6489 MB/sec  325.191 MBit/sec)
25.990u 81.690s 2:10.91 82.2%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 3000 80 > /proc/sys/vm/bdflush
Throughput 31.7866 MB/sec (NB=39.7332 MB/sec  317.866 MBit/sec)
25.510u 85.010s 2:13.90 82.5%   0+0k 0+0io 911pf+0w

echo 50 64 64 256 500 6000 80 > /proc/sys/vm/bdflush
Throughput 31.2084 MB/sec (NB=39.0105 MB/sec  312.084 MBit/sec)
26.010u 87.040s 2:16.36 82.9%   0+0k 0+0io 911pf+0w

echo 85 64 64 256 500 3000 95 > /proc/sys/vm/bdflush
Throughput 31.6878 MB/sec (NB=39.6098 MB/sec  316.878 MBit/sec)
25.640u 86.710s 2:14.31 83.6%   0+0k 0+0io 911pf+0w

echo 85 64 64 256 500 6000 95 > /proc/sys/vm/bdflush
Throughput 32.4279 MB/sec (NB=40.5349 MB/sec  324.279 MBit/sec)
25.860u 86.710s 2:11.27 85.7%   0+0k 0+0io 911pf+0w


Conclusion.

I found that stopping kupdated together with ReiserFS is a big win.
As everyone know ReiserFS need more CPU cycles then the "other"
filesystems could this be the answer to the observed disk thrashing?
With kupdated running I saw several more percent of idle CPU.
Are there any drawbacks?

Thanks and good night.

-Dieter

