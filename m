Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbRBTRT3>; Tue, 20 Feb 2001 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130114AbRBTRTU>; Tue, 20 Feb 2001 12:19:20 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:59250 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129997AbRBTRTD>; Tue, 20 Feb 2001 12:19:03 -0500
Date: Tue, 20 Feb 2001 11:18:33 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: linux-kernel@vger.kernel.org, David Weinehall <tao@acc.umu.se>
Subject: [PATCH] (2.0) make softdog/hardware watchdog in same box work
Message-ID: <Pine.LNX.3.96.1010220111056.9350G-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While misc_register() semantics are different in 2.0 from 2.[24], and the
2.[24] code would actually work in 2.0, the 2.0 code doesn't.

This fixes (I think) the case where you have softdog and a hardware
watchdog driver on the same box (and obviously want to use the hardware
watchdog).

diff -ur linux/drivers/char/misc.c linux-prumpf/drivers/char/misc.c
--- linux/drivers/char/misc.c	Thu Jun  4 00:17:47 1998
+++ linux-prumpf/drivers/char/misc.c	Tue Feb 20 18:05:46 2001
@@ -220,14 +220,17 @@
 #ifdef CONFIG_SUN_MOUSE
 	sun_mouse_init();
 #endif
-#ifdef CONFIG_SOFT_WATCHDOG
-	watchdog_init();
-#endif
+	/* In 2.0, only the first misc_register() is significant for each
+	 * minor.  So we load the hardware watchdog drivers first, then the
+	 * softdog driver. */
 #ifdef CONFIG_WDT
 	wdt_init();
 #endif
 #ifdef CONFIG_PCWATCHDOG
 	pcwatchdog_init();
+#endif
+#ifdef CONFIG_SOFT_WATCHDOG
+	watchdog_init();
 #endif
 #ifdef CONFIG_APM
 	apm_bios_init();

