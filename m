Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTEEEvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEEEvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:51:46 -0400
Received: from dp.samba.org ([66.70.73.150]:19155 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261925AbTEEEvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:51:44 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: APIC is not properly suspending in 2.5.67 on UP
Date: Mon, 05 May 2003 14:59:11 +1000
Message-Id: <20030505050414.399872C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Pavel Machek <pavel@ucw.cz>

  Hi!
  
  > >This is needed otherwise APIC thinks it is not active, does not
  > >suspend properly, and kills machine.
  > 
  > This can only happen with UP if the machine boots with local
  > APIC enabled and the BIOS announces an MP table.
  > 
  > If this is the case, then yes apic_pm_activate() needs to be done.
  > 
  > > Extra whitespace killed (looks
  > >ugly). Please apply,
  > 
  > I think some fixes are needed first:
  > - You're calling apic_pm_activate() from setup_local_APIC(), which
  >   is before its definition. This will cause a compile warning, and
  >   a linkage error if CONFIG_PM=n.
  
  Fixed (by adding function prototype). Please apply,
  								Pavel
  
  %patch
  Index: linux/arch/i386/kernel/apic.c
  ===================================================================

--- trivial-2.5.69/arch/i386/kernel/apic.c.orig	2003-05-05 14:46:23.000000000 +1000
+++ trivial-2.5.69/arch/i386/kernel/apic.c	2003-05-05 14:46:23.000000000 +1000
@@ -38,6 +38,8 @@
 
 #include "io_ports.h"
 
+static void apic_pm_activate(void);
+
 void __init apic_intr_init(void)
 {
 #ifdef CONFIG_SMP
@@ -451,6 +453,7 @@
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
+	apic_pm_activate();
 }
 
 #ifdef CONFIG_PM
@@ -587,7 +590,7 @@
 
 #else	/* CONFIG_PM */
 
-static inline void apic_pm_activate(void) { }
+static void apic_pm_activate(void) { }
 
 #endif	/* CONFIG_PM */
 
@@ -654,9 +657,7 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
 	apic_pm_activate();
-
 	return 0;
 
 no_apic:
@@ -1135,11 +1136,8 @@
 	}
 
 	verify_local_APIC();
-
 	connect_bsp_APIC();
-
 	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -1150,6 +1148,5 @@
 			setup_IO_APIC();
 #endif
 	setup_boot_APIC_clock();
-
 	return 0;
 }
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Pavel Machek <pavel@ucw.cz>: Re: APIC is not properly suspending in 2.5.67 on UP
