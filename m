Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTLWAbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbTLWA3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:29:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:31661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264829AbTLWA3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:29:22 -0500
Date: Mon, 22 Dec 2003 16:26:09 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223002609.GC4805@kroah.com>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223002439.GB4805@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds /sys/class/mem which enables all mem char devices to show up
properly in udev.

Has been posted to linux-kernel every so often since last July, and
acked by a number of other kernel developers.


diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Mon Dec 22 16:02:08 2003
+++ b/drivers/char/mem.c	Mon Dec 22 16:02:08 2003
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -657,7 +658,7 @@
 	.open		= memory_open,	/* just a selector for the real open */
 };
 
-static const struct {
+static const struct mem_dev {
 	unsigned int		minor;
 	char			*name;
 	umode_t			mode;
@@ -676,6 +677,23 @@
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
 };
 
+static void release_mem_dev(struct class_device *class_dev)
+{
+	kfree(class_dev);
+}
+
+static struct class mem_class = {
+	.name		= "mem",
+	.release	= &release_mem_dev,
+};
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct mem_dev *mem_dev = class_get_devdata(class_dev);
+	return print_dev_t(buf, MKDEV(MEM_MAJOR, mem_dev->minor));
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
 static int __init chr_dev_init(void)
 {
 	int i;
@@ -683,7 +701,20 @@
 	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
+	class_register(&mem_class);
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+		struct class_device *class_dev;
+
+		class_dev = kmalloc(sizeof(*class_dev), GFP_KERNEL);
+		if (class_dev) {
+			memset(class_dev, 0x00, sizeof(*class_dev));
+			class_dev->class = &mem_class;
+			strncpy(class_dev->class_id, devlist[i].name, BUS_ID_SIZE);
+			class_set_devdata(class_dev, (void *)&devlist[i]);
+			if (!class_device_register(class_dev));
+				class_device_create_file(class_dev, &class_device_attr_dev);
+		}
+
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
