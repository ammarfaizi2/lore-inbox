Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVLOMTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVLOMTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVLOMTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:19:15 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:54932 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965165AbVLOMTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:19:15 -0500
Date: Thu, 15 Dec 2005 15:19:48 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: [PATCH/RFC] SPI:  async message handing library update
Message-Id: <20051215151948.497d703b.vwool@ru.mvista.com>
In-Reply-To: <20051213170629.7240d211.vwool@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	<20051213170629.7240d211.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an update of the library for handling async SPI messages using kernel threads, one per each SPI controller. The only change is that thread's mutex has been changed to spinlock, in order to make it possible to call transfer function from the interrupt context.

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 drivers/spi/Kconfig            |    9 +
 drivers/spi/Makefile           |    3
 drivers/spi/spi-thread.c       |  198 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-thread.h |   27 +++++
 include/linux/spi/spi.h        |    3
 5 files changed, 240 insertions(+)

Index: linux-2.6.orig/drivers/spi/Kconfig
===================================================================
--- linux-2.6.orig.orig/drivers/spi/Kconfig
+++ linux-2.6.orig/drivers/spi/Kconfig
@@ -13,6 +13,7 @@ config SPI_ARCH_HAS_MASTER
 	default y if ARCH_AT91
 	default y if ARCH_OMAP
 	default y if ARCH_PXA
+	default y if ARCH_PNX4008
 	default y if X86	# devel hack only!!  (ICH7 can...)
 
 config SPI_ARCH_HAS_SLAVE
@@ -63,6 +64,14 @@ config SPI_MASTER
 	  controller and the protocol drivers for the SPI slave chips
 	  that are connected.
 
+config SPI_THREAD
+	boolean "Library for threaded asynchronous message processing"
+	depends on SPI_MASTER
+	help
+	  Choose this if you want to use thread-based asynchronous
+	  message processing library. Using kernel threads for
+	  asynchronous data processing is the most common option.
+
 comment "SPI Master Controller Drivers"
 	depends on SPI_MASTER
 
Index: linux-2.6.orig/drivers/spi/Makefile
===================================================================
--- linux-2.6.orig.orig/drivers/spi/Makefile
+++ linux-2.6.orig/drivers/spi/Makefile
@@ -10,6 +10,9 @@ endif
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
+# thread-based async message handling library
+obj-$(CONFIG_SPI_THREAD)		+= spi-thread.o
+
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 # 	... add above this line ...
Index: linux-2.6.orig/drivers/spi/spi-thread.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spi-thread.c
@@ -0,0 +1,198 @@
+/*
+ *  drivers/spi/spi-thread.c
+ *
+ * Authors:
+ * 	Vitaly Wool <vwool@ru.mvista.com>
+ * 	Dmitry Pervushin <dpervushin@gmail.com>
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
+#include <linux/spi/spi.h>
+#include <asm/atomic.h>
+
+static int spi_thread(void *);
+static int spi_queue(struct spi_device *, struct spi_message *);
+
+struct threaded_async_data {
+	atomic_t exiting;
+	struct spi_master *master;
+	struct task_struct *thread;
+	wait_queue_head_t wq;
+	struct list_head msgs;
+	spinlock_t lock;
+	int (*xfer) (struct spi_master *, struct spi_message *);
+};
+
+/**
+ * spi_start_async - start the thread
+ * @master: SPI controller structure which the thread is related to
+ * @return: abstract pointer to the thread context
+ */
+int spi_start_async (struct spi_master *master, int (*xfer)(struct spi_master *, struct spi_message *))
+{
+	struct threaded_async_data *td = kzalloc (sizeof (struct threaded_async_data), GFP_KERNEL);
+	int rc = 0;
+
+	if (!td) {
+		rc =  -ENOMEM;
+		goto out;
+	}
+
+	if (master->context) {
+		rc = -EEXIST;
+		goto out;
+	}
+
+	td->master = master;
+	atomic_set(&td->exiting, 0);
+	td->thread = kthread_run(spi_thread, td, "%s-work", master->cdev.dev->bus_id);
+	init_waitqueue_head(&td->wq);
+	spi_lock_init(&td->lock);
+	INIT_LIST_HEAD(&td->msgs);
+	master->transfer = spi_queue;
+	td->xfer = xfer;
+	master->context = td;
+
+out:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(spi_start_async);
+
+/**
+ * spi_stop_async - stop the thread
+ * @master: SPI controller structure which the thread is related to
+ */
+void spi_stop_async (struct spi_master *master)
+{
+	struct threaded_async_data *td = master->context;
+
+	if (td) {
+		/* TODO: free messages, if any */
+		atomic_inc (&td->exiting);
+		kthread_stop(td->thread);
+		kfree(td);
+		master->context = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(spi_stop_async);
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
+
+	if (!td || atomic_read(&td->exiting)) {
+		goto out;
+	}
+
+	spin_lock_irq(&td->lock);
+	ret = !list_empty(&td->msgs);
+	spin_unlock_irq(&td->lock);
+out:
+	return ret;
+}
+
+/**
+ * spi_get_next_msg - retrieve the next message
+ * @data: pointer to threaded_async_data structure associated with
+ * SPI controller thread
+ */
+static inline struct spi_message *spi_get_next_msg(struct threaded_async_data *data)
+{
+	return list_entry(data->msgs.next, struct spi_message, queue);
+}
+
+/**
+ * spi_thread - the thread that calls bus functions to perform actual transfers
+ * @context: pointer to struct spi_bus_data with bus-specific data
+ * Description:
+ * 	This function is started as separate thread to perform actual
+ * 	transfers on SPI bus
+ */
+static int spi_thread(void *context)
+{
+	struct threaded_async_data *td = context;
+	struct spi_message *message = NULL;
+
+	while (!kthread_should_stop()) {
+
+		wait_event_interruptible(td->wq, spi_thread_awake(td));
+
+		if (atomic_read(&td->exiting))
+			goto thr_exit;
+
+		spin_lock_irq(&td->lock);
+		while (!list_empty(&td->msgs)) {
+			/*
+			 * this part is locked by td->lock,
+			 * to protect spi_message extraction
+			 */
+			message = spi_get_next_msg(td);
+			list_del (&message->queue);
+
+			spin_unlock_irq(&td->lock);
+
+			message->status = td->xfer(td->master, message);
+			if (message->complete)
+				message->complete(context);
+
+			/* lock the data again... */
+			spin_lock_irq(&td->lock);
+		}
+		spin_unlock_irq(&td->lock);
+	}
+
+thr_exit:
+	return 0;
+}
+
+/**
+ * spi_queue - (internal) queue the message to be processed asynchronously
+ * @spi: SPI device to perform transfer to/from
+ * @msg: message to be sent
+ * Description:
+ * 	This function queues the message to SPI controller's queue.
+ */
+static int spi_queue(struct spi_device *spi, struct spi_message *msg)
+{
+	struct threaded_async_data *td = spi->master->context;
+	int rc = 0;
+
+	if (!td) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	msg->spi = spi;
+	spin_lock_irq(&td->lock);
+	list_add_tail(&msg->queue, &td->msgs);
+	spin_unlock_irq(&td->lock);
+	dev_dbg(spi->dev.parent, "message has been queued\n");
+	wake_up_interruptible(&td->wq);
+
+out:
+	return rc;
+}
+
Index: linux-2.6.orig/include/linux/spi/spi-thread.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/include/linux/spi/spi-thread.h
@@ -0,0 +1,27 @@
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
+#if defined (CONFIG_SPI_THREAD)
+extern int spi_start_async (struct spi_master *, int (*)(struct spi_master *, struct spi_message *));
+extern void spi_stop_async (struct spi_master *);
+#else
+static inline int spi_start_async (struct spi_master *master, int (*xfer)(struct spi_master *, struct spi_message *))
+{
+	return -EINVAL;
+}
+static inline void spi_stop_async (struct spi_master *master)
+{
+}
+#endif /* CONFIG_SPI_THREAD */
+#endif /* __SPI_THREAD_H */
Index: linux-2.6.orig/include/linux/spi/spi.h
===================================================================
--- linux-2.6.orig.orig/include/linux/spi/spi.h
+++ linux-2.6.orig/include/linux/spi/spi.h
@@ -152,6 +152,7 @@ static inline void spi_unregister_driver
  * 	device's SPI controller; protocol code may call this.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @context: controller-specific data
  *
  * Each SPI master controller can communicate with one or more spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -207,6 +208,8 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(const struct spi_device *spi);
+
+	void 			*context;
 };
 
 /* the spi driver core manages memory for the spi_master classdev */
