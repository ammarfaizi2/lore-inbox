Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbREOVnI>; Tue, 15 May 2001 17:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbREOVnA>; Tue, 15 May 2001 17:43:00 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:57607 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261599AbREOVmr>; Tue, 15 May 2001 17:42:47 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105152142.XAA23753@green.mif.pg.gda.pl>
Subject: Re: [PATCH] SCSI disk minor number cleaning
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 23:42:31 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>   The following patch cleans up a bit usage of parameters related to
> number of minors per disk in the SCSI subsystem. This is a preliminary
> patch and it seems to not contain any problematic changes. The full version
> of the patch (that allows to succesfully change SCSI_MINOR_SHIFT and use
> more/less partitions per disk) is available at
> 
> ftp://rudy.mif.pg.gda.pl/pub/People/ankry/patches/scsi-minor/
> 
> Both are against 2.4.4-ac9, but the "shorter" one can be applied to
> 2.4.5-pre series as well.

Oops. The previous putch was buggy (broken #include).
The enclosed in corrected...

> Any comments are welcome.

     Andrzej
******************************************************************
diff -ur linux-2.4.4-ac9/drivers/scsi/sd.c linux-scsi/drivers/scsi/sd.c
--- linux-2.4.4-ac9/drivers/scsi/sd.c	Thu May  3 19:29:16 2001
+++ linux-scsi/drivers/scsi/sd.c	Tue May 15 23:39:12 2001
@@ -67,11 +67,12 @@
 
 #define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
 
-#define SCSI_DISKS_PER_MAJOR	16
+#define SCSI_MINOR_SHIFT	4
+#define SCSI_DISKS_PER_MAJOR	(1 << (8 - SCSI_MINOR_SHIFT))
 #define SD_MAJOR_NUMBER(i)	SD_MAJOR((i) >> 8)
 #define SD_MINOR_NUMBER(i)	((i) & 255)
 #define MKDEV_SD_PARTITION(i)	MKDEV(SD_MAJOR_NUMBER(i), (i) & 255)
-#define MKDEV_SD(index)		MKDEV_SD_PARTITION((index) << 4)
+#define MKDEV_SD(index)		MKDEV_SD_PARTITION((index) << SCSI_MINOR_SHIFT)
 #define N_USED_SCSI_DISKS  (sd_template.dev_max + SCSI_DISKS_PER_MAJOR - 1)
 #define N_USED_SD_MAJORS   (N_USED_SCSI_DISKS / SCSI_DISKS_PER_MAJOR)
 
@@ -298,7 +299,7 @@
 	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev = %d, block = %d\n", devm, block));
 
 	dpnt = &rscsi_disks[dev];
-	if (devm >= (sd_template.dev_max << 4) ||
+	if (devm >= (sd_template.dev_max << SCSI_MINOR_SHIFT) ||
 	    !dpnt ||
 	    !dpnt->device->online ||
  	    block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
@@ -563,8 +564,8 @@
 {
 	SCSI_DISK0_MAJOR,	/* Major number */
 	"sd",			/* Major name */
-	4,			/* Bits to shift to get real from partition */
-	1 << 4,			/* Number of partitions per real */
+	SCSI_MINOR_SHIFT,	/* Bits to shift to get real from partition */
+	1 << SCSI_MINOR_SHIFT,	/* Number of partitions per real */
 	NULL,			/* hd struct */
 	NULL,			/* block sizes */
 	0,			/* number */
@@ -951,7 +952,7 @@
 			 * The disk reading code does not allow for reading
 			 * of partial sectors.
 			 */
-			for (m = i << 4; m < ((i + 1) << 4); m++) {
+			for (m = i << SCSI_MINOR_SHIFT; m < ((i + 1) << SCSI_MINOR_SHIFT); m++) {
 				sd_blocksizes[m] = sector_size;
 			}
 		} {
@@ -964,8 +965,11 @@
 			int hard_sector = sector_size;
 			int sz = rscsi_disks[i].capacity * (hard_sector/256);
 
-			/* There are 16 minors allocated for each major device */
-			for (m = i << 4; m < ((i + 1) << 4); m++) {
+			/* 
+			 * There are 1<<SCSI_MINOR_SHIFT minors allocated 
+			 * for each major device
+			 */
+			for (m = i << SCSI_MINOR_SHIFT; m < ((i + 1) << SCSI_MINOR_SHIFT); m++) {
 				sd_hardsizes[m] = hard_sector;
 			}
 
@@ -1083,34 +1087,34 @@
 	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));
 
 	/* for every (necessary) major: */
-	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_sizes = kmalloc((sd_template.dev_max << SCSI_MINOR_SHIFT) * sizeof(int), GFP_ATOMIC);
 	if (!sd_sizes)
 		goto cleanup_disks;
-	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
+	memset(sd_sizes, 0, (sd_template.dev_max << SCSI_MINOR_SHIFT) * sizeof(int));
 
-	sd_blocksizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_blocksizes = kmalloc((sd_template.dev_max << SCSI_MINOR_SHIFT) * sizeof(int), GFP_ATOMIC);
 	if (!sd_blocksizes)
 		goto cleanup_sizes;
 	
-	sd_hardsizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_hardsizes = kmalloc((sd_template.dev_max << SCSI_MINOR_SHIFT) * sizeof(int), GFP_ATOMIC);
 	if (!sd_hardsizes)
 		goto cleanup_blocksizes;
 
-	for (i = 0; i < sd_template.dev_max << 4; i++) {
+	for (i = 0; i < sd_template.dev_max << SCSI_MINOR_SHIFT; i++) {
 		sd_blocksizes[i] = 1024;
 		sd_hardsizes[i] = 512;
 	}
 
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << 4);
-		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
+		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << SCSI_MINOR_SHIFT);
+		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << SCSI_MINOR_SHIFT);
 	}
-	sd = kmalloc((sd_template.dev_max << 4) *
+	sd = kmalloc((sd_template.dev_max << SCSI_MINOR_SHIFT) *
 					  sizeof(struct hd_struct),
 					  GFP_ATOMIC);
 	if (!sd)
 		goto cleanup_sd;
-	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
+	memset(sd, 0, (sd_template.dev_max << SCSI_MINOR_SHIFT) * sizeof(struct hd_struct));
 
 	if (N_USED_SD_MAJORS > 1)
 		sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
@@ -1132,10 +1136,10 @@
                         SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags);
 		sd_gendisks[i].major = SD_MAJOR(i);
 		sd_gendisks[i].major_name = "sd";
-		sd_gendisks[i].minor_shift = 4;
-		sd_gendisks[i].max_p = 1 << 4;
-		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
-		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
+		sd_gendisks[i].minor_shift = SCSI_MINOR_SHIFT;
+		sd_gendisks[i].max_p = 1 << SCSI_MINOR_SHIFT;
+		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << SCSI_MINOR_SHIFT);
+		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << SCSI_MINOR_SHIFT);
 		sd_gendisks[i].nr_real = 0;
 		sd_gendisks[i].next = sd_gendisks + i + 1;
 		sd_gendisks[i].real_devices =
@@ -1191,9 +1195,9 @@
 		if (!rscsi_disks[i].capacity && rscsi_disks[i].device) {
 			sd_init_onedisk(i);
 			if (!rscsi_disks[i].has_part_table) {
-				sd_sizes[i << 4] = rscsi_disks[i].capacity;
+				sd_sizes[i << SCSI_MINOR_SHIFT] = rscsi_disks[i].capacity;
 				register_disk(&SD_GENDISK(i), MKDEV_SD(i),
-						1<<4, &sd_fops,
+						1 << SCSI_MINOR_SHIFT, &sd_fops,
 						rscsi_disks[i].capacity);
 				rscsi_disks[i].has_part_table = 1;
 			}
@@ -1312,7 +1316,7 @@
 #endif
 
 	grok_partitions(&SD_GENDISK(target), target % SCSI_DISKS_PER_MAJOR,
-			1<<4, CAPACITY);
+			1 << SCSI_MINOR_SHIFT, CAPACITY);
 
 	DEVICE_BUSY = 0;
 	return 0;

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
