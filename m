Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275261AbTHSAdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275262AbTHSAdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:33:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:22722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275261AbTHSAc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:32:57 -0400
Date: Mon, 18 Aug 2003 17:33:05 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: rml@tech9.net
Subject: [RFC] /sys/class/mem support
Message-ID: <20030819003305.GA1546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against the latest 2.6.0-test3-bk tree that adds
/sys/class/mem support for the "memory" char devices.  I know that
Robert Love was thinking of moving some of the /proc/sys/kernel/random/
files into sysfs, so this patch is needed for him to do this (Robert,
you will need to export some variables for this to work, this patch is
just a start...)

This patch is needed for a complete persistant device naming scheme
(such as udev.)

Anyway, with this patch, /sys/class/mem looks like the following:

$ tree /sys/class/mem/
/sys/class/mem/
|-- full
|   `-- dev
|-- kmem
|   `-- dev
|-- kmsg
|   `-- dev
|-- mem
|   `-- dev
|-- null
|   `-- dev
|-- port
|   `-- dev
|-- random
|   `-- dev
|-- urandom
|   `-- dev
`-- zero
    `-- dev

$ cat /sys/class/mem/*/dev
1:7
1:2
1:11
1:1
1:3
1:4
1:8
1:9
1:5


Memory devices are never unregistered from the kernel, so that is why
this patch does not have any support for this.

Comments?

thanks,

greg k-h


--- a/drivers/char/mem.c	Mon Aug 18 16:51:45 2003
+++ b/drivers/char/mem.c	Mon Aug 18 16:51:45 2003
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -649,7 +650,7 @@
 	.open		= memory_open,	/* just a selector for the real open */
 };
 
-static const struct {
+static const struct mem_dev {
 	unsigned int		minor;
 	char			*name;
 	umode_t			mode;
@@ -668,6 +669,23 @@
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
@@ -675,7 +693,20 @@
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
