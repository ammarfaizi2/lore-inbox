Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDUIMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDUIMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVDUILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:11:30 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:59575 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261455AbVDUHaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 16/22] W1: cleanup masters refcounting & more
Date: Thu, 21 Apr 2005 02:23:15 -0500
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
Message-Id: <200504210223.15682.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: clean-up master device implementation:
    - get rid of separate refcount, rely on driver model to
      enforce lifetime rules;
    - use atomic to generate unique master IDs;
    - drop unused fields.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |  263 ++++++++++++++++++++++++++-----------------------------------------
 w1.h |   17 +---
 2 files changed, 108 insertions(+), 172 deletions(-)

Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -103,30 +103,21 @@ struct w1_bus_ops
 
 struct w1_master
 {
+	void			*private;
+
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
 	int			max_slave_count;
 	int			slave_ttl;
 	int			scan_interval;
-	int			initialized;
-	u32			id;
-
-	atomic_t		refcnt;
-
-	void			*private;
 
-	int			need_exit;
 	pid_t			kpid;
-	struct semaphore	mutex;
 
-	struct device_driver	*driver;
 	struct device		dev;
-	struct completion	dev_released;
-	struct completion	dev_exited;
+	struct completion	thread_exited;
+	struct semaphore	mutex;
 
 	struct w1_bus_ops	*bus_ops;
-
-	u32			seq, groups;
 };
 #define to_w1_master(dev)	container_of((dev), struct w1_master, dev)
 
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -50,49 +50,19 @@ module_param_named(scan_interval, w1_sca
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-static u32 w1_ids = 1;
-
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
 }
 
-static int w1_master_probe(struct device *dev)
-{
-	return -ENODEV;
-}
-
-static int w1_master_remove(struct device *dev)
-{
-	return 0;
-}
-
-static void w1_master_release(struct device *dev)
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-
-	complete(&md->dev_released);
-}
-
-
 static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
 };
 
-struct device_driver w1_driver = {
-	.name = "w1_driver",
-	.bus = &w1_bus_type,
-	.probe = w1_master_probe,
-	.remove = w1_master_remove,
-};
-
-struct device w1_device = {
-	.parent = NULL,
+struct device_driver w1_master_driver = {
+	.name = "master",
 	.bus = &w1_bus_type,
-	.bus_id = "w1 bus master",
-	.driver = &w1_driver,
-	.release = &w1_master_release
 };
 
 static ssize_t w1_slave_attribute_show_family(struct device *dev, char *buf)
@@ -166,7 +136,6 @@ static int __w1_attach_slave_device(stru
 	int err;
 
 	sl->dev.parent = &sl->master->dev;
-	sl->dev.driver = sl->master->driver;
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 
@@ -346,52 +315,44 @@ static void w1_slave_found(struct w1_mas
 	w1_attach_slave_device(dev, reg_num);
 }
 
-
-static int w1_process(void *data)
+static void w1_master_scan_slaves(struct w1_master *master)
 {
-	struct w1_master *dev = (struct w1_master *) data;
 	struct w1_slave *slave, *next;
 
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
-
-	while (!dev->need_exit) {
-		try_to_freeze(PF_FREEZE);
-		msleep_interruptible(dev->scan_interval * 1000);
-
-		if (signal_pending(current))
-			flush_signals(current);
-
-		if (dev->need_exit)
-			break;
-
-		if (!dev->initialized)
-			continue;
-
-		if (down_interruptible(&dev->mutex))
-			continue;
+	if (down_interruptible(&master->mutex))
+		return;
 
-		list_for_each_entry(slave, &dev->slist, node)
-			clear_bit(W1_SLAVE_ACTIVE, &slave->flags);
+	list_for_each_entry(slave, &master->slist, node)
+		clear_bit(W1_SLAVE_ACTIVE, &slave->flags);
 
-		w1_search_devices(dev, w1_slave_found);
+	w1_search_devices(master, w1_slave_found);
 
-		list_for_each_entry_safe(slave, next, &dev->slist, node) {
+	list_for_each_entry_safe(slave, next, &master->slist, node) {
 
-			if (!test_bit(W1_SLAVE_ACTIVE, &slave->flags) &&
-			    !--slave->ttl) {
-				list_del(&slave->node);
-				w1_slave_detach(slave);
-				kfree(slave);
-			}
+		if (!test_bit(W1_SLAVE_ACTIVE, &slave->flags) &&
+		    !--slave->ttl) {
+			list_del(&slave->node);
+			w1_slave_detach(slave);
+			kfree(slave);
 		}
-		up(&dev->mutex);
 	}
+	up(&master->mutex);
+}
+
+static int w1_process(void *data)
+{
+	struct w1_master *master = (struct w1_master *) data;
 
-	atomic_dec(&dev->refcnt);
-	complete_and_exit(&dev->dev_exited, 0);
+	daemonize("%s", master->dev.bus_id);
+	allow_signal(SIGTERM);
 
-	return 0;
+	do {
+		w1_master_scan_slaves(master);
+		msleep_interruptible(master->scan_interval * 1000);
+		try_to_freeze(PF_FREEZE);
+	} while (!signal_pending(current));
+
+	complete_and_exit(&master->thread_exited, 0);
 }
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
@@ -497,128 +458,110 @@ static struct attribute_group w1_master_
 	.attrs = w1_master_default_attrs,
 };
 
+static void w1_release_master_device(struct device *dev)
+{
+	struct w1_master *master = to_w1_master(dev);
+
+	kfree(master);
+	module_put(THIS_MODULE);
+}
+
 struct w1_master *w1_allocate_master_device(void)
 {
-	struct w1_master *dev;
+	struct w1_master *master;
 
-	/*
-	 * We are in process context(kernel thread), so can sleep.
-	 */
-	dev = kcalloc(1, sizeof(struct w1_master), GFP_KERNEL);
-	if (!dev) {
+	master = kcalloc(1, sizeof(struct w1_master), GFP_KERNEL);
+	if (!master) {
 		printk(KERN_ERR
-			"Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
+		       "w1: Failed to allocate %zd bytes for new w1 device.\n",
+		       sizeof(struct w1_master));
 		return NULL;
 	}
 
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
+	master->max_slave_count	= w1_max_slave_count;
+	master->slave_ttl	= w1_max_slave_ttl;
+	master->scan_interval	= w1_scan_interval;
 
-	dev->driver = &w1_driver;
-
-	dev->groups = 23;
-	dev->seq = 1;
-
-	return dev;
-}
-
-static void w1_free_master_dev(struct w1_master *dev)
-{
-	device_unregister(&dev->dev);
-	kfree(dev);
-}
+	INIT_LIST_HEAD(&master->slist);
+	init_MUTEX(&master->mutex);
+	init_completion(&master->thread_exited);
 
-static void w1_stop_master_device(struct w1_master *dev)
-{
-	dev->need_exit = 1;
-	if (kill_proc(dev->kpid, SIGTERM, 1))
-		dev_err(&dev->dev,
-			 "Failed to send signal to w1 kernel thread %d.\n",
-			 dev->kpid);
-	wait_for_completion(&dev->dev_exited);
+	return master;
 }
 
-int w1_add_master_device(struct w1_master *dev)
+int w1_add_master_device(struct w1_master *master)
 {
+	static atomic_t master_no = ATOMIC_INIT(0);
 	int error;
 
-	error = device_register(&dev->dev);
+	snprintf(master->dev.bus_id, sizeof(master->dev.bus_id),
+		 "master%lu", (unsigned long)atomic_inc_return(&master_no));
+	master->dev.bus = &w1_bus_type;
+	master->dev.release = w1_release_master_device;
+	master->dev.driver = &w1_master_driver;
+
+	error = device_register(&master->dev);
 	if (error) {
-		printk(KERN_ERR "Failed to register master device. err=%d\n", error);
+		printk(KERN_ERR
+		       "w1: Failed to register master device. err=%d\n",
+		       error);
 		return error;
 	}
 
-	dev->kpid = kernel_thread(&w1_process, dev, 0);
-	if (dev->kpid < 0) {
-		dev_err(&dev->dev,
-			 "Failed to create new kernel thread. err=%d\n",
-			 dev->kpid);
-		error = dev->kpid;
-		goto err_out_free_dev;
-	}
-
-	error = sysfs_create_group(&dev->dev.kobj, &w1_master_defattr_group);
-	if (error)
-		goto err_out_kill_thread;
-
-	dev->initialized = 1;
-
 	__module_get(THIS_MODULE);
 
-	return 0;
+	error = sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
+	if (error) {
+		printk(KERN_ERR
+		       "w1: Failed to create master attributes, err=%d\n",
+		       error);
+		goto err_out_unregister;
+	}
 
-err_out_kill_thread:
-	w1_stop_master_device(dev);
+	master->kpid = kernel_thread(&w1_process, master, 0);
+	if (master->kpid < 0) {
+		printk(KERN_ERR
+		       "w1: Failed to create new kernel thread, err=%d\n",
+		       master->kpid);
+		error = master->kpid;
+		goto err_out_remove_attrs;
+	}
 
-err_out_free_dev:
-	w1_free_master_dev(dev);
+	return 0;
 
+err_out_remove_attrs:
+	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
+err_out_unregister:
+	device_unregister(&master->dev);
 	return error;
 }
 
-void w1_remove_master_device(struct w1_master *dev)
+static void w1_stop_master_device(struct w1_master *master)
+{
+	if (kill_proc(master->kpid, SIGTERM, 1))
+		printk(KERN_ERR
+		       "w1: Failed to send signal to w1 kernel thread %d.\n",
+		       master->kpid);
+	wait_for_completion(&master->thread_exited);
+}
+
+void w1_remove_master_device(struct w1_master *master)
 {
 	struct w1_slave *slave, *next;
 
-	w1_stop_master_device(dev);
+	w1_stop_master_device(master);
 
-	list_for_each_entry_safe(slave, next, &dev->slist, node) {
+	list_for_each_entry_safe(slave, next, &master->slist, node) {
 		list_del(&slave->node);
 		w1_slave_detach(slave);
 		kfree(slave);
 	}
 
-	sysfs_remove_group(&dev->dev.kobj, &w1_master_defattr_group);
-
-	while (atomic_read(&dev->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
-				dev->name, atomic_read(&dev->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
-
-	w1_free_master_dev(dev);
-	module_put(THIS_MODULE);
+	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
+	device_unregister(&master->dev);
 }
 
-
-int w1_init(void)
+static int w1_init(void)
 {
 	int error;
 
@@ -626,14 +569,16 @@ int w1_init(void)
 
 	error = bus_register(&w1_bus_type);
 	if (error) {
-		printk(KERN_ERR "Failed to register bus. err=%d.\n", error);
+		printk(KERN_ERR "w1: Failed to register bus. err=%d.\n",
+		       error);
 		return error;
 	}
 
-	error = driver_register(&w1_driver);
+	error = driver_register(&w1_master_driver);
 	if (error) {
 		printk(KERN_ERR
-			"Failed to register master driver. err=%d.\n", error);
+		       "w1: Failed to register master driver. err=%d.\n",
+		       error);
 		bus_unregister(&w1_bus_type);
 		return error;
 	}
@@ -641,14 +586,14 @@ int w1_init(void)
 	return 0;
 }
 
-void w1_fini(void)
+static void w1_exit(void)
 {
-	driver_unregister(&w1_driver);
+	driver_unregister(&w1_master_driver);
 	bus_unregister(&w1_bus_type);
 }
 
 module_init(w1_init);
-module_exit(w1_fini);
+module_exit(w1_exit);
 
 EXPORT_SYMBOL(w1_allocate_master_device);
 EXPORT_SYMBOL(w1_add_master_device);
