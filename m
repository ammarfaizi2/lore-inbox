Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbRBTRGt>; Tue, 20 Feb 2001 12:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRBTRGj>; Tue, 20 Feb 2001 12:06:39 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:9314 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129253AbRBTRGV>; Tue, 20 Feb 2001 12:06:21 -0500
Date: Tue, 20 Feb 2001 11:06:19 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] make softdog/hardware watchdog in same box work
Message-ID: <Pine.LNX.3.96.1010220110121.9350F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

misc_register() overrides misc devices with the same minor that have been
registered earlier, so if you enable both softdog and a hardware watchdog
the current initialization order will leave you with softdog only.

Should be fixed by (untested, 2.2):

diff -ur linux/drivers/char/misc.c linux-prumpf/drivers/char/misc.c
--- linux/drivers/char/misc.c	Mon Dec 11 01:49:42 2000
+++ linux-prumpf/drivers/char/misc.c	Tue Feb 20 17:49:30 2001
@@ -216,11 +216,15 @@
 	pc110pad_init();
 #endif
 /*
- *	Only one watchdog can succeed. We probe the pcwatchdog first,
- *	then the wdt cards and finally the software watchdog which always
- *	works. This means if your hardware watchdog dies or is 'borrowed'
- *	for some reason the software watchdog still gives you some cover.
+ *	Only one watchdog can succeed. We probe the software watchdog first,
+ *	then the hardware watchdogs which can override softdog if you have
+ *	both configured.  This means if your hardware watchdog dies or is
+ *	'borrowed' for some reason the software watchdog still gives you
+ *	some cover.
  */
+#ifdef CONFIG_SOFT_WATCHDOG
+	watchdog_init();
+#endif
 #ifdef CONFIG_PCWATCHDOG
 	pcwatchdog_init();
 #endif
@@ -232,9 +236,6 @@
 #endif
 #ifdef CONFIG_60XX_WDT
 	sbc60xxwdt_init();
-#endif
-#ifdef CONFIG_SOFT_WATCHDOG
-	watchdog_init();
 #endif
 #ifdef CONFIG_DTLK
 	dtlk_init();

and (untested, 2.4):

diff -ur linux/drivers/char/Makefile linux-prumpf/drivers/char/Makefile
--- linux/drivers/char/Makefile	Thu Jan  4 22:00:55 2001
+++ linux-prumpf/drivers/char/Makefile	Tue Feb 20 17:51:39 2001
@@ -170,11 +170,13 @@
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
+# Only one watchdog can succeed. We probe the software watchdog first,
+# then the hardware watchdogs which can override softdog if you have
+# both configured.  This means if your hardware watchdog dies or is
+# 'borrowed' for some reason the software watchdog still gives you
+# some cover.
 
+obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
@@ -184,7 +186,6 @@
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_I810_TCO) += i810-tco.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 
 
 include $(TOPDIR)/Rules.make


