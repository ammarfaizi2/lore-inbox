Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVLZWVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVLZWVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLZWVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:21:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:42441 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750741AbVLZWVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:21:11 -0500
Date: Mon, 26 Dec 2005 23:19:43 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Theodore Ts'o" <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226221942.GA16837@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Theodore Ts'o <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226025525.GA6697@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 25, 2005 at 09:55:26PM -0500, Theodore Ts'o wrote:
> With dyntick enabled, the laptop never enters the C4 state, but
> instead bounces back and forth between C2 and C3 (and I notice that we
> never enter C1 state, even when the CPU is completely pegged, but
> that's true with or without dyntick).  

Could you try out this patch on top of it? It also adds some debug output to
/proc/acpi/processor/CPU0/power which I'd be interested in during normal
usage on your notebook.

Hope this helps a bit...

	Dominik

PS: this patch isn't yet in mergeable shape...


Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -61,7 +61,7 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
-#define BM_JIFFIES	(HZ >= 800 ? 4 : 2)
+#define BM_JIFFIES	(HZ >= 800 ? 2 : 1)
 
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
@@ -181,6 +181,14 @@ static void acpi_safe_halt(void)
 
 static atomic_t c3_cpu_count;
 
+u32 super_fastpath;
+u32 fastpath;
+u32 fastpath_demotion;
+u32 kickback;
+u32 promotion;
+u32 demotion;
+u32 bm_demotion;
+
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
@@ -237,7 +245,6 @@ static void acpi_processor_idle(void)
 				pr->power.bm_activity |= 0x1;
 			pr->power.bm_activity <<= 1;
 		}
-
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
 		if (bm_status) {
@@ -273,11 +280,12 @@ static void acpi_processor_idle(void)
 		if ((pr->power.bm_activity & 0x01) &&
 		    cx->demotion.threshold.bm) {
 			local_irq_enable();
+			if (!pr->power.pre_bm_state)
+				pr->power.pre_bm_state = cx;
+			bm_demotion++;
 			next_state = cx->demotion.state;
 			if (dyn_tick_enabled())
-				dyn_early_reprogram(BM_JIFFIES);
-			/* do not promote in fast-path */
-			pr->power.last_sleep = 0;
+				dyn_early_reprogram(1);
 			goto end;
 		}
 	}
@@ -287,38 +295,64 @@ static void acpi_processor_idle(void)
 	 */
 	if (dyn_tick_enabled()) {
 		/*
-		 * Fast-path promotion: if we slept for more than 2 jiffies the
-		 * last time, and we're intended to sleep for more than 2
-		 * jiffies now, promote. Note that the processor won't enter a
-		 * low-power state during this call (to this funciton) but
-		 * should upon the next.
+		 * Fast-path promotion: promote to higher state if
+		 *   	- we can promote
+		 *	- we did sleep at least "threshold" pm_timer ticks last time
+		 *	- there is no bm_activity this tick
+		 *	- we slept more than BM_JIFFIES ticks last time
+		 *	- we're scheduled to sleep at least BM_JIFFIES ticks now
 		 */
-		if (cx->promotion.state && cx->promotion.count &&
-		    dyn_tick_skipping() && ((pr->power.last_sleep >
-		      (BM_JIFFIES * cx->promotion.threshold.ticks)) ||
-		     (pr->power.quick_promotion == 1)) &&
-		    (dyn_tick_current_skip() > BM_JIFFIES)) {
+		if (cx->promotion.state &&
+		    cx->promotion.count &&
+		    !(pr->power.bm_activity & 0x01) &&
+		    (pr->power.last_sleep > BM_JIFFIES) &&
+		    (dyn_tick_current_skip() >= BM_JIFFIES)) {
 			local_irq_enable();
 			next_state = cx->promotion.state;
+			/*
+			 * Super-fast-path: promote to next higher state if
+			 * 	- we can promote
+			 *	- we did sleep longer than 2 * BM_JIFFIES times last time
+			 */
+			if (next_state->promotion.state &&
+			    ((cx->promotion.threshold.bm && next_state->promotion.threshold.bm) ||
+			     (!cx->promotion.threshold.bm && !next_state->promotion.threshold.bm)) &&
+			    (pr->power.last_sleep > (2 * BM_JIFFIES))) {
+				next_state = next_state->promotion.state;
+				super_fastpath++;
+			} else
+				fastpath++;
 			goto end;
 		}
 
+	       /*
+		* Kick-back promotion: promote to C-State used before bm activity was detected if
+		*  	- we have a pre-bm-state
+		*  	- we had bus mastering activity last jiffy, but not this jiffy
+  	  	*  	- we're scheduled to sleep at least BM_JIFFIES now
+		*/
+		if (pr->power.pre_bm_state &&			/* we have a pre-bm-state */
+		    ((pr->power.bm_activity & 0x11) == 0x10) &&	/* we had bm activity last jiffy, not this jiffy */
+		    (dyn_tick_current_skip() >= BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = pr->power.pre_bm_state;
+			pr->power.pre_bm_state = NULL;
+			kickback++;
+			goto end;
+		}
 
 		/*
 		 * Fast-path demotion: if we're going to sleep for only one
-		 * jiffy, and we'd enter C3-type sleep, and the wakeup latency
-		 * is high, don't use C3-type sleep but (temporarily) C2.
+		 * jiffy, and the wakeup latency is high, demote.
 		 */
-		if (cx->demotion.state && cx->demotion.threshold.bm &&
-		    (dyn_tick_next_tick() < (jiffies + 1))
-		    && (cx->latency > 150)) {
+		if (cx->demotion.state &&
+		    (dyn_tick_next_tick() < (jiffies + 1)) &&
+		    (cx->latency > 150)) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
-
 			/* don't do a fast-path promotion next time... */
 			pr->power.last_sleep = 0;
-			/* ... but thereafter. */
-			pr->power.quick_promotion = 2;
+			fastpath_demotion++;
 			goto end;
 		}
 	}
@@ -446,9 +480,6 @@ static void acpi_processor_idle(void)
 
 	next_state = pr->power.state;
 
-	if (pr->power.quick_promotion)
-		pr->power.quick_promotion--;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Don't do promotion/demotion */
 	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
@@ -477,11 +508,13 @@ static void acpi_processor_idle(void)
 					if (!
 					    (pr->power.bm_activity & cx->
 					     promotion.threshold.bm)) {
+						promotion++;
 						next_state =
 						    cx->promotion.state;
 						goto end;
 					}
 				} else {
+					promotion++;
 					next_state = cx->promotion.state;
 					goto end;
 				}
@@ -500,6 +533,7 @@ static void acpi_processor_idle(void)
 			cx->demotion.count++;
 			cx->promotion.count = 0;
 			if (cx->demotion.count >= cx->demotion.threshold.count) {
+				demotion++;
 				next_state = cx->demotion.state;
 				goto end;
 			}
@@ -1019,6 +1053,16 @@ static int acpi_processor_power_seq_show
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
 		   max_cstate, (unsigned)pr->power.bm_activity);
 
+	seq_printf(seq,
+		   "promotion:    %08d\n"
+		   "demotion:     %08d\n"
+		   "bm_demotion:  %08d\n"
+		   "fastpath_demotion:  %08d\n"
+		   "fastpath:     %08d\n"
+		   "sfastpath:    %08d\n"
+		   "kickback:     %08d\n",
+		   promotion, demotion, bm_demotion, fastpath_demotion, fastpath, super_fastpath, kickback);
+
 	seq_puts(seq, "states:\n");
 
 	for (i = 1; i <= pr->power.count; i++) {
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -58,11 +58,11 @@ struct acpi_processor_cx {
 
 struct acpi_processor_power {
 	struct acpi_processor_cx *state;
+	struct acpi_processor_cx *pre_bm_state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
 	u16 last_sleep;
-	u16 quick_promotion;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 
