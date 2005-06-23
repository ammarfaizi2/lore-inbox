Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVFWMWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVFWMWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVFWMV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:21:56 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:27329 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262337AbVFWMS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:18:59 -0400
Subject: [RFC] SPI core -- revisited
From: dmitry pervushin <dpervushin@gmail.com>
Reply-To: dpervushin@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:18:54 +0400
Message-Id: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

we finally decided to rework the SPI core and now it its ready for your comments.. 
Here we have several boards equipped with SPI bus, and use this spi core with these boards; 
Drivers for them are available by request (...and if community approve this patch)

Signed-off-by: dmitry pervushin <dpervushin@gmail.com>

 drivers/Kconfig         |    2
 drivers/Makefile        |    1
 drivers/spi/Kconfig     |   31 ++++
 drivers/spi/Makefile    |    9 +
 drivers/spi/helpers.c   |   45 ++++++
 drivers/spi/spi-core.c  |  244 ++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dev.c   |  337 ++++++++++++++++++++++++++++++++++++++++++++++++ 
 drivers/spi/spi.h       |   35 ++++
 include/linux/spi/spi.h |  205 +++++++++++++++++++++++++++++
 9 files changed, 909 insertions(+)

diff -uNr -X dontdiff linux-2.6.12/drivers/Kconfig linux/drivers/Kconfig
--- linux-2.6.12/drivers/Kconfig	2005-06-23 13:14:18.000000000 +0400
+++ linux/drivers/Kconfig	2005-06-23 15:38:08.633516840 +0400
@@ -42,6 +42,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/misc/Kconfig"
diff -uNr -X dontdiff linux-2.6.12/drivers/Makefile linux/drivers/Makefile
--- linux-2.6.12/drivers/Makefile	2005-06-23 13:14:18.000000000 +0400
+++ linux/drivers/Makefile	2005-06-23 15:36:55.733688821 +0400
@@ -64,3 +64,4 @@
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_SPI)               += spi/
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/helpers.c linux/drivers/spi/helpers.c
--- linux-2.6.12/drivers/spi/helpers.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/helpers.c	2005-06-23 13:28:23.000000000 +0400
@@ -0,0 +1,45 @@
+/*
+ * drivers/spi/helper.c
+ *
+ * Helper functions.
+ *
+ * Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+typedef struct {
+	int (*callback) (struct device * dev, void *data);
+	struct device_driver *drv;
+	void *data;
+} _find_t;
+
+static int dfed_callback(struct device *device, void *data)
+{
+	_find_t *local_data = (_find_t *) data;
+
+	return (device->driver != local_data->drv) ? 0 : 
+	        (*local_data->callback) (device, local_data->data);
+}
+
+int driver_for_each_dev(struct device_driver *drv, void *data,
+			int (*callback) (struct device * dev, void *data))
+{
+	_find_t local_data;
+
+	local_data.drv = drv;
+	local_data.data = data;
+	local_data.callback = callback;
+	return bus_for_each_dev(drv->bus, NULL, &local_data, dfed_callback);
+}
+
+EXPORT_SYMBOL(driver_for_each_dev);
+
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/Kconfig linux/drivers/spi/Kconfig
--- linux-2.6.12/drivers/spi/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/Kconfig	2005-06-23 15:42:34.318785056 +0400
@@ -0,0 +1,31 @@
+#
+# SPI device configuration
+#
+menu "SPI support"
+
+config SPI
+	tristate "SPI support"
+        default false
+	help
+	  Say Y if you need to enable SPI support on your kernel
+
+config SPI_DEBUG
+	bool "SPI debug output" 
+	depends on SPI 
+	default false 
+	help 
+          Say Y there if you'd like to see debug output from SPI drivers.
+	  If unsure, say N
+	
+config SPI_CHARDEV
+	tristate "SPI device interface"
+	depends on SPI
+	help
+	  Say Y here to use spi-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the SPI bus. 
+	  This support is also available as a module.  If so, the module 
+	  will be called spi-dev.
+
+endmenu
+
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/Makefile linux/drivers/spi/Makefile
--- linux-2.6.12/drivers/spi/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/Makefile	2005-06-23 15:10:08.000000000 +0400
@@ -0,0 +1,9 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+# Init order: core, chardev, bit adapters, pcf adapters
+
+obj-$(CONFIG_SPI) += spi-core.o helpers.o
+obj-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/spi-core.c linux/drivers/spi/spi-core.c
--- linux-2.6.12/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/spi-core.c	2005-06-23 13:25:51.000000000 +0400
@@ -0,0 +1,244 @@
+/*
+ *  linux/drivers/spi/spi-core.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *  Copyright (C) 2002 Compaq Computer Corporation
+ *
+ *  Adapted from l3-core.c by Jamey Hicks <jamey.hicks@compaq.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+
+#ifdef CONFIG_SPI_DEBUG
+#define DEBUG
+#endif				/* CONFIG_SPI_DEBUG */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/proc_fs.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+
+#include <linux/spi/spi.h>
+
+#include "spi.h"
+
+static int spi_match(struct device *dev, struct device_driver *driver)
+{
+	struct spi_driver *spidrv = SPI_DRV(driver);
+	struct spi_adapter *spidev = SPI_ADAP(dev);
+	char **id;
+	int found = 0;
+
+	if (NULL == dev || NULL == driver) {
+		printk(KERN_ERR
+		       "%s: error - both dev and driver should not be NULL !\n",
+		       __FUNCTION__);
+		found = 0;
+		goto spi_match_done;
+	}
+	if (NULL == spidev->name) {
+		printk("%s: device has no name, so it cannot be attached\n",
+		       __FUNCTION__);
+		found = 0;
+		goto spi_match_done;
+	}
+
+	if (NULL == spidrv->supported_ids) {
+		printk
+		    ("%s: driver has no ids of devices to support, assuming ALL\n",
+		     __FUNCTION__);
+		found = 1;
+		goto spi_match_done;
+	}
+
+	id = *spidrv->supported_ids;
+	while (*id) {
+		pr_debug
+		    ("Verifying driver's supported id of '%s' against '%s'\n",
+		     *id, spidev->name);
+		if (0 == strncmp(*id, SPI_ID_ANY, strlen(SPI_ID_ANY))) {
+			pr_debug
+			    ("The driver (%p) can be attached to any device (%p)\n",
+			     driver, dev);
+			found = 1;
+			goto spi_match_done;
+		}
+		if (0 == strcmp(*id, spidev->name)) {
+			pr_debug("Done, driver (%p) match the device '%p'\n",
+				 driver, dev);
+			found = 1;
+			goto spi_match_done;
+		}
+		++id;
+	}
+
+	pr_debug("%s: no match\n ", __FUNCTION__);
+	found = 0;
+spi_match_done:	
+	return found;
+}
+
+/**
+ * spi_add_adapter - register a new SPI bus adapter
+ * @adap: spi_adapter structure for the registering adapter
+ *
+ * Make the adapter available for use by clients using name adap->name.
+ * The adap->adapters list is initialised by this function.
+ *
+ * Returns error code ( 0 on success ) ;
+ */
+
+int spi_add_adapter(struct spi_adapter *adap)
+{
+	int err;
+
+	memset(&adap->dev, 0, sizeof(adap->dev));
+
+	adap->dev.parent = NULL;
+	strncpy(adap->dev.bus_id, adap->name, sizeof(adap->dev.bus_id) - 1);
+	adap->dev.bus = &spi_bus_type;
+	sema_init(&adap->lock, 1);
+
+	err = device_register(&adap->dev);
+	pr_debug("device_register (%p) status = %d\n", &adap->dev, err);
+	return err;
+}
+
+/**
+ * spi_del_adapter - unregister a SPI bus adapter
+ * @adap: spi_adapter structure to unregister
+ *
+ * Remove an adapter from the list of available SPI Bus adapters.
+ *
+ * Returns error code (0 on success);
+ */
+
+void spi_del_adapter(struct spi_adapter *adap)
+{
+	device_unregister(&adap->dev);
+}
+
+/**
+ * spi_transfer - transfer information on an SPI bus
+ * @adap: adapter structure to perform transfer on
+ * @msgs: array of spi_msg structures describing transfer
+ * @num: number of spi_msg structures
+ *
+ * Transfer the specified messages to/from a device on the SPI bus.
+ *
+ * Returns number of messages successfully transferred, otherwise negative
+ * error code.
+ */
+int spi_transfer(struct spi_adapter *adap, struct spi_msg msgs[], int num)
+{
+	int ret = -ENOSYS;
+
+	if (adap->algo->xfer) {
+		down(&adap->lock);
+		if (adap->select) {
+			adap->select(adap, 1);
+		}
+		ret = adap->algo->xfer(adap, msgs, num);
+		if (adap->select) {
+			adap->select(adap, 0);
+		}
+		up(&adap->lock);
+	}
+	return ret;
+}
+
+/**
+ * spi_write - send data to a device on an SPI bus
+ * @client: registered client structure
+ * @addr: SPI bus address
+ * @buf: buffer for bytes to send
+ * @len: number of bytes to send
+ *
+ * Send len bytes pointed to by buf to device address addr on the SPI bus
+ * described by client.
+ *
+ * Returns the number of bytes transferred, or negative error code.
+ */
+int spi_write(struct spi_adapter *adap, int addr, const char *buf, int len)
+{
+	struct spi_msg msg;
+	int ret;
+
+	msg.addr = addr;
+	msg.flags = 0;
+	msg.buf = (char *)buf;
+	msg.len = len;
+
+	ret = spi_transfer(adap, &msg, 1);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_read - receive data from a device on an SPI bus
+ * @client: registered client structure
+ * @addr: SPI bus address
+ * @buf: buffer for bytes to receive
+ * @len: number of bytes to receive
+ *
+ * Receive len bytes from device address addr on the SPI bus described by
+ * client to a buffer pointed to by buf.
+ *
+ * Returns the number of bytes transferred, or negative error code.
+ */
+int spi_read(struct spi_adapter *adap, int addr, char *buf, int len)
+{
+	struct spi_msg msg;
+	int ret;
+
+	msg.addr = addr;
+	msg.flags = SPI_M_RD;
+	msg.buf = buf;
+	msg.len = len;
+
+	ret = spi_transfer(adap, &msg, 1);
+	return ret == 1 ? len : ret;
+}
+
+/*
+ * Bus declaration, init/exit functions 
+ */
+struct bus_type spi_bus_type = {
+	.name = "spi",
+	.match = spi_match,
+};
+
+int __init spibus_init(void)
+{
+	int status;
+
+	status = bus_register(&spi_bus_type);
+	pr_debug("SPI: bus_register status = %d\n", status);
+	printk("SPI bus driver loaded.\n");
+	return status;
+}
+
+void __exit spibus_exit(void)
+{
+	bus_unregister(&spi_bus_type);
+	pr_debug("SPI: leaving\n");
+}
+
+subsys_initcall(spibus_init);
+module_exit(spibus_exit);
+
+MODULE_LICENSE( "GPL" );
+MODULE_AUTHOR( "dmitry pervushin <dpervushin@ru.mvista.com>" );
+
+EXPORT_SYMBOL_GPL(spi_add_adapter);
+EXPORT_SYMBOL_GPL(spi_del_adapter);
+EXPORT_SYMBOL_GPL(spi_transfer);
+EXPORT_SYMBOL_GPL(spi_write);
+EXPORT_SYMBOL_GPL(spi_read);
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/spi-dev.c linux/drivers/spi/spi-dev.c
--- linux-2.6.12/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/spi-dev.c	2005-06-23 15:28:32.000000000 +0400
@@ -0,0 +1,337 @@
+/*
+    spi-dev.c - spi-bus driver, char device interface  
+
+    Copyright (C) 1995-97 Simon G. Vogl
+    Copyright (C) 1998-99 Frodo Looijaard <frodol@dds.nl>
+    Copyright (C) 2002 Compaq Computer Corporation
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* Adapted from i2c-dev module by Jamey Hicks <jamey.hicks@compaq.com> */
+
+/* Note that this is a complete rewrite of Simon Vogl's i2c-dev module.
+   But I have used so much of his original code and ideas that it seems
+   only fair to recognize him as co-author -- Frodo */
+
+/* The devfs code is contributed by Philipp Matthias Hahn 
+   <pmhahn@titan.lahn.de> */
+
+/* Modifications to allow work with current spi-core by 
+   Andrey Ivolgin <aivolgin@ru.mvista.com>, Sep 2004
+ */
+
+/* devfs code corrected to support automatic device addition/deletion
+   by Vitaly Wool <vwool@ru.mvista.com> (C) 2004 MontaVista Software, Inc. 
+ */
+
+/* $Id: cee_lsp-philips-melody.patch,v 1.1.4.8 2005/02/25 10:20:15 wool Exp $ */
+
+#ifdef CONFIG_SPI_DEBUG
+#define DEBUG
+#endif				/* CONFIG_SPI_DEBUG */
+
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/smp_lock.h>
+
+#include <linux/devfs_fs_kernel.h>
+
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/spi/spi.h>
+#include "spi.h"
+
+#define SPI_TRANSFER_MAX	65535
+#define SPI_ADAP_MAX		32
+
+/* struct file_operations changed too often in the 2.1 series for nice code */
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset);
+static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
+			    loff_t * offset);
+
+static int spidev_open(struct inode *inode, struct file *file);
+static int spidev_release(struct inode *inode, struct file *file);
+static int spidev_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg);
+static int __init spi_dev_init(void);
+
+static void spidev_cleanup(void);
+
+static int spidev_probe(struct device *dev);
+static int spidev_remove(struct device *dev);
+
+static struct file_operations spidev_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = spidev_read,
+	.write = spidev_write,
+	.open = spidev_open,
+	.release = spidev_release,
+};
+
+SPI_IDS_TABLE_BEGIN
+    SPI_ID_ANY 
+SPI_IDS_TABLE_END 
+
+static struct spi_driver spidev_driver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		   .name = "generic spi",
+		   .bus = &spi_bus_type,
+		   .probe = spidev_probe,
+		   .remove = spidev_remove,
+		   },
+	.supported_ids = SPI_IDS,
+	.minor = 0,
+};
+
+static int spidev_probe(struct device *dev)
+{
+	spidev_driver_data_t *drvdata;
+	int err = 0;
+
+	if (NULL == dev) {
+		printk(KERN_ERR "%s: probing the NULL device!\n", __FUNCTION__);
+		err = -EFAULT;
+		goto probe_out;
+	}
+
+	drvdata = (spidev_driver_data_t *) kmalloc(sizeof(spidev_driver_data_t),
+						   GFP_KERNEL);
+	if (NULL == drvdata) {
+		pr_debug("%s: allocating drvdata failed\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto probe_out;
+	}
+
+	drvdata->minor = spidev_driver.minor++;
+	pr_debug("%s: setting device's(%p) minor to %d\n",
+		 __FUNCTION__, dev, drvdata->minor);
+	dev_set_drvdata(dev, drvdata);
+#ifdef CONFIG_DEVFS_FS
+	devfs_mk_cdev(MKDEV(SPI_MAJOR, drvdata->minor),
+		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", drvdata->minor);
+#endif
+	pr_debug("%s: Registered as minor %d\n", __FUNCTION__, drvdata->minor);
+probe_out:	
+	return err;
+}
+
+static int spidev_remove(struct device *dev)
+{
+	spidev_driver_data_t *drvdata;
+	int err = 0;
+
+	if (NULL == dev) {
+		printk(KERN_ERR "%s: removing the NULL device\n", __FUNCTION__);
+	}
+
+	drvdata = (spidev_driver_data_t *) dev_get_drvdata(dev);
+	if (NULL == drvdata) {
+		pr_debug("%s: oops, drvdata is NULL !\n", __FUNCTION__);
+		err = -ENODEV;
+		goto remove_out;
+	}
+#ifdef CONFIG_DEVFS_FS
+	devfs_remove("spi/%d", drvdata->minor);
+#endif
+	kfree(drvdata);
+	pr_debug("%s: device removed\n", __FUNCTION__);
+remove_out:	
+	return err;
+}
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset)
+{
+	char *tmp;
+	int ret = 0;
+#ifdef DEBUG
+	struct inode *inode = file->f_dentry->d_inode;
+#endif
+	struct spi_adapter *adap = (struct spi_adapter *)file->private_data;
+	unsigned long (*cpy_to_user) (void *to_user, const void *from,
+				      unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+
+	cpy_to_user = adap->copy_to_user ? adap->copy_to_user : copy_to_user;
+	alloc = adap->alloc ? adap->alloc : kmalloc;
+	free = adap->free ? adap->free : kfree;
+
+	/* copy user space data to kernel space. */
+	tmp = alloc(count, GFP_KERNEL);
+	if (tmp == NULL) {
+		ret = -ENOMEM;
+		goto read_out;
+	}
+
+	pr_debug("spi-%d reading %d bytes.\n", MINOR(inode->i_rdev), count);
+
+	ret = spi_read(adap, 0, tmp, count);
+	if (ret >= 0)
+		ret = cpy_to_user(buf, tmp, count) ? -EFAULT : ret;
+	free(tmp);
+read_out:	
+	return ret;
+}
+
+static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
+			    loff_t * offset)
+{
+	int ret = 0;
+	char *tmp;
+	struct spi_adapter *adap = (struct spi_adapter *)file->private_data;
+#ifdef DEBUG
+	struct inode *inode = file->f_dentry->d_inode;
+#endif
+	unsigned long (*cpy_from_user) (void *to, const void *from_user,
+					unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+
+	cpy_from_user =
+	    adap->copy_from_user ? adap->copy_from_user : copy_from_user;
+	alloc = adap->alloc ? adap->alloc : kmalloc;
+	free = adap->free ? adap->free : kfree;
+
+	/* copy user space data to kernel space. */
+	tmp = alloc(count, GFP_KERNEL);
+	if (tmp == NULL) {
+		ret =  -ENOMEM;
+		goto write_out_1;
+	}
+
+	if (cpy_from_user(tmp, buf, count)) {
+		ret = -EFAULT;
+		goto write_out_2;
+	}
+
+	pr_debug("spi-%d writing %d bytes.\n", MINOR(inode->i_rdev), count);
+	ret = spi_write(adap, 0, tmp, count);
+write_out_2:	
+	free(tmp);
+write_out_1:	
+	return ret;
+}
+
+typedef struct {
+	unsigned int minor;
+	struct file *file;
+} spidev_openclose_t;
+
+static int spidev_do_open(struct device *dev, void *context)
+{
+	spidev_openclose_t *o = (spidev_openclose_t *) context;
+	struct spi_adapter *adap = SPI_ADAP(dev);
+	spidev_driver_data_t *drvdata;
+	int ret = 0;
+
+	drvdata = (spidev_driver_data_t *) dev_get_drvdata(dev);
+	if (NULL == drvdata) {
+		pr_debug("%s: oops, drvdata is NULL !\n", __FUNCTION__);
+		goto do_open_out;
+	}
+
+	pr_debug("drvdata->minor = %d vs %d\n", drvdata->minor, o->minor);
+	if (drvdata->minor == o->minor) {
+		get_device(&adap->dev);
+		o->file->private_data = adap;
+		ret = 1;
+	}
+do_open_out:
+	return ret;
+}
+
+int spidev_open(struct inode *inode, struct file *file)
+{
+	spidev_openclose_t o;
+	int status;
+
+	o.minor = iminor(inode);
+	o.file = file;
+	status = driver_for_each_dev(&spidev_driver.driver, &o, spidev_do_open);
+	if (status == 0) {
+		status = -ENODEV;
+	}
+	return status < 0 ? status : 0;
+}
+
+static int spidev_release(struct inode *inode, struct file *file)
+{
+	struct spi_adapter *adapter = file->private_data;
+
+	if (adapter) {
+		put_device(&adapter->dev);
+	}
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static int __init spi_dev_init(void)
+{
+	int res;
+
+	printk(KERN_INFO "spi /dev entries driver\n");
+
+	if (0 != (res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops))) {
+		goto out;
+	}
+
+	if (0 != (res = spi_add_driver(&spidev_driver))) {
+		goto out_unreg;
+	}
+#ifdef CONFIG_DEVFS_FS
+	devfs_mk_dir("spi");
+#endif
+	return 0;
+
+      out_unreg:
+	unregister_chrdev(SPI_MAJOR, "spi");
+      out:
+	printk(KERN_ERR "%s: Driver initialization failed\n", __FILE__);
+	return res;
+}
+
+static void spidev_cleanup(void)
+{
+	spi_del_driver(&spidev_driver);
+#ifdef CONFIG_DEVFS_FS
+	devfs_remove("spi");
+#endif
+	unregister_chrdev(SPI_MAJOR, "spi");
+}
+
+MODULE_AUTHOR("Jamey Hicks <jamey.hicks@compaq.com> Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("SPI /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(spi_dev_init);
+module_exit(spidev_cleanup);
diff -uNr -X dontdiff linux-2.6.12/drivers/spi/spi.h linux/drivers/spi/spi.h
--- linux-2.6.12/drivers/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/spi.h	2005-06-23 15:03:48.000000000 +0400
@@ -0,0 +1,35 @@
+/*
+ *  linux/drivers/spi/spi.h
+ *
+ *  Copyright (C) 2005 MontaVista
+ *
+ *  Local structures and macros
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ */
+#ifndef __SPI_LOCAL_H
+#define __SPI_LOCAL_H
+
+#define SPI_DRV( n ) container_of( n, struct spi_driver, driver )
+#define SPI_ADAP( n ) container_of( n, struct spi_adapter, dev )
+
+typedef struct {
+	const void *id;
+	void *found;
+} spi_srch_context_t;
+
+#define SPI_STUFF_FOUND -ECANCELED
+
+/* helpers.c */
+int driver_for_each_dev(struct device_driver *drv, void *data,
+			int (*callback) (struct device * dev, void *data));
+
+// #undef pr_debug
+//#define pr_debug printk
+#define ENTER() pr_debug( "%s: ENTERed\n", __FUNCTION__ )
+#define LEAVE() pr_debug( "%s: LEFT OUT\n", __FUNCTION__ )
+
+#endif				/* __SPI_LOCAL_H */
diff -uNr -X dontdiff linux-2.6.12/include/linux/spi/spi.h linux/include/linux/spi/spi.h
--- linux-2.6.12/include/linux/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/spi/spi.h	2005-06-23 13:55:06.000000000 +0400
@@ -0,0 +1,205 @@
+/*
+ *  linux/include/linux/spi/spi.h
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *  Copyright (C) 2002 Compaq Computer Corporation, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Derived from l3.h by Jamey Hicks
+ */
+#ifndef SPI_H
+#define SPI_H
+
+#include <linux/types.h>
+
+struct spi_msg {
+	unsigned char addr;	/* slave address        */
+	unsigned char flags;
+#define SPI_M_RD	0x01
+#define SPI_M_WR	0x02	/**< Write mode flag */
+#define SPI_M_CSREL	0x04	/**< CS release level at end of the frame  */
+#define SPI_M_CS	0x08	/**< CS active level at begining of frame ( default low ) */
+#define SPI_M_CPOL	0x10	/**< Clock polarity */
+#define SPI_M_CPHA	0x20	/**< Clock Phase */
+#define SPI_M_NOADDR	0x80
+
+	unsigned short len;	/* msg length           */
+	unsigned char *buf;	/* pointer to msg data  */
+	unsigned long clock;
+};
+
+
+#define SPI_MAJOR	98
+
+extern struct bus_type spi_bus_type;
+
+/*
+ * A driver is capable of handling one or more physical devices present on
+ * SPI adapters.
+ */
+struct spi_driver;
+
+struct spi_ops {
+	int (*open) (struct spi_driver *);
+	int (*command) (struct spi_driver *, int cmd, void *arg);
+	void (*close) (struct spi_driver *);
+};
+
+typedef char *spi_ids_t[];
+#define SPI_ID_ANY     "* ANY *"
+#define SPI_IDS_TABLE_BEGIN static spi_ids_t spi_devices_supported = {
+#define SPI_IDS_TABLE_END ,NULL };
+#define SPI_IDS &spi_devices_supported
+
+struct spi_driver {
+	struct spi_ops *ops;
+	struct module *owner;
+	struct device_driver driver;
+	unsigned int minor;
+	spi_ids_t *supported_ids;
+};
+
+struct spi_adapter;
+
+#define SELECT   	0x01
+#define UNSELECT 	0x02
+#define BEFORE_READ 	0x03
+#define BEFORE_WRITE	0x04
+#define AFTER_READ	0x05
+#define AFTER_WRITE	0x06
+
+struct spi_algorithm {
+	/* textual description */
+	char name[32];
+
+	/* perform bus transactions */
+	int (*xfer) (struct spi_adapter *, struct spi_msg msgs[], int num);
+	int (*chip_cs) (int, void *context);
+};
+
+/*
+ * spi_adapter is the structure used to identify a physical SPI device along
+ * with the access algorithms necessary to access it.
+ */
+struct spi_adapter {
+	/*
+	 * This name is used to uniquely identify the adapter.
+	 * It should be the same as the module name.
+	 */
+	char name[32];
+
+	/* the algorithm to access the device */
+	struct spi_algorithm *algo;
+
+	/* algorithm-specific data            */
+	void *algo_data;
+
+	/* private data                       */
+	void *private_data;
+
+	/*  This may be NULL, or should point to the module structure */
+	struct module *owner;
+
+	struct semaphore lock;
+
+	void (*select) (struct spi_adapter * this, int onoff);
+
+	/* The alternative way to allocate/free memory. */
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+
+	/*
+	 * Copy data from/to user in case the alternative
+	 * alloc/free functions are used.
+	 */
+	unsigned long (*copy_from_user) (void *to, const void *from_user,
+					 unsigned long len);
+	unsigned long (*copy_to_user) (void *to_user, const void *from,
+				       unsigned long len);
+
+	struct device dev;
+};
+
+extern int spi_add_adapter(struct spi_adapter *);
+extern void spi_del_adapter(struct spi_adapter *);
+
+extern int spi_transfer(struct spi_adapter *, struct spi_msg msgs[], int);
+extern int spi_write(struct spi_adapter *, int, const char *, int);
+extern int spi_read(struct spi_adapter *, int, char *, int);
+
+static inline int spi_add_driver(struct spi_driver *driver)
+{
+	return driver_register(&driver->driver);
+}
+
+static inline void spi_del_driver(struct spi_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+
+typedef struct {
+	unsigned int minor;
+	void *private_data;
+} spidev_driver_data_t;
+
+static inline void *spi_get_adapdata(struct spi_adapter *dev)
+{
+	spidev_driver_data_t *dd;
+
+	dd = (spidev_driver_data_t *) dev_get_drvdata(&dev->dev);
+	return dd ? dd->private_data : NULL;
+}
+
+static inline void spi_set_adapdata(struct spi_adapter *dev, void *data)
+{
+	spidev_driver_data_t *dd;
+
+	dd = (spidev_driver_data_t *) dev_get_drvdata(&dev->dev);
+	if (dd) {
+		dd->private_data = data;
+	}
+}
+
+/**
+ * spi_command - send a command to a SPI device driver
+ * @client: registered client structure
+ * @cmd: device driver command
+ * @arg: device driver arguments
+ *
+ * Ask the SPI device driver to perform some function.  Further information
+ * should be sought from the device driver in question.
+ *
+ * Returns negative error code on failure.
+ */
+static inline int spi_command(struct spi_driver *clnt, int cmd, void *arg)
+{
+	struct spi_ops *ops = clnt->ops;
+	int ret = -EINVAL;
+
+	if (ops && ops->command)
+		ret = ops->command(clnt, cmd, arg);
+
+	return ret;
+}
+
+static inline int spi_open(struct spi_driver *clnt)
+{
+	struct spi_ops *ops = clnt->ops;
+	int ret = 0;
+
+	if (ops && ops->open)
+		ret = ops->open(clnt);
+	return ret;
+}
+
+static inline void spi_close(struct spi_driver *clnt)
+{
+	struct spi_ops *ops = clnt->ops;
+	if (ops && ops->close)
+		ops->close(clnt);
+}
+
+#endif				/* SPI_H */


