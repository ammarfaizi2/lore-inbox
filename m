Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWCINMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWCINMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCINMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:12:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41708 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751044AbWCINMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:12:14 -0500
Date: Thu, 9 Mar 2006 14:11:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Collie battery status sensing code
Message-ID: <20060309131153.GA3516@elf.ucw.cz>
References: <20060309123842.GA3619@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309123842.GA3619@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is collie battery sensing code. It differs from sharpsl code a
> bit -- because it is dependend on ucb1x00, not on platform bus.
> 
> I guess I should reorganize #include's and remove #if 0-ed
> code. Anything else?

I cleaned it up a bit more. Anything left?
								Pavel

--- /dev/null
+++ b/arch/arm/mach-sa1100/collie_pm.c
@@ -0,0 +1,254 @@
+/*
+ * Based on spitz_pm.c and sharp code.
+ *
+ * Copyright (C) 2001  SHARP
+ * Copyright 2005 Pavel Machek <pavel@suse.cz>
+ *
+ * Distribute under GPLv2.
+ */
+
+#include <linux/module.h>
+#include <linux/stat.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+#include <asm/hardware.h>
+#include <asm/hardware/scoop.h>
+#include <asm/dma.h>
+#include <asm/arch/collie.h>
+#include <asm/mach/sharpsl_param.h>
+
+#include "../mach-pxa/sharpsl.h"
+#include "../drivers/mfd/ucb1x00.h"
+
+static struct ucb1x00 *ucb;
+static int ad_revise;
+
+#define ADCtoPower(x)	       ((330 * x * 2) / 1024)
+
+static void collie_charger_init(void)
+{
+	int err;
+
+	if (sharpsl_param.adadj != -1) {
+		ad_revise = sharpsl_param.adadj;
+	}
+
+	/* Register interrupt handler. */
+	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
+			       "ACIN", sharpsl_ac_isr))) {
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
+		return;
+	}
+	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
+			       "CO", sharpsl_chrg_full_isr))) {
+		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
+		return;
+	}
+
+	/* Set transition detect */
+	ucb1x00_enable_irq(ucb, COLLIE_GPIO_AC_IN, UCB_RISING);
+	ucb1x00_enable_irq(ucb, COLLIE_GPIO_CO, UCB_RISING);
+
+	ucb1x00_adc_enable(ucb);
+	ucb1x00_io_set_dir(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON |  COLLIE_TC35143_GPIO_TMP_ON |
+			           COLLIE_TC35143_GPIO_BBAT_ON);
+	return;
+}
+
+static void collie_measure_temp(int on)
+{
+	if (on)
+		ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_TMP_ON, 0);
+	else
+		ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_TMP_ON);
+}
+
+static void collie_charge(int on)
+{
+#ifdef I_AM_SURE
+#define CF_BUF_CTRL_BASE 0xF0800000
+#define        SCOOP_REG(adr) (*(volatile unsigned short*)(CF_BUF_CTRL_BASE+(adr)))
+#define        SCOOP_REG_GPWR    SCOOP_REG(SCOOP_GPWR)
+
+	if (on) {
+		SCOOP_REG_GPWR |= COLLIE_SCP_CHARGE_ON;
+	} else {
+		SCOOP_REG_GPWR &= ~COLLIE_SCP_CHARGE_ON;
+	}
+#endif
+}
+
+static void collie_discharge(int on)
+{
+}
+
+static void collie_discharge1(int on)
+{
+}
+
+static void collie_presuspend(void)
+{
+}
+
+static void collie_postsuspend(void)
+{
+}
+
+static int collie_should_wakeup(unsigned int resume_on_alarm)
+{
+	return 0;
+}
+
+static unsigned long collie_charger_wakeup(void)
+{
+	return 0;
+}
+
+int collie_read_backup_battery(void)
+{
+	int voltage;
+
+	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_BBAT_ON, 0);
+	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
+
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
+
+	printk("Backup battery = %d(%d)\n", ADCtoPower(voltage), voltage);
+
+	return ADCtoPower(voltage);
+}
+
+int collie_read_main_battery(void)
+{
+	int voltage, voltage_rev, voltage_volts;
+
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
+	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_MBAT_ON, 0);
+	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
+
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON);
+
+	voltage_rev = voltage + ((ad_revise * voltage) / 652);
+	voltage_volts = ADCtoPower(voltage_rev);
+
+	printk("Main battery = %d(%d)\n", voltage_volts, voltage);
+
+	if ( voltage != -1 ) {
+		return voltage_volts;
+	} else {
+		return voltage;
+	}
+}
+
+int collie_read_temp(void)
+{
+	int voltage;
+
+	/* temp must be > 973, main battery must be < 465 */
+	/* FIXME sharpsl_pm.c has both conditions negated? */
+
+	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_TMP_ON, 0);
+	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD0, UCB_SYNC);
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_TMP_ON);
+
+	printk("Battery temp = %d\n", voltage);
+	return voltage;
+}
+
+static unsigned long read_devdata(int which)
+{
+	switch (which) {
+	case SHARPSL_BATT_VOLT:
+		return collie_read_main_battery();
+	case SHARPSL_BATT_TEMP:
+		return collie_read_temp();
+	case SHARPSL_ACIN_VOLT:
+		return 0x1;
+	case SHARPSL_STATUS_ACIN: {
+		int ret = GPLR & COLLIE_GPIO_AC_IN;
+		printk("AC status = %d\n", ret);
+		return ret;
+	}
+	case SHARPSL_STATUS_FATAL: {
+		int ret = GPLR & COLLIE_GPIO_MAIN_BAT_LOW;
+		printk("Fatal bat = %d\n", ret);
+		return ret;
+	}
+	default:
+		return ~0;
+	}
+}
+
+struct battery_thresh spitz_battery_levels_noac[] = {
+	{ 368, 100},
+	{ 358,  25},
+	{ 356,   5},
+	{   0,   0},
+};
+
+struct battery_thresh spitz_battery_levels_acin[] = {
+	{ 378, 100},
+	{ 365,  25},
+	{ 363,   5},
+	{   0,   0},
+};
+
+struct sharpsl_charger_machinfo collie_pm_machinfo = {
+	.init             = collie_charger_init,
+	.read_devdata	  = read_devdata,
+	.discharge        = collie_discharge,
+	.discharge1       = collie_discharge1,
+	.charge           = collie_charge,
+	.measure_temp     = collie_measure_temp,
+	.presuspend       = collie_presuspend,
+	.postsuspend      = collie_postsuspend,
+	.charger_wakeup   = collie_charger_wakeup,
+	.should_wakeup    = collie_should_wakeup,
+	.bat_levels       = 3,
+	.bat_levels_noac  = spitz_battery_levels_noac,
+	.bat_levels_acin  = spitz_battery_levels_acin,
+	.status_high_acin = 368,
+	.status_low_acin  = 358,
+	.status_high_noac = 368,
+	.status_low_noac  = 358,
+};
+
+extern struct sharpsl_pm_status sharpsl_pm;
+
+static int __init collie_pm_add(struct ucb1x00_dev *pdev)
+{
+	sharpsl_pm.dev = NULL;
+	sharpsl_pm.machinfo = &collie_pm_machinfo;
+	ucb = pdev->ucb;
+	return sharpsl_pm_init();
+}
+
+static void collie_pm_remove(struct ucb1x00_dev *pdev)
+{
+	sharpsl_pm_done();
+}
+
+static struct ucb1x00_driver collie_pm_driver = {
+	.add            = collie_pm_add,
+	.remove         = collie_pm_remove,
+};
+
+static int __init collie_pm_init(void)
+{
+	return ucb1x00_register_driver(&collie_pm_driver);
+}
+
+static void __exit collie_pm_exit(void)
+{
+	ucb1x00_unregister_driver(&collie_pm_driver);
+}
+
+late_initcall(collie_pm_init);
+module_exit(collie_pm_exit);

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
