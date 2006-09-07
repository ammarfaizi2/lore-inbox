Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWIGXhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWIGXhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWIGXhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:37:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422679AbWIGXhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:37:37 -0400
Date: Thu, 7 Sep 2006 16:36:38 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: viro@www.linux.org.uk
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Patch to get rid of first_minor
Message-Id: <20060907163638.86787c5b.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.2; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, here's the patch you were interested in. This does not add any
nasty hooks into check.c.

I'm not sure if I chose the best way to handle bdget_disk. To keep the
old interface was a little unpleasant, so I changed it to only work
with the whole device.

The rest should be uncontrovertial.

This is tested to work with usual devices and FC-5 userland, but
there's no guarantee that I didn't typo it in an obscure driver.
So, I think it would be better to give it a run in -mm or something.

-- Pete

diff -urp -X dontdiff linux-2.6.18-rc6/arch/um/drivers/ubd_kern.c linux-2.6.18-rc6-lem/arch/um/drivers/ubd_kern.c
--- linux-2.6.18-rc6/arch/um/drivers/ubd_kern.c	2006-09-06 21:55:52.000000000 -0700
+++ linux-2.6.18-rc6-lem/arch/um/drivers/ubd_kern.c	2006-09-06 22:16:44.000000000 -0700
@@ -632,8 +632,7 @@ static int ubd_new_disk(int major, u64 s
 	if(disk == NULL)
 		return(-ENOMEM);
 
-	disk->major = major;
-	disk->first_minor = unit << UBD_SHIFT;
+	disk->gd_dev = MKDEV(major, unit << UBD_SHIFT);
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
 	if(major == MAJOR_NR)
diff -urp -X dontdiff linux-2.6.18-rc6/block/genhd.c linux-2.6.18-rc6-lem/block/genhd.c
--- linux-2.6.18-rc6/block/genhd.c	2006-09-06 21:55:54.000000000 -0700
+++ linux-2.6.18-rc6-lem/block/genhd.c	2006-09-07 16:22:06.000000000 -0700
@@ -181,7 +181,7 @@ static int exact_lock(dev_t dev, void *d
 void add_disk(struct gendisk *disk)
 {
 	disk->flags |= GENHD_FL_UP;
-	blk_register_region(MKDEV(disk->major, disk->first_minor),
+	blk_register_region(disk->gd_dev,
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	blk_register_queue(disk);
@@ -193,8 +193,7 @@ EXPORT_SYMBOL(del_gendisk);	/* in partit
 void unlink_gendisk(struct gendisk *disk)
 {
 	blk_unregister_queue(disk);
-	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
-			      disk->minors);
+	blk_unregister_region(disk->gd_dev, disk->minors);
 }
 
 #define to_disk(obj) container_of(obj,struct gendisk,kobj)
@@ -257,17 +256,18 @@ static int show_partition(struct seq_fil
 
 	/* show the full disk and all non-0 size partitions of it */
 	seq_printf(part, "%4d  %4d %10llu %s\n",
-		sgp->major, sgp->first_minor,
+		MAJOR(sgp->gd_dev), MINOR(sgp->gd_dev),
 		(unsigned long long)get_capacity(sgp) >> 1,
 		disk_name(sgp, 0, buf));
 	for (n = 0; n < sgp->minors - 1; n++) {
-		if (!sgp->part[n])
+		struct hd_struct *p;
+		if ((p = sgp->part[n]) == NULL)
 			continue;
-		if (sgp->part[n]->nr_sects == 0)
+		if (p->nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10llu %s\n",
-			sgp->major, n + 1 + sgp->first_minor,
-			(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
+			MAJOR(p->dev), MINOR(p->dev),
+			(unsigned long long)p->nr_sects >> 1 ,
 			disk_name(sgp, n + 1, buf));
 	}
 
@@ -347,8 +347,7 @@ static ssize_t disk_uevent_store(struct 
 }
 static ssize_t disk_dev_read(struct gendisk * disk, char *page)
 {
-	dev_t base = MKDEV(disk->major, disk->first_minor); 
-	return print_dev_t(page, base);
+	return print_dev_t(page, disk->gd_dev);
 }
 static ssize_t disk_range_read(struct gendisk * disk, char *page)
 {
@@ -459,19 +458,19 @@ static int block_uevent(struct kset *kse
 	if (ktype == &ktype_block) {
 		disk = container_of(kobj, struct gendisk, kobj);
 		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "MINOR=%u", disk->first_minor);
+			       &length, "MINOR=%u", MINOR(disk->gd_dev));
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "MAJOR=%u", MAJOR(disk->gd_dev));
 	} else if (ktype == &ktype_part) {
 		disk = container_of(kobj->parent, struct gendisk, kobj);
 		part = container_of(kobj, struct hd_struct, kobj);
 		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "MINOR=%u",
-			       disk->first_minor + part->partno);
+			       &length, "MINOR=%u", MINOR(part->dev));
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "MAJOR=%u", MAJOR(part->dev));
 	} else
 		return 0;
 
-	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
-		       "MAJOR=%u", disk->major);
-
 	/* add physical device, backing this device  */
 	physdev = disk->driverfs_dev;
 	if (physdev) {
@@ -551,7 +550,7 @@ static int diskstats_show(struct seq_fil
 {
 	struct gendisk *gp = v;
 	char buf[BDEVNAME_SIZE];
-	int n = 0;
+	int n;
 
 	/*
 	if (&sgp->kobj.entry == block_subsys.kset.list.next)
@@ -565,7 +564,7 @@ static int diskstats_show(struct seq_fil
 	disk_round_stats(gp);
 	preempt_enable();
 	seq_printf(s, "%4d %4d %s %lu %lu %llu %u %lu %lu %llu %u %u %u %u\n",
-		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
+		MAJOR(gp->gd_dev), MINOR(gp->gd_dev), disk_name(gp, 0, buf),
 		disk_stat_read(gp, ios[0]), disk_stat_read(gp, merges[0]),
 		(unsigned long long)disk_stat_read(gp, sectors[0]),
 		jiffies_to_msecs(disk_stat_read(gp, ticks[0])),
@@ -582,7 +581,7 @@ static int diskstats_show(struct seq_fil
 
 		if (hd && hd->nr_sects)
 			seq_printf(s, "%4d %4d %s %u %u %u %u\n",
-				gp->major, n + gp->first_minor + 1,
+				MAJOR(hd->dev), MINOR(hd->dev),
 				disk_name(gp, n + 1, buf),
 				hd->ios[0], hd->sectors[0],
 				hd->ios[1], hd->sectors[1]);
@@ -698,7 +697,16 @@ EXPORT_SYMBOL(bdev_read_only);
 int invalidate_partition(struct gendisk *disk, int index)
 {
 	int res = 0;
-	struct block_device *bdev = bdget_disk(disk, index);
+	struct block_device *bdev;
+
+	if (index == 0)
+		bdev = bdget_disk(disk);
+	else {
+		if (disk->part[index-1])
+			bdev = bdget(disk->part[index-1]->dev);
+		else
+			bdev = NULL;
+	}
 	if (bdev) {
 		fsync_bdev(bdev);
 		res = __invalidate_device(bdev);
diff -urp -X dontdiff linux-2.6.18-rc6/block/ioctl.c linux-2.6.18-rc6-lem/block/ioctl.c
--- linux-2.6.18-rc6/block/ioctl.c	2006-09-06 21:55:54.000000000 -0700
+++ linux-2.6.18-rc6-lem/block/ioctl.c	2006-09-06 22:16:44.000000000 -0700
@@ -69,7 +69,7 @@ static int blkpg_ioctl(struct block_devi
 				return -ENXIO;
 			if (disk->part[part - 1]->nr_sects == 0)
 				return -ENXIO;
-			bdevp = bdget_disk(disk, part);
+			bdevp = bdget(disk->part[part-1]->dev);
 			if (!bdevp)
 				return -ENOMEM;
 			mutex_lock_nested(&bdevp->bd_mutex, BD_MUTEX_PARTITION);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/acorn/block/fd1772.c linux-2.6.18-rc6-lem/drivers/acorn/block/fd1772.c
--- linux-2.6.18-rc6/drivers/acorn/block/fd1772.c	2005-10-28 19:11:34.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/acorn/block/fd1772.c	2006-09-06 22:16:44.000000000 -0700
@@ -1568,8 +1568,7 @@ int fd1772_init(void)
 
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
-		disks[i]->major = MAJOR_NR;
-		disks[i]->first_minor = 0;
+		disks[i]->gd_dev = MKDEV(MAJOR_NR, 0);
 		disks[i]->fops = &floppy_fops;
 		sprintf(disks[i]->disk_name, "fd%d", i);
 		disks[i]->private_data = &unit[i];
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/acorn/block/mfmhd.c linux-2.6.18-rc6-lem/drivers/acorn/block/mfmhd.c
--- linux-2.6.18-rc6/drivers/acorn/block/mfmhd.c	2006-09-06 21:55:55.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/acorn/block/mfmhd.c	2006-09-06 22:16:44.000000000 -0700
@@ -1269,8 +1269,7 @@ static int mfm_do_init(unsigned char irq
 		struct gendisk *disk = alloc_disk(64);
 		if (!disk)
 			goto Enomem;
-		disk->major = MAJOR_NR;
-		disk->first_minor = i << 6;
+		disk->gd_dev = MKDEV(MAJOR_NR, i << 6);
 		disk->fops = &mfm_fops;
 		sprintf(disk->disk_name, "mfm%c", 'a'+i);
 		mfm_gendisk[i] = disk;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/acsi.c linux-2.6.18-rc6-lem/drivers/block/acsi.c
--- linux-2.6.18-rc6/drivers/block/acsi.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/acsi.c	2006-09-06 22:16:44.000000000 -0700
@@ -1731,8 +1731,7 @@ int acsi_init( void )
 		struct gendisk *disk = acsi_gendisk[i];
 		sprintf(disk->disk_name, "ad%c", 'a'+i);
 		aip = &acsi_info[NDevices];
-		disk->major = ACSI_MAJOR;
-		disk->first_minor = i << 4;
+		disk->gd_dev = MKDEV(ACSI_MAJOR, i << 4);
 		if (acsi_info[i].type != HARDDISK)
 			disk->minors = 1;
 		disk->fops = &acsi_fops;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/amiflop.c linux-2.6.18-rc6-lem/drivers/block/amiflop.c
--- linux-2.6.18-rc6/drivers/block/amiflop.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/amiflop.c	2006-09-06 22:16:44.000000000 -0700
@@ -1681,8 +1681,7 @@ static int __init fd_probe_drives(void)
 			nomem = 1;
 		}
 		printk("fd%d ",drive);
-		disk->major = FLOPPY_MAJOR;
-		disk->first_minor = drive;
+		disk->gd_dev = MKDEV(FLOPPY_MAJOR, drive);
 		disk->fops = &floppy_fops;
 		sprintf(disk->disk_name, "fd%d", drive);
 		disk->private_data = &unit[drive];
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/aoe/aoeblk.c linux-2.6.18-rc6-lem/drivers/block/aoe/aoeblk.c
--- linux-2.6.18-rc6/drivers/block/aoe/aoeblk.c	2006-06-21 14:14:18.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/aoe/aoeblk.c	2006-09-06 22:16:44.000000000 -0700
@@ -224,8 +224,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_lock_irqsave(&d->lock, flags);
 	blk_queue_make_request(&d->blkq, aoeblk_make_request);
-	gd->major = AOE_MAJOR;
-	gd->first_minor = d->sysminor * AOE_PARTITIONS;
+	gd->gd_dev = MKDEV(AOE_MAJOR, d->sysminor * AOE_PARTITIONS);
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
 	gd->capacity = d->ssize;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/aoe/aoecmd.c linux-2.6.18-rc6-lem/drivers/block/aoe/aoecmd.c
--- linux-2.6.18-rc6/drivers/block/aoe/aoecmd.c	2006-06-21 14:14:18.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/aoe/aoecmd.c	2006-09-06 22:16:44.000000000 -0700
@@ -380,7 +380,7 @@ aoecmd_sleepwork(void *vp)
 		u64 ssize;
 
 		ssize = d->gd->capacity;
-		bd = bdget_disk(d->gd, 0);
+		bd = bdget_disk(d->gd);
 
 		if (bd) {
 			mutex_lock(&bd->bd_inode->i_mutex);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/ataflop.c linux-2.6.18-rc6-lem/drivers/block/ataflop.c
--- linux-2.6.18-rc6/drivers/block/ataflop.c	2006-06-21 14:14:18.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/ataflop.c	2006-09-06 22:16:44.000000000 -0700
@@ -1923,8 +1923,7 @@ static int __init atari_floppy_init (voi
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		unit[i].disk->major = FLOPPY_MAJOR;
-		unit[i].disk->first_minor = i;
+		unit[i].disk->gd_dev = MKDEV(FLOPPY_MAJOR, i);
 		sprintf(unit[i].disk->disk_name, "fd%d", i);
 		unit[i].disk->fops = &floppy_fops;
 		unit[i].disk->private_data = &unit[i];
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/cciss.c linux-2.6.18-rc6-lem/drivers/block/cciss.c
--- linux-2.6.18-rc6/drivers/block/cciss.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/cciss.c	2006-09-06 22:16:44.000000000 -0700
@@ -3252,8 +3252,7 @@ static int __devinit cciss_init_one(stru
 
 		q->queuedata = hba[i];
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
-		disk->major = hba[i]->major;
-		disk->first_minor = j << NWD_SHIFT;
+		disk->gd_dev = MKDEV(hba[i]->major, j << NWD_SHIFT);
 		disk->fops = &cciss_fops;
 		disk->queue = q;
 		disk->private_data = drv;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/cpqarray.c linux-2.6.18-rc6-lem/drivers/block/cpqarray.c
--- linux-2.6.18-rc6/drivers/block/cpqarray.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/cpqarray.c	2006-09-06 22:16:45.000000000 -0700
@@ -471,8 +471,7 @@ static int __init cpqarray_register_ctlr
 		struct gendisk *disk = ida_gendisk[i][j];
 		drv_info_t *drv = &hba[i]->drv[j];
 		sprintf(disk->disk_name, "ida/c%dd%d", i, j);
-		disk->major = COMPAQ_SMART2_MAJOR + i;
-		disk->first_minor = j<<NWD_SHIFT;
+		disk->gd_dev = MKDEV(COMPAQ_SMART2_MAJOR + i, j<<NWD_SHIFT);
 		disk->fops = &ida_fops;
 		if (j && !drv->nr_blks)
 			continue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/DAC960.c linux-2.6.18-rc6-lem/drivers/block/DAC960.c
--- linux-2.6.18-rc6/drivers/block/DAC960.c	2006-09-06 21:55:56.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/DAC960.c	2006-09-06 22:16:45.000000000 -0700
@@ -2530,8 +2530,7 @@ static boolean DAC960_RegisterBlockDevic
 	blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
 	disk->queue = RequestQueue;
 	sprintf(disk->disk_name, "rd/c%dd%d", Controller->ControllerNumber, n);
-	disk->major = MajorNumber;
-	disk->first_minor = n << DAC960_MaxPartitionsBits;
+	disk->gd_dev = MKDEV(MajorNumber, n << DAC960_MaxPartitionsBits);
 	disk->fops = &DAC960_BlockDeviceOperations;
    }
   /*
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/floppy.c linux-2.6.18-rc6-lem/drivers/block/floppy.c
--- linux-2.6.18-rc6/drivers/block/floppy.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/floppy.c	2006-09-06 22:16:45.000000000 -0700
@@ -4191,8 +4191,7 @@ static int __init floppy_init(void)
 			goto out_put_disk;
 		}
 
-		disks[dr]->major = FLOPPY_MAJOR;
-		disks[dr]->first_minor = TOMINOR(dr);
+		disks[dr]->gd_dev = MKDEV(FLOPPY_MAJOR, TOMINOR(dr));
 		disks[dr]->fops = &floppy_fops;
 		sprintf(disks[dr]->disk_name, "fd%d", dr);
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/loop.c linux-2.6.18-rc6-lem/drivers/block/loop.c
--- linux-2.6.18-rc6/drivers/block/loop.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/loop.c	2006-09-06 22:16:45.000000000 -0700
@@ -1288,8 +1288,7 @@ static int __init loop_init(void)
 		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
-		disk->major = LOOP_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(LOOP_MAJOR, i);
 		disk->fops = &lo_fops;
 		sprintf(disk->disk_name, "loop%d", i);
 		disk->private_data = lo;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/nbd.c linux-2.6.18-rc6-lem/drivers/block/nbd.c
--- linux-2.6.18-rc6/drivers/block/nbd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/nbd.c	2006-09-06 22:16:45.000000000 -0700
@@ -654,8 +654,7 @@ static int __init nbd_init(void)
 		init_waitqueue_head(&nbd_dev[i].active_wq);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].bytesize = 0x7ffffc00ULL << 10; /* 2TB */
-		disk->major = NBD_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(NBD_MAJOR, i);
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/paride/pcd.c linux-2.6.18-rc6-lem/drivers/block/paride/pcd.c
--- linux-2.6.18-rc6/drivers/block/paride/pcd.c	2005-10-28 19:11:38.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/paride/pcd.c	2006-09-06 22:16:45.000000000 -0700
@@ -299,8 +299,7 @@ static void pcd_init_units(void)
 		cd->info.speed = 0;
 		cd->info.capacity = 1;
 		cd->info.mask = 0;
-		disk->major = major;
-		disk->first_minor = unit;
+		disk->gd_dev = MKDEV(major, unit);
 		strcpy(disk->disk_name, cd->name);	/* umm... */
 		disk->fops = &pcd_bdops;
 	}
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/paride/pd.c linux-2.6.18-rc6-lem/drivers/block/paride/pd.c
--- linux-2.6.18-rc6/drivers/block/paride/pd.c	2006-06-21 14:14:18.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/paride/pd.c	2006-09-06 22:16:45.000000000 -0700
@@ -831,8 +831,7 @@ static void pd_probe_drive(struct pd_uni
 		return;
 	strcpy(p->disk_name, disk->name);
 	p->fops = &pd_fops;
-	p->major = major;
-	p->first_minor = (disk - pd) << PD_BITS;
+	p->gd_dev = MKDEV(major, (disk - pd) << PD_BITS);
 	disk->gd = p;
 	p->private_data = disk;
 	p->queue = pd_queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/paride/pf.c linux-2.6.18-rc6-lem/drivers/block/paride/pf.c
--- linux-2.6.18-rc6/drivers/block/paride/pf.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/paride/pf.c	2006-09-06 22:16:45.000000000 -0700
@@ -287,8 +287,7 @@ static void __init pf_init_units(void)
 		pf->drive = (*drives[unit])[D_SLV];
 		pf->lun = (*drives[unit])[D_LUN];
 		snprintf(pf->name, PF_NAMELEN, "%s%d", name, unit);
-		disk->major = major;
-		disk->first_minor = unit;
+		disk->gd_dev = MKDEV(major, unit);
 		strcpy(disk->disk_name, pf->name);
 		disk->fops = &pf_fops;
 		if (!(*drives[unit])[D_PRT])
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/pktcdvd.c linux-2.6.18-rc6-lem/drivers/block/pktcdvd.c
--- linux-2.6.18-rc6/drivers/block/pktcdvd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/pktcdvd.c	2006-09-06 22:16:45.000000000 -0700
@@ -2474,8 +2474,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 	init_waitqueue_head(&pd->wqueue);
 	pd->bio_queue = RB_ROOT;
 
-	disk->major = pkt_major;
-	disk->first_minor = idx;
+	disk->gd_dev = MKDEV(pkt_major, idx);
 	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "pktcdvd%d", idx);
@@ -2484,7 +2483,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 	if (!disk->queue)
 		goto out_mem2;
 
-	pd->pkt_dev = MKDEV(disk->major, disk->first_minor);
+	pd->pkt_dev = disk->gd_dev;
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
 		goto out_new_dev;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/ps2esdi.c linux-2.6.18-rc6-lem/drivers/block/ps2esdi.c
--- linux-2.6.18-rc6/drivers/block/ps2esdi.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/ps2esdi.c	2006-09-06 22:16:45.000000000 -0700
@@ -417,8 +417,7 @@ static int __init ps2esdi_geninit(void)
 		struct gendisk *disk = alloc_disk(64);
 		if (!disk)
 			goto err_out4;
-		disk->major = PS2ESDI_MAJOR;
-		disk->first_minor = i<<6;
+		disk->gd_dev = MKDEV(PS2ESDI_MAJOR, i<<6);
 		sprintf(disk->disk_name, "ed%c", 'a'+i);
 		disk->fops = &ps2esdi_fops;
 		ps2esdi_gendisk[i] = disk;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/rd.c linux-2.6.18-rc6-lem/drivers/block/rd.c
--- linux-2.6.18-rc6/drivers/block/rd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/rd.c	2006-09-06 22:16:45.000000000 -0700
@@ -450,8 +450,7 @@ static int __init rd_init(void)
 		blk_queue_hardsect_size(rd_queue[i], rd_blocksize);
 
 		/* rd_size is given in kB */
-		disk->major = RAMDISK_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(RAMDISK_MAJOR, i);
 		disk->fops = &rd_bd_op;
 		disk->queue = rd_queue[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/swim3.c linux-2.6.18-rc6-lem/drivers/block/swim3.c
--- linux-2.6.18-rc6/drivers/block/swim3.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/swim3.c	2006-09-06 22:16:45.000000000 -0700
@@ -1141,8 +1141,7 @@ static int __devinit swim3_attach(struct
 	if (disk == NULL)
 		return 0;
 
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = i;
+	disk->gd_dev = MKDEV(FLOPPY_MAJOR, i);
 	disk->fops = &floppy_fops;
 	disk->private_data = &floppy_states[i];
 	disk->queue = swim3_queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/swim_iop.c linux-2.6.18-rc6-lem/drivers/block/swim_iop.c
--- linux-2.6.18-rc6/drivers/block/swim_iop.c	2005-10-28 19:11:38.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/swim_iop.c	2006-09-06 22:16:45.000000000 -0700
@@ -193,8 +193,7 @@ int swimiop_init(void)
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			continue;
-		disk->major = FLOPPY_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(FLOPPY_MAJOR, i);
 		disk->fops = &floppy_fops;
 		sprintf(disk->disk_name, "fd%d", i);
 		disk->private_data = &floppy_states[i];
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/sx8.c linux-2.6.18-rc6-lem/drivers/block/sx8.c
--- linux-2.6.18-rc6/drivers/block/sx8.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/sx8.c	2006-09-06 22:16:45.000000000 -0700
@@ -1509,8 +1509,7 @@ static int carm_init_disks(struct carm_h
 		port->disk = disk;
 		sprintf(disk->disk_name, DRV_NAME "/%u",
 			(unsigned int) (host->id * CARM_MAX_PORTS) + i);
-		disk->major = host->major;
-		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
+		disk->gd_dev = MKDEV(host->major, i * CARM_MINORS_PER_MAJOR);
 		disk->fops = &carm_bd_ops;
 		disk->private_data = port;
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/ub.c linux-2.6.18-rc6-lem/drivers/block/ub.c
--- linux-2.6.18-rc6/drivers/block/ub.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/ub.c	2006-09-06 23:00:50.000000000 -0700
@@ -2289,8 +2305,7 @@ static int ub_probe_lun(struct ub_dev *s
 		goto err_diskalloc;
 
 	sprintf(disk->disk_name, DRV_NAME "%c", lun->id + 'a');
-	disk->major = UB_MAJOR;
-	disk->first_minor = lun->id * UB_PARTS_PER_LUN;
+	disk->gd_dev = MKDEV(UB_MAJOR, lun->id * UB_PARTS_PER_LUN);
 	disk->fops = &ub_bd_fops;
 	disk->private_data = lun;
 	disk->driverfs_dev = &sc->intf->dev;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/umem.c linux-2.6.18-rc6-lem/drivers/block/umem.c
--- linux-2.6.18-rc6/drivers/block/umem.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/umem.c	2006-09-06 22:16:45.000000000 -0700
@@ -1192,8 +1192,7 @@ static int __init mm_init(void)
 		struct gendisk *disk = mm_gendisk[i];
 		sprintf(disk->disk_name, "umem%c", 'a'+i);
 		spin_lock_init(&cards[i].lock);
-		disk->major = major_nr;
-		disk->first_minor  = i << MM_SHIFT;
+		disk->gd_dev = MKDEV(major_nr, i << MM_SHIFT);
 		disk->fops = &mm_fops;
 		disk->private_data = &cards[i];
 		disk->queue = cards[i].queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/viodasd.c linux-2.6.18-rc6-lem/drivers/block/viodasd.c
--- linux-2.6.18-rc6/drivers/block/viodasd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/viodasd.c	2006-09-06 22:16:45.000000000 -0700
@@ -513,8 +513,7 @@ retry:
 	blk_queue_max_hw_segments(q, VIOMAXBLOCKDMA);
 	blk_queue_max_phys_segments(q, VIOMAXBLOCKDMA);
 	blk_queue_max_sectors(q, VIODASD_MAXSECTORS);
-	g->major = VIODASD_MAJOR;
-	g->first_minor = dev_no << PARTITION_SHIFT;
+	g->gd_dev = MKDEV(VIODASD_MAJOR, dev_no << PARTITION_SHIFT);
 	if (dev_no >= 26)
 		snprintf(g->disk_name, sizeof(g->disk_name),
 				VIOD_GENHD_NAME "%c%c",
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/xd.c linux-2.6.18-rc6-lem/drivers/block/xd.c
--- linux-2.6.18-rc6/drivers/block/xd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/xd.c	2006-09-06 22:16:45.000000000 -0700
@@ -212,8 +212,7 @@ static int __init xd_init(void)
 		if (!disk)
 			goto Enomem;
 		p->unit = i;
-		disk->major = XT_DISK_MAJOR;
-		disk->first_minor = i<<6;
+		disk->gd_dev = MKDEV(XT_DISK_MAJOR, i<<6);
 		sprintf(disk->disk_name, "xd%c", i+'a');
 		disk->fops = &xd_fops;
 		disk->private_data = p;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/block/z2ram.c linux-2.6.18-rc6-lem/drivers/block/z2ram.c
--- linux-2.6.18-rc6/drivers/block/z2ram.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/block/z2ram.c	2006-09-06 22:16:45.000000000 -0700
@@ -350,8 +350,7 @@ z2_init(void)
     if (!z2_queue)
 	goto out_queue;
 
-    z2ram_gendisk->major = Z2RAM_MAJOR;
-    z2ram_gendisk->first_minor = 0;
+    z2ram_gendisk->gd_dev = MKDEV(Z2RAM_MAJOR, 0);
     z2ram_gendisk->fops = &z2_fops;
     sprintf(z2ram_gendisk->disk_name, "z2ram");
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/aztcd.c linux-2.6.18-rc6-lem/drivers/cdrom/aztcd.c
--- linux-2.6.18-rc6/drivers/cdrom/aztcd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/aztcd.c	2006-09-06 22:16:45.000000000 -0700
@@ -1914,8 +1914,7 @@ static int __init aztcd_init(void)
 	}
 
 	blk_queue_hardsect_size(azt_queue, 2048);
-	azt_disk->major = MAJOR_NR;
-	azt_disk->first_minor = 0;
+	azt_disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	azt_disk->fops = &azt_fops;
 	sprintf(azt_disk->disk_name, "aztcd");
 	azt_disk->queue = azt_queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/cdu31a.c linux-2.6.18-rc6-lem/drivers/cdrom/cdu31a.c
--- linux-2.6.18-rc6/drivers/cdrom/cdu31a.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/cdu31a.c	2006-09-06 22:16:45.000000000 -0700
@@ -3122,8 +3122,7 @@ int __init cdu31a_init(void)
 	disk = alloc_disk(1);
 	if (!disk)
 		goto errout1;
-	disk->major = MAJOR_NR;
-	disk->first_minor = 0;
+	disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	sprintf(disk->disk_name, "cdu31a");
 	disk->fops = &scd_bdops;
 	disk->flags = GENHD_FL_CD;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/cm206.c linux-2.6.18-rc6-lem/drivers/cdrom/cm206.c
--- linux-2.6.18-rc6/drivers/cdrom/cm206.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/cm206.c	2006-09-06 22:16:45.000000000 -0700
@@ -1470,8 +1470,7 @@ int __init cm206_init(void)
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out_disk;
-	disk->major = MAJOR_NR;
-	disk->first_minor = 0;
+	disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	sprintf(disk->disk_name, "cm206cd");
 	disk->fops = &cm206_bdops;
 	disk->flags = GENHD_FL_CD;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/gscd.c linux-2.6.18-rc6-lem/drivers/cdrom/gscd.c
--- linux-2.6.18-rc6/drivers/cdrom/gscd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/gscd.c	2006-09-06 22:16:45.000000000 -0700
@@ -951,8 +951,7 @@ static int __init gscd_init(void)
 	gscd_disk = alloc_disk(1);
 	if (!gscd_disk)
 		goto err_out1;
-	gscd_disk->major = MAJOR_NR;
-	gscd_disk->first_minor = 0;
+	gscd_disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	gscd_disk->fops = &gscd_fops;
 	sprintf(gscd_disk->disk_name, "gscd");
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/mcdx.c linux-2.6.18-rc6-lem/drivers/cdrom/mcdx.c
--- linux-2.6.18-rc6/drivers/cdrom/mcdx.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/mcdx.c	2006-09-06 22:16:45.000000000 -0700
@@ -1226,8 +1226,7 @@ static int __init mcdx_init_drive(int dr
 	stuffp->info.capacity = 1;
 	stuffp->info.handle = stuffp;
 	sprintf(stuffp->info.name, "mcdx%d", drive);
-	disk->major = MAJOR_NR;
-	disk->first_minor = drive;
+	disk->gd_dev = MKDEV(MAJOR_NR, drive);
 	strcpy(disk->disk_name, stuffp->info.name);
 	disk->fops = &mcdx_bdops;
 	disk->flags = GENHD_FL_CD;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/optcd.c linux-2.6.18-rc6-lem/drivers/cdrom/optcd.c
--- linux-2.6.18-rc6/drivers/cdrom/optcd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/optcd.c	2006-09-06 22:16:45.000000000 -0700
@@ -2029,8 +2029,7 @@ static int __init optcd_init(void)
 		printk(KERN_ERR "optcd: can't allocate disk\n");
 		return -ENOMEM;
 	}
-	optcd_disk->major = MAJOR_NR;
-	optcd_disk->first_minor = 0;
+	optcd_disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	optcd_disk->fops = &opt_fops;
 	sprintf(optcd_disk->disk_name, "optcd");
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/sbpcd.c linux-2.6.18-rc6-lem/drivers/cdrom/sbpcd.c
--- linux-2.6.18-rc6/drivers/cdrom/sbpcd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/sbpcd.c	2006-09-06 22:16:45.000000000 -0700
@@ -5862,8 +5862,7 @@ int __init sbpcd_init(void)
 		sbpcd_infop->handle = p;
 		p->sbpcd_infop = sbpcd_infop;
 		disk = alloc_disk(1);
-		disk->major = MAJOR_NR;
-		disk->first_minor = j;
+		disk->gd_dev = MKDEV(MAJOR_NR, j);
 		disk->fops = &sbpcd_bdops;
 		strcpy(disk->disk_name, sbpcd_infop->name);
 		disk->flags = GENHD_FL_CD;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/sjcd.c linux-2.6.18-rc6-lem/drivers/cdrom/sjcd.c
--- linux-2.6.18-rc6/drivers/cdrom/sjcd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/sjcd.c	2006-09-06 22:16:45.000000000 -0700
@@ -1691,8 +1691,7 @@ static int __init sjcd_init(void)
 		printk(KERN_ERR "SJCD: can't allocate disk");
 		goto out1;
 	}
-	sjcd_disk->major = MAJOR_NR,
-	sjcd_disk->first_minor = 0,
+	sjcd_disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	sjcd_disk->fops = &sjcd_fops,
 	sprintf(sjcd_disk->disk_name, "sjcd");
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/sonycd535.c linux-2.6.18-rc6-lem/drivers/cdrom/sonycd535.c
--- linux-2.6.18-rc6/drivers/cdrom/sonycd535.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/sonycd535.c	2006-09-06 22:16:45.000000000 -0700
@@ -1585,8 +1585,7 @@ static int __init sony535_init(void)
 	cdu_disk = alloc_disk(1);
 	if (!cdu_disk)
 		goto out6;
-	cdu_disk->major = MAJOR_NR;
-	cdu_disk->first_minor = 0;
+	cdu_disk->gd_dev = MKDEV(MAJOR_NR, 0);
 	cdu_disk->fops = &cdu_fops;
 	sprintf(cdu_disk->disk_name, "cdu");
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/cdrom/viocd.c linux-2.6.18-rc6-lem/drivers/cdrom/viocd.c
--- linux-2.6.18-rc6/drivers/cdrom/viocd.c	2006-09-06 21:55:57.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/cdrom/viocd.c	2006-09-06 22:16:45.000000000 -0700
@@ -683,8 +683,7 @@ static int viocd_probe(struct vio_dev *v
 				c->name);
 		goto out_cleanup_queue;
 	}
-	gendisk->major = VIOCD_MAJOR;
-	gendisk->first_minor = deviceno;
+	gendisk->gd_dev = MKDEV(VIOCD_MAJOR, deviceno);
 	strncpy(gendisk->disk_name, c->name,
 			sizeof(gendisk->disk_name));
 	blk_queue_max_hw_segments(q, 1);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/char/random.c linux-2.6.18-rc6-lem/drivers/char/random.c
--- linux-2.6.18-rc6/drivers/char/random.c	2006-09-06 21:55:59.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/char/random.c	2006-09-06 22:16:45.000000000 -0700
@@ -660,10 +660,9 @@ void add_disk_randomness(struct gendisk 
 	if (!disk || !disk->random)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
-	DEBUG_ENT("disk event %d:%d\n", disk->major, disk->first_minor);
+	DEBUG_ENT("disk event %d:%d\n",MAJOR(disk->gd_dev),MINOR(disk->gd_dev));
 
-	add_timer_randomness(disk->random,
-			     0x100 + MKDEV(disk->major, disk->first_minor));
+	add_timer_randomness(disk->random, 0x100 + disk->gd_dev);
 }
 
 EXPORT_SYMBOL(add_disk_randomness);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/ide/ide-probe.c linux-2.6.18-rc6-lem/drivers/ide/ide-probe.c
--- linux-2.6.18-rc6/drivers/ide/ide-probe.c	2006-09-06 21:56:02.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/ide/ide-probe.c	2006-09-06 22:16:45.000000000 -0700
@@ -1222,7 +1222,7 @@ static int exact_lock(dev_t dev, void *d
 
 void ide_register_region(struct gendisk *disk)
 {
-	blk_register_region(MKDEV(disk->major, disk->first_minor),
+	blk_register_region(disk->gd_dev,
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 }
 
@@ -1230,8 +1230,7 @@ EXPORT_SYMBOL_GPL(ide_register_region);
 
 void ide_unregister_region(struct gendisk *disk)
 {
-	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
-			      disk->minors);
+	blk_unregister_region(disk->gd_dev, disk->minors);
 }
 
 EXPORT_SYMBOL_GPL(ide_unregister_region);
@@ -1241,8 +1240,7 @@ void ide_init_disk(struct gendisk *disk,
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned int unit = (drive->select.all >> 4) & 1;
 
-	disk->major = hwif->major;
-	disk->first_minor = unit << PARTN_BITS;
+	disk->gd_dev = MKDEV(hwif->major, unit << PARTN_BITS);
 	sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit);
 	disk->queue = drive->queue;
 }
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/ide/legacy/hd.c linux-2.6.18-rc6-lem/drivers/ide/legacy/hd.c
--- linux-2.6.18-rc6/drivers/ide/legacy/hd.c	2006-09-06 21:56:02.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/ide/legacy/hd.c	2006-09-06 22:16:45.000000000 -0700
@@ -792,8 +792,7 @@ static int __init hd_init(void)
 		struct hd_i_struct *p = &hd_info[drive];
 		if (!disk)
 			goto Enomem;
-		disk->major = MAJOR_NR;
-		disk->first_minor = drive << 6;
+		disk->gd_dev = MKDEV(MAJOR_NR, drive << 6);
 		disk->fops = &hd_fops;
 		sprintf(disk->disk_name, "hd%c", 'a'+drive);
 		disk->private_data = p;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/md/dm.c linux-2.6.18-rc6-lem/drivers/md/dm.c
--- linux-2.6.18-rc6/drivers/md/dm.c	2006-09-06 21:56:08.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/md/dm.c	2006-09-06 22:16:45.000000000 -0700
@@ -929,8 +929,7 @@ static struct mapped_device *alloc_dev(i
 	init_waitqueue_head(&md->wait);
 	init_waitqueue_head(&md->eventq);
 
-	md->disk->major = _major;
-	md->disk->first_minor = minor;
+	md->disk->gd_dev = MKDEV(_major, minor);
 	md->disk->fops = &dm_blk_dops;
 	md->disk->queue = md->queue;
 	md->disk->private_data = md;
@@ -963,7 +962,7 @@ static struct mapped_device *alloc_dev(i
 
 static void free_dev(struct mapped_device *md)
 {
-	int minor = md->disk->first_minor;
+	int minor = MINOR(md->disk->gd_dev);
 
 	if (md->suspended_bdev) {
 		thaw_bdev(md->suspended_bdev, NULL);
@@ -1073,7 +1072,7 @@ static struct mapped_device *dm_find_md(
 
 	md = idr_find(&_minor_idr, minor);
 	if (md && (md == MINOR_ALLOCED ||
-		   (dm_disk(md)->first_minor != minor) ||
+		   MINOR(dm_disk(md)->gd_dev) != minor ||
 		   test_bit(DMF_FREEING, &md->flags))) {
 		md = NULL;
 		goto out;
@@ -1124,7 +1123,7 @@ void dm_put(struct mapped_device *md)
 
 	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		map = dm_get_table(md);
-		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
+		idr_replace(&_minor_idr, MINOR_ALLOCED, MINOR(dm_disk(md)->gd_dev));
 		set_bit(DMF_FREEING, &md->flags);
 		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
@@ -1232,7 +1231,7 @@ int dm_suspend(struct mapped_device *md,
 	/* This does not get reverted if there's an error later. */
 	dm_table_presuspend_targets(map);
 
-	md->suspended_bdev = bdget_disk(md->disk, 0);
+	md->suspended_bdev = bdget_disk(md->disk);
 	if (!md->suspended_bdev) {
 		DMWARN("bdget failed in dm_suspend");
 		r = -ENOMEM;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/md/dm-ioctl.c linux-2.6.18-rc6-lem/drivers/md/dm-ioctl.c
--- linux-2.6.18-rc6/drivers/md/dm-ioctl.c	2006-09-06 21:56:08.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/md/dm-ioctl.c	2006-09-06 22:16:45.000000000 -0700
@@ -423,7 +423,7 @@ static int list_devices(struct dm_ioctl 
 				old_nl->next = (uint32_t) ((void *) nl -
 							   (void *) old_nl);
 			disk = dm_disk(hc->md);
-			nl->dev = huge_encode_dev(MKDEV(disk->major, disk->first_minor));
+			nl->dev = huge_encode_dev(disk->gd_dev);
 			nl->next = 0;
 			strcpy(nl->name, hc->name);
 
@@ -536,7 +536,7 @@ static int __dev_status(struct mapped_de
 	if (dm_suspended(md))
 		param->flags |= DM_SUSPEND_FLAG;
 
-	param->dev = huge_encode_dev(MKDEV(disk->major, disk->first_minor));
+	param->dev = huge_encode_dev(disk->gd_dev);
 
 	/*
 	 * Yes, this will be out of date by the time it gets back
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/md/md.c linux-2.6.18-rc6-lem/drivers/md/md.c
--- linux-2.6.18-rc6/drivers/md/md.c	2006-09-06 21:56:08.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/md/md.c	2006-09-06 22:16:45.000000000 -0700
@@ -2926,8 +2926,7 @@ static struct kobject *md_probe(dev_t de
 		mddev_put(mddev);
 		return NULL;
 	}
-	disk->major = MAJOR(dev);
-	disk->first_minor = unit << shift;
+	disk->gd_dev = dev;
 	if (partitioned)
 		sprintf(disk->disk_name, "md_d%d", unit);
 	else
@@ -4073,7 +4072,7 @@ static int update_size(mddev_t *mddev, u
 	if (!rv) {
 		struct block_device *bdev;
 
-		bdev = bdget_disk(mddev->gendisk, 0);
+		bdev = bdget_disk(mddev->gendisk);
 		if (bdev) {
 			mutex_lock(&bdev->bd_inode->i_mutex);
 			i_size_write(bdev->bd_inode, (loff_t)mddev->array_size << 10);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/md/raid5.c linux-2.6.18-rc6-lem/drivers/md/raid5.c
--- linux-2.6.18-rc6/drivers/md/raid5.c	2006-09-06 21:56:08.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/md/raid5.c	2006-09-06 22:16:45.000000000 -0700
@@ -3636,7 +3636,7 @@ static void end_reshape(raid5_conf_t *co
 		set_capacity(conf->mddev->gendisk, conf->mddev->array_size << 1);
 		conf->mddev->changed = 1;
 
-		bdev = bdget_disk(conf->mddev->gendisk, 0);
+		bdev = bdget_disk(conf->mddev->gendisk);
 		if (bdev) {
 			mutex_lock(&bdev->bd_inode->i_mutex);
 			i_size_write(bdev->bd_inode, conf->mddev->array_size << 10);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/message/i2o/i2o_block.c linux-2.6.18-rc6-lem/drivers/message/i2o/i2o_block.c
--- linux-2.6.18-rc6/drivers/message/i2o/i2o_block.c	2006-09-06 21:56:11.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/message/i2o/i2o_block.c	2006-09-06 22:16:45.000000000 -0700
@@ -1010,7 +1010,6 @@ static struct i2o_block_device *i2o_bloc
 	blk_queue_prep_rq(queue, i2o_block_prep_req_fn);
 	blk_queue_issue_flush_fn(queue, i2o_block_issue_flush);
 
-	gd->major = I2O_MAJOR;
 	gd->queue = queue;
 	gd->fops = &i2o_block_fops;
 	gd->private_data = dev;
@@ -1087,7 +1086,7 @@ static int i2o_block_probe(struct device
 
 	/* setup gendisk */
 	gd = i2o_blk_dev->gd;
-	gd->first_minor = unit << 4;
+	gd->gd_dev = MKDEV(I2O_MAJOR, unit << 4);
 	sprintf(gd->disk_name, "i2o/hd%c", 'a' + unit);
 	gd->driverfs_dev = &i2o_dev->device;
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/mmc/mmc_block.c linux-2.6.18-rc6-lem/drivers/mmc/mmc_block.c
--- linux-2.6.18-rc6/drivers/mmc/mmc_block.c	2006-09-06 21:56:12.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/mmc/mmc_block.c	2006-09-06 22:16:45.000000000 -0700
@@ -388,8 +388,7 @@ static struct mmc_blk_data *mmc_blk_allo
 	md->queue.issue_fn = mmc_blk_issue_rq;
 	md->queue.data = md;
 
-	md->disk->major	= major;
-	md->disk->first_minor = devidx << MMC_SHIFT;
+	md->disk->gd_dev = MKDEV(major, devidx << MMC_SHIFT);
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
@@ -496,7 +495,7 @@ static void mmc_blk_remove(struct mmc_ca
 		 */
 		md->disk->queue = NULL;
 
-		devidx = md->disk->first_minor >> MMC_SHIFT;
+		devidx = MINOR(md->disk->gd_dev) >> MMC_SHIFT;
 		__clear_bit(devidx, dev_use);
 
 		mmc_blk_put(md);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/mtd/mtd_blkdevs.c linux-2.6.18-rc6-lem/drivers/mtd/mtd_blkdevs.c
--- linux-2.6.18-rc6/drivers/mtd/mtd_blkdevs.c	2006-06-21 14:14:32.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/mtd/mtd_blkdevs.c	2006-09-06 22:16:45.000000000 -0700
@@ -278,8 +278,7 @@ int add_mtd_blktrans_dev(struct mtd_blkt
 		list_del(&new->list);
 		return -ENOMEM;
 	}
-	gd->major = tr->major;
-	gd->first_minor = (new->devnum) << tr->part_bits;
+	gd->gd_dev = MKDEV(tr->major, new->devnum << tr->part_bits);
 	gd->fops = &mtd_blktrans_ops;
 
 	if (tr->part_bits)
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/block/dasd_genhd.c linux-2.6.18-rc6-lem/drivers/s390/block/dasd_genhd.c
--- linux-2.6.18-rc6/drivers/s390/block/dasd_genhd.c	2006-09-06 21:56:23.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/block/dasd_genhd.c	2006-09-06 22:16:45.000000000 -0700
@@ -40,8 +40,7 @@ dasd_gendisk_alloc(struct dasd_device *d
 		return -ENOMEM;
 
 	/* Initialize gendisk structure. */
-	gdp->major = DASD_MAJOR;
-	gdp->first_minor = device->devindex << DASD_PARTN_BITS;
+	gdp->gd_dev = MKDEV(DASD_MAJOR, device->devindex << DASD_PARTN_BITS);
 	gdp->fops = &dasd_device_operations;
 	gdp->driverfs_dev = &device->cdev->dev;
 
@@ -99,7 +98,7 @@ dasd_scan_partitions(struct dasd_device 
 {
 	struct block_device *bdev;
 
-	bdev = bdget_disk(device->gdp, 0);
+	bdev = bdget_disk(device->gdp);
 	if (!bdev || blkdev_get(bdev, FMODE_READ, 1) < 0)
 		return -ENODEV;
 	/*
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/block/dasd_ioctl.c linux-2.6.18-rc6-lem/drivers/s390/block/dasd_ioctl.c
--- linux-2.6.18-rc6/drivers/s390/block/dasd_ioctl.c	2006-09-06 21:56:23.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/block/dasd_ioctl.c	2006-09-06 22:16:45.000000000 -0700
@@ -156,7 +156,7 @@ dasd_format(struct dasd_device * device,
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		struct block_device *bdev = bdget_disk(device->gdp, 0);
+		struct block_device *bdev = bdget_disk(device->gdp);
 		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
 		bdput(bdev);
 	}
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/block/dasd_proc.c linux-2.6.18-rc6-lem/drivers/s390/block/dasd_proc.c
--- linux-2.6.18-rc6/drivers/s390/block/dasd_proc.c	2006-09-06 21:56:23.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/block/dasd_proc.c	2006-09-06 22:16:45.000000000 -0700
@@ -67,7 +67,8 @@ dasd_devices_show(struct seq_file *m, vo
 	/* Print kdev. */
 	if (device->gdp)
 		seq_printf(m, " at (%3d:%6d)",
-			   device->gdp->major, device->gdp->first_minor);
+			   MAJOR(device->gdp->gd_dev),
+			   MINOR(device->gdp->gd_dev));
 	else
 		seq_printf(m, "  at (???:??????)");
 	/* Print device name. */
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/block/dcssblk.c linux-2.6.18-rc6-lem/drivers/s390/block/dcssblk.c
--- linux-2.6.18-rc6/drivers/s390/block/dcssblk.c	2006-06-21 14:14:43.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/block/dcssblk.c	2006-09-06 22:16:45.000000000 -0700
@@ -114,13 +114,13 @@ dcssblk_assign_free_minor(struct dcssblk
 		found = 0;
 		// test if minor available
 		list_for_each_entry(entry, &dcssblk_devices, lh)
-			if (minor == entry->gd->first_minor)
+			if (minor == MINOR(entry->gd->gd_dev))
 				found++;
 		if (!found) break; // got unused minor
 	}
 	if (found)
 		return -EBUSY;
-	dev_info->gd->first_minor = minor;
+	dev_info->gd->gd_dev = MKDEV(dcssblk_major, minor);
 	return 0;
 }
 
@@ -404,7 +404,6 @@ dcssblk_add_store(struct device *dev, st
 		rc = -ENOMEM;
 		goto free_dev_info;
 	}
-	dev_info->gd->major = dcssblk_major;
 	dev_info->gd->fops = &dcssblk_devops;
 	dev_info->dcssblk_queue = blk_alloc_queue(GFP_KERNEL);
 	dev_info->gd->queue = dev_info->dcssblk_queue;
@@ -442,7 +441,7 @@ dcssblk_add_store(struct device *dev, st
 		goto unload_seg;
 	}
 	sprintf(dev_info->gd->disk_name, "dcssblk%d",
-		dev_info->gd->first_minor);
+		MINOR(dev_info->gd->gd_dev));
 	list_add_tail(&dev_info->lh, &dcssblk_devices);
 
 	if (!try_module_get(THIS_MODULE)) {
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/block/xpram.c linux-2.6.18-rc6-lem/drivers/s390/block/xpram.c
--- linux-2.6.18-rc6/drivers/s390/block/xpram.c	2006-09-06 21:56:23.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/block/xpram.c	2006-09-06 22:16:45.000000000 -0700
@@ -411,8 +411,7 @@ static int __init xpram_setup_blkdev(voi
 		xpram_devices[i].size = xpram_sizes[i] / 4;
 		xpram_devices[i].offset = offset;
 		offset += xpram_devices[i].size;
-		disk->major = XPRAM_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(XPRAM_MAJOR, i);
 		disk->fops = &xpram_devops;
 		disk->private_data = &xpram_devices[i];
 		disk->queue = xpram_queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/s390/char/tape_block.c linux-2.6.18-rc6-lem/drivers/s390/char/tape_block.c
--- linux-2.6.18-rc6/drivers/s390/char/tape_block.c	2006-09-06 21:56:23.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/s390/char/tape_block.c	2006-09-06 22:16:45.000000000 -0700
@@ -240,8 +240,7 @@ tapeblock_setup_device(struct tape_devic
 		goto cleanup_queue;
 	}
 
-	disk->major = tapeblock_major;
-	disk->first_minor = device->first_minor;
+	disk->gd_dev = MKDEV(tapeblock_major, device->first_minor);
 	disk->fops = &tapeblock_fops;
 	disk->private_data = tape_get_device_reference(device);
 	disk->queue = blkdat->request_queue;
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/sbus/char/jsflash.c linux-2.6.18-rc6-lem/drivers/sbus/char/jsflash.c
--- linux-2.6.18-rc6/drivers/sbus/char/jsflash.c	2006-01-03 20:03:29.000000000 -0800
+++ linux-2.6.18-rc6-lem/drivers/sbus/char/jsflash.c	2006-09-06 22:16:45.000000000 -0700
@@ -575,8 +575,7 @@ static int jsfd_init(void)
 		jsf = &jsf0;	/* actually, &jsfv[i >> JSF_PART_BITS] */
 		jdp = &jsf->dv[i&JSF_PART_MASK];
 
-		disk->major = JSFD_MAJOR;
-		disk->first_minor = i;
+		disk->gd_dev = MKDEV(JSFD_MAJOR, i);
 		sprintf(disk->disk_name, "jsfd%d", i);
 		disk->fops = &jsfd_fops;
 		set_capacity(disk, jdp->dsize >> 9);
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/scsi/sd.c linux-2.6.18-rc6-lem/drivers/scsi/sd.c
--- linux-2.6.18-rc6/drivers/scsi/sd.c	2006-09-06 21:56:29.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/scsi/sd.c	2006-09-06 22:16:45.000000000 -0700
@@ -1616,6 +1616,7 @@ static int sd_probe(struct device *dev)
 	struct scsi_device *sdp = to_scsi_device(dev);
 	struct scsi_disk *sdkp;
 	struct gendisk *gd;
+	unsigned int major;
 	u32 index;
 	int error;
 
@@ -1670,8 +1671,8 @@ static int sd_probe(struct device *dev)
 			sdp->timeout = SD_MOD_TIMEOUT;
 	}
 
-	gd->major = sd_major((index & 0xf0) >> 4);
-	gd->first_minor = ((index & 0xf) << 4) | (index & 0xfff00);
+	major = sd_major((index & 0xf0) >> 4);
+	gd->gd_dev = MKDEV(major, ((index & 0xf) << 4) | (index & 0xfff00));
 	gd->minors = 16;
 	gd->fops = &sd_fops;
 
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/scsi/sg.c linux-2.6.18-rc6-lem/drivers/scsi/sg.c
--- linux-2.6.18-rc6/drivers/scsi/sg.c	2006-09-06 21:56:29.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/scsi/sg.c	2006-09-06 22:16:45.000000000 -0700
@@ -1362,7 +1362,7 @@ static int sg_alloc(struct gendisk *disk
 
 	SCSI_LOG_TIMEOUT(3, printk("sg_alloc: dev=%d \n", k));
 	sprintf(disk->disk_name, "sg%d", k);
-	disk->first_minor = k;
+	disk->gd_dev = MKDEV(SCSI_GENERIC_MAJOR, k);
 	sdp->disk = disk;
 	sdp->device = scsidp;
 	init_waitqueue_head(&sdp->o_excl_wait);
@@ -1408,7 +1408,6 @@ sg_add(struct class_device *cl_dev, stru
 		printk(KERN_WARNING "alloc_disk failed\n");
 		return -ENOMEM;
 	}
-	disk->major = SCSI_GENERIC_MAJOR;
 
 	error = -ENOMEM;
 	cdev = cdev_alloc();
diff -urp -X dontdiff linux-2.6.18-rc6/drivers/scsi/sr.c linux-2.6.18-rc6-lem/drivers/scsi/sr.c
--- linux-2.6.18-rc6/drivers/scsi/sr.c	2006-09-06 21:56:29.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/scsi/sr.c	2006-09-06 22:16:45.000000000 -0700
@@ -563,8 +563,7 @@ static int sr_probe(struct device *dev)
 	__set_bit(minor, sr_index_bits);
 	spin_unlock(&sr_index_lock);
 
-	disk->major = SCSI_CDROM_MAJOR;
-	disk->first_minor = minor;
+	disk->gd_dev = MKDEV(SCSI_CDROM_MAJOR, minor);
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD;
@@ -852,7 +851,7 @@ static void sr_kref_release(struct kref 
 	struct gendisk *disk = cd->disk;
 
 	spin_lock(&sr_index_lock);
-	clear_bit(disk->first_minor, sr_index_bits);
+	clear_bit(MINOR(disk->gd_dev), sr_index_bits);
 	spin_unlock(&sr_index_lock);
 
 	unregister_cdrom(&cd->cdi);
diff -urp -X dontdiff linux-2.6.18-rc6/fs/block_dev.c linux-2.6.18-rc6-lem/fs/block_dev.c
--- linux-2.6.18-rc6/fs/block_dev.c	2006-09-06 21:56:37.000000000 -0700
+++ linux-2.6.18-rc6-lem/fs/block_dev.c	2006-09-06 22:16:46.000000000 -0700
@@ -984,7 +984,7 @@ do_open(struct block_device *bdev, struc
 		} else {
 			struct hd_struct *p;
 			struct block_device *whole;
-			whole = bdget_disk(disk, 0);
+			whole = bdget_disk(disk);
 			ret = -ENOMEM;
 			if (!whole)
 				goto out_first;
diff -urp -X dontdiff linux-2.6.18-rc6/fs/partitions/check.c linux-2.6.18-rc6-lem/fs/partitions/check.c
--- linux-2.6.18-rc6/fs/partitions/check.c	2006-09-06 21:56:42.000000000 -0700
+++ linux-2.6.18-rc6-lem/fs/partitions/check.c	2006-09-06 22:16:46.000000000 -0700
@@ -129,7 +129,7 @@ char *disk_name(struct gendisk *hd, int 
 
 const char *bdevname(struct block_device *bdev, char *buf)
 {
-	int part = MINOR(bdev->bd_dev) - bdev->bd_disk->first_minor;
+	int part = bdev->bd_dev - bdev->bd_disk->gd_dev;
 	return disk_name(bdev->bd_disk, part, buf);
 }
 
@@ -226,9 +226,7 @@ static ssize_t part_uevent_store(struct 
 }
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
 {
-	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
-	dev_t dev = MKDEV(disk->major, disk->first_minor + p->partno); 
-	return print_dev_t(page, dev);
+	return print_dev_t(page, p->dev);
 }
 static ssize_t part_start_read(struct hd_struct * p, char *page)
 {
@@ -338,7 +336,7 @@ void add_partition(struct gendisk *disk,
 	memset(p, 0, sizeof(*p));
 	p->start_sect = start;
 	p->nr_sects = len;
-	p->partno = part;
+	p->dev = disk->gd_dev + part;
 	p->policy = disk->policy;
 
 	if (isdigit(disk->kobj.name[strlen(disk->kobj.name)-1]))
@@ -417,7 +415,7 @@ void register_disk(struct gendisk *disk)
 	if (!get_capacity(disk))
 		goto exit;
 
-	bdev = bdget_disk(disk, 0);
+	bdev = bdget_disk(disk);
 	if (!bdev)
 		goto exit;
 
diff -urp -X dontdiff linux-2.6.18-rc6/include/linux/genhd.h linux-2.6.18-rc6-lem/include/linux/genhd.h
--- linux-2.6.18-rc6/include/linux/genhd.h	2006-09-06 21:57:04.000000000 -0700
+++ linux-2.6.18-rc6-lem/include/linux/genhd.h	2006-09-07 16:16:47.000000000 -0700
@@ -80,7 +80,8 @@ struct hd_struct {
 	struct kobject kobj;
 	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
-	int policy, partno;
+	int policy;
+	dev_t dev;
 };
 
 #define GENHD_FL_REMOVABLE			1
@@ -97,10 +98,9 @@ struct disk_stats {
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 };
-	
+
 struct gendisk {
-	int major;			/* major number of driver */
-	int first_minor;
+	dev_t gd_dev;			/* whole device */
 	int minors;                     /* maximum number of minors, =1 for
                                          * disks that can't be partitioned. */
 	char disk_name[32];		/* name of major driver */
@@ -412,9 +412,9 @@ extern void blk_register_region(dev_t de
 			void *data);
 extern void blk_unregister_region(dev_t dev, unsigned long range);
 
-static inline struct block_device *bdget_disk(struct gendisk *disk, int index)
+static inline struct block_device *bdget_disk(struct gendisk *disk)
 {
-	return bdget(MKDEV(disk->major, disk->first_minor) + index);
+	return bdget(disk->gd_dev);
 }
 
 #endif
