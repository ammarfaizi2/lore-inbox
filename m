Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbUKQREy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUKQREy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUKQRDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:03:16 -0500
Received: from peabody.ximian.com ([130.57.169.10]:13982 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262411AbUKQRAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:00:46 -0500
Subject: [patch] inotify: make our sysfs files show up
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 17 Nov 2004 11:57:57 -0500
Message-Id: <1100710677.6280.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, John.

On top of the patch I just posted (see "[patch] add class_device to
miscdevice") this patch uses the newly attainable class_device value to
correctly add our sysfs attributes.

The problem with the current solution is that we were adding attributes
to the device.  But we did not have a device entry, only the fake
inotify entry in class/misc.  So we need to attach the attributes to the
class device and not the nonexistent physical device.

In order to attach attributes to the class_device, I needed to make the
changes I sent to Greg.  I would suggest merging that patch and this and
hopefully the miscdevice bits will find their way into mainline and we
can then drop them from inotify.

Thanks,

	Robert Love


Make our /sys/class/misc/inotify entries show up and work.

Signed-Off-By: Robert Love <rml@novell.com>

 inotify.c |   57 +++++++++++++++++++++++----------------------------------
 1 files changed, 23 insertions(+), 34 deletions(-)

diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux/drivers/char/inotify.c	2004-11-15 15:28:34.951248696 -0500
+++ linux/drivers/char/inotify.c	2004-11-16 14:42:11.929575168 -0500
@@ -80,60 +80,48 @@
 #define inotify_watch_i_list(pos) list_entry((pos), struct inotify_watch, i_list)
 #define inotify_watch_u_list(pos) list_entry((pos), struct inotify_watch, u_list)
 
-static ssize_t show_max_queued_events(struct device *dev, char *buf)
+static ssize_t show_max_queued_events(struct class_device *class, char *buf)
 {
 	sprintf(buf, "%d", sysfs_attrib_max_queued_events);
-
 	return strlen(buf) + 1;
 }
 
-static ssize_t store_max_queued_events(struct device *dev, const char *buf,
-				      size_t count)
+static ssize_t store_max_queued_events(struct class_device *class,
+				       const char *buf, size_t count)
 {
 	return 0;
 }
 
-static ssize_t show_max_user_devices(struct device *dev, char *buf)
+static ssize_t show_max_user_devices(struct class_device *class, char *buf)
 {
 	sprintf(buf, "%d", sysfs_attrib_max_user_devices);
-
 	return strlen(buf) + 1;
 }
 
-static ssize_t store_max_user_devices(struct device *dev, const char *buf,
-				      size_t count)
+static ssize_t store_max_user_devices(struct class_device *class,
+				      const char *buf, size_t count)
 {
 	return 0;
 }
 
-static ssize_t show_max_user_watches(struct device *dev, char *buf)
+static ssize_t show_max_user_watches(struct class_device *class, char *buf)
 {
 	sprintf(buf, "%d", sysfs_attrib_max_user_watches);
-
 	return strlen(buf) + 1;
 }
 
-static ssize_t store_max_user_watches(struct device *dev, const char *buf,
-				      size_t count)
+static ssize_t store_max_user_watches(struct class_device *class,
+				      const char *buf, size_t count)
 {
 	return 0;
 }
 
-
-static DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR, show_max_queued_events,
- store_max_queued_events);
-static DEVICE_ATTR(max_user_devices, S_IRUGO | S_IWUSR, show_max_user_devices,
- store_max_user_devices);
-static DEVICE_ATTR(max_user_watches, S_IRUGO | S_IWUSR, show_max_user_watches,
- store_max_user_watches);
-
-static struct device_attribute *inotify_device_attrs[] = {
-	&dev_attr_max_queued_events,
-	&dev_attr_max_user_devices,
-	&dev_attr_max_user_watches,
-	NULL
-};
-
+static CLASS_DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR,
+	show_max_queued_events, store_max_queued_events);
+static CLASS_DEVICE_ATTR(max_user_devices, S_IRUGO | S_IWUSR,
+	show_max_user_devices, store_max_user_devices);
+static CLASS_DEVICE_ATTR(max_user_watches, S_IRUGO | S_IWUSR,
+	show_max_user_watches, store_max_user_watches);
 
 /*
  * A list of these is attached to each instance of the driver
@@ -307,7 +295,8 @@
 {
 	int ret;
 
-	if (atomic_read(&dev->user->inotify_watches) >= sysfs_attrib_max_user_watches)
+	if (atomic_read(&dev->user->inotify_watches) >=
+			sysfs_attrib_max_user_watches)
 		return -ENOSPC;
 
 repeat:
@@ -968,7 +957,8 @@
 
 static int __init inotify_init(void)
 {
-	int ret,i;
+	struct class_device *class;
+	int ret;
 
 	ret = misc_register(&inotify_device);
 	if (ret)
@@ -978,11 +968,10 @@
 	sysfs_attrib_max_user_devices = 64;
 	sysfs_attrib_max_user_watches = 16384;
 
-	for (i = 0; inotify_device_attrs[i]; i++) {
-		int res;
-		res = device_create_file (inotify_device.dev, inotify_device_attrs[i]);
-		printk(KERN_INFO "Inotify sysfs create file = %d\n", res);
-	}
+	class = inotify_device.class;
+	class_device_create_file(class, &class_device_attr_max_queued_events);
+	class_device_create_file(class, &class_device_attr_max_user_devices);
+	class_device_create_file(class, &class_device_attr_max_user_watches);
 
 	atomic_set(&inotify_cookie, 0);
 
 


