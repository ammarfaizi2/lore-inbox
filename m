Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbSKFODc>; Wed, 6 Nov 2002 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbSKFODc>; Wed, 6 Nov 2002 09:03:32 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:49607 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265279AbSKFODX>; Wed, 6 Nov 2002 09:03:23 -0500
Date: Wed, 6 Nov 2002 06:09:51 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Example patch (2.5.46): Using init_disk() in IDE
Message-ID: <20021106060951.A330@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	To provide a real world example of how allowing struct gendisk
to be initialized from pointer, here is a port of drivers/ide to use
init_disk() instead of alloc_disk(), making the code 16 lines shorter
(well, two lines were from deleting unnecessary "drive->disk = NULL;"
statements, so 14 lines).  I am running the resulting code now.

	I am not submitting these IDE changes yet.  I wanted to
illustrate the clean-ups enabled by being able to initialize a struct
gendisk from a pointer.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

diff -u -r linux/drivers/ide.bak/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux/drivers/ide.bak/ide-cd.c	2002-11-04 21:38:05.000000000 -0800
+++ linux/drivers/ide/ide-cd.c	2002-11-06 05:44:22.000000000 -0800
@@ -2337,7 +2337,7 @@
 	if (stat)
 		toc->capacity = 0x1fffff;
 
-	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+	set_capacity(&drive->disk, toc->capacity * SECTORS_PER_FRAME);
 
 	/* Remember that we've read this stuff. */
 	CDROM_STATE_FLAGS(drive)->toc_valid = 1;
@@ -3071,7 +3071,7 @@
 	/*
 	 * default to read-only always and fix latter at the bottom
 	 */
-	set_disk_ro(drive->disk, 1);
+	set_disk_ro(&drive->disk, 1);
 	blk_queue_hardsect_size(&drive->queue, CD_FRAMESIZE);
 
 	blk_queue_prep_rq(&drive->queue, ide_cdrom_prep_fn);
@@ -3194,7 +3194,7 @@
 	nslots = ide_cdrom_probe_capabilities (drive);
 
 	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
-		set_disk_ro(drive->disk, 0);
+		set_disk_ro(&drive->disk, 0);
 
 #if 0
 	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
@@ -3230,7 +3230,7 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *devinfo = &info->devinfo;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 
 	if (ide_unregister_subdriver(drive)) {
 		printk("%s: %s: failed to ide_unregister_subdriver\n",
@@ -3345,7 +3345,7 @@
 static int ide_cdrom_attach (ide_drive_t *drive)
 {
 	struct cdrom_info *info;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 	struct request_sense sense;
 
 	if (!strstr("ide-cdrom", drive->driver_req))
diff -u -r linux/drivers/ide.bak/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux/drivers/ide.bak/ide-disk.c	2002-10-29 20:26:53.000000000 -0800
+++ linux/drivers/ide/ide-disk.c	2002-11-06 05:44:02.000000000 -0800
@@ -1669,7 +1669,7 @@
 
 static int idedisk_cleanup (ide_drive_t *drive)
 {
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
@@ -1786,7 +1786,7 @@
 
 static int idedisk_attach(ide_drive_t *drive)
 {
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 
 	/* strstr("foo", "") is non-NULL */
 	if (!strstr("ide-disk", drive->driver_req))
diff -u -r linux/drivers/ide.bak/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux/drivers/ide.bak/ide-floppy.c	2002-11-04 21:38:06.000000000 -0800
+++ linux/drivers/ide/ide-floppy.c	2002-11-06 05:43:41.000000000 -0800
@@ -1412,7 +1412,7 @@
 	drive->bios_cyl = 0;
 	drive->bios_head = drive->bios_sect = 0;
 	floppy->blocks = floppy->bs_factor = 0;
-	set_capacity(drive->disk, 0);
+	set_capacity(&drive->disk, 0);
 
 	idefloppy_create_read_capacity_cmd(&pc);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
@@ -1486,7 +1486,7 @@
 		(void) idefloppy_get_flexible_disk_page(drive);
 	}
 
-	set_capacity(drive->disk, floppy->blocks * floppy->bs_factor);
+	set_capacity(&drive->disk, floppy->blocks * floppy->bs_factor);
 	return rc;
 }
 
@@ -1851,7 +1851,7 @@
 static int idefloppy_cleanup (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 
 	if (ide_unregister_subdriver(drive))
 		return 1;
@@ -2069,7 +2069,7 @@
 static int idefloppy_attach (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = &drive->disk;
 	if (!strstr("ide-floppy", drive->driver_req))
 		goto failed;
 	if (!drive->present)
diff -u -r linux/drivers/ide.bak/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux/drivers/ide.bak/ide-geometry.c	2002-10-19 20:13:10.000000000 -0700
+++ linux/drivers/ide/ide-geometry.c	2002-11-06 05:43:01.000000000 -0800
@@ -203,7 +203,7 @@
 		ret = 1;
 	}
 
-	set_capacity(drive->disk, current_capacity(drive));
+	set_capacity(&drive->disk, current_capacity(drive));
 
 	if (ret)
 		printk(KERN_INFO "%s%s [%d/%d/%d]", msg, msg1,
diff -u -r linux/drivers/ide.bak/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux/drivers/ide.bak/ide-probe.c	2002-10-29 20:34:53.000000000 -0800
+++ linux/drivers/ide/ide-probe.c	2002-11-06 05:46:31.000000000 -0800
@@ -1002,36 +1002,25 @@
 	if (!drive->driver)
 		return NULL;
 	*part &= (1 << PARTN_BITS) - 1;
-	return get_disk(drive->disk);
+	return get_disk(&drive->disk);
 }
 
-static int alloc_disks(ide_hwif_t *hwif)
+static void alloc_disks(ide_hwif_t *hwif)
 {
 	unsigned int unit;
-	struct gendisk *disks[MAX_DRIVES];
 
-	for (unit = 0; unit < MAX_DRIVES; unit++) {
-		disks[unit] = alloc_disk(1 << PARTN_BITS);
-		if (!disks[unit])
-			goto Enomem;
-	}
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
-		struct gendisk *disk = disks[unit];
+		struct gendisk *disk = &drive->disk;
+		init_disk(disk, 1 << PARTN_BITS);
+		disk->part = drive->disk_partitions;
 		disk->major  = hwif->major;
 		disk->first_minor = unit << PARTN_BITS;
 		sprintf(disk->disk_name,"hd%c",'a'+hwif->index*MAX_DRIVES+unit);
 		disk->fops = ide_fops;
 		disk->private_data = drive;
 		disk->queue = &drive->queue;
-		drive->disk = disk;
 	}
-	return 0;
-Enomem:
-	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
-	while (unit--)
-		put_disk(disks[unit]);
-	return -ENOMEM;
 }
 
 /*
@@ -1101,9 +1090,8 @@
 		return 0;
 	}
 
-	if (alloc_disks(hwif) < 0)
-		goto out;
-	
+	alloc_disks(hwif);	
+
 	if (init_irq(hwif) == 0)
 		goto done;
 
@@ -1132,11 +1120,9 @@
 
 out_disks:
 	for (unit = 0; unit < MAX_DRIVES; unit++) {
-		struct gendisk *disk = hwif->drives[unit].disk;
-		hwif->drives[unit].disk = NULL;
+		struct gendisk *disk = &hwif->drives[unit].disk;
 		put_disk(disk);
 	}
-out:
 	unregister_blkdev(hwif->major, hwif->name);
 	return 0;
 }
diff -u -r linux/drivers/ide.bak/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux/drivers/ide.bak/ide-tape.c	2002-11-04 21:38:05.000000000 -0800
+++ linux/drivers/ide/ide-tape.c	2002-11-06 05:40:22.000000000 -0800
@@ -6123,7 +6123,7 @@
 	devfs_unregister(tape->de_r);
 	devfs_unregister(tape->de_n);
 	kfree (tape);
-	drive->disk->fops = ide_fops;
+	drive->disk.fops = ide_fops;
 	return 0;
 }
 
@@ -6270,7 +6270,7 @@
 			    S_IFCHR | S_IRUGO | S_IWUGO,
 			    &idetape_fops, NULL);
 	devfs_register_tape(tape->de_r);
-	drive->disk->fops = &idetape_block_ops;
+	drive->disk.fops = &idetape_block_ops;
 	return 0;
 failed:
 	return 1;
diff -u -r linux/drivers/ide.bak/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux/drivers/ide.bak/ide-taskfile.c	2002-11-04 21:38:05.000000000 -0800
+++ linux/drivers/ide/ide-taskfile.c	2002-11-06 05:40:06.000000000 -0800
@@ -1356,7 +1356,7 @@
 	rq->special = args;
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
-	rq->rq_disk = drive->disk;
+	rq->rq_disk = &drive->disk;
 	rq->waiting = &wait;
 
 	spin_lock_irqsave(&ide_lock, flags);
diff -u -r linux/drivers/ide.bak/ide.c linux/drivers/ide/ide.c
--- linux/drivers/ide.bak/ide.c	2002-11-04 21:42:37.000000000 -0800
+++ linux/drivers/ide/ide.c	2002-11-06 05:45:50.000000000 -0800
@@ -1533,7 +1533,7 @@
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 
-	rq->rq_disk = drive->disk;
+	rq->rq_disk = &drive->disk;
 
 	/*
 	 * we need to hold an extra reference to request for safe inspection
@@ -1774,9 +1774,7 @@
 	 */
 	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	for (i = 0; i < MAX_DRIVES; i++) {
-		struct gendisk *disk = hwif->drives[i].disk;
-		hwif->drives[i].disk = NULL;
-		put_disk(disk);
+		put_disk(&hwif->drives[i].disk);
 	}
 	unregister_blkdev(hwif->major, hwif->name);
 	old_hwif			= *hwif;

--vtzGhvizbBRQ85DL--
