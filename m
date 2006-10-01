Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWJAXIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWJAXIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWJAXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:07:59 -0400
Received: from www.osadl.org ([213.239.205.134]:8883 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932481AbWJAXGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:51 -0400
Message-Id: <20061001225724.289766000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:57 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 11/21] hrtimers: state tracking
Content-Disposition: inline; filename=hrtimer-change-state-tracking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

reintroduce ktimers feature "optimized away" by the ktimers
review process: multiple hrtimer states to enable the running
of hrtimers without holding the cpu-base-lock.

(the "optimized" rbtree hack carried only 2 states worth of
information and we need 4 for high resolution timers and
dynamic ticks.)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hrtimer.h |   36 +++++++++++++++++++++++++++++++++++-
 kernel/hrtimer.c        |   21 ++++++++++++++-------
 2 files changed, 49 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-10-02 00:55:52.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-10-02 00:55:52.000000000 +0200
@@ -40,6 +40,34 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,	/* Timer must be restarted */
 };
 
+/*
+ * Bit values to track state of the timer
+ *
+ * Possible states:
+ *
+ * 0x00		inactive
+ * 0x01		enqueued into rbtree
+ * 0x02		callback function running
+ * 0x03		callback function running and enqueued
+ *		(was requeued on another CPU)
+ *
+ * The "callback function running and enqueued" status is only possible on
+ * SMP. It happens for example when a posix timer expired and the callback
+ * queued a signal. Between dropping the lock which protects the posix timer
+ * and reacquiring the base lock of the hrtimer, another CPU can deliver the
+ * signal and rearm the timer. We have to preserve the callback running state,
+ * as otherwise the timer could be removed before the softirq code finishes the
+ * the handling of the timer.
+ *
+ * The HRTIMER_STATE_ENQUEUE bit is always or'ed to the current state to
+ * preserve the HRTIMER_STATE_CALLBACK bit in the above scenario.
+ *
+ * All state transitions are protected by cpu_base->lock.
+ */
+#define HRTIMER_STATE_INACTIVE	0x00
+#define HRTIMER_STATE_ENQUEUED	0x01
+#define HRTIMER_STATE_CALLBACK	0x02
+
 /**
  * struct hrtimer - the basic hrtimer structure
  * @node:	red black tree node for time ordered insertion
@@ -48,6 +76,7 @@ enum hrtimer_restart {
  *		which the timer is based.
  * @function:	timer expiry callback function
  * @base:	pointer to the timer base (per cpu and per clock)
+ * @state:	state information (See bit values above)
  *
  * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
  */
@@ -56,6 +85,7 @@ struct hrtimer {
 	ktime_t				expires;
 	enum hrtimer_restart		(*function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
+	unsigned long			state;
 };
 
 /**
@@ -141,9 +171,13 @@ extern int hrtimer_get_res(const clockid
 extern ktime_t hrtimer_get_next_event(void);
 #endif
 
+/*
+ * A timer is active, when it is enqueued into the rbtree or the callback
+ * function is running.
+ */
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return rb_parent(&timer->node) != &timer->node;
+	return timer->state != HRTIMER_STATE_INACTIVE;
 }
 
 /* Forward a hrtimer so it expires after now: */
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-10-02 00:55:52.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-10-02 00:55:52.000000000 +0200
@@ -385,6 +385,11 @@ static void enqueue_hrtimer(struct hrtim
 	 */
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
+	/*
+	 * HRTIMER_STATE_ENQUEUED is or'ed to the current state to preserve the
+	 * state of a possibly running callback.
+	 */
+	timer->state |= HRTIMER_STATE_ENQUEUED;
 
 	if (!base->first || timer->expires.tv64 <
 	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
@@ -397,7 +402,8 @@ static void enqueue_hrtimer(struct hrtim
  * Caller must hold the base lock.
  */
 static void __remove_hrtimer(struct hrtimer *timer,
-			     struct hrtimer_clock_base *base)
+			     struct hrtimer_clock_base *base,
+			     unsigned long newstate)
 {
 	/*
 	 * Remove the timer from the rbtree and replace the
@@ -406,7 +412,7 @@ static void __remove_hrtimer(struct hrti
 	if (base->first == &timer->node)
 		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
-	rb_set_parent(&timer->node, &timer->node);
+	timer->state = newstate;
 }
 
 /*
@@ -416,7 +422,7 @@ static inline int
 remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base)
 {
 	if (hrtimer_active(timer)) {
-		__remove_hrtimer(timer, base);
+		__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
 		return 1;
 	}
 	return 0;
@@ -488,7 +494,7 @@ int hrtimer_try_to_cancel(struct hrtimer
 
 	base = lock_hrtimer_base(timer, &flags);
 
-	if (base->cpu_base->curr_timer != timer)
+	if (!(timer->state & HRTIMER_STATE_CALLBACK))
 		ret = remove_hrtimer(timer, base);
 
 	unlock_hrtimer_base(timer, &flags);
@@ -593,7 +599,6 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &cpu_base->clock_base[clock_id];
-	rb_set_parent(&timer->node, &timer->node);
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
@@ -644,13 +649,14 @@ static inline void run_hrtimer_queue(str
 
 		fn = timer->function;
 		set_curr_timer(cpu_base, timer);
-		__remove_hrtimer(timer, base);
+		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK);
 		spin_unlock_irq(&cpu_base->lock);
 
 		restart = fn(timer);
 
 		spin_lock_irq(&cpu_base->lock);
 
+		timer->state &= ~HRTIMER_STATE_CALLBACK;
 		if (restart != HRTIMER_NORESTART) {
 			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
@@ -821,7 +827,8 @@ static void migrate_hrtimer_list(struct 
 
 	while ((node = rb_first(&old_base->active))) {
 		timer = rb_entry(node, struct hrtimer, node);
-		__remove_hrtimer(timer, old_base);
+		BUG_ON(timer->state & HRTIMER_CALLBACK);
+		__remove_hrtimer(timer, old_base, HRTIMER_INACTIVE);
 		timer->base = new_base;
 		enqueue_hrtimer(timer, new_base);
 	}

--

