Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUEWVuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUEWVuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUEWVuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:50:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52406 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S263641AbUEWVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:49:49 -0400
Message-ID: <40B11DAC.9070906@easyco.com>
Date: Sun, 23 May 2004 14:54:52 -0700
From: Doug Dumitru <doug@easyco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1)
 - Not out of memory.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personal replies gladly accepted at "doug at easyco.com"

I have a production system that will run for several hours and then rapidly degrade and finally 
start spitting out a 0-order allocation failed message on the console in an endless loop.  The time 
from performance degredation to hard hang is 2 to 10 minutes.

   Hardware:       Dual Xeon 3.06GHz
                   8 Gig RAM
                   Raid disk array on Adaptec I2O controller
                   1Gbit LAN

   Kernels tried:  2.4.20  4Gig
                   2.4.25  4Gig
                   2.4.25 64Gig
                   2.4.26  4Gig
                   2.4.26 64Gig

   Filesystem:     RedHat 7.3

   Applications:   Terminal-based distribution system running on
                   "D3" database with ~240 live users.

The system crashes with a swap partition (1Gig) and with no swap partition.  In trying to determine 
what was happening, I started a cron logger to log the output of cat /proc/meminfo to see if there 
were symptoms leading up to the crash.

Here is a log transition across one crash

MemTotal  is constant at 8274016
HighTotal is constant at 7471040
LowTotal  is constant at  802976

              MFree  Bufs   Cached    Active Inactive HighFree LowFree

   09:40:00   10172  31812  7284408  2813124  4687520     1044    9128
   09:41:01   18400  31600  7276472  2780948  4711328     9192    9208
   09:42:12   10756  31480  7282428  2740084  4758444     2820    7936
   09:43:00   10404  30632  7281524  2708496  4789292     2712    7692
   09:44:01    7640  29576  7280824  2662620  4835340     1500    6140
     ... note that the next log job takes an extra 38 seconds to run because
         loadavg was >100 at this point
   09:45:39    6996  29424  7282088  2580316  4917912     1084    5912
     ... system hangs and is rebooted
   09:55:00 7634392  17160   535912   535912    39024  7390488  243904

I have been trying to find a set of jobs that reproduces this crash, but have not been able to 
without actually running live users (which is not desireable).

One behaviour that I am somewhat concerned about is that LowFree drops to <10Megabytes and stays 
there with this job mix while my tests to stress the system tend to leave 240Meg to 300Meg of 
LowFree available.  I was under the impression that the kernel tries to maintain a certain amount of 
LowFree available based on tunable entries in /proc.

The user is currently running the same application on a slightly older (Dual 1.7 Xeon w/ 4G RAM) 
system and their memory usage is similar, but they don't get the hang.  Their current /proc/meminfo is:

[root@... /root]# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  3443044352 3413295104 29749248        0 79945728 2947735552
Swap: 1077469184 144068608 933400576
MemTotal:      3362348 kB
MemFree:         29052 kB
MemShared:           0 kB
Buffers:         78072 kB
Cached:        2852116 kB
SwapCached:      26532 kB
Active:        1587692 kB
Inactive:      1378096 kB
HighTotal:     2489280 kB
HighFree:        10668 kB
LowTotal:       873068 kB
LowFree:         18384 kB  (this seems awful low to me)
SwapTotal:     1052216 kB
SwapFree:       911524 kB
[root@... /root]# uptime
  11:34pm  up 9 days,  2:52,  4 users,  load average: 0.00, 0.00, 0.00

The actual crash dump is:

__alloc_pages: 0-order allocation failed (gfp=0x20/1)
cc68bad8 c0135289 00000000 011410ac 00000001 0000000c c03689dc 0000 cbccb780 cbccb780 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c02d23ba>] [<c01327f1>]
   [<c029923f>] [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>] [<c01f05ec>]
   [<c010a4de>] [<c010a6f4>] [<c0133ce6>] [<c0134152>] [<c01341fc>] [<c0134271>]
   [<c0134dff>] [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>]
   [<c014c467>] [<c014c8e9>] [<c010a72d>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d8c77c38 c0135289 00000000 de22f034 00000001 0000000c c03689dc c0368b94
        00000000 00000020 00000000 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 dbb0c000 c0725980 c0725980 011410ac c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c01327f1>] [<c029923f>]
   [<c01f0d3c>] [<c01f0c52>] [<c0121c57>] [<c01f05ec>] [<c010a4de>] [<c010a6f4>]
   [<c0133ce6>] [<c0134152>] [<c01341fc>] [<c0134271>] [<c0134dff>] [<c0135169>]
   [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>] [<c014c467>] [<c014c8e9>]
   [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d8c77c38 c0135289 00000000 de22f034 00000001 0000000c c03689dc c0368b94
        00000000 00000020 00000000 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000000 c0725980 c0725980 011410ac c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c01327f1>] [<c029923f>]
   [<c01f0d3c>] [<c01f0c52>] [<c0121c57>] [<c01f05ec>] [<c010a4de>] [<c010a6f4>]
   [<c0133ce6>] [<c0134152>] [<c01341fc>] [<c0134271>] [<c0134dff>] [<c0135169>]
   [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>] [<c014c467>] [<c014c8e9>]
   [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d8c77c38 c0135289 00000000 f598a880 00000001 0000000c c03689dc c0368b94
        00000000 00000020 c7cb0000 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 c029957c c0d14d80 c0d14d80 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c029957c>] [<c02d23ba>]
   [<c01327f1>] [<c029923f>] [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>]
   [<c01f05ec>] [<c010a4de>] [<c010a6f4>] [<c0133ce6>] [<c0134152>] [<c01341fc>]
   [<c0134271>] [<c0134dff>] [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>]
   [<c029634f>] [<c014c467>] [<c014c8e9>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d8c77c38 c0135289 00000000 f598a880 00000001 0000000c c03689dc c0368b94
        00000000 00000020 c7cb0000 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000000 c0d14d80 c0d14d80 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c02d23ba>] [<c01327f1>]
   [<c029923f>] [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>] [<c01f05ec>]
   [<c010a4de>] [<c010a6f4>] [<c0133ce6>] [<c0134152>] [<c01341fc>] [<c0134271>]
   [<c0134dff>] [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>]
   [<c014c467>] [<c014c8e9>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d93e9c5c c0135289 00000000 f598a880 00000001 0000000c c03689dc c0368b94
        00000000 00000020 c02b3b74 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 c029957c c0751b80 c0751b80 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c02b3b74>] [<c01352b0>] [<c0132214>] [<c029957c>]
   [<c02d23ba>] [<c01327f1>] [<c029923f>] [<c01f0d3c>] [<c02c6a91>] [<c01f0c52>]
   [<c02c7300>] [<c0121c57>] [<c01f05ec>] [<c010a4de>] [<c010a6f4>] [<c0133d77>]
   [<c0134152>] [<c01341fc>] [<c0134271>] [<c0134dff>] [<c0135169>] [<c01352b0>]
   [<c014c203>] [<c0146559>] [<c014c467>] [<c014c8e9>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
d93e9c5c c0135289 00000000 f598a880 00000001 0000000c c03689dc c0368b94
        00000000 00000020 c02b3b74 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000000 c0751b80 c0751b80 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c02b3b74>] [<c01352b0>] [<c0132214>] [<c02d23ba>]
   [<c01327f1>] [<c029923f>] [<c01f0d3c>] [<c02c6a91>] [<c01f0c52>] [<c02c7300>]
   [<c0121c57>] [<c01f05ec>] [<c010a4de>] [<c010a6f4>] [<c0133d77>] [<c0134152>]
   [<c01341fc>] [<c0134271>] [<c0134dff>] [<c0135169>] [<c01352b0>] [<c014c203>]
   [<c0146559>] [<c014c467>] [<c014c8e9>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
e1b73c38 c0135289 00000000 00000002 00000001 0000000c c03689dc c0368b94
        00000000 00000020 dad83880 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000000 c0eb9080 c0eb9080 011410ac c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c01327f1>] [<c029923f>]
   [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>] [<c01f05ec>] [<c010a4de>]
   [<c010a6f4>] [<c0133d0f>] [<c0134152>] [<c01341fc>] [<c0134271>] [<c0134dff>]
   [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>] [<c014c467>]
   [<c014c8e9>] [<c010a72d>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
e1b73c38 c0135289 00000000 00000002 00000001 0000000c c03689dc c0368b94
        00000000 00000020 dad83880 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000000 c0eb9080 c0eb9080 011410ac c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c01327f1>] [<c029923f>]
   [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>] [<c01f05ec>] [<c010a4de>]
   [<c010a6f4>] [<c0133d0f>] [<c0134152>] [<c01341fc>] [<c0134271>] [<c0134dff>]
   [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>] [<c029634f>] [<c014c467>]
   [<c014c8e9>] [<c010a72d>] [<c0108b63>]
__alloc_pages: 0-order allocation failed (gfp=0x20/1)
dccf7c38 c0135289 00000000 c07bf034 00000001 0000000c c03689dc c0368b94
        00000000 00000020 c02b3b74 00000000 c7c5b838 00000020 00000000 c01352b0
        c0132214 00000003 00000020 00000001 00000020 f6d3f270 ffffffff c7c5b838
Call Trace:    [<c0135289>] [<c02b3b74>] [<c01352b0>] [<c0132214>] [<c01327f1>]
   [<c029923f>] [<c01f0d3c>] [<c02c6a91>] [<c01f0c52>] [<c02c7300>] [<c0121c57>]
   [<c01f05ec>] [<c010a4de>] [<c010a6f4>] [<c0133ce6>] [<c0134152>] [<c01341fc>]

This looks to me like the memory manager stops trying to re-tune available low memory (although I 
might be very off-base).  Any explanation of how the memory manager tries to maintain available High 
and Low memory ratios would be greatly appreciated.  Also, what processes, if any, take and keep low 
memory to the point that the system can end up with <10Meg on such a large memory system.

Thank you,

--------------------------------------------------------------------
Doug Dumitru     800-470-2756        (610-237-2000)
EasyCo LLC       doug at easyco.com  http://easyco.com
--------------------------------------------------------------------

