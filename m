Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287880AbSAMCyS>; Sat, 12 Jan 2002 21:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAMCyJ>; Sat, 12 Jan 2002 21:54:09 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:51331
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287966AbSAMCx6>; Sat, 12 Jan 2002 21:53:58 -0500
Message-ID: <006901c19bdd$a3d9eb50$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Bristow" <paul@paulbristow.net>
Subject: [CFT][PATCH] ide-floppy cleanups/media change detection (4/5)
Date: Sat, 12 Jan 2002 19:54:38 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 follows:

diff -X dontdiff -urN linux-3/drivers/ide/ide-floppy.c
linux-4/drivers/ide/ide-floppy.c
--- linux-3/drivers/ide/ide-floppy.c Sat Jan 12 17:26:13 2002
+++ linux-4/drivers/ide/ide-floppy.c Sat Jan 12 19:00:33 2002
@@ -1647,6 +1647,27 @@
  return (0);
 }

+static int idefloppy_lockunlock(ide_drive_t *drive, int lock)
+{
+ idefloppy_pc_t *pc;
+ idefloppy_floppy_t *floppy = drive->driver_data;
+
+ /* The IOMEGA Clik! Drive doesn't support this command - no room for an
eject mechanism */
+ if (test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
+  return 0;
+ }
+
+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return 1;
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
+ idefloppy_create_prevent_cmd (pc, lock ? 1 : 0);
+ (void) idefloppy_queue_pc_tail (drive, pc);
+ kfree(pc);
+ return 0;
+}
+
 /*
  * Our special ide-floppy ioctl's.
  *
@@ -1661,28 +1682,23 @@

  switch (cmd) {
  case CDROMEJECT:
-  prevent = 0;
-  /* fall through */
- case CDROM_LOCKDOOR:
   if (drive->usage > 1)
    return -EBUSY;
-
+  (void) idefloppy_lockunlock (drive, 0);
   if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
    printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
    return (-EIO);
   }
   memset (pc, 0, sizeof (idefloppy_pc_t));
-  /* The IOMEGA Clik! Drive doesn't support this command - no room for an
eject mechanism */
-                if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   idefloppy_create_prevent_cmd (pc, prevent);
-   (void) idefloppy_queue_pc_tail (drive, pc);
-  }
-  if (cmd == CDROMEJECT) {
-   idefloppy_create_start_stop_cmd (pc, 2);
-   (void) idefloppy_queue_pc_tail (drive, pc);
-  }
+  idefloppy_create_start_stop_cmd (pc, 2);
+  (void) idefloppy_queue_pc_tail (drive, pc);
   kfree (pc);
   return 0;
+ case CDROM_LOCKDOOR:
+  if (drive->usage > 1)
+   return -EBUSY;
+  (void) idefloppy_lockunlock (drive, prevent);
+  return 0;
  case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
   return (0);
  case IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY:
@@ -1784,11 +1800,7 @@
    return -EROFS;
   }
   set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
-  /* IOMEGA Clik! drives do not support lock/unlock commands */
-                if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   idefloppy_create_prevent_cmd (pc, 1);
-   (void) idefloppy_queue_pc_tail (drive, pc);
-  }
+  (void) idefloppy_lockunlock (drive, 1);
   check_disk_change(inode->i_rdev);
   kfree (pc);
  }
@@ -1803,7 +1815,6 @@

 static void idefloppy_release (struct inode *inode, struct file *filp,
ide_drive_t *drive)
 {
- idefloppy_pc_t *pc;

 #if IDEFLOPPY_DEBUG_LOG
  printk (KERN_INFO "Reached idefloppy_release\n");
@@ -1814,17 +1825,7 @@

   invalidate_bdev (inode->i_bdev, 0);

-  /* IOMEGA Clik! drives do not support lock/unlock commands */
-                if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
-    printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
-   } else {
-    memset (pc, 0, sizeof (idefloppy_pc_t));
-    idefloppy_create_prevent_cmd (pc, 0);
-    (void) idefloppy_queue_pc_tail (drive, pc);
-    kfree (pc);
-   }
-  }
+  (void) idefloppy_lockunlock (drive, 0);

   clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
  }



