Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVKWNF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKWNF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKWNFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:05:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18051 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750766AbVKWNFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:05:24 -0500
Date: Wed, 23 Nov 2005 14:03:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] split sharpsl_pm.c into generic and corgi/spitz specific parts
Message-ID: <20051123130350.GA23090@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This splits sharpsl_pm.c into sharpsl_pm.c (generic code) and
sharpsl_pm_pxa.c (spitz/corgi specific code). sharpsl_pm.c code should
be reusable by collie.

I'd like to see it applied...
								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -11,8 +11,8 @@ obj-$(CONFIG_PXA27x) += pxa27x.o
 obj-$(CONFIG_ARCH_LUBBOCK) += lubbock.o
 obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o
 obj-$(CONFIG_ARCH_PXA_IDP) += idp.o
-obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o corgi_pm.o
-obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o spitz_pm.o
+obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o sharpsl_pm_pxa.o corgi_pm.o
+obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o corgi_ssp.o corgi_lcd.o sharpsl_pm.o sharpsl_pm_pxa.o spitz_pm.o
 obj-$(CONFIG_MACH_AKITA)	+= akita-ioexp.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)         += tosa.o
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
@@ -3,6 +3,7 @@
  * series of PDAs
  *
  * Copyright (c) 2004-2005 Richard Purdie
+ * Copyright (c) 2005 Pavel Machek <pavel@suse.cz>
  *
  * Based on code written by Sharp for 2.4 kernels
  *
@@ -29,10 +30,11 @@
 #include <asm/irq.h>
 #include <asm/apm.h>
 
+#include "../mach-pxa/sharpsl.h"
+
 #include <asm/arch/pm.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/sharpsl.h>
-#include "sharpsl.h"
 
 /*
  * Constants
@@ -57,110 +59,9 @@
 #define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
 #define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
 
-struct battery_thresh spitz_battery_levels_acin[] = {
-	{ 213, 100},
-	{ 212,  98},
-	{ 211,  95},
-	{ 210,  93},
-	{ 209,  90},
-	{ 208,  88},
-	{ 207,  85},
-	{ 206,  83},
-	{ 205,  80},
-	{ 204,  78},
-	{ 203,  75},
-	{ 202,  73},
-	{ 201,  70},
-	{ 200,  68},
-	{ 199,  65},
-	{ 198,  63},
-	{ 197,  60},
-	{ 196,  58},
-	{ 195,  55},
-	{ 194,  53},
-	{ 193,  50},
-	{ 192,  48},
-	{ 192,  45},
-	{ 191,  43},
-	{ 191,  40},
-	{ 190,  38},
-	{ 190,  35},
-	{ 189,  33},
-	{ 188,  30},
-	{ 187,  28},
-	{ 186,  25},
-	{ 185,  23},
-	{ 184,  20},
-	{ 183,  18},
-	{ 182,  15},
-	{ 181,  13},
-	{ 180,  10},
-	{ 179,   8},
-	{ 178,   5},
-	{   0,   0},
-};
-
-struct battery_thresh  spitz_battery_levels_noac[] = {
-	{ 213, 100},
-	{ 212,  98},
-	{ 211,  95},
-	{ 210,  93},
-	{ 209,  90},
-	{ 208,  88},
-	{ 207,  85},
-	{ 206,  83},
-	{ 205,  80},
-	{ 204,  78},
-	{ 203,  75},
-	{ 202,  73},
-	{ 201,  70},
-	{ 200,  68},
-	{ 199,  65},
-	{ 198,  63},
-	{ 197,  60},
-	{ 196,  58},
-	{ 195,  55},
-	{ 194,  53},
-	{ 193,  50},
-	{ 192,  48},
-	{ 191,  45},
-	{ 190,  43},
-	{ 189,  40},
-	{ 188,  38},
-	{ 187,  35},
-	{ 186,  33},
-	{ 185,  30},
-	{ 184,  28},
-	{ 183,  25},
-	{ 182,  23},
-	{ 181,  20},
-	{ 180,  18},
-	{ 179,  15},
-	{ 178,  13},
-	{ 177,  10},
-	{ 176,   8},
-	{ 175,   5},
-	{   0,   0},
-};
-
-/* MAX1111 Commands */
-#define MAXCTRL_PD0      1u << 0
-#define MAXCTRL_PD1      1u << 1
-#define MAXCTRL_SGL      1u << 2
-#define MAXCTRL_UNI      1u << 3
-#define MAXCTRL_SEL_SH   4
-#define MAXCTRL_STR      1u << 7
-
-/* MAX1111 Channel Definitions */
-#define BATT_AD    4u
-#define BATT_THM   2u
-#define JK_VAD     6u
-
-
 /*
  * Prototypes
  */
-static int sharpsl_read_main_battery(void);
 static int sharpsl_off_charge_battery(void);
 static int sharpsl_check_battery_temp(void);
 static int sharpsl_check_battery_voltage(void);
@@ -237,7 +138,7 @@ static void sharpsl_battery_thread(void 
 		schedule_work(&toggle_charger);
 
 	while(1) {
-		voltage = sharpsl_read_main_battery();
+		voltage = sharpsl_pm.machinfo->read_main_battery();
 		if (voltage > 0) break;
 		if (i++ > 5) {
 			voltage = sharpsl_pm.machinfo->bat_levels_noac[0].voltage;
@@ -350,7 +251,7 @@ static void sharpsl_ac_timer(unsigned lo
 }
 
 
-static irqreturn_t sharpsl_ac_isr(int irq, void *dev_id, struct pt_regs *fp)
+irqreturn_t sharpsl_ac_isr(int irq, void *dev_id, struct pt_regs *fp)
 {
 	/* Delay the event slightly to debounce */
 	/* Must be a smaller delay than the chrg_full_isr below */
@@ -385,7 +286,7 @@ static void sharpsl_chrg_full_timer(unsi
 /* Charging Finished Interrupt (Not present on Corgi) */
 /* Can trigger at the same time as an AC staus change so
    delay until after that has been processed */
-static irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
+irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id, struct pt_regs *fp)
 {
 	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
 		return IRQ_HANDLED;
@@ -396,7 +297,7 @@ static irqreturn_t sharpsl_chrg_full_isr
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id, struct pt_regs *fp)
+irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id, struct pt_regs *fp)
 {
 	int is_fatal = 0;
 
@@ -452,40 +353,6 @@ static int sharpsl_average_value(int ad)
 	return (ad_val / sharpsl_ad_index);
 }
 
-
-/*
- * Read MAX1111 ADC
- */
-static int read_max1111(int channel)
-{
-	return corgi_ssp_max1111_get((channel << MAXCTRL_SEL_SH) | MAXCTRL_PD0 | MAXCTRL_PD1
-			| MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
-}
-
-static int sharpsl_read_main_battery(void)
-{
-	return read_max1111(BATT_AD);
-}
-
-static int sharpsl_read_temp(void)
-{
-	int temp;
-
-	sharpsl_pm.machinfo->measure_temp(1);
-
-	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
-	temp = read_max1111(BATT_THM);
-
-	sharpsl_pm.machinfo->measure_temp(0);
-
-	return temp;
-}
-
-static int sharpsl_read_acin(void)
-{
-	return read_max1111(JK_VAD);
-}
-
 /*
  * Take an array of 5 integers, remove the maximum and minimum values
  * and return the average.
@@ -530,7 +397,7 @@ static int sharpsl_check_battery_temp(vo
 	/* Check battery temperature */
 	for (i=0; i<5; i++) {
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
-		buff[i] = sharpsl_read_temp();
+		buff[i] = sharpsl_pm.machinfo->read_temp();
 	}
 
 	val = get_select_val(buff);
@@ -556,7 +423,7 @@ static int sharpsl_check_battery_voltage
 
 	/* Check battery voltage */
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_main_battery();
+		buff[i] = sharpsl_pm.machinfo->read_main_battery();
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
 	}
 
@@ -579,7 +446,7 @@ static int sharpsl_ac_check(void)
 	int temp, i, buff[5];
 
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_acin();
+		buff[i] = sharpsl_pm.machinfo->read_acin();
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
 	}
 
@@ -681,7 +548,6 @@ static int corgi_enter_suspend(unsigned 
 		corgi_goto_sleep(alarm_time, alarm_enable, state);
 		return 1;
 	}
-
 	return 0;
 }
 
@@ -729,7 +595,7 @@ static int sharpsl_fatal_check(void)
 
 	/* Check battery : check inserting battery ? */
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_main_battery();
+		buff[i] = sharpsl_pm.machinfo->read_main_battery();
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
 	}
 
@@ -743,7 +609,7 @@ static int sharpsl_fatal_check(void)
 	}
 
 	temp = get_select_val(buff);
-	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_read_main_battery());
+	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_pm.machinfo.read_main_battery());
 
 	if ((acin && (temp < SHARPSL_FATAL_ACIN_VOLT)) ||
 			(!acin && (temp < SHARPSL_FATAL_NOACIN_VOLT)))
@@ -908,37 +774,6 @@ static int __init sharpsl_pm_probe(struc
 	init_timer(&sharpsl_pm.chrg_full_timer);
 	sharpsl_pm.chrg_full_timer.function = sharpsl_chrg_full_timer;
 
-	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_acin | GPIO_IN);
-	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batfull | GPIO_IN);
-	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batlock | GPIO_IN);
-
-	/* Register interrupt handlers */
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, SA_INTERRUPT, "AC Input Detect", sharpsl_ac_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
-	}
-	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin),IRQT_BOTHEDGE);
-
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, SA_INTERRUPT, "Battery Cover", sharpsl_fatal_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
-	}
-	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock),IRQT_FALLING);
-
-	if (sharpsl_pm.machinfo->gpio_fatal) {
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, SA_INTERRUPT, "Fatal Battery", sharpsl_fatal_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
-		}
-		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal),IRQT_FALLING);
-	}
-
-	if (!machine_is_corgi())
-	{
-		/* Register interrupt handler. */
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, SA_INTERRUPT, "CO", sharpsl_chrg_full_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
-		}
-		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull),IRQT_RISING);
-	}
-
 	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
 	device_create_file(&pdev->dev, &dev_attr_battery_voltage);
 
@@ -958,18 +793,10 @@ static int sharpsl_pm_remove(struct plat
 	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
 	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
 
-	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
-	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
-
-	if (sharpsl_pm.machinfo->gpio_fatal)
-		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
-
-	if (!machine_is_corgi())
-		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
+	sharpsl_pm.machinfo->remove();
 
 	del_timer_sync(&sharpsl_pm.chrg_full_timer);
 	del_timer_sync(&sharpsl_pm.ac_timer);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/sharpsl_pm_pxa.c b/arch/arm/mach-pxa/sharpsl_pm_pxa.c
new file mode 100644
--- /dev/null
+++ b/arch/arm/mach-pxa/sharpsl_pm_pxa.c
@@ -0,0 +1,217 @@
+/*
+ * Battery and Power Management code for the Sharp SL-C7xx and SL-Cxx00
+ * series of PDAs
+ *
+ * Copyright (c) 2004-2005 Richard Purdie
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
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/sharpsl.h>
+
+#include "../mach-pxa/sharpsl.h"
+
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
+
+struct battery_thresh spitz_battery_levels_acin[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 192,  45},
+	{ 191,  43},
+	{ 191,  40},
+	{ 190,  38},
+	{ 190,  35},
+	{ 189,  33},
+	{ 188,  30},
+	{ 187,  28},
+	{ 186,  25},
+	{ 185,  23},
+	{ 184,  20},
+	{ 183,  18},
+	{ 182,  15},
+	{ 181,  13},
+	{ 180,  10},
+	{ 179,   8},
+	{ 178,   5},
+	{   0,   0},
+};
+
+struct battery_thresh  spitz_battery_levels_noac[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 191,  45},
+	{ 190,  43},
+	{ 189,  40},
+	{ 188,  38},
+	{ 187,  35},
+	{ 186,  33},
+	{ 185,  30},
+	{ 184,  28},
+	{ 183,  25},
+	{ 182,  23},
+	{ 181,  20},
+	{ 180,  18},
+	{ 179,  15},
+	{ 178,  13},
+	{ 177,  10},
+	{ 176,   8},
+	{ 175,   5},
+	{   0,   0},
+};
+
+
+/* MAX1111 Commands */
+#define MAXCTRL_PD0      1u << 0
+#define MAXCTRL_PD1      1u << 1
+#define MAXCTRL_SGL      1u << 2
+#define MAXCTRL_UNI      1u << 3
+#define MAXCTRL_SEL_SH   4
+#define MAXCTRL_STR      1u << 7
+
+/* MAX1111 Channel Definitions */
+#define BATT_AD    4u
+#define BATT_THM   2u
+#define JK_VAD     6u
+
+/*
+ * Read MAX1111 ADC
+ */
+static int read_max1111(int channel)
+{
+	return corgi_ssp_max1111_get((channel << MAXCTRL_SEL_SH) | MAXCTRL_PD0 | MAXCTRL_PD1
+			| MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
+}
+
+int sharpsl_read_main_battery(void)
+{
+	return read_max1111(BATT_AD);
+}
+
+int sharpsl_read_temp(void)
+{
+	int temp;
+
+	sharpsl_pm.machinfo->measure_temp(1);
+
+	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
+	temp = read_max1111(BATT_THM);
+
+	sharpsl_pm.machinfo->measure_temp(0);
+
+	return temp;
+}
+
+int sharpsl_read_acin(void)
+{
+	return read_max1111(JK_VAD);
+}
+
+int sharpsl_arch_pm_init(void)
+{
+	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_acin | GPIO_IN);
+	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batfull | GPIO_IN);
+	pxa_gpio_mode(sharpsl_pm.machinfo->gpio_batlock | GPIO_IN);
+
+	/* Register interrupt handlers */
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, SA_INTERRUPT, "AC Input Detect", sharpsl_ac_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
+	}
+	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin),IRQT_BOTHEDGE);
+
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, SA_INTERRUPT, "Battery Cover", sharpsl_fatal_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
+	}
+	else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock),IRQT_FALLING);
+
+	if (sharpsl_pm.machinfo->gpio_fatal) {
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, SA_INTERRUPT, "Fatal Battery", sharpsl_fatal_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
+		}
+		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal),IRQT_FALLING);
+	}
+
+	if (!machine_is_corgi())
+	{
+		/* Register interrupt handler. */
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, SA_INTERRUPT, "CO", sharpsl_chrg_full_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
+		}
+		else set_irq_type(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull),IRQT_RISING);
+	}
+	return 0;
+}
+
+int sharpsl_arch_pm_remove(void)
+{
+	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
+	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
+
+	if (sharpsl_pm.machinfo->gpio_fatal)
+		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
+
+	if (!machine_is_corgi())
+		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
+	return 0;
+}
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

-- 
Thanks, Sharp!
