Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752166AbWCCCoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbWCCCoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbWCCCoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:44:12 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:9448 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1752166AbWCCCoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:44:10 -0500
Date: Fri, 03 Mar 2006 11:44:06 +0900 (JST)
Message-Id: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
To: clameter@engr.sgi.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ralf@linux-mips.org
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 2 Mar 2006 11:09:16 -0800 (PST), Christoph Lameter <clameter@engr.sgi.com> said:
>> In kernel 2.6, update_times() is called directly in timer
>> interrupt, so there is no point calculating ticks here.  This also
>> get rid of difference of jiffies and jiffies_64 due to compiler's
>> optimization (which was reported previously with subject
>> "jiffies_64 vs. jiffies").

clameter> If update_wall_time() and calc_load() are always called with
clameter> the constant one then you may be able to optimize these two
clameter> functions as well.

Sure.  I tried to do only one thing at a time, but it might be better
to clean them up together.  Patch revised.


In kernel 2.6, update_times() is called directly in timer interrupt,
so there is no point calculating ticks here.  Then update_wall_time()
and calc_load() can also be optimized.  This also get rid of
difference of jiffies and jiffies_64 due to compiler's optimization
(which was reported previously with subject "jiffies_64 vs. jiffies").

Also adjust x86_64 timer interrupt handler with this change.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 3080f84..7a1d790 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -423,7 +423,8 @@ void main_timer_handler(struct pt_regs *
 
 	if (lost > 0) {
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
+		while (lost--)
+			do_timer(regs);
 	}
 
 /*
diff --git a/kernel/timer.c b/kernel/timer.c
index fc6646f..54544a7 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -787,24 +787,14 @@ u64 current_tick_length(void)
 	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
 }
 
-/*
- * Using a loop looks inefficient, but "ticks" is
- * usually just one (we shouldn't be losing ticks,
- * we're doing this this way mainly for interrupt
- * latency reasons, not because we think we'll
- * have lots of lost timer ticks
- */
-static void update_wall_time(unsigned long ticks)
+static void update_wall_time(void)
 {
-	do {
-		ticks--;
-		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
-			xtime.tv_nsec -= 1000000000;
-			xtime.tv_sec++;
-			second_overflow();
-		}
-	} while (ticks);
+	update_wall_time_one_tick();
+	if (xtime.tv_nsec >= 1000000000) {
+		xtime.tv_nsec -= 1000000000;
+		xtime.tv_sec++;
+		second_overflow();
+	}
 }
 
 /*
@@ -849,15 +839,15 @@ unsigned long avenrun[3];
 EXPORT_SYMBOL(avenrun);
 
 /*
- * calc_load - given tick count, update the avenrun load estimates.
+ * calc_load - update the avenrun load estimates.
  * This is called while holding a write_lock on xtime_lock.
  */
-static inline void calc_load(unsigned long ticks)
+static inline void calc_load(void)
 {
 	unsigned long active_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
 
-	count -= ticks;
+	count--;
 	if (count < 0) {
 		count += LOAD_FREQ;
 		active_tasks = count_active_tasks();
@@ -906,14 +896,9 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
-	if (ticks) {
-		wall_jiffies += ticks;
-		update_wall_time(ticks);
-	}
-	calc_load(ticks);
+	wall_jiffies++;
+	update_wall_time();
+	calc_load();
 }
   
 /*
