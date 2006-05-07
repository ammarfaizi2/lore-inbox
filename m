Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWEGL3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWEGL3x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 07:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWEGL3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 07:29:53 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:46248
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932125AbWEGL3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 07:29:44 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 13:36:05 2006
Message-Id: <20060507113604.778384000@pc1>
References: <20060507113513.418451000@pc1>
Date: Sun, 07 May 2006 13:35:15 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: [patch 2/6] New Generic HW RNG
Content-Disposition: inline; filename=add-hw-random-core.patch
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new generic H/W RNG core.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/Kconfig
===================================================================
--- hwrng.orig/drivers/char/Kconfig	2006-05-07 01:35:45.000000000 +0200
+++ hwrng/drivers/char/Kconfig	2006-05-07 01:36:15.000000000 +0200
@@ -670,6 +670,8 @@
 
 	  If you're not sure, say N.
 
+source "drivers/char/hw_random/Kconfig"
+
 config NVRAM
 	tristate "/dev/nvram support"
 	depends on ATARI || X86 || ARM || GENERIC_NVRAM
Index: hwrng/drivers/char/Makefile
===================================================================
--- hwrng.orig/drivers/char/Makefile	2006-05-07 01:35:45.000000000 +0200
+++ hwrng/drivers/char/Makefile	2006-05-07 01:36:15.000000000 +0200
@@ -75,6 +75,7 @@
 obj-$(CONFIG_TOSHIBA)		+= toshiba.o
 obj-$(CONFIG_I8K)		+= i8k.o
 obj-$(CONFIG_DS1620)		+= ds1620.o
+obj-$(CONFIG_HW_RANDOM)		+= hw_random/
 obj-$(CONFIG_FTAPE)		+= ftape/
 obj-$(CONFIG_COBALT_LCD)	+= lcd.o
 obj-$(CONFIG_PPDEV)		+= ppdev.o
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-07 01:40:45.000000000 +0200
@@ -0,0 +1,11 @@
+#
+# Hardware Random Number Generator (RNG) configuration
+#
+
+config HW_RANDOM
+	bool "Hardware Random Number Generator Core support"
+	default y
+	---help---
+	  Hardware Random Number Generator Core infrastructure.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-07 01:41:11.000000000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for HW Random Number Generator (RNG) device drivers.
+#
+
+obj-$(CONFIG_HW_RANDOM) += core.o
Index: hwrng/drivers/char/hw_random/core.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/core.c	2006-05-07 01:04:42.000000000 +0200
@@ -0,0 +1,324 @@
+/*
+        Added support for the AMD Geode LX RNG
+	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
+
+	derived from
+
+ 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
+	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
+
+ 	derived from
+
+        Hardware driver for the AMD 768 Random Number Generator (RNG)
+        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+
+ 	derived from
+
+	Hardware driver for Intel i810 Random Number Generator (RNG)
+	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+
+	Added generic RNG API
+	Copyright 2006 Michael Buesch <mbuesch@freenet.de>
+	Copyright 2005 (c) MontaVista Software, Inc.
+
+	Please read Documentation/hw_random.txt for details on use.
+
+	----------------------------------------------------------
+	This software may be used and distributed according to the terms
+        of the GNU General Public License, incorporated herein by reference.
+
+ */
+
+
+#include <linux/device.h>
+#include <linux/hw_random.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+
+
+#define RNG_MODULE_NAME		"hw_random"
+#define PFX RNG_MODULE_NAME	": "
+#define RNG_MISCDEV_MINOR		183 /* official */
+
+
+static struct hwrng *current_rng;
+static LIST_HEAD(rng_list);
+static DEFINE_MUTEX(rng_mutex);
+
+
+static int rng_dev_open(struct inode *inode, struct file *filp)
+{
+	/* enforce read-only access to this chrdev */
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+	return 0;
+}
+
+static ssize_t rng_dev_read(struct file *filp, char __user *buf,
+			    size_t size, loff_t *offp)
+{
+	unsigned int have_data;
+	u32 data = 0;
+	ssize_t ret = 0;
+	int i, err;
+
+	while (size) {
+		err = mutex_lock_interruptible(&rng_mutex);
+		if (err)
+			return err;
+		if (!current_rng) {
+			mutex_unlock(&rng_mutex);
+			return -ENODEV;
+		}
+		have_data = 0;
+		if (current_rng->data_present == NULL ||
+		    current_rng->data_present(current_rng))
+			have_data = current_rng->data_read(current_rng, &data);
+		mutex_unlock(&rng_mutex);
+
+		while (have_data && size) {
+			if (put_user((u8)data, buf++)) {
+				ret = ret ? : -EFAULT;
+				break;
+			}
+			size--;
+			ret++;
+			have_data--;
+			data>>=8;
+		}
+
+		if (filp->f_flags & O_NONBLOCK)
+			return ret ? : -EAGAIN;
+
+		if (need_resched()) {
+			schedule_timeout_interruptible(1);
+		} else {
+			err = mutex_lock_interruptible(&rng_mutex);
+			if (err)
+				return err;
+			if (!current_rng) {
+				mutex_unlock(&rng_mutex);
+				return -ENODEV;
+			}
+			for (i = 0; i < 20; i++) {
+				if (current_rng->data_present == NULL ||
+				    current_rng->data_present(current_rng))
+					break;
+				udelay(10);
+			}
+			mutex_unlock(&rng_mutex);
+		}
+
+		if (signal_pending(current))
+			return ret ? : -ERESTARTSYS;
+	}
+	return ret;
+}
+
+
+static struct file_operations rng_chrdev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.read		= rng_dev_read,
+};
+
+static struct miscdevice rng_miscdev = {
+	.minor		= RNG_MISCDEV_MINOR,
+	.name		= RNG_MODULE_NAME,
+	.fops		= &rng_chrdev_ops,
+};
+
+
+static ssize_t hwrng_attr_current_store(struct class_device *class,
+					const char *buf, size_t len)
+{
+	int err;
+	struct hwrng *rng;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	err = -ENODEV;
+	list_for_each_entry(rng, &rng_list, list) {
+		if (strncmp(rng->name, buf, len) == 0) {
+			if (rng->init) {
+				err = rng->init(rng);
+				if (err)
+					break;
+			}
+			if (current_rng && current_rng->cleanup)
+				current_rng->cleanup(current_rng);
+			current_rng = rng;
+			err = 0;
+			break;
+		}
+	}
+	mutex_unlock(&rng_mutex);
+
+	return err ? : len;
+}
+
+static ssize_t hwrng_attr_current_show(struct class_device *class,
+				       char *buf)
+{
+	int err;
+	ssize_t ret;
+	const char *name = "none";
+
+	err = mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	if (current_rng)
+		name = current_rng->name;
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
+	mutex_unlock(&rng_mutex);
+
+	return ret;
+}
+
+static ssize_t hwrng_attr_available_show(struct class_device *class,
+					 char *buf)
+{
+	int err;
+	ssize_t ret = 0;
+	struct hwrng *rng;
+
+	err = mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	buf[0] = '\0';
+	list_for_each_entry(rng, &rng_list, list) {
+		strncat(buf, rng->name, PAGE_SIZE - ret - 1);
+		ret += strlen(rng->name);
+		strncat(buf, " ", PAGE_SIZE - ret - 1);
+		ret++;
+	}
+	strncat(buf, "\n", PAGE_SIZE - ret - 1);
+	ret++;
+	mutex_unlock(&rng_mutex);
+
+	return ret;
+}
+
+static CLASS_DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
+			 hwrng_attr_current_show,
+			 hwrng_attr_current_store);
+static CLASS_DEVICE_ATTR(rng_available, S_IRUGO,
+			 hwrng_attr_available_show,
+			 NULL);
+
+
+static void unregister_miscdev(void)
+{
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_available);
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+	misc_deregister(&rng_miscdev);
+}
+
+static int register_miscdev(void)
+{
+	int err;
+
+	err = misc_register(&rng_miscdev);
+	if (err)
+		goto out;
+	err = class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_current);
+	if (err)
+		goto err_misc_dereg;
+	err = class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_available);
+	if (err)
+		goto err_remove_current;
+out:
+	return err;
+
+err_remove_current:
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+err_misc_dereg:
+	misc_deregister(&rng_miscdev);
+	goto out;
+}
+
+int hwrng_register(struct hwrng *rng)
+{
+	int must_register_misc;
+	int err;
+	struct hwrng *old_current;
+
+	if (rng->name == NULL)
+		return -EINVAL;
+	if (rng->data_read == NULL)
+		return -EINVAL;
+
+	mutex_lock(&rng_mutex);
+
+	must_register_misc = (current_rng == NULL);
+	old_current = current_rng;
+	if (!current_rng) {
+		if (rng->init) {
+			err = rng->init(rng);
+			if (err) {
+				mutex_unlock(&rng_mutex);
+				return err;
+			}
+		}
+		current_rng = rng;
+	}
+	INIT_LIST_HEAD(&rng->list);
+	list_add_tail(&rng->list, &rng_list);
+	err = 0;
+	if (must_register_misc) {
+		err = register_miscdev();
+		if (err) {
+			if (rng->cleanup)
+				rng->cleanup(rng);
+			list_del(&rng->list);
+			current_rng = old_current;
+		}
+	}
+
+	mutex_unlock(&rng_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(hwrng_register);
+
+void hwrng_unregister(struct hwrng *rng)
+{
+	mutex_lock(&rng_mutex);
+
+	list_del(&rng->list);
+	if (current_rng == rng) {
+		if (rng->cleanup)
+			rng->cleanup(rng);
+		if (list_empty(&rng_list))
+			current_rng = NULL;
+		else
+			current_rng = list_entry(rng_list.prev, struct hwrng, list);
+	}
+	if (list_empty(&rng_list))
+		unregister_miscdev();
+
+	mutex_unlock(&rng_mutex);
+}
+EXPORT_SYMBOL_GPL(hwrng_unregister);
+
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");

--

