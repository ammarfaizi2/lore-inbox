Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUDMT34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDMT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:29:56 -0400
Received: from [82.138.8.106] ([82.138.8.106]:17914 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263701AbUDMT3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:29:22 -0400
Subject: [RFC] extents,delayed allocation,mballoc for ext3
From: <alex@clusterfs.com>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, <alex@clusterfs.com>
Organization: HOME
Date: Tue, 13 Apr 2004 23:28:57 +0400
Message-ID: <m365c3pthi.fsf@bzzz.home.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


these patches implement several features for ext3:
- extents
- multiblock allocator
- delayed allocation (a.k.a. allocation on flush)


extents
=======
it's just a way to store inode's blockmap in well-known triples
[logical block; phys. block; length]. all the extents are stored
in B+Tree. code is splitted in two parts:
1) generic extents support
   implements primitives like lookup, insert, remove, walk
2) VFS part
   implements ->getblock() and ->truncate() methods

multiblock allocator
===================
the larger extents the better. the reasonable way is to ask block
allocator to allocate several blocks at once. it is possible to
scan bitmaps, but such a scanning isn't very good method. so, here
is mballoc - buddy algorithm + possibility to find contig.buddies
fast way. mballoc is backward-compatible, buddies are stored on a
disk as usual file (temporal solution until fsck support is ready)
and regenerated at mount time. also, with existing block-at-once
allocator it's impossible to write at very high rate (several
hundreds MB a sec). multiblock allocator solves this issue.

delayed allocation
==================
this is ->writepages() implementation that exploits very nice tagged
radix tree. it finds contiguous spaces and asks extents code to walk
over specified ranges of blocks. extents code calls given callback
routine that allocates blocks for listed pages, cookes a bio's and
submit them on a disk.


todo
====
1) blocks must be reserved to avoid -ENOSPC upon writeback
2) blocks must be available for allocation after committing only
3) data=order support
4) blocksize < PAGE_CACHE_SIZE support
5) option to allocator to look for +N blocks if goal is busy
6) probably preallocation for slowly-growing files
7) allocation policy tuning
8) regenerate buddies in crash case only


NOTE: don't try to use it in production. all the patches (probably
excluding extents) are pre-pre-alpha. because of size I put patches
in ftp://ftp.clusterfs.com/pub/people/alex/2.6.4-mm2/


benchmarks (hardware: 2way iPIII-1000Mhz/512MB/old scsi hdd (20MB/s)
====================================================================

I ran dd to write specified amount of data and measured time ext3
spent in allocator via get_cycles(). all the bitmaps were preloaded.

size 5kb, before:  2 allocations, 30285 cycles
size 5kb, before:  2 allocations, 27550 cycles
size 5kb, before:  2 allocations, 27307 cycles
size 5kb, before:  2 allocations, 27486 cycles
14078 cycles per block

size 5kb, after :  1 allocations, 50531 cycles
size 5kb, after :  1 allocations, 47915 cycles
size 5kb, after :  1 allocations, 51890 cycles
size 5kb, after :  1 allocations, 49094 cycles
24928 cycles per block

size 600kb, before:  151 allocations, 443282 cycles
size 600kb, before:  151 allocations, 439809 cycles
size 600kb, before:  151 allocations, 438705 cycles
size 600kb, before:  151 allocations, 506309 cycles
3026 cycles per block

size 600kb, after :  1 allocations, 55344 cycles
size 600kb, after :  1 allocations, 55094 cycles
size 600kb, after :  1 allocations, 54311 cycles
size 600kb, after :  1 allocations, 102892 cycles
446 cycles per block

size 12445kb, before:  3117 allocations, 9683780 cycles
size 12445kb, before:  3117 allocations, 9866494 cycles
size 12445kb, before:  3117 allocations, 9702287 cycles
size 12445kb, before:  3117 allocations, 10127695 cycles
3158 cycles per block

size 12445kb, after :  1 allocations, 60446 cycles
size 12445kb, after :  1 allocations, 60978 cycles
size 12445kb, after :  1 allocations, 65121 cycles
size 12445kb, after :  1 allocations, 61893 cycles
20 cycles per block


single dd writes 2GB:
before:
	real    2m2.623s
	user    0m0.028s
	sys     0m12.236s

after:
	real    1m49.696s
	user    0m0.028s
	sys     0m8.008s


9 copies of dd, each writes 20MB:
before:
	real    1m22.151s
	user    0m0.057s
	sys     0m2.102s

after:
	real    0m9.664s
	user    0m0.061s
	sys     0m1.209s


time to dbench things ...
before
	Throughput 150.215 MB/sec 8 procs
	Throughput 140.273 MB/sec 8 procs
	Throughput 153.377 MB/sec 8 procs
	Throughput 101.198 MB/sec 8 procs
	Average: 136.26575

	Throughput 68.8406 MB/sec 16 procs
	Throughput 83.0574 MB/sec 16 procs
	Throughput 48.3245 MB/sec 16 procs
	Throughput 54.4254 MB/sec 16 procs
	Average: 63.66197

	Throughput 53.6807 MB/sec 32 procs
	Throughput 66.5997 MB/sec 32 procs
	Throughput 59.4454 MB/sec 32 procs
	Throughput 62.9191 MB/sec 32 procs
	Average: 60.66122

after:
	Throughput 226.799 MB/sec 8 procs
	Throughput 205.548 MB/sec 8 procs
	Throughput 220.675 MB/sec 8 procs
	Throughput 192.285 MB/sec 8 procs
	Average: 211.32675

	Throughput 178.969 MB/sec 16 procs
	Throughput 182.105 MB/sec 16 procs
	Throughput 196.786 MB/sec 16 procs
	Throughput 180.526 MB/sec 16 procs
	Average: 184.59650

	Throughput 139.905 MB/sec 32 procs
	Throughput 132.72 MB/sec 32 procs
	Throughput 133.429 MB/sec 32 procs
	Throughput 131.498 MB/sec 32 procs
	Average: 134.38800

