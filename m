Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbVJ1Goo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVJ1Goo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVJ1GoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:44:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:23018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965120AbVJ1GbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:10 -0400
Cc: will.dyson@gmail.com
Subject: [PATCH] add sysfs support for ide tape
In-Reply-To: <1130481022955@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <11304810222258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] add sysfs support for ide tape

I was recently given an old Travan tape drive and asked to do something
useful with it.  The ide-scsi + st (+serverworks ide controller) combo
results in a hard lockup of the machine which I have not had the energy to
debug, so I turned to ide-tape (which seems to work).  The system in
question debian stable, using udev to manage /dev.

The following patch to ide-tape.c allows udev to create the cdev nodes for
my drive.

Cc: Gadi Oxman <gadio@netvision.net.il>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e801e49d1ca90da1ab0286a3688f2465cb1e45e4
tree e7983a7c7dce4213431a1b951d3d803167ed41f9
parent 271c0df6e700b3f208b1802a1e96bb9eeeaa880c
author Will Dyson <will.dyson@gmail.com> Fri, 16 Sep 2005 02:55:07 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 drivers/ide/ide-tape.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index ee38e6b..95abe98 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1013,6 +1013,8 @@ typedef struct ide_tape_obj {
 
 static DECLARE_MUTEX(idetape_ref_sem);
 
+static struct class *idetape_sysfs_class;
+
 #define to_ide_tape(obj) container_of(obj, struct ide_tape_obj, kref)
 
 #define ide_tape_g(disk) \
@@ -4704,6 +4706,10 @@ static void ide_tape_release(struct kref
 
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
+	class_device_destroy(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, tape->minor));
+	class_device_destroy(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, tape->minor + 128));
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
 	devfs_unregister_tape(g->number);
@@ -4878,6 +4884,11 @@ static int ide_tape_probe(struct device 
 
 	idetape_setup(drive, tape, minor);
 
+	class_device_create(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, minor), dev, "%s", tape->name);
+	class_device_create(idetape_sysfs_class,
+			MKDEV(IDETAPE_MAJOR, minor + 128), dev, "n%s", tape->name);
+
 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"%s/mt", drive->devfs_name);
@@ -4903,6 +4914,7 @@ MODULE_LICENSE("GPL");
 static void __exit idetape_exit (void)
 {
 	driver_unregister(&idetape_driver.gen_driver);
+	class_destroy(idetape_sysfs_class);
 	unregister_chrdev(IDETAPE_MAJOR, "ht");
 }
 
@@ -4911,11 +4923,33 @@ static void __exit idetape_exit (void)
  */
 static int idetape_init (void)
 {
+	int error = 1;
+	idetape_sysfs_class = class_create(THIS_MODULE, "ide_tape");
+	if (IS_ERR(idetape_sysfs_class)) {
+		idetape_sysfs_class = NULL;
+		printk(KERN_ERR "Unable to create sysfs class for ide tapes\n");
+		error = -EBUSY;
+		goto out;
+	}
+
 	if (register_chrdev(IDETAPE_MAJOR, "ht", &idetape_fops)) {
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");
-		return -EBUSY;
+		error = -EBUSY;
+		goto out_free_class;
 	}
-	return driver_register(&idetape_driver.gen_driver);
+
+	error = driver_register(&idetape_driver.gen_driver);
+	if (error)
+		goto out_free_driver;
+
+	return 0;
+
+out_free_driver:
+	driver_unregister(&idetape_driver.gen_driver);
+out_free_class:
+	class_destroy(idetape_sysfs_class);
+out:
+	return error;
 }
 
 module_init(idetape_init);

