Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVLSAK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVLSAK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVLSAK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:10:57 -0500
Received: from isilmar.linta.de ([213.239.214.66]:20201 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1030194AbVLSAK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:10:56 -0500
Date: Mon, 19 Dec 2005 01:10:50 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, acpi-devel@lists.sourceforge.net
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: ACPI C-States [Was: Re: [PATCH] i386 No Idle HZ aka dynticks 051217]
Message-ID: <20051219001050.GA10777@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>, acpi-devel@lists.sourceforge.net,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512190219.40631.kernel@kolivas.org> <200512190222.40399.kernel@kolivas.org> <200512190934.51210.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512190934.51210.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few improvements and bugfixes to the ACPI C-States management based on
what's already in your dyn-tick patchset:
- last_sleep needs to be per-CPU
- cx->time for C1-type sleep is meaningless, remove support for it.
- Add a fast-path demotion: if dynticks are enabled, we can relax a bit
  and use a more responsive sleep type if we're going to sleep only
  for a short period of time (<1 tick), as long as we get back to deep
  sleep soon (quick_promotion).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -180,7 +180,6 @@ static void acpi_safe_halt(void)
 }
 
 static atomic_t c3_cpu_count;
-static int last_sleep = 0;
 
 static void acpi_processor_idle(void)
 {
@@ -277,28 +276,55 @@ static void acpi_processor_idle(void)
 			next_state = cx->demotion.state;
 			if (dyn_tick_enabled())
 				dyn_early_reprogram(BM_JIFFIES);
-			last_sleep = 0; /* do not promote in fast-path */
+			/* do not promote in fast-path */
+			pr->power.last_sleep = 0;
 			goto end;
 		}
 	}
 
 	/*
-	 * Fast-path promotion: if we slept for more than 2 jiffies the last
-	 * time, and we're intended to sleep for more than 2 jiffies now,
-	 * promote. Note that the processor won't enter a low-power state
-	 * during this call (to this funciton) but should upon the next.
+	 * Some special policy tweaks for dynamic ticks
 	 */
 	if (dyn_tick_enabled()) {
+		/*
+		 * Fast-path promotion: if we slept for more than 2 jiffies the
+		 * last time, and we're intended to sleep for more than 2
+		 * jiffies now, promote. Note that the processor won't enter a
+		 * low-power state during this call (to this funciton) but
+		 * should upon the next.
+		 */
 		if (cx->promotion.state && cx->promotion.count &&
-		    (last_sleep > BM_JIFFIES) &&
+		    (dyn_tick->next_tick > jiffies) &&
+		    ((pr->power.last_sleep >
+		      (BM_JIFFIES * cx->promotion.threshold.ticks)) ||
+		     (pr->power.quick_promotion == 1)) &&
 		    (dyn_tick->skip > BM_JIFFIES)) {
 			local_irq_enable();
 			next_state = cx->promotion.state;
 			goto end;
 		}
+
+
+		/*
+		 * Fast-path demotion: if we're going to sleep for only one
+		 * jiffy, and we'd enter C3-type sleep, and the wakeup latency
+		 * is high, don't use C3-type sleep but (temporarily) C2.
+		 */
+		if (cx->demotion.state && cx->demotion.threshold.bm &&
+		    (dyn_tick->next_tick < (jiffies + 1))
+		    && (cx->latency > 150)) {
+			local_irq_enable();
+			next_state = cx->demotion.state;
+
+			/* don't do a fast-path promotion next time... */
+			pr->power.last_sleep = 0;
+			/* ... but thereafter. */
+			pr->power.quick_promotion = 2;
+			goto end;
+		}
 	}
 
-	last_sleep = 0;
+	pr->power.last_sleep = 0;
 
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
@@ -411,19 +437,18 @@ static void acpi_processor_idle(void)
 	if (cx->type != ACPI_STATE_C1) {
 		if (sleep_ticks > 0)
 			cx->time += sleep_ticks;
-	} else {
-		/* for C1, where we don't know the exact value, assume 0.5 of
-		 * a jiffy */
-		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
 	}
 
-	last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+	pr->power.last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
 
 	if (pr->flags.bm_check)
-		pr->power.bm_check_timestamp += last_sleep;
+		pr->power.bm_check_timestamp += pr->power.last_sleep;
 
 	next_state = pr->power.state;
 
+	if (pr->power.quick_promotion)
+		pr->power.quick_promotion--;
+
 	/*
 	 * Promotion?
 	 * ----------
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -61,6 +61,8 @@ struct acpi_processor_power {
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
+	u16 last_sleep;
+	u16 quick_promotion;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 
