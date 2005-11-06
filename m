Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVKFVbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVKFVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVKFVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:31:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751050AbVKFVbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:31:15 -0500
Date: Sun, 6 Nov 2005 22:30:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] cleanup spitz battery charging code
Message-ID: <20051106213054.GI29901@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up sharpsl charging code a bit, without really changing
anything. It will probably break compilation on corgi, but few "()"s
should fix that, and those macros are *really* evil.

Please apply... rmk said he prefers sharp patches to go through you. I
hope it is okay with you.

Signed-off-by: Pavel Machek <pavel@suse.cz>


---
commit c2c4df2e9a028895eccc644b45272cba5d40d1a6
tree 9d9d3e51dd34dc72520de5f776a51d0b4dd4ae70
parent 5ca0c6d2dc47d84f33410487ab21878e3fe515f6
author <pavel@amd.(none)> Sun, 06 Nov 2005 22:29:23 +0100
committer <pavel@amd.(none)> Sun, 06 Nov 2005 22:29:23 +0100

 arch/arm/mach-pxa/sharpsl.h    |    8 +++---
 arch/arm/mach-pxa/sharpsl_pm.c |   54 ++++++++++++++++++++--------------------
 arch/arm/mach-pxa/spitz_pm.c   |    6 ++--
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
--- a/arch/arm/mach-pxa/sharpsl.h
+++ b/arch/arm/mach-pxa/sharpsl.h
@@ -115,7 +115,7 @@ extern struct battery_thresh spitz_batte
 #define CHARGE_LED_ERR()    sharpsl_pm.machinfo->chargeled(SHARPSL_LED_ERROR)
 #define DISCHARGE_ON()      sharpsl_pm.machinfo->discharge(1)
 #define DISCHARGE_OFF()     sharpsl_pm.machinfo->discharge(0)
-#define STATUS_AC_IN        sharpsl_pm.machinfo->status_acin()
-#define STATUS_BATT_LOCKED  READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock)
-#define STATUS_CHRG_FULL    READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull)
-#define STATUS_FATAL        READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal)
+#define STATUS_AC_IN()      sharpsl_pm.machinfo->status_acin()
+#define STATUS_BATT_LOCKED() READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock)
+#define STATUS_CHRG_FULL()  READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull)
+#define STATUS_FATAL()      READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal)
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -45,15 +45,15 @@
 #define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
 #define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
 #define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_JKVAD  10  /* 10 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN  10  /* 10 msec */
 #define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
 #define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
 #define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
 
 #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
 #define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
-#define SHARPSL_CHARGE_ON_JKVAD_HIGH   0x9b  /* 6V */
-#define SHARPSL_CHARGE_ON_JKVAD_LOW    0x34  /* 2V */
+#define SHARPSL_CHARGE_ON_ACIN_HIGH   0x9b  /* 6V */
+#define SHARPSL_CHARGE_ON_ACIN_LOW    0x34  /* 2V */
 #define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
 #define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
 
@@ -160,7 +160,7 @@ struct battery_thresh  spitz_battery_lev
 /*
  * Prototypes
  */
-static int sharpsl_read_MainBattery(void);
+static int sharpsl_read_main_battery(void);
 static int sharpsl_off_charge_battery(void);
 static int sharpsl_check_battery(int mode);
 static int sharpsl_ac_check(void);
@@ -228,7 +228,7 @@ static void sharpsl_battery_thread(void 
 	if (!sharpsl_pm.machinfo)
 		return;
 
-	sharpsl_pm.battstat.ac_status = (!(STATUS_AC_IN) ? APM_AC_OFFLINE : APM_AC_ONLINE);
+	sharpsl_pm.battstat.ac_status = (STATUS_AC_IN() ? APM_AC_ONLINE : APM_AC_OFFLINE);
 
 	/* Corgi cannot confirm when battery fully charged so periodically kick! */
 	if (machine_is_corgi() && (sharpsl_pm.charge_mode == CHRG_ON)
@@ -236,7 +236,7 @@ static void sharpsl_battery_thread(void 
 		schedule_work(&toggle_charger);
 
 	while(1) {
-		voltage = sharpsl_read_MainBattery();
+		voltage = sharpsl_read_main_battery();
 		if (voltage > 0) break;
 		if (i++ > 5) {
 			voltage = sharpsl_pm.machinfo->bat_levels_noac[0].voltage;
@@ -317,7 +317,7 @@ static void sharpsl_charge_toggle(void *
 {
 	dev_dbg(sharpsl_pm.dev, "Toogling Charger at time: %lx\n", jiffies);
 
-	if (STATUS_AC_IN == 0) {
+	if (STATUS_AC_IN() == 0) {
 		sharpsl_charge_off();
 		return;
 	} else if ((sharpsl_check_battery(1) < 0) || (sharpsl_ac_check() < 0)) {
@@ -335,7 +335,7 @@ static void sharpsl_charge_toggle(void *
 
 static void sharpsl_ac_timer(unsigned long data)
 {
-	int acin = STATUS_AC_IN;
+	int acin = STATUS_AC_IN();
 
 	dev_dbg(sharpsl_pm.dev, "AC Status: %d\n",acin);
 
@@ -364,7 +364,7 @@ static void sharpsl_chrg_full_timer(unsi
 
 	sharpsl_pm.full_count++;
 
-	if (STATUS_AC_IN == 0) {
+	if (STATUS_AC_IN() == 0) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
 		if (sharpsl_pm.charge_mode == CHRG_ON)
 			sharpsl_charge_off();
@@ -399,12 +399,12 @@ static irqreturn_t sharpsl_fatal_isr(int
 {
 	int is_fatal = 0;
 
-	if (STATUS_BATT_LOCKED == 0) {
+	if (STATUS_BATT_LOCKED() == 0) {
 		dev_err(sharpsl_pm.dev, "Battery now Unlocked! Suspending.\n");
 		is_fatal = 1;
 	}
 
-	if (sharpsl_pm.machinfo->gpio_fatal && (STATUS_FATAL == 0)) {
+	if (sharpsl_pm.machinfo->gpio_fatal && (STATUS_FATAL() == 0)) {
 		dev_err(sharpsl_pm.dev, "Fatal Batt Error! Suspending.\n");
 		is_fatal = 1;
 	}
@@ -461,15 +461,16 @@ static int read_max1111(int channel)
 			| MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
 }
 
-static int sharpsl_read_MainBattery(void)
+static int sharpsl_read_main_battery(void)
 {
 	return read_max1111(BATT_AD);
 }
 
-static int sharpsl_read_Temp(void)
+static int sharpsl_read_temp(void)
 {
 	int temp;
 
+	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
 	sharpsl_pm.machinfo->measure_temp(1);
 
 	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
@@ -480,7 +481,7 @@ static int sharpsl_read_Temp(void)
 	return temp;
 }
 
-static int sharpsl_read_jkvad(void)
+static int sharpsl_read_acin(void)
 {
 	return read_max1111(JK_VAD);
 }
@@ -530,8 +531,7 @@ static int sharpsl_check_battery(int mod
 
 	/* Check battery temperature */
 	for (i=0; i<5; i++) {
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
-		buff[i] = sharpsl_read_Temp();
+		buff[i] = sharpsl_read_temp();
 	}
 
 	val = get_select_val(buff);
@@ -552,7 +552,7 @@ static int sharpsl_check_battery(int mod
 
 	/* Check battery voltage */
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_MainBattery();
+		buff[i] = sharpsl_read_main_battery();
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
 	}
 
@@ -575,14 +575,14 @@ static int sharpsl_ac_check(void)
 	int temp, i, buff[5];
 
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_jkvad();
-		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_JKVAD);
+		buff[i] = sharpsl_read_acin();
+		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
 	}
 
 	temp = get_select_val(buff);
 	dev_dbg(sharpsl_pm.dev, "AC Voltage: %d\n",temp);
 
-	if ((temp > SHARPSL_CHARGE_ON_JKVAD_HIGH) || (temp < SHARPSL_CHARGE_ON_JKVAD_LOW)) {
+	if ((temp > SHARPSL_CHARGE_ON_ACIN_HIGH) || (temp < SHARPSL_CHARGE_ON_ACIN_LOW)) {
 		dev_err(sharpsl_pm.dev, "Error: AC check failed.\n");
 		return -1;
 	}
@@ -622,7 +622,7 @@ static void corgi_goto_sleep(unsigned lo
 	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n",sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
 	/* not charging and AC-IN! */
 
-	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (STATUS_AC_IN != 0)) {
+	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (STATUS_AC_IN() != 0)) {
 		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
 		sharpsl_pm.charge_mode = CHRG_OFF;
 		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
@@ -671,7 +671,7 @@ static int corgi_enter_suspend(unsigned 
 		dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
 	}
 
-	if ((STATUS_BATT_LOCKED == 0) || (sharpsl_fatal_check() < 0) )
+	if ((STATUS_BATT_LOCKED() == 0) || (sharpsl_fatal_check() < 0) )
 	{
 		dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
 		corgi_goto_sleep(alarm_time, alarm_enable, state);
@@ -711,7 +711,7 @@ static int sharpsl_fatal_check(void)
 	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check entered\n");
 
 	/* Check AC-Adapter */
-	acin = STATUS_AC_IN;
+	acin = STATUS_AC_IN();
 
 	if (acin && (sharpsl_pm.charge_mode == CHRG_ON)) {
 		CHARGE_OFF();
@@ -725,7 +725,7 @@ static int sharpsl_fatal_check(void)
 
 	/* Check battery : check inserting battery ? */
 	for (i=0; i<5; i++) {
-		buff[i] = sharpsl_read_MainBattery();
+		buff[i] = sharpsl_read_main_battery();
 		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
 	}
 
@@ -739,7 +739,7 @@ static int sharpsl_fatal_check(void)
 	}
 
 	temp = get_select_val(buff);
-	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_read_MainBattery());
+	dev_dbg(sharpsl_pm.dev, "sharpsl_fatal_check: acin: %d, discharge voltage: %d, no discharge: %d\n", acin, temp, sharpsl_read_main_battery());
 
 	if ((acin && (temp < SHARPSL_FATAL_ACIN_VOLT)) ||
 			(!acin && (temp < SHARPSL_FATAL_NOACIN_VOLT)))
@@ -811,7 +811,7 @@ static int sharpsl_off_charge_battery(vo
 			/* Check for timeout */
 			if ((RCNR - time) > SHARPSL_WAIT_CO_TIME)
 				return 1;
-			if (STATUS_CHRG_FULL) {
+			if (STATUS_CHRG_FULL()) {
 				dev_dbg(sharpsl_pm.dev, "Offline Charger: Charge full occured. Retrying to check\n");
 	   			sharpsl_pm.full_count++;
 				CHARGE_OFF();
@@ -840,7 +840,7 @@ static int sharpsl_off_charge_battery(vo
 			sharpsl_pm.full_count++;
 			return 1;
 		}
-		if (STATUS_CHRG_FULL) {
+		if (STATUS_CHRG_FULL()) {
 			dev_dbg(sharpsl_pm.dev, "Offline Charger: Charging complete.\n");
 			CHARGE_LED_OFF();
 			CHARGE_OFF();
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -81,7 +81,7 @@ static void spitz_discharge1(int on)
 
 static void spitz_presuspend(void)
 {
-	spitz_last_ac_status = STATUS_AC_IN;
+	spitz_last_ac_status = STATUS_AC_IN();
 
 	/* GPIO Sleep Register */
 	PGSR0 = 0x00144018;
@@ -130,8 +130,8 @@ static int spitz_should_wakeup(unsigned 
 {
 	int is_resume = 0;
 
-	if (spitz_last_ac_status != STATUS_AC_IN) {
-		if (STATUS_AC_IN) {
+	if (spitz_last_ac_status != STATUS_AC_IN()) {
+		if (STATUS_AC_IN()) {
 			/* charge on */
 			sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
 			dev_dbg(sharpsl_pm.dev, "AC Inserted\n");




-- 
Thanks, Sharp!
