Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284906AbRLFAkI>; Wed, 5 Dec 2001 19:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284908AbRLFAkA>; Wed, 5 Dec 2001 19:40:00 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32189 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284906AbRLFAjn>; Wed, 5 Dec 2001 19:39:43 -0500
Date: Wed, 5 Dec 2001 19:39:41 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for oopses if sd_init fails
Message-ID: <20011205193941.A23288@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not fix _all_ of oopses, I am working on
a worse one yet in scsi.c. This whole area is a rat hole.
However, I would appreciate if Marcelo
added those now - if nobody disagrees.

Ask me for precise oops scenarios, if anything is unclear.

-- Pete

diff -ur -X dontdiff linux-2.4.17-pre4/drivers/scsi/sd.c linux-2.4.17-pre4-p3/drivers/scsi/sd.c
--- linux-2.4.17-pre4/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
+++ linux-2.4.17-pre4-p3/drivers/scsi/sd.c	Wed Dec  5 15:10:50 2001
@@ -1175,7 +1175,8 @@
 		kfree(sd_gendisks[i].de_arr);
 		kfree(sd_gendisks[i].flags);
 	}
-	kfree(sd_gendisks);
+	if (sd_gendisks != &sd_gendisk)
+		kfree(sd_gendisks);
 cleanup_sd_gendisks:
 	kfree(sd);
 cleanup_sd:
@@ -1188,6 +1189,7 @@
 	kfree(sd_sizes);
 cleanup_disks:
 	kfree(rscsi_disks);
+	rscsi_disks = NULL;
 cleanup_devfs:
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
@@ -1251,7 +1253,7 @@
 	if (SDp->type != TYPE_DISK && SDp->type != TYPE_MOD)
 		return 0;
 
-	if (sd_template.nr_dev >= sd_template.dev_max) {
+	if (sd_template.nr_dev >= sd_template.dev_max || rscsi_disks == NULL) {
 		SDp->attached--;
 		return 1;
 	}
@@ -1347,6 +1349,9 @@
 	int i, j;
 	int max_p;
 	int start;
+
+	if (rscsi_disks == NULL)
+		return;
 
 	for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++)
 		if (dpnt->device == SDp) {
diff -ur -X dontdiff linux-2.4.17-pre4/drivers/scsi/sr.c linux-2.4.17-pre4-p3/drivers/scsi/sr.c
--- linux-2.4.17-pre4/drivers/scsi/sr.c	Thu Oct 25 13:58:35 2001
+++ linux-2.4.17-pre4-p3/drivers/scsi/sr.c	Wed Dec  5 15:32:09 2001
@@ -542,7 +542,7 @@
 	if (SDp->type != TYPE_ROM && SDp->type != TYPE_WORM)
 		return 1;
 
-	if (sr_template.nr_dev >= sr_template.dev_max) {
+	if (sr_template.nr_dev >= sr_template.dev_max || scsi_CDs == NULL) {
 		SDp->attached--;
 		return 1;
 	}
@@ -830,6 +830,7 @@
 	kfree(sr_sizes);
 cleanup_cds:
 	kfree(scsi_CDs);
+	scsi_CDs = NULL;
 cleanup_devfs:
 	devfs_unregister_blkdev(MAJOR_NR, "sr");
 	sr_registered--;
@@ -904,6 +905,9 @@
 {
 	Scsi_CD *cpnt;
 	int i;
+
+	if (scsi_CDs == NULL)
+		return;
 
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
