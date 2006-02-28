Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWB1D31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWB1D31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWB1D31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:29:27 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:22458 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932210AbWB1D30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:29:26 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 27 Feb 2006 19:29:01 -0800
From: Tony Lindgren <tony@atomide.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
Message-ID: <20060228032900.GE4486@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net> <1140884243.5237.104.camel@localhost.localdomain> <20060225185731.GA4294@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20060225185731.GA4294@atomide.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here's take 3 for comments and testing. It should fix the issues
mentioned by Thomas Gleixner.

I've changed ARM xtime_lock to read lock, but now there's a slight
chance that an interrupt adds a timer after next_timer_interrupt() is
called and before timer is reprogrammed. I believe s390 also has this
problem.

Regards,

Tony

--hOcCNbCCxyk/YU74
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
@@ -505,6 +505,106 @@
 	return rem;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/**
+ * hrtimer_get_next_offset - get next hrtimer to expire in ktime_t from now
+ *
+ * @offset:	pointer for next event offset
+ *
+ * Note that the timer event may get removed, so the result is not guaranteed
+ * to be correct. Nanosleep hrtimers are on the stack and can go away due to
+ * a signal, and posix timers can be removed and destroyed on another CPU.
+ * For next_timer_interrupt() this should be OK, as it causes just an extra
+ * timer interrupt.
+ */
+static inline int hrtimer_get_next_offset(ktime_t *offset)
+{
+	struct hrtimer_base *bases = __get_cpu_var(hrtimer_bases);
+	unsigned long flags;
+	int i, ret = -EAGAIN;
+
+	if (bases == NULL)
+		return ret;
+
+	offset->tv64 = KTIME_MAX;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+		struct hrtimer_base *base;
+		struct rb_node *node;
+		struct hrtimer *timer;
+		ktime_t delta, now;
+
+		base = &bases[i];
+		now = base->get_time();
+		spin_lock_irqsave(&base->lock, flags);
+		if ((node = base->first) != NULL) {
+			timer = rb_entry(node, struct hrtimer, node);
+			delta = ktime_sub(timer->expires, now);
+
+			if (delta.tv64 <= 0) {
+				spin_unlock_irqrestore(&base->lock, flags);
+				continue;
+			}
+
+			if (delta.tv64 <= offset->tv64) {
+				offset->tv64 = delta.tv64;
+				ret = 0;
+			}
+		}
+		spin_unlock_irqrestore(&base->lock, flags);
+	}
+
+	return ret;
+}
+
+/**
+ * ktime_offset_to_jiffies - converts ktime to jiffies
+ *
+ * @offset:	ktime event offset to be converted to jiffies
+ *
+ * Note that this function should not be needed once next_timer_interrupt()
+ * is converted to return nsecs instead of jiffies.
+ */
+static inline unsigned long ktime_offset_to_jiffies(const ktime_t offset)
+{
+	unsigned long timer_jiffies;
+
+	if (offset.tv64 <= 0)
+		return jiffies + 1;
+
+	timer_jiffies = (unsigned long)(((offset.tv64 * NSEC_CONVERSION) >>
+				(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)) >> SEC_JIFFIE_SC);
+
+	if (timer_jiffies < 1)
+		timer_jiffies = 1;
+
+	return jiffies + timer_jiffies;
+}
+
+/**
+ * hrtimer_next_jiffie - translates next hrtimer event into jiffies
+ *
+ * Called from next_timer_interrupt() to get the next hrtimer event.
+ * Eventually we should change next_timer_interrupt() to return
+ * results in nanoseconds instead of jiffies.
+ */
+int hrtimer_next_jiffie(unsigned long *next_jiffie)
+{
+	ktime_t offset;
+	int ret;
+
+	ret = hrtimer_get_next_offset(&offset);
+	if (ret != 0)
+		return ret;
+
+	*next_jiffie = ktime_offset_to_jiffies(offset);
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
@@ -489,9 +489,15 @@
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
@@ -542,6 +548,10 @@
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
@@ -115,6 +115,7 @@
 /* Query timers: */
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
 extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
+extern int hrtimer_next_jiffie(unsigned long *next_jiffie);
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -422,12 +422,14 @@
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
 


--hOcCNbCCxyk/YU74--
