Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSKLUb5>; Tue, 12 Nov 2002 15:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbSKLUb5>; Tue, 12 Nov 2002 15:31:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43524 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266938AbSKLUbv>; Tue, 12 Nov 2002 15:31:51 -0500
Date: Tue, 12 Nov 2002 15:37:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
In-Reply-To: <3DD0E037.1FC50147@digeo.com>
Message-ID: <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002, Andrew Morton wrote:

> Tuning of 2.5 has really hardly started.  In some ways, it should be
> tested against 2.3.99 (well, not really, but...)
> 
> It will never be stunningly better than 2.4 for normal workloads on
> normal machines, because 2.4 just ain't that bad.
> 
> What is being addressed in 2.5 is the areas where 2.4 fell down:
> large machines, large numbers of threads, large disks, large amounts
> of memory, etc.  There have been really big gains in that area.
> 
> For the uniprocessors and small servers, there will be significant
> gains in some corner cases.   And some losses.  Quite a lot of work
> has gone into "fairness" issues: allowing tasks to make equal progress
> when the machine is under load.  Not stalling tasks for unreasonable
> amounts of time, etc.   Simple operations such as copying a forest
> of files from one part of the disk to another have taken a bit of a
> hit from this.  (But copying them to another disk got better).
> 
> Generally, 2.6 should be "nicer to use" on the desktop.  But not appreciably
> faster.  Significantly slower when there are several processes causing a
> lot of swapout.  That is one area where fairness really hurts throughput.
> The old `make -j30 bzImage' with mem=128M takes 1.5x as long with 2.5.
> Because everyone makes equal progress.
> 
> Most of the VM gains involve situations where there are large amounts
> of dirty data in the machine.  This has always been a big problem
> for Linux, and I think we've largely got it under control now.  There
> are still a few issues in the page reclaim code wrt this, but they're
> fairly obscure (I'm the only person who has noticed them ;))
> 
> There are some things which people simply have not yet noticed.
> 
> 
> Andrea's kernel is the fastest which 2.4 has to offer; let's tickle
> its weak spots:
> 
At this point let me say that these are not things I do every day,
thankfully. 
> 
> Run mke2fs against six disks at the same time, mem=1G:
> 
> Write six 4G files to six disks in parallel, mem=1G:
> 
> Compile a kernel while running `while true;do;./dbench 32;done' against
> the same disk.  mem=128m:

 
> It's the "doing multiple things at the same time" which gets better; the
> straightline throughput of "one thing at a time" won't change much at all.
> 
> Corner cases....

In the area of things I do do every day, the occasionally posted AIM and
BYTE benchmarks look as though pipe latency and thruput are down, UNIX
socket latency and thruput are down, and these are things which will make
the system feel slower. More to the point, they are things which seem to
go down from 2.2 to 2.4 and 2.4 to 2.6, and are not obviously impacted by
fairness. I have a context switching benchmark which I should run on a
single machine to get some results. Unfortunately I don't have a single
machine which runs all the kernels, although I might next month.

This is neither a complain nor a condemnation of the development process.
It is an observation I believe is easily checked by numbers from recent
posts to this list. See
<7F396B9772328640B7593FA817EEEDAD08AAC2@blr-m3-msg.wipro.com> for an
example. A few items:


10 signal_test        Signal Traps/second
   linux-2.4.19        60.00  13358    222.62222    222622.20
   linux-2.4.20-rc1    60.01  13350    222.49630    222496.30 
 
   linux-2.5.42        60.01  9099     151.62473    151624.73 
   linux-2.5.43        60.00  9474     157.90000    157900.00 
   linux-2.5.44        60.00  9186     153.10000    153100.00 
   linux-2.5.45        60.01  7481     124.66256    124662.56  
   linux-2.5.46        60.00  7621     127.01667    127016.67
12 fork_test          Task Creations/second
   linux-2.4.19        60.01  1903     31.70560     3170.60
   linux-2.4.20-rc1    60.01  1736     28.92510     2892.20
 
   linux-2.5.42        60.03  772      12.86024     1286.02 
   linux-2.5.43        60.06  705      11.33826     1173.83 
   linux-2.5.44        60.01  806      13.43109     1343.11 
   linux-2.5.45        60.02  867      14.44518     1444.52  
   linux-2.5.46        60.06  755      12.57076     1257.08
22 disk_src           Directory Searches/second
   linux-2.4.19        60.00  21280    354.66670    26600.10
   linux-2.4.20-rc1    60.00  20690    344.82760    25862.10 
 
   linux-2.5.42        60.00  9147     152.45000    11433.75 
   linux-2.5.43        60.00  9208     153.46667    11510.00
   linux-2.5.44        60.01  9193     153.19113    11489.34 
   linux-2.5.45        60.01  9053     150.85819    11314.36 
   linux-2.5.46        60.00  8891     148.18333    11113.75
54 tcp_test           TCP/IP Messages/second
   linux-2.4.19        60.01  36185    603.08330    54277.50
   linux-2.4.20-rc1    60.00  35735    595.58330    53602.50 
 
   linux-2.5.42        60.00  9464     157.73333    14196.00
   linux-2.5.43        60.00  9377     156.28333    14065.50
   linux-2.5.44        60.00  9368     156.13333    14052.00
   linux-2.5.45        60.01  13410    223.46276    20111.65 
   linux-2.5.46        60.01  10293    171.52141    15436.93 

Looking at the whole post, you will also see that some categories are far
better, this is not a one way street.  But latencies have been creeping
up, version by version, for some years. And I suspect if the old results
I'm looking at were run on a modern machine the values would show even
more changes.

As you say, the new kernel is being tuned, maybe these things will get
faster, but at the moment there are some performance drops in things which
happen on the desktop rather than the server.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

