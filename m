Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWB1JD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWB1JD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWB1JD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:03:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:16024
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932090AbWB1JD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:03:27 -0500
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tony Lindgren <tony@atomide.com>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228032900.GE4486@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net>
	 <1140884243.5237.104.camel@localhost.localdomain>
	 <20060225185731.GA4294@atomide.com>  <20060228032900.GE4486@atomide.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 10:05:00 +0100
Message-Id: <1141117500.5237.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 19:29 -0800, Tony Lindgren wrote:
> I've changed ARM xtime_lock to read lock, but now there's a slight
> chance that an interrupt adds a timer after next_timer_interrupt() is
> called and before timer is reprogrammed. I believe s390 also has this
> problem.

This needs a more generalized solution later, but I picked up your ARM
change and simplified the hrtimer related bits.

	tglx


Index: 2.6.16-rc4-git/arch/arm/kernel/time.c
===================================================================
--- 2.6.16-rc4-git.orig/arch/arm/kernel/time.c
+++ 2.6.16-rc4-git/arch/arm/kernel/time.c
@@ -422,12 +422,14 @@ static int timer_dyn_tick_disable(void)
 void timer_dyn_reprogram(void)
 {
 	struct dyn_tick_timer *dyn_tick = system_timer->dyn_tick;
+	unsigned long next, seq;
 
-	if (dyn_tick) {
-		write_seqlock(&xtime_lock);
-		if (dyn_tick->state & DYN_TICK_ENABLED)
+	if (dyn_tick && (dyn_tick->state & DYN_TICK_ENABLED)) {
+		next = next_timer_interrupt();
+		do {
+			seq = read_seqbegin(&xtime_lock);
 			dyn_tick->reprogram(next_timer_interrupt() - jiffies);
-		write_sequnlock(&xtime_lock);
+		} while (read_seqretry(&xtime_lock, seq));
 	}
 }
 
Index: 2.6.16-rc4-git/include/linux/hrtimer.h
===================================================================
--- 2.6.16-rc4-git.orig/include/linux/hrtimer.h
+++ 2.6.16-rc4-git/include/linux/hrtimer.h
@@ -116,6 +116,10 @@ extern int hrtimer_try_to_cancel(struct 
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
 extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
 
+#ifdef CONFIG_NO_IDLE_HZ
+extern ktime_t hrtimer_get_next_event(void);
+#endif
+
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
 	return timer->state == HRTIMER_PENDING;
Index: 2.6.16-rc4-git/kernel/hrtimer.c
===================================================================
--- 2.6.16-rc4-git.orig/kernel/hrtimer.c
+++ 2.6.16-rc4-git/kernel/hrtimer.c
@@ -505,6 +505,41 @@ ktime_t hrtimer_get_remaining(const stru
 	return rem;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+/**
+ * hrtimer_get_next_event - get the time until next expiry event
+ *
+ * Returns the delta to the next expiry event or KTIME_MAX if no timer
+ * is pending.
+ */
+ktime_t hrtimer_get_next_event(void)
+{
+	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	ktime_t delta, mindelta = { .tv64 = KTIME_MAX };
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++) {
+		struct hrtimer *timer;
+
+		spin_lock_irqsave(&base->lock, flags);
+		if (!base->first) {
+			spin_unlock_irqrestore(&base->lock, flags);
+			continue;
+		}
+		timer = rb_entry(base->first, struct hrtimer, node);
+		delta.tv64 = timer->expires.tv64;
+		spin_unlock_irqrestore(&base->lock, flags);
+		delta = ktime_sub(delta, base->get_time());
+		if (delta.tv64 < mindelta.tv64)
+			mindelta.tv64 = delta.tv64;
+	}
+	if (mindelta.tv64 < 0)
+		mindelta.tv64 = 0;
+	return mindelta;
+}
+#endif
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  *
Index: 2.6.16-rc4-git/kernel/timer.c
===================================================================
--- 2.6.16-rc4-git.orig/kernel/timer.c
+++ 2.6.16-rc4-git/kernel/timer.c
@@ -488,10 +488,21 @@ unsigned long next_timer_interrupt(void)
 	tvec_base_t *base;
 	struct list_head *list;
 	struct timer_list *nte;
-	unsigned long expires;
+	unsigned long expires, hr_expires = MAX_JIFFY_OFFSET;
+	ktime_t hr_delta;
 	tvec_t *varray[4];
 	int i, j;
 
+	hr_delta = hrtimer_get_next_event();
+	if (hr_delta.tv64 != KTIME_MAX) {
+		struct timespec tsdelta;
+		tsdelta = ktime_to_timespec(hr_delta);
+		hr_expires = timespec_to_jiffies(&tsdelta);
+		if (hr_expires < 3)
+			return hr_expires + jiffies;
+	}
+	hr_expires += jiffies;
+
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
@@ -542,6 +553,10 @@ found:
 		}
 	}
 	spin_unlock(&base->t_base.lock);
+
+	if (time_before(hr_expires, expires))
+		return hr_expires;
+
 	return expires;
 }
 #endif


