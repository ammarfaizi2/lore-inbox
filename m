Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbTDGUSo (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTDGUSn (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:18:43 -0400
Received: from mta02.alltel.net ([166.102.165.144]:11951 "EHLO
	mta02-srv.alltel.net") by vger.kernel.org with ESMTP
	id S263630AbTDGUSk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 16:18:40 -0400
Date: Mon, 7 Apr 2003 16:30:14 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5] Kernel won't release cache unless pushed
Message-ID: <Pine.LNX.4.43.0304071615000.3052-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. In both the 2.5 and 2.4 kernel series, if I do an 'ls -lR' on a
directory with several gigs of data, the kernel will cache all of the
metadata (in dentry_cache, I think), which is fine (we don't want ram to
go to waste).

However, large malloc's then fail, returning ENOMEM, because the kernel
won't give up the memory. Staring with a small malloc, and increasing the
malloc size by 10-15 megs at a time will eventually cause it to let go,
and then the large malloc will succeed, but this seems like a bug
somewhere. If you fill RAM with file cache (by doing, say, cat *), the
memory will be freed at once when needed, and the large malloc will work,
so the kernel is able to free it instantly under some instances, but not
all. Is this a bug, or are my expectations too high?

Example:
razor:/home/bwindle/C# free -m
             total       used       free     shared    buffers     cached
Mem:           249         52        197          0          0          2
-/+ buffers/cache:         50        199
Swap:            0          0          0
razor:/home/bwindle/C# ./alloc 200
Allocating 200 megs...

 200MB
 Success.
razor:/home/bwindle/C# cd /giant/
razor:/giant# ls -lR 1>/dev/null
razor:/giant# free -m
             total       used       free     shared    buffers     cached
Mem:           249        238         11          0         17         69
-/+ buffers/cache:        151         98
Swap:            0          0          0
razor:/giant# /home/bwindle/C/alloc 150
Allocating 150 megs...

      malloc(157286400): Cannot allocate memory
razor:/giant# cat /proc/meminfo
MemTotal:       255832 kB
MemFree:         11896 kB
Buffers:         17888 kB
Cached:          71168 kB
SwapCached:          0 kB
Active:          50376 kB
Inactive:        76904 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255832 kB
LowFree:         11896 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:          39540 kB
Slab:           114172 kB
Committed_AS:   126444 kB
PageTables:        580 kB
ReverseMaps:     12957

razor:/giant# cat /proc/slabinfo
dentry_cache      109364 109364    204 5756 5756    1 :   32   16 : 121008 1115504 35299   21    0    2   51 : 1237079  98636 1163820  62536
ext2_inode_cache  151363 151368    544 21624 21624    1 :   32   16 : 151669  314826 44501    6    0    5   39 : 270372  44720 153533  10196
ext3_inode_cache     239    462    576   66   66    1 :   32   16 : 138936  580549 50579   28    0    5   39 : 701980  64946 730516  36171



--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


