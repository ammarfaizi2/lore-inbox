Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTDMNCN (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTDMNB5 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 09:01:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:61115 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263505AbTDMNBe (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 09:01:34 -0400
Date: Sun, 13 Apr 2003 15:13:15 +0200 (MEST)
Message-Id: <200304131313.h3DDDFWq004625@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: torvalds@transmeta.com
Subject: [PATCH] 2.5.67 lapic_nmi_watchdog resume fix
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I managed to add a bug to the local APIC NMI watchdog's
resume procedure in the driver model conversion for 2.5.67.
The problem is that the resume procedure simply calls the
enable procedure. If the NMI watchdog has been disabled by
another driver (like oprofile or perfctr), then the NMI
watchdog will incorrectly be re-enabled.

I discovered this when updating the perfctr driver for 2.5.67
and seeing unexpected NMIs after a resume from apm --suspend.

We can fix this by unregistering the NMI watchdog from the
driver model when disabling it (like the code did before the
driver model changes), or by remembering the previous state
at suspend and checking it at resume. The patch below uses
the second, simpler, approach. Tested, please apply.

/Mikael

--- linux-2.5.67-perfctr/arch/i386/kernel/nmi.c.~1~	2003-04-08 01:47:25.000000000 +0200
+++ linux-2.5.67-perfctr/arch/i386/kernel/nmi.c	2003-04-12 23:26:35.000000000 +0200
@@ -181,11 +181,13 @@
 #ifdef CONFIG_PM
 
 #include <linux/device.h>
+static int nmi_pm_active; /* nmi_active before suspend */
 
 static int lapic_nmi_suspend(struct device *dev, u32 state, u32 level)
 {
 	if (level != SUSPEND_POWER_DOWN)
 		return 0;
+	nmi_pm_active = nmi_active;
 	disable_lapic_nmi_watchdog();
 	return 0;
 }
@@ -194,7 +196,8 @@
 {
 	if (level != RESUME_POWER_ON)
 		return 0;
-	enable_lapic_nmi_watchdog();
+	if (nmi_pm_active > 0)
+		enable_lapic_nmi_watchdog();
 	return 0;
 }
 
