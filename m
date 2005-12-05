Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVLESA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLESA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLESA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:00:56 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:15318 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932487AbVLESAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:00:54 -0500
Date: Mon, 5 Dec 2005 21:01:10 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git] SPI core refresh
Message-Id: <20051205210110.44a3ba4c.vwool@ru.mvista.com>
In-Reply-To: <20051201191109.40f2d04b.vwool@ru.mvista.com>
References: <20051201191109.40f2d04b.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is an updated version of SPI framework developed by Dmitry Pervushin and Vitaly Wool.

The main changes are:

- simplified memory allocation framework in case of non-DMAable buffers
- Greg's review matched
- thread-based handling of the async messages is now an option
- spi_msg is now an abstract structure for SPI core users
- spi_msg can now be chained
- documentation updated

Again, some advantages of our core compared to David's I'd like to mention

- it can be compiled as a module (as opposed to basic David's core w/o Mark Underwood's patch)
- it is less priority inversion-exposed
- it can gain more performance with multiple controllers
- it's more adapted for use in real-time environments

Well, what else? 
1. Now thw footprint of the pure (i. e. w/o device interface and thread-based handling) .text section is _less_ than 2k for ARM. 
2. We still think that thread-based async messages processing will be the most commonly used option so we didn't remove it from core but made it a compication option whether to include it or not. In any case it can be overridden by a specific bus driver, so even when compiled in, thread-based handling won't necessarily _start_ the threads, so the overhead is minimal even in that case.
3. We still don't feel comportable with complicated structure of SPI message in David's core being exposed to all over the world. On the other hand, chaining SPI messages can really be helpful, so we added this option to our core (yeeeep, convergence is gong on :)) but 
4. We made struct spi_msg not being exposed to anywhere except the core itself. Thus we're free to change its implementation in future if necessary.
5. Some changes weren't tested thoroughly yet, so you may encounter problems. Feel free to provide feedback and patches :)

 Documentation/spi.txt    |  115 +++++++++
 arch/arm/Kconfig         |    2 
 drivers/Kconfig          |    2 
 drivers/Makefile         |    1 
 drivers/spi/Kconfig      |   39 +++
 drivers/spi/Makefile     |   16 +
 drivers/spi/spi-core.c   |  551 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-core.h   |   41 +++
 drivers/spi/spi-dev.c    |  191 ++++++++++++++++
 drivers/spi/spi-thread.c |  192 ++++++++++++++++
 drivers/spi/spi-thread.h |   33 ++
 include/linux/spi.h      |  169 ++++++++++++++
 12 files changed, 1352 insertions(+)

diff -uNr linux-2.6.orig/arch/arm/Kconfig linux-2.6/arch/arm/Kconfig
--- linux-2.6.orig/arch/arm/Kconfig	2005-11-30 19:38:45.000000000 +0300
+++ linux-2.6/arch/arm/Kconfig	2005-12-05 18:38:05.000000000 +0300
@@ -748,6 +748,8 @@
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
diff -uNr linux-2.6.orig/Documentation/spi.txt linux-2.6/Documentation/spi.txt
--- linux-2.6.orig/Documentation/spi.txt	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/Documentation/spi.txt	2005-12-05 18:38:05.000000000 +0300
@@ -0,0 +1,115 @@
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
+  | some_bus     |                    | spi_bus |
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
+3.2 How do the SPI devices get discovered and probed ?
+
+In general, the SPI bus driver cannot effectively discover devices
+on its bus. Fortunately, the devices on SPI bus usually implemented
+onboard, so you need to create array of structures spi_device_desc and
+pass this array to function spi_bus_populate, like this:
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
+  err = spi_bus_populate( the_spi_bus, spi_slaves, callback );
+
+3.3. DMA and SPI messages
+-------------------------
+
+The core provides additional robustness when the buffer suppiled is not
+DMA-safe. If it is, the core will allocate DMA-safe buffer and copy user-
+supplied buffer to it (before operation in WRITE case, and after in READ case).
+This two situations are distinguished by specific flag SPI_M_DMAUNSAFE.
+Bus driver should use spimsg_get_buffer and spimsg_put_buffer to access buffer.
+The buffer received from spimsg_get_buffer will be always DMA-safe and suitable for
+DMA mapping.
+
+4. SPI functions are structures reference
+-----------------------------------------
+Please refer to kerneldocs for the information. To create it, use command
+	$ scripts/kernel-doc -html drivers/spi/* > spi.html
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
diff -uNr linux-2.6.orig/drivers/Kconfig linux-2.6/drivers/Kconfig
--- linux-2.6.orig/drivers/Kconfig	2005-11-30 19:38:45.000000000 +0300
+++ linux-2.6/drivers/Kconfig	2005-12-05 18:38:05.000000000 +0300
@@ -44,6 +44,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
diff -uNr linux-2.6.orig/drivers/Makefile linux-2.6/drivers/Makefile
--- linux-2.6.orig/drivers/Makefile	2005-11-30 19:38:45.000000000 +0300
+++ linux-2.6/drivers/Makefile	2005-12-05 18:38:05.000000000 +0300
@@ -69,3 +69,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_SPI)		+= spi/
diff -uNr linux-2.6.orig/drivers/spi/Kconfig linux-2.6/drivers/spi/Kconfig
--- linux-2.6.orig/drivers/spi/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/Kconfig	2005-12-05 18:42:38.000000000 +0300
@@ -0,0 +1,39 @@
+#
+# SPI device configuration
+#
+menu "SPI support"
+
+config SPI
+	tristate "SPI (Serial Peripheral Interface) bus support"
+        default false
+	help
+	  Say Y if you need to enable SPI support on your kernel.
+ 	  Say M if you want to create the spi-core loadable module.
+
+config SPI_THREAD
+	bool "Threaded handling of SPI asynchronous messages"
+	default true
+	help
+	  Say Y here to compile thread-based asynchronous message
+	  handling for SPI. This will be a default SPI async message
+	  handling method, which can be overridden by bus driver.
+	  If unsure, say Y.
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
+	bool "SPI device interface"
+	depends on SPI
+	help
+	  Say Y here to use /dev/spiNN device files. They make it possible to have user-space
+	  programs use the SPI bus.
+
+endmenu
+
diff -uNr linux-2.6.orig/drivers/spi/Makefile linux-2.6/drivers/spi/Makefile
--- linux-2.6.orig/drivers/spi/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/Makefile	2005-12-05 18:38:05.000000000 +0300
@@ -0,0 +1,16 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+spi-y += spi-core.o
+spi-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+spi-$(CONFIG_SPI_THREAD) += spi-thread.o
+# bus drivers
+# ...functional drivers
+# ...and the common spi-dev driver
+obj-$(CONFIG_SPI) += spi.o
+
+ifeq ($(CONFIG_SPI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
diff -uNr linux-2.6.orig/drivers/spi/spi-core.c linux-2.6/drivers/spi/spi-core.c
--- linux-2.6.orig/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-core.c	2005-12-05 18:38:05.000000000 +0300
@@ -0,0 +1,551 @@
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
+#include "spi-thread.h"
+#include "spi-core.h"
+
+static int spi_device_del(struct device *dev, void *data);
+
+void spimsg_set_clock (struct spi_msg* message, u32 clock)
+{
+	message->clock = clock;
+}
+
+u32 spimsg_get_clock (struct spi_msg* message)
+{
+	return message->clock;
+}
+
+u32 spimsg_get_flags (struct spi_msg* message)
+{
+	return message->flags;
+}
+
+u32 spimsg_get_buffer (struct spi_msg *message, void **buffer)
+{
+	if (!buffer)
+		return 0;
+	*buffer = message->buf_ptr;
+
+	if (message->flags & SPI_M_DMAUNSAFE) {
+
+		*buffer = kmalloc (message->len+sizeof(void*), GFP_DMA);
+		if (!*buffer)
+			return 0;
+		*(void**)((u8*)*buffer + message->len) = message->buf_ptr;
+		if (message->flags & SPI_M_WR)
+			memcpy( *buffer, message->buf_ptr, message->len );
+	}
+	return message->len;
+}
+
+void spimsg_put_buffer (struct spi_msg *message, void *buffer)
+{
+	if (message->flags & SPI_M_DMAUNSAFE) {
+		if (message->flags & SPI_M_RD)
+			memcpy (message->buf_ptr, buffer, message->len);
+		kfree(buffer);
+	}
+}
+
+/**
+ * spimsg_alloc - allocate the spi message
+ *
+ * @device: target device
+ * @flags: SPI message flags
+ * @buf: user-supplied buffer
+ * @len: buffer's length
+ * @status: user-supplied callback function
+**/
+struct spi_msg *spimsg_alloc(struct spi_device *device,
+					   struct spi_msg *link,
+					   u32 flags,
+					   void *buf,
+					   unsigned short len,
+					   void (*status) (struct spi_msg *,
+							   int code))
+{
+	struct spi_msg *msg;
+
+	if ((flags & (SPI_M_RD|SPI_M_WR)) == (SPI_M_RD|SPI_M_WR))
+		return NULL;
+	msg = kzalloc( sizeof (struct spi_msg), GFP_KERNEL);
+	if (!msg)
+		return NULL;
+	msg->len = len;
+	msg->status = status;
+	msg->device = device;
+	msg->flags = flags;
+	INIT_LIST_HEAD(&msg->link);
+
+	msg->buf_ptr = buf;
+
+	if (link)
+		link->next = msg;
+
+	return msg;
+}
+
+/**
+ * spimsg_free - free the message allocated by spimsg_alloc
+ *
+ * @msg: message to free
+ **/
+void spimsg_free(struct spi_msg *msg)
+{
+	kfree(msg);
+}
+
+
+
+/**
+ * spi_bus_match_name - verify that driver matches device on spi bus
+ * @dev: device that hasn't yet being assigned to any driver
+ * @drv: driver for spi device
+ * Description: match the device to driver.Drivers and devices on SPI bus
+ * are matched by name, just like the platform devices
+ */
+static int spi_bus_match_name(struct device *dev, struct device_driver *drv)
+{
+	return !strcmp(TO_SPI_DEV(dev)->name, drv->name);
+}
+
+/**
+ * spi_bus_suspend - suspend all devices on the spi bus
+ *
+ * @dev: spi device to be suspended
+ * @message: PM message
+ *
+ * This function set device on SPI bus to suspended state, just like platform_bus does
+ */
+static int spi_bus_suspend(struct device * dev, pm_message_t message)
+{
+	int ret = 0;
+
+	if (dev && dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {
+		ret = TO_SPI_DRIVER(dev->driver)->suspend( TO_SPI_DEV(dev), message);
+		if (ret == 0 )
+			dev->power.power_state = message;
+	}
+	return ret;
+}
+
+/**
+ * spi_bus_resume - resume functioning of all devices on spi bus
+ *
+ * @dev: device to resume
+ *
+ * This function resumes device on SPI bus, just like platform_bus does
+**/
+static int spi_bus_resume(struct device * dev)
+{
+	int ret = 0;
+
+	if (dev && dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {
+		ret = TO_SPI_DRIVER(dev->driver)->resume(TO_SPI_DEV(dev));
+		if (ret == 0)
+			dev->power.power_state = PMSG_ON;
+	}
+	return ret;
+}
+
+struct bus_type spi_bus = {
+	.name = "spi",
+	.match = spi_bus_match_name,
+	.suspend = spi_bus_suspend,
+	.resume = spi_bus_resume,
+};
+
+/**
+ * spi_bus_driver_init - init internal bus driver structures
+ *
+ * @bus: registered spi_bus_driver structure
+ * @dev: device that represents spi controller
+ *
+ * Once registered by spi_bus_register, the bus driver needs initialization, that
+ * includes starting thread, initializing internal structures.. The best place where
+ * the spi_bus_driver_init is in the `probe' function, when we already sure that passed
+ * device object is SPI master controller
+**/
+int spi_bus_driver_init(struct spi_bus_driver *bus, struct device *dev)
+{
+	struct spi_bus_data *pd =
+	    kmalloc(sizeof(struct spi_bus_data), GFP_KERNEL);
+	int err = 0;
+
+	if (!pd) {
+		err = -ENOMEM;
+		goto init_failed;
+	}
+
+	pd->bus = bus;
+	init_MUTEX(&pd->lock);
+	INIT_LIST_HEAD(&pd->msgs);
+	pd->id = dev->bus_id;
+
+	if (!bus->start_async && !bus->stop_async) {
+		bus->start_async = spi_start_async;
+		bus->stop_async = spi_stop_async;
+	}
+
+	dev->platform_data = pd;
+
+	pd->async_data = bus->start_async ? bus->start_async(dev) : NULL;
+
+	return 0;
+
+init_failed:
+	return err;
+}
+
+/**
+ * __spi_bus_free -- unregister all children of the spi bus
+ *
+ * @dev: the spi bus `device' object
+ * @context: not used, will be NULL
+ *
+ * This is internal function that is called when unregistering bus driver. Responsibility
+ * of this function is freeing the resources that were requested by spi_bus_driver_init
+ **/
+static int __spi_bus_free(struct device *dev, void *context)
+{
+	struct spi_bus_data *pd = dev->platform_data;
+	struct spi_bus_driver *bus= TO_SPI_BUS_DRIVER(dev->driver);
+
+	if (bus->stop_async)
+		bus->stop_async(dev, pd->async_data);
+
+	dev_dbg(dev, "unregistering children\n");
+	device_for_each_child(dev, NULL, spi_device_del);
+	return 0;
+}
+
+/**
+ * spi_bus_driver_unregister - unregister SPI bus controller from the system
+ *
+ * @bus_driver: driver registered by call to spi_bus_driver_register
+ *
+ * unregisters the SPI bus from the system. Before unregistering, it deletes
+ * each SPI device on the bus using call to __spi_device_free
+**/
+void spi_bus_driver_unregister(struct spi_bus_driver *bus_driver)
+{
+	if (bus_driver) {
+		driver_for_each_device(&bus_driver->driver, NULL, NULL, __spi_bus_free);
+		driver_unregister(&bus_driver->driver);
+	}
+}
+
+/**
+ * spi_device_release - release the spi device structure
+ *
+ * @dev: spi_device to be released
+ *
+ * Pointer to this function will be put to dev->release place
+ * This fus called as a part of device removing
+**/
+void spi_device_release(struct device *dev)
+{
+	struct spi_device* sdev = TO_SPI_DEV(dev);
+
+	kfree(sdev);
+}
+
+/**
+ * spi_device_add - add the new (discovered) SPI device to the bus. Mostly used by bus drivers
+ *
+ * @parent: the bus device object
+ * @name: name of device (non-null!)
+ * @bus_data: bus data to be assigned to device
+ *
+ * SPI devices usually cannot be discovered by SPI bus driver, so it needs to take the configuration
+ * somewhere from hardcoded structures, and prepare bus_data for its devices
+**/
+struct spi_device* spi_device_add(struct device *parent, char *name, void *bus_data)
+{
+	struct spi_device* dev;
+	static int minor = 0;
+
+	if (!name)
+		goto dev_add_out;
+
+	dev = kmalloc(sizeof(struct spi_device), GFP_KERNEL);
+	if(!dev)
+		goto dev_add_out;
+
+	memset(&dev->dev, 0, sizeof(dev->dev));
+	dev->dev.parent = parent;
+	dev->dev.bus = &spi_bus;
+	strncpy(dev->name, name, sizeof(dev->name));
+	strncpy(dev->dev.bus_id, name, sizeof(dev->dev.bus_id));
+	dev->dev.release = spi_device_release;
+	dev->dev.platform_data = bus_data;
+
+	if (device_register(&dev->dev)<0) {
+		dev_dbg(parent, "device '%s' cannot be added\n", name);
+		goto dev_add_out_2;
+	}
+	dev->cdev = spi_class_device_create(minor, &dev->dev);
+	dev->minor = minor++;
+	return dev;
+
+dev_add_out_2:
+	kfree(dev);
+dev_add_out:
+	return NULL;
+}
+
+static int spi_device_del(struct device *dev, void *data)
+{
+	struct spi_device *spidev = TO_SPI_DEV(dev);
+	if (spidev->cdev) {
+		spi_class_device_destroy(spidev->cdev);
+		spidev->cdev = NULL;
+	}
+	device_unregister(&spidev->dev);
+	return 0;
+}
+/**
+ * __spi_transfer_callback - callback to process synchronous messages
+ *
+ * @msg: message that is about to complete
+ * @code: message status
+ *
+ * callback for synchronously processed message. If spi_transfer determines
+ * that there is no callback provided neither by msg->status nor callback
+ * parameter, the __spi_transfer_callback will be used, and spi_transfer
+ * does not return until transfer is finished
+ *
+**/
+static void __spi_transfer_callback(struct spi_msg *msg, int code)
+{
+	if (code & (SPIMSG_OK | SPIMSG_FAILED))
+		complete((struct completion *)msg->context);
+}
+
+/*
+ * spi_transfer - transfer the message either in sync or async way
+ *
+ * @msg: message to process
+ * @callback: user-supplied callback
+ *
+ * If both msg->status and callback are set, the error code of -EINVAL
+ * will be returned
+ */
+int spi_transfer(struct spi_msg *msg, void (*callback) (struct spi_msg *, int))
+{
+	struct completion msg_done;
+	int err = -EINVAL;
+	struct device *bus = msg->device->dev.parent;
+
+	if (TO_SPI_BUS_DRIVER(bus->driver)->queue)
+	{
+		if (callback && !msg->status) {
+			msg->status = callback;
+			callback = NULL;
+		}
+
+		if (!callback) {
+			if (!msg->status) {
+				init_completion(&msg_done);
+				msg->context = &msg_done;
+				msg->status = __spi_transfer_callback;
+				err = TO_SPI_BUS_DRIVER(bus->driver)->queue(msg);
+				wait_for_completion(&msg_done);
+				err = 0;
+			} else {
+				err = TO_SPI_BUS_DRIVER(bus->driver)->queue(msg);
+			}
+		}
+	}
+
+	return err;
+}
+
+/**
+ * spi_write - send data to a device on an SPI bus
+ *
+ * @dev: the target device
+ * @flags: additional flags for message
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ *
+ * Returns the number of bytes transferred, or negative error code.
+**/
+int spi_write(struct spi_device *dev, u32 flags, char *buf, size_t len)
+{
+	struct spi_msg *msg = spimsg_alloc(dev, NULL, SPI_M_WR | SPI_M_DMAUNSAFE | flags, buf, len, NULL);
+	int ret;
+
+	ret = spi_transfer(msg, NULL);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_read - receive data from a device on an SPI bus
+ *
+ * @dev: the target device
+ * @flags: additional flags for message
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ *
+ * Returns the number of bytes transferred, or negative error code.
+**/
+int spi_read(struct spi_device *dev, u32 flags, char *buf, size_t len)
+{
+	int ret;
+	struct spi_msg *msg = spimsg_alloc(dev, NULL, SPI_M_RD | SPI_M_DMAUNSAFE | flags, buf, len, NULL);
+
+	ret = spi_transfer(msg, NULL);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_bus_populate - populate the bus
+ *
+ * @parent: the SPI bus device object
+ * @devices_s: array of structures that represents bus population
+ * @callback: optional pointer to function that called on each device's add
+ *
+ * This function is intended to populate the SPI bus corresponding to
+ * device passed as 1st parameter.
+ * If some device cannot be added because of spi_device_add fail, the function will
+ * not try to parse the rest of list
+ */
+int spi_bus_populate(struct device *parent,
+			struct spi_device_desc* devices_s,
+			void (*callback) (struct device* bus,
+					  struct spi_device *new_dev,
+					  void* params))
+{
+	struct spi_device *new_device;
+	int count = 0;
+
+	while (devices_s->name) {
+		dev_dbg(parent, " discovered new SPI device, name '%s'\n",
+				devices_s->name);
+		if ((new_device = spi_device_add(parent, devices_s->name, devices_s->params)) == NULL)
+			break;
+		if (callback)
+			callback(parent, new_device, devices_s->params);
+		devices_s++;
+		count++;
+	}
+	return count;
+}
+
+/**
+ * spi_bus_reset - reset the spi bus
+ *
+ * @bus: device object that represents the SPI bus
+ * @context: u32 value to be passed to reset method of bus
+ *
+ * This is simple wrapper for bus' `reset' method
+ *
+**/
+void spi_bus_reset (struct device *bus, u32 context)
+{
+	if (bus && bus->driver && TO_SPI_BUS_DRIVER(bus->driver)->reset)
+		TO_SPI_BUS_DRIVER(bus->driver)->reset(bus, context);
+}
+
+/*
+ * the functions below are wrappers for corresponding device_driver's methods
+ */
+static int spi_driver_probe (struct device *dev)
+{
+	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
+	struct spi_device *sdev = TO_SPI_DEV(dev);
+
+	return sdrv->probe ? sdrv->probe(sdev) : -EFAULT;
+}
+
+static int spi_driver_remove (struct device *dev)
+{
+	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
+	struct spi_device *sdev = TO_SPI_DEV(dev);
+
+	return  sdrv->remove  ? sdrv->remove(sdev) : -EFAULT;
+}
+
+static void spi_driver_shutdown (struct device *dev)
+{
+	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
+	struct spi_device *sdev = TO_SPI_DEV(dev);
+
+	if (dev->driver && sdrv->shutdown)
+		sdrv->shutdown(sdev);
+}
+
+static int __init spi_core_init(void)
+{
+	int ret = spidev_init();
+
+	if (ret == 0)
+		ret = bus_register(&spi_bus);
+
+	return ret;
+}
+
+int spi_driver_add(struct spi_driver *drv)
+{
+	drv->driver.bus = &spi_bus;
+	drv->driver.probe = spi_driver_probe;
+	drv->driver.remove = spi_driver_remove;
+	drv->driver.shutdown = spi_driver_shutdown;
+	return driver_register(&drv->driver);
+}
+
+static void __exit spi_core_exit(void)
+{
+	bus_unregister(&spi_bus);
+	spidev_cleanup();
+}
+
+subsys_initcall(spi_core_init);
+module_exit(spi_core_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+
+EXPORT_SYMBOL_GPL(spi_bus_reset);
+EXPORT_SYMBOL_GPL(spi_device_add);
+EXPORT_SYMBOL_GPL(spi_driver_add);
+EXPORT_SYMBOL_GPL(spi_bus_driver_unregister);
+EXPORT_SYMBOL_GPL(spi_bus_populate);
+EXPORT_SYMBOL_GPL(spi_transfer);
+EXPORT_SYMBOL_GPL(spi_write);
+EXPORT_SYMBOL_GPL(spi_read);
+EXPORT_SYMBOL_GPL(spi_bus);
+EXPORT_SYMBOL_GPL(spi_bus_driver_init);
+
+EXPORT_SYMBOL_GPL(spimsg_alloc);
+EXPORT_SYMBOL_GPL(spimsg_free);
+EXPORT_SYMBOL_GPL(spimsg_put_buffer);
+EXPORT_SYMBOL_GPL(spimsg_get_flags);
+EXPORT_SYMBOL_GPL(spimsg_get_buffer);
+EXPORT_SYMBOL_GPL(spimsg_get_clock);
+EXPORT_SYMBOL_GPL(spimsg_set_clock);
+
diff -uNr linux-2.6.orig/drivers/spi/spi-core.h linux-2.6/drivers/spi/spi-core.h
--- linux-2.6.orig/drivers/spi/spi-core.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-core.h	2005-12-05 18:54:25.000000000 +0300
@@ -0,0 +1,41 @@
+/*
+ *  linux/drivers/spi/spi-core.h
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+#ifndef __SPI_CORE_H
+#define __SPI_CORE_H
+
+struct spi_msg {
+	u32  flags;
+#define SPI_M_RD	0x00000001
+#define SPI_M_WR	0x00000002	/**< Write mode flag */
+#define SPI_M_CSREL	0x00000004	/**< CS release level at end of the frame  */
+#define SPI_M_CS	0x00000008	/**< CS active level at begining of frame  */
+#define SPI_M_CPOL	0x00000010	/**< Clock polarity */
+#define SPI_M_CPHA	0x00000020	/**< Clock Phase */
+#define SPI_M_EXTBUF	0x80000000    	/** externally allocated buffers */
+#define SPI_M_ASYNC_CB	0x40000000      /** use workqueue to deliver callbacks */
+#define SPI_M_DNA	0x20000000	/** do not allocate buffers */
+#define SPI_M_DMAUNSAFE 0x10000000	/** buffer is dma-unsafe */
+
+	u16 len;	/* msg length           */
+	u32 clock;
+	struct spi_device *device;
+	void *context;
+
+	struct spi_msg *next;
+
+	struct list_head link;
+
+	void (*status) (struct spi_msg * msg, int code);
+
+	void *buf_ptr;
+};
+
+#endif /* __SPI_CORE_H */
diff -uNr linux-2.6.orig/drivers/spi/spi-dev.c linux-2.6/drivers/spi/spi-dev.c
--- linux-2.6.orig/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-dev.c	2005-12-05 20:26:17.000000000 +0300
@@ -0,0 +1,191 @@
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
+static struct class *spidev_class;
+
+static ssize_t spidev_read(struct file *file, char *buf, size_t count,
+			   loff_t * offset);
+static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
+			    loff_t * offset);
+
+static int spidev_open(struct inode *inode, struct file *file);
+static int spidev_release(struct inode *inode, struct file *file);
+
+/**
+ * spi_class_device_create - wrapper for class_device_create to be used in spi core
+ *
+ * @minor: sequental minor number of SPI slave device
+ * @device: pointer to struct device embedded to spi_device
+ *
+**/
+struct class_device *spi_class_device_create(int minor, struct device *device)
+{
+	return class_device_create(spidev_class, NULL, MKDEV(SPI_MAJOR, minor), device, "spi%d", minor);
+}
+
+/**
+ * spi_class_device_destroy - wrapper for class_device_destroy to be used in spi core
+ *
+ * @cdev: class device created by spi_class_device_create
+ */
+void spi_class_device_destroy(struct class_device *cdev)
+{
+	class_device_destroy(spidev_class, cdev->devt);
+}
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
+static ssize_t spidev_read(struct file *file, char __user *buf, size_t count,
+			   loff_t * offset)
+{
+	int rc = 0;
+	char *kbuf = kmalloc(count, GFP_DMA);
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+
+	if (!kbuf)
+		rc = -ENOMEM;
+	else {
+		rc = spi_read(dev, SPI_M_DNA, kbuf, count);
+		if (rc < 0 || copy_to_user(buf, kbuf, count))
+			rc = -EFAULT;
+		kfree(kbuf);
+	}
+	return rc;
+}
+
+static ssize_t spidev_write(struct file *file, const char __user *buf, size_t count,
+			    loff_t * offset)
+{
+	int rc = 0;
+	char *kbuf = kmalloc(count, GFP_DMA);
+	struct spi_device *dev = (struct spi_device *)file->private_data;
+
+	if (!kbuf)
+		rc = -ENOMEM;
+	else {
+		if (!copy_from_user(kbuf, buf, count))
+			rc = spi_write(dev, SPI_M_DNA, kbuf, count);
+		else
+			rc = -EFAULT;
+		kfree(kbuf);
+	}
+	return rc;
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
+
+	pr_debug("device->minor = %d vs %d\n", dev->minor, o->minor);
+	if (dev->minor == o->minor) {
+		get_device(&dev->dev);
+		o->file->private_data = dev;
+		return 1;
+	}
+
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
+	status = bus_for_each_dev(&spi_bus, NULL, &o, spidev_do_open);
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
+int __init spidev_init(void)
+{
+	int res;
+
+	if ((res = register_chrdev(SPI_MAJOR, "spi", &spidev_fops)) != 0) {
+		goto out;
+	}
+
+	spidev_class = class_create(THIS_MODULE, "spi");
+	if (IS_ERR(spidev_class)) {
+		printk(KERN_ERR "%s: error creating class\n", __FUNCTION__);
+		res = -EINVAL;
+		goto out_unreg;
+	}
+
+	return 0;
+
+out_unreg:
+	unregister_chrdev(SPI_MAJOR, "spi");
+out:
+	return res;
+}
+
+void __exit spidev_cleanup(void)
+{
+	class_destroy(spidev_class);
+	unregister_chrdev(SPI_MAJOR, "spi");
+}
+
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+MODULE_DESCRIPTION("SPI class device driver");
+MODULE_LICENSE("GPL");
diff -uNr linux-2.6.orig/drivers/spi/spi-thread.c linux-2.6/drivers/spi/spi-thread.c
--- linux-2.6.orig/drivers/spi/spi-thread.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-thread.c	2005-12-05 20:07:56.000000000 +0300
@@ -0,0 +1,192 @@
+/*
+ *  drivers/spi/spi-thread.c
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
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
+#include "spi-core.h"
+
+static int spi_thread(void *context);
+
+struct threaded_async_data {
+	atomic_t exiting;
+	struct device *dev;
+	struct task_struct *thread;
+};
+
+void *__spi_start_async (struct device *dev)
+{
+	struct threaded_async_data *td = kmalloc (sizeof (struct threaded_async_data), GFP_KERNEL);
+
+	if (!td) 
+		return NULL;
+
+	td->dev = dev;
+	atomic_set(&td->exiting, 0);
+	td->thread = kthread_run(spi_thread, td, "%s-work", dev->bus_id);
+	return NULL;
+}
+
+void __spi_stop_async (struct device *dev, void *ctx)
+{
+	struct threaded_async_data *td = ctx;
+
+	if (ctx) {
+		atomic_inc (&td->exiting);
+		kthread_stop(td->thread);
+		kfree(td);
+	}
+}
+
+/**
+ * spi_thread_awake - function that called to determine if thread needs to process any messages
+ *
+ * @td: pointer to struct threaded_async_data
+ *
+ * Thread wakes up if there is signal to exit (bd->exiting is set) or there are any messages
+ * in bus' queue.
+ */
+static int spi_thread_awake(struct threaded_async_data *td)
+{
+	int ret = -EINVAL;
+	struct spi_bus_data *bd = td->dev->platform_data;
+
+	if (atomic_read(&td->exiting)) {
+		return 1;
+	}
+
+	if (bd) {
+		down(&bd->lock);
+		ret = !list_empty(&bd->msgs);
+		up(&bd->lock);
+	}
+	return ret;
+}
+
+/**
+ * spi_bus_next_msg - the wrapper for retrieve method for bus driver
+ *
+ * @this: spi_bus_driver that needs to retrieve next message from queue
+ * @data: pointer to spi_bus_data structure associated with spi_bus_driver
+ *
+ * If bus driver provides the `retrieve' method, it is called to retrieve the next message
+ * from queue. Otherwise, the spi_bus_fifo_retrieve is called
+ *
+ **/
+static struct spi_msg *spi_bus_next_msg(struct spi_bus_driver *this, struct spi_bus_data *data)
+{
+	return list_entry(data->msgs.next, struct spi_msg, link);
+}
+
+/**
+ * spi_thread - the thread that calls bus functions to perform actual transfers
+ *
+ * @context: pointer to struct spi_bus_data with bus-specific data
+ *
+ * Description:
+ * 	This function is started as separate thread to perform actual
+ * 	transfers on SPI bus
+ **/
+static int spi_thread(void *context)
+{
+	struct threaded_async_data *td = context;
+	struct spi_bus_data *bd = td->dev->platform_data;
+	struct spi_msg *cmsg;
+	int xfer_status;
+
+	while (!kthread_should_stop()) {
+
+		wait_event_interruptible(bd->queue, spi_thread_awake(td));
+
+		if (atomic_read(&td->exiting))
+			goto thr_exit;
+
+		down(&bd->lock);
+		cmsg = NULL;
+		while (!list_empty(&bd->msgs) || cmsg) {
+			/*
+			 * this part is locked by bus_data->lock,
+			 * to protect spi_msg extraction
+			 */
+			if (!cmsg) 
+				cmsg = spi_bus_next_msg(bd->bus, bd);
+			else
+				cmsg = cmsg->next;
+
+			if (cmsg == NULL)
+				break;
+
+			list_del(&cmsg->link);
+			up(&bd->lock);
+
+			/*
+			 * and this part is locked by device's lock;
+			 * spi_queue will be able to queue new
+			 * messages
+			 *
+			 * note that bd->selected_device is locked, not msg->device
+			 * they are the same, but msg can be freed in msg->status function
+			 */
+			spi_device_lock(bd->selected_device);
+			if (bd->bus->set_clock && cmsg->clock)
+				bd->bus->set_clock(cmsg->device->dev.parent,
+						cmsg->clock);
+			xfer_status = bd->bus->xfer(cmsg);
+			if (cmsg->status) 
+				cmsg->status(cmsg, xfer_status);
+
+			spi_device_unlock(bd->selected_device);
+
+			/* lock the bus_data again... */
+			down(&bd->lock);
+		}
+		up(&bd->lock);
+	}
+
+thr_exit:
+	return 0;
+}
+
+/**
+ * spi_queue - queue the message to be processed asynchronously
+ *
+ * @msg: message to be sent
+ *
+ * This function queues the message to spi bus driver's queue. The bus driver
+ * retrieves the message from queue according to its own rules (see retrieve method)
+ * and sends the message to target device. If message has no callback method, originator
+ * of message would get no chance to know where the message is processed. The better
+ * solution is using spi_transfer function, which will return error code if no callback
+ * is provided, or transfer the message synchronously.
+**/
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
+
diff -uNr linux-2.6.orig/drivers/spi/spi-thread.h linux-2.6/drivers/spi/spi-thread.h
--- linux-2.6.orig/drivers/spi/spi-thread.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-thread.h	2005-12-05 19:33:39.000000000 +0300
@@ -0,0 +1,33 @@
+/*
+ *  linux/drivers/spi/spi-thread.h
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+#ifndef __SPI_THREAD_H
+#define __SPI_THREAD_H
+
+
+static inline void *spi_start_async (struct device *dev) 
+{
+#ifdef CONFIG_SPI_THREAD
+extern void *__spi_start_async (struct device *dev);
+	return  __spi_start_async(dev);
+#else 
+	return 0;
+#endif
+}
+
+static inline void spi_stop_async (struct device *dev, void *t)
+{
+#ifdef CONFIG_SPI_THREAD
+extern void __spi_stop_async (struct device *dev, void *t);
+	__spi_stop_async (dev, t);
+#endif
+}
+
+#endif /* __SPI_THREAD_H */
diff -uNr linux-2.6.orig/include/linux/spi.h linux-2.6/include/linux/spi.h
--- linux-2.6.orig/include/linux/spi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/include/linux/spi.h	2005-12-05 18:38:05.000000000 +0300
@@ -0,0 +1,169 @@
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
+#include <linux/device.h>
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
+	void *async_data;
+	wait_queue_head_t queue;
+	struct spi_device *selected_device;
+	struct spi_bus_driver *bus;
+	char *id;
+};
+
+#define TO_SPI_BUS_DRIVER(drv) container_of(drv, struct spi_bus_driver, driver)
+struct spi_bus_driver {
+
+	int 	(*xfer) (struct spi_msg * msg);
+	void 	(*set_clock) (struct device * bus_device, u32 clock_hz);
+	void 	(*reset) (struct device *bus_device, u32 context);
+
+	int	(*queue) (struct spi_msg *msg);
+	void   *(*start_async)( struct device *bus);
+	void 	(*stop_async)( struct device *bus, void *async);
+
+	struct device_driver driver;
+};
+
+#define TO_SPI_DEV(device) container_of(device, struct spi_device, dev)
+struct spi_device {
+	char name[BUS_ID_SIZE];
+	int minor;
+	struct class_device *cdev;
+	struct device dev;
+};
+
+#define TO_SPI_DRIVER(drv) container_of(drv, struct spi_driver, driver)
+struct spi_driver {
+
+	int     (*probe)        (struct spi_device * dev);
+	int     (*remove)       (struct spi_device * dev);
+	void    (*shutdown)     (struct spi_device * dev);
+	int	(*suspend)	(struct spi_device * dev, pm_message_t pm);
+	int 	(*resume)	(struct spi_device * dev);
+
+	struct device_driver driver;
+};
+
+#define SPI_DEV_DRV(device)  TO_SPI_BUS_DRIVER((device)->dev.parent->driver)
+
+#define spi_device_lock(spi_dev)	 down(&(spi_dev)->dev.sem)
+#define spi_device_unlock(spi_dev)	 up(&(spi_dev)->dev.sem)
+
+#define SPI_M_RD	0x00000001
+#define SPI_M_WR	0x00000002	/**< Write mode flag */
+#define SPI_M_CSREL	0x00000004	/**< CS release level at end of the frame  */
+#define SPI_M_CS	0x00000008	/**< CS active level at begining of frame  */
+#define SPI_M_CPOL	0x00000010	/**< Clock polarity */
+#define SPI_M_CPHA	0x00000020	/**< Clock Phase */
+#define SPI_M_EXTBUF	0x80000000    	/** externally allocated buffers */
+#define SPI_M_ASYNC_CB	0x40000000      /** use workqueue to deliver callbacks */
+#define SPI_M_DNA	0x20000000	/** do not allocate buffers */
+#define SPI_M_DMAUNSAFE 0x10000000	/** buffer is dma-unsafe */
+
+void spimsg_set_clock (struct spi_msg* message, u32 clock);
+u32 spimsg_get_clock (struct spi_msg* message);
+u32 spimsg_get_flags (struct spi_msg* message);
+u32 spimsg_get_len (struct spi_msg *message);
+u32 spimsg_get_buffer (struct spi_msg *message, void **buffer);
+void spimsg_put_buffer (struct spi_msg *message, void *buffer);
+struct spi_msg *spimsg_alloc(struct spi_device *device,
+			   struct spi_msg *link,
+			   u32 flags,
+			   void *buf,
+			   unsigned short len,
+			   void (*status) (struct spi_msg *,
+					   int code));
+void spimsg_free (struct spi_msg *message);
+
+#if defined (CONFIG_SPI_CHARDEV)
+extern struct class_device *spi_class_device_create(int minor, struct device *device);
+extern void spi_class_device_destroy(struct class_device *cdev);
+#else
+static inline struct class_device *spi_class_device_create(int minor, struct device *device)
+{
+	return NULL;
+}
+static inline void  spi_class_device_destroy(struct class_device *cdev)
+{
+}
+#endif
+
+enum {
+	SPIMSG_OK = 0,
+	SPIMSG_FAILED = -1,
+};
+
+#define SPI_MAJOR	153
+
+struct spi_driver;
+struct spi_device;
+
+#if defined (CONFIG_SPI_CHARDEV)
+extern int __init spidev_init(void);
+extern void __exit spidev_cleanup(void);
+#else
+static inline int spidev_init(void)
+{
+	return 0;
+}
+static inline void spidev_cleanup(void)
+{
+}
+#endif
+
+static inline int spi_bus_driver_register (struct spi_bus_driver *bus_driver)
+{
+	return driver_register (&bus_driver->driver);
+}
+
+void spi_bus_driver_unregister(struct spi_bus_driver *);
+int spi_bus_driver_init(struct spi_bus_driver *driver, struct device *dev);
+struct spi_device* spi_device_add(struct device *parent, char *name, void *private);
+
+extern int spi_driver_add(struct spi_driver *drv);
+
+static inline void spi_driver_del(struct spi_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+extern void spi_bus_reset(struct device* bus, u32 context);
+extern int spi_write(struct spi_device *dev, u32 flags, char *buf, size_t len);
+extern int spi_read(struct spi_device *dev, u32 flags, char *buf, size_t len);
+
+extern int spi_queue(struct spi_msg *message);
+extern int spi_transfer(struct spi_msg *message,
+			void (*status) (struct spi_msg *, int));
+struct spi_device_desc {
+	char* name;
+	void* params;
+};
+extern int spi_bus_populate(struct device *parent,
+			     struct spi_device_desc *devices,
+			     void (*assign) (struct device *parent,
+				             struct spi_device *,
+					     void *));
+
+#endif				/* SPI_H */
