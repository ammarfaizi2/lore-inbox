Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUJIUOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUJIUOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUJIUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:14:14 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:36522 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267361AbUJIULu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:11:50 -0400
Subject: [PATCH]: pbook apm_emu.c fix remaining time when charging
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-jXnjhupzySYHF1yimsk1"
Date: Sat, 09 Oct 2004 22:11:40 +0200
Message-Id: <1097352701.3483.12.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jXnjhupzySYHF1yimsk1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

this should make /proc/apm 

a) display the remaining time until the battery is fully charged and
b) when the system is on AC but the battery is not getting charged 0 is
displayed as remaining time.

Please comment/apply,
Soeren
-- 
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety." Benjamin Franklin

--=-jXnjhupzySYHF1yimsk1
Content-Disposition: attachment; filename=apm_emu_fix.diff
Content-Type: text/x-patch; name=apm_emu_fix.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- t/linux-2.6.9-rc3/drivers/macintosh/apm_emu.c	2004-09-30 05:05:41.000000000 +0200
+++ linux-2.6.9-rc3-sonne/drivers/macintosh/apm_emu.c	2004-10-09 21:32:30.000000000 +0200
@@ -440,6 +440,7 @@
 	char *		p = buf;
 	char		charging       = 0;
 	long		charge	       = -1;
+	long		max_charge	   = -1;
 	long		amperage       = 0;
 	unsigned long	btype          = 0;
 
@@ -450,9 +451,12 @@
 				percentage = 0;
 			if (charge < 0)
 				charge = 0;
+			if (max_charge < 0)
+				max_charge = 0;
 			percentage += (pmu_batteries[i].charge * 100) /
 				pmu_batteries[i].max_charge;
 			charge += pmu_batteries[i].charge;
+			max_charge += pmu_batteries[i].max_charge;
 			amperage += pmu_batteries[i].amperage;
 			if (btype == 0)
 				btype = (pmu_batteries[i].flags & PMU_BATT_TYPE_MASK);
@@ -461,13 +465,27 @@
 				charging++;
 		}
 	}
+
 	if (real_count) {
 		if (amperage < 0) {
+			/* when less than 100mA are used the machine must be on AC and as it is 
+			   not charging the battery is only slightly self decharging and thus full be definition */
+			if (amperage < 100) {
+				if (btype == PMU_BATT_TYPE_SMART)
+					time_units = (charge * 59) / (amperage * -1);
+				else
+					time_units = (charge * 16440) / (amperage * -60);
+			}
+			else
+				time_units = 0;
+		}
+		else if (amperage >0 && max_charge>=charge) {
 			if (btype == PMU_BATT_TYPE_SMART)
-				time_units = (charge * 59) / (amperage * -1);
+				time_units = ( (max_charge - charge) * 59) / amperage;
 			else
-				time_units = (charge * 16440) / (amperage * -60);
+				time_units = ( (max_charge - charge) * 16440) / amperage;
 		}
+
 		percentage /= real_count;
 		if (charging > 0) {
 			battery_status = 0x03;
@@ -483,6 +501,7 @@
 			battery_flag = 0x01;
 		}
 	}
+
 	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
 		     (FAKE_APM_BIOS_VERSION >> 8) & 0xff,

--=-jXnjhupzySYHF1yimsk1--

