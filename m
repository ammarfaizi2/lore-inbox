Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbVLOJ74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbVLOJ74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbVLOJ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:59:56 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:15549 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1422680AbVLOJ7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:59:55 -0500
Date: Thu, 15 Dec 2005 13:00:27 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net, david-b@pacbell.net,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git 1/3] SPI core refresh: the core
Message-Id: <20051215130027.1347634b.vwool@ru.mvista.com>
In-Reply-To: <20051215125800.4fa95de6.vwool@ru.mvista.com>
References: <20051215125800.4fa95de6.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>
Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 Documentation/spi.txt    |  134 +++++++++
 arch/arm/Kconfig         |    2
 drivers/Kconfig          |    2
 drivers/Makefile         |    1
 drivers/spi/Kconfig      |   46 +++
 drivers/spi/Makefile     |   19 +
 drivers/spi/spi-alloc.c  |  101 +++++++
 drivers/spi/spi-alloc.h  |   54 +++
 drivers/spi/spi-core.c   |  658 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-core.h   |   32 ++
 drivers/spi/spi-dev.c    |  209 ++++++++++++++
 drivers/spi/spi-thread.c |  187 +++++++++++++
 drivers/spi/spi-thread.h |   42 +++
 include/linux/spi.h      |  252 ++++++++++++++++++
 14 files changed, 1739 insertions(+)

Index: linux-2.6.orig/Documentation/spi.txt
===================================================================
--- /dev/null
+++ linux-2.6.orig/Documentation/spi.txt
@@ -0,0 +1,134 @@
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
+5. Getting the latest sources
+-----------------------------
+The stable snapshots are available at
+	http://spi-devel.sourceforge.net/downloads
+The most recent sources can be obtained via the CVS.
+Use the following CVS setup to grab them:
+* set CVSROOT environment variable to 
+	:pserver:anonymous@cvs.sourceforge.net:/cvsroot/spi-devel, i. e.
+$ export CVSROOT=:pserver:anonymous@cvs.sourceforge.net:/cvsroot/spi-devel
+* login into the anonymous CVS using 'cvs login'. When prompted for password,
+  just type Enter, i. e.
+$ cvs login
+Logging in to :pserver:anonymous@cvs.sourceforge.net:2401/cvsroot/spi-devel
+CVS password:
+$
+* checkout the 'spi-core' CVS repo:
+$ cvs co cpi-core
+You'll get a set of patches to be applied to the most recent 2.6-git kernel.
+
+6. How to contact authors
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
Index: linux-2.6.orig/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig.orig/arch/arm/Kconfig
+++ linux-2.6.orig/arch/arm/Kconfig
@@ -753,6 +753,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
Index: linux-2.6.orig/drivers/Kconfig
===================================================================
--- linux-2.6.orig.orig/drivers/Kconfig
+++ linux-2.6.orig/drivers/Kconfig
@@ -44,6 +44,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
Index: linux-2.6.orig/drivers/Makefile
===================================================================
--- linux-2.6.orig.orig/drivers/Makefile
+++ linux-2.6.orig/drivers/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_SPI)		+= spi/
Index: linux-2.6.orig/drivers/spi/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/Kconfig
@@ -0,0 +1,46 @@
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
+ 	  Say M if you want to create the spi loadable module.
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
+config SPI_CUSTOM_ALLOC
+	bool "Custom (faster) SPI message allocation"
+	default false
+	help
+	  Say Y here to use faster SPI message allocation.
+	  If unsure, say N.
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
Index: linux-2.6.orig/drivers/spi/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/Makefile
@@ -0,0 +1,19 @@
+#
+# Makefile for the kernel spi bus driver.
+#
+
+spi-y += spi-core.o
+spi-$(CONFIG_SPI_CHARDEV) += spi-dev.o
+spi-$(CONFIG_SPI_THREAD) += spi-thread.o
+spi-$(CONFIG_SPI_CUSTOM_ALLOC) += spi-alloc.o
+# bus drivers
+obj-$(CONFIG_SPI_PNX) += spipnx.o
+#  ...functional drivers
+obj-$(CONFIG_SPI_PNX4008_EEPROM) += pnx4008-eeprom.o
+# ...and the common spi-dev driver
+obj-$(CONFIG_SPI) += spi.o
+
+ifeq ($(CONFIG_SPI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
Index: linux-2.6.orig/drivers/spi/spi-core.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-core.c
@@ -0,0 +1,658 @@
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
+#include "spi-alloc.h"
+#include "spi-core.h"
+
+static int spi_device_del(struct device *dev, void *data);
+
+/**
+ * spimsg_set_clock - set message's clock
+ * @message: SPI message
+ * @clock: clock settings
+ */
+void spimsg_set_clock (struct spi_msg* message, u32 clock)
+{
+	message->clock = clock;
+}
+
+/**
+ * spimsg_get_clock - get message's clock
+ * @message: SPI message
+ */
+u32 spimsg_get_clock (struct spi_msg* message)
+{
+	return message->clock;
+}
+
+/**
+ * spimsg_get_flags - get message's flags
+ * @message: SPI message
+ */
+u32 spimsg_get_flags (struct spi_msg* message)
+{
+	return message->flags;
+}
+
+/**
+ * spimsg_get_buffer - get the buffer for I/O ops
+ * @message: SPI message
+ * @buffer: ptr to the buffer to be filled in
+ */
+u32 spimsg_get_buffer (struct spi_msg *message, void **buffer)
+{
+	struct spi_bus_driver *bdrv = SPI_DEV_DRV(message->device);
+	
+	if (!buffer)
+		return 0;
+
+	*buffer = message->buf_ptr;
+
+	if (message->flags & SPI_M_DMAUNSAFE && bdrv->dma_safe_alloc) {
+		*buffer = bdrv->dma_safe_alloc (message->buf_ptr, message->len, message->flags & (SPI_M_RD|SPI_M_WR));
+		if (!*buffer)
+			return 0;
+	}
+	return message->len;
+}
+
+/**
+ * spimsg_put_buffer - put the buffer used by I/O ops
+ * @message: SPI message
+ * @buffer: buffer used for I/O
+ */
+void spimsg_put_buffer (struct spi_msg *message, void *buffer)
+{
+	struct spi_bus_driver *bdrv = SPI_DEV_DRV(message->device);
+
+	if (message->flags & SPI_M_DMAUNSAFE && bdrv->dma_safe_free)
+		bdrv->dma_safe_free (message->buf_ptr, buffer, message->len, message->flags & (SPI_M_RD|SPI_M_WR));
+}
+
+/**
+ * spimsg_get_spidev - obtain the SPI device from the message
+ * @message: SPI message
+ */
+struct spi_device *spimsg_get_spidev (struct spi_msg* message)
+{
+	return message->device;
+}
+
+void spimsg_set_ctx(struct spi_msg *message, void *ctx)
+{
+	message->context = ctx;
+}
+
+void *spimsg_get_ctx(struct spi_msg *message)
+{
+	return message->context;
+}
+
+int spimsg_complete(struct spi_msg *message, int code)
+{
+	if (message->status)
+		message->status(message, code);
+	return code;
+}
+
+static inline struct spi_msg *__spimsg_alloc(struct spi_device *device,
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
+	msg = spimsg_kzalloc();
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
+ * spimsg_alloc - allocate the spi message
+ * @device: target device
+ * @flags: SPI message flags
+ * @buf: user-supplied buffer
+ * @len: buffer's length
+ * @status: user-supplied callback function
+ */
+struct spi_msg *spimsg_alloc(struct spi_device *device,
+					   u32 flags,
+					   void *buf,
+					   unsigned short len,
+					   void (*status) (struct spi_msg *,
+							   int code))
+{
+	return __spimsg_alloc(device, NULL, flags, buf, len, status);
+}
+
+/**
+ * spimsg_chain - allocate the spi message and link it to the current
+ * @msg: current message
+ * @flags: SPI message flags
+ * @buf: user-supplied buffer
+ * @len: buffer's length
+ * @status: user-supplied callback function
+ */
+struct spi_msg *spimsg_chain(struct spi_msg *msg,
+					   u32 flags,
+					   void *buf,
+					   unsigned short len,
+					   void (*status) (struct spi_msg *,
+							   int code))
+{
+	return msg ?
+		__spimsg_alloc(msg->device, msg, flags, buf, len, status) :
+		NULL;
+}
+
+/**
+ * spimsg_free - free the message(s) allocated by spimsg_alloc
+ * @msg: head message to free
+ */
+void spimsg_free(struct spi_msg *msg)
+{
+	if (msg->next)
+		spimsg_free(msg->next);
+	spimsg_kfree(msg);
+}
+
+/**
+ * spimsg_getnext - get next message in chain
+ * @message: this message
+ */
+struct spi_msg *spimsg_getnext(struct spi_msg *message)
+{
+	return message ? message->next : ERR_PTR(-EINVAL);
+}
+
+/**
+ * spi_bus_match_name - verify that driver matches device on spi bus
+ * @dev: device that hasn't yet being assigned to any driver
+ * @drv: driver for spi device
+ * Description:
+ * 	match the device to driver.Drivers and devices on SPI bus
+ * 	are matched by name, just like the platform devices
+ */
+static int spi_bus_match_name(struct device *dev, struct device_driver *drv)
+{
+	return !strcmp(TO_SPI_DEV(dev)->name, drv->name);
+}
+
+/**
+ * spi_bus_suspend - suspend all devices on the spi bus
+ * @dev: spi device to be suspended
+ * @message: PM message
+ * Description:
+ * 	this function set device on SPI bus to suspended state, just
+ * 	like platform_bus does
+ */
+static int spi_bus_suspend(struct device * dev, pm_message_t message)
+{
+	int ret = 0;
+
+	if (dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {
+		ret = TO_SPI_DRIVER(dev->driver)->suspend( TO_SPI_DEV(dev), message);
+		if (ret == 0 )
+			dev->power.power_state = message;
+	}
+	return ret;
+}
+
+/**
+ * spi_bus_resume - resume functioning of all devices on spi bus
+ * @dev: device to resume
+ * Description:
+ * 	This function resumes device on SPI bus, just like platform_bus does
+ */
+static int spi_bus_resume(struct device * dev)
+{
+	int ret = 0;
+
+	if (dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {
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
+ * @bus: registered spi_bus_driver structure
+ * @dev: device that represents spi controller
+ * Description:
+ * 	Once registered by spi_bus_register, the bus driver needs
+ * 	initialization, that includes starting thread, initializing
+ * 	internal structures.. The best place where the spi_bus_driver_init
+ * 	is in the `probe' function, when we already sure that passed
+ * 	device object is SPI master controller.
+ */
+int spi_bus_driver_init(struct spi_bus_driver *bus, struct device *dev)
+{
+	struct spi_bus_data *pd =
+	    kmalloc(sizeof(struct spi_bus_data), SLAB_KERNEL);
+	int err = 0;
+
+	if (!pd) {
+		err = -ENOMEM;
+		goto init_failed;
+	}
+
+	pd->bus = bus;
+	pd->lock = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&pd->msgs);
+	pd->id = dev->bus_id;
+
+	if (!bus->start_async && !bus->stop_async) {
+		bus->start_async = spi_start_async;
+		bus->stop_async = spi_stop_async;
+		if (!bus->queue)
+			bus->queue = spi_queue;
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
+ * spi_bus_driver_cleanup -  cleanup internal driver structures
+ *
+ * @bus: pointer to spi_bus_driver structure to deinitialize
+ * @dev: bus device object
+ *
+ * Description: in order to roll back initialization of bus driver,
+ * which is made by spi_bus_driver_init, this function should be used
+ **/
+int spi_bus_driver_cleanup (struct spi_bus_driver *bus_drv, struct device *dev)
+{
+	struct spi_bus_data *pd = dev->platform_data;
+
+	if (!pd) {
+		if(bus_drv->stop_async)
+			bus_drv->stop_async(dev, pd->async_data);
+		kfree (pd);
+		dev->platform_data = NULL;
+		device_for_each_child(dev, NULL, spi_device_del);
+	}
+	return 0;
+}
+/**
+ * __spi_bus_free -- unregister all children of the spi bus
+ * @dev: the spi bus `device' object
+ * @context: not used, will be NULL
+ * Description:
+ * 	This is an internal function that is called when unregistering
+ * 	bus driver. Responsibility of this function is freeing the
+ * 	resources that were requested by spi_bus_driver_init
+ */
+static int __spi_bus_free(struct device *dev, void *context)
+{
+	return spi_bus_driver_cleanup(TO_SPI_BUS_DRIVER(dev->driver), dev);
+}
+
+/**
+ * spi_bus_driver_unregister - unregister SPI bus controller from the system
+ * @bus_driver: driver registered by call to spi_bus_driver_register
+ * Description:
+ * 	This routine unregisters the SPI bus from the system. Before
+ * 	unregistering, it deletes each SPI device on the bus using call
+ * 	to __spi_device_free
+ */
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
+ * @dev: spi_device to be released
+ * Description:
+ * 	Pointer to this function will be put to dev->release place
+ * 	This fus called as a part of device removing
+ */
+void spi_device_release(struct device *dev)
+{
+	struct spi_device* sdev = TO_SPI_DEV(dev);
+
+	kfree(sdev);
+}
+
+/**
+ * spi_device_add - add the new (discovered) SPI device to the bus. Mostly used by bus drivers
+ * @parent: the bus device object
+ * @name: name of device (non-null!)
+ * @bus_data: bus data to be assigned to device
+ * Description:
+ * 	SPI device usually cannot be discovered by SPI bus driver, so it
+ * 	needs to take the configuration somewhere from hardcoded structures,
+ * 	and prepare bus_data for its devices
+ */
+struct spi_device* spi_device_add(struct device *parent, char *name, void *bus_data)
+{
+	struct spi_device* dev;
+	static int minor = 0;
+
+	if (!name)
+		goto dev_add_out;
+
+	dev = kzalloc(sizeof(struct spi_device), SLAB_KERNEL);
+	if(!dev)
+		goto dev_add_out;
+
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
+/**
+ * spi_device_del - delete the SPI device
+ * @dev: device to delete
+ * @data: data associated with the device
+ */
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
+ * @msg: message that is about to complete
+ * @code: message status
+ * Description:
+ * 	callback for synchronously processed message. If spi_transfer
+ * 	determines that there is no callback provided neither by
+ * 	msg->status nor callback parameter, the __spi_transfer_callback
+ * 	will be used, and spi_transfer does not return until transfer
+ * 	is finished
+ */
+static void __spi_transfer_callback(struct spi_msg *msg, int code)
+{
+	complete(&msg->sync);
+}
+
+/*
+ * spi_transfer - transfer the message either in sync or async way
+ * @msg: message to process
+ * @callback: user-supplied callback
+ * @return:
+ * 	if both msg->status and callback are set, the error code of -EINVAL
+ * 	will be returned
+ */
+int spi_transfer(struct spi_msg *msg, void (*callback) (struct spi_msg *, int))
+{
+	int err = -EINVAL;
+	struct device *bus = msg->device->dev.parent;
+
+	if (msg && TO_SPI_BUS_DRIVER(bus->driver)->queue)
+	{
+		if (callback && !msg->status) {
+			msg->status = callback;
+			callback = NULL;
+		}
+
+		if (!callback) {
+			if (!msg->status) {
+				init_completion (&msg->sync);
+				msg->status = __spi_transfer_callback;
+				err = TO_SPI_BUS_DRIVER(bus->driver)->queue(msg);
+				wait_for_completion(&msg->sync);
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
+ * @dev: the target device
+ * @flags: additional flags for message
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ * @return: Returns the number of bytes transferred, or negative error code.
+ */
+int spi_write(struct spi_device *dev, u32 flags, char *buf, size_t len)
+{
+	struct spi_msg *msg = spimsg_alloc(dev, SPI_M_WR | SPI_M_DMAUNSAFE | flags, buf, len, NULL);
+	int ret;
+
+	ret = spi_transfer(msg, NULL);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_read - receive data from a device on an SPI bus
+ * @dev: the target device
+ * @flags: additional flags for message
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ * @return: Returns the number of bytes transferred, or negative error code.
+ */
+int spi_read(struct spi_device *dev, u32 flags, char *buf, size_t len)
+{
+	int ret;
+	struct spi_msg *msg = spimsg_alloc(dev, SPI_M_RD | SPI_M_DMAUNSAFE | flags, buf, len, NULL);
+
+	ret = spi_transfer(msg, NULL);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_bus_populate - populate the bus
+ * @parent: the SPI bus device object
+ * @devices_s: array of structures that represents bus population
+ * @callback: optional pointer to function that called on each device's add
+ * Description:
+ * 	This function is intended to populate the SPI bus corresponding to
+ * 	device passed as 1st parameter. If some device cannot be added
+ * 	because of spi_device_add fail, the function will not try to parse
+ * 	the rest of list
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
+ * @bus: device object that represents the SPI bus
+ * @context: u32 value to be passed to reset method of bus
+ * Description:
+ * 	This is simple wrapper for bus' `reset' method
+ */
+void spi_bus_reset (struct device *bus, u32 context)
+{
+	if (bus && bus->driver && TO_SPI_BUS_DRIVER(bus->driver)->reset)
+		TO_SPI_BUS_DRIVER(bus->driver)->reset(bus, context);
+}
+
+/*
+ * The functions below are wrappers for corresponding device_driver's methods
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
+	if (ret < 0)
+		goto out;
+
+	ret = spimsg_init();
+	if (ret < 0)
+		goto out;
+
+	ret = bus_register(&spi_bus);
+
+out:
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
+	spimsg_exit();
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
+EXPORT_SYMBOL_GPL(spi_bus_driver_cleanup);
+
+EXPORT_SYMBOL_GPL(spimsg_alloc);
+EXPORT_SYMBOL_GPL(spimsg_chain);
+EXPORT_SYMBOL_GPL(spimsg_free);
+EXPORT_SYMBOL_GPL(spimsg_put_buffer);
+EXPORT_SYMBOL_GPL(spimsg_get_flags);
+EXPORT_SYMBOL_GPL(spimsg_get_buffer);
+EXPORT_SYMBOL_GPL(spimsg_get_clock);
+EXPORT_SYMBOL_GPL(spimsg_set_clock);
+EXPORT_SYMBOL_GPL(spimsg_getnext);
+EXPORT_SYMBOL_GPL(spimsg_get_spidev);
+EXPORT_SYMBOL_GPL(spimsg_set_ctx);
+EXPORT_SYMBOL_GPL(spimsg_get_ctx);
+EXPORT_SYMBOL_GPL(spimsg_complete);
+
Index: linux-2.6.orig/drivers/spi/spi-core.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-core.h
@@ -0,0 +1,32 @@
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
+	u16 len;	/* msg length           */
+	u32 clock;
+	struct spi_device *device;
+	void *context;
+
+	struct completion sync;
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
Index: linux-2.6.orig/drivers/spi/spi-dev.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-dev.c
@@ -0,0 +1,209 @@
+/*
+ *  drivers/spi/spi-dev.c
+ *
+ *  Character device interface for SPI
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
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
+ * spi_class_device_create - wrapper for class_device_create
+ * @minor: sequental minor number of SPI slave device
+ * @device: pointer to struct device embedded to spi_device
+ */
+struct class_device *spi_class_device_create(int minor, struct device *device)
+{
+	return class_device_create(spidev_class, NULL, MKDEV(SPI_MAJOR, minor), device, "spi%d", minor);
+}
+
+/**
+ * spi_class_device_destroy - wrapper for class_device_destroy
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
+/**
+ * spidev_read - read from the SPI device
+ * @file: device file
+ * @buf: buffer to read into
+ * @count: number of bytes to read
+ * @offset: offset to read from
+ */
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
+		rc = spi_read(dev, SPI_M_DMAUNSAFE, kbuf, count);
+		if (rc < 0 || copy_to_user(buf, kbuf, count))
+			rc = -EFAULT;
+		kfree(kbuf);
+	}
+	return rc;
+}
+
+/**
+ * spidev_write - write to the SPI device
+ * @file: device file
+ * @buf: buffer to write the data from
+ * @count: number of bytes to write
+ * @offset: start offset to write to
+ */
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
+			rc = spi_write(dev, SPI_M_DMAUNSAFE, kbuf, count);
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
+/**
+ * spidev_do_open - open the SPI device
+ * @the_device: device structure
+ * @context: context of SPI device
+ */
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
+/**
+ * spidev_open - open the SPI bus device
+ * @inode: device inode
+ * @file: device file
+ */
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
+/**
+ * spidev_release - release the SPI bus device
+ * @inode: device inode
+ * @file: device file
+ */
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
Index: linux-2.6.orig/drivers/spi/spi-thread.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-thread.c
@@ -0,0 +1,187 @@
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
+	wait_queue_head_t wq;
+};
+
+/**
+ * __spi_start_async - start the thread
+ * @dev: device which the thread is related to
+ * @return: abstract pointer to the thread context
+ */
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
+	init_waitqueue_head(&td->wq);
+	return td;
+}
+
+/**
+ * __spi_stop_async - stop the thread
+ * @dev: device which the thread is related to
+ * @ctx: abstract pointer to the thread context
+ */
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
+ * @td: pointer to struct threaded_async_data
+ * Description:
+ * 	Thread wakes up if there is signal to exit (bd->exiting is set)
+ * 	or there are any messages in bus' queue.
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
+		spin_lock_irq(&bd->lock);
+		ret = !list_empty(&bd->msgs);
+		spin_unlock_irq(&bd->lock);
+	}
+	return ret;
+}
+
+/**
+ * spi_bus_next_msg - retrieve the next message
+ * @this: spi_bus_driver that needs to retrieve next message from queue
+ * @data: pointer to spi_bus_data structure associated with spi_bus_driver
+ */
+static struct spi_msg *spi_bus_next_msg(struct spi_bus_driver *this, struct spi_bus_data *data)
+{
+	return list_entry(data->msgs.next, struct spi_msg, link);
+}
+
+/**
+ * spi_thread - the thread that calls bus functions to perform actual transfers
+ * @context: pointer to struct spi_bus_data with bus-specific data
+ * Description:
+ * 	This function is started as separate thread to perform actual
+ * 	transfers on SPI bus
+ **/
+static int spi_thread(void *context)
+{
+	struct threaded_async_data *td = context;
+	struct spi_bus_data *bd = td->dev->platform_data;
+	struct spi_msg *cmsg = NULL;
+	int xfer_status;
+
+	while (!kthread_should_stop()) {
+
+		wait_event_interruptible(td->wq, spi_thread_awake(td));
+
+		if (atomic_read(&td->exiting))
+			goto thr_exit;
+
+		spin_lock_irq(&bd->lock);
+		while (!list_empty(&bd->msgs)) {
+			/*
+			 * this part is locked by bus_data->lock,
+			 * to protect spi_msg extraction
+			 */
+			cmsg = spi_bus_next_msg(bd->bus, bd);
+			list_del (&cmsg->link);
+
+			spin_unlock_irq(&bd->lock);
+
+			/*
+			 * and this part is locked by device's lock;
+			 * spi_queue will be able to queue new
+			 * messages
+			 *
+			 * note that bd->selected_device is locked,
+			 * not msg->device
+			 * they are the same, but msg can be freed in
+			 * msg->status function
+			 */
+			bd->selected_device = spimsg_get_spidev(cmsg);
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
+			spin_lock_irq(&bd->lock);
+		}
+		spin_unlock_irq(&bd->lock);
+	}
+
+thr_exit:
+	return 0;
+}
+
+/**
+ * __spi_queue - (internal) queue the message to be processed asynchronously
+ * @msg: message to be sent
+ * Description:
+ * 	This function queues the message to spi bus driver's queue.
+ */
+int __spi_queue(struct spi_msg *msg)
+{
+	struct device *dev = &msg->device->dev;
+	struct spi_bus_data *pd = dev->parent->platform_data;
+	struct threaded_async_data *td = pd->async_data;
+
+	spin_lock_irq(&pd->lock);
+	list_add_tail(&msg->link, &pd->msgs);
+	dev_dbg(dev->parent, "message has been queued\n");
+	spin_unlock_irq(&pd->lock);
+	wake_up_interruptible(&td->wq);
+	return 0;
+}
+
+
Index: linux-2.6.orig/drivers/spi/spi-thread.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-thread.h
@@ -0,0 +1,42 @@
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
+	extern void *__spi_start_async (struct device *dev);
+	return  __spi_start_async(dev);
+#else
+	return 0;
+#endif
+}
+
+static inline void spi_stop_async (struct device *dev, void *t)
+{
+#ifdef CONFIG_SPI_THREAD
+	extern void __spi_stop_async (struct device *dev, void *t);
+	__spi_stop_async (dev, t);
+#endif
+}
+
+static inline int spi_queue (struct spi_msg *msg)
+{
+#ifdef CONFIG_SPI_THREAD
+	extern int __spi_queue (struct spi_msg *msg);
+	return __spi_queue(msg);
+#else
+	return -EINVAL;
+#endif
+}
+#endif /* __SPI_THREAD_H */
Index: linux-2.6.orig/include/linux/spi.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/include/linux/spi.h
@@ -0,0 +1,252 @@
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
+	spinlock_t lock;
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
+	void   *(*dma_safe_alloc)(void *buf, size_t len, int dir);
+	void    (*dma_safe_free)(void *buf, void *safe, size_t len, int dir);
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
+static inline void *spi_device_get_busdata(struct spi_device *dev)
+{
+	return dev->dev.platform_data;
+}
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
+#define SPI_M_CSKEEP	0x00000010	/**< Don't change CS */
+#define SPI_M_CPOL	0x00000100	/**< Clock polarity */
+#define SPI_M_CPHA	0x00000200	/**< Clock Phase */
+#define SPI_M_DMAUNSAFE 0x10000000	/** buffer is dma-unsafe */
+
+void spimsg_set_ctx (struct spi_msg *message, void *ctx);
+void *spimsg_get_ctx (struct spi_msg *message);
+int spimsg_complete (struct spi_msg *message, int code);
+void spimsg_set_clock (struct spi_msg* message, u32 clock);
+u32 spimsg_get_clock (struct spi_msg* message);
+struct spi_device *spimsg_get_spidev (struct spi_msg* message);
+u32 spimsg_get_flags (struct spi_msg* message);
+u32 spimsg_get_buffer (struct spi_msg *message, void **buffer);
+void spimsg_put_buffer (struct spi_msg *message, void *buffer);
+struct spi_msg *spimsg_alloc(struct spi_device *device,
+			   u32 flags,
+			   void *buf,
+			   unsigned short len,
+			   void (*status) (struct spi_msg *,
+					   int code));
+struct spi_msg *spimsg_chain(struct spi_msg *msg,
+			   u32 flags,
+			   void *buf,
+			   unsigned short len,
+			   void (*status) (struct spi_msg *,
+					   int code));
+
+void spimsg_free (struct spi_msg *message);
+struct spi_msg *spimsg_getnext(struct spi_msg *message);
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
+int spi_bus_driver_cleanup(struct spi_bus_driver *driver, struct device *dev);
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
+static inline int spi_w8r8 (struct spi_device *dev, u8 wr)
+{
+	u8 byte;
+	int rc = -ENOMEM;
+	struct spi_msg *msg;
+
+	msg = spimsg_alloc(dev,
+			SPI_M_WR | SPI_M_CS | SPI_M_DMAUNSAFE,
+			&wr,
+			1,
+			NULL);
+	if (!msg)
+		goto out;
+	msg = spimsg_chain(msg,
+			SPI_M_RD | SPI_M_CSREL | SPI_M_DMAUNSAFE,
+			&byte,
+			1,
+			NULL);
+
+	if (!msg)
+		goto out;
+
+	rc = spi_transfer(msg, NULL);
+	spimsg_free(msg);
+
+out:
+	return rc < 0 ? rc : byte;
+}
+
+static inline int spi_w8r16 (struct spi_device *dev, u8 wr)
+{
+	u16 word;
+	int rc = -ENOMEM;
+	struct spi_msg *msg;
+
+	msg = spimsg_alloc(dev,
+			SPI_M_WR | SPI_M_CS | SPI_M_DMAUNSAFE,
+			&wr,
+			1,
+			NULL);
+	if (!msg)
+		goto out;
+	msg = spimsg_chain(msg,
+			SPI_M_RD | SPI_M_CSREL | SPI_M_DMAUNSAFE,
+			&word,
+			2,
+			NULL);
+
+	if (!msg)
+		goto out;
+
+	rc = spi_transfer(msg, NULL);
+	spimsg_free(msg);
+
+out:
+	return rc < 0 ? rc : word;
+}
+
+static inline int spi_sync(struct spi_msg *message)
+{
+	return spi_transfer(message, NULL);
+}
+
+static inline int spi_async(struct spi_msg *message, void (*status) (struct spi_msg *, int))
+{
+	return spi_transfer(message, status);
+}
+
+#endif				/* SPI_H */
Index: linux-2.6.orig/drivers/spi/spi-alloc.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-alloc.c
@@ -0,0 +1,101 @@
+/*
+ *  linux/drivers/spi/spi-alloc.c
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
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/spi.h>
+#include <asm/atomic.h>
+#include "spi-core.h"
+
+#define SPIMSG_POOL_SIZE	0x10000
+
+static struct spi_msg_pool {
+	void *vaddr;
+	void *cur;
+	int count;
+} spimsg_pool;
+
+static spinlock_t spimsg_lock = SPIN_LOCK_UNLOCKED;
+
+struct spi_msg *__spimsg_kzalloc(void)
+{
+	struct spi_msg *msg = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spimsg_lock, flags);
+	if (spimsg_pool.count > 4) {
+		msg = *(struct spi_msg **) spimsg_pool.cur;
+		*(void **)spimsg_pool.cur = **(void ***)spimsg_pool.cur;
+		memset(msg, 0, sizeof(*msg));
+		spimsg_pool.count--;
+	}
+	spin_unlock_irqrestore(&spimsg_lock, flags);
+
+	return msg;
+}
+
+void __spimsg_kfree(struct spi_msg *msg)
+{
+	unsigned long flags;
+
+	if (msg) {
+		if ((unsigned long)((long)msg - (long)spimsg_pool.vaddr) >
+				SPIMSG_POOL_SIZE) {
+			printk(KERN_ERR "Trying to free entry not from the SPI pool\n");
+			BUG();
+		}
+
+		spin_lock_irqsave(&spimsg_lock, flags);
+		*(long *)msg = *(long *)spimsg_pool.cur;
+		*(long *)spimsg_pool.cur = (long)msg;
+		spimsg_pool.count++;
+		spin_unlock_irqrestore(&spimsg_lock, flags);
+	}
+}
+
+int __spimsg_init(void)
+{
+	int ret = 0, i;
+
+	int size = ((sizeof(struct spi_msg) + 3) >> 2) << 2;
+
+	spimsg_pool.cur = spimsg_pool.vaddr =
+		kzalloc(SPIMSG_POOL_SIZE, SLAB_KERNEL);
+
+	if (!spimsg_pool.cur) {
+		printk(KERN_ERR "Couldn't allocate large buffer for SPI\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spimsg_pool.count = SPIMSG_POOL_SIZE / size;
+	for (i = 0; i < spimsg_pool.count - 1; i++) {
+		void **addr = spimsg_pool.vaddr + i*size;
+		*addr = (void *)addr + size;
+	}
+	*(long *)(spimsg_pool.vaddr + (spimsg_pool.count - 1) * size) =
+	    (long)spimsg_pool.vaddr;
+
+out:
+	return ret;
+}
+
+void __spimsg_exit(void)
+{
+	if (spimsg_pool.vaddr)
+		kfree(spimsg_pool.vaddr);
+}
Index: linux-2.6.orig/drivers/spi/spi-alloc.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-alloc.h
@@ -0,0 +1,54 @@
+/*
+ *  linux/linux/drivers/spi/spi-alloc.h
+ *
+ *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+#ifndef __SPI_ALLOC_H
+#define __SPI_ALLOC_H
+
+#include <linux/slab.h>
+
+static inline struct spi_msg *spimsg_kzalloc(void)
+{
+#ifdef CONFIG_SPI_CUSTOM_ALLOC
+	extern struct spi_msg *__spimsg_kzalloc(void);
+	return  __spimsg_kzalloc();
+#else
+	return kzalloc(sizeof(struct spi_msg), SLAB_KERNEL);
+#endif
+}
+
+static inline void spimsg_kfree(struct spi_msg *msg)
+{
+#ifdef CONFIG_SPI_CUSTOM_ALLOC
+	extern void __spimsg_kfree (struct spi_msg *msg);
+	__spimsg_kfree(msg);
+#else
+	kfree(msg);
+#endif
+}
+
+static inline int spimsg_init(void)
+{
+#ifdef CONFIG_SPI_CUSTOM_ALLOC
+	extern int __spimsg_init(void);
+	return __spimsg_init();
+#else
+	return 0;
+#endif
+}
+
+static inline void spimsg_exit(void)
+{
+#ifdef CONFIG_SPI_CUSTOM_ALLOC
+	extern void __spimsg_exit(void);
+	__spimsg_exit();
+#endif
+}
+
+#endif /* __SPI_ALLOC_H */
