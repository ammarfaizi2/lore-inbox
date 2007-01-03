Return-Path: <linux-kernel-owner+w=401wt.eu-S1754889AbXACHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbXACHpn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXACHpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:45:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25818 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbXACHpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:45:41 -0500
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org
Subject: [BLOCK] 0/4 explicit io plugging
Date: Wed,  3 Jan 2007 08:48:24 +0100
Message-Id: <11678105083001-git-send-email-jens.axboe@oracle.com>
X-Mailer: git-send-email 1.4.4.2.g02c9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of 4 patches switch the block layer to use explicit
plugging instead of the implicit plugging that takes place now when io
is queued against an empty queue.

The first three patches update RCU to include a QRCU method similar to
SRCU. QRCU is a bit heavier on the reader side, but a _lot_ cheaper for
the synchronization part. The new plugging scheme needs to synchronize
queue plugs for barriers and queue quiescing, so it needs to be cheap.

The fourth patch is the actual meat of the series. It also has a longer
explanation of the benefits of the explicit plugging.

I'm sending this out to get some review of the code, and to ask people
to do some testing. I'm looking for both the "hey it works for me" as
well as benchmark runs. In the performance category, I'm interested in
both high end (lots of CPUs) testing to see whether this actually does
reduce lock contention and block layer cpu utilization as well as more
simplistic io performance results on "normal" boxes to make sure we are
not regressing anywhere.

This code is also available in the 'plug' branch of the block layer git
repo:

git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git/

 Documentation/RCU/checklist.txt |   13 +
 Documentation/RCU/rcu.txt       |    6 
 Documentation/RCU/torture.txt   |   15 -
 Documentation/RCU/whatisRCU.txt |    3 
 Documentation/block/biodoc.txt  |    5 
 block/as-iosched.c              |   15 -
 block/cfq-iosched.c             |    8 
 block/deadline-iosched.c        |    9 
 block/elevator.c                |   44 ---
 block/ll_rw_blk.c               |  483 ++++++++++++++++++++--------------------
 block/noop-iosched.c            |    8 
 drivers/block/cciss.c           |    6 
 drivers/block/cpqarray.c        |    3 
 drivers/block/floppy.c          |    1 
 drivers/block/loop.c            |   12 
 drivers/block/pktcdvd.c         |    5 
 drivers/block/rd.c              |    2 
 drivers/block/umem.c            |   16 -
 drivers/ide/ide-cd.c            |    9 
 drivers/ide/ide-io.c            |   25 --
 drivers/md/bitmap.c             |    1 
 drivers/md/dm-emc.c             |    2 
 drivers/md/dm-table.c           |   14 -
 drivers/md/dm.c                 |   18 -
 drivers/md/dm.h                 |    1 
 drivers/md/linear.c             |   14 -
 drivers/md/md.c                 |    3 
 drivers/md/multipath.c          |   32 --
 drivers/md/raid0.c              |   17 -
 drivers/md/raid1.c              |   70 -----
 drivers/md/raid10.c             |   73 ------
 drivers/md/raid5.c              |   60 ----
 drivers/message/i2o/i2o_block.c |    6 
 drivers/mmc/mmc_queue.c         |    3 
 drivers/s390/block/dasd.c       |    3 
 drivers/s390/char/tape_block.c  |    1 
 drivers/scsi/ide-scsi.c         |    2 
 drivers/scsi/scsi_lib.c         |   47 +--
 fs/adfs/inode.c                 |    1 
 fs/affs/file.c                  |    2 
 fs/befs/linuxvfs.c              |    1 
 fs/bfs/file.c                   |    1 
 fs/block_dev.c                  |    2 
 fs/buffer.c                     |   25 --
 fs/cifs/file.c                  |    2 
 fs/direct-io.c                  |    7 
 fs/ecryptfs/mmap.c              |   23 -
 fs/efs/inode.c                  |    1 
 fs/ext2/inode.c                 |    2 
 fs/ext3/inode.c                 |    3 
 fs/ext4/inode.c                 |    3 
 fs/fat/inode.c                  |    1 
 fs/freevxfs/vxfs_subr.c         |    1 
 fs/fuse/inode.c                 |    1 
 fs/gfs2/ops_address.c           |    1 
 fs/hfs/inode.c                  |    2 
 fs/hfsplus/inode.c              |    2 
 fs/hpfs/file.c                  |    1 
 fs/isofs/inode.c                |    1 
 fs/jfs/inode.c                  |    1 
 fs/jfs/jfs_metapage.c           |    1 
 fs/minix/inode.c                |    1 
 fs/ntfs/aops.c                  |    4 
 fs/ntfs/compress.c              |    2 
 fs/ocfs2/aops.c                 |    1 
 fs/ocfs2/cluster/heartbeat.c    |    4 
 fs/qnx4/inode.c                 |    1 
 fs/reiserfs/inode.c             |    1 
 fs/sysv/itree.c                 |    1 
 fs/udf/file.c                   |    1 
 fs/udf/inode.c                  |    1 
 fs/ufs/inode.c                  |    1 
 fs/ufs/truncate.c               |    2 
 fs/xfs/linux-2.6/xfs_aops.c     |    1 
 fs/xfs/linux-2.6/xfs_buf.c      |   15 -
 include/linux/backing-dev.h     |    3 
 include/linux/blkdev.h          |   75 +++---
 include/linux/buffer_head.h     |    1 
 include/linux/elevator.h        |    8 
 include/linux/fs.h              |    1 
 include/linux/pagemap.h         |   12 
 include/linux/raid/md.h         |    1 
 include/linux/sched.h           |    1 
 include/linux/srcu.h            |   30 ++
 include/linux/swap.h            |    2 
 kernel/rcutorture.c             |   71 +++++
 kernel/sched.c                  |    1 
 kernel/srcu.c                   |  105 ++++++++
 mm/filemap.c                    |   62 -----
 mm/nommu.c                      |    4 
 mm/page-writeback.c             |    8 
 mm/readahead.c                  |   11 
 mm/shmem.c                      |    1 
 mm/swap_state.c                 |    5 
 mm/swapfile.c                   |   37 ---
 mm/vmscan.c                     |    6 
 96 files changed, 632 insertions(+), 989 deletions(-)

-- 
Jens Axboe


