Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSGDMvM>; Thu, 4 Jul 2002 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGDMvL>; Thu, 4 Jul 2002 08:51:11 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17392 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317401AbSGDMvK> convert rfc822-to-8bit;
	Thu, 4 Jul 2002 08:51:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.org
Subject: [PATCH] do_timer api change common part. 
Date: Thu, 4 Jul 2002 14:48:22 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207041448.22860.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
while working with my timer patch stuff I  wondered about two details of
do_timer and update_process_times. It bothered me that do_timer calls
update_process_times in the non smp case. In the smp case it is cleanly
separated, so why not let the caller of do_timer always do the call to
update_process_times?
The second thing is that you can only account for a single tick with a
call to do_timer & update_process_times.

I extracted the relevant parts of the timer patch for review. The arch part
of the change is in the second mail and is only relevant if this first one
makes sense to you.

blue skies,
  Martin.

diff -urN linux-2.5.24/include/linux/sched.h linux-2.5.24-timer/include/linux/sched.h
--- linux-2.5.24/include/linux/sched.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-timer/include/linux/sched.h	Thu Jul  4 13:17:38 2002
@@ -147,7 +147,8 @@
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
-extern void update_process_times(int user);
+extern void update_process_times(unsigned long user_ticks,
+				 unsigned long system_ticks);
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
@@ -482,7 +483,7 @@
 
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern void do_timer(struct pt_regs *);
+extern void do_timer(unsigned long ticks);
 
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
diff -urN linux-2.5.24/kernel/timer.c linux-2.5.24-timer/kernel/timer.c
--- linux-2.5.24/kernel/timer.c	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-timer/kernel/timer.c	Thu Jul  4 13:17:38 2002
@@ -462,8 +462,7 @@
 #endif
 }
 
-/* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+void update_wall_time(unsigned long ticks)
 {
 	if ( (time_adjust_step = time_adjust) != 0 ) {
 	    /* We are doing an adjtime thing. 
@@ -474,21 +473,22 @@
 	     *
 	     * Limit the amount of the step to be in the range
 	     * -tickadj .. +tickadj
+	     * per tick.
 	     */
-	     if (time_adjust > tickadj)
-		time_adjust_step = tickadj;
-	     else if (time_adjust < -tickadj)
-		time_adjust_step = -tickadj;
+	     if (time_adjust > tickadj*ticks)
+		time_adjust_step = tickadj*ticks;
+	     else if (time_adjust < -tickadj*ticks)
+		time_adjust_step = -tickadj*ticks;
 	     
 	    /* Reduce by this step the amount of time left  */
 	    time_adjust -= time_adjust_step;
 	}
-	xtime.tv_usec += tick + time_adjust_step;
+	xtime.tv_usec += tick*ticks + time_adjust_step;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
 	 */
-	time_phase += time_adj;
+	time_phase += time_adj*ticks;
 	if (time_phase <= -FINEUSEC) {
 		long ltemp = -time_phase >> SHIFT_SCALE;
 		time_phase += ltemp << SHIFT_SCALE;
@@ -499,23 +499,8 @@
 		time_phase -= ltemp << SHIFT_SCALE;
 		xtime.tv_usec += ltemp;
 	}
-}
-
-/*
- * Using a loop looks inefficient, but "ticks" is
- * usually just one (we shouldn't be losing ticks,
- * we're doing this this way mainly for interrupt
- * latency reasons, not because we think we'll
- * have lots of lost timer ticks
- */
-static void update_wall_time(unsigned long ticks)
-{
-	do {
-		ticks--;
-		update_wall_time_one_tick();
-	} while (ticks);
 
-	if (xtime.tv_usec >= 1000000) {
+	while (xtime.tv_usec >= 1000000) {
 	    xtime.tv_usec -= 1000000;
 	    xtime.tv_sec++;
 	    second_overflow();
@@ -580,13 +565,13 @@
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
  */
-void update_process_times(int user_tick)
+void update_process_times(unsigned long user_ticks, unsigned long system_ticks)
 {
 	struct task_struct *p = current;
-	int cpu = smp_processor_id(), system = user_tick ^ 1;
+	int cpu = smp_processor_id();
 
-	update_one_process(p, user_tick, system, cpu);
-	scheduler_tick(user_tick, system);
+	update_one_process(p, user_ticks, system_ticks, cpu);
+	scheduler_tick(user_ticks, system_ticks);
 }
 
 /*
@@ -617,7 +602,7 @@
 	static int count = LOAD_FREQ;
 
 	count -= ticks;
-	if (count < 0) {
+	while (count < 0) {
 		count += LOAD_FREQ;
 		active_tasks = count_active_tasks();
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
@@ -663,14 +648,9 @@
 	run_timer_list();
 }
 
-void do_timer(struct pt_regs *regs)
+void do_timer(unsigned long ticks)
 {
-	jiffies_64++;
-#ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
-	update_process_times(user_mode(regs));
-#endif
+	jiffies_64 += ticks;
 	mark_bh(TIMER_BH);
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);

