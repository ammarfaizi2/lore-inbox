Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSJRPLG>; Fri, 18 Oct 2002 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265165AbSJRPLF>; Fri, 18 Oct 2002 11:11:05 -0400
Received: from ns0.cobite.com ([208.222.80.10]:57357 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S265108AbSJRPLD>;
	Fri, 18 Oct 2002 11:11:03 -0400
Date: Fri, 18 Oct 2002 11:17:03 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: 2.5.43: raid5 hangs. processes in D state, raid5d at 100% cpu.
Message-ID: <Pine.LNX.4.44.0210181102240.30777-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil, list,

I've been trying to get raid5 running for a while under the development
kernels, and have been failing since the early 2.5.30's.  My current
failure scenario is back to what it was in 2.5.40 (the ll_rw_blk.c BUG has
hidden itself away again).  This particular failure was created on a raid5
made out of 3 loop devices on regular files on an ext3 filesystem on a
single SCSI disk (script used to create this is below), but the exact same
failure occurs on a raid5 of 4 disk partitions on 4 scsi disks.

The current failure looks like:

1) all processes accessing the md stuck in D state
2) raid5d stuck in a cpu-gobbling loop, R state. 

Kernel is 2.5.43 plus a patch (below) I needed to fs/block_dev.c to get
the raid device to open.  System is SMP 2xPII 450, 1GB ram (highmem_4g), 
adaptec aic7xxx.

Here are the pertinent pieces of sysrq-t (blktest is a throughput tester I 
wrote a while back):

raid5d        R DC90C938     0  3896      1                3893 (L-TLB)
Call Trace:
 [<c01229b0>] tasklet_hi_action+0x80/0xd0
 [<c0120068>] release_task+0x78/0x1c0
 [<c02aa5af>] handle_stripe+0x2cf/0xf10
 [<c01226ab>] do_softirq+0x5b/0xc0
 [<c02a8a9d>] release_stripe+0x8d/0x130
 [<c02ab729>] raid5d+0x139/0x600
 [<c02b1a89>] md_thread+0x199/0x210
 [<c0118fd0>] default_wake_function+0x0/0x40
 [<c02b18f0>] md_thread+0x0/0x210
 [<c01070d9>] kernel_thread_helper+0x5/0xc


blktest       D EE1C9B68     0  4231   3744                4180 (L-TLB)
Call Trace:
 [<c02a8e34>] get_active_stripe+0x144/0x360
 [<c0118fd0>] default_wake_function+0x0/0x40
 [<c02ab390>] raid5_unplug_device+0x1a0/0x400
 [<c014d9ba>] bio_alloc+0x13a/0x1d0
 [<c024f289>] generic_make_request+0x189/0x1a0
 [<c024f33f>] submit_bio+0x9f/0xb0
 [<c014bbd4>] __block_write_full_page+0x2c4/0x460
 [<c014f610>] blkdev_writepage+0x0/0x20
 [<c014f4e0>] blkdev_get_block+0x0/0x60
 [<c014cf18>] block_write_full_page+0xe8/0x100
 [<c014f4e0>] blkdev_get_block+0x0/0x60
 [<c0109976>] apic_timer_interrupt+0x1a/0x20
 [<c014f610>] blkdev_writepage+0x0/0x20
 [<c014f61f>] blkdev_writepage+0xf/0x20
 [<c014f4e0>] blkdev_get_block+0x0/0x60
 [<c0167179>] mpage_writepages+0x2c9/0xb01
 [<c0158ca1>] kill_fasync+0x31/0x4e
 [<c023b7e6>] n_tty_receive_buf+0xe76/0xed0
 [<c023b808>] n_tty_receive_buf+0xe98/0xed0
 [<c014f610>] blkdev_writepage+0x0/0x20
 [<c02e6e73>] tcp_v4_do_rcv+0x93/0x180
 [<c013c00a>] __pagevec_free+0x1a/0x20
 [<c01396b8>] release_pages+0x168/0x180
 [<c010ae7a>] handle_IRQ_event+0x3a/0x60
 [<c01336c6>] find_get_pages+0x36/0x80
 [<c0139a8d>] pagevec_lookup+0x1d/0x24
 [<c01465ca>] truncate_inode_pages+0x2fa/0x350
 [<c0150811>] generic_writepages+0x11/0x15
 [<c0145086>] do_writepages+0x16/0x30
 [<c0132dcf>] filemap_fdatawrite+0x4f/0x60
 [<c014a25b>] sync_blockdev+0x1b/0x40
 [<c0150606>] blkdev_put+0x76/0x1a0
 [<c0149d1b>] __fput+0x2b/0xf0
 [<c0147f10>] filp_close+0xb0/0xc0
 [<c01205db>] put_files_struct+0x4b/0xd0
 [<c0120ffc>] do_exit+0x14c/0x370
 [<c01324f1>] do_munmap+0x121/0x130
 [<c0132544>] sys_munmap+0x44/0x70
 [<c0108faf>] syscall_call+0x7/0xb

Here is the script I used to create the raid:

#!/bin/sh

DIR=/tmp
SIZE=64k

rm -f $DIR/md.pt1 $DIR/md.pt2 $DIR/md.pt3

dd if=/dev/zero of=$DIR/md.pt1 bs=1k count=$SIZE
dd if=/dev/zero of=$DIR/md.pt2 bs=1k count=$SIZE
dd if=/dev/zero of=$DIR/md.pt3 bs=1k count=$SIZE

losetup /dev/loop0 $DIR/md.pt1
losetup /dev/loop1 $DIR/md.pt2
losetup /dev/loop2 $DIR/md.pt3

cat >$DIR/raidtab.tst <<EOF
raiddev /dev/md0
  raid-level 5
  nr-raid-disks 3
  nr-spare-disks 0
  persistent-superblock 1
  parity-algorithm left-symmetric
  chunk-size 64k

  device /dev/loop0
  raid-disk 0
  device /dev/loop1
  raid-disk 1
  device /dev/loop2
  raid-disk 2
EOF

mkraid -c $DIR/raidtab.tst /dev/md0

Here is the patch to make the md open successfully:

--- linux-2.5.43/fs/block_dev.c	Mon Sep 16 07:25:59 2002
+++ linux-currentish-vanilla/fs/block_dev.c	Mon Sep 16 15:14:58 2002
@@ -612,12 +612,12 @@
 		if (owner)
 			__MOD_DEC_USE_COUNT(owner);
 	}
+
 	disk = get_gendisk(bdev->bd_dev, &part);
-	if (!disk)
-		goto out1;
+
 	if (!bdev->bd_contains) {
 		bdev->bd_contains = bdev;
-		if (part) {
+		if (disk && part) {
 			struct block_device *whole;
 			whole = bdget(MKDEV(disk->major, disk->first_minor));
 			ret = -ENOMEM;
@@ -631,7 +631,7 @@
 	}
 	if (bdev->bd_contains == bdev) {
 		if (!bdev->bd_openers)
-			bdev->bd_disk = disk;
+                       bdev->bd_disk = disk;
 		if (!bdev->bd_queue) {
 			struct blk_dev_struct *p = blk_dev + major(dev);
 			bdev->bd_queue = &p->request_queue;
@@ -645,8 +645,12 @@
 		}
 		if (!bdev->bd_openers) {
 			struct backing_dev_info *bdi;
+			sector_t sect = 0;
+
 			bdev->bd_offset = 0;
-			bd_set_size(bdev, (loff_t)get_capacity(disk) << 9);
+			if (disk)
+				sect = get_capacity(disk);
+			bd_set_size(bdev, (loff_t)sect << 9);
 			bdi = blk_get_backing_dev_info(bdev);
 			if (bdi == NULL)
 				bdi = &default_backing_dev_info;


-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


