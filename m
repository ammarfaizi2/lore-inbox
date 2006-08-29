Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965347AbWH2Uue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965347AbWH2Uue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965344AbWH2Uu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:50:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29336 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965347AbWH2Uu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:50:27 -0400
Subject: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
From: Adam Belay <abelay@novell.com>
To: Len Brown <len.brown@intel.com>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 16:51:52 -0400
Message-Id: <1156884713.1781.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch takes advantage of the infrastructure introduced in the last
patch, and allows the processor idle algorithm to proactively choose a
c-state based on the time the next timer interrupt is expected to occur.
It preserves the residency metric, so the algorithm should, in theory,
remain effective against bursts of activity from other interrupt
sources.

This patch is mostly intended to be illustrative.  There may be some
"#ifdef CONFIG_ACPI" issues, and I would appreciate any advice on
implementing this more cleanly.

Cheers,
Adam

Patch is against 2.6.18-rc4.
Signed-off-by: Adam Belay <abelay@novell.com>

---
 drivers/acpi/processor_idle.c |   17 +++++++++++++++++
 include/acpi/processor.h      |    2 ++
 kernel/timer.c                |    7 +++++++
 3 files changed, 26 insertions(+)


--- a/drivers/acpi/processor_idle.c	2006-08-28 17:14:54.000000000 -0400
+++ b/drivers/acpi/processor_idle.c	2006-08-28 17:29:21.000000000 -0400
@@ -64,6 +64,7 @@
  * Currently, we aim for the entry/exit latency to be 20% of measured residency.
  */
 #define RESIDENCY_TO_LATENCY_RATIO	5
+#define TIMER_TICKS (PM_TIMER_FREQUENCY / HZ)
 
 /* --------------------------------------------------------------------------
                                 Power Management
@@ -271,6 +272,22 @@
 		int count = min(pr->power.count, (int) max_cstate);
 		cx = &pr->power.states[state_idx];
 
+		/*
+		 * We are proactive with timer interrupts.  After a timer
+		 * interrupt has occurred the previous sleep_ticks value is
+		 * restored.
+		 */
+		if (pr->power.pretimer_last_ticks) {
+			sleep_ticks = pr->power.pretimer_last_ticks;
+			pr->power.pretimer_last_ticks = 0;
+		}
+		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
+		i = TIMER_TICKS - t1 + pr->power.timer_tick;
+		if (i < sleep_ticks) {
+			pr->power.pretimer_last_ticks = sleep_ticks;
+			sleep_ticks = i;
+		}
+
 		if (cx->target_ticks < sleep_ticks) { /* promotion */
 			for (i = state_idx + 1; i <= count; i++) {
 				cx = &pr->power.states[i];
--- a/kernel/timer.c	2006-08-03 13:39:22.000000000 -0400
+++ b/kernel/timer.c	2006-08-28 17:16:36.000000000 -0400
@@ -41,6 +41,9 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
+#include <acpi/acpi_bus.h>
+#include <acpi/processor.h>
+
 #ifdef CONFIG_TIME_INTERPOLATION
 static void time_interpolator_update(long delta_nsec);
 #else
@@ -1175,6 +1178,10 @@
 {
 	struct task_struct *p = current;
 	int cpu = smp_processor_id();
+	struct acpi_processor *pr = processors[cpu];
+
+	if (pr)
+		pr->power.timer_tick = inl(acpi_fadt.xpm_tmr_blk.address);
 
 	/* Note: this timer irq context must be accounted for as well. */
 	if (user_tick)
--- a/include/acpi/processor.h	2006-08-28 17:14:54.000000000 -0400
+++ b/include/acpi/processor.h	2006-08-28 17:20:25.000000000 -0400
@@ -60,6 +60,8 @@
 	u32 bm_activity;
 	u32 bm_veto_state;
 	u32 last_ticks;
+	u32 timer_tick;
+	u32 pretimer_last_ticks;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };


