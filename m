Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWCLKiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCLKiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWCLKhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:37:39 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:28646
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751480AbWCLKg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:57 -0500
Message-Id: <20060312080332.274315000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 5/8] hrtimer remove state field
Content-Disposition: inline; filename=hrtimers-remove-state-field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

Remove the state field and encode this information in the rb_node
similiar to normal timer.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/hrtimer.h |   11 ++---------
 kernel/hrtimer.c        |   13 ++++---------
 2 files changed, 6 insertions(+), 18 deletions(-)

Index: linux-2.6.16-updates/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/hrtimer.h
+++ linux-2.6.16-updates/include/linux/hrtimer.h
@@ -34,13 +34,7 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,
 };
 
-/*
- * Timer states:
- */
-enum hrtimer_state {
-	HRTIMER_INACTIVE,		/* Timer is inactive */
-	HRTIMER_PENDING,		/* Timer is pending */
-};
+#define HRTIMER_INACTIVE	((void *)1UL)
 
 struct hrtimer_base;
 
@@ -61,7 +55,6 @@ struct hrtimer_base;
 struct hrtimer {
 	struct rb_node		node;
 	ktime_t			expires;
-	enum hrtimer_state	state;
 	int			(*function)(void *);
 	void			*data;
 	struct hrtimer_base	*base;
@@ -124,7 +117,7 @@ extern ktime_t hrtimer_get_next_event(vo
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return timer->state == HRTIMER_PENDING;
+	return timer->node.rb_parent != HRTIMER_INACTIVE;
 }
 
 /* Forward a hrtimer so it expires after now: */
Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -374,8 +374,6 @@ static void enqueue_hrtimer(struct hrtim
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
 
-	timer->state = HRTIMER_PENDING;
-
 	if (!base->first || timer->expires.tv64 <
 	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
 		base->first = &timer->node;
@@ -395,6 +393,7 @@ static void __remove_hrtimer(struct hrti
 	if (base->first == &timer->node)
 		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
+	timer->node.rb_parent = HRTIMER_INACTIVE;
 }
 
 /*
@@ -405,7 +404,6 @@ remove_hrtimer(struct hrtimer *timer, st
 {
 	if (hrtimer_active(timer)) {
 		__remove_hrtimer(timer, base);
-		timer->state = HRTIMER_INACTIVE;
 		return 1;
 	}
 	return 0;
@@ -579,6 +577,7 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &bases[clock_id];
+	timer->node.rb_parent = HRTIMER_INACTIVE;
 }
 
 /**
@@ -625,7 +624,6 @@ static inline void run_hrtimer_queue(str
 		fn = timer->function;
 		data = timer->data;
 		set_curr_timer(base, timer);
-		timer->state = HRTIMER_INACTIVE;
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
@@ -633,11 +631,8 @@ static inline void run_hrtimer_queue(str
 
 		spin_lock_irq(&base->lock);
 
-		/* Another CPU has added back the timer */
-		if (timer->state != HRTIMER_INACTIVE)
-			continue;
-
-		if (restart != HRTIMER_NORESTART)
+		if (restart != HRTIMER_NORESTART &&
+		    !hrtimer_active(timer))
 			enqueue_hrtimer(timer, base);
 	}
 	set_curr_timer(base, NULL);

--

