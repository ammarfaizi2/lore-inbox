Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVCOUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVCOUsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVCOUqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:46:20 -0500
Received: from rozz.csail.mit.edu ([128.30.2.16]:17826 "EHLO
	rozz.csail.mit.edu") by vger.kernel.org with ESMTP id S261734AbVCOUoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:44:18 -0500
Date: Tue, 15 Mar 2005 15:44:13 -0500
From: Noah Meyerhans <noahm@csail.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: OOM problems with 2.6.11-rc4
Message-ID: <20050315204413.GF20253@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  We have a server, currently running 2.6.11-rc4, that is
experiencing similar OOM problems to those described at
http://groups-beta.google.com/group/fa.linux.kernel/msg/9633559fea029f6e
and discussed further by several developers here (the summary is at
http://www.kerneltraffic.org/kernel-traffic/kt20050212_296.html#6)  We
are running 2.6.11-rc4 because it contains the patches that Andrea
mentioned in the kerneltraffic link.  The problem was present in 2.6.10
as well.  We can try newer 2.6 kernels if it helps.

The machine in question is a dual Xeon system with 2 GB of RAM, 3.5 GB
of swap, and several TB of NFS exported filesystems.  One notable point
is that this machine has been running in overcommit mode 2
(/proc/sys/vm/overcommit_memory = 2) and the OOM killer is still being
triggered, which is allegedly not supposed to be possible according to
the kerneltraffic.org document above.  We had been running in overcommit
mode 0 until about a month ago, and experienced similar OOM problems
then as well.

The problem can be somewhat reliably triggered by running our backup
software on a particular filesystem.  The backup software attempts to
keep the entire file list in memory, and this filesystem contains
several million files, so lots of memory is being allocated.

The server experienced these problems today and we captured the kernel
output, which is included below.  Note that this machine has not used
very much swap at all, and we've never observed it completely running
out of swap.

Note that in this kernel output, the last memory dump is from the magic
SysRq key.  By the time we've reached this point, the machine is
unresponsive and our next action is to trigger a sync+reboot via the
SysRq key.

File content:
057 slab:220275 mapped:12395 pagetables:118
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:696kB present:16384kB pages_scanned:1203 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:3744kB min:3756kB low:4692kB high:5632kB active:0kB inactive:368kB present:901120kB pages_scanned:683 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:896kB min:512kB low:640kB high:768kB active:50076kB inactive:1121156kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 2*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 10*8kB 1*16kB 2*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3744kB
HighMem: 82*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 896kB
Swap cache: add 2582, delete 2011, find 276/524, race 0+0
Free swap  = 3610572kB
Total swap = 3615236kB
Out of Memory: Killed process 1188 (exim).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

HighMem per-cpu:

cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:        9196kB (1856kB HighMem)
Active:12382 inactive:280459 dirty:214 writeback:0 unstable:0 free:2299 slab:220221 mapped:12256 pagetables:122
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:736kB present:16384kB pages_scanned:5706 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:3752kB min:3756kB low:4692kB high:5632kB active:0kB inactive:368kB present:901120kB pages_scanned:6943 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:1856kB min:512kB low:640kB high:768kB active:49528kB inactive:1120732kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 3*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 11*8kB 1*16kB 2*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3752kB
HighMem: 204*4kB 36*8kB 9*16kB 3*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1856kB
Swap cache: add 2582, delete 2011, find 276/524, race 0+0
Free swap  = 3610572kB
Total swap = 3615236kB
Out of Memory: Killed process 17905 (terad).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1

Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       21804kB (14464kB HighMem)
Active:9243 inactive:280452 dirty:214 writeback:0 unstable:0 free:5451 slab:220222 mapped:9110 pagetables:115
DMA free:3588kB min:68kB low:84kB high:100kB active:28kB inactive:708kB present:16384kB pages_scanned:5739 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:3752kB min:3756kB low:4692kB high:5632kB active:0kB inactive:368kB present:901120kB pages_scanned:6943 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:14464kB min:512kB low:640kB high:768kB active:36944kB inactive:1120732kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 3*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 11*8kB 1*16kB 2*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3752kB
HighMem: 1824*4kB 572*8kB 122*16kB 4*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 14464kB
Swap cache: add 2582, delete 2047, find 276/524, race 0+0
Free swap  = 3612564kB
Total swap = 3615236kB
Out of Memory: Killed process 19442 (terad).

SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       21380kB (14016kB HighMem)
Active:9400 inactive:280265 dirty:35 writeback:0 unstable:0 free:5345 slab:220381 mapped:9238 pagetables:139
DMA free:3604kB min:68kB low:84kB high:100kB active:80kB inactive:48kB present:16384kB pages_scanned:5968 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:3760kB min:3756kB low:4692kB high:5632kB active:60kB inactive:276kB present:901120kB pages_scanned:2019134 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:14016kB min:512kB low:640kB high:768kB active:37460kB inactive:1120736kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 5*4kB 2*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3604kB
Normal: 0*4kB 12*8kB 1*16kB 2*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3760kB
HighMem: 1712*4kB 572*8kB 122*16kB 4*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 14016kB
Swap cache: add 2582, delete 2047, find 276/524, race 0+0
Free swap  = 3612564kB
Total swap = 3615236kB
Free swap:       3612564kB
524160 pages of RAM
294768 pages of HIGHMEM
5496 reserved pages
22159 pages shared
535 pages swap cached

-- 
Noah Meyerhans                         System Administrator
MIT Computer Science and Artificial Intelligence Laboratory

