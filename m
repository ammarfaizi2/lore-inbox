Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVLDNBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVLDNBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVLDNBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:01:42 -0500
Received: from isilmar.linta.de ([213.239.214.66]:2453 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932204AbVLDNBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:01:41 -0500
Date: Sun, 4 Dec 2005 14:01:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com, acpi-devel@lists.sourceforge.net
Subject: C-State policy and dynticks [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Message-ID: <20051204130128.GA9514@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	Adam Belay <abelay@novell.com>,
	Daniel Petrini <d.pensator@gmail.com>, vatsa@in.ibm.com,
	acpi-devel@lists.sourceforge.net
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the ACPI C-States policy smarter when dynticks are enabled:

- reprogram the timer if bus mastering activity is present, so that we don't
  sleep too long in C2, but hopefully can switch to C3 then.
- promote to a higher C-State more easily: if we slept for more than 2
  jiffies the last time, and we're intended to sleep for more than 2
  jiffies now, promote. This is justified as the current policy looks at
  whether we slept longer than a certain threshold for the last 4 or 10
  times; but we usually sleep much longer when dynticks are enabled.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,8 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+#define BM_JIFFIES	(HZ >= 800 ? 4 : 2)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -177,6 +180,7 @@ static void acpi_safe_halt(void)
 }
 
 static atomic_t c3_cpu_count;
+static int last_sleep = 0;
 
 static void acpi_processor_idle(void)
 {
@@ -259,7 +263,7 @@ static void acpi_processor_idle(void)
 		 * If bus mastering is active, automatically demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -270,10 +274,31 @@ static void acpi_processor_idle(void)
 		if (bm_status && cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
+			if (dyn_tick_enabled())
+				dyn_early_reprogram(BM_JIFFIES);
+			last_sleep = 0; /* do not promote in fast-path */
+			goto end;
+		}
+	}
+
+	/*
+	 * Fast-path promotion: if we slept for more than 2 jiffies the last
+	 * time, and we're intended to sleep for more than 2 jiffies now,
+	 * promote. Note that the processor won't enter a low-power state
+	 * during this call (to this funciton) but should upon the next.
+	 */
+	if (dyn_tick_enabled()) {
+		if (cx->promotion.state && cx->promotion.count &&
+		    (last_sleep > BM_JIFFIES) &&
+		    (dyn_tick->skip > BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = cx->promotion.state;
 			goto end;
 		}
 	}
 
+	last_sleep = 0;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
@@ -391,9 +416,10 @@ static void acpi_processor_idle(void)
 		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
 	}
 
+	last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
 	if (pr->flags.bm_check)
-		pr->power.bm_check_timestamp += sleep_ticks /
-			(PM_TIMER_FREQUENCY / HZ);
+		pr->power.bm_check_timestamp += last_sleep;
 
 	next_state = pr->power.state;
 
