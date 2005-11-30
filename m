Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVK3Quj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVK3Quj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVK3Quj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:50:39 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:35806 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751450AbVK3Qui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:50:38 -0500
Date: Wed, 30 Nov 2005 19:50:53 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git] SPI core refresh
Message-Id: <20051130195053.713ea9ef.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is an updated version of SPI framework developed by Dmitry Pervushin and Vitaly Wool.

The main changes are:

- Matching rmk's 2.6.14-git5+ changes for device_driver suspend and resume calls
- The character device interface was reworked

I still think that we need to continue converging with David Brownell's core, despite some misalignments happening in the email exchange :). Although it's not yet done in our core, I plan to move to 
- using chained SPI messages as David does
- maybe rework the SPI device interface more taking David's one as a reference

However, there also are some advantages of our core compared to David's I'd like to mention

- it can be compiled as a module
- it is DMA-safe
- it is priority inversion-free
- it can gain more performance with multiple controllers
- it's more adapted for use in real-time environments
- it's not so lightweight, but it leaves less effort for the bus driver developer.

It's also been proven to work on SPI EEPROMs and SPI WiFi module (the latter was a really good survival test! :)).

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: dmitry pervushin <dpervushin@gmail.com>

 arch/arm/Kconfig       |    2 
 drivers/Kconfig        |    2 
 drivers/Makefile       |    1 
 drivers/spi/Kconfig    |   33 ++
 drivers/spi/Makefile   |   14 +
 drivers/spi/spi-core.c |  650 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dev.c  |  176 +++++++++++++
 include/linux/spi.h    |  297 ++++++++++++++++++++++
 8 files changed, 1175 insertions(+)

diff -uNr linux-2.6.orig/include/linux/spi.h linux-2.6/include/linux/spi.h
--- linux-2.6.orig/include/linux/spi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/include/linux/spi.h	2005-11-30 19:03:51.000000000 +0300
@@ -0,0 +1,297 @@
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
+#define kzalloc(size,type) kcalloc(1,size,type)
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
+	char *id;
+};
+
+#define TO_SPI_BUS_DRIVER(drv) container_of( drv, struct spi_bus_driver, driver )
+struct spi_bus_driver {
+	int 	(*xfer) (struct spi_msg * msg);
+	void 	(*select) (struct spi_device * dev);
+	void 	(*deselect) (struct spi_device * dev);
+	void 	(*set_clock) (struct device * bus_device, u32 clock_hz);
+	void 	(*reset) (struct device *bus_device, u32 context);
+	struct spi_msg *
+		(*retrieve) (struct spi_bus_driver *bus, struct spi_bus_data *data);
+	struct device_driver driver;
+};
+
+#define TO_SPI_DEV(device) container_of( device, struct spi_device, dev )
+struct spi_device {
+	char name[BUS_ID_SIZE];
+	void *private;
+	int minor;
+	struct class_device *cdev;
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
+	u32  flags;
+#define SPI_M_RD	0x00000001
+#define SPI_M_WR	0x00000002	/**< Write mode flag */
+#define SPI_M_CSREL	0x00000004	/**< CS release level at end of the frame  */
+#define SPI_M_CS	0x00000008	/**< CS active level at begining of frame ( default low ) */
+#define SPI_M_CPOL	0x00000010	/**< Clock polarity */
+#define SPI_M_CPHA	0x00000020	/**< Clock Phase */
+#define SPI_M_EXTBUF	0x80000000    	/** externally allocated buffers */
+#define SPI_M_ASYNC_CB	0x40000000      /** use workqueue to deliver callbacks */
+#define SPI_M_DNA	0x20000000	/** do not allocate buffers */
+
+	unsigned short len;	/* msg length           */
+	unsigned long clock;
+	struct spi_device *device;
+	void *context;
+	void *arg;
+	void *parent;		/* in case of complex messages */
+	struct list_head link;
+
+	void (*status) (struct spi_msg * msg, int code);
+
+	void *devbuf_rd, *devbuf_wr;
+	u8 *databuf_rd, *databuf_wr;
+
+	struct work_struct wq_item;
+};
+
+#ifdef CONFIG_SPI_CHARDEV
+extern struct class_device *spi_class_device_create(int minor, struct device *device);
+extern void spi_class_device_destroy(int minor);
+#else
+#define spi_class_device_create(a, b)		NULL
+#define spi_class_device_destroy(a)		do { } while (0)
+#endif
+
+static inline struct spi_msg *spimsg_alloc(struct spi_device *device,
+					   unsigned flags,
+					   unsigned short len,
+					   void (*status) (struct spi_msg *,
+							   int code))
+{
+	struct spi_msg *msg;
+	struct spi_driver *drv = SPI_DEV_DRV(device);
+	int msgsize = sizeof (struct spi_msg);
+
+	if (drv->alloc || (flags & (SPI_M_RD|SPI_M_WR)) == (SPI_M_RD | SPI_M_WR ) ) {
+		pr_debug ( "%s: external buffers\n", __FUNCTION__ );
+		flags |= SPI_M_EXTBUF;
+	} else {
+		pr_debug ("%s: no ext buffers, msgsize increased from %d by %d to %d\n", __FUNCTION__,
+				msgsize, len, msgsize + len );
+		msgsize += len;
+	}
+
+	msg = kmalloc( msgsize, GFP_KERNEL);
+	if (!msg)
+		return NULL;
+	memset(msg, 0, sizeof(struct spi_msg));
+	msg->len = len;
+	msg->status = status;
+	msg->device = device;
+	msg->flags = flags;
+	INIT_LIST_HEAD(&msg->link);
+
+	if (flags & SPI_M_DNA )
+		return msg;
+
+	/* otherwise, we need to set up pointers */
+	if (!(flags & SPI_M_EXTBUF)) {
+		msg->databuf_rd = msg->databuf_wr =
+			(u8*)msg + sizeof ( struct spi_msg);
+	} else {
+		if (flags & SPI_M_RD) {
+			msg->devbuf_rd = drv->alloc ?
+		    		drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
+			msg->databuf_rd = drv->get_buffer ?
+		    		drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
+		}
+		if (flags & SPI_M_WR) {
+			msg->devbuf_wr = drv->alloc ?
+		    		drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
+			msg->databuf_wr = drv->get_buffer ?
+		    		drv->get_buffer(device, msg->devbuf_wr) : msg->devbuf_wr;
+		}
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
+
+		if ( !(msg->flags & SPI_M_DNA) || (msg->flags & SPI_M_EXTBUF) ) {
+			if (drv->free)
+				do_free = drv->free;
+			if (drv->release_buffer) {
+				if (msg->databuf_rd)
+					drv->release_buffer(msg->device,
+						    msg->databuf_rd);
+				if (msg->databuf_wr)
+					drv->release_buffer(msg->device,
+						    msg->databuf_wr);
+			}
+			if (msg->devbuf_rd)
+				do_free(msg->devbuf_rd);
+			if (msg->devbuf_wr)
+				do_free(msg->devbuf_wr);
+		}
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
+static inline void spimsg_set_rd( struct spi_msg* msg, void* buf )
+{
+	msg->databuf_rd = buf;
+}
+
+static inline void spimsg_set_wr (struct spi_msg *msg, void *buf )
+{
+	msg->databuf_wr = buf;
+}
+
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
+#ifdef CONFIG_SPI_CHARDEV
+extern int __init spidev_init(void);
+extern void __exit spidev_cleanup(void);
+#else
+#define spidev_init()		(0)
+#define spidev_cleanup()	do { } while (0)
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
+extern void spi_bus_reset(struct device* bus, u32 context);
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
diff -uNr linux-2.6.orig/arch/arm/Kconfig linux-2.6/arch/arm/Kconfig
--- linux-2.6.orig/arch/arm/Kconfig	2005-11-30 16:19:55.000000000 +0300
+++ linux-2.6/arch/arm/Kconfig	2005-11-30 16:22:35.000000000 +0300
@@ -748,6 +748,8 @@
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"

diff -uNr linux-2.6.orig/drivers/Kconfig linux-2.6/drivers/Kconfig
--- linux-2.6.orig/drivers/Kconfig	2005-11-30 16:19:55.000000000 +0300
+++ linux-2.6/drivers/Kconfig	2005-11-30 16:22:35.000000000 +0300
@@ -44,6 +44,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
diff -uNr linux-2.6.orig/drivers/Makefile linux-2.6/drivers/Makefile
--- linux-2.6.orig/drivers/Makefile	2005-11-30 16:19:55.000000000 +0300
+++ linux-2.6/drivers/Makefile	2005-11-30 16:22:35.000000000 +0300
@@ -69,3 +69,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_SPI)		+= spi/
diff -uNr linux-2.6.orig/drivers/spi/Kconfig linux-2.6/drivers/spi/Kconfig
--- linux-2.6.orig/drivers/spi/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/Kconfig	2005-11-30 16:22:35.000000000 +0300
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
diff -uNr linux-2.6.orig/drivers/spi/Makefile linux-2.6/drivers/spi/Makefile
--- linux-2.6.orig/drivers/spi/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/Makefile	2005-11-30 16:22:35.000000000 +0300
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
diff -uNr linux-2.6.orig/drivers/spi/spi-core.c linux-2.6/drivers/spi/spi-core.c
--- linux-2.6.orig/drivers/spi/spi-core.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-core.c	2005-11-30 19:03:52.000000000 +0300
@@ -0,0 +1,650 @@
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
+static int spi_device_del(struct device *dev, void *data);
+
+/**
+ * spi_bus_match_name - verify that driver matches device on spi bus
+ *
+ * @dev: device that hasn't yet being assigned to any driver
+ * @drv: driver for spi device
+ *
+ * Drivers and devices on SPI bus are matched by name, just like the
+ * platform devices, with exception of SPI_DEV_CHAR. Driver with this name
+ * will be matched against any device
+**/
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
+**/
+static int spi_bus_suspend(struct device * dev, pm_message_t message)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, message);
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
+	if (dev->driver && dev->driver->resume)
+		ret = dev->driver->resume(dev);
+	return ret;
+}
+
+/**
+ * spi_bus - the &bus_type structure for SPI devices and drivers
+ *
+ * @name: the name of subsystem, "spi" here
+ * @match: function that matches devices to their drivers
+ * @suspend: PM callback to suspend device
+ * @resume: PM callback to resume device
+**/
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
+		goto init_failed_1;
+	}
+	atomic_set(&pd->exiting, 0);
+	pd->bus = bus;
+	init_MUTEX(&pd->lock);
+	INIT_LIST_HEAD(&pd->msgs);
+	init_waitqueue_head(&pd->queue);
+	pd->id = dev->bus_id;
+	pd->thread = kthread_run(spi_thread, pd, "%s-work", pd->id);
+	if (IS_ERR(pd->thread)) {
+		err = PTR_ERR(pd->thread);
+		goto init_failed_2;
+	}
+	dev->platform_data = pd;
+	return 0;
+
+init_failed_2:
+	kfree(pd);
+init_failed_1:
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
+
+	if (pd) {
+		atomic_inc(&pd->exiting);
+		kthread_stop(pd->thread);
+		kfree(pd);
+	}
+
+	dev_dbg(dev, "unregistering children\n");
+
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
+	if( !dev )
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
+		spi_class_device_destroy(spidev->minor);
+		spidev->cdev = NULL;
+	}
+	device_unregister(&spidev->dev);
+	return 0;
+}
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
+/**
+ * spi_thread_awake - function that called to determine if thread needs to process any messages
+ *
+ * @bd: pointer to struct spi_bus_data
+ *
+ * Thread wakes up if there is signal to exit (bd->exiting is set) or there are any messages
+ * in bus' queue.
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
+static void spi_async_callback(void *_msg)
+{
+	struct spi_msg *msg = _msg;
+
+	msg->status (msg, SPIMSG_OK);
+}
+
+/**
+ * spi_bus_fifo_retrieve - simple function to retrieve the first message from the queue
+ *
+ * @this: spi_bus_driver that needs to retrieve next message from queue
+ * @data: pointer to spi_bus_data structure associated with spi_bus_driver
+ *
+ * This is pretty simple `retrieve' function. It retrieves the first message from the queue,
+ * and does not care about target of the message. For simple cases, this function is the best
+ * and the fastest solution to provide as retrieve method of bus driver
+ **/
+static struct spi_msg *spi_bus_fifo_retrieve (struct spi_bus_driver *this, struct spi_bus_data *data)
+{
+	return list_entry(data->msgs.next, struct spi_msg, link);
+}
+
+/**
+ * spi_bus_simple_retrieve -- retrieve message from the queue with taking into account previous target
+ *
+ * @this: spi_bus_driver that needs to retrieve next message from queue
+ * @data: pointer to spi_bus_data structure associated with spi_bus_driver
+ *
+ * this function is more complex than spi_bus_fifo_retrieve; it takes into account the already selected
+ * device on SPI bus, and tries to retrieve the message targeted to the same device.
+ *
+ **/
+static struct spi_msg *spi_bus_simple_retrieve( struct spi_bus_driver *this, struct spi_bus_data *data)
+{
+	int found = 0;
+	struct spi_msg *msg;
+
+	list_for_each_entry(msg, &data->msgs, link) {
+		if (!data->selected_device || msg->device == data->selected_device) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		/*
+		 * all messages for current selected_device
+		 * are processed.
+		 * let's switch to another device
+		 */
+		msg = list_entry(data->msgs.next, struct spi_msg, link);
+
+	return msg;
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
+static struct spi_msg *spi_bus_next_msg( struct spi_bus_driver *this, struct spi_bus_data *data)
+{
+	if (!this)
+       		return NULL;
+	if (this->retrieve)
+		return this->retrieve (this, data);
+	return spi_bus_fifo_retrieve( this, data );
+}
+
+/**
+ * spi_thread - the thread that calls bus functions to perform actual transfers
+ *
+ * @pd: pointer to struct spi_bus_data with bus-specific data
+ *
+ * This function is started as separate thread to perform actual
+ * transfers on SPI bus
+ **/
+static int spi_thread(void *context)
+{
+	struct spi_bus_data *bd = context;
+	struct spi_msg *msg;
+	int xfer_status;
+	struct workqueue_struct *wq;
+
+	wq = create_workqueue ( bd->id );
+	if (!wq)
+		pr_debug( "%s: cannot create workqueue, async callbacks will be unavailable\n", bd->id );
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
+			msg = spi_bus_next_msg( bd->bus, bd );
+
+			/* verify if device needs re-selecting */
+			if (bd->selected_device != msg->device) {
+				if (bd->selected_device && bd->bus->deselect)
+					bd->bus->deselect (bd->selected_device);
+				bd->selected_device = msg->device;
+				if (bd->bus->select)
+					bd->bus->select (bd->selected_device);
+			}
+			list_del(&msg->link);
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
+			spi_device_lock(&bd->selected_device);
+			if (bd->bus->set_clock && msg->clock)
+				bd->bus->set_clock(msg->device->dev.parent,
+						msg->clock);
+			xfer_status = bd->bus->xfer(msg);
+			if (msg->status) {
+				if (msg->flags & SPI_M_ASYNC_CB) {
+					INIT_WORK( &msg->wq_item, spi_async_callback, msg);
+					queue_work (wq, &msg->wq_item);
+				} else {
+					msg->status(msg,
+					    xfer_status == 0 ? SPIMSG_OK :
+					    SPIMSG_FAILED);
+				}
+			}
+
+			spi_device_unlock(&bd_selected->device);
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
+
+thr_exit:
+	if (wq)
+		destroy_workqueue (wq);
+	return 0;
+}
+
+/**
+ * spi_write - send data to a device on an SPI bus
+ *
+ * @dev: the target device
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ *
+ * Returns the number of bytes transferred, or negative error code.
+**/
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
+/**
+ * spi_read - receive data from a device on an SPI bus
+ *
+ * @dev: the target device
+ * @buf: buffer to be sent
+ * @len: buffer's length
+ *
+ * Returns the number of bytes transferred, or negative error code.
+**/
+int spi_read(struct spi_device *dev, char *buf, int len)
+{
+	int ret;
+	struct spi_msg *msg = spimsg_alloc(dev, SPI_M_RD, len, NULL);
+
+	ret = spi_transfer(msg, NULL);
+	memcpy(buf, spimsg_buffer_rd(msg), len);
+	return ret == 1 ? len : ret;
+}
+
+/**
+ * spi_bus_populate/spi_bus_populate2 - populate the bus
+ *
+ * @parent: the SPI bus device object
+ * @devices: string that represents bus population
+ * @devices_s: array of structures that represents bus population
+ * @callback: optional pointer to function that called on each device's add
+ *
+ * These two functions intended to populate the SPI bus corresponding to
+ * device passed as 1st parameter. The difference is in the way to describe
+ * new SPI slave devices: the spi_bus_populate takes the ASCII string delimited
+ * by '\0', where each section matches one SPI device name _and_ its parameters,
+ * and the spi_bus_populate2 takes the array of structures spi_device_desc.
+ *
+ * If some device cannot be added because of spi_device_add fail, the function will
+ * not try to parse the rest of list
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
+		if ((new_device = spi_device_add(parent, devices, NULL)) == NULL)
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
+				devices_s->name );
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
+void spi_bus_reset (struct device* bus, u32 context)
+{
+	if (bus && bus->driver && TO_SPI_BUS_DRIVER(bus->driver)->reset)
+		TO_SPI_BUS_DRIVER(bus->driver)->reset( bus, context );
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
+EXPORT_SYMBOL_GPL(spi_bus_fifo_retrieve);
+EXPORT_SYMBOL_GPL(spi_bus_simple_retrieve);
+
diff -uNr linux-2.6.orig/drivers/spi/spi-dev.c linux-2.6/drivers/spi/spi-dev.c
--- linux-2.6.orig/drivers/spi/spi-dev.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/spi/spi-dev.c	2005-11-30 19:03:54.000000000 +0300
@@ -0,0 +1,176 @@
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
+struct class_device *spi_class_device_create(int minor, struct device *device)
+{
+	return class_device_create(spidev_class, NULL, MKDEV(SPI_MAJOR, minor), device, "spi%d", minor);
+}
+
+void spi_class_device_destroy(int minor)
+{
+	class_device_destroy(spidev_class, MKDEV(SPI_MAJOR, minor));
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
+	printk(KERN_ERR "%s: Driver initialization failed\n", __FILE__);
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
+MODULE_DESCRIPTION("SPI /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(spidev_init);
+module_exit(spidev_cleanup);
