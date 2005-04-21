Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVDUHzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVDUHzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVDUHzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:55:38 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:48055 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261443AbVDUHaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 8/22] W1: merge master code into one file
Date: Thu, 21 Apr 2005 02:15:14 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210215.15139.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: fold w1_int.c into w1.c - there is no point in artificially
    separating code for master devices between 2 files.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/w1/w1_int.c            |  181 -----------------------------------------
 drivers/w1/w1_int.h            |   36 --------
 dtor/drivers/w1/Makefile       |    2 
 dtor/drivers/w1/ds_w1_bridge.c |    1 
 dtor/drivers/w1/matrox_w1.c    |    1 
 dtor/drivers/w1/w1.c           |  158 +++++++++++++++++++++++++++++++++--
 dtor/drivers/w1/w1.h           |    7 -
 dtor/drivers/w1/w1_smem.c      |    1 
 dtor/drivers/w1/w1_therm.c     |    1 
 9 files changed, 155 insertions(+), 233 deletions(-)

Index: dtor/drivers/w1/ds_w1_bridge.c
===================================================================
--- dtor.orig/drivers/w1/ds_w1_bridge.c
+++ dtor/drivers/w1/ds_w1_bridge.c
@@ -23,7 +23,6 @@
 #include <linux/types.h>
 
 #include "../w1/w1.h"
-#include "../w1/w1_int.h"
 #include "dscore.h"
 
 static struct ds_device *ds_dev;
Index: dtor/drivers/w1/w1_therm.c
===================================================================
--- dtor.orig/drivers/w1/w1_therm.c
+++ dtor/drivers/w1/w1_therm.c
@@ -30,7 +30,6 @@
 
 #include "w1.h"
 #include "w1_io.h"
-#include "w1_int.h"
 #include "w1_family.h"
 
 MODULE_LICENSE("GPL");
Index: dtor/drivers/w1/w1_int.c
===================================================================
--- dtor.orig/drivers/w1/w1_int.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- *	w1_int.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/delay.h>
-
-#include "w1.h"
-#include "w1_log.h"
-#include "w1_netlink.h"
-
-static u32 w1_ids = 1;
-
-extern struct device_driver w1_driver;
-extern struct bus_type w1_bus_type;
-extern struct device w1_device;
-extern int w1_max_slave_count;
-extern int w1_max_slave_ttl;
-extern struct list_head w1_masters;
-extern spinlock_t w1_mlock;
-
-extern int w1_process(void *);
-
-struct w1_master *w1_allocate_master_device(void)
-{
-	struct w1_master *dev;
-
-	/*
-	 * We are in process context(kernel thread), so can sleep.
-	 */
-	dev = kcalloc(1, sizeof(struct w1_master), GFP_KERNEL);
-	if (!dev) {
-		printk(KERN_ERR
-			"Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
-		return NULL;
-	}
-
-	dev->max_slave_count	= w1_max_slave_count;
-	dev->kpid		= -1;
-	dev->id			= w1_ids++;
-	dev->slave_ttl		= w1_max_slave_ttl;
-
-	atomic_set(&dev->refcnt, 2);
-
-	INIT_LIST_HEAD(&dev->slist);
-	init_MUTEX(&dev->mutex);
-
-	init_completion(&dev->dev_released);
-	init_completion(&dev->dev_exited);
-
-	dev->dev = w1_device;
-	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
-		  "w1_bus_master%u", dev->id);
-
-	dev->driver = &w1_driver;
-
-	dev->groups = 23;
-	dev->seq = 1;
-
-	return dev;
-}
-
-void w1_free_dev(struct w1_master *dev)
-{
-	device_unregister(&dev->dev);
-	if (dev->nls && dev->nls->sk_socket)
-		sock_release(dev->nls->sk_socket);
-	memset(dev, 0, sizeof(struct w1_master));
-	kfree(dev);
-}
-
-int w1_add_master_device(struct w1_master *dev)
-{
-	int error;
-	struct w1_netlink_msg msg;
-
-	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
-	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
-			NETLINK_NFLOG, dev->dev.bus_id);
-		return -1;
-	}
-
-	error = device_register(&dev->dev);
-	if (error) {
-		printk(KERN_ERR "Failed to register master device. err=%d\n", error);
-		if (dev->nls && dev->nls->sk_socket)
-			sock_release(dev->nls->sk_socket);
-		return error;
-	}
-
-	dev->kpid = kernel_thread(&w1_process, dev, 0);
-	if (dev->kpid < 0) {
-		dev_err(&dev->dev,
-			 "Failed to create new kernel thread. err=%d\n",
-			 dev->kpid);
-		error = dev->kpid;
-		goto err_out_free_dev;
-	}
-
-	error = w1_create_master_attributes(dev);
-	if (error)
-		goto err_out_kill_thread;
-
-	dev->initialized = 1;
-
-	spin_lock(&w1_mlock);
-	list_add(&dev->node, &w1_masters);
-	spin_unlock(&w1_mlock);
-
-	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
-	msg.type = W1_MASTER_ADD;
-	w1_netlink_send(dev, &msg);
-
-	return 0;
-
-err_out_kill_thread:
-	dev->need_exit = 1;
-	if (kill_proc(dev->kpid, SIGTERM, 1))
-		dev_err(&dev->dev,
-			 "Failed to send signal to w1 kernel thread %d.\n",
-			 dev->kpid);
-	wait_for_completion(&dev->dev_exited);
-
-err_out_free_dev:
-	w1_free_dev(dev);
-
-	return error;
-}
-
-void w1_remove_master_device(struct w1_master *dev)
-{
-	int err;
-	struct w1_netlink_msg msg;
-
-	dev->need_exit = 1;
-	err = kill_proc(dev->kpid, SIGTERM, 1);
-	if (err)
-		dev_err(&dev->dev,
-			 "%s: Failed to send signal to w1 kernel thread %d.\n",
-			 __func__, dev->kpid);
-
-	while (atomic_read(&dev->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
-				dev->name, atomic_read(&dev->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
-
-	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
-	msg.type = W1_MASTER_REMOVE;
-	w1_netlink_send(dev, &msg);
-
-	w1_free_dev(dev);
-}
-
-EXPORT_SYMBOL(w1_allocate_master_device);
-EXPORT_SYMBOL(w1_add_master_device);
-EXPORT_SYMBOL(w1_remove_master_device);
Index: dtor/drivers/w1/Makefile
===================================================================
--- dtor.orig/drivers/w1/Makefile
+++ dtor/drivers/w1/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS	+= -DNETLINK_DISABLED
 endif
 
 obj-$(CONFIG_W1)	+= wire.o
-wire-objs		:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
+wire-objs		:= w1.o w1_family.o w1_netlink.o w1_io.o
 
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
Index: dtor/drivers/w1/matrox_w1.c
===================================================================
--- dtor.orig/drivers/w1/matrox_w1.c
+++ dtor/drivers/w1/matrox_w1.c
@@ -36,7 +36,6 @@
 #include <linux/timer.h>
 
 #include "w1.h"
-#include "w1_int.h"
 #include "w1_log.h"
 
 MODULE_LICENSE("GPL");
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -36,7 +36,6 @@
 #include "w1.h"
 #include "w1_io.h"
 #include "w1_log.h"
-#include "w1_int.h"
 #include "w1_family.h"
 #include "w1_netlink.h"
 
@@ -45,15 +44,16 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
 static int w1_timeout = 10;
-int w1_max_slave_count = 10;
-int w1_max_slave_ttl = 10;
+static int w1_max_slave_count = 10;
+static int w1_max_slave_ttl = 10;
 
 module_param_named(timeout, w1_timeout, int, 0);
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-DEFINE_SPINLOCK(w1_mlock);
-LIST_HEAD(w1_masters);
+static DEFINE_SPINLOCK(w1_mlock);
+static LIST_HEAD(w1_masters);
+static u32 w1_ids = 1;
 
 static pid_t control_thread;
 static int control_needs_exit;
@@ -475,7 +475,7 @@ static void w1_slave_detach(struct w1_sl
 	w1_netlink_send(sl->master, &msg);
 }
 
-void w1_slave_found(struct w1_master *dev, u64 rn)
+static void w1_slave_found(struct w1_master *dev, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *slave;
@@ -594,7 +594,7 @@ void w1_search(struct w1_master *dev)
 }
 
 
-int w1_control(void *data)
+static int w1_control(void *data)
 {
 	struct w1_slave *slave, *nexts;
 	struct w1_master *master, *nextm;
@@ -654,7 +654,7 @@ int w1_control(void *data)
 	complete_and_exit(&w1_control_complete, 0);
 }
 
-int w1_process(void *data)
+static int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
 	struct w1_slave *slave, *next;
@@ -703,6 +703,144 @@ int w1_process(void *data)
 	return 0;
 }
 
+struct w1_master *w1_allocate_master_device(void)
+{
+	struct w1_master *dev;
+
+	/*
+	 * We are in process context(kernel thread), so can sleep.
+	 */
+	dev = kcalloc(1, sizeof(struct w1_master), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR
+			"Failed to allocate %zd bytes for new w1 device.\n",
+			sizeof(struct w1_master));
+		return NULL;
+	}
+
+	dev->max_slave_count	= w1_max_slave_count;
+	dev->kpid		= -1;
+	dev->id			= w1_ids++;
+	dev->slave_ttl		= w1_max_slave_ttl;
+
+	atomic_set(&dev->refcnt, 2);
+
+	INIT_LIST_HEAD(&dev->slist);
+	init_MUTEX(&dev->mutex);
+
+	init_completion(&dev->dev_released);
+	init_completion(&dev->dev_exited);
+
+	dev->dev = w1_device;
+	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
+		  "w1_bus_master%u", dev->id);
+
+	dev->driver = &w1_driver;
+
+	dev->groups = 23;
+	dev->seq = 1;
+
+	return dev;
+}
+
+static void w1_free_dev(struct w1_master *dev)
+{
+	device_unregister(&dev->dev);
+	if (dev->nls && dev->nls->sk_socket)
+		sock_release(dev->nls->sk_socket);
+	memset(dev, 0, sizeof(struct w1_master));
+	kfree(dev);
+}
+
+int w1_add_master_device(struct w1_master *dev)
+{
+	int error;
+	struct w1_netlink_msg msg;
+
+	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
+			NETLINK_NFLOG, dev->dev.bus_id);
+		return -1;
+	}
+
+	error = device_register(&dev->dev);
+	if (error) {
+		printk(KERN_ERR "Failed to register master device. err=%d\n", error);
+		if (dev->nls && dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return error;
+	}
+
+	dev->kpid = kernel_thread(&w1_process, dev, 0);
+	if (dev->kpid < 0) {
+		dev_err(&dev->dev,
+			 "Failed to create new kernel thread. err=%d\n",
+			 dev->kpid);
+		error = dev->kpid;
+		goto err_out_free_dev;
+	}
+
+	error = w1_create_master_attributes(dev);
+	if (error)
+		goto err_out_kill_thread;
+
+	dev->initialized = 1;
+
+	spin_lock(&w1_mlock);
+	list_add(&dev->node, &w1_masters);
+	spin_unlock(&w1_mlock);
+
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_ADD;
+	w1_netlink_send(dev, &msg);
+
+	return 0;
+
+err_out_kill_thread:
+	dev->need_exit = 1;
+	if (kill_proc(dev->kpid, SIGTERM, 1))
+		dev_err(&dev->dev,
+			 "Failed to send signal to w1 kernel thread %d.\n",
+			 dev->kpid);
+	wait_for_completion(&dev->dev_exited);
+
+err_out_free_dev:
+	w1_free_dev(dev);
+
+	return error;
+}
+
+void w1_remove_master_device(struct w1_master *dev)
+{
+	int err;
+	struct w1_netlink_msg msg;
+
+	dev->need_exit = 1;
+	err = kill_proc(dev->kpid, SIGTERM, 1);
+	if (err)
+		dev_err(&dev->dev,
+			 "%s: Failed to send signal to w1 kernel thread %d.\n",
+			 __func__, dev->kpid);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+				dev->name, atomic_read(&dev->refcnt));
+
+		if (msleep_interruptible(1000))
+			flush_signals(current);
+	}
+
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_REMOVE;
+	w1_netlink_send(dev, &msg);
+
+	w1_free_dev(dev);
+}
+
+
 int w1_init(void)
 {
 	int retval;
@@ -760,3 +898,7 @@ void w1_fini(void)
 
 module_init(w1_init);
 module_exit(w1_fini);
+
+EXPORT_SYMBOL(w1_allocate_master_device);
+EXPORT_SYMBOL(w1_add_master_device);
+EXPORT_SYMBOL(w1_remove_master_device);
Index: dtor/drivers/w1/w1_int.h
===================================================================
--- dtor.orig/drivers/w1/w1_int.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *	w1_int.h
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __W1_INT_H
-#define __W1_INT_H
-
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/err.h>
-
-#include "w1.h"
-
-struct w1_master *w1_allocate_master_device(void);
-void w1_free_dev(struct w1_master *dev);
-int w1_add_master_device(struct w1_master *);
-void w1_remove_master_device(struct w1_master *);
-
-#endif /* __W1_INT_H */
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -133,9 +133,10 @@ struct w1_master
 	struct sock		*nls;
 };
 
-int w1_create_master_attributes(struct w1_master *);
-void w1_destroy_master_attributes(struct w1_master *);
-void w1_search(struct w1_master *dev);
+struct w1_master *w1_allocate_master_device(void);
+int w1_add_master_device(struct w1_master *);
+void w1_remove_master_device(struct w1_master *);
+void w1_search(struct w1_master *);
 
 #endif /* __KERNEL__ */
 
Index: dtor/drivers/w1/w1_smem.c
===================================================================
--- dtor.orig/drivers/w1/w1_smem.c
+++ dtor/drivers/w1/w1_smem.c
@@ -29,7 +29,6 @@
 
 #include "w1.h"
 #include "w1_io.h"
-#include "w1_int.h"
 #include "w1_family.h"
 
 MODULE_LICENSE("GPL");
