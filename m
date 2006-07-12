Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWGLXGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWGLXGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWGLXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:06:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932467AbWGLXGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:06:18 -0400
Date: Thu, 13 Jul 2006 01:04:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz
Subject: [FYI] better battery sensing code for collie
Message-ID: <20060712230430.GA4636@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I played a bit with battery sensing code, and found out that default
sharp thresholds only use 40% (!) of my battery capacity. Collie seems
to work down to 3.35V.. I even added the code to guess current power
consumption, and compute internal battery voltage, so guesses should
be less depended on backlight settings.

(Internal battery resistance seems to be ~1ohm, unfortunately changes
with charge).

More precise values would be welcome, as would be some temperature
calibration. 

Here are relevant parts of my diff... One possible message is "having
values in miliVolts actually has some benefits". Perhaps we could even
share voltage tables between different zauruses... I can use collie
(sl-5500) battery in spitz (c-3000) just fine, for example.

								Pavel
diff --git a/Documentation/collie-battery.txt b/Documentation/collie-battery.txt
new file mode 100755
index 0000000..6c132c0
--- /dev/null
+++ b/Documentation/collie-battery.txt
@@ -0,0 +1,180 @@
+#!/bin/bash
+( 
+  while true; do
+	read hour min volt rem || exit
+	t=$[$hour*60 + $min - 4*60 - 7]
+	percent=$[100*$t /146]
+	percent=$[100-percent]
+#	echo $t $volt $percent '#' $rem; 
+	echo "	{ $volt, $percent }, /* at $t minutes was $rem */ "
+done ) < collie-battery.raw
+exit
+
+132mA base system
++103mA for 25% backlight
++155mA for 50% backlight
++270mA for 75% backlight
++450mA for 100% backlight
++284mA for audio + cpu (mp3 playback)
+
+(with default brightness)
+3:10 (approx): collie reports charge full. Battery is at 4.2V most of the time.
+3:57 still charging?
+4:07 started discharge
+
+4:07 killed charger: 398, 100% and 401, 100%
+4:10 396, 100%
+4:12 394, 100%
+4:14 392, 100%
+4:15 390, 90%
+4:19 388, 90%
+4:22 386, 90%
+4:24 385, 85%
+4:28 381, 85%
+4:29 380, 80%
+4:31 379, 80%
+4:33 378, 80%
+4:35 377, 80%
+4:37 376, 80%
+4:39 375, 70%
+4:40 374, 70%
+4:42 373, 70%
+4:45 372, 70%
+4:49 370, 60%
+4:53 368, 60%
+4:55 364, 50%
+4:59 362, 40%
+5:02 360, 30%
+5:05 359, 30%
+5:07 autosuspend :-(
+5:08 357, 0%
+5:10 358, 0%
+5:11 356, 0%
+5:13 356, 0%
+5:16 357, 0%
+5:18 357, 0%
+5:21 355, 0%
+5:23 355, 0%
+5:24 354, 0%, turned brightness to 0
+5:24 366, 0% (on brighness 0)
+5:25 turned brighness to 2.
+5:27 354, 0%
+5:28 353, 0%
+5:31 352, 0%
+5:32 352, 0%
+5:37 351, 0%
+5:39 350
+5:42 349
+5:44 350
+5:47 349
+5:49 348
+5:52 347
+6:00 345
+6:02 345, turned brighness to 0
+6:03 357 (on brighness 0), 359, 360, brightness = 2
+6:08 343
+6:11 341
+6:15 339
+6:16 338
+6:18 337
+6:19 335
+6:21 334
+6:23 332 I start to see artifacts on screen.
+6:24 330
+6:25 327
+6:28 326, brightness = 0
+6:28 344, 345, 345, 346, brightness = 2
+6:32 318
+6:33 315 
+
+6:34 312 display failed, start charging.
+6:35 402 55%
+6:36 406 60%
+6:37 410 60%
+6:39 413 65%
+6:41 414 65%
+6:45 414 65%
+6:46 415 65%
+6:50 416 70%
+6:54 417 70%
+6:59 418 75%
+7:00 AC unlpuged
+7:00 374 70%
+7:01 367 0%
+7:02 366 0%
+7:02 AC replugged
+7:03 414 65%
+7:06 417 70%
+7:08 418 75%
+
+U_observed = U_battery - R_battery * current
+
+R_battery = (U_observed_1 - U_observed_2) / (current_2 - current_1)
+
+16:03: R_battery = (3.45 V - 3.59 V) / (132 mA - 132 mA - 155 mA) \ ohm = 0.9032 Ohm
+sanity check:
+15:23: R_battery = (3.54 V - 3.66 V) / (132 mA - 132 mA - 155 mA) \ ohm = 0.7742 Ohm
+16:28: R_battery = (3.28 V - 3.46 V) / (132 mA - 132 mA - 155 mA) \ ohm = 1.1612 Ohm
+
+6:34-4:07: battery lasted 2:27 == 147 minutes.
+
+time voltage percent old_percent
+================================
+0 401 100 #
+3 396 98 # 100%
+5 394 97 # 100%
+7 392 96 # 100%
+8 390 95 # 90%
+12 388 92 # 90%
+15 386 90 # 90%
+17 385 89 # 85%
+21 381 86 # 85%
+22 380 85 # 80%
+24 379 84 # 80%
+26 378 83 # 80%
+28 377 81 # 80%
+30 376 80 # 80%
+32 375 79 # 70%
+33 374 78 # 70%
+35 373 77 # 70%
+38 372 74 # 70%
+42 370 72 # 60%
+46 368 69 # 60%
+48 364 68 # 50%
+52 362 65 # 40%
+55 360 63 # 30%
+58 359 61 # 30%
+61 357 59 # 0%
+63 358 57 # 0%
+64 356 57 # 0%
+66 356 55 # 0%
+69 357 53 # 0%
+71 357 52 # 0%
+74 355 50 # 0%
+76 355 48 # 0%
+77 354 48 # 0%
+80 354 46 # 0%
+81 353 45 # 0%
+84 352 43 # 0%
+85 352 42 # 0%
+90 351 39 # 0%
+92 350 37 #
+95 349 35 #
+97 350 34 #
+100 349 32 #
+102 348 31 #
+105 347 29 #
+113 345 23 #
+121 343 18 #
+124 341 16 #
+128 339 13 #
+129 338 12 #
+131 337 11 #
+132 335 10 #
+134 334 9 #
+136 332 7 #
+137 330 7 #
+138 327 6 #
+141 326 4 #
+145 318 1 #
+146 315 0 #
diff --git a/arch/arm/common/sharpsl_pm.c b/arch/arm/common/sharpsl_pm.c
index 045e37e..ae37a39 100644
--- a/arch/arm/common/sharpsl_pm.c
+++ b/arch/arm/common/sharpsl_pm.c
@@ -12,7 +12,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/module.h>
 #include <linux/timer.h>
@@ -28,16 +28,22 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/apm.h>
+
+#ifndef CONFIG_SA1100_COLLIE
 #include <asm/arch/pm.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/sharpsl.h>
+#endif
 #include <asm/hardware/sharpsl_pm.h>
 
+#define dev_dbg(a, b...) printk(b)
+
+
 /*
  * Constants
  */
 #define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
-#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
+#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(30*60*1000)) /* 30 min */
 #define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
 #define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
 #define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
@@ -114,10 +120,27 @@ void sharpsl_battery_kick(void)
 }
 EXPORT_SYMBOL(sharpsl_battery_kick);
 
+int basic_current = 132; /* miliAmp */
+int battery_resistance = 903; /* miliOhm */
+extern int backlight_current;
+
+int battery_current(void)
+{
+	return basic_current + backlight_current;
+}
+
+int liion_internal_voltage(int voltage, int current_ma)
+{
+	return voltage + (battery_resistance * current_ma / 1000);
+}
+
+int liion_expected_voltage(int internal_voltage, int current_ma)
+{	return internal_voltage - (battery_resistance * current_ma / 1000);
+}
 
 static void sharpsl_battery_thread(void *private_)
 {
-	int voltage, percent, apm_status, i = 0;
+	int voltage, raw_voltage, internal_voltage, percent, apm_status, i = 0;
 
 	if (!sharpsl_pm.machinfo)
 		return;
@@ -140,7 +163,9 @@ static void sharpsl_battery_thread(void 
 		}
 	}
 
-	voltage = sharpsl_average_value(voltage);
+	raw_voltage = voltage = sharpsl_average_value(voltage);
+	internal_voltage = liion_internal_voltage(voltage * 10, battery_current());
+	voltage = liion_expected_voltage(internal_voltage, 132+155) / 10;
 	apm_status = get_apm_status(voltage);
 	percent = get_percentage(voltage);
 
@@ -152,9 +177,11 @@ static void sharpsl_battery_thread(void 
 		sharpsl_pm.battstat.mainbat_percent = percent;
 	}
 
-	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %d\n", voltage,
+	dev_dbg(sharpsl_pm.dev, "Voltage: raw %d mV, %d mA, bat %d mV, corr: %d mV\n", raw_voltage * 10, battery_current(), internal_voltage, voltage * 10);
+	dev_dbg(sharpsl_pm.dev, "Battery: %d dV, status: %d, %d %%, time: %d\n", voltage,
 			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
 
+#ifndef CONFIG_SA1100_COLLIE
 	/* If battery is low. limit backlight intensity to save power. */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
 			&& ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW) ||
@@ -167,6 +194,7 @@ static void sharpsl_battery_thread(void 
 		sharpsl_pm.machinfo->backlight_limit(0);
 		sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
 	}
+#endif
 
 	/* Suspend if critical battery level */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
@@ -276,13 +304,23 @@ static void sharpsl_chrg_full_timer(unsi
 		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
 		if (sharpsl_pm.charge_mode == CHRG_ON)
 			sharpsl_charge_off();
-	} else if (sharpsl_pm.full_count < 2) {
+		return;
+	} 
+#ifndef CONFIG_SA1100_COLLIE
+	if (sharpsl_pm.full_count < 2) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
 		schedule_work(&toggle_charger);
-	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
+		return;
+	}
+#endif
+	if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
 		schedule_work(&toggle_charger);
-	} else {
+		return;
+	}
+
+	/* collie checks if battery voltage is lower than 465, and if so, it calls it charge error */
+	{
 		sharpsl_charge_off();
 		sharpsl_pm.charge_mode = CHRG_DONE;
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
@@ -294,6 +332,15 @@ static void sharpsl_chrg_full_timer(unsi
    delay until after that has been processed */
 irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
 {
+	extern int volatile force_charge;
+
+	if (force_charge) {
+		printk("charge full: Interrupt came but we are ignoring it\n");
+		force_charge = 0;
+		return IRQ_HANDLED;
+	}
+
+	printk("charge full interrupt came\n");
 	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
 		return IRQ_HANDLED;
 
@@ -412,8 +459,10 @@ static int sharpsl_check_battery_temp(vo
 	val = get_select_val(buff);
 
 	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > sharpsl_pm.machinfo->charge_on_temp)
+	if (val > sharpsl_pm.machinfo->charge_on_temp) {
+		printk(KERN_WARNING "Not charging: temperature out of limits.\n"); 
 		return -1;
+	}
 
 	return 0;
 }
@@ -502,6 +551,7 @@ static void corgi_goto_sleep(unsigned lo
 	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
 	/* not charging and AC-IN! */
 
+#ifndef CONFIG_SA1100_COLLIE
 	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN))) {
 		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
 		sharpsl_pm.charge_mode = CHRG_OFF;
@@ -532,6 +582,7 @@ static void corgi_goto_sleep(unsigned lo
 	sharpsl_pm.machinfo->postsuspend();
 
 	dev_dbg(sharpsl_pm.dev, "Corgi woken up from suspend: %08x\n",PEDR);
+#endif
 }
 
 static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
@@ -629,6 +680,7 @@ static int sharpsl_fatal_check(void)
 
 static int sharpsl_off_charge_error(void)
 {
+	panic("collie: not off charging\n");
 	dev_err(sharpsl_pm.dev, "Offline Charger: Error occured.\n");
 	sharpsl_pm.machinfo->charge(0);
 	sharpsl_pm_led(SHARPSL_LED_ERROR);
@@ -645,6 +697,7 @@ static int sharpsl_off_charge_battery(vo
 {
 	int time;
 
+	panic("off_charging -- not on collie\n");
 	dev_dbg(sharpsl_pm.dev, "Charge Mode: %d\n", sharpsl_pm.charge_mode);
 
 	if (sharpsl_pm.charge_mode == CHRG_OFF) {
@@ -761,9 +814,11 @@ static void sharpsl_apm_get_power_status
 
 static struct pm_ops sharpsl_pm_ops = {
 	.pm_disk_mode	= PM_DISK_FIRMWARE,
+#ifndef CONFIG_SA1100_COLLIE
 	.prepare	= pxa_pm_prepare,
 	.enter		= corgi_pxa_pm_enter,
 	.finish		= pxa_pm_finish,
+#endif
 };
 
 static int __init sharpsl_pm_probe(struct platform_device *pdev)
@@ -773,6 +828,7 @@ static int __init sharpsl_pm_probe(struc
 
 	sharpsl_pm.dev = &pdev->dev;
 	sharpsl_pm.machinfo = pdev->dev.platform_data;
+
 	sharpsl_pm.charge_mode = CHRG_OFF;
 	sharpsl_pm.flags = 0;
 
diff --git a/arch/arm/mach-sa1100/collie_pm.c b/arch/arm/mach-sa1100/collie_pm.c
index 45b1e71..642c866 100644
--- a/arch/arm/mach-sa1100/collie_pm.c
+++ b/arch/arm/mach-sa1100/collie_pm.c
@@ -9,6 +9,9 @@
  * Li-ion batteries are angry beasts, and they like to explode. This driver is not finished,
  * and sometimes charges them when it should not. If it makes angry lithium to come your way...
  * ...well, you have been warned.
+ *
+ * Actually, this should be quite safe, it seems sharp leaves charger enabled by default,
+ * and my collie did not explode (yet).
  */
 
 #include <linux/module.h>
@@ -34,15 +37,16 @@
 static struct ucb1x00 *ucb;
 static int ad_revise;
 
+volatile int force_charge = 0;
+
 #define ADCtoPower(x)	       ((330 * x * 2) / 1024)
 
 static void collie_charger_init(void)
 {
 	int err;
 
-	if (sharpsl_param.adadj != -1) {
+	if (sharpsl_param.adadj != -1)
 		ad_revise = sharpsl_param.adadj;
-	}
 
 	/* Register interrupt handler. */
 	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, IRQF_DISABLED,
@@ -72,27 +76,31 @@ static void collie_measure_temp(int on)
 
 static void collie_charge(int on)
 {
-	if (on) {
-		printk("Should start charger\n");
-	} else {
-		printk("Should stop charger\n");
-	}
-#ifdef I_AM_SURE
+	extern struct platform_device colliescoop_device;
 
-	/* Zaurus seems to contain LTC1731 ; it should know when to
+	/* Zaurus seems to contain LTC1731; it should know when to
 	 * stop charging itself, so setting charge on should be
 	 * relatively harmless (as long as it is not done too often).
 	 */
-#define CF_BUF_CTRL_BASE 0xF0800000
-#define        SCOOP_REG(adr) (*(volatile unsigned short*)(CF_BUF_CTRL_BASE+(adr)))
-#define        SCOOP_REG_GPWR    SCOOP_REG(SCOOP_GPWR)
-
 	if (on) {
+		printk("Collie: starting charger\n");
+		force_charge = 1;
 		set_scoop_gpio(&colliescoop_device.dev, COLLIE_SCP_CHARGE_ON);
+		mdelay(100);
+		if (force_charge)
+			printk("Interrupt should acknowledge charger on status?!\n");
+		printk("Collie: charger started?\n");
 	} else {
+		printk("Collie: stopping charger\n");
 		reset_scoop_gpio(&colliescoop_device.dev, COLLIE_SCP_CHARGE_ON);
+		force_charge = 1;
+		set_scoop_gpio(&colliescoop_device.dev, COLLIE_SCP_CHARGE_ON);
+		mdelay(100);
+		if (force_charge)
+			printk("Interrupt should acknowledge charger off?!\n");
+		printk("Collie: charger stopped?\n");
 	}
-#endif
+	force_charge = 0;
 }
 
 static void collie_discharge(int on)
@@ -127,7 +135,6 @@ int collie_read_backup_battery(void)
 
 	ucb1x00_adc_enable(ucb);
 
-	/* Gives 75..130 */
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_BBAT_ON, 0);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
 
@@ -146,9 +153,8 @@ int collie_read_main_battery(void)
 	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_MBAT_ON, 0);
-	/* gives values 160..255 with battery removed... and
-	   145..255 with battery inserted. (on AC), goes as low as
-	   80 on DC. */
+
+	mdelay(1);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
 
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON);
@@ -175,7 +181,7 @@ int collie_read_temp(void)
 
 	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_TMP_ON, 0);
-	/* >1010 = battery removed, 460 = 22C ?, higer = lower temp ? */
+	/* >1010 = battery removed, 460 = 22C, 550 = 27C, higer = lower temp ? */
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD0, UCB_SYNC);
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_TMP_ON);
 	ucb1x00_adc_disable(ucb);
@@ -192,7 +198,7 @@ static unsigned long read_devdata(int wh
 	case SHARPSL_BATT_TEMP:
 		return collie_read_temp();
 	case SHARPSL_ACIN_VOLT:
-		return 0x1;
+		return 500;
 	case SHARPSL_STATUS_ACIN: {
 		int ret = GPLR & COLLIE_GPIO_AC_IN;
 		printk("AC status = %d\n", ret);
@@ -208,11 +214,127 @@ static unsigned long read_devdata(int wh
 	}
 }
 
+/*
+{ 420, 100 },
+{ 417, 95 }, means it will report 100% between 418 and 420
+*/
+
+/* It looks like these values are in deciVolts */
+struct battery_thresh collie_battery_levels_acin[] = {
+	{ 420, 70 },
+	{ 419, 60 },
+	{ 418, 50 },
+	{ 417, 40 },
+	{ 416, 30 },
+	{ 415, 27 },
+	{ 414, 25 },
+	{ 413, 23 },
+	{ 412, 20 },
+	{ 411, 17 },
+	{ 410, 15 },
+	{ 409, 13 },
+	{ 408, 11 },
+	{ 407, 9 },
+	{ 406, 8 },
+	{ 405, 7 },
+	{ 404, 6 }, 
+	{ 403, 5 }, 
+	{ 402, 4 }, 
+	{ 401, 3 }, 
+	{ 400, 2 }, 
+	{ 390, 1 }, 
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+	{   0, 0 },
+};
+
+
+/* See for example http://www.kokam.com/english/biz/rc.html for
+ * voltage/capacity characteristic. I assume it is going to be
+ * reasonably similar to li-ion used in collie.
+ *
+ * Collie with frontlight level 2 will last ~2.5 hours, so we are at
+ * ~0.5C. */
+
+	/* From sharp code: battery high with frontlight: 368 */
+	/* From sharp code: battery low with frontlight: 358 */
+	/* From sharp code: battery verylow with frontlight: 356 */
 struct battery_thresh collie_battery_levels[] = {
-	{ 368, 100},
-	{ 358,  25},
-	{ 356,   5},
-	{   0,   0},
+	{ 398, 100 }, /* at 0 minutes */ 
+	{ 396, 98 }, /* at 3 minutes */ 
+	{ 394, 97 }, /* at 5 minutes */ 
+	{ 392, 96 }, /* at 7 minutes */ 
+	{ 390, 95 }, /* at 8 minutes */ 
+	{ 388, 92 }, /* at 12 minutes */ 
+	{ 386, 90 }, /* at 15 minutes */ 
+	{ 385, 89 }, /* at 17 minutes */ 
+	{ 381, 86 }, /* at 21 minutes */ 
+	{ 380, 85 }, /* at 22 minutes */ 
+	{ 379, 84 }, /* at 24 minutes */ 
+	{ 378, 83 }, /* at 26 minutes */ 
+	{ 377, 81 }, /* at 28 minutes */ 
+	{ 376, 80 }, /* at 30 minutes */ 
+	{ 375, 79 }, /* at 32 minutes */ 
+	{ 374, 78 }, /* at 33 minutes */ 
+	{ 373, 77 }, /* at 35 minutes */ 
+	{ 372, 74 }, /* at 38 minutes */ 
+	{ 370, 72 }, /* at 42 minutes */ 
+	{ 368, 69 }, /* at 46 minutes */ 
+	{ 364, 68 }, /* at 48 minutes */ 
+	{ 362, 65 }, /* at 52 minutes */ 
+	{ 360, 63 }, /* at 55 minutes */ 
+	{ 359, 61 }, /* at 58 minutes */ 
+	{ 357, 59 }, /* at 61 minutes */ 
+	{ 358, 57 }, /* at 63 minutes */ 
+	{ 356, 55 }, /* at 66 minutes */ 
+	{ 355, 48 }, /* at 76 minutes */ 
+	{ 354, 46 }, /* at 80 minutes */ 
+	{ 353, 45 }, /* at 81 minutes */ 
+	{ 352, 42 }, /* at 85 minutes */ 
+	{ 351, 39 }, /* at 90 minutes */ 
+	{ 350, 37 }, /* at 92 minutes */ 
+	{ 349, 33 }, /* at 100 minutes */ 
+	{ 348, 31 }, /* at 102 minutes */ 
+	{ 347, 29 }, /* at 105 minutes */ 
+	{ 345, 23 }, /* at 113 minutes */ 
+	{ 343, 18 }, /* at 121 minutes */ 
+	{ 341, 16 }, /* at 124 minutes */ 
+	{ 339, 13 }, /* at 128 minutes */ 
+	{ 338, 12 }, /* at 129 minutes */ 
+	{ 337, 11 }, /* at 131 minutes */ 
+	{ 335, 10 }, /* at 132 minutes */ 
+	{ 334, 9 }, /* at 134 minutes */ 
+	{ 330, 7 }, /* at 137 minutes */ 
+	{ 327, 6 }, /* at 138 minutes */ 
+	{ 326, 4 }, /* at 141 minutes */ 
+	{ 318, 2 }, /* at 145 minutes */ 
+	{ 315, 1 }, /* at 146 minutes */ 
+	{   0, 0 },
 };
 
 struct sharpsl_charger_machinfo collie_pm_machinfo = {
@@ -226,13 +348,21 @@ struct sharpsl_charger_machinfo collie_p
 	.postsuspend      = collie_postsuspend,
 	.charger_wakeup   = collie_charger_wakeup,
 	.should_wakeup    = collie_should_wakeup,
-	.bat_levels       = 3,
+	.bat_levels       = 49,
 	.bat_levels_noac  = collie_battery_levels,
-	.bat_levels_acin  = collie_battery_levels,
+	.bat_levels_acin  = collie_battery_levels_acin,
 	.status_high_acin = 368,
 	.status_low_acin  = 358,
 	.status_high_noac = 368,
 	.status_low_noac  = 358,
+	.charge_on_volt	  = 350,	/* spitz uses 2.90V, but lets play it safe. */
+	.charge_on_temp   = 550,
+	.charge_acin_high = 550,	/* collie does not seem to have sensor for this, anyway */
+	.charge_acin_low  = 450,	/* ignored, too */
+	.fatal_acin_volt  = 356,
+	.fatal_noacin_volt = 356,
+
+	.batfull_irq = 1,		/* We do not want periodical charge restarts */
 };
 
 static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index caf1eca..4c2e888 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -109,6 +109,7 @@ EXPORT_SYMBOL(locomolcd_power);
 
 
 static int current_intensity;
+int backlight_current;
 
 static int locomolcd_set_intensity(struct backlight_device *bd)
 {
@@ -123,12 +124,11 @@ static int locomolcd_set_intensity(struc
 
 	switch (intensity) {
 	/* AC and non-AC are handled differently, but produce same results in sharp code? */
-	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
-	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
-	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
-	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
-	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
-
+	case 0: backlight_current = 0; locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
+	case 1: backlight_current = 103; locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
+	case 2: backlight_current = 155; locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
+	case 3: backlight_current = 270; locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
+	case 4: backlight_current = 450; locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
 	default:
 		return -ENODEV;
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
