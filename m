Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271052AbUJVBgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271052AbUJVBgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbUJVBbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:31:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:13233 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271181AbUJVBYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:24:05 -0400
Subject: [PATCH] ppc64: Update G5 thermal control driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098408189.6071.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 11:23:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch updates the G5 thermal control driver, the main change
is support for the new "PowerMac7,3" type desktops including the
dual 2.5Ghz with liquid cooling.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-work.orig/drivers/macintosh/therm_pm72.c	2004-10-20 13:01:01.000000000 +1000
+++ linux-work/drivers/macintosh/therm_pm72.c	2004-10-22 11:08:15.059331488 +1000
@@ -46,6 +46,9 @@
  *          overtemp conditions so userland can take some policy
  *          decisions, like slewing down CPUs
  *	  - Deal with fan and i2c failures in a better way
+ *	  - Maybe do a generic PID based on params used for
+ *	    U3 and Drives ?
+ *        - Add RackMac3,1 support (XServe g5)
  *
  * History:
  *
@@ -73,6 +76,15 @@
  *        values in the configuration register
  *	- Switch back to use of target fan speed for PID, thus lowering
  *        pressure on i2c
+ *
+ *  Oct. 20, 2004 : 1.1
+ *	- Add device-tree lookup for fan IDs, should detect liquid cooling
+ *        pumps when present
+ *	- Enable driver for PowerMac7,3 machines
+ *	- Split the U3/Backside cooling on U3 & U3H versions as Darwin does
+ *	- Add new CPU cooling algorithm for machines with liquid cooling
+ *	- Workaround for some PowerMac7,3 with empty "fan" node in the devtree
+ *	- Fix a signed/unsigned compare issue in some PID loops
  */
 
 #include <linux/config.h>
@@ -88,7 +100,6 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
-#include <linux/suspend.h>
 #include <linux/reboot.h>
 #include <linux/kmod.h>
 #include <linux/i2c.h>
@@ -102,7 +113,7 @@
 
 #include "therm_pm72.h"
 
-#define VERSION "0.9"
+#define VERSION "1.1"
 
 #undef DEBUG
 
@@ -122,16 +133,100 @@
 static struct i2c_adapter *		u3_1;
 static struct i2c_client *		fcu;
 static struct cpu_pid_state		cpu_state[2];
+static struct basckside_pid_params	backside_params;
 static struct backside_pid_state	backside_state;
 static struct drives_pid_state		drives_state;
 static int				state;
 static int				cpu_count;
+static int				cpu_pid_type;
 static pid_t				ctrl_task;
 static struct completion		ctrl_complete;
 static int				critical_state;
 static DECLARE_MUTEX(driver_lock);
 
 /*
+ * We have 2 types of CPU PID control. One is "split" old style control
+ * for intake & exhaust fans, the other is "combined" control for both
+ * CPUs that also deals with the pumps when present. To be "compatible"
+ * with OS X at this point, we only use "COMBINED" on the machines that
+ * are identified as having the pumps (though that identification is at
+ * least dodgy). Ultimately, we could probably switch completely to this
+ * algorithm provided we hack it to deal with the UP case
+ */
+#define CPU_PID_TYPE_SPLIT	0
+#define CPU_PID_TYPE_COMBINED	1
+
+/*
+ * This table describes all fans in the FCU. The "id" and "type" values
+ * are defaults valid for all earlier machines. Newer machines will
+ * eventually override the table content based on the device-tree
+ */
+struct fcu_fan_table
+{
+	char*	loc;	/* location code */
+	int	type;	/* 0 = rpm, 1 = pwm, 2 = pump */
+	int	id;	/* id or -1 */
+};
+
+#define FCU_FAN_RPM		0
+#define FCU_FAN_PWM		1
+
+#define FCU_FAN_ABSENT_ID	-1
+
+#define FCU_FAN_COUNT		ARRAY_SIZE(fcu_fans)
+
+struct fcu_fan_table	fcu_fans[] = {
+	[BACKSIDE_FAN_PWM_INDEX] = {
+		.loc	= "BACKSIDE",
+		.type	= FCU_FAN_PWM,
+		.id	= BACKSIDE_FAN_PWM_DEFAULT_ID,
+	},
+	[DRIVES_FAN_RPM_INDEX] = {
+		.loc	= "DRIVE BAY",
+		.type	= FCU_FAN_RPM,
+		.id	= DRIVES_FAN_RPM_DEFAULT_ID,
+	},
+	[SLOTS_FAN_PWM_INDEX] = {
+		.loc	= "SLOT",
+		.type	= FCU_FAN_PWM,
+		.id	= SLOTS_FAN_PWM_DEFAULT_ID,
+	},
+	[CPUA_INTAKE_FAN_RPM_INDEX] = {
+		.loc	= "CPU A INTAKE",
+		.type	= FCU_FAN_RPM,
+		.id	= CPUA_INTAKE_FAN_RPM_DEFAULT_ID,
+	},
+	[CPUA_EXHAUST_FAN_RPM_INDEX] = {
+		.loc	= "CPU A EXHAUST",
+		.type	= FCU_FAN_RPM,
+		.id	= CPUA_EXHAUST_FAN_RPM_DEFAULT_ID,
+	},
+	[CPUB_INTAKE_FAN_RPM_INDEX] = {
+		.loc	= "CPU B INTAKE",
+		.type	= FCU_FAN_RPM,
+		.id	= CPUB_INTAKE_FAN_RPM_DEFAULT_ID,
+	},
+	[CPUB_EXHAUST_FAN_RPM_INDEX] = {
+		.loc	= "CPU B EXHAUST",
+		.type	= FCU_FAN_RPM,
+		.id	= CPUB_EXHAUST_FAN_RPM_DEFAULT_ID,
+	},
+	/* pumps aren't present by default, have to be looked up in the
+	 * device-tree
+	 */
+	[CPUA_PUMP_RPM_INDEX] = {
+		.loc	= "CPU A PUMP",
+		.type	= FCU_FAN_RPM,		
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPUB_PUMP_RPM_INDEX] = {
+		.loc	= "CPU B PUMP",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+};
+
+/*
  * i2c_driver structure to attach to the host i2c controller
  */
 
@@ -332,10 +427,16 @@
 	return 0;
 }
 
-static int set_rpm_fan(int fan, int rpm)
+static int set_rpm_fan(int fan_index, int rpm)
 {
 	unsigned char buf[2];
-	int rc;
+	int rc, id;
+
+	if (fcu_fans[fan_index].type != FCU_FAN_RPM)
+		return -EINVAL;
+	id = fcu_fans[fan_index].id; 
+	if (id == FCU_FAN_ABSENT_ID)
+		return -EINVAL;
 
 	if (rpm < 300)
 		rpm = 300;
@@ -343,43 +444,55 @@
 		rpm = 8191;
 	buf[0] = rpm >> 5;
 	buf[1] = rpm << 3;
-	rc = fan_write_reg(0x10 + (fan * 2), buf, 2);
+	rc = fan_write_reg(0x10 + (id * 2), buf, 2);
 	if (rc < 0)
 		return -EIO;
 	return 0;
 }
 
-static int get_rpm_fan(int fan, int programmed)
+static int get_rpm_fan(int fan_index, int programmed)
 {
 	unsigned char failure;
 	unsigned char active;
 	unsigned char buf[2];
-	int rc, reg_base;
+	int rc, id, reg_base;
+
+	if (fcu_fans[fan_index].type != FCU_FAN_RPM)
+		return -EINVAL;
+	id = fcu_fans[fan_index].id; 
+	if (id == FCU_FAN_ABSENT_ID)
+		return -EINVAL;
 
 	rc = fan_read_reg(0xb, &failure, 1);
 	if (rc != 1)
 		return -EIO;
-	if ((failure & (1 << fan)) != 0)
+	if ((failure & (1 << id)) != 0)
 		return -EFAULT;
 	rc = fan_read_reg(0xd, &active, 1);
 	if (rc != 1)
 		return -EIO;
-	if ((active & (1 << fan)) == 0)
+	if ((active & (1 << id)) == 0)
 		return -ENXIO;
 
 	/* Programmed value or real current speed */
 	reg_base = programmed ? 0x10 : 0x11;
-	rc = fan_read_reg(reg_base + (fan * 2), buf, 2);
+	rc = fan_read_reg(reg_base + (id * 2), buf, 2);
 	if (rc != 2)
 		return -EIO;
 
 	return (buf[0] << 5) | buf[1] >> 3;
 }
 
-static int set_pwm_fan(int fan, int pwm)
+static int set_pwm_fan(int fan_index, int pwm)
 {
 	unsigned char buf[2];
-	int rc;
+	int rc, id;
+
+	if (fcu_fans[fan_index].type != FCU_FAN_PWM)
+		return -EINVAL;
+	id = fcu_fans[fan_index].id; 
+	if (id == FCU_FAN_ABSENT_ID)
+		return -EINVAL;
 
 	if (pwm < 10)
 		pwm = 10;
@@ -387,32 +500,38 @@
 		pwm = 100;
 	pwm = (pwm * 2559) / 1000;
 	buf[0] = pwm;
-	rc = fan_write_reg(0x30 + (fan * 2), buf, 1);
+	rc = fan_write_reg(0x30 + (id * 2), buf, 1);
 	if (rc < 0)
 		return rc;
 	return 0;
 }
 
-static int get_pwm_fan(int fan)
+static int get_pwm_fan(int fan_index)
 {
 	unsigned char failure;
 	unsigned char active;
 	unsigned char buf[2];
-	int rc;
+	int rc, id;
+
+	if (fcu_fans[fan_index].type != FCU_FAN_PWM)
+		return -EINVAL;
+	id = fcu_fans[fan_index].id; 
+	if (id == FCU_FAN_ABSENT_ID)
+		return -EINVAL;
 
 	rc = fan_read_reg(0x2b, &failure, 1);
 	if (rc != 1)
 		return -EIO;
-	if ((failure & (1 << fan)) != 0)
+	if ((failure & (1 << id)) != 0)
 		return -EFAULT;
 	rc = fan_read_reg(0x2d, &active, 1);
 	if (rc != 1)
 		return -EIO;
-	if ((active & (1 << fan)) == 0)
+	if ((active & (1 << id)) == 0)
 		return -ENXIO;
 
 	/* Programmed value or real current speed */
-	rc = fan_read_reg(0x30 + (fan * 2), buf, 1);
+	rc = fan_read_reg(0x30 + (id * 2), buf, 1);
 	if (rc != 1)
 		return -EIO;
 
@@ -514,80 +633,84 @@
 /*
  * CPUs fans control loop
  */
-static void do_monitor_cpu(struct cpu_pid_state *state)
+
+static int do_read_one_cpu_values(struct cpu_pid_state *state, s32 *temp, s32 *power)
 {
-	s32 temp, voltage, current_a, power, power_target;
-	s32 integral, derivative, proportional, adj_in_target, sval;
-	s64 integ_p, deriv_p, prop_p, sum; 
-	int i, intake, rc;
+	s32 ltemp, volts, amps;
+	int rc = 0;
 
-	DBG("cpu %d:\n", state->index);
+	/* Default (in case of error) */
+	*temp = state->cur_temp;
+	*power = state->cur_power;
 
 	/* Read current fan status */
 	if (state->index == 0)
-		rc = get_rpm_fan(CPUA_EXHAUST_FAN_RPM_ID, !RPM_PID_USE_ACTUAL_SPEED);
+		rc = get_rpm_fan(CPUA_EXHAUST_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
 	else
-		rc = get_rpm_fan(CPUB_EXHAUST_FAN_RPM_ID, !RPM_PID_USE_ACTUAL_SPEED);
+		rc = get_rpm_fan(CPUB_EXHAUST_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
 	if (rc < 0) {
-		printk(KERN_WARNING "Error %d reading CPU %d exhaust fan !\n",
-		       rc, state->index);
-		/* XXX What do we do now ? */
-	} else
+		/* XXX What do we do now ? Nothing for now, keep old value, but
+		 * return error upstream
+		 */
+		DBG("  cpu %d, fan reading error !\n", state->index);
+	} else {
 		state->rpm = rc;
-	DBG("  current rpm: %d\n", state->rpm);
+		DBG("  cpu %d, exhaust RPM: %d\n", state->index, state->rpm);
+	}
 
 	/* Get some sensor readings and scale it */
-	temp = read_smon_adc(state, 1);
-	if (temp == -1) {
+	ltemp = read_smon_adc(state, 1);
+	if (ltemp == -1) {
+		/* XXX What do we do now ? */
 		state->overtemp++;
-		return;
+		if (rc == 0)
+			rc = -EIO;
+		DBG("  cpu %d, temp reading error !\n", state->index);
+	} else {
+		/* Fixup temperature according to diode calibration
+		 */
+		DBG("  cpu %d, temp raw: %04x, m_diode: %04x, b_diode: %04x\n",
+		    state->index,
+		    ltemp, state->mpu.mdiode, state->mpu.bdiode);
+		*temp = ((s32)ltemp * (s32)state->mpu.mdiode + ((s32)state->mpu.bdiode << 12)) >> 2;
+		state->last_temp = *temp;
+		DBG("  temp: %d.%03d\n", FIX32TOPRINT((*temp)));
 	}
-	voltage = read_smon_adc(state, 3);
-	current_a = read_smon_adc(state, 4);
 
-	/* Fixup temperature according to diode calibration
+	/*
+	 * Read voltage & current and calculate power
 	 */
-	DBG("  temp raw: %04x, m_diode: %04x, b_diode: %04x\n",
-	    temp, state->mpu.mdiode, state->mpu.bdiode);
-	temp = ((s32)temp * (s32)state->mpu.mdiode + ((s32)state->mpu.bdiode << 12)) >> 2;
-	state->last_temp = temp;
-	DBG("  temp: %d.%03d\n", FIX32TOPRINT(temp));
+	volts = read_smon_adc(state, 3);
+	amps = read_smon_adc(state, 4);
 
-	/* Check tmax, increment overtemp if we are there. At tmax+8, we go
-	 * full blown immediately and try to trigger a shutdown
-	 */
-	if (temp >= ((state->mpu.tmax + 8) << 16)) {
-		printk(KERN_WARNING "Warning ! CPU %d temperature way above maximum"
-		       " (%d) !\n",
-		       state->index, temp >> 16);
-		state->overtemp = CPU_MAX_OVERTEMP;
-	} else if (temp > (state->mpu.tmax << 16))
-		state->overtemp++;
-	else
-		state->overtemp = 0;
-	if (state->overtemp >= CPU_MAX_OVERTEMP)
-		critical_state = 1;
-	if (state->overtemp > 0) {
-		state->rpm = state->mpu.rmaxn_exhaust_fan;
-		state->intake_rpm = intake = state->mpu.rmaxn_intake_fan;
-		goto do_set_fans;
-	}
-	
-	/* Scale other sensor values according to fixed scales
+	/* Scale voltage and current raw sensor values according to fixed scales
 	 * obtained in Darwin and calculate power from I and V
 	 */
-	state->voltage = voltage *= ADC_CPU_VOLTAGE_SCALE;
-	state->current_a = current_a *= ADC_CPU_CURRENT_SCALE;
-	power = (((u64)current_a) * ((u64)voltage)) >> 16;
+	volts *= ADC_CPU_VOLTAGE_SCALE;
+	amps *= ADC_CPU_CURRENT_SCALE;
+	*power = (((u64)volts) * ((u64)amps)) >> 16;
+	state->voltage = volts;
+	state->current_a = amps;
+	state->last_power = *power;
+
+	DBG("  cpu %d, current: %d.%03d, voltage: %d.%03d, power: %d.%03d W\n",
+	    state->index, FIX32TOPRINT(state->current_a),
+	    FIX32TOPRINT(state->voltage), FIX32TOPRINT(*power));
+
+	return 0;
+}
+
+static void do_cpu_pid(struct cpu_pid_state *state, s32 temp, s32 power)
+{
+	s32 power_target, integral, derivative, proportional, adj_in_target, sval;
+	s64 integ_p, deriv_p, prop_p, sum; 
+	int i;
 
 	/* Calculate power target value (could be done once for all)
 	 * and convert to a 16.16 fp number
 	 */
 	power_target = ((u32)(state->mpu.pmaxh - state->mpu.padjmax)) << 16;
-
-	DBG("  current: %d.%03d, voltage: %d.%03d\n",
-	    FIX32TOPRINT(current_a), FIX32TOPRINT(voltage));
-	DBG("  power: %d.%03d W, target: %d.%03d, error: %d.%03d\n", FIX32TOPRINT(power),
+	DBG("  power target: %d.%03d, error: %d.%03d\n",
 	    FIX32TOPRINT(power_target), FIX32TOPRINT(power_target - power));
 
 	/* Store temperature and power in history array */
@@ -627,7 +750,7 @@
 	 * input target is mpu.ttarget, input max is mpu.tmax
 	 */
 	integ_p = ((s64)state->mpu.pid_gr) * (s64)integral;
-	DBG("   integ_p: %d\n", (int)(deriv_p >> 36));
+	DBG("   integ_p: %d\n", (int)(integ_p >> 36));
 	sval = (state->mpu.tmax << 16) - ((integ_p >> 20) & 0xffffffff);
 	adj_in_target = (state->mpu.ttarget << 16);
 	if (adj_in_target > sval)
@@ -656,15 +779,136 @@
 	DBG("   sum: %d\n", (int)sum);
 	state->rpm += (s32)sum;
 
-	if (state->rpm < state->mpu.rminn_exhaust_fan)
+	if (state->rpm < (int)state->mpu.rminn_exhaust_fan)
 		state->rpm = state->mpu.rminn_exhaust_fan;
-	if (state->rpm > state->mpu.rmaxn_exhaust_fan)
+	if (state->rpm > (int)state->mpu.rmaxn_exhaust_fan)
 		state->rpm = state->mpu.rmaxn_exhaust_fan;
+}
+
+static void do_monitor_cpu_combined(void)
+{
+	struct cpu_pid_state *state0 = &cpu_state[0];
+	struct cpu_pid_state *state1 = &cpu_state[1];
+	s32 temp0, power0, temp1, power1;
+	s32 temp_combi, power_combi;
+	int rc, intake, pump;
+
+	rc = do_read_one_cpu_values(state0, &temp0, &power0);
+	if (rc < 0) {
+		/* XXX What do we do now ? */
+	}
+	state1->overtemp = 0;
+	rc = do_read_one_cpu_values(state1, &temp1, &power1);
+	if (rc < 0) {
+		/* XXX What do we do now ? */
+	}
+	if (state1->overtemp)
+		state0->overtemp++;
+
+	temp_combi = max(temp0, temp1);
+	power_combi = max(power0, power1);
+
+	/* Check tmax, increment overtemp if we are there. At tmax+8, we go
+	 * full blown immediately and try to trigger a shutdown
+	 */
+	if (temp_combi >= ((state0->mpu.tmax + 8) << 16)) {
+		printk(KERN_WARNING "Warning ! Temperature way above maximum (%d) !\n",
+		       temp_combi >> 16);
+		state0->overtemp = CPU_MAX_OVERTEMP;
+	} else if (temp_combi > (state0->mpu.tmax << 16))
+		state0->overtemp++;
+	else
+		state0->overtemp = 0;
+	if (state0->overtemp >= CPU_MAX_OVERTEMP)
+		critical_state = 1;
+	if (state0->overtemp > 0) {
+		state0->rpm = state0->mpu.rmaxn_exhaust_fan;
+		state0->intake_rpm = intake = state0->mpu.rmaxn_intake_fan;
+		pump = CPU_PUMP_OUTPUT_MAX;
+		goto do_set_fans;
+	}
+
+	/* Do the PID */
+	do_cpu_pid(state0, temp_combi, power_combi);
+
+	/* Calculate intake fan speed */
+	intake = (state0->rpm * CPU_INTAKE_SCALE) >> 16;
+	if (intake < (int)state0->mpu.rminn_intake_fan)
+		intake = state0->mpu.rminn_intake_fan;
+	if (intake > (int)state0->mpu.rmaxn_intake_fan)
+		intake = state0->mpu.rmaxn_intake_fan;
+	state0->intake_rpm = intake;
+
+	/* Calculate pump speed */
+	pump = (state0->rpm * CPU_PUMP_OUTPUT_MAX) /
+		state0->mpu.rmaxn_exhaust_fan;
+	if (pump > CPU_PUMP_OUTPUT_MAX)
+		pump = CPU_PUMP_OUTPUT_MAX;
+	if (pump < CPU_PUMP_OUTPUT_MIN)
+		pump = CPU_PUMP_OUTPUT_MIN;
+	
+ do_set_fans:
+	/* We copy values from state 0 to state 1 for /sysfs */
+	state1->rpm = state0->rpm;
+	state1->intake_rpm = state0->intake_rpm;
+
+	DBG("** CPU %d RPM: %d Ex, %d, Pump: %d, In, overtemp: %d\n",
+	    state1->index, (int)state1->rpm, intake, pump, state1->overtemp);
+
+	/* We should check for errors, shouldn't we ? But then, what
+	 * do we do once the error occurs ? For FCU notified fan
+	 * failures (-EFAULT) we probably want to notify userland
+	 * some way...
+	 */
+	set_rpm_fan(CPUA_INTAKE_FAN_RPM_INDEX, intake);
+	set_rpm_fan(CPUA_EXHAUST_FAN_RPM_INDEX, state0->rpm);
+	set_rpm_fan(CPUB_INTAKE_FAN_RPM_INDEX, intake);
+	set_rpm_fan(CPUB_EXHAUST_FAN_RPM_INDEX, state0->rpm);
+
+	if (fcu_fans[CPUA_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID)
+		set_rpm_fan(CPUA_PUMP_RPM_INDEX, pump);
+	if (fcu_fans[CPUB_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID)
+		set_rpm_fan(CPUB_PUMP_RPM_INDEX, pump);
+}
+
+static void do_monitor_cpu_split(struct cpu_pid_state *state)
+{
+	s32 temp, power;
+	int rc, intake;
+
+	/* Read current fan status */
+	rc = do_read_one_cpu_values(state, &temp, &power);
+	if (rc < 0) {
+		/* XXX What do we do now ? */
+	}
+
+	/* Check tmax, increment overtemp if we are there. At tmax+8, we go
+	 * full blown immediately and try to trigger a shutdown
+	 */
+	if (temp >= ((state->mpu.tmax + 8) << 16)) {
+		printk(KERN_WARNING "Warning ! CPU %d temperature way above maximum"
+		       " (%d) !\n",
+		       state->index, temp >> 16);
+		state->overtemp = CPU_MAX_OVERTEMP;
+	} else if (temp > (state->mpu.tmax << 16))
+		state->overtemp++;
+	else
+		state->overtemp = 0;
+	if (state->overtemp >= CPU_MAX_OVERTEMP)
+		critical_state = 1;
+	if (state->overtemp > 0) {
+		state->rpm = state->mpu.rmaxn_exhaust_fan;
+		state->intake_rpm = intake = state->mpu.rmaxn_intake_fan;
+		goto do_set_fans;
+	}
+
+	/* Do the PID */
+	do_cpu_pid(state, temp, power);
 
 	intake = (state->rpm * CPU_INTAKE_SCALE) >> 16;
-	if (intake < state->mpu.rminn_intake_fan)
+	if (intake < (int)state->mpu.rminn_intake_fan)
 		intake = state->mpu.rminn_intake_fan;
-	if (intake > state->mpu.rmaxn_intake_fan)
+	if (intake > (int)state->mpu.rmaxn_intake_fan)
 		intake = state->mpu.rmaxn_intake_fan;
 	state->intake_rpm = intake;
 
@@ -678,11 +922,11 @@
 	 * some way...
 	 */
 	if (state->index == 0) {
-		set_rpm_fan(CPUA_INTAKE_FAN_RPM_ID, intake);
-		set_rpm_fan(CPUA_EXHAUST_FAN_RPM_ID, state->rpm);
+		set_rpm_fan(CPUA_INTAKE_FAN_RPM_INDEX, intake);
+		set_rpm_fan(CPUA_EXHAUST_FAN_RPM_INDEX, state->rpm);
 	} else {
-		set_rpm_fan(CPUB_INTAKE_FAN_RPM_ID, intake);
-		set_rpm_fan(CPUB_EXHAUST_FAN_RPM_ID, state->rpm);
+		set_rpm_fan(CPUB_INTAKE_FAN_RPM_INDEX, intake);
+		set_rpm_fan(CPUB_EXHAUST_FAN_RPM_INDEX, state->rpm);
 	}
 }
 
@@ -697,6 +941,7 @@
 	state->overtemp = 0;
 	state->adc_config = 0x00;
 
+
 	if (index == 0)
 		state->monitor = attach_i2c_chip(SUPPLY_MONITOR_ID, "CPU0_monitor");
 	else if (index == 1)
@@ -779,7 +1024,7 @@
 	DBG("backside:\n");
 
 	/* Check fan status */
-	rc = get_pwm_fan(BACKSIDE_FAN_PWM_ID);
+	rc = get_pwm_fan(BACKSIDE_FAN_PWM_INDEX);
 	if (rc < 0) {
 		printk(KERN_WARNING "Error %d reading backside fan !\n", rc);
 		/* XXX What do we do now ? */
@@ -791,12 +1036,12 @@
 	temp = i2c_smbus_read_byte_data(state->monitor, MAX6690_EXT_TEMP) << 16;
 	state->last_temp = temp;
 	DBG("  temp: %d.%03d, target: %d.%03d\n", FIX32TOPRINT(temp),
-	    FIX32TOPRINT(BACKSIDE_PID_INPUT_TARGET));
+	    FIX32TOPRINT(backside_params.input_target));
 
 	/* Store temperature and error in history array */
 	state->cur_sample = (state->cur_sample + 1) % BACKSIDE_PID_HISTORY_SIZE;
 	state->sample_history[state->cur_sample] = temp;
-	state->error_history[state->cur_sample] = temp - BACKSIDE_PID_INPUT_TARGET;
+	state->error_history[state->cur_sample] = temp - backside_params.input_target;
 	
 	/* If first loop, fill the history table */
 	if (state->first) {
@@ -805,7 +1050,7 @@
 				BACKSIDE_PID_HISTORY_SIZE;
 			state->sample_history[state->cur_sample] = temp;
 			state->error_history[state->cur_sample] =
-				temp - BACKSIDE_PID_INPUT_TARGET;
+				temp - backside_params.input_target;
 		}
 		state->first = 0;
 	}
@@ -817,7 +1062,7 @@
 		integral += state->error_history[i];
 	integral *= BACKSIDE_PID_INTERVAL;
 	DBG("  integral: %08x\n", integral);
-	integ_p = ((s64)BACKSIDE_PID_G_r) * (s64)integral;
+	integ_p = ((s64)backside_params.G_r) * (s64)integral;
 	DBG("   integ_p: %d\n", (int)(integ_p >> 36));
 	sum += integ_p;
 
@@ -826,12 +1071,12 @@
 		state->error_history[(state->cur_sample + BACKSIDE_PID_HISTORY_SIZE - 1)
 				    % BACKSIDE_PID_HISTORY_SIZE];
 	derivative /= BACKSIDE_PID_INTERVAL;
-	deriv_p = ((s64)BACKSIDE_PID_G_d) * (s64)derivative;
+	deriv_p = ((s64)backside_params.G_d) * (s64)derivative;
 	DBG("   deriv_p: %d\n", (int)(deriv_p >> 36));
 	sum += deriv_p;
 
 	/* Calculate the proportional term */
-	prop_p = ((s64)BACKSIDE_PID_G_p) * (s64)(state->error_history[state->cur_sample]);
+	prop_p = ((s64)backside_params.G_p) * (s64)(state->error_history[state->cur_sample]);
 	DBG("   prop_p: %d\n", (int)(prop_p >> 36));
 	sum += prop_p;
 
@@ -840,13 +1085,13 @@
 
 	DBG("   sum: %d\n", (int)sum);
 	state->pwm += (s32)sum;
-	if (state->pwm < BACKSIDE_PID_OUTPUT_MIN)
-		state->pwm = BACKSIDE_PID_OUTPUT_MIN;
-	if (state->pwm > BACKSIDE_PID_OUTPUT_MAX)
-		state->pwm = BACKSIDE_PID_OUTPUT_MAX;
+	if (state->pwm < backside_params.output_min)
+		state->pwm = backside_params.output_min;
+	if (state->pwm > backside_params.output_max)
+		state->pwm = backside_params.output_max;
 
 	DBG("** BACKSIDE PWM: %d\n", (int)state->pwm);
-	set_pwm_fan(BACKSIDE_FAN_PWM_ID, state->pwm);
+	set_pwm_fan(BACKSIDE_FAN_PWM_INDEX, state->pwm);
 }
 
 /*
@@ -854,6 +1099,35 @@
  */
 static int init_backside_state(struct backside_pid_state *state)
 {
+	struct device_node *u3;
+	int u3h = 1; /* conservative by default */
+
+	/*
+	 * There are different PID params for machines with U3 and machines
+	 * with U3H, pick the right ones now
+	 */
+	u3 = of_find_node_by_path("/u3@0,f8000000");
+	if (u3 != NULL) {
+		u32 *vers = (u32 *)get_property(u3, "device-rev", NULL);
+		if (vers)
+			if (((*vers) & 0x3f) < 0x34)
+				u3h = 0;
+		of_node_put(u3);
+	}
+
+	backside_params.G_p = BACKSIDE_PID_G_p;
+	backside_params.G_r = BACKSIDE_PID_G_r;
+	backside_params.output_max = BACKSIDE_PID_OUTPUT_MAX;
+	if (u3h) {
+		backside_params.G_d = BACKSIDE_PID_U3H_G_d;
+		backside_params.input_target = BACKSIDE_PID_U3H_INPUT_TARGET;
+		backside_params.output_min = BACKSIDE_PID_U3H_OUTPUT_MIN;
+	} else {
+		backside_params.G_d = BACKSIDE_PID_U3_G_d;
+		backside_params.input_target = BACKSIDE_PID_U3_INPUT_TARGET;
+		backside_params.output_min = BACKSIDE_PID_U3_OUTPUT_MIN;
+	}
+
 	state->ticks = 1;
 	state->first = 1;
 	state->pwm = 50;
@@ -899,7 +1173,7 @@
 	DBG("drives:\n");
 
 	/* Check fan status */
-	rc = get_rpm_fan(DRIVES_FAN_RPM_ID, !RPM_PID_USE_ACTUAL_SPEED);
+	rc = get_rpm_fan(DRIVES_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
 	if (rc < 0) {
 		printk(KERN_WARNING "Error %d reading drives fan !\n", rc);
 		/* XXX What do we do now ? */
@@ -966,7 +1240,7 @@
 		state->rpm = DRIVES_PID_OUTPUT_MAX;
 
 	DBG("** DRIVES RPM: %d\n", (int)state->rpm);
-	set_rpm_fan(DRIVES_FAN_RPM_ID, state->rpm);
+	set_rpm_fan(DRIVES_FAN_RPM_INDEX, state->rpm);
 }
 
 /*
@@ -1033,7 +1307,7 @@
 	}
 
 	/* Set the PCI fan once for now */
-	set_pwm_fan(SLOTS_FAN_PWM_ID, SLOTS_FAN_DEFAULT_PWM);
+	set_pwm_fan(SLOTS_FAN_PWM_INDEX, SLOTS_FAN_DEFAULT_PWM);
 
 	/* Initialize ADCs */
 	initialize_adc(&cpu_state[0]);
@@ -1045,17 +1319,16 @@
 	while (state == state_attached) {
 		unsigned long elapsed, start;
 
-		if (current->flags & PF_FREEZE) {
-			printk(KERN_INFO "therm_pm72: freezing thermostat\n");
-			refrigerator(PF_FREEZE);
-		}
-
 		start = jiffies;
 
 		down(&driver_lock);
-		do_monitor_cpu(&cpu_state[0]);
-		if (cpu_state[1].monitor != NULL)
-			do_monitor_cpu(&cpu_state[1]);
+		if (cpu_pid_type == CPU_PID_TYPE_COMBINED)
+			do_monitor_cpu_combined();
+		else {
+			do_monitor_cpu_split(&cpu_state[0]);
+			if (cpu_state[1].monitor != NULL)
+				do_monitor_cpu_split(&cpu_state[1]);
+		}
 		do_monitor_backside(&backside_state);
 		do_monitor_drives(&drives_state);
 		up(&driver_lock);
@@ -1119,6 +1392,19 @@
 
 	DBG("counted %d CPUs in the device-tree\n", cpu_count);
 
+	/* Decide the type of PID algorithm to use based on the presence of
+	 * the pumps, though that may not be the best way, that is good enough
+	 * for now
+	 */
+	if (machine_is_compatible("PowerMac7,3")
+	    && (cpu_count > 1)
+	    && fcu_fans[CPUA_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID
+	    && fcu_fans[CPUB_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID) {
+		printk(KERN_INFO "Liquid cooling pumps detected, using new algorithm !\n");
+		cpu_pid_type = CPU_PID_TYPE_COMBINED;
+	} else
+		cpu_pid_type = CPU_PID_TYPE_SPLIT;
+
 	/* Create control loops for everything. If any fail, everything
 	 * fails
 	 */
@@ -1263,12 +1549,91 @@
 	return 0;
 }
 
+static void fcu_lookup_fans(struct device_node *fcu_node)
+{
+	struct device_node *np = NULL;
+	int i;
+
+	/* The table is filled by default with values that are suitable
+	 * for the old machines without device-tree informations. We scan
+	 * the device-tree and override those values with whatever is
+	 * there
+	 */
+
+	DBG("Looking up FCU controls in device-tree...\n");
+
+	while ((np = of_get_next_child(fcu_node, np)) != NULL) {
+		int type = -1;
+		char *loc;
+		u32 *reg;
+
+		DBG(" control: %s, type: %s\n", np->name, np->type);
+
+		/* Detect control type */
+		if (!strcmp(np->type, "fan-rpm-control") ||
+		    !strcmp(np->type, "fan-rpm"))
+			type = FCU_FAN_RPM;
+		if (!strcmp(np->type, "fan-pwm-control") ||
+		    !strcmp(np->type, "fan-pwm"))
+			type = FCU_FAN_PWM;
+		/* Only care about fans for now */
+		if (type == -1)
+			continue;
+
+		/* Lookup for a matching location */
+		loc = (char *)get_property(np, "location", NULL);
+		reg = (u32 *)get_property(np, "reg", NULL);
+		if (loc == NULL || reg == NULL)
+			continue;
+		DBG(" matching location: %s, reg: 0x%08x\n", loc, *reg);
+
+		for (i = 0; i < FCU_FAN_COUNT; i++) {
+			int fan_id;
+
+			if (strcmp(loc, fcu_fans[i].loc))
+				continue;
+			DBG(" location match, index: %d\n", i);
+			fcu_fans[i].id = FCU_FAN_ABSENT_ID;
+			if (type != fcu_fans[i].type) {
+				printk(KERN_WARNING "therm_pm72: Fan type mismatch "
+				       "in device-tree for %s\n", np->full_name);
+				break;
+			}
+			if (type == FCU_FAN_RPM)
+				fan_id = ((*reg) - 0x10) / 2;
+			else
+				fan_id = ((*reg) - 0x30) / 2;
+			if (fan_id > 7) {
+				printk(KERN_WARNING "therm_pm72: Can't parse "
+				       "fan ID in device-tree for %s\n", np->full_name);
+				break;
+			}
+			DBG(" fan id -> %d, type -> %d\n", fan_id, type);
+			fcu_fans[i].id = fan_id;
+		}
+	}
+
+	/* Now dump the array */
+	printk(KERN_INFO "Detected fan controls:\n");
+	for (i = 0; i < FCU_FAN_COUNT; i++) {
+		if (fcu_fans[i].id == FCU_FAN_ABSENT_ID)
+			continue;
+		printk(KERN_INFO "  %d: %s fan, id %d, location: %s\n", i,
+		       fcu_fans[i].type == FCU_FAN_RPM ? "RPM" : "PWM",
+		       fcu_fans[i].id, fcu_fans[i].loc);
+	}
+}
+
 static int fcu_of_probe(struct of_device* dev, const struct of_match *match)
 {
 	int rc;
 
 	state = state_detached;
 
+	/* Lookup the fans in the device tree */
+	fcu_lookup_fans(dev->node);
+
+	/* Add the driver */
 	rc = i2c_add_driver(&therm_pm72_driver);
 	if (rc < 0)
 		return rc;
@@ -1307,15 +1672,20 @@
 {
 	struct device_node *np;
 
-	if (!machine_is_compatible("PowerMac7,2"))
+	if (!machine_is_compatible("PowerMac7,2") &&
+	    !machine_is_compatible("PowerMac7,3"))
 	    	return -ENODEV;
 
 	printk(KERN_INFO "PowerMac G5 Thermal control driver %s\n", VERSION);
 
 	np = of_find_node_by_type(NULL, "fcu");
 	if (np == NULL) {
-		printk(KERN_ERR "Can't find FCU in device-tree !\n");
-		return -ENODEV;
+		/* Some machines have strangely broken device-tree */
+		np = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/fan@15e");
+		if (np == NULL) {
+			    printk(KERN_ERR "Can't find FCU in device-tree !\n");
+			    return -ENODEV;
+		}
 	}
 	of_dev = of_platform_device_create(np, "temperature");
 	if (of_dev == NULL) {
Index: linux-work/drivers/macintosh/therm_pm72.h
===================================================================
--- linux-work.orig/drivers/macintosh/therm_pm72.h	2004-09-24 14:34:05.000000000 +1000
+++ linux-work/drivers/macintosh/therm_pm72.h	2004-10-22 11:07:51.290944832 +1000
@@ -119,18 +119,33 @@
 #define ADC_CPU_CURRENT_SCALE	0x1f40	/* _AD4 */
 
 /*
- * PID factors for the U3/Backside fan control loop
+ * PID factors for the U3/Backside fan control loop. We have 2 sets
+ * of values here, one set for U3 and one set for U3H
  */
-#define BACKSIDE_FAN_PWM_ID		1
-#define BACKSIDE_PID_G_d		0x02800000
+#define BACKSIDE_FAN_PWM_DEFAULT_ID	1
+#define BACKSIDE_FAN_PWM_INDEX		0
+#define BACKSIDE_PID_U3_G_d		0x02800000
+#define BACKSIDE_PID_U3H_G_d		0x01400000
 #define BACKSIDE_PID_G_p		0x00500000
 #define BACKSIDE_PID_G_r		0x00000000
-#define BACKSIDE_PID_INPUT_TARGET	0x00410000
+#define BACKSIDE_PID_U3_INPUT_TARGET	0x00410000
+#define BACKSIDE_PID_U3H_INPUT_TARGET	0x004b0000
 #define BACKSIDE_PID_INTERVAL		5
 #define BACKSIDE_PID_OUTPUT_MAX		100
-#define BACKSIDE_PID_OUTPUT_MIN		20
+#define BACKSIDE_PID_U3_OUTPUT_MIN	20
+#define BACKSIDE_PID_U3H_OUTPUT_MIN	30
 #define BACKSIDE_PID_HISTORY_SIZE	2
 
+struct basckside_pid_params
+{
+	s32			G_d;
+	s32			G_p;
+	s32			G_r;
+	s32			input_target;
+	s32			output_min;
+	s32			output_max;
+};
+
 struct backside_pid_state
 {
 	int			ticks;
@@ -146,7 +161,8 @@
 /*
  * PID factors for the Drive Bay fan control loop
  */
-#define DRIVES_FAN_RPM_ID      		2
+#define DRIVES_FAN_RPM_DEFAULT_ID	2
+#define DRIVES_FAN_RPM_INDEX		1
 #define DRIVES_PID_G_d			0x01e00000
 #define DRIVES_PID_G_p			0x00500000
 #define DRIVES_PID_G_r			0x00000000
@@ -168,7 +184,8 @@
 	int			first;
 };
 
-#define SLOTS_FAN_PWM_ID       		2
+#define SLOTS_FAN_PWM_DEFAULT_ID	2
+#define SLOTS_FAN_PWM_INDEX		2
 #define	SLOTS_FAN_DEFAULT_PWM		50 /* Do better here ! */
 
 /*
@@ -191,10 +208,15 @@
  * CPU B FAKE POWER	49	(I_V_inputs: 18, 19)
  */
 
-#define CPUA_INTAKE_FAN_RPM_ID		3
-#define CPUA_EXHAUST_FAN_RPM_ID		4
-#define CPUB_INTAKE_FAN_RPM_ID		5
-#define CPUB_EXHAUST_FAN_RPM_ID		6
+#define CPUA_INTAKE_FAN_RPM_DEFAULT_ID	3
+#define CPUA_EXHAUST_FAN_RPM_DEFAULT_ID	4
+#define CPUB_INTAKE_FAN_RPM_DEFAULT_ID	5
+#define CPUB_EXHAUST_FAN_RPM_DEFAULT_ID	6
+
+#define CPUA_INTAKE_FAN_RPM_INDEX	3
+#define CPUA_EXHAUST_FAN_RPM_INDEX	4
+#define CPUB_INTAKE_FAN_RPM_INDEX	5
+#define CPUB_EXHAUST_FAN_RPM_INDEX	6
 
 #define CPU_INTAKE_SCALE		0x0000f852
 #define CPU_TEMP_HISTORY_SIZE		2
@@ -202,6 +224,11 @@
 #define CPU_PID_INTERVAL		1
 #define CPU_MAX_OVERTEMP		30
 
+#define CPUA_PUMP_RPM_INDEX		7
+#define CPUB_PUMP_RPM_INDEX		8
+#define CPU_PUMP_OUTPUT_MAX		3700
+#define CPU_PUMP_OUTPUT_MIN		1000
+
 struct cpu_pid_state
 {
 	int			index;
@@ -219,6 +246,7 @@
 	s32			voltage;
 	s32			current_a;
 	s32			last_temp;
+	s32			last_power;
 	int			first;
 	u8			adc_config;
 };


