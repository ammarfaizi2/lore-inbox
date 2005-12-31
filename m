Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVLaLNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVLaLNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLaLNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:13:15 -0500
Received: from isilmar.linta.de ([213.239.214.66]:4311 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751329AbVLaLNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:13:12 -0500
Date: Sat, 31 Dec 2005 12:12:51 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, len.brown@intel.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
Subject: [PATCH 4/4] ACPI C-States: dyn-ticks tweaks
Message-ID: <20051231111251.GE9123@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>, len.brown@intel.com,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, linux-acpi@vger.kernel.org
References: <200512281718.14897.kernel@kolivas.org> <20051231110955.GA9123@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231110955.GA9123@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If dyn-ticks is enabled, we can and should try to be smart when
deciding which C-State to enter.

If we're likely not to wake up soon, we can "kick back" to the high C-State
the system was in before bus mastering activity was present.

If we slept for a long period of time last time, and we're scheduled to do
so again, we can enter a higher (or even the next higher) C-State.
(fastpath, super-fastpath promotion).

If bus mastering activity was detected this jiffy, schedule an extra
early wakeup: most likely there's something to handle then anyways, and
we hope this bus mastering activity will end soon, allowing us to utilize
high C-States afterwards.

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
 
+#define BM_JIFFIES	(HZ >= 800 ? 2 : 1)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -264,6 +267,8 @@ static void acpi_processor_idle(void)
 		if ((pr->power.bm_activity & 0x1) &&
 		    cx->demotion.threshold.bm) {
 			local_irq_enable();
+			if (!pr->power.pre_bm_state)
+				pr->power.pre_bm_state = cx;
 			next_state = cx->demotion.state;
 			goto end;
 		}
@@ -281,6 +286,69 @@ static void acpi_processor_idle(void)
 #endif
 
 	/*
+	 * Some special policy tweaks for dynamic ticks
+	 */
+	if (dyn_tick_enabled()) {
+	       /*
+		* Kick-back promotion: promote to C-State used before bm
+		* activity was detected if
+		*	- we have a pre-bm-state
+		*	- we do not have bus mastering at the moment
+  	  	*  	- we're scheduled to sleep at least BM_JIFFIES now
+		*/
+		if (pr->power.pre_bm_state &&
+		    !(pr->power.bm_activity & 0x1) &&
+		    (dyn_tick_current_skip() >= BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = pr->power.pre_bm_state;
+			pr->power.pre_bm_state = NULL;
+			goto end;
+		}
+
+		/*
+		 * Fast-path promotion: promote to higher state if
+		 *   	- we can promote
+		 *	- there is no bm_activity this tick
+		 *	- we slept more than BM_JIFFIES ticks last time
+		 *	- we're scheduled to sleep at least BM_JIFFIES ticks
+ 		 */
+		if (cx->promotion.state &&
+		    !(pr->power.bm_activity & 0x1) &&
+		    (pr->power.last_sleep > BM_JIFFIES) &&
+		    (dyn_tick_current_skip() >= BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = cx->promotion.state;
+			/*
+			 * Super-fast-path: promote to next higher state if
+			 * 	- we can promote
+			 *	- we did sleep longer than 2 * BM_JIFFIES
+			 *	  times last time
+			 *	- we're scheduled to sleep at least 2 *
+			 *	  BM_JIFFIES ticks
+			 */
+			if ((next_state->promotion.state) &&
+			    (pr->power.last_sleep > 2 * BM_JIFFIES) &&
+			    (dyn_tick_current_skip() >= 2 * BM_JIFFIES))
+				next_state = next_state->promotion.state;
+			pr->power.pre_bm_state = NULL;
+			goto end;
+		}
+
+		/*
+		 * Re-program if bm activity is present this jiffy -- we hope
+		 * that it ends soon, so that we can go into a deeper sleep
+		 * type
+		 */
+		if (cx->demotion.state &&
+		    (pr->power.bm_activity & 0x1) &&
+		    (pr->power.bm_check_timestamp == jiffies)) {
+			dyn_early_reprogram(BM_JIFFIES);
+		}
+	}
+
+	pr->power.last_sleep = 0;
+
+	/*
 	 * Sleep:
 	 * ------
 	 * Invoke the current Cx state to put the processor to sleep.
@@ -377,9 +445,13 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+
+	/* Accounting */
 	cx->usage++;
 	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
 		cx->time += sleep_ticks;
+	pr->power.last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
 
 	next_state = pr->power.state;
 
@@ -413,10 +485,12 @@ static void acpi_processor_idle(void)
 					     promotion.threshold.bm)) {
 						next_state =
 						    cx->promotion.state;
+						pr->power.pre_bm_state = NULL;
 						goto end;
 					}
 				} else {
 					next_state = cx->promotion.state;
+					pr->power.pre_bm_state = NULL;
 					goto end;
 				}
 			}
@@ -434,6 +508,7 @@ static void acpi_processor_idle(void)
 			cx->demotion.count++;
 			cx->promotion.count = 0;
 			if (cx->demotion.count >= cx->demotion.threshold.count) {
+				pr->power.pre_bm_state = NULL;
 				next_state = cx->demotion.state;
 				goto end;
 			}
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -61,8 +61,10 @@ struct acpi_processor_power {
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
+	u16 last_sleep;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
+	struct acpi_processor_cx *pre_bm_state;
 
 	/* the _PDC objects passed by the driver, if any */
 	struct acpi_object_list *pdc;
