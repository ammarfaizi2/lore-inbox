Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUEMTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUEMTTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUEMTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:18:10 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:5849 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264453AbUEMTPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:15:07 -0400
Date: Thu, 13 May 2004 21:15:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/6): 3270 console driver.
Message-ID: <20040513191500.GE2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: 3270 driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

3270 device driver change:
 - Don't allow activation of views while the initial size sensing is still
   in progress. Replace RAW3270_FLAGS_SHUTDOWN with RAW3270_FLAGS_READY.
 - Make 3270 views loadable as modules.

diffstat:
 arch/s390/defconfig         |    2 
 drivers/s390/Kconfig        |   25 ++++++--
 drivers/s390/char/Makefile  |    5 +
 drivers/s390/char/raw3270.c |  129 +++++++++++++++++++++++++++++++-------------
 drivers/s390/char/raw3270.h |    7 +-
 drivers/s390/char/tty3270.c |   37 +++++++++++-
 6 files changed, 153 insertions(+), 52 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Thu May 13 21:00:59 2004
+++ linux-2.6-s390/arch/s390/defconfig	Thu May 13 21:01:02 2004
@@ -178,6 +178,8 @@
 # S/390 character device drivers
 #
 CONFIG_TN3270=y
+CONFIG_TN3270_TTY=y
+CONFIG_TN3270_FS=m
 CONFIG_TN3270_CONSOLE=y
 CONFIG_TN3215=y
 CONFIG_TN3215_CONSOLE=y
diff -urN linux-2.6/drivers/s390/Kconfig linux-2.6-s390/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/drivers/s390/Kconfig	Thu May 13 21:01:02 2004
@@ -54,17 +54,28 @@
 comment "S/390 character device drivers"
 
 config TN3270
-	tristate "Support for locally attached 3270 tubes"
+	tristate "Support for locally attached 3270 terminals"
 	help
-	  Include support for IBM 3270 line-mode terminals.
+	  Include support for IBM 3270 terminals.
+
+config TN3270_TTY
+	tristate "Support for tty input/output on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for using an IBM 3270 terminal as a Linux tty.
+
+config TN3270_FS
+	tristate "Support for fullscreen applications on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for fullscreen applications on an IBM 3270 terminal.
 
 config TN3270_CONSOLE
-	bool "Support for console on 3270 line mode terminal"
-	depends on TN3270=y
+	bool "Support for console on 3270 terminal"
+	depends on TN3270=y && TN3270_TTY=y
 	help
-	  Include support for using an IBM 3270 line-mode terminal as a Linux
-	  system console.  Available only if 3270 support is compiled in
-	  statically.
+	  Include support for using an IBM 3270 terminal as a Linux system
+	  console.  Available only if 3270 support is compiled in statically.
 
 config TN3215
 	bool "Support for 3215 line mode terminal"
diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-s390/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	Mon May 10 04:32:29 2004
+++ linux-2.6-s390/drivers/s390/char/Makefile	Thu May 13 21:01:02 2004
@@ -4,9 +4,10 @@
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o
 
-tub3270-objs := raw3270.o tty3270.o fs3270.o
-obj-$(CONFIG_TN3270) += tub3270.o
+obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
+obj-$(CONFIG_TN3270_TTY) += tty3270.o
+obj-$(CONFIG_TN3270_FS) += fs3270.o
 
 obj-$(CONFIG_TN3215) += con3215.o
 
diff -urN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-s390/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/drivers/s390/char/raw3270.c	Thu May 13 21:01:02 2004
@@ -47,11 +47,11 @@
 #define RAW3270_FLAGS_14BITADDR	0	/* 14-bit buffer addresses */
 #define RAW3270_FLAGS_BUSY	1	/* Device busy, leave it alone */
 #define RAW3270_FLAGS_ATTN	2	/* Device sent an ATTN interrupt */
-#define RAW3270_FLAGS_SHUTDOWN	4	/* Device is in offline processing */
+#define RAW3270_FLAGS_READY	4	/* Device is useable by views */
 #define RAW3270_FLAGS_CONSOLE	8	/* Device is the console. */
 
-/* Lock to protect global data of raw3270 (devices, views, etc). */
-static spinlock_t raw3270_lock = SPIN_LOCK_UNLOCKED;
+/* Semaphore to protect global data of raw3270 (devices, views, etc). */
+static DECLARE_MUTEX(raw3270_sem);
 
 /* List of 3270 devices. */
 static struct list_head raw3270_devices = LIST_HEAD_INIT(raw3270_devices);
@@ -308,7 +308,7 @@
 	rp = view->dev;
 	if (!rp || rp->view != view)
 		rc = -EACCES;
-	else if (test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags))
+	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
 	else
 		rc =  __raw3270_start(rp, view, rq);
@@ -603,7 +603,6 @@
 {
 	static const unsigned char wbuf[] =
 		{ 0x00, 0x07, 0x01, 0xff, 0x03, 0x00, 0x81 };
-	unsigned long flags;
 	struct raw3270_ua *uap;
 	unsigned short count;
 	int rc;
@@ -638,6 +637,8 @@
 	/* Wait for attention interrupt. */
 #ifdef CONFIG_TN3270_CONSOLE
 	if (raw3270_registered == 0) {
+		unsigned long flags;
+
 		spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 		while (!test_and_clear_bit(RAW3270_FLAGS_ATTN, &rp->flags))
 			wait_cons_dev();
@@ -764,7 +765,7 @@
 	 * Add device to list and find the smallest unused minor
 	 * number for it.
 	 */
-	spin_lock(&raw3270_lock);
+	down(&raw3270_sem);
 	/* Keep the list sorted. */
 	minor = 0;
 	rp->minor = -1;
@@ -781,7 +782,7 @@
 		rp->minor = minor;
 		list_add_tail(&rp->list, &raw3270_devices);
 	}
-	spin_unlock(&raw3270_lock);
+	up(&raw3270_sem);
 	/* No free minor number? Then give up. */
 	if (rp->minor == -1)
 		return -EUSERS;
@@ -811,6 +812,7 @@
 	raw3270_reset_device(rp);
 	raw3270_size_device(rp);
 	raw3270_reset_device(rp);
+	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	return rp;
 }
 
@@ -872,7 +874,7 @@
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	if (rp->view == view)
 		rc = 0;
-	else if (test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags))
+	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
 	else {
 		oldview = 0;
@@ -921,7 +923,7 @@
 		list_del_init(&view->list);
 		list_add_tail(&view->list, &rp->view_list);
 		/* Try to activate another view. */
-		if (!test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags)) {
+		if (test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
 			list_for_each_entry(view, &rp->view_list, list)
 				if (view->fn->activate(view) == 0) {
 					rp->view = view;
@@ -942,13 +944,13 @@
 	struct raw3270 *rp;
 	int rc;
 
-	spin_lock(&raw3270_lock);
+	down(&raw3270_sem);
 	rc = -ENODEV;
 	list_for_each_entry(rp, &raw3270_devices, list) {
 		if (rp->minor != minor)
 			continue;
 		spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
-		if (!test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags)) {
+		if (test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
 			atomic_set(&view->ref_count, 2);
 			view->dev = rp;
 			view->fn = fn;
@@ -963,7 +965,7 @@
 		spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
 		break;
 	}
-	spin_unlock(&raw3270_lock);
+	up(&raw3270_sem);
 	return rc;
 }
 
@@ -977,25 +979,26 @@
 	struct raw3270_view *view, *tmp;
 	unsigned long flags;
 
-	spin_lock(&raw3270_lock);
+	down(&raw3270_sem);
 	view = ERR_PTR(-ENODEV);
 	list_for_each_entry(rp, &raw3270_devices, list) {
 		if (rp->minor != minor)
 			continue;
 		spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
-		if (!test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags)) {
+		if (test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
+			view = ERR_PTR(-ENOENT);
 			list_for_each_entry(tmp, &rp->view_list, list) {
 				if (tmp->fn == fn) {
 					raw3270_get_view(tmp);
 					view = tmp;
+					break;
 				}
 			}
-		} else
-			view = ERR_PTR(-ENOENT);
+		}
 		spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
 		break;
 	}
-	spin_unlock(&raw3270_lock);
+	up(&raw3270_sem);
 	return view;
 }
 
@@ -1007,6 +1010,7 @@
 {
 	unsigned long flags;
 	struct raw3270 *rp;
+	struct raw3270_view *nv;
 
 	rp = view->dev;
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
@@ -1015,17 +1019,18 @@
 		rp->view = 0;
 	}
 	list_del_init(&view->list);
-	if (!rp->view && !test_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags)) {
+	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
 		/* Try to activate another view. */
-		list_for_each_entry(view, &rp->view_list, list)
-			if (view->fn->activate(view) == 0) {
-				rp->view = view;
+		list_for_each_entry(nv, &rp->view_list, list) {
+			if (nv->fn->activate(view) == 0) {
+				rp->view = nv;
 				break;
 			}
+		}
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
 	/* Wait for reference counter to drop to zero. */
-	atomic_dec(&view->ref_count);
+	atomic_sub(2, &view->ref_count);
 	wait_event(raw3270_wait_queue, atomic_read(&view->ref_count) == 0);
 	if (view->fn->free)
 		view->fn->free(view);
@@ -1040,9 +1045,9 @@
 	struct ccw_device *cdev;
 
 	/* Remove from device chain. */
-	spin_lock(&raw3270_lock);
+	down(&raw3270_sem);
 	list_del_init(&rp->list);
-	spin_unlock(&raw3270_lock);
+	up(&raw3270_sem);
 
 	/* Disconnect from ccw_device. */
 	cdev = rp->cdev;
@@ -1109,8 +1114,48 @@
 	sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
 }
 
-/* Hackish. A notifier chain would be cleaner. */
-extern void tty3270_notifier(int index, int active);
+/*
+ * Notifier for device addition/removal
+ */
+struct raw3270_notifier {
+	struct list_head list;
+	void (*notifier)(int, int);
+};
+
+static struct list_head raw3270_notifier = LIST_HEAD_INIT(raw3270_notifier);
+
+int raw3270_register_notifier(void (*notifier)(int, int))
+{
+	struct raw3270_notifier *np;
+	struct raw3270 *rp;
+
+	np = kmalloc(sizeof(struct raw3270_notifier), GFP_KERNEL);
+	if (!np)
+		return -ENOMEM;
+	np->notifier = notifier;
+	down(&raw3270_sem);
+	list_add_tail(&np->list, &raw3270_notifier);
+	list_for_each_entry(rp, &raw3270_devices, list) {
+		get_device(&rp->cdev->dev);
+		notifier(rp->minor, 1);
+	}
+	up(&raw3270_sem);
+	return 0;
+}
+
+void raw3270_unregister_notifier(void (*notifier)(int, int))
+{
+	struct raw3270_notifier *np;
+
+	down(&raw3270_sem);
+	list_for_each_entry(np, &raw3270_notifier, list)
+		if (np->notifier == notifier) {
+			list_del(&np->list);
+			kfree(np);
+			break;
+		}
+	up(&raw3270_sem);
+}
 
 /*
  * Set 3270 device online.
@@ -1119,6 +1164,7 @@
 raw3270_set_online (struct ccw_device *cdev)
 {
 	struct raw3270 *rp;
+	struct raw3270_notifier *np;
 
 	rp = raw3270_create_device(cdev);
 	if (IS_ERR(rp))
@@ -1127,7 +1173,11 @@
 	raw3270_size_device(rp);
 	raw3270_reset_device(rp);
 	raw3270_create_attributes(rp);
-	tty3270_notifier(rp->minor, 1);
+	set_bit(RAW3270_FLAGS_READY, &rp->flags);
+	down(&raw3270_sem);
+	list_for_each_entry(np, &raw3270_notifier, list)
+		np->notifier(rp->minor, 1);
+	up(&raw3270_sem);
 	return 0;
 }
 
@@ -1140,9 +1190,10 @@
 	unsigned long flags;
 	struct raw3270 *rp;
 	struct raw3270_view *v;
+	struct raw3270_notifier *np;
 
 	rp = cdev->dev.driver_data;
-	set_bit(RAW3270_FLAGS_SHUTDOWN, &rp->flags);
+	clear_bit(RAW3270_FLAGS_READY, &rp->flags);
 
 	sysfs_remove_group(&cdev->dev.kobj, &raw3270_attr_group);
 
@@ -1162,7 +1213,10 @@
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 
-	tty3270_notifier(rp->minor, 0);
+	down(&raw3270_sem);
+	list_for_each_entry(np, &raw3270_notifier, list)
+		np->notifier(rp->minor, 0);
+	up(&raw3270_sem);
 
 	/* Reset 3270 device. */
 	raw3270_reset_device(rp);
@@ -1210,7 +1264,7 @@
 	.set_offline	= &raw3270_set_offline,
 };
 
-int
+static int
 raw3270_init(void)
 {
 	struct raw3270 *rp;
@@ -1222,18 +1276,17 @@
 	rc = ccw_driver_register(&raw3270_ccw_driver);
 	if (rc == 0) {
 		/* Create attributes for early (= console) device. */
-		spin_lock(&raw3270_lock);
+		down(&raw3270_sem);
 		list_for_each_entry(rp, &raw3270_devices, list) {
 			get_device(&rp->cdev->dev);
 			raw3270_create_attributes(rp);
-			tty3270_notifier(rp->minor, 1);
 		}
-		spin_unlock(&raw3270_lock);
+		up(&raw3270_sem);
 	}
 	return rc;
 }
 
-void
+static void
 raw3270_exit(void)
 {
 	ccw_driver_unregister(&raw3270_ccw_driver);
@@ -1241,8 +1294,9 @@
 
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(raw3270_init);
-EXPORT_SYMBOL(raw3270_exit);
+module_init(raw3270_init);
+module_exit(raw3270_exit);
+
 EXPORT_SYMBOL(raw3270_request_alloc);
 EXPORT_SYMBOL(raw3270_request_free);
 EXPORT_SYMBOL(raw3270_request_reset);
@@ -1258,3 +1312,6 @@
 EXPORT_SYMBOL(raw3270_deactivate_view);
 EXPORT_SYMBOL(raw3270_start);
 EXPORT_SYMBOL(raw3270_start_irq);
+EXPORT_SYMBOL(raw3270_register_notifier);
+EXPORT_SYMBOL(raw3270_unregister_notifier);
+EXPORT_SYMBOL(raw3270_wait_queue);
diff -urN linux-2.6/drivers/s390/char/raw3270.h linux-2.6-s390/drivers/s390/char/raw3270.h
--- linux-2.6/drivers/s390/char/raw3270.h	Mon May 10 04:32:52 2004
+++ linux-2.6-s390/drivers/s390/char/raw3270.h	Thu May 13 21:01:02 2004
@@ -78,9 +78,6 @@
 
 #define RAW3270_MAXDEVS	256
 
-int raw3270_init(void);
-void raw3270_exit(void);
-
 /* For TUBGETMOD and TUBSETMOD. Should include. */
 struct raw3270_iocb {
 	short model;
@@ -190,6 +187,10 @@
 struct raw3270 *raw3270_setup_console(struct ccw_device *cdev);
 void raw3270_wait_cons_dev(struct raw3270 *);
 
+/* Notifier for device addition/removal */
+int raw3270_register_notifier(void (*notifier)(int, int));
+void raw3270_unregister_notifier(void (*notifier)(int, int));
+
 /*
  * Little memory allocator for string objects. 
  */
diff -urN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-s390/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/drivers/s390/char/tty3270.c	Thu May 13 21:01:02 2004
@@ -35,6 +35,7 @@
 #define TTY3270_STRING_PAGES 5
 
 struct tty_driver *tty3270_driver;
+static int tty3270_max_index;
 
 struct raw3270_fn tty3270_fn;
 
@@ -836,6 +837,22 @@
 	tty3270_free_view((struct tty3270 *) view);
 }
 
+/*
+ * Delayed freeing of tty3270 views.
+ */
+static void
+tty3270_del_views(void)
+{
+	struct tty3270 *tp;
+	int i;
+
+	for (i = 0; i < tty3270_max_index; i++) {
+		tp = (struct tty3270 *) raw3270_find_view(&tty3270_fn, i);
+		if (!IS_ERR(tp))
+			raw3270_del_view(&tp->view);
+	}
+}
+
 struct raw3270_fn tty3270_fn = {
 	.activate = tty3270_activate,
 	.deactivate = tty3270_deactivate,
@@ -867,6 +884,12 @@
 		tp->inattr = TF_INPUT;
 		return 0;
 	}
+	if (tty3270_max_index < tty->index + 1)
+		tty3270_max_index = tty->index + 1;
+
+	/* Quick exit if there is no device for tty->index. */
+	if (PTR_ERR(tp) == -ENODEV)
+		return -ENODEV;
 
 	/* Allocate tty3270 structure on first open. */
 	tp = tty3270_alloc_view();
@@ -1778,9 +1801,6 @@
 	struct tty_driver *driver;
 	int ret;
 
-	ret = raw3270_init();
-	if (ret)
-		return ret;
 	driver = alloc_tty_driver(256);
 	if (!driver)
 		return -ENOMEM;
@@ -1807,6 +1827,14 @@
 		return ret;
 	}
 	tty3270_driver = driver;
+	ret = raw3270_register_notifier(tty3270_notifier);
+	if (ret) {
+		printk(KERN_ERR "tty3270 notifier registration failed "
+		       "with %d\n", ret);
+		put_tty_driver(driver);
+		return ret;
+
+	}
 	return 0;
 }
 
@@ -1815,10 +1843,11 @@
 {
 	struct tty_driver *driver;
 
+	raw3270_unregister_notifier(tty3270_notifier);
 	driver = tty3270_driver;
 	tty3270_driver = 0;
 	tty_unregister_driver(driver);
-	raw3270_exit();
+	tty3270_del_views();
 }
 
 MODULE_LICENSE("GPL");
