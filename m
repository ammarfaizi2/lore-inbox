Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVBDDGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVBDDGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbVBDDDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:03:42 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:38580 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263102AbVBDCyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:54:16 -0500
Date: Fri, 4 Feb 2005 03:51:58 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 6/9] kill ide_drive_t->disk
Message-ID: <Pine.GSO.4.58.0502040350580.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* move ->disk from ide_drive_t to driver specific objects
* make drivers allocate struct gendisk and setup rq->rq_disk
  (there is no need to do this for REQ_DRIVE_TASKFILE requests)
* add ide_init_disk() helper and kill alloc_disks() in ide-probe.c
* kill no longer needed ide_open() and ide_fops[] in ide.c

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-cd.c	2005-02-04 03:31:46 +01:00
@@ -556,10 +556,13 @@
 /*
  * Initialize a ide-cd packet command request
  */
-static void cdrom_prepare_request(struct request *rq)
+static void cdrom_prepare_request(ide_drive_t *drive, struct request *rq)
 {
+	struct cdrom_info *cd = drive->driver_data;
+
 	ide_init_drive_cmd(rq);
 	rq->flags = REQ_PC;
+	rq->rq_disk = cd->disk;
 }

 static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
@@ -572,7 +575,7 @@
 		sense = &info->sense_data;

 	/* stuff the sense request in front of our current request */
-	cdrom_prepare_request(rq);
+	cdrom_prepare_request(drive, rq);

 	rq->data = sense;
 	rq->cmd[0] = GPCMD_REQUEST_SENSE;
@@ -1856,7 +1859,7 @@
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = info->disk;
 	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;

 	/*
@@ -2048,7 +2051,7 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = sense;
 	req.cmd[0] = GPCMD_TEST_UNIT_READY;
@@ -2080,7 +2083,7 @@
 	if (CDROM_CONFIG_FLAGS(drive)->no_doorlock) {
 		stat = 0;
 	} else {
-		cdrom_prepare_request(&req);
+		cdrom_prepare_request(drive, &req);
 		req.sense = sense;
 		req.cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
 		req.cmd[4] = lockflag ? 1 : 0;
@@ -2124,7 +2127,7 @@
 	if (CDROM_STATE_FLAGS(drive)->door_locked && ejectflag)
 		return 0;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	/* only tell drive to close tray if open, if it can do that */
 	if (ejectflag && !CDROM_CONFIG_FLAGS(drive)->close_tray)
@@ -2148,7 +2151,7 @@
 	int stat;
 	struct request req;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = sense;
 	req.cmd[0] = GPCMD_READ_CDVD_CAPACITY;
@@ -2171,7 +2174,7 @@
 {
 	struct request req;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = sense;
 	req.data =  buf;
@@ -2228,7 +2231,7 @@
 	if (stat)
 		toc->capacity = 0x1fffff;

-	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
+	set_capacity(info->disk, toc->capacity * sectors_per_frame);
 	blk_queue_hardsect_size(drive->queue,
 				sectors_per_frame << SECTOR_BITS);

@@ -2348,7 +2351,7 @@
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && (last_written > toc->capacity)) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
+		set_capacity(info->disk, toc->capacity * sectors_per_frame);
 	}

 	/* Remember that we've read this stuff. */
@@ -2363,7 +2366,7 @@
 {
 	struct request req;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = sense;
 	req.data = buf;
@@ -2383,7 +2386,7 @@
 			      struct request_sense *sense)
 {
 	struct request req;
-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = sense;
 	if (speed == 0)
@@ -2413,7 +2416,7 @@
 	struct request_sense sense;
 	struct request req;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);

 	req.sense = &sense;
 	req.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
@@ -2463,7 +2466,7 @@
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);
 	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
 	if (cgc->sense)
 		memset(cgc->sense, 0, sizeof(struct request_sense));
@@ -2613,7 +2616,7 @@
 	struct request req;
 	int ret;

-	cdrom_prepare_request(&req);
+	cdrom_prepare_request(drive, &req);
 	req.flags = REQ_SPECIAL | REQ_QUIET;
 	ret = ide_do_drive_cmd(drive, &req, ide_wait);

@@ -2857,7 +2860,7 @@
 	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		devinfo->mask |= CDC_MO_DRIVE;

-	devinfo->disk = drive->disk;
+	devinfo->disk = info->disk;
 	return register_cdrom(devinfo);
 }

@@ -3262,7 +3265,7 @@
 		return 1;
 	}

-	del_gendisk(drive->disk);
+	del_gendisk(info->disk);

 	ide_cd_put(info);

@@ -3274,7 +3277,7 @@
 	struct cdrom_info *info = to_ide_cd(kref);
 	struct cdrom_device_info *devinfo = &info->devinfo;
 	ide_drive_t *drive = info->drive;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = info->disk;

 	if (info->buffer != NULL)
 		kfree(info->buffer);
@@ -3289,7 +3292,7 @@
 	drive->driver_data = NULL;
 	blk_queue_prep_rq(drive->queue, NULL);
 	g->private_data = NULL;
-	g->fops = ide_fops;
+	put_disk(g);
 	kfree(info);
 }

@@ -3417,7 +3420,7 @@
 static int ide_cdrom_attach (ide_drive_t *drive)
 {
 	struct cdrom_info *info;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g;
 	struct request_sense sense;

 	if (!strstr("ide-cdrom", drive->driver_req))
@@ -3442,17 +3445,25 @@
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;
 	}
+
+	g = alloc_disk(1 << PARTN_BITS);
+	if (!g)
+		goto out_free_cd;
+
+	ide_init_disk(g, drive);
+
 	if (ide_register_subdriver(drive, &ide_cdrom_driver)) {
 		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n",
 			drive->name);
-		kfree(info);
-		goto failed;
+		goto out_put_disk;
 	}
 	memset(info, 0, sizeof (struct cdrom_info));

 	kref_init(&info->kref);

 	info->drive = drive;
+	info->disk = g;
+
 	drive->driver_data = info;

 	DRIVER(drive)->busy++;
@@ -3485,6 +3496,11 @@
 	g->flags |= GENHD_FL_REMOVABLE;
 	add_disk(g);
 	return 0;
+
+out_put_disk:
+	put_disk(g);
+out_free_cd:
+	kfree(info);
 failed:
 	return 1;
 }
diff -Nru a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
--- a/drivers/ide/ide-cd.h	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-cd.h	2005-02-04 03:31:46 +01:00
@@ -461,6 +461,7 @@
 /* Extra per-device info for cdrom drives. */
 struct cdrom_info {
 	ide_drive_t	*drive;
+	struct gendisk	*disk;
 	struct kref	kref;

 	/* Buffer for table of contents.  NULL if we haven't allocated
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-04 03:31:46 +01:00
@@ -73,6 +73,7 @@

 struct ide_disk_obj {
 	ide_drive_t	*drive;
+	struct gendisk	*disk;
 	struct kref	kref;
 };

@@ -973,7 +974,7 @@
 static int idedisk_cleanup (ide_drive_t *drive)
 {
 	struct ide_disk_obj *idkp = drive->driver_data;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = idkp->disk;

 	ide_cacheflush_p(drive);
 	if (ide_unregister_subdriver(drive))
@@ -989,12 +990,12 @@
 {
 	struct ide_disk_obj *idkp = to_ide_disk(kref);
 	ide_drive_t *drive = idkp->drive;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = idkp->disk;

 	drive->driver_data = NULL;
 	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
-	g->fops = ide_fops;
+	put_disk(g);
 	kfree(idkp);
 }

@@ -1148,7 +1149,7 @@
 static int idedisk_attach(ide_drive_t *drive)
 {
 	struct ide_disk_obj *idkp;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g;

 	/* strstr("foo", "") is non-NULL */
 	if (!strstr("ide-disk", drive->driver_req))
@@ -1162,9 +1163,15 @@
 	if (!idkp)
 		goto failed;

+	g = alloc_disk(1 << PARTN_BITS);
+	if (!g)
+		goto out_free_idkp;
+
+	ide_init_disk(g, drive);
+
 	if (ide_register_subdriver(drive, &idedisk_driver)) {
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_free_idkp;
+		goto out_put_disk;
 	}

 	memset(idkp, 0, sizeof(*idkp));
@@ -1172,6 +1179,8 @@
 	kref_init(&idkp->kref);

 	idkp->drive = drive;
+	idkp->disk = g;
+
 	drive->driver_data = idkp;

 	DRIVER(drive)->busy++;
@@ -1192,6 +1201,9 @@
 	g->private_data = idkp;
 	add_disk(g);
 	return 0;
+
+out_put_disk:
+	put_disk(g);
 out_free_idkp:
 	kfree(idkp);
 failed:
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-02-04 03:31:46 +01:00
@@ -276,6 +276,7 @@
  */
 typedef struct ide_floppy_obj {
 	ide_drive_t	*drive;
+	struct gendisk	*disk;
 	struct kref	kref;

 	/* Current packet command */
@@ -680,9 +681,12 @@
  */
 static void idefloppy_queue_pc_head (ide_drive_t *drive,idefloppy_pc_t *pc,struct request *rq)
 {
+	struct ide_floppy_obj *floppy = drive->driver_data;
+
 	ide_init_drive_cmd(rq);
 	rq->buffer = (char *) pc;
 	rq->flags = REQ_SPECIAL;	//rq->cmd = IDEFLOPPY_PC_RQ;
+	rq->rq_disk = floppy->disk;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }

@@ -1274,7 +1278,8 @@
 	unsigned long block = (unsigned long)block_s;

 	debug_log(KERN_INFO "rq_status: %d, dev: %s, flags: %lx, errors: %d\n",
-			rq->rq_status, rq->rq_disk->disk_name,
+			rq->rq_status,
+			rq->rq_disk ? rq->rq_disk->disk_name ? "?",
 			rq->flags, rq->errors);
 	debug_log(KERN_INFO "sector: %ld, nr_sectors: %ld, "
 			"current_nr_sectors: %d\n", (long)rq->sector,
@@ -1329,11 +1334,13 @@
  */
 static int idefloppy_queue_pc_tail (ide_drive_t *drive,idefloppy_pc_t *pc)
 {
+	struct ide_floppy_obj *floppy = drive->driver_data;
 	struct request rq;

 	ide_init_drive_cmd (&rq);
 	rq.buffer = (char *) pc;
 	rq.flags = REQ_SPECIAL;		//	rq.cmd = IDEFLOPPY_PC_RQ;
+	rq.rq_disk = floppy->disk;

 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1358,7 +1365,7 @@
 	}
 	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
 	floppy->wp = header->wp;
-	set_disk_ro(drive->disk, floppy->wp);
+	set_disk_ro(floppy->disk, floppy->wp);
 	page = (idefloppy_flexible_disk_page_t *) (header + 1);

 	page->transfer_rate = ntohs(page->transfer_rate);
@@ -1424,7 +1431,7 @@
 	drive->bios_cyl = 0;
 	drive->bios_head = drive->bios_sect = 0;
 	floppy->blocks = floppy->bs_factor = 0;
-	set_capacity(drive->disk, 0);
+	set_capacity(floppy->disk, 0);

 	idefloppy_create_read_capacity_cmd(&pc);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
@@ -1498,7 +1505,7 @@
 		(void) idefloppy_get_flexible_disk_page(drive);
 	}

-	set_capacity(drive->disk, floppy->blocks * floppy->bs_factor);
+	set_capacity(floppy->disk, floppy->blocks * floppy->bs_factor);
 	return rc;
 }

@@ -1859,7 +1866,7 @@
 static int idefloppy_cleanup (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = floppy->disk;

 	if (ide_unregister_subdriver(drive))
 		return 1;
@@ -1875,11 +1882,11 @@
 {
 	struct ide_floppy_obj *floppy = to_ide_floppy(kref);
 	ide_drive_t *drive = floppy->drive;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = floppy->disk;

 	drive->driver_data = NULL;
 	g->private_data = NULL;
-	g->fops = ide_fops;
+	put_disk(g);
 	kfree(floppy);
 }

@@ -2116,7 +2123,8 @@
 static int idefloppy_attach (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g;
+
 	if (!strstr("ide-floppy", drive->driver_req))
 		goto failed;
 	if (!drive->present)
@@ -2135,10 +2143,16 @@
 		printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
 		goto failed;
 	}
+
+	g = alloc_disk(1 << PARTN_BITS);
+	if (!g)
+		goto out_free_floppy;
+
+	ide_init_disk(g, drive);
+
 	if (ide_register_subdriver(drive, &idefloppy_driver)) {
 		printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
-		kfree (floppy);
-		goto failed;
+		goto out_put_disk;
 	}

 	memset(floppy, 0, sizeof(*floppy));
@@ -2146,6 +2160,7 @@
 	kref_init(&floppy->kref);

 	floppy->drive = drive;
+	floppy->disk = g;

 	drive->driver_data = floppy;

@@ -2161,6 +2176,11 @@
 	drive->attach = 1;
 	add_disk(g);
 	return 0;
+
+out_put_disk:
+	put_disk(g);
+out_free_floppy:
+	kfree(floppy);
 failed:
 	return 1;
 }
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-04 03:31:46 +01:00
@@ -1752,8 +1752,6 @@
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;

-	rq->rq_disk = drive->disk;
-
 	/*
 	 * we need to hold an extra reference to request for safe inspection
 	 * after completion
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-probe.c	2005-02-04 03:31:46 +01:00
@@ -1011,10 +1011,8 @@
 	blk_queue_max_hw_segments(q, max_sg_entries);
 	blk_queue_max_phys_segments(q, max_sg_entries);

-	/* assign drive and gendisk queue */
+	/* assign drive queue */
 	drive->queue = q;
-	if (drive->disk)
-		drive->disk->queue = drive->queue;

 	/* needs drive->queue to be set */
 	ide_toggle_bounce(drive, 1);
@@ -1268,34 +1266,19 @@

 EXPORT_SYMBOL_GPL(ide_unregister_region);

-static int alloc_disks(ide_hwif_t *hwif)
+void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
 {
-	unsigned int unit;
-	struct gendisk *disks[MAX_DRIVES];
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned int unit = drive->select.all & (1 << 4);

-	for (unit = 0; unit < MAX_DRIVES; unit++) {
-		disks[unit] = alloc_disk(1 << PARTN_BITS);
-		if (!disks[unit])
-			goto Enomem;
-	}
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
-		struct gendisk *disk = disks[unit];
-		disk->major  = hwif->major;
-		disk->first_minor = unit << PARTN_BITS;
-		sprintf(disk->disk_name,"hd%c",'a'+hwif->index*MAX_DRIVES+unit);
-		disk->fops = ide_fops;
-		disk->private_data = drive;
-		drive->disk = disk;
-	}
-	return 0;
-Enomem:
-	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
-	while (unit--)
-		put_disk(disks[unit]);
-	return -ENOMEM;
+	disk->major = hwif->major;
+	disk->first_minor = unit << PARTN_BITS;
+	sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit);
+	disk->queue = drive->queue;
 }

+EXPORT_SYMBOL_GPL(ide_init_disk);
+
 static void drive_release_dev (struct device *dev)
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
@@ -1336,7 +1319,7 @@

 static int hwif_init(ide_hwif_t *hwif)
 {
-	int old_irq, unit;
+	int old_irq;

 	if (!hwif->present)
 		return 0;
@@ -1371,9 +1354,6 @@
 		printk(KERN_ERR "%s: unable to allocate SG table.\n", hwif->name);
 		goto out;
 	}
-
-	if (alloc_disks(hwif) < 0)
-		goto out;

 	if (init_irq(hwif) == 0)
 		goto done;
@@ -1386,12 +1366,12 @@
 	if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET]))) {
 		printk("%s: Disabled unable to get IRQ %d.\n",
 			hwif->name, old_irq);
-		goto out_disks;
+		goto out;
 	}
 	if (init_irq(hwif)) {
 		printk("%s: probed IRQ %d and default IRQ %d failed.\n",
 			hwif->name, old_irq, hwif->irq);
-		goto out_disks;
+		goto out;
 	}
 	printk("%s: probed IRQ %d failed, using default.\n",
 		hwif->name, hwif->irq);
@@ -1401,12 +1381,6 @@
 	hwif->present = 1;	/* success */
 	return 1;

-out_disks:
-	for (unit = 0; unit < MAX_DRIVES; unit++) {
-		struct gendisk *disk = hwif->drives[unit].disk;
-		hwif->drives[unit].disk = NULL;
-		put_disk(disk);
-	}
 out:
 	unregister_blkdev(hwif->major, hwif->name);
 	return 0;
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:31:46 +01:00
@@ -783,6 +783,7 @@
  */
 typedef struct ide_tape_obj {
 	ide_drive_t	*drive;
+	struct gendisk	*disk;
 	struct kref	kref;

 	/*
@@ -1543,6 +1544,7 @@
 	}
 #endif /* IDETAPE_DEBUG_BUGS */

+	rq->rq_disk = tape->disk;
 	rq->buffer = NULL;
 	rq->special = (void *)stage->bh;
 	tape->active_data_request = rq;
@@ -1795,8 +1797,11 @@
  */
 static void idetape_queue_pc_head (ide_drive_t *drive, idetape_pc_t *pc,struct request *rq)
 {
+	struct ide_tape_obj *tape = drive->driver_data;
+
 	idetape_init_rq(rq, REQ_IDETAPE_PC1);
 	rq->buffer = (char *) pc;
+	rq->rq_disk = tape->disk;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }

@@ -2851,10 +2856,12 @@
  */
 static int __idetape_queue_pc_tail (ide_drive_t *drive, idetape_pc_t *pc)
 {
+	struct ide_tape_obj *tape = drive->driver_data;
 	struct request rq;

 	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
 	rq.buffer = (char *) pc;
+	rq.rq_disk = tape->disk;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }

@@ -3078,6 +3085,7 @@
 #endif /* IDETAPE_DEBUG_BUGS */

 	idetape_init_rq(&rq, cmd);
+	rq.rq_disk = tape->disk;
 	rq.special = (void *)bh;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
@@ -4680,7 +4688,7 @@
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);

-	ide_unregister_region(drive->disk);
+	ide_unregister_region(tape->disk);

 	ide_tape_put(tape);

@@ -4691,7 +4699,7 @@
 {
 	struct ide_tape_obj *tape = to_ide_tape(kref);
 	ide_drive_t *drive = tape->drive;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g = tape->disk;

 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
@@ -4700,7 +4708,7 @@
 	devfs_unregister_tape(g->number);
 	idetape_devs[tape->minor] = NULL;
 	g->private_data = NULL;
-	g->fops = ide_fops;
+	put_disk(g);
 	kfree(tape);
 }

@@ -4815,7 +4823,7 @@
 static int idetape_attach (ide_drive_t *drive)
 {
 	idetape_tape_t *tape;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g;
 	int minor;

 	if (!strstr("ide-tape", drive->driver_req))
@@ -4841,10 +4849,16 @@
 		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 		goto failed;
 	}
+
+	g = alloc_disk(1 << PARTN_BITS);
+	if (!g)
+		goto out_free_tape;
+
+	ide_init_disk(g, drive);
+
 	if (ide_register_subdriver(drive, &idetape_driver)) {
 		printk(KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
-		kfree(tape);
-		goto failed;
+		goto out_put_disk;
 	}

 	memset(tape, 0, sizeof(*tape));
@@ -4852,6 +4866,7 @@
 	kref_init(&tape->kref);

 	tape->drive = drive;
+	tape->disk = g;

 	drive->driver_data = tape;

@@ -4876,6 +4891,10 @@
 	ide_register_region(g);

 	return 0;
+out_put_disk:
+	put_disk(g);
+out_free_tape:
+	kfree(tape);
 failed:
 	return 1;
 }
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:31:46 +01:00
@@ -355,11 +355,6 @@
 	return system_bus_speed;
 }

-static int ide_open (struct inode * inode, struct file * filp)
-{
-	return -ENXIO;
-}
-
 /*
  *	drives_lock protects the list of drives, drivers_lock the
  *	list of drivers.  Currently nobody takes both at once.
@@ -759,11 +754,6 @@
 	 * Remove us from the kernel's knowledge
 	 */
 	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
-	for (i = 0; i < MAX_DRIVES; i++) {
-		struct gendisk *disk = hwif->drives[i].disk;
-		hwif->drives[i].disk = NULL;
-		put_disk(disk);
-	}
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
@@ -2158,13 +2148,6 @@
 }

 EXPORT_SYMBOL(ide_unregister_driver);
-
-struct block_device_operations ide_fops[] = {{
-	.owner		= THIS_MODULE,
-	.open		= ide_open,
-}};
-
-EXPORT_SYMBOL(ide_fops);

 /*
  * Probe module
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-02-04 03:31:46 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-02-04 03:31:46 +01:00
@@ -98,6 +98,7 @@

 typedef struct ide_scsi_obj {
 	ide_drive_t		*drive;
+	struct gendisk		*disk;
 	struct Scsi_Host	*host;

 	idescsi_pc_t *pc;			/* Current packet command */
@@ -323,6 +324,7 @@
 		printk ("ide-scsi: %s: queue cmd = ", drive->name);
 		hexdump(pc->c, 6);
 	}
+	rq->rq_disk = scsi->disk;
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }

@@ -718,7 +720,8 @@
 static int idescsi_cleanup (ide_drive_t *drive)
 {
 	struct Scsi_Host *scsihost = drive->driver_data;
-	struct gendisk *g = drive->disk;
+	struct ide_scsi_obj *scsi = scsihost_to_idescsi(scsihost);
+	struct gendisk *g = scsi->disk;

 	if (ide_unregister_subdriver(drive))
 		return 1;
@@ -729,10 +732,10 @@
 	drive->driver_data = NULL;
 	/* FIXME: add driver's private struct gendisk */
 	g->private_data = NULL;
-	g->fops = ide_fops;
+	put_disk(g);

 	scsi_remove_host(scsihost);
-	ide_scsi_put(scsihost_to_idescsi(scsihost));
+	ide_scsi_put(scsi);

 	return 0;
 }
@@ -914,6 +917,7 @@
 	rq->special = (char *) pc;
 	rq->flags = REQ_SPECIAL;
 	spin_unlock_irq(host->host_lock);
+	rq->rq_disk = scsi->disk;
 	(void) ide_do_drive_cmd (drive, rq, ide_end);
 	spin_lock_irq(host->host_lock);
 	return 0;
@@ -1089,9 +1093,9 @@
 {
 	idescsi_scsi_t *idescsi;
 	struct Scsi_Host *host;
-	struct gendisk *g = drive->disk;
+	struct gendisk *g;
 	static int warned;
-	int err;
+	int err = -ENOMEM;

 	if (!warned && drive->media == ide_cdrom) {
 		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
@@ -1104,6 +1108,12 @@
 	    !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
 		return 1;

+	g = alloc_disk(1 << PARTN_BITS);
+	if (!g)
+		goto out_host_put;
+
+	ide_init_disk(g, drive);
+
 	host->max_id = 1;

 #if IDESCSI_DEBUG_LOG
@@ -1119,6 +1129,7 @@
 	idescsi = scsihost_to_idescsi(host);
 	idescsi->drive = drive;
 	idescsi->host = host;
+	idescsi->disk = g;
 	err = ide_register_subdriver(drive, &idescsi_driver);
 	if (!err) {
 		idescsi_setup (drive, idescsi);
@@ -1135,6 +1146,8 @@
 		ide_unregister_subdriver(drive);
 	}

+	put_disk(g);
+out_host_put:
 	scsi_host_put(host);
 	return err;
 }
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-04 03:31:46 +01:00
+++ b/include/linux/ide.h	2005-02-04 03:31:46 +01:00
@@ -757,7 +757,6 @@
 	struct list_head list;
 	struct device	gendev;
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */
-	struct gendisk *disk;
 } ide_drive_t;

 #define IDE_CHIPSET_PCI_MASK	\
@@ -1342,7 +1341,7 @@
 extern void do_ide_request(request_queue_t *);
 extern void ide_init_subdrivers(void);

-extern struct block_device_operations ide_fops[];
+void ide_init_disk(struct gendisk *, ide_drive_t *);

 extern int ata_attach(ide_drive_t *);

