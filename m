Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVBDCyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVBDCyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVBDCvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:51:10 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:52915 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261831AbVBDCnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:43:21 -0500
Date: Fri, 4 Feb 2005 03:41:13 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/9] ide-tape: fix character device ->open() vs ->cleanup()
 race 
Message-ID: <Pine.GSO.4.58.0502040339260.2469@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar to the same race but for the block device.

* store pointer to struct ide_tape_obj in idetape_chrdevs[]
* rename idetape_chrdevs[] to idetape_devs[] and kill idetape_chrdev_t
* add ide_tape_chrdev_get() for getting reference to the tape
* store tape pointer in file->private_data and fix all users of it
* fix idetape_chrdev_{open,release}() to get/put reference to the tape

diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:30:44 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:30:44 +01:00
@@ -1122,15 +1122,6 @@
 #define	IDETAPE_ERROR_EOD		103

 /*
- *	idetape_chrdev_t provides the link between out character device
- *	interface and our block device interface and the corresponding
- *	ide_drive_t structure.
- */
-typedef struct {
-	ide_drive_t *drive;
-} idetape_chrdev_t;
-
-/*
  *	The following is used to format the general configuration word of
  *	the ATAPI IDENTIFY DEVICE command.
  */
@@ -1286,7 +1277,21 @@
  *	The variables below are used for the character device interface.
  *	Additional state variables are defined in our ide_drive_t structure.
  */
-static idetape_chrdev_t idetape_chrdevs[MAX_HWIFS * MAX_DRIVES];
+static struct ide_tape_obj * idetape_devs[MAX_HWIFS * MAX_DRIVES];
+
+#define ide_tape_f(file) ((file)->private_data)
+
+static struct ide_tape_obj *ide_tape_chrdev_get(unsigned int i)
+{
+	struct ide_tape_obj *tape = NULL;
+
+	down(&idetape_ref_sem);
+	tape = idetape_devs[i];
+	if (tape)
+		kref_get(&tape->kref);
+	up(&idetape_ref_sem);
+	return tape;
+}

 /*
  *      Function declarations
@@ -3697,8 +3702,8 @@
 static ssize_t idetape_chrdev_read (struct file *file, char __user *buf,
 				    size_t count, loff_t *ppos)
 {
-	ide_drive_t *drive = file->private_data;
-	idetape_tape_t *tape = drive->driver_data;
+	struct ide_tape_obj *tape = ide_tape_f(file);
+	ide_drive_t *drive = tape->drive;
 	ssize_t bytes_read,temp, actually_read = 0, rc;

 #if IDETAPE_DEBUG_LOG
@@ -3756,8 +3761,8 @@
 static ssize_t idetape_chrdev_write (struct file *file, const char __user *buf,
 				     size_t count, loff_t *ppos)
 {
-	ide_drive_t *drive = file->private_data;
-	idetape_tape_t *tape = drive->driver_data;
+	struct ide_tape_obj *tape = ide_tape_f(file);
+	ide_drive_t *drive = tape->drive;
 	ssize_t retval, actually_written = 0;

 	/* The drive is write protected. */
@@ -4059,8 +4064,8 @@
  */
 static int idetape_chrdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	ide_drive_t *drive = file->private_data;
-	idetape_tape_t *tape = drive->driver_data;
+	struct ide_tape_obj *tape = ide_tape_f(file);
+	ide_drive_t *drive = tape->drive;
 	struct mtop mtop;
 	struct mtget mtget;
 	struct mtpos mtpos;
@@ -4131,17 +4136,24 @@

 	if (i >= MAX_HWIFS * MAX_DRIVES)
 		return -ENXIO;
-	drive = idetape_chrdevs[i].drive;
-	tape = drive->driver_data;
-	filp->private_data = drive;

-	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))
-		return -EBUSY;
+	if (!(tape = ide_tape_chrdev_get(i)))
+		return -ENXIO;
+
+	drive = tape->drive;
+
+	filp->private_data = tape;
+
+	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags)) {
+		retval = -EBUSY;
+		goto out_put_tape;
+	}
+
 	retval = idetape_wait_ready(drive, 60 * HZ);
 	if (retval) {
 		clear_bit(IDETAPE_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
-		return retval;
+		goto out_put_tape;
 	}

 	idetape_read_position(drive);
@@ -4165,7 +4177,8 @@
 		if ((filp->f_flags & O_ACCMODE) == O_WRONLY ||
 		    (filp->f_flags & O_ACCMODE) == O_RDWR) {
 			clear_bit(IDETAPE_BUSY, &tape->flags);
-			return -EROFS;
+			retval = -EROFS;
+			goto out_put_tape;
 		}
 	}

@@ -4183,6 +4196,10 @@
 	idetape_restart_speed_control(drive);
 	tape->restart_speed_control_req = 0;
 	return 0;
+
+out_put_tape:
+	ide_tape_put(tape);
+	return retval;
 }

 static void idetape_write_release (ide_drive_t *drive, unsigned int minor)
@@ -4206,8 +4223,8 @@
  */
 static int idetape_chrdev_release (struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = filp->private_data;
-	idetape_tape_t *tape;
+	struct ide_tape_obj *tape = ide_tape_f(filp);
+	ide_drive_t *drive = tape->drive;
 	idetape_pc_t pc;
 	unsigned int minor = iminor(inode);

@@ -4241,6 +4258,7 @@
 		}
 	}
 	clear_bit(IDETAPE_BUSY, &tape->flags);
+	ide_tape_put(tape);
 	unlock_kernel();
 	return 0;
 }
@@ -4649,7 +4667,6 @@
 static int idetape_cleanup (ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int minor = tape->minor;
 	unsigned long flags;

 	spin_lock_irqsave(&ide_lock, flags);
@@ -4658,7 +4675,7 @@
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
 	}
-	idetape_chrdevs[minor].drive = NULL;
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);
@@ -4678,6 +4695,7 @@
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
 	devfs_unregister_tape(g->number);
+	idetape_devs[tape->minor] = NULL;
 	g->private_data = NULL;
 	g->fops = ide_fops;
 	kfree(tape);
@@ -4825,8 +4843,6 @@
 		kfree(tape);
 		goto failed;
 	}
-	for (minor = 0; idetape_chrdevs[minor].drive != NULL; minor++)
-		;

 	memset(tape, 0, sizeof(*tape));

@@ -4836,8 +4852,13 @@

 	drive->driver_data = tape;

+	down(&idetape_ref_sem);
+	for (minor = 0; idetape_devs[minor]; minor++)
+		;
+	idetape_devs[minor] = tape;
+	up(&idetape_ref_sem);
+
 	idetape_setup(drive, tape, minor);
-	idetape_chrdevs[minor].drive = drive;

 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
 			S_IFCHR | S_IRUGO | S_IWUGO,
