Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273741AbRIQWlD>; Mon, 17 Sep 2001 18:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRIQWkt>; Mon, 17 Sep 2001 18:40:49 -0400
Received: from ns.caldera.de ([212.34.180.1]:44722 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273732AbRIQWkb>;
	Mon, 17 Sep 2001 18:40:31 -0400
Date: Tue, 18 Sep 2001 00:40:47 +0200
Message-Id: <200109172240.f8HMel917969@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: andersen@codepoet.org (Erik Andersen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010917151957.A26615@codepoet.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010917151957.A26615@codepoet.org> you wrote:
> [----------snip----------]
> [----------snip----------]

Could you please try the attached patch agains 2.4.10-pre10?

--- ../master/linux-2.4.10-pre10/drivers/scsi/sd.c	Mon Sep 17 00:48:49 2001
+++ linux/drivers/scsi/sd.c	Tue Sep 18 00:34:41 2001
@@ -557,22 +557,7 @@
 	revalidate:		fop_revalidate_scsidisk
 };
 
-/*
- *    If we need more than one SCSI disk major (i.e. more than
- *      16 SCSI disks), we'll have to kmalloc() more gendisks later.
- */
-
-static struct gendisk sd_gendisk =
-{
-	major:		SCSI_DISK0_MAJOR,
-	major_name:	"sd",
-	minor_shift:	4,
-	max_p:		1 << 4,
-	fops:		&sd_fops,
-};
-
-static struct gendisk *sd_gendisks = &sd_gendisk;
-
+static struct gendisk *sd_gendisks;
 #define SD_GENDISK(i)    sd_gendisks[(i) / SCSI_DISKS_PER_MAJOR]
 
 /*
@@ -1132,33 +1117,34 @@
 		goto cleanup_sd;
 	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
 
-	if (N_USED_SD_MAJORS > 1)
-		sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
-		if (!sd_gendisks)
-			goto cleanup_sd_gendisks;
+	sd_gendisks = kmalloc(N_USED_SD_MAJORS * sizeof(struct gendisk), GFP_ATOMIC);
+	if (!sd_gendisks)
+		goto cleanup_sd_gendisks;
+
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		sd_gendisks[i] = sd_gendisk;
-		sd_gendisks[i].de_arr = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr,
-                                                 GFP_ATOMIC);
-		if (!sd_gendisks[i].de_arr)
+		struct gendisk	*g = &sd_gendisks[i];
+
+		g->de_arr = kmalloc(SCSI_DISKS_PER_MAJOR * sizeof(*g->de_arr),
+				GFP_ATOMIC);
+		if (!g->de_arr)
 			goto cleanup_gendisks_de_arr;
-                memset (sd_gendisks[i].de_arr, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].de_arr);
-		sd_gendisks[i].flags = kmalloc (SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags,
-                                                GFP_ATOMIC);
-		if (!sd_gendisks[i].flags)
+		memset(g->de_arr, 0, SCSI_DISKS_PER_MAJOR * sizeof(*g->de_arr));
+
+		g->flags = kmalloc(SCSI_DISKS_PER_MAJOR *
+				sizeof(*g->flags), GFP_ATOMIC);
+		if (!g->flags)
 			goto cleanup_gendisks_flags;
-                memset (sd_gendisks[i].flags, 0,
-                        SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags);
-		sd_gendisks[i].major = SD_MAJOR(i);
-		sd_gendisks[i].major_name = "sd";
-		sd_gendisks[i].minor_shift = 4;
-		sd_gendisks[i].max_p = 1 << 4;
-		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
-		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
-		sd_gendisks[i].nr_real = 0;
-		sd_gendisks[i].real_devices =
-		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
+		memset(g->flags, 0, SCSI_DISKS_PER_MAJOR * sizeof(*g->flags));
+
+		g->major = SD_MAJOR(i);
+		g->major_name = "sd";
+		g->minor_shift = 4;
+		g->max_p = 1 << g->minor_shift;
+		g->part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
+		g->sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
+		g->nr_real = 0;
+		g->real_devices = (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
+		g->fops = &sd_fops;
 	}
 
 	return 0;
@@ -1348,8 +1334,8 @@
 
 			/* If we are disconnecting a disk driver, sync and invalidate
 			 * everything */
-			max_p = sd_gendisk.max_p;
-			start = i << sd_gendisk.minor_shift;
+			max_p = sd_gendisks->max_p;
+			start = i << sd_gendisks->minor_shift;
 
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
@@ -1403,8 +1389,7 @@
 		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;
-	if (sd_gendisks != &sd_gendisk)
-		kfree(sd_gendisks);
+	kfree(sd_gendisks);
 }
 
 module_init(init_sd);
