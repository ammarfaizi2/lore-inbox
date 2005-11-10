Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVKJX5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVKJX5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKJX5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:57:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6545 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932223AbVKJX5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:57:18 -0500
Date: Fri, 11 Nov 2005 00:56:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: More cleanups for sharpsl_pm.c
Message-ID: <20051110235614.GA21337@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

sharpsl.c uses macros to hide method calls, in quite a confusing
way. This just inlines the macros, so it is easy to see what is going
on.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
--- a/arch/arm/mach-pxa/sharpsl.h
+++ b/arch/arm/mach-pxa/sharpsl.h
@@ -108,14 +108,6 @@ extern struct battery_thresh spitz_batte
 #define SHARPSL_LED_ON     1
 #define SHARPSL_LED_OFF    0
 
-#define CHARGE_ON()         sharpsl_pm.machinfo->charge(1)
-#define CHARGE_OFF()        sharpsl_pm.machinfo->charge(0)
-#define CHARGE_LED_ON()     sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ON)
-#define CHARGE_LED_OFF()    sharpsl_pm.machinfo->chargeled(SHARPSL_LED_OFF)
-#define CHARGE_LED_ERR()    sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ERROR)
-#define DISCHARGE_ON()      sharpsl_pm.machinfo->discharge(1)
-#define DISCHARGE_OFF()     sharpsl_pm.machinfo->discharge(0)
-#define STATUS_AC_IN()      sharpsl_pm.machinfo->status_acin()
 #define STATUS_BATT_LOCKED() READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock)
 #define STATUS_CHRG_FULL()  READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull)
 #define STATUS_FATAL()      READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal)
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -198,7 +214,9 @@ static int get_percentage(int voltage)
 static int get_apm_status(int voltage)
 {
 	int low_thresh, high_thresh;
-
+/* FIXME:
+   why not simply get_percentage, and base it off that?
+*/
 	if (sharpsl_pm.charge_mode == CHRG_ON) {
 		high_thresh = sharpsl_pm.machinfo->status_high_acin;
 		low_thresh = sharpsl_pm.machinfo->status_low_acin;
@@ -228,7 +246,7 @@ static void sharpsl_battery_thread(void 
 	if (!sharpsl_pm.machinfo)
 		return;
 
-	sharpsl_pm.battstat.ac_status = (STATUS_AC_IN() ? APM_AC_ONLINE : APM_AC_OFFLINE);
+	sharpsl_pm.battstat.ac_status = (sharpsl_pm.machinfo->status_acin() ? APM_AC_ONLINE : APM_AC_OFFLINE);
 
 	/* Corgi cannot confirm when battery fully charged so periodically kick! */
 	if (machine_is_corgi() && (sharpsl_pm.charge_mode == CHRG_ON)
@@ -299,8 +317,8 @@ static void sharpsl_charge_off(void)
 {
 	dev_dbg(sharpsl_pm.dev, "Turning Charger Off\n");
 
-	CHARGE_OFF();
-	CHARGE_LED_OFF();
+	sharpsl_pm.machinfo->charge(0);
+	sharpsl_pm.machinfo->chargeled(SHARPSL_LED_OFF);
 	sharpsl_pm.charge_mode = CHRG_OFF;
 
 	schedule_work(&sharpsl_bat);
@@ -308,16 +326,16 @@ static void sharpsl_charge_off(void)
 
 static void sharpsl_charge_error(void)
 {
-	CHARGE_LED_ERR();
-	CHARGE_OFF();
+	sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ERROR);
+	sharpsl_pm.machinfo->charge(0);
 	sharpsl_pm.charge_mode = CHRG_ERROR;
 }
 
 static void sharpsl_charge_toggle(void *private_)
 {
-	dev_dbg(sharpsl_pm.dev, "Toogling Charger at time: %lx\n", jiffies);
+	dev_dbg(sharpsl_pm.dev, "Toggling Charger at time: %lx\n", jiffies);
 
-	if (STATUS_AC_IN() == 0) {
+	if (sharpsl_pm.machinfo->status_acin() == 0) {
 		sharpsl_charge_off();
 		return;
 	} else if ((sharpsl_check_battery(1) < 0) || (sharpsl_ac_check() < 0)) {
@@ -325,17 +343,17 @@ static void sharpsl_charge_toggle(void *
 		return;
 	}
 
-	CHARGE_LED_ON();
-	CHARGE_OFF();
+	sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ON);
+	sharpsl_pm.machinfo->charge(0);
 	mdelay(SHARPSL_CHARGE_WAIT_TIME);
-	CHARGE_ON();
+	sharpsl_pm.machinfo->charge(1);
 
 	sharpsl_pm.charge_start_time = jiffies;
 }
 
 static void sharpsl_ac_timer(unsigned long data)
 {
-	int acin = STATUS_AC_IN();
+	int acin = sharpsl_pm.machinfo->status_acin();
 
 	dev_dbg(sharpsl_pm.dev, "AC Status: %d\n",acin);
 
@@ -364,7 +382,7 @@ static void sharpsl_chrg_full_timer(unsi
 
 	sharpsl_pm.full_count++;
 
-	if (STATUS_AC_IN() == 0) {
+	if (sharpsl_pm.machinfo->status_acin() == 0) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
 		if (sharpsl_pm.charge_mode == CHRG_ON)
 			sharpsl_charge_off();
@@ -543,8 +614,8 @@ static int sharpsl_check_battery(int mod
 		return 0;
 
 	/* disable charge, enable discharge */
-	CHARGE_OFF();
-	DISCHARGE_ON();
+	sharpsl_pm.machinfo->charge(0);
+	sharpsl_pm.machinfo->discharge(1);
 	mdelay(SHARPSL_WAIT_DISCHARGE_ON);
 
 	if (sharpsl_pm.machinfo->discharge1)
@@ -559,7 +630,7 @@ static int sharpsl_check_battery(int mod
 	if (sharpsl_pm.machinfo->discharge1)
 		sharpsl_pm.machinfo->discharge1(0);
 
-	DISCHARGE_OFF();
+	sharpsl_pm.machinfo->discharge(0);
 
 	val = get_select_val(buff);
 	dev_dbg(sharpsl_pm.dev, "Battery Voltage: %d\n", val);
@@ -622,7 +693,7 @@ static void corgi_goto_sleep(unsigned lo
 	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
 	/* not charging and AC-IN! */
 
-	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (STATUS_AC_IN() != 0)) {
+	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (sharpsl_pm.machinfo->status_acin() != 0)) {
 		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
 		sharpsl_pm.charge_mode = CHRG_OFF;
 		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
@@ -711,12 +782,12 @@ static int sharpsl_fatal_check(void)
 	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check entered\n");
 
 	/* Check AC-Adapter */
-	acin = STATUS_AC_IN();
+	acin = sharpsl_pm.machinfo->status_acin();
 
 	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
-		CHARGE_OFF();
+		sharpsl_pm.machinfo->charge(0);
 		udelay(100);
-		DISCHARGE_ON();	/* enable discharge */
+		sharpsl_pm.machinfo->discharge(1);	/* enable discharge */
 		mdelay(SHARPSL_WAIT_DISCHARGE_ON);
 	}
 
@@ -734,8 +805,8 @@ static int sharpsl_fatal_check(void)
 
 	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
 		udelay(100);
-		CHARGE_ON();
-		DISCHARGE_OFF();
+		sharpsl_pm.machinfo->charge(1);
+		sharpsl_pm.machinfo->discharge(0);
 	}
 
 	temp = get_select_val(buff);
@@ -750,8 +821,8 @@ static int sharpsl_fatal_check(void)
 static int sharpsl_off_charge_error(void)
 {
 	dev_err(sharpsl_pm.dev, "Offline Charger: Error occured.\n");
-	CHARGE_OFF();
-	CHARGE_LED_ERR();
+	sharpsl_pm.machinfo->charge(0);
+	sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ERROR);
 	sharpsl_pm.charge_mode = CHRG_ERROR;
 	return 1;
 }
@@ -775,10 +846,10 @@ static int sharpsl_off_charge_battery(vo
 			return sharpsl_off_charge_error();
 
 		/* Start Charging */
-		CHARGE_LED_ON();
-		CHARGE_OFF();
+		sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ON);
+		sharpsl_pm.machinfo->charge(0);
 		mdelay(SHARPSL_CHARGE_WAIT_TIME);
-		CHARGE_ON();
+		sharpsl_pm.machinfo->charge(1);
 
 		sharpsl_pm.charge_mode = CHRG_ON;
 		sharpsl_pm.full_count = 0;
@@ -796,9 +867,9 @@ static int sharpsl_off_charge_battery(vo
 		if (sharpsl_check_battery(0) < 0)
 			return sharpsl_off_charge_error();
 
-		CHARGE_OFF();
+		sharpsl_pm.machinfo->charge(0);
 		mdelay(SHARPSL_CHARGE_WAIT_TIME);
-		CHARGE_ON();
+		sharpsl_pm.machinfo->charge(1);
 		sharpsl_pm.charge_mode = CHRG_ON;
 
 		mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
@@ -814,9 +885,9 @@ static int sharpsl_off_charge_battery(vo
 			if (STATUS_CHRG_FULL()) {
 				dev_dbg(sharpsl_pm.dev, "Offline Charger: Charge full occured. Retrying to check\n");
 	   			sharpsl_pm.full_count++;
-				CHARGE_OFF();
+				sharpsl_pm.machinfo->charge(0);
 				mdelay(SHARPSL_CHARGE_WAIT_TIME);
-				CHARGE_ON();
+				sharpsl_pm.machinfo->charge(1);
 				return 1;
 			}
 		}
@@ -842,8 +913,8 @@ static int sharpsl_off_charge_battery(vo
 		}
 		if (STATUS_CHRG_FULL()) {
 			dev_dbg(sharpsl_pm.dev, "Offline Charger: Charging complete.\n");
-			CHARGE_LED_OFF();
-			CHARGE_OFF();
+			sharpsl_pm.machinfo->chargeled(SHARPSL_LED_OFF);
+			sharpsl_pm.machinfo->charge(0);
 			sharpsl_pm.charge_mode = CHRG_DONE;
 			return 1;
 		}
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -81,7 +81,7 @@ static void spitz_discharge1(int on)
 
 static void spitz_presuspend(void)
 {
-	spitz_last_ac_status = STATUS_AC_IN();
+	spitz_last_ac_status = sharpsl_pm.machinfo->status_acin();
 
 	/* GPIO Sleep Register */
 	PGSR0 = 0x00144018;
@@ -129,17 +129,18 @@ static void spitz_postsuspend(void)
 static int spitz_should_wakeup(unsigned int resume_on_alarm)
 {
 	int is_resume = 0;
+	int acin = sharpsl_pm.machinfo->status_acin();
 
-	if (spitz_last_ac_status != STATUS_AC_IN()) {
-		if (STATUS_AC_IN()) {
+	if (spitz_last_ac_status != acin) {
+		if (acin) {
 			/* charge on */
 			sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
 			dev_dbg(sharpsl_pm.dev, "AC Inserted\n");
 		} else {
 			/* charge off */
 			dev_dbg(sharpsl_pm.dev, "AC Removed\n");
-			CHARGE_LED_OFF();
-			CHARGE_OFF();
+			sharpsl_pm.machinfo->chargeled(SHARPSL_LED_OFF);
+			sharpsl_pm.machinfo->charge(0);
 			sharpsl_pm.charge_mode = CHRG_OFF;
 		}
 		/* Return to suspend as this must be what we were woken for */

-- 
Thanks, Sharp!
