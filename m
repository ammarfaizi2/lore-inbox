Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTFPO6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTFPO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:58:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:46783 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263938AbTFPO5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:57:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.56877.239305.852139@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 17:11:41 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.71] x86-64 apic/nmi cleanups
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

The driver model conversion left x86-64's apic.c and nmi.c with
obsolete #includes and comments, and some poor code formatting.

nmi.c also lacks the 'nmi_pm_active' change which went into
i386 recently. It's needed to prevent enabling the watchdog
after resume if it was disabled before suspend: this happens
if another driver has claimed the HW and disabled the watchdog.
This won't hit until you remove the #if 0 in lapic_nmi_resume(),
however. (Why do you need that?)

Patch below fixes these issues. (Against 2.5.71 + x86_64-2.5.71-1)

/Mikael

diff -ruN linux-2.5.71-andi/arch/x86_64/kernel/apic.c linux-2.5.71-mikpe/arch/x86_64/kernel/apic.c
--- linux-2.5.71-andi/arch/x86_64/kernel/apic.c	2003-06-16 16:08:35.000000000 +0200
+++ linux-2.5.71-mikpe/arch/x86_64/kernel/apic.c	2003-06-16 16:17:38.000000000 +0200
@@ -441,9 +441,6 @@
 
 #ifdef CONFIG_PM
 
-#include <linux/device.h>
-#include <linux/module.h>
-
 static struct {
 	/* 'active' is true if the local APIC was enabled by us and
 	   not the BIOS; this signifies that we are also responsible
@@ -540,7 +537,6 @@
 	.suspend	= lapic_suspend,
 };
 
-/* not static, needed by child devices */
 static struct sys_device device_lapic = {
 	.id		= 0,
 	.cls		= &lapic_sysclass,
diff -ruN linux-2.5.71-andi/arch/x86_64/kernel/nmi.c linux-2.5.71-mikpe/arch/x86_64/kernel/nmi.c
--- linux-2.5.71-andi/arch/x86_64/kernel/nmi.c	2003-06-16 16:08:35.000000000 +0200
+++ linux-2.5.71-mikpe/arch/x86_64/kernel/nmi.c	2003-06-16 16:20:29.000000000 +0200
@@ -141,20 +141,22 @@
 	/* tell do_nmi() and others that we're not active any more */
 	nmi_watchdog = 0;
 }
+
 void enable_lapic_nmi_watchdog(void)
-  {
+{
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
 		setup_apic_nmi_watchdog();
 	}
-  }
+}
 
 #ifdef CONFIG_PM
 
-#include <linux/device.h>
+static int nmi_pm_active; /* nmi_active before suspend */
 
 static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
 {
+	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
 	return 0;
 }
@@ -162,7 +164,8 @@
 static int lapic_nmi_resume(struct sys_device *dev)
 {
 #if 0
-	enable_lapic_nmi_watchdog();
+	if (nmi_pm_active > 0)
+		enable_lapic_nmi_watchdog();
 #endif
 	return 0;
 }
@@ -174,7 +177,7 @@
 };
 
 static struct sys_device device_lapic_nmi = {
-	.id		= 0,
+	.id	= 0,
 	.cls	= &nmi_sysclass,
 };
 
