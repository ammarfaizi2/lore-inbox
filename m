Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUKPKfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUKPKfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKPKfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:35:32 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:54656 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261916AbUKPKfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:35:02 -0500
Message-ID: <4199E633.D6037C7A@tv-sign.ru>
Date: Tue, 16 Nov 2004 14:36:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] reduce false TIMER_SOFTIRQ calls
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

smp_local_timer_interrupt() calls run_local_timers() which
triggers TIMER_SOFTIRQ unconditionally.

The handler, run_timer_softirq(), does:
	if (time_after_eq(jiffies, base->timer_jiffies))
		__run_timers(base);

This time_after_eq() is useless, base->timer_jiffies == jifiies
almost allways.

So every local timer interrupt implies do_softirq()->__run_timers().

This patch adds tvec_base_t->timer_expires, which is used as
estimation for the "nearest" pending timer. It is calculated in
__run_timers(), by scanning next 64 entries in tvec_base_t->tv1.

So, if we have single pending timer which constantly readds
itself after invocation with expires = jiffies + 1, we lost
up to 64 (average 56) loop iterations (scanning tvec_base_t->tv1)
per jiffie. But if expires = jiffies + 2, we have 28 iterations
per jiffie, and only 50% of interrupts trigger TIMER_SOFTIRQ.

I have collected some stat during kernel compilation:
0.0282  TIMER_SOFTIRQ's per jiffie
1.0880  loop iterations (timer_expires calculation) per jiffie
0.0570  do_softirq() calls from smp_apic_timer_interrupt()

but there is no noticeable time difference.

Simple benchmark, counts gettimeofday() per second, 3 runs.

Clean kernel:
2810548.9333			// gettimeofday()s per second
1m0.002s 0m8.761s 0m51.243s	// real, user, sys
2811569.0833
1m0.003s 0m8.875s 0m51.130s
2810842.0333
1m0.002s 0m9.073s 0m50.931s

Patched:
2812897.6667			// gettimeofday()s per second
1m0.002s 0m10.920s 0m49.090s	// real, user, sys
2812929.4667
1m0.002s 0m11.074s 0m48.938s
2812905.9000
1m0.002s 0m11.092s 0m48.919s

Again, slightly faster, but far below 1%.

Code bloat: 68 bytes (gcc 2.95.3).

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc2/include/linux/timer.h~	2004-09-13 09:32:56.000000000 +0400
+++ 2.6.10-rc2/include/linux/timer.h	2004-11-15 17:38:11.371136600 +0300
@@ -96,7 +96,6 @@ static inline void add_timer(struct time
 #endif
 
 extern void init_timers(void);
-extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
 #endif
--- 2.6.10-rc2/kernel/timer.c~	2004-11-15 17:12:21.000000000 +0300
+++ 2.6.10-rc2/kernel/timer.c	2004-11-15 18:55:16.596995392 +0300
@@ -65,7 +65,7 @@ typedef struct tvec_root_s {
 
 struct tvec_t_base_s {
 	spinlock_t lock;
-	unsigned long timer_jiffies;
+	unsigned long timer_jiffies, timer_expires;
 	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
@@ -136,6 +136,7 @@ static void internal_add_timer(tvec_base
 		 * or you set a timer to go off in the past
 		 */
 		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+		expires = base->timer_jiffies;
 	} else {
 		int i;
 		/* If the timeout is larger than 0xffffffff on 64-bit
@@ -152,6 +153,9 @@ static void internal_add_timer(tvec_base
 	 * Timers are FIFO:
 	 */
 	list_add_tail(&timer->entry, vec);
+
+	if (time_after(base->timer_expires, expires))
+		base->timer_expires = expires;
 }
 
 int __mod_timer(struct timer_list *timer, unsigned long expires)
@@ -431,14 +435,17 @@ static int cascade(tvec_base_t *base, tv
 
 static inline void __run_timers(tvec_base_t *base)
 {
-	struct timer_list *timer;
+	unsigned long expires;
+	int probes;
 
 	spin_lock_irq(&base->lock);
+
+	base->timer_jiffies = base->timer_expires;
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
- 
+
 		/*
 		 * Cascade timers:
 		 */
@@ -447,10 +454,11 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->timer_jiffies;
 		list_splice_init(base->tv1.vec + index, &work_list);
 repeat:
 		if (!list_empty(head)) {
+			struct timer_list *timer;
 			void (*fn)(unsigned long);
 			unsigned long data;
 
@@ -469,9 +477,36 @@ repeat:
 		}
 	}
 	set_running_timer(base, NULL);
+
+	expires = base->timer_jiffies;
+	for (probes = 65; --probes &&
+		(expires & TVR_MASK) &&
+		list_empty(base->tv1.vec + (expires & TVR_MASK));
+		++expires);
+	base->timer_expires = expires;
+
 	spin_unlock_irq(&base->lock);
 }
 
+/*
+ * This function runs timers and the timer-tq in bottom half context.
+ */
+static void run_timer_softirq(struct softirq_action *h)
+{
+	__run_timers(&__get_cpu_var(tvec_bases));
+}
+
+/*
+ * Called by the local, per-CPU timer interrupt on SMP.
+ */
+static inline void run_local_timers(int cpu)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+
+	if (time_after_eq(jiffies, base->timer_expires))
+		raise_softirq(TIMER_SOFTIRQ);
+}
+
 #ifdef CONFIG_NO_IDLE_HZ
 /*
  * Find out when the next timer event is due to happen. This
@@ -860,7 +895,7 @@ void update_process_times(int user_tick)
 	int cpu = smp_processor_id(), system = user_tick ^ 1;
 
 	update_one_process(p, user_tick, system, cpu);
-	run_local_timers();
+	run_local_timers(cpu);
 	scheduler_tick(user_tick, system);
 }
 
@@ -915,25 +950,6 @@ EXPORT_SYMBOL(xtime_lock);
 #endif
 
 /*
- * This function runs timers and the timer-tq in bottom half context.
- */
-static void run_timer_softirq(struct softirq_action *h)
-{
-	tvec_base_t *base = &__get_cpu_var(tvec_bases);
-
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
-}
-
-/*
- * Called by the local, per-CPU timer interrupt on SMP.
- */
-void run_local_timers(void)
-{
-	raise_softirq(TIMER_SOFTIRQ);
-}
-
-/*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
@@ -1332,6 +1348,7 @@ static void __devinit init_timers_cpu(in
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
 	base->timer_jiffies = jiffies;
+	base->timer_expires = base->timer_jiffies;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
