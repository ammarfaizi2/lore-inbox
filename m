Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFOBc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTFOBc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:32:28 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:37278 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261757AbTFOBc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:32:26 -0400
Date: Sun, 15 Jun 2003 03:46:10 +0200 (MEST)
Message-Id: <200306150146.h5F1kAj1021228@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: torvalds@transmeta.com
Subject: [PATCH][2.5.71] local APIC blacklist rules updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch removes the x86 local APIC blacklist rules for the
Microstar 6163 and Intel AL440LX mainboards. These boards do
work with local APIC enabled. Heavily tested. Please apply.

Long story: When I worked on the initial UP_APIC code, these
two mainboard (MS-6163 and AL440LX) were the only ones that
caused hangs when the local APIC was enabled. At the time,
I attributed these hangs to broken BIOSen and implemented DMI
scan blacklist rules to prevent enabling the local APIC on them.

However, the last year I've observed hangs on other mainboards
that initially were believed to be safe for local APIC. The
hangs turned out to be caused by APM's DISPLAY_BLANK option:
When this option is enabled, APM will invoke BIOS and graphics
card BIOS code without disabling the local APIC first. In many
cases, a local APIC timer interrupt while APM is trying to blank
the console will hang the system.

APM also has two other options that can hang the system: CPU_IDLE
and building APM as a module, both of which causes it to do BIOS
calls without disabling the local APIC first. On all my systems,
the only reliable configuration is to keep APM's DISPLAY_BLANK and
CPU_IDLE disabled, and to build APM non-modular.

/Mikael

diff -ruN linux-2.5.71/arch/i386/kernel/dmi_scan.c linux-2.5.71.lapic-blacklist-fixes/arch/i386/kernel/dmi_scan.c
--- linux-2.5.71/arch/i386/kernel/dmi_scan.c	2003-06-15 01:08:09.000000000 +0200
+++ linux-2.5.71.lapic-blacklist-fixes/arch/i386/kernel/dmi_scan.c	2003-06-15 01:29:25.000000000 +0200
@@ -311,43 +311,6 @@
 	return 0;
 }
 
-/*
- * The Microstar 6163-2 (a.k.a Pro) mainboard will hang shortly after
- * resumes, and also at what appears to be asynchronous APM events,
- * if the local APIC is enabled.
- */
-static int __init apm_kills_local_apic(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (apm_info.bios.version && !dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
-		printk(KERN_WARNING "%s with broken BIOS detected. "
-		       "Refusing to enable the local APIC.\n",
-		       d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
- * The Intel AL440LX mainboard will hang randomly if the local APIC
- * timer is running and the APM BIOS hasn't been disabled.
- */
-static int __init apm_kills_local_apic_timer(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_use_local_apic_timer;
-	if (apm_info.bios.version && !dont_use_local_apic_timer) {
-		dont_use_local_apic_timer = 1;
-		printk(KERN_WARNING "%s with broken BIOS detected. "
-		       "The local APIC timer will not be used.\n",
-		       d->ident);
-	}
-#endif
-	return 0;
-}
-
 /* 
  * Don't access SMBus on IBM systems which get corrupted eeproms 
  */
@@ -743,16 +706,6 @@
 			NO_MATCH, NO_MATCH
 			} },
 
-	{ apm_kills_local_apic, "Microstar 6163", {
-			MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
-			MATCH(DMI_BOARD_NAME, "MS-6163"),
-			NO_MATCH, NO_MATCH } },
-
-	{ apm_kills_local_apic_timer, "Intel AL440LX", {
-			MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BOARD_NAME, "AL440LX"),
-			NO_MATCH, NO_MATCH } },
-
 	/* Problem Intel 440GX bioses */
 
 	{ broken_pirq, "SABR1 Bios", {			/* Bad $PIR */
