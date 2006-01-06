Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWAFOSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWAFOSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWAFOSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:18:25 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18053 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751163AbWAFOSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:18:24 -0500
Subject: [PATCH RT] make hrtimer_nanosleep return immediately if time has
	passed
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 09:18:06 -0500
Message-Id: <1136557086.12468.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

My jitter test has been bothering me that I was always get a large
jitter for the smallest increment.  For example:

reported res = 0.000001000
starting calibrate
finished calibrate: 367.9413MHz 367941272

  Requested timex       Max            Min            error
  ---------------       ---            ---            -----
  0.000001000        0.000206748   0.000014750   0.000205748  (205.748 usecs)
  0.000010000        0.000021071   0.000018930   0.000011071  (11.071 usecs)
  0.000100000        0.000113026   0.000108795   0.000013026  (13.026 usecs)
  0.001000000        0.001022049   0.001009267   0.000022049  (22.049 usecs)

The test of 1us would seem to always have a jitter of a few hundreds of
usecs.  So looking at the code, I found the reason. And this is my
solution:

When sys_nanosleep got down to enqueue_hrtimer, if the time has passed
since it took to get there, here's the current code of what is done:

static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
{
[...]
	if (!base->first || timer->expires.tv64 <
	    rb_entry(base->first, struct hrtimer, node)->expires.tv64) {

#ifdef CONFIG_HIGH_RES_TIMERS
		/*
		 * High resolution timers, when active try
		 * to reprogram. If the timer is in the
		 * past we just move it to the expired list
		 * and schedule the softirq.
		 */
		if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
			list_add_tail(&timer->list, &base->expired);
			timer->state = HRTIMER_PENDING_CALLBACK;
			raise_softirq(HRTIMER_SOFTIRQ);
			return;
		}
#endif
		base->first = &timer->node;
	}
[...]

The timer would be put on the expired queue, the hrtimer softirqd would
be woken up, and the task put to sleep.  So instead of returning
immediately, the nanosleep, would have to be scheduled out, the softirq
woken up, and then the task woken back up. This wastes sever hundreds of
usecs as was shown in the jitter test.

My patch does the following:

- Changes enqueue_hrtimer from void to int and returns 1 and does 
  nothing else in the case of the timer has passed.

- Change hrtimer_start to return 1 if the timer has passed and not when
  the timer was active.  I searched the kernel and I could not find one
  instance where this hrtimer_start had its return code checked.

- Changed schedule_hrtimer to not go to sleep if the time has passed.

So with the patch I get the following jitter:

reported res = 0.000001000
starting calibrate
finished calibrate: 367.9363MHz 367936300

  Requested timex       Max            Min            error
  ---------------       ---            ---            -----
  0.000001000        0.000018185   0.000003998   0.000017185  (17.185 usecs)
  0.000010000        0.000021381   0.000018278   0.000011381  (11.381 usecs)
  0.000100000        0.000109614   0.000108443   0.000009614  (9.614 usecs)


The jitter test can be found here:

http://www.kihontech.com/tests/hrtimer/jitter_inc.c

10 consecutive runs of the jitter test without the patch.
http://www.kihontech.com/tests/hrtimer/jitter_nopatch.txt

10 consecutive runs of the jitter test with the patch.
http://www.kihontech.com/tests/hrtimer/jitter_patch.txt


I'll be adding this patch to my 2.6.15-rt1-sr2 patch to be released soon.

-- Steve

Index: linux-2.6.15-rt1/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rt1.orig/kernel/hrtimer.c	2006-01-03 07:41:48.000000000 -0500
+++ linux-2.6.15-rt1/kernel/hrtimer.c	2006-01-05 22:17:45.000000000 -0500
@@ -226,6 +226,10 @@
  * for which the hrt time source was armed.
  *
  * Called with interrupts disabled and base lock held
+ *
+ * Returns:
+ *  0 on success
+ *  1 if time has already past.
  */
 static int hrtimer_reprogram(struct hrtimer *timer, struct hrtimer_base *base)
 {
@@ -239,6 +243,8 @@
 	res = clockevents_set_next_event(expires);
 	if (!res)
 		*expires_next = expires;
+	else
+		res = 1;
 	return res;
 }
 
@@ -381,11 +387,24 @@
 	       smp_processor_id());
 }
 
+/*
+ * kick_off_hrtimer - queue the timer to the expire list and
+ *                    raise the hrtimer softirq.
+ */
+static inline void
+kick_off_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+{
+	list_add_tail(&timer->list, &base->expired);
+	timer->state = HRTIMER_PENDING_CALLBACK;
+	raise_softirq(HRTIMER_SOFTIRQ);
+}
+
 #else /* CONFIG_HIGH_RES_TIMERS */
 
 # define hrtimer_hres_active		0
 # define hres_enqueue_expired(t,b,n)	0
 # define hrtimer_check_clocks()		do { } while (0)
+# define kick_off_hrtimer		do { } while (0)
 
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 
@@ -501,8 +520,12 @@
  *
  * The timer is inserted in expiry order. Insertion into the
  * red black tree is O(log(n)). Must hold the base lock.
+ *
+ * Returns:
+ *  0 on success
+ *  1 if time has already past.
  */
-static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+static int enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
 {
 	struct rb_node **link = &base->active.rb_node;
 	struct rb_node *parent = NULL;
@@ -534,12 +557,8 @@
 		 * past we just move it to the expired list
 		 * and schedule the softirq.
 		 */
-		if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
-			list_add_tail(&timer->list, &base->expired);
-			timer->state = HRTIMER_PENDING_CALLBACK;
-			raise_softirq(HRTIMER_SOFTIRQ);
-			return;
-		}
+		if (hrtimer_hres_active && hrtimer_reprogram(timer, base))
+			return 1;
 #endif
 		base->first = &timer->node;
 	}
@@ -551,6 +570,7 @@
 	rb_insert_color(&timer->node, &base->active);
 
 	timer->state = HRTIMER_PENDING;
+	return 0;
 }
 
 /*
@@ -598,7 +618,7 @@
  *
  * Returns:
  *  0 on success
- *  1 when the timer was active
+ *  1 if the time has already past
  */
 int
 hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
@@ -610,7 +630,7 @@
 	base = lock_hrtimer_base(timer, &flags);
 
 	/* Remove an active timer from the queue: */
-	ret = remove_hrtimer(timer, base);
+	remove_hrtimer(timer, base);
 
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base);
@@ -619,7 +639,7 @@
 		tim = ktime_add(tim, new_base->get_time());
 	timer->expires = tim;
 
-	enqueue_hrtimer(timer, new_base);
+	ret = enqueue_hrtimer(timer, new_base);
 
 	unlock_hrtimer_base(timer, &flags);
 
@@ -864,9 +884,10 @@
 
 		spin_lock_irq(&base->lock);
 
-		if (restart == HRTIMER_RESTART)
-			enqueue_hrtimer(timer, base);
-		else
+		if (restart == HRTIMER_RESTART) {
+			if (enqueue_hrtimer(timer, base))
+				kick_off_hrtimer(timer, base);
+		} else
 			timer->state = HRTIMER_EXPIRED;
 		set_curr_timer(base, NULL);
 	}
@@ -922,9 +943,10 @@
 
 		spin_lock_irq(&base->lock);
 
-		if (restart == HRTIMER_RESTART)
-			enqueue_hrtimer(timer, base);
-		else
+		if (restart == HRTIMER_RESTART) {
+			if (enqueue_hrtimer(timer, base))
+				kick_off_hrtimer(timer, base);
+		} else
 			timer->state = HRTIMER_EXPIRED;
 		set_curr_timer(base, NULL);
 	}
@@ -983,9 +1005,13 @@
 	/* fn stays NULL, meaning single-shot wakeup: */
 	timer->data = current;
 
-	hrtimer_start(timer, timer->expires, mode);
+	if (hrtimer_start(timer, timer->expires, mode)) {
+		/* time already past */
+		timer->state = HRTIMER_EXPIRED;
+		set_current_state(TASK_RUNNING);
+	} else
+		schedule();
 
-	schedule();
 	hrtimer_cancel(timer);
 
 	/* Return the remaining time: */
@@ -1128,7 +1154,8 @@
 		timer = rb_entry(node, struct hrtimer, node);
 		__remove_hrtimer(timer, old_base);
 		timer->base = new_base;
-		enqueue_hrtimer(timer, new_base);
+		if (enqueue_hrtimer(timer, new_base))
+			kick_off_hrtimer(timer, base);
 	}
 }
 


