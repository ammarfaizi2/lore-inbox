Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVFUHXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVFUHXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFUHXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:23:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:53731 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261991AbVFUGay convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:54 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the gendisk devfs_name field as it's no longer needed
In-Reply-To: <11193354432079@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <11193354441615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the gendisk devfs_name field as it's no longer needed

And remove the now unneeded number field.
Also fixes all drivers that set these fields.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b29ae24548f3d572399f72a6ac46b7ef3c13b2df
tree e191d4804a121404100e2f223306ee4b8f193623
parent 897ce8a75250fc3d857a017d85b927e4bb57bcb5
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:37 -0700

 arch/um/drivers/ubd_kern.c      |    8 ++------
 drivers/block/DAC960.c          |    1 -
 drivers/block/acsi.c            |    5 +----
 drivers/block/cciss.c           |    1 -
 drivers/block/cpqarray.c        |    2 --
 drivers/block/loop.c            |    1 -
 drivers/block/nbd.c             |    1 -
 drivers/block/ps2esdi.c         |    1 -
 drivers/block/rd.c              |    1 -
 drivers/block/swim3.c           |    1 -
 drivers/block/sx8.c             |    1 -
 drivers/block/ub.c              |    2 --
 drivers/block/umem.c            |    1 -
 drivers/block/viodasd.c         |    2 --
 drivers/block/xd.c              |    1 -
 drivers/block/z2ram.c           |    1 -
 drivers/cdrom/aztcd.c           |    1 -
 drivers/cdrom/gscd.c            |    1 -
 drivers/cdrom/optcd.c           |    1 -
 drivers/cdrom/sbpcd.c           |    1 -
 drivers/cdrom/sjcd.c            |    1 -
 drivers/cdrom/sonycd535.c       |    1 -
 drivers/cdrom/viocd.c           |    2 --
 drivers/ide/ide-cd.c            |    2 --
 drivers/ide/ide-disk.c          |    1 -
 drivers/ide/ide-floppy.c        |    1 -
 drivers/ide/ide-tape.c          |    1 -
 drivers/md/md.c                 |    7 ++-----
 drivers/message/i2o/i2o_block.c |    1 -
 drivers/mmc/mmc_block.c         |    1 -
 drivers/mtd/mtd_blkdevs.c       |    2 --
 drivers/s390/block/dasd_genhd.c |    2 --
 drivers/s390/block/xpram.c      |    1 -
 drivers/scsi/osst.c             |    1 -
 drivers/scsi/sd.c               |    2 --
 drivers/scsi/sr.c               |    2 --
 drivers/scsi/st.c               |    2 --
 include/linux/genhd.h           |    2 --
 38 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -628,14 +628,10 @@ static int ubd_new_disk(int major, u64 s
 	disk->first_minor = unit << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
-	if(major == MAJOR_NR){
+	if(major == MAJOR_NR)
 		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
-		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-	}
-	else {
+	else
 		sprintf(disk->disk_name, "ubd_fake%d", unit);
-		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
-	}
 
 	/* sysfs register (not for ide fake devices) */
 	if (major == MAJOR_NR) {
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -2546,7 +2546,6 @@ static boolean DAC960_RegisterBlockDevic
 	blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
 	disk->queue = RequestQueue;
 	sprintf(disk->disk_name, "rd/c%dd%d", Controller->ControllerNumber, n);
-	sprintf(disk->devfs_name, "rd/host%d/target%d", Controller->ControllerNumber, n);
 	disk->major = MajorNumber;
 	disk->first_minor = n << DAC960_MaxPartitionsBits;
 	disk->fops = &DAC960_BlockDeviceOperations;
diff --git a/drivers/block/acsi.c b/drivers/block/acsi.c
--- a/drivers/block/acsi.c
+++ b/drivers/block/acsi.c
@@ -1731,13 +1731,10 @@ int acsi_init( void )
 		struct gendisk *disk = acsi_gendisk[i];
 		sprintf(disk->disk_name, "ad%c", 'a'+i);
 		aip = &acsi_info[NDevices];
-		sprintf(disk->devfs_name, "ad/target%d/lun%d", aip->target, aip->lun);
 		disk->major = ACSI_MAJOR;
 		disk->first_minor = i << 4;
-		if (acsi_info[i].type != HARDDISK) {
+		if (acsi_info[i].type != HARDDISK)
 			disk->minors = 1;
-			strcat(disk->devfs_name, "/disc");
-		}
 		disk->fops = &acsi_fops;
 		disk->private_data = &acsi_info[i];
 		set_capacity(disk, acsi_info[i].size);
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2837,7 +2837,6 @@ static int __devinit cciss_init_one(stru
 		struct gendisk *disk = hba[i]->gendisk[j];
 
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
-		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
 		disk->major = hba[i]->major;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -1803,8 +1803,6 @@ static void getgeometry(int ctlr)
 
 				}
 
-				sprintf(disk->devfs_name, "ida/c%dd%d", ctlr, log_unit);
-
 				info_p->phys_drives =
 				    sense_config_buf->ctlr_phys_drv;
 				info_p->drv_assign_map
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1286,7 +1286,6 @@ static int __init loop_init(void)
 		disk->first_minor = i;
 		disk->fops = &lo_fops;
 		sprintf(disk->disk_name, "loop%d", i);
-		sprintf(disk->devfs_name, "loop/%d", i);
 		disk->private_data = lo;
 		disk->queue = lo->lo_queue;
 	}
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -693,7 +693,6 @@ static int __init nbd_init(void)
 		disk->private_data = &nbd_dev[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "nbd%d", i);
-		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x7ffffc00ULL << 1); /* 2 TB */
 		add_disk(disk);
 	}
diff --git a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c
+++ b/drivers/block/ps2esdi.c
@@ -422,7 +422,6 @@ static int __init ps2esdi_geninit(void)
 		disk->major = PS2ESDI_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "ed%c", 'a'+i);
-		sprintf(disk->devfs_name, "ed/target%d", i);
 		disk->fops = &ps2esdi_fops;
 		ps2esdi_gendisk[i] = disk;
 	}
diff --git a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -456,7 +456,6 @@ static int __init rd_init(void)
 		disk->queue = rd_queue[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "ram%d", i);
-		sprintf(disk->devfs_name, "rd/%d", i);
 		set_capacity(disk, rd_size * 2);
 		add_disk(rd_disks[i]);
 	}
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1057,7 +1057,6 @@ int swim3_init(void)
 		disk->queue = swim3_queue;
 		disk->flags |= GENHD_FL_REMOVABLE;
 		sprintf(disk->disk_name, "fd%d", i);
-		sprintf(disk->devfs_name, "floppy/%d", i);
 		set_capacity(disk, 2880);
 		add_disk(disk);
 	}
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1504,7 +1504,6 @@ static int carm_init_disks(struct carm_h
 		port->disk = disk;
 		sprintf(disk->disk_name, DRV_NAME "/%u",
 			(unsigned int) (host->id * CARM_MAX_PORTS) + i);
-		sprintf(disk->devfs_name, DRV_NAME "/%u_%u", host->id, i);
 		disk->major = host->major;
 		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
 		disk->fops = &carm_bd_ops;
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -32,7 +32,6 @@
 #include <scsi/scsi.h>
 
 #define DRV_NAME "ub"
-#define DEVFS_NAME DRV_NAME
 
 #define UB_MAJOR 180
 
@@ -2151,7 +2150,6 @@ static int ub_probe_lun(struct ub_dev *s
 
 	lun->disk = disk;
 	sprintf(disk->disk_name, DRV_NAME "%c", lun->id + 'a');
-	sprintf(disk->devfs_name, DEVFS_NAME "/%c", lun->id + 'a');
 	disk->major = UB_MAJOR;
 	disk->first_minor = lun->id * UB_MINORS_PER_MAJOR;
 	disk->fops = &ub_bd_fops;
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -1205,7 +1205,6 @@ static int __init mm_init(void)
 	for (i = 0; i < num_cards; i++) {
 		struct gendisk *disk = mm_gendisk[i];
 		sprintf(disk->disk_name, "umem%c", 'a'+i);
-		sprintf(disk->devfs_name, "umem/card%d", i);
 		spin_lock_init(&cards[i].lock);
 		disk->major = major_nr;
 		disk->first_minor  = i << MM_SHIFT;
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -551,8 +551,6 @@ retry:
 	else
 		snprintf(g->disk_name, sizeof(g->disk_name),
 				VIOD_GENHD_NAME "%c", 'a' + (dev_no % 26));
-	snprintf(g->devfs_name, sizeof(g->devfs_name),
-			"%s%d", VIOD_GENHD_DEVFS_NAME, dev_no);
 	g->fops = &viodasd_fops;
 	g->queue = q;
 	g->private_data = d;
diff --git a/drivers/block/xd.c b/drivers/block/xd.c
--- a/drivers/block/xd.c
+++ b/drivers/block/xd.c
@@ -211,7 +211,6 @@ static int __init xd_init(void)
 		disk->major = XT_DISK_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "xd%c", i+'a');
-		sprintf(disk->devfs_name, "xd/target%d", i);
 		disk->fops = &xd_fops;
 		disk->private_data = p;
 		disk->queue = xd_queue;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -354,7 +354,6 @@ z2_init(void)
     z2ram_gendisk->first_minor = 0;
     z2ram_gendisk->fops = &z2_fops;
     sprintf(z2ram_gendisk->disk_name, "z2ram");
-    strcpy(z2ram_gendisk->devfs_name, z2ram_gendisk->disk_name);
 
     z2ram_gendisk->queue = z2_queue;
     add_disk(z2ram_gendisk);
diff --git a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c
--- a/drivers/cdrom/aztcd.c
+++ b/drivers/cdrom/aztcd.c
@@ -1918,7 +1918,6 @@ static int __init aztcd_init(void)
 	azt_disk->first_minor = 0;
 	azt_disk->fops = &azt_fops;
 	sprintf(azt_disk->disk_name, "aztcd");
-	sprintf(azt_disk->devfs_name, "aztcd");
 	azt_disk->queue = azt_queue;
 	add_disk(azt_disk);
 	azt_invalidate_buffers();
diff --git a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
--- a/drivers/cdrom/gscd.c
+++ b/drivers/cdrom/gscd.c
@@ -955,7 +955,6 @@ static int __init gscd_init(void)
 	gscd_disk->first_minor = 0;
 	gscd_disk->fops = &gscd_fops;
 	sprintf(gscd_disk->disk_name, "gscd");
-	sprintf(gscd_disk->devfs_name, "gscd");
 
 	if (register_blkdev(MAJOR_NR, "gscd")) {
 		ret = -EIO;
diff --git a/drivers/cdrom/optcd.c b/drivers/cdrom/optcd.c
--- a/drivers/cdrom/optcd.c
+++ b/drivers/cdrom/optcd.c
@@ -2033,7 +2033,6 @@ static int __init optcd_init(void)
 	optcd_disk->first_minor = 0;
 	optcd_disk->fops = &opt_fops;
 	sprintf(optcd_disk->disk_name, "optcd");
-	sprintf(optcd_disk->devfs_name, "optcd");
 
 	if (!request_region(optcd_port, 4, "optcd")) {
 		printk(KERN_ERR "optcd: conflict, I/O port 0x%x already used\n",
diff --git a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -5873,7 +5873,6 @@ int __init sbpcd_init(void)
 		disk->fops = &sbpcd_bdops;
 		strcpy(disk->disk_name, sbpcd_infop->name);
 		disk->flags = GENHD_FL_CD;
-		sprintf(disk->devfs_name, "sbp/c0t%d", p->drv_id);
 		p->disk = disk;
 		if (register_cdrom(sbpcd_infop))
 		{
diff --git a/drivers/cdrom/sjcd.c b/drivers/cdrom/sjcd.c
--- a/drivers/cdrom/sjcd.c
+++ b/drivers/cdrom/sjcd.c
@@ -1695,7 +1695,6 @@ static int __init sjcd_init(void)
 	sjcd_disk->first_minor = 0,
 	sjcd_disk->fops = &sjcd_fops,
 	sprintf(sjcd_disk->disk_name, "sjcd");
-	sprintf(sjcd_disk->devfs_name, "sjcd");
 
 	if (!request_region(sjcd_base, 4,"sjcd")) {
 		printk
diff --git a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c
+++ b/drivers/cdrom/sonycd535.c
@@ -1590,7 +1590,6 @@ static int __init sony535_init(void)
 	cdu_disk->first_minor = 0;
 	cdu_disk->fops = &cdu_fops;
 	sprintf(cdu_disk->disk_name, "cdu");
-	sprintf(cdu_disk->devfs_name, "cdu535");
 
 	if (!request_region(sony535_cd_base_io, 4, CDU535_HANDLE)) {
 		printk(KERN_WARNING"sonycd535: Unable to request region 0x%x\n",
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -690,8 +690,6 @@ static int viocd_probe(struct vio_dev *v
 	gendisk->first_minor = deviceno;
 	strncpy(gendisk->disk_name, c->name,
 			sizeof(gendisk->disk_name));
-	snprintf(gendisk->devfs_name, sizeof(gendisk->devfs_name),
-			VIOCD_DEVICE_DEVFS "%d", deviceno);
 	blk_queue_max_hw_segments(q, 1);
 	blk_queue_max_phys_segments(q, 1);
 	blk_queue_max_sectors(q, 4096 / 512);
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3469,8 +3469,6 @@ static int ide_cd_probe(struct device *d
 	drive->driver_data = info;
 
 	g->minors = 1;
-	snprintf(g->devfs_name, sizeof(g->devfs_name),
-			"%s/cd", drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1244,7 +1244,6 @@ static int ide_disk_probe(struct device 
 		drive->attach = 1;
 
 	g->minors = 1 << PARTN_BITS;
-	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, idedisk_capacity(drive));
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2169,7 +2169,6 @@ static int ide_floppy_probe(struct devic
 
 	g->minors = 1 << PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
-	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	g->fops = &idefloppy_ops;
 	drive->attach = 1;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4875,7 +4875,6 @@ static int ide_tape_probe(struct device 
 
 	idetape_setup(drive, tape, minor);
 
-	g->number = -1;
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1470,13 +1470,10 @@ static struct kobject *md_probe(dev_t de
 	}
 	disk->major = MAJOR(dev);
 	disk->first_minor = unit << shift;
-	if (partitioned) {
+	if (partitioned)
 		sprintf(disk->disk_name, "md_d%d", unit);
-		sprintf(disk->devfs_name, "md/d%d", unit);
-	} else {
+	else
 		sprintf(disk->disk_name, "md%d", unit);
-		sprintf(disk->devfs_name, "md/%d", unit);
-	}
 	disk->fops = &md_fops;
 	disk->private_data = mddev;
 	disk->queue = mddev->queue;
diff --git a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
--- a/drivers/message/i2o/i2o_block.c
+++ b/drivers/message/i2o/i2o_block.c
@@ -1080,7 +1080,6 @@ static int i2o_block_probe(struct device
 	gd = i2o_blk_dev->gd;
 	gd->first_minor = unit << 4;
 	sprintf(gd->disk_name, "i2o/hd%c", 'a' + unit);
-	sprintf(gd->devfs_name, "i2o/hd%c", 'a' + unit);
 	gd->driverfs_dev = &i2o_dev->device;
 
 	/* setup request queue */
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -344,7 +344,6 @@ static struct mmc_blk_data *mmc_blk_allo
 		 */
 
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
-		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
 
 		md->block_bits = card->csd.read_blkbits;
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -291,8 +291,6 @@ int add_mtd_blktrans_dev(struct mtd_blkt
 	
 	snprintf(gd->disk_name, sizeof(gd->disk_name),
 		 "%s%c", tr->name, (tr->part_bits?'a':'0') + new->devnum);
-	snprintf(gd->devfs_name, sizeof(gd->devfs_name),
-		 "%s/%c", tr->name, (tr->part_bits?'a':'0') + new->devnum);
 
 	/* 2.5 has capacity in units of 512 bytes while still
 	   having BLOCK_SIZE_BITS set to 10. Just to keep us amused. */
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -73,8 +73,6 @@ dasd_gendisk_alloc(struct dasd_device *d
 	}
 	len += sprintf(gdp->disk_name + len, "%c", 'a'+(device->devindex%26));
 
- 	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
-
 	if (feature_ro)
 		set_disk_ro(gdp, 1);
 	gdp->private_data = device;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -470,7 +470,6 @@ static int __init xpram_setup_blkdev(voi
 		disk->private_data = &xpram_devices[i];
 		disk->queue = xpram_queue;
 		sprintf(disk->disk_name, "slram%d", i);
-		sprintf(disk->devfs_name, "slram/%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
 		add_disk(disk);
 	}
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5801,7 +5801,6 @@ static int osst_probe(struct device *dev
 		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
 		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
 	}
-	drive->number = -1;
 
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1612,8 +1612,6 @@ static int sd_probe(struct device *dev)
 			'a' + m1, 'a' + m2, 'a' + m3);
 	}
 
-	strcpy(gd->devfs_name, sdp->devfs_name);
-
 	gd->private_data = &sdkp->driver;
 
 	sd_revalidate_disk(gd);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -622,8 +622,6 @@ static int sr_probe(struct device *dev)
 	get_capabilities(cd);
 	sr_vendor_init(cd);
 
-	snprintf(disk->devfs_name, sizeof(disk->devfs_name),
-			"%s/cd", sdev->devfs_name);
 	disk->driverfs_dev = &sdev->sdev_gendev;
 	set_capacity(disk, cd->capacity);
 	disk->private_data = &cd->driver;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3990,8 +3990,6 @@ static int st_probe(struct device *dev)
 		do_create_class_files(tpnt, dev_num, mode);
 	}
 
-	disk->number = -1;
-
 	printk(KERN_WARNING
 	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
 	       tape_name(tpnt), SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -110,8 +110,6 @@ struct gendisk {
 	sector_t capacity;
 
 	int flags;
-	char devfs_name[64];		/* devfs crap */
-	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
 

