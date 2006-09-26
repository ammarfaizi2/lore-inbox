Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWIZFih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWIZFih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWIZFig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:47329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751318AbWIZFia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:30 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/47] Suspend infrastructure cleanup and extension
Date: Mon, 25 Sep 2006 22:37:29 -0700
Message-Id: <1159249111668-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491082990-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

Allow devices to participate in the suspend process more intimately,
in particular, allow the final phase (with interrupts disabled) to
also be open to normal devices, not just system devices.

Also, allow classes to participate in device suspend.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/resume.c  |   28 ++++++++--
 drivers/base/power/suspend.c |  122 ++++++++++++++++++++++++++++++++----------
 include/linux/device.h       |   11 +++-
 include/linux/pm.h           |    1 
 kernel/power/main.c          |    4 +
 5 files changed, 130 insertions(+), 36 deletions(-)

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 826093e..48e3d49 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -38,13 +38,35 @@ int resume_device(struct device * dev)
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
 	}
+	if (dev->class && dev->class->resume) {
+		dev_dbg(dev,"class resume\n");
+		error = dev->class->resume(dev);
+	}
 	up(&dev->sem);
 	TRACE_RESUME(error);
 	return error;
 }
 
 
+static int resume_device_early(struct device * dev)
+{
+	int error = 0;
 
+	TRACE_DEVICE(dev);
+	TRACE_RESUME(0);
+	if (dev->bus && dev->bus->resume_early) {
+		dev_dbg(dev,"EARLY resume\n");
+		error = dev->bus->resume_early(dev);
+	}
+	TRACE_RESUME(error);
+	return error;
+}
+
+/*
+ * Resume the devices that have either not gone through
+ * the late suspend, or that did go through it but also
+ * went through the early resume
+ */
 void dpm_resume(void)
 {
 	down(&dpm_list_sem);
@@ -99,10 +121,8 @@ void dpm_power_up(void)
 		struct list_head * entry = dpm_off_irq.next;
 		struct device * dev = to_device(entry);
 
-		get_device(dev);
-		list_move_tail(entry, &dpm_active);
-		resume_device(dev);
-		put_device(dev);
+		list_move_tail(entry, &dpm_off);
+		resume_device_early(dev);
 	}
 }
 
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 69509e0..10e8032 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -65,7 +65,19 @@ int suspend_device(struct device * dev, 
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
+	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
+		dev_dbg(dev, "class %s%s\n",
+			suspend_verb(state.event),
+			((state.event == PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
+		error = dev->class->suspend(dev, state);
+		suspend_report_result(dev->class->suspend, error);
+	}
+
+	if (!error && dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "%s%s\n",
 			suspend_verb(state.event),
 			((state.event == PM_EVENT_SUSPEND)
@@ -81,15 +93,74 @@ int suspend_device(struct device * dev, 
 }
 
 
+/*
+ * This is called with interrupts off, only a single CPU
+ * running. We can't do down() on a semaphore (and we don't
+ * need the protection)
+ */
+static int suspend_device_late(struct device *dev, pm_message_t state)
+{
+	int error = 0;
+
+	if (dev->power.power_state.event) {
+		dev_dbg(dev, "PM: suspend_late %d-->%d\n",
+			dev->power.power_state.event, state.event);
+	}
+
+	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
+		dev_dbg(dev, "LATE %s%s\n",
+			suspend_verb(state.event),
+			((state.event == PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
+		error = dev->bus->suspend_late(dev, state);
+		suspend_report_result(dev->bus->suspend_late, error);
+	}
+	return error;
+}
+
+/**
+ *	device_prepare_suspend - save state and prepare to suspend
+ *
+ *	NOTE! Devices cannot detach at this point - not only do we
+ *	hold the device list semaphores over the whole prepare, but
+ *	the whole point is to do non-invasive preparatory work, not
+ *	the actual suspend.
+ */
+int device_prepare_suspend(pm_message_t state)
+{
+	int error = 0;
+	struct device * dev;
+
+	down(&dpm_sem);
+	down(&dpm_list_sem);
+	list_for_each_entry_reverse(dev, &dpm_active, power.entry) {
+		if (!dev->bus || !dev->bus->suspend_prepare)
+			continue;
+		error = dev->bus->suspend_prepare(dev, state);
+		if (error)
+			break;
+	}
+	up(&dpm_list_sem);
+	up(&dpm_sem);
+	return error;
+}
+
 /**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
- *	it to dpm_off.
- *	Check the return value for each. If it returns 0, then we move the
- *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
- *	the dpm_off_irq list. If we get a different error, try and back out.
+ *	it to the dpm_off list.
+ *
+ *	(For historical reasons, if it returns -EAGAIN, that used to mean
+ *	that the device would be called again with interrupts disabled.
+ *	These days, we use the "suspend_late()" callback for that, so we
+ *	print a warning and consider it an error).
+ *
+ *	If we get a different error, try and back out.
  *
  *	If we hit a failure with any of the devices, call device_resume()
  *	above to bring the suspended devices back to life.
@@ -115,39 +186,27 @@ int device_suspend(pm_message_t state)
 
 		/* Check if the device got removed */
 		if (!list_empty(&dev->power.entry)) {
-			/* Move it to the dpm_off or dpm_off_irq list */
+			/* Move it to the dpm_off list */
 			if (!error)
 				list_move(&dev->power.entry, &dpm_off);
-			else if (error == -EAGAIN) {
-				list_move(&dev->power.entry, &dpm_off_irq);
-				error = 0;
-			}
 		}
 		if (error)
 			printk(KERN_ERR "Could not suspend device %s: "
-				"error %d\n", kobject_name(&dev->kobj), error);
+				"error %d%s\n",
+				kobject_name(&dev->kobj), error,
+				error == -EAGAIN ? " (please convert to suspend_late)" : "");
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error) {
-		/* we failed... before resuming, bring back devices from
-		 * dpm_off_irq list back to main dpm_off list, we do want
-		 * to call resume() on them, in case they partially suspended
-		 * despite returning -EAGAIN
-		 */
-		while (!list_empty(&dpm_off_irq)) {
-			struct list_head * entry = dpm_off_irq.next;
-			list_move(entry, &dpm_off);
-		}
+	if (error)
 		dpm_resume();
-	}
+
 	up(&dpm_sem);
 	return error;
 }
 
 EXPORT_SYMBOL_GPL(device_suspend);
 
-
 /**
  *	device_power_down - Shut down special devices.
  *	@state:		Power state to enter.
@@ -162,14 +221,17 @@ int device_power_down(pm_message_t state
 	int error = 0;
 	struct device * dev;
 
-	list_for_each_entry_reverse(dev, &dpm_off_irq, power.entry) {
-		if ((error = suspend_device(dev, state)))
-			break;
+	while (!list_empty(&dpm_off)) {
+		struct list_head * entry = dpm_off.prev;
+
+		dev = to_device(entry);
+		error = suspend_device_late(dev, state);
+		if (error)
+			goto Error;
+		list_move(&dev->power.entry, &dpm_off_irq);
 	}
-	if (error)
-		goto Error;
-	if ((error = sysdev_suspend(state)))
-		goto Error;
+
+	error = sysdev_suspend(state);
  Done:
 	return error;
  Error:
diff --git a/include/linux/device.h b/include/linux/device.h
index 8a648cd..b40be6f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -51,8 +51,12 @@ struct bus_type {
 	int		(*probe)(struct device * dev);
 	int		(*remove)(struct device * dev);
 	void		(*shutdown)(struct device * dev);
-	int		(*suspend)(struct device * dev, pm_message_t state);
-	int		(*resume)(struct device * dev);
+
+	int (*suspend_prepare)(struct device * dev, pm_message_t state);
+	int (*suspend)(struct device * dev, pm_message_t state);
+	int (*suspend_late)(struct device * dev, pm_message_t state);
+	int (*resume_early)(struct device * dev);
+	int (*resume)(struct device * dev);
 };
 
 extern int bus_register(struct bus_type * bus);
@@ -154,6 +158,9 @@ struct class {
 
 	void	(*release)(struct class_device *dev);
 	void	(*class_release)(struct class *class);
+
+	int	(*suspend)(struct device *, pm_message_t state);
+	int	(*resume)(struct device *);
 };
 
 extern int class_register(struct class *);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 658c1b9..096fb6f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -190,6 +190,7 @@ #ifdef CONFIG_PM
 extern suspend_disk_method_t pm_disk_mode;
 
 extern int device_suspend(pm_message_t state);
+extern int device_prepare_suspend(pm_message_t state);
 
 #define device_set_wakeup_enable(dev,val) \
 	((dev)->power.should_wakeup = !!(val))
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6d295c7..0c3ed6a 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -57,6 +57,10 @@ static int suspend_prepare(suspend_state
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 
+	error = device_prepare_suspend(PMSG_SUSPEND);
+	if (error)
+		return error;
+
 	pm_prepare_console();
 
 	disable_nonboot_cpus();
-- 
1.4.2.1

