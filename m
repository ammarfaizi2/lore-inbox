Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUBUGhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 01:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUBUGhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 01:37:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:56748 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261518AbUBUGhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 01:37:04 -0500
Subject: [PATCH] Remove use of "current" identifier in via-pmu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402210625.i1L6PQE25691@mail.osdl.org>
References: <200402210625.i1L6PQE25691@mail.osdl.org>
Content-Type: text/plain
Message-Id: <1077345060.860.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 17:31:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew spotted this one, here's the fix:

Remove usage of "current" as a variable name and structure member
in the battery management code of PowerMac via-pmu and apm-emu
drivers

diff -urN linux-2.5/drivers/macintosh/apm_emu.c linuxppc-2.5-benh/drivers/macintosh/apm_emu.c
--- linux-2.5/drivers/macintosh/apm_emu.c	2004-02-20 11:26:58.000000000 +1100
+++ linuxppc-2.5-benh/drivers/macintosh/apm_emu.c	2004-02-21 17:26:35.777953160 +1100
@@ -440,7 +440,7 @@
 	char *		p = buf;
 	char		charging       = 0;
 	long		charge	       = -1;
-	long		current        = 0;
+	long		amperage       = 0;
 	unsigned long	btype          = 0;
 
 	ac_line_status = ((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0);
@@ -453,7 +453,7 @@
 			percentage += (pmu_batteries[i].charge * 100) /
 				pmu_batteries[i].max_charge;
 			charge += pmu_batteries[i].charge;
-			current += pmu_batteries[i].current;
+			amperage += pmu_batteries[i].amperage;
 			if (btype == 0)
 				btype = (pmu_batteries[i].flags & PMU_BATT_TYPE_MASK);
 			real_count++;
@@ -462,11 +462,11 @@
 		}
 	}
 	if (real_count) {
-		if (current < 0) {
+		if (amperage < 0) {
 			if (btype == PMU_BATT_TYPE_SMART)
-				time_units = (charge * 59) / (current * -1);
+				time_units = (charge * 59) / (amperage * -1);
 			else
-				time_units = (charge * 16440) / (current * -60);
+				time_units = (charge * 16440) / (amperage * -60);
 		}
 		percentage /= real_count;
 		if (charging > 0) {
diff -urN linux-2.5/drivers/macintosh/via-pmu.c linuxppc-2.5-benh/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2004-02-20 11:26:58.000000000 +1100
+++ linuxppc-2.5-benh/drivers/macintosh/via-pmu.c	2004-02-21 17:24:22.629194848 +1100
@@ -649,7 +649,7 @@
 	unsigned int bat_flags = PMU_BATT_TYPE_HOOPER;
 	long pcharge, charge, vb, vmax, lmax;
 	long vmax_charging, vmax_charged;
-	long current, voltage, time, max;
+	long amperage, voltage, time, max;
 	int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
 			NULL, PMAC_MB_INFO_MODEL, 0);
 
@@ -676,10 +676,10 @@
 			bat_flags |= PMU_BATT_CHARGING;
 		vb = (req->reply[1] << 8) | req->reply[2];
 		voltage = (vb * 265 + 72665) / 10;
-		current = req->reply[5];
+		amperage = req->reply[5];
 		if ((req->reply[0] & 0x01) == 0) {
-			if (current > 200)
-				vb += ((current - 200) * 15)/100;
+			if (amperage > 200)
+				vb += ((amperage - 200) * 15)/100;
 		} else if (req->reply[0] & 0x02) {
 			vb = (vb * 97) / 100;
 			vmax = vmax_charging;
@@ -694,19 +694,19 @@
 			if (pcharge < charge)
 				charge = pcharge;
 		}
-		if (current > 0)
-			time = (charge * 16440) / current;
+		if (amperage > 0)
+			time = (charge * 16440) / amperage;
 		else
 			time = 0;
 		max = 100;
-		current = -current;
+		amperage = -amperage;
 	} else
-		charge = max = current = voltage = time = 0;
+		charge = max = amperage = voltage = time = 0;
 
 	pmu_batteries[pmu_cur_battery].flags = bat_flags;
 	pmu_batteries[pmu_cur_battery].charge = charge;
 	pmu_batteries[pmu_cur_battery].max_charge = max;
-	pmu_batteries[pmu_cur_battery].current = current;
+	pmu_batteries[pmu_cur_battery].amperage = amperage;
 	pmu_batteries[pmu_cur_battery].voltage = voltage;
 	pmu_batteries[pmu_cur_battery].time_remaining = time;
 }
@@ -734,7 +734,7 @@
 	 */
 	 
 	unsigned int bat_flags = PMU_BATT_TYPE_SMART;
-	int current;
+	int amperage;
 	unsigned int capa, max, voltage;
 	
 	if (req->reply[1] & 0x01)
@@ -749,12 +749,12 @@
 			case 3:
 			case 4: capa = req->reply[2];
 				max = req->reply[3];
-				current = *((signed char *)&req->reply[4]);
+				amperage = *((signed char *)&req->reply[4]);
 				voltage = req->reply[5];
 				break;
 			case 5: capa = (req->reply[2] << 8) | req->reply[3];
 				max = (req->reply[4] << 8) | req->reply[5];
-				current = *((signed short *)&req->reply[6]);
+				amperage = *((signed short *)&req->reply[6]);
 				voltage = (req->reply[8] << 8) | req->reply[9];
 				break;
 			default:
@@ -763,23 +763,23 @@
 				break;
 		}
 	} else
-		capa = max = current = voltage = 0;
+		capa = max = amperage = voltage = 0;
 
-	if ((req->reply[1] & 0x01) && (current > 0))
+	if ((req->reply[1] & 0x01) && (amperage > 0))
 		bat_flags |= PMU_BATT_CHARGING;
 
 	pmu_batteries[pmu_cur_battery].flags = bat_flags;
 	pmu_batteries[pmu_cur_battery].charge = capa;
 	pmu_batteries[pmu_cur_battery].max_charge = max;
-	pmu_batteries[pmu_cur_battery].current = current;
+	pmu_batteries[pmu_cur_battery].amperage = amperage;
 	pmu_batteries[pmu_cur_battery].voltage = voltage;
-	if (current) {
-		if ((req->reply[1] & 0x01) && (current > 0))
+	if (amperage) {
+		if ((req->reply[1] & 0x01) && (amperage > 0))
 			pmu_batteries[pmu_cur_battery].time_remaining
-				= ((max-capa) * 3600) / current;
+				= ((max-capa) * 3600) / amperage;
 		else
 			pmu_batteries[pmu_cur_battery].time_remaining
-				= (capa * 3600) / (-current);
+				= (capa * 3600) / (-amperage);
 	} else
 		pmu_batteries[pmu_cur_battery].time_remaining = 0;
 
@@ -861,7 +861,7 @@
 	p += sprintf(p, "max_charge : %d\n",
 		pmu_batteries[batnum].max_charge);
 	p += sprintf(p, "current    : %d\n",
-		pmu_batteries[batnum].current);
+		pmu_batteries[batnum].amperage);
 	p += sprintf(p, "voltage    : %d\n",
 		pmu_batteries[batnum].voltage);
 	p += sprintf(p, "time rem.  : %d\n",
diff -urN linux-2.5/include/linux/pmu.h linuxppc-2.5-benh/include/linux/pmu.h
--- linux-2.5/include/linux/pmu.h	2004-02-20 11:29:03.000000000 +1100
+++ linuxppc-2.5-benh/include/linux/pmu.h	2004-02-21 17:24:22.030285896 +1100
@@ -226,7 +226,7 @@
 	unsigned int	flags;
 	unsigned int	charge;		/* current charge */
 	unsigned int	max_charge;	/* maximum charge */
-	signed int	current;	/* current, positive if charging */
+	signed int	amperage;	/* current, positive if charging */
 	unsigned int	voltage;	/* voltage */
 	unsigned int	time_remaining;	/* remaining time */
 };


