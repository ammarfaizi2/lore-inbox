Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTBISqt>; Sun, 9 Feb 2003 13:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTBISqs>; Sun, 9 Feb 2003 13:46:48 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:30939 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267421AbTBISqq>; Sun, 9 Feb 2003 13:46:46 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200302091856.h19IuS0x031618@twopit.underworld>
Subject: Re: Linux 2.4.20-SMP: where is all my CPU time going?
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Sun, 9 Feb 2003 18:56:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302091247410.30451-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Feb 09, 2003 12:57:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TIMESTAMP [2002] CLIENT NAME             RUN-TIME         SYS-TIME
> > Sep 22 23:08:00: SETI-5              20606.560000       190.480000
> 
> incidentally, what's the meaning of the client-name column?
> (no, I've never run seti, so don't know whether it increments
> through spurious client names on the same machine for some reason...)

My super demon program has 6 "client" directories, each of which
contains an instance of the setiathome program. The super demon keeps
two of these clients processing work units at any one time; 2 because
the machine has 2 CPUs.

> > > do you have any other data?  if the kernel happens to pull pages away
> > > from the seti process, it could easily cause this sort of thing.
> > 
> > Well, I actually have no idea what sort of activity counts towards the
> > sys-time total. Is this time spent in spinlocks? Semaphores? Waiting
> > for DMA transfers to complete? And we're talking 36 minutes-worth of
> > sys-time here! It sounds as if some in-kernel process is going
> > completely off the deep end.
> 
> you have absolutely no data to support that.  all you know is that for some
> reason, the kernel thinks seti is taking up more in-kernel time.  in general,
> driver-level stuff (like irq's and dma) is not accounted by the kernel,
> and thus shows up in the user-time of whatever process happens to be running.
> 
> do you have *elapsed* time per workunit?  that's actually a hard number,
> not a wishywashy one like user/sys times.  if there's an increase in 
> elapsed time, the phenomenon is a little more interesting.

Yes I do. The work-unit began on Feb 08 2003 17:30:35 and finished
on Feb 09 2003 12:22:21. That's approximately 19 hours of wall time,
of which there were 32747.76 seconds of user time and 3840.99 seconds
of sys time. Compare this to a previous work unit which began on Feb
07 2003 16:16:48, finished on Feb 08 2003 02:27:32 (10 hours of wall
time) and took 33207.24 and 219.95 seconds of user and sys time
respectively. This is where my "9 hours of missing run-time" assertion
comes from.

> > > check your cron jobs; I'm guessing you simply run updatedb or something
> > > at that interval.  it does enough IO to flush pages in the seti client's
> > > working set.
> > 
> > My only cron job is one that runs "rmmod -a" every hour.
> 
> really?  no logwatch, logrotate, tmpclean, updatedb, tripwire,
> preen-man-pages?

Nope. This is a home-built box.

> > Could cache-thrashing account for the 9 hours of missing run-time? I
> 
> sure.  you have basically no useful data, since user/sys time accounting
> is purely for amusement purposes, not taken seriously by the kernel.

Terrific.

> the only way you can possibly track this down is by getting more data
> around one of these spikes.  something like running vmstat periodically,
> as well as grabbing /proc/{meminfo,slabinfo}.  perhaps kernel profiling
> or oprofile during non-spike and spike times.

Well on the assumption that I'm still in a spike time, here's some
more memory info. 

$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1058336768 860172288 198164480        0 59092992 614592512
Swap: 509956096 12288000 497668096
MemTotal:      1033532 kB
MemFree:        193520 kB
MemShared:           0 kB
Buffers:         57708 kB
Cached:         598712 kB
SwapCached:       1476 kB
Active:         342780 kB
Inactive:       414884 kB
HighTotal:      130944 kB
HighFree:         2044 kB
LowTotal:       902588 kB
LowFree:        191476 kB
SwapTotal:      498004 kB
SwapFree:       486004 kB

$ cat /proc/slabinfo 
slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
uhci_urb_priv          1     63     60    1    1    1 :  252  126
fib6_nodes           226    226     32    2    2    1 :  252  126
ip6_dst_cache         60     60    192    3    3    1 :  252  126
ndisc_cache           60     60    128    2    2    1 :  252  126
nfs_write_data       147    209    352   17   19    1 :  124   62
nfs_read_data          0      0    352    0    0    1 :  124   62
nfs_page             188    440     96    7   11    1 :  252  126
hpsb_packet            0      0    100    0    0    1 :  252  126
tcp_tw_bucket         60     60    128    2    2    1 :  252  126
tcp_bind_bucket      273    339     32    3    3    1 :  252  126
tcp_open_request      80     80     96    2    2    1 :  252  126
inet_peer_cache       59     59     64    1    1    1 :  252  126
ip_fib_hash           10    113     32    1    1    1 :  252  126
ip_dst_cache         192    192    160    8    8    1 :  252  126
arp_cache             30     30    128    1    1    1 :  252  126
blkdev_requests      512    520     96   13   13    1 :  252  126
devfsd_event         169    169     20    1    1    1 :  252  126
journal_head         324    702     48    8    9    1 :  252  126
revoke_table           1    253     12    1    1    1 :  252  126
revoke_record        226    226     32    2    2    1 :  252  126
dnotify_cache          0      0     20    0    0    1 :  252  126
file_lock_cache      120    120     96    3    3    1 :  252  126
fasync_cache           3    202     16    1    1    1 :  252  126
uid_cache              3    113     32    1    1    1 :  252  126
skbuff_head_cache    522    648    160   22   27    1 :  252  126
sock                 192    192    928   48   48    1 :  124   62
sigqueue             164    290    132    6   10    1 :  252  126
kiobuf                 0      0     64    0    0    1 :  252  126
cdev_cache           273    295     64    5    5    1 :  252  126
bdev_cache            10    118     64    2    2    1 :  252  126
mnt_cache             18    177     64    3    3    1 :  252  126
inode_cache        26053  28416    480 3269 3552    1 :  124   62
dentry_cache       41382  43650    128 1455 1455    1 :  252  126
dquot                  3     60    128    2    2    1 :  252  126
filp                1144   1200    128   40   40    1 :  252  126
names_cache           38     38   4096   38   38    1 :   60   30
buffer_head       158790 211920     96 5172 5298    1 :  252  126
mm_struct            312    312    160   13   13    1 :  252  126
vm_area_struct      1838   2360     96   59   59    1 :  252  126
fs_cache             354    354     64    6    6    1 :  252  126
files_cache          189    189    416   21   21    1 :  124   62
signal_act           132    132   1312   44   44    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             2     13  16384    2   13    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              4     18   8192    4   18    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            112    142   4096  112  142    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            130    190   2048   76   95    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            288    288   1024   72   72    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             330    392    512   49   49    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             264    390    256   26   26    1 :  252  126
size-128(DMA)          2     30    128    1    1    1 :  252  126
size-128            2088   2970    128   99   99    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64             1119   1475     64   24   25    1 :  252  126
size-32(DMA)           2    113     32    1    1    1 :  252  126
size-32             8679  11413     32   88  101    1 :  252  126

$ vmstat 5   
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0  12000 192384  57708 598728    0    0     3     3    3     4 94  6  0  0
 2  0  12000 192384  57708 598728    0    0     0     6  101   186 99  1  0  0
 2  0  12000 192376  57708 598728    0    0     0     6  101   186 100  0  0  0
 2  0  12000 193272  57708 598728    0    0     0     0  100   185 99  1  0  0
 2  0  12000 194432  57708 598728    0    0     0     0  100   180 99  1  0  0
 3  0  12000 193404  57708 598728    0    0     0     0  100   180 99  1  0  0
 2  0  12000 194432  57708 598728    0    0     0     0  100   179 99  1  0  0
 3  0  12000 194432  57708 598728    0    0     0    17  104   177 99  1  0  0
 2  0  12000 193144  57708 598728    0    0     0     0  100   185 98  2  0  0
