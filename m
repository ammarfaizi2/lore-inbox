Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317301AbSFRDpw>; Mon, 17 Jun 2002 23:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSFRDpv>; Mon, 17 Jun 2002 23:45:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50168 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317301AbSFRDpu>;
	Mon, 17 Jun 2002 23:45:50 -0400
Message-ID: <3D0EACCA.3290139@mvista.com>
Date: Mon, 17 Jun 2002 20:45:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>, Robert Love <rml@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Replace timer_bh with tasklet
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the timer_bh with a tasklet.  It also
introduces
a way to flag a tasklet as a must run (i.e. do NOT kick up
to ksoftirqd).

It make NO sense to pass timer work to a task.

Comments...




diff -urN linux-2.5.22/include/linux/interrupt.h
linux/include/linux/interrupt.h
--- linux-2.5.22/include/linux/interrupt.h	Sun Jun 16
19:31:22 2002
+++ linux/include/linux/interrupt.h	Mon Jun 17 15:58:59 2002
@@ -57,12 +57,19 @@
 
 enum
 {
-	HI_SOFTIRQ=0,
+	RUN_TIMER_LIST=0,
+	HI_SOFTIRQ,
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	TASKLET_SOFTIRQ
 };
 
+/*
+ * The ALWAYS_SOFTIRQ tasks will always be called
repeatedly (until
+ * the pending bit stays cleared) each time do_softirq is
called.
+ */
+#define ALWAYS_SOFTIRQ		(1 << RUN_TIMER_LIST)
+
 /* softirq mask and active fields moved to irq_cpustat_t in
  * asm/hardirq.h to get better cache usage.  KAO
  */
@@ -74,6 +81,7 @@
 };
 
 asmlinkage void do_softirq(void);
+extern void timer_softirq(struct softirq_action* a);
 extern void open_softirq(int nr, void (*action)(struct
softirq_action*), void *data);
 extern void softirq_init(void);
 #define __cpu_raise_softirq(cpu, nr) do {
softirq_pending(cpu) |= 1UL << (nr); } while (0)
diff -urN linux-2.5.22/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.22/kernel/sched.c	Sun Jun 16 19:31:27 2002
+++ linux/kernel/sched.c	Mon Jun 17 15:57:06 2002
@@ -1633,7 +1633,6 @@
 }
 
 extern void init_timervecs(void);
-extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
 
@@ -1671,7 +1670,6 @@
 	wake_up_process(current);
 
 	init_timervecs();
-	init_bh(TIMER_BH, timer_bh);
 	init_bh(TQUEUE_BH, tqueue_bh);
 	init_bh(IMMEDIATE_BH, immediate_bh);
 
diff -urN linux-2.5.22/kernel/softirq.c
linux/kernel/softirq.c
--- linux-2.5.22/kernel/softirq.c	Sun Jun 16 19:31:27 2002
+++ linux/kernel/softirq.c	Mon Jun 17 16:00:03 2002
@@ -96,7 +96,7 @@
 		local_irq_disable();
 
 		pending = softirq_pending(cpu);
-		if (pending & mask) {
+		if (pending & (mask | ALWAYS_SOFTIRQ)) {
 			mask &= ~pending;
 			goto restart;
 		}
@@ -332,6 +332,7 @@
 
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
+	open_softirq(RUN_TIMER_LIST,timer_softirq, NULL);
 }
 
 void __run_task_queue(task_queue *list)
diff -urN linux-2.5.22/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.22/kernel/timer.c	Sun Jun 16 19:31:28 2002
+++ linux/kernel/timer.c	Mon Jun 17 16:02:54 2002
@@ -14,6 +14,7 @@
  *                              Copyright (C) 1998  Andrea
Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
  *  2002-05-31	Move sys_sysinfo here and make its locking
sane, Robert Love
+ *  2002-06-17	Run timers off a tasklet and remove TIMER_BH
  */
 
 #include <linux/config.h>
@@ -37,6 +38,12 @@
 /* The current time */
 struct timeval xtime __attribute__ ((aligned (16)));
 
+/*
+ * This atomic prevents re-entry of the run_timer_list and
has the side
+ * effect of shifting conflict runs to the "owning" cpu.
+ */
+static atomic_t timer_tasklet_lock = ATOMIC_INIT(-1);
+
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
@@ -645,7 +652,7 @@
 	unsigned long ticks;
 
 	/*
-	 * update_times() is run from the raw timer_bh handler so
we
+	 * update_times() is run from the raw timer_tasklet so we
 	 * just know that the irqs are locally enabled and so we
don't
 	 * need to save/restore the flags of the local CPU here.
-arca
 	 */
@@ -661,10 +668,24 @@
 	write_unlock_irq(&xtime_lock);
 }
 
-void timer_bh(void)
+
+/*
+ * timer_tasklet_lock starts at -1.  0 then means it is
cool to
+ * continue.  If another cpu bumps it while the first is
still in
+ * run_timer_list, it will be detected on exit and we will
run it
+ * again.  But multiple entries are not needed, just once
for all the
+ * "hits" while we are in run_timer_list.
+ */
+void timer_softirq(struct softirq_action* a)
 {
-	update_times();
-	run_timer_list();
+	if (!atomic_inc_and_test(&timer_tasklet_lock))
+		return;
+
+        do {
+		atomic_set(&timer_tasklet_lock, 0);
+		update_times();
+		run_timer_list();
+        } while (!atomic_add_negative(-1,
&timer_tasklet_lock));
 }
 
 void do_timer(struct pt_regs *regs)
@@ -675,7 +696,7 @@
 
 	update_process_times(user_mode(regs));
 #endif
-	mark_bh(TIMER_BH);
+	raise_softirq( RUN_TIMER_LIST );
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
