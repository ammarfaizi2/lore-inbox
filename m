Return-Path: <linux-kernel-owner+willy=40w.ods.org-S275821AbUKAXSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275821AbUKAXSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381622AbUKAXQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:16:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:9636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S273923AbUKAV7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:23 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <1099346276148@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:57 -0800
Message-Id: <10993462773570@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2447, 2004/11/01 13:05:06-08:00, akpm@osdl.org

[PATCH] Fix deadlocks on dpm_sem

From: Paul Mackerras <paulus@samba.org>

Currently the device_pm_foo() functions are rather prone to deadlocks
during suspend/resume.  This is because the dpm_sem is held for the
duration of device_suspend() and device_resume() as well as device_pm_add()
and device_pm_remove().  If for any reason you get a device addition or
removal triggered by a device's suspend or resume code, you get a deadlock.
 (The classic example is a USB host adaptor resuming and discovering that
the mouse you used to have plugged in has gone away.)

This patch fixes the problem by using a separate semaphore, called
dpm_list_sem, to cover the places where we need the device pm lists to be
stable, and by being careful about how we traverse the lists on suspend and
resume.  I have analysed the various cases that can occur and I am
confident that I have handled them all correctly.  I posted this patch
together with a detailed analysis 10 days ago.

Signed-off-by Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/main.c    |   11 +++++-----
 drivers/base/power/power.h   |    5 ++++
 drivers/base/power/resume.c  |   16 ++++++++++++---
 drivers/base/power/suspend.c |   44 ++++++++++++++++++++++++-------------------
 4 files changed, 49 insertions(+), 27 deletions(-)


diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	2004-11-01 13:36:34 -08:00
+++ b/drivers/base/power/main.c	2004-11-01 13:36:34 -08:00
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
 
 
diff -Nru a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h	2004-11-01 13:36:34 -08:00
+++ b/drivers/base/power/power.h	2004-11-01 13:36:34 -08:00
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
diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	2004-11-01 13:36:34 -08:00
+++ b/drivers/base/power/resume.c	2004-11-01 13:36:34 -08:00
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
 
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	2004-11-01 13:36:34 -08:00
+++ b/drivers/base/power/suspend.c	2004-11-01 13:36:34 -08:00
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

