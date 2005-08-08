Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVHHJM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHHJM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 05:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVHHJM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 05:12:27 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:48296 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750785AbVHHJM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 05:12:26 -0400
Subject: [PATCH] spi
From: dmitry pervushin <dpervushin@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1121025679.3008.10.camel@spirit>
References: <1121025679.3008.10.camel@spirit>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 13:12:18 +0400
Message-Id: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 


Here is the spi core patch (slightly redesigned again). Now it operates
with three abstractions:
a) the spi bus, which is registered in system and is resposible for
general things like registering devices on it, handling PM events for
entire bus, providing bus-wide operations;
b) the spi device, which is responsible for interactions between the
device and the bus (selecting/deselecting device) and PM events for the
specifi device;
c) the driver, which is attached to spi devices and (possibly) provide
interface to the upper level like block device interface. The spi-dev is
the good starting point for people who does not want anything but simple
character device access.
The new abstraction is the spi bus, which functionality was represented
by spi_device structure.

Especially for Greg K-H: yes, I ran this code through sparse :), thank
you.

Signed-off-by: dmitry pervushin <dpervushin@gmail.com>

Kernel-version: 2.6.12

This patch is to provide SPI support on linux

 drivers/Kconfig          |    2
 drivers/Makefile         |    1
 drivers/spi/Kconfig      |   33 ++++
 drivers/spi/Makefile     |   12 +
 drivers/spi/spi-core.c   |  327 +++++++++++++++++++++++++++++++++++++++++++++++ 
 drivers/spi/spi-dev.c    |  303 +++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi_locals.h |   10 +
 include/linux/spi.h      |  148 +++++++++++++++++++++
 8 files changed, 836 insertions(+)

Index: linux-2.6.10/drivers/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/Kconfig	2005-07-15 06:56:55.000000000 +0000
+++ linux-2.6.10/drivers/Kconfig	2005-07-15 06:57:39.000000000 +0000
@@ -42,6 +42,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/misc/Kconfig"
Index: linux-2.6.10/drivers/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/Makefile	2005-07-15 06:57:21.000000000 +0000
+++ linux-2.6.10/drivers/Makefile	2005-07-15 06:59:04.000000000 +0000
@@ -67,1 +67,2 @@
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_SPI)               += spi/
Index: linux-2.6.10/drivers/spi/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/spi/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/drivers/spi/Kconfig	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,33 @@
+#
+# SPI device configuration
+#
+menu "SPI support"
+
+config SPI
+	default Y
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
+	default Y
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
Index: linux-2.6.10/drivers/spi/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/spi/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/drivers/spi/Makefile	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,12 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+obj-$(CONFIG_SPI) += spi-core.o helpers.o
+
+obj-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+
+ifeq ($(CONFIG_SPI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
Index: linux-2.6.10/drivers/spi/spi-core.c
===================================================================
--- linux-2.6.10.orig/drivers/spi/spi-core.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/drivers/spi/spi-core.c	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,327 @@
+/*
+ *  linux/drivers/spi/spi-core.c
+ *
+ *  Copyright (C) 2005 MontaVista Software
+ *  Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
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
+#include <linux/spi.h>
+
+#include "spi_locals.h"
+
+static LIST_HEAD( spi_busses );
+
+int spi_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct spi_driver *spidrv = SPI_DRV(driver);
+	struct spi_device *spidev = SPI_DEV(dev);
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
+		     *id, spidev->dev.bus_id);
+		if (0 == strncmp(*id, SPI_ID_ANY, strlen(SPI_ID_ANY))) {
+			pr_debug
+			    ("The driver (%p) can be attached to any device (%p)\n",
+			     driver, dev);
+			found = 1;
+			goto spi_match_done;
+		}
+		if (0 == strcmp(*id, spidev->dev.bus_id)) {
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
+int spi_bus_register( struct spi_bus* bus, char* name )
+{
+	int err = -EINVAL;
+	static int count = 0;
+	char busname[ BUS_ID_SIZE ];
+	char fullname[ BUS_ID_SIZE ];
+
+	ENTER();	
+	if( bus ) {
+		init_MUTEX( &bus->lock );
+
+		bus->platform_device.name = NULL;
+		bus->the_bus.name = NULL;
+
+		strncpy( busname, name ? name : "SPI", sizeof( busname ) );
+		bus->platform_device.id = count++ % 100;
+		sprintf( fullname, "%s_%02d", busname, bus->platform_device.id);
+		bus->the_bus.name = kmalloc( strlen( fullname )+1, GFP_KERNEL );
+		if( bus->the_bus.name ) {
+			strcpy( bus->the_bus.name, fullname );
+		}
+
+		err = bus_register( &bus->the_bus );
+		if( err ) {
+			goto out;
+		}
+		list_add_tail( &bus->bus_list, &spi_busses );
+		bus->platform_device.name = kmalloc( strlen( busname )+1, GFP_KERNEL );
+		if( bus->platform_device.name ) {
+			strcpy( bus->platform_device.name, busname );
+		}
+		err = platform_device_register( &bus->platform_device );
+	}
+out:
+	if( err ) {
+		if( bus->the_bus.name ) {
+			kfree( bus->the_bus.name );
+		}
+		if( bus->platform_device.name ) {
+			kfree( bus->platform_device.name );
+		}
+		/* TODO: platform_device_unregister */
+	}
+	return err;
+}
+
+void spi_bus_unregister( struct spi_bus* bus )
+{
+	if( bus ) {
+		platform_device_unregister( &bus->platform_device );
+		if( bus->platform_device.name ) {
+			kfree( bus->platform_device.name );
+		}
+		bus_unregister( &bus->the_bus );
+		if( bus->the_bus.name ) {
+			kfree( bus->the_bus.name );
+		}
+		list_del_init( &bus->bus_list );
+	}
+}
+
+/**
+ * spi_add_adapter - register a new SPI bus adapter
+ * @spidev: spi_device structure for the registering adapter
+ *
+ * Make the adapter available for use by clients using name adap->name.
+ * The adap->adapters list is initialised by this function.
+ *
+ * Returns error code ( 0 on success ) ;
+ */
+struct spi_bus* spi_bus_find( char* id )
+{
+	struct bus_type* the_bus = find_bus( id );
+
+	return the_bus ? container_of( the_bus, struct spi_bus, the_bus ) : NULL;
+}
+
+EXPORT_SYMBOL( spi_bus_find );
+int spi_device_add( struct spi_bus* bus, struct spi_device *dev, char* name)
+{
+	int err;
+
+	memset(&dev->dev, 0, sizeof(dev->dev));
+
+	if (dev->dev.parent == NULL)
+		dev->dev.parent = &platform_bus;
+	if( name ) {
+		strncpy( dev->dev.bus_id, name, sizeof( dev->dev.bus_id ) );
+	} else {
+		snprintf( dev->dev.bus_id, sizeof( dev->dev.bus_id ), "DEV%p_%s", dev, bus->the_bus.name );
+	}
+	dev->dev.bus = &bus->the_bus;
+	init_MUTEX( &dev->lock );
+
+	err = device_register(&dev->dev);
+	pr_debug("device_register (%p) status = %d\n", &dev->dev, err);
+	return err;
+}
+
+/**
+ * spi_del_adapter - unregister a SPI bus adapter
+ * @dev: spi_device structure to unregister
+ *
+ * Remove an adapter from the list of available SPI Bus adapters.
+ *
+ * Returns error code (0 on success);
+ */
+
+void spi_device_del(struct spi_device *dev)
+{
+	device_unregister(&dev->dev);
+}
+
+int spi_do_probe( struct device* dev, void* device_driver )
+{
+	struct device_driver* drv = device_driver;
+	
+	if( dev->bus->match && !dev->bus->match( dev, drv ) ) {
+		goto do_probe_out;
+	}
+	if( drv->probe ) {
+		if( 0 == drv->probe( dev ) ) {
+			dev->driver = drv;
+			device_bind_driver( dev );
+		}	
+	}
+do_probe_out:	
+	return 0;
+}
+int spi_driver_add( struct spi_driver* drv )
+{
+	int err;
+	struct list_head* entry;
+       
+	err = driver_register( &drv->driver );
+	if( err ) {
+		goto out;
+	}
+
+	err = kobject_set_name(&drv->driver.kobj, "%s", drv->driver.name);
+	if( err ) {
+		goto out;
+	}
+	err = kobject_register(&drv->driver.kobj);
+	if( err ) {
+		goto out;
+	}
+	list_for_each( entry, &spi_busses ) {
+		struct spi_bus* bus = container_of( entry, struct spi_bus, bus_list );
+		bus_for_each_dev( &bus->the_bus, NULL, &drv->driver, spi_do_probe );
+	}
+	module_add_driver( drv->driver.owner, &drv->driver );
+out:
+	return err;	
+}
+
+void spi_driver_del( struct spi_driver* drv )
+{
+	driver_unregister( &drv->driver );
+}
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
+int spi_transfer(struct spi_device *dev, struct spi_msg msgs[], int num)
+{
+	int ret = -ENOSYS;
+	struct spi_bus* bus;
+
+	bus = TO_SPI_BUS( dev->dev.bus );
+
+	if (bus->xfer) {
+		down( &dev->lock );
+		ret = bus->xfer(bus, dev, msgs, num, 0);
+		up(&dev->lock);
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
+int spi_write(struct spi_device *dev, int addr, const char *buf, int len)
+{
+	struct spi_msg msg;
+	int ret;
+
+	msg.addr = addr;
+	msg.flags = 0;
+	msg.buf = (char *)buf;
+	msg.len = len;
+
+	ret = spi_transfer(dev, &msg, 1);
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
+int spi_read(struct spi_device *dev, int addr, char *buf, int len)
+{
+	struct spi_msg msg;
+	int ret;
+
+	msg.addr = addr;
+	msg.flags = SPI_M_RD;
+	msg.buf = buf;
+	msg.len = len;
+
+	ret = spi_transfer(dev, &msg, 1);
+	return ret == 1 ? len : ret;
+}
+
+MODULE_LICENSE( "GPL" );
+MODULE_AUTHOR( "dmitry pervushin <dpervushin@ru.mvista.com>" );
+
+EXPORT_SYMBOL_GPL(spi_driver_add);
+EXPORT_SYMBOL_GPL(spi_driver_del);
+EXPORT_SYMBOL_GPL(spi_device_add);
+EXPORT_SYMBOL_GPL(spi_device_del);
+EXPORT_SYMBOL_GPL(spi_bus_match);
+EXPORT_SYMBOL_GPL(spi_transfer);
+EXPORT_SYMBOL_GPL(spi_write);
+EXPORT_SYMBOL_GPL(spi_read);
Index: linux-2.6.10/drivers/spi/spi-dev.c
===================================================================
--- linux-2.6.10.orig/drivers/spi/spi-dev.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/drivers/spi/spi-dev.c	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,303 @@
+/*#ifdef CONFIG_DEVFS_FS	
+
+    spi-dev.c - spi-bus driver, char device interface  
+
+    Copyright (C) 2005 MontaVista Software
+    Author: dmitry pervushin <dpervushin@ru.mvista.com>
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
+/* $Id: common_spi_core-2.patch,v 1.1.2.6 2005/07/15 07:24:40 tpoynor Exp $ */
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
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/spi.h>
+#include "spi_locals.h"
+
+#define SPI_TRANSFER_MAX	65535
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
+static int __init spidev_init(void);
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
+static struct class_simple *spidev_class;
+
+static struct spi_driver spidev_driver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		   .name = "generic_spi",
+		   .probe = spidev_probe,
+		   .remove = spidev_remove,
+		   },
+	.supported_ids = NULL,
+	.minor = 0,
+};
+
+static int spidev_probe(struct device *dev)
+{
+	struct spidev_driver_data *drvdata;
+
+	if (NULL == dev) {
+		printk(KERN_ERR "%s: probing the NULL device!\n", __FUNCTION__);
+		return -EFAULT;
+	}
+
+	drvdata = kmalloc(sizeof(struct spidev_driver_data), GFP_KERNEL);
+	if (NULL == drvdata) {
+		pr_debug("%s: allocating drvdata failed\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	drvdata->minor = spidev_driver.minor++;
+	pr_debug("%s: setting device's(%p) minor to %d\n",
+		 __FUNCTION__, dev, drvdata->minor);
+	dev_set_drvdata(dev, drvdata);
+
+	class_simple_device_add( spidev_class, 
+			 MKDEV( SPI_MAJOR, drvdata->minor ),
+		         NULL, "spi%d", drvdata->minor );
+
+	pr_debug("%s: Registered as minor %d\n", __FUNCTION__, drvdata->minor);
+	return 0;
+}
+
+static int spidev_remove(struct device *dev)
+{
+	struct spidev_driver_data *drvdata;
+
+	if (NULL == dev) {
+		printk(KERN_ERR "%s: removing the NULL device\n", __FUNCTION__);
+	}
+
+	drvdata = (struct spidev_driver_data *) dev_get_drvdata(dev);
+	if (NULL == drvdata) {
+		pr_debug("%s: oops, drvdata is NULL !\n", __FUNCTION__);
+		return -ENODEV;
+	}
+	class_simple_device_remove( MKDEV( SPI_MAJOR, drvdata->minor ) );
+	kfree(drvdata);
+	pr_debug("%s: device removed\n", __FUNCTION__);
+	return 0;
+}
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset)
+{
+	char *tmp;
+	int ret;
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+	unsigned long (*cpy_to_user) (void *to_user, const void *from,
+				      unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+
+	cpy_to_user = dev->copy_to_user ? dev->copy_to_user : copy_to_user;
+	alloc = dev->alloc ? dev->alloc : kmalloc;
+	free = dev->free ? dev->free : kfree;
+
+	/* copy user space data to kernel space. */
+	tmp = alloc(count, GFP_KERNEL);
+	if (tmp == NULL)
+		return -ENOMEM;
+
+	ret = spi_read( dev, 0, tmp, count);
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
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+	unsigned long (*cpy_from_user) (void *to, const void *from_user,
+					unsigned long len);
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+
+	cpy_from_user =
+	    dev->copy_from_user ? dev->copy_from_user : copy_from_user;
+	alloc = dev->alloc ? dev->alloc : kmalloc;
+	free = dev->free ? dev->free : kfree;
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
+	pr_debug("spi-%d writing %d bytes.\n", MINOR(file->f_dentry->d_inode->i_rdev), count);
+	ret = spi_write( dev, 0, tmp, count);
+	free(tmp);
+	return ret;
+}
+
+struct spidev_openclose {
+	unsigned int minor;
+	struct file *file;
+};
+
+static int spidev_do_open(struct device *the_dev, void *context)
+{
+	struct spidev_openclose *o = (struct spidev_openclose *) context;
+	struct spi_device *dev = SPI_DEV(the_dev);
+	struct spidev_driver_data *drvdata;
+
+	drvdata = (struct spidev_driver_data *) dev_get_drvdata(the_dev);
+	if (NULL == drvdata) {
+		pr_debug("%s: oops, drvdata is NULL !\n", __FUNCTION__);
+		return 0;
+	}
+
+	pr_debug("drvdata->minor = %d vs %d\n", drvdata->minor, o->minor);
+	if (drvdata->minor == o->minor) {
+		get_device(&dev->dev);
+		o->file->private_data = dev;
+		return 1;
+	}
+	return 0;
+}
+
+int spidev_open(struct inode *inode, struct file *file)
+{
+	struct spidev_openclose o;
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
+	struct spi_device *dev = file->private_data;
+
+	if (dev) {
+		put_device(&dev->dev);
+	}
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static int __init spidev_init(void)
+{
+	int res;
+
+	if (0 != (res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops))) {
+		goto out;
+	}
+
+	spidev_class = class_simple_create(THIS_MODULE, "spi" );
+	if ( IS_ERR( spidev_class)) {
+		printk( KERN_ERR"%s: error creating class\n", __FUNCTION__ );
+		res = -EINVAL;
+		goto out_unreg;
+	}
+
+	if (0 != (res = spi_driver_add(&spidev_driver))) {
+		goto out_unreg;
+	}
+	
+	printk( "SPI /dev entries driver.\n" );
+
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
+	spi_driver_del(&spidev_driver);
+	class_simple_destroy( spidev_class );
+	unregister_chrdev(SPI_MAJOR, "spi");
+}
+
+MODULE_AUTHOR( "dmitry pervushin <dpervushin@ru.mvista.com>" );
+MODULE_DESCRIPTION("SPI /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(spidev_init);
+module_exit(spidev_cleanup);
Index: linux-2.6.10/drivers/spi/spi_locals.h
===================================================================
--- linux-2.6.10.orig/drivers/spi/spi_locals.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/drivers/spi/spi_locals.h	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,10 @@
+#ifndef __SPI_LOCAL_H
+#define __SPI_LOCAL_H
+
+#define SPI_DRV( n ) container_of( n, struct spi_driver, driver )
+#define SPI_DEV( n ) container_of( n, struct spi_device, dev )
+
+#define ENTER() pr_debug( "%s: ENTERed\n", __FUNCTION__ )
+#define LEAVE() pr_debug( "%s: LEFT OUT\n", __FUNCTION__ )
+
+#endif				/* __SPI_LOCAL_H */
Index: linux-2.6.10/include/linux/spi.h
===================================================================
--- linux-2.6.10.orig/include/linux/spi.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/include/linux/spi.h	2005-07-15 06:57:39.000000000 +0000
@@ -0,0 +1,148 @@
+/*
+ *  linux/include/linux/spi/spi.h
+ *
+ *  Copyright (C) 2005 MontaVista Software
+ *  Author: dmitry pervushin <dpervushin@ru.mvista.com>
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
+struct spi_driver;
+struct spi_device;
+struct spi_bus;
+
+int spi_bus_register( struct spi_bus*, char* name );
+void spi_bus_unregister( struct spi_bus* );
+struct spi_bus* spi_bus_find( char* id );
+
+int spi_device_add( struct spi_bus*, struct spi_device*, char* name );
+void spi_device_del( struct spi_device* );
+
+int spi_driver_add( struct spi_driver* );
+void spi_driver_del( struct spi_driver* );
+
+struct spi_ops {
+	int (*open) (struct spi_driver *);
+	int (*command) (struct spi_driver *, int cmd, void *arg);
+	void (*close) (struct spi_driver *);
+};
+
+#define SPI_ID_ANY "* ANY *"
+
+struct spi_driver {
+	struct spi_ops *ops;
+	struct module *owner;
+	struct device_driver driver;
+	unsigned int minor;
+	char *(*supported_ids)[];
+};
+
+#define TO_SPI_BUS( bus ) container_of( bus, struct spi_bus, the_bus )
+#define TO_SPI_BUS_PLDEV( dev ) container_of( dev, struct spi_bus, platform_device )
+struct spi_bus
+{
+	struct bus_type the_bus;
+	struct platform_device platform_device;
+	struct list_head bus_list;
+	struct semaphore lock;
+	int (*xfer)( struct spi_bus* this, struct spi_device* device, struct spi_msg msgs[], int num, int flags );
+	int (*chip_cs)( int op, void* context );
+	struct resource *rsrc;
+};
+
+#define SPI_DEVICE( dev ) container_of( dev, struct spi_device, dev )
+struct spi_device {
+
+	void* bus_data;
+	void* drv_data;
+
+	struct semaphore lock;
+
+	void (*select)( int op, struct spi_device* this );
+
+	void *(*alloc) (size_t, int);
+	void (*free) (const void *);
+	unsigned long (*copy_from_user) (void *to, const void *from_user,
+					 unsigned long len);
+	unsigned long (*copy_to_user) (void *to_user, const void *from,
+				       unsigned long len);
+	
+	struct device dev;
+};
+
+struct spidev_driver_data {
+	unsigned int minor;
+	void *private_data;
+};
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
+extern int spi_write(struct spi_device *dev, int addr, const char *buf, int len);
+extern int spi_read(struct spi_device *dev, int addr, char *buf, int len);
+
+
+#endif				/* SPI_H */


