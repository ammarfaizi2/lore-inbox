Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWCUUdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWCUUdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWCUUdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:33:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21977 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751149AbWCUUdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:33:00 -0500
Date: Tue, 21 Mar 2006 14:32:49 -0600
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org
Subject: [RFC] - Move call to calc_load()
Message-ID: <20060321203249.GA16182@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone know why calc_load() must be called under the protection of the
xtime_lock???


One of the big-system hot spots that I am chasing involves timers, nsec
clocks, hrtimer, and related functions. I added debug code to see why
these paths are so bad on large systems.

At least part of the problem is in the following code path:

        timer_interrupt
            lock xtime_lock
            do_timer
               update_times
                 calc_load
            unlock xtimer_lock


Once every 5 sec, update_times() calls calc_load(). On a large systems
depending on load, it can take several msec to calculate the load averages..
During this entire time, the xtime_lock is held. Any other cpu that calls
current_kernel_time(), getnstimeofday(), do_gettimeofday() or similar
functions will spin for the remaining time that xtime_lock is held.

Code added to getnstimeofday() shows that this function iterates an average
of 3200 times thru the read_seqbegin/read_seqretry loop once every 5 sec
when the system is running an application that causes a lot of memory
traffic (512p system).

Question: why is it necessary to hold the xtime_lock when doing the
calculation of calc_load(). calc_load() recalculates the recent system
load. This calculation is statisticaly in nature - it does not seem to
warrant a heavyweight lock such as xtime_lock.

calc_load() updates avenrun[]. There are only 3 consumers of this
data:

        loadavg_read_proc - this function ignores xtime_lock. It reads the
                avenrun[] without checking locks. Removing the xtime_lock
                will have no effect.

        sys_sysinfo - this function uses xtime_lock to atomically read
                avenrun, getnstimeofday() & nr_threads. I understand
		why getnstimeofday & wall_to_monotonic should be read
		atomically. However, I don't see why avenrun[]
		must also be read atomically.

	net/sched/em_meta.c - ignores xtime_lock.

None of these would appear to require a lock for accesses to avenrun[].
What have I overlooked??


Here is the patch that I am proposing. This patch is incomplete because it
addresses only the IA64 architecture. If this approach is acceptible, I'll
update the patch to cover all architectures.

	Signed-off-by: Jack Steiner <steiner@sgi.com>

	 arch/ia64/kernel/time.c |    5 +++--
	 include/linux/sched.h   |    3 ++-
	 kernel/timer.c          |   13 ++++++++-----
	 3 files changed, 13 insertions(+), 8 deletions(-)



Index: linux/arch/ia64/kernel/time.c
===================================================================
--- linux.orig/arch/ia64/kernel/time.c	2006-03-21 10:15:38.000000000 -0600
+++ linux/arch/ia64/kernel/time.c	2006-03-21 10:17:23.746892642 -0600
@@ -50,7 +50,7 @@ static struct time_interpolator itc_inte
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
-	unsigned long new_itm;
+	unsigned long new_itm, ticks;
 
 	if (unlikely(cpu_is_offline(smp_processor_id()))) {
 		return IRQ_HANDLED;
@@ -79,9 +79,10 @@ timer_interrupt (int irq, void *dev_id, 
 			 * xtime_lock.
 			 */
 			write_seqlock(&xtime_lock);
-			do_timer(regs);
+			ticks = do_timer(regs);
 			local_cpu_data->itm_next = new_itm;
 			write_sequnlock(&xtime_lock);
+			calc_load(ticks);
 		} else
 			local_cpu_data->itm_next = new_itm;
 
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-03-21 10:15:37.000000000 -0600
+++ linux/include/linux/sched.h	2006-03-21 10:16:19.562739421 -0600
@@ -1152,7 +1152,8 @@ extern void switch_uid(struct user_struc
 
 #include <asm/current.h>
 
-extern void do_timer(struct pt_regs *);
+extern unsigned long do_timer(struct pt_regs *);
+extern void calc_load(unsigned long ticks);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c	2006-03-21 10:15:37.000000000 -0600
+++ linux/kernel/timer.c	2006-03-21 10:16:19.564692355 -0600
@@ -871,7 +871,7 @@ EXPORT_SYMBOL(avenrun);
  * calc_load - given tick count, update the avenrun load estimates.
  * This is called while holding a write_lock on xtime_lock.
  */
-static inline void calc_load(unsigned long ticks)
+void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
@@ -923,7 +923,7 @@ void run_local_timers(void)
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
-static inline void update_times(void)
+static inline unsigned long update_times(void)
 {
 	unsigned long ticks;
 
@@ -932,7 +932,7 @@ static inline void update_times(void)
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
-	calc_load(ticks);
+	return ticks;
 }
   
 /*
@@ -941,13 +941,16 @@ static inline void update_times(void)
  * jiffies is defined in the linker script...
  */
 
-void do_timer(struct pt_regs *regs)
+unsigned long do_timer(struct pt_regs *regs)
 {
+	unsigned long ticks;
+
 	jiffies_64++;
 	/* prevent loading jiffies before storing new jiffies_64 value. */
 	barrier();
-	update_times();
+	ticks = update_times();
 	softlockup_tick(regs);
+	return ticks;
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM
