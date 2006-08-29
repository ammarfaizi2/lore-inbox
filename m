Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWH2UuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWH2UuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWH2UuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:50:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:27544 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965333AbWH2UuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:50:03 -0400
Subject: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
From: Adam Belay <abelay@novell.com>
To: Len Brown <len.brown@intel.com>
Cc: ACPI ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 16:51:20 -0400
Message-Id: <1156884681.1781.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch improves the ACPI c-state selection algorithm.  It also
includes a major cleanup and simplification of the processor idle code.

The new implementation considers the full menu of available c-states.
Just as the previous implementation, decisions are primarily based on
the residency time of the last c-state entry.  This is generally an
effective metric because it allows for detection of interrupt activity.
However, the new algorithm differs in that it does not promote or demote
through the c-states in succession.  Rather, it immediately jumps to
whatever c-state has the best expected power consumption advantage for
the predicted residency time (i.e. the previously measured residency).
If the residency time is too short during a deep c-state entry, then the
cost of entering the state outweighs any power consumption advantage.
Similarly, if a shallow c-state is entered and resident for an
excessively long duration, then a potential opportunity to save more
power is missed.

The changes in this patch allow the ACPI idle processor mechanism to
react more quickly to sudden bursts of activity because it can jump
directly to whatever c-state is appropriate.  However, because of the
"menu" nature of c-state selection, the code works best when ACPI
implementations expose all of the c-states supported by hardware.

The bus master activity mechanism has undergone similar improvements.
During capability detection, the deepest c-state that allows bus master
activity is determined.  BM_STS is then polled each time the ACPI code
prepares to enter a c-state.  If bus master activity is detected, then
the previously mentioned bus master capable c-state becomes the deepest
c-state allowed for that quantum.  In contrast, the old implementation
would permit bus master activity to cause a promotion from one C3-type
state to the next shallower C3-type state, imposing unnecessary latency.
As a further optimization, BM_STS is cleared each time
acpi_processor_idle() is entered.  This prevents any stale bus master
status from affecting c-state policy, as it may have occurred long ago
during scheduled work.

Finally, it's worth mentioning that the bulk of c-state policy
calculations have been moved to take place before c-states are entered.
This should further reduce exit latency when returning from a c-state.

This algorithm has not yet been carefully benchmarked (e.g. bltk or
power meters).  However, I can say with some confidence that it saves a
small amount more power during an idle workload and a larger amount more
power during typical user-input oriented workloads such as word
processing.

I would really appreciate any comments, suggestions, or testing.

Cheers,
Adam

P.S.: It would be great if we had an accurate way to determine the ticks
spent in the C1 state.  Currently, I work around the issue by setting
"sleep_ticks" such that it promotes to the next deeper state during the
next quantum.

Patch is against 2.6.18-rc4.
Signed-off-by: Adam Belay <abelay@novell.com>

---
 drivers/acpi/processor_idle.c |  502 +++++++++++++++---------------------------
 include/acpi/processor.h      |   18 -
 2 files changed, 184 insertions(+), 336 deletions(-)

--- a/drivers/acpi/processor_idle.c	2006-08-28 17:14:40.000000000 -0400
+++ b/drivers/acpi/processor_idle.c	2006-08-28 17:13:56.000000000 -0400
@@ -8,6 +8,8 @@
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
  *  			- Added support for C3 on SMP
+ *  Copyright (C) 2006  Adam Belay <abelay@novell.com>
+ *  			- New policy algorithm, several cleanups
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -52,8 +54,6 @@
 ACPI_MODULE_NAME("acpi_processor")
 #define ACPI_PROCESSOR_FILE_POWER	"power"
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
-#define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-#define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 static void (*pm_idle_save) (void) __read_mostly;
 module_param(max_cstate, uint, 0644);
 
@@ -61,15 +61,10 @@
 module_param(nocst, uint, 0000);
 
 /*
- * bm_history -- bit-mask with a bit per jiffy of bus-master activity
- * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
- * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
- * 100 HZ: 0x0000000F: 4 jiffies = 40ms
- * reduce history for more aggressive entry into C3
+ * Currently, we aim for the entry/exit latency to be 20% of measured residency.
  */
-static unsigned int bm_history __read_mostly =
-    (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
-module_param(bm_history, uint, 0644);
+#define RESIDENCY_TO_LATENCY_RATIO	5
+
 /* --------------------------------------------------------------------------
                                 Power Management
    -------------------------------------------------------------------------- */
@@ -165,6 +160,13 @@
 		return ((0xFFFFFFFF - t1) + t2);
 }
 
+static atomic_t c3_cpu_count;
+
+/**
+ * acpi_processor_power_activate - prepares for the next power state
+ * @power: power data
+ * @new: the target power state
+ */
 static void
 acpi_processor_power_activate(struct acpi_processor *pr,
 			      struct acpi_processor_cx *new)
@@ -176,10 +178,6 @@
 
 	old = pr->power.state;
 
-	if (old)
-		old->promotion.count = 0;
-	new->demotion.count = 0;
-
 	/* Cleanup from old state. */
 	if (old) {
 		switch (old->type) {
@@ -207,330 +205,216 @@
 	return;
 }
 
-static void acpi_safe_halt(void)
+
+/**
+ * acpi_check_bm_status - determines if there is BM activity
+ *
+ * Returns: a non-zero value to indicate BM activity
+ */
+static inline int acpi_check_bm_status(void)
 {
-	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
-	if (!need_resched())
-		safe_halt();
-	current_thread_info()->status |= TS_POLLING;
-}
+	u32 bm_status;
 
-static atomic_t c3_cpu_count;
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			  &bm_status, ACPI_MTX_DO_NOT_LOCK);
+	if (bm_status) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+				  1, ACPI_MTX_DO_NOT_LOCK);
+		return 1;
+	}
+	/*
+	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+	 * the true state of bus mastering activity; forcing us to
+	 * manually check the BMIDEA bit of each IDE channel.
+	 */
+	else if (errata.piix4.bmisx) {
+		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+		    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+			return 1;
+	}
+
+	return 0;
+}
 
+/**
+ * acpi_processor_idle - the main ACPI idle loop
+ *
+ * This function determines and enters the most appropriate ACPI c-state based
+ * on current system conditions.
+ */
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
 	struct acpi_processor_cx *cx = NULL;
-	struct acpi_processor_cx *next_state = NULL;
-	int sleep_ticks = 0;
-	u32 t1, t2 = 0;
+	u32 sleep_ticks, state_idx, t1, t2, i;
 
 	pr = processors[smp_processor_id()];
 	if (!pr)
 		return;
 
 	/*
-	 * Interrupts must be disabled during bus mastering calculations and
-	 * for C2/C3 transitions.
-	 */
-	local_irq_disable();
-
-	/*
-	 * Check whether we truly need to go idle, or should
-	 * reschedule:
-	 */
-	if (unlikely(need_resched())) {
-		local_irq_enable();
-		return;
-	}
-
-	cx = pr->power.state;
-	if (!cx) {
-		if (pm_idle_save)
-			pm_idle_save();
-		else
-			acpi_safe_halt();
-		return;
-	}
-
-	/*
-	 * Check BM Activity
-	 * -----------------
-	 * Check for bus mastering activity (if required), record, and check
-	 * for demotion.
-	 */
-	if (pr->flags.bm_check) {
-		u32 bm_status = 0;
-		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
-
-		if (diff > 31)
-			diff = 31;
-
-		pr->power.bm_activity <<= diff;
-
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
-				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
-		if (bm_status) {
-			pr->power.bm_activity |= 0x1;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
-					  1, ACPI_MTX_DO_NOT_LOCK);
+	 * We assume there's a good chance the idle conditions will be similar
+	 * to those before we scheduled work.  Therefore, the next state is
+	 * determined by the idle ticks of the last sleep state entered.
+	 */
+	sleep_ticks = pr->power.last_ticks;
+	state_idx = pr->power.count;
+
+	/*
+	 * We also clear BM_STS, as it may have been a while since we last
+	 * checked it.
+	 */
+	acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			  1, ACPI_MTX_DO_NOT_LOCK);
+
+	while (!need_resched()) {
+		int count = min(pr->power.count, (int) max_cstate);
+		cx = &pr->power.states[state_idx];
+
+		if (cx->target_ticks < sleep_ticks) { /* promotion */
+			for (i = state_idx + 1; i <= count; i++) {
+				cx = &pr->power.states[i];
+				if (!cx->valid)
+					continue;
+				state_idx = i;
+				if (cx->target_ticks >= sleep_ticks)
+					break;
+			}
+		} else { /* demotion */
+			for (i = state_idx - 1; i > 0; i--) {
+				cx = &pr->power.states[i];
+				if (!cx->valid)
+					continue;
+				state_idx = i;
+				if (cx->target_ticks < sleep_ticks)
+					break;
+			}
 		}
+
 		/*
-		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-		 * the true state of bus mastering activity; forcing us to
-		 * manually check the BMIDEA bit of each IDE channel.
+		 * Interrupts must be disabled during bus mastering
+		 * calculations and for C-state transitions.
 		 */
-		else if (errata.piix4.bmisx) {
-			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity |= 0x1;
-		}
+		local_irq_disable();
 
-		pr->power.bm_check_timestamp = jiffies;
+		if (unlikely(need_resched())) {
+			local_irq_enable();
+			return;
+		}
 
 		/*
-		 * If bus mastering is or was active this jiffy, demote
-		 * to avoid a faulty transition.  Note that the processor
-		 * won't enter a low-power state during this call (to this
-		 * function) but should upon the next.
-		 *
-		 * TBD: A better policy might be to fallback to the demotion
-		 *      state (use it for this quantum only) istead of
-		 *      demoting -- and rely on duration as our sole demotion
-		 *      qualification.  This may, however, introduce DMA
-		 *      issues (e.g. floppy DMA transfer overrun/underrun).
+		 * Check bus master status, if active ensure we enter a state
+		 * that allows bus master transactions.
 		 */
-		if ((pr->power.bm_activity & 0x1) &&
-		    cx->demotion.threshold.bm) {
-			local_irq_enable();
-			next_state = cx->demotion.state;
-			goto end;
+		if (pr->flags.bm_check && acpi_check_bm_status()) {
+			pr->power.bm_activity++;
+			state_idx = min(state_idx, pr->power.bm_veto_state);
 		}
-	}
 
 #ifdef CONFIG_HOTPLUG_CPU
-	/*
-	 * Check for P_LVL2_UP flag before entering C2 and above on
-	 * an SMP system. We do it here instead of doing it at _CST/P_LVL
-	 * detection phase, to work cleanly with logical CPU hotplug.
-	 */
-	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) && 
-	    !pr->flags.has_cst && !acpi_fadt.plvl2_up)
-		cx = &pr->power.states[ACPI_STATE_C1];
+		/*
+		 * Check for P_LVL2_UP flag before entering C2 and above on
+		 * an SMP system. We do it here instead of doing it at _CST/P_LVL
+		 * detection phase, to work cleanly with logical CPU hotplug.
+		 */
+		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) && 
+		    !pr->flags.has_cst && !acpi_fadt.plvl2_up)
+			state_idx = ACPI_STATE_C1;
 #endif
 
-	/*
-	 * Sleep:
-	 * ------
-	 * Invoke the current Cx state to put the processor to sleep.
-	 */
-	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
+		cx = &pr->power.states[state_idx];
+
+		acpi_processor_power_activate(pr, cx);
+
 		current_thread_info()->status &= ~TS_POLLING;
 		smp_mb__after_clear_bit();
+
 		if (need_resched()) {
 			current_thread_info()->status |= TS_POLLING;
 			local_irq_enable();
 			return;
 		}
-	}
-
-	switch (cx->type) {
 
-	case ACPI_STATE_C1:
-		/*
-		 * Invoke C1.
-		 * Use the appropriate idle routine, the one that would
-		 * be used without acpi C-states.
-		 */
-		if (pm_idle_save)
-			pm_idle_save();
-		else
-			acpi_safe_halt();
-
-		/*
-		 * TBD: Can't get time duration while in C1, as resumes
-		 *      go to an ISR rather than here.  Need to instrument
-		 *      base interrupt handler.
-		 */
-		sleep_ticks = 0xFFFFFFFF;
-		break;
+		if (cx->type == ACPI_STATE_C1) { /* enter C1 */
+			safe_halt();
+			/*
+			 * TBD: Can't get time duration while in C1, as resumes
+			 *      go to an ISR rather than here.  Need to instrument
+			 *      base interrupt handler.
+			 */
+			sleep_ticks = cx->target_ticks + 1;
+		} else { /* enter C2 or C3 */
+			if (cx->type == ACPI_STATE_C3) {
+				if (pr->flags.bm_check) {
+					if (atomic_inc_return(&c3_cpu_count) ==
+						num_online_cpus()) {
+						/*
+						 * All CPUs are trying to go to C3
+						 * Disable bus master arbitration
+						 */
+						acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
+								  ACPI_MTX_DO_NOT_LOCK);
+					}
+				} else {
+					/* SMP with no shared cache... Invalidate cache  */
+					ACPI_FLUSH_CPU_CACHE();
+				}
+			}
 
-	case ACPI_STATE_C2:
-		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
-		/* Invoke C2 */
-		inb(cx->address);
-		/* Dummy wait op - must do something useless after P_LVL2 read
-		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
-		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+			/* Get start time (ticks) */
+			t1= inl(acpi_fadt.xpm_tmr_blk.address);
+			/* invoke the target C-state */
+			inb(cx->address);
+			/* Dummy wait op - must do something useless after P_LVL2/3 read
+			   because chipsets cannot guarantee that STPCLK# signal gets
+			   asserted in time to freeze execution properly. */
+			t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+			/* Get end time (ticks) */
+			t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+
+			if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
+				/* Enable bus master arbitration */
+				atomic_dec(&c3_cpu_count);
+				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
+						  ACPI_MTX_DO_NOT_LOCK);
+			}
 
 #ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C2, so notify users */
-		mark_tsc_unstable();
+			/* TSC halts, so notify users */
+			mark_tsc_unstable();
 #endif
-		/* Re-enable interrupts */
-		local_irq_enable();
-		current_thread_info()->status |= TS_POLLING;
-		/* Compute time (ticks) that we were actually asleep */
-		sleep_ticks =
-		    ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
-		break;
 
-	case ACPI_STATE_C3:
-
-		if (pr->flags.bm_check) {
-			if (atomic_inc_return(&c3_cpu_count) ==
-			    num_online_cpus()) {
-				/*
-				 * All CPUs are trying to go to C3
-				 * Disable bus master arbitration
-				 */
-				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1,
-						  ACPI_MTX_DO_NOT_LOCK);
-			}
-		} else {
-			/* SMP with no shared cache... Invalidate cache  */
-			ACPI_FLUSH_CPU_CACHE();
+			/* Compute time (ticks) that we were actually asleep */
+			sleep_ticks = ticks_elapsed(t1, t2);
 		}
 
-		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
-		/* Invoke C3 */
-		inb(cx->address);
-		/* Dummy wait op (see above) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
-		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
-		if (pr->flags.bm_check) {
-			/* Enable bus master arbitration */
-			atomic_dec(&c3_cpu_count);
-			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0,
-					  ACPI_MTX_DO_NOT_LOCK);
-		}
-
-#ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C3, so notify users */
-		mark_tsc_unstable();
-#endif
-		/* Re-enable interrupts */
 		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
-		/* Compute time (ticks) that we were actually asleep */
-		sleep_ticks =
-		    ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
-		break;
 
-	default:
-		local_irq_enable();
-		return;
-	}
-	cx->usage++;
-	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->usage++;
 		cx->time += sleep_ticks;
-
-	next_state = pr->power.state;
-
-#ifdef CONFIG_HOTPLUG_CPU
-	/* Don't do promotion/demotion */
-	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst && !acpi_fadt.plvl2_up) {
-		next_state = cx;
-		goto end;
-	}
-#endif
-
-	/*
-	 * Promotion?
-	 * ----------
-	 * Track the number of longs (time asleep is greater than threshold)
-	 * and promote when the count threshold is reached.  Note that bus
-	 * mastering activity may prevent promotions.
-	 * Do not promote above max_cstate.
-	 */
-	if (cx->promotion.state &&
-	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
-		if (sleep_ticks > cx->promotion.threshold.ticks) {
-			cx->promotion.count++;
-			cx->demotion.count = 0;
-			if (cx->promotion.count >=
-			    cx->promotion.threshold.count) {
-				if (pr->flags.bm_check) {
-					if (!
-					    (pr->power.bm_activity & cx->
-					     promotion.threshold.bm)) {
-						next_state =
-						    cx->promotion.state;
-						goto end;
-					}
-				} else {
-					next_state = cx->promotion.state;
-					goto end;
-				}
-			}
-		}
-	}
-
-	/*
-	 * Demotion?
-	 * ---------
-	 * Track the number of shorts (time asleep is less than time threshold)
-	 * and demote when the usage threshold is reached.
-	 */
-	if (cx->demotion.state) {
-		if (sleep_ticks < cx->demotion.threshold.ticks) {
-			cx->demotion.count++;
-			cx->promotion.count = 0;
-			if (cx->demotion.count >= cx->demotion.threshold.count) {
-				next_state = cx->demotion.state;
-				goto end;
-			}
-		}
 	}
 
-      end:
-	/*
-	 * Demote if current state exceeds max_cstate
-	 */
-	if ((pr->power.state - pr->power.states) > max_cstate) {
-		if (cx->demotion.state)
-			next_state = cx->demotion.state;
-	}
-
-	/*
-	 * New Cx State?
-	 * -------------
-	 * If we're going to start using a new Cx state we must clean up
-	 * from the previous and prepare to use the new.
-	 */
-	if (next_state != pr->power.state)
-		acpi_processor_power_activate(pr, next_state);
+	pr->power.last_ticks = sleep_ticks;
 }
 
+/**
+ * acpi_processor_set_power_policy - sets the default idle policy
+ * @pr: the processor
+ *
+ * This function sets the default Cx state policy (OS idle handler).
+ * Note that the Cx state policy is completely customizable and can
+ * be altered dynamically.
+ */
 static int acpi_processor_set_power_policy(struct acpi_processor *pr)
 {
 	unsigned int i;
 	unsigned int state_is_set = 0;
-	struct acpi_processor_cx *lower = NULL;
-	struct acpi_processor_cx *higher = NULL;
 	struct acpi_processor_cx *cx;
 
-
 	if (!pr)
 		return -EINVAL;
 
-	/*
-	 * This function sets the default Cx state policy (OS idle handler).
-	 * Our scheme is to promote quickly to C2 but more conservatively
-	 * to C3.  We're favoring C2  for its characteristics of low latency
-	 * (quick response), good power savings, and ability to allow bus
-	 * mastering activity.  Note that the Cx state policy is completely
-	 * customizable and can be altered dynamically.
-	 */
-
 	/* startup state */
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		cx = &pr->power.states[i];
@@ -546,41 +430,31 @@
 	if (!state_is_set)
 		return -ENODEV;
 
-	/* demotion */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	state_is_set = 0;
+
+	/* find deepest bus master compatible state */
+	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
 		cx = &pr->power.states[i];
 		if (!cx->valid)
 			continue;
+		if (cx->type == ACPI_STATE_C3)
+			continue;
 
-		if (lower) {
-			cx->demotion.state = lower;
-			cx->demotion.threshold.ticks = cx->latency_ticks;
-			cx->demotion.threshold.count = 1;
-			if (cx->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = bm_history;
-		}
-
-		lower = cx;
+		pr->power.bm_veto_state = i;
+		state_is_set = 1;
+		break;
 	}
 
-	/* promotion */
-	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
+	if (!state_is_set)
+		return -ENODEV;
+
+	/* determine target sleep ticks */
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		cx = &pr->power.states[i];
 		if (!cx->valid)
 			continue;
 
-		if (higher) {
-			cx->promotion.state = higher;
-			cx->promotion.threshold.ticks = cx->latency_ticks;
-			if (cx->type >= ACPI_STATE_C2)
-				cx->promotion.threshold.count = 4;
-			else
-				cx->promotion.threshold.count = 10;
-			if (higher->type == ACPI_STATE_C3)
-				cx->promotion.threshold.bm = bm_history;
-		}
-
-		higher = cx;
+		cx->target_ticks = cx->latency_ticks * RESIDENCY_TO_LATENCY_RATIO;
 	}
 
 	return 0;
@@ -1009,7 +883,7 @@
 
 	seq_printf(seq, "active state:            C%zd\n"
 		   "max_cstate:              C%d\n"
-		   "bus master activity:     %08x\n",
+		   "bus master activity:     %d\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
 		   max_cstate, (unsigned)pr->power.bm_activity);
 
@@ -1040,20 +914,6 @@
 			break;
 		}
 
-		if (pr->power.states[i].promotion.state)
-			seq_printf(seq, "promotion[C%zd] ",
-				   (pr->power.states[i].promotion.state -
-				    pr->power.states));
-		else
-			seq_puts(seq, "promotion[--] ");
-
-		if (pr->power.states[i].demotion.state)
-			seq_printf(seq, "demotion[C%zd] ",
-				   (pr->power.states[i].demotion.state -
-				    pr->power.states));
-		else
-			seq_puts(seq, "demotion[--] ");
-
 		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
 			   pr->power.states[i].latency,
 			   pr->power.states[i].usage,
--- a/include/acpi/processor.h	2006-08-28 17:14:40.000000000 -0400
+++ b/include/acpi/processor.h	2006-08-28 16:37:35.000000000 -0400
@@ -43,17 +43,6 @@
 	u64 address;
 } __attribute__ ((packed));
 
-struct acpi_processor_cx_policy {
-	u32 count;
-	struct acpi_processor_cx *state;
-	struct {
-		u32 time;
-		u32 ticks;
-		u32 count;
-		u32 bm;
-	} threshold;
-};
-
 struct acpi_processor_cx {
 	u8 valid;
 	u8 type;
@@ -63,15 +52,14 @@
 	u32 power;
 	u32 usage;
 	u64 time;
-	struct acpi_processor_cx_policy promotion;
-	struct acpi_processor_cx_policy demotion;
+	u32 target_ticks;
 };
 
 struct acpi_processor_power {
 	struct acpi_processor_cx *state;
-	unsigned long bm_check_timestamp;
-	u32 default_state;
 	u32 bm_activity;
+	u32 bm_veto_state;
+	u32 last_ticks;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };


