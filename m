Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270543AbRHISRJ>; Thu, 9 Aug 2001 14:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270536AbRHISRB>; Thu, 9 Aug 2001 14:17:01 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:35480
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S270528AbRHISQl>; Thu, 9 Aug 2001 14:16:41 -0400
Message-ID: <02b101c120ff$8d2b2990$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] keep devfs partition nodes in sync with block device drivers
Date: Thu, 9 Aug 2001 11:17:29 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm resending this again... Richard Gooch raised some points last time, but
I think I adequately answered those. There does not appear to be a "cleaner"
solution to implement during 2.4, unless I've missed something obvious)

The attached patch (which touches nearly every block device driver that
supports partitioned media) fixes a couple of problems when devfs is in use:

- when a block device's media is "revalidated", the partition table is
re-read and /dev nodes are created for those partitions, but the previously
existing entries are not removed first. this can easily lead to "left over"
entries when the partition table is changed (either by partition table
editing or replacement of removable media)

- if media is ejected from a removable media device (normally done using an
ioctl), the /dev entries for that media do not get removed

- if a block device driver has sub-drivers (specifically the IDE layer)
loaded as modules, and one of those sub-drivers is unloaded, the /dev nodes
it was responsible for do not get removed. this problem will not occur if
the main block driver (at the major number level) is unloaded, only for
sub-drivers

The patch is against 2.4.8-pre1, but should apply to nearly any recent
kernel version. I have tested that all the drivers compile (except for acsi
and acorn/mfmhd since I don't have those platforms), and have tested the
desired effects on the ide-floppy driver. In addition, there are very likely
other block device drivers in other architecture trees that I did not touch
as the code was not clearly understandable (to me at least). Comments
welcome :-)

--- cut here ---
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/acorn/block/mfmhd.c
linux-2.4/drivers/acorn/block/mfmhd.c
--- linux-old/drivers/acorn/block/mfmhd.c Sat Jul 28 10:41:51 2001
+++ linux-2.4/drivers/acorn/block/mfmhd.c Sat Jul 28 10:48:14 2001
@@ -1492,6 +1492,7 @@

  /* Divide by 2, since sectors are 2 times smaller than usual ;-) */

+ ungrok_partitions(&mfm_gendisk, target);
  grok_partitions(&mfm_gendisk, target, 1<<6, mfm_info[target].heads *
       mfm_info[target].cylinders * mfm_info[target].sectors / 2);

diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/DAC960.c
linux-2.4/drivers/block/DAC960.c
--- linux-old/drivers/block/DAC960.c Sat Jul 28 10:41:51 2001
+++ linux-2.4/drivers/block/DAC960.c Sat Jul 28 10:48:14 2001
@@ -5153,6 +5153,8 @@
    */
    set_blocksize(Device, BLOCK_SIZE);
  }
+      ungrok_partitions(&Controller->GenericDiskInfo,
+   LogicalDriveNumber);
       if (Controller->FirmwareType == DAC960_V1_Controller)
  grok_partitions(&Controller->GenericDiskInfo,
    LogicalDriveNumber,
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/acsi.c
linux-2.4/drivers/block/acsi.c
--- linux-old/drivers/block/acsi.c Sat Jul 28 10:41:51 2001
+++ linux-2.4/drivers/block/acsi.c Sat Jul 28 10:48:14 2001
@@ -1906,6 +1906,7 @@
  ENABLE_IRQ();
  stdma_release();

+ ungrok_partitions(gdev, device);
  grok_partitions(gdev, device, (aip->type==HARDDISK)?1<<4:1, aip->size);

  DEVICE_BUSY = 0;
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/cciss.c
linux-2.4/drivers/block/cciss.c
--- linux-old/drivers/block/cciss.c Sat Jul 28 10:41:55 2001
+++ linux-2.4/drivers/block/cciss.c Sat Jul 28 10:48:14 2001
@@ -736,6 +736,7 @@
                 blksize_size[MAJOR_NR+ctlr][minor] = 1024;
         }
  /* setup partitions per disk */
+        ungrok_partitions(gdev, target);
  grok_partitions(gdev, target, MAX_PART,
    hba[ctlr]->drv[target].nr_blocks);
         hba[ctlr]->drv[target].usage_count--;
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/cpqarray.c
linux-2.4/drivers/block/cpqarray.c
--- linux-old/drivers/block/cpqarray.c Sat Jul 28 10:42:01 2001
+++ linux-2.4/drivers/block/cpqarray.c Sat Jul 28 10:48:14 2001
@@ -1665,6 +1665,7 @@
   blksize_size[MAJOR_NR+ctlr][minor] = 1024;
  }

+ ungrok_partitions(gdev, target);
  /* 16 minors per disk... */
  grok_partitions(gdev, target, 16, hba[ctlr]->drv[target].nr_blks);
  hba[ctlr]->drv[target].usage_count--;
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/paride/pd.c
linux-2.4/drivers/block/paride/pd.c
--- linux-old/drivers/block/paride/pd.c Sat Jul 28 10:41:51 2001
+++ linux-2.4/drivers/block/paride/pd.c Sat Jul 28 10:48:14 2001
@@ -510,7 +510,10 @@

         switch (cmd) {
      case CDROMEJECT:
-  if (PD.access == 1) pd_eject(unit);
+  if (PD.access == 1) {
+                    ungrok_partitions(&pd_gendisk,unit);
+                    pd_eject(unit);
+  }
   return 0;
             case HDIO_GETGEO:
                 if (!geo) return -EINVAL;
@@ -609,8 +612,10 @@
                 pd_hd[minor].nr_sects = 0;
         }

- if (pd_identify(unit))
+ if (pd_identify(unit)) {
+                ungrok_partitions(&pd_gendisk,unit);
   grok_partitions(&pd_gendisk,unit,1<<PD_BITS,PD.capacity);
+ }

         pd_valid = 1;
         wake_up(&pd_wait_open);
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/ps2esdi.c
linux-2.4/drivers/block/ps2esdi.c
--- linux-old/drivers/block/ps2esdi.c Sat Jul 28 10:41:59 2001
+++ linux-2.4/drivers/block/ps2esdi.c Sat Jul 28 10:48:14 2001
@@ -1155,6 +1155,7 @@
   ps2esdi_gendisk.part[minor].nr_sects = 0;
  }

+ ungrok_partitions(&ps2esdi_gendisk, target);
  grok_partitions(&ps2esdi_gendisk, target, 1<<6,
   ps2esdi_info[target].head * ps2esdi_info[target].cyl *
ps2esdi_info[target].sect);

diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/block/xd.c
linux-2.4/drivers/block/xd.c
--- linux-old/drivers/block/xd.c Sat Jul 28 10:41:51 2001
+++ linux-2.4/drivers/block/xd.c Sat Jul 28 10:48:14 2001
@@ -406,6 +406,7 @@
   xd_gendisk.part[minor].nr_sects = 0;
  };

+ ungrok_partitions(&xd_gendisk, target);
  grok_partitions(&xd_gendisk, target, 1<<6,
    xd_info[target].heads * xd_info[target].cylinders *
xd_info[target].sectors);

diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/i2o/i2o_block.c
linux-2.4/drivers/i2o/i2o_block.c
--- linux-old/drivers/i2o/i2o_block.c Sat Jul 28 10:41:59 2001
+++ linux-2.4/drivers/i2o/i2o_block.c Sat Jul 28 10:48:14 2001
@@ -1441,6 +1441,7 @@
   */
  dev->req_queue = &i2ob_queues[c->unit]->req_queue;

+ ungrok_partitions(&i2ob_gendisk, unit>>4);
  grok_partitions(&i2ob_gendisk, unit>>4, 1<<4, (long)(size>>9));

  /*
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/ide/hd.c
linux-2.4/drivers/ide/hd.c
--- linux-old/drivers/ide/hd.c Sat Jul 28 10:41:52 2001
+++ linux-2.4/drivers/ide/hd.c Sat Jul 28 10:48:14 2001
@@ -901,6 +901,7 @@
  MAYBE_REINIT;
 #endif

+ ungrok_partitions(gdev, target);
  grok_partitions(gdev, target, 1<<6, CAPACITY);

  DEVICE_BUSY = 0;
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/ide/ide-disk.c
linux-2.4/drivers/ide/ide-disk.c
--- linux-old/drivers/ide/ide-disk.c Sat Jul 28 10:41:39 2001
+++ linux-2.4/drivers/ide/ide-disk.c Sat Jul 28 10:48:14 2001
@@ -494,6 +494,7 @@

 static void idedisk_revalidate (ide_drive_t *drive)
 {
+ ungrok_partitions(HWIF(drive)->gd, drive->select.b.unit);
  grok_partitions(HWIF(drive)->gd, drive->select.b.unit,
    1<<PARTN_BITS,
    current_capacity(drive));
@@ -728,6 +729,7 @@

 static int idedisk_cleanup (ide_drive_t *drive)
 {
+ ungrok_partitions(HWIF(drive)->gd, drive->select.b.unit);
  return ide_unregister_subdriver(drive);
 }

diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/ide/ide-floppy.c
linux-2.4/drivers/ide/ide-floppy.c
--- linux-old/drivers/ide/ide-floppy.c Sat Jul 28 10:41:56 2001
+++ linux-2.4/drivers/ide/ide-floppy.c Sat Jul 28 10:48:14 2001
@@ -1293,7 +1293,7 @@
 /*
  * Our special ide-floppy ioctl's.
  *
- * Currently there aren't any ioctl's.
+ * Currently the only ioctl supported is to eject the cartridge, using the
CDROMEJECT ioctl.
  */
 static int idefloppy_ioctl (ide_drive_t *drive, struct inode *inode, struct
file *file,
      unsigned int cmd, unsigned long arg)
@@ -1307,6 +1307,7 @@
   (void) idefloppy_queue_pc_tail (drive, &pc);
   idefloppy_create_start_stop_cmd (&pc, 2);
   (void) idefloppy_queue_pc_tail (drive, &pc);
+                ungrok_partitions(HWIF(drive)->gd, drive->select.b.unit);
   return 0;
  }
   return -EIO;
@@ -1380,6 +1381,7 @@
  */
 static void idefloppy_revalidate (ide_drive_t *drive)
 {
+ ungrok_partitions(HWIF(drive)->gd, drive->select.b.unit);
  grok_partitions(HWIF(drive)->gd, drive->select.b.unit,
    1<<PARTN_BITS,
    current_capacity(drive));
@@ -1577,6 +1579,7 @@
 {
  idefloppy_floppy_t *floppy = drive->driver_data;

+ ungrok_partitions(HWIF(drive)->gd, drive->select.b.unit);
  if (ide_unregister_subdriver (drive))
   return 1;
  drive->driver_data = NULL;
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/mtd/nftlcore.c
linux-2.4/drivers/mtd/nftlcore.c
--- linux-old/drivers/mtd/nftlcore.c Sat Jul 28 10:41:56 2001
+++ linux-2.4/drivers/mtd/nftlcore.c Sat Jul 28 10:50:06 2001
@@ -166,6 +166,7 @@
 #if LINUX_VERSION_CODE < 0x20328
  resetup_one_dev(&nftl_gendisk, firstfree);
 #else
+  ungrok_partitions(&nftl_gendisk, firstfree);
  grok_partitions(&nftl_gendisk, firstfree, 1<<NFTL_PARTN_BITS,
nftl->nr_sects);
 #endif
 }
@@ -824,6 +825,7 @@
 #if LINUX_VERSION_CODE < 0x20328
   resetup_one_dev(&nftl_gendisk, MINOR(inode->i_rdev) >> NFTL_PARTN_BITS);
 #else
+   ungrok_partitions(&nftl_gendisk, MINOR(inode->i_rdev) >>
NFTL_PARTN_BITS);
   grok_partitions(&nftl_gendisk, MINOR(inode->i_rdev) >> NFTL_PARTN_BITS,
     1<<NFTL_PARTN_BITS, nftl->nr_sects);
 #endif
diff -rbwU3 --exclude-from=dontdiff linux-old/drivers/scsi/sd.c
linux-2.4/drivers/scsi/sd.c
--- linux-old/drivers/scsi/sd.c Sat Jul 28 10:42:00 2001
+++ linux-2.4/drivers/scsi/sd.c Sat Jul 28 10:48:14 2001
@@ -1310,6 +1310,7 @@
  MAYBE_REINIT;
 #endif

+ ungrok_partitions(&SD_GENDISK(target), target % SCSI_DISKS_PER_MAJOR);
  grok_partitions(&SD_GENDISK(target), target % SCSI_DISKS_PER_MAJOR,
    1<<4, CAPACITY);

diff -rbwU3 --exclude-from=dontdiff linux-old/fs/partitions/check.c
linux-2.4/fs/partitions/check.c
--- linux-old/fs/partitions/check.c Sat Jul 28 10:42:01 2001
+++ linux-2.4/fs/partitions/check.c Sat Jul 28 10:48:14 2001
@@ -308,7 +308,7 @@
  printk(" unknown partition table\n");
 setup_devfs:
  i = first_part_minor - 1;
- devfs_register_partitions (hd, i, hd->sizes ? 0 : 1);
+ devfs_register_partitions (hd, i, 0);
 }

 #ifdef CONFIG_DEVFS_FS
@@ -441,4 +441,11 @@
    dev->sizes[i] = dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
   blk_size[dev->major] = dev->sizes;
  }
+}
+
+void ungrok_partitions(struct gendisk *dev, int drive)
+{
+ int first_minor = drive << dev->minor_shift;
+
+        devfs_register_partitions(dev, first_minor, 1);
 }
diff -rbwU3 --exclude-from=dontdiff linux-old/include/linux/blkdev.h
linux-2.4/include/linux/blkdev.h
--- linux-old/include/linux/blkdev.h Sat Jul 28 10:42:00 2001
+++ linux-2.4/include/linux/blkdev.h Sat Jul 28 10:58:59 2001
@@ -149,6 +149,7 @@
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
 extern void grok_partitions(struct gendisk *dev, int drive, unsigned
minors, long size);
+extern void ungrok_partitions(struct gendisk *dev, int drive);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned
minors, struct block_device_operations *ops, long size);
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern request_queue_t *blk_get_queue(kdev_t dev);
diff -rbwU3 --exclude-from=dontdiff linux-old/kernel/ksyms.c
linux-2.4/kernel/ksyms.c
--- linux-old/kernel/ksyms.c Sat Jul 28 10:42:00 2001
+++ linux-2.4/kernel/ksyms.c Sat Jul 28 10:48:14 2001
@@ -296,6 +296,7 @@
 EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(gendisk_head);
 EXPORT_SYMBOL(grok_partitions);
+EXPORT_SYMBOL(ungrok_partitions);
 EXPORT_SYMBOL(register_disk);
 EXPORT_SYMBOL(tq_disk);
 EXPORT_SYMBOL(init_buffer);




