Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318486AbSGSJ02>; Fri, 19 Jul 2002 05:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSGSJ02>; Fri, 19 Jul 2002 05:26:28 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:35972 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S318486AbSGSJ01>; Fri, 19 Jul 2002 05:26:27 -0400
Date: Fri, 19 Jul 2002 02:27:19 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH 5/6] move slab pages to the lru, for rmap
Message-ID: <Pine.LNX.4.44.0207190120270.4647-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Part 5 in my rmap patch queue against 2.5.26:

	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.26/
	[ 2.5.26-rmap-5-slablru 18-Jul-2002 22:35    40k ]

This is a port of Ed Tomlinson's (tomlins@cam.org) really nifty patch to 
let the (full) rmap VM do the work of freeing (inode/dentry/dquot) slab 
pages based on page aging.  

	http://mail.nl.linux.org/linux-mm/2002-06/msg00001.html

Summary: The slab pages are moved into the active list, where they are
aged and pruned.  The rate of pruning is simply the rate we see entries
for these slabs in refill_inactive_zone (while scanning the active list
for pages to deactivate).  This has the significant advantage of being
wholly self-tuning!  If we can count a slab page as fully pruned and no
longer in use, it is freed.  For non-lru slab caches, we occasionally call
kmem_cache_shrink to keep those caches in check.  A final sweep though
kmem_cache_reap() is our last protection against OOM.

---

The only significant structural change to the patch is 2.5's invocation 
of the inode caches per-filesystem.  I have given each fs's inode 
cache a pruner method during its allocation (a one-line change).  
Filesystems edited:

 fs/adfs/super.c          |    1 
 fs/affs/super.c          |    1 
 fs/bfs/inode.c           |    1 
 fs/coda/inode.c          |    2 
 fs/efs/super.c           |    1 
 fs/ext2/super.c          |    1 
 fs/ext3/super.c          |    1 
 fs/fat/inode.c           |    1 
 fs/freevxfs/vxfs_super.c |    4 
 fs/hfs/super.c           |    1 
 fs/hpfs/super.c          |    1 
 fs/isofs/inode.c         |    1 
 fs/jffs2/super.c         |    1 
 fs/jfs/super.c           |    1 
 fs/minix/inode.c         |    1 
 fs/ncpfs/inode.c         |    1 
 fs/nfs/inode.c           |    1 
 fs/ntfs/super.c          |    2 
 fs/proc/inode.c          |    1 
 fs/qnx4/inode.c          |    1 
 fs/reiserfs/super.c      |    1 
 fs/romfs/inode.c         |    1 
 fs/smbfs/inode.c         |    1 
 fs/sysv/inode.c          |    1 
 fs/udf/super.c           |    1 
 fs/ufs/super.c           |    1 

Intermezzo has a funky dentry cache that may need a pruner method (??), 
but I didn't touch it.  If there was a better way to do this, I was too 
blind to see it.  

This patch has been well tested with ext3 and the generic slab caches.  I 
expect the other filesystems' inode caches to behave correctly, but it 
wouldn't hurt to test! ... ;)

I haven't benchmarked the patch quantitatively, but the balance of 
eviction between nonslab and slab pages seems to scale with the age of the 
pages.  Slocate runs don't evict the desktop, but do evict cold daemons 
and other cruft.  New allocations for applications shrink the older slabs 
accordingly.  Seems sane.  By comparison, plain rmap-13b plunders the slab 
caches rather ruthlessly.  

The overhead for putting these pages on the lru lists, and the hopeful 
benefits for properly aging and evicting them, should be benchmarked 
sometime. 

Give it a try! :)

Craig Kulesa
Steward Observatory
Univ. of Arizona

