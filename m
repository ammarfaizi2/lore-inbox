Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288698AbSADRe0>; Fri, 4 Jan 2002 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288693AbSADReP>; Fri, 4 Jan 2002 12:34:15 -0500
Received: from vena.lwn.net ([206.168.112.25]:40464 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S279798AbSADReG>;
	Fri, 4 Jan 2002 12:34:06 -0500
Message-ID: <20020104173405.28147.qmail@eklektix.com>
To: torvalds@transmeta.com
Subject: [PATCH] Fix kdev_t in st.c (2.5.2-pre7)
cc: linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet-lk@lwn.net>
Date: Fri, 04 Jan 2002 10:34:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since yesterday's patch, sr and sg appear to have been fixed, but the SCSI
tape driver still has kdev_t problems.  Having fat-fingered my way into a
disk disaster yesterday, I have a real interest in a working tape drive :)
Here's a rework of my st.c kdev_t patch for 2.5.2-pre7.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

diff -r -u 2.5.2-pre6/drivers/scsi/st.c linux-2.5.2-pre6-scsi/drivers/scsi/st.c
--- 2.5.2-pre6/drivers/scsi/st.c	Thu Jan  3 11:35:26 2002
+++ linux-2.5.2-pre6-scsi/drivers/scsi/st.c	Thu Jan  3 11:38:22 2002
@@ -133,8 +133,8 @@
 #define ST_TIMEOUT (900 * HZ)
 #define ST_LONG_TIMEOUT (14000 * HZ)
 
-#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
-#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
+#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
+#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
 
 /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
    24 bits) */
@@ -878,7 +878,7 @@
 	}
 	STp->in_use = 1;
 	write_unlock_irqrestore(&st_dev_arr_lock, flags);
-	STp->rew_at_close = STp->autorew_dev = (MINOR(inode->i_rdev) & 0x80) == 0;
+	STp->rew_at_close = STp->autorew_dev = (minor(inode->i_rdev) & 0x80) == 0;
 
 	if (STp->device->host->hostt->module)
 		__MOD_INC_USE_COUNT(STp->device->host->hostt->module);
@@ -3717,7 +3717,7 @@
 		tpnt->tape_type = MT_ISSCSI2;
 
         tpnt->inited = 0;
-	tpnt->devt = MKDEV(SCSI_TAPE_MAJOR, i);
+	tpnt->devt = mk_kdev(SCSI_TAPE_MAJOR, i);
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;	/* Try buffering if no mode sense */
