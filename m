Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbSJCNBf>; Thu, 3 Oct 2002 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbSJCNBf>; Thu, 3 Oct 2002 09:01:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32679 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263318AbSJCNBY>;
	Thu, 3 Oct 2002 09:01:24 -0400
Date: Thu, 3 Oct 2002 15:17:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] timer-2.5.40-F7
Message-ID: <Pine.LNX.4.44.0210031454340.12197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) adds a number of timer subsystem
enhancements:

- simplified timer initialization, now it's the cheapest possible thing:

    static inline void init_timer(struct timer_list * timer)
    {
            timer->base = NULL;
    }

  since the timer functions already did a !timer->base check this did not
  have any effect on their fastpath.

- the rule from now on is that timer->base is set upon activation of the
  timer, and cleared upon deactivation. This also made it possible to:

- reorganize all the timer handling code to not assume anything about
  timer->entry.next and timer->entry.prev - this also removed lots of
  unnecessery cleaning of these fields. Removed lots of unnecessary list
  operations from the fastpath.

- simplified del_timer_sync(): it now uses del_timer() plus some simple 
  synchronization code. Note that this also fixes a bug: if mod_timer (or 
  add_timer) moves a currently executing timer to another CPU's timer
  vector, then del_timer_sync() does not synchronize with the handler
  properly.

- bugfix: moved run_local_timers() from scheduler_tick() into 
  update_process_times() .. scheduler_tick() might be called from the fork
  code which will not quite have the intended effect ...

- removed the APIC-timer-IRQ shifting done on SMP, Dipankar Sarma's 
  testing shows no negative effects.

- cleaned up include/linux/timer.h:

     - removed the timer_t typedef, and fixes up kernel/workqueue.c to use 
       the 'struct timer_list' name instead.

     - removed unnecessery includes

     - renamed the 'list' field to 'entry' (it's an entry not a list head)

     - exchanged the 'function' and 'data' fields. This, besides being 
       more logical, also unearthed the last few remaining places that 
       initialized timers by assuming some given field ordering, the patch 
       also fixes these places. (fs/xfs/pagebuf/page_buf.c, 
       net/core/profile.c and net/ipv4/inetpeer.c)

     - removed the defunct sync_timers(), timer_enter() and timer_exit()
       prototypes.

     - added docbook-style comments.

- other kernel/timer.c changes:

     - base->running_timer does not have to be volatile ...

     - added consistent comments to all the important functions.

     - made the sync-waiting in del_timer_sync preempt- and lowpower-
       friendly.

i've compiled, booted & tested the patched kernel on x86 UP and SMP. I
have tried moderately high networking load as well, to make sure the timer
changes are correct - they appear to be.

	Ingo

--- linux/arch/i386/kernel/apic.c.orig	Fri Sep 20 17:20:37 2002
+++ linux/arch/i386/kernel/apic.c	Thu Oct  3 12:35:46 2002
@@ -813,24 +813,9 @@
 
 static void setup_APIC_timer(unsigned int clocks)
 {
-	unsigned int slice, t0, t1;
 	unsigned long flags;
-	int delta;
 
-	local_save_flags(flags);
-	local_irq_enable();
-	/*
-	 * ok, Intel has some smart code in their APIC that knows
-	 * if a CPU was in 'hlt' lowpower mode, and this increases
-	 * its APIC arbitration priority. To avoid the external timer
-	 * IRQ APIC event being in synchron with the APIC clock we
-	 * introduce an interrupt skew to spread out timer events.
-	 *
-	 * The number of slices within a 'big' timeslice is NR_CPUS+1
-	 */
-
-	slice = clocks / (NR_CPUS+1);
-	printk("cpu: %d, clocks: %d, slice: %d\n", smp_processor_id(), clocks, slice);
+	local_irq_save(flags);
 
 	/*
 	 * Wait for IRQ0's slice:
@@ -838,22 +823,6 @@
 	wait_8254_wraparound();
 
 	__setup_APIC_LVTT(clocks);
-
-	t0 = apic_read(APIC_TMICT)*APIC_DIVISOR;
-	/* Wait till TMCCT gets reloaded from TMICT... */
-	do {
-		t1 = apic_read(APIC_TMCCT)*APIC_DIVISOR;
-		delta = (int)(t0 - t1 - slice*(smp_processor_id()+1));
-	} while (delta >= 0);
-	/* Now wait for our slice for real. */
-	do {
-		t1 = apic_read(APIC_TMCCT)*APIC_DIVISOR;
-		delta = (int)(t0 - t1 - slice*(smp_processor_id()+1));
-	} while (delta < 0);
-
-	__setup_APIC_LVTT(clocks);
-
-	printk("CPU%d<T0:%d,T1:%d,D:%d,S:%d,C:%d>\n", smp_processor_id(), t0, t1, delta, slice, clocks);
 
 	local_irq_restore(flags);
 }
--- linux/fs/xfs/pagebuf/page_buf.c.orig	Thu Oct  3 14:47:29 2002
+++ linux/fs/xfs/pagebuf/page_buf.c	Thu Oct  3 14:47:40 2002
@@ -1680,7 +1680,7 @@
 	page_buf_t		*pb;
 	struct list_head	*curr, *next, tmp;
 	struct timer_list	pb_daemon_timer =
-		{ {NULL, NULL}, 0, 0, (timeout_fn)pagebuf_daemon_wakeup };
+		{ .function = (timeout_fn)pagebuf_daemon_wakeup };
 
 	/*  Set up the thread  */
 	daemonize();
--- linux/include/linux/timer.h.orig	Thu Oct  3 09:37:52 2002
+++ linux/include/linux/timer.h	Thu Oct  3 14:10:05 2002
@@ -2,70 +2,59 @@
 #define _LINUX_TIMER_H
 
 #include <linux/config.h>
-#include <linux/smp.h>
-#include <linux/stddef.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/cache.h>
 
 struct tvec_t_base_s;
 
-/*
- * Timers may be dynamically created and destroyed, and should be initialized
- * by a call to init_timer() upon creation.
- *
- * The "data" field enables use of a common timeout function for several
- * timeouts. You can use this field to distinguish between the different
- * invocations.
- */
-typedef struct timer_list {
-	struct list_head list;
+struct timer_list {
+	struct list_head entry;
 	unsigned long expires;
-	unsigned long data;
+
 	void (*function)(unsigned long);
+	unsigned long data;
+
 	struct tvec_t_base_s *base;
-} timer_t;
+};
 
-extern void add_timer(timer_t * timer);
-extern int del_timer(timer_t * timer);
-  
-#ifdef CONFIG_SMP
-extern int del_timer_sync(timer_t * timer);
-extern void sync_timers(void);
-#define timer_enter(base, t) do { base->running_timer = t; mb(); } while (0)
-#define timer_exit(base) do { base->running_timer = NULL; } while (0)
-#define timer_is_running(base,t) (base->running_timer == t)
-#define timer_synchronize(base,t) while (timer_is_running(base,t)) barrier()
-#else
-#define del_timer_sync(t)	del_timer(t)
-#define sync_timers()		do { } while (0)
-#define timer_enter(base,t)          do { } while (0)
-#define timer_exit(base)            do { } while (0)
-#endif
-  
-/*
- * mod_timer is a more efficient way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
- * mod_timer(a,b) is equivalent to del_timer(a); a->expires = b; add_timer(a).
- * If the timer is known to be not pending (ie, in the handler), mod_timer
- * is less efficient than a->expires = b; add_timer(a).
+/***
+ * init_timer - initialize a timer.
+ * @timer: the timer to be initialized
+ *
+ * init_timer() must be done to a timer prior calling *any* of the
+ * other timer functions.
  */
-int mod_timer(timer_t *timer, unsigned long expires);
-
-extern void it_real_fn(unsigned long);
-
-extern void init_timers(void);
-extern void run_local_timers(void);
-
-static inline void init_timer(timer_t * timer)
+static inline void init_timer(struct timer_list * timer)
 {
-	timer->list.next = timer->list.prev = NULL;
 	timer->base = NULL;
 }
 
-static inline int timer_pending(const timer_t * timer)
+/***
+ * timer_pending - is a timer pending?
+ * @timer: the timer in question
+ *
+ * timer_pending will tell whether a given timer is currently pending,
+ * or not. Callers must ensure serialization wrt. other operations done
+ * to this timer, eg. interrupt contexts, or other CPUs on SMP.
+ *
+ * return value: 1 if the timer is pending, 0 if not.
+ */
+static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->list.next != NULL;
+	return timer->base != NULL;
 }
+
+extern void add_timer(struct timer_list * timer);
+extern int del_timer(struct timer_list * timer);
+extern int mod_timer(struct timer_list *timer, unsigned long expires);
+  
+#if CONFIG_SMP
+  extern int del_timer_sync(struct timer_list * timer);
+#else
+# define del_timer_sync(t) del_timer(t)
+#endif
+
+extern void init_timers(void);
+extern void run_local_timers(void);
+extern void it_real_fn(unsigned long);
 
 #endif
--- linux/include/linux/workqueue.h.orig	Thu Oct  3 09:52:04 2002
+++ linux/include/linux/workqueue.h	Thu Oct  3 12:37:56 2002
@@ -15,7 +15,7 @@
 	void (*func)(void *);
 	void *data;
 	void *wq_data;
-	timer_t timer;
+	struct timer_list timer;
 };
 
 #define __WORK_INITIALIZER(n, f, d) {				\
--- linux/net/ipv4/inetpeer.c.orig	Thu Oct  3 14:40:58 2002
+++ linux/net/ipv4/inetpeer.c	Thu Oct  3 14:44:01 2002
@@ -98,7 +98,7 @@
 
 static void peer_check_expire(unsigned long dummy);
 static struct timer_list peer_periodic_timer =
-	{ { NULL, NULL }, 0, 0, &peer_check_expire };
+	{ .function = &peer_check_expire };
 
 /* Exported for sysctl_net_ipv4.  */
 int inet_peer_gc_mintime = 10 * HZ,
--- linux/net/core/profile.c.orig	Thu Oct  3 14:48:00 2002
+++ linux/net/core/profile.c	Thu Oct  3 14:48:14 2002
@@ -35,7 +35,7 @@
 static void alpha_tick(unsigned long);
 
 static struct timer_list alpha_timer =
-	{ NULL, NULL, 0, 0L, alpha_tick };
+	{ .function = alpha_tick };
 
 void alpha_tick(unsigned long dummy)
 {
@@ -158,7 +158,7 @@
 int whitehole_init(struct net_device *dev);
 
 static struct timer_list whitehole_timer =
-	{ NULL, NULL, 0, 0L, whitehole_inject };
+	{ .function = whitehole_inject };
 
 static struct net_device whitehole_dev = {
 	"whitehole", 0x0, 0x0, 0x0, 0x0, 0, 0, 0, 0, 0, NULL, whitehole_init, };
--- linux/kernel/workqueue.c.orig	Thu Oct  3 09:52:23 2002
+++ linux/kernel/workqueue.c	Thu Oct  3 12:37:56 2002
@@ -100,7 +100,7 @@
 int queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay)
 {
 	int ret = 0, cpu = get_cpu();
-	timer_t *timer = &work->timer;
+	struct timer_list *timer = &work->timer;
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 
 	if (!test_and_set_bit(0, &work->pending)) {
--- linux/kernel/timer.c.orig	Thu Oct  3 09:37:25 2002
+++ linux/kernel/timer.c	Thu Oct  3 14:52:43 2002
@@ -47,10 +47,12 @@
 	struct list_head vec[TVR_SIZE];
 } tvec_root_t;
 
+typedef struct timer_list timer_t;
+
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	volatile timer_t * volatile running_timer;
+	timer_t *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -69,7 +71,7 @@
 {
 	unsigned long expires = timer->expires;
 	unsigned long idx = expires - base->timer_jiffies;
-	struct list_head * vec;
+	struct list_head *vec;
 
 	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
@@ -92,24 +94,36 @@
 	} else if (idx <= 0xffffffffUL) {
 		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
-	} else {
+	} else
 		/* Can only get here on architectures with 64-bit jiffies */
-		INIT_LIST_HEAD(&timer->list);
 		return;
-	}
 	/*
 	 * Timers are FIFO:
 	 */
-	list_add_tail(&timer->list, vec);
+	list_add_tail(&timer->entry, vec);
 }
 
+/***
+ * add_timer - start a timer
+ * @timer: the timer to be added
+ *
+ * The kernel will do a ->function(->data) callback from the
+ * timer interrupt at the ->expired point in the future. The
+ * current time is 'jiffies'.
+ *
+ * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * fields must be set prior calling this function.
+ *
+ * Timers with an ->expired field in the past will be executed in the next
+ * timer tick. It's illegal to add an already pending timer.
+ */
 void add_timer(timer_t *timer)
 {
 	int cpu = get_cpu();
 	tvec_base_t *base = tvec_bases + cpu;
   	unsigned long flags;
   
-  	BUG_ON(timer_pending(timer));
+  	BUG_ON(timer_pending(timer) || !timer->function);
 
 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
@@ -118,25 +132,38 @@
 	put_cpu();
 }
 
-static inline int detach_timer (timer_t *timer)
-{
-	if (!timer_pending(timer))
-		return 0;
-	list_del(&timer->list);
-	return 1;
-}
-
-/*
- * mod_timer() has subtle locking semantics because parallel
- * calls to it must happen serialized.
+/***
+ * mod_timer - modify a timer's timeout
+ * @timer: the timer to be modified
+ *
+ * mod_timer is a more efficient way to update the expire field of an
+ * active timer (if the timer is inactive it will be activated)
+ *
+ * mod_timer(timer, expires) is equivalent to:
+ *
+ *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *
+ * Note that if there are multiple unserialized concurrent users of the
+ * same timer, then mod_timer() is the only safe way to modify the timeout,
+ * since add_timer() cannot modify an already running timer.
+ *
+ * The function returns whether it has modified a pending timer or not.
+ * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
+ * active timer returns 1.)
  */
 int mod_timer(timer_t *timer, unsigned long expires)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
-	if (timer_pending(timer) && timer->expires == expires)
+	BUG_ON(!timer->function);
+	/*
+	 * This is a common optimization triggered by the
+	 * networking code - if the timer is re-modified
+	 * to be the same thing then just return:
+	 */
+	if (timer->expires == expires && timer_pending(timer))
 		return 1;
 
 	local_irq_save(flags);
@@ -156,8 +183,8 @@
 			spin_lock(&new_base->lock);
 		}
 		/*
-		 * Subtle, we rely on timer->base being always
-		 * valid and being updated atomically.
+		 * The timer base might have changed while we were
+		 * trying to take the lock(s):
 		 */
 		if (timer->base != old_base) {
 			spin_unlock(&new_base->lock);
@@ -167,8 +194,15 @@
 	} else
 		spin_lock(&new_base->lock);
 
+	/*
+	 * Delete the previous timeout (if there was any), and install
+	 * the new one:
+	 */
+	if (old_base) {
+		list_del(&timer->entry);
+		ret = 1;
+	}
 	timer->expires = expires;
-	ret = detach_timer(timer);
 	internal_add_timer(new_base, timer);
 	timer->base = new_base;
 
@@ -179,66 +213,74 @@
 	return ret;
 }
 
-int del_timer(timer_t * timer)
+/***
+ * del_timer - deactive a timer.
+ * @timer: the timer to be deactivated
+ *
+ * del_timer() deactivates a timer - this works on both active and inactive
+ * timers.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
+ * active timer returns 1.)
+ */
+int del_timer(timer_t *timer)
 {
 	unsigned long flags;
-	tvec_base_t * base;
-	int ret;
+	tvec_base_t *base;
 
-	if (!timer->base)
-		return 0;
 repeat:
  	base = timer->base;
+	if (!base)
+		return 0;
 	spin_lock_irqsave(&base->lock, flags);
 	if (base != timer->base) {
 		spin_unlock_irqrestore(&base->lock, flags);
 		goto repeat;
 	}
-	ret = detach_timer(timer);
-	timer->list.next = timer->list.prev = NULL;
+	list_del(&timer->entry);
+	timer->base = NULL;
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	return ret;
+	return 1;
 }
 
 #ifdef CONFIG_SMP
-/*
- * SMP specific function to delete periodic timer.
- * Caller must disable by some means restarting the timer
- * for new. Upon exit the timer is not queued and handler is not running
- * on any CPU. It returns number of times, which timer was deleted
- * (for reference counting).
+/***
+ * del_timer_sync - deactivate a timer and wait for the handler to finish.
+ * @timer: the timer to be deactivated
+ *
+ * This function only differs from del_timer() on SMP: besides deactivating
+ * the timer it also makes sure the handler has finished executing on other
+ * CPUs.
+ *
+ * Synchronization rules: callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts. Upon exit the timer is not queued and the handler
+ * is not running on any CPU.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
  */
-
-int del_timer_sync(timer_t * timer)
+int del_timer_sync(timer_t *timer)
 {
-	tvec_base_t * base;
-	int ret = 0;
+	tvec_base_t *base = tvec_bases;
+	int i, ret;
 
-	if (!timer->base)
-		return 0;
-	for (;;) {
-		unsigned long flags;
-		int running;
+	ret = del_timer(timer);
 
-repeat:
-	 	base = timer->base;
-		spin_lock_irqsave(&base->lock, flags);
-		if (base != timer->base) {
-			spin_unlock_irqrestore(&base->lock, flags);
-			goto repeat;
-		}
-		ret += detach_timer(timer);
-		timer->list.next = timer->list.prev = 0;
-		running = timer_is_running(base, timer);
-		spin_unlock_irqrestore(&base->lock, flags);
-
-		if (!running)
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		if (base->running_timer == timer) {
+			while (base->running_timer == timer) {
+				cpu_relax();
+				preempt_disable();
+				preempt_enable();
+			}
 			break;
-
-		timer_synchronize(base, timer);
+		}
+		base++;
 	}
-
 	return ret;
 }
 #endif
@@ -258,11 +300,10 @@
 	while (curr != head) {
 		timer_t *tmp;
 
-		tmp = list_entry(curr, timer_t, list);
+		tmp = list_entry(curr, timer_t, entry);
 		if (tmp->base != base)
 			BUG();
 		next = curr->next;
-		list_del(curr); // not needed
 		internal_add_timer(base, tmp);
 		curr = next;
 	}
@@ -270,7 +311,14 @@
 	tv->index = (tv->index + 1) & TVN_MASK;
 }
 
-static void __run_timers(tvec_base_t *base)
+/***
+ * __run_timers - run all expired timers (if any) on this CPU.
+ * @base: the timer vector to be processed.
+ *
+ * This function cascades all vectors and executes all expired timer
+ * vectors.
+ */
+static inline void __run_timers(tvec_base_t *base)
 {
 	unsigned long flags;
 
@@ -300,22 +348,26 @@
 			unsigned long data;
 			timer_t *timer;
 
-			timer = list_entry(curr, timer_t, list);
+			timer = list_entry(curr, timer_t, entry);
  			fn = timer->function;
  			data = timer->data;
 
-			detach_timer(timer);
-			timer->list.next = timer->list.prev = NULL;
-			timer_enter(base, timer);
+			list_del(&timer->entry);
+			timer->base = NULL;
+#if CONFIG_SMP
+			base->running_timer = timer;
+#endif
 			spin_unlock_irq(&base->lock);
 			fn(data);
 			spin_lock_irq(&base->lock);
-			timer_exit(base);
 			goto repeat;
 		}
 		++base->timer_jiffies; 
 		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
+#if CONFIG_SMP
+	base->running_timer = NULL;
+#endif
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
@@ -607,6 +659,7 @@
 	int cpu = smp_processor_id(), system = user_tick ^ 1;
 
 	update_one_process(p, user_tick, system, cpu);
+	run_local_timers();
 	scheduler_tick(user_tick, system);
 }
 
--- linux/kernel/sched.c.orig	Thu Oct  3 10:17:31 2002
+++ linux/kernel/sched.c	Thu Oct  3 13:32:02 2002
@@ -854,6 +854,9 @@
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
+ *
+ * It also gets called by the fork code, when changing the parent's
+ * timeslices.
  */
 void scheduler_tick(int user_ticks, int sys_ticks)
 {
@@ -861,7 +864,6 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
-	run_local_timers();
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -2103,8 +2105,6 @@
  */
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 #endif
-
-extern void init_timers(void);
 
 void __init sched_init(void)
 {

