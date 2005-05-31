Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVEaQSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVEaQSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVEaQS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:18:29 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:48279 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261929AbVEaQJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:09:18 -0400
Subject: [RFC] SPI core
From: dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: montavista
Date: Tue, 31 May 2005 20:09:16 +0400
Message-Id: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

In order to support the specific board, we have ported the generic SPI core to the 2.6 kernel. This core provides basic API to create/manage SPI devices like the I2C core does. We need to continue providing support of SPI devices and would like to maintain the SPI subtree. It would be nice if SPI core patch were applied to the vanilla kernel.
I2C people do not like to mainain this code as well as I2C, so...

Signed-off-by: dmitry pervushin <dpervushin@gmail.com>

KernelVersion: 2.6.12-rc4

PATCH FOLLOWS
diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/Kconfig linux/drivers/spi/Kconfig
--- linux-2.6.12-rc4/drivers/spi/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/Kconfig	2005-05-31 19:59:01.000000000 +0400
@@ -0,0 +1,26 @@
+#
+# Character device configuration
+#
+
+menu "SPI support"
+
+config SPI
+	tristate "SPI support"
+
+config SPI_ALGOBIT
+	tristate "SPI bit-banging interfaces"
+	depends on SPI
+
+config SPI_CHARDEV
+	tristate "SPI device interface"
+	depends on SPI
+	help
+	  Say Y here to use spi-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the SPI bus.  Information on how to do this is
+	  contained in the file <file:Documentation/spi/dev-interface>.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called spi-dev.
+
+endmenu
diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/Makefile linux/drivers/spi/Makefile
--- linux-2.6.12-rc4/drivers/spi/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/Makefile	2005-05-31 19:59:01.000000000 +0400
@@ -0,0 +1,12 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+# Init order: core, chardev, bit adapters, pcf adapters
+
+obj-$(CONFIG_SPI)		+= spi-core.o
+obj-$(CONFIG_SPI_CHARDEV)	+= spi-dev.o
+
+# Bit adapters
+
+# PCF adapters
diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-core.c linux/drivers/spi/spi-core.c
--- linux-2.6.12-rc4/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/spi-core.c	2005-05-31 19:59:12.000000000 +0400
@@ -0,0 +1,385 @@
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
+ *  See linux/Documentation/spi for further documentation.
+ */
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/proc_fs.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/spi/spi.h>
+
+static DECLARE_MUTEX(adapter_lock);
+static LIST_HEAD(adapter_list);
+
+static DECLARE_MUTEX(driver_lock);
+static LIST_HEAD(driver_list);
+
+/**
+ * spi_add_adapter - register a new SPI bus adapter
+ * @adap: spi_adapter structure for the registering adapter
+ *
+ * Make the adapter available for use by clients using name adap->name.
+ * The adap->adapters list is initialised by this function.
+ *
+ * Returns 0;
+ */
+int spi_add_adapter(struct spi_adapter *adap)
+{
+	struct list_head *l;
+
+	INIT_LIST_HEAD(&adap->clients);
+	down(&adapter_lock);
+	init_MUTEX(&adap->lock);
+	list_add(&adap->adapters, &adapter_list);
+	up(&adapter_lock);
+
+	list_for_each(l, &driver_list) {
+		struct spi_driver *drv =
+		    list_entry(l, struct spi_driver, drivers);
+
+		if (drv->attach_adapter)
+			drv->attach_adapter(adap);
+	}
+
+	return 0;
+}
+
+/**
+ * spi_del_adapter - unregister a SPI bus adapter
+ * @adap: spi_adapter structure to unregister
+ *
+ * Remove an adapter from the list of available SPI Bus adapters.
+ *
+ * Returns 0;
+ */
+int spi_del_adapter(struct spi_adapter *adap)
+{
+	struct list_head *l;
+
+	down(&adapter_lock);
+	list_del(&adap->adapters);
+	up(&adapter_lock);
+
+	list_for_each(l, &driver_list) {
+		struct spi_driver *drv =
+		    list_entry(l, struct spi_driver, drivers);
+
+		if (drv->detach_adapter)
+			drv->detach_adapter(adap);
+	}
+
+	return 0;
+}
+
+/**
+ * spi_get_adapter - get a reference to an adapter
+ * @id: driver id
+ *
+ * Obtain a spi_adapter structure for the specified adapter.  If the adapter
+ * is not currently load, then load it.  The adapter will be locked in core
+ * until all references are released via spi_put_adapter.
+ */
+struct spi_adapter *spi_get_adapter(int id)
+{
+	struct list_head *item;
+	struct spi_adapter *adapter;
+
+	down(&adapter_lock);
+	list_for_each(item, &adapter_list) {
+		adapter = list_entry(item, struct spi_adapter, adapters);
+		if (id == adapter->nr && try_module_get(adapter->owner)) {
+			up(&adapter_lock);
+			return adapter;
+		}
+	}
+	up(&adapter_lock);
+	return NULL;
+
+}
+
+/**
+ * spi_put_adapter - release a reference to an adapter
+ * @adap: driver to release reference
+ *
+ * Indicate to the SPI core that you no longer require the adapter reference.
+ * The adapter module may be unloaded when there are no references to its
+ * data structure.
+ *
+ * You must not use the reference after calling this function.
+ */
+void spi_put_adapter(struct spi_adapter *adap)
+{
+	if (adap && adap->owner)
+		module_put(adap->owner);
+}
+
+/**
+ * spi_add_driver - register a new SPI device driver
+ * @driver - driver structure to make available
+ *
+ * Make the driver available for use by clients using name driver->name.
+ * The driver->drivers list is initialised by this function.
+ *
+ * Returns 0;
+ */
+int spi_add_driver(struct spi_driver *driver)
+{
+	down(&driver_lock);
+	list_add(&driver->drivers, &driver_list);
+	up(&driver_lock);
+	return 0;
+}
+
+/**
+ * spi_del_driver - unregister a SPI device driver
+ * @driver: driver to remove
+ *
+ * Remove an driver from the list of available SPI Bus device drivers.
+ *
+ * Returns 0;
+ */
+int spi_del_driver(struct spi_driver *driver)
+{
+	down(&driver_lock);
+	list_del(&driver->drivers);
+	up(&driver_lock);
+	return 0;
+}
+
+static struct spi_driver *__spi_get_driver(const char *name)
+{
+	struct list_head *l;
+
+	list_for_each(l, &driver_list) {
+		struct spi_driver *drv =
+		    list_entry(l, struct spi_driver, drivers);
+
+		if (strcmp(drv->name, name) == 0)
+			return drv;
+	}
+
+	return NULL;
+}
+
+/**
+ * spi_get_driver - get a reference to a driver
+ * @name: driver name
+ *
+ * Obtain a spi_driver structure for the specified driver.  If the driver is
+ * not currently load, then load it.  The driver will be locked in core
+ * until all references are released via spi_put_driver.
+ */
+struct spi_driver *spi_get_driver(const char *name)
+{
+	struct spi_driver *drv = NULL;
+	int try;
+
+	for (try = 0; try < 2; try++) {
+		down(&adapter_lock);
+		drv = __spi_get_driver(name);
+		if (drv && !try_module_get(drv->owner))
+			drv = NULL;
+		up(&adapter_lock);
+
+		if (drv)
+			break;
+
+		if (try == 0)
+			request_module(name);
+	}
+
+	return drv;
+}
+
+/**
+ * spi_put_driver - release a reference to a driver
+ * @drv: driver to release reference
+ *
+ * Indicate to the SPI core that you no longer require the driver reference.
+ * The driver module may be unloaded when there are no references to its
+ * data structure.
+ *
+ * You must not use the reference after calling this function.
+ */
+void spi_put_driver(struct spi_driver *drv)
+{
+	if (drv && drv->owner)
+		module_put(drv->owner);
+}
+
+/**
+ * spi_attach_client - attach a client to an adapter and driver
+ * @client: client structure to attach
+ * @adap: adapter (module) name
+ * @drv: driver (module) name
+ *
+ * Attempt to attach a client (a user of a device driver) to a particular
+ * driver and adapter.  If the specified driver or adapter aren't registered,
+ * request_module is used to load the relevant modules.
+ *
+ * Returns 0 on success, or negative error code.
+ */
+int spi_attach_client(struct spi_client *client, int id, const char *drv)
+{
+	struct spi_adapter *adapter = spi_get_adapter(id);
+	struct spi_driver *driver = spi_get_driver(drv);
+	int ret = -ENOENT;
+
+	if (!adapter)
+		printk(KERN_ERR "%s: unable to get adapter: %d\n", __FUNCTION__,
+		       id);
+	if (!driver)
+		printk(KERN_ERR "%s: unable to get driver: %s\n", __FUNCTION__,
+		       drv);
+
+	if (adapter && driver) {
+		ret = 0;
+
+		client->adapter = adapter;
+		client->driver = driver;
+
+		list_add(&client->__adap, &adapter->clients);
+
+		if (driver->attach_client)
+			ret = driver->attach_client(client);
+	}
+
+	if (ret) {
+		spi_put_driver(driver);
+		spi_put_adapter(adapter);
+	}
+	return ret;
+}
+
+/**
+ * spi_detach_client - detach a client from an adapter and driver
+ * @client: client structure to detach
+ *
+ * Detach the client from the adapter and driver.
+ */
+int spi_detach_client(struct spi_client *client)
+{
+	struct spi_adapter *adapter = client->adapter;
+	struct spi_driver *driver = client->driver;
+
+	driver->detach_client(client);
+
+	client->adapter = NULL;
+	client->driver = NULL;
+
+	spi_put_driver(driver);
+	spi_put_adapter(adapter);
+
+	list_del(&client->__adap);
+
+	return 0;
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
+		ret = adap->algo->xfer(adap, msgs, num);
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
+int spi_write(struct spi_client *client, int addr, const char *buf, int len)
+{
+	struct spi_adapter *adap = client->adapter;
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
+int spi_read(struct spi_client *client, int addr, char *buf, int len)
+{
+	struct spi_adapter *adap = client->adapter;
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
+EXPORT_SYMBOL(spi_add_adapter);
+EXPORT_SYMBOL(spi_del_adapter);
+EXPORT_SYMBOL(spi_get_adapter);
+EXPORT_SYMBOL(spi_put_adapter);
+
+EXPORT_SYMBOL(spi_add_driver);
+EXPORT_SYMBOL(spi_del_driver);
+EXPORT_SYMBOL(spi_get_driver);
+EXPORT_SYMBOL(spi_put_driver);
+
+EXPORT_SYMBOL(spi_attach_client);
+EXPORT_SYMBOL(spi_detach_client);
+
+EXPORT_SYMBOL(spi_transfer);
+EXPORT_SYMBOL(spi_write);
+EXPORT_SYMBOL(spi_read);
diff -uNr -X dontdiff linux-2.6.12-rc4/drivers/spi/spi-dev.c linux/drivers/spi/spi-dev.c
--- linux-2.6.12-rc4/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/spi/spi-dev.c	2005-05-31 19:59:18.000000000 +0400
@@ -0,0 +1,514 @@
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
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/smp_lock.h>
+#ifdef CONFIG_DEVFS_FS
+#include <linux/devfs_fs_kernel.h>
+#endif
+
+/*  Define SPIDEV_DEBUG for debugging info  */
+#undef SPIDEV_DEBUG
+
+#ifdef SPIDEV_DEBUG
+#define DBG(args...)	printk(KERN_INFO"spi-dev.o: " args)
+#else
+#define DBG(args...)
+#endif
+
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/spi/spi.h>
+
+#define SPI_TRANSFER_MAX	65535
+#define SPI_ADAP_MAX		32
+
+extern struct spi_adapter *spi_get_adapter(int id);	/* spi-core.c ? */
+extern void spi_put_adapter(struct spi_adapter *);
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
+static int spidev_attach_adapter(struct spi_adapter *);
+static int spidev_detach_adapter(struct spi_adapter *);
+static int __init spi_dev_init(void);
+static void spidev_cleanup(void);
+
+static struct file_operations spidev_fops = {
+      owner:THIS_MODULE,
+      llseek:no_llseek,
+      read:spidev_read,
+      write:spidev_write,
+      open:spidev_open,
+      release:spidev_release,
+      ioctl:spidev_ioctl,
+};
+
+static struct spi_driver spidev_driver = {
+      name:"spi",
+      attach_adapter:spidev_attach_adapter,
+      detach_adapter:spidev_detach_adapter,
+      owner:THIS_MODULE,
+};
+
+static struct spi_client spidev_client_template = {
+      driver:&spidev_driver
+};
+
+struct spi_dev {
+	int minor;
+	struct spi_adapter *adap;
+	struct class_device class_dev;
+	struct completion released;	/* FIXME, we need a class_device_unregister() */
+};
+
+#define to_spi_dev(d) container_of(d, struct spi_dev, class_dev)
+
+#define SPI_MINORS	256
+static struct spi_dev *spi_dev_array[SPI_MINORS];
+static DEFINE_SPINLOCK(spi_dev_array_lock);
+
+struct spi_dev *spi_dev_get_by_minor(unsigned index)
+{
+	struct spi_dev *spi_dev;
+
+	spin_lock(&spi_dev_array_lock);
+	spi_dev = spi_dev_array[index];
+	spin_unlock(&spi_dev_array_lock);
+	return spi_dev;
+}
+
+struct spi_dev *spi_dev_get_by_adapter(struct spi_adapter *adap)
+{
+	struct spi_dev *spi_dev = NULL;
+
+	spin_lock(&spi_dev_array_lock);
+	if ((spi_dev_array[adap->nr]) &&
+	    (spi_dev_array[adap->nr]->adap == adap))
+		spi_dev = spi_dev_array[adap->nr];
+	spin_unlock(&spi_dev_array_lock);
+	return spi_dev;
+}
+
+static struct spi_dev *get_free_spi_dev(struct spi_adapter *adap)
+{
+	struct spi_dev *spi_dev;
+
+	spi_dev = kmalloc(sizeof(*spi_dev), GFP_KERNEL);
+	if (!spi_dev)
+		return ERR_PTR(-ENOMEM);
+	memset(spi_dev, 0x00, sizeof(*spi_dev));
+
+	spin_lock(&spi_dev_array_lock);
+	if (spi_dev_array[adap->nr]) {
+		spin_unlock(&spi_dev_array_lock);
+		dev_err(&adap->dev,
+			"spi-dev already has a device assigned to this adapter\n");
+		goto error;
+	}
+	spi_dev->minor = adap->nr;
+	spi_dev_array[adap->nr] = spi_dev;
+	spin_unlock(&spi_dev_array_lock);
+	return spi_dev;
+      error:
+	kfree(spi_dev);
+	return ERR_PTR(-ENODEV);
+}
+
+static void return_spi_dev(struct spi_dev *spi_dev)
+{
+	spin_lock(&spi_dev_array_lock);
+	spi_dev_array[spi_dev->minor] = NULL;
+	spin_unlock(&spi_dev_array_lock);
+}
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct spi_dev *spi_dev = to_spi_dev(class_dev);
+	return print_dev_t(buf, MKDEV(SPI_MAJOR, spi_dev->minor));
+}
+
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
+{
+	struct spi_dev *spi_dev = to_spi_dev(class_dev);
+	return sprintf(buf, "%s\n", spi_dev->adap->name);
+}
+
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
+static int spidev_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct spi_client *client = (struct spi_client *)file->private_data;
+	struct spi_rdwr_ioctl_data rdwr_arg;
+	struct spi_msg *rdwr_pa;
+	int res, i;
+	unsigned long (*cpy_to_user) (void *to_user, const void *from,
+				      unsigned long len);
+	unsigned long (*cpy_from_user) (void *to, const void *from_user,
+					unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+
+	DBG("spi-%d ioctl, cmd: 0x%x, arg: %lx.\n",
+	    MINOR(inode->i_rdev), cmd, arg);
+
+	cpy_to_user =
+	    client->adapter->copy_to_user ? client->adapter->
+	    copy_to_user : copy_to_user;
+	cpy_from_user =
+	    client->adapter->copy_from_user ? client->adapter->
+	    copy_from_user : copy_from_user;
+	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
+	free = client->adapter->free ? client->adapter->free : kfree;
+
+	switch (cmd) {
+	case SPI_RDWR:
+		if (copy_from_user(&rdwr_arg,
+				   (struct spi_rdwr_ioctl_data *)arg,
+				   sizeof(rdwr_arg)))
+			return -EFAULT;
+
+		rdwr_pa = (struct spi_msg *)
+		    kmalloc(rdwr_arg.nmsgs * sizeof(struct spi_msg),
+			    GFP_KERNEL);
+
+		if (rdwr_pa == NULL)
+			return -ENOMEM;
+
+		res = 0;
+		for (i = 0; i < rdwr_arg.nmsgs; i++) {
+			if (copy_from_user(&(rdwr_pa[i]),
+					   &(rdwr_arg.msgs[i]),
+					   sizeof(rdwr_pa[i]))) {
+				res = -EFAULT;
+				break;
+			}
+			rdwr_pa[i].buf = alloc(rdwr_pa[i].len, GFP_KERNEL);
+			if (rdwr_pa[i].buf == NULL) {
+				res = -ENOMEM;
+				break;
+			}
+			if (cpy_from_user(rdwr_pa[i].buf,
+					  rdwr_arg.msgs[i].buf,
+					  rdwr_pa[i].len)) {
+				free(rdwr_pa[i].buf);
+				res = -EFAULT;
+				break;
+			}
+		}
+		if (!res) {
+			res = spi_transfer(client->adapter,
+					   rdwr_pa, rdwr_arg.nmsgs);
+		}
+		while (i-- > 0) {
+			if (res >= 0 && (rdwr_pa[i].flags & SPI_M_RD))
+				if (cpy_to_user(rdwr_arg.msgs[i].buf,
+						rdwr_pa[i].buf,
+						rdwr_pa[i].len)) {
+					res = -EFAULT;
+				}
+			free(rdwr_pa[i].buf);
+		}
+		kfree(rdwr_pa);
+		return res;
+
+	case SPI_CLK_RATE:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void release_spi_dev(struct class_device *dev)
+{
+	struct spi_dev *spi_dev = to_spi_dev(dev);
+	complete(&spi_dev->released);
+}
+
+static struct class spi_dev_class = {
+	.name = "spi-dev",
+	.release = &release_spi_dev,
+};
+
+static int spidev_attach_adapter(struct spi_adapter *adap)
+{
+	struct spi_dev *spi_dev;
+	int retval;
+
+	spi_dev = get_free_spi_dev(adap);
+	if (IS_ERR(spi_dev))
+		return PTR_ERR(spi_dev);
+
+#if defined( CONFIG_DEVFS_FS )
+	devfs_mk_cdev(MKDEV(SPI_MAJOR, spi_dev->minor),
+		      S_IFCHR | S_IRUSR | S_IWUSR, "spi/%d", spi_dev->minor);
+#endif
+	dev_dbg(&adap->dev, "Registered as minor %d\n", spi_dev->minor);
+
+	/* register this spi device with the driver core */
+	spi_dev->adap = adap;
+	if (adap->dev.parent == &platform_bus)
+		spi_dev->class_dev.dev = &adap->dev;
+	else
+		spi_dev->class_dev.dev = adap->dev.parent;
+	spi_dev->class_dev.class = &spi_dev_class;
+	snprintf(spi_dev->class_dev.class_id, BUS_ID_SIZE, "spi-%d",
+		 spi_dev->minor);
+	retval = class_device_register(&spi_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file(&spi_dev->class_dev, &class_device_attr_dev);
+	class_device_create_file(&spi_dev->class_dev, &class_device_attr_name);
+	return 0;
+      error:
+	return_spi_dev(spi_dev);
+	kfree(spi_dev);
+	return retval;
+
+}
+
+static int spidev_detach_adapter(struct spi_adapter *adap)
+{
+	struct spi_dev *spi_dev;
+
+	spi_dev = spi_dev_get_by_adapter(adap);
+	if (!spi_dev)
+		return -ENODEV;
+
+	init_completion(&spi_dev->released);
+#if defined( CONFIG_DEVFS_FS )
+	devfs_remove("spi/%d", spi_dev->minor);
+#endif
+	return_spi_dev(spi_dev);
+	class_device_unregister(&spi_dev->class_dev);
+	wait_for_completion(&spi_dev->released);
+	kfree(spi_dev);
+
+	dev_dbg(&adap->dev, "Adapter unregistered\n");
+	return 0;
+
+}
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset)
+{
+	char *tmp;
+	int ret;
+#ifdef SPIDEV_DEBUG
+	struct inode *inode = file->f_dentry->d_inode;
+#endif
+
+	struct spi_client *client = (struct spi_client *)file->private_data;
+	unsigned long (*cpy_to_user) (void *to_user, const void *from,
+				      unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+
+	cpy_to_user =
+	    client->adapter->copy_to_user ? client->adapter->
+	    copy_to_user : copy_to_user;
+	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
+	free = client->adapter->free ? client->adapter->free : kfree;
+
+	/* copy user space data to kernel space. */
+	tmp = alloc(count, GFP_KERNEL);
+	if (tmp == NULL)
+		return -ENOMEM;
+
+	DBG("spi-%d reading %d bytes.\n", MINOR(inode->i_rdev), count);
+
+	ret = spi_read(client, 0, tmp, count);
+	if (ret >= 0)
+		ret = cpy_to_user(buf, tmp, count) ? -EFAULT : ret;
+	free(tmp);
+	return ret;
+}
+
+static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
+			    loff_t * offset)
+{
+	int ret;
+	char *tmp;
+	struct spi_client *client = (struct spi_client *)file->private_data;
+#ifdef SPIDEV_DEBUG
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
+	    client->adapter->copy_from_user ? client->adapter->
+	    copy_from_user : copy_from_user;
+	alloc = client->adapter->alloc ? client->adapter->alloc : kmalloc;
+	free = client->adapter->free ? client->adapter->free : kfree;
+
+	/* copy user space data to kernel space. */
+	tmp = alloc(count, GFP_KERNEL);
+	if (tmp == NULL)
+		return -ENOMEM;
+
+	if (cpy_from_user(tmp, buf, count)) {
+		free(tmp);
+		return -EFAULT;
+	}
+
+	DBG("spi-%d writing %d bytes.\n", MINOR(inode->i_rdev), count);
+	ret = spi_write(client, 0, tmp, count);
+	free(tmp);
+	return ret;
+}
+
+int spidev_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+	struct spi_client *client;
+	struct spi_adapter *adap;
+	struct spi_dev *spi_dev;
+
+	spi_dev = spi_dev_get_by_minor(minor);
+	if (!spi_dev)
+		return -ENODEV;
+
+	adap = spi_get_adapter(spi_dev->adap->nr);
+	if (!adap)
+		return -ENODEV;
+
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if (!client) {
+		spi_put_adapter(adap);
+		return -ENOMEM;
+	}
+	memcpy(client, &spidev_client_template, sizeof(*client));
+
+	/* registered with adapter, passed as client to user */
+	client->adapter = adap;
+	file->private_data = client;
+
+	return 0;
+
+}
+
+static int spidev_release(struct inode *inode, struct file *file)
+{
+	struct spi_client *client = file->private_data;
+
+	spi_put_adapter(client->adapter);
+	kfree(client);
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
+	res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops);
+	if (res)
+		goto out;
+
+	res = class_register(&spi_dev_class);
+	if (res)
+		goto out_unreg_chrdev;
+
+	res = spi_add_driver(&spidev_driver);
+	if (res)
+		goto out_unreg_class;
+
+#ifdef CONFIG_DEVFS_FS
+	devfs_mk_dir("spi");
+#endif
+	return 0;
+
+      out_unreg_class:
+	class_unregister(&spi_dev_class);
+      out_unreg_chrdev:
+	unregister_chrdev(SPI_MAJOR, "spi");
+      out:
+	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
+	return res;
+}
+
+static void spidev_cleanup(void)
+{
+	spi_del_driver(&spidev_driver);
+	class_unregister(&spi_dev_class);
+#ifdef CONFIG_DEVFS_FS
+	devfs_remove("spi");
+#endif
+	unregister_chrdev(SPI_MAJOR, "spi");
+}
+
+MODULE_AUTHOR
+    ("Jamey Hicks <jamey.hicks@compaq.com> Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("SPI /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(spi_dev_init);
+module_exit(spidev_cleanup);
diff -uNr -X dontdiff linux-2.6.12-rc4/include/linux/spi/spi.h linux/include/linux/spi/spi.h
--- linux-2.6.12-rc4/include/linux/spi/spi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/spi/spi.h	2005-05-31 19:59:26.000000000 +0400
@@ -0,0 +1,265 @@
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
+struct spi_msg {
+	unsigned char addr;	/* slave address        */
+	unsigned char flags;
+#define SPI_M_RD		0x01
+#define SPI_M_NOADDR	0x02
+	unsigned short len;	/* msg length           */
+	unsigned char *buf;	/* pointer to msg data  */
+};
+
+/*  TODO: should be in a separate header file?  */
+
+/*  Commands for the ioctl call */
+#define SPI_RDWR	0x0801	/*  Read/write transfer in a single transaction */
+#define SPI_CLK_RATE	0x0802	/*  Sets SPI clock divisor (int type)           */
+#define SPI_SDMA	0x0803	/*  Turns on/off SDMA usage (int type).         */
+				 /*  Pass non-zero value to turn SDMA on         */
+struct spi_rdwr_ioctl_data {
+	struct spi_msg *msgs;	/* pointers to spi_msgs */
+	int nmsgs;		/* number of spi_msgs */
+};
+/*------------^^^^^^^^^^^^^^^--------------*/
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+#define SPI_ADAP_MAX	32
+#define SPI_MAJOR	98
+
+struct spi_client;
+struct spi_adapter;
+
+struct spi_ops {
+	int (*open) (struct spi_client *);
+	int (*command) (struct spi_client *, int cmd, void *arg);
+	void (*close) (struct spi_client *);
+};
+
+/*
+ * A driver is capable of handling one or more physical devices present on
+ * SPI adapters. This information is used to inform the driver of adapter
+ * events.
+ */
+struct spi_driver {
+	/*
+	 * This name is used to uniquely identify the driver.
+	 * It should be the same as the module name.
+	 */
+	char name[32];
+
+	/* Notifies the driver that new adapter added to spi-core
+	 */
+	int (*attach_adapter) (struct spi_adapter *);
+
+	/* Notifies the driver that adapter has been deleted from spi-core
+	 */
+	int (*detach_adapter) (struct spi_adapter *);
+
+	/*
+	 * Notifies the driver that a new client wishes to use its
+	 * services.  Note that the module use count will be increased
+	 * prior to this function being called.  In addition, the
+	 * clients driver and adapter fields will have been setup.
+	 */
+	int (*attach_client) (struct spi_client *);
+
+	/*
+	 * Notifies the driver that the client has finished with its
+	 * services, and any memory that it allocated for this client
+	 * should be cleaned up.  In addition the chip should be
+	 * shut down.
+	 */
+	void (*detach_client) (struct spi_client *);
+
+	/*
+	 * Possible operations on the driver.
+	 */
+	struct spi_ops *ops;
+
+	/*
+	 * Module structure, if any.    
+	 */
+	struct module *owner;
+
+	/*
+	 * drivers list
+	 */
+	struct list_head drivers;
+};
+
+struct spi_adapter;
+
+struct spi_algorithm {
+	/* textual description */
+	char name[32];
+
+	/* perform bus transactions */
+	int (*xfer) (struct spi_adapter *, struct spi_msg msgs[], int num);
+};
+
+struct semaphore;
+
+/*
+ * spi_adapter is the structure used to identify a physical SPI bus along
+ * with the access algorithms necessary to access it.
+ */
+struct spi_adapter {
+	/*
+	 * This name is used to uniquely identify the adapter.
+	 * It should be the same as the module name.
+	 */
+	char name[32];
+
+	/*
+	 * the algorithm to access the bus
+	 */
+	struct spi_algorithm *algo;
+
+	/*
+	 * Algorithm specific data
+	 */
+	void *algo_data;
+
+	/*
+	 * This may be NULL, or should point to the module struct
+	 */
+	struct module *owner;
+
+	/*
+	 * private data for the adapter
+	 */
+	void *data;
+
+	/*
+	 * Our lock.
+	 */
+	struct semaphore lock;
+
+	/*
+	 * List of attached clients.
+	 */
+	struct list_head clients;
+
+	/*
+	 * List of all adapters.
+	 */
+	struct list_head adapters;
+
+	/*
+	 * The alternative way to allocate/free memory.
+	 */
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
+	int nr;
+
+	struct device dev;	/* the adapter device */
+	struct class_device class_dev;	/* the class device */
+
+	struct completion dev_released;
+	struct completion class_dev_released;
+
+};
+
+/*
+ * spi_client identifies a single device (i.e. chip) that is connected to an 
+ * SPI bus. The behaviour is defined by the routines of the driver. This
+ * function is mainly used for lookup & other admin. functions.
+ */
+struct spi_client {
+	struct spi_adapter *adapter;	/* the adapter we sit on        */
+	struct spi_driver *driver;	/* and our access routines      */
+	void *driver_data;	/* private driver data          */
+	struct list_head __adap;
+};
+
+extern int spi_add_adapter(struct spi_adapter *);
+extern int spi_del_adapter(struct spi_adapter *);
+
+extern int spi_add_driver(struct spi_driver *);
+extern int spi_del_driver(struct spi_driver *);
+
+extern int spi_attach_client(struct spi_client *, int, const char *);
+extern int spi_detach_client(struct spi_client *);
+
+extern int spi_transfer(struct spi_adapter *, struct spi_msg msgs[], int);
+extern int spi_write(struct spi_client *, int, const char *, int);
+extern int spi_read(struct spi_client *, int, char *, int);
+
+static inline void *spi_get_adapdata(struct spi_adapter *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void spi_set_adapdata(struct spi_adapter *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
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
+static inline int spi_command(struct spi_client *clnt, int cmd, void *arg)
+{
+	struct spi_ops *ops = clnt->driver->ops;
+	int ret = -EINVAL;
+
+	if (ops && ops->command)
+		ret = ops->command(clnt, cmd, arg);
+
+	return ret;
+}
+
+static inline int spi_open(struct spi_client *clnt)
+{
+	struct spi_ops *ops = clnt->driver->ops;
+	int ret = 0;
+
+	if (ops && ops->open)
+		ret = ops->open(clnt);
+	return ret;
+}
+
+static inline void spi_close(struct spi_client *clnt)
+{
+	struct spi_ops *ops = clnt->driver->ops;
+	if (ops && ops->close)
+		ops->close(clnt);
+}
+#endif
+
+#endif				/* SPI_H */


