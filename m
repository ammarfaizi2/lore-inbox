Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbWBHFmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWBHFmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWBHFma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:42:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:16297 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030535AbWBHFm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:42:29 -0500
Subject: [PATCH] powerpc: Thermal control for dual core G5s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 16:42:51 +1100
Message-Id: <1139377372.8187.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a windfarm module, windfarm_pm112, for the dual core G5s
(both 2 and 4 core models), keeping the machine from getting into
vacuum-cleaner mode ;) For proper credits, the patch was initially
written by Paul Mackerras, and slightly reworked by me to add overtemp
handling among others. The patch also removes the sysfs attributes from
windfarm_pm81 and windfarm_pm91 and instead adds code to the windfarm
core to automagically expose attributes for sensor & controls.

Signed-off-by; Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/Kconfig
===================================================================
--- linux-work.orig/drivers/macintosh/Kconfig	2006-01-12 16:33:08.000000000 +1100
+++ linux-work/drivers/macintosh/Kconfig	2006-02-07 13:45:57.000000000 +1100
@@ -187,6 +187,14 @@ config WINDFARM_PM91
 	  This driver provides thermal control for the PowerMac9,1
           which is the recent (SMU based) single CPU desktop G5
 
+config WINDFARM_PM112
+	tristate "Support for thermal management on PowerMac11,2"
+	depends on WINDFARM && I2C && PMAC_SMU
+	select I2C_PMAC_SMU
+	help
+	  This driver provides thermal control for the PowerMac11,2
+	  which are the recent dual and quad G5 machines using the
+	  970MP dual-core processor.
 
 config ANSLCD
 	tristate "Support for ANS LCD display"
Index: linux-work/drivers/macintosh/Makefile
===================================================================
--- linux-work.orig/drivers/macintosh/Makefile	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/Makefile	2006-02-07 13:45:57.000000000 +1100
@@ -35,3 +35,8 @@ obj-$(CONFIG_WINDFARM_PM91)     += windf
 				   windfarm_smu_sensors.o \
 				   windfarm_lm75_sensor.o windfarm_pid.o \
 				   windfarm_cpufreq_clamp.o windfarm_pm91.o
+obj-$(CONFIG_WINDFARM_PM112)	+= windfarm_pm112.o windfarm_smu_sat.o \
+				   windfarm_smu_controls.o \
+				   windfarm_smu_sensors.o \
+				   windfarm_max6690_sensor.o \
+				   windfarm_lm75_sensor.o windfarm_pid.o
Index: linux-work/drivers/macintosh/windfarm.h
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm.h	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm.h	2006-02-07 13:45:57.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/device.h>
 
 /* Display a 16.16 fixed point value */
 #define FIX32TOPRINT(f)	((f) >> 16),((((f) & 0xffff) * 1000) >> 16)
@@ -39,6 +40,7 @@ struct wf_control {
 	char			*name;
 	int			type;
 	struct kref		ref;
+	struct device_attribute	attr;
 };
 
 #define WF_CONTROL_TYPE_GENERIC		0
@@ -87,6 +89,7 @@ struct wf_sensor {
 	struct wf_sensor_ops	*ops;
 	char			*name;
 	struct kref		ref;
+	struct device_attribute	attr;
 };
 
 /* Same lifetime rules as controls */
Index: linux-work/drivers/macintosh/windfarm_core.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_core.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_core.c	2006-02-07 13:45:57.000000000 +1100
@@ -55,6 +55,10 @@ static unsigned int wf_overtemp;
 static unsigned int wf_overtemp_counter;
 struct task_struct *wf_thread;
 
+static struct platform_device wf_platform_device = {
+	.name	= "windfarm",
+};
+
 /*
  * Utilities & tick thread
  */
@@ -156,6 +160,40 @@ static void wf_control_release(struct kr
 		kfree(ct);
 }
 
+static ssize_t wf_show_control(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct wf_control *ctrl = container_of(attr, struct wf_control, attr);
+	s32 val = 0;
+	int err;
+
+	err = ctrl->ops->get_value(ctrl, &val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%d\n", val);
+}
+
+/* This is really only for debugging... */
+static ssize_t wf_store_control(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct wf_control *ctrl = container_of(attr, struct wf_control, attr);
+	int val;
+	int err;
+	char *endp;
+
+	val = simple_strtoul(buf, &endp, 0);
+	while (endp < buf + count && (*endp == ' ' || *endp == '\n'))
+		++endp;
+	if (endp - buf < count)
+		return -EINVAL;
+	err = ctrl->ops->set_value(ctrl, val);
+	if (err < 0)
+		return err;
+	return count;
+}
+
 int wf_register_control(struct wf_control *new_ct)
 {
 	struct wf_control *ct;
@@ -172,6 +210,13 @@ int wf_register_control(struct wf_contro
 	kref_init(&new_ct->ref);
 	list_add(&new_ct->link, &wf_controls);
 
+	new_ct->attr.attr.name = new_ct->name;
+	new_ct->attr.attr.owner = THIS_MODULE;
+	new_ct->attr.attr.mode = 0644;
+	new_ct->attr.show = wf_show_control;
+	new_ct->attr.store = wf_store_control;
+	device_create_file(&wf_platform_device.dev, &new_ct->attr);
+
 	DBG("wf: Registered control %s\n", new_ct->name);
 
 	wf_notify(WF_EVENT_NEW_CONTROL, new_ct);
@@ -246,6 +291,19 @@ static void wf_sensor_release(struct kre
 		kfree(sr);
 }
 
+static ssize_t wf_show_sensor(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct wf_sensor *sens = container_of(attr, struct wf_sensor, attr);
+	s32 val = 0;
+	int err;
+
+	err = sens->ops->get_value(sens, &val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%d.%03d\n", FIX32TOPRINT(val));
+}
+
 int wf_register_sensor(struct wf_sensor *new_sr)
 {
 	struct wf_sensor *sr;
@@ -262,6 +320,13 @@ int wf_register_sensor(struct wf_sensor 
 	kref_init(&new_sr->ref);
 	list_add(&new_sr->link, &wf_sensors);
 
+	new_sr->attr.attr.name = new_sr->name;
+	new_sr->attr.attr.owner = THIS_MODULE;
+	new_sr->attr.attr.mode = 0444;
+	new_sr->attr.show = wf_show_sensor;
+	new_sr->attr.store = NULL;
+	device_create_file(&wf_platform_device.dev, &new_sr->attr);
+
 	DBG("wf: Registered sensor %s\n", new_sr->name);
 
 	wf_notify(WF_EVENT_NEW_SENSOR, new_sr);
@@ -395,10 +460,6 @@ int wf_is_overtemp(void)
 }
 EXPORT_SYMBOL_GPL(wf_is_overtemp);
 
-static struct platform_device wf_platform_device = {
-	.name	= "windfarm",
-};
-
 static int __init windfarm_core_init(void)
 {
 	DBG("wf: core loaded\n");
Index: linux-work/drivers/macintosh/windfarm_max6690_sensor.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_max6690_sensor.c	2006-02-07 16:05:23.000000000 +1100
@@ -0,0 +1,169 @@
+/*
+ * Windfarm PowerMac thermal control.  MAX6690 sensor.
+ *
+ * Copyright (C) 2005 Paul Mackerras, IBM Corp. <paulus@samba.org>
+ *
+ * Use and redistribute under the terms of the GNU GPL v2.
+ */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <asm/prom.h>
+#include <asm/pmac_low_i2c.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.1"
+
+/* This currently only exports the external temperature sensor,
+   since that's all the control loops need. */
+
+/* Some MAX6690 register numbers */
+#define MAX6690_INTERNAL_TEMP	0
+#define MAX6690_EXTERNAL_TEMP	1
+
+struct wf_6690_sensor {
+	struct i2c_client	i2c;
+	struct wf_sensor	sens;
+};
+
+#define wf_to_6690(x)	container_of((x), struct wf_6690_sensor, sens)
+#define i2c_to_6690(x)	container_of((x), struct wf_6690_sensor, i2c)
+
+static int wf_max6690_attach(struct i2c_adapter *adapter);
+static int wf_max6690_detach(struct i2c_client *client);
+
+static struct i2c_driver wf_max6690_driver = {
+	.driver = {
+		.name		= "wf_max6690",
+	},
+	.attach_adapter	= wf_max6690_attach,
+	.detach_client	= wf_max6690_detach,
+};
+
+static int wf_max6690_get(struct wf_sensor *sr, s32 *value)
+{
+	struct wf_6690_sensor *max = wf_to_6690(sr);
+	s32 data;
+
+	if (max->i2c.adapter == NULL)
+		return -ENODEV;
+
+	/* chip gets initialized by firmware */
+	data = i2c_smbus_read_byte_data(&max->i2c, MAX6690_EXTERNAL_TEMP);
+	if (data < 0)
+		return data;
+	*value = data << 16;
+	return 0;
+}
+
+static void wf_max6690_release(struct wf_sensor *sr)
+{
+	struct wf_6690_sensor *max = wf_to_6690(sr);
+
+	if (max->i2c.adapter) {
+		i2c_detach_client(&max->i2c);
+		max->i2c.adapter = NULL;
+	}
+	kfree(max);
+}
+
+static struct wf_sensor_ops wf_max6690_ops = {
+	.get_value	= wf_max6690_get,
+	.release	= wf_max6690_release,
+	.owner		= THIS_MODULE,
+};
+
+static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr)
+{
+	struct wf_6690_sensor *max;
+	char *name = "u4-temp";
+
+	max = kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
+	if (max == NULL) {
+		printk(KERN_ERR "windfarm: Couldn't create MAX6690 sensor %s: "
+		       "no memory\n", name);
+		return;
+	}
+
+	max->sens.ops = &wf_max6690_ops;
+	max->sens.name = name;
+	max->i2c.addr = addr >> 1;
+	max->i2c.adapter = adapter;
+	max->i2c.driver = &wf_max6690_driver;
+	strncpy(max->i2c.name, name, I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&max->i2c)) {
+		printk(KERN_ERR "windfarm: failed to attach MAX6690 sensor\n");
+		goto fail;
+	}
+
+	if (wf_register_sensor(&max->sens)) {
+		i2c_detach_client(&max->i2c);
+		goto fail;
+	}
+
+	return;
+
+ fail:
+	kfree(max);
+}
+
+static int wf_max6690_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev = NULL;
+	struct pmac_i2c_bus *bus;
+	const char *loc;
+	u32 *reg;
+
+	bus = pmac_i2c_adapter_to_bus(adapter);
+	if (bus == NULL)
+		return -ENODEV;
+	busnode = pmac_i2c_get_bus_node(bus);
+
+	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
+		if (!device_is_compatible(dev, "max6690"))
+			continue;
+		loc = get_property(dev, "hwsensor-location", NULL);
+		reg = (u32 *) get_property(dev, "reg", NULL);
+		if (!loc || !reg)
+			continue;
+		printk("found max6690, loc=%s reg=%x\n", loc, *reg);
+		if (strcmp(loc, "BACKSIDE"))
+			continue;
+		wf_max6690_create(adapter, *reg);
+	}
+
+	return 0;
+}
+
+static int wf_max6690_detach(struct i2c_client *client)
+{
+	struct wf_6690_sensor *max = i2c_to_6690(client);
+
+	max->i2c.adapter = NULL;
+	wf_unregister_sensor(&max->sens);
+
+	return 0;
+}
+
+static int __init wf_max6690_sensor_init(void)
+{
+	return i2c_add_driver(&wf_max6690_driver);
+}
+
+static void __exit wf_max6690_sensor_exit(void)
+{
+	i2c_del_driver(&wf_max6690_driver);
+}
+
+module_init(wf_max6690_sensor_init);
+module_exit(wf_max6690_sensor_exit);
+
+MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
+MODULE_DESCRIPTION("MAX6690 sensor objects for PowerMac thermal control");
+MODULE_LICENSE("GPL");
Index: linux-work/drivers/macintosh/windfarm_pid.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pid.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pid.c	2006-02-07 13:45:57.000000000 +1100
@@ -88,8 +88,8 @@ EXPORT_SYMBOL_GPL(wf_cpu_pid_init);
 
 s32 wf_cpu_pid_run(struct wf_cpu_pid_state *st, s32 new_power, s32 new_temp)
 {
-	s64	error, integ, deriv, prop;
-	s32	target, sval, adj;
+	s64	integ, deriv, prop;
+	s32	error, target, sval, adj;
 	int	i, hlen = st->param.history_len;
 
 	/* Calculate error term */
@@ -117,7 +117,7 @@ s32 wf_cpu_pid_run(struct wf_cpu_pid_sta
 		integ += st->errors[(st->index + hlen - i) % hlen];
 	integ *= st->param.interval;
 	integ *= st->param.gr;
-	sval = st->param.tmax - ((integ >> 20) & 0xffffffff);
+	sval = st->param.tmax - (s32)(integ >> 20);
 	adj = min(st->param.ttarget, sval);
 
 	DBG("integ: %lx, sval: %lx, adj: %lx\n", integ, sval, adj);
@@ -129,7 +129,7 @@ s32 wf_cpu_pid_run(struct wf_cpu_pid_sta
 	deriv *= st->param.gd;
 
 	/* Calculate proportional term */
-	prop = (new_temp - adj);
+	prop = st->last_delta = (new_temp - adj);
 	prop *= st->param.gp;
 
 	DBG("deriv: %lx, prop: %lx\n", deriv, prop);
Index: linux-work/drivers/macintosh/windfarm_pid.h
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pid.h	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pid.h	2006-02-07 13:45:57.000000000 +1100
@@ -72,6 +72,7 @@ struct wf_cpu_pid_state {
 	int	index; 				/* index of current power */
 	int	tindex; 			/* index of current temp */
 	s32	target;				/* current target value */
+	s32	last_delta;			/* last Tactual - Ttarget */
 	s32	powers[WF_PID_MAX_HISTORY];	/* power history buffer */
 	s32	errors[WF_PID_MAX_HISTORY];	/* error history buffer */
 	s32	temps[2];			/* temp. history buffer */
Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-02-08 16:28:38.000000000 +1100
@@ -0,0 +1,698 @@
+/*
+ * Windfarm PowerMac thermal control.
+ * Control loops for machines with SMU and PPC970MP processors.
+ *
+ * Copyright (C) 2005 Paul Mackerras, IBM Corp. <paulus@samba.org>
+ * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * Use and redistribute under the terms of the GNU GPL v2.
+ */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <asm/prom.h>
+#include <asm/smu.h>
+
+#include "windfarm.h"
+#include "windfarm_pid.h"
+
+#define VERSION "0.2"
+
+#define DEBUG
+#undef LOTSA_DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+#ifdef LOTSA_DEBUG
+#define DBG_LOTS(args...)	printk(args)
+#else
+#define DBG_LOTS(args...)	do { } while(0)
+#endif
+
+/* define this to force CPU overtemp to 60 degree, useful for testing
+ * the overtemp code
+ */
+#undef HACKED_OVERTEMP
+
+/* We currently only handle 2 chips, 4 cores... */
+#define NR_CHIPS	2
+#define NR_CORES	4
+#define NR_CPU_FANS	3 * NR_CHIPS
+
+/* Controls and sensors */
+static struct wf_sensor *sens_cpu_temp[NR_CORES];
+static struct wf_sensor *sens_cpu_power[NR_CORES];
+static struct wf_sensor *hd_temp;
+static struct wf_sensor *slots_power;
+static struct wf_sensor *u4_temp;
+
+static struct wf_control *cpu_fans[NR_CPU_FANS];
+static char *cpu_fan_names[NR_CPU_FANS] = {
+	"cpu-rear-fan-0",
+	"cpu-rear-fan-1",
+	"cpu-front-fan-0",
+	"cpu-front-fan-1",
+	"cpu-pump-0",
+	"cpu-pump-1",
+};
+static struct wf_control *cpufreq_clamp;
+
+/* Second pump isn't required (and isn't actually present) */
+#define CPU_FANS_REQD		(NR_CPU_FANS - 2)
+#define FIRST_PUMP		4
+#define LAST_PUMP		5
+
+/* We keep a temperature history for average calculation of 180s */
+#define CPU_TEMP_HIST_SIZE	180
+
+/* Scale factor for fan speed, *100 */
+static int cpu_fan_scale[NR_CPU_FANS] = {
+	100,
+	100,
+	97,		/* inlet fans run at 97% of exhaust fan */
+	97,
+	100,		/* updated later */
+	100,		/* updated later */
+};
+
+static struct wf_control *backside_fan;
+static struct wf_control *slots_fan;
+static struct wf_control *drive_bay_fan;
+
+/* PID loop state */
+static struct wf_cpu_pid_state cpu_pid[NR_CORES];
+static u32 cpu_thist[CPU_TEMP_HIST_SIZE];
+static int cpu_thist_pt;
+static s64 cpu_thist_total;
+static s32 cpu_all_tmax = 100 << 16;
+static int cpu_last_target;
+static struct wf_pid_state backside_pid;
+static int backside_tick;
+static struct wf_pid_state slots_pid;
+static int slots_started;
+static struct wf_pid_state drive_bay_pid;
+static int drive_bay_tick;
+
+static int nr_cores;
+static int have_all_controls;
+static int have_all_sensors;
+static int started;
+
+static int failure_state;
+#define FAILURE_SENSOR		1
+#define FAILURE_FAN		2
+#define FAILURE_PERM		4
+#define FAILURE_LOW_OVERTEMP	8
+#define FAILURE_HIGH_OVERTEMP	16
+
+/* Overtemp values */
+#define LOW_OVER_AVERAGE	0
+#define LOW_OVER_IMMEDIATE	(10 << 16)
+#define LOW_OVER_CLEAR		((-10) << 16)
+#define HIGH_OVER_IMMEDIATE	(14 << 16)
+#define HIGH_OVER_AVERAGE	(10 << 16)
+#define HIGH_OVER_IMMEDIATE	(14 << 16)
+
+
+/* Implementation... */
+static int create_cpu_loop(int cpu)
+{
+	int chip = cpu / 2;
+	int core = cpu & 1;
+	struct smu_sdbp_header *hdr;
+	struct smu_sdbp_cpupiddata *piddata;
+	struct wf_cpu_pid_param pid;
+	struct wf_control *main_fan = cpu_fans[0];
+	s32 tmax;
+	int fmin;
+
+	/* Get PID params from the appropriate SAT */
+	hdr = smu_sat_get_sdb_partition(chip, 0xC8 + core, NULL);
+	if (hdr == NULL) {
+		printk(KERN_WARNING"windfarm: can't get CPU PID fan config\n");
+		return -EINVAL;
+	}
+	piddata = (struct smu_sdbp_cpupiddata *)&hdr[1];
+
+	/* Get FVT params to get Tmax; if not found, assume default */
+	hdr = smu_sat_get_sdb_partition(chip, 0xC4 + core, NULL);
+	if (hdr) {
+		struct smu_sdbp_fvt *fvt = (struct smu_sdbp_fvt *)&hdr[1];
+		tmax = fvt->maxtemp << 16;
+	} else
+		tmax = 95 << 16;	/* default to 95 degrees C */
+
+	/* We keep a global tmax for overtemp calculations */
+	if (tmax < cpu_all_tmax)
+		cpu_all_tmax = tmax;
+
+	/*
+	 * Darwin has a minimum fan speed of 1000 rpm for the 4-way and
+	 * 515 for the 2-way.  That appears to be overkill, so for now,
+	 * impose a minimum of 750 or 515.
+	 */
+	fmin = (nr_cores > 2) ? 750 : 515;
+
+	/* Initialize PID loop */
+	pid.interval = 1;	/* seconds */
+	pid.history_len = piddata->history_len;
+	pid.gd = piddata->gd;
+	pid.gp = piddata->gp;
+	pid.gr = piddata->gr / piddata->history_len;
+	pid.pmaxadj = (piddata->max_power << 16) - (piddata->power_adj << 8);
+	pid.ttarget = tmax - (piddata->target_temp_delta << 16);
+	pid.tmax = tmax;
+	pid.min = main_fan->ops->get_min(main_fan);
+	pid.max = main_fan->ops->get_max(main_fan);
+	if (pid.min < fmin)
+		pid.min = fmin;
+
+	wf_cpu_pid_init(&cpu_pid[cpu], &pid);
+	return 0;
+}
+
+static void cpu_max_all_fans(void)
+{
+	int i;
+
+	/* We max all CPU fans in case of a sensor error. We also do the
+	 * cpufreq clamping now, even if it's supposedly done later by the
+	 * generic code anyway, we do it earlier here to react faster
+	 */
+	if (cpufreq_clamp)
+		wf_control_set_max(cpufreq_clamp);
+	for (i = 0; i < NR_CPU_FANS; ++i)
+		if (cpu_fans[i])
+			wf_control_set_max(cpu_fans[i]);
+}
+
+static int cpu_check_overtemp(s32 temp)
+{
+	int new_state = 0;
+	s32 t_avg, t_old;
+
+	/* First check for immediate overtemps */
+	if (temp >= (cpu_all_tmax + LOW_OVER_IMMEDIATE)) {
+		new_state |= FAILURE_LOW_OVERTEMP;
+		if ((failure_state & FAILURE_LOW_OVERTEMP) == 0)
+			printk(KERN_ERR "windfarm: Overtemp due to immediate CPU"
+			       " temperature !\n");
+	}
+	if (temp >= (cpu_all_tmax + HIGH_OVER_IMMEDIATE)) {
+		new_state |= FAILURE_HIGH_OVERTEMP;
+		if ((failure_state & FAILURE_HIGH_OVERTEMP) == 0)
+			printk(KERN_ERR "windfarm: Critical overtemp due to"
+			       " immediate CPU temperature !\n");
+	}
+
+	/* We calculate a history of max temperatures and use that for the
+	 * overtemp management
+	 */
+	t_old = cpu_thist[cpu_thist_pt];
+	cpu_thist[cpu_thist_pt] = temp;
+	cpu_thist_pt = (cpu_thist_pt + 1) % CPU_TEMP_HIST_SIZE;
+	cpu_thist_total -= t_old;
+	cpu_thist_total += temp;
+	t_avg = cpu_thist_total / CPU_TEMP_HIST_SIZE;
+
+	DBG_LOTS("t_avg = %d.%03d (out: %d.%03d, in: %d.%03d)\n",
+		 FIX32TOPRINT(t_avg), FIX32TOPRINT(t_old), FIX32TOPRINT(temp));
+
+	/* Now check for average overtemps */
+	if (t_avg >= (cpu_all_tmax + LOW_OVER_AVERAGE)) {
+		new_state |= FAILURE_LOW_OVERTEMP;
+		if ((failure_state & FAILURE_LOW_OVERTEMP) == 0)
+			printk(KERN_ERR "windfarm: Overtemp due to average CPU"
+			       " temperature !\n");
+	}
+	if (t_avg >= (cpu_all_tmax + HIGH_OVER_AVERAGE)) {
+		new_state |= FAILURE_HIGH_OVERTEMP;
+		if ((failure_state & FAILURE_HIGH_OVERTEMP) == 0)
+			printk(KERN_ERR "windfarm: Critical overtemp due to"
+			       " average CPU temperature !\n");
+	}
+
+	/* Now handle overtemp conditions. We don't currently use the windfarm
+	 * overtemp handling core as it's not fully suited to the needs of those
+	 * new machine. This will be fixed later.
+	 */
+	if (new_state) {
+		/* High overtemp -> immediate shutdown */
+		if (new_state & FAILURE_HIGH_OVERTEMP)
+			machine_power_off();
+		if ((failure_state & new_state) != new_state)
+			cpu_max_all_fans();
+		failure_state |= new_state;
+	} else if ((failure_state & FAILURE_LOW_OVERTEMP) &&
+		   (temp < (cpu_all_tmax + LOW_OVER_CLEAR))) {
+		printk(KERN_ERR "windfarm: Overtemp condition cleared !\n");
+		failure_state &= ~FAILURE_LOW_OVERTEMP;
+	}
+
+	return failure_state & (FAILURE_LOW_OVERTEMP | FAILURE_HIGH_OVERTEMP);
+}
+
+static void cpu_fans_tick(void)
+{
+	int err, cpu;
+	s32 greatest_delta = 0;
+	s32 temp, power, t_max = 0;
+	int i, t, target = 0;
+	struct wf_sensor *sr;
+	struct wf_control *ct;
+	struct wf_cpu_pid_state *sp;
+
+	DBG_LOTS(KERN_DEBUG);
+	for (cpu = 0; cpu < nr_cores; ++cpu) {
+		/* Get CPU core temperature */
+		sr = sens_cpu_temp[cpu];
+		err = sr->ops->get_value(sr, &temp);
+		if (err) {
+			DBG("\n");
+			printk(KERN_WARNING "windfarm: CPU %d temperature "
+			       "sensor error %d\n", cpu, err);
+			failure_state |= FAILURE_SENSOR;
+			cpu_max_all_fans();
+			return;
+		}
+
+		/* Keep track of highest temp */
+		t_max = max(t_max, temp);
+
+		/* Get CPU power */
+		sr = sens_cpu_power[cpu];
+		err = sr->ops->get_value(sr, &power);
+		if (err) {
+			DBG("\n");
+			printk(KERN_WARNING "windfarm: CPU %d power "
+			       "sensor error %d\n", cpu, err);
+			failure_state |= FAILURE_SENSOR;
+			cpu_max_all_fans();
+			return;
+		}
+
+		/* Run PID */
+		sp = &cpu_pid[cpu];
+		t = wf_cpu_pid_run(sp, power, temp);
+
+		if (cpu == 0 || sp->last_delta > greatest_delta) {
+			greatest_delta = sp->last_delta;
+			target = t;
+		}
+		DBG_LOTS("[%d] P=%d.%.3d T=%d.%.3d ",
+		    cpu, FIX32TOPRINT(power), FIX32TOPRINT(temp));
+	}
+	DBG_LOTS("fans = %d, t_max = %d.%03d\n", target, FIX32TOPRINT(t_max));
+
+	/* Darwin limits decrease to 20 per iteration */
+	if (target < (cpu_last_target - 20))
+		target = cpu_last_target - 20;
+	cpu_last_target = target;
+	for (cpu = 0; cpu < nr_cores; ++cpu)
+		cpu_pid[cpu].target = target;
+
+	/* Handle possible overtemps */
+	if (cpu_check_overtemp(t_max))
+		return;
+
+	/* Set fans */
+	for (i = 0; i < NR_CPU_FANS; ++i) {
+		ct = cpu_fans[i];
+		if (ct == NULL)
+			continue;
+		err = ct->ops->set_value(ct, target * cpu_fan_scale[i] / 100);
+		if (err) {
+			printk(KERN_WARNING "windfarm: fan %s reports "
+			       "error %d\n", ct->name, err);
+			failure_state |= FAILURE_FAN;
+			break;
+		}
+	}
+}
+
+/* Backside/U4 fan */
+static struct wf_pid_param backside_param = {
+	.interval	= 5,
+	.history_len	= 2,
+	.gd		= 48 << 20,
+	.gp		= 5 << 20,
+	.gr		= 0,
+	.itarget	= 64 << 16,
+	.additive	= 1,
+};
+
+static void backside_fan_tick(void)
+{
+	s32 temp;
+	int speed;
+	int err;
+
+	if (!backside_fan || !u4_temp)
+		return;
+	if (!backside_tick) {
+		/* first time; initialize things */
+		backside_param.min = backside_fan->ops->get_min(backside_fan);
+		backside_param.max = backside_fan->ops->get_max(backside_fan);
+		wf_pid_init(&backside_pid, &backside_param);
+		backside_tick = 1;
+	}
+	if (--backside_tick > 0)
+		return;
+	backside_tick = backside_pid.param.interval;
+
+	err = u4_temp->ops->get_value(u4_temp, &temp);
+	if (err) {
+		printk(KERN_WARNING "windfarm: U4 temp sensor error %d\n",
+		       err);
+		failure_state |= FAILURE_SENSOR;
+		wf_control_set_max(backside_fan);
+		return;
+	}
+	speed = wf_pid_run(&backside_pid, temp);
+	DBG_LOTS("backside PID temp=%d.%.3d speed=%d\n",
+		 FIX32TOPRINT(temp), speed);
+
+	err = backside_fan->ops->set_value(backside_fan, speed);
+	if (err) {
+		printk(KERN_WARNING "windfarm: backside fan error %d\n", err);
+		failure_state |= FAILURE_FAN;
+	}
+}
+
+/* Drive bay fan */
+static struct wf_pid_param drive_bay_prm = {
+	.interval	= 5,
+	.history_len	= 2,
+	.gd		= 30 << 20,
+	.gp		= 5 << 20,
+	.gr		= 0,
+	.itarget	= 40 << 16,
+	.additive	= 1,
+};
+
+static void drive_bay_fan_tick(void)
+{
+	s32 temp;
+	int speed;
+	int err;
+
+	if (!drive_bay_fan || !hd_temp)
+		return;
+	if (!drive_bay_tick) {
+		/* first time; initialize things */
+		drive_bay_prm.min = drive_bay_fan->ops->get_min(drive_bay_fan);
+		drive_bay_prm.max = drive_bay_fan->ops->get_max(drive_bay_fan);
+		wf_pid_init(&drive_bay_pid, &drive_bay_prm);
+		drive_bay_tick = 1;
+	}
+	if (--drive_bay_tick > 0)
+		return;
+	drive_bay_tick = drive_bay_pid.param.interval;
+
+	err = hd_temp->ops->get_value(hd_temp, &temp);
+	if (err) {
+		printk(KERN_WARNING "windfarm: drive bay temp sensor "
+		       "error %d\n", err);
+		failure_state |= FAILURE_SENSOR;
+		wf_control_set_max(drive_bay_fan);
+		return;
+	}
+	speed = wf_pid_run(&drive_bay_pid, temp);
+	DBG_LOTS("drive_bay PID temp=%d.%.3d speed=%d\n",
+		 FIX32TOPRINT(temp), speed);
+
+	err = drive_bay_fan->ops->set_value(drive_bay_fan, speed);
+	if (err) {
+		printk(KERN_WARNING "windfarm: drive bay fan error %d\n", err);
+		failure_state |= FAILURE_FAN;
+	}
+}
+
+/* PCI slots area fan */
+/* This makes the fan speed proportional to the power consumed */
+static struct wf_pid_param slots_param = {
+	.interval	= 1,
+	.history_len	= 2,
+	.gd		= 0,
+	.gp		= 0,
+	.gr		= 0x1277952,
+	.itarget	= 0,
+	.min		= 1560,
+	.max		= 3510,
+};
+
+static void slots_fan_tick(void)
+{
+	s32 power;
+	int speed;
+	int err;
+
+	if (!slots_fan || !slots_power)
+		return;
+	if (!slots_started) {
+		/* first time; initialize things */
+		wf_pid_init(&slots_pid, &slots_param);
+		slots_started = 1;
+	}
+
+	err = slots_power->ops->get_value(slots_power, &power);
+	if (err) {
+		printk(KERN_WARNING "windfarm: slots power sensor error %d\n",
+		       err);
+		failure_state |= FAILURE_SENSOR;
+		wf_control_set_max(slots_fan);
+		return;
+	}
+	speed = wf_pid_run(&slots_pid, power);
+	DBG_LOTS("slots PID power=%d.%.3d speed=%d\n",
+		 FIX32TOPRINT(power), speed);
+
+	err = slots_fan->ops->set_value(slots_fan, speed);
+	if (err) {
+		printk(KERN_WARNING "windfarm: slots fan error %d\n", err);
+		failure_state |= FAILURE_FAN;
+	}
+}
+
+static void set_fail_state(void)
+{
+	int i;
+
+	if (cpufreq_clamp)
+		wf_control_set_max(cpufreq_clamp);
+	for (i = 0; i < NR_CPU_FANS; ++i)
+		if (cpu_fans[i])
+			wf_control_set_max(cpu_fans[i]);
+	if (backside_fan)
+		wf_control_set_max(backside_fan);
+	if (slots_fan)
+		wf_control_set_max(slots_fan);
+	if (drive_bay_fan)
+		wf_control_set_max(drive_bay_fan);
+}
+
+static void pm112_tick(void)
+{
+	int i, last_failure;
+
+	if (!started) {
+		started = 1;
+		for (i = 0; i < nr_cores; ++i) {
+			if (create_cpu_loop(i) < 0) {
+				failure_state = FAILURE_PERM;
+				set_fail_state();
+				break;
+			}
+		}
+		DBG_LOTS("cpu_all_tmax=%d.%03d\n", FIX32TOPRINT(cpu_all_tmax));
+
+#ifdef HACKED_OVERTEMP
+		cpu_all_tmax = 60 << 16;
+#endif
+	}
+
+	/* Permanent failure, bail out */
+	if (failure_state & FAILURE_PERM)
+		return;
+	/* Clear all failure bits except low overtemp which will be eventually
+	 * cleared by the control loop itself
+	 */
+	last_failure = failure_state;
+	failure_state &= FAILURE_LOW_OVERTEMP;
+	cpu_fans_tick();
+	backside_fan_tick();
+	slots_fan_tick();
+	drive_bay_fan_tick();
+
+	DBG_LOTS("last_failure: 0x%x, failure_state: %x\n",
+		 last_failure, failure_state);
+
+	/* Check for failures. Any failure causes cpufreq clamping */
+	if (failure_state && last_failure == 0 && cpufreq_clamp)
+		wf_control_set_max(cpufreq_clamp);
+	if (failure_state == 0 && last_failure && cpufreq_clamp)
+		wf_control_set_min(cpufreq_clamp);
+
+	/* That's it for now, we might want to deal with other failures
+	 * differently in the future though
+	 */
+}
+
+static void pm112_new_control(struct wf_control *ct)
+{
+	int i, max_exhaust;
+
+	if (cpufreq_clamp == NULL && !strcmp(ct->name, "cpufreq-clamp")) {
+		if (wf_get_control(ct) == 0)
+			cpufreq_clamp = ct;
+	}
+
+	for (i = 0; i < NR_CPU_FANS; ++i) {
+		if (!strcmp(ct->name, cpu_fan_names[i])) {
+			if (cpu_fans[i] == NULL && wf_get_control(ct) == 0)
+				cpu_fans[i] = ct;
+			break;
+		}
+	}
+	if (i >= NR_CPU_FANS) {
+		/* not a CPU fan, try the others */
+		if (!strcmp(ct->name, "backside-fan")) {
+			if (backside_fan == NULL && wf_get_control(ct) == 0)
+				backside_fan = ct;
+		} else if (!strcmp(ct->name, "slots-fan")) {
+			if (slots_fan == NULL && wf_get_control(ct) == 0)
+				slots_fan = ct;
+		} else if (!strcmp(ct->name, "drive-bay-fan")) {
+			if (drive_bay_fan == NULL && wf_get_control(ct) == 0)
+				drive_bay_fan = ct;
+		}
+		return;
+	}
+
+	for (i = 0; i < CPU_FANS_REQD; ++i)
+		if (cpu_fans[i] == NULL)
+			return;
+
+	/* work out pump scaling factors */
+	max_exhaust = cpu_fans[0]->ops->get_max(cpu_fans[0]);
+	for (i = FIRST_PUMP; i <= LAST_PUMP; ++i)
+		if ((ct = cpu_fans[i]) != NULL)
+			cpu_fan_scale[i] =
+				ct->ops->get_max(ct) * 100 / max_exhaust;
+
+	have_all_controls = 1;
+}
+
+static void pm112_new_sensor(struct wf_sensor *sr)
+{
+	unsigned int i;
+
+	if (have_all_sensors)
+		return;
+	if (!strncmp(sr->name, "cpu-temp-", 9)) {
+		i = sr->name[9] - '0';
+		if (sr->name[10] == 0 && i < NR_CORES &&
+		    sens_cpu_temp[i] == NULL && wf_get_sensor(sr) == 0)
+			sens_cpu_temp[i] = sr;
+
+	} else if (!strncmp(sr->name, "cpu-power-", 10)) {
+		i = sr->name[10] - '0';
+		if (sr->name[11] == 0 && i < NR_CORES &&
+		    sens_cpu_power[i] == NULL && wf_get_sensor(sr) == 0)
+			sens_cpu_power[i] = sr;
+	} else if (!strcmp(sr->name, "hd-temp")) {
+		if (hd_temp == NULL && wf_get_sensor(sr) == 0)
+			hd_temp = sr;
+	} else if (!strcmp(sr->name, "slots-power")) {
+		if (slots_power == NULL && wf_get_sensor(sr) == 0)
+			slots_power = sr;
+	} else if (!strcmp(sr->name, "u4-temp")) {
+		if (u4_temp == NULL && wf_get_sensor(sr) == 0)
+			u4_temp = sr;
+	} else
+		return;
+
+	/* check if we have all the sensors we need */
+	for (i = 0; i < nr_cores; ++i)
+		if (sens_cpu_temp[i] == NULL || sens_cpu_power[i] == NULL)
+			return;
+
+	have_all_sensors = 1;
+}
+
+static int pm112_wf_notify(struct notifier_block *self,
+			   unsigned long event, void *data)
+{
+	switch (event) {
+	case WF_EVENT_NEW_SENSOR:
+		pm112_new_sensor(data);
+		break;
+	case WF_EVENT_NEW_CONTROL:
+		pm112_new_control(data);
+		break;
+	case WF_EVENT_TICK:
+		if (have_all_controls && have_all_sensors)
+			pm112_tick();
+	}
+	return 0;
+}
+
+static struct notifier_block pm112_events = {
+	.notifier_call = pm112_wf_notify,
+};
+
+static int wf_pm112_probe(struct device *dev)
+{
+	wf_register_client(&pm112_events);
+	return 0;
+}
+
+static int wf_pm112_remove(struct device *dev)
+{
+	wf_unregister_client(&pm112_events);
+	/* should release all sensors and controls */
+	return 0;
+}
+
+static struct device_driver wf_pm112_driver = {
+	.name = "windfarm",
+	.bus = &platform_bus_type,
+	.probe = wf_pm112_probe,
+	.remove = wf_pm112_remove,
+};
+
+static int __init wf_pm112_init(void)
+{
+	struct device_node *cpu;
+
+	if (!machine_is_compatible("PowerMac11,2"))
+		return -ENODEV;
+
+	/* Count the number of CPU cores */
+	nr_cores = 0;
+	for (cpu = NULL; (cpu = of_find_node_by_type(cpu, "cpu")) != NULL; )
+		++nr_cores;
+
+	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
+	driver_register(&wf_pm112_driver);
+	return 0;
+}
+
+static void __exit wf_pm112_exit(void)
+{
+	driver_unregister(&wf_pm112_driver);
+}
+
+module_init(wf_pm112_init);
+module_exit(wf_pm112_exit);
+
+MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
+MODULE_DESCRIPTION("Thermal control for PowerMac11,2");
+MODULE_LICENSE("GPL");
Index: linux-work/drivers/macintosh/windfarm_smu_controls.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_smu_controls.c	2006-01-12 16:33:08.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_smu_controls.c	2006-02-07 13:45:57.000000000 +1100
@@ -24,7 +24,7 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.3"
+#define VERSION "0.4"
 
 #undef DEBUG
 
@@ -34,6 +34,8 @@
 #define DBG(args...)	do { } while(0)
 #endif
 
+static int smu_supports_new_fans_ops = 1;
+
 /*
  * SMU fans control object
  */
@@ -59,23 +61,49 @@ static int smu_set_fan(int pwm, u8 id, u
 
 	/* Fill SMU command structure */
 	cmd.cmd = SMU_CMD_FAN_COMMAND;
-	cmd.data_len = 14;
+
+	/* The SMU has an "old" and a "new" way of setting the fan speed
+	 * Unfortunately, I found no reliable way to know which one works
+	 * on a given machine model. After some investigations it appears
+	 * that MacOS X just tries the new one, and if it fails fallbacks
+	 * to the old ones ... Ugh.
+	 */
+ retry:
+	if (smu_supports_new_fans_ops) {
+		buffer[0] = 0x30;
+		buffer[1] = id;
+		*((u16 *)(&buffer[2])) = value;
+		cmd.data_len = 4;
+	} else {
+		if (id > 7)
+			return -EINVAL;
+		/* Fill argument buffer */
+		memset(buffer, 0, 16);
+		buffer[0] = pwm ? 0x10 : 0x00;
+		buffer[1] = 0x01 << id;
+		*((u16 *)&buffer[2 + id * 2]) = value;
+		cmd.data_len = 14;
+	}
+
 	cmd.reply_len = 16;
 	cmd.data_buf = cmd.reply_buf = buffer;
 	cmd.status = 0;
 	cmd.done = smu_done_complete;
 	cmd.misc = &comp;
 
-	/* Fill argument buffer */
-	memset(buffer, 0, 16);
-	buffer[0] = pwm ? 0x10 : 0x00;
-	buffer[1] = 0x01 << id;
-	*((u16 *)&buffer[2 + id * 2]) = value;
-
 	rc = smu_queue_cmd(&cmd);
 	if (rc)
 		return rc;
 	wait_for_completion(&comp);
+
+	/* Handle fallback (see coment above) */
+	if (cmd.status != 0 && smu_supports_new_fans_ops) {
+		printk(KERN_WARNING "windfarm: SMU failed new fan command "
+		       "falling back to old method\n");
+		smu_supports_new_fans_ops = 0;
+		goto retry;
+	}
+
 	return cmd.status;
 }
 
@@ -158,19 +186,29 @@ static struct smu_fan_control *smu_fan_c
 
 	/* Names used on desktop models */
 	if (!strcmp(l, "Rear Fan 0") || !strcmp(l, "Rear Fan") ||
-	    !strcmp(l, "Rear fan 0") || !strcmp(l, "Rear fan"))
+	    !strcmp(l, "Rear fan 0") || !strcmp(l, "Rear fan") ||
+	    !strcmp(l, "CPU A EXHAUST"))
 		fct->ctrl.name = "cpu-rear-fan-0";
-	else if (!strcmp(l, "Rear Fan 1") || !strcmp(l, "Rear fan 1"))
+	else if (!strcmp(l, "Rear Fan 1") || !strcmp(l, "Rear fan 1") ||
+		 !strcmp(l, "CPU B EXHAUST"))
 		fct->ctrl.name = "cpu-rear-fan-1";
 	else if (!strcmp(l, "Front Fan 0") || !strcmp(l, "Front Fan") ||
-		 !strcmp(l, "Front fan 0") || !strcmp(l, "Front fan"))
+		 !strcmp(l, "Front fan 0") || !strcmp(l, "Front fan") ||
+		 !strcmp(l, "CPU A INTAKE"))
 		fct->ctrl.name = "cpu-front-fan-0";
-	else if (!strcmp(l, "Front Fan 1") || !strcmp(l, "Front fan 1"))
+	else if (!strcmp(l, "Front Fan 1") || !strcmp(l, "Front fan 1") ||
+		 !strcmp(l, "CPU B INTAKE"))
 		fct->ctrl.name = "cpu-front-fan-1";
-	else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan"))
+	else if (!strcmp(l, "CPU A PUMP"))
+		fct->ctrl.name = "cpu-pump-0";
+	else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan") ||
+		 !strcmp(l, "EXPANSION SLOTS INTAKE"))
 		fct->ctrl.name = "slots-fan";
-	else if (!strcmp(l, "Drive Bay") || !strcmp(l, "Drive bay"))
+	else if (!strcmp(l, "Drive Bay") || !strcmp(l, "Drive bay") ||
+		 !strcmp(l, "DRIVE BAY A INTAKE"))
 		fct->ctrl.name = "drive-bay-fan";
+	else if (!strcmp(l, "BACKSIDE"))
+		fct->ctrl.name = "backside-fan";
 
 	/* Names used on iMac models */
 	if (!strcmp(l, "System Fan") || !strcmp(l, "System fan"))
@@ -223,7 +261,8 @@ static int __init smu_controls_init(void
 
 	/* Look for RPM fans */
 	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
-		if (!strcmp(fans->name, "rpm-fans"))
+		if (!strcmp(fans->name, "rpm-fans") ||
+		    device_is_compatible(fans, "smu-rpm-fans"))
 			break;
 	for (fan = NULL;
 	     fans && (fan = of_get_next_child(fans, fan)) != NULL;) {
Index: linux-work/drivers/macintosh/windfarm_smu_sensors.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_smu_sensors.c	2006-01-12 16:33:08.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_smu_sensors.c	2006-02-07 13:45:57.000000000 +1100
@@ -220,14 +220,29 @@ static struct smu_ad_sensor *smu_ads_cre
 	    !strcmp(l, "CPU T-Diode")) {
 		ads->sens.ops = &smu_cputemp_ops;
 		ads->sens.name = "cpu-temp";
+		if (cpudiode == NULL) {
+			DBG("wf: cpudiode partition (%02x) not found\n",
+			    SMU_SDB_CPUDIODE_ID);
+			goto fail;
+		}
 	} else if (!strcmp(c, "current-sensor") &&
 		   !strcmp(l, "CPU Current")) {
 		ads->sens.ops = &smu_cpuamp_ops;
 		ads->sens.name = "cpu-current";
+		if (cpuvcp == NULL) {
+			DBG("wf: cpuvcp partition (%02x) not found\n",
+			    SMU_SDB_CPUVCP_ID);
+			goto fail;
+		}
 	} else if (!strcmp(c, "voltage-sensor") &&
 		   !strcmp(l, "CPU Voltage")) {
 		ads->sens.ops = &smu_cpuvolt_ops;
 		ads->sens.name = "cpu-voltage";
+		if (cpuvcp == NULL) {
+			DBG("wf: cpuvcp partition (%02x) not found\n",
+			    SMU_SDB_CPUVCP_ID);
+			goto fail;
+		}
 	} else if (!strcmp(c, "power-sensor") &&
 		   !strcmp(l, "Slots Power")) {
 		ads->sens.ops = &smu_slotspow_ops;
@@ -365,29 +380,22 @@ smu_cpu_power_create(struct wf_sensor *v
 	return NULL;
 }
 
-static int smu_fetch_param_partitions(void)
+static void smu_fetch_param_partitions(void)
 {
 	struct smu_sdbp_header *hdr;
 
 	/* Get CPU voltage/current/power calibration data */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUVCP_ID, NULL);
-	if (hdr == NULL) {
-		DBG("wf: cpuvcp partition (%02x) not found\n",
-		    SMU_SDB_CPUVCP_ID);
-		return -ENODEV;
+	if (hdr != NULL) {
+		cpuvcp = (struct smu_sdbp_cpuvcp *)&hdr[1];
+		/* Keep version around */
+		cpuvcp_version = hdr->version;
 	}
-	cpuvcp = (struct smu_sdbp_cpuvcp *)&hdr[1];
-	/* Keep version around */
-	cpuvcp_version = hdr->version;
 
 	/* Get CPU diode calibration data */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUDIODE_ID, NULL);
-	if (hdr == NULL) {
-		DBG("wf: cpudiode partition (%02x) not found\n",
-		    SMU_SDB_CPUDIODE_ID);
-		return -ENODEV;
-	}
-	cpudiode = (struct smu_sdbp_cpudiode *)&hdr[1];
+	if (hdr != NULL)
+		cpudiode = (struct smu_sdbp_cpudiode *)&hdr[1];
 
 	/* Get slots power calibration data if any */
 	hdr = smu_get_sdb_partition(SMU_SDB_SLOTSPOW_ID, NULL);
@@ -398,23 +406,18 @@ static int smu_fetch_param_partitions(vo
 	hdr = smu_get_sdb_partition(SMU_SDB_DEBUG_SWITCHES_ID, NULL);
 	if (hdr != NULL)
 		debugswitches = (u8 *)&hdr[1];
-
-	return 0;
 }
 
 static int __init smu_sensors_init(void)
 {
 	struct device_node *smu, *sensors, *s;
 	struct smu_ad_sensor *volt_sensor = NULL, *curr_sensor = NULL;
-	int rc;
 
 	if (!smu_present())
 		return -ENODEV;
 
 	/* Get parameters partitions */
-	rc = smu_fetch_param_partitions();
-	if (rc)
-		return rc;
+	smu_fetch_param_partitions();
 
 	smu = of_find_node_by_type(NULL, "smu");
 	if (smu == NULL)
Index: linux-work/drivers/macintosh/windfarm_smu_sat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/windfarm_smu_sat.c	2006-02-07 16:18:32.000000000 +1100
@@ -0,0 +1,418 @@
+/*
+ * Windfarm PowerMac thermal control.  SMU "satellite" controller sensors.
+ *
+ * Copyright (C) 2005 Paul Mackerras, IBM Corp. <paulus@samba.org>
+ *
+ * Released under the terms of the GNU GPL v2.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <asm/semaphore.h>
+#include <asm/prom.h>
+#include <asm/smu.h>
+#include <asm/pmac_low_i2c.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.2"
+
+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+/* If the cache is older than 800ms we'll refetch it */
+#define MAX_AGE		msecs_to_jiffies(800)
+
+struct wf_sat {
+	int			nr;
+	atomic_t		refcnt;
+	struct semaphore	mutex;
+	unsigned long		last_read; /* jiffies when cache last updated */
+	u8			cache[16];
+	struct i2c_client	i2c;
+	struct device_node	*node;
+};
+
+static struct wf_sat *sats[2];
+
+struct wf_sat_sensor {
+	int		index;
+	int		index2;		/* used for power sensors */
+	int		shift;
+	struct wf_sat	*sat;
+	struct wf_sensor sens;
+};
+
+#define wf_to_sat(c)	container_of(c, struct wf_sat_sensor, sens)
+#define i2c_to_sat(c)	container_of(c, struct wf_sat, i2c)
+
+static int wf_sat_attach(struct i2c_adapter *adapter);
+static int wf_sat_detach(struct i2c_client *client);
+
+static struct i2c_driver wf_sat_driver = {
+	.driver = {
+		.name		= "wf_smu_sat",
+	},
+	.attach_adapter	= wf_sat_attach,
+	.detach_client	= wf_sat_detach,
+};
+
+/*
+ * XXX i2c_smbus_read_i2c_block_data doesn't pass the requested
+ * length down to the low-level driver, so we use this, which
+ * works well enough with the SMU i2c driver code...
+ */
+static int sat_read_block(struct i2c_client *client, u8 command,
+			  u8 *values, int len)
+{
+	union i2c_smbus_data data;
+	int err;
+
+	data.block[0] = len;
+	err = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			     I2C_SMBUS_READ, command, I2C_SMBUS_I2C_BLOCK_DATA,
+			     &data);
+	if (!err)
+		memcpy(values, data.block, len);
+	return err;
+}
+
+struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
+						  unsigned int *size)
+{
+	struct wf_sat *sat;
+	int err;
+	unsigned int i, len;
+	u8 *buf;
+	u8 data[4];
+
+	/* TODO: Add the resulting partition to the device-tree */
+
+	if (sat_id > 1 || (sat = sats[sat_id]) == NULL)
+		return NULL;
+
+	err = i2c_smbus_write_word_data(&sat->i2c, 8, id << 8);
+	if (err) {
+		printk(KERN_ERR "smu_sat_get_sdb_part wr error %d\n", err);
+		return NULL;
+	}
+
+	len = i2c_smbus_read_word_data(&sat->i2c, 9);
+	if (len < 0) {
+		printk(KERN_ERR "smu_sat_get_sdb_part rd len error\n");
+		return NULL;
+	}
+	if (len == 0) {
+		printk(KERN_ERR "smu_sat_get_sdb_part no partition %x\n", id);
+		return NULL;
+	}
+
+	len = le16_to_cpu(len);
+	len = (len + 3) & ~3;
+	buf = kmalloc(len, GFP_KERNEL);
+	if (buf == NULL)
+		return NULL;
+
+	for (i = 0; i < len; i += 4) {
+		err = sat_read_block(&sat->i2c, 0xa, data, 4);
+		if (err) {
+			printk(KERN_ERR "smu_sat_get_sdb_part rd err %d\n",
+			       err);
+			goto fail;
+		}
+		buf[i] = data[1];
+		buf[i+1] = data[0];
+		buf[i+2] = data[3];
+		buf[i+3] = data[2];
+	}
+#ifdef DEBUG
+	DBG(KERN_DEBUG "sat %d partition %x:", sat_id, id);
+	for (i = 0; i < len; ++i)
+		DBG(" %x", buf[i]);
+	DBG("\n");
+#endif
+
+	if (size)
+		*size = len;
+	return (struct smu_sdbp_header *) buf;
+
+ fail:
+	kfree(buf);
+	return NULL;
+}
+
+/* refresh the cache */
+static int wf_sat_read_cache(struct wf_sat *sat)
+{
+	int err;
+
+	err = sat_read_block(&sat->i2c, 0x3f, sat->cache, 16);
+	if (err)
+		return err;
+	sat->last_read = jiffies;
+#ifdef LOTSA_DEBUG
+	{
+		int i;
+		DBG(KERN_DEBUG "wf_sat_get: data is");
+		for (i = 0; i < 16; ++i)
+			DBG(" %.2x", sat->cache[i]);
+		DBG("\n");
+	}
+#endif
+	return 0;
+}
+
+static int wf_sat_get(struct wf_sensor *sr, s32 *value)
+{
+	struct wf_sat_sensor *sens = wf_to_sat(sr);
+	struct wf_sat *sat = sens->sat;
+	int i, err;
+	s32 val;
+
+	if (sat->i2c.adapter == NULL)
+		return -ENODEV;
+
+	down(&sat->mutex);
+	if (time_after(jiffies, (sat->last_read + MAX_AGE))) {
+		err = wf_sat_read_cache(sat);
+		if (err)
+			goto fail;
+	}
+
+	i = sens->index * 2;
+	val = ((sat->cache[i] << 8) + sat->cache[i+1]) << sens->shift;
+	if (sens->index2 >= 0) {
+		i = sens->index2 * 2;
+		/* 4.12 * 8.8 -> 12.20; shift right 4 to get 16.16 */
+		val = (val * ((sat->cache[i] << 8) + sat->cache[i+1])) >> 4;
+	}
+
+	*value = val;
+	err = 0;
+
+ fail:
+	up(&sat->mutex);
+	return err;
+}
+
+static void wf_sat_release(struct wf_sensor *sr)
+{
+	struct wf_sat_sensor *sens = wf_to_sat(sr);
+	struct wf_sat *sat = sens->sat;
+
+	if (atomic_dec_and_test(&sat->refcnt)) {
+		if (sat->i2c.adapter) {
+			i2c_detach_client(&sat->i2c);
+			sat->i2c.adapter = NULL;
+		}
+		if (sat->nr >= 0)
+			sats[sat->nr] = NULL;
+		kfree(sat);
+	}
+	kfree(sens);
+}
+
+static struct wf_sensor_ops wf_sat_ops = {
+	.get_value	= wf_sat_get,
+	.release	= wf_sat_release,
+	.owner		= THIS_MODULE,
+};
+
+static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
+{
+	struct wf_sat *sat;
+	struct wf_sat_sensor *sens;
+	u32 *reg;
+	char *loc, *type;
+	u8 addr, chip, core;
+	struct device_node *child;
+	int shift, cpu, index;
+	char *name;
+	int vsens[2], isens[2];
+
+	reg = (u32 *) get_property(dev, "reg", NULL);
+	if (reg == NULL)
+		return;
+	addr = *reg;
+	DBG(KERN_DEBUG "wf_sat: creating sat at address %x\n", addr);
+
+	sat = kzalloc(sizeof(struct wf_sat), GFP_KERNEL);
+	if (sat == NULL)
+		return;
+	sat->nr = -1;
+	sat->node = of_node_get(dev);
+	atomic_set(&sat->refcnt, 0);
+	init_MUTEX(&sat->mutex);
+	sat->i2c.addr = (addr >> 1) & 0x7f;
+	sat->i2c.adapter = adapter;
+	sat->i2c.driver = &wf_sat_driver;
+	strncpy(sat->i2c.name, "smu-sat", I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&sat->i2c)) {
+		printk(KERN_ERR "windfarm: failed to attach smu-sat to i2c\n");
+		goto fail;
+	}
+
+	vsens[0] = vsens[1] = -1;
+	isens[0] = isens[1] = -1;
+	child = NULL;
+	while ((child = of_get_next_child(dev, child)) != NULL) {
+		reg = (u32 *) get_property(child, "reg", NULL);
+		type = get_property(child, "device_type", NULL);
+		loc = get_property(child, "location", NULL);
+		if (reg == NULL || loc == NULL)
+			continue;
+
+		/* the cooked sensors are between 0x30 and 0x37 */
+		if (*reg < 0x30 || *reg > 0x37)
+			continue;
+		index = *reg - 0x30;
+
+		/* expect location to be CPU [AB][01] ... */
+		if (strncmp(loc, "CPU ", 4) != 0)
+			continue;
+		chip = loc[4] - 'A';
+		core = loc[5] - '0';
+		if (chip > 1 || core > 1) {
+			printk(KERN_ERR "wf_sat_create: don't understand "
+			       "location %s for %s\n", loc, child->full_name);
+			continue;
+		}
+		cpu = 2 * chip + core;
+		if (sat->nr < 0)
+			sat->nr = chip;
+		else if (sat->nr != chip) {
+			printk(KERN_ERR "wf_sat_create: can't cope with "
+			       "multiple CPU chips on one SAT (%s)\n", loc);
+			continue;
+		}
+
+		if (strcmp(type, "voltage-sensor") == 0) {
+			name = "cpu-voltage";
+			shift = 4;
+			vsens[core] = index;
+		} else if (strcmp(type, "current-sensor") == 0) {
+			name = "cpu-current";
+			shift = 8;
+			isens[core] = index;
+		} else if (strcmp(type, "temp-sensor") == 0) {
+			name = "cpu-temp";
+			shift = 10;
+		} else
+			continue;	/* hmmm shouldn't happen */
+
+		/* the +16 is enough for "cpu-voltage-n" */
+		sens = kzalloc(sizeof(struct wf_sat_sensor) + 16, GFP_KERNEL);
+		if (sens == NULL) {
+			printk(KERN_ERR "wf_sat_create: couldn't create "
+			       "%s sensor %d (no memory)\n", name, cpu);
+			continue;
+		}
+		sens->index = index;
+		sens->index2 = -1;
+		sens->shift = shift;
+		sens->sat = sat;
+		atomic_inc(&sat->refcnt);
+		sens->sens.ops = &wf_sat_ops;
+		sens->sens.name = (char *) (sens + 1);
+		snprintf(sens->sens.name, 16, "%s-%d", name, cpu);
+
+		if (wf_register_sensor(&sens->sens)) {
+			atomic_dec(&sat->refcnt);
+			kfree(sens);
+		}
+	}
+
+	/* make the power sensors */
+	for (core = 0; core < 2; ++core) {
+		if (vsens[core] < 0 || isens[core] < 0)
+			continue;
+		cpu = 2 * sat->nr + core;
+		sens = kzalloc(sizeof(struct wf_sat_sensor) + 16, GFP_KERNEL);
+		if (sens == NULL) {
+			printk(KERN_ERR "wf_sat_create: couldn't create power "
+			       "sensor %d (no memory)\n", cpu);
+			continue;
+		}
+		sens->index = vsens[core];
+		sens->index2 = isens[core];
+		sens->shift = 0;
+		sens->sat = sat;
+		atomic_inc(&sat->refcnt);
+		sens->sens.ops = &wf_sat_ops;
+		sens->sens.name = (char *) (sens + 1);
+		snprintf(sens->sens.name, 16, "cpu-power-%d", cpu);
+
+		if (wf_register_sensor(&sens->sens)) {
+			atomic_dec(&sat->refcnt);
+			kfree(sens);
+		}
+	}
+
+	if (sat->nr >= 0)
+		sats[sat->nr] = sat;
+
+	return;
+
+ fail:
+	kfree(sat);
+}
+
+static int wf_sat_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev = NULL;
+	struct pmac_i2c_bus *bus;
+
+	bus = pmac_i2c_adapter_to_bus(adapter);
+	if (bus == NULL)
+		return -ENODEV;
+	busnode = pmac_i2c_get_bus_node(bus);
+
+	while ((dev = of_get_next_child(busnode, dev)) != NULL)
+		if (device_is_compatible(dev, "smu-sat"))
+			wf_sat_create(adapter, dev);
+	return 0;
+}
+
+static int wf_sat_detach(struct i2c_client *client)
+{
+	struct wf_sat *sat = i2c_to_sat(client);
+
+	/* XXX TODO */
+
+	sat->i2c.adapter = NULL;
+	return 0;
+}
+
+static int __init sat_sensors_init(void)
+{
+	int err;
+
+	err = i2c_add_driver(&wf_sat_driver);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static void __exit sat_sensors_exit(void)
+{
+	i2c_del_driver(&wf_sat_driver);
+}
+
+module_init(sat_sensors_init);
+/*module_exit(sat_sensors_exit); Uncomment when cleanup is implemented */
+
+MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
+MODULE_DESCRIPTION("SMU satellite sensors for PowerMac thermal control");
+MODULE_LICENSE("GPL");
Index: linux-work/include/asm-powerpc/smu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/smu.h	2006-01-13 16:55:09.000000000 +1100
+++ linux-work/include/asm-powerpc/smu.h	2006-02-07 13:45:57.000000000 +1100
@@ -521,6 +521,11 @@ struct smu_sdbp_cpupiddata {
 extern struct smu_sdbp_header *smu_get_sdb_partition(int id,
 					unsigned int *size);
 
+/* Get "sdb" partition data from an SMU satellite */
+extern struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id,
+					int id, unsigned int *size);
+
+
 #endif /* __KERNEL__ */
 
 
Index: linux-work/drivers/macintosh/windfarm_pm91.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm91.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm91.c	2006-02-08 16:34:39.000000000 +1100
@@ -458,45 +458,6 @@ static void wf_smu_slots_fans_tick(struc
 
 
 /*
- * ****** Attributes ******
- *
- */
-
-#define BUILD_SHOW_FUNC_FIX(name, data)				\
-static ssize_t show_##name(struct device *dev,                  \
-			   struct device_attribute *attr,       \
-			   char *buf)	                        \
-{								\
-	ssize_t r;						\
-	s32 val = 0;                                            \
-	data->ops->get_value(data, &val);                       \
-	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(val)); 	\
-	return r;						\
-}                                                               \
-static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
-
-
-#define BUILD_SHOW_FUNC_INT(name, data)				\
-static ssize_t show_##name(struct device *dev,                  \
-			   struct device_attribute *attr,       \
-			   char *buf)	                        \
-{								\
-	s32 val = 0;                                            \
-	data->ops->get_value(data, &val);                       \
-	return sprintf(buf, "%d", val);  			\
-}                                                               \
-static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
-
-BUILD_SHOW_FUNC_INT(cpu_fan, fan_cpu_main);
-BUILD_SHOW_FUNC_INT(hd_fan, fan_hd);
-BUILD_SHOW_FUNC_INT(slots_fan, fan_slots);
-
-BUILD_SHOW_FUNC_FIX(cpu_temp, sensor_cpu_temp);
-BUILD_SHOW_FUNC_FIX(cpu_power, sensor_cpu_power);
-BUILD_SHOW_FUNC_FIX(hd_temp, sensor_hd_temp);
-BUILD_SHOW_FUNC_FIX(slots_power, sensor_slots_power);
-
-/*
  * ****** Setup / Init / Misc ... ******
  *
  */
@@ -581,10 +542,8 @@ static void wf_smu_new_control(struct wf
 		return;
 
 	if (fan_cpu_main == NULL && !strcmp(ct->name, "cpu-rear-fan-0")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_cpu_main = ct;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_fan);
-		}
 	}
 
 	if (fan_cpu_second == NULL && !strcmp(ct->name, "cpu-rear-fan-1")) {
@@ -603,17 +562,13 @@ static void wf_smu_new_control(struct wf
 	}
 
 	if (fan_hd == NULL && !strcmp(ct->name, "drive-bay-fan")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_hd = ct;
-			device_create_file(wf_smu_dev, &dev_attr_hd_fan);
-		}
 	}
 
 	if (fan_slots == NULL && !strcmp(ct->name, "slots-fan")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_slots = ct;
-			device_create_file(wf_smu_dev, &dev_attr_slots_fan);
-		}
 	}
 
 	if (fan_cpu_main && (fan_cpu_second || fan_cpu_third) && fan_hd &&
@@ -627,31 +582,23 @@ static void wf_smu_new_sensor(struct wf_
 		return;
 
 	if (sensor_cpu_power == NULL && !strcmp(sr->name, "cpu-power")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_cpu_power = sr;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_power);
-		}
 	}
 
 	if (sensor_cpu_temp == NULL && !strcmp(sr->name, "cpu-temp")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_cpu_temp = sr;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_temp);
-		}
 	}
 
 	if (sensor_hd_temp == NULL && !strcmp(sr->name, "hd-temp")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_hd_temp = sr;
-			device_create_file(wf_smu_dev, &dev_attr_hd_temp);
-		}
 	}
 
 	if (sensor_slots_power == NULL && !strcmp(sr->name, "slots-power")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_slots_power = sr;
-			device_create_file(wf_smu_dev, &dev_attr_slots_power);
-		}
 	}
 
 	if (sensor_cpu_power && sensor_cpu_temp &&
@@ -720,40 +667,26 @@ static int wf_smu_remove(struct device *
 	 * with that except by adding locks all over... I'll do that
 	 * eventually but heh, who ever rmmod this module anyway ?
 	 */
-	if (sensor_cpu_power) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_power);
+	if (sensor_cpu_power)
 		wf_put_sensor(sensor_cpu_power);
-	}
-	if (sensor_cpu_temp) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_temp);
+	if (sensor_cpu_temp)
 		wf_put_sensor(sensor_cpu_temp);
-	}
-	if (sensor_hd_temp) {
-		device_remove_file(wf_smu_dev, &dev_attr_hd_temp);
+	if (sensor_hd_temp)
 		wf_put_sensor(sensor_hd_temp);
-	}
-	if (sensor_slots_power) {
-		device_remove_file(wf_smu_dev, &dev_attr_slots_power);
+	if (sensor_slots_power)
 		wf_put_sensor(sensor_slots_power);
-	}
 
 	/* Release all controls */
-	if (fan_cpu_main) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_fan);
+	if (fan_cpu_main)
 		wf_put_control(fan_cpu_main);
-	}
 	if (fan_cpu_second)
 		wf_put_control(fan_cpu_second);
 	if (fan_cpu_third)
 		wf_put_control(fan_cpu_third);
-	if (fan_hd) {
-		device_remove_file(wf_smu_dev, &dev_attr_hd_fan);
+	if (fan_hd)
 		wf_put_control(fan_hd);
-	}
-	if (fan_slots) {
-		device_remove_file(wf_smu_dev, &dev_attr_slots_fan);
+	if (fan_slots)
 		wf_put_control(fan_slots);
-	}
 	if (cpufreq_clamp)
 		wf_put_control(cpufreq_clamp);
 
Index: linux-work/drivers/macintosh/windfarm_pm81.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm81.c	2006-01-13 16:55:07.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm81.c	2006-02-08 16:35:28.000000000 +1100
@@ -538,45 +538,6 @@ static void wf_smu_cpu_fans_tick(struct 
 	}
 }
 
-
-/*
- * ****** Attributes ******
- *
- */
-
-#define BUILD_SHOW_FUNC_FIX(name, data)				\
-static ssize_t show_##name(struct device *dev,                  \
-			   struct device_attribute *attr,       \
-			   char *buf)	                        \
-{								\
-	ssize_t r;						\
-	s32 val = 0;                                            \
-	data->ops->get_value(data, &val);                       \
-	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(val)); 	\
-	return r;						\
-}                                                               \
-static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
-
-
-#define BUILD_SHOW_FUNC_INT(name, data)				\
-static ssize_t show_##name(struct device *dev,                  \
-			   struct device_attribute *attr,       \
-			   char *buf)	                        \
-{								\
-	s32 val = 0;                                            \
-	data->ops->get_value(data, &val);                       \
-	return sprintf(buf, "%d", val);  			\
-}                                                               \
-static DEVICE_ATTR(name,S_IRUGO,show_##name, NULL);
-
-BUILD_SHOW_FUNC_INT(cpu_fan, fan_cpu_main);
-BUILD_SHOW_FUNC_INT(sys_fan, fan_system);
-BUILD_SHOW_FUNC_INT(hd_fan, fan_hd);
-
-BUILD_SHOW_FUNC_FIX(cpu_temp, sensor_cpu_temp);
-BUILD_SHOW_FUNC_FIX(cpu_power, sensor_cpu_power);
-BUILD_SHOW_FUNC_FIX(hd_temp, sensor_hd_temp);
-
 /*
  * ****** Setup / Init / Misc ... ******
  *
@@ -654,17 +615,13 @@ static void wf_smu_new_control(struct wf
 		return;
 
 	if (fan_cpu_main == NULL && !strcmp(ct->name, "cpu-fan")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_cpu_main = ct;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_fan);
-		}
 	}
 
 	if (fan_system == NULL && !strcmp(ct->name, "system-fan")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_system = ct;
-			device_create_file(wf_smu_dev, &dev_attr_sys_fan);
-		}
 	}
 
 	if (cpufreq_clamp == NULL && !strcmp(ct->name, "cpufreq-clamp")) {
@@ -683,10 +640,8 @@ static void wf_smu_new_control(struct wf
 	}
 
 	if (fan_hd == NULL && !strcmp(ct->name, "drive-bay-fan")) {
-		if (wf_get_control(ct) == 0) {
+		if (wf_get_control(ct) == 0)
 			fan_hd = ct;
-			device_create_file(wf_smu_dev, &dev_attr_hd_fan);
-		}
 	}
 
 	if (fan_system && fan_hd && fan_cpu_main && cpufreq_clamp)
@@ -699,24 +654,18 @@ static void wf_smu_new_sensor(struct wf_
 		return;
 
 	if (sensor_cpu_power == NULL && !strcmp(sr->name, "cpu-power")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_cpu_power = sr;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_power);
-		}
 	}
 
 	if (sensor_cpu_temp == NULL && !strcmp(sr->name, "cpu-temp")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_cpu_temp = sr;
-			device_create_file(wf_smu_dev, &dev_attr_cpu_temp);
-		}
 	}
 
 	if (sensor_hd_temp == NULL && !strcmp(sr->name, "hd-temp")) {
-		if (wf_get_sensor(sr) == 0) {
+		if (wf_get_sensor(sr) == 0)
 			sensor_hd_temp = sr;
-			device_create_file(wf_smu_dev, &dev_attr_hd_temp);
-		}
 	}
 
 	if (sensor_cpu_power && sensor_cpu_temp && sensor_hd_temp)
@@ -794,32 +743,20 @@ static int wf_smu_remove(struct device *
 	 * with that except by adding locks all over... I'll do that
 	 * eventually but heh, who ever rmmod this module anyway ?
 	 */
-	if (sensor_cpu_power) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_power);
+	if (sensor_cpu_power)
 		wf_put_sensor(sensor_cpu_power);
-	}
-	if (sensor_cpu_temp) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_temp);
+	if (sensor_cpu_temp)
 		wf_put_sensor(sensor_cpu_temp);
-	}
-	if (sensor_hd_temp) {
-		device_remove_file(wf_smu_dev, &dev_attr_hd_temp);
+	if (sensor_hd_temp)
 		wf_put_sensor(sensor_hd_temp);
-	}
 
 	/* Release all controls */
-	if (fan_cpu_main) {
-		device_remove_file(wf_smu_dev, &dev_attr_cpu_fan);
+	if (fan_cpu_main)
 		wf_put_control(fan_cpu_main);
-	}
-	if (fan_hd) {
-		device_remove_file(wf_smu_dev, &dev_attr_hd_fan);
+	if (fan_hd)
 		wf_put_control(fan_hd);
-	}
-	if (fan_system) {
-		device_remove_file(wf_smu_dev, &dev_attr_sys_fan);
+	if (fan_system)
 		wf_put_control(fan_system);
-	}
 	if (cpufreq_clamp)
 		wf_put_control(cpufreq_clamp);
 


