Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUGQXab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUGQXab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUGQWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:43:22 -0400
Received: from digitalimplant.org ([64.62.235.95]:50921 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262772AbUGQWgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:00 -0400
Date: Sat, 17 Jul 2004 15:35:49 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [18/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171531340.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1860, 2004/07/17 13:16:31-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge pmdisk and swsusp read wrappers.

- Merge pmdisk_read() and __read_suspend_image() and rename to swsusp_read()
- Fix up call in kernel/power/disk.c to call new name.
- Remove extra error checking from software_resume().


 kernel/power/disk.c   |    4 ++--
 kernel/power/pmdisk.c |   43 -------------------------------------------
 kernel/power/swsusp.c |   33 +++++++++++++++++++--------------
 3 files changed, 21 insertions(+), 59 deletions(-)


diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:50:49 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:50:49 -07:00
@@ -25,7 +25,7 @@

 extern int swsusp_suspend(void);
 extern int pmdisk_write(void);
-extern int pmdisk_read(void);
+extern int swsusp_read(void);
 extern int swsusp_resume(void);
 extern int pmdisk_free(void);

@@ -205,7 +205,7 @@

 	pr_debug("PM: Reading pmdisk image.\n");

-	if ((error = pmdisk_read()))
+	if ((error = swsusp_read()))
 		goto Done;

 	pr_debug("PM: Preparing system for restore.\n");
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:49 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:49 -07:00
@@ -35,9 +35,6 @@

 /* For resume= kernel option */
 static char resume_file[256] = CONFIG_PM_DISK_PARTITION;
-
-static dev_t resume_device;
-
 extern suspend_pagedir_t *pagedir_save;

 /*
@@ -73,14 +70,6 @@
 }


-/* More restore stuff */
-
-extern struct block_device * resume_bdev;
-
-extern dev_t __init name_to_dev_t(const char *line);
-
-
-
 /**
  *	pmdisk_write - Write saved memory image to swap.
  *
@@ -95,38 +84,6 @@
 {
 	return suspend_save_image();
 }
-
-
-/**
- *	pmdisk_read - Read saved image from swap.
- */
-
-int __init pmdisk_read(void)
-{
-	extern int read_suspend_image(void);
-	int error;
-
-	if (!strlen(resume_file))
-		return -ENOENT;
-
-	resume_device = name_to_dev_t(resume_file);
-	pr_debug("pmdisk: Resume From Partition: %s\n", resume_file);
-
-	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
-	if (!IS_ERR(resume_bdev)) {
-		set_blocksize(resume_bdev, PAGE_SIZE);
-		error = read_suspend_image();
-		blkdev_put(resume_bdev);
-	} else
-		error = PTR_ERR(resume_bdev);
-
-	if (!error)
-		pr_debug("Reading resume file was successful\n");
-	else
-		pr_debug("pmdisk: Error %d resuming\n", error);
-	return error;
-}
-

 /**
  *	pmdisk_free - Free memory allocated to hold snapshot.
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:49 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:49 -07:00
@@ -1145,7 +1145,7 @@
 }


-struct block_device * resume_bdev;
+static struct block_device * resume_bdev;

 /**
  *	submit - submit BIO request.
@@ -1331,7 +1331,7 @@
 	return error;
 }

-int __init read_suspend_image(void)
+static int __init read_suspend_image(void)
 {
 	int error = 0;

@@ -1345,13 +1345,20 @@
 	return error;
 }

-static int __init __read_suspend_image(const char * specialfile)
+/**
+ *	pmdisk_read - Read saved image from swap.
+ */
+
+int __init swsusp_read(void)
 {
 	int error;
-	char b[BDEVNAME_SIZE];

-	resume_device = name_to_dev_t(specialfile);
-	printk("Resuming from device %s\n", __bdevname(resume_device, b));
+	if (!strlen(resume_file))
+		return -ENOENT;
+
+	resume_device = name_to_dev_t(resume_file);
+	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
+
 	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
@@ -1359,7 +1366,11 @@
 		blkdev_put(resume_bdev);
 	} else
 		error = PTR_ERR(resume_bdev);
-	MDELAY(1000);
+
+	if (!error)
+		pr_debug("Reading resume file was successful\n");
+	else
+		pr_debug("pmdisk: Error %d resuming\n", error);
 	return error;
 }

@@ -1398,13 +1409,7 @@
 	if (pm_prepare_console())
 		printk("swsusp: Can't allocate a console... proceeding\n");

-	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
-		printk( "suspension device unspecified\n" );
-		return -EINVAL;
-	}
-
-	printk( "resuming from %s\n", resume_file);
-	if (__read_suspend_image(resume_file))
+	if (swsusp_read())
 		goto read_failure;
 	/* FIXME: Should we stop processes here, just to be safer? */
 	disable_nonboot_cpus();
