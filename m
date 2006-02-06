Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWBFEAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWBFEAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBFEAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:00:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60637 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750943AbWBFEAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:00:44 -0500
Date: Mon, 6 Feb 2006 15:00:27 +1100
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] Prevent large file writeback starvation
Message-ID: <20060206040027.GI43335175@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have recently been running some mixed workload tests on a 4p Altix,
and I came across what looks to be a lack-of-writeback problem. The
filesystem is XFS, but the problem is in the generic writeback code.

The workload involves ~16 postmark threads running in the background
each creating ~15m subdirectories of ~1m files each. The idea is
that this generates a nice, steady background file creation load.
Each file is between 1-10k in size, and it runs at 3-5k creates/s.

The disk subsystem is nowhere near I/O bound - the luns are less than 10%
busy when running this workload, and only writing about 30-40MB/s aggregate.

The problem comes when I run another thread that writes a large single
file to disk. e.g.:

# dd if=/dev/zero of=/mnt/dgc/stripe/testfile bs=1024k count=4096

to write out a 4GB file. Now this goes straight into memory (takes
about 7-8s) with some writeback occurring. The result is that approximately
2.5GB of the file is still dirty in memory.

It then takes over an hour to write the remaining data to disk. The
pattern of writeback appears to be that roughly every
dirty_expire_centisecs a chunk of 1024 pages (16MB on altix) are
written to for that large file, and it is done in a single flush.
Then the inode then gets moved to the superblock dirty list, and the
next pdflush iteration of 1024 pages works on the next inodes on the
superblock I/O list.

The problem is that when you are creating thousands of files per second
with some data in them, the superblock I/O list blows out to approximately
(create rate * expiry age) inodes, and any one inode in this list will
get a maximum of 1024 pages written back per iteration on the list.

So, in a typical 30s period, the superblock dirty inode list grows to 60-70k
inodes, which pdflush then splices to the I/O list when the I/O list is
empty. We now have and empty dirty list and a really long I/O list.

In the time it takes the I/O list to be emptied, we've created many more
thousands of files, so the large file gets moved to an extremely heavily
populated dirty list after a tiny amount of writeback. Hence when pdflush
finally empties the I/O list, it splices another 60-70k inodes into the
I/O list, and we go through the cycle again.

The result is that under this sort of load we starve the large files
of I/O bandwidth and cannot keep the disk subsystem busy.

If I ran sync(1) while there was lots of dirty data from the large file
still in memory, it would take roughly 4-5s to complete the writeback
at disk bandwidth (~400MB/s).

Looking at this comment in __sync_single_inode():

    196             if (wbc->for_kupdate) {
    197                 /*              
    198                  * For the kupdate function we leave the inode
    199                  * at the head of sb_dirty so it will get more
    200                  * writeout as soon as the queue becomes
    201                  * uncongested.
    202                  */
    203                 inode->i_state |= I_DIRTY_PAGES;
    204                 list_move_tail(&inode->i_list, &sb->s_dirty);
    205             } else {    

It appears that it is intended to handle congested devices. The thing
is, 1024 pages on writeback is not enough to congest a single disk,
let alone a RAID box 10 or 100 times faster than a single disk.
Hence we're stopping writeback long before we congest the device.

Therefore, lets only move the inode back onto the dirty list if the device
really is congested. Patch against 2.6.15-rc2 below.

The difference is that writing back the large file takes about 2
minutes - it gets written in 3 chunks of about 70,000 pages each 30s
apart.  In the test that I just ran, the create rate dips from
around 4.5k/s to 1-2k/s during each period where pdflush is flushing
the large file.

With multiple large files being written, the create rate dips lower,
for longer, due to actually geting the device to congestion levels
for periods of a few seconds, but in the time period between the
writeback of the large files, it returns to ~4.5k creates/s.

It's not perfect - the disks only reach full throughput for a
few seconds every dirty_expire_centisecs - but it's a couple of
orders of magnitude better and it scales with disk bandwidth
and queue depths.

Signed-off-by: Dave Chinner <dgc@sgi.com>

---

 fs-writeback.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- linux.orig/fs/fs-writeback.c	2006-01-25 13:10:17.000000000 +1100
+++ linux/fs/fs-writeback.c	2006-02-06 14:17:24.060687209 +1100
@@ -198,10 +198,15 @@
 				 * For the kupdate function we leave the inode
 				 * at the head of sb_dirty so it will get more
 				 * writeout as soon as the queue becomes
-				 * uncongested.
+				 * uncongested. Only do this move if we really
+				 * did encounter congestion so we don't starve
+				 * heavy writers and under-utilise disk
+				 * resources.
 				 */
 				inode->i_state |= I_DIRTY_PAGES;
-				list_move_tail(&inode->i_list, &sb->s_dirty);
+				if (wbc->encountered_congestion)
+					list_move_tail(&inode->i_list,
+							&sb->s_dirty);
 			} else {
 				/*
 				 * Otherwise fully redirty the inode so that

-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
