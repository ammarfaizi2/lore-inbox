Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUGGIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUGGIYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUGGIYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:24:47 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48046 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264965AbUGGIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:24:42 -0400
Date: Wed, 07 Jul 2004 17:26:00 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4][Diskdump]Update patches
To: linux-kernel@vger.kernel.org
Message-id: <EC463FC08D159indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I release new diskdump patches.

- Support sysfs interface instead of proc
- Fix some bugs

Source code can be downloaded from
 http://sourceforge.net/projects/lkdump


The main change from previous version is replacing proc interface with
sysfs.
If you want to add a new dump device /dev/sda3, 

  # echo 3 > /sys/block/sda/device/dump

Like this, you need write the partition number into the appropriate
sysfs entry. You can also do the same thing using diskdumpctl command, 
which is included in the diskdumputils.

  # diskdumpctl /dev/sda3

If you want to remove the dump device /dev/sda3, 

  # echo -3 > /sys/block/sda/device/dump

or

  # diskdumpctl -u /dev/sda1

Here is a part of patch of sysfs interface.
I added a new attribute "dump" to the /sys/block/sdX/device. The handler
of show/store operation calls a function which is registered via
sdev_dump_handler_register(). When the scsi_dump module is installed,
sysfs handler of scsi_dump is registered using 
sdev_dump_handler_register().

Please feel free to comment!


diff -Nur linux-2.6.7.org/drivers/scsi/scsi_sysfs.c linux-2.6.7/drivers/scsi/scsi_sysfs.c
--- linux-2.6.7.org/drivers/scsi/scsi_sysfs.c	2004-06-22 10:27:50.000000000 +0900
+++ linux-2.6.7/drivers/scsi/scsi_sysfs.c	2004-07-07 17:01:26.146353152 +0900
@@ -375,6 +375,66 @@
 
 DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
 
+static DECLARE_MUTEX(sdev_dump_mutex);
+
+static struct device_attribute sdev_dump_attr = {
+	.show  = NULL,
+	.store = NULL,
+};
+
+int sdev_dump_handler_register(struct device_attribute* attr)
+{
+	if (sdev_dump_attr.show || sdev_dump_attr.store)
+		return -EEXIST;
+
+	down(&sdev_dump_mutex);
+	sdev_dump_attr = *attr;
+	up(&sdev_dump_mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(sdev_dump_handler_register);
+
+void sdev_dump_handler_unregister(void)
+{
+	down(&sdev_dump_mutex);
+	sdev_dump_attr.show  = NULL;
+	sdev_dump_attr.store = NULL;
+	up(&sdev_dump_mutex);
+}
+
+EXPORT_SYMBOL(sdev_dump_handler_unregister);
+
+static ssize_t
+sdev_store_dump(struct device *dev, const char *buf, size_t count)
+{
+	ssize_t ret = count;
+
+	down(&sdev_dump_mutex);
+	if (sdev_dump_attr.store)
+		ret = sdev_dump_attr.store(dev, buf, count);
+	up(&sdev_dump_mutex);
+
+	return ret;
+}
+
+static ssize_t
+sdev_show_dump(struct device *dev, char *buf)
+{
+	ssize_t ret;
+
+	down(&sdev_dump_mutex);
+	if (sdev_dump_attr.show)
+		ret = sdev_dump_attr.show(dev, buf);
+	else
+		ret = snprintf(buf, 20, "handler not found\n");
+	up(&sdev_dump_mutex);
+
+	return ret;
+}
+
+DEVICE_ATTR(dump, S_IRUGO | S_IWUSR, sdev_show_dump, sdev_store_dump);
 
 /* Default template for device attributes.  May NOT be modified */
 static struct device_attribute *scsi_sysfs_sdev_attrs[] = {
@@ -389,6 +449,7 @@
 	&dev_attr_delete,
 	&dev_attr_state,
 	&dev_attr_timeout,
+	&dev_attr_dump,
 	NULL
 };
 
 

Best Regards,
Takao Indoh
