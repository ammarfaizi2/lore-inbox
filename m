Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSASWDL>; Sat, 19 Jan 2002 17:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSASWA6>; Sat, 19 Jan 2002 17:00:58 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:55812 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287563AbSASV7H>;
	Sat, 19 Jan 2002 16:59:07 -0500
Date: Sat, 19 Jan 2002 16:59:04 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (5/7)
Message-ID: <Pine.LNX.4.33.0201191504230.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.

Description of patch 5:
This patch touches only two files, drivers/ide/qd65xx.c and
drivers/ide/qd65xx.h.  Patch was compile tested but not booted due to lack of
hardware.  This patch adds a fixup for the QDI QD65XX driver.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/drivers/ide/qd65xx.c linux-2.4.18-pre3-ide-rr/drivers/ide/qd65xx.c
--- linux-2.4.18-pre3/drivers/ide/qd65xx.c	Fri Sep  7 12:28:38 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/qd65xx.c	Mon Jan 14 18:29:06 2002
@@ -1,14 +1,15 @@
 /*
- *  linux/drivers/ide/qd65xx.c		Version 0.06	Aug 3, 2000
+ *  linux/drivers/ide/qd65xx.c		Version 0.07	Sep 30, 2001
  *
- *  Copyright (C) 1996-2000  Linus Torvalds & author (see below)
+ *  Copyright (C) 1996-2001  Linus Torvalds & author (see below)
  */

 /*
  *  Version 0.03	Cleaned auto-tune, added probe
  *  Version 0.04	Added second channel tuning
  *  Version 0.05	Enhanced tuning ; added qd6500 support
- *  Version 0.06	added dos driver's list
+ *  Version 0.06	Added dos driver's list
+ *  Version 0.07	Second channel bug fix
  *
  * QDI QD6500/QD6580 EIDE controller fast support
  *
@@ -67,6 +68,7 @@
  *        qd6500: 1100
  *        qd6580: either 1010 or 0101
  *
+ *
  * base+0x02: Timer2 (qd6580 only)
  *
  *
@@ -137,12 +139,12 @@
 {
 	byte active_cycle,recovery_cycle;

-	if (system_bus_clock()<=33) {
-		active_cycle =   9  - IDE_IN(active_time   * system_bus_clock() / 1000 + 1, 2, 9);
-		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_clock() / 1000 + 1, 0, 15);
+	if (ide_system_bus_speed()<=33) {
+		active_cycle =   9  - IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 2, 9);
+		recovery_cycle = 15 - IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 0, 15);
 	} else {
-		active_cycle =   8  - IDE_IN(active_time   * system_bus_clock() / 1000 + 1, 1, 8);
-		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_clock() / 1000 + 1, 3, 18);
+		active_cycle =   8  - IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 1, 8);
+		recovery_cycle = 18 - IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 3, 18);
 	}

 	return((recovery_cycle<<4) | 0x08 | active_cycle);
@@ -156,8 +158,8 @@

 static byte qd6580_compute_timing (int active_time, int recovery_time)
 {
-	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_clock() / 1000 + 1, 2, 17);
-	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_clock() / 1000 + 1, 2, 15);
+	byte active_cycle   = 17-IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 2, 17);
+	byte recovery_cycle = 15-IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 2, 15);

 	return((recovery_cycle<<4) | active_cycle);
 }
@@ -427,7 +429,8 @@
 				ide_hwifs[i].tuneproc = &qd6580_tune_drive;

 				for (j=0;j<2;j++) {
-					ide_hwifs[i].drives[j].drive_data = QD6580_DEF_DATA;
+					ide_hwifs[i].drives[j].drive_data =
+					       i?QD6580_DEF_DATA2:QD6580_DEF_DATA;
 					ide_hwifs[i].drives[j].io_32bit = 1;
 				}
 			}
diff -ruN linux-2.4.18-pre3/drivers/ide/qd65xx.h linux-2.4.18-pre3-ide-rr/drivers/ide/qd65xx.h
--- linux-2.4.18-pre3/drivers/ide/qd65xx.h	Fri Sep  7 12:28:38 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/qd65xx.h	Mon Jan 14 18:29:06 2002
@@ -29,7 +29,7 @@

 #define QD_CONTR_SEC_DISABLED	0x01

-#define QD_ID3			(config & QD_CONFIG_ID3)
+#define QD_ID3			((config & QD_CONFIG_ID3)!=0)

 #define QD_CONFIG(hwif)		((hwif)->config_data & 0x00ff)
 #define QD_CONTROL(hwif)	(((hwif)->config_data & 0xff00) >> 8)
@@ -39,6 +39,7 @@

 #define QD6500_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0c : 0x08))
 #define QD6580_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0a : 0x00))
+#define QD6580_DEF_DATA2	((QD_TIM2_PORT<<8) | (QD_ID3 ? 0x0a : 0x00))
 #define QD_DEF_CONTR		(0x40 | ((control & 0x02) ? 0x9f : 0x1f))

 #define QD_TESTVAL		0x19	/* safe value */



