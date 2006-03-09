Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWCIMjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWCIMjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCIMjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:39:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6592 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932134AbWCIMjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:39:09 -0500
Date: Thu, 9 Mar 2006 13:38:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [rfc] Collie battery status sensing code
Message-ID: <20060309123842.GA3619@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is collie battery sensing code. It differs from sharpsl code a
bit -- because it is dependend on ucb1x00, not on platform bus.

I guess I should reorganize #include's and remove #if 0-ed
code. Anything else?
							Pavel

diff --git a/arch/arm/mach-sa1100/collie_pm.c b/arch/arm/mach-sa1100/collie_pm.c
new file mode 100644
index 0000000..491d03a
--- /dev/null
+++ b/arch/arm/mach-sa1100/collie_pm.c
@@ -0,0 +1,324 @@
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
+#include <asm/apm.h>
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+#include <asm/hardware.h>
+#include <asm/hardware/scoop.h>
+#include <asm/dma.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/collie.h>
+#include "../mach-pxa/sharpsl.h"
+#include "../drivers/mfd/ucb1x00.h"
+#include <asm/mach/sharpsl_param.h>
+
+#ifdef CONFIG_MCP_UCB1200_TS
+#error Battery interferes with touchscreen
+#endif
+
+static struct ucb1x00 *ucb;
+
+#define ConvRevise(x)          ( ( ad_revise * x ) / 652 )
+#define ADCtoPower(x)	       (( 330 * x * 2 ) / 1024 )
+
+static int ad_revise = 0;
+
+static void collie_charger_init(void)
+{
+	int err;
+
+	/* get ad revise */
+	if (sharpsl_param.adadj != -1) {
+		ad_revise = sharpsl_param.adadj;
+	} else {
+		ad_revise = 0;
+	}
+
+	/* Register interrupt handler. */
+	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
+			       "ACIN", sharpsl_ac_isr))) {
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
+		return;
+	}
+
+	/* Register interrupt handler. */
+	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
+			       "CO", sharpsl_chrg_full_isr))) {
+		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
+		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
+		return;
+	}
+
+	if (!ucb)
+		printk(KERN_CRIT "ucb is null!\n");
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
+static void collie_charge_led(int val)
+{
+	if (val == SHARPSL_LED_ERROR) {
+		dev_dbg(sharpsl_pm.dev, "Charge LED Error\n");
+	} else if (val == SHARPSL_LED_ON) {
+		dev_dbg(sharpsl_pm.dev, "Charge LED On\n");
+	} else {
+		dev_dbg(sharpsl_pm.dev, "Charge LED Off\n");
+	}
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
+	if (on) {
+		printk("Should start charger\n");
+	} else {
+		printk("Should stop charger\n");
+	}
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
+static int collie_acin_status(void)
+{
+	int ret = GPLR & COLLIE_GPIO_AC_IN;
+	printk("AC status = %d\n", ret);
+	return ret;
+}
+
+int collie_read_backup_battery(void)
+{
+	int voltage;
+
+	/* Gives 75..130 */
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
+	int voltage;
+
+	collie_read_temp();
+	collie_read_backup_battery();
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
+	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_MBAT_ON, 0);
+	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
+
+	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON);
+
+	/*
+	   gives values 160..255 with battery removed... and
+	   145..255 with battery inserted. (on AC)
+
+	   On battery, it goes as low as 80.
+	*/
+
+	printk("Main battery = %d(%d)\n",ADCtoPower((voltage+ConvRevise(voltage))),voltage);
+
+	if ( voltage != -1 ) {
+		return ADCtoPower((voltage+ConvRevise(voltage)));
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
+	/* >1010 = battery removed.
+	   460 = 22C ?
+	   higer = lower temp ?
+	*/
+
+	printk("Battery temp = %d\n", voltage);
+	return voltage;
+}
+
+static int collie_read_acin(void)
+{
+	return 0x1;
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
+		return collie_read_acin();
+	case SHARPSL_STATUS_ACIN:
+	case SHARPSL_STATUS_LOCK:
+	case SHARPSL_STATUS_CHRGFULL:
+	case SHARPSL_STATUS_FATAL:
+	default:
+		return ~0;
+	}
+#if 0
+It should be okay. Nobody really needs those.
+	.gpio_batlock     = COLLIE_GPIO_BAT_COVER,
+	.gpio_acin        = COLLIE_GPIO_AC_IN,
+	.gpio_batfull     = COLLIE_GPIO_CHRG_FULL,
+	.gpio_fatal       = COLLIE_GPIO_FATAL_BAT,
+#endif
+}
+
+struct battery_thresh spitz_battery_levels_noac[] = {
+#ifdef FOO_FRONTLIGHT
+	{ 368, 100},
+	{ 358,  25},
+	{ 356,   5},
+	{   0,   0},
+#else
+	{ 378, 100},
+	{ 365,  25},
+	{ 363,   5},
+	{   0,   0},
+#endif	
+};
+
+struct battery_thresh spitz_battery_levels_acin[] = {
+#ifdef FOO_FRONTLIGHT
+	{ 368, 100},
+	{ 358,  25},
+	{ 356,   5},
+	{   0,   0},
+#else
+	{ 378, 100},
+	{ 365,  25},
+	{ 363,   5},
+	{   0,   0},
+#endif	
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
+static int collie_pm_remove(struct ucb1x00_dev *pdev)
+{
+	return sharpsl_pm_done();
+}
+
+static struct ucb1x00_driver collie_pm_driver = {
+	.add            = collie_pm_add,
+        .remove         = collie_pm_remove,
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
