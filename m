Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSALPLk>; Sat, 12 Jan 2002 10:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSALPLb>; Sat, 12 Jan 2002 10:11:31 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:38902 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S287048AbSALPLR>; Sat, 12 Jan 2002 10:11:17 -0500
Message-ID: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Writeout in recent kernels/VMs poor compared to last -ac
Date: Sat, 12 Jan 2002 10:17:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Jan 2002 15:17:39.0896 (UTC) FILETIME=[46312380:01C19B7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently began regularly transferring large (600 MB+) files to my
Linux-based fileserver and have noticed what I would characterize as poor
writeout behavior under this load. I've done a bit of comparison testing
which may help reveal the problem better.

Disclaimer: I did not choose this test because it is scientific or stresses
the system in any particular way. I use it because it's an operation which I
perform frequently and so the faster it goes, the broader I smile. This may
be an entirely inappropriate load to optimize for, and if so I understand.

Test consisted of FTPing in (Linux was the destination) a 650 MB file and
timing the transfer (from the client's perspective) which capturing "vmstat
1" output on the server. Server hardware is Dual PPro 200, 160 MB RAM, 512
MB swap, destination filesystem is VFAT[0] on cpqarray partition on a RAID5
logical drive. Root and swap are not on the cpqarray.

Here are my results (average of 2 runs, each from a clean reboot with all
unneeded services disabled):

2.4.17: 6:52
2.4.17-rmap11a: 6:53
2.4.18-pre2aa2: 7:10
2.4.13-ac7: 5:30 (!)
2.4.17 with cpqarray driver update from -ac: 6:30

The last test was just to see if -ac's better performance had anything to do
with the driver update. Apparently it had little or nothing to do with it.

The vmstat output is very revealing. All tests except for -ac show a strong
oscillation on the blocks out (this is a representative sample from stock
2.4.17 but the other recent kernels show essentially the same behavior):

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  1  1      0   4408   2712 118756   0   0     0     0  109    16   0   0
100
 0  1  1      0   4436   2716 118724   0   0     1  3913  287    13   0   8
92
 0  1  0      0   4436   2716 118724   0   0     0     0  118    11   0   0
100
 0  0  0      0   4352   2724 118816   0   0     8     0 3639   203   2  28
70
 0  0  0      0   4420   2736 118752   0   0    11     0 4530   259   0  33
67
 0  0  0      0   4348   2744 118816   0   0    10     0 4273   245   0  42
58
 1  0  0      0   4376   2756 118772   0   0    11     0 4551   246   1  39
60
 0  1  1      0   4364   2760 118724   0   0     4  6730 1710    93   1  19
80
 0  1  1      0   4364   2760 118724   0   0     0     0  108     9   0   0
100
 0  1  1      0   4364   2760 118724   0   0     0  3667  117     9   0   2
98
 0  1  1      0   4364   2760 118724   0   0     0     0  125     8   0   0
100
 1  0  1      0   4364   2760 118724   0   0     0  3819  124    10   0   2
98
 0  1  1      0   4372   2760 118704   0   0     0  2055  195    10   0   5
95
 0  1  1      0   4372   2760 118704   0   0     0     0  120     6   0   0
100
 0  1  1      0   4408   2760 118668   0   0     0  2415  203    16   0   4
96
 0  1  1      0   4472   2760 118608   0   0     0  4321  280    18   1   6
93
 0  2  1      0   4468   2760 118608   0   0     0     0  112     8   0   0
100
 0  1  1      0   4352   2760 118724   0   0     1  3232  227     9   0  10
90
 0  1  1      0   4352   2760 118724   0   0     0     0  108     8   0   0
100
 0  0  0      0   4440   2768 118696   0   0     7     0 3233   179   1  25
74
 1  0  0      0   4448   2776 118680   0   0    11     0 4417   253   0  36
63

-ac, on the other hand, is very smooth (still a noticeable oscillation, but
far more consistent):

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  1  0      0   3064   3900 121580   0   0     4  2051 1714   174   0  16
83
 0  1  0      0   3064   3904 121576   0   0     3  1572 1331   133   0  10
90
 0  1  0      0   3064   3904 121576   0   0     4  2048 1727   163   0  14
86
 0  1  0      0   3064   3908 121572   0   0     4  2048 1720   160   0  17
82
 0  1  0      0   3064   3912 121568   0   0     3  1536 1312   124   0  12
88
 0  1  0      0   3064   3916 121564   0   0     4  2048 1727   168   0  16
84
 0  1  1      0   3064   3920 121560   0   0     4  2080 1720   158   0  16
84
 0  1  0      0   3064   3924 121556   0   0     3  1536 1314   119   0  12
87
 0  1  0      0   3064   3928 121552   0   0     4  2048 1719   160   1  13
86
 0  1  1      0   3064   3932 121548   0   0     4  2048 1726   159   1  15
84
 0  1  0      0   3064   3936 121544   0   0     3  1536 1327   129   1  12
86
 0  1  0      0   3064   3940 121540   0   0     4  2048 1714   159   0  18
82
 1  0  1      0   3064   3944 121536   0   0     3  1920 1604   151   0  16
83
 0  1  0      0   3064   3944 121536   0   0     4  1696 1429   130   1  13
86
 0  1  0      0   3064   3948 121532   0   0     4  2048 1726   159   1  17
82
 0  1  0      0   3064   3952 121528   0   0     3  1536 1324   121   0  11
88
 0  1  0      0   3064   3956 121524   0   0     4  2051 1722   164   1  15
83
 0  0  1      0   3064   3960 121520   0   0     3  1728 1586   139   1  13
86
 0  1  0      0   3064   3964 121516   0   0     4  1856 1455   129   1  12
86
 0  1  0      0   3064   3968 121512   0   0     4  2052 1717   162   0  17
83
 0  1  0      0   3064   3972 121508   0   0     3  1568 1327   131   0  12
88

Full vmstat output for all runs is available by request.

Any ideas? I'm willing to do further testing if it is of use to anyone. I
rather like the ~15% boost I get from -ac, and I feel much more comfortable
seeing consistent behavior.

--Adam

[0] Early on I experienced some flukes with the cpqarray driver (bad RAM, I
think) so I use VFAT in case Linux suddenly doesn't want to access the array
anymore I will have a chance of booting $OTHER_OS and recovering my data.


