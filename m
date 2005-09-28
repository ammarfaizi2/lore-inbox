Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVI1NOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVI1NOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVI1NOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:14:34 -0400
Received: from [85.21.88.2] ([85.21.88.2]:35535 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750952AbVI1NOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:14:33 -0400
Subject: [PATCH] SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Greg KH <greg@kroah.com>, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <20050927145442.GA27470@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <20050927124335.GA10361@kroah.com>
	 <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
	 <20050927143505.GA24245@kroah.com>
	 <1127832597.7577.37.camel@diimka.dev.rtsoft.ru>
	 <20050927145442.GA27470@kroah.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 17:14:22 +0400
Message-Id: <1127913262.7577.54.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

Here is the revised SPI-core patch. Changes are as follows:
- spi_device_add now allocates and returns struct spi_device* instead of
taking caller-allocated spi_device* as parameter;
- spi_device_release changed to deallocate spi_device* allocated by call
to spi_device_add;
- new function spi_bus_populate2; it populates bus in the same manner as
spi_bus_populate does, but parameter is array of struct spi_device_desc
instead of string delimited by '\0's;
- code style fixes;
- documentation fixes.

-----------------8<- cut here ------------------------------------
The supplied patch is starting point for implementing drivers for
various SPI busses as well as devices connected to these busses.
Currently, the SPI core supports only for MASTER mode for systems
running Linux.

 Documentation/spi.txt  |  374 ++++++++++++++++++++++++++++++++++++
 arch/arm/Kconfig       |    2
 drivers/Kconfig        |    2
 drivers/Makefile       |    1
 drivers/spi/Kconfig    |   33 +++
 drivers/spi/Makefile   |   14 +
 drivers/spi/spi-core.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dev.c  |  219 +++++++++++++++++++++
 include/linux/spi.h    |  232 ++++++++++++++++++++++

Signed-off-by: dmitry pervushin <dpervushin@ru.mvista.com>

PATCH FOLLOWS
Index: linux-2.6.10/arch/arm/Kconfig
===================================================================
--- linux-2.6.10.orig/arch/arm/Kconfig
+++ linux-2.6.10/arch/arm/Kconfig
@@ -834,6 +834,8 @@ source "drivers/ssi/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "ktools/Kconfig"
Index: linux-2.6.10/drivers/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/Kconfig
+++ linux-2.6.10/drivers/Kconfig
@@ -42,6 +42,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/misc/Kconfig"
Index: linux-2.6.10/drivers/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/Makefile
+++ linux-2.6.10/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_DPM)		+= dpm/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-y				+= firmware/
 obj-$(CONFIG_EVENT_BROKER)	+= evb/
+obj-$(CONFIG_SPI)		+= spi/
Index: linux-2.6.10/drivers/spi/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/Kconfig
@@ -0,0 +1,33 @@
+#
+# SPI device configuration
+#
+menu "SPI support"
+
+config SPI
+	default Y
+	tristate "SPI (Serial Peripheral Interface) bus support"
+        default false
+	help
+	  Say Y if you need to enable SPI support on your kernel.
+ 	  Say M if you want to create the spi-core loadable module.
+
+config SPI_DEBUG
+	bool "SPI debug output"
+	depends on SPI
+	default false
+	help
+          Say Y there if you'd like to see debug output from SPI drivers
+	  If unsure, say N
+
+config SPI_CHARDEV
+	default Y
+	tristate "SPI device interface"
+	depends on SPI
+	help
+	  Say Y here to use /dev/spiNN device files. They make it possible to have user-space
+	  programs use the SPI bus.
+	  This support is also available as a module.  If so, the module
+	  will be called spi-dev.
+
+endmenu
+
Index: linux-2.6.10/drivers/spi/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+obj-$(CONFIG_SPI) += spi-core.o
+# bus drivers
+# ...functional drivers
+# ...and the common spi-dev driver
+obj-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+
+ifeq ($(CONFIG_SPI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
Index: linux-2.6.10/drivers/spi/spi-core.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spi-core.c
@@ -0,0 +1,506 @@
+/*
+ *  drivers/spi/spi-core.c
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
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
+#include <linux/wait.h>
+#include <linux/kthread.h>
+#include <linux/spi.h>
+#include <asm/atomic.h>
+
+static int spi_thread(void *context);
+
+/*
+ * spi_bus_match_name
+ *
+ * Drivers and devices on SPI bus are matched by name, just like the
+ * platform devices, with exception of SPI_DEV_CHAR. Driver with this name
+ * will be matched against any device
+ */
+static int spi_bus_match_name(struct device *dev, struct device_driver *drv)
+{
+	return !strcmp(drv->name, SPI_DEV_CHAR) ||
+	    !strcmp(TO_SPI_DEV(dev)->name, drv->name);
+}
+
+struct bus_type spi_bus = {
+	.name = "spi",
+	.match = spi_bus_match_name,
+};
+
+/*
+ * spi_bus_driver_init
+ *
+ * This function initializes the spi_bus_data structure for the
+ * bus. Functions has to be called when bus driver gets probed
+ *
+ * Parameters:
+ * 	spi_bus_driver* 	pointer to bus driver structure
+ * 	device*			platform device to be attached to
+ * Return value:
+ * 	0 on success, error code otherwise
+ */
+int spi_bus_driver_init(struct spi_bus_driver *bus, struct device *dev)
+{
+	struct spi_bus_data *pd =
+	    kmalloc(sizeof(struct spi_bus_data), GFP_KERNEL);
+	int err = 0;
+
+	if (!pd) {
+		err = -ENOMEM;
+		goto init_failed_1;
+	}
+	atomic_set(&pd->exiting, 0);
+	pd->bus = bus;
+	init_MUTEX(&pd->lock);
+	INIT_LIST_HEAD(&pd->msgs);
+	init_waitqueue_head(&pd->queue);
+	pd->thread = kthread_run(spi_thread, pd, "%s-work", dev->bus_id);
+	if (IS_ERR(pd->thread)) {
+		err = PTR_ERR(pd->thread);
+		goto init_failed_2;
+	}
+	dev->platform_data = pd;
+	return 0;
+
+init_failed_2:
+	kfree(pd);
+      init_failed_1:
+	return err;
+}
+
+/*
+ * __spi_bus_free
+ *
+ * This function called as part of unregistering bus device driver. It
+ * calls spi_device_del for each child (SPI) device on the bus
+ *
+ * Parameters:
+ * 	struct device* dev	the 'bus' device
+ * 	void* context		not used. Will be NULL
+ */
+int __spi_bus_free(struct device *dev, void *context)
+{
+	struct spi_bus_data *pd = dev->platform_data;
+
+	atomic_inc(&pd->exiting);
+	kthread_stop(pd->thread);
+	kfree(pd);
+
+	dev_dbg(dev, "unregistering children\n");
+	/*
+	 * NOTE: the loop below might needs redesign. Currently
+	 *       we delete devices from the head of children list
+	 *       until the list is empty; that's because the function
+	 *       device_for_each_child will hold the semaphore needed
+	 *       for deletion of device
+	 */
+	while (!list_empty(&dev->children)) {
+		struct device *child =
+		    list_entry(dev->children.next, struct device, node);
+		spi_device_del(TO_SPI_DEV(child));
+	}
+	return 0;
+}
+
+/*
+ * spi_bus_driver_unregister
+ *
+ * unregisters the SPI bus from the system. Before unregistering, it deletes
+ * each SPI device on the bus using call to __spi_device_free
+ *
+ * Parameters:
+ *  	struct spi_bus_driver* bus_driver	the bus driver
+ * Return value:
+ *  	void
+ */
+void spi_bus_driver_unregister(struct spi_bus_driver *bus_driver)
+{
+	if (bus_driver) {
+		driver_for_each_dev(&bus_driver->driver, NULL, __spi_bus_free);
+		driver_unregister(&bus_driver->driver);
+	}
+}
+
+/*
+ * spi_device_release
+ *
+ * Pointer to this function will be put to dev->release place
+ * This function gets called as a part of device removing
+ *
+ * Parameters:
+ * 	struct device* dev
+ * Return value:
+ * 	none
+ */
+void spi_device_release(struct device *dev)
+{
+	struct spi_device* sdev = TO_SPI_DEV(dev);
+
+	kfree( sdev );
+}
+
+/*
+ * spi_device_add
+ *
+ * Add the new (discovered) SPI device to the bus. Mostly used by bus drivers
+ *
+ * Parameters:
+ * 	struct device* parent		the 'bus' device
+ * 	char* name			name of device. Should not be NULL
+ * Return value:
+ * 	pointer to allocated spi_device structure; NULL on error
+ */
+struct spi_device* spi_device_add(struct device *parent, char *name)
+{
+	struct spi_device* dev;
+
+	if (!name)
+		goto dev_add_out;
+
+	dev = kmalloc(sizeof(struct spi_device), GFP_KERNEL);
+	if( !dev )
+		goto dev_add_out;
+
+	memset(&dev->dev, 0, sizeof(dev->dev));
+	dev->dev.parent = parent;
+	dev->dev.bus = &spi_bus;
+	strncpy(dev->name, name, sizeof(dev->name));
+	strncpy(dev->dev.bus_id, name, sizeof(dev->dev.bus_id));
+	dev->dev.release = spi_device_release;
+
+	if (device_register(&dev->dev)<0) {
+		dev_dbg(parent, " device '%s' cannot be added\n", name);
+		goto dev_add_out_2;
+	}
+	return dev;
+
+dev_add_out_2:
+	kfree(dev);
+dev_add_out:
+	return NULL;
+}
+
+/*
+ * spi_queue
+ *
+ * Queue the message to be processed asynchronously
+ *
+ * Parameters:
+ *  	struct spi_msg* msg            message to be sent
+ * Return value:
+ *  	0 on no errors, negative error code otherwise
+ */
+int spi_queue(struct spi_msg *msg)
+{
+	struct device *dev = &msg->device->dev;
+	struct spi_bus_data *pd = dev->parent->platform_data;
+
+	down(&pd->lock);
+	list_add_tail(&msg->link, &pd->msgs);
+	dev_dbg(dev->parent, "message has been queued\n");
+	up(&pd->lock);
+	wake_up_interruptible(&pd->queue);
+	return 0;
+}
+
+/*
+ * __spi_transfer_callback
+ *
+ * callback for synchronously processed message. If spi_transfer determines
+ * that there is no callback provided neither by msg->status nor callback
+ * parameter, the __spi_transfer_callback will be used, and spi_transfer
+ * does not return until transfer is finished
+ *
+ * Parameters:
+ * 	struct spimsg* msg	message that is being processed now
+ * 	int code		status of processing
+ */
+static void __spi_transfer_callback(struct spi_msg *msg, int code)
+{
+	if (code & (SPIMSG_OK | SPIMSG_FAILED))
+		complete((struct completion *)msg->context);
+}
+
+/*
+ * spi_transfer
+ *
+ * Process the SPI message, by queuing it to the driver and either
+ * immediately return or waiting till the end-of-processing
+ *
+ * Parameters:
+ * 	struct spi_msg* msg	message to process
+ * 	callback		user-supplied callback. If both msg->status and
+ * 				callback are set, the error code of -EINVAL
+ * 				will be returned
+ * Return value:
+ * 	0 on success, error code otherwise. This code does not reflect
+ * 	status of message, just status of queueing
+ */
+int spi_transfer(struct spi_msg *msg, void (*callback) (struct spi_msg *, int))
+{
+	struct completion msg_done;
+	int err = -EINVAL;
+
+	if (callback && !msg->status) {
+		msg->status = callback;
+		callback = NULL;
+	}
+
+	if (!callback) {
+		if (!msg->status) {
+			init_completion(&msg_done);
+			msg->context = &msg_done;
+			msg->status = __spi_transfer_callback;
+			spi_queue(msg);
+			wait_for_completion(&msg_done);
+			err = 0;
+		} else {
+			err = spi_queue(msg);
+		}
+	}
+
+	return err;
+}
+
+/*
+ * spi_thread
+ *
+ * This function is started as separate thread to perform actual
+ * transfers on SPI bus
+ *
+ * Parameters:
+ *	void* context 		pointer to struct spi_bus_data
+ */
+static int spi_thread_awake(struct spi_bus_data *bd)
+{
+	int ret;
+
+	if (atomic_read(&bd->exiting)) {
+		return 1;
+	}
+	down(&bd->lock);
+	ret = !list_empty(&bd->msgs);
+	up(&bd->lock);
+	return ret;
+}
+
+static int spi_thread(void *context)
+{
+	struct spi_bus_data *bd = context;
+	struct spi_msg *msg;
+	int xfer_status;
+	int found;
+
+	while (!kthread_should_stop()) {
+
+		wait_event_interruptible(bd->queue, spi_thread_awake(bd));
+
+		if (atomic_read(&bd->exiting))
+			goto thr_exit;
+
+		down(&bd->lock);
+		while (!list_empty(&bd->msgs)) {
+			/*
+			 * this part is locked by bus_data->lock,
+			 * to protect spi_msg extraction
+			 */
+			found = 0;
+			list_for_each_entry(msg, &bd->msgs, link) {
+				if (!bd->selected_device) {
+					bd->selected_device = msg->device;
+					if (bd->bus->select)
+						bd->bus->select(bd->
+								selected_device);
+					found = 1;
+					break;
+				}
+				if (msg->device == bd->selected_device) {
+					found = 1;
+					break;
+				}
+			}
+			if (!found) {
+				/*
+				 * all messages for current selected_device
+				 * are processed.
+				 * let's switch to another device
+				 */
+				msg =
+				    list_entry(bd->msgs.next, struct spi_msg,
+					       link);
+				if (bd->bus->deselect)
+					bd->bus->deselect(bd->selected_device);
+				bd->selected_device = msg->device;
+				if (bd->bus->select)
+					bd->bus->select(bd->selected_device);
+			}
+			list_del(&msg->link);
+			up(&bd->lock);
+
+			/*
+			 * and this part is locked by device's lock;
+			 * spi_queue will be able to queue new
+			 * messages
+			 */
+			spi_device_lock(&msg->device);
+			if (msg->status)
+				msg->status(msg, SPIMSG_STARTED);
+			if (bd->bus->set_clock && msg->clock)
+				bd->bus->set_clock(msg->device->dev.parent,
+						   msg->clock);
+			xfer_status = bd->bus->xfer(msg);
+			if (msg->status) {
+				msg->status(msg, SPIMSG_DONE);
+				msg->status(msg,
+					    xfer_status ? SPIMSG_OK :
+					    SPIMSG_FAILED);
+			}
+			spi_device_unlock(&msg->device);
+
+			/* lock the bus_data again... */
+			down(&bd->lock);
+		}
+		if (bd->bus->deselect)
+			bd->bus->deselect(bd->selected_device);
+		bd->selected_device = NULL;
+		/* device has been just deselected, unlocking the bus */
+		up(&bd->lock);
+	}
+thr_exit:
+	return 0;
+}
+
+/*
+ * spi_write
+ * 	send data to a device on an SPI bus
+ * Parameters:
+ * 	spi_device* dev		the target device
+ *	char* buf		buffer to be sent
+ *	int len			buffer length
+ * Return:
+ * 	the number of bytes transferred, or negative error code.
+ */
+int spi_write(struct spi_device *dev, const char *buf, int len)
+{
+	struct spi_msg *msg = spimsg_alloc(dev, SPI_M_WR, len, NULL);
+	int ret;
+
+	memcpy(spimsg_buffer_wr(msg), buf, len);
+	ret = spi_transfer(msg, NULL);
+	return ret == 1 ? len : ret;
+}
+
+/*
+ * spi_write
+ * 	receive data from a device on an SPI bus
+ * Parameters:
+ * 	spi_device* dev		the target device
+ *	char* buf		buffer to be sent
+ *	int len			number of bytes to receive
+ * Return:
+ * 	 the number of bytes transferred, or negative error code.
+ */
+int spi_read(struct spi_device *dev, char *buf, int len)
+{
+	int ret;
+	struct spimsg *msg = spimsg_alloc(dev, SPI_M_RD, len, NULL);
+
+	ret = spi_transfer(msg, NULL);
+	memcpy(buf, spimsg_buffer_rd(msg), len);
+	return ret == 1 ? len : ret;
+}
+
+/*
+ * spi_bus_populate and spi_bus_populate2
+ *
+ * These two functions intended to populate the SPI bus corresponding to
+ * device passed as 1st parameter. The difference is in the way to describe
+ * new SPI slave devices: the spi_bus_populate takes the ASCII string delimited
+ * by '\0', where each section matches one SPI device name _and_ its parameters,
+ * and the spi_bus_populate2 takes the array of structures spi_device_desc.
+ *
+ * If some device cannot be added because of spi_device_add fail, the function will
+ * not try to parse the rest of list
+ *
+ * Return:
+ * 	the number of devices that were successfully added
+ */
+int spi_bus_populate(struct device *parent,
+		     char *devices,
+		     void (*callback) (struct device * bus,
+				       struct spi_device * new_dev))
+{
+	struct spi_device *new_device;
+	int count = 0;
+
+	while (devices[0]) {
+		dev_dbg(parent, " discovered new SPI device, name '%s'\n",
+			devices);
+		if ((new_device = spi_device_add(parent, devices)) == NULL)
+			break;
+		if (callback)
+			callback(parent, new_device);
+		devices += (strlen(devices) + 1);
+		count++;
+	}
+	return count;
+}
+
+int spi_bus_populate2(struct device *parent,
+			struct spi_device_desc* devices,
+			void (*callback) (struct device* bus,
+					  struct spi_device *new_dev,
+					  void* params))
+{
+	struct spi_device *new_device;
+	int count = 0;
+
+	while (devices->name) {
+		dev_dbg(parent, " discovered new SPI device, name '%s'\n",
+				devices->name );
+		if ((new_device = spi_device_add(parent, devices->name)) == NULL)
+			break;
+		if (callback)
+			callback(parent, new_device, devices->params);
+		devices++;
+		count++;
+	}
+	return count;
+}
+
+int __init spi_core_init(void)
+{
+	return bus_register(&spi_bus);
+}
+
+subsys_initcall(spi_core_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+
+EXPORT_SYMBOL_GPL(spi_queue);
+EXPORT_SYMBOL_GPL(spi_device_add);
+EXPORT_SYMBOL_GPL(spi_bus_driver_unregister);
+EXPORT_SYMBOL_GPL(spi_bus_populate);
+EXPORT_SYMBOL_GPL(spi_bus_populate2);
+EXPORT_SYMBOL_GPL(spi_transfer);
+EXPORT_SYMBOL_GPL(spi_write);
+EXPORT_SYMBOL_GPL(spi_read);
+EXPORT_SYMBOL_GPL(spi_bus);
+EXPORT_SYMBOL_GPL(spi_bus_driver_init);
Index: linux-2.6.10/drivers/spi/spi-dev.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/spi/spi-dev.c
@@ -0,0 +1,219 @@
+/*
+    spi-dev.c - spi driver, char device interface
+
+    Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
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
+
+#define SPI_TRANSFER_MAX	65535L
+
+struct spidev_driver_data {
+	int minor;
+};
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
+	.driver = {
+		   .name = SPI_DEV_CHAR,
+		   .probe = spidev_probe,
+		   .remove = spidev_remove,
+		   },
+};
+
+static int spidev_minor;
+
+static int spidev_probe(struct device *dev)
+{
+	struct spidev_driver_data *drvdata;
+
+	drvdata = kmalloc(sizeof(struct spidev_driver_data), GFP_KERNEL);
+	if (!drvdata) {
+		dev_dbg(dev, "allocating drvdata failed\n");
+		return -ENOMEM;
+	}
+
+	drvdata->minor = spidev_minor++;
+	dev_dbg(dev, "setting device's(%p) minor to %d\n", dev, drvdata->minor);
+	dev_set_drvdata(dev, drvdata);
+
+	class_simple_device_add(spidev_class,
+				MKDEV(SPI_MAJOR, drvdata->minor),
+				NULL, "spi%d", drvdata->minor);
+	dev_dbg(dev, " added\n");
+	return 0;
+}
+
+static int spidev_remove(struct device *dev)
+{
+	struct spidev_driver_data *drvdata;
+
+	drvdata = (struct spidev_driver_data *)dev_get_drvdata(dev);
+	class_simple_device_remove(MKDEV(SPI_MAJOR, drvdata->minor));
+	kfree(drvdata);
+	dev_dbg(dev, " removed\n");
+	return 0;
+}
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset)
+{
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+	return spi_read(dev, buf, count);
+}
+
+static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
+			    loff_t * offset)
+{
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+	if (count > SPI_TRANSFER_MAX)
+		count = SPI_TRANSFER_MAX;
+	return spi_write(dev, buf, count);
+}
+
+struct spidev_openclose {
+	unsigned int minor;
+	struct file *file;
+};
+
+static int spidev_do_open(struct device *the_dev, void *context)
+{
+	struct spidev_openclose *o = (struct spidev_openclose *)context;
+	struct spi_device *dev = TO_SPI_DEV(the_dev);
+	struct spidev_driver_data *drvdata;
+
+	drvdata = (struct spidev_driver_data *)dev_get_drvdata(the_dev);
+	if (!drvdata) {
+		pr_debug("%s: oops, drvdata is NULL !\n", __FUNCTION__);
+		goto do_open_fail;
+	}
+
+	pr_debug("drvdata->minor = %d vs %d\n", drvdata->minor, o->minor);
+	if (drvdata->minor == o->minor) {
+		get_device(&dev->dev);
+		o->file->private_data = dev;
+		return 1;
+	}
+
+do_open_fail:
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
+	if (dev)
+		put_device(&dev->dev);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static int __init spidev_init(void)
+{
+	int res;
+
+	if ((res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops)) != 0) {
+		goto out;
+	}
+
+	spidev_class = class_simple_create(THIS_MODULE, "spi");
+	if (IS_ERR(spidev_class)) {
+		printk(KERN_ERR "%s: error creating class\n", __FUNCTION__);
+		res = -EINVAL;
+		goto out_unreg;
+	}
+
+	if ((res = spi_driver_add(&spidev_driver)) != 0)
+		goto out_unreg;
+
+	printk("SPI /dev entries driver.\n");
+	return 0;
+
+out_unreg:
+	unregister_chrdev(SPI_MAJOR, "spi");
+out:
+	printk(KERN_ERR "%s: Driver initialization failed\n", __FILE__);
+	return res;
+}
+
+static void spidev_cleanup(void)
+{
+	spi_driver_del(&spidev_driver);
+	class_simple_destroy(spidev_class);
+	unregister_chrdev(SPI_MAJOR, "spi");
+}
+
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+MODULE_DESCRIPTION("SPI /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(spidev_init);
+module_exit(spidev_cleanup);
Index: linux-2.6.10/Documentation/spi.txt
===================================================================
--- /dev/null
+++ linux-2.6.10/Documentation/spi.txt
@@ -0,0 +1,374 @@
+Documentation/spi.txt
+========================================================
+Table of contents
+1. Introduction -- what is SPI ?
+2. Purposes of this code
+3. SPI devices stack
+3.1 SPI outline
+3.2 How the SPI devices gets discovered and probed ?
+3.3 DMA and SPI messages
+4. SPI functions and structures reference
+5. How to contact authors
+========================================================
+
+1. What is SPI ?
+----------------
+SPI stands for "Serial Peripheral Interface", a full-duplex synchronous
+serial interface for connecting low-/medium-bandwidth external devices
+using four wires. SPI devices communicate using a master/slave relation-
+ship over two data lines and two control lines:
+- Master Out Slave In (MOSI): supplies the output data from the master
+  to the inputs of the slaves;
+- Master In Slave Out (MISO): supplies the output data from a slave to
+  the input of the master. It is important to note that there can be no
+  more than one slave that is transmitting data during any particular
+  transfer;
+- Serial Clock (SCLK): a control line driven by the master, regulating
+  the flow of data bits;
+- Slave Select (SS): a control line that allows slaves to be turned on
+  and off with  hardware control.
+More information is also available at http://en.wikipedia.org/wiki/Serial_Peripheral_Interface
+
+2. Purposes of this code
+------------------------
+The supplied patch is starting point for implementing drivers for various
+SPI busses as well as devices connected to these busses. Currently, the
+SPI core supports only for MASTER mode for system running Linux.
+
+3. SPI devices stack
+--------------------
+
+3.1 The SPI outline
+
+The SPI infrastructure deals with several levels of abstraction. They are
+"SPI bus", "SPI bus driver", "SPI slave device" and "SPI device driver". The
+"SPI bus" is hardware device, which usually called "SPI adapter", and has
+"SPI slave devices" connected. From the Linux' point of view, the "SPI bus" is
+structure of type platform_device, and "SPI slave device" is structure of type
+spi_device. The "SPI bus driver" is the driver which controls the whole
+SPI bus (and, particularly, creates and destroys "SPI slave devices" on the bus),
+and "SPI device driver" is driver that controls the only device on the SPI
+bus, controlled by "SPI bus driver". "SPI device driver" can indirectly
+call "SPI bus driver" to send/receive messages using API provided by SPI
+core, and provide its own interface to the kernel and/or userland.
+So, the device stack looks as follows:
+
+  +--------------+                    +---------+
+  | platform_bus |                    | spi_bus |
+  +--------------+                    +---------+
+       |..|                                |
+       |..|--------+               +---------------+
+     +------------+| is parent to  |  SPI devices  |
+     | SPI busses |+-------------> |               |
+     +------------+                +---------------+
+           |                               |
+     +----------------+          +----------------------+
+     | SPI bus driver |          |    SPI device driver |
+     +----------------+          +----------------------+
+
+3.2 How do the SPI devices gets discovered and probed ?
+
+In general, the SPI bus driver cannot effective discover devices
+on its bus. Fortunately, the devices on SPI bus usually implemented
+onboard, so the following method has been chosen: the SPI bus driver
+calls the function named spi_bus_populate and passed the `topology
+string' to it. The function will parse the string and call the callback
+for each device, just before registering it. This allows bus driver
+to determine parameters like CS# for each device, retrieve them from
+string and store somewhere like spi_device->platform_data. An example:
+	err = spi_bus_populate( the_spi_bus,
+			"Dev1 0 1 2\0" "Dev2 2 1 0\0",
+			extract_name )
+In this example, function like extract_name would put the '\0' on the
+1st space of device's name, so names will become just "Dev1", "Dev2",
+and the rest of string will become parameters of device.
+
+The another way is to create array of structures spi_device_desc and pass
+this array to function spi_bus_populate2, like this:
+  struct spi_device_desc spi_slaves[] = {
+    [0] = {
+	.name = "device1",
+        .param = device1_params,
+    },
+    [1] = {
+        .name = "device2",
+        .param = NULL,
+    }
+    [2] = {
+	NULL, NULL
+    };
+  spi_bus_populate2( the_spi_bus, spi_slaves, callback );
+
+3.3. DMA and SPI messages
+-------------------------
+
+To handle DMA transfers on SPI bus, any device driver might provide special
+callbacks to allocate/free/get access to buffer. These callbacks are defined
+in subsection iii of section 4.
+To send data using DMA, the buffers should be allocated using
+dma_alloc_coherent function. Usually buffers are allocated statically or
+using kmalloc function.
+To allow drivers to allocate buffers in non-standard
+When one allocates the structure for spi message, it needs to provide target
+device. If its driver wants to allocate buffer in driver-specific way, it may
+provide its own allocation/free methods: alloc and free. If driver does not
+provide these methods, kmalloc and kfree will be used.
+After allocation, the buffer must be accessed to copy the buffer to be send
+or retrieve buffer that has been just received from device. If buffer was
+allocated using driver's alloc method, it(buffer) will be accessed using
+get_buffer. Driver should provide accessible buffer that corresponds buffer
+allocated by driver's alloc method. If there is no get_buffer method,
+the result of alloc will be used.
+After reading/writing from/to buffer, it will be released by call to driver's
+release_buffer method.
+
+
+4. SPI functions are structures reference
+-----------------------------------------
+This section describes structures and functions that listed
+in include/linux/spi.h
+
+i. struct spi_msg
+~~~~~~~~~~~~~~~~~
+
+struct spi_msg {
+        unsigned char flags;
+        unsigned short len;
+        unsigned long clock;
+        struct spi_device* device;
+        void          *context;
+        struct list_head link;
+        void (*status)( struct spi_msg* msg, int code );
+        void *devbuf_rd, *devbuf_wr;
+        u8 *databuf_rd, *databuf_wr;
+};
+This structure represents the message that SPI device driver sends to the
+SPI bus driver to handle.
+Fields:
+	flags 	combination of message flags
+		SPI_M_RD	"read" operation (from device to host)
+		SPI_M_WR	"write" operation (from host to device)
+		SPI_M_CS	assert the CS signal before sending the message
+		SPI_M_CSREL	clear the CS signal after sending the message
+		SPI_M_CSPOL	set clock polarity to high
+		SPI_M_CPHA	set clock phase to high
+	len	length, in bytes, of allocated buffer
+	clock	reserved, set to zero
+	device	the target device of the message
+	context	user-defined field; to associate any user data with the message
+	link	used by bus driver to queue messages
+	status	user-provided callback function to inform about message flow
+	devbuf_rd, devbuf_wr
+		so-called "device buffers". These buffers allocated by the
+		device driver, if device driver provides approproate callback.
+		Otherwise, the kmalloc API will be used.
+	databuf_rd, databuf_wr
+		pointers to access content of device buffers. They are acquired
+		using get_buffer callback, if device driver provides one.
+		Otherwise, they are just pointers to corresponding
+		device buffers
+
+struct spi_msg* spimsg_alloc( struct spi_device* device,
+                              unsigned flags,
+                              unsigned short len,
+                              void (*status)( struct spi_msg*, int code ) )
+This functions is called to allocate the spi_msg structure and set the
+corresponding fields in structure. If device->platform_data provides callbacks
+to handle buffers, alloc/get_buffer are to be used. Returns NULL on errors.
+
+struct void spimsg_free( struct spi_msg* msg )
+Deallocate spi_msg as well as internal buffers. If msg->device->platform_data
+provides callbacks to handle buffers, release_buffer and free are to be used.
+
+u8* spimsg_buffer_rd( struct spi_msg* msg )
+u8* spimsg_buffer_wr( struct spi_msg* msg )
+u8* spimsg_buffer( struct spi_msg* )
+Return the corresponding data buffer, which can be directly modified by driver.
+spimsg_buffer checks flags and return either databuf_rd or databuf_wr basing on
+value of `flags' in spi_msg structure.
+
+ii. struct spi_device
+~~~~~~~~~~~~~~~~~~~~~
+
+struct spi_device
+{
+        char name[ BUS_ID_SIZE ];
+        struct device dev;
+};
+This structure represents the physical device on SPI bus. The SPI bus driver
+will create and register this structure for you.
+	name	the name of the device. It should match to the SPI device
+		driver name
+	dev	field used to be registered with core
+
+struct spi_device* spi_device_add( struct device* parent,
+                    		   char* name )
+This function registers the device on the spi bus, and set its parent
+to `parent', which represents the SPI bus. The device name will be set to name,
+that should be non-empty, non-NULL string. Returns pointer to allocated
+spi_device structure, NULL on error.
+
+void spi_device_del( struct spi_device* dev )
+Unregister the SPI device. Return value is ignored
+
+iii. struct spi_driver
+~~~~~~~~~~~~~~~~~~~~~~
+
+struct spi_driver {
+    	void* (*alloc)( size_t, int );
+    	void  (*free)( const void* );
+    	unsigned char* (*get_buffer)( struct spi_device*, void* );
+    	void (*release_buffer)( struct spi_device*, unsigned char*);
+    	void (*control)( struct spi_device*, int mode, u32 ctl );
+        struct device_driver driver;
+};
+This structure represents the SPI device driver object. Before registering,
+all fields of driver sub-structure should be properly filled, e.g., the
+`bus_type' should be set to spi_bus. Otherwise, the driver will be incorrectly
+registered and its callbacks might never been called. An example of will-
+formed spi_driver structure:
+	extern struct bus_type spi_bus;
+	static struct spi_driver pnx4008_eeprom_driver = {
+        	.driver = {
+                   	.bus = &spi_bus,
+                   	.name = "pnx4008-eeprom",
+                   	.probe = pnx4008_spiee_probe,
+                   	.remove = pnx4008_spiee_remove,
+                   	.suspend = pnx4008_spiee_suspend,
+                   	.resume = pnx4008_spiee_resume,
+               	},
+};
+The method control gets called during the processing of SPI message.
+For detailed description of malloc/free/get_buffer/release_buffer, please
+look to section 3.3, "DMA and SPI messages"
+
+
+int spi_driver_add( struct spi_driver* driver )
+Register the SPI device driver with core; returns 0 on no errors, error code
+otherwise.
+
+void spi_driver_del( struct spi_driver* driver )
+Unregisters the SPI device driver; return value ignored.
+
+iv. struct spi_bus_driver
+~~~~~~~~~~~~~~~~~~~~~~~~~
+To handle transactions over the SPI bus, the spi_bus_driver structure must
+be prepared and registered with core. Any transactions, either synchronous
+or asynchronous, go through spi_bus_driver->xfer function.
+
+struct spi_bus_driver
+{
+        int (*xfer)( struct spi_msg* msgs );
+        void (*select) ( struct spi_device* arg );
+        void (*deselect)( struct spi_device* arg );
+
+        struct device_driver driver;
+};
+
+Fields:
+	xfer	pointer to function to execute actual transaction on SPI bus
+		msg	message to handle
+	select	pointer to function that gets called when bus needs to
+		select another device to be target of transfers
+	deselect
+		pointer to function that gets called before another device
+		is selected to be the target of transfers
+
+
+spi_bus_driver_register( struct spi_bus_driver* )
+
+Register the SPI bus driver with the system. The driver sub-structure should
+be properly filled before using this function, otherwise you may get unpredi-
+ctable results when trying to exchange data. An example of correctly prepared
+spi_bus_driver structure:
+	static struct spi_bus_driver spipnx_driver = {
+        .driver = {
+                   .bus = &platform_bus_type,
+                   .name = "spipnx",
+                   .probe = spipnx_probe,
+                   .remove = spipnx_remove,
+                   .suspend = spipnx_suspend,
+                   .resume = spipnx_resume,
+                   },
+        .xfer = spipnx_xfer,
+};
+The driver and corresponding platform device are matched by name, so, in
+order the example abive to work, the platform_device named "spipnx" should
+be registered somewhere.
+
+void spi_bus_driver_unregister( struct spi_bus_driver* )
+
+Unregister the SPI bus driver registered by call to spi_buys_driver_register
+function; returns void.
+
+int spi_bus_populate( struct device* parent,
+			      char* devices,
+			      void (*callback)( struct device* parent, struct spi_device* new_one ) )
+This function usually called by SPI bus drivers in order to populate the SPI
+bus (see also section 3.2, "How the SPI devices gets discovered and probed ?").
+After creating the spi_device, the spi_bus_populate calls the `callback'
+function to allow to modify spi_device's fields before registering it with core.
+	parent	pointer to SPI bus
+	devices	string representing the current topology of SPI bus. It should
+		be formed like
+		"dev-1_and_its_info\0dev-2_and_its_info\0another_device\0\0"
+		the spi_bus_populate delimits this string by '\0' characters,
+		creates spi_device and after calling the callback registers the
+		spi_device
+	callback
+		pointer to function which could modify spi_device fields just
+		before registering them with core
+
+int spi_bus_populate2 (struct device *parent, struct spi_device_desc *devices,
+			void (*callback) (struct device* parent, struct spi_device* new_dev,
+					  void *params ))
+This is another way to populate the bus; but instead of string with device names and
+parameters, the array of structures spi_device_desc is passed. Each item in array describes
+the SPI slave device to create.
+
+
+v. spi_transfer and spi_queue
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver that uses SPI core can initiate transfers either by calling
+spi_transfer function (that will wait till the transfer is funished) or
+queueing the message using spi_queue function (you need to provide function
+that will be called during message is processed). In any way, you need to
+prepare the spimsg structure and know the target device to your message to
+be sent.
+
+int spi_transfer( struct spi_msg msgs,
+                  void (*callback)( struct spi_msg* msg, int ) )
+If callback is zero, start synchronous transfer. Otherwise, queue
+the message.
+	msg		message to be handled
+	callback	the callback function to be called during
+			message processing. If NULL, the function
+			will wait until end of processing.
+
+int spi_queue( struct spi_device* device,
+               struct spi_msg* msg )
+Queue the only message to the device. Returns status of queueing. To obtain
+status of message processing, you have to provide `status' callback in message
+and examine its parameters
+	msg	message to be queued
+
+vi. the spi_bus variable
+~~~~~~~~~~~~~~~~~~~~~~~~
+This variable is created during initialization of spi core, and has to be
+specified as `bus' on any SPI device driver (look to section iii, "struct
+spi_driver" ). If you do not specify spi_bus, your driver will be never
+matched to spi_device and never be probed with hardware. Note that
+spi_bus.match points to function that matches drivers and devices by name,
+so SPI devices and their drivers should have the same name.
+
+5. How to contact authors
+-------------------------
+Do you have any comments ? Enhancements ? Device driver ? Feel free
+to contact me:
+	dpervushin@gmail.com
+	dimka@pervushin.msk.ru
+Visit our project page:
+	http://spi-devel.sourceforge.net
+Subscribe to mailing list:
+	spi-devel-general@lists.sourceforge.net
+
Index: linux-2.6.10/include/linux/spi.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/linux/spi.h
@@ -0,0 +1,232 @@
+/*
+ *  linux/include/linux/spi/spi.h
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
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
+struct spi_device;
+struct spi_driver;
+struct spi_msg;
+struct spi_bus_driver;
+
+extern struct bus_type spi_bus;
+
+struct spi_bus_data {
+	struct semaphore lock;
+	struct list_head msgs;
+	atomic_t exiting;
+	struct task_struct *thread;
+	wait_queue_head_t queue;
+	struct spi_device *selected_device;
+	struct spi_bus_driver *bus;
+};
+
+#define TO_SPI_BUS_DRIVER(drv) container_of( drv, struct spi_bus_driver, driver )
+struct spi_bus_driver {
+	int 	(*xfer) (struct spi_msg * msg);
+	void 	(*select) (struct spi_device * dev);
+	void 	(*deselect) (struct spi_device * dev);
+	void 	(*set_clock) (struct device * bus_device, u32 clock_hz);
+	struct device_driver driver;
+};
+
+#define TO_SPI_DEV(device) container_of( device, struct spi_device, dev )
+struct spi_device {
+	char name[BUS_ID_SIZE];
+	struct device dev;
+};
+
+#define TO_SPI_DRIVER(drv) container_of( drv, struct spi_driver, driver )
+struct spi_driver {
+	void 	       *(*alloc) (size_t, int);
+	void 	 	(*free) (const void *);
+	unsigned char  *(*get_buffer) (struct spi_device *, void *);
+	void 		(*release_buffer) (struct spi_device *, unsigned char *);
+	void 		(*control) (struct spi_device *, int mode, u32 ctl);
+	struct device_driver driver;
+};
+
+#define SPI_DEV_DRV( device )  TO_SPI_DRIVER( (device)->dev.driver )
+
+#define spi_device_lock( dev )		/* down( dev->dev.sem ) */
+#define spi_device_unlock( dev )	/* up( dev->dev.sem ) */
+
+/*
+ * struct spi_msg
+ *
+ * This structure represent the SPI message internally. You should never use fields of this structure directly
+ * Please use corresponding functions to create/destroy/access fields
+ *
+ */
+struct spi_msg {
+	unsigned char flags;
+#define SPI_M_RD	0x01
+#define SPI_M_WR	0x02	/**< Write mode flag */
+#define SPI_M_CSREL	0x04	/**< CS release level at end of the frame  */
+#define SPI_M_CS	0x08	/**< CS active level at begining of frame ( default low ) */
+#define SPI_M_CPOL	0x10	/**< Clock polarity */
+#define SPI_M_CPHA	0x20	/**< Clock Phase */
+	unsigned short len;	/* msg length           */
+	unsigned long clock;
+	struct spi_device *device;
+	void *context;
+	struct list_head link;
+	void (*status) (struct spi_msg * msg, int code);
+	void *devbuf_rd, *devbuf_wr;
+	u8 *databuf_rd, *databuf_wr;
+};
+
+static inline struct spi_msg *spimsg_alloc(struct spi_device *device,
+					   unsigned flags,
+					   unsigned short len,
+					   void (*status) (struct spi_msg *,
+							   int code))
+{
+	struct spi_msg *msg;
+	struct spi_driver *drv = SPI_DEV_DRV(device);
+
+	msg = kmalloc(sizeof(struct spi_msg), GFP_KERNEL);
+	if (!msg)
+		return NULL;
+	memset(msg, 0, sizeof(struct spi_msg));
+	msg->len = len;
+	msg->status = status;
+	msg->device = device;
+	msg->flags = flags;
+	INIT_LIST_HEAD(&msg->link);
+	if (flags & SPI_M_RD) {
+		msg->devbuf_rd = drv->alloc ?
+		    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
+		msg->databuf_rd = drv->get_buffer ?
+		    drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
+	}
+	if (flags & SPI_M_WR) {
+		msg->devbuf_wr = drv->alloc ?
+		    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
+		msg->databuf_wr = drv->get_buffer ?
+		    drv->get_buffer(device, msg->devbuf_wr) : msg->devbuf_wr;
+	}
+	pr_debug("%s: msg = %p, RD=(%p,%p) WR=(%p,%p). Actual flags = %s+%s\n",
+		 __FUNCTION__,
+		 msg,
+		 msg->devbuf_rd, msg->databuf_rd,
+		 msg->devbuf_wr, msg->databuf_wr,
+		 msg->flags & SPI_M_RD ? "RD" : "~rd",
+		 msg->flags & SPI_M_WR ? "WR" : "~wr");
+	return msg;
+}
+
+static inline void spimsg_free(struct spi_msg *msg)
+{
+	void (*do_free) (const void *) = kfree;
+	struct spi_driver *drv = SPI_DEV_DRV(msg->device);
+
+	if (msg) {
+		if (drv->free)
+			do_free = drv->free;
+		if (drv->release_buffer) {
+			if (msg->databuf_rd)
+				drv->release_buffer(msg->device,
+						    msg->databuf_rd);
+			if (msg->databuf_wr)
+				drv->release_buffer(msg->device,
+						    msg->databuf_wr);
+		}
+		if (msg->devbuf_rd)
+			do_free(msg->devbuf_rd);
+		if (msg->devbuf_wr)
+			do_free(msg->devbuf_wr);
+		kfree(msg);
+	}
+}
+
+static inline u8 *spimsg_buffer_rd(struct spi_msg *msg)
+{
+	return msg ? msg->databuf_rd : NULL;
+}
+
+static inline u8 *spimsg_buffer_wr(struct spi_msg *msg)
+{
+	return msg ? msg->databuf_wr : NULL;
+}
+
+static inline u8 *spimsg_buffer(struct spi_msg *msg)
+{
+	if (!msg)
+		return NULL;
+	if ((msg->flags & (SPI_M_RD | SPI_M_WR)) == (SPI_M_RD | SPI_M_WR)) {
+		printk(KERN_ERR "%s: what buffer do you really want ?\n",
+		       __FUNCTION__);
+		return NULL;
+	}
+	if (msg->flags & SPI_M_RD)
+		return msg->databuf_rd;
+	if (msg->flags & SPI_M_WR)
+		return msg->databuf_wr;
+}
+
+#define SPIMSG_OK 	0x01
+#define SPIMSG_FAILED 	0x80
+#define SPIMSG_STARTED  0x02
+#define SPIMSG_DONE	0x04
+
+#define SPI_MAJOR	153
+
+struct spi_driver;
+struct spi_device;
+
+static inline int spi_bus_driver_register(struct spi_bus_driver *bus_driver)
+{
+	return driver_register(&bus_driver->driver);
+}
+
+void spi_bus_driver_unregister(struct spi_bus_driver *);
+int spi_bus_driver_init(struct spi_bus_driver *driver, struct device *dev);
+struct spi_device* spi_device_add(struct device *parent, char *name);
+
+static inline void spi_device_del(struct spi_device *dev)
+{
+	device_unregister(&dev->dev);
+}
+static inline int spi_driver_add(struct spi_driver *drv)
+{
+	drv->driver.bus = &spi_bus;
+	return driver_register(&drv->driver);
+}
+static inline void spi_driver_del(struct spi_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+#define SPI_DEV_CHAR "spi-char"
+
+extern int spi_write(struct spi_device *dev, const char *buf, int len);
+extern int spi_read(struct spi_device *dev, char *buf, int len);
+
+extern int spi_queue(struct spi_msg *message);
+extern int spi_transfer(struct spi_msg *message,
+			void (*status) (struct spi_msg *, int));
+extern int spi_bus_populate(struct device *parent, char *device,
+			    void (*assign) (struct device *parent,
+					    struct spi_device *));
+struct spi_device_desc {
+	char* name;
+	void* params;
+};
+extern int spi_bus_populate2(struct device *parent,
+			     struct spi_device_desc *devices,
+			     void (*assign) (struct device *parent,
+				             struct spi_device *,
+					     void *));
+
+#endif				/* SPI_H */



