Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbRFRAtp>; Sun, 17 Jun 2001 20:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbRFRAtg>; Sun, 17 Jun 2001 20:49:36 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12738 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263244AbRFRAtU>;
	Sun, 17 Jun 2001 20:49:20 -0400
Date: Mon, 18 Jun 2001 02:49:17 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106180049.CAA314369.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sd_init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the "partition shift"
	block += partition_start;
from the bowels of SCSI and IDE drivers to ll_rw_blk.c
(something that must wait for 2.5) I changed sd_init a bit
and noticed that the present version is buggy:

static struct gendisk sd_gendisk = {
	SCSI_DISK0_MAJOR,       /* Major number */
	...
};
static struct gendisk *sd_gendisks = &sd_gendisk;
...
static int sd_init() {
	...
	if (N_USED_SD_MAJORS > 1)
		sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
	...
		sd_gendisks[i].de_arr = kmalloc(...);
		if (!sd_gendisks[i].de_arr)
			goto cleanup_gendisks_de_arr;
	...
cleanup_gendisks_de_arr:
	...
	kfree(sd_gendisks);


That is, we may free sd_gendisk that was never allocated.
The easiest fix is to delete the condition "if (N_USED_SD_MAJORS > 1)".

Andries


(I was allocating some more stuff there, and following the local style
gave too ugly code. Present version of this one-line fix follows.)

diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/scsi/sd.c ./linux/drivers/scsi/sd.c
--- ../linux-2.4.6-pre3/linux/drivers/scsi/sd.c	Wed Jun 13 09:21:03 2001
+++ ./linux/drivers/scsi/sd.c	Mon Jun 18 00:52:18 2001
@@ -55,9 +55,6 @@
 
 #include <linux/genhd.h>
 
-/*
- *  static const char RCSid[] = "$Header:";
- */
 
 #define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
 
@@ -66,8 +63,7 @@
 #define SD_MINOR_NUMBER(i)	((i) & 255)
 #define MKDEV_SD_PARTITION(i)	MKDEV(SD_MAJOR_NUMBER(i), (i) & 255)
 #define MKDEV_SD(index)		MKDEV_SD_PARTITION((index) << 4)
-#define N_USED_SCSI_DISKS  (sd_template.dev_max + SCSI_DISKS_PER_MAJOR - 1)
-#define N_USED_SD_MAJORS   (N_USED_SCSI_DISKS / SCSI_DISKS_PER_MAJOR)
+#define N_USED_SD_MAJORS	(1 + ((sd_template.dev_max - 1) >> 4))
 
 #define MAX_RETRIES 5
 
@@ -90,7 +86,6 @@
 
 static int sd_init_onedisk(int);
 
-
 static int sd_init(void);
 static void sd_finish(void);
 static int sd_attach(Scsi_Device *);
@@ -1020,7 +1015,7 @@
 
 static int sd_init()
 {
-	int i;
+	int i, maxparts;
 
 	if (sd_template.dev_noticed == 0)
 		return 0;
@@ -1031,37 +1026,44 @@
 	if (sd_template.dev_max > N_SD_MAJORS * SCSI_DISKS_PER_MAJOR)
 		sd_template.dev_max = N_SD_MAJORS * SCSI_DISKS_PER_MAJOR;
 
+	/* At most 16 partitions on each scsi disk. */
+	maxparts = (sd_template.dev_max << 4);
+	if (maxparts == 0)
+		return 0;
+
 	if (!sd_registered) {
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
-				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
+				printk("Unable to get major %d for SCSI disk\n",
+				       SD_MAJOR(i));
 				return 1;
 			}
 		}
 		sd_registered++;
 	}
+
 	/* We do not support attaching loadable devices yet. */
 	if (rscsi_disks)
 		return 0;
 
-	rscsi_disks = kmalloc(sd_template.dev_max * sizeof(Scsi_Disk), GFP_ATOMIC);
-	if (!rscsi_disks)
-		goto cleanup_devfs;
-	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));
-
-	/* for every (necessary) major: */
-	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
-	if (!sd_sizes)
-		goto cleanup_disks;
-	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
-
-	sd_blocksizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
-	if (!sd_blocksizes)
-		goto cleanup_sizes;
-	
-	sd_hardsizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
-	if (!sd_hardsizes)
-		goto cleanup_blocksizes;
+	/* Allocate memory */
+#define init_mem_lth(x,n)	x = kmalloc((n) * sizeof(*x), GFP_ATOMIC)
+#define zero_mem_lth(x,n)	memset(x, 0, (n) * sizeof(*x))
+
+	init_mem_lth(rscsi_disks, sd_template.dev_max);
+	init_mem_lth(sd_sizes, maxparts);
+	init_mem_lth(sd_blocksizes, maxparts);
+	init_mem_lth(sd_hardsizes, maxparts);
+	init_mem_lth(sd, maxparts);
+	init_mem_lth(sd_gendisks, N_USED_SD_MAJORS);
+
+	if (!rscsi_disks || !sd_sizes || !sd_blocksizes ||
+	    !sd_hardsizes || !sd || !sd_gendisks)
+		goto cleanup_mem;
+
+	zero_mem_lth(rscsi_disks, sd_template.dev_max);
+	zero_mem_lth(sd_sizes, maxparts);
+	zero_mem_lth(sd, maxparts);
 
 	for (i = 0; i < sd_template.dev_max << 4; i++) {
 		sd_blocksizes[i] = 1024;
@@ -1069,68 +1071,59 @@
 	}
 
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << 4);
-		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
+		int parts_per_major = (SCSI_DISKS_PER_MAJOR << 4);
+
+		blksize_size[SD_MAJOR(i)] =
+			sd_blocksizes + i * parts_per_major;
+		hardsect_size[SD_MAJOR(i)] =
+			sd_hardsizes + i * parts_per_major;
 	}
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
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
+		int N = SCSI_DISKS_PER_MAJOR;
+
 		sd_gendisks[i] = sd_gendisk;
-		sd_gendisks[i].de_arr = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr,
-                                                 GFP_ATOMIC);
-		if (!sd_gendisks[i].de_arr)
-			goto cleanup_gendisks_de_arr;
-                memset (sd_gendisks[i].de_arr, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr);
-		sd_gendisks[i].flags = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags,
-                                                GFP_ATOMIC);
-		if (!sd_gendisks[i].flags)
-			goto cleanup_gendisks_flags;
-                memset (sd_gendisks[i].flags, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags);
+
+		init_mem_lth(sd_gendisks[i].de_arr, N);
+		init_mem_lth(sd_gendisks[i].flags, N);
+
+		if (!sd_gendisks[i].de_arr || !sd_gendisks[i].flags)
+			goto cleanup_gendisks;
+
+		zero_mem_lth(sd_gendisks[i].de_arr, N);
+		zero_mem_lth(sd_gendisks[i].flags, N);
+
 		sd_gendisks[i].major = SD_MAJOR(i);
 		sd_gendisks[i].major_name = "sd";
 		sd_gendisks[i].minor_shift = 4;
 		sd_gendisks[i].max_p = 1 << 4;
-		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
-		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
+		sd_gendisks[i].part = sd + i * (N << 4);
+		sd_gendisks[i].sizes = sd_sizes + i * (N << 4);
 		sd_gendisks[i].nr_real = 0;
 		sd_gendisks[i].next = sd_gendisks + i + 1;
-		sd_gendisks[i].real_devices =
-		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
+		sd_gendisks[i].real_devices = (void *) (rscsi_disks + i * N);
 	}
+#undef init_mem_lth
+#undef zero_mem_lth
 
 	LAST_SD_GENDISK.next = NULL;
 	return 0;
 
-cleanup_gendisks_flags:
-	kfree(sd_gendisks[i].de_arr);
-cleanup_gendisks_de_arr:
-	while (--i >= 0 ) {
+cleanup_gendisks:
+	/* kfree can handle NULL, so no test is required here */
+	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		kfree(sd_gendisks[i].de_arr);
 		kfree(sd_gendisks[i].flags);
 	}
 	kfree(sd_gendisks);
-cleanup_sd_gendisks:
+cleanup_mem:
+	/* kfree can handle NULL, so no test is required here */
 	kfree(sd);
-cleanup_sd:
 	kfree(sd_hardsizes);
-cleanup_blocksizes:
 	kfree(sd_blocksizes);
-cleanup_sizes:
 	kfree(sd_sizes);
-cleanup_disks:
 	kfree(rscsi_disks);
-cleanup_devfs:
+
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 	}
