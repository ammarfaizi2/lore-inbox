Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWI3AKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWI3AKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWI3AKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:10:00 -0400
Received: from www.osadl.org ([213.239.205.134]:13716 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422800AbWI3AEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:05 -0400
Message-Id: <20060929234439.836620000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 09/23] dynticks: extend next_timer_interrupt() to use a
	reference jiffie
Content-Disposition: inline; filename=extend-timer-next-interrupt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For CONFIG_NO_HZ we need to calculate the next timer wheel event based
to a given jiffie value. Extend the existing code to allow the extra now
argument. Provide a compability function for the existing implementations
to call the function with now = jiffies.
This also solves the racyness of the original code vs. jiffies changing
during the iteration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
----
 include/linux/timer.h |   10 +++++++
 kernel/timer.c        |   64 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 56 insertions(+), 18 deletions(-)

Index: linux-2.6.18-mm2/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/timer.h	2006-09-30 01:41:12.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/timer.h	2006-09-30 01:41:16.000000000 +0200
@@ -61,7 +61,17 @@ extern int del_timer(struct timer_list *
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 
+/*
+ * Return when the next timer-wheel timeout occurs (in absolute jiffies),
+ * locks the timer base:
+ */
 extern unsigned long next_timer_interrupt(void);
+/*
+ * Return when the next timer-wheel timeout occurs (in absolute jiffies),
+ * locks the timer base and does the comparison against the given
+ * jiffie.
+ */
+extern unsigned long get_next_timer_interrupt(unsigned long now);
 
 /***
  * add_timer - start a timer
Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:15.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:16.000000000 +0200
@@ -468,29 +468,28 @@ static inline void __run_timers(tvec_bas
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
-unsigned long next_timer_interrupt(void)
+unsigned long __next_timer_interrupt(tvec_base_t *base, unsigned long now)
 {
-	tvec_base_t *base;
 	struct list_head *list;
-	struct timer_list *nte;
+	struct timer_list *nte, *found = NULL;
 	unsigned long expires;
-	unsigned long hr_expires = MAX_JIFFY_OFFSET;
-	ktime_t hr_delta;
 	tvec_t *varray[4];
 	int i, j;
 
-	hr_delta = hrtimer_get_next_event();
+#ifndef CONFIG_NO_HZ
+	unsigned long hr_expires = MAX_JIFFY_OFFSET;
+	ktime_t hr_delta = hrtimer_get_next_event();
+
 	if (hr_delta.tv64 != KTIME_MAX) {
 		struct timespec tsdelta;
 		tsdelta = ktime_to_timespec(hr_delta);
 		hr_expires = timespec_to_jiffies(&tsdelta);
 		if (hr_expires < 3)
-			return hr_expires + jiffies;
+			return hr_expires + now;
 	}
-	hr_expires += jiffies;
+	hr_expires += now;
+#endif
 
-	base = __get_cpu_var(tvec_bases);
-	spin_lock(&base->lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = NULL;
 
@@ -499,6 +498,7 @@ unsigned long next_timer_interrupt(void)
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
 			expires = nte->expires;
+			found = nte;
 			if (j < (base->timer_jiffies & TVR_MASK))
 				list = base->tv2.vec + (INDEX(0));
 			goto found;
@@ -518,9 +518,12 @@ unsigned long next_timer_interrupt(void)
 				j = (j + 1) & TVN_MASK;
 				continue;
 			}
-			list_for_each_entry(nte, varray[i]->vec + j, entry)
-				if (time_before(nte->expires, expires))
+			list_for_each_entry(nte, varray[i]->vec + j, entry) {
+				if (time_before(nte->expires, expires)) {
 					expires = nte->expires;
+					found = nte;
+				}
+			}
 			if (j < (INDEX(i)) && i < 3)
 				list = varray[i + 1]->vec + (INDEX(i + 1));
 			goto found;
@@ -534,12 +537,15 @@ found:
 		 * where we found the timer element.
 		 */
 		list_for_each_entry(nte, list, entry) {
-			if (time_before(nte->expires, expires))
+			if (time_before(nte->expires, expires)) {
 				expires = nte->expires;
+				found = nte;
+			}
 		}
 	}
-	spin_unlock(&base->lock);
+	WARN_ON(!found);
 
+#ifndef CONFIG_NO_HZ
 	/*
 	 * It can happen that other CPUs service timer IRQs and increment
 	 * jiffies, but we have not yet got a local timer tick to process
@@ -553,14 +559,36 @@ found:
 	 * would falsely evaluate to true.  If that is the case, just
 	 * return jiffies so that we can immediately fire the local timer
 	 */
-	if (time_before(expires, jiffies))
-		return jiffies;
+	if (time_before(expires, now))
+		expires = now;
+	else if (time_before(hr_expires, expires))
+		expires = hr_expires;
+#endif
+	/*
+	 * 'Timer wheel time' can lag behind 'jiffies time' due to
+	 * delayed processing, so make sure we return a value that
+	 * makes sense externally:
+	 */
+	return expires - (now - base->timer_jiffies);
+}
+
+unsigned long get_next_timer_interrupt(unsigned long now)
+{
+	tvec_base_t *base = __get_cpu_var(tvec_bases);
+	unsigned long expires;
 
-	if (time_before(hr_expires, expires))
-		return hr_expires;
+	spin_lock(&base->lock);
+	expires = __next_timer_interrupt(base, now);
+	spin_unlock(&base->lock);
 
 	return expires;
 }
+
+unsigned long next_timer_interrupt(void)
+{
+	return get_next_timer_interrupt(jiffies);
+}
+
 #endif
 
 /******************************************************************/

--

