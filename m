Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCVJiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCVJiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWCVJiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:38:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751165AbWCVJiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:38:19 -0500
Date: Wed, 22 Mar 2006 10:37:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
Subject: Re: [rfc] separate sharpsl_pm initialization from sysfs code
Message-ID: <20060322093752.GG14075@elf.ucw.cz>
References: <20060309124237.GA3794@elf.ucw.cz> <1141911202.10107.54.camel@localhost.localdomain> <20060310180719.GD8018@elf.ucw.cz> <20060313000231.GA6555@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313000231.GA6555@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	/* Register interrupt handler. */
> > 	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
> > 			       "ACIN", sharpsl_ac_isr))) {
> > 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
> > 		return;
> > 	}
> > 	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
> > 			       "CO", sharpsl_chrg_full_isr))) {
> > 		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
> > 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
> > 		return;
> > 	}
> 
> Shouldn't these be ucb1x00_hook_irq()'s?
> 
> Shouldn't you only enable the ADC when you need to use it?

Yes, I should.

> This driver makes no calls to ucb1x00_enable() and ucb1x00_disable().
> They're part of power management, and if your driver doesn't appear to
> require them to work, that means some other code is buggy (or you're
> keeping the ADC always enabled.)

Keeping ADC always enabled, which interferes with touchscreen,
badly. This fixes it, and allows touchscreen and battery to coexist.

(I'll clean it up and properly submit).
							Pavel

Enable/disable adc as needed. Now battery and touchscreen code seems
to cooperate.

---
commit 4907317f98c84569eb6c3d9c24b5b177fe60981b
tree 2998b0eebdd138b56740575d98f02e1cecaf4c34
parent e89a9fd829a3cd639f93ec0291251f6a99916226
author <pavel@amd.ucw.cz> Wed, 22 Mar 2006 10:22:10 +0100
committer <pavel@amd.ucw.cz> Wed, 22 Mar 2006 10:22:10 +0100

 arch/arm/mach-sa1100/collie_pm.c |    8 +++++++-
 drivers/mfd/ucb1x00-ts.c         |    4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie_pm.c b/arch/arm/mach-sa1100/collie_pm.c
index 1618ade..6a9f833 100644
--- a/arch/arm/mach-sa1100/collie_pm.c
+++ b/arch/arm/mach-sa1100/collie_pm.c
@@ -70,7 +70,6 @@ static void collie_charger_init(void)
 	ucb1x00_enable_irq(ucb, COLLIE_GPIO_AC_IN, UCB_RISING);
 	ucb1x00_enable_irq(ucb, COLLIE_GPIO_CO, UCB_RISING);
 
-	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_set_dir(ucb, 0, COLLIE_TC35143_GPIO_MBAT_ON |  COLLIE_TC35143_GPIO_TMP_ON |
 			           COLLIE_TC35143_GPIO_BBAT_ON);
 	return;
@@ -139,11 +138,14 @@ int collie_read_backup_battery(void)
 {
 	int voltage;
 
+	ucb1x00_adc_enable(ucb);
+
 	/* Gives 75..130 */
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_BBAT_ON, 0);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
 
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
+	ucb1x00_adc_disable(ucb);
 
 	printk("Backup battery = %d(%d)\n", ADCtoPower(voltage), voltage);
 
@@ -158,6 +160,7 @@ int collie_read_main_battery(void)
 	collie_read_temp();
 	collie_read_backup_battery();
 #endif
+	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_BBAT_ON);
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_MBAT_ON, 0);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD1, UCB_SYNC);
@@ -170,6 +173,7 @@ int collie_read_main_battery(void)
 
 	   On battery, it goes as low as 80.
 	*/
+	ucb1x00_adc_disable(ucb);
 
 	voltage_rev = voltage + ((ad_revise * voltage) / 652);
 	voltage_volts = ADCtoPower(voltage_rev);
@@ -190,9 +194,11 @@ int collie_read_temp(void)
 	/* temp must be > 973, main battery must be < 465 */
 	/* FIXME sharpsl_pm.c has both conditions negated? */
 
+	ucb1x00_adc_enable(ucb);
 	ucb1x00_io_write(ucb, COLLIE_TC35143_GPIO_TMP_ON, 0);
 	voltage = ucb1x00_adc_read(ucb, UCB_ADC_INP_AD0, UCB_SYNC);
 	ucb1x00_io_write(ucb, 0, COLLIE_TC35143_GPIO_TMP_ON);
+	ucb1x00_adc_disable(ucb);
 
 	/* >1010 = battery removed.
 	   460 = 22C ?

-- 
Picture of sleeping (Linux) penguin wanted...
