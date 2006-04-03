Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWDCT5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWDCT5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWDCT5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:57:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1257 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964865AbWDCT5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:57:10 -0400
Date: Mon, 3 Apr 2006 21:57:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] periodic clocksource update
Message-ID: <Pine.LNX.4.64.0604032156430.4714@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This introduces the clocksource equivalent of do_timer().
clocksource_update() periodically updates the clocksource state, which
includes updating jiffies_64 and NTP state. After that we adjust the
clocksource multiplier to reduce the error difference between NTP
updates and clock updates.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/sched.h |    1 
 kernel/timer.c        |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2006-04-02 17:23:15.000000000 +0200
+++ linux-2.6-mm/include/linux/sched.h	2006-04-02 17:23:36.000000000 +0200
@@ -1044,6 +1044,7 @@ extern void switch_uid(struct user_struc
 #include <asm/current.h>
 
 extern void do_timer(struct pt_regs *);
+extern void clocksource_update(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-04-02 17:23:23.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-04-02 17:30:19.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/clocksource.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -923,6 +924,114 @@ void do_timer(struct pt_regs *regs)
 	update_times();
 }
 
+/*
+ * Periodically update the clocksource
+ */
+static inline void clocksource_update_tick(void)
+{
+	curr_clocksource->cycles_last += curr_clocksource->cycle_update;
+	curr_clocksource->xtime_nsec += curr_clocksource->xtime_update;
+	if (curr_clocksource->xtime_nsec >= (u64)NSEC_PER_SEC << curr_clocksource->shift) {
+		curr_clocksource->xtime_nsec -= (u64)NSEC_PER_SEC << curr_clocksource->shift;
+		xtime.tv_sec++;
+		second_overflow();
+	}
+	jiffies_64++;
+	curr_clocksource->ntp_error += current_tick_length();
+	curr_clocksource->ntp_error -= curr_clocksource->xtime_update << (32 - curr_clocksource->shift);
+
+	if (time_next_adjust) {
+		time_adjust = time_next_adjust;
+		time_next_adjust = 0;
+	} else if (time_adjust)
+		time_adjust -= adjtime_adjustment();
+}
+
+/*
+ * If the error is already larger, we look ahead another tick,
+ * to compensate for late or lost adjustments.
+ */
+static int __always_inline clocksource_bigadjust(int sign, s64 error, s64 update)
+{
+	int adj = 0;
+
+	error += current_tick_length() >> (33 - curr_clocksource->shift);
+	error -= curr_clocksource->xtime_update >> 1;
+
+	while (1) {
+		error >>= 1;
+		if (likely(sign > 0 ? error <= update : error >= update))
+			return adj;
+		adj++;
+	}
+}
+
+#define clocksource_adjustcheck(sign, error, update, offset) ({		\
+	int adj = sign;							\
+	error >>= 2;							\
+	if (unlikely(sign > 0 ? error > update : error < update)) {	\
+		adj = clocksource_bigadjust(sign, error, update);	\
+		update <<= adj;						\
+		offset <<= adj;						\
+		adj = sign << adj;					\
+	}								\
+	adj;								\
+})
+
+/*
+ * adjust the multiplier to reduce the error value,
+ * this is optimized for the most common adjustments of -1,0,1,
+ * for other values we can do a bit more work.
+ */
+static void clocksource_adjust(s64 offset)
+{
+	s64 error = curr_clocksource->ntp_error >> (31 - curr_clocksource->shift);
+	s64 update = curr_clocksource->cycle_update;
+	int adj;
+
+	if (error > update) {
+		adj = clocksource_adjustcheck(1, error, update, offset);
+	} else if (error < -update) {
+		update = -update;
+		offset = -offset;
+		adj = clocksource_adjustcheck(-1, error, update, offset);
+	} else
+		goto done;
+
+	curr_clocksource->mult += adj;
+	curr_clocksource->xtime_update += update;
+	curr_clocksource->xtime_nsec -= offset;
+	curr_clocksource->ntp_error -= (update - offset) << (32 - curr_clocksource->shift);
+done:
+	xtime.tv_nsec = curr_clocksource->xtime_nsec >> curr_clocksource->shift;
+}
+
+void clocksource_update(struct pt_regs *regs)
+{
+	unsigned long ticks;
+	u64 cycles, cycle_offset;
+
+	cycles = curr_clocksource->read();
+	while (1) {
+		cycle_offset = cycles - curr_clocksource->cycles_last;
+		cycle_offset &= curr_clocksource->mask;
+		if (cycle_offset < curr_clocksource->cycle_update)
+			break;
+		clocksource_update_tick();
+	}
+
+	clocksource_adjust(cycle_offset);
+
+	/* prevent loading jiffies before storing new jiffies_64 value. */
+	barrier();
+	ticks = jiffies - wall_jiffies;
+	if (ticks) {
+		wall_jiffies += ticks;
+		calc_load(ticks);
+	}
+	softlockup_tick();
+}
+
 #ifdef __ARCH_WANT_SYS_ALARM
 
 /*
