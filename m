Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJNKwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTJNKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:52:11 -0400
Received: from holomorphy.com ([66.224.33.161]:25738 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262306AbTJNKwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:52:03 -0400
Date: Tue, 14 Oct 2003 03:55:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: mem=16MB laptop testing
Message-ID: <20031014105514.GH765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I tried mem=16m on my laptop (stinkpad T21). I made the following
potentially useless observations:

MemTotal:        12424 kB
MemFree:           352 kB
Buffers:           180 kB
Cached:           1328 kB
SwapCached:       3548 kB
Active:           4576 kB
Inactive:          664 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        12424 kB
LowFree:           352 kB
SwapTotal:      997880 kB
SwapFree:       969112 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           4320 kB
Slab:             4884 kB
Committed_AS:    45776 kB
PageTables:        656 kB
VmallocTotal:  1015752 kB
VmallocUsed:       732 kB
VmallocChunk:  1014368 kB

(a) The profile buffer requires about a 5MB bootmem allocation;
	this near halves MemTotal when used. I refrained from using it,
	as otherwise it's a test of mem=8m instead of mem=16m.

(b) bootmem allocations aren't adding up; after kernel text, data,
	and tracing __alloc_bootmem_core(), there is still about 0.5MB
	still missing from MemTotal. I still haven't found where it's
	gone. mem_map's bootmem allocation also didn't show up in the
	logs, but it should only be 160KB for 16MB of RAM, not 512KB.
	Matt Mackall spotted this, too.

(c) mem= no longer bounds the highest physical address, but rather
	the sum of memory in e820 entries post-sanitization. This
	means a ZONE_NORMAL with about 384KB showed up, with duly
	perverse heuristic consequences for page_alloc.c

(d) The system thrashed heavily on boot, allowing the largest mm
	to acquire an RSS no larger than about 100KB. This needed
	turning /proc/sys/vm/min_free_kb down to 128 to make the
	system behave closer to normally. Matt Mackall spotted this.

(e) About 4.8MB are consumed by slab allocations at runtime.
	The top 10 slab abusers are:

inode_cache               840K           840K     100.00%   
dentry_cache              746K           753K      99.07%   
ext3_inode_cache          591K           592K      99.84%   
size-4096                 504K           504K     100.00%   
size-512                  203K           204K      99.75%   
size-2048                 182K           204K      89.22%   
pgd                       188K           188K     100.00%   
task_struct               100K           108K      92.86%   
vm_area_struct             93K           101K      92.28%   
blkdev_requests           101K           101K     100.00%   

The inode_cache culprit is the obvious butt of many complaints:
# find /sys | wc -l
2656

... which accounts for 100% of the 840KB. TANSTAAFL. OTOH, maybe we
need to learn to do better than pinning dentries and inodes in-core...

(f) the VM appeared to favor processes that burn cpu and take many faults:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  nFLT COMMAND      
  486 wli       16   0  4196 2072  456 S  1.7 16.7   0:19.41 312k slabtop      
  413 wli       15   0  4360 1064  188 S  0.0  8.6   0:20.33 757k VMTop        
  420 wli       15   0  2004  456  320 R  0.3  3.7   0:15.41 229k top          
  416 wli       16   0  5964  184  116 S  0.0  1.5   0:01.09  13k sshd         
  435 root      15   0 22304  184   88 S  0.0  1.5   0:06.60  85k XFree86      
  409 wli       15   0  5964  180  112 S  0.0  1.4   0:00.21 1646 sshd         
  466 wli       16   0  5964  180  112 S  0.0  1.4   0:00.34 4598 sshd         
  373 root      15   0  1724  152  108 S  0.0  1.2   0:00.07 2126 cron         
  207 root      16   0  1520   96   48 S  0.0  0.8   0:00.14 4342 syslogd      
  417 wli       16   0  3088   88   68 S  0.0  0.7   0:00.08 2289 zsh          

The top 3 RSS consumers were statistics reporting programs that (of
course) burn immense amounts of cpu, and in what is probably no
coincidence, also dominate the nflt category. There are also a bunch
of mostly useless processes holding bits of RAM. Load control, anyone?

(g) X isn't terribly swift; it's slower than I remember old Sun IPC's
	being, though they had 24MB RAM. OTOH luserspace is much more
	bloated these days. zsh alone is at least 3 times the size of
	ksh, which I used back then. fvwm2 is a lot bigger than fvwm1.
	And so on and so forth. I guess the upshot is "unbloating" the
	kernel wouldn't do much good anyway, since luserspace isn't in
	any kind of shape to run in this kind of environment anymore either.


-- wli
