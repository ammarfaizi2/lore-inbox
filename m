Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422978AbWCXBcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWCXBcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbWCXBbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:31:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:42436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422979AbWCXBbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:31:15 -0500
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/8] w1: use kthread api.
In-Reply-To: <11431638383855-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 17:30:38 -0800
Message-Id: <11431638382449-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes old-style kernel thread initialization
and changes w1 to use kthread api.
It is based on Christoph Hellwig <hch@lst.de> work.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/w1/w1.c     |   56 +++++++++++++++------------------------------------
 drivers/w1/w1.h     |    3 +--
 drivers/w1/w1_int.c |   34 ++++++++++---------------------
 3 files changed, 28 insertions(+), 65 deletions(-)

674a396c6d2ba0341ebdd7c1c9950f32f018e2dd
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index d640c1e..a698b51 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -30,6 +30,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 
 #include <asm/atomic.h>
 
@@ -57,9 +58,7 @@ module_param_named(slave_ttl, w1_max_sla
 DEFINE_SPINLOCK(w1_mlock);
 LIST_HEAD(w1_masters);
 
-static pid_t control_thread;
-static int control_needs_exit;
-static DECLARE_COMPLETION(w1_control_complete);
+static struct task_struct *w1_control_thread;
 
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
@@ -717,22 +716,16 @@ static int w1_control(void *data)
 {
 	struct w1_slave *sl, *sln;
 	struct w1_master *dev, *n;
-	int err, have_to_wait = 0;
+	int have_to_wait = 0;
 
-	daemonize("w1_control");
-	allow_signal(SIGTERM);
-
-	while (!control_needs_exit || have_to_wait) {
+	while (!kthread_should_stop() || have_to_wait) {
 		have_to_wait = 0;
 
 		try_to_freeze();
 		msleep_interruptible(w1_control_timeout * 1000);
 
-		if (signal_pending(current))
-			flush_signals(current);
-
 		list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry) {
-			if (!control_needs_exit && !dev->flags)
+			if (!kthread_should_stop() && !dev->flags)
 				continue;
 			/*
 			 * Little race: we can create thread but not set the flag.
@@ -743,21 +736,12 @@ static int w1_control(void *data)
 				continue;
 			}
 
-			if (control_needs_exit) {
+			if (kthread_should_stop() || test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 
-				err = kill_proc(dev->kpid, SIGTERM, 1);
-				if (err)
-					dev_err(&dev->dev,
-						 "Failed to send signal to w1 kernel thread %d.\n",
-						 dev->kpid);
-			}
-
-			if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
-				wait_for_completion(&dev->dev_exited);
-				spin_lock_bh(&w1_mlock);
+				spin_lock(&w1_mlock);
 				list_del(&dev->w1_master_entry);
-				spin_unlock_bh(&w1_mlock);
+				spin_unlock(&w1_mlock);
 
 				down(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
@@ -789,7 +773,7 @@ static int w1_control(void *data)
 		}
 	}
 
-	complete_and_exit(&w1_control_complete, 0);
+	return 0;
 }
 
 int w1_process(void *data)
@@ -797,17 +781,11 @@ int w1_process(void *data)
 	struct w1_master *dev = (struct w1_master *) data;
 	struct w1_slave *sl, *sln;
 
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
-
-	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
+	while (!kthread_should_stop() && !test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 		try_to_freeze();
 		msleep_interruptible(w1_timeout * 1000);
 
-		if (signal_pending(current))
-			flush_signals(current);
-
-		if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags))
+		if (kthread_should_stop() || test_bit(W1_MASTER_NEED_EXIT, &dev->flags))
 			break;
 
 		if (!dev->initialized)
@@ -840,7 +818,6 @@ int w1_process(void *data)
 	}
 
 	atomic_dec(&dev->refcnt);
-	complete_and_exit(&dev->dev_exited, 0);
 
 	return 0;
 }
@@ -873,11 +850,11 @@ static int w1_init(void)
 		goto err_out_master_unregister;
 	}
 
-	control_thread = kernel_thread(&w1_control, NULL, 0);
-	if (control_thread < 0) {
+	w1_control_thread = kthread_run(w1_control, NULL, "w1_control");
+	if (IS_ERR(w1_control_thread)) {
+		retval = PTR_ERR(w1_control_thread);
 		printk(KERN_ERR "Failed to create control thread. err=%d\n",
-			control_thread);
-		retval = control_thread;
+			retval);
 		goto err_out_slave_unregister;
 	}
 
@@ -903,8 +880,7 @@ static void w1_fini(void)
 	list_for_each_entry(dev, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
-	control_needs_exit = 1;
-	wait_for_completion(&w1_control_complete);
+	kthread_stop(w1_control_thread);
 
 	driver_unregister(&w1_slave_driver);
 	driver_unregister(&w1_master_driver);
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 5f09213..5698050 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -172,12 +172,11 @@ struct w1_master
 
 	long			flags;
 
-	pid_t			kpid;
+	struct task_struct	*thread;
 	struct semaphore	mutex;
 
 	struct device_driver	*driver;
 	struct device		dev;
-	struct completion	dev_exited;
 
 	struct w1_bus_master	*bus_master;
 
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index a2f9065..68565aa 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 
 #include "w1.h"
 #include "w1_log.h"
@@ -56,7 +57,6 @@ static struct w1_master * w1_alloc_dev(u
 	dev->max_slave_count	= slave_count;
 	dev->slave_count	= 0;
 	dev->attempts		= 0;
-	dev->kpid		= -1;
 	dev->initialized	= 0;
 	dev->id			= id;
 	dev->slave_ttl		= slave_ttl;
@@ -67,8 +67,6 @@ static struct w1_master * w1_alloc_dev(u
 	INIT_LIST_HEAD(&dev->slist);
 	init_MUTEX(&dev->mutex);
 
-	init_completion(&dev->dev_exited);
-
 	memcpy(&dev->dev, device, sizeof(struct device));
 	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
 		  "w1_bus_master%u", dev->id);
@@ -116,12 +114,12 @@ int w1_add_master_device(struct w1_bus_m
 	if (!dev)
 		return -ENOMEM;
 
-	dev->kpid = kernel_thread(&w1_process, dev, 0);
-	if (dev->kpid < 0) {
+	dev->thread = kthread_run(&w1_process, dev, "%s", dev->name);
+	if (IS_ERR(dev->thread)) {
+		retval = PTR_ERR(dev->thread);
 		dev_err(&dev->dev,
 			 "Failed to create new kernel thread. err=%d\n",
-			 dev->kpid);
-		retval = dev->kpid;
+			 retval);
 		goto err_out_free_dev;
 	}
 
@@ -138,20 +136,14 @@ int w1_add_master_device(struct w1_bus_m
 	spin_unlock(&w1_mlock);
 
 	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
+	msg.id.mst.pid = dev->thread->pid;
 	msg.type = W1_MASTER_ADD;
 	w1_netlink_send(dev, &msg);
 
 	return 0;
 
 err_out_kill_thread:
-	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
-	if (kill_proc(dev->kpid, SIGTERM, 1))
-		dev_err(&dev->dev,
-			 "Failed to send signal to w1 kernel thread %d.\n",
-			 dev->kpid);
-	wait_for_completion(&dev->dev_exited);
-
+	kthread_stop(dev->thread);
 err_out_free_dev:
 	w1_free_dev(dev);
 
@@ -160,18 +152,14 @@ err_out_free_dev:
 
 void __w1_remove_master_device(struct w1_master *dev)
 {
-	int err;
 	struct w1_netlink_msg msg;
+	pid_t pid = dev->thread->pid;
 
 	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
-	err = kill_proc(dev->kpid, SIGTERM, 1);
-	if (err)
-		dev_err(&dev->dev,
-			 "%s: Failed to send signal to w1 kernel thread %d.\n",
-			 __func__, dev->kpid);
+	kthread_stop(dev->thread);
 
 	while (atomic_read(&dev->refcnt)) {
-		dev_dbg(&dev->dev, "Waiting for %s to become free: refcnt=%d.\n",
+		dev_info(&dev->dev, "Waiting for %s to become free: refcnt=%d.\n",
 				dev->name, atomic_read(&dev->refcnt));
 
 		if (msleep_interruptible(1000))
@@ -179,7 +167,7 @@ void __w1_remove_master_device(struct w1
 	}
 
 	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
+	msg.id.mst.pid = pid;
 	msg.type = W1_MASTER_REMOVE;
 	w1_netlink_send(dev, &msg);
 
-- 
1.2.4


