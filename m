Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWGFFHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWGFFHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWGFFHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:07:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:10202 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965148AbWGFFHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:07:18 -0400
Subject: [PATCH] powerpc: Xserve G5 thermal control fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 15:06:34 +1000
Message-Id: <1152162394.24632.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal control for the Xserve G5s had a few issues. For one, the
way to program the RPM fans speeds into the FCU is different between it
and the desktop models, which I didn't figure out until recently, and it
was missing a control loop for the slots fan, running it too fast. Both
of those problems were causing the machine to be much more noisy than
necessary. This patch also changes the fixed value of the slots fan for
desktop G5s to 40% instead of 50%. It seems to still have a pretty good
airflow that way and is much less noisy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-irq-work.orig/drivers/macintosh/therm_pm72.c	2006-07-05 14:46:11.000000000 +1000
+++ linux-irq-work/drivers/macintosh/therm_pm72.c	2006-07-06 14:42:31.000000000 +1000
@@ -95,6 +95,14 @@
  *	- Use min/max macros here or there
  *	- Latest darwin updated U3H min fan speed to 20% PWM
  *
+ *  July. 06, 2006 : 1.3
+ *	- Fix setting of RPM fans on Xserve G5 (they were going too fast)
+ *      - Add missing slots fan control loop for Xserve G5
+ *	- Lower fixed slots fan speed from 50% to 40% on desktop G5s. We
+ *        still can't properly implement the control loop for these, so let's
+ *        reduce the noise a little bit, it appears that 40% still gives us
+ *        a pretty good air flow
+ *
  */
 
 #include <linux/types.h>
@@ -121,7 +129,7 @@
 
 #include "therm_pm72.h"
 
-#define VERSION "1.2b2"
+#define VERSION "1.3"
 
 #undef DEBUG
 
@@ -146,6 +154,7 @@
 static struct backside_pid_state	backside_state;
 static struct drives_pid_state		drives_state;
 static struct dimm_pid_state		dimms_state;
+static struct slots_pid_state		slots_state;
 static int				state;
 static int				cpu_count;
 static int				cpu_pid_type;
@@ -154,7 +163,7 @@
 static int				critical_state;
 static int				rackmac;
 static s32				dimm_output_clamp;
-
+static int 				fcu_rpm_shift;
 static DECLARE_MUTEX(driver_lock);
 
 /*
@@ -495,13 +504,20 @@
 	rc = fan_write_reg(0x2e, &buf, 1);
 	if (rc < 0)
 		return -EIO;
+	rc = fan_read_reg(0, &buf, 1);
+	if (rc < 0)
+		return -EIO;
+	fcu_rpm_shift = (buf == 1) ? 2 : 3;
+	printk(KERN_DEBUG "FCU Initialized, RPM fan shift is %d\n",
+	       fcu_rpm_shift);
+
 	return 0;
 }
 
 static int set_rpm_fan(int fan_index, int rpm)
 {
 	unsigned char buf[2];
-	int rc, id;
+	int rc, id, min, max;
 
 	if (fcu_fans[fan_index].type != FCU_FAN_RPM)
 		return -EINVAL;
@@ -509,12 +525,15 @@
 	if (id == FCU_FAN_ABSENT_ID)
 		return -EINVAL;
 
-	if (rpm < 300)
-		rpm = 300;
-	else if (rpm > 8191)
-		rpm = 8191;
-	buf[0] = rpm >> 5;
-	buf[1] = rpm << 3;
+	min = 2400 >> fcu_rpm_shift;
+	max = 56000 >> fcu_rpm_shift;
+
+	if (rpm < min)
+		rpm = min;
+	else if (rpm > max)
+		rpm = max;
+	buf[0] = rpm >> (8 - fcu_rpm_shift);
+	buf[1] = rpm << fcu_rpm_shift;
 	rc = fan_write_reg(0x10 + (id * 2), buf, 2);
 	if (rc < 0)
 		return -EIO;
@@ -551,7 +570,7 @@
 	if (rc != 2)
 		return -EIO;
 
-	return (buf[0] << 5) | buf[1] >> 3;
+	return (buf[0] << (8 - fcu_rpm_shift)) | buf[1] >> fcu_rpm_shift;
 }
 
 static int set_pwm_fan(int fan_index, int pwm)
@@ -715,6 +734,9 @@
 BUILD_SHOW_FUNC_FIX(drives_temperature, drives_state.last_temp)
 BUILD_SHOW_FUNC_INT(drives_fan_rpm, drives_state.rpm)
 
+BUILD_SHOW_FUNC_FIX(slots_temperature, slots_state.last_temp)
+BUILD_SHOW_FUNC_INT(slots_fan_pwm, slots_state.pwm)
+
 BUILD_SHOW_FUNC_FIX(dimms_temperature, dimms_state.last_temp)
 
 static DEVICE_ATTR(cpu0_temperature,S_IRUGO,show_cpu0_temperature,NULL);
@@ -735,6 +757,9 @@
 static DEVICE_ATTR(drives_temperature,S_IRUGO,show_drives_temperature,NULL);
 static DEVICE_ATTR(drives_fan_rpm,S_IRUGO,show_drives_fan_rpm,NULL);
 
+static DEVICE_ATTR(slots_temperature,S_IRUGO,show_slots_temperature,NULL);
+static DEVICE_ATTR(slots_fan_pwm,S_IRUGO,show_slots_fan_pwm,NULL);
+
 static DEVICE_ATTR(dimms_temperature,S_IRUGO,show_dimms_temperature,NULL);
 
 /*
@@ -1076,6 +1101,9 @@
 	fan_min = dimm_output_clamp;
 	fan_min = max(fan_min, (int)state->mpu.rminn_intake_fan);
 
+	DBG(" CPU min mpu = %d, min dimm = %d\n",
+	    state->mpu.rminn_intake_fan, dimm_output_clamp);
+
 	state->rpm = max(state->rpm, (int)fan_min);
 	state->rpm = min(state->rpm, (int)state->mpu.rmaxn_intake_fan);
 	state->intake_rpm = state->rpm;
@@ -1374,7 +1402,8 @@
 	DBG("  current rpm: %d\n", state->rpm);
 
 	/* Get some sensor readings */
-	temp = le16_to_cpu(i2c_smbus_read_word_data(state->monitor, DS1775_TEMP)) << 8;
+	temp = le16_to_cpu(i2c_smbus_read_word_data(state->monitor,
+						    DS1775_TEMP)) << 8;
 	state->last_temp = temp;
 	DBG("  temp: %d.%03d, target: %d.%03d\n", FIX32TOPRINT(temp),
 	    FIX32TOPRINT(DRIVES_PID_INPUT_TARGET));
@@ -1575,7 +1604,7 @@
 }
 
 /*
- * Dispose of the state data for the drives control loop
+ * Dispose of the state data for the DIMM control loop
  */
 static void dispose_dimms_state(struct dimm_pid_state *state)
 {
@@ -1588,6 +1617,127 @@
 	state->monitor = NULL;
 }
 
+/*
+ * Slots fan control loop
+ */
+static void do_monitor_slots(struct slots_pid_state *state)
+{
+	s32 temp, integral, derivative;
+	s64 integ_p, deriv_p, prop_p, sum;
+	int i, rc;
+
+	if (--state->ticks != 0)
+		return;
+	state->ticks = SLOTS_PID_INTERVAL;
+
+	DBG("slots:\n");
+
+	/* Check fan status */
+	rc = get_pwm_fan(SLOTS_FAN_PWM_INDEX);
+	if (rc < 0) {
+		printk(KERN_WARNING "Error %d reading slots fan !\n", rc);
+		/* XXX What do we do now ? */
+	} else
+		state->pwm = rc;
+	DBG("  current pwm: %d\n", state->pwm);
+
+	/* Get some sensor readings */
+	temp = le16_to_cpu(i2c_smbus_read_word_data(state->monitor,
+						    DS1775_TEMP)) << 8;
+	state->last_temp = temp;
+	DBG("  temp: %d.%03d, target: %d.%03d\n", FIX32TOPRINT(temp),
+	    FIX32TOPRINT(SLOTS_PID_INPUT_TARGET));
+
+	/* Store temperature and error in history array */
+	state->cur_sample = (state->cur_sample + 1) % SLOTS_PID_HISTORY_SIZE;
+	state->sample_history[state->cur_sample] = temp;
+	state->error_history[state->cur_sample] = temp - SLOTS_PID_INPUT_TARGET;
+
+	/* If first loop, fill the history table */
+	if (state->first) {
+		for (i = 0; i < (SLOTS_PID_HISTORY_SIZE - 1); i++) {
+			state->cur_sample = (state->cur_sample + 1) %
+				SLOTS_PID_HISTORY_SIZE;
+			state->sample_history[state->cur_sample] = temp;
+			state->error_history[state->cur_sample] =
+				temp - SLOTS_PID_INPUT_TARGET;
+		}
+		state->first = 0;
+	}
+
+	/* Calculate the integral term */
+	sum = 0;
+	integral = 0;
+	for (i = 0; i < SLOTS_PID_HISTORY_SIZE; i++)
+		integral += state->error_history[i];
+	integral *= SLOTS_PID_INTERVAL;
+	DBG("  integral: %08x\n", integral);
+	integ_p = ((s64)SLOTS_PID_G_r) * (s64)integral;
+	DBG("   integ_p: %d\n", (int)(integ_p >> 36));
+	sum += integ_p;
+
+	/* Calculate the derivative term */
+	derivative = state->error_history[state->cur_sample] -
+		state->error_history[(state->cur_sample + SLOTS_PID_HISTORY_SIZE - 1)
+				    % SLOTS_PID_HISTORY_SIZE];
+	derivative /= SLOTS_PID_INTERVAL;
+	deriv_p = ((s64)SLOTS_PID_G_d) * (s64)derivative;
+	DBG("   deriv_p: %d\n", (int)(deriv_p >> 36));
+	sum += deriv_p;
+
+	/* Calculate the proportional term */
+	prop_p = ((s64)SLOTS_PID_G_p) * (s64)(state->error_history[state->cur_sample]);
+	DBG("   prop_p: %d\n", (int)(prop_p >> 36));
+	sum += prop_p;
+
+	/* Scale sum */
+	sum >>= 36;
+
+	DBG("   sum: %d\n", (int)sum);
+	state->pwm = (s32)sum;
+
+	state->pwm = max(state->pwm, SLOTS_PID_OUTPUT_MIN);
+	state->pwm = min(state->pwm, SLOTS_PID_OUTPUT_MAX);
+
+	DBG("** DRIVES PWM: %d\n", (int)state->pwm);
+	set_pwm_fan(SLOTS_FAN_PWM_INDEX, state->pwm);
+}
+
+/*
+ * Initialize the state structure for the slots bay fan control loop
+ */
+static int init_slots_state(struct slots_pid_state *state)
+{
+	state->ticks = 1;
+	state->first = 1;
+	state->pwm = 50;
+
+	state->monitor = attach_i2c_chip(XSERVE_SLOTS_LM75, "slots_temp");
+	if (state->monitor == NULL)
+		return -ENODEV;
+
+	device_create_file(&of_dev->dev, &dev_attr_slots_temperature);
+	device_create_file(&of_dev->dev, &dev_attr_slots_fan_pwm);
+
+	return 0;
+}
+
+/*
+ * Dispose of the state data for the slots control loop
+ */
+static void dispose_slots_state(struct slots_pid_state *state)
+{
+	if (state->monitor == NULL)
+		return;
+
+	device_remove_file(&of_dev->dev, &dev_attr_slots_temperature);
+	device_remove_file(&of_dev->dev, &dev_attr_slots_fan_pwm);
+
+	detach_i2c_chip(state->monitor);
+	state->monitor = NULL;
+}
+
+
 static int call_critical_overtemp(void)
 {
 	char *argv[] = { critical_overtemp_path, NULL };
@@ -1617,8 +1767,9 @@
 		goto out;
 	}
 
-	/* Set the PCI fan once for now */
-	set_pwm_fan(SLOTS_FAN_PWM_INDEX, SLOTS_FAN_DEFAULT_PWM);
+	/* Set the PCI fan once for now on non-RackMac */
+	if (!rackmac)
+		set_pwm_fan(SLOTS_FAN_PWM_INDEX, SLOTS_FAN_DEFAULT_PWM);
 
 	/* Initialize ADCs */
 	initialize_adc(&cpu_state[0]);
@@ -1654,7 +1805,9 @@
 		}
 		/* Then, the rest */
 		do_monitor_backside(&backside_state);
-		if (!rackmac)
+		if (rackmac)
+			do_monitor_slots(&slots_state);
+		else
 			do_monitor_drives(&drives_state);
 		up(&driver_lock);
 
@@ -1696,6 +1849,7 @@
 	dispose_cpu_state(&cpu_state[1]);
 	dispose_backside_state(&backside_state);
 	dispose_drives_state(&drives_state);
+	dispose_slots_state(&slots_state);
 	dispose_dimms_state(&dimms_state);
 }
 
@@ -1745,6 +1899,8 @@
 		goto fail;
 	if (rackmac && init_dimms_state(&dimms_state))
 		goto fail;
+	if (rackmac && init_slots_state(&slots_state))
+		goto fail;
 	if (!rackmac && init_drives_state(&drives_state))
 		goto fail;
 
Index: linux-irq-work/drivers/macintosh/therm_pm72.h
===================================================================
--- linux-irq-work.orig/drivers/macintosh/therm_pm72.h	2006-07-01 13:51:20.000000000 +1000
+++ linux-irq-work/drivers/macintosh/therm_pm72.h	2006-07-06 14:03:16.000000000 +1000
@@ -105,6 +105,7 @@
 #define DRIVES_DALLAS_ID	0x94
 #define BACKSIDE_MAX_ID		0x98
 #define XSERVE_DIMMS_LM87	0x25a
+#define XSERVE_SLOTS_LM75	0x290
 
 /*
  * Some MAX6690, DS1775, LM87 register definitions
@@ -198,7 +199,7 @@
 
 #define SLOTS_FAN_PWM_DEFAULT_ID	2
 #define SLOTS_FAN_PWM_INDEX		2
-#define	SLOTS_FAN_DEFAULT_PWM		50 /* Do better here ! */
+#define	SLOTS_FAN_DEFAULT_PWM		40 /* Do better here ! */
 
 
 /*
@@ -206,7 +207,7 @@
  */
 #define DIMM_PID_G_d			0
 #define DIMM_PID_G_p			0
-#define DIMM_PID_G_r			0x6553600
+#define DIMM_PID_G_r			0x06553600
 #define DIMM_PID_INPUT_TARGET		3276800
 #define DIMM_PID_INTERVAL    		1
 #define DIMM_PID_OUTPUT_MAX		14000
@@ -226,6 +227,31 @@
 };
 
 
+/*
+ * PID factors for the Xserve Slots control loop
+ */
+#define SLOTS_PID_G_d			0
+#define SLOTS_PID_G_p			0
+#define SLOTS_PID_G_r			0x00100000
+#define SLOTS_PID_INPUT_TARGET		3200000
+#define SLOTS_PID_INTERVAL    		1
+#define SLOTS_PID_OUTPUT_MAX		100
+#define SLOTS_PID_OUTPUT_MIN		20
+#define SLOTS_PID_HISTORY_SIZE		20
+
+struct slots_pid_state
+{
+	int			ticks;
+	struct i2c_client *	monitor;
+	s32	       		sample_history[SLOTS_PID_HISTORY_SIZE];
+	s32			error_history[SLOTS_PID_HISTORY_SIZE];
+	int			cur_sample;
+	s32			last_temp;
+	int			first;
+	int			pwm;
+};
+
+
 
 /* Desktops */
 


