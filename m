Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263862AbUDVWbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUDVWbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUDVWbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:31:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:7856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263862AbUDVWbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:31:02 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core fixes for 2.6.6-rc2
In-Reply-To: <20040422222853.GA2932@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 22 Apr 2004 15:30:48 -0700
Message-Id: <10826730482684@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1927, 2004/04/22 12:19:51-07:00, mebrown@michaels-house.net

[PATCH] sysfs module unload race fix for bin_attributes

 -  Add module locking to sysfs bin_attribute files. Update all in-tree
    users to set module owner.

	Compile tested. booted. stress tests pass:

while true; do modprobe mymod; rmmod mymod; done &
while true; do hexdump -C /sys/path/to/sysfs/binary/file; done


 drivers/base/firmware_class.c |    2 +-
 drivers/i2c/chips/eeprom.c    |    1 +
 drivers/scsi/qla2xxx/qla_os.c |    2 ++
 fs/sysfs/bin.c                |   16 +++++++++++++---
 4 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Thu Apr 22 15:27:17 2004
+++ b/drivers/base/firmware_class.c	Thu Apr 22 15:27:17 2004
@@ -254,7 +254,7 @@
 	return retval;
 }
 static struct bin_attribute firmware_attr_data_tmpl = {
-	.attr = {.name = "data", .mode = 0644},
+	.attr = {.name = "data", .mode = 0644, .owner = THIS_MODULE},
 	.size = 0,
 	.read = firmware_data_read,
 	.write = firmware_data_write,
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Thu Apr 22 15:27:17 2004
+++ b/drivers/i2c/chips/eeprom.c	Thu Apr 22 15:27:17 2004
@@ -155,6 +155,7 @@
 	.attr = {
 		.name = "eeprom",
 		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
 	},
 	.size = EEPROM_SIZE,
 	.read = eeprom_read,
diff -Nru a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c	Thu Apr 22 15:27:17 2004
+++ b/drivers/scsi/qla2xxx/qla_os.c	Thu Apr 22 15:27:17 2004
@@ -402,6 +402,7 @@
 	.attr = {
 		.name = "fw_dump",
 		.mode = S_IRUSR | S_IWUSR,
+		.owner = THIS_MODULE,
 	},
 	.size = 0,
 	.read = qla2x00_sysfs_read_fw_dump,
@@ -415,6 +416,7 @@
 	.attr = {
 		.name = "nvram",
 		.mode = S_IRUSR | S_IWUSR,
+		.owner = THIS_MODULE,
 	},
 	.size = sizeof(nvram_t),
 	.read = qla2x00_sysfs_read_nvram,
diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	Thu Apr 22 15:27:17 2004
+++ b/fs/sysfs/bin.c	Thu Apr 22 15:27:17 2004
@@ -101,19 +101,27 @@
 	if (!kobj || !attr)
 		goto Done;
 
+	/* Grab the module reference for this attribute if we have one */
+	error = -ENODEV;
+	if (!try_module_get(attr->attr.owner)) 
+		goto Done;
+
 	error = -EACCES;
 	if ((file->f_mode & FMODE_WRITE) && !attr->write)
-		goto Done;
+		goto Error;
 	if ((file->f_mode & FMODE_READ) && !attr->read)
-		goto Done;
+		goto Error;
 
 	error = -ENOMEM;
 	file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!file->private_data)
-		goto Done;
+		goto Error;
 
 	error = 0;
+    goto Done;
 
+ Error:
+	module_put(attr->attr.owner);
  Done:
 	if (error && kobj)
 		kobject_put(kobj);
@@ -123,10 +131,12 @@
 static int release(struct inode * inode, struct file * file)
 {
 	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct bin_attribute * attr = file->f_dentry->d_fsdata;
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
 		kobject_put(kobj);
+	module_put(attr->attr.owner);
 	kfree(buffer);
 	return 0;
 }

