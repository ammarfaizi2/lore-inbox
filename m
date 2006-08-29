Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWH2J5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWH2J5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWH2J5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:57:10 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:42528 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964860AbWH2J5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:57:07 -0400
Date: Tue, 29 Aug 2006 05:55:18 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: [PATCH] HPA resume fix
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Message-id: <44F40F06.4010408@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with computers that have HPA on their hard
drive and not being able to come out of resume from RAM or disk. This is
my first patch to the kernel and third time submitting it, hopefully I
got it right this time.

Signed-off-by: Lee Trager <Lee@PicturesInMotion.net>

---

diff -uprN -X linux-2.6.18-rc5/Documentation/dontdiff linux-2.6.18-rc5-old/drivers/ide/ide-disk.c linux-2.6.18-rc5/drivers/ide/ide-disk.c
--- linux-2.6.18-rc5-old/drivers/ide/ide-disk.c	2006-08-29 05:14:43.000000000 -0400
+++ linux-2.6.18-rc5/drivers/ide/ide-disk.c	2006-08-29 05:18:13.000000000 -0400
@@ -1024,6 +1024,17 @@ static void ide_disk_release(struct kref
 
 static int ide_disk_probe(ide_drive_t *drive);
 
+/*
+ * On HPA drives the capacity needs to be
+ * reinitilized on resume otherwise the disk
+ * can not be used and a hard reset is required
+ */
+static void ide_disk_resume(ide_drive_t *drive)
+{
+	if (idedisk_supports_hpa(drive->id))
+		init_idedisk_capacity(drive);
+}
+
 static void ide_device_shutdown(ide_drive_t *drive)
 {
 #ifdef	CONFIG_ALPHA
@@ -1067,6 +1078,7 @@ static ide_driver_t idedisk_driver = {
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
+	.resume			= ide_disk_resume,
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
diff -uprN -X linux-2.6.18-rc5/Documentation/dontdiff linux-2.6.18-rc5-old/drivers/ide/ide.c linux-2.6.18-rc5/drivers/ide/ide.c
--- linux-2.6.18-rc5-old/drivers/ide/ide.c	2006-08-29 05:14:43.000000000 -0400
+++ linux-2.6.18-rc5/drivers/ide/ide.c	2006-08-29 05:18:13.000000000 -0400
@@ -1229,9 +1229,11 @@ static int generic_ide_suspend(struct de
 static int generic_ide_resume(struct device *dev)
 {
 	ide_drive_t *drive = dev->driver_data;
+	ide_driver_t *drv = to_ide_driver(dev->driver);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int err;
 
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
@@ -1242,7 +1244,12 @@ static int generic_ide_resume(struct dev
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+
+	if (err == 0 && drv->resume)
+		drv->resume(drive);
+
+	return err;
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
diff -uprN -X linux-2.6.18-rc5/Documentation/dontdiff linux-2.6.18-rc5-old/include/linux/ide.h linux-2.6.18-rc5/include/linux/ide.h
--- linux-2.6.18-rc5-old/include/linux/ide.h	2006-08-29 05:15:53.000000000 -0400
+++ linux-2.6.18-rc5/include/linux/ide.h	2006-08-29 05:18:13.000000000 -0400
@@ -987,6 +987,7 @@ typedef struct ide_driver_s {
 	int		(*probe)(ide_drive_t *);
 	void		(*remove)(ide_drive_t *);
 	void		(*shutdown)(ide_drive_t *);
+	void		(*resume)(ide_drive_t *);
 } ide_driver_t;
 
 #define to_ide_driver(drv) container_of(drv, ide_driver_t, gen_driver)


