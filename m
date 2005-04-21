Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVDUIAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDUIAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVDUH7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:59:44 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:51127 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261447AbVDUHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 10/22] W1: drop main control thread
Date: Thu, 21 Apr 2005 02:17:04 -0500
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
Message-Id: <200504210217.05859.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: Drop control thread from w1 core, whatever it does can
    also be done in the context of w1_remove_master_device.
    Also, pin the module when registering new master device
    to make sure that w1 core is not unloaded until last
    device is gone. This simplifies logic a lot.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |  157 +++++++++++++++----------------------------------------------------
 w1.h |    1 
 2 files changed, 36 insertions(+), 122 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -50,14 +50,8 @@ module_param_named(timeout, w1_timeout, 
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-static DEFINE_SPINLOCK(w1_mlock);
-static LIST_HEAD(w1_masters);
 static u32 w1_ids = 1;
 
-static pid_t control_thread;
-static int control_needs_exit;
-static DECLARE_COMPLETION(w1_control_complete);
-
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
@@ -582,66 +576,6 @@ void w1_search(struct w1_master *dev)
 }
 
 
-static int w1_control(void *data)
-{
-	struct w1_slave *slave, *nexts;
-	struct w1_master *master, *nextm;
-	int err, have_to_wait = 0;
-
-	daemonize("w1_control");
-	allow_signal(SIGTERM);
-
-	while (!control_needs_exit || have_to_wait) {
-		have_to_wait = 0;
-
-		try_to_freeze(PF_FREEZE);
-		msleep_interruptible(w1_timeout * 1000);
-
-		if (signal_pending(current))
-			flush_signals(current);
-
-		list_for_each_entry_safe(master, nextm, &w1_masters, node) {
-
-			if (!control_needs_exit && !master->need_exit)
-				continue;
-			/*
-			 * Little race: we can create thread but not set the flag.
-			 * Get a chance for external process to set flag up.
-			 */
-			if (!master->initialized) {
-				have_to_wait = 1;
-				continue;
-			}
-
-			spin_lock(&w1_mlock);
-			list_del(&master->node);
-			spin_unlock(&w1_mlock);
-
-			if (control_needs_exit) {
-				master->need_exit = 1;
-
-				err = kill_proc(master->kpid, SIGTERM, 1);
-				if (err)
-					dev_err(&master->dev,
-						 "Failed to send signal to w1 kernel thread %d.\n",
-						 master->kpid);
-			}
-
-			wait_for_completion(&master->dev_exited);
-
-			list_for_each_entry_safe(slave, nexts, &master->slist, node) {
-				list_del(&slave->node);
-				w1_slave_detach(slave);
-				kfree(slave);
-			}
-			w1_destroy_master_attributes(master);
-			atomic_dec(&master->refcnt);
-		}
-	}
-
-	complete_and_exit(&w1_control_complete, 0);
-}
-
 static int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
@@ -731,12 +665,22 @@ struct w1_master *w1_allocate_master_dev
 	return dev;
 }
 
-static void w1_free_dev(struct w1_master *dev)
+static void w1_free_master_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 	kfree(dev);
 }
 
+static void w1_stop_master_device(struct w1_master *dev)
+{
+	dev->need_exit = 1;
+	if (kill_proc(dev->kpid, SIGTERM, 1))
+		dev_err(&dev->dev,
+			 "Failed to send signal to w1 kernel thread %d.\n",
+			 dev->kpid);
+	wait_for_completion(&dev->dev_exited);
+}
+
 int w1_add_master_device(struct w1_master *dev)
 {
 	int error;
@@ -762,36 +706,32 @@ int w1_add_master_device(struct w1_maste
 
 	dev->initialized = 1;
 
-	spin_lock(&w1_mlock);
-	list_add(&dev->node, &w1_masters);
-	spin_unlock(&w1_mlock);
+	__module_get(THIS_MODULE);
 
 	return 0;
 
 err_out_kill_thread:
-	dev->need_exit = 1;
-	if (kill_proc(dev->kpid, SIGTERM, 1))
-		dev_err(&dev->dev,
-			 "Failed to send signal to w1 kernel thread %d.\n",
-			 dev->kpid);
-	wait_for_completion(&dev->dev_exited);
+	w1_stop_master_device(dev);
 
 err_out_free_dev:
-	w1_free_dev(dev);
+	w1_free_master_dev(dev);
 
 	return error;
 }
 
 void w1_remove_master_device(struct w1_master *dev)
 {
-	int err;
+	struct w1_slave *slave, *next;
 
-	dev->need_exit = 1;
-	err = kill_proc(dev->kpid, SIGTERM, 1);
-	if (err)
-		dev_err(&dev->dev,
-			 "%s: Failed to send signal to w1 kernel thread %d.\n",
-			 __func__, dev->kpid);
+	w1_stop_master_device(dev);
+
+	list_for_each_entry_safe(slave, next, &dev->slist, node) {
+		list_del(&slave->node);
+		w1_slave_detach(slave);
+		kfree(slave);
+	}
+
+	w1_destroy_master_attributes(dev);
 
 	while (atomic_read(&dev->refcnt)) {
 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
@@ -801,61 +741,36 @@ void w1_remove_master_device(struct w1_m
 			flush_signals(current);
 	}
 
-	w1_free_dev(dev);
+	w1_free_master_dev(dev);
+	module_put(THIS_MODULE);
 }
 
 
 int w1_init(void)
 {
-	int retval;
+	int error;
 
 	printk(KERN_INFO "Driver for 1-wire Dallas network protocol.\n");
 
-	retval = bus_register(&w1_bus_type);
-	if (retval) {
-		printk(KERN_ERR "Failed to register bus. err=%d.\n", retval);
-		goto err_out_exit_init;
+	error = bus_register(&w1_bus_type);
+	if (error) {
+		printk(KERN_ERR "Failed to register bus. err=%d.\n", error);
+		return error;
 	}
 
-	retval = driver_register(&w1_driver);
-	if (retval) {
+	error = driver_register(&w1_driver);
+	if (error) {
 		printk(KERN_ERR
-			"Failed to register master driver. err=%d.\n",
-			retval);
-		goto err_out_bus_unregister;
-	}
-
-	control_thread = kernel_thread(&w1_control, NULL, 0);
-	if (control_thread < 0) {
-		printk(KERN_ERR "Failed to create control thread. err=%d\n",
-			control_thread);
-		retval = control_thread;
-		goto err_out_driver_unregister;
+			"Failed to register master driver. err=%d.\n", error);
+		bus_unregister(&w1_bus_type);
+		return error;
 	}
 
 	return 0;
-
-err_out_driver_unregister:
-	driver_unregister(&w1_driver);
-
-err_out_bus_unregister:
-	bus_unregister(&w1_bus_type);
-
-err_out_exit_init:
-	return retval;
 }
 
 void w1_fini(void)
 {
-	struct w1_master *master, *next;
-
-	list_for_each_entry_safe(master, next, &w1_masters, node)
-		w1_remove_master_device(master);
-
-	control_needs_exit = 1;
-
-	wait_for_completion(&w1_control_complete);
-
 	driver_unregister(&w1_driver);
 	bus_unregister(&w1_bus_type);
 }
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -103,7 +103,6 @@ struct w1_bus_ops
 
 struct w1_master
 {
-	struct list_head	node;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
 	int			max_slave_count, slave_count;
