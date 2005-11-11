Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVKKKQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVKKKQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVKKKQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:16:29 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:64694 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751262AbVKKKQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:16:28 -0500
Subject: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: spi-devel-general@lists.sourceforge.net
Content-Type: text/plain
Date: Fri, 11 Nov 2005 13:11:21 +0300
Message-Id: <1131703881.5324.4.camel@fj-laptop.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of SPI framework from me, Dmitry Pervushin.
It seems that now it is good time to consolidate our SPI frameworks to
push it to kernel :)

We've tested our SPI core as well with bus drivers with wireless LAN
driver and achieved good performance with relatively small overhead.
This proves the viability of this framework in real life even in
real-time environment. The size of .text is
still about 2,500 bytes, that is comparable with David Brownell's
framework size.

I think now is the time to start the final convergence process for these
two cores and get the final core 
into the mainline kernel. And in order to understand where we need to
converge, I created the main differences
list (see below).

The list of main differences between David Brownell's SPI framework (A)
and my one (B):
- (A) uses more complicated structure of SPI message, that contains one
or more atomic transfers, and (B)
 offers the only spi_msg that represents the atomic transfer on SPI bus.
The similar approach can be imple-
 mented in (B), and actually is implemented. But my imp[ression is that
such enhancement may be added later..
- (A) uses workqueues to queue and handle SPI messages, and (B)
allocates the kernel thread to the same purpose.
 Using workqueues is not very good solution in real-time environment; I
think that allocating and starting the 
 separate thread will give us more predictable and stable results;
- (A) has some assumptions on buffers that are passed down to spi
functions. If some controller driver (or bus driver
 in terms of (B)) tries to perform DMA transfers, it must copy the
passed buffers to some memory allocated
 using GFP_DMA flag and map it using dma_map_single. From the other
hand, (B) relies on callbacks provided 
 by SPI device driver to allocate memory for DMA transfers, but keeps
ability to pass user-allocated buffers down
 to SPI functions by specifying flags in SPI message. SPI message being
a fundamental essense looks better to me when 
 it's as simple as possible. Especially when we don't lose any
flexibility which is exacly our case (buffers that are
 allocated as well as message itself/provided by user, DMA-capable
buffers..)		 
- (A) retrieves SPI message from the queue in sequential order (FIFO),
but (B) provides more flexible way by providing
 special callback to retrieve next message from queue. This callback may
implement its own discipline of scheduling 
 SPI messages. In any way, the default is FIFO.
- (A) uses standartized way to provide CS information, and (B) relies on
functional drivers callbacks, which looks more
 flexible to me.

SIgned-off-by: dmitry pervushin <dpervushin@gmail.com>

 linux/include/linux/spi.h |  285 +++++++++++++++
 linux/Documentation/spi.txt          |  382 ++++++++++++++++++++
 linux/arch/arm/Kconfig               |    2 
 linux/drivers/Kconfig                |    2 
 linux/drivers/Makefile               |    1 
 linux/drivers/spi/Kconfig            |   33 +
 linux/drivers/spi/Makefile           |   14 
 linux/drivers/spi/spi-core.c         |  645 +++++++++++++++++++++++++++++++++++
 linux/drivers/spi/spi-dev.c          |  219 +++++++++++
 9 files changed, 1583 insertions(+)
Index: linux/arch/arm/Kconfig
===================================================================
--- linux.orig/arch/arm/Kconfig
+++ linux/arch/arm/Kconfig
@@ -834,6 +834,8 @@ source "drivers/ssi/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "ktools/Kconfig"
Index: linux/drivers/Kconfig
===================================================================
--- linux.orig/drivers/Kconfig
+++ linux/drivers/Kconfig
@@ -42,6 +42,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/misc/Kconfig"
Index: linux/drivers/Makefile
===================================================================
--- linux.orig/drivers/Makefile
+++ linux/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_DPM)		+= dpm/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-y				+= firmware/
 obj-$(CONFIG_EVENT_BROKER)	+= evb/
+obj-$(CONFIG_SPI)		+= spi/
Index: linux/drivers/spi/Kconfig
===================================================================
--- /dev/null
+++ linux/drivers/spi/Kconfig
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
Index: linux/drivers/spi/Makefile
===================================================================
--- /dev/null
+++ linux/drivers/spi/Makefile
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
Index: linux/drivers/spi/spi-core.c
===================================================================
--- /dev/null
+++ linux/drivers/spi/spi-core.c
@@ -0,0 +1,645 @@
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
+	return !strcmp(drv->name, SPI_DEV_CHAR) ||
+	    !strcmp(TO_SPI_DEV(dev)->name, drv->name);
+}
+
+/**
+ * spi_bus_suspend - suspend all devices on the spi bus
+ *
+ * @dev: spi device to be suspended
+ * @state: state of device to be set
+ *
+ * This function set device on SPI bus to state `state', just like platform_bus does
+**/
+static int spi_bus_suspend(struct device * dev, u32 state)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend) {
+		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
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
+	if (dev->driver && dev->driver->resume) {
+		ret = dev->driver->resume(dev, RESUME_POWER_ON);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_ENABLE);
+	}
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
+		driver_for_each_dev(&bus_driver->driver, NULL, __spi_bus_free);
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
+ * This function gets called as a part of device removing
+**/
+void spi_device_release(struct device *dev)
+{
+	struct spi_device* sdev = TO_SPI_DEV(dev);
+
+	kfree( sdev );
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
+	return dev;
+
+dev_add_out_2:
+	kfree(dev);
+dev_add_out:
+	return NULL;
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
+static void spi_async_callback (void *_msg )
+{
+	struct spi_msg *msg = _msg;
+
+	msg->status ( msg, SPIMSG_OK );
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
+	return list_entry(data->msgs.next, struct spi_msg, link)
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
+						   msg->clock);
+			xfer_status = bd->bus->xfer(msg);
+			if (msg->status) {
+				if (msg->flags & SPI_M_ASYNC_CB ) {
+					INIT_WORK( &msg->wq_item, spi_async_callback, msg );
+					queue_work (wq, &msg->wq_item );
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
+	struct spimsg *msg = spimsg_alloc(dev, SPI_M_RD, len, NULL);
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
+				devices->name );
+		if ((new_device = spi_device_add(parent, devices_s->name, devices_s->params)) == NULL)
+			break;
+		if (callback)
+			callback(parent, new_device, devices_s->params);
+		devices++;
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
Index: linux/drivers/spi/spi-dev.c
===================================================================
--- /dev/null
+++ linux/drivers/spi/spi-dev.c
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
Index: linux/Documentation/spi.txt
===================================================================
--- /dev/null
+++ linux/Documentation/spi.txt
@@ -0,0 +1,382 @@
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
+	struct spi_msg *(*retrieve)( struct spi_bus_driver *this, struct spi_bus_data *bd);
+	void (*reset)( struct spi_bus_driver *this, u32 context);
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
+	reset
+		pointer to function that performs reset of SPI bus
+	retrieve
+		this function is used to retrieve next message from queue. If NULL,
+		spi_bus_fifo_retrieve is used
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
Index: linux/include/linux/spi.h
===================================================================
--- /dev/null
+++ linux/include/linux/spi.h
@@ -0,0 +1,285 @@
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
+static inline int spi_bus_driver_register (struct spi_bus_driver *bus_driver )
+{
+	return driver_register (&bus_driver->driver);
+}
+
+void spi_bus_driver_unregister(struct spi_bus_driver *);
+int spi_bus_driver_init(struct spi_bus_driver *driver, struct device *dev);
+struct spi_device* spi_device_add(struct device *parent, char *name, void *private);
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



