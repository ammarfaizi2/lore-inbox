Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267073AbTGROEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271783AbTGRODG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:03:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15493
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266555AbTGRNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:55:43 -0400
Date: Fri, 18 Jul 2003 15:10:03 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181410.h6IEA3jp017696@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: move watchdogs to __module_get now it exists
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Jan Dittmer)

Also add the 82801EB/ER 	(Wim Van Sebroeck)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/acquirewdt.c linux-2.6.0-test1-ac2/drivers/char/watchdog/acquirewdt.c
--- linux-2.6.0-test1/drivers/char/watchdog/acquirewdt.c	2003-07-10 21:11:36.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/acquirewdt.c	2003-07-14 14:48:04.000000000 +0100
@@ -143,7 +143,7 @@
 			return -EBUSY;
 		}
 		if (nowayout)
-			MOD_INC_USE_COUNT;
+			__module_get(THIS_MODULE);
 
 		/* Activate */
 		acq_is_open=1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/i810-tco.c linux-2.6.0-test1-ac2/drivers/char/watchdog/i810-tco.c
--- linux-2.6.0-test1/drivers/char/watchdog/i810-tco.c	2003-07-10 21:04:08.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/i810-tco.c	2003-07-14 14:58:02.000000000 +0100
@@ -25,7 +25,8 @@
  *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
  *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
  *	82801CA & 82801CAM chip : document number 290716-001, 290718-001,
- *	82801DB & 82801E   chip : document number 290744-001, 273599-001
+ *	82801DB & 82801E   chip : document number 290744-001, 273599-001,
+ *	82801EB & 82801ER  chip : document number 252516-001
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
@@ -42,9 +43,11 @@
  *	     clean up ioctls (WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and
  *	     WDIOC_SETOPTIONS), made i810tco_getdevice __init,
  *	     removed boot_status, removed tco_timer_read,
- *	     added support for 82801DB and 82801E chipset, general cleanup.
+ *	     added support for 82801DB and 82801E chipset,
+ *	     added support for 82801EB and 8280ER chipset,
+ *	     general cleanup.
  */
- 
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -164,7 +167,7 @@
  * Reload (trigger) the timer. Lock is needed so we don't reload it during
  * a reprogramming event
  */
- 
+
 static void tco_timer_reload (void)
 {
 	spin_lock(&tco_lock);
@@ -307,6 +310,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/i810-tco.h linux-2.6.0-test1-ac2/drivers/char/watchdog/i810-tco.h
--- linux-2.6.0-test1/drivers/char/watchdog/i810-tco.h	2003-07-10 21:12:20.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/i810-tco.h	2003-07-14 14:58:09.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
+ *	i810-tco:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -8,7 +8,7 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
+ *
  *	Neither kernel concepts nor Nils Faerber admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/ib700wdt.c linux-2.6.0-test1-ac2/drivers/char/watchdog/ib700wdt.c
--- linux-2.6.0-test1/drivers/char/watchdog/ib700wdt.c	2003-07-10 21:14:20.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/ib700wdt.c	2003-07-14 14:48:04.000000000 +0100
@@ -230,7 +230,7 @@
 			return -EBUSY;
 		}
 		if (nowayout)
-			MOD_INC_USE_COUNT;
+			__module_get(THIS_MODULE);
 
 		/* Activate */
 		ibwdt_is_open = 1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/indydog.c linux-2.6.0-test1-ac2/drivers/char/watchdog/indydog.c
--- linux-2.6.0-test1/drivers/char/watchdog/indydog.c	2003-07-10 21:14:50.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/indydog.c	2003-07-14 14:48:04.000000000 +0100
@@ -54,7 +54,7 @@
 		return -EBUSY;
 
 	if (nowayout)
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 
 	/*
 	 *	Activate timer
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/machzwd.c linux-2.6.0-test1-ac2/drivers/char/watchdog/machzwd.c
--- linux-2.6.0-test1/drivers/char/watchdog/machzwd.c	2003-07-10 21:05:39.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/machzwd.c	2003-07-14 14:48:04.000000000 +0100
@@ -392,7 +392,7 @@
 			}
 
 			if (nowayout)
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 
 			zf_is_open = 1;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/pcwd.c linux-2.6.0-test1-ac2/drivers/char/watchdog/pcwd.c
--- linux-2.6.0-test1/drivers/char/watchdog/pcwd.c	2003-07-10 21:04:53.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/pcwd.c	2003-07-14 14:48:04.000000000 +0100
@@ -431,7 +431,7 @@
 			atomic_inc( &open_allowed );
 			return -EBUSY;
 		}
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 		/*  Enable the port  */
 		if (revision == PCWD_REVISION_C) {
 			spin_lock(&io_lock);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/sbc60xxwdt.c linux-2.6.0-test1-ac2/drivers/char/watchdog/sbc60xxwdt.c
--- linux-2.6.0-test1/drivers/char/watchdog/sbc60xxwdt.c	2003-07-10 21:12:20.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/sbc60xxwdt.c	2003-07-14 14:48:04.000000000 +0100
@@ -207,9 +207,8 @@
 			/* Just in case we're already talking to someone... */
 			if(wdt_is_open)
 				return -EBUSY;
-			if (nowayout) {
-				MOD_INC_USE_COUNT;
-			}
+			if (nowayout) 
+				__module_get(THIS_MODULE);
 			/* Good, fire up the show */
 			wdt_is_open = 1;
 			wdt_startup();
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/sc520_wdt.c linux-2.6.0-test1-ac2/drivers/char/watchdog/sc520_wdt.c
--- linux-2.6.0-test1/drivers/char/watchdog/sc520_wdt.c	2003-07-10 21:09:00.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/sc520_wdt.c	2003-07-14 14:48:04.000000000 +0100
@@ -231,7 +231,7 @@
 			/* Good, fire up the show */
 			wdt_startup();
 			if (nowayout)
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 
 			return 0;
 		default:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/shwdt.c linux-2.6.0-test1-ac2/drivers/char/watchdog/shwdt.c
--- linux-2.6.0-test1/drivers/char/watchdog/shwdt.c	2003-07-10 21:06:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/shwdt.c	2003-07-14 14:48:04.000000000 +0100
@@ -189,9 +189,8 @@
 			if (test_and_set_bit(0, &sh_is_open))
 				return -EBUSY;
 
-			if (nowayout) {
-				MOD_INC_USE_COUNT;
-			}
+			if (nowayout) 
+				__module_get(THIS_MODULE);
 
 			sh_wdt_start();
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/softdog.c linux-2.6.0-test1-ac2/drivers/char/watchdog/softdog.c
--- linux-2.6.0-test1/drivers/char/watchdog/softdog.c	2003-07-10 21:08:26.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/softdog.c	2003-07-14 14:48:04.000000000 +0100
@@ -104,9 +104,8 @@
 {
 	if(test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
-	if (nowayout) {
-		MOD_INC_USE_COUNT;
-	}
+	if (nowayout) 
+		__module_get(THIS_MODULE);
 	/*
 	 *	Activate timer
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/wdt977.c linux-2.6.0-test1-ac2/drivers/char/watchdog/wdt977.c
--- linux-2.6.0-test1/drivers/char/watchdog/wdt977.c	2003-07-10 21:13:04.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/wdt977.c	2003-07-14 14:48:04.000000000 +0100
@@ -99,7 +99,7 @@
 
 	if (nowayout)
 	{
-		MOD_INC_USE_COUNT;
+		__module_get(THIS_MODULE);
 
 		/* do not permit disabling the watchdog by writing 0 to reg. 0xF2 */
 		if (!timeoutM) timeoutM = DEFAULT_TIMEOUT;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/char/watchdog/wdt_pci.c linux-2.6.0-test1-ac2/drivers/char/watchdog/wdt_pci.c
--- linux-2.6.0-test1/drivers/char/watchdog/wdt_pci.c	2003-07-10 21:12:08.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/char/watchdog/wdt_pci.c	2003-07-14 14:48:04.000000000 +0100
@@ -367,7 +367,7 @@
 				return -EBUSY;
 
 			if (nowayout) {
-				MOD_INC_USE_COUNT;
+				__module_get(THIS_MODULE);
 			}
 			/*
 			 *	Activate 
