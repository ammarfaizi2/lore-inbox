Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270856AbUJVDvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbUJVDvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270812AbUJVDs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:48:57 -0400
Received: from ozlabs.org ([203.10.76.45]:1177 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270938AbUJVDp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:45:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.33519.670998.641860@cargo.ozlabs.ibm.com>
Date: Fri, 22 Oct 2004 13:47:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix deadlocks on dpm_sem
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the device_pm_foo() functions are rather prone to deadlocks
during suspend/resume.  This is because the dpm_sem is held for the
duration of device_suspend() and device_resume() as well as
device_pm_add() and device_pm_remove().  If for any reason you get a
device addition or removal triggered by a device's suspend or resume
code, you get a deadlock.  (The classic example is a USB host adaptor
resuming and discovering that the mouse you used to have plugged in
has gone away.)

This patch fixes the problem by using a separate semaphore, called
dpm_list_sem, to cover the places where we need the device pm lists to
be stable, and by being careful about how we traverse the lists on
suspend and resume.  I have analysed the various cases that can occur
and I am confident that I have handled them all correctly.  I posted
this patch together with a detailed analysis 10 days ago.

Andrew, could this go in -mm for testing please?  Pat, any comments?

Signed-off-by Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/base/power/main.c test25-pseries/drivers/base/power/main.c
--- linux-2.5/drivers/base/power/main.c	2004-10-20 21:20:19.000000000 +1000
+++ test25-pseries/drivers/base/power/main.c	2004-10-22 13:16:29.628659544 +1000
@@ -28,6 +28,7 @@
 LIST_HEAD(dpm_off_irq);
 
 DECLARE_MUTEX(dpm_sem);
+DECLARE_MUTEX(dpm_list_sem);
 
 /*
  * PM Reference Counting.
@@ -75,12 +76,12 @@
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
 	atomic_set(&dev->power.pm_users, 0);
-	down(&dpm_sem);
+	down(&dpm_list_sem);
 	list_add_tail(&dev->power.entry, &dpm_active);
 	device_pm_set_parent(dev, dev->parent);
 	if ((error = dpm_sysfs_add(dev)))
 		list_del(&dev->power.entry);
-	up(&dpm_sem);
+	up(&dpm_list_sem);
 	return error;
 }
 
@@ -88,11 +89,11 @@
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
-	down(&dpm_sem);
+	down(&dpm_list_sem);
 	dpm_sysfs_remove(dev);
 	device_pm_release(dev->power.pm_parent);
-	list_del(&dev->power.entry);
-	up(&dpm_sem);
+	list_del_init(&dev->power.entry);
+	up(&dpm_list_sem);
 }
 
 
diff -urN linux-2.5/drivers/base/power/power.h test25-pseries/drivers/base/power/power.h
--- linux-2.5/drivers/base/power/power.h	2004-06-23 07:43:33.000000000 +1000
+++ test25-pseries/drivers/base/power/power.h	2004-10-22 13:16:29.630659240 +1000
@@ -28,6 +28,11 @@
 extern struct semaphore dpm_sem;
 
 /*
+ * Used to serialize changes to the dpm_* lists.
+ */
+extern struct semaphore dpm_list_sem;
+
+/*
  * The PM lists.
  */
 extern struct list_head dpm_active;
diff -urN linux-2.5/drivers/base/power/resume.c test25-pseries/drivers/base/power/resume.c
--- linux-2.5/drivers/base/power/resume.c	2004-10-20 21:20:19.000000000 +1000
+++ test25-pseries/drivers/base/power/resume.c	2004-10-22 13:16:29.631659088 +1000
@@ -31,16 +31,22 @@
 
 void dpm_resume(void)
 {
+	down(&dpm_list_sem);
 	while(!list_empty(&dpm_off)) {
 		struct list_head * entry = dpm_off.next;
 		struct device * dev = to_device(entry);
+
+		get_device(dev);
 		list_del_init(entry);
+		list_add_tail(entry, &dpm_active);
 
+		up(&dpm_list_sem);
 		if (!dev->power.prev_state)
 			resume_device(dev);
-
-		list_add_tail(entry, &dpm_active);
+		down(&dpm_list_sem);
+		put_device(dev);
 	}
+	up(&dpm_list_sem);
 }
 
 
@@ -76,9 +82,13 @@
 {
 	while(!list_empty(&dpm_off_irq)) {
 		struct list_head * entry = dpm_off_irq.next;
+		struct device * dev = to_device(entry);
+
+		get_device(dev);
 		list_del_init(entry);
-		resume_device(to_device(entry));
 		list_add_tail(entry, &dpm_active);
+		resume_device(dev);
+		put_device(dev);
 	}
 }
 
diff -urN linux-2.5/drivers/base/power/suspend.c test25-pseries/drivers/base/power/suspend.c
--- linux-2.5/drivers/base/power/suspend.c	2004-10-20 21:20:19.000000000 +1000
+++ test25-pseries/drivers/base/power/suspend.c	2004-10-22 13:16:29.633658784 +1000
@@ -63,11 +63,6 @@
  *	If we hit a failure with any of the devices, call device_resume()
  *	above to bring the suspended devices back to life.
  *
- *	Note this function leaves dpm_sem held to
- *	a) block other devices from registering.
- *	b) prevent other PM operations from happening after we've begun.
- *	c) make sure we're exclusive when we disable interrupts.
- *
  */
 
 int device_suspend(u32 state)
@@ -75,29 +70,40 @@
 	int error = 0;
 
 	down(&dpm_sem);
-	while(!list_empty(&dpm_active)) {
+	down(&dpm_list_sem);
+	while (!list_empty(&dpm_active) && error == 0) {
 		struct list_head * entry = dpm_active.prev;
 		struct device * dev = to_device(entry);
+
+		get_device(dev);
+		up(&dpm_list_sem);
+
 		error = suspend_device(dev, state);
 
-		if (!error) {
-			list_del(&dev->power.entry);
-			list_add(&dev->power.entry, &dpm_off);
-		} else if (error == -EAGAIN) {
-			list_del(&dev->power.entry);
-			list_add(&dev->power.entry, &dpm_off_irq);
-		} else {
+		down(&dpm_list_sem);
+
+		/* Check if the device got removed */
+		if (!list_empty(&dev->power.entry)) {
+			/* Move it to the dpm_off or dpm_off_irq list */
+			if (!error) {
+				list_del(&dev->power.entry);
+				list_add(&dev->power.entry, &dpm_off);
+			} else if (error == -EAGAIN) {
+				list_del(&dev->power.entry);
+				list_add(&dev->power.entry, &dpm_off_irq);
+				error = 0;
+			}
+		}
+		if (error)
 			printk(KERN_ERR "Could not suspend device %s: "
 				"error %d\n", kobject_name(&dev->kobj), error);
-			goto Error;
-		}
+		put_device(dev);
 	}
- Done:
+	up(&dpm_list_sem);
+	if (error)
+		dpm_resume();
 	up(&dpm_sem);
 	return error;
- Error:
-	dpm_resume();
-	goto Done;
 }
 
 EXPORT_SYMBOL_GPL(device_suspend);
