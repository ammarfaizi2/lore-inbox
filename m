Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbTCOEoq>; Fri, 14 Mar 2003 23:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbTCOEop>; Fri, 14 Mar 2003 23:44:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:47492 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261387AbTCOEon>;
	Fri, 14 Mar 2003 23:44:43 -0500
Date: Fri, 14 Mar 2003 20:54:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030314205455.49f834c2.akpm@digeo.com>
In-Reply-To: <20030315043744.GM1399@holomorphy.com>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net>
	<20030315043744.GM1399@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 04:54:48.0544 (UTC) FILETIME=[01849E00:01C2EAAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Fri, Mar 14, 2003 at 10:20:24AM +0300, Alex Tomas wrote:
> > and corrected patch:
> 
> This patch is a godsend. Whoever's listening, please apply!
> 
> dbench on 32x/48G NUMA-Q, aic7xxx adapter, pbay disk, 32K PAGE_SIZE
> (pgcl was used for benchmark feasibility purposes)
> 
> throughput:
> ---------- 
> before:
> Throughput 61.5376 MB/sec 512 procs
> dbench 512  637.21s user 15739.41s system 565% cpu 48:16.28 total
> 
> after:
> Throughput 104.074 MB/sec 512 procs
> (GRR, didn't do time, took ca. 30 minutes)

`dbench 512' will presumably do lots of IO and spend significant
time in I/O wait.  You should see the effects of this change more
if you use fewer clients (say, 32) so it doesn't hit disk.

On quad power4, dbench 32:

Unpatched:

	Throughput 334.372 MB/sec (NB=417.965 MB/sec  3343.72 MBit/sec)
	Throughput 331.379 MB/sec (NB=414.224 MB/sec  3313.79 MBit/sec)
	Throughput 364.151 MB/sec (NB=455.189 MB/sec  3641.51 MBit/sec)
	Throughput 333.066 MB/sec (NB=416.332 MB/sec  3330.66 MBit/sec)
	Throughput 365.335 MB/sec (NB=456.669 MB/sec  3653.35 MBit/sec)
	Throughput 335.523 MB/sec (NB=419.404 MB/sec  3355.23 MBit/sec)
	Throughput 334.457 MB/sec (NB=418.071 MB/sec  3344.57 MBit/sec)
	Throughput 329.527 MB/sec (NB=411.909 MB/sec  3295.27 MBit/sec)
	Throughput 332.721 MB/sec (NB=415.901 MB/sec  3327.21 MBit/sec)
	Throughput 328.735 MB/sec (NB=410.919 MB/sec  3287.35 MBit/sec)

patched:

	Throughput 335.262 MB/sec (NB=419.078 MB/sec  3352.62 MBit/sec)
	Throughput 334.531 MB/sec (NB=418.163 MB/sec  3345.31 MBit/sec)
	Throughput 337.366 MB/sec (NB=421.707 MB/sec  3373.66 MBit/sec)
	Throughput 334.504 MB/sec (NB=418.13 MB/sec  3345.04 MBit/sec)
	Throughput 332.482 MB/sec (NB=415.602 MB/sec  3324.82 MBit/sec)
	Throughput 334.69 MB/sec (NB=418.363 MB/sec  3346.9 MBit/sec)
	Throughput 370.14 MB/sec (NB=462.675 MB/sec  3701.4 MBit/sec)
	Throughput 333.255 MB/sec (NB=416.569 MB/sec  3332.55 MBit/sec)
	Throughput 336.065 MB/sec (NB=420.081 MB/sec  3360.65 MBit/sec)
	Throughput 334.328 MB/sec (NB=417.91 MB/sec  3343.28 MBit/sec)

No difference at all.

On the quad Xeon (after increasing dirty_ratio and dirty_background_ratio so
I/O was negligible) I was able to measure a 1.5% improvement.

I worry about the hardware you're using there.

> profile:
> --------
>
> ...
> after:
> vma        samples  %-age       symbol name
> c0106ff4   52751908 30.8696     default_idle
> c01dc3b0   28988721 16.9637     __copy_to_user_ll
> c01dc418    8240854  4.82242    __copy_from_user_ll
> c011e472    8044716  4.70764    .text.lock.fork
> c0264bd0    5666004  3.31566    sync_buffer
> c013dd28    4454362  2.60662    .text.lock.vmscan
> c0119058    4291999  2.51161    try_to_wake_up
> c0119dac    4055412  2.37316    scheduler_tick
> c011fadc    3554019  2.07976    profile_hook
> c011a1bc    2866025  1.67715    schedule
> c0119860    2637644  1.54351    load_balance
> c0108140    2433644  1.42413    .text.lock.semaphore
> c0264da0    1406704  0.823181   add_event_entry
> c011c9a4    1370708  0.802117   prepare_to_wait
> c0185e20    1236390  0.723516   ext2_new_block
> c011c4ff    1227452  0.718285   .text.lock.sched
> c013ece4    1148317  0.671977   check_highmem_ptes
> c0113590    1145881  0.670551   mark_offset_tsc

Lots of idle time.  Try it with a smaller client count, get the I/O out of
the picture.

> 
> vmstat (short excerpt, edited for readability):

With what interval?

> after:
> procs -----------memory---------- -----io---- --system-- ----cpu----
>  r  b     free    buff    cache     bi    bo   in    cs   us sy id wa
> 60 11   38659840 533920  9226720   100  1672  2760  1853   5 66 11 18
> 31 23   38565472 531264  9320384   240  1020  1195  1679   2 35 37 26
> 23 23   38384928 521952  9503104   772  3372  5624  5093   2 62  9 27
> 24 31   37945664 518080  9916448  1536  5808 10449 13484   1 45 13 41
> 31 86   37755072 516096 10091104  1040  1916  3672  9744   2 51 15 32
> 24 30   37644352 512864 10192960   900  1612  3184  8414   2 49 12 36
> 
> There's a lot of odd things going on in both of the vmstat logs.

Where are all those interrupts coming from?


