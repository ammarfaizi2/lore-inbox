Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWHDD2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWHDD2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWHDD1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:27:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:24521 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030316AbWHDD1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:27:32 -0400
Message-Id: <20060804032510.405094000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:15 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 01/10] -mm  clocksource: increase initcall priority
Content-Disposition: inline; filename=clocksource_init_call.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's likely that this interface would get used during bootup 
I moved all the clocksource registration into the postcore initcall. 
This also eliminated some clocksource shuffling during bootup.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/i386/kernel/hpet.c          |    2 +-
 arch/i386/kernel/i8253.c         |    2 +-
 arch/i386/kernel/tsc.c           |    2 +-
 drivers/clocksource/acpi_pm.c    |    2 +-
 drivers/clocksource/cyclone.c    |    2 +-
 drivers/clocksource/scx200_hrt.c |    2 +-
 kernel/time/clocksource.c        |   15 +--------------
 kernel/time/jiffies.c            |    2 +-
 8 files changed, 8 insertions(+), 21 deletions(-)

Index: linux-2.6.17/arch/i386/kernel/hpet.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/hpet.c
+++ linux-2.6.17/arch/i386/kernel/hpet.c
@@ -64,4 +64,4 @@ static int __init init_hpet_clocksource(
 	return clocksource_register(&clocksource_hpet);
 }
 
-module_init(init_hpet_clocksource);
+postcore_initcall(init_hpet_clocksource);
Index: linux-2.6.17/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.17/arch/i386/kernel/i8253.c
@@ -115,4 +115,4 @@ static int __init init_pit_clocksource(v
 	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
 	return clocksource_register(&clocksource_pit);
 }
-module_init(init_pit_clocksource);
+postcore_initcall(init_pit_clocksource);
Index: linux-2.6.17/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.17/arch/i386/kernel/tsc.c
@@ -475,4 +475,4 @@ static int __init init_tsc_clocksource(v
 	return 0;
 }
 
-module_init(init_tsc_clocksource);
+postcore_initcall(init_tsc_clocksource);
Index: linux-2.6.17/drivers/clocksource/acpi_pm.c
===================================================================
--- linux-2.6.17.orig/drivers/clocksource/acpi_pm.c
+++ linux-2.6.17/drivers/clocksource/acpi_pm.c
@@ -174,4 +174,4 @@ pm_good:
 	return clocksource_register(&clocksource_acpi_pm);
 }
 
-module_init(init_acpi_pm_clocksource);
+postcore_initcall(init_acpi_pm_clocksource);
Index: linux-2.6.17/drivers/clocksource/cyclone.c
===================================================================
--- linux-2.6.17.orig/drivers/clocksource/cyclone.c
+++ linux-2.6.17/drivers/clocksource/cyclone.c
@@ -116,4 +116,4 @@ static int __init init_cyclone_clocksour
 	return clocksource_register(&clocksource_cyclone);
 }
 
-module_init(init_cyclone_clocksource);
+postcore_initcall(init_cyclone_clocksource);
Index: linux-2.6.17/drivers/clocksource/scx200_hrt.c
===================================================================
--- linux-2.6.17.orig/drivers/clocksource/scx200_hrt.c
+++ linux-2.6.17/drivers/clocksource/scx200_hrt.c
@@ -94,7 +94,7 @@ static int __init init_hrt_clocksource(v
 	return clocksource_register(&cs_hrt);
 }
 
-module_init(init_hrt_clocksource);
+postcore_initcall(init_hrt_clocksource);
 
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
 MODULE_DESCRIPTION("clocksource on SCx200 HiRes Timer");
Index: linux-2.6.17/kernel/time/clocksource.c
===================================================================
--- linux-2.6.17.orig/kernel/time/clocksource.c
+++ linux-2.6.17/kernel/time/clocksource.c
@@ -50,19 +50,6 @@ static struct clocksource *next_clocksou
 static LIST_HEAD(clocksource_list);
 static DEFINE_SPINLOCK(clocksource_lock);
 static char override_name[32];
-static int finished_booting;
-
-/* clocksource_done_booting - Called near the end of bootup
- *
- * Hack to avoid lots of clocksource churn at boot time
- */
-static int __init clocksource_done_booting(void)
-{
-	finished_booting = 1;
-	return 0;
-}
-
-late_initcall(clocksource_done_booting);
 
 /**
  * clocksource_get_next - Returns the selected clocksource
@@ -73,7 +60,7 @@ struct clocksource *clocksource_get_next
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocksource_lock, flags);
-	if (next_clocksource && finished_booting) {
+	if (next_clocksource) {
 		curr_clocksource = next_clocksource;
 		next_clocksource = NULL;
 	}
Index: linux-2.6.17/kernel/time/jiffies.c
===================================================================
--- linux-2.6.17.orig/kernel/time/jiffies.c
+++ linux-2.6.17/kernel/time/jiffies.c
@@ -70,4 +70,4 @@ static int __init init_jiffies_clocksour
 	return clocksource_register(&clocksource_jiffies);
 }
 
-module_init(init_jiffies_clocksource);
+postcore_initcall(init_jiffies_clocksource);

--
