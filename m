Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUCKDOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCKDOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:14:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:47828 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262964AbUCKDOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:14:05 -0500
Subject: [PATCH] G5 temperature control update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078974608.9746.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 14:10:09 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch makes the temperature control code more robust, putting
less pressure on i2c, and work around occasional misconfiguration
of the ADC chips leading to incorrect temperature readings.

Ben.

===== drivers/macintosh/therm_pm72.c 1.1 vs edited =====
--- 1.1/drivers/macintosh/therm_pm72.c	Thu Feb  5 17:23:50 2004
+++ edited/drivers/macintosh/therm_pm72.c	Thu Mar 11 14:08:13 2004
@@ -2,7 +2,7 @@
  * Device driver for the thermostats & fan controller of  the
  * Apple G5 "PowerMac7,2" desktop machines.
  *
- * (c) Copyright IBM Corp. 2003
+ * (c) Copyright IBM Corp. 2003-2004
  *
  * Maintained by: Benjamin Herrenschmidt
  *                <benh@kernel.crashing.org>
@@ -45,7 +45,7 @@
  *        - Add things like /sbin/overtemp for non-critical
  *          overtemp conditions so userland can take some policy
  *          decisions, like slewing down CPUs
- *	  - Deal with fan failures
+ *	  - Deal with fan and i2c failures in a better way
  *
  * History:
  *
@@ -63,9 +63,16 @@
  *	- Move back statics definitions to .c file
  *	- Avoid calling schedule_timeout with a negative number
  *
- *  Dev. 18, 2003 : 0.8
+ *  Dec. 18, 2003 : 0.8
  *	- Fix typo when reading back fan speed on 2 CPU machines
  *
+ *  Mar. 11, 2004 : 0.9
+ *	- Rework code accessing the ADC chips, make it more robust and
+ *	  closer to the chip spec. Also make sure it is configured properly,
+ *        I've seen yet unexplained cases where on startup, I would have stale
+ *        values in the configuration register
+ *	- Switch back to use of target fan speed for PID, thus lowering
+ *        pressure on i2c
  */
 
 #include <linux/config.h>
@@ -94,14 +101,14 @@
 
 #include "therm_pm72.h"
 
-#define VERSION "0.8"
+#define VERSION "0.9"
 
 #undef DEBUG
 
 #ifdef DEBUG
 #define DBG(args...)	printk(args)
 #else
-#define DBG(args...)
+#define DBG(args...)	do { } while(0)
 #endif
 
 
@@ -194,14 +201,76 @@
 /*
  * Here are the i2c chip access wrappers
  */
-static int read_smon_adc(struct i2c_client *chip, int chan)
+
+static void initialize_adc(struct cpu_pid_state *state)
+{
+	int rc;
+	u8 buf[2];
+
+	/* Read ADC the configuration register and cache it. We
+	 * also make sure Config2 contains proper values, I've seen
+	 * cases where we got stale grabage in there, thus preventing
+	 * proper reading of conv. values
+	 */
+
+	/* Clear Config2 */
+	buf[0] = 5;
+	buf[1] = 0;
+	i2c_master_send(state->monitor, buf, 2);
+
+	/* Read & cache Config1 */
+	buf[0] = 1;
+	rc = i2c_master_send(state->monitor, buf, 1);
+	if (rc > 0) {
+		rc = i2c_master_recv(state->monitor, buf, 1);
+		if (rc > 0) {
+			state->adc_config = buf[0];
+			DBG("ADC config reg: %02x\n", state->adc_config);
+			/* Disable shutdown mode */
+		       	state->adc_config &= 0xfe;
+			buf[0] = 1;
+			buf[1] = state->adc_config;
+			rc = i2c_master_send(state->monitor, buf, 2);
+		}
+	}
+	if (rc <= 0)
+		printk(KERN_ERR "therm_pm72: Error reading ADC config"
+		       " register !\n");
+}
+
+static int read_smon_adc(struct cpu_pid_state *state, int chan)
 {
-	int ctrl;
+	int rc, data, tries = 0;
+	u8 buf[2];
 
-	ctrl = i2c_smbus_read_byte_data(chip, 1);
-	i2c_smbus_write_byte_data(chip, 1, (ctrl & 0x1f) | (chan << 5));
-	wait_ms(1);
-	return le16_to_cpu(i2c_smbus_read_word_data(chip, 4)) >> 6;
+	for (;;) {
+		/* Set channel */
+		buf[0] = 1;
+		buf[1] = (state->adc_config & 0x1f) | (chan << 5);
+		rc = i2c_master_send(state->monitor, buf, 2);
+		if (rc <= 0)
+			goto error;
+		/* Wait for convertion */
+		wait_ms(1);
+		/* Switch to data register */
+		buf[0] = 4;
+		rc = i2c_master_send(state->monitor, buf, 1);
+		if (rc <= 0)
+			goto error;
+		/* Read result */
+		rc = i2c_master_recv(state->monitor, buf, 2);
+		if (rc < 0)
+			goto error;
+		data = ((u16)buf[0]) << 8 | (u16)buf[1];
+		return data >> 6;
+	error:
+		DBG("Error reading ADC, retrying...\n");
+		if (++tries > 10) {
+			printk(KERN_ERR "therm_pm72: Error reading ADC !\n");
+			return -1;
+		}
+		wait_ms(10);
+	}
 }
 
 static int fan_read_reg(int reg, unsigned char *buf, int nb)
@@ -460,9 +529,13 @@
 	DBG("  current rpm: %d\n", state->rpm);
 
 	/* Get some sensor readings and scale it */
-	temp = read_smon_adc(state->monitor, 1);
-	voltage = read_smon_adc(state->monitor, 3);
-	current_a = read_smon_adc(state->monitor, 4);
+	temp = read_smon_adc(state, 1);
+	if (temp == -1) {
+		state->overtemp++;
+		return;
+	}
+	voltage = read_smon_adc(state, 3);
+	current_a = read_smon_adc(state, 4);
 
 	/* Fixup temperature according to diode calibration
 	 */
@@ -476,7 +549,8 @@
 	 * full blown immediately and try to trigger a shutdown
 	 */
 	if (temp >= ((state->mpu.tmax + 8) << 16)) {
-		printk(KERN_WARNING "Warning ! CPU %d temperature way above maximum (%d) !\n",
+		printk(KERN_WARNING "Warning ! CPU %d temperature way above maximum"
+		       " (%d) !\n",
 		       state->index, temp >> 16);
 		state->overtemp = CPU_MAX_OVERTEMP;
 	} else if (temp > (state->mpu.tmax << 16))
@@ -613,6 +687,7 @@
 	state->first = 1;
 	state->rpm = 1000;
 	state->overtemp = 0;
+	state->adc_config = 0x00;
 
 	if (index == 0)
 		state->monitor = attach_i2c_chip(SUPPLY_MONITOR_ID, "CPU0_monitor");
@@ -941,8 +1016,17 @@
 
 	DBG("main_control_loop started\n");
 
+	down(&driver_lock);
+
 	/* Set the PCI fan once for now */
 	set_pwm_fan(SLOTS_FAN_PWM_ID, SLOTS_FAN_DEFAULT_PWM);
+
+	/* Initialize ADCs */
+	initialize_adc(&cpu_state[0]);
+	if (cpu_state[1].monitor != NULL)
+		initialize_adc(&cpu_state[1]);
+
+	up(&driver_lock);
 
 	while (state == state_attached) {
 		unsigned long elapsed, start;
===== drivers/macintosh/therm_pm72.h 1.1 vs edited =====
--- 1.1/drivers/macintosh/therm_pm72.h	Thu Feb  5 17:23:51 2004
+++ edited/drivers/macintosh/therm_pm72.h	Thu Mar 11 12:32:46 2004
@@ -85,7 +85,7 @@
  * I'm not sure which of these Apple's algorithm is supposed
  * to use
  */
-#define RPM_PID_USE_ACTUAL_SPEED		1
+#define RPM_PID_USE_ACTUAL_SPEED		0
 
 /*
  * i2c IDs. Currently, we hard code those and assume that
@@ -220,6 +220,7 @@
 	s32			current_a;
 	s32			last_temp;
 	int			first;
+	u8			adc_config;
 };
 
 /*


