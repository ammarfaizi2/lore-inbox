Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVCRQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVCRQSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCRQQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:16:11 -0500
Received: from rozz.csail.mit.edu ([128.30.2.16]:43188 "EHLO
	rozz.csail.mit.edu") by vger.kernel.org with ESMTP id S261664AbVCRQMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:12:18 -0500
Date: Fri, 18 Mar 2005 11:12:18 -0500
From: Noah Meyerhans <noahm@csail.mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050318161217.GH642@csail.mit.edu>
References: <20050315204413.GF20253@csail.mit.edu> <20050315154608.29cee352.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315154608.29cee352.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Andrea, et al.  Sorry for taking a while to get back to you
on this.  Thanks a lot for the work you've already put in to this.  We
built a 2.6.11.4 kernel with Andrea's first patch for this problem (the
patch is included at the end of this mail, just to make sure you know
which one I'm referring to).  We had also switched back to overcommit
mode 0.  More comments follow inline...

On Tue, Mar 15, 2005 at 03:46:08PM -0800, Andrew Morton wrote:
> > Active:12382 inactive:280459 dirty:214 writeback:0 unstable:0 free:2299 slab:220221 mapped:12256 pagetables:122
> 
> Vast amounts of slab - presumably inode and dentries.
> 
> What sort of local filesystems are in use?

Well, that's certainly an interesting question.  The filesystem is IBM's
JFS.  If you tell me that's part of the problem, I'm not likely to
disagree.  8^)

> Can you take a copy of /proc/slabinfo when the backup has run for a while,
> send it?

We triggerred a backup process, and I watched slabtop and /proc/meminfo
while it was running, right up until the time the OOM killer was
triggered.  Unfortunately I didn't get a copy of slabinfo.  Hopefully
the slabtop and meminfo output help a bit, though.  Here are the last
three seconds worth of /proc/meminfo:

Fri Mar 18 10:41:08 EST 2005
MemTotal:      2074660 kB
MemFree:          8492 kB
Buffers:         19552 kB
Cached:        1132916 kB
SwapCached:       3672 kB
Active:          55040 kB
Inactive:      1136024 kB
HighTotal:     1179072 kB
HighFree:          576 kB
LowTotal:       895588 kB
LowFree:          7916 kB
SwapTotal:     3615236 kB
SwapFree:      3609168 kB
Dirty:              68 kB
Writeback:           0 kB
Mapped:          43744 kB
Slab:           861952 kB
CommitLimit:   4652564 kB
Committed_AS:    53272 kB
PageTables:        572 kB
VmallocTotal:   114680 kB
VmallocUsed:      6700 kB
VmallocChunk:   107964 kB
Fri Mar 18 10:41:10 EST 2005
MemTotal:      2074660 kB
MemFree:          8236 kB
Buffers:         19512 kB
Cached:        1132884 kB
SwapCached:       3672 kB
Active:          54708 kB
Inactive:      1136288 kB
HighTotal:     1179072 kB
HighFree:          576 kB
LowTotal:       895588 kB
LowFree:          7660 kB
SwapTotal:     3615236 kB
SwapFree:      3609168 kB
Dirty:              68 kB
Writeback:           0 kB
Mapped:          43744 kB
Slab:           862216 kB
CommitLimit:   4652564 kB
Committed_AS:    53272 kB
PageTables:        572 kB
VmallocTotal:   114680 kB
VmallocUsed:      6700 kB
VmallocChunk:   107964 kB
<date wasn't inserted here because OOM killer killed it>
MemTotal:      2074660 kB
MemFree:          8620 kB
Buffers:         19388 kB
Cached:        1132552 kB
SwapCached:       3780 kB
Active:          56200 kB
Inactive:      1134388 kB
HighTotal:     1179072 kB
HighFree:          960 kB
LowTotal:       895588 kB
LowFree:          7660 kB
SwapTotal:     3615236 kB
SwapFree:      3609204 kB
Dirty:             104 kB
Writeback:           0 kB
Mapped:          43572 kB
Slab:           862484 kB
CommitLimit:   4652564 kB
Committed_AS:    53100 kB
PageTables:        564 kB
VmallocTotal:   114680 kB
VmallocUsed:      6700 kB
VmallocChunk:   107964 kB

Here are the top few entries from the last page of slabtop:
830696 830639  99%    0.80K 207674        4    830696K jfs_ip
129675   4841   3%    0.05K   1729       75      6916K buffer_head
 39186  35588  90%    0.27K   2799       14     11196K radix_tree_node
  5983   2619  43%    0.12K    193       31       772K size-128
  4860   4728  97%    0.05K     60       81       240K journal_head
  4403   4403 100%    0.03K     37      119       148K size-32
  4164   4161  99%    1.00K   1041        4      4164K size-1024
  3857   1552  40%    0.13K    133       29       532K dentry_cache
  3355   1781  53%    0.06K     55       61       220K size-64
  3103   3026  97%    0.04K     29      107       116K sysfs_dir_cache
  2712   2412  88%    0.02K     12      226        48K dm_io
  2712   2412  88%    0.02K     12      226        48K dm_tio



> Does increasing /proc/sys/vm/vfs_cache_pressure help?  If you're watching
> /proc/meminfo you should be able to observe the effect of that upon the
> Slab: figure.

It doesn't have any noticable effect on the stability of the machine.  I
set it to 10000 but within a few hours the machine had crashed again.

We weren't able to capture all of the console messages prior to the
crash.  Here are some of them.  Note that, again, the last memory dump
is was manually triggered via SysRq:

nactive:132kB present:16384kB pages_scanned:1589 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:3752kB min:3756kB low:4692kB high:5632kB active:9948kB inactive:9648kB present:901120kB pages_scanned:20640 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:960kB min:512kB low:640kB high:768kB active:45132kB inactive:1125920kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB0*4096kB = 3588kB
Normal: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3752kB
HighMem: 92*4kB 10*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 960kB
Swap cache: add 2443, delete 1525, find 1049/1167, race 0+0
Free swap  = 3609204kB
Total swap = 3615236kB
Out of Memory: Killed process 21640 (zsh).
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

Free pages:        8812kB (1088kB HighMem)
Active:13647 inactive:283917 dirty:20 writeback:0 unstable:0 free:2203 slab:215622 mapped:10903 pagetables:141
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:132kB present:16384kB pages_scanned:3084 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:4136kB min:3756kB low:4692kB high:5632kB active:9504kB inactive:9656kB present:901120kB pages_scanned:22772 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:1088kB min:512kB low:640kB high:768kB active:45084kB inactive:1125880kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB0*4096kB = 3588kB
Normal: 96*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4136kB
HighMem: 116*4kB 14*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1088kB
Swap cache: add 2470, delete 1525, find 1085/1207, race 0+0
Free swap  = 3609204kB
Total swap = 3615236kB
Out of Memory: Killed process 21642 (sleep).
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

Free pages:        8940kB (1216kB HighMem)
Active:13638 inactive:283923 dirty:27 writeback:0 unstable:0 free:2235 slab:215622 mapped:10880 pagetables:141
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:132kB present:16384kB pages_scanned:3149 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:4136kB min:3756kB low:4692kB high:5632kB active:9520kB inactive:9668kB present:901120kB pages_scanned:22837 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9212
HighMem free:1216kB min:512kB low:640kB high:768kB active:45032kB inactive:1125892kB present:1179136kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB0*4096kB = 3588kB
Normal: 96*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4136kB
HighMem: 146*4kB 15*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1216kB
Swap cache: add 2470, delete 1525, find 1095/1217, race 0+0
Free swap  = 3609204kB
Total swap = 3615236kB




Andrea's patch, applied to the kernel we're currently running:
--- x/mm/vmscan.c.~1~   2005-03-14 05:02:17.000000000 +0100
+++ x/mm/vmscan.c       2005-03-16 01:28:16.000000000 +0100
@@ -1074,8 +1074,9 @@ scan:
                        total_scanned += sc.nr_scanned;
                        if (zone->all_unreclaimable)
                                continue;
-                       if (zone->pages_scanned >= (zone->nr_active +
-                                                       zone->nr_inactive) * 4)
+                       if (!reclaim_state->reclaimed_slab &&
+                           zone->pages_scanned >= (zone->nr_active +
+                                                   zone->nr_inactive) * 4)
                                zone->all_unreclaimable = 1;
                        /*
                         * If we've done a decent amount of scanning and

-- 
Noah Meyerhans                         System Administrator
MIT Computer Science and Artificial Intelligence Laboratory

