Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313699AbSDHW32>; Mon, 8 Apr 2002 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313723AbSDHW31>; Mon, 8 Apr 2002 18:29:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50990 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313699AbSDHW3Z>; Mon, 8 Apr 2002 18:29:25 -0400
Date: Mon, 8 Apr 2002 18:29:23 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch for sd.c to reduce maximum kmalloc size
Message-ID: <20020408182923.D2047@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I think the attached patch is ready to be included in a -preX.
The only voice of dissent I received was from a guy who
obviously was confused about relative sizes of vmalloc and
kmalloc areas.

Note that I am introducing a couple of XXXes. They mark places
which I think are buggy, but I do not want to fix them right
away and thus to hinder the more important fix in this patch.
These places were there for months, and nobody complained.
If 2.4.19 does not eat scsi disks, I'll return to these two
with a mallet in 2.4.20 time.

Greetings,
-- Pete

diff -urN -X dontdiff linux-2.4.19-pre6/drivers/scsi/sd.c linux-2.4.19-pre6-p3/drivers/scsi/sd.c
--- linux-2.4.19-pre6/drivers/scsi/sd.c	Fri Apr  5 16:00:33 2002
+++ linux-2.4.19-pre6-p3/drivers/scsi/sd.c	Fri Apr  5 16:19:03 2002
@@ -65,8 +65,13 @@
  *  static const char RCSid[] = "$Header:";
  */
 
+/* system major --> sd_gendisks index */
+#define SD_MAJOR_IDX(i)		(MAJOR(i) & SD_MAJOR_MASK)
+/* sd_gendisks index --> system major */
 #define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
 
+#define SD_PARTITION(dev)	((SD_MAJOR_IDX(dev) << 8) | (MINOR(dev) & 255))
+
 #define SCSI_DISKS_PER_MAJOR	16
 #define SD_MAJOR_NUMBER(i)	SD_MAJOR((i) >> 8)
 #define SD_MINOR_NUMBER(i)	((i) & 255)
@@ -84,9 +89,8 @@
 #define SD_TIMEOUT (30 * HZ)
 #define SD_MOD_TIMEOUT (75 * HZ)
 
-struct hd_struct *sd;
-
 static Scsi_Disk *rscsi_disks;
+static struct gendisk *sd_gendisks;
 static int *sd_sizes;
 static int *sd_blocksizes;
 static int *sd_hardsizes;	/* Hardware sector size */
@@ -195,7 +199,9 @@
 			if (put_user(diskinfo[0], &loc->heads) ||
 				put_user(diskinfo[1], &loc->sectors) ||
 				put_user(diskinfo[2], &loc->cylinders) ||
-				put_user(sd[SD_PARTITION(inode->i_rdev)].start_sect, &loc->start))
+				put_user(sd_gendisks[SD_MAJOR_IDX(
+				    inode->i_rdev)].part[MINOR(
+				    inode->i_rdev)].start_sect, &loc->start))
 				return -EFAULT;
 			return 0;
 		}
@@ -226,7 +232,9 @@
 			if (put_user(diskinfo[0], &loc->heads) ||
 				put_user(diskinfo[1], &loc->sectors) ||
 				put_user(diskinfo[2], (unsigned int *) &loc->cylinders) ||
-				put_user(sd[SD_PARTITION(inode->i_rdev)].start_sect, &loc->start))
+				put_user(sd_gendisks[SD_MAJOR_IDX(
+				    inode->i_rdev)].part[MINOR(
+				    inode->i_rdev)].start_sect, &loc->start))
 				return -EFAULT;
 			return 0;
 		}
@@ -286,30 +294,32 @@
 
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, devm, block, this_count;
+	int dev, block, this_count;
+	struct hd_struct *ppnt;
 	Scsi_Disk *dpnt;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 #endif
 
-	devm = SD_PARTITION(SCpnt->request.rq_dev);
+	ppnt = &sd_gendisks[SD_MAJOR_IDX(SCpnt->request.rq_dev)].part[MINOR(SCpnt->request.rq_dev)];
 	dev = DEVICE_NR(SCpnt->request.rq_dev);
 
 	block = SCpnt->request.sector;
 	this_count = SCpnt->request_bufflen >> 9;
 
-	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev = %d, block = %d\n", devm, block));
+	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev = 0x%x, block = %d\n",
+	    SCpnt->request.rq_dev, block));
 
 	dpnt = &rscsi_disks[dev];
-	if (devm >= (sd_template.dev_max << 4) ||
+	if (dev >= sd_template.dev_max ||
 	    !dpnt->device ||
 	    !dpnt->device->online ||
- 	    block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
+ 	    block + SCpnt->request.nr_sectors > ppnt->nr_sects) {
 		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_sectors));
 		SCSI_LOG_HLQUEUE(2, printk("Retry with 0x%p\n", SCpnt));
 		return 0;
 	}
-	block += sd[devm].start_sect;
+	block += ppnt->start_sect;
 	if (dpnt->device->changed) {
 		/*
 		 * quietly refuse to do anything to a changed disc until the changed
@@ -318,7 +328,7 @@
 		/* printk("SCSI disk has been changed. Prohibiting further I/O.\n"); */
 		return 0;
 	}
-	SCSI_LOG_HLQUEUE(2, sd_devname(devm, nbuff));
+	SCSI_LOG_HLQUEUE(2, sd_devname(dev, nbuff));
 	SCSI_LOG_HLQUEUE(2, printk("%s : real dev = /dev/%d, block = %d\n",
 				   nbuff, dev, block));
 
@@ -576,8 +586,6 @@
 	fops:		&sd_fops,
 };
 
-static struct gendisk *sd_gendisks = &sd_gendisk;
-
 #define SD_GENDISK(i)    sd_gendisks[(i) / SCSI_DISKS_PER_MAJOR]
 
 /*
@@ -644,7 +652,9 @@
 			default:
 				break;
 			}
-			error_sector -= sd[SD_PARTITION(SCpnt->request.rq_dev)].start_sect;
+			error_sector -= sd_gendisks[SD_MAJOR_IDX(
+				SCpnt->request.rq_dev)].part[MINOR(
+				SCpnt->request.rq_dev)].start_sect;
 			error_sector &= ~(block_sectors - 1);
 			good_sectors = error_sector - SCpnt->request.sector;
 			if (good_sectors < 0 || good_sectors >= this_count)
@@ -1146,23 +1156,12 @@
 		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 		max_sectors[SD_MAJOR(i)] = sd_max_sectors + i * (SCSI_DISKS_PER_MAJOR << 4);
 	}
-	/*
-	 * FIXME: should unregister blksize_size, hardsect_size and max_sectors when
-	 * the module is unloaded.
-	 */
-	sd = kmalloc((sd_template.dev_max << 4) *
-					  sizeof(struct hd_struct),
-					  GFP_ATOMIC);
-	if (!sd)
-		goto cleanup_sd;
-	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
-
-	if (N_USED_SD_MAJORS > 1)
-		sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
-		if (!sd_gendisks)
-			goto cleanup_sd_gendisks;
+
+	sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
+	if (!sd_gendisks)
+		goto cleanup_sd_gendisks;
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		sd_gendisks[i] = sd_gendisk;
+		sd_gendisks[i] = sd_gendisk;	/* memcpy */
 		sd_gendisks[i].de_arr = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr,
                                                  GFP_ATOMIC);
 		if (!sd_gendisks[i].de_arr)
@@ -1179,7 +1178,11 @@
 		sd_gendisks[i].major_name = "sd";
 		sd_gendisks[i].minor_shift = 4;
 		sd_gendisks[i].max_p = 1 << 4;
-		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
+		sd_gendisks[i].part = kmalloc((SCSI_DISKS_PER_MAJOR << 4) * sizeof(struct hd_struct),
+						GFP_ATOMIC);
+		if (!sd_gendisks[i].part)
+			goto cleanup_gendisks_part;
+		memset(sd_gendisks[i].part, 0, (SCSI_DISKS_PER_MAJOR << 4) * sizeof(struct hd_struct));
 		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].nr_real = 0;
 		sd_gendisks[i].real_devices =
@@ -1188,18 +1191,19 @@
 
 	return 0;
 
+cleanup_gendisks_part:
+	kfree(sd_gendisks[i].flags);
 cleanup_gendisks_flags:
 	kfree(sd_gendisks[i].de_arr);
 cleanup_gendisks_de_arr:
 	while (--i >= 0 ) {
 		kfree(sd_gendisks[i].de_arr);
 		kfree(sd_gendisks[i].flags);
+		kfree(sd_gendisks[i].part);
 	}
-	if (sd_gendisks != &sd_gendisk)
-		kfree(sd_gendisks);
+	kfree(sd_gendisks);
+	sd_gendisks = NULL;
 cleanup_sd_gendisks:
-	kfree(sd);
-cleanup_sd:
 	kfree(sd_max_sectors);
 cleanup_max_sectors:
 	kfree(sd_hardsizes);
@@ -1320,6 +1324,7 @@
  */
 int revalidate_scsidisk(kdev_t dev, int maxusage)
 {
+	struct gendisk *sdgd;
 	int target;
 	int max_p;
 	int start;
@@ -1333,14 +1338,15 @@
 	}
 	DEVICE_BUSY = 1;
 
-	max_p = sd_gendisks->max_p;
-	start = target << sd_gendisks->minor_shift;
+	sdgd = &SD_GENDISK(target);
+	max_p = sd_gendisk.max_p;
+	start = target << sd_gendisk.minor_shift;
 
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
 		invalidate_device(MKDEV_SD_PARTITION(index), 1);
-		sd_gendisks->part[index].start_sect = 0;
-		sd_gendisks->part[index].nr_sects = 0;
+		sdgd->part[SD_MINOR_NUMBER(index)].start_sect = 0;
+		sdgd->part[SD_MINOR_NUMBER(index)].nr_sects = 0;
 		/*
 		 * Reset the blocksize for everything so that we can read
 		 * the partition table.  Technically we will determine the
@@ -1372,6 +1378,7 @@
 static void sd_detach(Scsi_Device * SDp)
 {
 	Scsi_Disk *dpnt;
+	struct gendisk *sdgd;
 	int i, j;
 	int max_p;
 	int start;
@@ -1384,17 +1391,18 @@
 
 			/* If we are disconnecting a disk driver, sync and invalidate
 			 * everything */
+			sdgd = &SD_GENDISK(i);
 			max_p = sd_gendisk.max_p;
 			start = i << sd_gendisk.minor_shift;
 
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
 				invalidate_device(MKDEV_SD_PARTITION(index), 1);
-				sd_gendisks->part[index].start_sect = 0;
-				sd_gendisks->part[index].nr_sects = 0;
+				sdgd->part[SD_MINOR_NUMBER(index)].start_sect = 0;
+				sdgd->part[SD_MINOR_NUMBER(index)].nr_sects = 0;
 				sd_sizes[index] = 0;
 			}
-                        devfs_register_partitions (&SD_GENDISK (i),
+                        devfs_register_partitions (sdgd,
                                                    SD_MINOR_NUMBER (start), 1);
 			/* unregister_disk() */
 			dpnt->has_part_table = 0;
@@ -1430,16 +1438,22 @@
 		kfree(sd_sizes);
 		kfree(sd_blocksizes);
 		kfree(sd_hardsizes);
-		kfree((char *) sd);
+		for (i = 0; i < N_USED_SD_MAJORS; i++) {
+#if 0 /* XXX aren't we forgetting to deallocate something? */
+			kfree(sd_gendisks[i].de_arr);
+			kfree(sd_gendisks[i].flags);
+#endif
+			kfree(sd_gendisks[i].part);
+		}
 	}
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		del_gendisk(&sd_gendisks[i]);
-		blk_size[SD_MAJOR(i)] = NULL;
+		blk_size[SD_MAJOR(i)] = NULL;	/* XXX blksize_size actually? */
 		hardsect_size[SD_MAJOR(i)] = NULL;
 		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;
-	if (sd_gendisks != &sd_gendisk)
+	if (sd_gendisks != NULL)    /* kfree tests for 0, but leave explicit */
 		kfree(sd_gendisks);
 }
 
diff -urN -X dontdiff linux-2.4.19-pre6/drivers/scsi/sd.h linux-2.4.19-pre6-p3/drivers/scsi/sd.h
--- linux-2.4.19-pre6/drivers/scsi/sd.h	Thu Nov 22 11:49:15 2001
+++ linux-2.4.19-pre6-p3/drivers/scsi/sd.h	Fri Apr  5 16:46:06 2002
@@ -23,8 +23,6 @@
 #include <linux/genhd.h>
 #endif
 
-extern struct hd_struct *sd;
-
 typedef struct scsi_disk {
 	unsigned capacity;	/* size in blocks */
 	Scsi_Device *device;
@@ -45,7 +43,6 @@
 #define N_SD_MAJORS	8
 
 #define SD_MAJOR_MASK	(N_SD_MAJORS - 1)
-#define SD_PARTITION(i)		(((MAJOR(i) & SD_MAJOR_MASK) << 8) | (MINOR(i) & 255))
 
 #endif
 
