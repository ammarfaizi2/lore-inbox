Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWBXA1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBXA1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWBXA1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:27:34 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:4065 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932244AbWBXA1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:27:32 -0500
X-ORBL: [67.117.73.34]
Date: Thu, 23 Feb 2006 16:26:53 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Russell King <linux@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>
Subject: [PATCH] Fix next_timer_interrupt() for hrtimer
Message-ID: <20060224002653.GC4578@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Looks like next_timer_interrupt() got broken recently with sys_nanosleep
move to hrtimer. Here's a patch to fix it. Anybody got any better ideas
for ktime_to_jiffies() ?

Regards,

Tony


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-hrtimer-dyntick

This patch adds support for hrtimer to next_timer_interrupt()
and fixes current breakage.

Function next_timer_interrupt() got broken with a recent patch
6ba1b91213e81aa92b5cf7539f7d2a94ff54947c as sys_nanosleep() was
moved to hrtimer. This broke things as next_timer_interrupt()
did not check hrtimer tree for next event.

Function next_timer_interrupt() is needed with dyntick
(CONFIG_NO_IDLE_HZ, VST) implementations, as the system can
be in idle when next hrtimer event was supposed to happen.
At least ARM and S390 currently use next_timer_interrupt(). 

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -505,6 +505,94 @@
 	return rem;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/**
+ * hrtimer_get_next - get next hrtimer to expire
+ *
+ * @bases:	ktimer base array
+ */
+static inline struct hrtimer * hrtimer_get_next(struct hrtimer_base *bases)
+{
+	unsigned long flags;
+	struct hrtimer *timer = NULL;
+	int i;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+		struct hrtimer_base *base;
+		struct hrtimer *cur;
+
+		base = &bases[i];
+		spin_lock_irqsave(&base->lock, flags);
+		cur = rb_entry(base->first, struct hrtimer, node);
+		spin_unlock_irqrestore(&base->lock, flags);
+
+		if (cur == NULL)
+			continue;
+
+		if (timer == NULL || cur->expires.tv64 < timer->expires.tv64)
+			timer = cur;
+	}
+
+	return timer;
+}
+
+/**
+ * ktime_to_jiffies - converts ktime to jiffies
+ *
+ * @event:	ktime event to be converted
+ *
+ * Caller must take care xtime locking.
+ */
+static inline unsigned long ktime_to_jiffies(const ktime_t event)
+{
+	ktime_t now, delta;
+	unsigned long sec, nsec;
+	struct timespec tv;
+
+	tv = ktime_to_timespec(event);
+
+	/* Assume read xtime_lock is held, so we can't use getnstimeofday() */
+	sec = xtime.tv_sec;
+	nsec = xtime.tv_nsec;
+	while (unlikely(nsec >= NSEC_PER_SEC)) {
+		nsec -= NSEC_PER_SEC;
+		++sec;
+	}
+	tv.tv_sec = sec;
+	tv.tv_nsec = nsec;
+
+	now = timespec_to_ktime(tv);
+	delta = ktime_sub(event, now);
+
+	tv = ktime_to_timespec(delta);
+
+	return jiffies - 1 + timespec_to_jiffies(&tv);
+}
+
+/**
+ * hrtimer_next_jiffie - get next hrtimer event in jiffies
+ *
+ * Called from next_timer_interrupt() to get the next hrtimer event.
+ * Eventually we should change next_timer_interrupt() to return
+ * results in nanoseconds instead of jiffies. Caller must host xtime_lock.
+ */
+int hrtimer_next_jiffie(unsigned long *next_jiffie)
+{
+	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	struct hrtimer * timer;
+
+	timer = hrtimer_get_next(base);
+	if (timer == NULL)
+		return -EAGAIN;
+
+	*next_jiffie = ktime_to_jiffies(timer->expires);
+
+	return 0;
+}
+
+#endif
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  *
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -478,6 +478,7 @@
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
@@ -489,9 +490,15 @@
 	struct list_head *list;
 	struct timer_list *nte;
 	unsigned long expires;
+	unsigned long hr_expires = jiffies + 10 * HZ;	/* Anything far ahead */
 	tvec_t *varray[4];
 	int i, j;
 
+	/* Look for timer events in hrtimer. */
+	if ((hrtimer_next_jiffie(&hr_expires) == 0)
+		&& (time_before(hr_expires, jiffies + 2)))
+			return hr_expires;
+
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
@@ -542,6 +549,10 @@
 		}
 	}
 	spin_unlock(&base->t_base.lock);
+
+	if (time_before(hr_expires, expires))
+		expires = hr_expires;
+
 	return expires;
 }
 #endif
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -115,6 +115,7 @@ extern int hrtimer_try_to_cancel(struct 
 /* Query timers: */
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
 extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
+extern int hrtimer_next_jiffie(unsigned long *next_jiffie);
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {


--B4IIlcmfBL/1gGOG--
