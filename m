Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWH0ImB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWH0ImB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWH0ImB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:42:01 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:50 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750829AbWH0ImA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:42:00 -0400
Date: Sun, 27 Aug 2006 04:42:03 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: HPA Resume patch
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <44F15ADB.5040609@PicturesInMotion.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_P+o2gIDjKl1TKo+gMfpnjQ)"
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_P+o2gIDjKl1TKo+gMfpnjQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

This patch fixes a problem with computers that have HPA on their hard
drive and not being able to come out of resume from RAM or disk. I've
tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
of these. This patch also fixes the bug #6840. This is my first patch to
the kernel and I was told to e-mail the above people to get my patch
into the kernel. If I made a mistake please be gentle and correct me ;)

Lee Trager

--Boundary_(ID_P+o2gIDjKl1TKo+gMfpnjQ)
Content-type: text/plain; name=hpa-resume.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=hpa-resume.patch

diff -Naur linux-2.6.18-rc4-old/include/linux/ide.h linux-2.6.18-rc4/include/linux/ide.h
--- linux-2.6.18-rc4-old/include/linux/ide.h	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/include/linux/ide.h	2006-08-20 19:13:10.000000000 -0400
@@ -1201,6 +1201,17 @@
 void ide_register_subdriver(ide_drive_t *, ide_driver_t *);
 void ide_unregister_subdriver(ide_drive_t *, ide_driver_t *);
 
+/* Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
+*/
+static inline int idedisk_supports_hpa(const struct hd_driveid *id)
+{
+        return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+}
+
+extern void init_idedisk_capacity (ide_drive_t  *drive);
+
 #define ON_BOARD		1
 #define NEVER_BOARD		0

diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide-disk.c linux-2.6.18-rc4/drivers/ide/ide-disk.c
--- linux-2.6.18-rc4-old/drivers/ide/ide-disk.c	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/drivers/ide/ide-disk.c	2006-08-20 19:13:56.000000000 -0400
@@ -464,16 +464,6 @@
 }
 
 /*
- * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
- * so on non-buggy drives we need test only one.
- * However, we should also check whether these fields are valid.
- */
-static inline int idedisk_supports_hpa(const struct hd_driveid *id)
-{
-	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
-}
-
-/*
  * The same here.
  */
 static inline int idedisk_supports_lba48(const struct hd_driveid *id)
@@ -528,7 +518,7 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-static void init_idedisk_capacity (ide_drive_t  *drive)
+void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
 	/*
@@ -555,6 +545,8 @@
 	}
 }
 
+EXPORT_SYMBOL(init_idedisk_capacity);
+
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
 	return drive->capacity64 - drive->sect0;
diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide.c linux-2.6.18-rc4/drivers/ide/ide.c
--- linux-2.6.18-rc4-old/drivers/ide/ide.c	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/drivers/ide/ide.c	2006-08-20 19:12:38.000000000 -0400
@@ -1232,6 +1232,7 @@
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int ide_cmd;
 
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
@@ -1242,7 +1243,15 @@
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	ide_cmd = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+
+	/* check to see if this is a hard drive
+	 * if it is then checkhpa needs to be
+	 * disabled */
+	if(drive->media == ide_disk && idedisk_supports_hpa(drive->id))
+		init_idedisk_capacity(drive);
+
+	return ide_cmd;
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,

--Boundary_(ID_P+o2gIDjKl1TKo+gMfpnjQ)--
