Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbTC3Wvw>; Sun, 30 Mar 2003 17:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbTC3Wvw>; Sun, 30 Mar 2003 17:51:52 -0500
Received: from dp.samba.org ([66.70.73.150]:45246 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261306AbTC3Wvv>;
	Sun, 30 Mar 2003 17:51:51 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16007.29579.680218.567708@nanango.paulus.ozlabs.org>
Date: Mon, 31 Mar 2003 08:45:31 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] update apm emulation for mac
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the battery charge calculations for powerbooks.
This is Ben Herrenschmidt's work.

Please apply.

Paul.

diff -urN linux-2.5/drivers/macintosh/apm_emu.c linuxppc-2.5/drivers/macintosh/apm_emu.c
--- linux-2.5/drivers/macintosh/apm_emu.c	2003-01-08 23:03:45.000000000 +1100
+++ linuxppc-2.5/drivers/macintosh/apm_emu.c	2003-02-03 08:51:33.000000000 +1100
@@ -436,40 +436,40 @@
 	int		percentage     = -1;
 	int             time_units     = -1;
 	int		real_count     = 0;
-	int		charge         = -1;
-	int		current        = 0;
 	int		i;
 	char *		p = buf;
 	char		charging       = 0;
+	long		charge	       = -1;
+	long		current        = 0;
+	unsigned long	btype          = 0;
 
 	ac_line_status = ((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0);
 	for (i=0; i<pmu_battery_count; i++) {
-		if (percentage < 0)
-			percentage = 0;
-		if (charge < 0)
-			charge = 0;
 		if (pmu_batteries[i].flags & PMU_BATT_PRESENT) {
+			if (percentage < 0)
+				percentage = 0;
+			if (charge < 0)
+				charge = 0;
 			percentage += (pmu_batteries[i].charge * 100) /
 				pmu_batteries[i].max_charge;
-			/* hrm... should we provide the remaining charge
-			 * time when AC is plugged ? If yes, just remove
-			 * that test --BenH
-			 */
-			if (!ac_line_status) {
-				charge += pmu_batteries[i].charge;
-				current += pmu_batteries[i].current;
-			}
+			charge += pmu_batteries[i].charge;
+			current += pmu_batteries[i].current;
+			if (btype == 0)
+				btype = (pmu_batteries[i].flags & PMU_BATT_TYPE_MASK);
 			real_count++;
 			if ((pmu_batteries[i].flags & PMU_BATT_CHARGING))
 				charging++;
 		}
 	}
 	if (real_count) {
-		time_units = (charge * 59) / (current * -1);
-		if(!charging)
-			battery_flag &= ~0x08;
+		if (current < 0) {
+			if (btype == PMU_BATT_TYPE_SMART)
+				time_units = (charge * 59) / (current * -1);
+			else
+				time_units = (charge * 16440) / (current * -60);
+		}
 		percentage /= real_count;
-		if (battery_flag & 0x08) {
+		if (charging > 0) {
 			battery_status = 0x03;
 			battery_flag = 0x08;
 		} else if (percentage <= APM_CRITICAL) {
