Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTHYUXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbTHYUXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:23:30 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:60131 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262328AbTHYUWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:22:20 -0400
Date: Mon, 25 Aug 2003 22:21:04 +0200 (MEST)
Message-Id: <200308252021.h7PKL4P1015224@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo@conectiva.com.br
Subject: 2.4.22 local APIC updates 1/3: remove incorrect blacklist rules
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch removes the x86 local APIC blacklist rules for the
Microstar 6163 and Intel AL440LX mainboards, as these boards
_do_ work with local APIC enabled.

The AL440LX blacklist rule was the only place where the
dont_enable_local_apic_timer flag could be set, so the patch
removes that variable and the code which checks it.

The hangs these boards used to have has since been traced to
a combination of using specific graphics cards with APM's
DISPLAY_BLANK option.

Backport from 2.5.72. Also tested in 2.4 for months. Please apply.

/Mikael

diff -ruN linux-2.4.22/arch/i386/kernel/apic.c linux-2.4.22.apic-blacklist-fix/arch/i386/kernel/apic.c
--- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-14 13:30:19.000000000 +0200
+++ linux-2.4.22.apic-blacklist-fix/arch/i386/kernel/apic.c	2003-08-25 20:13:40.000000000 +0200
@@ -928,14 +928,8 @@
 
 static unsigned int calibration_result;
 
-int dont_use_local_apic_timer __initdata = 0;
-
 void __init setup_APIC_clocks (void)
 {
-	/* Disabled by DMI scan or kernel option? */
-	if (dont_use_local_apic_timer)
-		return;
-
 	printk("Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
diff -ruN linux-2.4.22/arch/i386/kernel/dmi_scan.c linux-2.4.22.apic-blacklist-fix/arch/i386/kernel/dmi_scan.c
--- linux-2.4.22/arch/i386/kernel/dmi_scan.c	2003-08-25 20:07:40.000000000 +0200
+++ linux-2.4.22.apic-blacklist-fix/arch/i386/kernel/dmi_scan.c	2003-08-25 20:13:40.000000000 +0200
@@ -347,43 +347,6 @@
 }
 
 /*
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
-/*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
  *
@@ -861,16 +824,6 @@
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
