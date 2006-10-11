Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030653AbWJKGL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030653AbWJKGL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWJKGLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:11:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17266 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1030654AbWJKGLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:11:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAFonLEU
Message-Id: <20061011061030.258583307.dtor@insightbb.com>
References: <20061011060138.920913139.dtor@insightbb.com>
Date: Wed, 11 Oct 2006 02:01:40 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-pm@lists.osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC/PATCH 2/3] Allow objects other than "struct device" in pm list
Content-Disposition: inline; filename=dpm-make-mutiobject.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PM: allow objects other than "struct device" in pm list

Any object with embedded dev_pm_info structure can be added to
ower management list and have its suspend/resume methods called
automatically by driver core.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/power/main.c    |   69 ++++++++++++++++++++++++++--------
 drivers/base/power/power.h   |   23 ++++++++++-
 drivers/base/power/resume.c  |   61 +++++++++++++++++-------------
 drivers/base/power/runtime.c |   30 ++++++++-------
 drivers/base/power/suspend.c |   85 ++++++++++++++++++++++++-------------------
 drivers/base/power/trace.c   |   17 +++++---
 drivers/pcmcia/ds.c          |    8 ++--
 include/linux/pm.h           |   21 +++++++---
 include/linux/resume-trace.h |   10 ++---
 9 files changed, 207 insertions(+), 117 deletions(-)

Index: work/drivers/base/power/main.c
===================================================================
--- work.orig/drivers/base/power/main.c
+++ work/drivers/base/power/main.c
@@ -31,8 +31,8 @@ DECLARE_MUTEX(dpm_list_sem);
 
 /**
  *	device_pm_set_parent - Specify power dependency.
- *	@dev:		Device who needs power.
- *	@parent:	Device that supplies power.
+ *	@dpm:		Object who needs power.
+ *	@parent:	Object that supplies power.
  *
  *	This function is used to manually describe a power-dependency
  *	relationship. It may be used to specify a transversal relationship
@@ -42,26 +42,63 @@ DECLARE_MUTEX(dpm_list_sem);
  *	before the power dependent.
  */
 
-void device_pm_set_parent(struct device * dev, struct device * parent)
+void dpm_set_parent(struct dev_pm_info *dpm, struct dev_pm_info *parent)
 {
-	put_device(dev->power.pm_parent);
-	dev->power.pm_parent = get_device(parent);
+	if (dpm->pm_parent)
+		kobject_put(dpm->pm_parent->pm_object);
+	if (parent)
+		kobject_get(parent->pm_object);
+	dpm->pm_parent = parent;
 }
-EXPORT_SYMBOL_GPL(device_pm_set_parent);
+EXPORT_SYMBOL_GPL(dpm_set_parent);
 
-int device_pm_add(struct device * dev)
+int dpm_add_object(struct dev_pm_info *dpm)
 {
+	down(&dpm_list_sem);
+	list_add_tail(&dpm->entry, &dpm_active);
+	up(&dpm_list_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dpm_add_object);
+
+void dpm_delete_object(struct dev_pm_info *dpm)
+{
+	down(&dpm_list_sem);
+	dpm_set_parent(dpm, NULL);
+	list_del_init(&dpm->entry);
+	up(&dpm_list_sem);
+}
+EXPORT_SYMBOL_GPL(dpm_delete_object);
+
+static const struct dev_pm_ops device_pm_ops = {
+	.suspend	= suspend_device,
+	.suspend_late	= suspend_device_late,
+	.resume		= resume_device,
+	.resume_early	= resume_device_early,
+};
+
+int device_pm_add(struct device *dev)
+{
+	struct dev_pm_info *dpm = &dev->power;
 	int error;
 
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
-	down(&dpm_list_sem);
-	list_add_tail(&dev->power.entry, &dpm_active);
-	device_pm_set_parent(dev, dev->parent);
-	if ((error = dpm_sysfs_add(dev)))
-		list_del(&dev->power.entry);
-	up(&dpm_list_sem);
+
+	dpm->pm_object = &dev->kobj;
+	dpm->pm_ops = &device_pm_ops;
+	if (dev->parent)
+		dpm_set_parent(dpm, &dev->parent->power);
+	error = dpm_add_object(dpm);
+	if (error)
+		return error;
+
+	error = dpm_sysfs_add(dev);
+	if (error)
+		dpm_delete_object(dpm);
+
 	return error;
 }
 
@@ -70,11 +107,9 @@ void device_pm_remove(struct device * de
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
-	down(&dpm_list_sem);
+
 	dpm_sysfs_remove(dev);
-	put_device(dev->power.pm_parent);
-	list_del_init(&dev->power.entry);
-	up(&dpm_list_sem);
+	dpm_delete_object(&dev->power);
 }
 
 
Index: work/drivers/base/power/resume.c
===================================================================
--- work.orig/drivers/base/power/resume.c
+++ work/drivers/base/power/resume.c
@@ -20,26 +20,28 @@
  *
  */
 
-int resume_device(struct device * dev)
+int resume_device(struct dev_pm_info *dpm)
 {
 	int error = 0;
+	struct device *dev = container_of(dpm, struct device, power);
+	struct dev_pm_info *pm_parent = dpm->pm_parent;
 
-	TRACE_DEVICE(dev);
+	TRACE_DEVICE(dpm);
 	TRACE_RESUME(0);
 	down(&dev->sem);
-	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+
+	if (pm_parent && pm_parent->power_state.event) {
+		pm_err(dpm, "resume from %d, parent %s still %d\n",
+			dpm->power_state.event,
+			kobject_name(pm_parent->pm_object),
+			pm_parent->power_state.event);
 	}
 	if (dev->bus && dev->bus->resume) {
-		dev_dbg(dev,"resuming\n");
+		pm_dbg(dpm, "resuming\n");
 		error = dev->bus->resume(dev);
 	}
 	if (dev->class && dev->class->resume) {
-		dev_dbg(dev,"class resume\n");
+		pm_dbg(dpm, "class resume\n");
 		error = dev->class->resume(dev);
 	}
 	up(&dev->sem);
@@ -47,12 +49,12 @@ int resume_device(struct device * dev)
 	return error;
 }
 
-
-static int resume_device_early(struct device * dev)
+int resume_device_early(struct dev_pm_info *dpm)
 {
 	int error = 0;
+	struct device *dev = container_of(dpm, struct device, power);
 
-	TRACE_DEVICE(dev);
+	TRACE_DEVICE(dpm);
 	TRACE_RESUME(0);
 	if (dev->bus && dev->bus->resume_early) {
 		dev_dbg(dev,"EARLY resume\n");
@@ -62,6 +64,7 @@ static int resume_device_early(struct de
 	return error;
 }
 
+
 /*
  * Resume the devices that have either not gone through
  * the late suspend, or that did go through it but also
@@ -69,19 +72,21 @@ static int resume_device_early(struct de
  */
 void dpm_resume(void)
 {
-	down(&dpm_list_sem);
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
-		struct device * dev = to_device(entry);
+	struct dev_pm_info *dpm;
 
-		get_device(dev);
-		list_move_tail(entry, &dpm_active);
+	down(&dpm_list_sem);
+	while (!list_empty(&dpm_off)) {
+		dpm = list_entry(dpm_off.next, struct dev_pm_info, entry);
 
+		kobject_get(dpm->pm_object);
+		list_move_tail(&dpm->entry, &dpm_active);
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state.event)
-			resume_device(dev);
+
+		if (!dpm->prev_state.event)
+			dpm->pm_ops->resume(dpm);
+
 		down(&dpm_list_sem);
-		put_device(dev);
+		kobject_put(dpm->pm_object);
 	}
 	up(&dpm_list_sem);
 }
@@ -118,12 +123,14 @@ EXPORT_SYMBOL_GPL(device_resume);
 
 void dpm_power_up(void)
 {
-	while(!list_empty(&dpm_off_irq)) {
-		struct list_head * entry = dpm_off_irq.next;
-		struct device * dev = to_device(entry);
+	struct dev_pm_info *dpm;
+
+	while (!list_empty(&dpm_off_irq)) {
+		dpm = list_entry(dpm_off_irq.next, struct dev_pm_info, entry);
 
-		list_move_tail(entry, &dpm_off);
-		resume_device_early(dev);
+		list_move_tail(&dpm->entry, &dpm_off);
+		if (dpm->pm_ops->resume_early)
+			dpm->pm_ops->resume_early(dpm);
 	}
 }
 
Index: work/drivers/base/power/suspend.c
===================================================================
--- work.orig/drivers/base/power/suspend.c
+++ work/drivers/base/power/suspend.c
@@ -46,28 +46,29 @@ static inline char *suspend_verb(u32 eve
  *	@state:	Power state device is entering.
  */
 
-int suspend_device(struct device * dev, pm_message_t state)
+int suspend_device(struct dev_pm_info *dpm, pm_message_t state)
 {
 	int error = 0;
+	struct device *dev = container_of(dpm, struct device, power);
+	struct dev_pm_info *dpm_parent = dpm->pm_parent;
 
 	down(&dev->sem);
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev,
-			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state.event, state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
-	}
 
-	dev->power.prev_state = dev->power.power_state;
+	if (dpm->power_state.event)
+		pm_dbg(dpm, "suspend %d-->%d\n",
+			dpm->power_state.event, state.event);
+
+	if (dpm_parent && dpm_parent->power_state.event)
+		pm_err(dpm,
+			"suspend %d->%d, parent %s already %d\n",
+			dpm->power_state.event, state.event,
+			kobject_name(dpm_parent->pm_object),
+			dpm_parent->power_state.event);
+
+	dpm->prev_state = dpm->power_state;
 
-	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "class %s%s\n",
+	if (dev->class && dev->class->suspend && !dpm->power_state.event) {
+		pm_dbg(dpm, "class %s%s\n",
 			suspend_verb(state.event),
 			((state.event == PM_EVENT_SUSPEND)
 					&& device_may_wakeup(dev))
@@ -78,8 +79,8 @@ int suspend_device(struct device * dev, 
 		suspend_report_result(dev->class->suspend, error);
 	}
 
-	if (!error && dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "%s%s\n",
+	if (!error && dev->bus && dev->bus->suspend && !dpm->power_state.event) {
+		pm_dbg(dpm, "%s%s\n",
 			suspend_verb(state.event),
 			((state.event == PM_EVENT_SUSPEND)
 					&& device_may_wakeup(dev))
@@ -89,22 +90,23 @@ int suspend_device(struct device * dev, 
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
 	}
+
 	up(&dev->sem);
 	return error;
 }
 
-
 /*
  * This is called with interrupts off, only a single CPU
  * running. We can't do down() on a semaphore (and we don't
  * need the protection)
  */
-static int suspend_device_late(struct device *dev, pm_message_t state)
+int suspend_device_late(struct dev_pm_info *dpm, pm_message_t state)
 {
 	int error = 0;
+	struct device *dev = container_of(dpm, struct device, power);
 
 	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
-		dev_dbg(dev, "LATE %s%s\n",
+		pm_dbg(dpm, "LATE %s%s\n",
 			suspend_verb(state.event),
 			((state.event == PM_EVENT_SUSPEND)
 					&& device_may_wakeup(dev))
@@ -139,34 +141,40 @@ static int suspend_device_late(struct de
 int device_suspend(pm_message_t state)
 {
 	int error = 0;
+	struct dev_pm_info *dpm;
 
 	might_sleep();
+
 	down(&dpm_sem);
 	down(&dpm_list_sem);
+
 	while (!list_empty(&dpm_active) && error == 0) {
-		struct list_head * entry = dpm_active.prev;
-		struct device * dev = to_device(entry);
 
-		get_device(dev);
+		dpm = list_entry(dpm_active.prev, struct dev_pm_info, entry);
+		kobject_get(dpm->pm_object);
+
 		up(&dpm_list_sem);
 
-		error = suspend_device(dev, state);
+		error = dpm->pm_ops->suspend(dpm, state);
 
 		down(&dpm_list_sem);
 
 		/* Check if the device got removed */
-		if (!list_empty(&dev->power.entry)) {
+		if (!list_empty(&dpm->entry)) {
 			/* Move it to the dpm_off list */
 			if (!error)
-				list_move(&dev->power.entry, &dpm_off);
+				list_move(&dpm->entry, &dpm_off);
 		}
+
 		if (error)
 			printk(KERN_ERR "Could not suspend device %s: "
 				"error %d%s\n",
-				kobject_name(&dev->kobj), error,
+				kobject_name(dpm->pm_object), error,
 				error == -EAGAIN ? " (please convert to suspend_late)" : "");
-		put_device(dev);
+
+		kobject_put(dpm->pm_object);
 	}
+
 	up(&dpm_list_sem);
 	if (error)
 		dpm_resume();
@@ -189,16 +197,19 @@ EXPORT_SYMBOL_GPL(device_suspend);
 int device_power_down(pm_message_t state)
 {
 	int error = 0;
-	struct device * dev;
+	struct dev_pm_info *dpm;
 
 	while (!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.prev;
 
-		dev = to_device(entry);
-		error = suspend_device_late(dev, state);
-		if (error)
-			goto Error;
-		list_move(&dev->power.entry, &dpm_off_irq);
+		dpm = list_entry(dpm_off.prev, struct dev_pm_info, entry);
+
+		if (dpm->pm_ops->suspend_late) {
+			error = dpm->pm_ops->suspend_late(dpm, state);
+			if (error)
+				goto Error;
+		}
+
+		list_move(&dpm->entry, &dpm_off_irq);
 	}
 
 	error = sysdev_suspend(state);
@@ -206,7 +217,7 @@ int device_power_down(pm_message_t state
 	return error;
  Error:
 	printk(KERN_ERR "Could not power down device %s: "
-		"error %d\n", kobject_name(&dev->kobj), error);
+		"error %d\n", kobject_name(dpm->pm_object), error);
 	dpm_power_up();
 	goto Done;
 }
Index: work/include/linux/pm.h
===================================================================
--- work.orig/include/linux/pm.h
+++ work/include/linux/pm.h
@@ -206,12 +206,21 @@ struct dev_pm_info {
 #ifdef	CONFIG_PM
 	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
-	void			* saved_state;
-	struct device		* pm_parent;
+	void			*saved_state;
+	struct kobject		*pm_object;
+	struct dev_pm_info	*pm_parent;
 	struct list_head	entry;
+	const struct dev_pm_ops	*pm_ops;
 #endif
 };
 
+struct dev_pm_ops {
+	int (*suspend)(struct dev_pm_info *dpm, pm_message_t state);
+	int (*suspend_late)(struct dev_pm_info *dpm, pm_message_t state);
+	int (*resume_early)(struct dev_pm_info *dpm);
+	int (*resume)(struct dev_pm_info *dpm);
+};
+
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
 extern int device_power_down(pm_message_t state);
@@ -229,8 +238,8 @@ extern int device_prepare_suspend(pm_mes
 #define device_may_wakeup(dev) \
 	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
 
-extern int dpm_runtime_suspend(struct device *, pm_message_t);
-extern void dpm_runtime_resume(struct device *);
+extern int dpm_runtime_suspend(struct dev_pm_info *, pm_message_t);
+extern void dpm_runtime_resume(struct dev_pm_info *);
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
 #define suspend_report_result(fn, ret)					\
@@ -248,12 +257,12 @@ static inline int device_suspend(pm_mess
 #define device_set_wakeup_enable(dev,val)	do{}while(0)
 #define device_may_wakeup(dev)			(0)
 
-static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
+static inline int dpm_runtime_suspend(struct dev_pm_indo *dpm, pm_message_t state)
 {
 	return 0;
 }
 
-static inline void dpm_runtime_resume(struct device * dev)
+static inline void dpm_runtime_resume(struct dev_pm_info *dpm)
 {
 }
 
Index: work/drivers/base/power/power.h
===================================================================
--- work.orig/drivers/base/power/power.h
+++ work/drivers/base/power/power.h
@@ -7,6 +7,23 @@ extern void device_shutdown(void);
 
 #ifdef CONFIG_PM
 
+#ifdef DEBUG
+#define pm_dbg(dpm, format, arg...)			\
+	printk(KERN_DEBUG "%s PM: " format,		\
+		kobject_name(dpm->pm_object), ## arg)
+#else
+#define pm_dbg(dpm, format, arg...) do { (void)(dpm); } while (0)
+#endif
+
+#define pm_err(dpm, format, arg...)			\
+	printk(KERN_ERR "%s PM: " format,		\
+		kobject_name(dpm->pm_object), ## arg)
+
+#define pm_info(dpm, format, arg...)			\
+	printk(KERN_INFO, "%s PM: " format,		\
+		kobject_name(dpm->pm_object), ## arg)
+
+
 /*
  * main.c
  */
@@ -55,12 +72,14 @@ extern void dpm_sysfs_remove(struct devi
 
 extern void dpm_resume(void);
 extern void dpm_power_up(void);
-extern int resume_device(struct device *);
+extern int resume_device(struct dev_pm_info *);
+extern int resume_device_early(struct dev_pm_info *);
 
 /*
  * suspend.c
  */
-extern int suspend_device(struct device *, pm_message_t);
+extern int suspend_device(struct dev_pm_info *, pm_message_t);
+extern int suspend_device_late(struct dev_pm_info *, pm_message_t);
 
 
 /*
Index: work/drivers/base/power/runtime.c
===================================================================
--- work.orig/drivers/base/power/runtime.c
+++ work/drivers/base/power/runtime.c
@@ -10,13 +10,15 @@
 #include "power.h"
 
 
-static void runtime_resume(struct device * dev)
+static void runtime_resume(struct dev_pm_info *dpm)
 {
-	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state.event)
+	pm_dbg(dpm, "resuming\n");
+
+	if (!dpm->power_state.event)
 		return;
-	if (!resume_device(dev))
-		dev->power.power_state = PMSG_ON;
+
+	if (dpm->pm_ops->resume(dpm) == 0)
+		dpm->power_state = PMSG_ON;
 }
 
 
@@ -30,10 +32,10 @@ static void runtime_resume(struct device
  *	FIXME: We need to handle devices that are in an unknown state.
  */
 
-void dpm_runtime_resume(struct device * dev)
+void dpm_runtime_resume(struct dev_pm_info *dpm)
 {
 	down(&dpm_sem);
-	runtime_resume(dev);
+	runtime_resume(dpm);
 	up(&dpm_sem);
 }
 EXPORT_SYMBOL(dpm_runtime_resume);
@@ -45,19 +47,21 @@ EXPORT_SYMBOL(dpm_runtime_resume);
  *	@state:	State to enter.
  */
 
-int dpm_runtime_suspend(struct device * dev, pm_message_t state)
+int dpm_runtime_suspend(struct dev_pm_info *dpm, pm_message_t state)
 {
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state.event == state.event)
+
+	if (dpm->power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state.event)
-		runtime_resume(dev);
+	if (dpm->power_state.event)
+		runtime_resume(dpm);
 
-	if (!(error = suspend_device(dev, state)))
-		dev->power.power_state = state;
+	error = dpm->pm_ops->suspend(dpm, state);
+	if (!error)
+		dpm->power_state = state;
  Done:
 	up(&dpm_sem);
 	return error;
Index: work/drivers/pcmcia/ds.c
===================================================================
--- work.orig/drivers/pcmcia/ds.c
+++ work/drivers/pcmcia/ds.c
@@ -968,9 +968,9 @@ static ssize_t pcmcia_store_pm_state(str
                 return -EINVAL;
 
 	if ((!p_dev->suspended) && !strncmp(buf, "off", 3))
-		ret = dpm_runtime_suspend(dev, PMSG_SUSPEND);
+		ret = dpm_runtime_suspend(&dev->power, PMSG_SUSPEND);
 	else if (p_dev->suspended && !strncmp(buf, "on", 2))
-		dpm_runtime_resume(dev);
+		dpm_runtime_resume(&dev->power);
 
 	return ret ? ret : count;
 }
@@ -1095,7 +1095,7 @@ static int pcmcia_bus_suspend_callback(s
 	if (p_dev->socket != skt)
 		return 0;
 
-	return dpm_runtime_suspend(dev, PMSG_SUSPEND);
+	return dpm_runtime_suspend(&dev->power, PMSG_SUSPEND);
 }
 
 static int pcmcia_bus_resume_callback(struct device *dev, void * _data)
@@ -1106,7 +1106,7 @@ static int pcmcia_bus_resume_callback(st
 	if (p_dev->socket != skt)
 		return 0;
 
-	dpm_runtime_resume(dev);
+	dpm_runtime_resume(&dev->power);
 
 	return 0;
 }
Index: work/drivers/base/power/trace.c
===================================================================
--- work.orig/drivers/base/power/trace.c
+++ work/drivers/base/power/trace.c
@@ -138,9 +138,10 @@ static unsigned int hash_string(unsigned
 	return seed % mod;
 }
 
-void set_trace_device(struct device *dev)
+void set_trace_device(struct dev_pm_info *dpm)
 {
-	dev_hash_value = hash_string(DEVSEED, dev->bus_id, DEVHASH);
+	dev_hash_value = hash_string(DEVSEED, kobject_name(dpm->pm_object),
+				     DEVHASH);
 }
 
 /*
@@ -185,13 +186,17 @@ static int show_file_hash(unsigned int v
 static int show_dev_hash(unsigned int value)
 {
 	int match = 0;
-	struct list_head * entry = dpm_active.prev;
+	struct list_head *entry = dpm_active.prev;
+	struct dev_pm_info *dpm;
+	unsigned int hash;
 
 	while (entry != &dpm_active) {
-		struct device * dev = to_device(entry);
-		unsigned int hash = hash_string(DEVSEED, dev->bus_id, DEVHASH);
+		dpm = container_of(entry, struct dev_pm_info, entry);
+		hash = hash_string(DEVSEED, kobject_name(dpm->pm_object),
+				   DEVHASH);
 		if (hash == value) {
-			printk("  hash matches device %s\n", dev->bus_id);
+			printk("  hash matches device %s\n",
+				kobject_name(dpm->pm_object));
 			match++;
 		}
 		entry = entry->prev;
Index: work/include/linux/resume-trace.h
===================================================================
--- work.orig/include/linux/resume-trace.h
+++ work/include/linux/resume-trace.h
@@ -5,11 +5,11 @@
 
 extern int pm_trace_enabled;
 
-struct device;
-extern void set_trace_device(struct device *);
+struct dev_pm_info;
+extern void set_trace_device(struct dev_pm_info *);
 extern void generate_resume_trace(void *tracedata, unsigned int user);
 
-#define TRACE_DEVICE(dev) set_trace_device(dev)
+#define TRACE_DEVICE(dpm) set_trace_device(dpm)
 #define TRACE_RESUME(user) do {					\
 	if (pm_trace_enabled) {					\
 		void *tracedata;				\
@@ -26,8 +26,8 @@ extern void generate_resume_trace(void *
 
 #else
 
-#define TRACE_DEVICE(dev) do { } while (0)
-#define TRACE_RESUME(dev) do { } while (0)
+#define TRACE_DEVICE(dpm) do { } while (0)
+#define TRACE_RESUME(user) do { } while (0)
 
 #endif
 
