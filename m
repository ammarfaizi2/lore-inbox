Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSGZVsc>; Fri, 26 Jul 2002 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318530AbSGZVsc>; Fri, 26 Jul 2002 17:48:32 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:45786 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318529AbSGZVsa>; Fri, 26 Jul 2002 17:48:30 -0400
From: peterc@gelato.unsw.edu.au
To: linux-kernel@vger.kernel.org
Date: Sat, 27 Jul 2002 07:51:43 +1000
Subject: [PATCH] New Large Block Device patch (against 2.5.28)
Message-Id: <E17YCzv-0000IQ-00@lemon.gelato.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,
	For some reason lkml is not forwarding my messages from my normal
account.  So this is from somewhere else -- a repeat of a message I sent three
days ago.

There's a new patch for supporting block devices bigger than 2TB
now available at http://www.gelato.unsw.edu.au/patches/2.5.28-lbd-patch
and bk://gelato.unsw.edu.au:2023/

Changes are: 
 
ChangeSet@1.441, 2002-07-25 14:52:39+10:00, peterc@wombat.chubb.wattle.id.au 
 
 Merge to 2.5.28: Viro's partitioning 
changes conflicted with mine.  His make mine easier! Main change here 
is to allow a partition to be more than 2^32 sectors. 
 
ChangeSet@1.403.168.1, 2002-07-25 13:24:58+10:00,peterc@wombat.chubb.wattle.id. au
 Allow block devices larger than 2TB. 
   
  On 64-bit platforms, there's almost no penalty for the change, so 
  leave it permanently enabled.  For 32-bit platforms, add a 
  configuration option. 
   
  The changes are: 
        -- sizes[] arrays are now sector_t not int. 
        -- partition functions deal in sector_t for start and size of 
           partitions. 
        -- Because sector_t could be 64-bit, change printk formats to %llu 
           and cast to (unsigned long long) where they're printed out. 
           These are entirely within slow paths anyway, so there's no  
           significant overhead to the 64-bit arithmetic. 
        -- Fix the Loop device to allow large backing devices/files. 
   
  Where there's no possibility of a problem, the sector_t is cast back 
  to int or unsigned (e.g., for creating BIOS geometry), to avoid 
  having to do 64-bit division. 
   
  There are a few places (mostly in the RAID subsystem) where a 
  division is necessary; use a macro for those based on asm/div64.h 
   
  The file system interface changes slightly: bread() and bmap() are 
  both in terms of sector_t not long.  This is primaily so that when 
  the pagecache limit is removed, these functions will not have to be 
  changed again. 
   
  A configuration option, CONFIG_LBD, was added for x86 and 
  PPC(32-bit) to allow the sector_t to become 64-bits on those 
  platforms. 
 
Diffstat is: 
 
 drivers/block/Config.help    |    4 ++ 
 drivers/block/Config.in      |    3 + 
 drivers/block/blkpg.c        |   29 +++++++++------- 
 drivers/block/cciss.c        |   10 ++--- 
 drivers/block/cciss.h        |    4 +- 
 drivers/block/cpqarray.c     |    4 +- 
 drivers/block/floppy.c       |   10 +++-- 
 drivers/block/genhd.c        |    4 +- 
 drivers/block/ll_rw_blk.c    |   14 ++++---- 
 drivers/block/loop.c         |   74 +++++++++++++++++++++++++++---------------\ drivers/block/nbd.c          |    2 - 
 drivers/block/paride/pd.c    |    2 - 
 drivers/block/ps2esdi.c      |    4 +- 
 drivers/block/rd.c           |    2 - 
 drivers/block/umem.c         |    2 - 
 drivers/block/xd.c           |    2 - 
 drivers/ide/ataraid.c        |    2 - 
 drivers/ide/hd.c             |    8 ++-- 
 drivers/ide/ide-cd.c         |   25 +++++++++----- 
 drivers/ide/ide-disk.c       |   23 ++++++------- 
 drivers/ide/ide-floppy.c     |   10 ++--- 
 drivers/ide/ide-tape.c       |    2 - 
 drivers/ide/ide.c            |    2 - 
 drivers/ide/probe.c          |    2 - 
drivers/ieee1394/sbp2.c      |    5 +- 
 drivers/md/linear.c          |   10 +++-- 
 drivers/md/lvm.c             |    2 - 
 drivers/md/md.c              |   69 ++++++++++++++++++++++------------------ 
 drivers/md/multipath.c       |   12 +++--- 
 drivers/md/raid0.c           |   21 +++++++----- 
 drivers/md/raid1.c           |   16 ++++----- 
 drivers/md/raid5.c           |    8 ++-- 
 drivers/mtd/devices/blkmtd.c |    9 ++--- 
 drivers/mtd/ftl.c            |    2 - 
 drivers/mtd/mtdblock.c       |    2 - 
 drivers/mtd/nftlcore.c       |    6 +-- 
 drivers/scsi/scsi.c          |   10 ++--- 
 drivers/scsi/sd.c            |   42 ++++++++++++++---------- 
 drivers/scsi/sd.h            |    2 - 
 drivers/scsi/sr.c            |   10 ++--- 
 fs/adfs/inode.c              |    2 - 
 fs/affs/file.c               |   13 ++++--- 
 fs/affs/inode.c              |    2 - 
 fs/bfs/file.c                |    2 - 
 fs/block_dev.c               |    4 +- 
 fs/buffer.c                  |    8 ++-- 
 fs/efs/inode.c               |    2 - 
 fs/ext2/inode.c              |    2 - 
 fs/ext3/ialloc.c             |    7 ++-- 
 fs/ext3/inode.c              |    2 - 
 fs/fat/file.c                |    2 - 
 fs/fat/inode.c               |    2 - 
 fs/freevxfs/vxfs_subr.c      |    6 +-- 
 fs/hfs/inode.c               |    2 - 
fs/inode.c                   |    4 +- 
 fs/isofs/inode.c             |   10 ++--- 
 fs/jbd/commit.c              |    4 +- 
 fs/jbd/revoke.c              |    2 - 
 fs/jfs/inode.c               |    2 - 
 fs/jfs/jfs_metapage.c        |    2 - 
 fs/minix/inode.c             |    2 - 
 fs/partitions/acorn.c        |   23 ++++++------- 
 fs/partitions/check.c        |    6 +-- 
 fs/partitions/check.h        |    7 +--- 
 fs/partitions/efi.c          |    1  
 fs/partitions/ldm.c          |    2 - 
 fs/partitions/sun.c          |    2 - 
 fs/qnx4/inode.c              |    2 - 
 fs/reiserfs/inode.c          |    2 - 
 fs/reiserfs/journal.c        |   12 +++--- 
 fs/reiserfs/prints.c         |   40 +++++++++++------------ 
 fs/reiserfs/super.c          |    6 +-- 
 fs/sysv/itree.c              |    2 - 
 fs/udf/inode.c               |    2 - 
 fs/ufs/inode.c               |    2 - 
 include/asm-i386/types.h     |    5 ++ 
 include/asm-ppc/types.h      |    5 ++ 
 include/linux/blkdev.h       |   24 +++++++++++-- 
 include/linux/fs.h           |    4 +- 
 include/linux/genhd.h        |    8 ++-- 
 include/linux/iso_fs.h       |    2 - 
 include/linux/loop.h         |    4 +- 
 include/linux/raid/md.h      |    2 - 
 include/linux/loop.h         |    4 +- 
 include/linux/raid/md.h      |    2 - 
 include/linux/raid/md_k.h    |    6 +-- 
 include/linux/types.h        |   10 ++--- 
 86 files changed, 413 insertions(+), 320 deletions(-) 
 
