Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVJDFlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVJDFlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJDFlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:41:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:40875 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932325AbVJDFlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:41:03 -0400
Subject: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 15:36:54 +1000
Message-Id: <1128404215.31063.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the actual thermal control support for PowerMac8,1, PowerMac8,2
and PowerMac9,1 machines (SMU based), that is iMac G5 and single CPU desktop.
It requires CPUFREQ to be enabled to properly deal with overtemp conditions.
The new thermal control code implements a new framework (nicknamed "windfarm")
to which I expect to port the old G5 thermal control, and possibly some of the
powerbook thermal control drivers as well in the future.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2005-10-04 15:17:21.000000000 +1000
+++ linux-work/drivers/macintosh/smu.c	2005-10-04 15:17:32.000000000 +1000
@@ -590,6 +590,8 @@
 			sprintf(name, "smu-i2c-%02x", *reg);
 			of_platform_device_create(np, name, &smu->of_dev->dev);
 		}
+		if (device_is_compatible(np, "smu-sensors"))
+			of_platform_device_create(np, "smu-sensors", &smu->of_dev->dev);
 	}
 
 }
Index: linux-work/drivers/macintosh/Kconfig
===================================================================
--- linux-work.orig/drivers/macintosh/Kconfig	2005-10-04 15:17:21.000000000 +1000
+++ linux-work/drivers/macintosh/Kconfig	2005-10-04 15:17:33.000000000 +1000
@@ -169,6 +169,16 @@
 	  This driver provides thermostat and fan control for the desktop
 	  G5 machines. 
 
+config WINDFARM
+	tristate "New PowerMac thermal control infrastructure"
+
+config WINDFARM_SMU
+	tristate "Support for thermal management on SMU based PowerMacs"
+	depends on WINDFARM && I2C && CPU_FREQ_PMAC && PMAC_SMU
+	select I2C_PMAC_SMU
+	help
+	  This driver provides thermal control for iMacG5 and newer
+
 config ANSLCD
 	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
Index: linux-work/drivers/macintosh/Makefile
===================================================================
--- linux-work.orig/drivers/macintosh/Makefile	2005-10-04 15:17:21.000000000 +1000
+++ linux-work/drivers/macintosh/Makefile	2005-10-04 15:17:33.000000000 +1000
@@ -26,3 +26,8 @@
 obj-$(CONFIG_THERM_PM72)	+= therm_pm72.o
 obj-$(CONFIG_THERM_WINDTUNNEL)	+= therm_windtunnel.o
 obj-$(CONFIG_THERM_ADT746X)	+= therm_adt746x.o
+obj-$(CONFIG_WINDFARM)	        += windfarm_core.o
+obj-$(CONFIG_WINDFARM_SMU)      += windfarm_smu_controls.o \
+				   windfarm_smu_sensors.o \
+				   windfarm_lm75_sensor.o windfarm_pid.o \
+				   windfarm_cpufreq_clamp.o windfarm_smu.o
Index: linux-work/drivers/macintosh/windfarm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm.h	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,122 @@
+#ifndef __WINDFARM_H__
+#define __WINDFARM_H__
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+
+/* Display a 16.16 fixed point value */
+#define FIX32TOPRINT(f)	((f) >> 16),((((f) & 0xffff) * 1000) >> 16)
+
+/*
+ * Control objects
+ */
+
+struct wf_control;
+
+struct wf_control_ops {
+	int			(*set_value)(struct wf_control *ct, s32 val);
+	int			(*get_value)(struct wf_control *ct, s32 *val);
+	s32			(*get_min)(struct wf_control *ct);
+	s32			(*get_max)(struct wf_control *ct);
+	void			(*release)(struct wf_control *ct);
+        struct module           *owner;
+};
+
+struct wf_control {
+	struct list_head	link;
+	struct wf_control_ops	*ops;
+	char			*name;
+	int			type;
+	struct kref		ref;
+};
+
+#define WF_CONTROL_TYPE_GENERIC		0
+#define WF_CONTROL_RPM_FAN		1
+#define WF_CONTROL_PWM_FAN		2
+
+
+/* Note about lifetime rules: wf_register_control() will initialize
+ * the kref and wf_unregister_control will decrement it, thus the
+ * object creating/disposing a given control shouldn't assume it
+ * still exists after wf_unregister_control has been called.
+ * wf_find_control will inc the refcount for you
+ */
+extern int wf_register_control(struct wf_control *ct);
+extern void wf_unregister_control(struct wf_control *ct);
+extern struct wf_control * wf_find_control(const char *name);
+extern int wf_get_control(struct wf_control *ct);
+extern void wf_put_control(struct wf_control *ct);
+
+static inline int wf_control_set_max(struct wf_control *ct)
+{
+	s32 vmax = ct->ops->get_max(ct);
+	return ct->ops->set_value(ct, vmax);
+}
+
+static inline int wf_control_set_min(struct wf_control *ct)
+{
+	s32 vmin = ct->ops->get_min(ct);
+	return ct->ops->set_value(ct, vmin);
+}
+
+/*
+ * Sensor objects
+ */
+
+struct wf_sensor;
+
+struct wf_sensor_ops {
+	int			(*get_value)(struct wf_sensor *sr, s32 *val);
+	void			(*release)(struct wf_sensor *sr);
+        struct module           *owner;
+};
+
+struct wf_sensor {
+	struct list_head	link;
+	struct wf_sensor_ops	*ops;
+	char			*name;
+	struct kref		ref;
+};
+
+/* Same lifetime rules as controls */
+extern int wf_register_sensor(struct wf_sensor *sr);
+extern void wf_unregister_sensor(struct wf_sensor *sr);
+extern struct wf_sensor * wf_find_sensor(const char *name);
+extern int wf_get_sensor(struct wf_sensor *sr);
+extern void wf_put_sensor(struct wf_sensor *sr);
+
+/* For use by clients. Note that we are a bit racy here since
+ * notifier_block doesn't have a module owner field. I may fix
+ * it one day ...
+ *
+ * LOCKING NOTE !
+ *
+ * All "events" except WF_EVENT_TICK are called with an internal mutex
+ * held which will deadlock if you call basically any core routine.
+ * So don't ! Just take note of the event and do your actual operations
+ * from the ticker.
+ *
+ */
+extern int wf_register_client(struct notifier_block *nb);
+extern int wf_unregister_client(struct notifier_block *nb);
+
+/* Overtemp conditions. Those are refcounted */
+extern void wf_set_overtemp(void);
+extern void wf_clear_overtemp(void);
+extern int wf_is_overtemp(void);
+
+#define WF_EVENT_NEW_CONTROL	0 /* param is wf_control * */
+#define WF_EVENT_NEW_SENSOR	1 /* param is wf_sensor * */
+#define WF_EVENT_OVERTEMP	2 /* no param */
+#define WF_EVENT_NORMALTEMP	3 /* overtemp condition cleared */
+#define WF_EVENT_TICK		4 /* 1 second tick */
+
+/* Note: If that driver gets more broad use, we could replace the
+ * simplistic overtemp bits with "environmental conditions". That
+ * could then be used to also notify of things like fan failure,
+ * case open, battery conditions, ...
+ */
+
+#endif /* __WINDFARM_H__ */
Index: linux-work/drivers/macintosh/windfarm_core.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_core.c	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,428 @@
+/*
+ * Windfarm PowerMac thermal control. Core
+ *
+ * (c) Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ *
+ * This core code tracks the list of sensors & controls, register
+ * clients, and holds the kernel thread used for control.
+ *
+ * TODO:
+ *
+ * Add some information about sensor/control type and data format to
+ * sensors/controls, and have the sysfs attribute stuff be moved
+ * generically here instead of hard coded in the platform specific
+ * driver as it us currently
+ *
+ * This however requires solving some annoying lifetime issues with
+ * sysfs which doesn't seem to have lifetime rules for struct attribute,
+ * I may have to create full features kobjects for every sensor/control
+ * instead which is a bit of an overkill imho
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
+#include <linux/reboot.h>
+#include <linux/device.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.2"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+static LIST_HEAD(wf_controls);
+static LIST_HEAD(wf_sensors);
+static DECLARE_MUTEX(wf_lock);
+static struct notifier_block *wf_client_list;
+static int wf_client_count;
+static unsigned int wf_overtemp;
+static unsigned int wf_overtemp_counter;
+struct task_struct *wf_thread;
+
+/*
+ * Utilities & tick thread
+ */
+
+static inline void wf_notify(int event, void *param)
+{
+	notifier_call_chain(&wf_client_list, event, param);
+}
+
+int wf_critical_overtemp(void)
+{
+	static char * critical_overtemp_path = "/sbin/critical_overtemp";
+	char *argv[] = { critical_overtemp_path, NULL };
+	static char *envp[] = { "HOME=/",
+				"TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+				NULL };
+
+	return call_usermodehelper(critical_overtemp_path, argv, envp, 0);
+}
+EXPORT_SYMBOL_GPL(wf_critical_overtemp);
+
+static int wf_thread_func(void *data)
+{
+	unsigned long next, delay;
+
+	next = jiffies;
+
+	DBG("wf: thread started\n");
+
+	while(!kthread_should_stop()) {
+		try_to_freeze();
+
+		if (time_after_eq(jiffies, next)) {
+			wf_notify(WF_EVENT_TICK, NULL);
+			if (wf_overtemp) {
+				wf_overtemp_counter++;
+				/* 10 seconds overtemp, notify userland */
+				if (wf_overtemp_counter > 10)
+					wf_critical_overtemp();
+				/* 30 seconds, shutdown */
+				if (wf_overtemp_counter > 30) {
+					printk(KERN_ERR "windfarm: Overtemp "
+					       "for more than 30"
+					       " seconds, shutting down\n");
+					machine_power_off();
+				}
+			}
+			next += HZ;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		delay = next - jiffies;
+		if (delay <= HZ)
+			schedule_timeout(delay);
+		set_current_state(TASK_RUNNING);
+
+		/* there should be no signal, but oh well */
+		if (signal_pending(current)) {
+			printk(KERN_WARNING "windfarm: thread got sigl !\n");
+			break;
+		}
+	}
+
+	DBG("wf: thread stopped\n");
+
+	return 0;
+}
+
+static void wf_start_thread(void)
+{
+	wf_thread = kthread_run(wf_thread_func, NULL, "kwindfarm");
+	if (IS_ERR(wf_thread)) {
+		printk(KERN_ERR "windfarm: failed to create thread,err %ld\n",
+		       PTR_ERR(wf_thread));
+		wf_thread = NULL;
+	}
+}
+
+
+static void wf_stop_thread(void)
+{
+	if (wf_thread)
+		kthread_stop(wf_thread);
+	wf_thread = NULL;
+}
+
+/*
+ * Controls
+ */
+
+static void wf_control_release(struct kref *kref)
+{
+	struct wf_control *ct = container_of(kref, struct wf_control, ref);
+
+	DBG("wf: Deleting control %s\n", ct->name);
+
+	if (ct->ops && ct->ops->release)
+		ct->ops->release(ct);
+	else
+		kfree(ct);
+}
+
+int wf_register_control(struct wf_control *new_ct)
+{
+	struct wf_control *ct;
+
+	down(&wf_lock);
+	list_for_each_entry(ct, &wf_controls, link) {
+		if (!strcmp(ct->name, new_ct->name)) {
+			printk(KERN_WARNING "windfarm: trying to register"
+			       " duplicate control %s\n", ct->name);
+			up(&wf_lock);
+			return -EEXIST;
+		}
+	}
+	kref_init(&new_ct->ref);
+	list_add(&new_ct->link, &wf_controls);
+
+	DBG("wf: Registered control %s\n", new_ct->name);
+
+	wf_notify(WF_EVENT_NEW_CONTROL, new_ct);
+	up(&wf_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wf_register_control);
+
+void wf_unregister_control(struct wf_control *ct)
+{
+	down(&wf_lock);
+	list_del(&ct->link);
+	up(&wf_lock);
+
+	DBG("wf: Unregistered control %s\n", ct->name);
+
+	kref_put(&ct->ref, wf_control_release);
+}
+EXPORT_SYMBOL_GPL(wf_unregister_control);
+
+struct wf_control * wf_find_control(const char *name)
+{
+	struct wf_control *ct;
+
+	down(&wf_lock);
+	list_for_each_entry(ct, &wf_controls, link) {
+		if (!strcmp(ct->name, name)) {
+			if (wf_get_control(ct))
+				ct = NULL;
+			up(&wf_lock);
+			return ct;
+		}
+	}
+	up(&wf_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(wf_find_control);
+
+int wf_get_control(struct wf_control *ct)
+{
+	if (!try_module_get(ct->ops->owner))
+		return -ENODEV;
+	kref_get(&ct->ref);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wf_get_control);
+
+void wf_put_control(struct wf_control *ct)
+{
+	struct module *mod = ct->ops->owner;
+	kref_put(&ct->ref, wf_control_release);
+	module_put(mod);
+}
+EXPORT_SYMBOL_GPL(wf_put_control);
+
+
+/*
+ * Sensors
+ */
+
+
+static void wf_sensor_release(struct kref *kref)
+{
+	struct wf_sensor *sr = container_of(kref, struct wf_sensor, ref);
+
+	DBG("wf: Deleting sensor %s\n", sr->name);
+
+	if (sr->ops && sr->ops->release)
+		sr->ops->release(sr);
+	else
+		kfree(sr);
+}
+
+int wf_register_sensor(struct wf_sensor *new_sr)
+{
+	struct wf_sensor *sr;
+
+	down(&wf_lock);
+	list_for_each_entry(sr, &wf_sensors, link) {
+		if (!strcmp(sr->name, new_sr->name)) {
+			printk(KERN_WARNING "windfarm: trying to register"
+			       " duplicate sensor %s\n", sr->name);
+			up(&wf_lock);
+			return -EEXIST;
+		}
+	}
+	kref_init(&new_sr->ref);
+	list_add(&new_sr->link, &wf_sensors);
+
+	DBG("wf: Registered sensor %s\n", new_sr->name);
+
+	wf_notify(WF_EVENT_NEW_SENSOR, new_sr);
+	up(&wf_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wf_register_sensor);
+
+void wf_unregister_sensor(struct wf_sensor *sr)
+{
+	down(&wf_lock);
+	list_del(&sr->link);
+	up(&wf_lock);
+
+	DBG("wf: Unregistered sensor %s\n", sr->name);
+
+	wf_put_sensor(sr);
+}
+EXPORT_SYMBOL_GPL(wf_unregister_sensor);
+
+struct wf_sensor * wf_find_sensor(const char *name)
+{
+	struct wf_sensor *sr;
+
+	down(&wf_lock);
+	list_for_each_entry(sr, &wf_sensors, link) {
+		if (!strcmp(sr->name, name)) {
+			if (wf_get_sensor(sr))
+				sr = NULL;
+			up(&wf_lock);
+			return sr;
+		}
+	}
+	up(&wf_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(wf_find_sensor);
+
+int wf_get_sensor(struct wf_sensor *sr)
+{
+	if (!try_module_get(sr->ops->owner))
+		return -ENODEV;
+	kref_get(&sr->ref);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wf_get_sensor);
+
+void wf_put_sensor(struct wf_sensor *sr)
+{
+	struct module *mod = sr->ops->owner;
+	kref_put(&sr->ref, wf_sensor_release);
+	module_put(mod);
+}
+EXPORT_SYMBOL_GPL(wf_put_sensor);
+
+
+/*
+ * Client & notification
+ */
+
+int wf_register_client(struct notifier_block *nb)
+{
+	int rc;
+	struct wf_control *ct;
+	struct wf_sensor *sr;
+
+	down(&wf_lock);
+	rc = notifier_chain_register(&wf_client_list, nb);
+	if (rc != 0)
+		goto bail;
+	wf_client_count++;
+	list_for_each_entry(ct, &wf_controls, link)
+		wf_notify(WF_EVENT_NEW_CONTROL, ct);
+	list_for_each_entry(sr, &wf_sensors, link)
+		wf_notify(WF_EVENT_NEW_SENSOR, sr);
+	if (wf_client_count == 1)
+		wf_start_thread();
+	up(&wf_lock);
+ bail:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(wf_register_client);
+
+int wf_unregister_client(struct notifier_block *nb)
+{
+	down(&wf_lock);
+	notifier_chain_unregister(&wf_client_list, nb);
+	wf_client_count++;
+	if (wf_client_count == 0)
+		wf_stop_thread();
+	up(&wf_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wf_unregister_client);
+
+void wf_set_overtemp(void)
+{
+	down(&wf_lock);
+	wf_overtemp++;
+	if (wf_overtemp == 1) {
+		printk(KERN_WARNING "windfarm: Overtemp condition detected !\n");
+		wf_overtemp_counter = 0;
+		wf_notify(WF_EVENT_OVERTEMP, NULL);
+	}
+	up(&wf_lock);
+}
+EXPORT_SYMBOL_GPL(wf_set_overtemp);
+
+void wf_clear_overtemp(void)
+{
+	down(&wf_lock);
+	WARN_ON(wf_overtemp == 0);
+	if (wf_overtemp == 0) {
+		up(&wf_lock);
+		return;
+	}
+	wf_overtemp--;
+	if (wf_overtemp == 0) {
+		printk(KERN_WARNING "windfarm: Overtemp condition cleared !\n");
+		wf_notify(WF_EVENT_NORMALTEMP, NULL);
+	}
+	up(&wf_lock);
+}
+EXPORT_SYMBOL_GPL(wf_clear_overtemp);
+
+int wf_is_overtemp(void)
+{
+	return (wf_overtemp != 0);
+}
+EXPORT_SYMBOL_GPL(wf_is_overtemp);
+
+static struct platform_device wf_platform_device = {
+	.name	= "windfarm",
+};
+
+static int __init windfarm_core_init(void)
+{
+	DBG("wf: core loaded\n");
+
+	platform_device_register(&wf_platform_device);
+	return 0;
+}
+
+static void __exit windfarm_core_exit(void)
+{
+	BUG_ON(wf_client_count != 0);
+
+	DBG("wf: core unloaded\n");
+
+	platform_device_unregister(&wf_platform_device);
+}
+
+
+module_init(windfarm_core_init);
+module_exit(windfarm_core_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("Core component of PowerMac thermal control");
+MODULE_LICENSE("GPL");
+
Index: linux-work/drivers/macintosh/windfarm_smu_controls.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_smu_controls.c	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,274 @@
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/smu.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.3"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+/*
+ * SMU fans control object
+ */
+
+static LIST_HEAD(smu_fans);
+
+struct smu_fan_control {
+	struct list_head	link;
+	int    			fan_type;	/* 0 = rpm, 1 = pwm */
+	u32			reg;		/* index in SMU */
+	s32			value;		/* current value */
+	s32			min, max;	/* min/max values */
+	struct wf_control	ctrl;
+};
+#define to_smu_fan(c) container_of(c, struct smu_fan_control, ctrl)
+
+static int smu_set_fan(int pwm, u8 id, u16 value)
+{
+	struct smu_cmd cmd;
+	u8 buffer[16];
+	DECLARE_COMPLETION(comp);
+	int rc;
+
+	/* Fill SMU command structure */
+	cmd.cmd = SMU_CMD_FAN_COMMAND;
+	cmd.data_len = 14;
+	cmd.reply_len = 16;
+	cmd.data_buf = cmd.reply_buf = buffer;
+	cmd.status = 0;
+	cmd.done = smu_done_complete;
+	cmd.misc = &comp;
+
+	/* Fill argument buffer */
+	memset(buffer, 0, 16);
+	buffer[0] = pwm ? 0x10 : 0x00;
+	buffer[1] = 0x01 << id;
+	*((u16 *)&buffer[2 + id * 2]) = value;
+
+	rc = smu_queue_cmd(&cmd);
+	if (rc)
+		return rc;
+	wait_for_completion(&comp);
+	return cmd.status;
+}
+
+static void smu_fan_release(struct wf_control *ct)
+{
+	struct smu_fan_control *fct = to_smu_fan(ct);
+
+	kfree(fct);
+}
+
+static int smu_fan_set(struct wf_control *ct, s32 value)
+{
+	struct smu_fan_control *fct = to_smu_fan(ct);
+
+	if (value < fct->min)
+		value = fct->min;
+	if (value > fct->max)
+		value = fct->max;
+	fct->value = value;
+
+	return smu_set_fan(fct->fan_type, fct->reg, value);
+}
+
+static int smu_fan_get(struct wf_control *ct, s32 *value)
+{
+	struct smu_fan_control *fct = to_smu_fan(ct);
+	*value = fct->value; /* todo: read from SMU */
+	return 0;
+}
+
+static s32 smu_fan_min(struct wf_control *ct)
+{
+	struct smu_fan_control *fct = to_smu_fan(ct);
+	return fct->min;
+}
+
+static s32 smu_fan_max(struct wf_control *ct)
+{
+	struct smu_fan_control *fct = to_smu_fan(ct);
+	return fct->max;
+}
+
+static struct wf_control_ops smu_fan_ops = {
+	.set_value	= smu_fan_set,
+	.get_value	= smu_fan_get,
+	.get_min	= smu_fan_min,
+	.get_max	= smu_fan_max,
+	.release	= smu_fan_release,
+	.owner		= THIS_MODULE,
+};
+
+static struct smu_fan_control *smu_fan_create(struct device_node *node,
+					      int pwm_fan)
+{
+	struct smu_fan_control *fct;
+	s32 *v; u32 *reg;
+	char *l;
+
+	fct = kmalloc(sizeof(struct smu_fan_control), GFP_KERNEL);
+	if (fct == NULL)
+		return NULL;
+	fct->ctrl.ops = &smu_fan_ops;
+	l = (char *)get_property(node, "location", NULL);
+	if (l == NULL)
+		goto fail;
+
+	fct->fan_type = pwm_fan;
+	fct->ctrl.type = pwm_fan ? WF_CONTROL_PWM_FAN : WF_CONTROL_RPM_FAN;
+
+	/* We use the name & location here the same way we do for SMU sensors,
+	 * see the comment in windfarm_smu_sensors.c. The locations are a bit
+	 * less consistent here between the iMac and the desktop models, but
+	 * that is good enough for our needs for now at least.
+	 *
+	 * One problem though is that Apple seem to be inconsistent with case
+	 * and the kernel doesn't have strcasecmp =P
+	 */
+
+	fct->ctrl.name = NULL;
+
+	/* Names used on desktop models */
+	if (!strcmp(l, "Rear Fan 0") || !strcmp(l, "Rear Fan") ||
+	    !strcmp(l, "Rear fan 0") || !strcmp(l, "Rear fan"))
+		fct->ctrl.name = "cpu-rear-fan-0";
+	else if (!strcmp(l, "Rear Fan 1") || !strcmp(l, "Rear fan 1"))
+		fct->ctrl.name = "cpu-rear-fan-1";
+	else if (!strcmp(l, "Front Fan 0") || !strcmp(l, "Front Fan") ||
+		 !strcmp(l, "Front fan 0") || !strcmp(l, "Front fan"))
+		fct->ctrl.name = "cpu-front-fan-0";
+	else if (!strcmp(l, "Front Fan 1") || !strcmp(l, "Front fan 1"))
+		fct->ctrl.name = "cpu-front-fan-1";
+	else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan"))
+		fct->ctrl.name = "slots-fan";
+	else if (!strcmp(l, "Drive Bay") || !strcmp(l, "Drive bay"))
+		fct->ctrl.name = "drive-bay-fan";
+
+	/* Names used on iMac models */
+	if (!strcmp(l, "System Fan") || !strcmp(l, "System fan"))
+		fct->ctrl.name = "system-fan";
+	else if (!strcmp(l, "CPU Fan") || !strcmp(l, "CPU fan"))
+		fct->ctrl.name = "cpu-fan";
+	else if (!strcmp(l, "Hard Drive") || !strcmp(l, "Hard drive"))
+		fct->ctrl.name = "drive-bay-fan";
+
+	/* Unrecognized fan, bail out */
+	if (fct->ctrl.name == NULL)
+		goto fail;
+
+	/* Get min & max values*/
+	v = (s32 *)get_property(node, "min-value", NULL);
+	if (v == NULL)
+		goto fail;
+	fct->min = *v;
+	v = (s32 *)get_property(node, "max-value", NULL);
+	if (v == NULL)
+		goto fail;
+	fct->max = *v;
+
+	/* Get "reg" value */
+	reg = (u32 *)get_property(node, "reg", NULL);
+	if (reg == NULL)
+		goto fail;
+	fct->reg = *reg;
+
+	if (wf_register_control(&fct->ctrl))
+		goto fail;
+
+	return fct;
+ fail:
+	kfree(fct);
+	return NULL;
+}
+
+
+static int __init smu_controls_init(void)
+{
+	struct device_node *smu, *fans, *fan;
+
+	if (!smu_present())
+		return -ENODEV;
+
+	smu = of_find_node_by_type(NULL, "smu");
+	if (smu == NULL)
+		return -ENODEV;
+
+	/* Look for RPM fans */
+	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
+		if (!strcmp(fans->name, "rpm-fans"))
+			break;
+	for (fan = NULL;
+	     fans && (fan = of_get_next_child(fans, fan)) != NULL;) {
+		struct smu_fan_control *fct;
+
+		fct = smu_fan_create(fan, 0);
+		if (fct == NULL) {
+			printk(KERN_WARNING "windfarm: Failed to create SMU "
+			       "RPM fan %s\n", fan->name);
+			continue;
+		}
+		list_add(&fct->link, &smu_fans);
+	}
+	of_node_put(fans);
+
+
+	/* Look for PWM fans */
+	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
+		if (!strcmp(fans->name, "pwm-fans"))
+			break;
+	for (fan = NULL;
+	     fans && (fan = of_get_next_child(fans, fan)) != NULL;) {
+		struct smu_fan_control *fct;
+
+		fct = smu_fan_create(fan, 1);
+		if (fct == NULL) {
+			printk(KERN_WARNING "windfarm: Failed to create SMU "
+			       "PWM fan %s\n", fan->name);
+			continue;
+		}
+		list_add(&fct->link, &smu_fans);
+	}
+	of_node_put(fans);
+	of_node_put(smu);
+
+	return 0;
+}
+
+static void __exit smu_controls_exit(void)
+{
+	struct smu_fan_control *fct;
+
+	while (!list_empty(&smu_fans)) {
+		fct = list_entry(smu_fans.next, struct smu_fan_control, link);
+		list_del(&fct->link);
+		wf_unregister_control(&fct->ctrl);
+	}
+}
+
+
+module_init(smu_controls_init);
+module_exit(smu_controls_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("SMU control objects for PowerMacs thermal control");
+MODULE_LICENSE("GPL");
+
Index: linux-work/drivers/macintosh/windfarm_smu_sensors.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_smu_sensors.c	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,471 @@
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/smu.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.2"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+/*
+ * Various SMU "partitions" calibration objects for which we
+ * keep pointers here for use by bits & pieces of the driver
+ */
+static struct smu_sdbp_cpuvcp *cpuvcp;
+static int  cpuvcp_version;
+static struct smu_sdbp_cpudiode *cpudiode;
+static struct smu_sdbp_slotspow *slotspow;
+static u8 *debugswitches;
+
+/*
+ * SMU basic sensors objects
+ */
+
+static LIST_HEAD(smu_ads);
+
+struct smu_ad_sensor {
+	struct list_head	link;
+	u32			reg;		/* index in SMU */
+	struct wf_sensor	sens;
+};
+#define to_smu_ads(c) container_of(c, struct smu_ad_sensor, sens)
+
+static void smu_ads_release(struct wf_sensor *sr)
+{
+	struct smu_ad_sensor *ads = to_smu_ads(sr);
+
+	kfree(ads);
+}
+
+static int smu_read_adc(u8 id, s32 *value)
+{
+	struct smu_simple_cmd	cmd;
+	DECLARE_COMPLETION(comp);
+	int rc;
+
+	rc = smu_queue_simple(&cmd, SMU_CMD_READ_ADC, 1,
+			      smu_done_complete, &comp, id);
+	if (rc)
+		return rc;
+	wait_for_completion(&comp);
+	if (cmd.cmd.status != 0)
+		return cmd.cmd.status;
+	if (cmd.cmd.reply_len != 2) {
+		printk(KERN_ERR "winfarm: read ADC 0x%x returned %d bytes !\n",
+		       id, cmd.cmd.reply_len);
+		return -EIO;
+	}
+	*value = *((u16 *)cmd.buffer);
+	return 0;
+}
+
+static int smu_cputemp_get(struct wf_sensor *sr, s32 *value)
+{
+	struct smu_ad_sensor *ads = to_smu_ads(sr);
+	int rc;
+	s32 val;
+	s64 scaled;
+
+	rc = smu_read_adc(ads->reg, &val);
+	if (rc) {
+		printk(KERN_ERR "windfarm: read CPU temp failed, err %d\n",
+		       rc);
+		return rc;
+	}
+
+	/* Ok, we have to scale & adjust, taking units into account */
+	scaled = (s64)(((u64)val) * (u64)cpudiode->m_value);
+	scaled >>= 3;
+	scaled += ((s64)cpudiode->b_value) << 9;
+	*value = (s32)(scaled << 1);
+
+	return 0;
+}
+
+static int smu_cpuamp_get(struct wf_sensor *sr, s32 *value)
+{
+	struct smu_ad_sensor *ads = to_smu_ads(sr);
+	s32 val, scaled;
+	int rc;
+
+	rc = smu_read_adc(ads->reg, &val);
+	if (rc) {
+		printk(KERN_ERR "windfarm: read CPU current failed, err %d\n",
+		       rc);
+		return rc;
+	}
+
+	/* Ok, we have to scale & adjust, taking units into account */
+	scaled = (s32)(val * (u32)cpuvcp->curr_scale);
+	scaled += (s32)cpuvcp->curr_offset;
+	*value = scaled << 4;
+
+	return 0;
+}
+
+static int smu_cpuvolt_get(struct wf_sensor *sr, s32 *value)
+{
+	struct smu_ad_sensor *ads = to_smu_ads(sr);
+	s32 val, scaled;
+	int rc;
+
+	rc = smu_read_adc(ads->reg, &val);
+	if (rc) {
+		printk(KERN_ERR "windfarm: read CPU voltage failed, err %d\n",
+		       rc);
+		return rc;
+	}
+
+	/* Ok, we have to scale & adjust, taking units into account */
+	scaled = (s32)(val * (u32)cpuvcp->volt_scale);
+	scaled += (s32)cpuvcp->volt_offset;
+	*value = scaled << 4;
+
+	return 0;
+}
+
+static int smu_slotspow_get(struct wf_sensor *sr, s32 *value)
+{
+	struct smu_ad_sensor *ads = to_smu_ads(sr);
+	s32 val, scaled;
+	int rc;
+
+	rc = smu_read_adc(ads->reg, &val);
+	if (rc) {
+		printk(KERN_ERR "windfarm: read slots power failed, err %d\n",
+		       rc);
+		return rc;
+	}
+
+	/* Ok, we have to scale & adjust, taking units into account */
+	scaled = (s32)(val * (u32)slotspow->pow_scale);
+	scaled += (s32)slotspow->pow_offset;
+	*value = scaled << 4;
+
+	return 0;
+}
+
+
+static struct wf_sensor_ops smu_cputemp_ops = {
+	.get_value	= smu_cputemp_get,
+	.release	= smu_ads_release,
+	.owner		= THIS_MODULE,
+};
+static struct wf_sensor_ops smu_cpuamp_ops = {
+	.get_value	= smu_cpuamp_get,
+	.release	= smu_ads_release,
+	.owner		= THIS_MODULE,
+};
+static struct wf_sensor_ops smu_cpuvolt_ops = {
+	.get_value	= smu_cpuvolt_get,
+	.release	= smu_ads_release,
+	.owner		= THIS_MODULE,
+};
+static struct wf_sensor_ops smu_slotspow_ops = {
+	.get_value	= smu_slotspow_get,
+	.release	= smu_ads_release,
+	.owner		= THIS_MODULE,
+};
+
+
+static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
+{
+	struct smu_ad_sensor *ads;
+	char *c, *l;
+	u32 *v;
+
+	ads = kmalloc(sizeof(struct smu_ad_sensor), GFP_KERNEL);
+	if (ads == NULL)
+		return NULL;
+	c = (char *)get_property(node, "device_type", NULL);
+	l = (char *)get_property(node, "location", NULL);
+	if (c == NULL || l == NULL)
+		goto fail;
+
+	/* We currently pick the sensors based on the OF name and location
+	 * properties, while Darwin uses the sensor-id's.
+	 * The problem with the IDs is that they are model specific while it
+	 * looks like apple has been doing a reasonably good job at keeping
+	 * the names and locations consistents so I'll stick with the names
+	 * and locations for now.
+	 */
+	if (!strcmp(c, "temp-sensor") &&
+	    !strcmp(l, "CPU T-Diode")) {
+		ads->sens.ops = &smu_cputemp_ops;
+		ads->sens.name = "cpu-temp";
+	} else if (!strcmp(c, "current-sensor") &&
+		   !strcmp(l, "CPU Current")) {
+		ads->sens.ops = &smu_cpuamp_ops;
+		ads->sens.name = "cpu-current";
+	} else if (!strcmp(c, "voltage-sensor") &&
+		   !strcmp(l, "CPU Voltage")) {
+		ads->sens.ops = &smu_cpuvolt_ops;
+		ads->sens.name = "cpu-voltage";
+	} else if (!strcmp(c, "power-sensor") &&
+		   !strcmp(l, "Slots Power")) {
+		ads->sens.ops = &smu_slotspow_ops;
+		ads->sens.name = "slots-power";
+		if (slotspow == NULL) {
+			DBG("wf: slotspow partition (%02x) not found\n",
+			    SMU_SDB_SLOTSPOW_ID);
+			goto fail;
+		}
+	} else
+		goto fail;
+
+	v = (u32 *)get_property(node, "reg", NULL);
+	if (v == NULL)
+		goto fail;
+	ads->reg = *v;
+
+	if (wf_register_sensor(&ads->sens))
+		goto fail;
+	return ads;
+ fail:
+	kfree(ads);
+	return NULL;
+}
+
+/*
+ * SMU Power combo sensor object
+ */
+
+struct smu_cpu_power_sensor {
+	struct list_head	link;
+	struct wf_sensor	*volts;
+	struct wf_sensor	*amps;
+	int			fake_volts : 1;
+	int			quadratic : 1;
+	struct wf_sensor	sens;
+};
+#define to_smu_cpu_power(c) container_of(c, struct smu_cpu_power_sensor, sens)
+
+static struct smu_cpu_power_sensor *smu_cpu_power;
+
+static void smu_cpu_power_release(struct wf_sensor *sr)
+{
+	struct smu_cpu_power_sensor *pow = to_smu_cpu_power(sr);
+
+	if (pow->volts)
+		wf_put_sensor(pow->volts);
+	if (pow->amps)
+		wf_put_sensor(pow->amps);
+	kfree(pow);
+}
+
+static int smu_cpu_power_get(struct wf_sensor *sr, s32 *value)
+{
+	struct smu_cpu_power_sensor *pow = to_smu_cpu_power(sr);
+	s32 volts, amps, power;
+	u64 tmps, tmpa, tmpb;
+	int rc;
+
+	rc = pow->amps->ops->get_value(pow->amps, &amps);
+	if (rc)
+		return rc;
+
+	if (pow->fake_volts) {
+		*value = amps * 12 - 0x30000;
+		return 0;
+	}
+
+	rc = pow->volts->ops->get_value(pow->volts, &volts);
+	if (rc)
+		return rc;
+
+	power = (s32)((((u64)volts) * ((u64)amps)) >> 16);
+	if (!pow->quadratic) {
+		*value = power;
+		return 0;
+	}
+	tmps = (((u64)power) * ((u64)power)) >> 16;
+	tmpa = ((u64)cpuvcp->power_quads[0]) * tmps;
+	tmpb = ((u64)cpuvcp->power_quads[1]) * ((u64)power);
+	*value = (tmpa >> 28) + (tmpb >> 28) + (cpuvcp->power_quads[2] >> 12);
+
+	return 0;
+}
+
+static struct wf_sensor_ops smu_cpu_power_ops = {
+	.get_value	= smu_cpu_power_get,
+	.release	= smu_cpu_power_release,
+	.owner		= THIS_MODULE,
+};
+
+
+static struct smu_cpu_power_sensor *
+smu_cpu_power_create(struct wf_sensor *volts, struct wf_sensor *amps)
+{
+	struct smu_cpu_power_sensor *pow;
+
+	pow = kmalloc(sizeof(struct smu_cpu_power_sensor), GFP_KERNEL);
+	if (pow == NULL)
+		return NULL;
+	pow->sens.ops = &smu_cpu_power_ops;
+	pow->sens.name = "cpu-power";
+
+	wf_get_sensor(volts);
+	pow->volts = volts;
+	wf_get_sensor(amps);
+	pow->amps = amps;
+
+	/* Some early machines need a faked voltage */
+	if (debugswitches && ((*debugswitches) & 0x80)) {
+		printk(KERN_INFO "windfarm: CPU Power sensor using faked"
+		       " voltage !\n");
+		pow->fake_volts = 1;
+	} else
+		pow->fake_volts = 0;
+
+	/* Try to use quadratic transforms on PowerMac8,1 and 9,1 for now,
+	 * I yet have to figure out what's up with 8,2 and will have to
+	 * adjust for later, unless we can 100% trust the SDB partition...
+	 */
+	if ((machine_is_compatible("PowerMac8,1") ||
+	     machine_is_compatible("PowerMac8,2") ||
+	     machine_is_compatible("PowerMac9,1")) &&
+	    cpuvcp_version >= 2) {
+		pow->quadratic = 1;
+		DBG("windfarm: CPU Power using quadratic transform\n");
+	} else
+		pow->quadratic = 0;
+
+	if (wf_register_sensor(&pow->sens))
+		goto fail;
+	return pow;
+ fail:
+	kfree(pow);
+	return NULL;
+}
+
+static int smu_fetch_param_partitions(void)
+{
+	struct smu_sdbp_header *hdr;
+
+	/* Get CPU voltage/current/power calibration data */
+	hdr = smu_get_sdb_partition(SMU_SDB_CPUVCP_ID, NULL);
+	if (hdr == NULL) {
+		DBG("wf: cpuvcp partition (%02x) not found\n",
+		    SMU_SDB_CPUVCP_ID);
+		return -ENODEV;
+	}
+	cpuvcp = (struct smu_sdbp_cpuvcp *)&hdr[1];
+	/* Keep version around */
+	cpuvcp_version = hdr->version;
+
+	/* Get CPU diode calibration data */
+	hdr = smu_get_sdb_partition(SMU_SDB_CPUDIODE_ID, NULL);
+	if (hdr == NULL) {
+		DBG("wf: cpudiode partition (%02x) not found\n",
+		    SMU_SDB_CPUDIODE_ID);
+		return -ENODEV;
+	}
+	cpudiode = (struct smu_sdbp_cpudiode *)&hdr[1];
+
+	/* Get slots power calibration data if any */
+	hdr = smu_get_sdb_partition(SMU_SDB_SLOTSPOW_ID, NULL);
+	if (hdr != NULL)
+		slotspow = (struct smu_sdbp_slotspow *)&hdr[1];
+
+	/* Get debug switches if any */
+	hdr = smu_get_sdb_partition(SMU_SDB_DEBUG_SWITCHES_ID, NULL);
+	if (hdr != NULL)
+		debugswitches = (u8 *)&hdr[1];
+
+	return 0;
+}
+
+static int __init smu_sensors_init(void)
+{
+	struct device_node *smu, *sensors, *s;
+	struct smu_ad_sensor *volt_sensor = NULL, *curr_sensor = NULL;
+	int rc;
+
+	if (!smu_present())
+		return -ENODEV;
+
+	/* Get parameters partitions */
+	rc = smu_fetch_param_partitions();
+	if (rc)
+		return rc;
+
+	smu = of_find_node_by_type(NULL, "smu");
+	if (smu == NULL)
+		return -ENODEV;
+
+	/* Look for sensors subdir */
+	for (sensors = NULL;
+	     (sensors = of_get_next_child(smu, sensors)) != NULL;)
+		if (!strcmp(sensors->name, "sensors"))
+			break;
+
+	of_node_put(smu);
+
+	/* Create basic sensors */
+	for (s = NULL;
+	     sensors && (s = of_get_next_child(sensors, s)) != NULL;) {
+		struct smu_ad_sensor *ads;
+
+		ads = smu_ads_create(s);
+		if (ads == NULL)
+			continue;
+		list_add(&ads->link, &smu_ads);
+		/* keep track of cpu voltage & current */
+		if (!strcmp(ads->sens.name, "cpu-voltage"))
+			volt_sensor = ads;
+		else if (!strcmp(ads->sens.name, "cpu-current"))
+			curr_sensor = ads;
+	}
+
+	of_node_put(sensors);
+
+	/* Create CPU power sensor if possible */
+	if (volt_sensor && curr_sensor)
+		smu_cpu_power = smu_cpu_power_create(&volt_sensor->sens,
+						     &curr_sensor->sens);
+
+	return 0;
+}
+
+static void __exit smu_sensors_exit(void)
+{
+	struct smu_ad_sensor *ads;
+
+	/* dispose of power sensor */
+	if (smu_cpu_power)
+		wf_unregister_sensor(&smu_cpu_power->sens);
+
+	/* dispose of basic sensors */
+	while (!list_empty(&smu_ads)) {
+		ads = list_entry(smu_ads.next, struct smu_ad_sensor, link);
+		list_del(&ads->link);
+		wf_unregister_sensor(&ads->sens);
+	}
+}
+
+
+module_init(smu_sensors_init);
+module_exit(smu_sensors_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("SMU sensor objects for PowerMacs thermal control");
+MODULE_LICENSE("GPL");
+
Index: linux-work/drivers/macintosh/windfarm_smu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_smu.c	2005-10-04 15:19:19.000000000 +1000
@@ -0,0 +1,1221 @@
+/*
+ * Windfarm PowerMac thermal control. SMU based machines control loops
+ *
+ * (c) Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ *
+ * The algorithm used is the PID control algorithm, used the same
+ * way the published Darwin code does, using the same values that
+ * are present in the Darwin 8.2 snapshot property lists (note however
+ * that none of the code has been re-used, it's a complete re-implementation
+ *
+ * The various control loops found in Darwin config file are:
+ *
+ * PowerMac8,1 and PowerMac8,2
+ * ===========================
+ *
+ * System Fans control loop. Different based on models. In addition to the
+ * usual PID algorithm, the control loop gets 2 additional pairs of linear
+ * scaling factors (scale/offsets) expressed as 4.12 fixed point values
+ * signed offset, unsigned scale)
+ *
+ * The targets are modified such as:
+ *  - the linked control (second control) gets the target value as-is
+ *    (typically the drive fan)
+ *  - the main control (first control) gets the target value scaled with
+ *    the first pair of factors, and is then modified as below
+ *  - the value of the target of the CPU Fan control loop is retreived,
+ *    scaled with the second pair of factors, and the max of that and
+ *    the scaled target is applied to the main control.
+ *
+ * # model_id: 2
+ *   controls       : system-fan, drive-bay-fan
+ *   sensors        : hd-temp
+ *   PID params     : G_d = 0x15400000
+ *                    G_p = 0x00200000
+ *                    G_r = 0x000002fd
+ *                    History = 2 entries
+ *                    Input target = 0x3a0000
+ *                    Interval = 5s
+ *   linear-factors : offset = 0xff38 scale  = 0x0ccd
+ *                    offset = 0x0208 scale  = 0x07ae
+ *
+ * # model_id: 3
+ *   controls       : system-fan, drive-bay-fan
+ *   sensors        : hd-temp
+ *   PID params     : G_d = 0x08e00000
+ *                    G_p = 0x00566666
+ *                    G_r = 0x0000072b
+ *                    History = 2 entries
+ *                    Input target = 0x350000
+ *                    Interval = 5s
+ *   linear-factors : offset = 0xff38 scale  = 0x0ccd
+ *                    offset = 0x0000 scale  = 0x0000
+ *
+ * # model_id: 5
+ *   controls       : system-fan
+ *   sensors        : hd-temp
+ *   PID params     : G_d = 0x15400000
+ *                    G_p = 0x00233333
+ *                    G_r = 0x000002fd
+ *                    History = 2 entries
+ *                    Input target = 0x3a0000
+ *                    Interval = 5s
+ *   linear-factors : offset = 0x0000 scale  = 0x1000
+ *                    offset = 0x0091 scale  = 0x0bae
+ *
+ * CPU Fan control loop. The loop is identical for all models. it
+ * has an additional pair of scaling factor. This is used to scale the
+ * systems fan control loop target result (the one before it gets scaled
+ * by the System Fans control loop itself). Then, the max value of the
+ * calculated target value and system fan value is sent to the fans
+ *
+ *   controls       : cpu-fan
+ *   sensors        : cpu-temp cpu-power
+ *   PID params     : From SMU sdb partition
+ *   linear-factors : offset = 0xfb50 scale  = 0x1000
+ *
+ * CPU Slew control loop. Not implemented. The cpufreq driver in linux is
+ * completely separate for now, though we could find a way to link it, either
+ * as a client reacting to overtemp notifications, or directling monitoring
+ * the CPU temperature
+ *
+ * WARNING ! The CPU control loop requires the CPU tmax for the current
+ * operating point. However, we currently are completely separated from
+ * the cpufreq driver and thus do not know what the current operating
+ * point is. Fortunately, we also do not have any hardware supporting anything
+ * but operating point 0 at the moment, thus we just peek that value directly
+ * from the SDB partition. If we ever end up with actually slewing the system
+ * clock and thus changing operating points, we'll have to find a way to
+ * communicate with the CPU freq driver;
+ *
+ * PowerMac9,1
+ * ===========
+ *
+ * Has 3 control loops: CPU fans is similar to PowerMac8,1 (though it doesn't
+ * try to play with other control loops fans). Drive bay is rather basic PID
+ * with one sensor and one fan. Slots area is a bit different as the Darwin
+ * driver is supposed to be capable of working in a special "AGP" mode which
+ * involves the presence of an AGP sensor and an AGP fan (possibly on the
+ * AGP card itself). I can't deal with that special mode as I don't have
+ * access to those additional sensor/fans for now (though ultimately, it would
+ * be possible to add sensor objects for them) so I'm only implementing the
+ * basic PCI slot control loop
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+#include <linux/wait.h>
+#include <linux/kmod.h>
+#include <linux/device.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/smu.h>
+
+#include "windfarm.h"
+#include "windfarm_pid.h"
+
+#define VERSION "0.3"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+/* define this to force CPU overtemp to 74 degree, useful for testing
+ * the overtemp code
+ */
+#undef HACKED_OVERTEMP
+
+/* Machine identification */
+#define MACHINE_PM81	81	/* PM81, PM82 */
+#define MACHINE_PM91	91	/* PM91 */
+
+static int machine;	/* machine */
+static int mach_model;	/* machine model id */
+
+static struct device *wf_dev;
+
+/* Controls & sensors */
+static struct wf_sensor	*sensor_cpu_power;
+static struct wf_sensor	*sensor_cpu_temp;
+static struct wf_sensor	*sensor_hd_temp;
+static struct wf_sensor	*sensor_slots_power;
+static struct wf_control *fan_cpu_main;
+static struct wf_control *fan_cpu_second;
+static struct wf_control *fan_cpu_third;
+static struct wf_control *fan_hd;
+static struct wf_control *fan_system;
+static struct wf_control *fan_slots;
+static struct wf_control *cpufreq_clamp;
+
+/* Set to kick the control loop into life */
+static int all_controls_ok, all_sensors_ok, started;
+
+/* Failure handling.. could be nicer */
+#define FAILURE_FAN		0x01
+#define FAILURE_SENSOR		0x02
+#define FAILURE_OVERTEMP	0x04
+
+static unsigned int failure_state;
+static int readjust, skipping;
+
+/*
+ * ****** System Fans Control Loop ******
+ *
+ * (PowerMac8,1 and 8,2 only)
+ */
+
+/* Parameters for the System Fans control loop. Parameters
+ * not in this table such as interval, history size, ...
+ * are common to all versions and thus hard coded for now.
+ */
+struct wf_smu_sys_fans_param {
+	int	model_id;
+	s32	itarget;
+	s32	gd, gp, gr;
+
+	s16	offset0;
+	u16	scale0;
+	s16	offset1;
+	u16	scale1;
+};
+
+#define WF_SMU_SYS_FANS_INTERVAL	5
+#define WF_SMU_SYS_FANS_HISTORY_SIZE	2
+
+/* State data used by the system fans control loop
+ * (MACHINE_PM81 only)
+ */
+struct wf_smu_sys_fans_state {
+	int			ticks;
+	s32			sys_setpoint;
+	s32			hd_setpoint;
+	s16			offset0;
+	u16			scale0;
+	s16			offset1;
+	u16			scale1;
+	struct wf_pid_state	pid;
+};
+
+/* Only 3 known configs */
+#define WF_SMU_SYS_FANS_NUM_CONFIGS	3
+
+/*
+ * Configs for SMU Sytem Fan control loop
+ */
+static struct wf_smu_sys_fans_param wf_smu_sys_all_params[] = {
+	/* Model ID 2 */
+	{
+		.model_id	= 2,
+		.itarget	= 0x3a0000,
+		.gd		= 0x15400000,
+		.gp		= 0x00200000,
+		.gr		= 0x000002fd,
+		.offset0	= 0xff38,
+		.scale0		= 0x0ccd,
+		.offset1	= 0x0208,
+		.scale1		= 0x07ae,
+	},
+	/* Model ID 3 */
+	{
+		.model_id	= 2,
+		.itarget	= 0x350000,
+		.gd		= 0x08e00000,
+		.gp		= 0x00566666,
+		.gr		= 0x0000072b,
+		.offset0	= 0xff38,
+		.scale0		= 0x0ccd,
+		.offset1	= 0x0000,
+		.scale1		= 0x0000,
+	},
+	/* Model ID 5 */
+	{
+		.model_id	= 2,
+		.itarget	= 0x3a0000,
+		.gd		= 0x15400000,
+		.gp		= 0x00233333,
+		.gr		= 0x000002fd,
+		.offset0	= 0x0000,
+		.scale0		= 0x1000,
+		.offset1	= 0x0091,
+		.scale1		= 0x0bae,
+	},
+};
+
+static struct wf_smu_sys_fans_state *wf_smu_sys_fans;
+
+/*
+ * ****** CPU Fans Control Loop ******
+ *
+ */
+
+
+#define WF_SMU_CPU_FANS_INTERVAL	1
+#define WF_SMU_CPU_FANS_MAX_HISTORY	16
+#define WF_SMU_CPU_FANS_SIBLING_SCALE	0x00001000
+#define WF_SMU_CPU_FANS_SIBLING_OFFSET	0xfffffb50
+
+/* State data used by the cpu fans control loop
+ */
+struct wf_smu_cpu_fans_state {
+	int			ticks;
+	s32			cpu_setpoint;
+	s32			scale;
+	s32			offset;
+	struct wf_cpu_pid_state	pid;
+};
+
+static struct wf_smu_cpu_fans_state *wf_smu_cpu_fans;
+
+
+
+/*
+ * ****** Drive Fan Control Loop ******
+ *
+ */
+
+struct wf_smu_drive_fans_state {
+	int			ticks;
+	s32			setpoint;
+	struct wf_pid_state	pid;
+};
+
+static struct wf_smu_drive_fans_state *wf_smu_drive_fans;
+
+/*
+ * ****** Slots Fan Control Loop ******
+ *
+ */
+
+struct wf_smu_slots_fans_state {
+	int			ticks;
+	s32			setpoint;
+	struct wf_pid_state	pid;
+};
+
+static struct wf_smu_slots_fans_state *wf_smu_slots_fans;
+
+/*
+ * ***** Implementation *****
+ *
+ */
+
+static void wf_smu_create_sys_fans(void)
+{
+	struct wf_smu_sys_fans_param *param = NULL;
+	struct wf_pid_param pid_param;
+	int i;
+
+	/* First, locate the params for this model */
+	for (i = 0; i < WF_SMU_SYS_FANS_NUM_CONFIGS; i++)
+		if (wf_smu_sys_all_params[i].model_id == mach_model) {
+			param = &wf_smu_sys_all_params[i];
+			break;
+		}
+	/* No params found, put fans to max */
+	if (param == NULL) {
+		printk(KERN_WARNING "windfarm: System fan config not found "
+		       "for this machine model, max fan speed\n");
+		goto fail;
+	}
+
+	/* Alloc & initialize state */
+	wf_smu_sys_fans = kmalloc(sizeof(struct wf_smu_sys_fans_state),
+					GFP_KERNEL);
+	if (wf_smu_sys_fans == NULL) {
+		printk(KERN_WARNING "windfarm: Memory allocation error"
+		       " max fan speed\n");
+		goto fail;
+	}
+       	wf_smu_sys_fans->ticks = 1;
+	wf_smu_sys_fans->scale0 = param->scale0;
+	wf_smu_sys_fans->offset0 = param->offset0;
+	wf_smu_sys_fans->scale1 = param->scale1;
+	wf_smu_sys_fans->offset1 = param->offset1;
+
+	/* Fill PID params */
+	pid_param.gd = param->gd;
+	pid_param.gp = param->gp;
+	pid_param.gr = param->gr;
+	pid_param.interval = WF_SMU_SYS_FANS_INTERVAL;
+	pid_param.history_len = WF_SMU_SYS_FANS_HISTORY_SIZE;
+	pid_param.itarget = param->itarget;
+	pid_param.min = fan_system->ops->get_min(fan_system);
+	pid_param.max = fan_system->ops->get_max(fan_system);
+	if (fan_hd) {
+		pid_param.min =max(pid_param.min,fan_hd->ops->get_min(fan_hd));
+		pid_param.max =min(pid_param.max,fan_hd->ops->get_max(fan_hd));
+	}
+	wf_pid_init(&wf_smu_sys_fans->pid, &pid_param);
+
+	DBG("wf: System Fan control initialized.\n");
+	DBG("    itarged=%d.%03d, min=%d RPM, max=%d RPM\n",
+	    FIX32TOPRINT(pid_param.itarget), pid_param.min, pid_param.max);
+	return;
+
+ fail:
+
+	if (fan_system)
+		wf_control_set_max(fan_system);
+	if (fan_hd)
+		wf_control_set_max(fan_hd);
+}
+
+static void wf_smu_sys_fans_tick(struct wf_smu_sys_fans_state *st)
+{
+	s32 new_setpoint, temp, scaled, cputarget;
+	int rc;
+
+	if (--st->ticks != 0) {
+		if (readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks = WF_SMU_SYS_FANS_INTERVAL;
+
+	rc = sensor_hd_temp->ops->get_value(sensor_hd_temp, &temp);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: HD temp sensor error %d\n",
+		       rc);
+		failure_state |= FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("wf_smu: System Fans tick ! HD temp: %d.%03d\n",
+	    FIX32TOPRINT(temp));
+
+	if (temp > (st->pid.param.itarget + 0x50000))
+		failure_state |= FAILURE_OVERTEMP;
+
+	new_setpoint = wf_pid_run(&st->pid, temp);
+
+	DBG("wf_smu: new_setpoint: %d RPM\n", (int)new_setpoint);
+
+	scaled = ((((s64)new_setpoint) * (s64)st->scale0) >> 12) + st->offset0;
+
+	DBG("wf_smu: scaled setpoint: %d RPM\n", (int)scaled);
+
+	cputarget = wf_smu_cpu_fans ? wf_smu_cpu_fans->pid.target : 0;
+	cputarget = ((((s64)cputarget) * (s64)st->scale1) >> 12) + st->offset1;
+	scaled = max(scaled, cputarget);
+	scaled = max(scaled, st->pid.param.min);
+	scaled = min(scaled, st->pid.param.max);
+
+	DBG("wf_smu: adjusted setpoint: %d RPM\n", (int)scaled);
+
+	if (st->sys_setpoint == scaled && new_setpoint == st->hd_setpoint)
+		return;
+	st->sys_setpoint = scaled;
+	st->hd_setpoint = new_setpoint;
+ readjust:
+	if (fan_system && failure_state == 0) {
+		rc = fan_system->ops->set_value(fan_system, st->sys_setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: Sys fan error %d\n",
+			       rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+	if (fan_hd && failure_state == 0) {
+		rc = fan_hd->ops->set_value(fan_hd, st->hd_setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: HD fan error %d\n",
+			       rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+}
+
+static void wf_smu_create_cpu_fans(void)
+{
+	struct wf_cpu_pid_param pid_param;
+	struct smu_sdbp_header *hdr;
+	struct smu_sdbp_cpupiddata *piddata;
+	struct smu_sdbp_fvt *fvt;
+	s32 tmax, tdelta, maxpow, powadj;
+
+	/* First, locate the PID params in SMU SBD */
+	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
+	if (hdr == 0) {
+		printk(KERN_WARNING "windfarm: CPU PID fan config not found "
+		       "max fan speed\n");
+		goto fail;
+	}
+	piddata = (struct smu_sdbp_cpupiddata *)&hdr[1];
+
+	/* Get the FVT params for operating point 0 (the only supported one
+	 * for now) in order to get tmax
+	 */
+	hdr = smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
+	if (hdr) {
+		fvt = (struct smu_sdbp_fvt *)&hdr[1];
+		tmax = ((s32)fvt->maxtemp) << 16;
+	} else
+		tmax = 0x5e0000; /* 94 degree default */
+
+	/* Alloc & initialize state */
+	wf_smu_cpu_fans = kmalloc(sizeof(struct wf_smu_cpu_fans_state),
+				  GFP_KERNEL);
+	if (wf_smu_cpu_fans == NULL)
+		goto fail;
+       	wf_smu_cpu_fans->ticks = 1;
+
+	if (machine == MACHINE_PM81) {
+		wf_smu_cpu_fans->scale = WF_SMU_CPU_FANS_SIBLING_SCALE;
+		wf_smu_cpu_fans->offset = WF_SMU_CPU_FANS_SIBLING_OFFSET;
+	}
+
+	/* Fill PID params */
+	pid_param.interval = WF_SMU_CPU_FANS_INTERVAL;
+	pid_param.history_len = piddata->history_len;
+	if (pid_param.history_len > WF_CPU_PID_MAX_HISTORY) {
+		printk(KERN_WARNING "windfarm: History size overflow on "
+		       "CPU control loop (%d)\n", piddata->history_len);
+		pid_param.history_len = WF_CPU_PID_MAX_HISTORY;
+	}
+	pid_param.gd = piddata->gd;
+	pid_param.gp = piddata->gp;
+	pid_param.gr = piddata->gr / pid_param.history_len;
+
+	tdelta = ((s32)piddata->target_temp_delta) << 16;
+	maxpow = ((s32)piddata->max_power) << 16;
+	powadj = ((s32)piddata->power_adj) << 16;
+
+	pid_param.tmax = tmax;
+	pid_param.ttarget = tmax - tdelta;
+	pid_param.pmaxadj = maxpow - powadj;
+
+	pid_param.min = fan_cpu_main->ops->get_min(fan_cpu_main);
+	pid_param.max = fan_cpu_main->ops->get_max(fan_cpu_main);
+
+	wf_cpu_pid_init(&wf_smu_cpu_fans->pid, &pid_param);
+
+	DBG("wf: CPU Fan control initialized.\n");
+	DBG("    ttarged=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM\n",
+	    FIX32TOPRINT(pid_param.ttarget), FIX32TOPRINT(pid_param.tmax),
+	    pid_param.min, pid_param.max);
+
+	return;
+
+ fail:
+	printk(KERN_WARNING "windfarm: CPU fan config not found\n"
+	       "for this machine model, max fan speed\n");
+
+	if (cpufreq_clamp)
+		wf_control_set_max(cpufreq_clamp);
+	if (fan_cpu_main)
+		wf_control_set_max(fan_cpu_main);
+}
+
+static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
+{
+	s32 new_setpoint, temp, power, systarget;
+	int rc;
+
+	if (--st->ticks != 0) {
+		if (readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks = WF_SMU_CPU_FANS_INTERVAL;
+
+	rc = sensor_cpu_temp->ops->get_value(sensor_cpu_temp, &temp);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: CPU temp sensor error %d\n",
+		       rc);
+		failure_state |= FAILURE_SENSOR;
+		return;
+	}
+
+	rc = sensor_cpu_power->ops->get_value(sensor_cpu_power, &power);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: CPU power sensor error %d\n",
+		       rc);
+		failure_state |= FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("wf_smu: CPU Fans tick ! CPU temp: %d.%03d, power: %d.%03d\n",
+	    FIX32TOPRINT(temp), FIX32TOPRINT(power));
+
+#ifdef HACKED_OVERTEMP
+	if (temp > 0x4a0000)
+		failure_state |= FAILURE_OVERTEMP;
+#else
+	if (temp > st->pid.param.tmax)
+		failure_state |= FAILURE_OVERTEMP;
+#endif
+	new_setpoint = wf_cpu_pid_run(&st->pid, power, temp);
+
+	DBG("wf_smu: new_setpoint: %d RPM\n", (int)new_setpoint);
+
+	if (machine == MACHINE_PM81) {
+		systarget = wf_smu_sys_fans ? wf_smu_sys_fans->pid.target : 0;
+		systarget = ((((s64)systarget) * (s64)st->scale) >> 12)
+			+ st->offset;
+		new_setpoint = max(new_setpoint, systarget);
+		new_setpoint = max(new_setpoint, st->pid.param.min);
+		new_setpoint = min(new_setpoint, st->pid.param.max);
+
+		DBG("wf_smu: adjusted setpoint: %d RPM\n", (int)new_setpoint);
+	}
+	if (st->cpu_setpoint == new_setpoint)
+		return;
+	st->cpu_setpoint = new_setpoint;
+ readjust:
+	if (fan_cpu_main && failure_state == 0) {
+		rc = fan_cpu_main->ops->set_value(fan_cpu_main,
+						  st->cpu_setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: CPU main fan"
+			       " error %d\n", rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+	if (fan_cpu_second && failure_state == 0) {
+		rc = fan_cpu_second->ops->set_value(fan_cpu_second,
+						    st->cpu_setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: CPU second fan"
+			       " error %d\n", rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+	if (fan_cpu_third && failure_state == 0) {
+		rc = fan_cpu_main->ops->set_value(fan_cpu_third,
+						  st->cpu_setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: CPU third fan"
+			       " error %d\n", rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+}
+
+static void wf_smu_create_drive_fans(void)
+{
+	struct wf_pid_param param = {
+		.interval	= 5,
+		.history_len	= 2,
+		.gd		= 0x01e00000,
+		.gp		= 0x00500000,
+		.gr		= 0x00000000,
+		.itarget	= 0x00200000,
+	};
+
+	/* Alloc & initialize state */
+	wf_smu_drive_fans = kmalloc(sizeof(struct wf_smu_drive_fans_state),
+					GFP_KERNEL);
+	if (wf_smu_drive_fans == NULL) {
+		printk(KERN_WARNING "windfarm: Memory allocation error"
+		       " max fan speed\n");
+		goto fail;
+	}
+       	wf_smu_drive_fans->ticks = 1;
+
+	/* Fill PID params */
+	param.additive = (fan_hd->type == WF_CONTROL_RPM_FAN);
+	param.min = fan_hd->ops->get_min(fan_hd);
+	param.max = fan_hd->ops->get_max(fan_hd);
+	wf_pid_init(&wf_smu_drive_fans->pid, &param);
+
+	DBG("wf: Drive Fan control initialized.\n");
+	DBG("    itarged=%d.%03d, min=%d RPM, max=%d RPM\n",
+	    FIX32TOPRINT(param.itarget), param.min, param.max);
+	return;
+
+ fail:
+	if (fan_hd)
+		wf_control_set_max(fan_hd);
+}
+
+static void wf_smu_drive_fans_tick(struct wf_smu_drive_fans_state *st)
+{
+	s32 new_setpoint, temp;
+	int rc;
+
+	if (--st->ticks != 0) {
+		if (readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks = st->pid.param.interval;
+
+	rc = sensor_hd_temp->ops->get_value(sensor_hd_temp, &temp);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: HD temp sensor error %d\n",
+		       rc);
+		failure_state |= FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("wf_smu: Drive Fans tick ! HD temp: %d.%03d\n",
+	    FIX32TOPRINT(temp));
+
+	if (temp > (st->pid.param.itarget + 0x50000))
+		failure_state |= FAILURE_OVERTEMP;
+
+	new_setpoint = wf_pid_run(&st->pid, temp);
+
+	DBG("wf_smu: new_setpoint: %d\n", (int)new_setpoint);
+
+	if (st->setpoint == new_setpoint)
+		return;
+	st->setpoint = new_setpoint;
+ readjust:
+	if (fan_hd && failure_state == 0) {
+		rc = fan_hd->ops->set_value(fan_hd, st->setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: HD fan error %d\n",
+			       rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+}
+
+static void wf_smu_create_slots_fans(void)
+{
+	struct wf_pid_param param = {
+		.interval	= 1,
+		.history_len	= 8,
+		.gd		= 0x00000000,
+		.gp		= 0x00000000,
+		.gr		= 0x00020000,
+		.itarget	= 0x00000000
+	};
+
+	/* Alloc & initialize state */
+	wf_smu_slots_fans = kmalloc(sizeof(struct wf_smu_slots_fans_state),
+					GFP_KERNEL);
+	if (wf_smu_slots_fans == NULL) {
+		printk(KERN_WARNING "windfarm: Memory allocation error"
+		       " max fan speed\n");
+		goto fail;
+	}
+       	wf_smu_slots_fans->ticks = 1;
+
+	/* Fill PID params */
+	param.additive = (fan_slots->type == WF_CONTROL_RPM_FAN);
+	param.min = fan_slots->ops->get_min(fan_slots);
+	param.max = fan_slots->ops->get_max(fan_slots);
+	wf_pid_init(&wf_smu_slots_fans->pid, &param);
+
+	DBG("wf: Slots Fan control initialized.\n");
+	DBG("    itarged=%d.%03d, min=%d RPM, max=%d RPM\n",
+	    FIX32TOPRINT(param.itarget), param.min, param.max);
+	return;
+
+ fail:
+	if (fan_slots)
+		wf_control_set_max(fan_slots);
+}
+
+static void wf_smu_slots_fans_tick(struct wf_smu_slots_fans_state *st)
+{
+	s32 new_setpoint, power;
+	int rc;
+
+	if (--st->ticks != 0) {
+		if (readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks = st->pid.param.interval;
+
+	rc = sensor_slots_power->ops->get_value(sensor_slots_power, &power);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: Slots power sensor error %d\n",
+		       rc);
+		failure_state |= FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("wf_smu: Slots Fans tick ! Slots power: %d.%03d\n",
+	    FIX32TOPRINT(power));
+
+#if 0 /* Check what makes a good overtemp condition */
+	if (power > (st->pid.param.itarget + 0x50000))
+		failure_state |= FAILURE_OVERTEMP;
+#endif
+
+	new_setpoint = wf_pid_run(&st->pid, power);
+
+	DBG("wf_smu: new_setpoint: %d\n", (int)new_setpoint);
+
+	if (st->setpoint == new_setpoint)
+		return;
+	st->setpoint = new_setpoint;
+ readjust:
+	if (fan_slots && failure_state == 0) {
+		rc = fan_slots->ops->set_value(fan_slots, st->setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: Slots fan error %d\n",
+			       rc);
+			failure_state |= FAILURE_FAN;
+		}
+	}
+}
+
+
+/*
+ * ****** Attributes ******
+ *
+ */
+
+#define BUILD_SHOW_FUNC_FIX(name, data)				\
+static ssize_t show_##name(struct device *dev,                  \
+			   struct device_attribute *attr,       \
+			   char *buf)	                        \
+{								\
+	ssize_t r;						\
+        s32 val = 0;                                            \
+        data->ops->get_value(data, &val);                       \
+	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(val)); 	\
+	return r;						\
+}                                                               \
+static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
+
+
+#define BUILD_SHOW_FUNC_INT(name, data)				\
+static ssize_t show_##name(struct device *dev,                  \
+			   struct device_attribute *attr,       \
+			   char *buf)	                        \
+{								\
+        s32 val = 0;                                            \
+        data->ops->get_value(data, &val);                       \
+	return sprintf(buf, "%d", val);  			\
+}                                                               \
+static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
+
+BUILD_SHOW_FUNC_INT(cpu_fan, fan_cpu_main);
+BUILD_SHOW_FUNC_INT(sys_fan, fan_system);
+BUILD_SHOW_FUNC_INT(hd_fan, fan_hd);
+BUILD_SHOW_FUNC_INT(slots_fan, fan_slots);
+
+BUILD_SHOW_FUNC_FIX(cpu_temp, sensor_cpu_temp);
+BUILD_SHOW_FUNC_FIX(cpu_power, sensor_cpu_power);
+BUILD_SHOW_FUNC_FIX(hd_temp, sensor_hd_temp);
+BUILD_SHOW_FUNC_FIX(slots_power, sensor_slots_power);
+
+/*
+ * ****** Setup / Init / Misc ... ******
+ *
+ */
+
+static void wf_smu_tick(void)
+{
+	unsigned int last_failure = failure_state;
+	unsigned int new_failure;
+
+	if (!started) {
+		DBG("wf: creating control loops !\n");
+		if (machine == MACHINE_PM81) {
+			wf_smu_create_sys_fans();
+			wf_smu_create_cpu_fans();
+		} else if (machine == MACHINE_PM91) {
+			wf_smu_create_drive_fans();
+			wf_smu_create_slots_fans();
+			wf_smu_create_cpu_fans();
+		}
+		started = 1;
+	}
+
+	/* Skipping ticks */
+	if (skipping && --skipping)
+		return;
+
+	failure_state = 0;
+	if (wf_smu_sys_fans)
+		wf_smu_sys_fans_tick(wf_smu_sys_fans);
+	if (wf_smu_drive_fans)
+		wf_smu_drive_fans_tick(wf_smu_drive_fans);
+	if (wf_smu_slots_fans)
+		wf_smu_slots_fans_tick(wf_smu_slots_fans);
+	if (wf_smu_cpu_fans)
+		wf_smu_cpu_fans_tick(wf_smu_cpu_fans);
+
+	readjust = 0;
+	new_failure = failure_state & ~last_failure;
+
+	/* If entering failure mode, clamp cpufreq and ramp all
+	 * fans to full speed.
+	 */
+	if (failure_state && !last_failure) {
+		if (cpufreq_clamp)
+			wf_control_set_max(cpufreq_clamp);
+		if (fan_system)
+			wf_control_set_max(fan_system);
+		if (fan_cpu_main)
+			wf_control_set_max(fan_cpu_main);
+		if (fan_cpu_second)
+			wf_control_set_max(fan_cpu_second);
+		if (fan_cpu_third)
+			wf_control_set_max(fan_cpu_third);
+		if (fan_hd)
+			wf_control_set_max(fan_hd);
+		if (fan_slots)
+			wf_control_set_max(fan_slots);
+	}
+
+	/* If leaving failure mode, unclamp cpufreq and readjust
+	 * all fans on next iteration
+	 */
+	if (!failure_state && last_failure) {
+		if (cpufreq_clamp)
+			wf_control_set_min(cpufreq_clamp);
+		readjust = 1;
+	}
+
+	/* Overtemp condition detected, notify and start skipping a couple
+	 * ticks to let the temperature go down
+	 */
+	if (new_failure & FAILURE_OVERTEMP) {
+		wf_set_overtemp();
+		skipping = 2;
+	}
+
+	/* We only clear the overtemp condition if overtemp is cleared
+	 * _and_ no other failure is present. Since a sensor error will
+	 * clear the overtemp condition (can't measure temperature) at
+	 * the control loop levels, but we don't want to keep it clear
+	 * here in this case
+	 */
+	if (new_failure == 0 && last_failure & FAILURE_OVERTEMP)
+		wf_clear_overtemp();
+}
+
+static void wf_smu_new_control81(struct wf_control *ct)
+{
+	if (all_controls_ok)
+		return;
+
+	if (fan_cpu_main == NULL && !strcmp(ct->name, "cpu-fan")) {
+		if (wf_get_control(ct) == 0) {
+			fan_cpu_main = ct;
+			device_create_file(wf_dev, &dev_attr_cpu_fan);
+		}
+	}
+
+	if (fan_system == NULL && !strcmp(ct->name, "system-fan")) {
+		if (wf_get_control(ct) == 0) {
+			fan_system = ct;
+			device_create_file(wf_dev, &dev_attr_sys_fan);
+		}
+	}
+
+	if (cpufreq_clamp == NULL && !strcmp(ct->name, "cpufreq-clamp")) {
+		if (wf_get_control(ct) == 0)
+			cpufreq_clamp = ct;
+	}
+
+	/* Darwin property list says the HD fan is only for model ID
+	 * 0, 1, 2 and 3
+	 */
+
+	if (mach_model > 3) {
+		if (fan_system && fan_cpu_main && cpufreq_clamp)
+			all_controls_ok = 1;
+		return;
+	}
+
+	if (fan_hd == NULL && !strcmp(ct->name, "drive-bay-fan")) {
+		if (wf_get_control(ct) == 0) {
+			fan_hd = ct;
+			device_create_file(wf_dev, &dev_attr_hd_fan);
+		}
+	}
+
+	if (fan_system && fan_hd && fan_cpu_main && cpufreq_clamp)
+		all_controls_ok = 1;
+}
+
+static void wf_smu_new_control91(struct wf_control *ct)
+{
+	if (all_controls_ok)
+		return;
+
+	if (fan_cpu_main == NULL && !strcmp(ct->name, "cpu-rear-fan-0")) {
+		if (wf_get_control(ct) == 0) {
+			fan_cpu_main = ct;
+			device_create_file(wf_dev, &dev_attr_cpu_fan);
+		}
+	}
+
+	if (fan_cpu_second == NULL && !strcmp(ct->name, "cpu-rear-fan-1")) {
+		if (wf_get_control(ct) == 0)
+			fan_cpu_second = ct;
+	}
+
+	if (fan_cpu_third == NULL && !strcmp(ct->name, "cpu-front-fan-0")) {
+		if (wf_get_control(ct) == 0)
+			fan_cpu_third = ct;
+	}
+
+	if (cpufreq_clamp == NULL && !strcmp(ct->name, "cpufreq-clamp")) {
+		if (wf_get_control(ct) == 0)
+			cpufreq_clamp = ct;
+	}
+
+	if (fan_hd == NULL && !strcmp(ct->name, "drive-bay-fan")) {
+		if (wf_get_control(ct) == 0) {
+			fan_hd = ct;
+			device_create_file(wf_dev, &dev_attr_hd_fan);
+		}
+	}
+
+	if (fan_slots == NULL && !strcmp(ct->name, "slots-fan")) {
+		if (wf_get_control(ct) == 0) {
+			fan_slots = ct;
+			device_create_file(wf_dev, &dev_attr_slots_fan);
+		}
+	}
+
+	if (fan_cpu_main && (fan_cpu_second || fan_cpu_third) && fan_hd &&
+	    fan_slots && cpufreq_clamp)
+		all_controls_ok = 1;
+}
+
+static void wf_smu_new_sensor(struct wf_sensor *sr)
+{
+	if (all_sensors_ok)
+		return;
+
+	if (sensor_cpu_power == NULL && !strcmp(sr->name, "cpu-power")) {
+		if (wf_get_sensor(sr) == 0) {
+			sensor_cpu_power = sr;
+			device_create_file(wf_dev, &dev_attr_cpu_power);
+		}
+	}
+
+	if (sensor_cpu_temp == NULL && !strcmp(sr->name, "cpu-temp")) {
+		if (wf_get_sensor(sr) == 0) {
+			sensor_cpu_temp = sr;
+			device_create_file(wf_dev, &dev_attr_cpu_temp);
+		}
+	}
+
+	if (sensor_hd_temp == NULL && !strcmp(sr->name, "hd-temp")) {
+		if (wf_get_sensor(sr) == 0) {
+			sensor_hd_temp = sr;
+			device_create_file(wf_dev, &dev_attr_hd_temp);
+		}
+	}
+
+	if (sensor_slots_power == NULL && !strcmp(sr->name, "slots-power")) {
+		if (wf_get_sensor(sr) == 0) {
+			sensor_slots_power = sr;
+			device_create_file(wf_dev, &dev_attr_slots_power);
+		}
+	}
+
+	if (machine == MACHINE_PM81 && sensor_cpu_power &&
+	    sensor_cpu_temp && sensor_hd_temp)
+		all_sensors_ok = 1;
+
+	if (machine == MACHINE_PM91 && sensor_cpu_power &&
+	    sensor_cpu_temp && sensor_hd_temp && sensor_slots_power)
+		all_sensors_ok = 1;
+}
+
+
+static int wf_smu_notify(struct notifier_block *self,
+			       unsigned long event, void *data)
+{
+	switch(event) {
+	case WF_EVENT_NEW_CONTROL:
+		DBG("wf: new control %s detected\n",
+		    ((struct wf_control *)data)->name);
+		if (machine == MACHINE_PM81)
+			wf_smu_new_control81(data);
+		else
+			wf_smu_new_control91(data);
+		readjust = 1;
+		break;
+	case WF_EVENT_NEW_SENSOR:
+		DBG("wf: new sensor %s detected\n",
+		    ((struct wf_sensor *)data)->name);
+		wf_smu_new_sensor(data);
+		break;
+	case WF_EVENT_TICK:
+		if (all_controls_ok && all_sensors_ok)
+			wf_smu_tick();
+	};
+
+	return 0;
+}
+
+static struct notifier_block events = {
+	.notifier_call	= wf_smu_notify,
+};
+
+static int wf_init_pm81(void)
+{
+	struct smu_sdbp_header *hdr;
+
+	machine = MACHINE_PM81;
+
+	hdr = smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
+	if (hdr != 0) {
+		struct smu_sdbp_sensortree *st =
+			(struct smu_sdbp_sensortree *)&hdr[1];
+		mach_model = st->model_id;
+	}
+
+	printk(KERN_INFO "windfarm: Initializing for iMacG5 model ID %d\n",
+	       mach_model);
+
+	return 0;
+}
+
+static int wf_init_pm91(void)
+{
+	machine = MACHINE_PM91;
+
+	printk(KERN_INFO "windfarm: Initializing for Desktop G5 model\n");
+
+	return 0;
+}
+
+static int wf_smu_probe(struct device *ddev)
+{
+	wf_dev = ddev;
+
+	wf_register_client(&events);
+
+	return 0;
+}
+
+static int wf_smu_remove(struct device *ddev)
+{
+	wf_unregister_client(&events);
+
+	/* XXX We don't have yet a guarantee that our callback isn't
+	 * in progress when returning from wf_unregister_client, so
+	 * we add an arbitrary delay. I'll have to fix that in the core
+	 */
+	msleep(1000);
+
+	/* Release all sensors */
+	/* One more crappy race: I don't think we have any guarantee here
+	 * that the attribute callback won't race with the sensor beeing
+	 * disposed of, and I'm not 100% certain what best way to deal
+	 * with that except by adding locks all over... I'll do that
+	 * eventually but heh, who ever rmmod this module anyway ?
+	 */
+	if (sensor_cpu_power) {
+		device_remove_file(wf_dev, &dev_attr_cpu_power);
+		wf_put_sensor(sensor_cpu_power);
+	}
+	if (sensor_cpu_temp) {
+		device_remove_file(wf_dev, &dev_attr_cpu_temp);
+		wf_put_sensor(sensor_cpu_temp);
+	}
+	if (sensor_hd_temp) {
+		device_remove_file(wf_dev, &dev_attr_hd_temp);
+		wf_put_sensor(sensor_hd_temp);
+	}
+	if (sensor_slots_power) {
+		device_remove_file(wf_dev, &dev_attr_slots_power);
+		wf_put_sensor(sensor_slots_power);
+	}
+
+	/* Release all controls */
+	if (fan_cpu_main) {
+		device_remove_file(wf_dev, &dev_attr_cpu_fan);
+		wf_put_control(fan_cpu_main);
+	}
+	if (fan_cpu_second)
+		wf_put_control(fan_cpu_second);
+	if (fan_cpu_third)
+		wf_put_control(fan_cpu_third);
+	if (fan_hd) {
+		device_remove_file(wf_dev, &dev_attr_hd_fan);
+		wf_put_control(fan_hd);
+	}
+	if (fan_system) {
+		device_remove_file(wf_dev, &dev_attr_sys_fan);
+		wf_put_control(fan_system);
+	}
+	if (fan_slots) {
+		device_remove_file(wf_dev, &dev_attr_slots_fan);
+		wf_put_control(fan_slots);
+	}
+	if (cpufreq_clamp)
+		wf_put_control(cpufreq_clamp);
+
+	/* Destroy control loops state structures */
+	if (wf_smu_sys_fans)
+		kfree(wf_smu_sys_fans);
+	if (wf_smu_slots_fans)
+		kfree(wf_smu_cpu_fans);
+	if (wf_smu_drive_fans)
+		kfree(wf_smu_cpu_fans);
+	if (wf_smu_cpu_fans)
+		kfree(wf_smu_cpu_fans);
+
+	wf_dev = NULL;
+
+	return 0;
+}
+
+static struct device_driver wf_smu_driver = {
+        .name = "windfarm",
+        .bus = &platform_bus_type,
+        .probe = wf_smu_probe,
+        .remove = wf_smu_remove,
+};
+
+
+static int __init wf_smu_init(void)
+{
+	int rc = -ENODEV;
+
+	if (machine_is_compatible("PowerMac8,1") ||
+	    machine_is_compatible("PowerMac8,2"))
+		rc = wf_init_pm81();
+	else if (machine_is_compatible("PowerMac9,1"))
+		rc = wf_init_pm91();
+
+	if (rc == 0) {
+#ifdef MODULE
+		request_module("windfarm_smu_controls");
+		request_module("windfarm_smu_sensors");
+		request_module("windfarm_lm75_sensor");
+
+#endif /* MODULE */
+		driver_register(&wf_smu_driver);
+	}
+
+	return rc;
+}
+
+static void __exit wf_smu_exit(void)
+{
+
+	driver_unregister(&wf_smu_driver);
+}
+
+
+module_init(wf_smu_init);
+module_exit(wf_smu_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("Thermal control logic for SMU based PowerMacs");
+MODULE_LICENSE("GPL");
+
Index: linux-work/include/asm-ppc64/smu.h
===================================================================
--- linux-work.orig/include/asm-ppc64/smu.h	2005-10-04 15:17:21.000000000 +1000
+++ linux-work/include/asm-ppc64/smu.h	2005-10-04 15:17:33.000000000 +1000
@@ -41,8 +41,30 @@
 /*
  * Fan control
  *
- * This is a "mux" for fan control commands, first byte is the
- * "sub" command.
+ * This is a "mux" for fan control commands. The command seem to
+ * act differently based on the number of arguments. With 1 byte
+ * of argument, this seem to be queries for fans status, setpoint,
+ * etc..., while with 0xe arguments, we will set the fans speeds.
+ *
+ * Queries (1 byte arg):
+ * ---------------------
+ *
+ * arg=0x01: read RPM fans status
+ * arg=0x02: read RPM fans setpoint
+ * arg=0x11: read PWM fans status
+ * arg=0x12: read PWM fans setpoint
+ *
+ * the "status" queries return the current speed while the "setpoint" ones
+ * return the programmed/target speed. It _seems_ that the result is a bit
+ * mask in the first byte of active/available fans, followed by 6 words (16
+ * bits) containing the requested speed.
+ *
+ * Setpoint (14 bytes arg):
+ * ------------------------
+ *
+ * first arg byte is 0 for RPM fans and 0x10 for PWM. Second arg byte is the
+ * mask of fans affected by the command. Followed by 6 words containing the
+ * setpoint value for selected fans in the mask (or 0 if mask value is 0)
  */
 #define SMU_CMD_FAN_COMMAND			0x4a
 
@@ -169,7 +191,16 @@
 #define   SMU_CMD_POWER_SHUTDOWN		"SHUTDOWN"
 #define   SMU_CMD_POWER_VOLTAGE_SLEW		"VSLEW"
 
-/* Misc commands
+/*
+ * Read ADC sensors
+ *
+ * This command takes one byte of parameter: the sensor ID (or "reg"
+ * value in the device-tree) and returns a 16 bits value
+ */
+#define SMU_CMD_READ_ADC			0xd8
+
+/*
+ * Misc commands
  *
  * This command seem to be a grab bag of various things
  */
@@ -386,10 +417,12 @@
 };
 
 /*
- * 32 bits integers are usually encoded with 2x16 bits swapped,
- * this demangles them
+ * demangle 16 and 32 bits integer in some SMU partitions
+ * (currently, afaik, this concerns only the FVT partition
+ * (0x12)
  */
-//#define SMU_U32_MIX(x)	((((x) << 16) & 0xffff0000u) | (((x) >> 16) & 0xffffu))
+#define SMU_U16_MIX(x)	le16_to_cpu(x);
+#define SMU_U32_MIX(x)  ((((x) & 0xff00ff00u) >> 8)|(((x) & 0x00ff00ffu) << 8))
 
 /* This is the definition of the SMU sdb-partition-0x12 table (called
  * CPU F/V/T operating points in Darwin). The definition for all those
@@ -399,7 +432,8 @@
 
 struct smu_sdbp_fvt {
 	__u32	sysclk;			/* Base SysClk frequency in Hz for
-					 * this operating point
+					 * this operating point. Value need to
+					 * be unmixed with SMU_U32_MIX()
 					 */
 	__u8	pad;
 	__u8	maxtemp;		/* Max temp. supported by this
@@ -408,10 +442,69 @@
 
 	__u16	volts[3];		/* CPU core voltage for the 3
 					 * PowerTune modes, a mode with
-					 * 0V = not supported.
+					 * 0V = not supported. Value need
+					 * to be unmixed with SMU_U16_MIX()
 					 */
 };
 
+/* This partition contains voltage & current sensor calibration
+ * informations
+ */
+#define SMU_SDB_CPUVCP_ID		0x21
+
+struct smu_sdbp_cpuvcp {
+	__u16	volt_scale;		/* u4.12 fixed point */
+	__s16	volt_offset;		/* s4.12 fixed point */
+	__u16	curr_scale;		/* u4.12 fixed point */
+	__s16	curr_offset;		/* s4.12 fixed point */
+	__s32	power_quads[3];		/* s4.28 fixed point */
+};
+
+/* This partition contains CPU thermal diode calibration
+ */
+#define SMU_SDB_CPUDIODE_ID		0x18
+
+struct smu_sdbp_cpudiode {
+	__u16	m_value;		/* u1.15 fixed point */
+	__s16	b_value;		/* s10.6 fixed point */
+
+};
+
+/* This partition contains Slots power calibration
+ */
+#define SMU_SDB_SLOTSPOW_ID		0x78
+
+struct smu_sdbp_slotspow {
+	__u16	pow_scale;		/* u4.12 fixed point */
+	__s16	pow_offset;		/* s4.12 fixed point */
+};
+
+/* This partition contains machine specific version information about
+ * the sensor/control layout
+ */
+#define SMU_SDB_SENSORTREE_ID		0x25
+
+struct smu_sdbp_sensortree {
+	u8	model_id;
+	u8	unknown[3];
+};
+
+/* This partition contains CPU thermal control PID informations. So far
+ * only single CPU machines have been seen with an SMU, so we assume this
+ * carries only informations for those
+ */
+#define SMU_SDB_CPUPIDDATA_ID		0x17
+
+struct smu_sdbp_cpupiddata {
+	u8	unknown1;
+	u8	target_temp_delta;
+	u8	unknown2;
+	u8	history_len;
+	s16	power_adj;
+	u16	max_power;
+	s32	gp,gr,gd;
+};
+
 /* Other partitions without known structures */
 #define SMU_SDB_DEBUG_SWITCHES_ID	0x05
 
Index: linux-work/drivers/macintosh/windfarm_lm75_sensor.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_lm75_sensor.c	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,255 @@
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.1"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+struct wf_lm75_sensor {
+	int			ds1775 : 1;
+	int			inited : 1;
+	struct 	i2c_client	i2c;
+	struct 	wf_sensor	sens;
+};
+#define wf_to_lm75(c) container_of(c, struct wf_lm75_sensor, sens)
+#define i2c_to_lm75(c) container_of(c, struct wf_lm75_sensor, i2c)
+
+static int wf_lm75_attach(struct i2c_adapter *adapter);
+static int wf_lm75_detach(struct i2c_client *client);
+
+static struct i2c_driver wf_lm75_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "wf_lm75",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= wf_lm75_attach,
+	.detach_client	= wf_lm75_detach,
+};
+
+static int wf_lm75_get(struct wf_sensor *sr, s32 *value)
+{
+	struct wf_lm75_sensor *lm = wf_to_lm75(sr);
+	s32 data;
+
+	if (lm->i2c.adapter == NULL)
+		return -ENODEV;
+
+	/* Init chip if necessary */
+	if (!lm->inited) {
+		u8 cfg_new, cfg = (u8)i2c_smbus_read_byte_data(&lm->i2c, 1);
+
+		DBG("wf_lm75: Initializing %s, cfg was: %02x\n",
+		    sr->name, cfg);
+
+		/* clear shutdown bit, keep other settings as left by
+		 * the firmware for now
+		 */
+		cfg_new = cfg & ~0x01;
+		i2c_smbus_write_byte_data(&lm->i2c, 1, cfg_new);
+		lm->inited = 1;
+
+		/* If we just powered it up, let's wait 200 ms */
+		msleep(200);
+	}
+
+	/* Read temperature register */
+	data = (s32)le16_to_cpu(i2c_smbus_read_word_data(&lm->i2c, 0));
+	data <<= 8;
+	*value = data;
+
+	return 0;
+}
+
+static void wf_lm75_release(struct wf_sensor *sr)
+{
+	struct wf_lm75_sensor *lm = wf_to_lm75(sr);
+
+	/* check if client is registered and detach from i2c */
+	if (lm->i2c.adapter) {
+		i2c_detach_client(&lm->i2c);
+		lm->i2c.adapter = NULL;
+	}
+
+	kfree(lm);
+}
+
+static struct wf_sensor_ops wf_lm75_ops = {
+	.get_value	= wf_lm75_get,
+	.release	= wf_lm75_release,
+	.owner		= THIS_MODULE,
+};
+
+static struct wf_lm75_sensor *wf_lm75_create(struct i2c_adapter *adapter,
+					     u8 addr, int ds1775,
+					     const char *loc)
+{
+	struct wf_lm75_sensor *lm;
+
+	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
+	    ds1775 ? "ds1775" : "lm75", addr);
+
+	lm = kmalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
+	if (lm == NULL)
+		return NULL;
+	memset(lm, 0, sizeof(struct wf_lm75_sensor));
+
+	/* Usual rant about sensor names not beeing very consistent in
+	 * the device-tree, oh well ...
+	 * Add more entries below as you deal with more setups
+	 */
+	if (!strcmp(loc, "Hard drive") || !strcmp(loc, "DRIVE BAY"))
+		lm->sens.name = "hd-temp";
+	else
+		goto fail;
+
+	lm->inited = 0;
+	lm->sens.ops = &wf_lm75_ops;
+	lm->ds1775 = ds1775;
+	lm->i2c.addr = (addr >> 1) & 0x7f;
+	lm->i2c.adapter = adapter;
+	lm->i2c.driver = &wf_lm75_driver;
+	strncpy(lm->i2c.name, lm->sens.name, I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&lm->i2c)) {
+		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c\n",
+		       ds1775 ? "ds1775" : "lm75", lm->i2c.name);
+		goto fail;
+	}
+
+	if (wf_register_sensor(&lm->sens)) {
+		i2c_detach_client(&lm->i2c);
+		goto fail;
+	}
+
+	return lm;
+ fail:
+	kfree(lm);
+	return NULL;
+}
+
+static int wf_lm75_attach(struct i2c_adapter *adapter)
+{
+	u8 bus_id;
+	struct device_node *smu, *bus, *dev;
+
+	/* We currently only deal with LM75's hanging off the SMU
+	 * i2c busses. If we extend that driver to other/older
+	 * machines, we should split this function into SMU-i2c,
+	 * keywest-i2c, PMU-i2c, ...
+	 */
+
+	DBG("wf_lm75: adapter %s detected\n", adapter->name);
+
+	if (strncmp(adapter->name, "smu-i2c-", 8) != 0)
+		return 0;
+	smu = of_find_node_by_type(NULL, "smu");
+	if (smu == NULL)
+		return 0;
+
+	/* Look for the bus in the device-tree */
+	bus_id = (u8)simple_strtoul(adapter->name + 8, NULL, 16);
+
+	DBG("wf_lm75: bus ID is %x\n", bus_id);
+
+	/* Look for sensors subdir */
+	for (bus = NULL;
+	     (bus = of_get_next_child(smu, bus)) != NULL;) {
+		u32 *reg;
+
+		if (strcmp(bus->name, "i2c"))
+			continue;
+		reg = (u32 *)get_property(bus, "reg", NULL);
+		if (reg == NULL)
+			continue;
+		if (bus_id == *reg)
+			break;
+	}
+	of_node_put(smu);
+	if (bus == NULL) {
+		printk(KERN_WARNING "windfarm: SMU i2c bus 0x%x not found"
+		       " in device-tree !\n", bus_id);
+		return 0;
+	}
+
+	DBG("wf_lm75: bus found, looking for device...\n");
+
+	/* Now look for lm75(s) in there */
+	for (dev = NULL;
+	     (dev = of_get_next_child(bus, dev)) != NULL;) {
+		const char *loc =
+			get_property(dev, "hwsensor-location", NULL);
+		u32 *reg = (u32 *)get_property(dev, "reg", NULL);
+		DBG(" dev: %s... (loc: %p, reg: %p)\n", dev->name, loc, reg);
+		if (loc == NULL || reg == NULL)
+			continue;
+		/* real lm75 */
+		if (device_is_compatible(dev, "lm75"))
+			wf_lm75_create(adapter, *reg, 0, loc);
+		/* ds1775 (compatible, better resolution */
+		else if (device_is_compatible(dev, "ds1775"))
+			wf_lm75_create(adapter, *reg, 1, loc);
+	}
+
+	of_node_put(bus);
+
+	return 0;
+}
+
+static int wf_lm75_detach(struct i2c_client *client)
+{
+	struct wf_lm75_sensor *lm = i2c_to_lm75(client);
+
+	DBG("wf_lm75: i2c detatch called for %s\n", lm->sens.name);
+
+	/* Mark client detached */
+	lm->i2c.adapter = NULL;
+
+	/* release sensor */
+	wf_unregister_sensor(&lm->sens);
+
+	return 0;
+}
+
+static int __init wf_lm75_sensor_init(void)
+{
+	int rc;
+
+	rc = i2c_add_driver(&wf_lm75_driver);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void __exit wf_lm75_sensor_exit(void)
+{
+	i2c_del_driver(&wf_lm75_driver);
+}
+
+
+module_init(wf_lm75_sensor_init);
+module_exit(wf_lm75_sensor_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("LM75 sensor objects for PowerMacs thermal control");
+MODULE_LICENSE("GPL");
+
Index: linux-work/drivers/macintosh/windfarm_pid.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_pid.c	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,146 @@
+/*
+ * Windfarm PowerMac thermal control. Generic PID helpers
+ *
+ * (c) Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+#include "windfarm_pid.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+void wf_pid_init(struct wf_pid_state *st, struct wf_pid_param *param)
+{
+	memset(st, 0, sizeof(struct wf_pid_state));
+	st->param = *param;
+	st->first = 1;
+}
+EXPORT_SYMBOL_GPL(wf_pid_init);
+
+s32 wf_pid_run(struct wf_pid_state *st, s32 new_sample)
+{
+	s64	error, integ, deriv;
+	s32	target;
+	int	i, hlen = st->param.history_len;
+
+	/* Calculate error term */
+	error = new_sample - st->param.itarget;
+
+	/* Get samples into our history buffer */
+	if (st->first) {
+		for (i = 0; i < hlen; i++) {
+			st->samples[i] = new_sample;
+			st->errors[i] = error;
+		}
+		st->first = 0;
+		st->index = 0;
+	} else {
+		st->index = (st->index + 1) % hlen;
+		st->samples[st->index] = new_sample;
+		st->errors[st->index] = error;
+	}
+
+	/* Calculate integral term */
+	for (i = 0, integ = 0; i < hlen; i++)
+		integ += st->errors[(st->index + hlen - i) % hlen];
+	integ *= st->param.interval;
+
+	/* Calculate derivative term */
+	deriv = st->errors[st->index] -
+		st->errors[(st->index + hlen - 1) % hlen];
+	deriv /= st->param.interval;
+
+	/* Calculate target */
+	target = (s32)((integ * (s64)st->param.gr + deriv * (s64)st->param.gd +
+		  error * (s64)st->param.gp) >> 36);
+	if (st->param.additive)
+		target += st->target;
+	target = max(target, st->param.min);
+	target = min(target, st->param.max);
+	st->target = target;
+
+	return st->target;
+}
+EXPORT_SYMBOL_GPL(wf_pid_run);
+
+void wf_cpu_pid_init(struct wf_cpu_pid_state *st,
+		     struct wf_cpu_pid_param *param)
+{
+	memset(st, 0, sizeof(struct wf_cpu_pid_state));
+	st->param = *param;
+	st->first = 1;
+}
+EXPORT_SYMBOL_GPL(wf_cpu_pid_init);
+
+s32 wf_cpu_pid_run(struct wf_cpu_pid_state *st, s32 new_power, s32 new_temp)
+{
+	s64	error, integ, deriv, prop;
+	s32	target, sval, adj;
+	int	i, hlen = st->param.history_len;
+
+	/* Calculate error term */
+	error = st->param.pmaxadj - new_power;
+
+	/* Get samples into our history buffer */
+	if (st->first) {
+		for (i = 0; i < hlen; i++) {
+			st->powers[i] = new_power;
+			st->errors[i] = error;
+		}
+		st->temps[0] = st->temps[1] = new_temp;
+		st->first = 0;
+		st->index = st->tindex = 0;
+	} else {
+		st->index = (st->index + 1) % hlen;
+		st->powers[st->index] = new_power;
+		st->errors[st->index] = error;
+		st->tindex = (st->tindex + 1) % 2;
+		st->temps[st->tindex] = new_temp;
+	}
+
+	/* Calculate integral term */
+	for (i = 0, integ = 0; i < hlen; i++)
+		integ += st->errors[(st->index + hlen - i) % hlen];
+	integ *= st->param.interval;
+	integ *= st->param.gr;
+	sval = st->param.tmax - ((integ >> 20) & 0xffffffff);
+	adj = min(st->param.ttarget, sval);
+
+	DBG("integ: %lx, sval: %lx, adj: %lx\n", integ, sval, adj);
+
+	/* Calculate derivative term */
+	deriv = st->temps[st->tindex] -
+		st->temps[(st->tindex + 2 - 1) % 2];
+	deriv /= st->param.interval;
+	deriv *= st->param.gd;
+
+	/* Calculate proportional term */
+	prop = (new_temp - adj);
+	prop *= st->param.gp;
+
+	DBG("deriv: %lx, prop: %lx\n", deriv, prop);
+
+	/* Calculate target */
+	target = st->target + (s32)((deriv + prop) >> 36);
+	target = max(target, st->param.min);
+	target = min(target, st->param.max);
+	st->target = target;
+
+	return st->target;
+}
+EXPORT_SYMBOL_GPL(wf_cpu_pid_run);
Index: linux-work/drivers/macintosh/windfarm_pid.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_pid.h	2005-10-04 15:17:33.000000000 +1000
@@ -0,0 +1,84 @@
+/*
+ * Windfarm PowerMac thermal control. Generic PID helpers
+ *
+ * (c) Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ *
+ * This is a pair of generic PID helpers that can be used by
+ * control loops. One is the basic PID implementation, the
+ * other one is more specifically tailored to the loops used
+ * for CPU control with 2 input sample types (temp and power)
+ */
+
+/*
+ * *** Simple PID ***
+ */
+
+#define WF_PID_MAX_HISTORY	32
+
+/* This parameter array is passed to the PID algorithm. Currently,
+ * we don't support changing parameters on the fly as it's not needed
+ * but could be implemented (with necessary adjustment of the history
+ * buffer
+ */
+struct wf_pid_param {
+	int	interval;	/* Interval between samples in seconds */
+	int	history_len;	/* Size of history buffer */
+	int	additive;	/* 1: target relative to previous value */
+	s32	gd, gp, gr;	/* PID gains */
+	s32	itarget;	/* PID input target */
+	s32	min,max;	/* min and max target values */
+};
+
+struct wf_pid_state {
+	int	first;				/* first run of the loop */
+	int	index; 				/* index of current sample */
+	s32	target;				/* current target value */
+	s32	samples[WF_PID_MAX_HISTORY];	/* samples history buffer */
+	s32	errors[WF_PID_MAX_HISTORY];	/* error history buffer */
+
+	struct wf_pid_param param;
+};
+
+extern void wf_pid_init(struct wf_pid_state *st, struct wf_pid_param *param);
+extern s32 wf_pid_run(struct wf_pid_state *st, s32 sample);
+
+
+/*
+ * *** CPU PID ***
+ */
+
+#define WF_CPU_PID_MAX_HISTORY	32
+
+/* This parameter array is passed to the CPU PID algorithm. Currently,
+ * we don't support changing parameters on the fly as it's not needed
+ * but could be implemented (with necessary adjustment of the history
+ * buffer
+ */
+struct wf_cpu_pid_param {
+	int	interval;	/* Interval between samples in seconds */
+	int	history_len;	/* Size of history buffer */
+	s32	gd, gp, gr;	/* PID gains */
+	s32	pmaxadj;	/* PID max power adjust */
+	s32	ttarget;	/* PID input target */
+	s32	tmax;		/* PID input max */
+	s32	min,max;	/* min and max target values */
+};
+
+struct wf_cpu_pid_state {
+	int	first;				/* first run of the loop */
+	int	index; 				/* index of current power */
+	int	tindex; 			/* index of current temp */
+	s32	target;				/* current target value */
+	s32	powers[WF_PID_MAX_HISTORY];	/* power history buffer */
+	s32	errors[WF_PID_MAX_HISTORY];	/* error history buffer */
+	s32	temps[2];			/* temp. history buffer */
+
+	struct wf_cpu_pid_param param;
+};
+
+extern void wf_cpu_pid_init(struct wf_cpu_pid_state *st,
+			    struct wf_cpu_pid_param *param);
+extern s32 wf_cpu_pid_run(struct wf_cpu_pid_state *st, s32 power, s32 temp);
Index: linux-work/arch/ppc64/kernel/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_cpufreq.c	2005-10-04 15:17:21.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac_cpufreq.c	2005-10-04 15:18:26.000000000 +1000
@@ -84,7 +84,8 @@
 static u32 *g5_pmode_data;
 static int g5_pmode_max;
 static int g5_pmode_cur;
-
+static int g5_driver_active;
+static DECLARE_MUTEX(g5_switch_mutex);
 
 static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
 static int g5_fvt_count;			/* number of op. points */
@@ -105,11 +106,20 @@
 
 static int g5_switch_freq(int speed_mode)
 {
+	struct cpufreq_freqs freqs;
 	int to;
 
 	if (g5_pmode_cur == speed_mode)
 		return 0;
 
+	down(&g5_switch_mutex);
+
+	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
+	freqs.new = g5_cpu_freqs[speed_mode].frequency;
+	freqs.cpu = 0;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
 	/* If frequency is going up, first ramp up the voltage */
 	if (speed_mode < g5_pmode_cur)
 		g5_switch_volt(speed_mode);
@@ -143,6 +153,10 @@
 	g5_pmode_cur = speed_mode;
 	ppc_proc_freq = g5_cpu_freqs[speed_mode].frequency * 1000ul;
 
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	up(&g5_switch_mutex);
+
 	return 0;
 }
 
@@ -159,12 +173,12 @@
 }
 
 /* ----------------- cpufreq bookkeeping */
-static int __pmac g5_cpufreq_verify(struct cpufreq_policy *policy)
+static int g5_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy, g5_cpu_freqs);
 }
 
-static int __pmac g5_cpufreq_target(struct cpufreq_policy *policy,
+static int g5_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int target_freq, unsigned int relation)
 {
 	unsigned int    newstate = 0;
@@ -173,10 +187,20 @@
 			target_freq, relation, &newstate))
 		return -EINVAL;
 
+	DBG("g5_cpufreq: Request to switch to %d state: %d\n",
+	    target_freq, newstate);
+
 	return g5_switch_freq(newstate);
 }
 
-static int __pmac g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static unsigned int g5_cpufreq_get_speed(unsigned int cpu)
+{
+	DBG("g5_cpufreq: Get speed %d\n",
+	    g5_cpu_freqs[g5_pmode_cur].frequency);
+	return g5_cpu_freqs[g5_pmode_cur].frequency;
+}
+
+static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -ENODEV;
@@ -198,6 +222,7 @@
 	.init		= g5_cpufreq_cpu_init,
 	.verify		= g5_cpufreq_verify,
 	.target		= g5_cpufreq_target,
+	.get		= g5_cpufreq_get_speed,
 	.attr 		= g5_cpu_freqs_attr,
 };
 
@@ -266,11 +291,14 @@
 
 	/* Check current frequency */
 	g5_pmode_cur = g5_query_freq();
-	if (g5_pmode_cur > 1) {
+	if (g5_pmode_cur > 1)
 		/* We don't support anything but 1:1 and 1:2, fixup ... */
-		g5_switch_freq(1);
 		g5_pmode_cur = 1;
-	}
+
+	/* Force apply current frequency to make sure everything is in
+	 * sync (voltage is right for example)
+	 */
+	g5_switch_freq(g5_pmode_cur);
 
 	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
 	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
@@ -279,6 +307,8 @@
 		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
 
 	rc = cpufreq_register_driver(&g5_cpufreq_driver);
+	if (rc == 0)
+		g5_driver_active = 1;
 
 	/* We keep the CPU node on hold... hopefully, Apple G5 don't have
 	 * hotplug CPU with a dynamic device-tree ...
Index: linux-work/drivers/macintosh/windfarm_cpufreq_clamp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_cpufreq_clamp.c	2005-10-04 15:19:48.000000000 +1000
@@ -0,0 +1,105 @@
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/cpufreq.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.3"
+
+static int clamped;
+static struct wf_control *clamp_control;
+
+static int clamp_notifier_call(struct notifier_block *self,
+			       unsigned long event, void *data)
+{
+	struct cpufreq_policy *p = data;
+	unsigned long max_freq;
+
+	if (event != CPUFREQ_ADJUST)
+		return 0;
+
+	max_freq = clamped ? (p->cpuinfo.min_freq) : (p->cpuinfo.max_freq);
+	cpufreq_verify_within_limits(p, 0, max_freq);
+
+	return 0;
+}
+
+static struct notifier_block clamp_notifier = {
+	.notifier_call = clamp_notifier_call,
+};
+
+static int clamp_set(struct wf_control *ct, s32 value)
+{
+	if (value)
+		printk(KERN_INFO "windfarm: Clamping CPU frequency to "
+		       "minimum !\n");
+	else
+		printk(KERN_INFO "windfarm: CPU frequency unclamped !\n");
+	clamped = value;
+        cpufreq_update_policy(0);
+	return 0;
+}
+
+static int clamp_get(struct wf_control *ct, s32 *value)
+{
+	*value = clamped;
+	return 0;
+}
+
+static s32 clamp_min(struct wf_control *ct)
+{
+	return 0;
+}
+
+static s32 clamp_max(struct wf_control *ct)
+{
+	return 1;
+}
+
+static struct wf_control_ops clamp_ops = {
+	.set_value	= clamp_set,
+	.get_value	= clamp_get,
+	.get_min	= clamp_min,
+	.get_max	= clamp_max,
+	.owner		= THIS_MODULE,
+};
+
+static int __init wf_cpufreq_clamp_init(void)
+{
+	struct wf_control *clamp;
+
+	clamp = kmalloc(sizeof(struct wf_control), GFP_KERNEL);
+	if (clamp == NULL)
+		return -ENOMEM;
+	cpufreq_register_notifier(&clamp_notifier, CPUFREQ_POLICY_NOTIFIER);
+	clamp->ops = &clamp_ops;
+	clamp->name = "cpufreq-clamp";
+	if (wf_register_control(clamp))
+		goto fail;
+	clamp_control = clamp;
+	return 0;
+ fail:
+	kfree(clamp);
+	return -ENODEV;
+}
+
+static void __exit wf_cpufreq_clamp_exit(void)
+{
+	if (clamp_control)
+		wf_unregister_control(clamp_control);
+}
+
+
+module_init(wf_cpufreq_clamp_init);
+module_exit(wf_cpufreq_clamp_exit);
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("CPU frequency clamp for PowerMacs thermal control");
+MODULE_LICENSE("GPL");
+


