Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269418AbUJLDb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269418AbUJLDb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbUJLDb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:31:59 -0400
Received: from ozlabs.org ([203.10.76.45]:50139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269418AbUJLDbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:31:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16747.20196.293232.983056@cargo.ozlabs.ibm.com>
Date: Tue, 12 Oct 2004 13:26:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Proposed fix for PM deadlock on dpm_sem
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having trouble with deadlocks on dpm_sem when suspending
and resuming, particularly if I remove a usb device while my powerbook
is suspended.  The dpm_sem deadlocks also mean that USB can't deal
with devices whose drivers don't have suspend/resume callbacks by
simply disconnecting the device, as it did in the past.  This meant
that while I can get my dual G4 powermac desktop machine to suspend
to ram and resume (using the powerbook sleep code), its USB keyboard
wouldn't work after resume.

This patch removes the deadlocks by adding a new semaphore, called
dpm_list_sem, which serializes changes to the power management lists
(dpm_active et al.).  We hold dpm_sem during calls to suspend_device
and resume_device but not dpm_list_sem.

The question is then of course, what happens if devices are added or
removed during a device suspend or resume operation?  I have gone
through the various possibilities pretty carefully and I think I have
covered them all, but I would appreciate a review.

1. Device being removed during device_suspend().

The device will be removed from whichever list it is on.  If it is the
one currently being suspended, it won't go away while we are working
on it, because device_suspend does get_device().  However,
device_pm_remove will do list_del_init(&dev->power.entry).  In
device_suspend(), I added an if (!list_empty(&dev->power.entry)) to
make sure that we don't try to add the device to the dpm_off or
dpm_off_irq lists.

If it is not the device being suspended, device_pm_remove() will just
remove it from its current list.  If it is the dpm_active list, we are
still safe, because device_suspend() just takes the last entry from
the dpm_active list each time around the loop.

2. Device being added during device_suspend().

This is a much less likely case than 1 above.  If a device gets added,
it will get added to the tail of the dpm_active list and we will
suspend it next time around the loop.  The only problem I can see is
that the dpm_off{,_irq} lists might get disordered if a device gets
added after its parent has suspended.  However, it seems highly
unlikely to me that a device could be discovered when its parent is
suspended.

3. Device being removed during device_resume().

Here the device just gets removed from whatever list it is on and
there is no problem.  The dpm_resume() function just takes the first
entry from the dpm_off list each time, removes it from that list and
adds it to the dpm_active list.  I changed dpm_resume() to do that
list manipulation before calling resume_device, and to do get_device/
put_device around the resume_device call.

4. Device being added during device_resume().

In this case the device gets added to tail of the dpm_active list, and
presumably is already active and doesn't need to be resumed.  Assuming
that a device can't be added until its parent is resumed, the
dpm_active list will be in the correct order, since the parent is
already on the dpm_active list at the time it is being resumed.

The same analysis applies to dpm_power_up() as to dpm_resume().

Comments?

Paul.

diff -urN linux-2.5/drivers/base/power/main.c pmac-2.5/drivers/base/power/main.c
--- linux-2.5/drivers/base/power/main.c	2004-06-23 07:43:33.000000000 +1000
+++ pmac-2.5/drivers/base/power/main.c	2004-10-12 12:11:35.053833144 +1000
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
 
 
diff -urN linux-2.5/drivers/base/power/power.h pmac-2.5/drivers/base/power/power.h
--- linux-2.5/drivers/base/power/power.h	2004-06-23 07:43:33.000000000 +1000
+++ pmac-2.5/drivers/base/power/power.h	2004-10-12 08:36:46.000000000 +1000
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
diff -urN linux-2.5/drivers/base/power/resume.c pmac-2.5/drivers/base/power/resume.c
--- linux-2.5/drivers/base/power/resume.c	2004-06-23 07:43:33.000000000 +1000
+++ pmac-2.5/drivers/base/power/resume.c	2004-10-12 13:20:02.200451952 +1000
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
 
diff -urN linux-2.5/drivers/base/power/suspend.c pmac-2.5/drivers/base/power/suspend.c
--- linux-2.5/drivers/base/power/suspend.c	2004-06-23 07:43:33.000000000 +1000
+++ pmac-2.5/drivers/base/power/suspend.c	2004-10-12 08:45:23.000000000 +1000
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
 
 EXPORT_SYMBOL(device_suspend);
