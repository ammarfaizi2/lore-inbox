Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVKUWsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKUWsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKUWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:48:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51352 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751131AbVKUWsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:48:23 -0500
Date: Mon, 21 Nov 2005 23:47:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Sharp power management: split into sharpsl-dependend and generic parts
Message-ID: <20051121224706.GA12906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This splits sharpsl_pm.c into sharpsl_pm.c and
sharp_pm.c. sharpsl_pm.c contains stuff that is shared between spitz
and corgi, sharp_pm.c contains more widely usable code. I'd like
something like this to be eventually merged... [Of course, I'll
cleanup #ifdef COLLIE's, I did not realize some were still pending.]

Comments?

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -33,6 +33,7 @@ static void corgi_charger_init(void)
 	pxa_gpio_mode(CORGI_GPIO_CHRG_ON | GPIO_OUT);
 	pxa_gpio_mode(CORGI_GPIO_CHRG_UKN | GPIO_OUT);
 	pxa_gpio_mode(CORGI_GPIO_KEY_INT | GPIO_IN);
+	sharpsl_arch_pm_init();
 }
 
 static void corgi_charge_led(int val)
@@ -179,6 +180,10 @@ static int corgi_acin_status(void)
 
 static struct sharpsl_charger_machinfo corgi_pm_machinfo = {
 	.init            = corgi_charger_init,
+	.remove		 = sharpsl_arch_pm_remove,
+	.read_main_battery= sharpsl_read_main_battery,
+	.read_temp	  = sharpsl_read_temp,
+	.read_acin	  = sharpsl_read_acin,
 	.gpio_batlock    = CORGI_GPIO_BAT_COVER,
 	.gpio_acin       = CORGI_GPIO_AC_IN,
 	.gpio_batfull    = CORGI_GPIO_CHRG_FULL,
diff --git a/arch/arm/mach-pxa/sharp_pm.c b/arch/arm/mach-pxa/sharp_pm.c
new file mode 100644
--- /dev/null
+++ b/arch/arm/mach-pxa/sharp_pm.c
@@ -0,0 +1,881 @@
+/*
+ * Battery and Power Management code for the Sharp SL-C7xx and SL-Cxx00
+ * series of PDAs
+ *
+ * Copyright (c) 2004-2005 Richard Purdie
+ * Copyright (c) 2005 Pavel Machek <pavel@suse.cz>
+ *
+ * Based on code written by Sharp for 2.4 kernels
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/apm_bios.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware.h>
+#include <asm/hardware/scoop.h>
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+#include <asm/apm.h>
+
+#ifndef CONFIG_SA1100_COLLIE
+#include <asm/arch/pm.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/sharpsl.h>
+#endif
+#include "../mach-pxa/sharpsl.h"
+
+#ifdef CONFIG_SA1100_COLLIE
+#include <asm/dma.h>
+#include <asm/arch/collie.h>
+#include "../drivers/mfd/ucb1x00.h"
+#include <asm/mach/sharpsl_param.h>
+
+#define STATUS_BATT_LOCKED()	1
+#define STATUS_FATAL()		0
+#define STATUS_CHRG_FULL()	0
+
+extern struct ucb1x00 *collie_ucb;
+#define ucb collie_ucb
+
+#endif
+
+/*
+ * Constants
+ */
+#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
+#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
+#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
+#define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
+#define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
+#define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN   10  /* 10 msec */
+#define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
+#define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
+#define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
+
+#define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
+#define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
+#define SHARPSL_CHARGE_ON_ACIN_HIGH    0x9b  /* 6V */
+#define SHARPSL_CHARGE_ON_ACIN_LOW     0x34  /* 2V */
+#define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
+#define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
+
+/*
+ * Prototypes
+ */
+static int sharpsl_off_charge_battery(void);
+static int sharpsl_check_battery_temp(void);
+static int sharpsl_check_battery_voltage(void);
+static int sharpsl_ac_check(void);
+static int sharpsl_fatal_check(void);
+static int sharpsl_average_value(int ad);
+static void sharpsl_average_clear(void);
+static void sharpsl_charge_toggle(void *private_);
+static void sharpsl_battery_thread(void *private_);
+
+
+/*
+ * Variables
+ */
+struct sharpsl_pm_status sharpsl_pm;
+DECLARE_WORK(toggle_charger, sharpsl_charge_toggle, NULL);
+DECLARE_WORK(sharpsl_bat, sharpsl_battery_thread, NULL);
+
+
+static int get_percentage(int voltage)
+{
+	int i = sharpsl_pm.machinfo->bat_levels - 1;
+	struct battery_thresh *thresh;
+
+	if (sharpsl_pm.charge_mode == CHRG_ON)
+		thresh=sharpsl_pm.machinfo->bat_levels_acin;
+	else
+		thresh=sharpsl_pm.machinfo->bat_levels_noac;
+
+	while (i > 0 && (voltage > thresh[i].voltage))
+		i--;
+
+	return thresh[i].percentage;
+}
+
+static int get_apm_status(int voltage)
+{
+	int low_thresh, high_thresh;
+
+	if (sharpsl_pm.charge_mode == CHRG_ON) {
+		high_thresh = sharpsl_pm.machinfo->status_high_acin;
+		low_thresh = sharpsl_pm.machinfo->status_low_acin;
+	} else {
+		high_thresh = sharpsl_pm.machinfo->status_high_noac;
+		low_thresh = sharpsl_pm.machinfo->status_low_noac;
+	}
+
+	if (voltage >= high_thresh)
+		return APM_BATTERY_STATUS_HIGH;
+	if (voltage >= low_thresh)
+		return APM_BATTERY_STATUS_LOW;
+	return APM_BATTERY_STATUS_CRITICAL;
+}
+
+void sharpsl_battery_kick(void)
+{
+	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
+}
+EXPORT_SYMBOL(sharpsl_battery_kick);
+
+
+static void sharpsl_battery_thread(void *private_)
+{
+	int voltage, percent, apm_status, i = 0;
+
+	if (!sharpsl_pm.machinfo)
+		return;
+
+	sharpsl_pm.battstat.ac_status = (STATUS_AC_IN() ? APM_AC_ONLINE : APM_AC_OFFLINE);
+
+	/* Corgi cannot confirm when battery fully charged so periodically kick! */
+	if (machine_is_corgi() && (sharpsl_pm.charge_mode == CHRG_ON)
+			&& time_after(jiffies, sharpsl_pm.charge_start_time +  SHARPSL_CHARGE_ON_TIME_INTERVAL))
+		schedule_work(&toggle_charger);
+
+	while(1) {
+		voltage = sharpsl_pm.machinfo->read_main_battery();
+		if (voltage > 0) break;
+		if (i++ > 5) {
+			voltage = sharpsl_pm.machinfo->bat_levels_noac[0].voltage;
+			dev_warn(sharpsl_pm.dev, "Warning: Cannot read main battery!\n");
+			break;
+		}
+	}
+
+	voltage = sharpsl_average_value(voltage);
+	apm_status = get_apm_status(voltage);
+	percent = get_percentage(voltage);
+
+	/* At low battery voltages, the voltage has a tendency to start
+           creeping back up so we try to avoid this here */
+	if ((sharpsl_pm.battstat.ac_status == APM_AC_ONLINE) || (apm_status == APM_BATTERY_STATUS_HIGH) ||  percent <= sharpsl_pm.battstat.mainbat_percent) {
+		sharpsl_pm.battstat.mainbat_voltage = voltage;
+		sharpsl_pm.battstat.mainbat_status = apm_status;
+		sharpsl_pm.battstat.mainbat_percent = percent;
+	}
+
+	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %d\n", voltage,
+			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
+
+	/* If battery is low. limit backlight intensity to save power. */
+	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
+			&& ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW) ||
+			(sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL))) {
+		if (!(sharpsl_pm.flags & SHARPSL_BL_LIMIT)) {
+#ifndef CONFIG_SA1100_COLLIE
+			corgibl_limit_intensity(1);
+#endif
+			sharpsl_pm.flags |= SHARPSL_BL_LIMIT;
+		}
+	} else if (sharpsl_pm.flags & SHARPSL_BL_LIMIT) {
+#ifndef CONFIG_SA1100_COLLIE
+		corgibl_limit_intensity(0);
+#endif
+		sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
+	}
+
+	/* Suspend if critical battery level */
+	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
+			&& (sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL)
+			&& !(sharpsl_pm.flags & SHARPSL_APM_QUEUED)) {
+		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
+		dev_err(sharpsl_pm.dev, "Fatal Off\n");
+		apm_queue_event(APM_CRITICAL_SUSPEND);
+	}
+
+	schedule_delayed_work(&sharpsl_bat, SHARPSL_BATCHK_TIME);
+}
+
+static void sharpsl_charge_on(void)
+{
+	dev_dbg(sharpsl_pm.dev, "Turning Charger On\n");
+
+	sharpsl_pm.full_count = 0;
+	sharpsl_pm.charge_mode = CHRG_ON;
+	schedule_delayed_work(&toggle_charger, msecs_to_jiffies(250));
+	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(500));
+}
+
+static void sharpsl_charge_off(void)
+{
+	dev_dbg(sharpsl_pm.dev, "Turning Charger Off\n");
+
+	CHARGE_OFF();
+	CHARGE_LED_OFF();
+	sharpsl_pm.charge_mode = CHRG_OFF;
+
+	schedule_work(&sharpsl_bat);
+}
+
+static void sharpsl_charge_error(void)
+{
+	CHARGE_LED_ERR();
+	CHARGE_OFF();
+	sharpsl_pm.charge_mode = CHRG_ERROR;
+}
+
+static void sharpsl_charge_toggle(void *private_)
+{
+	dev_dbg(sharpsl_pm.dev, "Toogling Charger at time: %lx\n", jiffies);
+
+	if (STATUS_AC_IN() == 0) {
+		sharpsl_charge_off();
+		return;
+	} else if ((sharpsl_check_battery_temp() < 0) || (sharpsl_ac_check() < 0)) {
+		sharpsl_charge_error();
+		return;
+	}
+
+	CHARGE_LED_ON();
+	CHARGE_OFF();
+	mdelay(SHARPSL_CHARGE_WAIT_TIME);
+	CHARGE_ON();
+
+	sharpsl_pm.charge_start_time = jiffies;
+}
+
+static void sharpsl_ac_timer(unsigned long data)
+{
+	int acin = STATUS_AC_IN();
+
+	dev_dbg(sharpsl_pm.dev, "AC Status: %d\n",acin);
+
+	sharpsl_average_clear();
+	if (acin && (sharpsl_pm.charge_mode != CHRG_ON))
+		sharpsl_charge_on();
+	else if (sharpsl_pm.charge_mode == CHRG_ON)
+		sharpsl_charge_off();
+
+	schedule_work(&sharpsl_bat);
+}
+
+
+irqreturn_t sharpsl_ac_isr(int irq, void *dev_id, struct pt_regs *fp)
+{
+	/* Delay the event slightly to debounce */
+	/* Must be a smaller delay than the chrg_full_isr below */
+	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
+
+	return IRQ_HANDLED;
+}
+
+static void sharpsl_chrg_full_timer(unsigned long data)
+{
+	dev_dbg(sharpsl_pm.dev, "Charge Full at time: %lx\n", jiffies);
+
+	sharpsl_pm.full_count++;
+
+	if (STATUS_AC_IN() == 0) {
+		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
+		if (sharpsl_pm.charge_mode == CHRG_ON)
+			sharpsl_charge_off();
+	} else if (sharpsl_pm.full_count < 2) {
+		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
+		schedule_work(&toggle_charger);
+	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
+		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
+		schedule_work(&toggle_charger);
+	} else {
+		sharpsl_charge_off();
+		sharpsl_pm.charge_mode = CHRG_DONE;
+		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
+	}
+}
+
+/* Charging Finished Interrupt (Not present on Corgi) */
+/* Can trigger at the same time as an AC staus change so
+   delay until after that has been processed */
+irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
+{
+	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
+		return IRQ_HANDLED;
+
+	/* delay until after any ac interrupt */
+	mod_timer(&sharpsl_pm.chrg_full_timer, jiffies + msecs_to_jiffies(500));
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id, struct pt_regs *fp)
+{
+	int is_fatal = 0;
+
+	if (STATUS_BATT_LOCKED() == 0) {
+		dev_err(sharpsl_pm.dev, "Battery now Unlocked! Suspending.\n");
+		is_fatal = 1;
+	}
+
+	if (sharpsl_pm.machinfo->gpio_fatal && (STATUS_FATAL() == 0)) {
+		dev_err(sharpsl_pm.dev, "Fatal Batt Error! Suspending.\n");
+		is_fatal = 1;
+	}
+
+	if (!(sharpsl_pm.flags & SHARPSL_APM_QUEUED) && is_fatal) {
+		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
+		apm_queue_event(APM_CRITICAL_SUSPEND);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Maintain an average of the last 10 readings
+ */
+#define SHARPSL_CNV_VALUE_NUM    10
+static int sharpsl_ad_index;
+
+static void sharpsl_average_clear(void)
+{
+	sharpsl_ad_index = 0;
+}
+
+static int sharpsl_average_value(int ad)
+{
+	int i, ad_val = 0;
+	static int sharpsl_ad[SHARPSL_CNV_VALUE_NUM+1];
+
+	if (sharpsl_pm.battstat.mainbat_status != APM_BATTERY_STATUS_HIGH) {
+		sharpsl_ad_index = 0;
+		return ad;
+	}
+
+	sharpsl_ad[sharpsl_ad_index] = ad;
+	sharpsl_ad_index++;
+	if (sharpsl_ad_index >= SHARPSL_CNV_VALUE_NUM) {
+		for (i=0; i < (SHARPSL_CNV_VALUE_NUM-1); i++)
+			sharpsl_ad[i] = sharpsl_ad[i+1];
+		sharpsl_ad_index = SHARPSL_CNV_VALUE_NUM - 1;
+	}
+	for (i=0; i < sharpsl_ad_index; i++)
+		ad_val += sharpsl_ad[i];
+
+	return (ad_val / sharpsl_ad_index);
+}
+
+/*
+ * Take an array of 5 integers, remove the maximum and minimum values
+ * and return the average.
+ */
+static int get_select_val(int *val)
+{
+	int i, j, k, temp, sum = 0;
+
+	/* Find MAX val */
+	temp = val[0];
+	j=0;
+	for (i=1; i<5; i++) {
+		if (temp < val[i]) {
+			temp = val[i];
+			j = i;
+		}
+	}
+
+	/* Find MIN val */
+	temp = val[4];
+	k=4;
+	for (i=3; i>=0; i--) {
+		if (temp > val[i]) {
+			temp = val[i];
+			k = i;
+		}
+	}
+
+	for (i=0; i<5; i++)
+		if (i != j && i != k )
+			sum += val[i];
+
+	dev_dbg(sharpsl_pm.dev, "Average: %d from values: %d, %d, %d, %d, %d\n", sum/3, val[0], val[1], val[2], val[3], val[4]);
+
+	return (sum/3);
+}
+
+static int sharpsl_check_battery_temp(void)
+{
+	int val, i, buff[5];
+
+	/* Check battery temperature */
+	for (i=0; i<5; i++) {
+		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
+		buff[i] = sharpsl_pm.machinfo->read_temp();
+	}
+
+	val = get_select_val(buff);
+
+	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
+	if (val > SHARPSL_CHARGE_ON_TEMP)
+		return -1;
+
+	return 0;
+}
+
+static int sharpsl_check_battery_voltage(void)
+{
+	int val, i, buff[5];
+
+	/* disable charge, enable discharge */
+	CHARGE_OFF();
+	DISCHARGE_ON();
+	mdelay(SHARPSL_WAIT_DISCHARGE_ON);
+
+	if (sharpsl_pm.machinfo->discharge1)
+		sharpsl_pm.machinfo->discharge1(1);
+
+	/* Check battery voltage */
+	for (i=0; i<5; i++) {
+		buff[i] = sharpsl_pm.machinfo->read_main_battery();
+		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
+	}
+
+	if (sharpsl_pm.machinfo->discharge1)
+		sharpsl_pm.machinfo->discharge1(0);
+
+	DISCHARGE_OFF();
+
+	val = get_select_val(buff);
+	dev_dbg(sharpsl_pm.dev, "Battery Voltage: %d\n", val);
+
+	if (val < SHARPSL_CHARGE_ON_VOLT)
+		return -1;
+
+	return 0;
+}
+
+static int sharpsl_ac_check(void)
+{
+	int temp, i, buff[5];
+
+	for (i=0; i<5; i++) {
+		buff[i] = sharpsl_pm.machinfo->read_acin();
+		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
+	}
+
+	temp = get_select_val(buff);
+	dev_dbg(sharpsl_pm.dev, "AC Voltage: %d\n",temp);
+
+	if ((temp > SHARPSL_CHARGE_ON_ACIN_HIGH) || (temp < SHARPSL_CHARGE_ON_ACIN_LOW)) {
+		dev_err(sharpsl_pm.dev, "Error: AC check failed.\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sharpsl_pm_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	sharpsl_pm.flags |= SHARPSL_SUSPENDED;
+	flush_scheduled_work();
+
+	if (sharpsl_pm.charge_mode == CHRG_ON)
+		sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
+	else
+		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
+
+	return 0;
+}
+
+static int sharpsl_pm_resume(struct platform_device *pdev)
+{
+	/* Clear the reset source indicators as they break the bootloader upon reboot */
+	RCSR = 0x0f;
+	sharpsl_average_clear();
+	sharpsl_pm.flags &= ~SHARPSL_APM_QUEUED;
+	sharpsl_pm.flags &= ~SHARPSL_SUSPENDED;
+
+	return 0;
+}
+
+static void corgi_goto_sleep(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
+{
+#ifndef CONFIG_SA1100_COLLIE
+	dev_dbg(sharpsl_pm.dev, "Time is: %08x\n",RCNR);
+
+	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
+	/* not charging and AC-IN! */
+
+	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (STATUS_AC_IN() != 0)) {
+		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
+		sharpsl_pm.charge_mode = CHRG_OFF;
+		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
+		sharpsl_off_charge_battery();
+	}
+
+	sharpsl_pm.machinfo->presuspend();
+
+	PEDR = 0xffffffff; /* clear it */
+
+	sharpsl_pm.flags &= ~SHARPSL_ALARM_ACTIVE;
+	if ((sharpsl_pm.charge_mode == CHRG_ON) && ((alarm_enable && ((alarm_time - RCNR) > (SHARPSL_BATCHK_TIME_SUSPEND + 30))) || !alarm_enable)) {
+		RTSR &= RTSR_ALE;
+		RTAR = RCNR + SHARPSL_BATCHK_TIME_SUSPEND;
+		dev_dbg(sharpsl_pm.dev, "Charging alarm at: %08x\n",RTAR);
+		sharpsl_pm.flags |= SHARPSL_ALARM_ACTIVE;
+	} else if (alarm_enable) {
+		RTSR &= RTSR_ALE;
+		RTAR = alarm_time;
+		dev_dbg(sharpsl_pm.dev, "User alarm at: %08x\n",RTAR);
+	} else {
+		dev_dbg(sharpsl_pm.dev, "No alarms set.\n");
+	}
+
+	pxa_pm_enter(state);
+
+	sharpsl_pm.machinfo->postsuspend();
+
+	dev_dbg(sharpsl_pm.dev, "Corgi woken up from suspend: %08x\n",PEDR);
+}
+
+static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
+{
+	if (!sharpsl_pm.machinfo->should_wakeup(!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE) && alarm_enable) )
+	{
+		if (!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE)) {
+			dev_dbg(sharpsl_pm.dev, "No user triggered wakeup events and not charging. Strange. Suspend.\n");
+			corgi_goto_sleep(alarm_time, alarm_enable, state);
+			return 1;
+		}
+		if(sharpsl_off_charge_battery()) {
+			dev_dbg(sharpsl_pm.dev, "Charging. Suspend...\n");
+			corgi_goto_sleep(alarm_time, alarm_enable, state);
+			return 1;
+		}
+		dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
+	}
+
+	if ((STATUS_BATT_LOCKED() == 0) || (sharpsl_fatal_check() < 0) )
+	{
+		dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
+		corgi_goto_sleep(alarm_time, alarm_enable, state);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+static int corgi_pxa_pm_enter(suspend_state_t state)
+{
+	unsigned long alarm_time = RTAR;
+	unsigned int alarm_status = ((RTSR & RTSR_ALE) != 0);
+
+	dev_dbg(sharpsl_pm.dev, "SharpSL suspending for first time.\n");
+
+	corgi_goto_sleep(alarm_time, alarm_status, state);
+
+#ifndef CONFIG_SA1100_COLLIE
+	while (corgi_enter_suspend(alarm_time,alarm_status,state))
+		{}
+#endif
+
+	dev_dbg(sharpsl_pm.dev, "SharpSL resuming...\n");
+
+	return 0;
+}
+#endif
+
+
+/*
+ * Check for fatal battery errors
+ * Fatal returns -1
+ */
+static int sharpsl_fatal_check(void)
+{
+	int buff[5], temp, i, acin;
+
+	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check entered\n");
+
+	/* Check AC-Adapter */
+	acin = STATUS_AC_IN();
+
+	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
+		CHARGE_OFF();
+		udelay(100);
+		DISCHARGE_ON();	/* enable discharge */
+		mdelay(SHARPSL_WAIT_DISCHARGE_ON);
+	}
+
+	if (sharpsl_pm.machinfo->discharge1)
+		sharpsl_pm.machinfo->discharge1(1);
+
+	/* Check battery : check inserting battery ? */
+	for (i=0; i<5; i++) {
+		buff[i] = sharpsl_pm.machinfo->read_main_battery();
+		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
+	}
+
+	if (sharpsl_pm.machinfo->discharge1)
+		sharpsl_pm.machinfo->discharge1(0);
+
+	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
+		udelay(100);
+		CHARGE_ON();
+		DISCHARGE_OFF();
+	}
+
+	temp = get_select_val(buff);
+	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_pm.machinfo.read_main_battery());
+
+	if ((acin && (temp < SHARPSL_FATAL_ACIN_VOLT)) ||
+			(!acin && (temp < SHARPSL_FATAL_NOACIN_VOLT)))
+		return -1;
+	return 0;
+}
+
+static int sharpsl_off_charge_error(void)
+{
+	dev_err(sharpsl_pm.dev, "Offline Charger: Error occured.\n");
+	CHARGE_OFF();
+	CHARGE_LED_ERR();
+	sharpsl_pm.charge_mode = CHRG_ERROR;
+	return 1;
+}
+
+/*
+ * Charging Control while suspended
+ * Return 1 - go straight to sleep
+ * Return 0 - sleep or wakeup depending on other factors
+ */
+static int sharpsl_off_charge_battery(void)
+{
+	int time;
+
+	dev_dbg(sharpsl_pm.dev, "Charge Mode: %d\n", sharpsl_pm.charge_mode);
+
+	if (sharpsl_pm.charge_mode == CHRG_OFF) {
+		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 1\n");
+
+		/* AC Check */
+		if ((sharpsl_ac_check() < 0) || (sharpsl_check_battery_temp() < 0))
+			return sharpsl_off_charge_error();
+
+		/* Start Charging */
+		CHARGE_LED_ON();
+		CHARGE_OFF();
+		mdelay(SHARPSL_CHARGE_WAIT_TIME);
+		CHARGE_ON();
+
+		sharpsl_pm.charge_mode = CHRG_ON;
+		sharpsl_pm.full_count = 0;
+
+		return 1;
+	} else if (sharpsl_pm.charge_mode != CHRG_ON) {
+		return 1;
+	}
+
+	if (sharpsl_pm.full_count == 0) {
+		int time;
+
+		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 2\n");
+
+		if ((sharpsl_check_battery_temp() < 0) || (sharpsl_check_battery_voltage() < 0))
+			return sharpsl_off_charge_error();
+
+		CHARGE_OFF();
+		mdelay(SHARPSL_CHARGE_WAIT_TIME);
+		CHARGE_ON();
+		sharpsl_pm.charge_mode = CHRG_ON;
+
+		mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
+
+		time = RCNR;
+		while(1) {
+			/* Check if any wakeup event had occured */
+			if (sharpsl_pm.machinfo->charger_wakeup() != 0)
+				return 0;
+			/* Check for timeout */
+			if ((RCNR - time) > SHARPSL_WAIT_CO_TIME)
+				return 1;
+			if (STATUS_CHRG_FULL()) {
+				dev_dbg(sharpsl_pm.dev, "Offline Charger: Charge full occured. Retrying to check\n");
+	   			sharpsl_pm.full_count++;
+				CHARGE_OFF();
+				mdelay(SHARPSL_CHARGE_WAIT_TIME);
+				CHARGE_ON();
+				return 1;
+			}
+		}
+	}
+
+	dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 3\n");
+
+	mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
+
+	time = RCNR;
+	while(1) {
+		/* Check if any wakeup event had occured */
+		if (sharpsl_pm.machinfo->charger_wakeup() != 0)
+			return 0;
+		/* Check for timeout */
+		if ((RCNR-time) > SHARPSL_WAIT_CO_TIME) {
+			if (sharpsl_pm.full_count > SHARPSL_CHARGE_RETRY_CNT) {
+				dev_dbg(sharpsl_pm.dev, "Offline Charger: Not charged sufficiently. Retrying.\n");
+				sharpsl_pm.full_count = 0;
+			}
+			sharpsl_pm.full_count++;
+			return 1;
+		}
+		if (STATUS_CHRG_FULL()) {
+			dev_dbg(sharpsl_pm.dev, "Offline Charger: Charging complete.\n");
+			CHARGE_LED_OFF();
+			CHARGE_OFF();
+			sharpsl_pm.charge_mode = CHRG_DONE;
+			return 1;
+		}
+	}
+}
+
+
+static ssize_t battery_percentage_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n",sharpsl_pm.battstat.mainbat_percent);
+}
+
+static ssize_t battery_voltage_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n",sharpsl_pm.battstat.mainbat_voltage);
+}
+
+static DEVICE_ATTR(battery_percentage, 0444, battery_percentage_show, NULL);
+static DEVICE_ATTR(battery_voltage, 0444, battery_voltage_show, NULL);
+
+extern void (*apm_get_power_status)(struct apm_power_info *);
+
+static void sharpsl_apm_get_power_status(struct apm_power_info *info)
+{
+	info->ac_line_status = sharpsl_pm.battstat.ac_status;
+
+	if (sharpsl_pm.charge_mode == CHRG_ON)
+		info->battery_status = APM_BATTERY_STATUS_CHARGING;
+	else
+		info->battery_status = sharpsl_pm.battstat.mainbat_status;
+
+	info->battery_flag = (1 << info->battery_status);
+	info->battery_life = sharpsl_pm.battstat.mainbat_percent;
+}
+
+static struct pm_ops sharpsl_pm_ops = {
+	.pm_disk_mode	= PM_DISK_FIRMWARE,
+#ifndef CONFIG_SA1100_COLLIE
+	.prepare	= pxa_pm_prepare,
+	.enter		= corgi_pxa_pm_enter,
+	.finish		= pxa_pm_finish,
+#endif
+};
+
+static int __init sharpsl_pm_probe(struct platform_device *pdev)
+{
+	if (!pdev->dev.platform_data)
+		return -EINVAL;
+
+	sharpsl_pm.dev = &pdev->dev;
+	sharpsl_pm.machinfo = pdev->dev.platform_data;
+	sharpsl_pm.charge_mode = CHRG_OFF;
+	sharpsl_pm.flags = 0;
+
+	sharpsl_pm.machinfo->init();
+
+	init_timer(&sharpsl_pm.ac_timer);
+	sharpsl_pm.ac_timer.function = sharpsl_ac_timer;
+
+	init_timer(&sharpsl_pm.chrg_full_timer);
+	sharpsl_pm.chrg_full_timer.function = sharpsl_chrg_full_timer;
+
+#ifdef CONFIG_SA1100_COLLIE
+	/* get ad revise */
+	collie_get_ad();
+
+	/* Set transition detect */
+	ucb1x00_enable_irq(ucb, COLLIE_GPIO_AC_IN, UCB_RISING);
+	ucb1x00_enable_irq(ucb, COLLIE_GPIO_CO, UCB_RISING);
+
+	int err;
+
+	/* Register interrupt handler. */
+	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
+			       "ACIN", sharpsl_ac_isr))) {
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
+		return -EIO;
+	}
+
+	/* Register interrupt handler. */
+	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
+			       "CO", sharpsl_chrg_full_isr))) {
+		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
+		return -EIO;
+	}
+
+#endif
+
+	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
+	device_create_file(&pdev->dev, &dev_attr_battery_voltage);
+
+	apm_get_power_status = sharpsl_apm_get_power_status;
+
+	pm_set_ops(&sharpsl_pm_ops);
+
+	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
+
+	return 0;
+}
+
+static int sharpsl_pm_remove(struct platform_device *pdev)
+{
+	pm_set_ops(NULL);
+
+	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
+	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
+
+	sharpsl_pm.machinfo->remove();
+
+	del_timer_sync(&sharpsl_pm.chrg_full_timer);
+	del_timer_sync(&sharpsl_pm.ac_timer);
+
+#ifdef CONFIG_SA1100_COLLIE
+	panic("No unload on collie.");
+#endif
+	return 0;
+}
+
+static struct platform_driver sharpsl_pm_driver = {
+	.probe		= sharpsl_pm_probe,
+	.remove		= sharpsl_pm_remove,
+	.suspend	= sharpsl_pm_suspend,
+	.resume		= sharpsl_pm_resume,
+	.driver		= {
+		.name		= "sharpsl-pm",
+	},
+};
+
+static int __devinit sharpsl_pm_init(void)
+{
+	return platform_driver_register(&sharpsl_pm_driver);
+}
+
+static void sharpsl_pm_exit(void)
+{
+ 	platform_driver_unregister(&sharpsl_pm_driver);
+}
+
+late_initcall(sharpsl_pm_init);
+module_exit(sharpsl_pm_exit);
diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
--- a/arch/arm/mach-pxa/sharpsl.h
+++ b/arch/arm/mach-pxa/sharpsl.h
@@ -2,6 +2,8 @@
  * SharpSL SSP Driver
  */
 
+#include <linux/interrupt.h>
+
 struct corgissp_machinfo {
 	int port;
 	int cs_lcdcon;
@@ -51,8 +53,12 @@ struct sharpsl_charger_machinfo {
 	void (*measure_temp)(int);
 	void (*presuspend)(void);
 	void (*postsuspend)(void);
+	int (*read_main_battery)(void);
+	int (*read_temp)(void);
+	int (*read_acin)(void);
 	unsigned long (*charger_wakeup)(void);
 	int (*should_wakeup)(unsigned int resume_on_alarm);
+	int (*remove)(void);
 	int bat_levels;
 	struct battery_thresh *bat_levels_noac;
 	struct battery_thresh *bat_levels_acin;
@@ -119,3 +125,14 @@ extern struct battery_thresh spitz_batte
 #define STATUS_BATT_LOCKED()  READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock)
 #define STATUS_CHRG_FULL()  READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull)
 #define STATUS_FATAL()      READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal)
+
+extern irqreturn_t sharpsl_ac_isr(int irq, void *dev_id, struct pt_regs *fp);
+extern irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id, struct pt_regs *fp);
+extern irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp);
+
+extern int sharpsl_read_main_battery(void);
+extern int sharpsl_read_temp(void);
+extern int sharpsl_read_acin(void);
+
+extern int sharpsl_arch_pm_init(void);
+extern int sharpsl_arch_pm_remove(void);
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -28,34 +28,12 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <asm/apm.h>
-
-#include <asm/arch/pm.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/sharpsl.h>
-#include "sharpsl.h"
 
-/*
- * Constants
- */
-#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
-#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
-#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
-#define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
-#define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
-#define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
+#include "../mach-pxa/sharpsl.h"
+
 #define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN   10  /* 10 msec */
-#define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
-#define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
-#define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
-
-#define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
-#define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
-#define SHARPSL_CHARGE_ON_ACIN_HIGH    0x9b  /* 6V */
-#define SHARPSL_CHARGE_ON_ACIN_LOW     0x34  /* 2V */
-#define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
-#define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
 
 struct battery_thresh spitz_battery_levels_acin[] = {
 	{ 213, 100},
@@ -143,6 +121,7 @@ struct battery_thresh  spitz_battery_lev
 	{   0,   0},
 };
 
+
 /* MAX1111 Commands */
 #define MAXCTRL_PD0      1u << 0
 #define MAXCTRL_PD1      1u << 1
@@ -156,303 +135,6 @@ struct battery_thresh  spitz_battery_lev
 #define BATT_THM   2u
 #define JK_VAD     6u
 
-
-/*
- * Prototypes
- */
-static int sharpsl_read_main_battery(void);
-static int sharpsl_off_charge_battery(void);
-static int sharpsl_check_battery_temp(void);
-static int sharpsl_check_battery_voltage(void);
-static int sharpsl_ac_check(void);
-static int sharpsl_fatal_check(void);
-static int sharpsl_average_value(int ad);
-static void sharpsl_average_clear(void);
-static void sharpsl_charge_toggle(void *private_);
-static void sharpsl_battery_thread(void *private_);
-
-
-/*
- * Variables
- */
-struct sharpsl_pm_status sharpsl_pm;
-DECLARE_WORK(toggle_charger, sharpsl_charge_toggle, NULL);
-DECLARE_WORK(sharpsl_bat, sharpsl_battery_thread, NULL);
-
-
-static int get_percentage(int voltage)
-{
-	int i = sharpsl_pm.machinfo->bat_levels - 1;
-	struct battery_thresh *thresh;
-
-	if (sharpsl_pm.charge_mode == CHRG_ON)
-		thresh=sharpsl_pm.machinfo->bat_levels_acin;
-	else
-		thresh=sharpsl_pm.machinfo->bat_levels_noac;
-
-	while (i > 0 && (voltage > thresh[i].voltage))
-		i--;
-
-	return thresh[i].percentage;
-}
-
-static int get_apm_status(int voltage)
-{
-	int low_thresh, high_thresh;
-
-	if (sharpsl_pm.charge_mode == CHRG_ON) {
-		high_thresh = sharpsl_pm.machinfo->status_high_acin;
-		low_thresh = sharpsl_pm.machinfo->status_low_acin;
-	} else {
-		high_thresh = sharpsl_pm.machinfo->status_high_noac;
-		low_thresh = sharpsl_pm.machinfo->status_low_noac;
-	}
-
-	if (voltage >= high_thresh)
-		return APM_BATTERY_STATUS_HIGH;
-	if (voltage >= low_thresh)
-		return APM_BATTERY_STATUS_LOW;
-	return APM_BATTERY_STATUS_CRITICAL;
-}
-
-void sharpsl_battery_kick(void)
-{
-	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
-}
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
-
-static void sharpsl_battery_thread(void *private_)
-{
-	int voltage, percent, apm_status, i = 0;
-
-	if (!sharpsl_pm.machinfo)
-		return;
-
-	sharpsl_pm.battstat.ac_status = (STATUS_AC_IN() ? APM_AC_ONLINE : APM_AC_OFFLINE);
-
-	/* Corgi cannot confirm when battery fully charged so periodically kick! */
-	if (machine_is_corgi() && (sharpsl_pm.charge_mode == CHRG_ON)
-			&& time_after(jiffies, sharpsl_pm.charge_start_time +  SHARPSL_CHARGE_ON_TIME_INTERVAL))
-		schedule_work(&toggle_charger);
-
-	while(1) {
-		voltage = sharpsl_read_main_battery();
-		if (voltage > 0) break;
-		if (i++ > 5) {
-			voltage = sharpsl_pm.machinfo->bat_levels_noac[0].voltage;
-			dev_warn(sharpsl_pm.dev, "Warning: Cannot read main battery!\n");
-			break;
-		}
-	}
-
-	voltage = sharpsl_average_value(voltage);
-	apm_status = get_apm_status(voltage);
-	percent = get_percentage(voltage);
-
-	/* At low battery voltages, the voltage has a tendency to start
-           creeping back up so we try to avoid this here */
-	if ((sharpsl_pm.battstat.ac_status == APM_AC_ONLINE) || (apm_status == APM_BATTERY_STATUS_HIGH) ||  percent <= sharpsl_pm.battstat.mainbat_percent) {
-		sharpsl_pm.battstat.mainbat_voltage = voltage;
-		sharpsl_pm.battstat.mainbat_status = apm_status;
-		sharpsl_pm.battstat.mainbat_percent = percent;
-	}
-
-	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %d\n", voltage,
-			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
-
-	/* If battery is low. limit backlight intensity to save power. */
-	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
-			&& ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW) ||
-			(sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL))) {
-		if (!(sharpsl_pm.flags & SHARPSL_BL_LIMIT)) {
-			corgibl_limit_intensity(1);
-			sharpsl_pm.flags |= SHARPSL_BL_LIMIT;
-		}
-	} else if (sharpsl_pm.flags & SHARPSL_BL_LIMIT) {
-		corgibl_limit_intensity(0);
-		sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
-	}
-
-	/* Suspend if critical battery level */
-	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
-			&& (sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL)
-			&& !(sharpsl_pm.flags & SHARPSL_APM_QUEUED)) {
-		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
-		dev_err(sharpsl_pm.dev, "Fatal Off\n");
-		apm_queue_event(APM_CRITICAL_SUSPEND);
-	}
-
-	schedule_delayed_work(&sharpsl_bat, SHARPSL_BATCHK_TIME);
-}
-
-static void sharpsl_charge_on(void)
-{
-	dev_dbg(sharpsl_pm.dev, "Turning Charger On\n");
-
-	sharpsl_pm.full_count = 0;
-	sharpsl_pm.charge_mode = CHRG_ON;
-	schedule_delayed_work(&toggle_charger, msecs_to_jiffies(250));
-	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(500));
-}
-
-static void sharpsl_charge_off(void)
-{
-	dev_dbg(sharpsl_pm.dev, "Turning Charger Off\n");
-
-	CHARGE_OFF();
-	CHARGE_LED_OFF();
-	sharpsl_pm.charge_mode = CHRG_OFF;
-
-	schedule_work(&sharpsl_bat);
-}
-
-static void sharpsl_charge_error(void)
-{
-	CHARGE_LED_ERR();
-	CHARGE_OFF();
-	sharpsl_pm.charge_mode = CHRG_ERROR;
-}
-
-static void sharpsl_charge_toggle(void *private_)
-{
-	dev_dbg(sharpsl_pm.dev, "Toogling Charger at time: %lx\n", jiffies);
-
-	if (STATUS_AC_IN() == 0) {
-		sharpsl_charge_off();
-		return;
-	} else if ((sharpsl_check_battery_temp() < 0) || (sharpsl_ac_check() < 0)) {
-		sharpsl_charge_error();
-		return;
-	}
-
-	CHARGE_LED_ON();
-	CHARGE_OFF();
-	mdelay(SHARPSL_CHARGE_WAIT_TIME);
-	CHARGE_ON();
-
-	sharpsl_pm.charge_start_time = jiffies;
-}
-
-static void sharpsl_ac_timer(unsigned long data)
-{
-	int acin = STATUS_AC_IN();
-
-	dev_dbg(sharpsl_pm.dev, "AC Status: %d\n",acin);
-
-	sharpsl_average_clear();
-	if (acin && (sharpsl_pm.charge_mode != CHRG_ON))
-		sharpsl_charge_on();
-	else if (sharpsl_pm.charge_mode == CHRG_ON)
-		sharpsl_charge_off();
-
-	schedule_work(&sharpsl_bat);
-}
-
-
-static irqreturn_t sharpsl_ac_isr(int irq, void *dev_id, struct pt_regs *fp)
-{
-	/* Delay the event slightly to debounce */
-	/* Must be a smaller delay than the chrg_full_isr below */
-	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
-
-	return IRQ_HANDLED;
-}
-
-static void sharpsl_chrg_full_timer(unsigned long data)
-{
-	dev_dbg(sharpsl_pm.dev, "Charge Full at time: %lx\n", jiffies);
-
-	sharpsl_pm.full_count++;
-
-	if (STATUS_AC_IN() == 0) {
-		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
-		if (sharpsl_pm.charge_mode == CHRG_ON)
-			sharpsl_charge_off();
-	} else if (sharpsl_pm.full_count < 2) {
-		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
-		schedule_work(&toggle_charger);
-	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
-		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
-		schedule_work(&toggle_charger);
-	} else {
-		sharpsl_charge_off();
-		sharpsl_pm.charge_mode = CHRG_DONE;
-		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
-	}
-}
-
-/* Charging Finished Interrupt (Not present on Corgi) */
-/* Can trigger at the same time as an AC staus change so
-   delay until after that has been processed */
-static irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
-{
-	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
-		return IRQ_HANDLED;
-
-	/* delay until after any ac interrupt */
-	mod_timer(&sharpsl_pm.chrg_full_timer, jiffies + msecs_to_jiffies(500));
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id, struct pt_regs *fp)
-{
-	int is_fatal = 0;
-
-	if (STATUS_BATT_LOCKED() == 0) {
-		dev_err(sharpsl_pm.dev, "Battery now Unlocked! Suspending.\n");
-		is_fatal = 1;
-	}
-
-	if (sharpsl_pm.machinfo->gpio_fatal && (STATUS_FATAL() == 0)) {
-		dev_err(sharpsl_pm.dev, "Fatal Batt Error! Suspending.\n");
-		is_fatal = 1;
-	}
-
-	if (!(sharpsl_pm.flags & SHARPSL_APM_QUEUED) && is_fatal) {
-		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
-		apm_queue_event(APM_CRITICAL_SUSPEND);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Maintain an average of the last 10 readings
- */
-#define SHARPSL_CNV_VALUE_NUM    10
-static int sharpsl_ad_index;
-
-static void sharpsl_average_clear(void)
-{
-	sharpsl_ad_index = 0;
-}
-
-static int sharpsl_average_value(int ad)
-{
-	int i, ad_val = 0;
-	static int sharpsl_ad[SHARPSL_CNV_VALUE_NUM+1];
-
-	if (sharpsl_pm.battstat.mainbat_status != APM_BATTERY_STATUS_HIGH) {
-		sharpsl_ad_index = 0;
-		return ad;
-	}
-
-	sharpsl_ad[sharpsl_ad_index] = ad;
-	sharpsl_ad_index++;
-	if (sharpsl_ad_index >= SHARPSL_CNV_VALUE_NUM) {
-		for (i=0; i < (SHARPSL_CNV_VALUE_NUM-1); i++)
-			sharpsl_ad[i] = sharpsl_ad[i+1];
-		sharpsl_ad_index = SHARPSL_CNV_VALUE_NUM - 1;
-	}
-	for (i=0; i < sharpsl_ad_index; i++)
-		ad_val += sharpsl_ad[i];
-
-	return (ad_val / sharpsl_ad_index);
-}
-
-
 /*
  * Read MAX1111 ADC
  */
@@ -462,12 +144,12 @@ static int read_max1111(int channel)
 			| MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
 }
 
-static int sharpsl_read_main_battery(void)
+int sharpsl_read_main_battery(void)
 {
 	return read_max1111(BATT_AD);
 }
 
-static int sharpsl_read_temp(void)
+int sharpsl_read_temp(void)
 {
 	int temp;
 
@@ -481,433 +163,13 @@ static int sharpsl_read_temp(void)
 	return temp;
 }
 
-static int sharpsl_read_acin(void)
+int sharpsl_read_acin(void)
 {
 	return read_max1111(JK_VAD);
 }
 
-/*
- * Take an array of 5 integers, remove the maximum and minimum values
- * and return the average.
- */
-static int get_select_val(int *val)
-{
-	int i, j, k, temp, sum = 0;
-
-	/* Find MAX val */
-	temp = val[0];
-	j=0;
-	for (i=1; i<5; i++) {
-		if (temp < val[i]) {
-			temp = val[i];
-			j = i;
-		}
-	}
-
-	/* Find MIN val */
-	temp = val[4];
-	k=4;
-	for (i=3; i>=0; i--) {
-		if (temp > val[i]) {
-			temp = val[i];
-			k = i;
-		}
-	}
-
-	for (i=0; i<5; i++)
-		if (i != j && i != k )
-			sum += val[i];
-
-	dev_dbg(sharpsl_pm.dev, "Average: %d from values: %d, %d, %d, %d, %d\n", sum/3, val[0], val[1], val[2], val[3], val[4]);
-
-	return (sum/3);
-}
-
-static int sharpsl_check_battery_temp(void)
-{
-	int val, i, buff[5];
-
-	/* Check battery temperature */
-	for (i=0; i<5; i++) {
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
-		buff[i] = sharpsl_read_temp();
-	}
-
-	val = get_select_val(buff);
-
-	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > SHARPSL_CHARGE_ON_TEMP)
-		return -1;
-
-	return 0;
-}
-
-static int sharpsl_check_battery_voltage(void)
+int sharpsl_arch_pm_init(void)
 {
-	int val, i, buff[5];
-
-	/* disable charge, enable discharge */
-	CHARGE_OFF();
-	DISCHARGE_ON();
-	mdelay(SHARPSL_WAIT_DISCHARGE_ON);
-
-	if (sharpsl_pm.machinfo->discharge1)
-		sharpsl_pm.machinfo->discharge1(1);
-
-	/* Check battery voltage */
-	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_main_battery();
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
-	}
-
-	if (sharpsl_pm.machinfo->discharge1)
-		sharpsl_pm.machinfo->discharge1(0);
-
-	DISCHARGE_OFF();
-
-	val = get_select_val(buff);
-	dev_dbg(sharpsl_pm.dev, "Battery Voltage: %d\n", val);
-
-	if (val < SHARPSL_CHARGE_ON_VOLT)
-		return -1;
-
-	return 0;
-}
-
-static int sharpsl_ac_check(void)
-{
-	int temp, i, buff[5];
-
-	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_acin();
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
-	}
-
-	temp = get_select_val(buff);
-	dev_dbg(sharpsl_pm.dev, "AC Voltage: %d\n",temp);
-
-	if ((temp > SHARPSL_CHARGE_ON_ACIN_HIGH) || (temp < SHARPSL_CHARGE_ON_ACIN_LOW)) {
-		dev_err(sharpsl_pm.dev, "Error: AC check failed.\n");
-		return -1;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int sharpsl_pm_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	sharpsl_pm.flags |= SHARPSL_SUSPENDED;
-	flush_scheduled_work();
-
-	if (sharpsl_pm.charge_mode == CHRG_ON)
-		sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
-	else
-		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
-
-	return 0;
-}
-
-static int sharpsl_pm_resume(struct platform_device *pdev)
-{
-	/* Clear the reset source indicators as they break the bootloader upon reboot */
-	RCSR = 0x0f;
-	sharpsl_average_clear();
-	sharpsl_pm.flags &= ~SHARPSL_APM_QUEUED;
-	sharpsl_pm.flags &= ~SHARPSL_SUSPENDED;
-
-	return 0;
-}
-
-static void corgi_goto_sleep(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
-{
-	dev_dbg(sharpsl_pm.dev, "Time is: %08x\n",RCNR);
-
-	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
-	/* not charging and AC-IN! */
-
-	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (STATUS_AC_IN() != 0)) {
-		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
-		sharpsl_pm.charge_mode = CHRG_OFF;
-		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
-		sharpsl_off_charge_battery();
-	}
-
-	sharpsl_pm.machinfo->presuspend();
-
-	PEDR = 0xffffffff; /* clear it */
-
-	sharpsl_pm.flags &= ~SHARPSL_ALARM_ACTIVE;
-	if ((sharpsl_pm.charge_mode == CHRG_ON) && ((alarm_enable && ((alarm_time - RCNR) > (SHARPSL_BATCHK_TIME_SUSPEND + 30))) || !alarm_enable)) {
-		RTSR &= RTSR_ALE;
-		RTAR = RCNR + SHARPSL_BATCHK_TIME_SUSPEND;
-		dev_dbg(sharpsl_pm.dev, "Charging alarm at: %08x\n",RTAR);
-		sharpsl_pm.flags |= SHARPSL_ALARM_ACTIVE;
-	} else if (alarm_enable) {
-		RTSR &= RTSR_ALE;
-		RTAR = alarm_time;
-		dev_dbg(sharpsl_pm.dev, "User alarm at: %08x\n",RTAR);
-	} else {
-		dev_dbg(sharpsl_pm.dev, "No alarms set.\n");
-	}
-
-	pxa_pm_enter(state);
-
-	sharpsl_pm.machinfo->postsuspend();
-
-	dev_dbg(sharpsl_pm.dev, "Corgi woken up from suspend: %08x\n",PEDR);
-}
-
-static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
-{
-	if (!sharpsl_pm.machinfo->should_wakeup(!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE) && alarm_enable) )
-	{
-		if (!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE)) {
-			dev_dbg(sharpsl_pm.dev, "No user triggered wakeup events and not charging. Strange. Suspend.\n");
-			corgi_goto_sleep(alarm_time, alarm_enable, state);
-			return 1;
-		}
-		if(sharpsl_off_charge_battery()) {
-			dev_dbg(sharpsl_pm.dev, "Charging. Suspend...\n");
-			corgi_goto_sleep(alarm_time, alarm_enable, state);
-			return 1;
-		}
-		dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
-	}
-
-	if ((STATUS_BATT_LOCKED() == 0) || (sharpsl_fatal_check() < 0) )
-	{
-		dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
-		corgi_goto_sleep(alarm_time, alarm_enable, state);
-		return 1;
-	}
-
-	return 0;
-}
-
-static int corgi_pxa_pm_enter(suspend_state_t state)
-{
-	unsigned long alarm_time = RTAR;
-	unsigned int alarm_status = ((RTSR & RTSR_ALE) != 0);
-
-	dev_dbg(sharpsl_pm.dev, "SharpSL suspending for first time.\n");
-
-	corgi_goto_sleep(alarm_time, alarm_status, state);
-
-	while (corgi_enter_suspend(alarm_time,alarm_status,state))
-		{}
-
-	dev_dbg(sharpsl_pm.dev, "SharpSL resuming...\n");
-
-	return 0;
-}
-#endif
-
-
-/*
- * Check for fatal battery errors
- * Fatal returns -1
- */
-static int sharpsl_fatal_check(void)
-{
-	int buff[5], temp, i, acin;
-
-	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check entered\n");
-
-	/* Check AC-Adapter */
-	acin = STATUS_AC_IN();
-
-	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
-		CHARGE_OFF();
-		udelay(100);
-		DISCHARGE_ON();	/* enable discharge */
-		mdelay(SHARPSL_WAIT_DISCHARGE_ON);
-	}
-
-	if (sharpsl_pm.machinfo->discharge1)
-		sharpsl_pm.machinfo->discharge1(1);
-
-	/* Check battery : check inserting battery ? */
-	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_main_battery();
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
-	}
-
-	if (sharpsl_pm.machinfo->discharge1)
-		sharpsl_pm.machinfo->discharge1(0);
-
-	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
-		udelay(100);
-		CHARGE_ON();
-		DISCHARGE_OFF();
-	}
-
-	temp = get_select_val(buff);
-	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_read_main_battery());
-
-	if ((acin && (temp < SHARPSL_FATAL_ACIN_VOLT)) ||
-			(!acin && (temp < SHARPSL_FATAL_NOACIN_VOLT)))
-		return -1;
-	return 0;
-}
-
-static int sharpsl_off_charge_error(void)
-{
-	dev_err(sharpsl_pm.dev, "Offline Charger: Error occured.\n");
-	CHARGE_OFF();
-	CHARGE_LED_ERR();
-	sharpsl_pm.charge_mode = CHRG_ERROR;
-	return 1;
-}
-
-/*
- * Charging Control while suspended
- * Return 1 - go straight to sleep
- * Return 0 - sleep or wakeup depending on other factors
- */
-static int sharpsl_off_charge_battery(void)
-{
-	int time;
-
-	dev_dbg(sharpsl_pm.dev, "Charge Mode: %d\n", sharpsl_pm.charge_mode);
-
-	if (sharpsl_pm.charge_mode == CHRG_OFF) {
-		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 1\n");
-
-		/* AC Check */
-		if ((sharpsl_ac_check() < 0) || (sharpsl_check_battery_temp() < 0))
-			return sharpsl_off_charge_error();
-
-		/* Start Charging */
-		CHARGE_LED_ON();
-		CHARGE_OFF();
-		mdelay(SHARPSL_CHARGE_WAIT_TIME);
-		CHARGE_ON();
-
-		sharpsl_pm.charge_mode = CHRG_ON;
-		sharpsl_pm.full_count = 0;
-
-		return 1;
-	} else if (sharpsl_pm.charge_mode != CHRG_ON) {
-		return 1;
-	}
-
-	if (sharpsl_pm.full_count == 0) {
-		int time;
-
-		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 2\n");
-
-		if ((sharpsl_check_battery_temp() < 0) || (sharpsl_check_battery_voltage() < 0))
-			return sharpsl_off_charge_error();
-
-		CHARGE_OFF();
-		mdelay(SHARPSL_CHARGE_WAIT_TIME);
-		CHARGE_ON();
-		sharpsl_pm.charge_mode = CHRG_ON;
-
-		mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
-
-		time = RCNR;
-		while(1) {
-			/* Check if any wakeup event had occured */
-			if (sharpsl_pm.machinfo->charger_wakeup() != 0)
-				return 0;
-			/* Check for timeout */
-			if ((RCNR - time) > SHARPSL_WAIT_CO_TIME)
-				return 1;
-			if (STATUS_CHRG_FULL()) {
-				dev_dbg(sharpsl_pm.dev, "Offline Charger: Charge full occured. Retrying to check\n");
-	   			sharpsl_pm.full_count++;
-				CHARGE_OFF();
-				mdelay(SHARPSL_CHARGE_WAIT_TIME);
-				CHARGE_ON();
-				return 1;
-			}
-		}
-	}
-
-	dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 3\n");
-
-	mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
-
-	time = RCNR;
-	while(1) {
-		/* Check if any wakeup event had occured */
-		if (sharpsl_pm.machinfo->charger_wakeup() != 0)
-			return 0;
-		/* Check for timeout */
-		if ((RCNR-time) > SHARPSL_WAIT_CO_TIME) {
-			if (sharpsl_pm.full_count > SHARPSL_CHARGE_RETRY_CNT) {
-				dev_dbg(sharpsl_pm.dev, "Offline Charger: Not charged sufficiently. Retrying.\n");
-				sharpsl_pm.full_count = 0;
-			}
-			sharpsl_pm.full_count++;
-			return 1;
-		}
-		if (STATUS_CHRG_FULL()) {
-			dev_dbg(sharpsl_pm.dev, "Offline Charger: Charging complete.\n");
-			CHARGE_LED_OFF();
-			CHARGE_OFF();
-			sharpsl_pm.charge_mode = CHRG_DONE;
-			return 1;
-		}
-	}
-}
-
-
-static ssize_t battery_percentage_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n",sharpsl_pm.battstat.mainbat_percent);
-}
-
-static ssize_t battery_voltage_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n",sharpsl_pm.battstat.mainbat_voltage);
-}
-
-static DEVICE_ATTR(battery_percentage, 0444, battery_percentage_show, NULL);
-static DEVICE_ATTR(battery_voltage, 0444, battery_voltage_show, NULL);
-
-extern void (*apm_get_power_status)(struct apm_power_info *);
-
-static void sharpsl_apm_get_power_status(struct apm_power_info *info)
-{
-	info->ac_line_status = sharpsl_pm.battstat.ac_status;
-
-	if (sharpsl_pm.charge_mode == CHRG_ON)
-		info->battery_status = APM_BATTERY_STATUS_CHARGING;
-	else
-		info->battery_status = sharpsl_pm.battstat.mainbat_status;
-
-	info->battery_flag = (1 << info->battery_status);
-	info->battery_life = sharpsl_pm.battstat.mainbat_percent;
-}
-
-static struct pm_ops sharpsl_pm_ops = {
-	.pm_disk_mode	= PM_DISK_FIRMWARE,
-	.prepare	= pxa_pm_prepare,
-	.enter		= corgi_pxa_pm_enter,
-	.finish		= pxa_pm_finish,
-};
-
-static int __init sharpsl_pm_probe(struct platform_device *pdev)
-{
-	if (!pdev->dev.platform_data)
-		return -EINVAL;
-
-	sharpsl_pm.dev = &pdev->dev;
-	sharpsl_pm.machinfo = pdev->dev.platform_data;
-	sharpsl_pm.charge_mode = CHRG_OFF;
-	sharpsl_pm.flags = 0;
-
-	sharpsl_pm.machinfo->init();
-
-	init_timer(&sharpsl_pm.ac_timer);
-	sharpsl_pm.ac_timer.function = sharpsl_ac_timer;
-
-	init_timer(&sharpsl_pm.chrg_full_timer);
-	sharpsl_pm.chrg_full_timer.function = sharpsl_chrg_full_timer;
-
 	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_acin | GPIO_IN);
 	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batfull | GPIO_IN);
 	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batlock | GPIO_IN);
@@ -938,26 +200,11 @@ static int __init sharpsl_pm_probe(struc
 		}
 		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull),IRQT_RISING);
 	}
-
-	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
-	device_create_file(&pdev->dev, &dev_attr_battery_voltage);
-
-	apm_get_power_status = sharpsl_apm_get_power_status;
-
-	pm_set_ops(&sharpsl_pm_ops);
-
-	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
-
 	return 0;
 }
 
-static int sharpsl_pm_remove(struct platform_device *pdev)
+int sharpsl_arch_pm_remove(void)
 {
-	pm_set_ops(NULL);
-
-	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
-	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
-
 	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
 	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
 
@@ -966,32 +213,5 @@ static int sharpsl_pm_remove(struct plat
 
 	if (!machine_is_corgi())
 		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
-
-	del_timer_sync(&sharpsl_pm.chrg_full_timer);
-	del_timer_sync(&sharpsl_pm.ac_timer);
-
 	return 0;
 }
-
-static struct platform_driver sharpsl_pm_driver = {
-	.probe		= sharpsl_pm_probe,
-	.remove		= sharpsl_pm_remove,
-	.suspend	= sharpsl_pm_suspend,
-	.resume		= sharpsl_pm_resume,
-	.driver		= {
-		.name		= "sharpsl-pm",
-	},
-};
-
-static int __devinit sharpsl_pm_init(void)
-{
-	return platform_driver_register(&sharpsl_pm_driver);
-}
-
-static void sharpsl_pm_exit(void)
-{
- 	platform_driver_unregister(&sharpsl_pm_driver);
-}
-
-late_initcall(sharpsl_pm_init);
-module_exit(sharpsl_pm_exit);
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -33,6 +33,7 @@ static void spitz_charger_init(void)
 {
 	pxa_gpio_mode(SPITZ_GPIO_KEY_INT | GPIO_IN);
 	pxa_gpio_mode(SPITZ_GPIO_SYNC | GPIO_IN);
+	sharpsl_arch_pm_init();
 }
 
 static void spitz_charge_led(int val)
@@ -182,6 +183,10 @@ static int spitz_acin_status(void)
 
 struct sharpsl_charger_machinfo spitz_pm_machinfo = {
 	.init             = spitz_charger_init,
+	.remove		  = sharpsl_arch_pm_remove,
+	.read_main_battery= sharpsl_read_main_battery,
+	.read_temp	  = sharpsl_read_temp,
+	.read_acin	  = sharpsl_read_acin,
 	.gpio_batlock     = SPITZ_GPIO_BAT_COVER,
 	.gpio_acin        = SPITZ_GPIO_AC_IN,
 	.gpio_batfull     = SPITZ_GPIO_CHRG_FULL,
--- clean-rp/arch/arm/mach-pxa/Makefile	2005-11-14 16:45:28.000000000 +0100
+++ linux-rp/arch/arm/mach-pxa/Makefile	2005-11-21 21:44:40.000000000 +0100
@@ -11,8 +11,8 @@
 obj-$(CONFIG_ARCH_LUBBOCK) += lubbock.o
 obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o
 obj-$(CONFIG_ARCH_PXA_IDP) += idp.o
-obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o corgi_pm.o
-obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o spitz_pm.o
+obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o sharp_pm.o sharpsl_pm.o corgi_pm.o
+obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o corgi_ssp.o corgi_lcd.o sharp_pm.o sharpsl_pm.o spitz_pm.o
 obj-$(CONFIG_MACH_AKITA)	+= akita-ioexp.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)         += tosa.o

-- 
Thanks, Sharp!
