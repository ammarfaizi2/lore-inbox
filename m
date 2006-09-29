Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWI3AI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWI3AI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWI3AIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:08:32 -0400
Received: from www.osadl.org ([213.239.205.134]:17556 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422815AbWI3AEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:07 -0400
Message-Id: <20060929234440.069571000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:30 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 11/23] hrtimers: state tracking
Content-Disposition: inline; filename=hrtimer-change-state-tracking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

reintroduce ktimers feature "optimized away" by the ktimers
review process: multiple hrtimer states to enable the running
of hrtimers without holding the cpu-base-lock.

(the "optimized" rbtree hack carried only 2 states worth of
information and we need 3.)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hrtimer.h |    7 +++++--
 kernel/hrtimer.c        |   17 ++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:17.000000000 +0200
@@ -34,7 +34,9 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,
 };
 
-#define HRTIMER_INACTIVE	((void *)1UL)
+#define HRTIMER_INACTIVE	0x00
+#define HRTIMER_ACTIVE		0x01
+#define HRTIMER_CALLBACK	0x02
 
 struct hrtimer_clock_base;
 
@@ -54,6 +56,7 @@ struct hrtimer {
 	ktime_t				expires;
 	int				(*function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
+	unsigned long			state;
 };
 
 /**
@@ -139,7 +142,7 @@ extern ktime_t hrtimer_get_next_event(vo
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return rb_parent(&timer->node) != &timer->node;
+	return timer->state != HRTIMER_INACTIVE;
 }
 
 /* Forward a hrtimer so it expires after now: */
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-09-30 01:41:17.000000000 +0200
@@ -384,6 +384,7 @@ static void enqueue_hrtimer(struct hrtim
 	 */
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
+	timer->state |= HRTIMER_ACTIVE;
 
 	if (!base->first || timer->expires.tv64 <
 	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
@@ -396,7 +397,8 @@ static void enqueue_hrtimer(struct hrtim
  * Caller must hold the base lock.
  */
 static void __remove_hrtimer(struct hrtimer *timer,
-			     struct hrtimer_clock_base *base)
+			     struct hrtimer_clock_base *base,
+			     unsigned long newstate)
 {
 	/*
 	 * Remove the timer from the rbtree and replace the
@@ -405,7 +407,7 @@ static void __remove_hrtimer(struct hrti
 	if (base->first == &timer->node)
 		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
-	rb_set_parent(&timer->node, &timer->node);
+	timer->state = newstate;
 }
 
 /*
@@ -415,7 +417,7 @@ static inline int
 remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base)
 {
 	if (hrtimer_active(timer)) {
-		__remove_hrtimer(timer, base);
+		__remove_hrtimer(timer, base, HRTIMER_INACTIVE);
 		return 1;
 	}
 	return 0;
@@ -487,7 +489,7 @@ int hrtimer_try_to_cancel(struct hrtimer
 
 	base = lock_hrtimer_base(timer, &flags);
 
-	if (base->cpu_base->curr_timer != timer)
+	if (!(timer->state & HRTIMER_CALLBACK))
 		ret = remove_hrtimer(timer, base);
 
 	unlock_hrtimer_base(timer, &flags);
@@ -592,7 +594,6 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &cpu_base->clock_base[clock_id];
-	rb_set_parent(&timer->node, &timer->node);
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
@@ -643,13 +644,14 @@ static inline void run_hrtimer_queue(str
 
 		fn = timer->function;
 		set_curr_timer(cpu_base, timer);
-		__remove_hrtimer(timer, base);
+		__remove_hrtimer(timer, base, HRTIMER_CALLBACK);
 		spin_unlock_irq(&cpu_base->lock);
 
 		restart = fn(timer);
 
 		spin_lock_irq(&cpu_base->lock);
 
+		timer->state &= ~HRTIMER_CALLBACK;
 		if (restart != HRTIMER_NORESTART) {
 			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
@@ -820,7 +822,8 @@ static void migrate_hrtimer_list(struct 
 
 	while ((node = rb_first(&old_base->active))) {
 		timer = rb_entry(node, struct hrtimer, node);
-		__remove_hrtimer(timer, old_base);
+		BUG_ON(timer->state & HRTIMER_CALLBACK);
+		__remove_hrtimer(timer, old_base, HRTIMER_INACTIVE);
 		timer->base = new_base;
 		enqueue_hrtimer(timer, new_base);
 	}

--

