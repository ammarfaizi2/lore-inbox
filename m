Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbUKQEKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUKQEKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUKQEKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:10:13 -0500
Received: from mail.renesas.com ([202.234.163.13]:29930 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262204AbUKQEKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:10:01 -0500
Date: Wed, 17 Nov 2004 13:09:49 +0900 (JST)
Message-Id: <20041117.130949.468707905.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] m32r: Fix a boot hang of UP kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch of arch/m32r/kernel/time.c for m32r.

This patch fixes a hanging up at boot time of 2.6.10-rc2 m32r UP kernel.
It was due to a lack of update_process_times() in time.c.

Such a boot hang was caused only in UP systems, because 
update_process_times() had been executed correctly
in smp_local_timer_interrupt() of arch/m32r/kernel/smp.c for SMP.

Thanks.

	* arch/m32r/kernel/time.c:
	- UP: Fix do_timer_interrupt() to use update_process_times().
	- UP: Move profile_tick() into do_timer_interrupt().
	- Change __inline__ to inline.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/time.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

--- a/arch/m32r/kernel/time.c	2004-10-19 06:54:55.000000000 +0900
+++ b/arch/m32r/kernel/time.c	2004-11-17 12:04:14.000000000 +0900
@@ -193,7 +193,7 @@ EXPORT_SYMBOL(do_settimeofday);
  * BUG: This routine does not handle hour overflow properly; it just
  *      sets the minutes. Usually you won't notice until after reboot!
  */
-static __inline__ int set_rtc_mmss(unsigned long nowtime)
+static inline int set_rtc_mmss(unsigned long nowtime)
 {
 	return 0;
 }
@@ -205,11 +205,17 @@ static long last_rtc_update = 0;
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static __inline__ void do_timer_interrupt(int irq, void *dev_id,
-	struct pt_regs * regs)
+static inline void
+do_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
+#ifndef CONFIG_SMP
+	profile_tick(CPU_PROFILING, regs);
+#endif
 	do_timer(regs);
 
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -241,10 +247,6 @@ irqreturn_t timer_interrupt(int irq, voi
 	do_timer_interrupt(irq, NULL, regs);
 	write_sequnlock(&xtime_lock);
 
-#ifndef CONFIG_SMP
-	profile_tick(CPU_PROFILING, regs);
-#endif
-
 	return IRQ_HANDLED;
 }
 
@@ -314,4 +316,3 @@ unsigned long long sched_clock(void)
 {
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
