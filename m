Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWGGLsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWGGLsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGGLsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:48:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19875 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751159AbWGGLsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:48:32 -0400
Date: Fri, 7 Jul 2006 13:48:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Subject: [patch] sharpsl_pm refactor
Message-ID: <20060707114818.GA5423@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares sharpsl_pm.c for collie. Without nested if()s, #ifdefs
can be added. Also warn users about charging in unsuitable
temperature.

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.18-rc1-git

diff --git a/arch/arm/common/sharpsl_pm.c b/arch/arm/common/sharpsl_pm.c
index 045e37e..12beac3 100644
--- a/arch/arm/common/sharpsl_pm.c
+++ b/arch/arm/common/sharpsl_pm.c
@@ -276,13 +284,19 @@ static void sharpsl_chrg_full_timer(unsi
 		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
 		if (sharpsl_pm.charge_mode == CHRG_ON)
 			sharpsl_charge_off();
-	} else if (sharpsl_pm.full_count < 2) {
+		return;
+	} 
+	if (sharpsl_pm.full_count < 2) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
 		schedule_work(&toggle_charger);
-	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
+		return;
+	} 
+	if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
 		schedule_work(&toggle_charger);
-	} else {
+		return;
+	}
+	{
 		sharpsl_charge_off();
 		sharpsl_pm.charge_mode = CHRG_DONE;
 		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
@@ -412,8 +429,10 @@ static int sharpsl_check_battery_temp(vo
 	val = get_select_val(buff);
 
 	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > sharpsl_pm.machinfo->charge_on_temp)
+	if (val > sharpsl_pm.machinfo->charge_on_temp) {
+		printk(KERN_WARNING "Not charging: temperature out of limits.\n"); 
 		return -1;
+	}
 
 	return 0;
 }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
