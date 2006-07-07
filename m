Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWGGLov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGGLov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWGGLov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:44:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64439 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932102AbWGGLou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:44:50 -0400
Date: Fri, 7 Jul 2006 13:44:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Subject: [patch] collie charging
Message-ID: <20060707114433.GA5407@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that sharp had charger on by default... This at least turns
it off. Also battery reading now works and is useful.

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.18-rc1-git

diff --git a/arch/arm/mach-sa1100/collie_pm.c b/arch/arm/mach-sa1100/collie_pm.c
index 45b1e71..1e25b1d 100644
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
@@ -40,9 +43,8 @@ static void collie_charger_init(void)
 {
 	int err;
 
-	if (sharpsl_param.adadj != -1) {
+	if (sharpsl_param.adadj != -1)
 		ad_revise = sharpsl_param.adadj;
-	}
 
 	/* Register interrupt handler. */
 	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, IRQF_DISABLED,
@@ -72,27 +74,17 @@ static void collie_measure_temp(int on)
 
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
 		set_scoop_gpio(&colliescoop_device.dev, COLLIE_SCP_CHARGE_ON);
 	} else {
 		reset_scoop_gpio(&colliescoop_device.dev, COLLIE_SCP_CHARGE_ON);
 	}
-#endif
 }
 
 static void collie_discharge(int on)
@@ -127,7 +119,6 @@ int collie_read_backup_battery(void)
 
 	ucb1x00_adc_enable(ucb);
 
-	/* Gives 75..130 */
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_BBAT_ON, 0);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
 
@@ -146,9 +137,8 @@ int collie_read_main_battery(void)
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
@@ -192,7 +182,7 @@ static unsigned long read_devdata(int wh
 	case SHARPSL_BATT_TEMP:
 		return collie_read_temp();
 	case SHARPSL_ACIN_VOLT:
-		return 0x1;
+		return 500;
 	case SHARPSL_STATUS_ACIN: {
 		int ret = GPLR & COLLIE_GPIO_AC_IN;
 		printk("AC status = %d\n", ret);
@@ -208,10 +198,33 @@ static unsigned long read_devdata(int wh
 	}
 }
 
+struct battery_thresh collie_battery_levels_acin[] = {
+	{ 420, 100},
+	{ 417,  95},
+	{ 415,  90},
+	{ 413,  80},
+	{ 411,  75},
+	{ 408,  70},
+	{ 406,  60},
+	{ 403,  50},
+	{ 398,  40},
+	{ 391,  25},
+	{  10,   5},
+	{   0,   0},
+};
+
 struct battery_thresh collie_battery_levels[] = {
-	{ 368, 100},
-	{ 358,  25},
-	{ 356,   5},
+	{ 394, 100},
+	{ 390,  95},
+	{ 380,  90},
+	{ 370,  80},
+	{ 368,  75},	/* From sharp code: battery high with frontlight */
+	{ 366,  70},	/* 60..90 -- fake values invented by me for testing */
+	{ 364,  60},
+	{ 362,  50},
+	{ 360,  40},
+	{ 358,  25},	/* From sharp code: battery low with frontlight */
+	{ 356,   5},	/* From sharp code: battery verylow with frontlight */
 	{   0,   0},
 };
 
@@ -226,13 +239,21 @@ struct sharpsl_charger_machinfo collie_p
 	.postsuspend      = collie_postsuspend,
 	.charger_wakeup   = collie_charger_wakeup,
 	.should_wakeup    = collie_should_wakeup,
-	.bat_levels       = 3,
+	.bat_levels       = 12,
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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
