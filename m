Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSJVUqz>; Tue, 22 Oct 2002 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264929AbSJVUqz>; Tue, 22 Oct 2002 16:46:55 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:51907 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S264986AbSJVUqx> convert rfc822-to-8bit;
	Tue, 22 Oct 2002 16:46:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Emilio Gargiulo <emilio.gargiulo@infinito.it>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [patch] 2.4 raid shutdown issue
Date: Tue, 22 Oct 2002 22:51:24 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210222251.24380.emilio.gargiulo@infinito.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.19
I've found a minor problem with software RAID during linux shutdown.
If the raid device contains a filesystem, and the filesystem wasn't dismounted 
at shutdown time, the RAID device will not shutdown properly, and at next 
reboot it'll need a resync.
This happens when:
- I have the root filesystem on a RAID1 device
- The RAID isn't compiled as module
- The RAID partition id is 0xfd (linux raid autodetect)
So I wrote this kernel patch forcing read-only mode for every RAID device, 
before shutdown.
This is my first kernel patch, so, maybe, there could be a cleaner way to 
resolve this issue; please, let me know your opinion on it.

*****************

--- linux/drivers/md/md.c.orig	2002-10-13 21:37:34.000000000 +0200
+++ linux/drivers/md/md.c	2002-10-13 23:55:15.000000000 +0200
@@ -1794,9 +1794,15 @@
 	int err = 0, resync_interrupted = 0;
 	kdev_t dev = mddev_to_kdev(mddev);
 
-	if (atomic_read(&mddev->active)>1) {
-		printk(STILL_IN_USE, mdidx(mddev));
-		OUT(-EBUSY);
+	if (ro < 3 ) {
+		if (atomic_read(&mddev->active)>1) {
+			printk(STILL_IN_USE, mdidx(mddev));
+			OUT(-EBUSY);
+		}
+	} else {
+		if (atomic_read(&mddev->active)>1) {
+			printk("md: md%d forcing to read-only mode\n", mdidx(mddev));
+		}
 	}
 
 	if (mddev->pers) {
@@ -3608,7 +3614,7 @@
 		printk(KERN_INFO "md: stopping all md devices.\n");
 
 		ITERATE_MDDEV(mddev,tmp)
-			do_md_stop (mddev, 1);
+			do_md_stop (mddev, 3);
 		/*
 		 * certain more exotic SCSI devices are known to be
 		 * volatile wrt too early system reboots. While the




*****************

Thanks
Emilio Gargiulo 
