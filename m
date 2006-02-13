Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWBMBMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWBMBMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWBMBLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:11:39 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:35289 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751521AbWBMBLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:11:20 -0500
Date: Mon, 13 Feb 2006 02:11:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] hrtimer: completely remove state field
Message-ID: <Pine.LNX.4.61.0602130210480.23835@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the state field and encode this information in the rb_node
similiar to normal timer.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/hrtimer.h |   11 ++---------
 kernel/hrtimer.c        |   13 ++++---------
 2 files changed, 6 insertions(+), 18 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-12 18:33:25.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-12 18:33:30.000000000 +0100
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
+#define HRTIMER_POISON	((void *)1UL)
 
 struct hrtimer_base;
 
@@ -61,7 +55,6 @@ struct hrtimer_base;
 struct hrtimer {
 	struct rb_node		node;
 	ktime_t			expires;
-	enum hrtimer_state	state;
 	int			(*function)(void *);
 	void			*data;
 	struct hrtimer_base	*base;
@@ -117,7 +110,7 @@ extern int hrtimer_get_res(clockid_t whi
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return timer->state == HRTIMER_PENDING;
+	return timer->node.rb_parent != HRTIMER_POISON;
 }
 
 /* Forward a hrtimer so it expires after now: */
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-12 18:33:25.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-12 18:33:30.000000000 +0100
@@ -355,8 +355,6 @@ static void enqueue_hrtimer(struct hrtim
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
 
-	timer->state = HRTIMER_PENDING;
-
 	if (!base->first || timer->expires.tv64 <
 	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
 		base->first = &timer->node;
@@ -376,6 +374,7 @@ static void __remove_hrtimer(struct hrti
 	if (base->first == &timer->node)
 		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
+	timer->node.rb_parent = HRTIMER_POISON;
 }
 
 /*
@@ -386,7 +385,6 @@ remove_hrtimer(struct hrtimer *timer, st
 {
 	if (hrtimer_active(timer)) {
 		__remove_hrtimer(timer, base);
-		timer->state = HRTIMER_INACTIVE;
 		return 1;
 	}
 	return 0;
@@ -515,6 +513,7 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &bases[clock_id];
+	timer->node.rb_parent = HRTIMER_POISON;
 }
 
 /**
@@ -559,7 +558,6 @@ static inline void run_hrtimer_queue(str
 		fn = timer->function;
 		data = timer->data;
 		set_curr_timer(base, timer);
-		timer->state = HRTIMER_INACTIVE;
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
@@ -567,11 +565,8 @@ static inline void run_hrtimer_queue(str
 
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
