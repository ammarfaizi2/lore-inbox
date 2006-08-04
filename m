Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWHDD0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWHDD0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWHDD0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:26:08 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:16329 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030317AbWHDDZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:56 -0400
Message-Id: <20060804032522.521288000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:21 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 07/10] -mm  clocksource: remove update_callback
Content-Disposition: inline; filename=clocksource_remove_update_callback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the new notifier block the update_callback becomes
obsolete.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>
---
 arch/i386/kernel/tsc.c      |    5 +++--
 include/linux/clocksource.h |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.17/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.17/arch/i386/kernel/tsc.c
@@ -60,9 +60,12 @@ static inline int check_tsc_unstable(voi
 	return tsc_unstable;
 }
 
+static int tsc_update_callback(void);
 void mark_tsc_unstable(void)
 {
 	tsc_unstable = 1;
+
+	tsc_update_callback();
 }
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
@@ -322,7 +325,6 @@ core_initcall(cpufreq_tsc);
 /* clock source code */
 
 static unsigned long current_tsc_khz = 0;
-static int tsc_update_callback(void);
 
 static cycle_t read_tsc(void)
 {
@@ -340,7 +342,6 @@ static struct clocksource clocksource_ts
 	.mask			= CLOCKSOURCE_MASK(64),
 	.mult			= 0, /* to be set */
 	.shift			= 22,
-	.update_callback	= tsc_update_callback,
 	.is_continuous		= 1,
 };
 
Index: linux-2.6.17/include/linux/clocksource.h
===================================================================
--- linux-2.6.17.orig/include/linux/clocksource.h
+++ linux-2.6.17/include/linux/clocksource.h
@@ -60,7 +60,6 @@ extern struct clocksource clocksource_ji
  *			subtraction of non 64 bit counters
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
- * @update_callback:	called when safe to alter clocksource values
  * @is_continuous:	defines if clocksource is free-running.
  * @cycle_interval:	Used internally by timekeeping core, please ignore.
  * @xtime_interval:	Used internally by timekeeping core, please ignore.
@@ -73,7 +72,6 @@ struct clocksource {
 	cycle_t mask;
 	u32 mult;
 	u32 shift;
-	int (*update_callback)(void);
 	int is_continuous;
 
 	/* timekeeping specific data, ignore */

--
