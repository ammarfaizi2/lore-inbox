Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSI2Rjy>; Sun, 29 Sep 2002 13:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSI2Rjx>; Sun, 29 Sep 2002 13:39:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30683 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261409AbSI2RjH>;
	Sun, 29 Sep 2002 13:39:07 -0400
Date: Sun, 29 Sep 2002 19:52:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is the smptimers patch plus the removal of old BHs and
a rewrite of task-queue handling.

Basically with the removal of TIMER_BH i think the time is right to get
rid of old BHs forever, and to do a massive cleanup of all related fields.
The following five basic 'execution context' abstractions are supported by
the kernel:

  - hardirq
  - softirq
  - tasklet
  - keventd-driven task-queues
  - process contexts

i've done the following cleanups/simplifications to task-queues:

 - removed the ability to define your own task-queue, what can be done is 
   to schedule_task() a given task to keventd, and to flush all pending 
   tasks.

this is actually a quite easy transition, since 90% of all task-queue
users in the kernel used BH_IMMEDIATE - which is very similar in
functionality to keventd.

i believe task-queues should not be removed from the kernel altogether.
It's true that they were written as a candidate replacement for BHs
originally, but they do make sense in a different way: it's perhaps the
easiest interface to do deferred processing from IRQ context, in
performance-uncritical code areas. They are easier to use than tasklets.

code that cares about performance should convert to tasklets - as the
timer code and the serial subsystem has done already. For extreme
performance softirqs should be used - the net subsystem does this.

and we can do this for 2.6 - there are only a couple of areas left after
fixing all the BH_IMMEDIATE places.

i have moved all the taskqueue handling code into kernel/context.c, and
only kept the basic 'queue a task' definitions in include/linux/tqueue.h.
I've converted three of the most commonly used BH_IMMEDIATE users:
tty_io.c, floppy.c and random.c. [random.c might need more thought
though.]

i've also cleaned up kernel/timer.c over that of the stock smptimers
patch: privatized the timer-vec definitions (nothing needs it,
init_timer() used it mistakenly) and cleaned up the code. Plus i've moved
some code around that does not belong into timer.c, and within timer.c
i've organized data and functions along functionality and further
separated the base timer code from the NTP bits.

net_bh_lock: i have removed it, since it would synchronize to nothing. The
old protocol handlers should still run on UP, and on SMP the kernel prints
a warning upon use. Alexey, is this approach fine with you?

scalable timers: i've further improved the patch ported to 2.5 by wli and
Dipankar. There is only one pending issue i can see, the question of
whether to migrate timers in mod_timer() or not. I'm quite convinced that
they should be migrated, but i might be wrong. It's a 10 lines change to
switch between migrating and non-migrating timers, we can do performance
tests later on. The current, more complex migration code is pretty fast
and has been stable under extremely high networking loads in the past 2
years, so we can immediately switch to the simpler variant if someone
proves it improves performance. (I'd say if non-migrating timers improve
Apache performance on one of the bigger NUMA boxes then the point is
proven, no further though will be needed.)

would this patch be an acceptable approach? We could avoid all the fuss
about synchronizing the timer execution to the old-BH (and tq) paradigms
by removing those right on the spot.

The attached patch (against BK-curr) compiles, boots & works just fine on
x86 SMP and UP. I've done some wider functionality testing as well (X,
mouse, other input and console features, networking), and it all appears
to work just fine.

	Ingo

--- linux/drivers/net/eepro100.c.orig	Fri Sep 20 17:20:31 2002
+++ linux/drivers/net/eepro100.c	Sun Sep 29 17:53:24 2002
@@ -1210,9 +1210,6 @@
 	/* We must continue to monitor the media. */
 	sp->timer.expires = RUN_AT(2*HZ); 			/* 2.0 sec. */
 	add_timer(&sp->timer);
-#if defined(timer_exit)
-	timer_exit(&sp->timer);
-#endif
 }
 
 static void speedo_show_state(struct net_device *dev)
--- linux/drivers/char/random.c.orig	Sun Sep 29 18:26:17 2002
+++ linux/drivers/char/random.c	Sun Sep 29 18:27:01 2002
@@ -649,7 +649,7 @@
  * Changes to the entropy data is put into a queue rather than being added to
  * the entropy counts directly.  This is presumably to avoid doing heavy
  * hashing calculations during an interrupt in add_timer_randomness().
- * Instead, the entropy is only added to the pool once per timer tick.
+ * Instead, the entropy is only added to the pool by keventd.
  */
 void batch_entropy_store(u32 a, u32 b, int num)
 {
@@ -664,7 +664,8 @@
 
 	new = (batch_head+1) & (batch_max-1);
 	if (new != batch_tail) {
-		queue_task(&batch_tqueue, &tq_timer);
+		// FIXME: is this correct?
+		schedule_task(&batch_tqueue);
 		batch_head = new;
 	} else {
 		DEBUG_ENT("batch entropy buffer full\n");
--- linux/drivers/char/tty_io.c.orig	Sun Sep 29 18:11:49 2002
+++ linux/drivers/char/tty_io.c	Sun Sep 29 18:14:34 2002
@@ -1265,7 +1265,6 @@
 	/*
 	 * Make sure that the tty's task queue isn't activated. 
 	 */
-	run_task_queue(&tq_timer);
 	flush_scheduled_tasks();
 
 	/* 
@@ -1876,7 +1875,6 @@
 
 /*
  * The tq handling here is a little racy - tty->SAK_tq may already be queued.
- * But there's no mechanism to fix that without futzing with tqueue_lock.
  * Fortunately we don't need to worry, because if ->SAK_tq is already queued,
  * the values which we write to it will be identical to the values which it
  * already has. --akpm
@@ -1902,7 +1900,7 @@
 	unsigned long flags;
 
 	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		queue_task(&tty->flip.tqueue, &tq_timer);
+		schedule_task(&tty->flip.tqueue);
 		return;
 	}
 	if (tty->flip.buf_num) {
@@ -1979,7 +1977,7 @@
 	if (tty->low_latency)
 		flush_to_ldisc((void *) tty);
 	else
-		queue_task(&tty->flip.tqueue, &tq_timer);
+		schedule_task(&tty->flip.tqueue);
 }
 
 /*
--- linux/drivers/block/floppy.c.orig	Sun Sep 29 18:29:09 2002
+++ linux/drivers/block/floppy.c	Sun Sep 29 18:30:22 2002
@@ -1009,8 +1009,7 @@
 static void schedule_bh( void (*handler)(void*) )
 {
 	floppy_tq.routine = (void *)(void *) handler;
-	queue_task(&floppy_tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&floppy_tq);
 }
 
 static struct timer_list fd_timer;
@@ -4361,7 +4360,7 @@
 	if (have_no_fdc) 
 	{
 		DPRINT("no floppy controllers found\n");
-		run_task_queue(&tq_immediate);
+		flush_scheduled_tasks();
 		if (usage_count)
 			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
--- linux/arch/i386/mm/fault.c.orig	Fri Sep 20 17:20:13 2002
+++ linux/arch/i386/mm/fault.c	Sun Sep 29 17:53:24 2002
@@ -99,18 +99,14 @@
 	goto bad_area;
 }
 
-extern spinlock_t timerlist_lock;
-
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
+ * message out 
  */
 void bust_spinlocks(int yes)
 {
 	int loglevel_save = console_loglevel;
 
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 		return;
--- linux/fs/file_table.c.orig	Sun Sep 29 18:52:58 2002
+++ linux/fs/file_table.c	Sun Sep 29 18:53:20 2002
@@ -25,6 +25,9 @@
 /* public *and* exported. Not pretty! */
 spinlock_t files_lock = SPIN_LOCK_UNLOCKED;
 
+/* file version */
+unsigned long event;
+
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
--- linux/include/linux/interrupt.h.orig	Fri Sep 20 17:20:29 2002
+++ linux/include/linux/interrupt.h	Sun Sep 29 17:53:24 2002
@@ -22,25 +22,6 @@
 	struct irqaction *next;
 };
 
-
-/* Who gets which entry in bh_base.  Things which will occur most often
-   should come first */
-   
-enum {
-	TIMER_BH = 0,
-	TQUEUE_BH = 1,
-	DIGI_BH = 2,
-	SERIAL_BH = 3,
-	RISCOM8_BH = 4,
-	SPECIALIX_BH = 5,
-	AURORA_BH = 6,
-	ESP_BH = 7,
-	IMMEDIATE_BH = 9,
-	CYCLADES_BH = 10,
-	MACSERIAL_BH = 13,
-	ISICOM_BH = 14
-};
-
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
 
@@ -217,23 +198,6 @@
 #define SMP_TIMER_DEFINE(name, task)
 
 #endif /* CONFIG_SMP */
-
-
-/* Old BH definitions */
-
-extern struct tasklet_struct bh_task_vec[];
-
-/* It is exported _ONLY_ for wait_on_irq(). */
-extern spinlock_t global_bh_lock;
-
-static inline void mark_bh(int nr)
-{
-	tasklet_hi_schedule(bh_task_vec+nr);
-}
-
-extern void init_bh(int nr, void (*routine)(void));
-extern void remove_bh(int nr);
-
 
 /*
  * Autoprobing for irqs:
--- linux/include/linux/timer.h.orig	Fri Sep 20 17:20:19 2002
+++ linux/include/linux/timer.h	Sun Sep 29 19:07:24 2002
@@ -2,11 +2,15 @@
 #define _LINUX_TIMER_H
 
 #include <linux/config.h>
+#include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+
+struct tvec_t_base_s;
 
 /*
- * In Linux 2.4, static timers have been removed from the kernel.
  * Timers may be dynamically created and destroyed, and should be initialized
  * by a call to init_timer() upon creation.
  *
@@ -14,22 +18,31 @@
  * timeouts. You can use this field to distinguish between the different
  * invocations.
  */
-struct timer_list {
+typedef struct timer_list {
 	struct list_head list;
 	unsigned long expires;
 	unsigned long data;
 	void (*function)(unsigned long);
-};
-
-extern void add_timer(struct timer_list * timer);
-extern int del_timer(struct timer_list * timer);
+	struct tvec_t_base_s *base;
+} timer_t;
 
+extern void add_timer(timer_t * timer);
+extern int del_timer(timer_t * timer);
+  
 #ifdef CONFIG_SMP
-extern int del_timer_sync(struct timer_list * timer);
+extern int del_timer_sync(timer_t * timer);
+extern void sync_timers(void);
+#define timer_enter(base, t) do { base->running_timer = t; mb(); } while (0)
+#define timer_exit(base) do { base->running_timer = NULL; } while (0)
+#define timer_is_running(base,t) (base->running_timer == t)
+#define timer_synchronize(base,t) while (timer_is_running(base,t)) barrier()
 #else
 #define del_timer_sync(t)	del_timer(t)
+#define sync_timers()		do { } while (0)
+#define timer_enter(base,t)          do { } while (0)
+#define timer_exit(base)            do { } while (0)
 #endif
-
+  
 /*
  * mod_timer is a more efficient way to update the expire field of an
  * active timer (if the timer is inactive it will be activated)
@@ -37,16 +50,20 @@
  * If the timer is known to be not pending (ie, in the handler), mod_timer
  * is less efficient than a->expires = b; add_timer(a).
  */
-int mod_timer(struct timer_list *timer, unsigned long expires);
+int mod_timer(timer_t *timer, unsigned long expires);
 
 extern void it_real_fn(unsigned long);
 
-static inline void init_timer(struct timer_list * timer)
+extern void init_timers(void);
+extern void run_local_timers(void);
+
+static inline void init_timer(timer_t * timer)
 {
 	timer->list.next = timer->list.prev = NULL;
+	timer->base = NULL;
 }
 
-static inline int timer_pending (const struct timer_list * timer)
+static inline int timer_pending(const timer_t * timer)
 {
 	return timer->list.next != NULL;
 }
--- linux/include/linux/sched.h.orig	Sun Sep 29 18:33:10 2002
+++ linux/include/linux/sched.h	Sun Sep 29 18:33:14 2002
@@ -172,7 +172,6 @@
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
 
-extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
 
--- linux/include/linux/tqueue.h.orig	Sun Sep 29 18:15:16 2002
+++ linux/include/linux/tqueue.h	Sun Sep 29 18:33:39 2002
@@ -1,13 +1,12 @@
 /*
  * tqueue.h --- task queue handling for Linux.
  *
- * Mostly based on a proposed bottom-half replacement code written by
- * Kai Petzke, wpp@marie.physik.tu-berlin.de.
+ * Modified version of previous incarnations of task-queues,
+ * written by:
  *
+ * (C) 1994 Kai Petzke, wpp@marie.physik.tu-berlin.de
  * Modified for use in the Linux kernel by Theodore Ts'o,
- * tytso@mit.edu.  Any bugs are my fault, not Kai's.
- *
- * The original comment follows below.
+ * tytso@mit.edu.
  */
 
 #ifndef _LINUX_TQUEUE_H
@@ -18,25 +17,8 @@
 #include <linux/bitops.h>
 #include <asm/system.h>
 
-/*
- * New proposed "bottom half" handlers:
- * (C) 1994 Kai Petzke, wpp@marie.physik.tu-berlin.de
- *
- * Advantages:
- * - Bottom halfs are implemented as a linked list.  You can have as many
- *   of them, as you want.
- * - No more scanning of a bit field is required upon call of a bottom half.
- * - Support for chained bottom half lists.  The run_task_queue() function can be
- *   used as a bottom half handler.  This is for example useful for bottom
- *   halfs, which want to be delayed until the next clock tick.
- *
- * Notes:
- * - Bottom halfs are called in the reverse order that they were linked into
- *   the list.
- */
-
 struct tq_struct {
-	struct list_head list;		/* linked list of active bh's */
+	struct list_head list;		/* linked list of active tq's */
 	unsigned long sync;		/* must be initialized to zero */
 	void (*routine)(void *);	/* function to call */
 	void *data;			/* argument to function */
@@ -61,68 +43,13 @@
 		PREPARE_TQUEUE((_tq), (_routine), (_data));	\
 	} while (0)
 
-typedef struct list_head task_queue;
-
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
-#define TQ_ACTIVE(q)		(!list_empty(&q))
-
-extern task_queue tq_timer, tq_immediate;
-
-/*
- * To implement your own list of active bottom halfs, use the following
- * two definitions:
- *
- * DECLARE_TASK_QUEUE(my_tqueue);
- * struct tq_struct my_task = {
- * 	routine: (void (*)(void *)) my_routine,
- *	data: &my_data
- * };
- *
- * To activate a bottom half on a list, use:
- *
- *	queue_task(&my_task, &my_tqueue);
- *
- * To later run the queued tasks use
- *
- *	run_task_queue(&my_tqueue);
- *
- * This allows you to do deferred processing.  For example, you could
- * have a task queue called tq_timer, which is executed within the timer
- * interrupt.
- */
-
-extern spinlock_t tqueue_lock;
-
-/*
- * Queue a task on a tq.  Return non-zero if it was successfully
- * added.
- */
-static inline int queue_task(struct tq_struct *bh_pointer, task_queue *bh_list)
-{
-	int ret = 0;
-	if (!test_and_set_bit(0,&bh_pointer->sync)) {
-		unsigned long flags;
-		spin_lock_irqsave(&tqueue_lock, flags);
-		list_add_tail(&bh_pointer->list, bh_list);
-		spin_unlock_irqrestore(&tqueue_lock, flags);
-		ret = 1;
-	}
-	return ret;
-}
 
 /* Schedule a tq to run in process context */
 extern int schedule_task(struct tq_struct *task);
 
-/*
- * Call all "bottom halfs" on a given list.
- */
-
-extern void __run_task_queue(task_queue *list);
+/* finish all currently pending tasks - do not call from irq context */
+extern void flush_scheduled_tasks(void);
 
-static inline void run_task_queue(task_queue *list)
-{
-	if (TQ_ACTIVE(*list))
-		__run_task_queue(list);
-}
+#endif
 
-#endif /* _LINUX_TQUEUE_H */
--- linux/include/linux/tty_flip.h.orig	Sun Sep 29 18:23:30 2002
+++ linux/include/linux/tty_flip.h	Sun Sep 29 18:23:41 2002
@@ -19,7 +19,7 @@
 
 _INLINE_ void tty_schedule_flip(struct tty_struct *tty)
 {
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_task(&tty->flip.tqueue);
 }
 
 #undef _INLINE_
--- linux/net/core/dev.c.orig	Fri Sep 20 17:20:29 2002
+++ linux/net/core/dev.c	Sun Sep 29 17:53:24 2002
@@ -1296,7 +1296,6 @@
 static int deliver_to_old_ones(struct packet_type *pt,
 			       struct sk_buff *skb, int last)
 {
-	static spinlock_t net_bh_lock = SPIN_LOCK_UNLOCKED;
 	int ret = NET_RX_DROP;
 
 	if (!last) {
@@ -1307,20 +1306,13 @@
 	if (skb_is_nonlinear(skb) && skb_linearize(skb, GFP_ATOMIC))
 		goto out_kfree;
 
-	/* The assumption (correct one) is that old protocols
-	   did not depened on BHs different of NET_BH and TIMER_BH.
+#if CONFIG_SMP
+	/* Old protocols did not depened on BHs different of NET_BH and
+	   TIMER_BH - they need to be fixed for the new assumptions.
 	 */
-
-	/* Emulate NET_BH with special spinlock */
-	spin_lock(&net_bh_lock);
-
-	/* Disable timers and wait for all timers completion */
-	tasklet_disable(bh_task_vec+TIMER_BH);
-
+	print_symbol("fix old protocol handler %s!\n", (unsigned long)pt->func);
+#endif
 	ret = pt->func(skb, skb->dev, pt);
-
-	tasklet_hi_enable(bh_task_vec+TIMER_BH);
-	spin_unlock(&net_bh_lock);
 out:
 	return ret;
 out_kfree:
--- linux/lib/bust_spinlocks.c.orig	Fri Sep 20 17:20:20 2002
+++ linux/lib/bust_spinlocks.c	Sun Sep 29 17:53:24 2002
@@ -14,11 +14,9 @@
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
 
-extern spinlock_t timerlist_lock;
 
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
--- linux/kernel/ksyms.c.orig	Sun Sep 29 17:52:59 2002
+++ linux/kernel/ksyms.c	Sun Sep 29 18:12:59 2002
@@ -420,12 +420,9 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 EXPORT_SYMBOL(mod_timer);
-EXPORT_SYMBOL(tq_timer);
-EXPORT_SYMBOL(tq_immediate);
+EXPORT_SYMBOL(tvec_bases);
 
 #ifdef CONFIG_SMP
-/* Various random spinlocks we want to export */
-EXPORT_SYMBOL(tqueue_lock);
 
 /* Big-Reader lock implementation */
 EXPORT_SYMBOL(__brlock_array);
--- linux/kernel/sched.c.orig	Sun Sep 29 17:52:59 2002
+++ linux/kernel/sched.c	Sun Sep 29 17:53:24 2002
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <linux/timer.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -860,6 +861,7 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	run_local_timers();
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -2101,10 +2103,7 @@
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 #endif
 
-extern void init_timervecs(void);
-extern void timer_bh(void);
-extern void tqueue_bh(void);
-extern void immediate_bh(void);
+extern void init_timers(void);
 
 void __init sched_init(void)
 {
@@ -2140,10 +2139,7 @@
 	set_task_cpu(current, smp_processor_id());
 	wake_up_process(current);
 
-	init_timervecs();
-	init_bh(TIMER_BH, timer_bh);
-	init_bh(TQUEUE_BH, tqueue_bh);
-	init_bh(IMMEDIATE_BH, immediate_bh);
+	init_timers();
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
--- linux/kernel/timer.c.orig	Sun Sep 29 17:52:59 2002
+++ linux/kernel/timer.c	Sun Sep 29 19:22:25 2002
@@ -14,74 +14,21 @@
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
  *  2002-05-31	Move sys_sysinfo here and make its locking sane, Robert Love
+ *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
+ *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
+ *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
 
-#include <linux/config.h>
-#include <linux/mm.h>
-#include <linux/timex.h>
-#include <linux/delay.h>
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/mm.h>
 
 #include <asm/uaccess.h>
 
-struct kernel_stat kstat;
-
-/*
- * Timekeeping variables
- */
-
-unsigned long tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
-unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
-
-/* The current time */
-struct timespec xtime __attribute__ ((aligned (16)));
-
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
-
-DECLARE_TASK_QUEUE(tq_timer);
-DECLARE_TASK_QUEUE(tq_immediate);
-
 /*
- * phase-lock loop variables
- */
-/* TIME_ERROR prevents overwriting the CMOS clock */
-int time_state = TIME_OK;		/* clock synchronization status	*/
-int time_status = STA_UNSYNC;		/* clock status bits		*/
-long time_offset;			/* time adjustment (us)		*/
-long time_constant = 2;			/* pll time constant		*/
-long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
-long time_precision = 1;		/* clock precision (us)		*/
-long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
-long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-long time_phase;			/* phase offset (scaled us)	*/
-long time_freq = ((1000000 + HZ/2) % HZ - HZ/2) << SHIFT_USEC;
-					/* frequency offset (scaled ppm)*/
-long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
-long time_reftime;			/* time at last adjustment (s)	*/
-
-long time_adjust;
-
-unsigned long event;
-
-extern int do_setitimer(int, struct itimerval *, struct itimerval *);
-
-/*
- * The 64-bit jiffies value is not atomic - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock).
- * jiffies is defined in the linker script...
- */
-
-
-unsigned int * prof_buffer;
-unsigned long prof_len;
-unsigned long prof_shift;
-
-/*
- * Event timer code
+ * per-CPU timer vector definitions:
  */
 #define TVN_BITS 6
 #define TVR_BITS 8
@@ -90,115 +37,88 @@
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
 
-struct timer_vec {
+typedef struct tvec_s {
 	int index;
 	struct list_head vec[TVN_SIZE];
-};
+} tvec_t;
 
-struct timer_vec_root {
+typedef struct tvec_root_s {
 	int index;
 	struct list_head vec[TVR_SIZE];
-};
+} tvec_root_t;
 
-static struct timer_vec tv5;
-static struct timer_vec tv4;
-static struct timer_vec tv3;
-static struct timer_vec tv2;
-static struct timer_vec_root tv1;
+struct tvec_t_base_s {
+	spinlock_t lock;
+	unsigned long timer_jiffies;
+	volatile timer_t * volatile running_timer;
+	tvec_root_t tv1;
+	tvec_t tv2;
+	tvec_t tv3;
+	tvec_t tv4;
+	tvec_t tv5;
+} ____cacheline_aligned_in_smp;
 
-static struct timer_vec * const tvecs[] = {
-	(struct timer_vec *)&tv1, &tv2, &tv3, &tv4, &tv5
-};
+typedef struct tvec_t_base_s tvec_base_t;
 
-#define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
+static tvec_base_t tvec_bases[NR_CPUS] __cacheline_aligned;
 
-void init_timervecs (void)
-{
-	int i;
+/* Fake initialization needed to avoid compiler breakage */
+static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
-	for (i = 0; i < TVN_SIZE; i++) {
-		INIT_LIST_HEAD(tv5.vec + i);
-		INIT_LIST_HEAD(tv4.vec + i);
-		INIT_LIST_HEAD(tv3.vec + i);
-		INIT_LIST_HEAD(tv2.vec + i);
-	}
-	for (i = 0; i < TVR_SIZE; i++)
-		INIT_LIST_HEAD(tv1.vec + i);
-}
-
-static unsigned long timer_jiffies;
-
-static inline void internal_add_timer(struct timer_list *timer)
+static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
 {
-	/*
-	 * must be cli-ed when calling this
-	 */
 	unsigned long expires = timer->expires;
-	unsigned long idx = expires - timer_jiffies;
+	unsigned long idx = expires - base->timer_jiffies;
 	struct list_head * vec;
 
 	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
-		vec = tv1.vec + i;
+		vec = base->tv1.vec + i;
 	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
 		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = tv2.vec + i;
+		vec = base->tv2.vec + i;
 	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
 		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec =  tv3.vec + i;
+		vec = base->tv3.vec + i;
 	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
 		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = tv4.vec + i;
+		vec = base->tv4.vec + i;
 	} else if ((signed long) idx < 0) {
-		/* can happen if you add a timer with expires == jiffies,
+		/*
+		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = tv1.vec + tv1.index;
+		vec = base->tv1.vec + base->tv1.index;
 	} else if (idx <= 0xffffffffUL) {
 		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = tv5.vec + i;
+		vec = base->tv5.vec + i;
 	} else {
 		/* Can only get here on architectures with 64-bit jiffies */
 		INIT_LIST_HEAD(&timer->list);
 		return;
 	}
 	/*
-	 * Timers are FIFO!
+	 * Timers are FIFO:
 	 */
-	list_add(&timer->list, vec->prev);
+	list_add_tail(&timer->list, vec);
 }
 
-/* Initialize both explicitly - let's try to have them in the same cache line */
-spinlock_t timerlist_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
-#ifdef CONFIG_SMP
-volatile struct timer_list * volatile running_timer;
-#define timer_enter(t) do { running_timer = t; mb(); } while (0)
-#define timer_exit() do { running_timer = NULL; } while (0)
-#define timer_is_running(t) (running_timer == t)
-#define timer_synchronize(t) while (timer_is_running(t)) barrier()
-#else
-#define timer_enter(t)		do { } while (0)
-#define timer_exit()		do { } while (0)
-#endif
-
-void add_timer(struct timer_list *timer)
+void add_timer(timer_t *timer)
 {
-	unsigned long flags;
+	int cpu = get_cpu();
+	tvec_base_t *base = tvec_bases + cpu;
+  	unsigned long flags;
+  
+  	BUG_ON(timer_pending(timer));
 
-	spin_lock_irqsave(&timerlist_lock, flags);
-	if (unlikely(timer_pending(timer)))
-		goto bug;
-	internal_add_timer(timer);
-	spin_unlock_irqrestore(&timerlist_lock, flags);
-	return;
-bug:
-	spin_unlock_irqrestore(&timerlist_lock, flags);
-	printk(KERN_ERR "BUG: kernel timer added twice at %p.\n",
-			__builtin_return_address(0));
+	spin_lock_irqsave(&base->lock, flags);
+	internal_add_timer(base, timer);
+	timer->base = base;
+	spin_unlock_irqrestore(&base->lock, flags);
+	put_cpu();
 }
 
-static inline int detach_timer (struct timer_list *timer)
+static inline int detach_timer (timer_t *timer)
 {
 	if (!timer_pending(timer))
 		return 0;
@@ -206,28 +126,78 @@
 	return 1;
 }
 
-int mod_timer(struct timer_list *timer, unsigned long expires)
+/*
+ * mod_timer() has subtle locking semantics because parallel
+ * calls to it must happen serialized.
+ */
+int mod_timer(timer_t *timer, unsigned long expires)
 {
-	int ret;
+	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
+	int ret;
+
+	if (timer_pending(timer) && timer->expires == expires)
+		return 1;
+
+	local_irq_save(flags);
+	new_base = tvec_bases + smp_processor_id();
+repeat:
+	old_base = timer->base;
+
+	/*
+	 * Prevent deadlocks via ordering by old_base < new_base.
+	 */
+	if (old_base && (new_base != old_base)) {
+		if (old_base < new_base) {
+			spin_lock(&new_base->lock);
+			spin_lock(&old_base->lock);
+		} else {
+			spin_lock(&old_base->lock);
+			spin_lock(&new_base->lock);
+		}
+		/*
+		 * Subtle, we rely on timer->base being always
+		 * valid and being updated atomically.
+		 */
+		if (timer->base != old_base) {
+			spin_unlock(&new_base->lock);
+			spin_unlock(&old_base->lock);
+			goto repeat;
+		}
+	} else
+		spin_lock(&new_base->lock);
 
-	spin_lock_irqsave(&timerlist_lock, flags);
 	timer->expires = expires;
 	ret = detach_timer(timer);
-	internal_add_timer(timer);
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	internal_add_timer(new_base, timer);
+	timer->base = new_base;
+
+	if (old_base && (new_base != old_base))
+		spin_unlock(&old_base->lock);
+	spin_unlock_irqrestore(&new_base->lock, flags);
+
 	return ret;
 }
 
-int del_timer(struct timer_list * timer)
+int del_timer(timer_t * timer)
 {
-	int ret;
 	unsigned long flags;
+	tvec_base_t * base;
+	int ret;
 
-	spin_lock_irqsave(&timerlist_lock, flags);
+	if (!timer->base)
+		return 0;
+repeat:
+ 	base = timer->base;
+	spin_lock_irqsave(&base->lock, flags);
+	if (base != timer->base) {
+		spin_unlock_irqrestore(&base->lock, flags);
+		goto repeat;
+	}
 	ret = detach_timer(timer);
 	timer->list.next = timer->list.prev = NULL;
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	spin_unlock_irqrestore(&base->lock, flags);
+
 	return ret;
 }
 
@@ -240,24 +210,33 @@
  * (for reference counting).
  */
 
-int del_timer_sync(struct timer_list * timer)
+int del_timer_sync(timer_t * timer)
 {
+	tvec_base_t * base;
 	int ret = 0;
 
+	if (!timer->base)
+		return 0;
 	for (;;) {
 		unsigned long flags;
 		int running;
 
-		spin_lock_irqsave(&timerlist_lock, flags);
+repeat:
+	 	base = timer->base;
+		spin_lock_irqsave(&base->lock, flags);
+		if (base != timer->base) {
+			spin_unlock_irqrestore(&base->lock, flags);
+			goto repeat;
+		}
 		ret += detach_timer(timer);
 		timer->list.next = timer->list.prev = 0;
-		running = timer_is_running(timer);
-		spin_unlock_irqrestore(&timerlist_lock, flags);
+		running = timer_is_running(base, timer);
+		spin_unlock_irqrestore(&base->lock, flags);
 
 		if (!running)
 			break;
 
-		timer_synchronize(timer);
+		timer_synchronize(base, timer);
 	}
 
 	return ret;
@@ -265,7 +244,7 @@
 #endif
 
 
-static inline void cascade_timers(struct timer_vec *tv)
+static void cascade(tvec_base_t *base, tvec_t *tv)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
@@ -277,67 +256,107 @@
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
-		struct timer_list *tmp;
+		timer_t *tmp;
 
-		tmp = list_entry(curr, struct timer_list, list);
+		tmp = list_entry(curr, timer_t, list);
+		if (tmp->base != base)
+			BUG();
 		next = curr->next;
 		list_del(curr); // not needed
-		internal_add_timer(tmp);
+		internal_add_timer(base, tmp);
 		curr = next;
 	}
 	INIT_LIST_HEAD(head);
 	tv->index = (tv->index + 1) & TVN_MASK;
 }
 
-static inline void run_timer_list(void)
+static void __run_timers(tvec_base_t *base)
 {
-	spin_lock_irq(&timerlist_lock);
-	while ((long)(jiffies - timer_jiffies) >= 0) {
+	unsigned long flags;
+
+	spin_lock_irqsave(&base->lock, flags);
+	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
-		if (!tv1.index) {
-			int n = 1;
-			do {
-				cascade_timers(tvecs[n]);
-			} while (tvecs[n]->index == 1 && ++n < NOOF_TVECS);
+
+		/*
+		 * Cascade timers:
+		 */
+		if (!base->tv1.index) {
+			cascade(base, &base->tv2);
+			if (base->tv2.index == 1) {
+				cascade(base, &base->tv3);
+				if (base->tv3.index == 1) {
+					cascade(base, &base->tv4);
+					if (base->tv4.index == 1)
+						cascade(base, &base->tv5);
+				}
+			}
 		}
 repeat:
-		head = tv1.vec + tv1.index;
+		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
 		if (curr != head) {
-			struct timer_list *timer;
 			void (*fn)(unsigned long);
 			unsigned long data;
+			timer_t *timer;
 
-			timer = list_entry(curr, struct timer_list, list);
+			timer = list_entry(curr, timer_t, list);
  			fn = timer->function;
- 			data= timer->data;
+ 			data = timer->data;
 
 			detach_timer(timer);
 			timer->list.next = timer->list.prev = NULL;
-			timer_enter(timer);
-			spin_unlock_irq(&timerlist_lock);
+			timer_enter(base, timer);
+			spin_unlock_irq(&base->lock);
 			fn(data);
-			spin_lock_irq(&timerlist_lock);
-			timer_exit();
+			spin_lock_irq(&base->lock);
+			timer_exit(base);
 			goto repeat;
 		}
-		++timer_jiffies; 
-		tv1.index = (tv1.index + 1) & TVR_MASK;
+		++base->timer_jiffies; 
+		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
-	spin_unlock_irq(&timerlist_lock);
+	spin_unlock_irqrestore(&base->lock, flags);
 }
 
-spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+/******************************************************************/
 
-void tqueue_bh(void)
-{
-	run_task_queue(&tq_timer);
-}
+/*
+ * Timekeeping variables
+ */
+unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
+unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
 
-void immediate_bh(void)
-{
-	run_task_queue(&tq_immediate);
-}
+/* The current time */
+struct timespec xtime __attribute__ ((aligned (16)));
+
+/* Don't completely fail for HZ > 500.  */
+int tickadj = 500/HZ ? : 1;		/* microsecs */
+
+struct kernel_stat kstat;
+
+/*
+ * phase-lock loop variables
+ */
+/* TIME_ERROR prevents overwriting the CMOS clock */
+int time_state = TIME_OK;		/* clock synchronization status	*/
+int time_status = STA_UNSYNC;		/* clock status bits		*/
+long time_offset;			/* time adjustment (us)		*/
+long time_constant = 2;			/* pll time constant		*/
+long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
+long time_precision = 1;		/* clock precision (us)		*/
+long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
+long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
+long time_phase;			/* phase offset (scaled us)	*/
+long time_freq = ((1000000 + HZ/2) % HZ - HZ/2) << SHIFT_USEC;
+					/* frequency offset (scaled ppm)*/
+long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
+long time_reftime;			/* time at last adjustment (s)	*/
+long time_adjust;
+
+unsigned int * prof_buffer;
+unsigned long prof_len;
+unsigned long prof_shift;
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -638,17 +657,33 @@
 rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
+/*
+ * This function runs timers and the timer-tq in softirq context.
+ */
+static void run_timer_tasklet(unsigned long data)
+{
+	tvec_base_t *base = tvec_bases + smp_processor_id();
+
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+}
+
+/*
+ * Called by the local, per-CPU timer interrupt on SMP.
+ */
+void run_local_timers(void)
+{
+	tasklet_hi_schedule(&per_cpu(timer_tasklet, smp_processor_id()));
+}
+
+/*
+ * Called by the timer interrupt. xtime_lock must already be taken
+ * by the timer IRQ!
+ */
 static inline void update_times(void)
 {
 	unsigned long ticks;
 
-	/*
-	 * update_times() is run from the raw timer_bh handler so we
-	 * just know that the irqs are locally enabled and so we don't
-	 * need to save/restore the flags of the local CPU here. -arca
-	 */
-	write_lock_irq(&xtime_lock);
-
 	ticks = jiffies - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
@@ -656,14 +691,13 @@
 	}
 	last_time_offset = 0;
 	calc_load(ticks);
-	write_unlock_irq(&xtime_lock);
-}
-
-void timer_bh(void)
-{
-	update_times();
-	run_timer_list();
 }
+  
+/*
+ * The 64-bit jiffies value is not atomic - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock).
+ * jiffies is defined in the linker script...
+ */
 
 void do_timer(struct pt_regs *regs)
 {
@@ -673,13 +707,13 @@
 
 	update_process_times(user_mode(regs));
 #endif
-	mark_bh(TIMER_BH);
-	if (TQ_ACTIVE(tq_timer))
-		mark_bh(TQUEUE_BH);
+	update_times();
 }
 
 #if !defined(__alpha__) && !defined(__ia64__)
 
+extern int do_setitimer(int, struct itimerval *, struct itimerval *);
+
 /*
  * For backwards compatibility?  This can be done in libc so Alpha
  * and all newer ports shouldn't need it.
@@ -821,7 +855,7 @@
  */
 signed long schedule_timeout(signed long timeout)
 {
-	struct timer_list timer;
+	timer_t timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -973,4 +1007,25 @@
 		return -EFAULT;
 
 	return 0;
+}
+
+void __init init_timers(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		tvec_base_t *base;
+	       
+		base = tvec_bases + i;
+		spin_lock_init(&base->lock);
+		for (j = 0; j < TVN_SIZE; j++) {
+			INIT_LIST_HEAD(base->tv5.vec + j);
+			INIT_LIST_HEAD(base->tv4.vec + j);
+			INIT_LIST_HEAD(base->tv3.vec + j);
+			INIT_LIST_HEAD(base->tv2.vec + j);
+		}
+		for (j = 0; j < TVR_SIZE; j++)
+			INIT_LIST_HEAD(base->tv1.vec + j);
+		tasklet_init(&per_cpu(timer_tasklet, i), run_timer_tasklet, 0);
+	}
 }
--- linux/kernel/softirq.c.orig	Fri Sep 20 17:20:20 2002
+++ linux/kernel/softirq.c	Sun Sep 29 18:37:46 2002
@@ -3,21 +3,15 @@
  *
  *	Copyright (C) 1992 Linus Torvalds
  *
- * Fixed a disable_bh()/enable_bh() race (was causing a console lockup)
- * due bh_mask_count not atomic handling. Copyright (C) 1998  Andrea Arcangeli
- *
  * Rewritten. Old one was good in 2.2, but in 2.3 it was immoral. --ANK (990903)
  */
 
-#include <linux/config.h>
-#include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
-#include <linux/tqueue.h>
-#include <linux/percpu.h>
 #include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/mm.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -35,7 +29,6 @@
      it is logically serialized per device, but this serialization
      is invisible to common code.
    - Tasklets: serialized wrt itself.
-   - Bottom halves: globally serialized, grr...
  */
 
 irq_cpustat_t irq_stat[NR_CPUS];
@@ -115,10 +108,10 @@
 	__cpu_raise_softirq(cpu, nr);
 
 	/*
-	 * If we're in an interrupt or bh, we're done
-	 * (this also catches bh-disabled code). We will
+	 * If we're in an interrupt or softirq, we're done
+	 * (this also catches softirq-disabled code). We will
 	 * actually run the softirq once we return from
-	 * the irq or bh.
+	 * the irq or softirq.
 	 *
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
@@ -267,89 +260,10 @@
 	clear_bit(TASKLET_STATE_SCHED, &t->state);
 }
 
-
-
-/* Old style BHs */
-
-static void (*bh_base[32])(void);
-struct tasklet_struct bh_task_vec[32];
-
-/* BHs are serialized by spinlock global_bh_lock.
-
-   It is still possible to make synchronize_bh() as
-   spin_unlock_wait(&global_bh_lock). This operation is not used
-   by kernel now, so that this lock is not made private only
-   due to wait_on_irq().
-
-   It can be removed only after auditing all the BHs.
- */
-spinlock_t global_bh_lock = SPIN_LOCK_UNLOCKED;
-
-static void bh_action(unsigned long nr)
-{
-	if (!spin_trylock(&global_bh_lock))
-		goto resched;
-
-	if (bh_base[nr])
-		bh_base[nr]();
-
-	hardirq_endlock();
-	spin_unlock(&global_bh_lock);
-	return;
-
-	spin_unlock(&global_bh_lock);
-resched:
-	mark_bh(nr);
-}
-
-void init_bh(int nr, void (*routine)(void))
-{
-	bh_base[nr] = routine;
-	mb();
-}
-
-void remove_bh(int nr)
-{
-	tasklet_kill(bh_task_vec+nr);
-	bh_base[nr] = NULL;
-}
-
 void __init softirq_init()
 {
-	int i;
-
-	for (i=0; i<32; i++)
-		tasklet_init(bh_task_vec+i, bh_action, i);
-
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
-}
-
-void __run_task_queue(task_queue *list)
-{
-	struct list_head head, *next;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tqueue_lock, flags);
-	list_add(&head, list);
-	list_del_init(list);
-	spin_unlock_irqrestore(&tqueue_lock, flags);
-
-	next = head.next;
-	while (next != &head) {
-		void (*f) (void *);
-		struct tq_struct *p;
-		void *data;
-
-		p = list_entry(next, struct tq_struct, list);
-		next = next->next;
-		f = p->routine;
-		data = p->data;
-		wmb();
-		p->sync = 0;
-		if (f)
-			f(data);
-	}
 }
 
 static int ksoftirqd(void * __bind_cpu)
--- linux/kernel/context.c.orig	Sun Sep 29 18:13:44 2002
+++ linux/kernel/context.c	Sun Sep 29 18:36:48 2002
@@ -28,6 +28,60 @@
 static int keventd_running;
 static struct task_struct *keventd_task;
 
+static spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
+typedef struct list_head task_queue;
+
+/*
+ * Queue a task on a tq.  Return non-zero if it was successfully
+ * added.
+ */
+static inline int queue_task(struct tq_struct *tq, task_queue *list)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (!test_and_set_bit(0, &tq->sync)) {
+		spin_lock_irqsave(&tqueue_lock, flags);
+		list_add_tail(&tq->list, list);
+		spin_unlock_irqrestore(&tqueue_lock, flags);
+		ret = 1;
+	}
+	return ret;
+}
+
+#define TQ_ACTIVE(q)	(!list_empty(&q))
+
+static inline void run_task_queue(task_queue *list)
+{
+	struct list_head head, *next;
+	unsigned long flags;
+
+	if (!TQ_ACTIVE(*list))
+		return;
+
+	spin_lock_irqsave(&tqueue_lock, flags);
+	list_add(&head, list);
+	list_del_init(list);
+	spin_unlock_irqrestore(&tqueue_lock, flags);
+
+	next = head.next;
+	while (next != &head) {
+		void (*f) (void *);
+		struct tq_struct *p;
+		void *data;
+
+		p = list_entry(next, struct tq_struct, list);
+		next = next->next;
+		f = p->routine;
+		data = p->data;
+		wmb();
+		p->sync = 0;
+		if (f)
+			f(data);
+	}
+}
+
 static int need_keventd(const char *who)
 {
 	if (keventd_running == 0)


